//+------------------------------------------------------------------+
//|                                         ConvergenceBreakoutEA.mq5 |
//|                        Convergence Zone Breakout - MetaTrader 5   |
//+------------------------------------------------------------------+
#property strict
#property version   "1.00"

#include <Trade\Trade.mqh>

CTrade trade;

//+------------------------------------------------------------------+
//| Input Parameters                                                 |
//+------------------------------------------------------------------+
input group "=== General Trading Settings ==="
input double InpLotSize           = 0.01;
input int    InpStopLoss          = 300;       // points
input int    InpTakeProfit        = 600;       // points
input ulong  InpMagicNumber       = 123456;
input int    InpSlippage          = 10;
input int    InpMaxSpread         = 30;        // points
input int    InpMaxPositions      = 1;

input group "=== Convergence Zone Settings ==="
input int    InpZoneBars          = 10;        // Number of closed candles used for convergence zone
input int    InpCompareBars       = 10;        // Older candles used to confirm contraction
input double InpConvergenceRatio  = 0.70;      // Current range must be <= older range * ratio
input int    InpMinZonePoints     = 30;        // Minimum valid zone height
input int    InpMaxZonePoints     = 500;       // Maximum valid zone height
input int    InpBreakoutBuffer    = 5;         // Breakout buffer in points
input bool   InpUseNewBarOnly     = true;

input group "=== Break Even ==="
input bool   InpUseBreakEven      = true;
input int    InpBreakEvenTrigger  = 150;       // points
input int    InpBreakEvenOffset   = 5;         // points locked after BE

input group "=== Trailing Stop ==="
input bool   InpUseTrailingStop   = true;
input int    InpTrailingStart     = 200;       // points
input int    InpTrailingDistance  = 150;       // points
input int    InpTrailingStep      = 20;        // minimum SL improvement in points

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
datetime g_lastBarTime = 0;

//+------------------------------------------------------------------+
//| Check if terminal/account can trade                              |
//+------------------------------------------------------------------+
bool IsTradingAllowed()
{
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return false;

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return false;

   if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| New bar detection                                                |
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
//| Normalize lot size                                               |
//+------------------------------------------------------------------+
double NormalizeVolume(double volume)
{
   double minVolume = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double maxVolume = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   double volumeStep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);

   if(volumeStep <= 0.0)
      return 0.0;

   volume = MathMax(minVolume, MathMin(maxVolume, volume));

   double steps = MathFloor((volume - minVolume) / volumeStep + 0.5);
   double normalizedVolume = minVolume + steps * volumeStep;

   int volumeDigits = 0;
   double tempStep = volumeStep;

   while(tempStep < 1.0 && volumeDigits < 8)
   {
      tempStep *= 10.0;
      volumeDigits++;
   }

   return NormalizeDouble(normalizedVolume, volumeDigits);
}

//+------------------------------------------------------------------+
//| Count open positions for this EA                                 |
//+------------------------------------------------------------------+
int CountEAOpenPositions()
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

   return count;
}

//+------------------------------------------------------------------+
//| Get highest high in specified closed-bar range                   |
//+------------------------------------------------------------------+
double GetHighestHigh(int startShift, int count)
{
   if(count <= 0)
      return 0.0;

   double highest = -DBL_MAX;

   for(int i = startShift; i < startShift + count; i++)
   {
      double value = iHigh(_Symbol, _Period, i);

      if(value <= 0.0)
         return 0.0;

      if(value > highest)
         highest = value;
   }

   return highest;
}

//+------------------------------------------------------------------+
//| Get lowest low in specified closed-bar range                     |
//+------------------------------------------------------------------+
double GetLowestLow(int startShift, int count)
{
   if(count <= 0)
      return 0.0;

   double lowest = DBL_MAX;

   for(int i = startShift; i < startShift + count; i++)
   {
      double value = iLow(_Symbol, _Period, i);

      if(value <= 0.0)
         return 0.0;

      if(value < lowest)
         lowest = value;
   }

   return lowest;
}

