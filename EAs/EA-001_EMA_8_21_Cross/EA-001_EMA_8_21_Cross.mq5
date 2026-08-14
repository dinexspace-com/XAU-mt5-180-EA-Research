//+------------------------------------------------------------------+
//|                                                  EMA_Crossover.mq5 |
//|                                    Copyright 2023, Your Name Here |
//|                                       https://www.yourwebsite.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, Your Name Here"
#property link      "https://www.yourwebsite.com"
#property version   "1.00"

#include <Trade\Trade.mqh>

//--- Input parameters
input double   InpLotSize      = 0.01;     // Lot size
input int     InpStopLoss     = 500;       // Stop Loss (points)
input int     InpTakeProfit   = 1000;      // Take Profit (points)
input ulong   InpMagicNumber  = 123456;    // Magic Number
input int     InpSlippage     = 10;        // Slippage

//--- Strategy specific parameters
input int     InpFastEMA      = 8;         // Fast EMA period
input int     InpSlowEMA      = 21;        // Slow EMA period
input int     InpMaxSpread    = 30;        // Maximum allowed spread (points)
input int     InpMaxPositions = 1;         // Maximum number of positions

//--- Break Even & Trailing Stop parameters
input bool    InpUseBreakEven = true;      // Enable Break Even
input int     InpBreakEven    = 150;       // Break Even activation (points)
input bool    InpUseTrailing  = true;      // Enable Trailing Stop
input int     InpTrailingStop = 200;       // Trailing Stop distance (points)

//--- Global variables
CTrade        trade;
double        point;
ulong         magicNumber;
int           slippage;
int           stopLoss;
int           takeProfit;
int           breakEven;
int           trailingStop;
int           maxSpread;
int           maxPositions;
bool          useBreakEven;
bool          useTrailing;
datetime      lastBarTime;

//--- Indicator handles
int           handleFastEMA;
int           handleSlowEMA;
double        fastEMA[];
double        slowEMA[];

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   //--- Initialize trade settings
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFilling(ORDER_FILLING_FOK);
   
   //--- Store input values to global variables
   magicNumber   = InpMagicNumber;
   slippage      = InpSlippage;
   stopLoss      = InpStopLoss;
   takeProfit    = InpTakeProfit;
   breakEven     = InpBreakEven;
   trailingStop  = InpTrailingStop;
   maxSpread     = InpMaxSpread;
   maxPositions  = InpMaxPositions;
   useBreakEven  = InpUseBreakEven;
   useTrailing   = InpUseTrailing;
   
   //--- Calculate point value
   point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   if(point == 0.0) point = 0.00001;
   if(_Digits == 3 || _Digits == 5) point *= 10;
   
   //--- Create indicator handles
   handleFastEMA = iMA(_Symbol, _Period, InpFastEMA, 0, MODE_EMA, PRICE_CLOSE);
   handleSlowEMA = iMA(_Symbol, _Period, InpSlowEMA, 0, MODE_EMA, PRICE_CLOSE);
   
   if(handleFastEMA == INVALID_HANDLE || handleSlowEMA == INVALID_HANDLE)
   {
      Print("Failed to create indicator handles. Error: ", GetLastError());
      return(INIT_FAILED);
   }
   
   //--- Set arrays as series
   ArraySetAsSeries(fastEMA, true);
   ArraySetAsSeries(slowEMA, true);
   
   //--- Initialize lastBarTime
   lastBarTime = 0;
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   //--- Release indicator handles
   if(handleFastEMA != INVALID_HANDLE) IndicatorRelease(handleFastEMA);
   if(handleSlowEMA != INVALID_HANDLE) IndicatorRelease(handleSlowEMA);
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   //--- New Bar check
   if(!IsNewBar()) return;
   
   //--- Check if we can trade
   if(!CanTrade()) return;
   
   //--- Get indicator data
   if(!GetIndicatorData()) return;
   
   //--- Check for crossover signals
   int signal = CheckSignal();
   if(signal == 0) return;
   
   //--- Close opposite positions if any
   CloseOppositePositions(signal);
   
   //--- Count current positions
   int posCount = CountPositions();
   if(posCount >= maxPositions) return;
   
   //--- Manage existing positions (Break Even & Trailing Stop)
   ManagePositions();
   
   //--- Execute trade
   if(signal > 0)
      OpenBuy();
   else if(signal < 0)
      OpenSell();
}

//+------------------------------------------------------------------+
//| Check if new bar has formed                                      |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol, _Period, 0);
   if(currentBarTime == lastBarTime) return false;
   lastBarTime = currentBarTime;
   return true;
}

//+------------------------------------------------------------------+
//| Check if trading conditions are met                              |
//+------------------------------------------------------------------+
bool CanTrade()
{
   //--- Check account margin
   if(AccountInfoDouble(ACCOUNT_MARGIN_FREE) <= 0.0) return false;
   
   //--- Check spread
   int spread = (int)SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
   if(spread > maxSpread) return false;
   
   return true;
}

//+------------------------------------------------------------------+
//| Get indicator data                                               |
//+------------------------------------------------------------------+
bool GetIndicatorData()
{
   if(CopyBuffer(handleFastEMA, 0, 0, 3, fastEMA) < 3) return false;
   if(CopyBuffer(handleSlowEMA, 0, 0, 3, slowEMA) < 3) return false;
   return true;
}

