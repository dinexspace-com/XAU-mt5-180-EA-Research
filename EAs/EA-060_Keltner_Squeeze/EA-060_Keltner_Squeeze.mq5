//+------------------------------------------------------------------+
//|                                      Keltner_Squeeze_Breakout.mq5|
//|                        Keltner Squeeze Breakout EA for MT5        |
//+------------------------------------------------------------------+
#property strict
#property version   "1.00"

#include <Trade\Trade.mqh>

CTrade trade;

//--- Trading inputs
input group "=== Trading Parameters ==="
input double InpLotSize          = 0.01;
input int    InpStopLoss         = 300;      // points
input int    InpTakeProfit       = 600;      // points
input ulong  InpMagicNumber      = 123456;
input int    InpSlippage         = 10;
input int    InpMaxSpread        = 30;       // points

//--- Keltner Channel inputs
input group "=== Keltner Channel ==="
input int    InpKeltnerEMAPeriod = 20;
input int    InpATRPeriod        = 20;
input double InpATRMultiplier    = 1.5;

//--- Squeeze inputs
input group "=== Keltner Squeeze ==="
input int    InpSqueezeLookback  = 5;
input double InpSqueezeRatio     = 0.80;

//--- Break Even
input group "=== Break Even ==="
input bool   InpUseBreakEven     = true;
input int    InpBreakEvenTrigger = 150;      // points
input int    InpBreakEvenOffset  = 0;        // points

//--- Trailing Stop
input group "=== Trailing Stop ==="
input bool   InpUseTrailingStop  = true;
input int    InpTrailingStart    = 200;      // points
input int    InpTrailingDistance = 150;      // points

//--- Global variables
int      g_emaHandle = INVALID_HANDLE;
int      g_atrHandle = INVALID_HANDLE;
datetime g_lastBarTime = 0;

//+------------------------------------------------------------------+
//| Normalize price                                                  |
//+------------------------------------------------------------------+
double NormalizePrice(const double price)
{
   int digits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
   return NormalizeDouble(price, digits);
}

//+------------------------------------------------------------------+
//| Validate trading environment                                     |
//+------------------------------------------------------------------+
bool IsTradingAllowed()
{
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return false;

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return false;

   if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
      return false;

   if(SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE) == SYMBOL_TRADE_MODE_DISABLED)
      return false;

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

   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);

   if(point <= 0.0)
      return false;

   double spreadPoints = (tick.ask - tick.bid) / point;

   return (spreadPoints <= (double)InpMaxSpread);
}

//+------------------------------------------------------------------+
//| Detect new bar                                                   |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);

   if(currentBarTime <= 0)
      return false;

   if(g_lastBarTime == 0)
   {
      g_lastBarTime = currentBarTime;
      return false;
   }

   if(currentBarTime != g_lastBarTime)
   {
      g_lastBarTime = currentBarTime;
      return true;
   }

   return false;
}

//+------------------------------------------------------------------+
//| Check position belonging to this EA                              |
//+------------------------------------------------------------------+
bool HasOpenPosition()
{
   int total = PositionsTotal();

   for(int i = 0; i < total; i++)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      ulong  magic  = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol == _Symbol && magic == InpMagicNumber)
         return true;
   }

   return false;
}

//+------------------------------------------------------------------+
//| Adjust SL/TP to broker minimum stop distance                     |
//+------------------------------------------------------------------+
void AdjustStops(const ENUM_ORDER_TYPE orderType,
                 const double entryPrice,
                 double &sl,
                 double &tp)
{
   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);

   if(point <= 0.0)
      return;

   int stopsLevel = (int)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);

   double minimumDistance = stopsLevel * point;

   if(orderType == ORDER_TYPE_BUY)
   {
      if(sl > 0.0 && (entryPrice - sl) < minimumDistance)
         sl = entryPrice - minimumDistance;

      if(tp > 0.0 && (tp - entryPrice) < minimumDistance)
         tp = entryPrice + minimumDistance;
   }
   else if(orderType == ORDER_TYPE_SELL)
   {
      if(sl > 0.0 && (sl - entryPrice) < minimumDistance)
         sl = entryPrice + minimumDistance;

      if(tp > 0.0 && (entryPrice - tp) < minimumDistance)
         tp = entryPrice - minimumDistance;
   }

   sl = NormalizePrice(sl);
   tp = NormalizePrice(tp);
}