//+------------------------------------------------------------------+
//| Detect convergence zone                                          |
//|                                                                  |
//| Logic:                                                           |
//| 1. Calculate recent price range over InpZoneBars closed candles. |
//| 2. Calculate an older comparison range.                          |
//| 3. Recent range must contract relative to older range.           |
//| 4. Recent zone size must stay inside min/max bounds.              |
//+------------------------------------------------------------------+
bool GetConvergenceZone(double &zoneHigh, double &zoneLow)
{
   int requiredBars = InpZoneBars + InpCompareBars + 5;

   if(Bars(_Symbol, _Period) < requiredBars)
      return false;

   // Exclude candle #1 from the zone because it is used
   // as the breakout confirmation candle.
   zoneHigh = GetHighestHigh(2, InpZoneBars);
   zoneLow  = GetLowestLow(2, InpZoneBars);

   double oldHigh = GetHighestHigh(2 + InpZoneBars, InpCompareBars);
   double oldLow  = GetLowestLow(2 + InpZoneBars, InpCompareBars);

   if(zoneHigh <= 0.0 || zoneLow <= 0.0 ||
      oldHigh <= 0.0 || oldLow <= 0.0)
      return false;

   double recentRange = zoneHigh - zoneLow;
   double olderRange  = oldHigh - oldLow;

   if(recentRange <= 0.0 || olderRange <= 0.0)
      return false;

   double recentRangePoints = recentRange / _Point;

   if(recentRangePoints < InpMinZonePoints)
      return false;

   if(recentRangePoints > InpMaxZonePoints)
      return false;

   if(recentRange > olderRange * InpConvergenceRatio)
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Validate SL/TP against broker minimum stop distance              |
//+------------------------------------------------------------------+
void AdjustStops(ENUM_ORDER_TYPE orderType,
                 double entryPrice,
                 double &sl,
                 double &tp)
{
   long stopsLevel = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);

   double minDistance = (double)stopsLevel * _Point;

   if(orderType == ORDER_TYPE_BUY)
   {
      if(sl > 0.0 && entryPrice - sl < minDistance)
         sl = entryPrice - minDistance;

      if(tp > 0.0 && tp - entryPrice < minDistance)
         tp = entryPrice + minDistance;
   }
   else if(orderType == ORDER_TYPE_SELL)
   {
      if(sl > 0.0 && sl - entryPrice < minDistance)
         sl = entryPrice + minDistance;

      if(tp > 0.0 && entryPrice - tp < minDistance)
         tp = entryPrice - minDistance;
   }

   sl = NormalizeDouble(sl, _Digits);
   tp = NormalizeDouble(tp, _Digits);
}

//+------------------------------------------------------------------+
//| Open BUY                                                         |
//+------------------------------------------------------------------+
bool OpenBuy()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   double volume = NormalizeVolume(InpLotSize);

   if(volume <= 0.0)
      return false;

   double price = tick.ask;
   double sl = price - InpStopLoss * _Point;
   double tp = price + InpTakeProfit * _Point;

   AdjustStops(ORDER_TYPE_BUY, price, sl, tp);

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);

   ResetLastError();

   bool result = trade.Buy(
      volume,
      _Symbol,
      0.0,
      sl,
      tp,
      "Convergence Breakout BUY"
   );

   if(!result)
   {
      PrintFormat(
         "BUY failed. Retcode=%u, Description=%s, Error=%d",
         trade.ResultRetcode(),
         trade.ResultRetcodeDescription(),
         GetLastError()
      );

      return false;
   }

   PrintFormat(
      "BUY opened. Deal=%I64u Order=%I64u Price=%.5f SL=%.5f TP=%.5f",
      trade.ResultDeal(),
      trade.ResultOrder(),
      trade.ResultPrice(),
      sl,
      tp
   );

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

   double volume = NormalizeVolume(InpLotSize);

   if(volume <= 0.0)
      return false;

   double price = tick.bid;
   double sl = price + InpStopLoss * _Point;
   double tp = price - InpTakeProfit * _Point;

   AdjustStops(ORDER_TYPE_SELL, price, sl, tp);

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);

   ResetLastError();

   bool result = trade.Sell(
      volume,
      _Symbol,
      0.0,
      sl,
      tp,
      "Convergence Breakout SELL"
   );

   if(!result)
   {
      PrintFormat(
         "SELL failed. Retcode=%u, Description=%s, Error=%d",
         trade.ResultRetcode(),
         trade.ResultRetcodeDescription(),
         GetLastError()
      );

      return false;
   }

   PrintFormat(
      "SELL opened. Deal=%I64u Order=%I64u Price=%.5f SL=%.5f TP=%.5f",
      trade.ResultDeal(),
      trade.ResultOrder(),
      trade.ResultPrice(),
      sl,
      tp
   );

   return true;
}

