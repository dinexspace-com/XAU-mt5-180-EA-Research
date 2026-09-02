//+------------------------------------------------------------------+
//|                                                     EMA_ATR_EA.mq5 |
//|                                    Copyright 2024, Your Company  |
//|                                       https://www.yourcompany.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Your Company"
#property link      "https://www.yourcompany.com"
#property version   "1.00"

#include <Trade\Trade.mqh>

//--- Input Parameters
input double InpLotSize = 0.01;                    // Lot Size
input int    InpStopLoss = 300;                    // Stop Loss (points)
input int    InpTakeProfit = 600;                  // Take Profit (points)
input ulong  InpMagicNumber = 20240721;            // Magic Number
input int    InpSlippage = 10;                     // Slippage (points)
input int    InpMAPeriodFast = 20;                 // EMA Fast Period
input int    InpMAPeriodSlow = 50;                 // EMA Slow Period
input int    InpATRPeriod = 14;                    // ATR Period
input int    InpATRAveragePeriod = 50;             // ATR Average Period
input int    InpMaxSpread = 30;                    // Max Spread (points)
input int    InpBreakEvenTrigger = 150;            // Break Even Trigger (points)
input int    InpBreakEvenPips = 0;                 // Break Even Pips (points from entry, 0 = move SL to entry)
input int    InpTrailingStop = 200;                // Trailing Stop (points)
input bool   InpEnableBreakEven = true;            // Enable Break Even
input bool   InpEnableTrailingStop = true;         // Enable Trailing Stop

//--- Global Variables
CTrade  trade;
MqlTick currentTick;
datetime lastBarTime = 0;
int      fastMA_Handle = INVALID_HANDLE;
int      slowMA_Handle = INVALID_HANDLE;
int      atr_Handle = INVALID_HANDLE;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   // Set Magic Number
   trade.SetExpertMagicNumber(InpMagicNumber);
   
   // Setup Indicators
   fastMA_Handle = iMA(_Symbol, PERIOD_CURRENT, InpMAPeriodFast, 0, MODE_EMA, PRICE_CLOSE);
   slowMA_Handle = iMA(_Symbol, PERIOD_CURRENT, InpMAPeriodSlow, 0, MODE_EMA, PRICE_CLOSE);
   atr_Handle = iATR(_Symbol, PERIOD_CURRENT, InpATRPeriod);
   
   if(fastMA_Handle == INVALID_HANDLE || slowMA_Handle == INVALID_HANDLE || atr_Handle == INVALID_HANDLE)
   {
      Print("Failed to create indicator handles");
      return INIT_FAILED;
   }
   
   Print("EMA ATR EA initialized successfully");
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   if(fastMA_Handle != INVALID_HANDLE)
      IndicatorRelease(fastMA_Handle);
   if(slowMA_Handle != INVALID_HANDLE)
      IndicatorRelease(slowMA_Handle);
   if(atr_Handle != INVALID_HANDLE)
      IndicatorRelease(atr_Handle);
   
   Print("EMA ATR EA deinitialized");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   // Check for new bar
   if(!IsNewBar())
      return;
   
   // Get current tick
   if(!SymbolInfoTick(_Symbol, currentTick))
      return;
   
   // Check spread
   int currentSpread = (int)((currentTick.ask - currentTick.bid) / _Point);
   if(currentSpread > InpMaxSpread)
   {
      Print("Spread too high: ", currentSpread, " points. Max allowed: ", InpMaxSpread);
      return;
   }
   
   // Check existing positions
   if(CountPositions() >= 1)
   {
      // Manage existing positions
      ManagePositions();
      return;
   }
   
   // Get indicator values
   double fastMA[], slowMA[], atr[], atrAverage[];
   ArraySetAsSeries(fastMA, true);
   ArraySetAsSeries(slowMA, true);
   ArraySetAsSeries(atr, true);
   ArraySetAsSeries(atrAverage, true);
   
   if(CopyBuffer(fastMA_Handle, 0, 1, 3, fastMA) < 3)
      return;
   if(CopyBuffer(slowMA_Handle, 0, 1, 3, slowMA) < 3)
      return;
   if(CopyBuffer(atr_Handle, 0, 1, InpATRAveragePeriod + 1, atr) < InpATRAveragePeriod + 1)
      return;
   
   // Calculate average ATR
   double avgATR = 0;
   for(int i = 0; i < InpATRAveragePeriod; i++)
      avgATR += atr[i];
   avgATR /= InpATRAveragePeriod;
   
   double currentATR = atr[0];
   
   // Check ATR filter
   if(currentATR <= avgATR)
   {
      Print("ATR filter not passed. Current: ", currentATR, " Average: ", avgATR);
      return;
   }
   
   // Check for cross signals
   // Fast MA crossing above Slow MA = Buy signal
   if(fastMA[2] <= slowMA[2] && fastMA[1] > slowMA[1])
   {
      ExecuteBuy();
   }
   // Fast MA crossing below Slow MA = Sell signal
   else if(fastMA[2] >= slowMA[2] && fastMA[1] < slowMA[1])
   {
      ExecuteSell();
   }
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
      return true;
   }
   return false;
}

