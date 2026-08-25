
//+------------------------------------------------------------------+
//|                                                    DonchianEA.mq5|
//|                                      Senior MQL5 Developer       |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Senior MQL5 Developer"
#property link      ""
#property version   "1.00"
#property strict

#include <Trade\Trade.mqh>

//--- Input Parameters
input group "=== Order Settings ==="
input double InpLotSize      = 0.01;      // Lot Size
input int    InpStopLoss     = 300;       // Stop Loss (points)
input int    InpTakeProfit   = 600;       // Take Profit (points)
input ulong  InpMagicNumber  = 123456;    // Magic Number
input int    InpSlippage     = 10;        // Slippage / Deviation

input group "=== Risk Management ==="
input bool   InpUseBreakEven = true;      // Use Break Even
input int    InpBreakEvenTrigger = 150;   // Break Even Trigger (points)
input int    InpBreakEvenLevel   = 0;     // Break Even Level (points, 0 = entry)

input group "=== Trailing Stop ==="
input bool   InpUseTrailing  = true;      // Use Trailing Stop
input int    InpTrailingStart = 200;      // Trailing Start (points)
input int    InpTrailingStep  = 10;       // Trailing Step (points)

input group "=== Filter Settings ==="
input int    InpMaxSpread    = 30;        // Max Spread (points)
input int    InpDonchianPeriod = 20;      // Donchian Channel Period
input int    InpMaxPositions = 1;         // Max Positions

//--- Global Variables
CTrade  trade;
datetime lastBarTime = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   //--- Set Magic Number and deviation for all trades
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   
   //--- Validate inputs
   if(InpLotSize <= 0)
   {
      Print("Lot size must be greater than 0");
      return(INIT_PARAMETERS_INCORRECT);
   }
   if(InpDonchianPeriod <= 0)
   {
      Print("Donchian period must be greater than 0");
      return(INIT_PARAMETERS_INCORRECT);
   }
   if(InpStopLoss <= 0 || InpTakeProfit <= 0)
   {
      Print("SL and TP must be greater than 0");
      return(INIT_PARAMETERS_INCORRECT);
   }
   
   Print("Donchian EA initialized successfully");
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Print("Donchian EA deinitialized");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   //--- Check for new bar
   if(!IsNewBar())
      return;
   
   //--- Check spread limit
   if(!CheckSpread())
      return;
   
   //--- Check existing positions
   if(CountPositions() >= InpMaxPositions)
      return;
   
   //--- Get Donchian Channel values
   double donchianHigh = iHigh(_Symbol, PERIOD_CURRENT, InpDonchianPeriod);
   double donchianLow  = iLow(_Symbol, PERIOD_CURRENT, InpDonchianPeriod);
   
   //--- Get current price
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   
   //--- Get last closed bar close price
   double lastClose = iClose(_Symbol, PERIOD_CURRENT, 1);
   
   //--- Trading logic: BUY when close above Donchian High
   if(lastClose > donchianHigh)
   {
      OpenBuy();
   }
   //--- Trading logic: SELL when close below Donchian Low
   else if(lastClose < donchianLow)
   {
      OpenSell();
   }
   
   //--- Manage open positions
   if(InpUseBreakEven)
      ManageBreakEven();
   if(InpUseTrailing)
      ManageTrailingStop();
}

//+------------------------------------------------------------------+
//| Check for new bar                                                |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);
   if(currentBarTime != lastBarTime)
   {
      lastBarTime = currentBarTime;
      return(true);
   }
   return(false);
}

//+------------------------------------------------------------------+
//| Check spread limit                                               |
//+------------------------------------------------------------------+
bool CheckSpread()
{
   double spread = (SymbolInfoDouble(_Symbol, SYMBOL_ASK) - 
                    SymbolInfoDouble(_Symbol, SYMBOL_BID)) / _Point;
   
   if(spread > InpMaxSpread)
   {
      Print("Spread too high: ", spread, " points");
      return(false);
   }
   return(true);
}

//+------------------------------------------------------------------+
//| Count open positions with this magic number                      |
//+------------------------------------------------------------------+
int CountPositions()
{
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      if(PositionSelectByTicket(PositionGetTicket(i)))
      {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
            count++;
      }
   }
   return(count);
}

//+------------------------------------------------------------------+
//| Open Buy position                                                |
//+------------------------------------------------------------------+
void OpenBuy()
{
   double price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double sl = price - InpStopLoss * _Point;
   double tp = price + InpTakeProfit * _Point;
   
   //--- Normalize prices
   price = NormalizeDouble(price, _Digits);
   sl = NormalizeDouble(sl, _Digits);
   tp = NormalizeDouble(tp, _Digits);
   
   //--- Open buy position
   if(trade.Buy(InpLotSize, _Symbol, price, sl, tp, "Donchian EA Buy"))
   {
      Print("Buy position opened successfully at price: ", price);
   }
   else
   {
      Print("Failed to open Buy position. Error: ", GetLastError());
   }
}

