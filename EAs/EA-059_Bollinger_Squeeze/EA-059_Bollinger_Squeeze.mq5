//+------------------------------------------------------------------+
//|                                            BollingerSqueezeEA.mq5 |
//|                        Bollinger Squeeze Breakout - MetaTrader 5 |
//+------------------------------------------------------------------+
#property strict
#property version   "1.00"

#include <Trade\Trade.mqh>

CTrade trade;

//--- Trading inputs
input double InpLotSize              = 0.01;
input int    InpStopLoss             = 300;
input int    InpTakeProfit           = 600;
input ulong  InpMagicNumber          = 123456;
input int    InpSlippage             = 10;

//--- Bollinger Bands
input int    InpBBPeriod              = 20;
input double InpBBDeviation           = 2.0;
input int    InpSqueezeWidthPoints    = 150;

//--- Filters
input int    InpMaxSpreadPoints       = 30;

//--- Break Even
input bool   InpUseBreakEven          = true;
input int    InpBreakEvenTrigger      = 150;
input int    InpBreakEvenLockPoints   = 0;

//--- Trailing Stop
input bool   InpUseTrailingStop       = true;
input int    InpTrailingStart         = 200;
input int    InpTrailingDistance      = 150;

//--- Indicator handle
int      g_bbHandle       = INVALID_HANDLE;
datetime g_lastBarTime    = 0;

//+------------------------------------------------------------------+
//| Normalize price                                                  |
//+------------------------------------------------------------------+
double NormalizePrice(const double price)
{
   return NormalizeDouble(price, (int)_Digits);
}

//+------------------------------------------------------------------+
//| Check if trading is allowed                                      |
//+------------------------------------------------------------------+
bool IsTradingAllowed()
{
   if(!TerminalInfoInteger(TERMINAL_CONNECTED))
      return false;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return false;

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return false;

   if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Check new bar                                                    |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   const datetime currentBarTime = iTime(_Symbol, _Period, 0);

   if(currentBarTime <= 0)
      return false;

   if(currentBarTime == g_lastBarTime)
      return false;

   g_lastBarTime = currentBarTime;
   return true;
}

//+------------------------------------------------------------------+
//| Check spread                                                     |
//+------------------------------------------------------------------+
bool IsSpreadAllowed()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   if(tick.ask <= 0.0 || tick.bid <= 0.0)
      return false;

   const double spreadPoints = (tick.ask - tick.bid) / _Point;

   return (spreadPoints <= (double)InpMaxSpreadPoints);
}

//+------------------------------------------------------------------+
//| Check if this EA already has an open position                    |
//+------------------------------------------------------------------+
bool HasOpenPosition()
{
   const int total = PositionsTotal();

   for(int i = 0; i < total; i++)
   {
      const ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      const string symbol = PositionGetString(POSITION_SYMBOL);
      const ulong  magic  = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol == _Symbol && magic == InpMagicNumber)
         return true;
   }

   return false;
}

//+------------------------------------------------------------------+
//| Read Bollinger Bands                                             |
//+------------------------------------------------------------------+
bool GetBollingerBands(const int shift,
                       double &middle,
                       double &upper,
                       double &lower)
{
   if(g_bbHandle == INVALID_HANDLE)
      return false;

   double middleBuffer[1];
   double upperBuffer[1];
   double lowerBuffer[1];

   if(CopyBuffer(g_bbHandle, 0, shift, 1, middleBuffer) != 1)
      return false;

   if(CopyBuffer(g_bbHandle, 1, shift, 1, upperBuffer) != 1)
      return false;

   if(CopyBuffer(g_bbHandle, 2, shift, 1, lowerBuffer) != 1)
      return false;

   middle = middleBuffer[0];
   upper  = upperBuffer[0];
   lower  = lowerBuffer[0];

   return true;
}

//+------------------------------------------------------------------+
//| Check previous candle squeeze                                    |
//+------------------------------------------------------------------+
bool WasSqueeze()
{
   double middle = 0.0;
   double upper  = 0.0;
   double lower  = 0.0;

   // Shift 2 = candle immediately before breakout candle
   if(!GetBollingerBands(2, middle, upper, lower))
      return false;

   const double widthPoints = (upper - lower) / _Point;

   return (widthPoints <= (double)InpSqueezeWidthPoints);
}

