#property strict

#include <Trade\Trade.mqh>

CTrade trade;

//==================================================
// INPUT PARAMETERS
//==================================================
input group "=== General Trading Settings ==="
input double InpLotSize             = 0.01;
input int    InpStopLoss            = 300;
input int    InpTakeProfit          = 600;
input ulong  InpMagicNumber         = 123456;
input int    InpSlippage            = 10;
input int    InpMaxSpread           = 30;
input int    InpMaxPositions        = 1;

input group "=== Break Even Settings ==="
input bool   InpUseBreakEven        = true;
input int    InpBreakEvenTrigger    = 150;
input int    InpBreakEvenOffset     = 0;

input group "=== Trailing Stop Settings ==="
input bool   InpUseTrailingStop     = true;
input int    InpTrailingStart       = 200;
input int    InpTrailingDistance    = 150;

input group "=== Mother Bar Settings ==="
input bool   InpRequireInsideBar     = true;

//==================================================
// GLOBAL VARIABLES
//==================================================
datetime g_lastBarTime       = 0;
double   g_motherHigh        = 0.0;
double   g_motherLow         = 0.0;
datetime g_motherBarTime     = 0;
bool     g_motherBarValid    = false;
bool     g_setupTriggered    = false;

//==================================================
// FUNCTION DECLARATIONS
//==================================================
bool   IsNewBar();
bool   IsTradingAllowed();
bool   IsSpreadAllowed();
int    CountOwnPositions();
void   DetectMotherBar();
void   CheckEntry();
bool   OpenBuy();
bool   OpenSell();
void   ManagePositions();
void   ManageBreakEven(ulong ticket);
void   ManageTrailingStop(ulong ticket);
bool   ModifyPositionSLTP(ulong ticket,double sl,double tp);
double NormalizePrice(double price);
double NormalizeVolume(double volume);
double GetMinStopDistance();
bool   IsValidBuySL(double sl,double bid);
bool   IsValidSellSL(double sl,double ask);

//==================================================
// ONINIT
//==================================================
int OnInit()
{
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   g_lastBarTime = iTime(_Symbol,_Period,0);

   DetectMotherBar();

   return(INIT_SUCCEEDED);
}

//==================================================
// ONDEINIT
//==================================================
void OnDeinit(const int reason)
{
}

//==================================================
// ONTICK
//==================================================
void OnTick()
{
   // Position management must work on every tick.
   ManagePositions();

   if(!IsTradingAllowed())
      return;

   if(IsNewBar())
      DetectMotherBar();

   if(!g_motherBarValid)
      return;

   if(CountOwnPositions() >= InpMaxPositions)
      return;

   if(!IsSpreadAllowed())
      return;

   CheckEntry();
}

//==================================================
// NEW BAR CHECK
//==================================================
bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol,_Period,0);

   if(currentBarTime <= 0)
      return(false);

   if(currentBarTime != g_lastBarTime)
   {
      g_lastBarTime = currentBarTime;
      return(true);
   }

   return(false);
}

//==================================================
// ACCOUNT / TERMINAL CHECK
//==================================================
bool IsTradingAllowed()
{
   if(!TerminalInfoInteger(TERMINAL_CONNECTED))
      return(false);

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return(false);

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return(false);

   if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
      return(false);

   if(!AccountInfoInteger(ACCOUNT_TRADE_EXPERT))
      return(false);

   return(true);
}

//==================================================
// SPREAD FILTER
//==================================================
bool IsSpreadAllowed()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return(false);

   if(_Point <= 0.0)
      return(false);

   double spreadPoints = (tick.ask - tick.bid) / _Point;

   return(spreadPoints <= (double)InpMaxSpread);
}

//==================================================
// COUNT POSITIONS FOR SYMBOL + MAGIC
//==================================================
int CountOwnPositions()
{
   int count = 0;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      ulong magic   = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol == _Symbol && magic == InpMagicNumber)
         count++;
   }

   return(count);
}