//+------------------------------------------------------------------+
//| Open Sell position                                               |
//+------------------------------------------------------------------+
void OpenSell()
{
   double price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double sl = price + InpStopLoss * _Point;
   double tp = price - InpTakeProfit * _Point;
   
   //--- Normalize prices
   price = NormalizeDouble(price, _Digits);
   sl = NormalizeDouble(sl, _Digits);
   tp = NormalizeDouble(tp, _Digits);
   
   //--- Open sell position
   if(trade.Sell(InpLotSize, _Symbol, price, sl, tp, "Donchian EA Sell"))
   {
      Print("Sell position opened successfully at price: ", price);
   }
   else
   {
      Print("Failed to open Sell position. Error: ", GetLastError());
   }
}

//+------------------------------------------------------------------+
//| Manage Break Even                                                |
//+------------------------------------------------------------------+
void ManageBreakEven()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      if(PositionSelectByTicket(PositionGetTicket(i)))
      {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
         {
            double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            double currentPrice = PositionGetDouble(POSITION_PRICE_CURRENT);
            double currentSL = PositionGetDouble(POSITION_SL);
            long positionType = PositionGetInteger(POSITION_TYPE);
            
            //--- Check if position is in profit beyond break even trigger
            if(positionType == POSITION_TYPE_BUY)
            {
               double profitPoints = (currentPrice - entryPrice) / _Point;
               
               if(profitPoints >= InpBreakEvenTrigger && currentSL < entryPrice + InpBreakEvenLevel * _Point)
               {
                  double newSL = entryPrice + InpBreakEvenLevel * _Point;
                  newSL = NormalizeDouble(newSL, _Digits);
                  
                  if(trade.PositionModify(PositionGetTicket(i), newSL, PositionGetDouble(POSITION_TP)))
                  {
                     Print("Break Even applied for Buy position");
                  }
               }
            }
            else if(positionType == POSITION_TYPE_SELL)
            {
               double profitPoints = (entryPrice - currentPrice) / _Point;
               
               if(profitPoints >= InpBreakEvenTrigger && currentSL > entryPrice - InpBreakEvenLevel * _Point)
               {
                  double newSL = entryPrice - InpBreakEvenLevel * _Point;
                  newSL = NormalizeDouble(newSL, _Digits);
                  
                  if(trade.PositionModify(PositionGetTicket(i), newSL, PositionGetDouble(POSITION_TP)))
                  {
                     Print("Break Even applied for Sell position");
                  }
               }
            }
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Manage Trailing Stop                                             |
//+------------------------------------------------------------------+
void ManageTrailingStop()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      if(PositionSelectByTicket(PositionGetTicket(i)))
      {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
         {
            double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            double currentPrice = PositionGetDouble(POSITION_PRICE_CURRENT);
            double currentSL = PositionGetDouble(POSITION_SL);
            long positionType = PositionGetInteger(POSITION_TYPE);
            
            //--- Check if trailing should be applied
            if(positionType == POSITION_TYPE_BUY)
            {
               double profitPoints = (currentPrice - entryPrice) / _Point;
               
               if(profitPoints >= InpTrailingStart)
               {
                  double newSL = currentPrice - InpTrailingStart * _Point;
                  newSL = NormalizeDouble(newSL, _Digits);
                  
                  //--- Only move SL if new SL is better than current
                  if(newSL > currentSL + InpTrailingStep * _Point)
                  {
                     if(trade.PositionModify(PositionGetTicket(i), newSL, PositionGetDouble(POSITION_TP)))
                     {
                        Print("Trailing Stop updated for Buy position to: ", newSL);
                     }
                  }
               }
            }
            else if(positionType == POSITION_TYPE_SELL)
            {
               double profitPoints = (entryPrice - currentPrice) / _Point;
               
               if(profitPoints >= InpTrailingStart)
               {
                  double newSL = currentPrice + InpTrailingStart * _Point;
                  newSL = NormalizeDouble(newSL, _Digits);
                  
                  //--- Only move SL if new SL is better than current
                  if(newSL < currentSL - InpTrailingStep * _Point || currentSL == 0)
                  {
                     if(trade.PositionModify(PositionGetTicket(i), newSL, PositionGetDouble(POSITION_TP)))
                     {
                        Print("Trailing Stop updated for Sell position to: ", newSL);
                     }
                  }
               }
            }
         }
      }
   }
}
//+------------------------------------------------------------------+