//+------------------------------------------------------------------+
//| Get breakout signal                                              |
//|  1 = BUY                                                         |
//| -1 = SELL                                                        |
//|  0 = NONE                                                        |
//+------------------------------------------------------------------+
int GetSignal()
{
   if(!WasSqueeze())
      return 0;

   double middle1 = 0.0;
   double upper1  = 0.0;
   double lower1  = 0.0;

   double middle2 = 0.0;
   double upper2  = 0.0;
   double lower2  = 0.0;

   if(!GetBollingerBands(1, middle1, upper1, lower1))
      return 0;

   if(!GetBollingerBands(2, middle2, upper2, lower2))
      return 0;

   const double close1 = iClose(_Symbol, _Period, 1);
   const double close2 = iClose(_Symbol, _Period, 2);

   if(close1 <= 0.0 || close2 <= 0.0)
      return 0;

   // BUY:
   // Previous squeeze candle was not above its upper band,
   // latest closed candle breaks and closes above upper band.
   if(close2 <= upper2 && close1 > upper1)
      return 1;

   // SELL:
   // Previous squeeze candle was not below its lower band,
   // latest closed candle breaks and closes below lower band.
   if(close2 >= lower2 && close1 < lower1)
      return -1;

   return 0;
}

//+------------------------------------------------------------------+
//| Validate and normalize lot                                       |
//+------------------------------------------------------------------+
double GetValidLotSize()
{
   const double minLot  = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   const double maxLot  = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   const double lotStep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);

   if(minLot <= 0.0 || maxLot <= 0.0 || lotStep <= 0.0)
      return 0.0;

   double lot = InpLotSize;

   if(lot < minLot)
      lot = minLot;

   if(lot > maxLot)
      lot = maxLot;

   lot = MathFloor(lot / lotStep + 0.0000001) * lotStep;

   if(lot < minLot)
      lot = minLot;

   return NormalizeDouble(lot, 8);
}

//+------------------------------------------------------------------+
//| Validate SL/TP distance against broker restrictions              |
//+------------------------------------------------------------------+
int GetMinimumStopDistancePoints()
{
   const int stopsLevel = (int)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);

   if(stopsLevel < 0)
      return 0;

   return stopsLevel;
}

//+------------------------------------------------------------------+
//| Open BUY                                                         |
//+------------------------------------------------------------------+
bool OpenBuy()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   const double lot = GetValidLotSize();

   if(lot <= 0.0)
      return false;

   const int minStops = GetMinimumStopDistancePoints();

   int slPoints = InpStopLoss;
   int tpPoints = InpTakeProfit;

   if(slPoints > 0 && slPoints < minStops)
      slPoints = minStops;

   if(tpPoints > 0 && tpPoints < minStops)
      tpPoints = minStops;

   double sl = 0.0;
   double tp = 0.0;

   if(slPoints > 0)
      sl = NormalizePrice(tick.ask - (double)slPoints * _Point);

   if(tpPoints > 0)
      tp = NormalizePrice(tick.ask + (double)tpPoints * _Point);

   ResetLastError();

   const bool result = trade.Buy(lot,
                                 _Symbol,
                                 0.0,
                                 sl,
                                 tp,
                                 "BB Squeeze BUY");

   if(!result)
   {
      Print("BUY failed. Retcode=",
            trade.ResultRetcode(),
            " Description=",
            trade.ResultRetcodeDescription(),
            " LastError=",
            GetLastError());

      return false;
   }

   Print("BUY opened. Order=",
         trade.ResultOrder(),
         " Deal=",
         trade.ResultDeal(),
         " Price=",
         trade.ResultPrice());

   return true;
}

