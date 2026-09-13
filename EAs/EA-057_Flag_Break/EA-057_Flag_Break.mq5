//+------------------------------------------------------------------+
//|                                             ImpulseFlagBreak.mq5  |
//|  Strategy: Impulse Candle -> Flag Consolidation -> Breakout      |
//+------------------------------------------------------------------+
#property strict
#property version   "1.00"
#property description "Impulse candle + flag breakout EA"

#include <Trade\Trade.mqh>

CTrade trade;

//+------------------------------------------------------------------+
//| General Inputs                                                   |
//+------------------------------------------------------------------+
input group "=== GENERAL SETTINGS ==="
input double InpLotSize             = 0.01;
input int    InpStopLoss            = 300;       // points
input int    InpTakeProfit          = 600;       // points
input ulong  InpMagicNumber         = 123456;
input int    InpSlippage            = 10;
input int    InpMaxSpread           = 30;        // points

//+------------------------------------------------------------------+
//| Break Even                                                       |
//+------------------------------------------------------------------+
input group "=== BREAK EVEN ==="
input bool   InpUseBreakEven        = true;
input int    InpBreakEvenTrigger    = 150;       // points
input int    InpBreakEvenLock       = 10;        // points profit locked

//+------------------------------------------------------------------+
//| Trailing Stop                                                    |
//+------------------------------------------------------------------+
input group "=== TRAILING STOP ==="
input bool   InpUseTrailingStop     = true;
input int    InpTrailingStart       = 200;       // points
input int    InpTrailingDistance    = 150;       // points
input int    InpTrailingStep        = 20;        // minimum SL improvement

//+------------------------------------------------------------------+
//| Impulse / Flag Detection                                         |
//+------------------------------------------------------------------+
input group "=== IMPULSE SETTINGS ==="
input int    InpAverageRangePeriod  = 20;
input double InpImpulseMultiplier   = 1.50;
input double InpMinBodyRatio        = 0.65;

input group "=== FLAG SETTINGS ==="
input int    InpFlagBars            = 3;
input double InpMaxFlagToImpulse    = 0.60;
input double InpMaxRetracement      = 0.60;
input int    InpBreakoutBuffer      = 0;

//+------------------------------------------------------------------+
//| Globals                                                          |
//+------------------------------------------------------------------+
datetime g_lastBarTime = 0;

//+------------------------------------------------------------------+
//| Helper: Normalize price                                          |
//+------------------------------------------------------------------+
double NormalizePrice(const double price)
{
   return NormalizeDouble(price, (int)_Digits);
}

//+------------------------------------------------------------------+
//| Helper: Check trading permission                                 |
//+------------------------------------------------------------------+
bool TradingAllowed()
{
   if(!TerminalInfoInteger(TERMINAL_CONNECTED))
      return false;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return false;

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return false;

   if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
      return false;

   if(!AccountInfoInteger(ACCOUNT_TRADE_EXPERT))
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Helper: New bar check                                            |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol, _Period, 0);

   if(currentBarTime <= 0)
      return false;

   if(currentBarTime != g_lastBarTime)
   {
      g_lastBarTime = currentBarTime;
      return true;
   }

   return false;
}

//+------------------------------------------------------------------+
//| Helper: Current spread                                           |
//+------------------------------------------------------------------+
bool SpreadAllowed()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   if(_Point <= 0.0)
      return false;

   double spreadPoints = (tick.ask - tick.bid) / _Point;

   return (spreadPoints <= (double)InpMaxSpread);
}

//+------------------------------------------------------------------+
//| Helper: Find our position                                        |
//+------------------------------------------------------------------+
bool GetOurPosition(ulong &ticket,
                    ENUM_POSITION_TYPE &positionType,
                    double &openPrice,
                    double &sl,
                    double &tp)
{
   ticket       = 0;
   positionType = POSITION_TYPE_BUY;
   openPrice    = 0.0;
   sl           = 0.0;
   tp           = 0.0;

   int total = PositionsTotal();

   for(int i = 0; i < total; i++)
   {
      ulong currentTicket = PositionGetTicket(i);

      if(currentTicket == 0)
         continue;

      if(!PositionSelectByTicket(currentTicket))
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      long magic    = PositionGetInteger(POSITION_MAGIC);

      if(symbol != _Symbol)
         continue;

      if((ulong)magic != InpMagicNumber)
         continue;

      ticket       = currentTicket;
      positionType = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
      openPrice    = PositionGetDouble(POSITION_PRICE_OPEN);
      sl           = PositionGetDouble(POSITION_SL);
      tp           = PositionGetDouble(POSITION_TP);

      return true;
   }

   return false;
}

