
#property strict
#property version "1.01"

#include <Trade\Trade.mqh>

CTrade trade;

//+------------------------------------------------------------------+
//| INPUTS                                                           |
//+------------------------------------------------------------------+
input double InpLotSize            = 0.01;
input int    InpStopLoss           = 300;
input int    InpTakeProfit         = 600;
input ulong  InpMagicNumber        = 111001;
input int    InpSlippage           = 10;

input bool   InpUseBreakEven       = true;
input int    InpBreakEvenStart     = 150;
input int    InpBreakEvenOffset    = 0;

input bool   InpUseTrailingStop    = true;
input int    InpTrailingStart      = 200;
input int    InpTrailingDistance   = 200;

input int    InpMaxSpread          = 30;
input int    InpRSIPeriod          = 14;

//+------------------------------------------------------------------+
//| GLOBAL VARIABLES                                                 |
//+------------------------------------------------------------------+
int      g_handle = INVALID_HANDLE;
datetime g_lastBar = 0;

//+------------------------------------------------------------------+
//| EXPERT INITIALIZATION                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   g_handle = iRSI(
      _Symbol,
      _Period,
      InpRSIPeriod,
      PRICE_CLOSE
   );

   if(g_handle == INVALID_HANDLE)
      return INIT_FAILED;

   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| EXPERT DEINITIALIZATION                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   if(g_handle != INVALID_HANDLE)
      IndicatorRelease(g_handle);
}

//+------------------------------------------------------------------+
//| CHECK NEW BAR                                                    |
//+------------------------------------------------------------------+
bool NewBar()
{
   datetime t = iTime(_Symbol, _Period, 0);

   if(t == 0 || t == g_lastBar)
      return false;

   g_lastBar = t;

   return true;
}

//+------------------------------------------------------------------+
//| CHECK EXISTING POSITION                                          |
//+------------------------------------------------------------------+
bool HasPosition()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket > 0 &&
         PositionGetString(POSITION_SYMBOL) == _Symbol &&
         (ulong)PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
      {
         return true;
      }
   }

   return false;
}

//+------------------------------------------------------------------+
//| CHECK SPREAD                                                     |
//+------------------------------------------------------------------+
bool SpreadOK()
{
   MqlTick t;

   if(!SymbolInfoTick(_Symbol, t))
      return false;

   double spread = (t.ask - t.bid) / _Point;

   return spread <= InpMaxSpread;
}