//+------------------------------------------------------------------+
//| Open SELL                                                        |
//+------------------------------------------------------------------+
bool OpenSell()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   const double lot = GetValidLotSize();

   if(lot <= 0.0)
      return false;

   const int minStops = GetMinimumStopDistancePoints();

   int slPoints = InpStopLoss;
   int tpPoints = InpTakeProfit;

   if(slPoints > 0 && slPoints < minStops)
      slPoints = minStops;

   if(tpPoints > 0 && tpPoints < minStops)
      tpPoints = minStops;

   double sl = 0.0;
   double tp = 0.0;

   if(slPoints > 0)
      sl = NormalizePrice(tick.bid + (double)slPoints * _Point);

   if(tpPoints > 0)
      tp = NormalizePrice(tick.bid - (double)tpPoints * _Point);

   ResetLastError();

   const bool result = trade.Sell(lot,
                                  _Symbol,
                                  0.0,
                                  sl,
                                  tp,
                                  "BB Squeeze SELL");

   if(!result)
   {
      Print("SELL failed. Retcode=",
            trade.ResultRetcode(),
            " Description=",
            trade.ResultRetcodeDescription(),
            " LastError=",
            GetLastError());

      return false;
   }

   Print("SELL opened. Order=",
         trade.ResultOrder(),
         " Deal=",
         trade.ResultDeal(),
         " Price=",
         trade.ResultPrice());

   return true;
}

//+------------------------------------------------------------------+
//| Calculate protected SL for BUY                                   |
//+------------------------------------------------------------------+
double GetBuyProtectedSL(const double openPrice,
                         const double currentBid,
                         const double currentSL)
{
   double desiredSL = currentSL;

   const double profitPoints = (currentBid - openPrice) / _Point;

   //--- Break Even
   if(InpUseBreakEven && profitPoints >= (double)InpBreakEvenTrigger)
   {
      const double beSL =
         NormalizePrice(openPrice + (double)InpBreakEvenLockPoints * _Point);

      if(desiredSL == 0.0 || beSL > desiredSL)
         desiredSL = beSL;
   }

   //--- Trailing Stop
   if(InpUseTrailingStop && profitPoints >= (double)InpTrailingStart)
   {
      const double trailingSL =
         NormalizePrice(currentBid - (double)InpTrailingDistance * _Point);

      if(desiredSL == 0.0 || trailingSL > desiredSL)
         desiredSL = trailingSL;
   }

   return desiredSL;
}

//+------------------------------------------------------------------+
//| Calculate protected SL for SELL                                  |
//+------------------------------------------------------------------+
double GetSellProtectedSL(const double openPrice,
                          const double currentAsk,
                          const double currentSL)
{
   double desiredSL = currentSL;

   const double profitPoints = (openPrice - currentAsk) / _Point;

   //--- Break Even
   if(InpUseBreakEven && profitPoints >= (double)InpBreakEvenTrigger)
   {
      const double beSL =
         NormalizePrice(openPrice - (double)InpBreakEvenLockPoints * _Point);

      if(desiredSL == 0.0 || beSL < desiredSL)
         desiredSL = beSL;
   }

   //--- Trailing Stop
   if(InpUseTrailingStop && profitPoints >= (double)InpTrailingStart)
   {
      const double trailingSL =
         NormalizePrice(currentAsk + (double)InpTrailingDistance * _Point);

      if(desiredSL == 0.0 || trailingSL < desiredSL)
         desiredSL = trailingSL;
   }

   return desiredSL;
}

