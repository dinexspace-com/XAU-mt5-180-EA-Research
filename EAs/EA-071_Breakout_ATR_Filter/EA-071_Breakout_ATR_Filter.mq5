
#property strict
#property version "1.00"
#property description "EA-071 Breakout_ATR_Filter"
#include <Trade\Trade.mqh>

input group "Execution - column F defaults"
input double InpLotSize = 0.01;
input int InpStopLoss = 300;
input int InpTakeProfit = 600;
input ulong InpMagicNumber = 123071;
input int InpSlippage = 10;
input int InpMaxSpread = 30;
input ENUM_TIMEFRAMES InpTimeframe = PERIOD_M1;
input int InpBreakoutLookback = 20;
input int InpBreakoutBuffer = 0;

input group "Break Even"
input bool InpUseBreakEven = true;
input int InpBreakEvenTrigger = 150;
input int InpBreakEvenOffset = 0;

input group "Trailing Stop"
input bool InpUseTrailingStop = true;
input int InpTrailingStart = 200;
input int InpTrailingDistance = 100;
input int InpTrailingStep = 10;

input int InpATRPeriod=14; input int InpATRMeanPeriod=20;

CTrade trade;
datetime last_bar = 0;
double point_size = 0.0;
double tick_size = 0.0;
int price_digits = 0;
int indicator_handle = INVALID_HANDLE;


double RoundDown(const double price)
{
   return NormalizeDouble(MathFloor(price/tick_size+1e-8)*tick_size,price_digits);
}

double RoundUp(const double price)
{
   return NormalizeDouble(MathCeil(price/tick_size-1e-8)*tick_size,price_digits);
}

bool ReadIndicator(const int shift,double &value)
{
   double buffer[1];
   if(indicator_handle==INVALID_HANDLE || BarsCalculated(indicator_handle)<=shift)
      return false;
   if(CopyBuffer(indicator_handle,0,shift,1,buffer)!=1)
      return false;
   value=buffer[0];
   return MathIsValidNumber(value) && value!=EMPTY_VALUE;
}

void GetRange(const MqlRates &bars[],const int start,double &upper,double &lower)
{
   upper=bars[start].high;
   lower=bars[start].low;
   for(int i=start+1;i<start+InpBreakoutLookback;i++)
   {
      upper=MathMax(upper,bars[i].high);
      lower=MathMin(lower,bars[i].low);
   }
}

int BreakDirection(const MqlRates &bars[])
{
   double upper=0.0,lower=0.0;
   GetRange(bars,2,upper,lower);
   const double pad=(double)InpBreakoutBuffer*point_size;
   if(bars[1].close>upper+pad) return 1;
   if(bars[1].close<lower-pad) return -1;
   return 0;
}

int CrossLevel(const MqlRates &bars[],const double upper,const double lower)
{
   const double pad=(double)InpBreakoutBuffer*point_size;
   if(bars[2].close<=upper+pad && bars[1].close>upper+pad) return 1;
   if(bars[2].close>=lower-pad && bars[1].close<lower-pad) return -1;
   return 0;
}
bool GetSignal(const MqlRates &bars[],int &direction)
{
   direction=0;
   double current=0.0,history[];
   if(!ReadIndicator(1,current)) return false;
   if(CopyBuffer(indicator_handle,0,2,InpATRMeanPeriod,history)!=InpATRMeanPeriod) return false;
   double average=0.0;
   for(int i=0;i<InpATRMeanPeriod;i++)
   {
      if(!MathIsValidNumber(history[i]) || history[i]==EMPTY_VALUE || history[i]<=0.0) return false;
      average+=history[i];
   }
   average/=(double)InpATRMeanPeriod;
   if(current>average) direction=BreakDirection(bars);
   return true;
}

bool TradingAllowed()
{
   return TerminalInfoInteger(TERMINAL_CONNECTED)!=0 &&
          TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)!=0 &&
          MQLInfoInteger(MQL_TRADE_ALLOWED)!=0 &&
          AccountInfoInteger(ACCOUNT_TRADE_ALLOWED)!=0 &&
          AccountInfoInteger(ACCOUNT_TRADE_EXPERT)!=0;
}

bool EntryBlocked()
{
   const bool netting=(ENUM_ACCOUNT_MARGIN_MODE)AccountInfoInteger(ACCOUNT_MARGIN_MODE)
                       !=ACCOUNT_MARGIN_MODE_RETAIL_HEDGING;
   // At most ONE position/order for this magic across the account.
   // On netting accounts, never merge with another EA's symbol exposure.
   for(int i=PositionsTotal()-1;i>=0;i--)
   {
      if(PositionGetTicket(i)==0) return true;
      if((ulong)PositionGetInteger(POSITION_MAGIC)==InpMagicNumber) return true;
      if(netting && PositionGetString(POSITION_SYMBOL)==_Symbol) return true;
   }
   for(int i=OrdersTotal()-1;i>=0;i--)
   {
      if(OrderGetTicket(i)==0) return true;
      if((ulong)OrderGetInteger(ORDER_MAGIC)==InpMagicNumber) return true;
      if(netting && OrderGetString(ORDER_SYMBOL)==_Symbol) return true;
   }
   return false;
}

