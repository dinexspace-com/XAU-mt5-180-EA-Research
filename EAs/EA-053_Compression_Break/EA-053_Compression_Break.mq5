//+------------------------------------------------------------------+
//|                                         RangeCompressionBreak.mq5 |
//|                       Range Compression Breakout Expert Advisor   |
//+------------------------------------------------------------------+
#property strict
#property version   "1.00"

#include <Trade\Trade.mqh>

CTrade trade;

//--- Trading inputs
input double InpLotSize       = 0.01;
input int    InpStopLoss      = 300;
input int    InpTakeProfit    = 600;
input ulong  InpMagicNumber   = 123456;
input int    InpSlippage      = 10;

//--- Strategy inputs
input int    InpCompressionBars       = 4;
input double InpMinRangeDecreasePct   = 0.0;
input int    InpMaxSpread             = 30;

//--- Break Even
input group "Break Even"
input bool   InpUseBreakEven          = true;
input int    InpBreakEvenTrigger      = 150;
input int    InpBreakEvenLock         = 0;

//--- Trailing Stop
input group "Trailing Stop"
input bool   InpUseTrailingStop       = true;
input int    InpTrailingStart         = 200;
input int    InpTrailingDistance      = 150;
input int    InpTrailingStep          = 10;

//--- Global variables
datetime g_lastBarTime = 0;

//+------------------------------------------------------------------+
//| Check whether trading environment is available                   |
//+------------------------------------------------------------------+
bool IsTradingAllowed()
{
   if(!TerminalInfoInteger(TERMINAL_CONNECTED))
      return false;

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return false;

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return false;

   if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Normalize trading volume                                         |
//+------------------------------------------------------------------+
double NormalizeVolume(const double requested_volume)
{
   double min_volume = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double max_volume = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   double volume_step = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);

   if(volume_step <= 0.0)
      return 0.0;

   double volume = requested_volume;

   if(volume < min_volume)
      volume = min_volume;

   if(volume > max_volume)
      volume = max_volume;

   volume = MathFloor(volume / volume_step + 0.0000001) * volume_step;

   int volume_digits = 0;
   double step_check = volume_step;

   while(step_check < 1.0 && volume_digits < 8)
   {
      step_check *= 10.0;
      volume_digits++;
   }

   return NormalizeDouble(volume, volume_digits);
}

//+------------------------------------------------------------------+
//| Normalize price                                                  |
//+------------------------------------------------------------------+
double NormalizePrice(const double price)
{
   return NormalizeDouble(price, (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS));
}

//+------------------------------------------------------------------+
//| Check new bar                                                    |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime current_bar_time = iTime(_Symbol, _Period, 0);

   if(current_bar_time <= 0)
      return false;

   if(g_lastBarTime == 0)
   {
      g_lastBarTime = current_bar_time;
      return false;
   }

   if(current_bar_time != g_lastBarTime)
   {
      g_lastBarTime = current_bar_time;
      return true;
   }

   return false;
}

//+------------------------------------------------------------------+
//| Count positions belonging to this EA                             |
//+------------------------------------------------------------------+
int CountEAOpenPositions()
{
   int count = 0;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      ulong magic = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(magic == InpMagicNumber)
         count++;
   }

   return count;
}

//+------------------------------------------------------------------+
//| Check current spread                                             |
//+------------------------------------------------------------------+
bool IsSpreadAcceptable()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   if(tick.ask <= 0.0 || tick.bid <= 0.0)
      return false;

   double spread_points = (tick.ask - tick.bid) / _Point;

   return (spread_points <= (double)InpMaxSpread);
}

