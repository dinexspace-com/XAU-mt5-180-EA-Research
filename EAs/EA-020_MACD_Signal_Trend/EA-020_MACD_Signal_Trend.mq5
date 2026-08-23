//+------------------------------------------------------------------+
//|                                                  MACD_Strategy.mq5 |
//|                                     Copyright 2026, Your Company |
//|                                            https://www.your.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2026, Your Company"
#property link      "https://www.your.com"
#property version   "1.00"

#include <Trade\Trade.mqh>

//+------------------------------------------------------------------+
//| Input Parameters                                                |
//+------------------------------------------------------------------+
input double   InpLotSize         = 0.01;   // Lot size
input int     InpStopLoss        = 300;    // Stop Loss (points)
input int     InpTakeProfit      = 600;    // Take Profit (points)
input ulong   InpMagicNumber     = 123456; // Magic Number
input int     InpSlippage        = 10;     // Slippage (points)
input int     InpMaxSpread       = 30;     // Maximum spread (points)
input bool    InpBreakEven       = true;   // Enable Break Even
input int     InpBreakEvenPoints = 150;    // Break Even activation (points)
input bool    InpTrailing        = true;   // Enable Trailing Stop
input int     InpTrailingPoints  = 200;    // Trailing Stop distance (points)

//+------------------------------------------------------------------+
//| Global variables                                                |
//+------------------------------------------------------------------+
CTrade      trade;
ulong       g_magicNumber;
int         g_slippage;
double      g_lotSize;
int         g_stopLoss;
int         g_takeProfit;
int         g_maxSpread;
bool        g_breakEven;
int         g_breakEvenPoints;
bool        g_trailing;
int         g_trailingPoints;
datetime    g_lastBarTime;
int         g_handleMACD;
int         g_handleSignal;
double      g_macdBuffer[];
double      g_signalBuffer[];
double      g_histogramBuffer[];
int         g_macdMaxBars;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   // Set magic number
   g_magicNumber = InpMagicNumber;
   g_slippage    = InpSlippage;
   g_lotSize     = InpLotSize;
   g_stopLoss    = InpStopLoss;
   g_takeProfit  = InpTakeProfit;
   g_maxSpread   = InpMaxSpread;
   g_breakEven   = InpBreakEven;
   g_breakEvenPoints = InpBreakEvenPoints;
   g_trailing    = InpTrailing;
   g_trailingPoints = InpTrailingPoints;
   
   // Set trade object
   trade.SetExpertMagicNumber(g_magicNumber);
   trade.SetDeviationInPoints(g_slippage);
   trade.SetTypeFilling(ORDER_FILLING_FOK);
   
   // Initialize MACD indicator
   g_handleMACD = iMACD(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE);
   if(g_handleMACD == INVALID_HANDLE)
   {
      Print("Failed to create MACD indicator handle. Error: ", GetLastError());
      return(INIT_FAILED);
   }
   
   // Get signal line handle (same as MACD handle, using separate buffer)
   g_handleSignal = g_handleMACD;
   
   // Set buffer arrays for MACD values
   ArraySetAsSeries(g_macdBuffer, true);
   ArraySetAsSeries(g_signalBuffer, true);
   ArraySetAsSeries(g_histogramBuffer, true);
   
   // Initialize bar time
   g_lastBarTime = 0;
   g_macdMaxBars = 3;
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   if(g_handleMACD != INVALID_HANDLE)
   {
      IndicatorRelease(g_handleMACD);
   }
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   // Check for new bar
   if(!IsNewBar())
      return;
   
   // Check if position already exists for this magic number
   if(CountPositions() > 0)
      return;
   
   // Check maximum spread
   if(!CheckSpread())
      return;
   
   // Get MACD values
   if(!GetMACDValues())
      return;
   
   // Get current MACD and signal values
   double macdCurrent  = g_macdBuffer[0];
   double signalCurrent = g_signalBuffer[0];
   double macdPrevious = g_macdBuffer[1];
   double signalPrevious = g_signalBuffer[1];
   
   // Check for buy signal: MACD crosses signal line upwards in positive territory
   if(macdPrevious <= signalPrevious && macdCurrent > signalCurrent && macdCurrent > 0)
   {
      OpenPosition(ORDER_TYPE_BUY);
   }
   // Check for sell signal: MACD crosses signal line downwards in negative territory
   else if(macdPrevious >= signalPrevious && macdCurrent < signalCurrent && macdCurrent < 0)
   {
      OpenPosition(ORDER_TYPE_SELL);
   }
   
   // Manage existing position (Break Even and Trailing Stop)
   if(g_breakEven || g_trailing)
   {
      ManagePosition();
   }
}

