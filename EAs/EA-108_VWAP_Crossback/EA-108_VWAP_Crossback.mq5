#property strict

#include <Trade\Trade.mqh>

CTrade trade;

//====================================================
// INPUTS
//====================================================
input double InpLotSize       = 0.01;
input int    InpStopLoss      = 300;
input int    InpTakeProfit    = 600;
input ulong  InpMagicNumber   = 123463;
input int    InpSlippage      = 10;

input group "Break Even & Trailing Stop"

input bool InpUseBreakEven    = true;
input int  InpBreakEvenStart  = 150;
input int  InpBreakEvenOffset = 0;

input bool InpUseTrailingStop = true;
input int  InpTrailingStart   = 200;
input int  InpTrailingDistance= 200;

input int InpMaxSpreadPoints  = 30;

input group "VWAP Crossback"

input int InpRejectionBufferPoints = 0;

//====================================================
// GLOBAL
//====================================================
datetime g_lastBarTime = 0;

//====================================================
// NEW BAR
//====================================================
bool IsNewBar()
{
   datetime currentBar =
      iTime(_Symbol, _Period, 0);

   if(currentBar == 0)
      return false;

   if(currentBar == g_lastBarTime)
      return false;

   g_lastBarTime = currentBar;

   return true;
}

//====================================================
// TRADING PERMISSION
//====================================================
bool TradingAllowed()
{
   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return false;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return false;

   if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
      return false;

   return true;
}

//====================================================
// SPREAD
//====================================================
bool SpreadOK()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   double spread =
      (tick.ask - tick.bid) / _Point;

   return spread <= InpMaxSpreadPoints;
}

//====================================================
// EXISTING POSITION
//====================================================
bool HasOpenPosition()
{
   for(int i = PositionsTotal() - 1;
       i >= 0;
       i--)
   {
      ulong ticket =
         PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      if(PositionGetString(POSITION_SYMBOL)
         != _Symbol)
         continue;

      if((ulong)PositionGetInteger(
            POSITION_MAGIC)
         != InpMagicNumber)
         continue;

      return true;
   }

   return false;
}

//====================================================
// NORMALIZE PRICE
//====================================================
double NormalizePrice(double price)
{
   int digits =
      (int)SymbolInfoInteger(
         _Symbol,
         SYMBOL_DIGITS);

   return NormalizeDouble(
      price,
      digits);
}

//====================================================
// VALIDATE STOPS
//====================================================
bool StopsValid(
   ENUM_ORDER_TYPE type,
   double sl,
   double tp)
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   long stopsLevel =
      SymbolInfoInteger(
         _Symbol,
         SYMBOL_TRADE_STOPS_LEVEL);

   double minDistance =
      (double)stopsLevel * _Point;

   if(type == ORDER_TYPE_BUY)
   {
      if(tick.bid - sl < minDistance)
         return false;

      if(tp - tick.bid < minDistance)
         return false;
   }
   else
   {
      if(sl - tick.ask < minDistance)
         return false;

      if(tick.ask - tp < minDistance)
         return false;
   }

   return true;
}

