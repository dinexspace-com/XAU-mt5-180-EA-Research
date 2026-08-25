#property copyright "Senior MQL5 Developer"
#property version   "1.01"
#property description "EA Supertrend - Vào lệnh sau khi retest đường Supertrend"

#include <Trade\Trade.mqh>

// --- Risk Management Inputs ---
input group "=== Risk Management ==="
input double InpLotSize          = 0.01;    // Lot size
input int    InpStopLoss         = 300;     // Stop Loss (points)
input int    InpTakeProfit       = 600;     // Take Profit (points)
input ulong  InpMagicNumber      = 123456;  // Magic Number
input int    InpSlippage         = 10;      // Slippage / Deviation (points)
input int    InpMaxSpread        = 30;      // Maximum spread (points)
input int    InpMaxPositions     = 1;       // Maximum positions

// --- SuperTrend Inputs ---
input group "=== SuperTrend Parameters ==="
input int    InpAtrPeriod        = 10;      // ATR Period
input double InpMultiplier       = 3.0;     // SuperTrend Multiplier

// --- Retest Inputs ---
input group "=== Retest Parameters ==="
input int    InpRetestMaxBars    = 5;       // Max bars to wait for retest
input double InpRetestBuffer     = 5.0;     // Buffer for retest (points)

// --- Break Even & Trailing Inputs ---
input group "=== Break Even & Trailing ==="
input bool   InpUseBreakEven      = true;   // Enable Break Even
input int    InpBreakEvenTrigger  = 150;    // Break Even trigger (points)
input bool   InpUseTrailingStop   = true;   // Enable Trailing Stop
input int    InpTrailingStart     = 200;    // Trailing start (points)
input int    InpTrailingDistance  = 200;    // Trailing distance (points)
input int    InpTrailingStep      = 10;     // Trailing step (points)

// --- Global Variables ---
CTrade trade;
int atrHandle = INVALID_HANDLE;

// Structure to store SuperTrend values
struct SuperTrendData
  {
   double upper[];
   double lower[];
   int    dir[];
   int    size;
  };

// Pending signal storage
struct PendingSignal
  {
   int    direction;      // 1 = Buy, -1 = Sell
   int    barsSinceSignal; // Bars since signal appeared
   double signalPrice;     // Price level to retest
   bool   isActive;        // Signal is active
  };

PendingSignal pendingSignal;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   atrHandle = iATR(_Symbol, PERIOD_CURRENT, InpAtrPeriod);
   if(atrHandle == INVALID_HANDLE)
     {
      Print("Failed to create ATR indicator handle. Error: ", GetLastError());
      return INIT_FAILED;
     }

   // Initialize pending signal
   pendingSignal.isActive = false;
   pendingSignal.direction = 0;
   pendingSignal.barsSinceSignal = 0;
   pendingSignal.signalPrice = 0;

   Print("EA initialized on ", _Symbol, " with ATR period ", InpAtrPeriod);
   Print("Retest feature enabled: Max bars = ", InpRetestMaxBars, ", Buffer = ", InpRetestBuffer, " points");
   return INIT_SUCCEEDED;
  }

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Print("EA deinitialized, reason: ", reason);
   if(atrHandle != INVALID_HANDLE)
     {
      IndicatorRelease(atrHandle);
      atrHandle = INVALID_HANDLE;
     }
  }

//+------------------------------------------------------------------+
//| Count positions by magic number                                  |
//+------------------------------------------------------------------+
int CountPositionsByMagic()
  {
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      if(PositionGetString(POSITION_SYMBOL) != _Symbol)
         continue;

      if((ulong)PositionGetInteger(POSITION_MAGIC) != InpMagicNumber)
         continue;

      count++;
     }
   return count;
  }