//+------------------------------------------------------------------+
//| Modify position SL/TP                                            |
//+------------------------------------------------------------------+
bool ModifyPositionStops(ulong ticket, double newSL, double currentTP)
{
   newSL = NormalizeDouble(newSL, _Digits);

   ResetLastError();

   if(!trade.PositionModify(ticket, newSL, currentTP))
   {
      PrintFormat(
         "PositionModify failed. Ticket=%I64u Retcode=%u Description=%s Error=%d",
         ticket,
         trade.ResultRetcode(),
         trade.ResultRetcodeDescription(),
         GetLastError()
      );

      return false;
   }

   return true;
}

//+------------------------------------------------------------------+
//| Break-even and trailing-stop management                          |
//+------------------------------------------------------------------+
void ManageOpenPositions()
{
   if(!InpUseBreakEven && !InpUseTrailingStop)
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   long stopsLevel = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);
   double minStopDistance = (double)stopsLevel * _Point;

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

      ENUM_POSITION_TYPE positionType =
         (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

      double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      double currentSL = PositionGetDouble(POSITION_SL);
      double currentTP = PositionGetDouble(POSITION_TP);

      double marketPrice = 0.0;
      double profitPoints = 0.0;

      if(positionType == POSITION_TYPE_BUY)
      {
         marketPrice = tick.bid;
         profitPoints = (marketPrice - openPrice) / _Point;
      }
      else if(positionType == POSITION_TYPE_SELL)
      {
         marketPrice = tick.ask;
         profitPoints = (openPrice - marketPrice) / _Point;
      }
      else
      {
         continue;
      }

      double desiredSL = currentSL;
      bool shouldModify = false;

      // -------------------------------------------------------------
      // Break Even
      // -------------------------------------------------------------
      if(InpUseBreakEven && profitPoints >= InpBreakEvenTrigger)
      {
         if(positionType == POSITION_TYPE_BUY)
         {
            double beSL = openPrice + InpBreakEvenOffset * _Point;
            double maximumAllowedSL = marketPrice - minStopDistance;

            beSL = MathMin(beSL, maximumAllowedSL);

            if(beSL > 0.0 &&
               (currentSL == 0.0 || beSL > currentSL + _Point))
            {
               desiredSL = beSL;
               shouldModify = true;
            }
         }
         else
         {
            double beSL = openPrice - InpBreakEvenOffset * _Point;
            double minimumAllowedSL = marketPrice + minStopDistance;

            beSL = MathMax(beSL, minimumAllowedSL);

            if(beSL > 0.0 &&
               (currentSL == 0.0 || beSL < currentSL - _Point))
            {
               desiredSL = beSL;
               shouldModify = true;
            }
         }
      }

      // -------------------------------------------------------------
      // Trailing Stop
      // -------------------------------------------------------------
      if(InpUseTrailingStop && profitPoints >= InpTrailingStart)
      {
         if(positionType == POSITION_TYPE_BUY)
         {
            double trailingSL =
               marketPrice - InpTrailingDistance * _Point;

            double maximumAllowedSL =
               marketPrice - minStopDistance;

            trailingSL = MathMin(trailingSL, maximumAllowedSL);

            if(trailingSL > 0.0)
            {
               bool trailingImprovesCurrent =
                  (currentSL == 0.0 ||
                   trailingSL >= currentSL + InpTrailingStep * _Point);

               bool trailingImprovesDesired =
                  (!shouldModify ||
                   trailingSL > desiredSL);

               if(trailingImprovesCurrent &&
                  trailingImprovesDesired)
               {
                  desiredSL = trailingSL;
                  shouldModify = true;
               }
            }
         }
         else
         {
            double trailingSL =
               marketPrice + InpTrailingDistance * _Point;

            double minimumAllowedSL =
               marketPrice + minStopDistance;

            trailingSL = MathMax(trailingSL, minimumAllowedSL);

            if(trailingSL > 0.0)
            {
               bool trailingImprovesCurrent =
                  (currentSL == 0.0 ||
                   trailingSL <= currentSL - InpTrailingStep * _Point);

               bool trailingImprovesDesired =
                  (!shouldModify ||
                   trailingSL < desiredSL);

               if(trailingImprovesCurrent &&
                  trailingImprovesDesired)
               {
                  desiredSL = trailingSL;
                  shouldModify = true;
               }
            }
         }
      }

      if(shouldModify)
         ModifyPositionStops(ticket, desiredSL, currentTP);
   }
}