//+------------------------------------------------------------------+
//| Check for crossover signal                                       |
//+------------------------------------------------------------------+
int CheckSignal()
{
   //--- Get close price of current and previous bar
   double closeCurr = iClose(_Symbol, _Period, 0);
   double closePrev = iClose(_Symbol, _Period, 1);
   
   //--- Check BUY signal: Fast EMA crosses above Slow EMA
   if(fastEMA[1] <= slowEMA[1] && fastEMA[0] > slowEMA[0])
   {
      if(closeCurr > closePrev) return 1; // Buy signal
   }
   
   //--- Check SELL signal: Fast EMA crosses below Slow EMA
   if(fastEMA[1] >= slowEMA[1] && fastEMA[0] < slowEMA[0])
   {
      if(closeCurr < closePrev) return -1; // Sell signal
   }
   
   return 0; // No signal
}

//+------------------------------------------------------------------+
//| Count open positions with magic number                           |
//+------------------------------------------------------------------+
int CountPositions()
{
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      if(PositionSelectByTicket(PositionGetTicket(i)))
      {
         if(PositionGetInteger(POSITION_MAGIC) == (long)magicNumber)
         {
            if(PositionGetString(POSITION_SYMBOL) == _Symbol)
               count++;
         }
      }
   }
   return count;
}

//+------------------------------------------------------------------+
//| Check if position exists with magic number                       |
//+------------------------------------------------------------------+
bool HasPosition()
{
   return CountPositions() > 0;
}

//+------------------------------------------------------------------+
//| Close opposite positions                                         |
//+------------------------------------------------------------------+
void CloseOppositePositions(int signal)
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      if(PositionSelectByTicket(PositionGetTicket(i)))
      {
         if(PositionGetInteger(POSITION_MAGIC) == (long)magicNumber)
         {
            if(PositionGetString(POSITION_SYMBOL) == _Symbol)
            {
               int positionType = (int)PositionGetInteger(POSITION_TYPE);
               
               if((signal > 0 && positionType == POSITION_TYPE_SELL) ||
                  (signal < 0 && positionType == POSITION_TYPE_BUY))
               {
                  trade.PositionClose(PositionGetTicket(i));
               }
            }
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Open Buy order                                                   |
//+------------------------------------------------------------------+
void OpenBuy()
{
   //--- Calculate SL and TP
   double priceAsk = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double sl = priceAsk - stopLoss * point;
   double tp = priceAsk + takeProfit * point;
   
   //--- Open position
   bool result = trade.Buy(InpLotSize, _Symbol, priceAsk, sl, tp, "EMA Crossover Buy");
   
   if(!result)
   {
      Print("Buy order failed. Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
   }
}

//+------------------------------------------------------------------+
//| Open Sell order                                                  |
//+------------------------------------------------------------------+
void OpenSell()
{
   //--- Calculate SL and TP
   double priceBid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double sl = priceBid + stopLoss * point;
   double tp = priceBid - takeProfit * point;
   
   //--- Open position
   bool result = trade.Sell(InpLotSize, _Symbol, priceBid, sl, tp, "EMA Crossover Sell");
   
   if(!result)
   {
      Print("Sell order failed. Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
   }
}

//+------------------------------------------------------------------+
//| Manage positions - Break Even & Trailing Stop                    |
//+------------------------------------------------------------------+
void ManagePositions()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      if(PositionSelectByTicket(PositionGetTicket(i)))
      {
         if(PositionGetInteger(POSITION_MAGIC) == (long)magicNumber)
         {
            if(PositionGetString(POSITION_SYMBOL) == _Symbol)
            {
               double positionOpen = PositionGetDouble(POSITION_PRICE_OPEN);
               double positionCurrent = PositionGetDouble(POSITION_PRICE_CURRENT);
               double positionSL = PositionGetDouble(POSITION_SL);
               int positionType = (int)PositionGetInteger(POSITION_TYPE);
               ulong ticket = PositionGetTicket(i);
               
               //--- Calculate profit in points
               double profitInPoints = 0;
               if(positionType == POSITION_TYPE_BUY)
                  profitInPoints = (positionCurrent - positionOpen) / point;
               else
                  profitInPoints = (positionOpen - positionCurrent) / point;
               
               //--- Break Even logic (if enabled)
               if(useBreakEven && positionSL == 0.0 && profitInPoints >= breakEven)
               {
                  double newSL = positionOpen;
                  trade.PositionModify(ticket, newSL, PositionGetDouble(POSITION_TP));
               }
               
               //--- Trailing Stop logic (if enabled)
               if(useTrailing && positionSL > 0.0 && profitInPoints > trailingStop)
               {
                  double newSL = 0;
                  if(positionType == POSITION_TYPE_BUY)
                     newSL = positionCurrent - trailingStop * point;
                  else
                     newSL = positionCurrent + trailingStop * point;
                  
                  //--- Only trail if new SL is better than current SL
                  if((positionType == POSITION_TYPE_BUY && newSL > positionSL) ||
                     (positionType == POSITION_TYPE_SELL && newSL < positionSL))
                  {
                     trade.PositionModify(ticket, newSL, PositionGetDouble(POSITION_TP));
                  }
               }
            }
         }
      }
   }
}

//+------------------------------------------------------------------+