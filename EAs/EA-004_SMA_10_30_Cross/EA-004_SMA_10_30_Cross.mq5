#property copyright "Senior MQL5 Developer"
#property link      ""
#property version   "1.00"
#property strict

#include <Trade\Trade.mqh>

//--- Input Parameters
input group "=== General Settings ==="
input double InpLotSize = 0.01;              // Lot Size
input ulong  InpMagicNumber = 123456;        // Magic Number
input int    InpSlippage = 10;               // Slippage / Deviation (points)

input group "=== Signal Settings ==="
input int    InpFastMAPeriod = 10;           // Fast MA Period
input int    InpSlowMAPeriod = 30;           // Slow MA Period
input int    InpMaxSpread = 30;              // Maximum Spread (points)

input group "=== Risk Management ==="
input int    InpStopLoss = 300;              // Stop Loss (points)
input int    InpTakeProfit = 600;            // Take Profit (points)

input group "=== Break Even Settings ==="
input bool   InpUseBreakEven = true;         // Enable Break Even
input int    InpBreakEvenTrigger = 150;      // Break Even Trigger (points)
input int    InpBreakEvenLock = 0;           // Break Even Lock (points, 0 = breakeven)

input group "=== Trailing Stop Settings ==="
input bool   InpUseTrailingStop = true;      // Enable Trailing Stop
input int    InpTrailingStart = 200;         // Trailing Start (points)
input int    InpTrailingDistance = 200;      // Trailing Distance (points)

//--- Global Variables
CTrade  trade;
int     handleFastMA = INVALID_HANDLE;
int     handleSlowMA = INVALID_HANDLE;
datetime lastBarTime = 0;
string  lastSignal = ""; // "BUY" or "SELL" after bar close

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   //--- Validate inputs
   if(InpFastMAPeriod >= InpSlowMAPeriod)
   {
      Print("Error: Fast MA period must be less than Slow MA period");
      return(INIT_PARAMETERS_INCORRECT);
   }

   if(InpLotSize <= 0)
   {
      Print("Error: Lot size must be positive");
      return(INIT_PARAMETERS_INCORRECT);
   }

   //--- Set magic number and slippage
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetAsyncMode(false);

   //--- Create MA handles
   handleFastMA = iMA(_Symbol, PERIOD_M1, InpFastMAPeriod, 0, MODE_SMA, PRICE_CLOSE);
   handleSlowMA = iMA(_Symbol, PERIOD_M1, InpSlowMAPeriod, 0, MODE_SMA, PRICE_CLOSE);

   if(handleFastMA == INVALID_HANDLE || handleSlowMA == INVALID_HANDLE)
   {
      Print("Error: Failed to create MA handles");
      return(INIT_FAILED);
   }

   Print("EA initialized successfully. Fast MA: ", InpFastMAPeriod, ", Slow MA: ", InpSlowMAPeriod);
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   //--- Release indicator handles
   if(handleFastMA != INVALID_HANDLE)
      IndicatorRelease(handleFastMA);
   if(handleSlowMA != INVALID_HANDLE)
      IndicatorRelease(handleSlowMA);

   Print("EA deinitialized. Reason: ", reason);
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   //--- Check for new bar on M1
   if(!IsNewBar())
      return;

   //--- Check spread condition
   if(!CheckSpread())
      return;

   //--- Manage existing positions
   ManagePositions();

   //--- Check for existing positions before opening new ones
   if(CountPositions() >= 1)
      return;

   //--- Get MA values
   double fastMA[1], slowMA[1];
   double fastMAPrev[1], slowMAPrev[1];

   if(CopyBuffer(handleFastMA, 0, 1, 1, fastMA) <= 0)
   {
      Print("Error copying Fast MA buffer: ", GetLastError());
      return;
   }

   if(CopyBuffer(handleSlowMA, 0, 1, 1, slowMA) <= 0)
   {
      Print("Error copying Slow MA buffer: ", GetLastError());
      return;
   }

   if(CopyBuffer(handleFastMA, 0, 2, 1, fastMAPrev) <= 0)
   {
      Print("Error copying Fast MA previous buffer: ", GetLastError());
      return;
   }

   if(CopyBuffer(handleSlowMA, 0, 2, 1, slowMAPrev) <= 0)
   {
      Print("Error copying Slow MA previous buffer: ", GetLastError());
      return;
   }

   //--- Check for crossover signals
   bool bullishCross = (fastMAPrev[0] <= slowMAPrev[0] && fastMA[0] > slowMA[0]);
   bool bearishCross = (fastMAPrev[0] >= slowMAPrev[0] && fastMA[0] < slowMA[0]);

   //--- Execute trades based on signals
   if(bullishCross)
   {
      OpenBuyPosition();
   }
   else if(bearishCross)
   {
      OpenSellPosition();
   }
}

//+------------------------------------------------------------------+
//| Check if new bar has formed                                      |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol, PERIOD_M1, 0);
   if(currentBarTime != lastBarTime)
   {
      lastBarTime = currentBarTime;
      return(true);
   }
   return(false);
}

//+------------------------------------------------------------------+
//| Check spread condition                                           |
//+------------------------------------------------------------------+
bool CheckSpread()
{
   long spreadPoints = SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
   if(spreadPoints > InpMaxSpread)
   {
      Print("Spread too high: ", spreadPoints, " points (max: ", InpMaxSpread, ")");
      return(false);
   }
   return(true);
}

