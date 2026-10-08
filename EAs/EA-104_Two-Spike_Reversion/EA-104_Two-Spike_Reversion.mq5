
#property strict

#include <Trade\Trade.mqh>

CTrade trade;

//====================================================
// INPUTS
//====================================================
input double InpLotSize       = 0.01;
input int    InpStopLoss      = 300;
input int    InpTakeProfit    = 600;
input ulong  InpMagicNumber   = 123459;
input int    InpSlippage      = 10;

input group "Break Even & Trailing Stop"
input bool InpUseBreakEven       = true;
input int  InpBreakEvenStart     = 150;
input int  InpBreakEvenOffset    = 0;

input bool InpUseTrailingStop    = true;
input int  InpTrailingStart      = 200;
input int  InpTrailingDistance   = 200;

input int InpMaxSpreadPoints = 30;

input group "Two Spike Reversion"
input int    InpATRPeriod          = 14;
input double InpSpikeATRMultiplier = 1.5;

//====================================================
// GLOBAL VARIABLES
//====================================================
datetime g_lastBarTime = 0;
int      g_atrHandle   = INVALID_HANDLE;

//====================================================
// CHECK NEW BAR
//====================================================
bool IsNewBar()
{
   datetime currentBarTime = iTime(
      _Symbol,
      _Period,
      0
   );

   if(currentBarTime == 0)
      return false;

   if(currentBarTime == g_lastBarTime)
      return false;

   g_lastBarTime = currentBarTime;

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
// SPREAD CHECK
//====================================================
bool SpreadOK()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   double spreadPoints =
      (tick.ask - tick.bid) / _Point;

   if(spreadPoints > InpMaxSpreadPoints)
      return false;

   return true;
}

//====================================================
// CHECK EXISTING POSITION
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

      string symbol =
         PositionGetString(POSITION_SYMBOL);

      ulong magic =
         (ulong)PositionGetInteger(
            POSITION_MAGIC
         );

      if(symbol == _Symbol &&
         magic == InpMagicNumber)
      {
         return true;
      }
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
         SYMBOL_DIGITS
      );

   return NormalizeDouble(
      price,
      digits
   );
}

//====================================================
// VALIDATE SL / TP
//====================================================
bool StopsValid(
   ENUM_ORDER_TYPE orderType,
   double sl,
   double tp
)
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   long stopsLevel =
      SymbolInfoInteger(
         _Symbol,
         SYMBOL_TRADE_STOPS_LEVEL
      );

   double minDistance =
      (double)stopsLevel * _Point;

   if(orderType == ORDER_TYPE_BUY)
   {
      if((tick.bid - sl) < minDistance)
         return false;

      if((tp - tick.bid) < minDistance)
         return false;
   }
   else
   if(orderType == ORDER_TYPE_SELL)
   {
      if((sl - tick.ask) < minDistance)
         return false;

      if((tick.ask - tp) < minDistance)
         return false;
   }

   return true;
}

