//+------------------------------------------------------------------+
//|                                                    SwingBreak.mq5|
//|                                    Senior MQL5 Developer         |
//+------------------------------------------------------------------+
#property copyright "Senior MQL5 Developer"
#property link      ""
#property version   "1.00"
#property strict

#include <Trade\Trade.mqh>

//--- Input Parameters
input group "=== Lot & Order Settings ==="
input double InpLotSize = 0.01;           // Lot size
input ulong InpMagicNumber = 123456;      // Magic Number
input int   InpSlippage = 10;             // Slippage (points)

input group "=== Risk Management ==="
input int   InpStopLoss = 300;            // Stop Loss (points)
input int   InpTakeProfit = 600;          // Take Profit (points)

input group "=== Break Even / Trailing ==="
input bool  InpUseBreakEven = true;       // Use Break Even
input int   InpBreakEvenTrigger = 150;    // Break Even Trigger (points)
input int   InpBreakEvenLock = 0;         // Break Even Lock (points)
input bool  InpUseTrailing = true;        // Use Trailing Stop
input int   InpTrailingStart = 200;       // Trailing Start (points)
input int   InpTrailingStep = 50;         // Trailing Step (points)

input group "=== Filters ==="
input int   InpMaxSpread = 30;            // Max Spread (points)
input int   InpSwingBars = 5;             // Swing Bars (left/right)

//--- Global Variables
CTrade trade;
MqlTick currentTick;
MqlDateTime lastBarTime;
bool isNewBar = false;
datetime currentBarTime = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   
   lastBarTime.year = 0;
   lastBarTime.mon = 0;
   lastBarTime.day = 0;
   lastBarTime.hour = 0;
   lastBarTime.min = 0;
   lastBarTime.sec = 0;
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   //--- Get current tick
   if(!SymbolInfoTick(_Symbol, currentTick))
      return;
   
   //--- Check spread
   double currentSpread = (currentTick.ask - currentTick.bid) / _Point;
   if(currentSpread > InpMaxSpread)
      return;
   
   //--- Check new bar
   CheckNewBar();
   if(!isNewBar)
      return;
   
   //--- Check existing position
   if(CountOpenPositions() >= 1)
   {
      ManageOpenPositions();
      return;
   }
   
   //--- Calculate signals
   double swingHigh = FindSwingHigh();
   double swingLow = FindSwingLow();
   
   if(swingHigh == 0 && swingLow == 0)
      return;
   
   //--- Check buy signal: price breaks above swing high
   if(swingHigh > 0 && currentTick.ask > swingHigh)
   {
      double sl = currentTick.ask - InpStopLoss * _Point;
      double tp = currentTick.ask + InpTakeProfit * _Point;
      
      if(trade.Buy(InpLotSize, _Symbol, 0, sl, tp, "Swing Break BUY"))
      {
         Print("BUY order placed. Ticket: ", trade.ResultOrder());
      }
      else
      {
         Print("Failed to place BUY order. Error: ", trade.ResultRetcode());
      }
   }
   //--- Check sell signal: price breaks below swing low
   else if(swingLow > 0 && currentTick.bid < swingLow)
   {
      double sl = currentTick.bid + InpStopLoss * _Point;
      double tp = currentTick.bid - InpTakeProfit * _Point;
      
      if(trade.Sell(InpLotSize, _Symbol, 0, sl, tp, "Swing Break SELL"))
      {
         Print("SELL order placed. Ticket: ", trade.ResultOrder());
      }
      else
      {
         Print("Failed to place SELL order. Error: ", trade.ResultRetcode());
      }
   }
}

//+------------------------------------------------------------------+
//| Check for new bar                                                |
//+------------------------------------------------------------------+
void CheckNewBar()
{
   MqlDateTime currentTime;
   TimeToStruct(iTime(_Symbol, PERIOD_CURRENT, 0), currentTime);
   
   if(currentTime.year != lastBarTime.year ||
      currentTime.mon != lastBarTime.mon ||
      currentTime.day != lastBarTime.day ||
      currentTime.hour != lastBarTime.hour ||
      currentTime.min != lastBarTime.min)
   {
      isNewBar = true;
      lastBarTime = currentTime;
   }
   else
   {
      isNewBar = false;
   }
}