//+------------------------------------------------------------------+
//| Validate compression pattern                                     |
//|                                                                  |
//| Bars used:                                                       |
//| shift 2 = newest compression bar                                 |
//| shift 3 = previous                                               |
//| ...                                                              |
//| Oldest candle must have larger range, with ranges shrinking      |
//| toward the breakout candle.                                      |
//+------------------------------------------------------------------+
bool IsRangeCompression()
{
   if(InpCompressionBars < 2)
      return false;

   int required_bars = InpCompressionBars + 3;

   if(Bars(_Symbol, _Period) < required_bars)
      return false;

   // Example with 4 compression bars:
   // shift 5 -> oldest/largest
   // shift 4
   // shift 3
   // shift 2 -> newest/smallest
   for(int shift = InpCompressionBars + 1; shift >= 3; shift--)
   {
      double older_high = iHigh(_Symbol, _Period, shift);
      double older_low  = iLow(_Symbol, _Period, shift);

      double newer_high = iHigh(_Symbol, _Period, shift - 1);
      double newer_low  = iLow(_Symbol, _Period, shift - 1);

      double older_range = older_high - older_low;
      double newer_range = newer_high - newer_low;

      if(older_range <= 0.0 || newer_range <= 0.0)
         return false;

      double max_allowed_new_range =
         older_range * (1.0 - InpMinRangeDecreasePct / 100.0);

      if(newer_range >= max_allowed_new_range)
         return false;
   }

   return true;
}

//+------------------------------------------------------------------+
//| Get compression zone                                             |
//| Compression candles are bars shift 2 onward.                     |
//| Bar shift 1 is the completed breakout candle.                    |
//+------------------------------------------------------------------+
bool GetCompressionZone(double &zone_high, double &zone_low)
{
   if(InpCompressionBars < 2)
      return false;

   zone_high = -DBL_MAX;
   zone_low  = DBL_MAX;

   for(int shift = 2; shift <= InpCompressionBars + 1; shift++)
   {
      double bar_high = iHigh(_Symbol, _Period, shift);
      double bar_low  = iLow(_Symbol, _Period, shift);

      if(bar_high <= 0.0 || bar_low <= 0.0)
         return false;

      if(bar_high > zone_high)
         zone_high = bar_high;

      if(bar_low < zone_low)
         zone_low = bar_low;
   }

   if(zone_high <= zone_low)
      return false;

   return true;
}

//+------------------------------------------------------------------+
//| Generate trading signal                                          |
//|  1 = BUY                                                         |
//| -1 = SELL                                                        |
//|  0 = no signal                                                   |
//+------------------------------------------------------------------+
int GetTradeSignal()
{
   if(!IsRangeCompression())
      return 0;

   double zone_high = 0.0;
   double zone_low  = 0.0;

   if(!GetCompressionZone(zone_high, zone_low))
      return 0;

   // Breakout candle = most recently completed candle
   double breakout_open  = iOpen(_Symbol, _Period, 1);
   double breakout_high  = iHigh(_Symbol, _Period, 1);
   double breakout_low   = iLow(_Symbol, _Period, 1);
   double breakout_close = iClose(_Symbol, _Period, 1);

   if(breakout_open <= 0.0 ||
      breakout_high <= 0.0 ||
      breakout_low <= 0.0 ||
      breakout_close <= 0.0)
   {
      return 0;
   }

   // BUY:
   // Candle trades outside upper compression boundary
   // and closes above the compression zone.
   if(breakout_high > zone_high &&
      breakout_close > zone_high &&
      breakout_close > breakout_open)
   {
      return 1;
   }

   // SELL:
   // Candle trades outside lower compression boundary
   // and closes below the compression zone.
   if(breakout_low < zone_low &&
      breakout_close < zone_low &&
      breakout_close < breakout_open)
   {
      return -1;
   }

   return 0;
}