//====================================================
// MANAGE OPEN POSITION
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
      {
         continue;
      }

      if((ulong)PositionGetInteger(
            POSITION_MAGIC)
         != InpMagicNumber)
      {
         continue;
      }

      ENUM_POSITION_TYPE positionType =
         (ENUM_POSITION_TYPE)
         PositionGetInteger(
            POSITION_TYPE
         );

      double openPrice =
         PositionGetDouble(
            POSITION_PRICE_OPEN
         );

      double currentPrice = 0.0;

      if(positionType == POSITION_TYPE_BUY)
      {
         currentPrice =
            SymbolInfoDouble(
               _Symbol,
               SYMBOL_BID
            );
      }
      else
      if(positionType == POSITION_TYPE_SELL)
      {
         currentPrice =
            SymbolInfoDouble(
               _Symbol,
               SYMBOL_ASK
            );
      }

      double currentSL =
         PositionGetDouble(
            POSITION_SL
         );

      double currentTP =
         PositionGetDouble(
            POSITION_TP
         );

      double profitPoints = 0.0;

      if(positionType == POSITION_TYPE_BUY)
      {
         profitPoints =
            (currentPrice - openPrice)
            / _Point;
      }
      else
      if(positionType == POSITION_TYPE_SELL)
      {
         profitPoints =
            (openPrice - currentPrice)
            / _Point;
      }

      double newSL = currentSL;
      bool modifySL = false;

      //================================================
      // BREAK EVEN
      //================================================
      if(InpUseBreakEven &&
         profitPoints >= InpBreakEvenStart)
      {
         double breakEvenPrice = 0.0;

         if(positionType == POSITION_TYPE_BUY)
         {
            breakEvenPrice =
               openPrice +
               InpBreakEvenOffset * _Point;
         }
         else
         if(positionType == POSITION_TYPE_SELL)
         {
            breakEvenPrice =
               openPrice -
               InpBreakEvenOffset * _Point;
         }

         breakEvenPrice =
            NormalizePrice(
               breakEvenPrice
            );

         if(positionType == POSITION_TYPE_BUY)
         {
            if(currentSL == 0.0 ||
               breakEvenPrice > currentSL)
            {
               newSL = breakEvenPrice;
               modifySL = true;
            }
         }
         else
         if(positionType == POSITION_TYPE_SELL)
         {
            if(currentSL == 0.0 ||
               breakEvenPrice < currentSL)
            {
               newSL = breakEvenPrice;
               modifySL = true;
            }
         }
      }

      //================================================
      // TRAILING STOP
      //================================================
      if(InpUseTrailingStop &&
         profitPoints >= InpTrailingStart)
      {
         double trailingSL = 0.0;

         if(positionType == POSITION_TYPE_BUY)
         {
            trailingSL =
               currentPrice -
               InpTrailingDistance * _Point;
         }
         else
         if(positionType == POSITION_TYPE_SELL)
         {
            trailingSL =
               currentPrice +
               InpTrailingDistance * _Point;
         }

         trailingSL =
            NormalizePrice(
               trailingSL
            );

         if(positionType == POSITION_TYPE_BUY)
         {
            if(newSL == 0.0 ||
               trailingSL > newSL)
            {
               newSL = trailingSL;
               modifySL = true;
            }
         }
         else
         if(positionType == POSITION_TYPE_SELL)
         {
            if(newSL == 0.0 ||
               trailingSL < newSL)
            {
               newSL = trailingSL;
               modifySL = true;
            }
         }
      }

      //================================================
      // MODIFY SL
      //================================================
      if(modifySL)
      {
         bool validSL = false;

         if(positionType == POSITION_TYPE_BUY)
         {
            if(newSL < currentPrice)
               validSL = true;
         }
         else
         if(positionType == POSITION_TYPE_SELL)
         {
            if(newSL > currentPrice)
               validSL = true;
         }

         if(validSL)
         {
            if(!trade.PositionModify(
                  ticket,
                  newSL,
                  currentTP
               ))
            {
               Print(
                  "EA-104 PositionModify failed. ",
                  "Ticket=",
                  ticket,
                  " Retcode=",
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
         tp
      ))
   {
      Print(
         "EA-104 BUY: invalid SL/TP."
      );

      return false;
   }

   bool result =
      trade.Buy(
         InpLotSize,
         _Symbol,
         0.0,
         sl,
         tp,
         "EA-104 BUY"
      );

   if(!result)
   {
      Print(
         "EA-104 BUY failed. ",
         "Retcode=",
         trade.ResultRetcode(),
         " ",
         trade.ResultRetcodeDescription()
      );

      return false;
   }

   Print(
      "EA-104 BUY opened. ",
      "Price=",
      DoubleToString(
         tick.ask,
         _Digits
      ),
      " SL=",
      DoubleToString(
         sl,
         _Digits
      ),
      " TP=",
      DoubleToString(
         tp,
         _Digits
      )
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
         tp
      ))
   {
      Print(
         "EA-104 SELL: invalid SL/TP."
      );

      return false;
   }

   bool result =
      trade.Sell(
         InpLotSize,
         _Symbol,
         0.0,
         sl,
         tp,
         "EA-104 SELL"
      );

   if(!result)
   {
      Print(
         "EA-104 SELL failed. ",
         "Retcode=",
         trade.ResultRetcode(),
         " ",
         trade.ResultRetcodeDescription()
      );

      return false;
   }

   Print(
      "EA-104 SELL opened. ",
      "Price=",
      DoubleToString(
         tick.bid,
         _Digits
      ),
      " SL=",
      DoubleToString(
         sl,
         _Digits
      ),
      " TP=",
      DoubleToString(
         tp,
         _Digits
      )
   );

   return true;
}

//====================================================
// ON INIT
//====================================================
int OnInit()
{
   trade.SetExpertMagicNumber(
      InpMagicNumber
   );

   trade.SetDeviationInPoints(
      InpSlippage
   );

   g_atrHandle =
      iATR(
         _Symbol,
         _Period,
         InpATRPeriod
      );

   if(g_atrHandle == INVALID_HANDLE)
   {
      Print(
         "EA-104: Failed to create ATR handle."
      );

      return INIT_FAILED;
   }

   return INIT_SUCCEEDED;
}

//====================================================
// ON DEINIT
//====================================================
void OnDeinit(
   const int reason
)
{
   if(g_atrHandle != INVALID_HANDLE)
   {
      IndicatorRelease(
         g_atrHandle
      );

      g_atrHandle =
         INVALID_HANDLE;
   }
}