//+------------------------------------------------------------------+
//| Check Keltner squeeze                                            |
//|                                                                  |
//| Squeeze definition:                                              |
//| Current completed Keltner width must be <= average historical    |
//| width * InpSqueezeRatio.                                         |
//+------------------------------------------------------------------+
bool IsKeltnerSqueeze(const double &atr[])
{
   if(InpSqueezeLookback < 2)
      return false;

   double currentWidth = 2.0 * InpATRMultiplier * atr[1];

   if(currentWidth <= 0.0)
      return false;

   double averageWidth = 0.0;

   for(int i = 2; i < 2 + InpSqueezeLookback; i++)
   {
      double width = 2.0 * InpATRMultiplier * atr[i];

      if(width <= 0.0)
         return false;

      averageWidth += width;
   }

   averageWidth /= (double)InpSqueezeLookback;

   if(averageWidth <= 0.0)
      return false;

   return (currentWidth <= averageWidth * InpSqueezeRatio);
}

//+------------------------------------------------------------------+
//| Generate trading signal                                          |
//|  1 = BUY                                                         |
//| -1 = SELL                                                        |
//|  0 = no signal                                                   |
//+------------------------------------------------------------------+
int GetTradingSignal()
{
   int requiredBars = InpSqueezeLookback + 3;

   if(Bars(_Symbol, PERIOD_CURRENT) <
      MathMax(InpKeltnerEMAPeriod, InpATRPeriod) + requiredBars)
   {
      return 0;
   }

   double ema[];
   double atr[];

   ArraySetAsSeries(ema, true);
   ArraySetAsSeries(atr, true);

   if(CopyBuffer(g_emaHandle, 0, 0, requiredBars, ema) != requiredBars)
      return 0;

   if(CopyBuffer(g_atrHandle, 0, 0, requiredBars, atr) != requiredBars)
      return 0;

   double close1 = iClose(_Symbol, PERIOD_CURRENT, 1);
   double close2 = iClose(_Symbol, PERIOD_CURRENT, 2);

   if(close1 <= 0.0 || close2 <= 0.0)
      return 0;

   //--- Keltner bands on completed candles
   double upper1 = ema[1] + InpATRMultiplier * atr[1];
   double lower1 = ema[1] - InpATRMultiplier * atr[1];

   double upper2 = ema[2] + InpATRMultiplier * atr[2];
   double lower2 = ema[2] - InpATRMultiplier * atr[2];

   if(!IsKeltnerSqueeze(atr))
      return 0;

   //--- Breakout confirmation:
   //--- candle 1 closes outside channel while candle 2 was inside it.
   bool previousInside =
      (close2 <= upper2 && close2 >= lower2);

   if(!previousInside)
      return 0;

   if(close1 > upper1)
      return 1;

   if(close1 < lower1)
      return -1;

   return 0;
}

//+------------------------------------------------------------------+
//| Open BUY                                                         |
//+------------------------------------------------------------------+
bool OpenBuy()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);

   if(point <= 0.0)
      return false;

   double sl = 0.0;
   double tp = 0.0;

   if(InpStopLoss > 0)
      sl = tick.ask - InpStopLoss * point;

   if(InpTakeProfit > 0)
      tp = tick.ask + InpTakeProfit * point;

   AdjustStops(ORDER_TYPE_BUY, tick.ask, sl, tp);

   ResetLastError();

   bool result = trade.Buy(InpLotSize,
                           _Symbol,
                           0.0,
                           sl,
                           tp,
                           "Keltner Squeeze BUY");

   if(!result)
   {
      PrintFormat("BUY failed. Retcode=%u, Description=%s, LastError=%d",
                  trade.ResultRetcode(),
                  trade.ResultRetcodeDescription(),
                  GetLastError());
      return false;
   }

   PrintFormat("BUY opened successfully. Deal=%I64u Order=%I64u",
               trade.ResultDeal(),
               trade.ResultOrder());

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

   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);

   if(point <= 0.0)
      return false;

   double sl = 0.0;
   double tp = 0.0;

   if(InpStopLoss > 0)
      sl = tick.bid + InpStopLoss * point;

   if(InpTakeProfit > 0)
      tp = tick.bid - InpTakeProfit * point;

   AdjustStops(ORDER_TYPE_SELL, tick.bid, sl, tp);

   ResetLastError();

   bool result = trade.Sell(InpLotSize,
                            _Symbol,
                            0.0,
                            sl,
                            tp,
                            "Keltner Squeeze SELL");

   if(!result)
   {
      PrintFormat("SELL failed. Retcode=%u, Description=%s, LastError=%d",
                  trade.ResultRetcode(),
                  trade.ResultRetcodeDescription(),
                  GetLastError());
      return false;
   }

   PrintFormat("SELL opened successfully. Deal=%I64u Order=%I64u",
               trade.ResultDeal(),
               trade.ResultOrder());

   return true;
}