//==================================================
// DETECT MOTHER BAR
//
// Structure:
// Bar[2] = potential Mother Bar
// Bar[1] = completed Inside Bar
//
// Mother Bar is valid when Bar[1] is fully inside Bar[2].
//==================================================
void DetectMotherBar()
{
   if(Bars(_Symbol,_Period) < 4)
   {
      g_motherBarValid = false;
      return;
   }

   double motherHigh = iHigh(_Symbol,_Period,2);
   double motherLow  = iLow(_Symbol,_Period,2);
   double insideHigh = iHigh(_Symbol,_Period,1);
   double insideLow  = iLow(_Symbol,_Period,1);

   datetime motherTime = iTime(_Symbol,_Period,2);

   if(motherHigh <= 0.0 || motherLow <= 0.0 ||
      insideHigh <= 0.0 || insideLow <= 0.0)
   {
      g_motherBarValid = false;
      return;
   }

   bool validSetup = true;

   if(InpRequireInsideBar)
   {
      validSetup = (insideHigh <= motherHigh &&
                    insideLow  >= motherLow);
   }

   if(validSetup)
   {
      g_motherHigh     = NormalizePrice(motherHigh);
      g_motherLow      = NormalizePrice(motherLow);
      g_motherBarTime  = motherTime;
      g_motherBarValid = true;
      g_setupTriggered = false;
   }
   else
   {
      g_motherBarValid = false;
      g_setupTriggered = false;
   }
}

//==================================================
// ENTRY LOGIC
// BUY  = price breaks Mother Bar High
// SELL = price breaks Mother Bar Low
//==================================================
void CheckEntry()
{
   if(g_setupTriggered)
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return;

   if(tick.ask > g_motherHigh)
   {
      if(OpenBuy())
         g_setupTriggered = true;

      return;
   }

   if(tick.bid < g_motherLow)
   {
      if(OpenSell())
         g_setupTriggered = true;

      return;
   }
}

//==================================================
// BUY
//==================================================
bool OpenBuy()
{
   if(CountOwnPositions() >= InpMaxPositions)
      return(false);

   if(!IsSpreadAllowed())
      return(false);

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return(false);

   double volume = NormalizeVolume(InpLotSize);

   if(volume <= 0.0)
      return(false);

   double entry = tick.ask;
   double sl    = 0.0;
   double tp    = 0.0;

   if(InpStopLoss > 0)
      sl = NormalizePrice(entry - ((double)InpStopLoss * _Point));

   if(InpTakeProfit > 0)
      tp = NormalizePrice(entry + ((double)InpTakeProfit * _Point));

   double minStop = GetMinStopDistance();

   if(sl > 0.0 && (entry - sl) < minStop)
      sl = NormalizePrice(entry - minStop);

   if(tp > 0.0 && (tp - entry) < minStop)
      tp = NormalizePrice(entry + minStop);

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   ResetLastError();

   bool result = trade.Buy(
      volume,
      _Symbol,
      0.0,
      sl,
      tp,
      "MotherBar BUY"
   );

   if(!result)
   {
      PrintFormat(
         "BUY failed. Retcode=%u | Description=%s | LastError=%d",
         trade.ResultRetcode(),
         trade.ResultRetcodeDescription(),
         GetLastError()
      );

      return(false);
   }

   PrintFormat(
      "BUY opened. Deal=%I64u | Order=%I64u | Price=%.5f | SL=%.5f | TP=%.5f",
      trade.ResultDeal(),
      trade.ResultOrder(),
      trade.ResultPrice(),
      sl,
      tp
   );

   return(true);
}