//+------------------------------------------------------------------+
//| Signal calculation                                               |
//|                                                                  |
//| Entry is confirmed using the last CLOSED candle:                 |
//| BUY  = candle #1 closes above upper convergence boundary.         |
//| SELL = candle #1 closes below lower convergence boundary.         |
//+------------------------------------------------------------------+
void CheckEntrySignal()
{
   if(!IsTradingAllowed())
      return;

   if(CountEAOpenPositions() >= InpMaxPositions)
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   double spreadPoints = (tick.ask - tick.bid) / _Point;

   if(spreadPoints > InpMaxSpread)
      return;

   double zoneHigh = 0.0;
   double zoneLow  = 0.0;

   if(!GetConvergenceZone(zoneHigh, zoneLow))
      return;

   double previousOpen  = iOpen(_Symbol, _Period, 1);
   double previousClose = iClose(_Symbol, _Period, 1);

   if(previousOpen <= 0.0 || previousClose <= 0.0)
      return;

   double upperBreakout =
      zoneHigh + InpBreakoutBuffer * _Point;

   double lowerBreakout =
      zoneLow - InpBreakoutBuffer * _Point;

   // BUY breakout:
   // previous candle crosses and closes above upper boundary.
   if(previousClose > upperBreakout &&
      previousOpen <= upperBreakout)
   {
      OpenBuy();
      return;
   }

   // SELL breakout:
   // previous candle crosses and closes below lower boundary.
   if(previousClose < lowerBreakout &&
      previousOpen >= lowerBreakout)
   {
      OpenSell();
      return;
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
      InpMaxSpread <= 0)
   {
      Print("Invalid SL, TP or spread parameters.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpZoneBars < 3 ||
      InpCompareBars < 3)
   {
      Print("ZoneBars and CompareBars must be >= 3.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpConvergenceRatio <= 0.0 ||
      InpConvergenceRatio >= 1.0)
   {
      Print("InpConvergenceRatio must be between 0 and 1.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpMaxPositions < 1)
   {
      Print("InpMaxPositions must be >= 1.");
      return INIT_PARAMETERS_INCORRECT;
   }

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   g_lastBarTime = iTime(_Symbol, _Period, 0);

   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   // Position management must work on every tick.
   ManageOpenPositions();

   if(InpUseNewBarOnly)
   {
      if(!IsNewBar())
         return;
   }

   CheckEntrySignal();
}
//+------------------------------------------------------------------+