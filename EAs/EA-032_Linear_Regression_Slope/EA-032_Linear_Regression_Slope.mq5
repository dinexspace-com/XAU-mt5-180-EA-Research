#property copyright "Expert Advisor"
#property link      ""
#property version   "1.00"
#property strict

#include <Trade\Trade.mqh>

//--- Input Parameters
input double   InpLotSize        = 0.01;      // Lot Size
input int      InpStopLoss       = 300;       // Stop Loss (points)
input int      InpTakeProfit     = 600;       // Take Profit (points)
input ulong    InpMagicNumber    = 123456;    // Magic Number
input int      InpSlippage       = 10;        // Slippage (points)
input bool     InpUseBreakEven   = true;      // Use Break Even
input int      InpBreakEvenStart = 150;       // Break Even Start (points)
input int      InpBreakEvenShift = 10;        // Break Even Shift (points)
input bool     InpUseTrailing    = true;      // Use Trailing Stop
input int      InpTrailingStart  = 200;       // Trailing Start (points)
input int      InpTrailingStep   = 50;        // Trailing Step (points)
input int      InpMaxSpread      = 30;        // Max Spread (points)
input int      InpRegPeriod      = 20;        // Regression Period
input int      InpSensibility    = 2;         // Slope Sensibility

//--- Global Variables
CTrade  trade;
MqlTick currentTick;
datetime lastBarTime = 0;
double   slope = 0.0;
double   intercept = 0.0;
double   regMid = 0.0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetAsyncMode(false);
   
   if(InpLotSize <= 0)
     {
      Print("Invalid Lot Size!");
      return(INIT_PARAMETERS_INCORRECT);
     }
     
   if(InpStopLoss <= 0 || InpTakeProfit <= 0)
     {
      Print("Invalid SL/TP!");
      return(INIT_PARAMETERS_INCORRECT);
     }
   
   Print("EA initialized successfully. Magic Number: ", InpMagicNumber);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Print("EA deinitialized. Reason: ", reason);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   if(!IsNewBar())
      return;
      
   if(!SymbolInfoTick(_Symbol, currentTick))
     {
      Print("Failed to get tick data!");
      return;
     }
   
   int spreadPoints = (int)MathRound((currentTick.ask - currentTick.bid) / _Point);
   if(spreadPoints > InpMaxSpread)
     {
      Print("Spread too high: ", spreadPoints, " points. Max allowed: ", InpMaxSpread);
      return;
     }
   
   if(CountOpenPositions() >= 1)
      return;
      
   if(!CalculateLinearRegression())
     {
      Print("Failed to calculate regression!");
      return;
     }
   
   double currentPrice = currentTick.bid;
   bool buySignal = (slope > 0 && currentPrice > regMid);
   bool sellSignal = (slope < 0 && currentPrice < regMid);
   
   if(buySignal)
     {
      ExecuteBuy();
     }
   else if(sellSignal)
     {
      ExecuteSell();
     }
   
   if(InpUseBreakEven)
      ApplyBreakEven();
      
   if(InpUseTrailing)
      ApplyTrailingStop();
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
//| Count open positions with magic number                           |
//+------------------------------------------------------------------+
int CountOpenPositions()
  {
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
        {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
            count++;
        }
     }
   return count;
  }
//+------------------------------------------------------------------+
//| Calculate linear regression                                      |
//+------------------------------------------------------------------+
bool CalculateLinearRegression()
  {
   double sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0;
   int period = InpRegPeriod;
   
   if(period <= 0)
      return false;
      
   for(int i = 0; i < period; i++)
     {
      double closePrice = iClose(_Symbol, PERIOD_CURRENT, i);
      if(closePrice <= 0)
         return false;
         
      sumX += i;
      sumY += closePrice;
      sumXY += i * closePrice;
      sumX2 += i * i;
     }
   
   double denominator = period * sumX2 - sumX * sumX;
   if(MathAbs(denominator) < 0.000001)
      return false;
      
   slope = (period * sumXY - sumX * sumY) / denominator;
   intercept = (sumY - slope * sumX) / period;
   
   double sumClose = 0;
   for(int i = 0; i < period; i++)
     {
      sumClose += iClose(_Symbol, PERIOD_CURRENT, i);
     }
   regMid = sumClose / period;
   
   return true;
  }