//==================================================
// SELL
//==================================================
bool OpenSell()
{
   if(CountOwnPositions() >= InpMaxPositions)
      return(false);

   if(!IsSpreadAllowed())
      return(false);

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return(false);

   double volume = NormalizeVolume(InpLotSize);

   if(volume <= 0.0)
      return(false);

   double entry = tick.bid;
   double sl    = 0.0;
   double tp    = 0.0;

   if(InpStopLoss > 0)
      sl = NormalizePrice(entry + ((double)InpStopLoss * _Point));

   if(InpTakeProfit > 0)
      tp = NormalizePrice(entry - ((double)InpTakeProfit * _Point));

   double minStop = GetMinStopDistance();

   if(sl > 0.0 && (sl - entry) < minStop)
      sl = NormalizePrice(entry + minStop);

   if(tp > 0.0 && (entry - tp) < minStop)
      tp = NormalizePrice(entry - minStop);

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   ResetLastError();

   bool result = trade.Sell(
      volume,
      _Symbol,
      0.0,
      sl,
      tp,
      "MotherBar SELL"
   );

   if(!result)
   {
      PrintFormat(
         "SELL failed. Retcode=%u | Description=%s | LastError=%d",
         trade.ResultRetcode(),
         trade.ResultRetcodeDescription(),
         GetLastError()
      );

      return(false);
   }

   PrintFormat(
      "SELL opened. Deal=%I64u | Order=%I64u | Price=%.5f | SL=%.5f | TP=%.5f",
      trade.ResultDeal(),
      trade.ResultOrder(),
      trade.ResultPrice(),
      sl,
      tp
   );

   return(true);
}

//==================================================
// POSITION MANAGEMENT
//==================================================
void ManagePositions()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      ulong magic   = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol != _Symbol || magic != InpMagicNumber)
         continue;

      if(InpUseBreakEven)
         ManageBreakEven(ticket);

      if(InpUseTrailingStop)
         ManageTrailingStop(ticket);
   }
}

//==================================================
// BREAK EVEN
//==================================================
void ManageBreakEven(ulong ticket)
{
   if(!PositionSelectByTicket(ticket))
      return;

   ENUM_POSITION_TYPE type =
      (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

   double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double currentSL = PositionGetDouble(POSITION_SL);
   double currentTP = PositionGetDouble(POSITION_TP);

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return;

   double minStop = GetMinStopDistance();

   if(type == POSITION_TYPE_BUY)
   {
      double profitPoints = (tick.bid - openPrice) / _Point;

      if(profitPoints < (double)InpBreakEvenTrigger)
         return;

      double newSL =
         NormalizePrice(openPrice +
                        ((double)InpBreakEvenOffset * _Point));

      if(!IsValidBuySL(newSL,tick.bid))
         return;

      if((tick.bid - newSL) < minStop)
         return;

      if(currentSL == 0.0 || newSL > currentSL + (_Point * 0.5))
         ModifyPositionSLTP(ticket,newSL,currentTP);
   }
   else if(type == POSITION_TYPE_SELL)
   {
      double profitPoints = (openPrice - tick.ask) / _Point;

      if(profitPoints < (double)InpBreakEvenTrigger)
         return;

      double newSL =
         NormalizePrice(openPrice -
                        ((double)InpBreakEvenOffset * _Point));

      if(!IsValidSellSL(newSL,tick.ask))
         return;

      if((newSL - tick.ask) < minStop)
         return;

      if(currentSL == 0.0 || newSL < currentSL - (_Point * 0.5))
         ModifyPositionSLTP(ticket,newSL,currentTP);
   }
}

//==================================================
// TRAILING STOP
//==================================================
void ManageTrailingStop(ulong ticket)
{
   if(!PositionSelectByTicket(ticket))
      return;

   ENUM_POSITION_TYPE type =
      (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

   double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double currentSL = PositionGetDouble(POSITION_SL);
   double currentTP = PositionGetDouble(POSITION_TP);

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return;

   double minStop = GetMinStopDistance();
   double trailingDistance =
      MathMax((double)InpTrailingDistance * _Point,minStop);

   if(type == POSITION_TYPE_BUY)
   {
      double profitPoints = (tick.bid - openPrice) / _Point;

      if(profitPoints < (double)InpTrailingStart)
         return;

      double newSL =
         NormalizePrice(tick.bid - trailingDistance);

      // Do not let trailing move below break-even once
      // Break Even conditions have already been reached.
      if(InpUseBreakEven &&
         profitPoints >= (double)InpBreakEvenTrigger)
      {
         double breakEvenPrice =
            NormalizePrice(openPrice +
                           ((double)InpBreakEvenOffset * _Point));

         if(newSL < breakEvenPrice)
            newSL = breakEvenPrice;
      }

      if(!IsValidBuySL(newSL,tick.bid))
         return;

      if(currentSL == 0.0 || newSL > currentSL + (_Point * 0.5))
         ModifyPositionSLTP(ticket,newSL,currentTP);
   }
   else if(type == POSITION_TYPE_SELL)
   {
      double profitPoints = (openPrice - tick.ask) / _Point;

      if(profitPoints < (double)InpTrailingStart)
         return;

      double newSL =
         NormalizePrice(tick.ask + trailingDistance);

      if(InpUseBreakEven &&
         profitPoints >= (double)InpBreakEvenTrigger)
      {
         double breakEvenPrice =
            NormalizePrice(openPrice -
                           ((double)InpBreakEvenOffset * _Point));

         if(newSL > breakEvenPrice)
            newSL = breakEvenPrice;
      }

      if(!IsValidSellSL(newSL,tick.ask))
         return;

      if(currentSL == 0.0 || newSL < currentSL - (_Point * 0.5))
         ModifyPositionSLTP(ticket,newSL,currentTP);
   }
}

//==================================================
// MODIFY POSITION BY TICKET
//==================================================
bool ModifyPositionSLTP(ulong ticket,double sl,double tp)
{
   if(!PositionSelectByTicket(ticket))
      return(false);

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);

   ResetLastError();

   bool result = trade.PositionModify(ticket,sl,tp);

   if(!result)
   {
      PrintFormat(
         "PositionModify failed. Ticket=%I64u | Retcode=%u | Description=%s | LastError=%d",
         ticket,
         trade.ResultRetcode(),
         trade.ResultRetcodeDescription(),
         GetLastError()
      );

      return(false);
   }

   return(true);
}

//==================================================
// NORMALIZE PRICE
//==================================================
double NormalizePrice(double price)
{
   double tickSize = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);

   if(tickSize <= 0.0)
      return(NormalizeDouble(price,_Digits));

   double normalized =
      MathRound(price / tickSize) * tickSize;

   return(NormalizeDouble(normalized,_Digits));
}