//+------------------------------------------------------------------+
//| Count open positions for this EA                                 |
//+------------------------------------------------------------------+
int CountPositions()
{
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
      {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol &&
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
         {
            count++;
         }
      }
   }
   return(count);
}

//+------------------------------------------------------------------+
//| Open buy position                                                |
//+------------------------------------------------------------------+
void OpenBuyPosition()
{
   double price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double sl = NormalizeDouble(price - InpStopLoss * _Point, _Digits);
   double tp = NormalizeDouble(price + InpTakeProfit * _Point, _Digits);

   if(trade.Buy(InpLotSize, _Symbol, price, sl, tp, "SMA Cross BUY"))
   {
      Print("BUY order opened. Ticket: ", trade.ResultOrder(), ", Price: ", price, ", SL: ", sl, ", TP: ", tp);
   }
   else
   {
      Print("Failed to open BUY order. Error: ", trade.ResultRetcode());
   }
}

//+------------------------------------------------------------------+
//| Open sell position                                               |
//+------------------------------------------------------------------+
void OpenSellPosition()
{
   double price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double sl = NormalizeDouble(price + InpStopLoss * _Point, _Digits);
   double tp = NormalizeDouble(price - InpTakeProfit * _Point, _Digits);

   if(trade.Sell(InpLotSize, _Symbol, price, sl, tp, "SMA Cross SELL"))
   {
      Print("SELL order opened. Ticket: ", trade.ResultOrder(), ", Price: ", price, ", SL: ", sl, ", TP: ", tp);
   }
   else
   {
      Print("Failed to open SELL order. Error: ", trade.ResultRetcode());
   }
}

//+------------------------------------------------------------------+
//| Manage existing positions (Break Even & Trailing Stop)          |
//+------------------------------------------------------------------+
void ManagePositions()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
      {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol &&
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
         {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
            {
               ManageBuyPosition(ticket);
            }
            else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
            {
               ManageSellPosition(ticket);
            }
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Manage buy position (Break Even & Trailing Stop)                |
//+------------------------------------------------------------------+
void ManageBuyPosition(ulong ticket)
{
   double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double currentSL = PositionGetDouble(POSITION_SL);
   double currentTP = PositionGetDouble(POSITION_TP);
   double profitPoints = (currentPrice - entryPrice) / _Point;

   //--- Break Even
   if(InpUseBreakEven && profitPoints >= InpBreakEvenTrigger)
   {
      double newSL = entryPrice + InpBreakEvenLock * _Point;
      newSL = NormalizeDouble(newSL, _Digits);

      if(newSL > currentSL)
      {
         if(trade.PositionModify(ticket, newSL, currentTP))
         {
            Print("Break Even applied to BUY position ", ticket, ". New SL: ", newSL);
         }
         else
         {
            Print("Failed to apply Break Even to BUY position ", ticket, ". Error: ", trade.ResultRetcode());
         }
      }
   }

   //--- Trailing Stop
   if(InpUseTrailingStop && profitPoints >= InpTrailingStart)
   {
      double newSL = currentPrice - InpTrailingDistance * _Point;
      newSL = NormalizeDouble(newSL, _Digits);

      if(newSL > currentSL)
      {
         if(trade.PositionModify(ticket, newSL, currentTP))
         {
            Print("Trailing Stop applied to BUY position ", ticket, ". New SL: ", newSL);
         }
         else
         {
            Print("Failed to apply Trailing Stop to BUY position ", ticket, ". Error: ", trade.ResultRetcode());
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Manage sell position (Break Even & Trailing Stop)               |
//+------------------------------------------------------------------+
void ManageSellPosition(ulong ticket)
{
   double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double currentSL = PositionGetDouble(POSITION_SL);
   double currentTP = PositionGetDouble(POSITION_TP);
   double profitPoints = (entryPrice - currentPrice) / _Point;

   //--- Break Even
   if(InpUseBreakEven && profitPoints >= InpBreakEvenTrigger)
   {
      double newSL = entryPrice - InpBreakEvenLock * _Point;
      newSL = NormalizeDouble(newSL, _Digits);

      if(newSL < currentSL || currentSL == 0)
      {
         if(trade.PositionModify(ticket, newSL, currentTP))
         {
            Print("Break Even applied to SELL position ", ticket, ". New SL: ", newSL);
         }
         else
         {
            Print("Failed to apply Break Even to SELL position ", ticket, ". Error: ", trade.ResultRetcode());
         }
      }
   }

   //--- Trailing Stop
   if(InpUseTrailingStop && profitPoints >= InpTrailingStart)
   {
      double newSL = currentPrice + InpTrailingDistance * _Point;
      newSL = NormalizeDouble(newSL, _Digits);

      if(newSL < currentSL || currentSL == 0)
      {
         if(trade.PositionModify(ticket, newSL, currentTP))
         {
            Print("Trailing Stop applied to SELL position ", ticket, ". New SL: ", newSL);
         }
         else
         {
            Print("Failed to apply Trailing Stop to SELL position ", ticket, ". Error: ", trade.ResultRetcode());
         }
      }
   }
}
