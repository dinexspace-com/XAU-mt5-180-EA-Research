#property copyright "Copyright 2026, Senior MQL5 Developer"
#property link      "https://www.mql5.com"
#property version   "1.00"
#include <Trade\Trade.mqh>

input group "=== General ==="
input double InpLotSize = 0.01;
input int    InpStopLoss = 300;        // Stop Loss (points)
input int    InpTakeProfit = 600;      // Take Profit (points)
input ulong  InpMagicNumber = 123456;
input int    InpSlippage = 10;
input int    InpMaxSpreadPoints = 30;
input int    InpMaxOrders = 1;
input int    InpFastEmaPeriod = 50;
input int    InpSlowEmaPeriod = 200;

input group "=== Break Even ==="
input bool  InpUseBreakEven = true;
input int   InpBreakEvenTriggerPoints = 150;
input int   InpBreakEvenLockPoints = 0;

input group "=== Trailing Stop ==="
input bool  InpUseTrailingStop = true;
input int   InpTrailingStartPoints = 200;
input int   InpTrailingStopPoints = 200;

CTrade trade;
int emaFastHandle = INVALID_HANDLE;
int emaSlowHandle = INVALID_HANDLE;
datetime lastBarTime = 0;

int OnInit()
{
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   
   emaFastHandle = iMA(_Symbol, PERIOD_CURRENT, InpFastEmaPeriod, 0, MODE_EMA, PRICE_CLOSE);
   emaSlowHandle = iMA(_Symbol, PERIOD_CURRENT, InpSlowEmaPeriod, 0, MODE_EMA, PRICE_CLOSE);
   
   if(emaFastHandle == INVALID_HANDLE || emaSlowHandle == INVALID_HANDLE)
   {
      Print("Failed to create EMA indicator handles");
      if(emaFastHandle != INVALID_HANDLE)
         IndicatorRelease(emaFastHandle);
      if(emaSlowHandle != INVALID_HANDLE)
         IndicatorRelease(emaSlowHandle);
      return(INIT_FAILED);
   }
   
   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   if(emaFastHandle != INVALID_HANDLE)
      IndicatorRelease(emaFastHandle);
   if(emaSlowHandle != INVALID_HANDLE)
      IndicatorRelease(emaSlowHandle);
}

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

bool CheckSpreadOK()
{
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   if(ask <= 0.0 || bid <= 0.0)
      return(false);
   return((ask - bid) <= InpMaxSpreadPoints * _Point);
}

int CountOpenPositions()
{
   int count = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;
      if(PositionSelectByTicket(ticket))
      {
         if((ulong)PositionGetInteger(POSITION_MAGIC) == InpMagicNumber &&
            PositionGetString(POSITION_SYMBOL) == _Symbol)
         {
            count++;
         }
      }
   }
   return(count);
}

double CurrentAsk()
{
   return(SymbolInfoDouble(_Symbol, SYMBOL_ASK));
}

double CurrentBid()
{
   return(SymbolInfoDouble(_Symbol, SYMBOL_BID));
}

void ExecuteSignal()
{
   double fast[1];
   double slow[1];
   
   if(CopyBuffer(emaFastHandle, 0, 0, 1, fast) != 1)
   {
      Print("Error copying fast EMA buffer");
      return;
   }
   if(CopyBuffer(emaSlowHandle, 0, 0, 1, slow) != 1)
   {
      Print("Error copying slow EMA buffer");
      return;
   }
   
   double price = iClose(_Symbol, PERIOD_CURRENT, 0);
   double ask = CurrentAsk();
   double bid = CurrentBid();
   if(price <= 0.0 || ask <= 0.0 || bid <= 0.0)
      return;
   
   bool buySignal  = (fast[0] > slow[0] && price > fast[0]);
   bool sellSignal = (fast[0] < slow[0] && price < fast[0]);
   
   if(!buySignal && !sellSignal)
      return;
   
   double sl = 0.0;
   double tp = 0.0;
   bool opened = false;
   
   if(buySignal)
   {
      sl = ask - InpStopLoss * _Point;
      tp = ask + InpTakeProfit * _Point;
      opened = trade.Buy(InpLotSize, _Symbol, 0.0, sl, tp, "EMA Crossover EA");
   }
   else if(sellSignal)
   {
      sl = bid + InpStopLoss * _Point;
      tp = bid - InpTakeProfit * _Point;
      opened = trade.Sell(InpLotSize, _Symbol, 0.0, sl, tp, "EMA Crossover EA");
   }
   
   if(!opened)
      Print("Failed to open position. Error: ", GetLastError());
}

void ManagePositions()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;
      
      if(!PositionSelectByTicket(ticket))
         continue;
      
      if((ulong)PositionGetInteger(POSITION_MAGIC) != InpMagicNumber)
         continue;
      if(PositionGetString(POSITION_SYMBOL) != _Symbol)
         continue;
      
      long positionType = PositionGetInteger(POSITION_TYPE);
      double openPrice  = PositionGetDouble(POSITION_PRICE_OPEN);
      double currentSL  = PositionGetDouble(POSITION_SL);
      double currentTP  = PositionGetDouble(POSITION_TP);
      double ask = CurrentAsk();
      double bid = CurrentBid();
      
      double newSL = 0.0;
      bool modify = false;
      
      if(positionType == POSITION_TYPE_BUY)
      {
         if(InpUseBreakEven && (bid - openPrice) >= InpBreakEvenTriggerPoints * _Point)
         {
            double breakEvenSL = openPrice + InpBreakEvenLockPoints * _Point;
            if(currentSL < breakEvenSL)
            {
               newSL = breakEvenSL;
               modify = true;
            }
         }
         
         if(InpUseTrailingStop && (bid - openPrice) >= InpTrailingStartPoints * _Point)
         {
            double trailingSL = bid - InpTrailingStopPoints * _Point;
            if(trailingSL > currentSL)
            {
               if(!modify || trailingSL > newSL)
               {
                  newSL = trailingSL;
                  modify = true;
               }
            }
         }
      }
      else if(positionType == POSITION_TYPE_SELL)
      {
         if(InpUseBreakEven && (openPrice - ask) >= InpBreakEvenTriggerPoints * _Point)
         {
            double breakEvenSL = openPrice - InpBreakEvenLockPoints * _Point;
            if(currentSL > breakEvenSL)
            {
               newSL = breakEvenSL;
               modify = true;
            }
         }
         
         if(InpUseTrailingStop && (openPrice - ask) >= InpTrailingStartPoints * _Point)
         {
            double trailingSL = ask + InpTrailingStopPoints * _Point;
            if(trailingSL < currentSL)
            {
               if(!modify || trailingSL < newSL)
               {
                  newSL = trailingSL;
                  modify = true;
               }
            }
         }
      }
      
      if(modify)
      {
         if(!trade.PositionModify(ticket, newSL, currentTP))
            Print("Failed to modify position #", ticket, ". Error: ", GetLastError());
      }
   }
}

void OnTick()
{
   if(IsNewBar())
   {
      if(CheckSpreadOK() && CountOpenPositions() < InpMaxOrders)
         ExecuteSignal();
   }
   
   ManagePositions();
}