//+------------------------------------------------------------------+
//| Manage open positions                                            |
//+------------------------------------------------------------------+
void ManagePositions()
{
   if(!InpUseBreakEven && !InpUseTrailingStop)
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   const int total = PositionsTotal();

   for(int i = total - 1; i >= 0; i--)
   {
      const ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      const string symbol = PositionGetString(POSITION_SYMBOL);
      const ulong  magic  = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol != _Symbol || magic != InpMagicNumber)
         continue;

      const ENUM_POSITION_TYPE type =
         (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

      const double openPrice  = PositionGetDouble(POSITION_PRICE_OPEN);
      const double currentSL  = PositionGetDouble(POSITION_SL);
      const double currentTP  = PositionGetDouble(POSITION_TP);

      double newSL = currentSL;

      if(type == POSITION_TYPE_BUY)
      {
         newSL = GetBuyProtectedSL(openPrice, tick.bid, currentSL);

         if(newSL <= 0.0)
            continue;

         // Do not move stop backwards
         if(currentSL > 0.0 && newSL <= currentSL + (_Point * 0.1))
            continue;

         const int minStops = GetMinimumStopDistancePoints();
         const double maximumAllowedSL =
            NormalizePrice(tick.bid - (double)minStops * _Point);

         if(newSL > maximumAllowedSL)
            newSL = maximumAllowedSL;

         if(newSL <= 0.0)
            continue;

         if(currentSL > 0.0 && newSL <= currentSL + (_Point * 0.1))
            continue;

         ResetLastError();

         if(!trade.PositionModify(ticket, newSL, currentTP))
         {
            Print("BUY position modify failed. Ticket=",
                  ticket,
                  " Retcode=",
                  trade.ResultRetcode(),
                  " Description=",
                  trade.ResultRetcodeDescription(),
                  " LastError=",
                  GetLastError());
         }
      }
      else if(type == POSITION_TYPE_SELL)
      {
         newSL = GetSellProtectedSL(openPrice, tick.ask, currentSL);

         if(newSL <= 0.0)
            continue;

         // Do not move stop backwards
         if(currentSL > 0.0 && newSL >= currentSL - (_Point * 0.1))
            continue;

         const int minStops = GetMinimumStopDistancePoints();
         const double minimumAllowedSL =
            NormalizePrice(tick.ask + (double)minStops * _Point);

         if(newSL < minimumAllowedSL)
            newSL = minimumAllowedSL;

         if(newSL <= 0.0)
            continue;

         if(currentSL > 0.0 && newSL >= currentSL - (_Point * 0.1))
            continue;

         ResetLastError();

         if(!trade.PositionModify(ticket, newSL, currentTP))
         {
            Print("SELL position modify failed. Ticket=",
                  ticket,
                  " Retcode=",
                  trade.ResultRetcode(),
                  " Description=",
                  trade.ResultRetcodeDescription(),
                  " LastError=",
                  GetLastError());
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Expert initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   if(InpLotSize <= 0.0)
   {
      Print("Invalid Lot Size.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpBBPeriod < 2)
   {
      Print("Invalid Bollinger Bands period.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpBBDeviation <= 0.0)
   {
      Print("Invalid Bollinger Bands deviation.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpSqueezeWidthPoints <= 0)
   {
      Print("Invalid squeeze width.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpMaxSpreadPoints < 0)
   {
      Print("Invalid maximum spread.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpStopLoss < 0 || InpTakeProfit < 0)
   {
      Print("SL/TP cannot be negative.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpBreakEvenTrigger < 0 ||
      InpBreakEvenLockPoints < 0 ||
      InpTrailingStart < 0 ||
      InpTrailingDistance <= 0)
   {
      Print("Invalid Break Even / Trailing parameters.");
      return INIT_PARAMETERS_INCORRECT;
   }

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   trade.SetAsyncMode(false);

   g_bbHandle = iBands(_Symbol,
                       _Period,
                       InpBBPeriod,
                       0,
                       InpBBDeviation,
                       PRICE_CLOSE);

   if(g_bbHandle == INVALID_HANDLE)
   {
      Print("Failed to create Bollinger Bands handle. Error=",
            GetLastError());

      return INIT_FAILED;
   }

   g_lastBarTime = iTime(_Symbol, _Period, 0);

   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   if(g_bbHandle != INVALID_HANDLE)
   {
      IndicatorRelease(g_bbHandle);
      g_bbHandle = INVALID_HANDLE;
   }

   Print("EA deinitialized. Reason=", reason);
}

//+------------------------------------------------------------------+
//| Expert tick                                                      |
//+------------------------------------------------------------------+
void OnTick()
{
   //--- Manage BE / Trailing on every tick
   ManagePositions();

   //--- Entry calculations only once per new candle
   if(!IsNewBar())
      return;

   if(!IsTradingAllowed())
      return;

   if(Bars(_Symbol, _Period) < InpBBPeriod + 10)
      return;

   if(BarsCalculated(g_bbHandle) < InpBBPeriod + 3)
      return;

   if(!IsSpreadAllowed())
      return;

   //--- Maximum 1 open position for this symbol + MagicNumber
   if(HasOpenPosition())
      return;

   const int signal = GetSignal();

   if(signal == 1)
   {
      OpenBuy();
   }
   else if(signal == -1)
   {
      OpenSell();
   }
}
//+------------------------------------------------------------------+