//+------------------------------------------------------------------+
//| Helper: Does our position exist                                  |
//+------------------------------------------------------------------+
bool HasOpenPosition()
{
   ulong ticket;
   ENUM_POSITION_TYPE type;
   double openPrice;
   double sl;
   double tp;

   return GetOurPosition(ticket, type, openPrice, sl, tp);
}

//+------------------------------------------------------------------+
//| Helper: Broker minimum stop distance                             |
//+------------------------------------------------------------------+
double MinimumStopDistance()
{
   long stopsLevel = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);

   if(stopsLevel < 0)
      stopsLevel = 0;

   return (double)stopsLevel * _Point;
}

//+------------------------------------------------------------------+
//| Calculate average candle range                                   |
//+------------------------------------------------------------------+
double GetAverageRange(const int startShift, const int period)
{
   if(period <= 0)
      return 0.0;

   double totalRange = 0.0;
   int validBars = 0;

   for(int shift = startShift; shift < startShift + period; shift++)
   {
      double high = iHigh(_Symbol, _Period, shift);
      double low  = iLow(_Symbol, _Period, shift);

      if(high <= 0.0 || low <= 0.0 || high < low)
         continue;

      totalRange += (high - low);
      validBars++;
   }

   if(validBars <= 0)
      return 0.0;

   return totalRange / (double)validBars;
}

