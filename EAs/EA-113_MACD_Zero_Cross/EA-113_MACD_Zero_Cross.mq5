#property strict
#property version "1.01"

#include <Trade\Trade.mqh>

CTrade trade;

//==================================================
// INPUTS
//==================================================
input double InpLotSize=0.01;
input int    InpStopLoss=300;
input int    InpTakeProfit=600;
input ulong  InpMagicNumber=113001;
input int    InpSlippage=10;

input bool   InpUseBreakEven=true;
input int    InpBreakEvenStart=150;
input int    InpBreakEvenOffset=0;

input bool   InpUseTrailingStop=true;
input int    InpTrailingStart=200;
input int    InpTrailingDistance=200;

input int    InpMaxSpread=30;

input int    InpFastEMA=12;
input int    InpSlowEMA=26;
input int    InpSignalPeriod=9;

//==================================================
// GLOBAL VARIABLES
//==================================================
int      h=INVALID_HANDLE;
datetime lastbar=0;

//==================================================
// INITIALIZATION
//==================================================
int OnInit()
{
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   h=iMACD(
      _Symbol,
      _Period,
      InpFastEMA,
      InpSlowEMA,
      InpSignalPeriod,
      PRICE_CLOSE
   );

   if(h==INVALID_HANDLE)
   {
      Print("Failed to create MACD handle.");
      return INIT_FAILED;
   }

   return INIT_SUCCEEDED;
}

//==================================================
// DEINITIALIZATION
//==================================================
void OnDeinit(const int reason)
{
   if(h!=INVALID_HANDLE)
      IndicatorRelease(h);
}

//==================================================
// NEW BAR DETECTION
//==================================================
bool NewBar()
{
   datetime t=iTime(_Symbol,_Period,0);

   if(t==0 || t==lastbar)
      return false;

   lastbar=t;

   return true;
}

//==================================================
// CHECK EXISTING POSITION
//==================================================
bool HasPosition()
{
   for(int i=PositionsTotal()-1;i>=0;i--)
   {
      ulong ticket=PositionGetTicket(i);

      if(ticket==0)
         continue;

      if(PositionGetString(POSITION_SYMBOL)!=_Symbol)
         continue;

      if((ulong)PositionGetInteger(POSITION_MAGIC)!=InpMagicNumber)
         continue;

      return true;
   }

   return false;
}

//==================================================
// SPREAD FILTER
//==================================================
bool SpreadOK()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return false;

   double spread=(tick.ask-tick.bid)/_Point;

   return spread<=InpMaxSpread;
}

//==================================================
// MANAGE OPEN POSITIONS
//==================================================
void ManagePositions()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return;

   int digits=(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);

   for(int i=PositionsTotal()-1;i>=0;i--)
   {
      ulong ticket=PositionGetTicket(i);

      if(ticket==0)
         continue;

      if(PositionGetString(POSITION_SYMBOL)!=_Symbol)
         continue;

      if((ulong)PositionGetInteger(POSITION_MAGIC)!=InpMagicNumber)
         continue;

      ENUM_POSITION_TYPE type=
         (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

      double openPrice=PositionGetDouble(POSITION_PRICE_OPEN);
      double stopLoss=PositionGetDouble(POSITION_SL);
      double takeProfit=PositionGetDouble(POSITION_TP);

      double currentPrice=
         type==POSITION_TYPE_BUY
         ? tick.bid
         : tick.ask;

      double profitPoints=
         type==POSITION_TYPE_BUY
         ? (currentPrice-openPrice)/_Point
         : (openPrice-currentPrice)/_Point;

      double newSL=stopLoss;

      //==================================================
      // BREAK EVEN
      //==================================================
      if(InpUseBreakEven && profitPoints>=InpBreakEvenStart)
      {
         double breakEvenPrice=
            type==POSITION_TYPE_BUY
            ? openPrice+InpBreakEvenOffset*_Point
            : openPrice-InpBreakEvenOffset*_Point;

         if(type==POSITION_TYPE_BUY)
         {
            if(newSL==0 || breakEvenPrice>newSL)
               newSL=breakEvenPrice;
         }
         else
         {
            if(newSL==0 || breakEvenPrice<newSL)
               newSL=breakEvenPrice;
         }
      }

      //==================================================
      // TRAILING STOP
      //==================================================
      if(InpUseTrailingStop && profitPoints>=InpTrailingStart)
      {
         double trailingSL=
            type==POSITION_TYPE_BUY
            ? currentPrice-InpTrailingDistance*_Point
            : currentPrice+InpTrailingDistance*_Point;

         if(type==POSITION_TYPE_BUY)
         {
            if(newSL==0 || trailingSL>newSL)
               newSL=trailingSL;
         }
         else
         {
            if(newSL==0 || trailingSL<newSL)
               newSL=trailingSL;
         }
      }

      newSL=NormalizeDouble(newSL,digits);

      if(newSL>0 && MathAbs(newSL-stopLoss)>=_Point)
      {
         if(!trade.PositionModify(ticket,newSL,takeProfit))
         {
            PrintFormat(
               "PositionModify failed. Ticket=%I64u Retcode=%u",
               ticket,
               trade.ResultRetcode()
            );
         }
      }
   }
}

