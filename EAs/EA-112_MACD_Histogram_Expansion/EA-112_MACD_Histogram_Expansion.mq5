
#property strict
#property version "1.01"

#include <Trade\Trade.mqh>

CTrade trade;

//+------------------------------------------------------------------+
//| INPUT PARAMETERS                                                 |
//+------------------------------------------------------------------+
input double InpLotSize            = 0.01;
input int    InpStopLoss           = 300;
input int    InpTakeProfit         = 600;
input ulong  InpMagicNumber        = 112001;
input int    InpSlippage           = 10;

input bool   InpUseBreakEven       = true;
input int    InpBreakEvenStart     = 150;
input int    InpBreakEvenOffset    = 0;

input bool   InpUseTrailingStop    = true;
input int    InpTrailingStart      = 200;
input int    InpTrailingDistance   = 200;

input int    InpMaxSpread          = 30;

input int    InpFastEMA             = 12;
input int    InpSlowEMA             = 26;
input int    InpSignalPeriod        = 9;

//+------------------------------------------------------------------+
//| GLOBAL VARIABLES                                                 |
//+------------------------------------------------------------------+
int      h        = INVALID_HANDLE;
datetime lastbar  = 0;

//+------------------------------------------------------------------+
//| EXPERT INITIALIZATION                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   h = iMACD(
      _Symbol,
      _Period,
      InpFastEMA,
      InpSlowEMA,
      InpSignalPeriod,
      PRICE_CLOSE
   );

   if(h == INVALID_HANDLE)
      return INIT_FAILED;

   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| EXPERT DEINITIALIZATION                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int r)
{
   if(h != INVALID_HANDLE)
      IndicatorRelease(h);
}

//+------------------------------------------------------------------+
//| CHECK NEW BAR                                                    |
//+------------------------------------------------------------------+
bool NewBar()
{
   datetime t = iTime(
      _Symbol,
      _Period,
      0
   );

   if(t == 0 || t == lastbar)
      return false;

   lastbar = t;

   return true;
}