//+------------------------------------------------------------------+
//| Check if new bar has formed                                      |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime currentTime = iTime(_Symbol, _Period, 0);
   if(currentTime == g_lastBarTime)
      return false;
   
   g_lastBarTime = currentTime;
   return true;
}

//+------------------------------------------------------------------+
//| Count positions with this Magic Number                          |
//+------------------------------------------------------------------+
int CountPositions()
{
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
      {
         if(PositionSelectByTicket(ticket))
         {
            if(PositionGetInteger(POSITION_MAGIC) == g_magicNumber)
            {
               count++;
            }
         }
      }
   }
   return count;
}

//+------------------------------------------------------------------+
//| Check maximum spread                                             |
//+------------------------------------------------------------------+
bool CheckSpread()
{
   int spread = (int)SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
   if(spread > g_maxSpread)
   {
      Print("Spread too high: ", spread, " points. Maximum allowed: ", g_maxSpread);
      return false;
   }
   return true;
}

//+------------------------------------------------------------------+
//| Get MACD values from indicator                                   |
//+------------------------------------------------------------------+
bool GetMACDValues()
{
   // Get MACD line values
   if(CopyBuffer(g_handleMACD, 0, 0, g_macdMaxBars, g_macdBuffer) < g_macdMaxBars)
   {
      Print("Failed to copy MACD buffer. Error: ", GetLastError());
      return false;
   }
   
   // Get Signal line values
   if(CopyBuffer(g_handleSignal, 1, 0, g_macdMaxBars, g_signalBuffer) < g_macdMaxBars)
   {
      Print("Failed to copy Signal buffer. Error: ", GetLastError());
      return false;
   }
   
   return true;
}

//+------------------------------------------------------------------+
//| Open position                                                    |
//+------------------------------------------------------------------+
void OpenPosition(ENUM_ORDER_TYPE orderType)
{
   // Get symbol info
   double price = 0;
   double sl = 0;
   double tp = 0;
   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   double minLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double maxLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   double lotStep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
   
   // Ensure lot size is valid
   double lotSize = NormalizeLot(g_lotSize, minLot, maxLot, lotStep);
   if(lotSize <= 0)
   {
      Print("Invalid lot size. Min: ", minLot, ", Max: ", maxLot);
      return;
   }
   
   // Calculate price, SL, TP
   if(orderType == ORDER_TYPE_BUY)
   {
      price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      sl = price - g_stopLoss * point;
      tp = price + g_takeProfit * point;
   }
   else if(orderType == ORDER_TYPE_SELL)
   {
      price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      sl = price + g_stopLoss * point;
      tp = price - g_takeProfit * point;
   }
   else
   {
      Print("Invalid order type");
      return;
   }
   
   // Verify price validity
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   if(price <= 0 || ask <= 0 || bid <= 0)
   {
      Print("Invalid price values. Ask: ", ask, ", Bid: ", bid);
      return;
   }
   
   // Normalize prices
   int digits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
   price = NormalizeDouble(price, digits);
   sl = NormalizeDouble(sl, digits);
   tp = NormalizeDouble(tp, digits);
   
   // Open order
   bool result = false;
   if(orderType == ORDER_TYPE_BUY)
   {
      result = trade.Buy(lotSize, _Symbol, price, sl, tp, "MACD Buy Strategy");
   }
   else
   {
      result = trade.Sell(lotSize, _Symbol, price, sl, tp, "MACD Sell Strategy");
   }
   
   if(result)
   {
      Print("Position opened successfully. Ticket: ", trade.ResultOrder());
   }
   else
   {
      Print("Failed to open position. Error: ", GetLastError(), ", Comment: ", trade.ResultRetcodeDescription());
   }
}