//+------------------------------------------------------------------+
//| Modify SL while preserving TP                                    |
//+------------------------------------------------------------------+
bool ModifyPositionStops(const ulong ticket,
                         const double newSL,
                         const double currentTP)
{
   ResetLastError();

   bool result = trade.PositionModify(ticket,
                                      NormalizePrice(newSL),
                                      NormalizePrice(currentTP));

   if(!result)
   {
      PrintFormat("PositionModify failed. Ticket=%I64u Retcode=%u Description=%s LastError=%d",
                  ticket,
                  trade.ResultRetcode(),
                  trade.ResultRetcodeDescription(),
                  GetLastError());

      return false;
   }

   return true;
}

//+------------------------------------------------------------------+
//| Manage Break Even and Trailing Stop                              |
//+------------------------------------------------------------------+
void ManageOpenPositions()
{
   if(!InpUseBreakEven && !InpUseTrailingStop)
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);

   if(point <= 0.0)
      return;

   int stopsLevel  = (int)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);
   int freezeLevel = (int)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_FREEZE_LEVEL);

   double minimumDistance =
      MathMax(stopsLevel, freezeLevel) * point;

   int total = PositionsTotal();

   for(int i = total - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      ulong  magic  = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol != _Symbol || magic != InpMagicNumber)
         continue;

      ENUM_POSITION_TYPE positionType =
         (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

      double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      double currentSL = PositionGetDouble(POSITION_SL);
      double currentTP = PositionGetDouble(POSITION_TP);

      double profitPoints = 0.0;

      if(positionType == POSITION_TYPE_BUY)
         profitPoints = (tick.bid - openPrice) / point;
      else if(positionType == POSITION_TYPE_SELL)
         profitPoints = (openPrice - tick.ask) / point;
      else
         continue;

      double candidateSL = currentSL;
      bool   needModify  = false;

      //==============================================================
      // BREAK EVEN
      //==============================================================
      if(InpUseBreakEven &&
         profitPoints >= (double)InpBreakEvenTrigger)
      {
         if(positionType == POSITION_TYPE_BUY)
         {
            double breakEvenSL =
               openPrice + InpBreakEvenOffset * point;

            double maximumAllowedSL =
               tick.bid - minimumDistance;

            breakEvenSL = MathMin(breakEvenSL, maximumAllowedSL);

            if(breakEvenSL > openPrice - point * 0.1)
            {
               if(currentSL == 0.0 ||
                  breakEvenSL > candidateSL + point * 0.1)
               {
                  candidateSL = breakEvenSL;
                  needModify = true;
               }
            }
         }
         else if(positionType == POSITION_TYPE_SELL)
         {
            double breakEvenSL =
               openPrice - InpBreakEvenOffset * point;

            double minimumAllowedSL =
               tick.ask + minimumDistance;

            breakEvenSL = MathMax(breakEvenSL, minimumAllowedSL);

            if(breakEvenSL < openPrice + point * 0.1)
            {
               if(currentSL == 0.0 ||
                  breakEvenSL < candidateSL - point * 0.1)
               {
                  candidateSL = breakEvenSL;
                  needModify = true;
               }
            }
         }
      }

      //==============================================================
      // TRAILING STOP
      //==============================================================
      if(InpUseTrailingStop &&
         profitPoints >= (double)InpTrailingStart)
      {
         if(positionType == POSITION_TYPE_BUY)
         {
            double trailingSL =
               tick.bid - InpTrailingDistance * point;

            double maximumAllowedSL =
               tick.bid - minimumDistance;

            trailingSL = MathMin(trailingSL, maximumAllowedSL);

            if(candidateSL == 0.0 ||
               trailingSL > candidateSL + point * 0.1)
            {
               candidateSL = trailingSL;
               needModify = true;
            }
         }
         else if(positionType == POSITION_TYPE_SELL)
         {
            double trailingSL =
               tick.ask + InpTrailingDistance * point;

            double minimumAllowedSL =
               tick.ask + minimumDistance;

            trailingSL = MathMax(trailingSL, minimumAllowedSL);

            if(candidateSL == 0.0 ||
               trailingSL < candidateSL - point * 0.1)
            {
               candidateSL = trailingSL;
               needModify = true;
            }
         }
      }

      if(!needModify)
         continue;

      candidateSL = NormalizePrice(candidateSL);

      //--- Never worsen current stop
      if(positionType == POSITION_TYPE_BUY)
      {
         if(currentSL > 0.0 &&
            candidateSL <= currentSL + point * 0.1)
         {
            continue;
         }

         if(candidateSL >= tick.bid)
            continue;
      }
      else if(positionType == POSITION_TYPE_SELL)
      {
         if(currentSL > 0.0 &&
            candidateSL >= currentSL - point * 0.1)
         {
            continue;
         }

         if(candidateSL <= tick.ask)
            continue;
      }

      ModifyPositionStops(ticket, candidateSL, currentTP);
   }
}