void LogTradeResult(const string action,const bool local_ok)
{
   PrintFormat("%s: local=%s, retcode=%u (%s), last_error=%d",
               action,(local_ok ? "true" : "false"),trade.ResultRetcode(),
               trade.ResultRetcodeDescription(),GetLastError());
}

void ManagePositions()
{
   if(!InpUseBreakEven && !InpUseTrailingStop) return;
   MqlTick tick;
   if(!SymbolInfoTick(_Symbol,tick) || tick.bid<=0.0 || tick.ask<=0.0) return;
   const double stop_gap=(double)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)*point_size;
   const double freeze_gap=(double)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL)*point_size;
   const double min_gap=MathMax(stop_gap,freeze_gap)+tick_size;
   for(int i=PositionsTotal()-1;i>=0;i--)
   {
      const ulong ticket=PositionGetTicket(i);
      if(ticket==0 || PositionGetString(POSITION_SYMBOL)!=_Symbol ||
         (ulong)PositionGetInteger(POSITION_MAGIC)!=InpMagicNumber) continue;
      const bool buy=(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY;
      const double opened=PositionGetDouble(POSITION_PRICE_OPEN);
      const double old_sl=PositionGetDouble(POSITION_SL);
      const double tp=PositionGetDouble(POSITION_TP);
      const double price=(buy ? tick.bid : tick.ask);
      const double profit=(buy ? price-opened : opened-price)/point_size;
      double candidate=old_sl;
      if(InpUseBreakEven && profit>=(double)InpBreakEvenTrigger)
      {
         const double raw=opened+(buy ? 1.0 : -1.0)*(double)InpBreakEvenOffset*point_size;
         // Round toward profit, so a BE stop cannot lie below/above entry.
         const double be=(buy ? RoundUp(raw) : RoundDown(raw));
         const bool valid=(buy ? price-be>=min_gap : be-price>=min_gap);
         if(valid && (candidate==0.0 || (buy ? be>candidate : be<candidate))) candidate=be;
      }
      if(InpUseTrailingStop && profit>=(double)InpTrailingStart)
      {
         const double raw=price+(buy ? -1.0 : 1.0)*(double)InpTrailingDistance*point_size;
         const double trailing=(buy ? RoundDown(raw) : RoundUp(raw));
         const bool valid=(buy ? price-trailing>=min_gap : trailing-price>=min_gap);
         const double step=MathMax((double)InpTrailingStep*point_size,tick_size);
         const bool improves_old=old_sl==0.0 || (buy ? trailing-old_sl>=step-1e-9 : old_sl-trailing>=step-1e-9);
         if(valid && improves_old && (candidate==0.0 || (buy ? trailing>candidate : trailing<candidate)))
            candidate=trailing;
      }
      if(candidate<=0.0 || (old_sl>0.0 && MathAbs(candidate-old_sl)<tick_size*0.5)) continue;
      if(old_sl>0.0 && (buy ? candidate<=old_sl : candidate>=old_sl)) continue;
      // Respect freezes on the existing SL and TP as well as the new SL.
      if(freeze_gap>0.0)
      {
         if(old_sl>0.0 && (buy ? price-old_sl : old_sl-price)<=freeze_gap) continue;
         if(tp>0.0 && (buy ? tp-price : price-tp)<=freeze_gap) continue;
      }
      ResetLastError();
      const bool ok=trade.PositionModify(ticket,candidate,tp);
      const uint code=trade.ResultRetcode();
      if(!ok || (code!=TRADE_RETCODE_DONE && code!=TRADE_RETCODE_NO_CHANGES))
         LogTradeResult("PositionModify",ok);
   }
}