//+------------------------------------------------------------------+
//| Open BUY                                                         |
//+------------------------------------------------------------------+
bool OpenBuy()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   double volume = NormalizeVolume(InpLotSize);

   if(volume <= 0.0)
      return false;

   double sl = 0.0;
   double tp = 0.0;

   if(InpStopLoss > 0)
      sl = NormalizePrice(tick.ask - (double)InpStopLoss * _Point);

   if(InpTakeProfit > 0)
      tp = NormalizePrice(tick.ask + (double)InpTakeProfit * _Point);

   ResetLastError();

   bool result = trade.Buy(
      volume,
      _Symbol,
      0.0,
      sl,
      tp,
      "RangeCompression BUY"
   );

   if(!result)
   {
      Print(
         "BUY failed. Retcode=",
         trade.ResultRetcode(),
         ", Description=",
         trade.ResultRetcodeDescription(),
         ", LastError=",
         GetLastError()
      );

      return false;
   }

   Print(
      "BUY opened. Order=",
      trade.ResultOrder(),
      ", Deal=",
      trade.ResultDeal(),
      ", Price=",
      trade.ResultPrice()
   );

   return true;
}

//+------------------------------------------------------------------+
//| Open SELL                                                        |
//+------------------------------------------------------------------+
bool OpenSell()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return false;

   double volume = NormalizeVolume(InpLotSize);

   if(volume <= 0.0)
      return false;

   double sl = 0.0;
   double tp = 0.0;

   if(InpStopLoss > 0)
      sl = NormalizePrice(tick.bid + (double)InpStopLoss * _Point);

   if(InpTakeProfit > 0)
      tp = NormalizePrice(tick.bid - (double)InpTakeProfit * _Point);

   ResetLastError();

   bool result = trade.Sell(
      volume,
      _Symbol,
      0.0,
      sl,
      tp,
      "RangeCompression SELL"
   );

   if(!result)
   {
      Print(
         "SELL failed. Retcode=",
         trade.ResultRetcode(),
         ", Description=",
         trade.ResultRetcodeDescription(),
         ", LastError=",
         GetLastError()
      );

      return false;
   }

   Print(
      "SELL opened. Order=",
      trade.ResultOrder(),
      ", Deal=",
      trade.ResultDeal(),
      ", Price=",
      trade.ResultPrice()
   );

   return true;
}

//+------------------------------------------------------------------+
//| Check broker minimum stop distance                               |
//+------------------------------------------------------------------+
double GetMinimumStopDistance()
{
   long stops_level = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);

   if(stops_level < 0)
      stops_level = 0;

   return (double)stops_level * _Point;
}