//+------------------------------------------------------------------+
//| CHECK EXISTING POSITION                                          |
//+------------------------------------------------------------------+
bool HasPosition()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong x = PositionGetTicket(i);

      if(
         x &&
         PositionGetString(POSITION_SYMBOL) == _Symbol &&
         (ulong)PositionGetInteger(POSITION_MAGIC) == InpMagicNumber
      )
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

   double spread =
      (t.ask - t.bid) / _Point;

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

   int d =
      (int)SymbolInfoInteger(
         _Symbol,
         SYMBOL_DIGITS
      );

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong x = PositionGetTicket(i);

      if(!x)
         continue;

      if(
         PositionGetString(POSITION_SYMBOL) != _Symbol ||
         (ulong)PositionGetInteger(POSITION_MAGIC) != InpMagicNumber
      )
      {
         continue;
      }

      ENUM_POSITION_TYPE ty =
         (ENUM_POSITION_TYPE)PositionGetInteger(
            POSITION_TYPE
         );

      double o =
         PositionGetDouble(
            POSITION_PRICE_OPEN
         );

      double s =
         PositionGetDouble(
            POSITION_SL
         );

      double tp =
         PositionGetDouble(
            POSITION_TP
         );

      double p =
         ty == POSITION_TYPE_BUY
         ? t.bid
         : t.ask;

      double pr =
         ty == POSITION_TYPE_BUY
         ? (p - o) / _Point
         : (o - p) / _Point;

      double ns = s;

      //==============================================================
      // BREAK EVEN
      //==============================================================
      if(
         InpUseBreakEven &&
         pr >= InpBreakEvenStart
      )
      {
         double b =
            ty == POSITION_TYPE_BUY
            ? o + InpBreakEvenOffset * _Point
            : o - InpBreakEvenOffset * _Point;

         if(
            ty == POSITION_TYPE_BUY
            ? (ns == 0 || b > ns)
            : (ns == 0 || b < ns)
         )
         {
            ns = b;
         }
      }

      //==============================================================
      // TRAILING STOP
      //==============================================================
      if(
         InpUseTrailingStop &&
         pr >= InpTrailingStart
      )
      {
         double tr =
            ty == POSITION_TYPE_BUY
            ? p - InpTrailingDistance * _Point
            : p + InpTrailingDistance * _Point;

         if(
            ty == POSITION_TYPE_BUY
            ? (ns == 0 || tr > ns)
            : (ns == 0 || tr < ns)
         )
         {
            ns = tr;
         }
      }

      ns =
         NormalizeDouble(
            ns,
            d
         );

      if(
         ns > 0 &&
         MathAbs(ns - s) >= _Point
      )
      {
         if(!trade.PositionModify(
            x,
            ns,
            tp
         ))
         {
            PrintFormat(
               "PositionModify failed. Ticket=%I64u Retcode=%u",
               x,
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
   // Manage existing positions on every tick
   ManagePositions();

   // Only process entry logic on a new candle
   if(!NewBar())
      return;

   // Trading permission
   if(!TerminalInfoInteger(
      TERMINAL_TRADE_ALLOWED
   ))
   {
      return;
   }

   if(!MQLInfoInteger(
      MQL_TRADE_ALLOWED
   ))
   {
      return;
   }

   // Only one position
   if(HasPosition())
      return;

   // Spread filter
   if(!SpreadOK())
      return;

   //==============================================================
   // MACD DATA
   //
   // IMPORTANT:
   // m[] and s[] are STATIC ARRAYS.
   //
   // Therefore ArraySetAsSeries() MUST NOT be used.
   //
   // CopyBuffer() stores the requested values in chronological
   // order for a static array:
   //
   // m[0] = oldest requested value
   // m[1] = next value
   // m[2] = next value
   // m[3] = newest value
   //
   // For CopyBuffer(..., 0, 0, 4, m):
   //
   // m[3] = current candle      (bar 0)
   // m[2] = previous candle     (bar 1)
   // m[1] = candle before that  (bar 2)
   // m[0] = candle before that  (bar 3)
   //
   // The original EA used:
   //
   // a = histogram bar 1
   // b = histogram bar 2
   // c = histogram bar 3
   //
   // Therefore we use:
   //
   // a = m[2] - s[2]
   // b = m[1] - s[1]
   // c = m[0] - s[0]
   //
   // This preserves the original strategy logic.
   //==============================================================

   double m[4];
   double s[4];

   if(
      CopyBuffer(
         h,
         0,
         0,
         4,
         m
      ) != 4
   )
   {
      return;
   }

   if(
      CopyBuffer(
         h,
         1,
         0,
         4,
         s
      ) != 4
   )
   {
      return;
   }

   //==============================================================
   // MACD HISTOGRAM
   //==============================================================

   double a =
      m[2] - s[2];

   double b =
      m[1] - s[1];

   double c =
      m[0] - s[0];

   //==============================================================
   // CURRENT MARKET TICK
   //==============================================================

   MqlTick t;

   if(!SymbolInfoTick(
      _Symbol,
      t
   ))
   {
      return;
   }

   int d =
      (int)SymbolInfoInteger(
         _Symbol,
         SYMBOL_DIGITS
      );

   //==============================================================
   // BUY CONDITION
   //
   // Histogram is:
   //
   // a > 0
   // a > b
   // b > c
   //
   // This means positive histogram expansion.
   //==============================================================

   if(
      a > 0 &&
      a > b &&
      b > c
   )
   {
      double sl =
         NormalizeDouble(
            t.ask - InpStopLoss * _Point,
            d
         );

      double tp =
         NormalizeDouble(
            t.ask + InpTakeProfit * _Point,
            d
         );

      if(!trade.Buy(
         InpLotSize,
         _Symbol,
         t.ask,
         sl,
         tp,
         "EA-112 BUY"
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
   // Histogram is:
   //
   // a < 0
   // a < b
   // b < c
   //
   // This means negative histogram expansion.
   //==============================================================

   else if(
      a < 0 &&
      a < b &&
      b < c
   )
   {
      double sl =
         NormalizeDouble(
            t.bid + InpStopLoss * _Point,
            d
         );

      double tp =
         NormalizeDouble(
            t.bid - InpTakeProfit * _Point,
            d
         );

      if(!trade.Sell(
         InpLotSize,
         _Symbol,
         t.bid,
         sl,
         tp,
         "EA-112 SELL"
      ))
      {
         PrintFormat(
            "Sell failed. Retcode=%u",
            trade.ResultRetcode()
         );
      }
   }
}