void OpenTrade(const int direction)
{
   if(direction==0 || !TradingAllowed() || EntryBlocked()) return;
   MqlTick tick;
   if(!SymbolInfoTick(_Symbol,tick) || tick.bid<=0.0 || tick.ask<tick.bid) return;
   if((tick.ask-tick.bid)/point_size>(double)InpMaxSpread+1e-8) return;
   const ENUM_SYMBOL_TRADE_MODE mode=(ENUM_SYMBOL_TRADE_MODE)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_MODE);
   if(mode==SYMBOL_TRADE_MODE_DISABLED || mode==SYMBOL_TRADE_MODE_CLOSEONLY) return;
   if(direction>0 && mode==SYMBOL_TRADE_MODE_SHORTONLY) return;
   if(direction<0 && mode==SYMBOL_TRADE_MODE_LONGONLY) return;
   const long flags=SymbolInfoInteger(_Symbol,SYMBOL_ORDER_MODE);
   if((flags&SYMBOL_ORDER_MARKET)==0 || (flags&SYMBOL_ORDER_SL)==0 || (flags&SYMBOL_ORDER_TP)==0) return;
   const bool buy=direction>0;
   const double price=(buy ? tick.ask : tick.bid);
   const double sl=(buy ? RoundDown(price-(double)InpStopLoss*point_size)
                        : RoundUp(price+(double)InpStopLoss*point_size));
   const double tp=(buy ? RoundUp(price+(double)InpTakeProfit*point_size)
                        : RoundDown(price-(double)InpTakeProfit*point_size));
   const double stop_gap=(double)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)*point_size;
   const double close_price=(buy ? tick.bid : tick.ask);
   if(sl<=0.0 || tp<=0.0 ||
      (buy ? close_price-sl : sl-close_price)<MathMax(stop_gap,tick_size)-1e-9 ||
      (buy ? tp-close_price : close_price-tp)<MathMax(stop_gap,tick_size)-1e-9)
   {
      Print("Entry skipped: configured SL/TP is not valid for broker stop distance.");
      return;
   }
   double margin=0.0;
   const ENUM_ORDER_TYPE order_type=(buy ? ORDER_TYPE_BUY : ORDER_TYPE_SELL);
   if(!OrderCalcMargin(order_type,_Symbol,InpLotSize,price,margin) ||
      margin>AccountInfoDouble(ACCOUNT_MARGIN_FREE))
   {
      PrintFormat("Entry skipped: insufficient margin or margin calculation failed (%d).",GetLastError());
      return;
   }
   if(!trade.SetTypeFillingBySymbol(_Symbol)) return;
   ResetLastError();
   // Protective prices are submitted in the SAME market-order request.
   const bool ok=(buy ? trade.Buy(InpLotSize,_Symbol,price,sl,tp,"EA-071")
                     : trade.Sell(InpLotSize,_Symbol,price,sl,tp,"EA-071"));
   const uint code=trade.ResultRetcode();
   if(!ok || (code!=TRADE_RETCODE_DONE && code!=TRADE_RETCODE_DONE_PARTIAL && code!=TRADE_RETCODE_PLACED))
      LogTradeResult((buy ? "Buy" : "Sell"),ok);
}

int OnInit()
{
   if(!MathIsValidNumber(InpLotSize) || InpLotSize<=0.0 || InpStopLoss<=0 || InpTakeProfit<=0 ||
      InpMagicNumber==0 || InpSlippage<0 || InpMaxSpread<0 || InpBreakoutLookback<2 ||
      InpBreakoutLookback>10000 || InpBreakoutBuffer<0 ||
      (InpUseBreakEven && (InpBreakEvenTrigger<=0 || InpBreakEvenOffset<0 || InpBreakEvenOffset>=InpBreakEvenTrigger)) ||
      (InpUseTrailingStop && (InpTrailingStart<=0 || InpTrailingDistance<=0 || InpTrailingStep<=0)))
      return INIT_PARAMETERS_INCORRECT;
   point_size=SymbolInfoDouble(_Symbol,SYMBOL_POINT);
   tick_size=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
   price_digits=(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);
   const double lot_min=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   const double lot_max=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MAX);
   const double lot_step=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   if(point_size<=0.0 || tick_size<=0.0 || lot_step<=0.0) return INIT_FAILED;
   if(InpLotSize<lot_min-1e-9 || InpLotSize>lot_max+1e-9 ||
      MathAbs(InpLotSize/lot_step-MathRound(InpLotSize/lot_step))>1e-7)
   {
      Print("Invalid lot size for this symbol. Lot is never silently increased.");
      return INIT_PARAMETERS_INCORRECT;
   }
   if(InpATRPeriod<2 || InpATRPeriod>10000 || InpATRMeanPeriod<2 || InpATRMeanPeriod>10000) return INIT_PARAMETERS_INCORRECT; indicator_handle=iATR(_Symbol,InpTimeframe,InpATRPeriod); if(indicator_handle==INVALID_HANDLE) return INIT_FAILED;
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetAsyncMode(false);
   trade.SetMarginMode();
   if(!trade.SetTypeFillingBySymbol(_Symbol)) return INIT_FAILED;
   // Start with the next candle, avoiding entry on an old signal at attachment.
   last_bar=iTime(_Symbol,InpTimeframe,0);
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   if(indicator_handle!=INVALID_HANDLE)
   {
      IndicatorRelease(indicator_handle);
      indicator_handle=INVALID_HANDLE;
   }
}

void OnTick()
{
   if(!TradingAllowed()) return;
   // Protective management runs every tick, including when spread is too high for entry.
   ManagePositions();
   const datetime current_bar=iTime(_Symbol,InpTimeframe,0);
   if(current_bar==0 || current_bar==last_bar) return;
   if(last_bar==0)
   {
      last_bar=current_bar;
      return;
   }
   MqlRates bars[];
   ArraySetAsSeries(bars,true);
   const int needed=InpBreakoutLookback+3;
   if(CopyRates(_Symbol,InpTimeframe,0,needed,bars)!=needed) return;
   if(bars[0].time!=current_bar) return;
   int direction=0;
   // Retry data availability on subsequent ticks, but evaluate each ready bar only once.
   if(!GetSignal(bars,direction)) return;
   last_bar=current_bar;
   if(EntryBlocked())
   {
      
      return;
   }
   OpenTrade(direction);
}