//+------------------------------------------------------------------+
//| Manage position (Break Even & Trailing Stop)                     |
//+------------------------------------------------------------------+
void ManagePosition()
{
   // Get first position with this magic number
   ulong ticket = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong posTicket = PositionGetTicket(i);
      if(posTicket > 0)
      {
         if(PositionSelectByTicket(posTicket))
         {
            if(PositionGetInteger(POSITION_MAGIC) == g_magicNumber)
            {
               ticket = posTicket;
               break;
            }
         }
      }
   }
   
   if(ticket == 0)
      return;
   
   // Get position information
   double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double currentSL = PositionGetDouble(POSITION_SL);
   double currentTP = PositionGetDouble(POSITION_TP);
   ENUM_POSITION_TYPE posType = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
   double currentPrice = (posType == POSITION_TYPE_BUY) ? 
                         SymbolInfoDouble(_Symbol, SYMBOL_BID) : 
                         SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   
   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   double profit = 0;
   double newSL = 0;
   bool modify = false;
   
   // Calculate current profit in points
   if(posType == POSITION_TYPE_BUY)
   {
      profit = (currentPrice - openPrice) / point;
   }
   else
   {
      profit = (openPrice - currentPrice) / point;
   }
   
   // Apply Break Even if enabled
   if(g_breakEven && profit >= g_breakEvenPoints)
   {
      double breakEvenSL = openPrice + (posType == POSITION_TYPE_SELL ? point * 1 : -point * 1);
      int digits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
      breakEvenSL = NormalizeDouble(breakEvenSL, digits);
      
      // Only modify if SL is not already at break even or better
      if((posType == POSITION_TYPE_BUY && (currentSL < breakEvenSL || currentSL == 0)) ||
         (posType == POSITION_TYPE_SELL && (currentSL > breakEvenSL || currentSL == 0)))
      {
         newSL = breakEvenSL;
         modify = true;
      }
   }
   
   // Apply Trailing Stop if enabled (and after Break Even if both enabled)
   if(g_trailing && profit >= g_trailingPoints)
   {
      double trailingSL;
      if(posType == POSITION_TYPE_BUY)
      {
         trailingSL = currentPrice - g_trailingPoints * point;
      }
      else
      {
         trailingSL = currentPrice + g_trailingPoints * point;
      }
      
      int digits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);
      trailingSL = NormalizeDouble(trailingSL, digits);
      
      // Check if trailing SL is better than current SL
      if(posType == POSITION_TYPE_BUY)
      {
         if(trailingSL > currentSL)
         {
            newSL = trailingSL;
            modify = true;
         }
      }
      else
      {
         if(trailingSL < currentSL)
         {
            newSL = trailingSL;
            modify = true;
         }
      }
   }
   
   // Modify position if needed
   if(modify && newSL > 0)
   {
      // Ensure new SL is not beyond TP
      if(posType == POSITION_TYPE_BUY && newSL < currentTP)
      {
         if(trade.PositionModify(ticket, newSL, currentTP))
         {
            Print("Position modified successfully. New SL: ", newSL);
         }
         else
         {
            Print("Failed to modify position. Error: ", GetLastError());
         }
      }
      else if(posType == POSITION_TYPE_SELL && newSL > currentTP)
      {
         if(trade.PositionModify(ticket, newSL, currentTP))
         {
            Print("Position modified successfully. New SL: ", newSL);
         }
         else
         {
            Print("Failed to modify position. Error: ", GetLastError());
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Normalize lot size to valid steps                                |
//+------------------------------------------------------------------+
double NormalizeLot(double lot, double minLot, double maxLot, double lotStep)
{
   if(lot < minLot) lot = minLot;
   if(lot > maxLot) lot = maxLot;
   
   if(lotStep > 0)
   {
      lot = MathRound(lot / lotStep) * lotStep;
   }
   
   lot = NormalizeDouble(lot, 2);
   return lot;
}
//+------------------------------------------------------------------+