//+------------------------------------------------------------------+
//| Manage Break Even and Trailing Stop                              |
//+------------------------------------------------------------------+
void ManageOpenPositions()
{
   if(!InpUseBreakEven && !InpUseTrailingStop)
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   double minimum_stop_distance = GetMinimumStopDistance();

   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      ulong magic = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol != _Symbol || magic != InpMagicNumber)
         continue;

      ENUM_POSITION_TYPE position_type =
         (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

      double open_price =
         PositionGetDouble(POSITION_PRICE_OPEN);

      double current_sl =
         PositionGetDouble(POSITION_SL);

      double current_tp =
         PositionGetDouble(POSITION_TP);

      double new_sl = current_sl;
      bool need_modify = false;

      //==============================================================
      // BUY position
      //==============================================================
      if(position_type == POSITION_TYPE_BUY)
      {
         double profit_points =
            (tick.bid - open_price) / _Point;

         //--- Break Even
         if(InpUseBreakEven &&
            profit_points >= (double)InpBreakEvenTrigger)
         {
            double be_sl =
               open_price + (double)InpBreakEvenLock * _Point;

            be_sl = NormalizePrice(be_sl);

            if((current_sl == 0.0 || be_sl > current_sl) &&
               (tick.bid - be_sl) >= minimum_stop_distance)
            {
               new_sl = be_sl;
               need_modify = true;
            }
         }

         //--- Trailing Stop
         if(InpUseTrailingStop &&
            profit_points >= (double)InpTrailingStart)
         {
            double trailing_sl =
               tick.bid - (double)InpTrailingDistance * _Point;

            trailing_sl = NormalizePrice(trailing_sl);

            double reference_sl =
               need_modify ? new_sl : current_sl;

            bool trail_is_better =
               (reference_sl == 0.0 ||
                trailing_sl >
                reference_sl + (double)InpTrailingStep * _Point);

            if(trail_is_better &&
               trailing_sl > open_price &&
               (tick.bid - trailing_sl) >= minimum_stop_distance)
            {
               new_sl = trailing_sl;
               need_modify = true;
            }
         }
      }

      //==============================================================
      // SELL position
      //==============================================================
      else if(position_type == POSITION_TYPE_SELL)
      {
         double profit_points =
            (open_price - tick.ask) / _Point;

         //--- Break Even
         if(InpUseBreakEven &&
            profit_points >= (double)InpBreakEvenTrigger)
         {
            double be_sl =
               open_price - (double)InpBreakEvenLock * _Point;

            be_sl = NormalizePrice(be_sl);

            if((current_sl == 0.0 || be_sl < current_sl) &&
               (be_sl - tick.ask) >= minimum_stop_distance)
            {
               new_sl = be_sl;
               need_modify = true;
            }
         }

         //--- Trailing Stop
         if(InpUseTrailingStop &&
            profit_points >= (double)InpTrailingStart)
         {
            double trailing_sl =
               tick.ask + (double)InpTrailingDistance * _Point;

            trailing_sl = NormalizePrice(trailing_sl);

            double reference_sl =
               need_modify ? new_sl : current_sl;

            bool trail_is_better =
               (reference_sl == 0.0 ||
                trailing_sl <
                reference_sl - (double)InpTrailingStep * _Point);

            if(trail_is_better &&
               trailing_sl < open_price &&
               (trailing_sl - tick.ask) >= minimum_stop_distance)
            {
               new_sl = trailing_sl;
               need_modify = true;
            }
         }
      }

      //==============================================================
      // Modify position
      //==============================================================
      if(need_modify)
      {
         new_sl = NormalizePrice(new_sl);

         if(MathAbs(new_sl - current_sl) >= _Point)
         {
            ResetLastError();

            bool modified =
               trade.PositionModify(ticket, new_sl, current_tp);

            if(!modified)
            {
               Print(
                  "PositionModify failed. Ticket=",
                  ticket,
                  ", Retcode=",
                  trade.ResultRetcode(),
                  ", Description=",
                  trade.ResultRetcodeDescription(),
                  ", LastError=",
                  GetLastError()
               );
            }
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Expert initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   if(InpLotSize <= 0.0)
      return INIT_PARAMETERS_INCORRECT;

   if(InpStopLoss < 0 ||
      InpTakeProfit < 0 ||
      InpSlippage < 0 ||
      InpMaxSpread < 0)
   {
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpCompressionBars < 2)
      return INIT_PARAMETERS_INCORRECT;

   if(InpMinRangeDecreasePct < 0.0 ||
      InpMinRangeDecreasePct >= 100.0)
   {
      return INIT_PARAMETERS_INCORRECT;
   }

   if(InpBreakEvenTrigger < 0 ||
      InpBreakEvenLock < 0 ||
      InpTrailingStart < 0 ||
      InpTrailingDistance <= 0 ||
      InpTrailingStep < 0)
   {
      return INIT_PARAMETERS_INCORRECT;
   }

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   trade.SetAsyncMode(false);

   g_lastBarTime = iTime(_Symbol, _Period, 0);

   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   if(reason >= 0)
   {
      // No resources requiring manual release.
   }
}

//+------------------------------------------------------------------+
//| Expert tick                                                      |
//+------------------------------------------------------------------+
void OnTick()
{
   //--- Position management runs on every tick
   ManageOpenPositions();

   //--- Entry logic only once per new candle
   if(!IsNewBar())
      return;

   if(!IsTradingAllowed())
      return;

   if(!IsSpreadAcceptable())
      return;

   //--- Maximum 1 active position for this Magic Number
   if(CountEAOpenPositions() >= 1)
      return;

   int signal = GetTradeSignal();

   if(signal == 1)
      OpenBuy();
   else if(signal == -1)
      OpenSell();
}
//+------------------------------------------------------------------+