//====================================================
// POSITION MANAGEMENT
//====================================================
void ManagePosition()
{
   for(int i = PositionsTotal() - 1;
       i >= 0;
       i--)
   {
      ulong ticket =
         PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      if(PositionGetString(POSITION_SYMBOL)
         != _Symbol)
         continue;

      if((ulong)PositionGetInteger(
            POSITION_MAGIC)
         != InpMagicNumber)
         continue;

      ENUM_POSITION_TYPE type =
         (ENUM_POSITION_TYPE)
         PositionGetInteger(
            POSITION_TYPE);

      double openPrice =
         PositionGetDouble(
            POSITION_PRICE_OPEN);

      double currentPrice;

      if(type == POSITION_TYPE_BUY)
      {
         currentPrice =
            SymbolInfoDouble(
               _Symbol,
               SYMBOL_BID);
      }
      else
      {
         currentPrice =
            SymbolInfoDouble(
               _Symbol,
               SYMBOL_ASK);
      }

      double currentSL =
         PositionGetDouble(
            POSITION_SL);

      double currentTP =
         PositionGetDouble(
            POSITION_TP);

      double profitPoints;

      if(type == POSITION_TYPE_BUY)
      {
         profitPoints =
            (currentPrice -
             openPrice) / _Point;
      }
      else
      {
         profitPoints =
            (openPrice -
             currentPrice) / _Point;
      }

      double newSL = currentSL;
      bool modify = false;

      //================================================
      // BREAK EVEN
      //================================================
      if(InpUseBreakEven &&
         profitPoints >=
         InpBreakEvenStart)
      {
         double bePrice;

         if(type == POSITION_TYPE_BUY)
         {
            bePrice =
               openPrice +
               InpBreakEvenOffset *
               _Point;
         }
         else
         {
            bePrice =
               openPrice -
               InpBreakEvenOffset *
               _Point;
         }

         bePrice =
            NormalizePrice(bePrice);

         if(type == POSITION_TYPE_BUY)
         {
            if(currentSL == 0 ||
               bePrice > currentSL)
            {
               newSL = bePrice;
               modify = true;
            }
         }
         else
         {
            if(currentSL == 0 ||
               bePrice < currentSL)
            {
               newSL = bePrice;
               modify = true;
            }
         }
      }

      //================================================
      // TRAILING STOP
      //================================================
      if(InpUseTrailingStop &&
         profitPoints >=
         InpTrailingStart)
      {
         double trailPrice;

         if(type == POSITION_TYPE_BUY)
         {
            trailPrice =
               currentPrice -
               InpTrailingDistance *
               _Point;
         }
         else
         {
            trailPrice =
               currentPrice +
               InpTrailingDistance *
               _Point;
         }

         trailPrice =
            NormalizePrice(trailPrice);

         if(type == POSITION_TYPE_BUY)
         {
            if(newSL == 0 ||
               trailPrice > newSL)
            {
               newSL = trailPrice;
               modify = true;
            }
         }
         else
         {
            if(newSL == 0 ||
               trailPrice < newSL)
            {
               newSL = trailPrice;
               modify = true;
            }
         }
      }

      //================================================
      // MODIFY POSITION
      //================================================
      if(modify)
      {
         bool valid = false;

         if(type == POSITION_TYPE_BUY)
         {
            if(newSL < currentPrice)
               valid = true;
         }
         else
         {
            if(newSL > currentPrice)
               valid = true;
         }

         if(valid)
         {
            if(!trade.PositionModify(
                  ticket,
                  newSL,
                  currentTP))
            {
               Print(
                  "EA-108 PositionModify failed. ",
                  "Retcode=",
                  trade.ResultRetcode(),
                  " ",
                  trade.ResultRetcodeDescription()
               );
            }
         }
      }
   }
}

//====================================================
// OPEN BUY
//====================================================
bool OpenBuy()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   double sl =
      tick.ask -
      InpStopLoss * _Point;

   double tp =
      tick.ask +
      InpTakeProfit * _Point;

   sl = NormalizePrice(sl);
   tp = NormalizePrice(tp);

   if(!StopsValid(
         ORDER_TYPE_BUY,
         sl,
         tp))
   {
      Print(
         "EA-108 BUY: invalid SL/TP."
      );

      return false;
   }

   if(!trade.Buy(
         InpLotSize,
         _Symbol,
         0.0,
         sl,
         tp,
         "EA-108 BUY"))
   {
      Print(
         "EA-108 BUY failed. ",
         "Retcode=",
         trade.ResultRetcode(),
         " ",
         trade.ResultRetcodeDescription()
      );

      return false;
   }

   Print(
      "EA-108 BUY opened."
   );

   return true;
}

//====================================================
// OPEN SELL
//====================================================
bool OpenSell()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   double sl =
      tick.bid +
      InpStopLoss * _Point;

   double tp =
      tick.bid -
      InpTakeProfit * _Point;

   sl = NormalizePrice(sl);
   tp = NormalizePrice(tp);

   if(!StopsValid(
         ORDER_TYPE_SELL,
         sl,
         tp))
   {
      Print(
         "EA-108 SELL: invalid SL/TP."
      );

      return false;
   }

   if(!trade.Sell(
         InpLotSize,
         _Symbol,
         0.0,
         sl,
         tp,
         "EA-108 SELL"))
   {
      Print(
         "EA-108 SELL failed. ",
         "Retcode=",
         trade.ResultRetcode(),
         " ",
         trade.ResultRetcodeDescription()
      );

      return false;
   }

   Print(
      "EA-108 SELL opened."
   );

   return true;
}