//+------------------------------------------------------------------+
//| MANAGE OPEN POSITIONS                                            |
//+------------------------------------------------------------------+
void ManagePositions()
{
   MqlTick t;

   if(!SymbolInfoTick(_Symbol, t))
      return;

   int digits = (int)SymbolInfoInteger(
      _Symbol,
      SYMBOL_DIGITS
   );

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(PositionGetString(POSITION_SYMBOL) != _Symbol)
         continue;

      if((ulong)PositionGetInteger(POSITION_MAGIC) != InpMagicNumber)
         continue;

      ENUM_POSITION_TYPE type =
         (ENUM_POSITION_TYPE)PositionGetInteger(
            POSITION_TYPE
         );

      double open =
         PositionGetDouble(POSITION_PRICE_OPEN);

      double sl =
         PositionGetDouble(POSITION_SL);

      double tp =
         PositionGetDouble(POSITION_TP);

      double price =
         type == POSITION_TYPE_BUY
         ? t.bid
         : t.ask;

      double profit =
         type == POSITION_TYPE_BUY
         ? (price - open) / _Point
         : (open - price) / _Point;

      double newSL = sl;

      //==============================================================
      // BREAK EVEN
      //==============================================================
      if(InpUseBreakEven &&
         profit >= InpBreakEvenStart)
      {
         double be =
            type == POSITION_TYPE_BUY
            ? open + InpBreakEvenOffset * _Point
            : open - InpBreakEvenOffset * _Point;

         if(
            type == POSITION_TYPE_BUY
            ? (newSL == 0 || be > newSL)
            : (newSL == 0 || be < newSL)
         )
         {
            newSL = be;
         }
      }

      //==============================================================
      // TRAILING STOP
      //==============================================================
      if(InpUseTrailingStop &&
         profit >= InpTrailingStart)
      {
         double tr =
            type == POSITION_TYPE_BUY
            ? price - InpTrailingDistance * _Point
            : price + InpTrailingDistance * _Point;

         if(
            type == POSITION_TYPE_BUY
            ? (newSL == 0 || tr > newSL)
            : (newSL == 0 || tr < newSL)
         )
         {
            newSL = tr;
         }
      }

      newSL = NormalizeDouble(
         newSL,
         digits
      );

      if(
         newSL > 0 &&
         MathAbs(newSL - sl) >= _Point
      )
      {
         if(!trade.PositionModify(
            ticket,
            newSL,
            tp
         ))
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

//+------------------------------------------------------------------+
//| EXPERT TICK                                                      |
//+------------------------------------------------------------------+
void OnTick()
{
   // Manage existing trades on every tick
   ManagePositions();

   // Only search for new entries on a new candle
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

   //==============================================================
   // RSI DATA
   //
   // IMPORTANT:
   // The array is STATIC.
   // DO NOT use ArraySetAsSeries() here.
   //
   // CopyBuffer() places the oldest requested value at index 0
   // and the newest requested value at index 2.
   //
   // r[0] = older candle
   // r[1] = previous closed candle
   // r[2] = current candle
   //==============================================================
   double r[3];

   if(CopyBuffer(
      g_handle,
      0,
      0,
      3,
      r
   ) != 3)
   {
      return;
   }

   //==============================================================
   // PRICE DATA
   //
   // Static array.
   // DO NOT use ArraySetAsSeries().
   //
   // a[0] = older candle
   // a[1] = previous closed candle
   // a[2] = current candle
   //==============================================================
   MqlRates a[3];

   if(CopyRates(
      _Symbol,
      _Period,
      0,
      3,
      a
   ) != 3)
   {
      return;
   }

   //==============================================================
   // MARKET TICK
   //==============================================================
   MqlTick t;

   if(!SymbolInfoTick(_Symbol, t))
      return;

   int digits =
      (int)SymbolInfoInteger(
         _Symbol,
         SYMBOL_DIGITS
      );

   //==============================================================
   // BUY CONDITION
   //
   // RSI moves back below 70:
   // previous value > 70
   // current closed value <= 70
   //
   // Previous closed candle must be bullish.
   //==============================================================
   if(
      r[0] <= 70 &&
      r[1] > 70 &&
      a[1].close > a[1].open
   )
   {
      double sl =
         NormalizeDouble(
            t.ask - InpStopLoss * _Point,
            digits
         );

      double tp =
         NormalizeDouble(
            t.ask + InpTakeProfit * _Point,
            digits
         );

      if(!trade.Buy(
         InpLotSize,
         _Symbol,
         t.ask,
         sl,
         tp,
         "EA-111 BUY"
      ))
      {
         PrintFormat(
            "Buy failed. Retcode=%u",
            trade.ResultRetcode()
         );
      }
   }

   //==============================================================
   // SELL CONDITION
   //
   // RSI moves back above 30:
   // previous value < 30
   // current closed value >= 30
   //
   // Previous closed candle must be bearish.
   //==============================================================
   else if(
      r[0] >= 30 &&
      r[1] < 30 &&
      a[1].close < a[1].open
   )
   {
      double sl =
         NormalizeDouble(
            t.bid + InpStopLoss * _Point,
            digits
         );

      double tp =
         NormalizeDouble(
            t.bid - InpTakeProfit * _Point,
            digits
         );

      if(!trade.Sell(
         InpLotSize,
         _Symbol,
         t.bid,
         sl,
         tp,
         "EA-111 SELL"
      ))
      {
         PrintFormat(
            "Sell failed. Retcode=%u",
            trade.ResultRetcode()
         );
      }
   }
}