//+------------------------------------------------------------------+
//| Expert initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   if(InpLotSize <= 0.0)
   {
      Print("Invalid lot size.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpKeltnerEMAPeriod < 2 ||
      InpATRPeriod < 2 ||
      InpATRMultiplier <= 0.0)
   {
      Print("Invalid Keltner parameters.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpSqueezeLookback < 2 ||
      InpSqueezeRatio <= 0.0)
   {
      Print("Invalid squeeze parameters.");
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpStopLoss < 0 ||
      InpTakeProfit < 0 ||
      InpMaxSpread < 0 ||
      InpBreakEvenTrigger < 0 ||
      InpTrailingStart < 0 ||
      InpTrailingDistance < 0)
   {
      Print("Invalid risk management parameters.");
      return INIT_PARAMETERS_INCORRECT;
   }

   g_emaHandle =
      iMA(_Symbol,
          PERIOD_CURRENT,
          InpKeltnerEMAPeriod,
          0,
          MODE_EMA,
          PRICE_CLOSE);

   if(g_emaHandle == INVALID_HANDLE)
   {
      PrintFormat("Failed to create EMA handle. Error=%d",
                  GetLastError());
      return INIT_FAILED;
   }

   g_atrHandle =
      iATR(_Symbol,
           PERIOD_CURRENT,
           InpATRPeriod);

   if(g_atrHandle == INVALID_HANDLE)
   {
      PrintFormat("Failed to create ATR handle. Error=%d",
                  GetLastError());

      IndicatorRelease(g_emaHandle);
      g_emaHandle = INVALID_HANDLE;

      return INIT_FAILED;
   }

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   trade.SetAsyncMode(false);

   g_lastBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);

   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   if(g_emaHandle != INVALID_HANDLE)
   {
      IndicatorRelease(g_emaHandle);
      g_emaHandle = INVALID_HANDLE;
   }

   if(g_atrHandle != INVALID_HANDLE)
   {
      IndicatorRelease(g_atrHandle);
      g_atrHandle = INVALID_HANDLE;
   }
}

//+------------------------------------------------------------------+
//| Expert tick                                                      |
//+------------------------------------------------------------------+
void OnTick()
{
   //--- Manage existing trade on every tick
   ManageOpenPositions();

   //--- Entry logic only on new candle
   if(!IsNewBar())
      return;

   if(!IsTradingAllowed())
      return;

   if(!IsSpreadAllowed())
      return;

   //--- Maximum one active position for this EA/symbol
   if(HasOpenPosition())
      return;

   int signal = GetTradingSignal();

   if(signal == 1)
      OpenBuy();
   else if(signal == -1)
      OpenSell();
}
//+------------------------------------------------------------------+