//+------------------------------------------------------------------+
//| Execute Buy order                                                |
//+------------------------------------------------------------------+
void ExecuteBuy()
  {
   double ask = currentTick.ask;
   double sl = NormalizeDouble(ask - InpStopLoss * _Point, _Digits);
   double tp = NormalizeDouble(ask + InpTakeProfit * _Point, _Digits);
   
   if(!trade.Buy(InpLotSize, _Symbol, ask, sl, tp, "Buy Signal - Regression"))
     {
      Print("Buy order failed! Error: ", trade.ResultRetcode());
     }
   else
     {
      Print("Buy order placed successfully. SL: ", sl, " TP: ", tp);
     }
  }
//+------------------------------------------------------------------+
//| Execute Sell order                                               |
//+------------------------------------------------------------------+
void ExecuteSell()
  {
   double bid = currentTick.bid;
   double sl = NormalizeDouble(bid + InpStopLoss * _Point, _Digits);
   double tp = NormalizeDouble(bid - InpTakeProfit * _Point, _Digits);
   
   if(!trade.Sell(InpLotSize, _Symbol, bid, sl, tp, "Sell Signal - Regression"))
     {
      Print("Sell order failed! Error: ", trade.ResultRetcode());
     }
   else
     {
      Print("Sell order placed successfully. SL: ", sl, " TP: ", tp);
     }
  }
//+------------------------------------------------------------------+
//| Apply Break Even                                                 |
//+------------------------------------------------------------------+
void ApplyBreakEven()
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
        {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
           {
            double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            double sl = PositionGetDouble(POSITION_SL);
            double currentSL = sl;
            long positionType = PositionGetInteger(POSITION_TYPE);
            
            if(positionType == POSITION_TYPE_BUY)
              {
               double breakEvenLevel = NormalizeDouble(openPrice + InpBreakEvenStart * _Point, _Digits);
               double newSL = NormalizeDouble(openPrice + InpBreakEvenShift * _Point, _Digits);
               
               if(currentTick.bid >= breakEvenLevel && (sl < newSL || sl == 0))
                 {
                  if(trade.PositionModify(ticket, newSL, PositionGetDouble(POSITION_TP)))
                     Print("Break Even applied to Buy position. New SL: ", newSL);
                  else
                     Print("Failed to apply Break Even to Buy position. Error: ", trade.ResultRetcode());
                 }
              }
            else if(positionType == POSITION_TYPE_SELL)
              {
               double breakEvenLevel = NormalizeDouble(openPrice - InpBreakEvenStart * _Point, _Digits);
               double newSL = NormalizeDouble(openPrice - InpBreakEvenShift * _Point, _Digits);
               
               if(currentTick.ask <= breakEvenLevel && (sl > newSL || sl == 0))
                 {
                  if(trade.PositionModify(ticket, newSL, PositionGetDouble(POSITION_TP)))
                     Print("Break Even applied to Sell position. New SL: ", newSL);
                  else
                     Print("Failed to apply Break Even to Sell position. Error: ", trade.ResultRetcode());
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Apply Trailing Stop                                              |
//+------------------------------------------------------------------+
void ApplyTrailingStop()
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
        {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
           {
            double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            double sl = PositionGetDouble(POSITION_SL);
            long positionType = PositionGetInteger(POSITION_TYPE);
            
            if(positionType == POSITION_TYPE_BUY)
              {
               double trailingLevel = NormalizeDouble(openPrice + InpTrailingStart * _Point, _Digits);
               double newSL = NormalizeDouble(currentTick.bid - InpTrailingStep * _Point, _Digits);
               
               if(currentTick.bid >= trailingLevel && (newSL > sl || sl == 0))
                 {
                  if(trade.PositionModify(ticket, newSL, PositionGetDouble(POSITION_TP)))
                     Print("Trailing Stop applied to Buy position. New SL: ", newSL);
                  else
                     Print("Failed to apply Trailing Stop to Buy position. Error: ", trade.ResultRetcode());
                 }
              }
            else if(positionType == POSITION_TYPE_SELL)
              {
               double trailingLevel = NormalizeDouble(openPrice - InpTrailingStart * _Point, _Digits);
               double newSL = NormalizeDouble(currentTick.ask + InpTrailingStep * _Point, _Digits);
               
               if(currentTick.ask <= trailingLevel && (newSL < sl || sl == 0))
                 {
                  if(trade.PositionModify(ticket, newSL, PositionGetDouble(POSITION_TP)))
                     Print("Trailing Stop applied to Sell position. New SL: ", newSL);
                  else
                     Print("Failed to apply Trailing Stop to Sell position. Error: ", trade.ResultRetcode());
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+