//+------------------------------------------------------------------+
//| Manage open positions: Break Even & Trailing Stop                |
//+------------------------------------------------------------------+
void ManageOpenPositions()
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      if(PositionGetString(POSITION_SYMBOL) != _Symbol)
         continue;

      if((ulong)PositionGetInteger(POSITION_MAGIC) != InpMagicNumber)
         continue;

      long   posType   = PositionGetInteger(POSITION_TYPE);
      double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      double currentSL = PositionGetDouble(POSITION_SL);
      double currentTP = PositionGetDouble(POSITION_TP);
      double bid       = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double ask       = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

      if(posType == POSITION_TYPE_BUY)
        {
         bool modify = false;
         double newSL = currentSL;

         // Break Even
         if(InpUseBreakEven && (bid - openPrice) >= InpBreakEvenTrigger * _Point)
           {
            if(openPrice > currentSL || currentSL == 0)
              {
               newSL = openPrice;
               modify = true;
              }
           }

         // Trailing Stop
         if(InpUseTrailingStop && (bid - openPrice) >= InpTrailingStart * _Point)
           {
            double trailSL = bid - InpTrailingDistance * _Point;
            if(trailSL > currentSL + InpTrailingStep * _Point)
              {
               newSL = trailSL;
               modify = true;
              }
           }

         if(modify)
           {
            if(!trade.PositionModify(ticket, newSL, currentTP))
               Print("Modify BUY failed. Ticket: ", ticket, " Error: ", trade.ResultRetcode());
           }
        }
      else if(posType == POSITION_TYPE_SELL)
        {
         bool modify = false;
         double newSL = currentSL;

         // Break Even
         if(InpUseBreakEven && (openPrice - ask) >= InpBreakEvenTrigger * _Point)
           {
            if(openPrice < currentSL || currentSL == 0)
              {
               newSL = openPrice;
               modify = true;
              }
           }

         // Trailing Stop
         if(InpUseTrailingStop && (openPrice - ask) >= InpTrailingStart * _Point)
           {
            double trailSL = ask + InpTrailingDistance * _Point;
            if(trailSL < currentSL - InpTrailingStep * _Point)
              {
               newSL = trailSL;
               modify = true;
              }
           }

         if(modify)
           {
            if(!trade.PositionModify(ticket, newSL, currentTP))
               Print("Modify SELL failed. Ticket: ", ticket, " Error: ", trade.ResultRetcode());
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| Get SuperTrend data                                              |
//+------------------------------------------------------------------+
bool GetSuperTrendData(SuperTrendData &stData)
  {
   if(atrHandle == INVALID_HANDLE)
      return false;

   int totalBars = Bars(_Symbol, PERIOD_CURRENT);
   int available = totalBars - InpAtrPeriod - 2;
   if(available < 3)
      return false;

   int limit = MathMin(available, 500);
   if(limit < 3)
      return false;

   double high[], low[], close[], atr[];
   ArraySetAsSeries(high, true);
   ArraySetAsSeries(low, true);
   ArraySetAsSeries(close, true);
   ArraySetAsSeries(atr, true);

   ArrayResize(high, limit);
   ArrayResize(low, limit);
   ArrayResize(close, limit);
   ArrayResize(atr, limit);

   if(CopyHigh(_Symbol, PERIOD_CURRENT, 0, limit, high) != limit)
      return false;
   if(CopyLow(_Symbol, PERIOD_CURRENT, 0, limit, low) != limit)
      return false;
   if(CopyClose(_Symbol, PERIOD_CURRENT, 0, limit, close) != limit)
      return false;
   if(CopyBuffer(atrHandle, 0, 0, limit, atr) != limit)
      return false;

   double upper[], lower[];
   int    dir[];

   ArraySetAsSeries(upper, true);
   ArraySetAsSeries(lower, true);
   ArraySetAsSeries(dir, true);

   ArrayResize(upper, limit);
   ArrayResize(lower, limit);
   ArrayResize(dir, limit);

   int oldest = limit - 1;

   double basicUpper = (high[oldest] + low[oldest]) / 2.0 + InpMultiplier * atr[oldest];
   double basicLower = (high[oldest] + low[oldest]) / 2.0 - InpMultiplier * atr[oldest];

   upper[oldest] = basicUpper;
   lower[oldest] = basicLower;
   dir[oldest]   = 0;

   for(int i = oldest - 1; i >= 0; i--)
     {
      basicUpper = (high[i] + low[i]) / 2.0 + InpMultiplier * atr[i];
      basicLower = (high[i] + low[i]) / 2.0 - InpMultiplier * atr[i];

      double prevUpper = upper[i + 1];
      double prevLower = lower[i + 1];
      double prevClose = close[i + 1];

      double currUpper = (basicUpper < prevUpper || prevClose > prevUpper) ? basicUpper : prevUpper;
      double currLower = (basicLower > prevLower || prevClose < prevLower) ? basicLower : prevLower;

      upper[i] = currUpper;
      lower[i] = currLower;

      if(close[i] > currUpper)
         dir[i] = 1;
      else if(close[i] < currLower)
         dir[i] = -1;
      else
         dir[i] = dir[i + 1];
     }

   // Store data
   stData.size = limit;
   ArrayResize(stData.upper, limit);
   ArrayResize(stData.lower, limit);
   ArrayResize(stData.dir, limit);
   
   for(int i = 0; i < limit; i++)
     {
      stData.upper[i] = upper[i];
      stData.lower[i] = lower[i];
      stData.dir[i] = dir[i];
     }

   return true;
  }

//+------------------------------------------------------------------+
//| Check for SuperTrend direction change                            |
//+------------------------------------------------------------------+
int CheckSuperTrendChange(SuperTrendData &stData)
  {
   if(stData.size < 3)
      return 0;

   int dirCurr = stData.dir[1];  // Current bar (just closed)
   int dirPrev = stData.dir[2];  // Previous bar

   // Buy signal: Supertrend changes from down to up
   if(dirPrev < 0 && dirCurr > 0)
      return 1;

   // Sell signal: Supertrend changes from up to down
   if(dirPrev > 0 && dirCurr < 0)
      return -1;

   return 0;
  }

//+------------------------------------------------------------------+
//| Check for retest condition                                       |
//+------------------------------------------------------------------+
bool CheckRetest(SuperTrendData &stData, int direction)
  {
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double buffer = InpRetestBuffer * _Point;

   if(direction == 1) // Buy retest
     {
      double lowerLine = stData.lower[1]; // Current lower line
      
      // Check if price retested the lower line (support)
      if(MathAbs(bid - lowerLine) <= buffer || 
         (bid >= lowerLine - buffer && bid <= lowerLine + buffer))
        {
         return true;
        }
      
      // Also check if price dipped below and came back
      double currentLow = iLow(_Symbol, PERIOD_CURRENT, 1);
      if(currentLow <= lowerLine + buffer && bid > lowerLine)
        {
         return true;
        }
     }
   else if(direction == -1) // Sell retest
     {
      double upperLine = stData.upper[1]; // Current upper line
      
      // Check if price retested the upper line (resistance)
      if(MathAbs(ask - upperLine) <= buffer || 
         (ask <= upperLine + buffer && ask >= upperLine - buffer))
        {
         return true;
        }
      
      // Also check if price spiked above and came back
      double currentHigh = iHigh(_Symbol, PERIOD_CURRENT, 1);
      if(currentHigh >= upperLine - buffer && ask < upperLine)
        {
         return true;
        }
     }

   return false;
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   // Quản lý lệnh mở mỗi tick
   ManageOpenPositions();

   // Bộ lọc nến mới
   static datetime lastBarTime = 0;
   datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);
   bool isNewBar = false;
   
   if(currentBarTime != lastBarTime)
     {
      isNewBar = true;
      lastBarTime = currentBarTime;
     }
   
   // Kiểm tra spread
   long spread = SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
   if(spread > InpMaxSpread)
      return;

   // Kiểm tra số lệnh tối đa
   int positions = CountPositionsByMagic();
   if(positions >= InpMaxPositions)
     {
      // Reset pending signal if max positions reached
      pendingSignal.isActive = false;
      return;
     }

   // Get SuperTrend data
   SuperTrendData stData;
   if(!GetSuperTrendData(stData))
      return;

   // Process on new bar
   if(isNewBar)
     {
      // Check for SuperTrend direction change
      int signal = CheckSuperTrendChange(stData);
      
      if(signal != 0)
        {
         // Store pending signal for retest
         pendingSignal.isActive = true;
         pendingSignal.direction = signal;
         pendingSignal.barsSinceSignal = 0;
         
         if(signal == 1)
            pendingSignal.signalPrice = stData.lower[1]; // Lower line for buy retest
         else
            pendingSignal.signalPrice = stData.upper[1]; // Upper line for sell retest
            
         Print("Signal detected: ", signal == 1 ? "BUY" : "SELL", 
               ". Waiting for retest at price: ", pendingSignal.signalPrice);
        }
      else if(pendingSignal.isActive)
        {
         // Increment bars since signal
         pendingSignal.barsSinceSignal++;
         
         // Check if retest window expired
         if(pendingSignal.barsSinceSignal > InpRetestMaxBars)
           {
            Print("Retest window expired. Cancelling pending ", 
                  pendingSignal.direction == 1 ? "BUY" : "SELL", " signal.");
            pendingSignal.isActive = false;
            pendingSignal.direction = 0;
            pendingSignal.barsSinceSignal = 0;
            pendingSignal.signalPrice = 0;
           }
        }
     }

   // Check for retest condition if we have pending signal
   if(pendingSignal.isActive && pendingSignal.direction != 0)
     {
      // Update signal price to current SuperTrend line
      if(pendingSignal.direction == 1)
         pendingSignal.signalPrice = stData.lower[1];
      else
         pendingSignal.signalPrice = stData.upper[1];
      
      // Check if retest occurred
      if(CheckRetest(stData, pendingSignal.direction))
        {
         if(pendingSignal.direction == 1)
           {
            double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
            double sl  = ask - InpStopLoss * _Point;
            double tp  = ask + InpTakeProfit * _Point;

            if(trade.Buy(InpLotSize, _Symbol, ask, sl, tp, "Supertrend Retest Buy"))
              {
               Print("BUY order opened after retest. Ticket: ", trade.ResultOrder());
               pendingSignal.isActive = false;
               pendingSignal.direction = 0;
               pendingSignal.barsSinceSignal = 0;
               pendingSignal.signalPrice = 0;
              }
            else
               Print("BUY failed. Retcode: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
           }
         else if(pendingSignal.direction == -1)
           {
            double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
            double sl  = bid + InpStopLoss * _Point;
            double tp  = bid - InpTakeProfit * _Point;

            if(trade.Sell(InpLotSize, _Symbol, bid, sl, tp, "Supertrend Retest Sell"))
              {
               Print("SELL order opened after retest. Ticket: ", trade.ResultOrder());
               pendingSignal.isActive = false;
               pendingSignal.direction = 0;
               pendingSignal.barsSinceSignal = 0;
               pendingSignal.signalPrice = 0;
              }
            else
               Print("SELL failed. Retcode: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
           }
        }
     }
  }