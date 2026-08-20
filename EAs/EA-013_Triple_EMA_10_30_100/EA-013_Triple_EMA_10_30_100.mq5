#property copyright "Senior MQL5 Developer"
#property version   "1.00"
#include <Trade\Trade.mqh>

//--- Input Parameters
input group "=== Moving Average Parameters ==="
input int    InpFastMAPeriod      = 10;          // Fast EMA Period
input int    InpMidMAPeriod       = 30;         // Middle EMA Period
input int    InpSlowMAPeriod      = 100;         // Slow EMA Period
input ENUM_MA_METHOD InpMAMethod  = MODE_EMA;   // MA Method
input ENUM_APPLIED_PRICE InpMAPrice = PRICE_CLOSE; // MA Applied Price

input group "=== Trading Parameters ==="
input double InpLotSize          = 0.01;      // Lot size
input int    InpStopLoss         = 300;        // Stop Loss (points)
input int    InpTakeProfit       = 600;        // Take Profit (points)
input ulong  InpMagicNumber      = 123456;     // Magic Number
input int    InpSlippage         = 10;         // Slippage / Deviation (points)
input int    InpMaxSpreadPoints  = 30;         // Max spread allowed (points)
input int    InpMaxOrders        = 1;          // Max open orders

input group "=== Break Even & Trailing Stop ==="
input bool   InpUseBreakEven     = true;       // Enable Break Even
input int    InpBreakEvenPoints  = 150;        // Break Even trigger (points)
input bool   InpUseTrailing      = true;       // Enable Trailing Stop
input int    InpTrailingPoints   = 200;        // Trailing distance (points)

//--- Global objects
CTrade trade;
int maFastHandle  = INVALID_HANDLE;
int maMidHandle   = INVALID_HANDLE;
int maSlowHandle  = INVALID_HANDLE;
datetime lastBarTime = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);

   maFastHandle = iMA(_Symbol, _Period, InpFastMAPeriod, 0, InpMAMethod, InpMAPrice);
   maMidHandle  = iMA(_Symbol, _Period, InpMidMAPeriod, 0, InpMAMethod, InpMAPrice);
   maSlowHandle = iMA(_Symbol, _Period, InpSlowMAPeriod, 0, InpMAMethod, InpMAPrice);

   if(maFastHandle == INVALID_HANDLE || maMidHandle == INVALID_HANDLE || maSlowHandle == INVALID_HANDLE)
     {
      Print("Failed to create EMA indicator handles. Error: ", GetLastError());
      return(INIT_FAILED);
     }

   // Validate MA periods
   if(InpFastMAPeriod >= InpMidMAPeriod || InpMidMAPeriod >= InpSlowMAPeriod)
     {
      Print("Warning: MA periods should be in ascending order (Fast < Mid < Slow) for proper trend detection.");
     }

   lastBarTime = 0; // Allow immediate evaluation on first tick
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   if(maFastHandle != INVALID_HANDLE)
      IndicatorRelease(maFastHandle);
   if(maMidHandle != INVALID_HANDLE)
      IndicatorRelease(maMidHandle);
   if(maSlowHandle != INVALID_HANDLE)
      IndicatorRelease(maSlowHandle);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   // Manage open positions on every tick
   ManageOpenPositions();

   // Check for a new bar before evaluating entry signals
   if(!IsNewBar())
      return;

   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   if(ask <= 0 || bid <= 0)
      return;

   // Spread filter
   double spreadPoints = (ask - bid) / _Point;
   if(spreadPoints > InpMaxSpreadPoints)
     {
      Print("Spread too high: ", spreadPoints, " points. Skip entries.");
      return;
     }

   // Maximum open orders filter
   if(CountOpenPositions() >= InpMaxOrders)
      return;

   // Get MA values
   double maFast = GetMAValue(maFastHandle, 0);
   double maMid  = GetMAValue(maMidHandle, 0);
   double maSlow = GetMAValue(maSlowHandle, 0);

   if(maFast <= 0 || maMid <= 0 || maSlow <= 0)
      return;

   bool buyCondition  = (maFast > maMid && maMid > maSlow);
   bool sellCondition = (maFast < maMid && maMid < maSlow);

   if(buyCondition)
     {
      double sl = NormalizeDouble(ask - InpStopLoss * _Point, _Digits);
      double tp = NormalizeDouble(ask + InpTakeProfit * _Point, _Digits);

      if(trade.Buy(InpLotSize, _Symbol, 0.0, sl, tp, "MA Trend Buy"))
         Print("Buy order opened successfully. Ticket: ", trade.ResultOrder());
      else
         Print("Buy order failed. Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
     }
   else if(sellCondition)
     {
      double sl = NormalizeDouble(bid + InpStopLoss * _Point, _Digits);
      double tp = NormalizeDouble(bid - InpTakeProfit * _Point, _Digits);

      if(trade.Sell(InpLotSize, _Symbol, 0.0, sl, tp, "MA Trend Sell"))
         Print("Sell order opened successfully. Ticket: ", trade.ResultOrder());
      else
         Print("Sell order failed. Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
     }
  }

//+------------------------------------------------------------------+
//| Check if a new bar has appeared                                  |
//+------------------------------------------------------------------+
bool IsNewBar()
  {
   datetime currentBarOpen = iTime(_Symbol, _Period, 0);
   if(currentBarOpen == 0)
      return(false);

   if(currentBarOpen != lastBarTime)
     {
      lastBarTime = currentBarOpen;
      return(true);
     }
   return(false);
  }

//+------------------------------------------------------------------+
//| Get indicator buffer value                                       |
//+------------------------------------------------------------------+
double GetMAValue(int handle, int shift)
  {
   double values[1];
   if(CopyBuffer(handle, 0, shift, 1, values) < 1)
     {
      Print("CopyBuffer failed for handle ", handle, ". Error: ", GetLastError());
      return(0.0);
     }
   return(values[0]);
  }

//+------------------------------------------------------------------+
//| Count open positions for this EA                                 |
//+------------------------------------------------------------------+
int CountOpenPositions()
  {
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;

      if(PositionGetString(POSITION_SYMBOL) != _Symbol)
         continue;

      if((ulong)PositionGetInteger(POSITION_MAGIC) != InpMagicNumber)
         continue;

      count++;
     }
   return(count);
  }