//+------------------------------------------------------------------+
//| Count open positions with current magic number                   |
//+------------------------------------------------------------------+
int CountPositions()
{
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong posTicket = PositionGetTicket(i);
      if(posTicket > 0)
      {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol &&
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
            count++;
      }
   }
   return count;
}

//+------------------------------------------------------------------+
//| Execute Buy order                                                |
//+------------------------------------------------------------------+
void ExecuteBuy()
{
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double sl = ask - InpStopLoss * _Point;
   double tp = ask + InpTakeProfit * _Point;
   
   sl = NormalizeDouble(sl, _Digits);
   tp = NormalizeDouble(tp, _Digits);
   
   if(trade.Buy(InpLotSize, _Symbol, ask, sl, tp, "EMA ATR Buy"))
   {
      Print("Buy order opened successfully");
   }
   else
   {
      Print("Failed to open Buy order. Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
   }
}

//+------------------------------------------------------------------+
//| Execute Sell order                                               |
//+------------------------------------------------------------------+
void ExecuteSell()
{
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double sl = bid + InpStopLoss * _Point;
   double tp = bid - InpTakeProfit * _Point;
   
   sl = NormalizeDouble(sl, _Digits);
   tp = NormalizeDouble(tp, _Digits);
   
   if(trade.Sell(InpLotSize, _Symbol, bid, sl, tp, "EMA ATR Sell"))
   {
      Print("Sell order opened successfully");
   }
   else
   {
      Print("Failed to open Sell order. Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
   }
}

//+------------------------------------------------------------------+
//| Manage existing positions (Break Even & Trailing Stop)          |
//+------------------------------------------------------------------+
void ManagePositions()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong posTicket = PositionGetTicket(i);
      if(posTicket > 0)
      {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol &&
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
         {
            double currentSL = PositionGetDouble(POSITION_SL);
            double currentTP = PositionGetDouble(POSITION_TP);
            double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            double currentPrice = PositionGetDouble(POSITION_PRICE_CURRENT);
            long positionType = PositionGetInteger(POSITION_TYPE);
            double profitPoints = 0;
            
            // Calculate profit in points
            if(positionType == POSITION_TYPE_BUY)
               profitPoints = (currentPrice - entryPrice) / _Point;
            else if(positionType == POSITION_TYPE_SELL)
               profitPoints = (entryPrice - currentPrice) / _Point;
            
            // Break Even logic
            if(InpEnableBreakEven && profitPoints >= InpBreakEvenTrigger)
            {
               double newSL = entryPrice;
               if(positionType == POSITION_TYPE_BUY)
                  newSL = entryPrice + InpBreakEvenPips * _Point;
               else if(positionType == POSITION_TYPE_SELL)
                  newSL = entryPrice - InpBreakEvenPips * _Point;
               
               newSL = NormalizeDouble(newSL, _Digits);
               
               if(newSL != currentSL && newSL > 0)
               {
                  if(trade.PositionModify(posTicket, newSL, currentTP))
                  {
                     Print("Break Even applied. New SL: ", newSL);
                  }
               }
            }
            
            // Trailing Stop logic
            if(InpEnableTrailingStop && profitPoints >= InpTrailingStop)
            {
               double newSL = currentSL;
               
               if(positionType == POSITION_TYPE_BUY)
               {
                  newSL = currentPrice - InpTrailingStop * _Point;
                  if(newSL > currentSL && newSL > entryPrice)
                     newSL = NormalizeDouble(newSL, _Digits);
                  else
                     newSL = currentSL;
               }
               else if(positionType == POSITION_TYPE_SELL)
               {
                  newSL = currentPrice + InpTrailingStop * _Point;
                  if(newSL < currentSL && newSL < entryPrice)
                     newSL = NormalizeDouble(newSL, _Digits);
                  else
                     newSL = currentSL;
               }
               
               if(newSL != currentSL && newSL > 0)
               {
                  if(trade.PositionModify(posTicket, newSL, currentTP))
                  {
                     Print("Trailing Stop applied. New SL: ", newSL);
                  }
               }
            }
         }
      }
   }
}
//+------------------------------------------------------------------+