//==================================================
// MAIN TICK
//==================================================
void OnTick()
{
   // Manage existing positions on every tick
   ManagePositions();

   // Only process trading logic on a new candle
   if(!NewBar())
      return;

   // Trading permission checks
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return;

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return;

   // Only one position for this EA/symbol
   if(HasPosition())
      return;

   // Spread filter
   if(!SpreadOK())
      return;

   //==================================================
   // MACD BUFFER
   //
   // IMPORTANT:
   // m[] is a STATIC ARRAY.
   // DO NOT use ArraySetAsSeries(m,true).
   //
   // CopyBuffer(h,0,0,3,m) fills the array as:
   //
   // m[0] = oldest requested value = bar 2
   // m[1] = bar 1 (last closed candle)
   // m[2] = bar 0 (current candle)
   //
   // Original code used ArraySetAsSeries(true):
   //
   // m[1] = bar 1
   // m[2] = bar 2
   //
   // Therefore, to preserve the original Zero Cross
   // logic:
   //
   // Previous MACD = m[0]
   // Current closed MACD = m[1]
   //==================================================

   double m[3];

   if(CopyBuffer(h,0,0,3,m)!=3)
      return;

   //==================================================
   // CURRENT MARKET PRICE
   //==================================================
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol,tick))
      return;

   int digits=(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);

   //==================================================
   // BUY SIGNAL
   //
   // MACD crosses from <= 0 to > 0
   //
   // Previous closed bar: m[0] <= 0
   // Latest closed bar:   m[1] > 0
   //==================================================
   if(m[0]<=0 && m[1]>0)
   {
      double sl=
         NormalizeDouble(
            tick.ask-InpStopLoss*_Point,
            digits
         );

      double tp=
         NormalizeDouble(
            tick.ask+InpTakeProfit*_Point,
            digits
         );

      if(!trade.Buy(
         InpLotSize,
         _Symbol,
         tick.ask,
         sl,
         tp,
         "EA-113 BUY"
      ))
      {
         PrintFormat(
            "Buy failed. Retcode=%u",
            trade.ResultRetcode()
         );
      }
   }

   //==================================================
   // SELL SIGNAL
   //
   // MACD crosses from >= 0 to < 0
   //
   // Previous closed bar: m[0] >= 0
   // Latest closed bar:   m[1] < 0
   //==================================================
   else if(m[0]>=0 && m[1]<0)
   {
      double sl=
         NormalizeDouble(
            tick.bid+InpStopLoss*_Point,
            digits
         );

      double tp=
         NormalizeDouble(
            tick.bid-InpTakeProfit*_Point,
            digits
         );

      if(!trade.Sell(
         InpLotSize,
         _Symbol,
         tick.bid,
         sl,
         tp,
         "EA-113 SELL"
      ))
      {
         PrintFormat(
            "Sell failed. Retcode=%u",
            trade.ResultRetcode()
         );
      }
   }
}