//+------------------------------------------------------------------+
//| Detect bullish impulse                                           |
//+------------------------------------------------------------------+
bool IsBullishImpulse(const int shift)
{
   double open  = iOpen(_Symbol, _Period, shift);
   double close = iClose(_Symbol, _Period, shift);
   double high  = iHigh(_Symbol, _Period, shift);
   double low   = iLow(_Symbol, _Period, shift);

   if(open <= 0.0 || close <= 0.0 || high <= low)
      return false;

   if(close <= open)
      return false;

   double range = high - low;
   double body  = close - open;

   if(range <= 0.0)
      return false;

   double bodyRatio = body / range;

   if(bodyRatio < InpMinBodyRatio)
      return false;

   double averageRange =
      GetAverageRange(shift + 1, InpAverageRangePeriod);

   if(averageRange <= 0.0)
      return false;

   if(range < averageRange * InpImpulseMultiplier)
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Detect bearish impulse                                           |
//+------------------------------------------------------------------+
bool IsBearishImpulse(const int shift)
{
   double open  = iOpen(_Symbol, _Period, shift);
   double close = iClose(_Symbol, _Period, shift);
   double high  = iHigh(_Symbol, _Period, shift);
   double low   = iLow(_Symbol, _Period, shift);

   if(open <= 0.0 || close <= 0.0 || high <= low)
      return false;

   if(close >= open)
      return false;

   double range = high - low;
   double body  = open - close;

   if(range <= 0.0)
      return false;

   double bodyRatio = body / range;

   if(bodyRatio < InpMinBodyRatio)
      return false;

   double averageRange =
      GetAverageRange(shift + 1, InpAverageRangePeriod);

   if(averageRange <= 0.0)
      return false;

   if(range < averageRange * InpImpulseMultiplier)
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Detect Bullish Flag Breakout                                     |
//|                                                                  |
//| Layout:                                                          |
//| shift 1                  = breakout candle                       |
//| shift 2..FlagBars+1      = flag candles                          |
//| shift FlagBars+2         = impulse candle                        |
//+------------------------------------------------------------------+
bool BullishSignal()
{
   int impulseShift = InpFlagBars + 2;

   if(!IsBullishImpulse(impulseShift))
      return false;

   double impulseHigh  = iHigh(_Symbol, _Period, impulseShift);
   double impulseLow   = iLow(_Symbol, _Period, impulseShift);
   double impulseClose = iClose(_Symbol, _Period, impulseShift);

   double impulseRange = impulseHigh - impulseLow;

   if(impulseRange <= 0.0)
      return false;

   double flagHigh = -DBL_MAX;
   double flagLow  = DBL_MAX;

   for(int shift = 2; shift <= InpFlagBars + 1; shift++)
   {
      double high = iHigh(_Symbol, _Period, shift);
      double low  = iLow(_Symbol, _Period, shift);

      if(high <= 0.0 || low <= 0.0 || high < low)
         return false;

      if(high > flagHigh)
         flagHigh = high;

      if(low < flagLow)
         flagLow = low;
   }

   double flagRange = flagHigh - flagLow;

   if(flagRange <= 0.0)
      return false;

   // Flag must be clearly smaller than impulse
   if(flagRange > impulseRange * InpMaxFlagToImpulse)
      return false;

   // Maximum retracement from impulse high
   double retracement = impulseHigh - flagLow;

   if(retracement > impulseRange * InpMaxRetracement)
      return false;

   // Do not allow a complete failure below impulse origin
   if(flagLow <= impulseLow)
      return false;

   // Prefer consolidation occurring around/above impulse close area
   if(flagHigh < impulseClose - impulseRange * InpMaxRetracement)
      return false;

   double breakoutOpen  = iOpen(_Symbol, _Period, 1);
   double breakoutClose = iClose(_Symbol, _Period, 1);
   double breakoutHigh  = iHigh(_Symbol, _Period, 1);

   double breakoutLevel =
      flagHigh + ((double)InpBreakoutBuffer * _Point);

   // Breakout candle must close bullish and above flag resistance
   if(breakoutClose <= breakoutOpen)
      return false;

   if(breakoutHigh <= breakoutLevel)
      return false;

   if(breakoutClose <= breakoutLevel)
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Detect Bearish Flag Breakout                                     |
//+------------------------------------------------------------------+
bool BearishSignal()
{
   int impulseShift = InpFlagBars + 2;

   if(!IsBearishImpulse(impulseShift))
      return false;

   double impulseHigh  = iHigh(_Symbol, _Period, impulseShift);
   double impulseLow   = iLow(_Symbol, _Period, impulseShift);
   double impulseClose = iClose(_Symbol, _Period, impulseShift);

   double impulseRange = impulseHigh - impulseLow;

   if(impulseRange <= 0.0)
      return false;

   double flagHigh = -DBL_MAX;
   double flagLow  = DBL_MAX;

   for(int shift = 2; shift <= InpFlagBars + 1; shift++)
   {
      double high = iHigh(_Symbol, _Period, shift);
      double low  = iLow(_Symbol, _Period, shift);

      if(high <= 0.0 || low <= 0.0 || high < low)
         return false;

      if(high > flagHigh)
         flagHigh = high;

      if(low < flagLow)
         flagLow = low;
   }

   double flagRange = flagHigh - flagLow;

   if(flagRange <= 0.0)
      return false;

   // Flag must be smaller than impulse
   if(flagRange > impulseRange * InpMaxFlagToImpulse)
      return false;

   // Maximum retracement from impulse low
   double retracement = flagHigh - impulseLow;

   if(retracement > impulseRange * InpMaxRetracement)
      return false;

   // Do not allow complete failure above impulse origin
   if(flagHigh >= impulseHigh)
      return false;

   if(flagLow > impulseClose + impulseRange * InpMaxRetracement)
      return false;

   double breakoutOpen  = iOpen(_Symbol, _Period, 1);
   double breakoutClose = iClose(_Symbol, _Period, 1);
   double breakoutLow   = iLow(_Symbol, _Period, 1);

   double breakoutLevel =
      flagLow - ((double)InpBreakoutBuffer * _Point);

   // Breakout candle must close bearish and below flag support
   if(breakoutClose >= breakoutOpen)
      return false;

   if(breakoutLow >= breakoutLevel)
      return false;

   if(breakoutClose >= breakoutLevel)
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Open Buy                                                         |
//+------------------------------------------------------------------+
bool OpenBuy()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
   {
      Print("OpenBuy: SymbolInfoTick failed. Error=", GetLastError());
      return false;
   }

   double minimumDistance = MinimumStopDistance();

   double slDistance = MathMax((double)InpStopLoss * _Point,
                               minimumDistance);

   double tpDistance = MathMax((double)InpTakeProfit * _Point,
                               minimumDistance);

   double sl = NormalizePrice(tick.ask - slDistance);
   double tp = NormalizePrice(tick.ask + tpDistance);

   ResetLastError();

   bool result = trade.Buy(
      InpLotSize,
      _Symbol,
      0.0,
      sl,
      tp,
      "ImpulseFlag BUY"
   );

   if(!result)
   {
      Print(
         "BUY failed. Retcode=",
         trade.ResultRetcode(),
         " Description=",
         trade.ResultRetcodeDescription(),
         " LastError=",
         GetLastError()
      );

      return false;
   }

   Print(
      "BUY opened successfully. Order=",
      trade.ResultOrder(),
      " Deal=",
      trade.ResultDeal(),
      " Price=",
      trade.ResultPrice()
   );

   return true;
}

//+------------------------------------------------------------------+
//| Open Sell                                                        |
//+------------------------------------------------------------------+
bool OpenSell()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
   {
      Print("OpenSell: SymbolInfoTick failed. Error=", GetLastError());
      return false;
   }

   double minimumDistance = MinimumStopDistance();

   double slDistance = MathMax((double)InpStopLoss * _Point,
                               minimumDistance);

   double tpDistance = MathMax((double)InpTakeProfit * _Point,
                               minimumDistance);

   double sl = NormalizePrice(tick.bid + slDistance);
   double tp = NormalizePrice(tick.bid - tpDistance);

   ResetLastError();

   bool result = trade.Sell(
      InpLotSize,
      _Symbol,
      0.0,
      sl,
      tp,
      "ImpulseFlag SELL"
   );

   if(!result)
   {
      Print(
         "SELL failed. Retcode=",
         trade.ResultRetcode(),
         " Description=",
         trade.ResultRetcodeDescription(),
         " LastError=",
         GetLastError()
      );

      return false;
   }

   Print(
      "SELL opened successfully. Order=",
      trade.ResultOrder(),
      " Deal=",
      trade.ResultDeal(),
      " Price=",
      trade.ResultPrice()
   );

   return true;
}

//+------------------------------------------------------------------+
//| Modify position                                                  |
//+------------------------------------------------------------------+
bool ModifyOurPosition(const ulong ticket,
                       const double newSL,
                       const double currentTP)
{
   ResetLastError();

   bool result = trade.PositionModify(
      ticket,
      NormalizePrice(newSL),
      NormalizePrice(currentTP)
   );

   if(!result)
   {
      Print(
         "PositionModify failed. Ticket=",
         ticket,
         " Retcode=",
         trade.ResultRetcode(),
         " Description=",
         trade.ResultRetcodeDescription(),
         " LastError=",
         GetLastError()
      );

      return false;
   }

   return true;
}

//+------------------------------------------------------------------+
//| Manage Break Even and Trailing Stop                              |
//+------------------------------------------------------------------+
void ManageOpenPosition()
{
   ulong ticket;
   ENUM_POSITION_TYPE positionType;
   double openPrice;
   double currentSL;
   double currentTP;

   if(!GetOurPosition(
      ticket,
      positionType,
      openPrice,
      currentSL,
      currentTP
   ))
   {
      return;
   }

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   double minimumDistance = MinimumStopDistance();

   //==============================================================
   // BUY POSITION
   //==============================================================
   if(positionType == POSITION_TYPE_BUY)
   {
      double profitPoints = (tick.bid - openPrice) / _Point;

      // Break Even
      if(InpUseBreakEven &&
         profitPoints >= (double)InpBreakEvenTrigger)
      {
         double beSL =
            openPrice + ((double)InpBreakEvenLock * _Point);

         double maximumAllowedSL =
            tick.bid - minimumDistance;

         if(beSL > maximumAllowedSL)
            beSL = maximumAllowedSL;

         beSL = NormalizePrice(beSL);

         if(beSL > 0.0 &&
            (currentSL == 0.0 ||
             beSL > currentSL + (_Point * 0.5)))
         {
            if(ModifyOurPosition(ticket, beSL, currentTP))
               currentSL = beSL;
         }
      }

      // Trailing Stop
      if(InpUseTrailingStop &&
         profitPoints >= (double)InpTrailingStart)
      {
         double trailingSL =
            tick.bid -
            ((double)InpTrailingDistance * _Point);

         double maximumAllowedSL =
            tick.bid - minimumDistance;

         if(trailingSL > maximumAllowedSL)
            trailingSL = maximumAllowedSL;

         trailingSL = NormalizePrice(trailingSL);

         double minimumImprovement =
            (double)InpTrailingStep * _Point;

         if(trailingSL > openPrice &&
            (currentSL == 0.0 ||
             trailingSL >= currentSL + minimumImprovement))
         {
            if(ModifyOurPosition(ticket, trailingSL, currentTP))
               currentSL = trailingSL;
         }
      }
   }

   //==============================================================
   // SELL POSITION
   //==============================================================
   else if(positionType == POSITION_TYPE_SELL)
   {
      double profitPoints = (openPrice - tick.ask) / _Point;

      // Break Even
      if(InpUseBreakEven &&
         profitPoints >= (double)InpBreakEvenTrigger)
      {
         double beSL =
            openPrice - ((double)InpBreakEvenLock * _Point);

         double minimumAllowedSL =
            tick.ask + minimumDistance;

         if(beSL < minimumAllowedSL)
            beSL = minimumAllowedSL;

         beSL = NormalizePrice(beSL);

         if(beSL > 0.0 &&
            (currentSL == 0.0 ||
             beSL < currentSL - (_Point * 0.5)))
         {
            if(ModifyOurPosition(ticket, beSL, currentTP))
               currentSL = beSL;
         }
      }

      // Trailing Stop
      if(InpUseTrailingStop &&
         profitPoints >= (double)InpTrailingStart)
      {
         double trailingSL =
            tick.ask +
            ((double)InpTrailingDistance * _Point);

         double minimumAllowedSL =
            tick.ask + minimumDistance;

         if(trailingSL < minimumAllowedSL)
            trailingSL = minimumAllowedSL;

         trailingSL = NormalizePrice(trailingSL);

         double minimumImprovement =
            (double)InpTrailingStep * _Point;

         if(trailingSL < openPrice &&
            (currentSL == 0.0 ||
             trailingSL <= currentSL - minimumImprovement))
         {
            if(ModifyOurPosition(ticket, trailingSL, currentTP))
               currentSL = trailingSL;
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
      Print("Invalid InpLotSize.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpStopLoss <= 0 ||
      InpTakeProfit <= 0 ||
      InpMaxSpread < 0)
   {
      Print("Invalid SL/TP/Spread parameters.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpFlagBars < 1 ||
      InpAverageRangePeriod < 2 ||
      InpImpulseMultiplier <= 0.0 ||
      InpMinBodyRatio <= 0.0 ||
      InpMinBodyRatio > 1.0 ||
      InpMaxFlagToImpulse <= 0.0 ||
      InpMaxRetracement <= 0.0)
   {
      Print("Invalid strategy parameters.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpBreakEvenTrigger < 0 ||
      InpBreakEvenLock < 0 ||
      InpTrailingStart < 0 ||
      InpTrailingDistance <= 0 ||
      InpTrailingStep < 0)
   {
      Print("Invalid position management parameters.");
      return INIT_PARAMETERS_INCORRECT;
   }

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   trade.SetAsyncMode(false);

   g_lastBarTime = iTime(_Symbol, _Period, 0);

   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Print("ImpulseFlagBreak EA stopped. Reason=", reason);
}

//+------------------------------------------------------------------+
//| Expert Tick                                                      |
//+------------------------------------------------------------------+
void OnTick()
{
   // Manage existing trade every tick
   ManageOpenPosition();

   // Entry logic only once per new candle
   if(!IsNewBar())
      return;

   if(!TradingAllowed())
      return;

   int requiredBars =
      InpFlagBars +
      InpAverageRangePeriod +
      10;

   if(Bars(_Symbol, _Period) < requiredBars)
      return;

   // Maximum one position for this EA/symbol
   if(HasOpenPosition())
      return;

   // Spread filter
   if(!SpreadAllowed())
      return;

   bool buySignal  = BullishSignal();
   bool sellSignal = BearishSignal();

   // Safety: never trade if contradictory signals somehow occur
   if(buySignal && sellSignal)
      return;

   if(buySignal)
   {
      OpenBuy();
      return;
   }

   if(sellSignal)
   {
      OpenSell();
      return;
   }
}
//+------------------------------------------------------------------+