//====================================================
// VWAP AT SPECIFIC TIME
//
// VWAP được tính từ đầu ngày đến targetTime.
// Dùng dữ liệu M1 để VWAP ổn định hơn khi EA chạy
// trên M1/M5/M15...
//====================================================
double VWAPAt(datetime targetTime)
{
   MqlDateTime dt;

   if(!TimeToStruct(
         targetTime,
         dt))
      return 0.0;

   dt.hour = 0;
   dt.min  = 0;
   dt.sec  = 0;

   datetime dayStart =
      StructToTime(dt);

   MqlRates rates[];

   int copied =
      CopyRates(
         _Symbol,
         PERIOD_M1,
         dayStart,
         targetTime,
         rates);

   if(copied <= 0)
      return 0.0;

   double priceVolume = 0.0;
   double totalVolume = 0.0;

   for(int i = 0;
       i < copied;
       i++)
   {
      if(rates[i].time >
         targetTime)
         continue;

      double volume =
         (double)rates[i].tick_volume;

      if(volume <= 0.0)
         volume = 1.0;

      double typicalPrice =
         (rates[i].high +
          rates[i].low +
          rates[i].close) / 3.0;

      priceVolume +=
         typicalPrice * volume;

      totalVolume += volume;
   }

   if(totalVolume <= 0.0)
      return 0.0;

   return priceVolume /
          totalVolume;
}

//====================================================
// INIT
//====================================================
int OnInit()
{
   trade.SetExpertMagicNumber(
      InpMagicNumber);

   trade.SetDeviationInPoints(
      InpSlippage);

   return INIT_SUCCEEDED;
}

//====================================================
// DEINIT
//====================================================
void OnDeinit(const int reason)
{
}

//====================================================
// ON TICK
//====================================================
void OnTick()
{
   // Manage open position on every tick
   ManagePosition();

   if(!TradingAllowed())
      return;

   // Entry once per new bar
   if(!IsNewBar())
      return;

   // Only one open position for this
   // symbol + Magic Number
   if(HasOpenPosition())
      return;

   if(!SpreadOK())
      return;

   //==================================================
   // CLOSED CANDLES
   //==================================================
   datetime time1 =
      iTime(_Symbol, _Period, 1);

   datetime time2 =
      iTime(_Symbol, _Period, 2);

   if(time1 == 0 ||
      time2 == 0)
      return;

   //==================================================
   // VWAP FOR EACH HISTORICAL CANDLE
   //==================================================
   double vwap1 =
      VWAPAt(time1);

   double vwap2 =
      VWAPAt(time2);

   if(vwap1 <= 0.0 ||
      vwap2 <= 0.0)
      return;

   //==================================================
   // CANDLE 1
   //==================================================
   double open1 =
      iOpen(_Symbol, _Period, 1);

   double close1 =
      iClose(_Symbol, _Period, 1);

   double high1 =
      iHigh(_Symbol, _Period, 1);

   double low1 =
      iLow(_Symbol, _Period, 1);

   //==================================================
   // CANDLE 2
   //==================================================
   double close2 =
      iClose(_Symbol, _Period, 2);

   double open2 =
      iOpen(_Symbol, _Period, 2);

   //==================================================
   // REJECTION BUFFER
   //==================================================
   double buffer =
      InpRejectionBufferPoints *
      _Point;

   //==================================================
   // BUY LOGIC
   //
   // Candle 2:
   //   Close below VWAP
   //
   // Candle 1:
   //   Low reaches/touches VWAP
   //   but closes back below VWAP
   //   and closes bullish
   //
   // => BUY toward VWAP
   //==================================================
   bool buySignal =
      close2 < vwap2 &&
      low1 <= vwap1 + buffer &&
      close1 < vwap1 &&
      close1 > open1;

   //==================================================
   // SELL LOGIC
   //
   // Candle 2:
   //   Close above VWAP
   //
   // Candle 1:
   //   High reaches/touches VWAP
   //   but closes back above VWAP
   //   and closes bearish
   //
   // => SELL toward VWAP
   //==================================================
   bool sellSignal =
      close2 > vwap2 &&
      high1 >= vwap1 - buffer &&
      close1 > vwap1 &&
      close1 < open1;

   //==================================================
   // EXECUTION
   //==================================================
   if(buySignal)
   {
      Print(
         "EA-108 BUY signal. ",
         "Close1=",
         DoubleToString(close1, _Digits),
         " VWAP1=",
         DoubleToString(vwap1, _Digits)
      );

      OpenBuy();
   }
   else
   if(sellSignal)
   {
      Print(
         "EA-108 SELL signal. ",
         "Close1=",
         DoubleToString(close1, _Digits),
         " VWAP1=",
         DoubleToString(vwap1, _Digits)
      );

      OpenSell();
   }
}