//+------------------------------------------------------------------+
//| Manage break even and trailing stop for open positions           |
//+------------------------------------------------------------------+
void ManageOpenPositions()
  {
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   if(ask <= 0 || bid <= 0)
      return;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;

      if(PositionGetString(POSITION_SYMBOL) != _Symbol)
         continue;

      if((ulong)PositionGetInteger(POSITION_MAGIC) != InpMagicNumber)
         continue;

      double currentSL = PositionGetDouble(POSITION_SL);
      double currentTP = PositionGetDouble(POSITION_TP);
      double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      long   type      = PositionGetInteger(POSITION_TYPE);
      double newSL     = currentSL;

      if(type == POSITION_TYPE_BUY)
        {
         double profitPoints = (bid - openPrice) / _Point;

         if(InpUseBreakEven && profitPoints >= InpBreakEvenPoints)
           {
            if(currentSL == 0.0 || currentSL < openPrice)
               newSL = openPrice;
           }

         if(InpUseTrailing && profitPoints >= InpTrailingPoints)
           {
            double trailStop = NormalizeDouble(bid - InpTrailingPoints * _Point, _Digits);
            if(trailStop > currentSL)
               newSL = trailStop;
           }

         if(currentSL == 0.0 || newSL > currentSL + _Point)
           {
            if(trade.PositionModify(ticket, newSL, currentTP))
               Print("Buy position ", ticket, " SL modified to ", newSL);
            else
               Print("Failed to modify buy position ", ticket, ". Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
           }
        }
      else if(type == POSITION_TYPE_SELL)
        {
         double profitPoints = (openPrice - ask) / _Point;

         if(InpUseBreakEven && profitPoints >= InpBreakEvenPoints)
           {
            if(currentSL == 0.0 || currentSL > openPrice)
               newSL = openPrice;
           }

         if(InpUseTrailing && profitPoints >= InpTrailingPoints)
           {
            double trailStop = NormalizeDouble(ask + InpTrailingPoints * _Point, _Digits);
            if(currentSL == 0.0 || trailStop < currentSL)
               newSL = trailStop;
           }

         if(currentSL == 0.0 || newSL < currentSL - _Point)
           {
            if(trade.PositionModify(ticket, newSL, currentTP))
               Print("Sell position ", ticket, " SL modified to ", newSL);
            else
               Print("Failed to modify sell position ", ticket, ". Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
           }
        }
     }
  }
//+------------------------------------------------------------------+