//====================================================
// ON TICK
//====================================================
void OnTick()
{
   //==================================================
   // MANAGE EXISTING POSITION
   //==================================================
   ManagePosition();

   //==================================================
   // BASIC CHECKS
   //==================================================
   if(!TradingAllowed())
      return;

   //==================================================
   // ENTRY ONLY ON NEW BAR
   //==================================================
   if(!IsNewBar())
      return;

   //==================================================
   // ONLY ONE POSITION
   //==================================================
   if(HasOpenPosition())
      return;

   //==================================================
   // SPREAD
   //==================================================
   if(!SpreadOK())
      return;

   //==================================================
   // ATR DATA
   //
   // Dynamic array is intentional.
   // This avoids the MQL5 warning caused by
   // ArraySetAsSeries() on static arrays.
   //==================================================
   double atr[];

   ArraySetAsSeries(
      atr,
      true
   );

   int copiedATR =
      CopyBuffer(
         g_atrHandle,
         0,
         0,
         4,
         atr
      );

   if(copiedATR < 4)
   {
      Print(
         "EA-104: ATR data unavailable. ",
         "Copied=",
         copiedATR
      );

      return;
   }

   //==================================================
   // PRICE DATA
   //
   // Dynamic array is intentional.
   //==================================================
   MqlRates rates[];

   ArraySetAsSeries(
      rates,
      true
   );

   int copiedRates =
      CopyRates(
         _Symbol,
         _Period,
         0,
         4,
         rates
      );

   if(copiedRates < 4)
   {
      Print(
         "EA-104: Price data unavailable. ",
         "Copied=",
         copiedRates
      );

      return;
   }

   //==================================================
   // INDEX STRUCTURE
   //
   // rates[0] = current forming candle
   // rates[1] = latest completed candle
   // rates[2] = previous completed candle
   // rates[3] = candle before that
   //
   // atr[0] = current ATR
   // atr[1] = ATR of latest completed candle
   // atr[2] = previous ATR
   // atr[3] = ATR before that
   //==================================================

   //==================================================
   // CANDLE RANGES
   //==================================================
   double range2 =
      rates[2].high -
      rates[2].low;

   double range3 =
      rates[3].high -
      rates[3].low;

   if(range2 <= 0.0 ||
      range3 <= 0.0)
   {
      return;
   }

   //==================================================
   // TWO BULLISH SPIKES
   //==================================================
   bool spikeUp2 =
      rates[2].close >
      rates[2].open &&
      range2 >=
      atr[2] *
      InpSpikeATRMultiplier;

   bool spikeUp3 =
      rates[3].close >
      rates[3].open &&
      range3 >=
      atr[3] *
      InpSpikeATRMultiplier;

   //==================================================
   // TWO BEARISH SPIKES
   //==================================================
   bool spikeDown2 =
      rates[2].close <
      rates[2].open &&
      range2 >=
      atr[2] *
      InpSpikeATRMultiplier;

   bool spikeDown3 =
      rates[3].close <
      rates[3].open &&
      range3 >=
      atr[3] *
      InpSpikeATRMultiplier;

   //==================================================
   // REVERSAL CANDLE
   //
   // rates[1] is fully closed.
   //==================================================
   bool bullishReversal =
      rates[1].close >
      rates[1].open;

   bool bearishReversal =
      rates[1].close <
      rates[1].open;

   //==================================================
   // SELL SIGNAL
   //
   // Candle 3 = bullish spike
   // Candle 2 = bullish spike
   // Candle 1 = bearish reversal
   //
   // Price starts reverting downward.
   //==================================================
   bool sellSignal =
      spikeUp3 &&
      spikeUp2 &&
      bearishReversal &&
      rates[1].close <
      rates[2].close;

   //==================================================
   // BUY SIGNAL
   //
   // Candle 3 = bearish spike
   // Candle 2 = bearish spike
   // Candle 1 = bullish reversal
   //
   // Price starts reverting upward.
   //==================================================
   bool buySignal =
      spikeDown3 &&
      spikeDown2 &&
      bullishReversal &&
      rates[1].close >
      rates[2].close;

   //==================================================
   // DEBUG INFORMATION
   //
   // Only print when a setup exists.
   //==================================================
   if(spikeUp3 && spikeUp2)
   {
      Print(
         "EA-104: Two bullish spikes detected. ",
         "Reversal=",
         bearishReversal ? "YES" : "NO"
      );
   }

   if(spikeDown3 && spikeDown2)
   {
      Print(
         "EA-104: Two bearish spikes detected. ",
         "Reversal=",
         bullishReversal ? "YES" : "NO"
      );
   }

   //==================================================
   // EXECUTE BUY
   //==================================================
   if(buySignal)
   {
      Print(
         "EA-104: BUY signal confirmed."
      );

      OpenBuy();

      return;
   }

   //==================================================
   // EXECUTE SELL
   //==================================================
   if(sellSignal)
   {
      Print(
         "EA-104: SELL signal confirmed."
      );

      OpenSell();

      return;
   }
}