//+------------------------------------------------------------------+
//| Count open positions with this magic number                      |
//+------------------------------------------------------------------+
int CountOpenPositions()
{
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong posTicket = PositionGetTicket(i);
      if(posTicket > 0)
      {
         if(PositionGetInteger(POSITION_MAGIC) == InpMagicNumber &&
            PositionGetString(POSITION_SYMBOL) == _Symbol)
         {
            count++;
         }
      }
   }
   return count;
}

//+------------------------------------------------------------------+
//| Find swing high                                                  |
//+------------------------------------------------------------------+
double FindSwingHigh()
{
   double high = 0;
   int barsCount = iBars(_Symbol, PERIOD_CURRENT);
   
   for(int i = InpSwingBars; i < barsCount - InpSwingBars; i++)
   {
      double currentHigh = iHigh(_Symbol, PERIOD_CURRENT, i);
      bool isSwingHigh = true;
      
      for(int j = 1; j <= InpSwingBars; j++)
      {
         if(iHigh(_Symbol, PERIOD_CURRENT, i - j) >= currentHigh ||
            iHigh(_Symbol, PERIOD_CURRENT, i + j) >= currentHigh)
         {
            isSwingHigh = false;
            break;
         }
      }
      
      if(isSwingHigh)
      {
         high = currentHigh;
         break;
      }
   }
   
   return high;
}

//+------------------------------------------------------------------+
//| Find swing low                                                   |
//+------------------------------------------------------------------+
double FindSwingLow()
{
   double low = 0;
   int barsCount = iBars(_Symbol, PERIOD_CURRENT);
   
   for(int i = InpSwingBars; i < barsCount - InpSwingBars; i++)
   {
      double currentLow = iLow(_Symbol, PERIOD_CURRENT, i);
      bool isSwingLow = true;
      
      for(int j = 1; j <= InpSwingBars; j++)
      {
         if(iLow(_Symbol, PERIOD_CURRENT, i - j) <= currentLow ||
            iLow(_Symbol, PERIOD_CURRENT, i + j) <= currentLow)
         {
            isSwingLow = false;
            break;
         }
      }
      
      if(isSwingLow)
      {
         low = currentLow;
         break;
      }
   }
   
   return low;
}

//+------------------------------------------------------------------+
//| Manage open positions (Break Even & Trailing Stop)               |
//+------------------------------------------------------------------+
void ManageOpenPositions()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong posTicket = PositionGetTicket(i);
      if(posTicket > 0)
      {
         if(PositionGetInteger(POSITION_MAGIC) == InpMagicNumber &&
            PositionGetString(POSITION_SYMBOL) == _Symbol)
         {
            double posOpenPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            double posSL = PositionGetDouble(POSITION_SL);
            double posTP = PositionGetDouble(POSITION_TP);
            long posType = PositionGetInteger(POSITION_TYPE);
            
            if(posType == POSITION_TYPE_BUY)
            {
               double profitPoints = (currentTick.bid - posOpenPrice) / _Point;
               
               //--- Break Even
               if(InpUseBreakEven && profitPoints >= InpBreakEvenTrigger)
               {
                  double newSL = posOpenPrice + InpBreakEvenLock * _Point;
                  if(newSL > posSL || posSL == 0)
                  {
                     trade.PositionModify(posTicket, newSL, posTP);
                  }
               }
               
               //--- Trailing Stop
               if(InpUseTrailing && profitPoints >= InpTrailingStart)
               {
                  double newSL = currentTick.bid - InpTrailingStep * _Point;
                  if(newSL > posSL || posSL == 0)
                  {
                     trade.PositionModify(posTicket, newSL, posTP);
                  }
               }
            }
            else if(posType == POSITION_TYPE_SELL)
            {
               double profitPoints = (posOpenPrice - currentTick.ask) / _Point;
               
               //--- Break Even
               if(InpUseBreakEven && profitPoints >= InpBreakEvenTrigger)
               {
                  double newSL = posOpenPrice - InpBreakEvenLock * _Point;
                  if(newSL < posSL || posSL == 0)
                  {
                     trade.PositionModify(posTicket, newSL, posTP);
                  }
               }
               
               //--- Trailing Stop
               if(InpUseTrailing && profitPoints >= InpTrailingStart)
               {
                  double newSL = currentTick.ask + InpTrailingStep * _Point;
                  if(newSL < posSL || posSL == 0)
                  {
                     trade.PositionModify(posTicket, newSL, posTP);
                  }
               }
            }
         }
      }
   }
}
//+------------------------------------------------------------------+