//==================================================
// NORMALIZE LOT SIZE
//==================================================
double NormalizeVolume(double volume)
{
   double minVolume =
      SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);

   double maxVolume =
      SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MAX);

   double volumeStep =
      SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

   if(minVolume <= 0.0 ||
      maxVolume <= 0.0 ||
      volumeStep <= 0.0)
      return(0.0);

   volume = MathMax(minVolume,MathMin(maxVolume,volume));

   double normalized =
      MathFloor((volume - minVolume) / volumeStep + 0.5)
      * volumeStep + minVolume;

   normalized =
      MathMax(minVolume,MathMin(maxVolume,normalized));

   return(NormalizeDouble(normalized,8));
}

//==================================================
// MINIMUM BROKER STOP DISTANCE
//==================================================
double GetMinStopDistance()
{
   long stopsLevel = 0;

   if(!SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL,stopsLevel))
      stopsLevel = 0;

   return((double)stopsLevel * _Point);
}

//==================================================
// VALIDATE BUY STOP LOSS
//==================================================
bool IsValidBuySL(double sl,double bid)
{
   if(sl <= 0.0)
      return(false);

   if(sl >= bid)
      return(false);

   double minStop = GetMinStopDistance();

   if((bid - sl) < minStop)
      return(false);

   return(true);
}

//==================================================
// VALIDATE SELL STOP LOSS
//==================================================
bool IsValidSellSL(double sl,double ask)
{
   if(sl <= ask)
      return(false);

   double minStop = GetMinStopDistance();

   if((sl - ask) < minStop)
      return(false);

   return(true);
}