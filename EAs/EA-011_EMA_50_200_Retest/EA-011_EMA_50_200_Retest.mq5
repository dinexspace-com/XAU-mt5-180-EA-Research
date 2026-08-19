#property copyright "Copyright 2025, Senior MQL5 Developer"
#property version   "1.00"
#include <Trade\Trade.mqh>

input group "=== Order Settings ==="
input double InpLotSize = 0.01;
input int    InpStopLoss = 300;
input int    InpTakeProfit = 600;
input ulong  InpMagicNumber = 123456;
input int    InpSlippage = 10;

input group "=== Break Even / Trailing ==="
input bool InpUseBreakEven = true;
input int  InpBreakEvenTriggerPoints = 150;
input bool InpUseTrailingStop = true;
input int  InpTrailingStartPoints = 200;

input group "=== Strategy Filters ==="
input int InpMaxSpreadPoints = 30;
input int InpMaxPositions = 1;
input int InpFastEMA = 50;
input int InpSlowEMA = 200;

CTrade trade;
int emaFastHandle = INVALID_HANDLE;
int emaSlowHandle = INVALID_HANDLE;
datetime lastBarTime = 0;
int pendingDirection = 0; // 1 = long, -1 = short
double emaFastBuffer[];
double emaSlowBuffer[];

int OnInit()
{
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
   {
      Print("Trading terminal not allowed.");
      return INIT_FAILED;
   }
   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
   {
      Print("Algorithmic trading not allowed.");
      return INIT_FAILED;
   }

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   emaFastHandle = iMA(_Symbol, PERIOD_CURRENT, InpFastEMA, 0, MODE_EMA, PRICE_CLOSE);
   emaSlowHandle = iMA(_Symbol, PERIOD_CURRENT, InpSlowEMA, 0, MODE_EMA, PRICE_CLOSE);

   if(emaFastHandle == INVALID_HANDLE || emaSlowHandle == INVALID_HANDLE)
   {
      Print("Failed to create EMA handles.");
      return INIT_FAILED;
   }

   ArraySetAsSeries(emaFastBuffer, true);
   ArraySetAsSeries(emaSlowBuffer, true);
   lastBarTime = 0;
   pendingDirection = 0;

   return INIT_SUCCEEDED;
}

void OnDeinit(const int /*reason*/)
{
   if(emaFastHandle != INVALID_HANDLE)
      IndicatorRelease(emaFastHandle);
   if(emaSlowHandle != INVALID_HANDLE)
      IndicatorRelease(emaSlowHandle);
   Comment("");
}

void OnTick()
{
   bool newBar = IsNewBar();

   if(newBar)
   {
      UpdateCrossSignal();
   }
   else
   {
      TryEnterOnRetest();
   }

   ManageOpenPositions();
}

bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);
   if(currentBarTime == 0)
      return false;

   if(currentBarTime != lastBarTime)
   {
      lastBarTime = currentBarTime;
      return true;
   }
   return false;
}

void UpdateCrossSignal()
{
   if(CopyBuffer(emaFastHandle, 0, 0, 3, emaFastBuffer) < 3)
      return;
   if(CopyBuffer(emaSlowHandle, 0, 0, 3, emaSlowBuffer) < 3)
      return;

   double fastPrev1 = emaFastBuffer[1];
   double slowPrev1 = emaSlowBuffer[1];
   double fastPrev2 = emaFastBuffer[2];
   double slowPrev2 = emaSlowBuffer[2];

   if(fastPrev1 > slowPrev1 && fastPrev2 <= slowPrev2)
      pendingDirection = 1;
   else if(fastPrev1 < slowPrev1 && fastPrev2 >= slowPrev2)
      pendingDirection = -1;
}

void TryEnterOnRetest()
{
   if(pendingDirection == 0)
      return;
   if(CountOpenPositions() >= InpMaxPositions)
      return;
   if(GetCurrentSpreadPoints() > InpMaxSpreadPoints)
      return;

   if(CopyBuffer(emaFastHandle, 0, 0, 1, emaFastBuffer) != 1)
      return;

   double emaFastCurrent = emaFastBuffer[0];
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);

   if(pendingDirection == 1 && ask <= emaFastCurrent)
   {
      OpenBuy(ask);
   }
   else if(pendingDirection == -1 && bid >= emaFastCurrent)
   {
      OpenSell(bid);
   }
}

void OpenBuy(double ask)
{
   double sl = ask - InpStopLoss * _Point;
   double tp = ask + InpTakeProfit * _Point;

   if(trade.Buy(InpLotSize, _Symbol, ask, sl, tp, "EMA50/200 Cross Retest Buy"))
   {
      pendingDirection = 0;
   }
   else
   {
      Print("Buy failed. Error code: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
   }
}

void OpenSell(double bid)
{
   double sl = bid + InpStopLoss * _Point;
   double tp = bid - InpTakeProfit * _Point;

   if(trade.Sell(InpLotSize, _Symbol, bid, sl, tp, "EMA50/200 Cross Retest Sell"))
   {
      pendingDirection = 0;
   }
   else
   {
      Print("Sell failed. Error code: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
   }
}

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
      if(PositionGetInteger(POSITION_MAGIC) != (long)InpMagicNumber)
         continue;
      count++;
   }
   return count;
}

double GetCurrentSpreadPoints()
{
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   if(ask <= 0 || bid <= 0)
      return 0;
   return (ask - bid) / _Point;
}

void ManageOpenPositions()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;
      if(PositionGetString(POSITION_SYMBOL) != _Symbol)
         continue;
      if(PositionGetInteger(POSITION_MAGIC) != (long)InpMagicNumber)
         continue;

      long posType = PositionGetInteger(POSITION_TYPE);
      double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      double currentSL = PositionGetDouble(POSITION_SL);
      double currentTP = PositionGetDouble(POSITION_TP);

      double currentPrice = (posType == POSITION_TYPE_BUY) ? SymbolInfoDouble(_Symbol, SYMBOL_BID) : SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      if(currentPrice <= 0)
         continue;

      double profitPoints = (posType == POSITION_TYPE_BUY) ? (currentPrice - openPrice) / _Point : (openPrice - currentPrice) / _Point;

      if(InpUseBreakEven && profitPoints >= InpBreakEvenTriggerPoints)
      {
         if(posType == POSITION_TYPE_BUY && currentSL < openPrice)
         {
            if(trade.PositionModify(ticket, openPrice, currentTP))
               currentSL = openPrice;
         }
         else if(posType == POSITION_TYPE_SELL && (currentSL == 0 || currentSL > openPrice))
         {
            if(trade.PositionModify(ticket, openPrice, currentTP))
               currentSL = openPrice;
         }
      }

      if(InpUseTrailingStop && profitPoints >= InpTrailingStartPoints)
      {
         double trailDistance = InpTrailingStartPoints * _Point;
         double trailingSL = (posType == POSITION_TYPE_BUY) ? currentPrice - trailDistance : currentPrice + trailDistance;

         if(posType == POSITION_TYPE_BUY && trailingSL > currentSL)
         {
            if(trade.PositionModify(ticket, trailingSL, currentTP))
               currentSL = trailingSL;
         }
         else if(posType == POSITION_TYPE_SELL && (currentSL == 0 || trailingSL < currentSL))
         {
            if(trade.PositionModify(ticket, trailingSL, currentTP))
               currentSL = trailingSL;
         }
      }
   }
}
