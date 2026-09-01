#property copyright "DinexSpace"
#property version   "1.00"
#property strict

#include <Trade/Trade.mqh>

enum ENUM_STOP_MODEL
  {
   STOP_PREVIOUS_OPPOSITE_WAVE = 0,
   STOP_ATR_DISTANCE           = 1
  };

input group "Signal"
input ENUM_TIMEFRAMES InpSignalTimeframe = PERIOD_M15;
input int             InpMacdFast        = 12;
input int             InpMacdSlow        = 26;
input int             InpMacdSignal      = 9;
input int             InpConfirmBars     = 4;

input group "Stop and targets"
input ENUM_STOP_MODEL InpStopModel       = STOP_PREVIOUS_OPPOSITE_WAVE;
input int             InpMaxWaveBars     = 120;
input int             InpAtrPeriod       = 14;
input double          InpAtrMultiple     = 2.0;
input double          InpTp1R            = 1.0;
input double          InpTp2R            = 2.0;
input double          InpTp1ClosePercent = 50.0;
input bool            InpMoveStopToBE     = true;

input group "Risk and execution"
input double          InpRiskPercent     = 1.0;
input double          InpFixedLots       = 0.0;
input int             InpMaxSpreadPoints = 80;
input int             InpDeviationPoints = 30;
input bool            InpOnePositionOnly = true;
input ulong           InpMagic            = 26090101;

CTrade   trade;
int      macd_handle = INVALID_HANDLE;
int      atr_handle  = INVALID_HANDLE;
datetime last_bar_time = 0;
double   active_initial_risk = 0.0;
bool     active_tp1_done = false;
ulong    active_position_ticket = 0;

bool CopyHistogram(const int start_shift,const int count,double &hist[])
  {
   double main_line[],signal_line[];
   ArrayResize(main_line,count);
   ArrayResize(signal_line,count);
   ArrayResize(hist,count);
   ArraySetAsSeries(main_line,true);
   ArraySetAsSeries(signal_line,true);
   ArraySetAsSeries(hist,true);
   if(CopyBuffer(macd_handle,0,start_shift,count,main_line)!=count)
      return false;
   if(CopyBuffer(macd_handle,1,start_shift,count,signal_line)!=count)
      return false;
   for(int i=0;i<count;i++)
      hist[i]=main_line[i]-signal_line[i];
   return true;
  }

bool IsNewSignalBar()
  {
   datetime times[1];
   if(CopyTime(_Symbol,InpSignalTimeframe,0,1,times)!=1)
      return false;
   if(times[0]==last_bar_time)
      return false;
   last_bar_time=times[0];
   return true;
  }

bool HasManagedPosition()
  {
   if(!PositionSelect(_Symbol))
      return false;
   return ((ulong)PositionGetInteger(POSITION_MAGIC)==InpMagic);
  }

int FifthElementSignal()
  {
   if(InpConfirmBars<1)
      return 0;
   const int needed=InpConfirmBars+1;
   double hist[];
   if(!CopyHistogram(1,needed,hist))
      return 0;

   bool all_positive=true;
   bool all_negative=true;
   for(int i=0;i<InpConfirmBars;i++)
     {
      if(hist[i]<=0.0) all_positive=false;
      if(hist[i]>=0.0) all_negative=false;
     }

   const double preceding=hist[InpConfirmBars];
   if(all_positive && preceding<=0.0)
      return 1;
   if(all_negative && preceding>=0.0)
      return -1;
   return 0;
  }

bool PreviousOppositeWaveStop(const int direction,double &stop_price)
  {
   const int first_wave_shift=InpConfirmBars+1;
   const int count=MathMax(InpMaxWaveBars,10);
   double hist[];
   MqlRates rates[];
   ArraySetAsSeries(rates,true);
   if(!CopyHistogram(first_wave_shift,count,hist))
      return false;
   if(CopyRates(_Symbol,InpSignalTimeframe,first_wave_shift,count,rates)!=count)
      return false;

   int wave_bars=0;
   stop_price=(direction>0 ? DBL_MAX : -DBL_MAX);
   for(int i=0;i<count;i++)
     {
      const bool belongs=(direction>0 ? hist[i]<0.0 : hist[i]>0.0);
      if(!belongs)
         break;
      wave_bars++;
      if(direction>0)
         stop_price=MathMin(stop_price,rates[i].low);
      else
         stop_price=MathMax(stop_price,rates[i].high);
     }
   return (wave_bars>0 && stop_price!=DBL_MAX && stop_price!=-DBL_MAX);
  }

bool AtrStop(const int direction,const double entry,double &stop_price)
  {
   double atr[1];
   if(CopyBuffer(atr_handle,0,1,1,atr)!=1 || atr[0]<=0.0)
      return false;
   stop_price=entry-direction*InpAtrMultiple*atr[0];
   return true;
  }

double NormalizeVolume(const double raw_volume)
  {
   const double min_volume=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   const double max_volume=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MAX);
   const double step=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);
   if(step<=0.0 || raw_volume<min_volume)
      return 0.0;
   double volume=MathFloor(raw_volume/step+1e-9)*step;
   volume=MathMin(volume,max_volume);
   int digits=0;
   double probe=step;
   while(digits<8 && MathAbs(probe-MathRound(probe))>1e-8)
     {
      probe*=10.0;
      digits++;
     }
   return NormalizeDouble(volume,digits);
  }

double CalculateVolume(const double entry,const double stop_price)
  {
   if(InpFixedLots>0.0)
      return NormalizeVolume(InpFixedLots);
   const double stop_distance=MathAbs(entry-stop_price);
   const double tick_size=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);
   const double tick_value=SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE_LOSS);
   if(stop_distance<=0.0 || tick_size<=0.0 || tick_value<=0.0)
      return 0.0;
   const double risk_money=AccountInfoDouble(ACCOUNT_EQUITY)*InpRiskPercent/100.0;
   const double loss_per_lot=(stop_distance/tick_size)*tick_value;
   return NormalizeVolume(risk_money/loss_per_lot);
  }

bool ValidStops(const int direction,const double entry,const double stop_price,const double take_profit)
  {
   const double point=SymbolInfoDouble(_Symbol,SYMBOL_POINT);
   const int stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
   const double minimum_distance=stops_level*point;
   if(direction>0)
      return (stop_price<entry && take_profit>entry && entry-stop_price>=minimum_distance && take_profit-entry>=minimum_distance);
   return (stop_price>entry && take_profit<entry && stop_price-entry>=minimum_distance && entry-take_profit>=minimum_distance);
  }

bool OpenSignal(const int direction)
  {
   MqlTick tick;
   if(!SymbolInfoTick(_Symbol,tick))
      return false;
   const double point=SymbolInfoDouble(_Symbol,SYMBOL_POINT);
   if(point<=0.0 || (tick.ask-tick.bid)/point>InpMaxSpreadPoints)
      return false;

   const double entry=(direction>0 ? tick.ask : tick.bid);
   double stop_price=0.0;
   bool stop_ok=false;
   if(InpStopModel==STOP_PREVIOUS_OPPOSITE_WAVE)
      stop_ok=PreviousOppositeWaveStop(direction,stop_price);
   else
      stop_ok=AtrStop(direction,entry,stop_price);
   if(!stop_ok)
      return false;

   const double initial_risk=MathAbs(entry-stop_price);
   const double take_profit=entry+direction*InpTp2R*initial_risk;
   if(!ValidStops(direction,entry,stop_price,take_profit))
      return false;
   const double volume=CalculateVolume(entry,stop_price);
   if(volume<=0.0)
     {
      Print("Signal skipped: calculated volume is below broker minimum.");
      return false;
     }

   trade.SetExpertMagicNumber(InpMagic);
   trade.SetDeviationInPoints(InpDeviationPoints);
   trade.SetTypeFillingBySymbol(_Symbol);
   const int digits=(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);
   const double sl=NormalizeDouble(stop_price,digits);
   const double tp=NormalizeDouble(take_profit,digits);
   const bool sent=(direction>0)
                   ? trade.Buy(volume,_Symbol,0.0,sl,tp,"Dinex Fifth Element")
                   : trade.Sell(volume,_Symbol,0.0,sl,tp,"Dinex Fifth Element");
   if(!sent)
     {
      Print("Entry failed: ",trade.ResultRetcode()," ",trade.ResultRetcodeDescription());
      return false;
     }
   active_initial_risk=initial_risk;
   active_tp1_done=false;
   if(PositionSelect(_Symbol))
      active_position_ticket=(ulong)PositionGetInteger(POSITION_TICKET);
   return true;
  }

bool ReducePosition(const double close_volume)
  {
   if(!PositionSelect(_Symbol))
      return false;
   const long position_type=PositionGetInteger(POSITION_TYPE);
   const ulong ticket=(ulong)PositionGetInteger(POSITION_TICKET);
   MqlTick tick;
   if(!SymbolInfoTick(_Symbol,tick))
      return false;

   MqlTradeRequest request={};
   MqlTradeResult result={};
   request.action=TRADE_ACTION_DEAL;
   request.position=ticket;
   request.symbol=_Symbol;
   request.magic=InpMagic;
   request.volume=close_volume;
   request.deviation=InpDeviationPoints;
   request.type=(position_type==POSITION_TYPE_BUY ? ORDER_TYPE_SELL : ORDER_TYPE_BUY);
   request.price=(request.type==ORDER_TYPE_SELL ? tick.bid : tick.ask);
   const long filling_flags=SymbolInfoInteger(_Symbol,SYMBOL_FILLING_MODE);
   if((filling_flags & SYMBOL_FILLING_FOK)==SYMBOL_FILLING_FOK)
      request.type_filling=ORDER_FILLING_FOK;
   else if((filling_flags & SYMBOL_FILLING_IOC)==SYMBOL_FILLING_IOC)
      request.type_filling=ORDER_FILLING_IOC;
   else
      request.type_filling=ORDER_FILLING_RETURN;
   if(!OrderSend(request,result))
      return false;
   return (result.retcode==TRADE_RETCODE_DONE || result.retcode==TRADE_RETCODE_DONE_PARTIAL);
  }

void ManageOpenPosition()
  {
   if(!HasManagedPosition())
     {
      active_position_ticket=0;
      active_initial_risk=0.0;
      active_tp1_done=false;
      return;
     }

   const ulong ticket=(ulong)PositionGetInteger(POSITION_TICKET);
   const long type=PositionGetInteger(POSITION_TYPE);
   const int direction=(type==POSITION_TYPE_BUY ? 1 : -1);
   const double entry=PositionGetDouble(POSITION_PRICE_OPEN);
   const double current=(direction>0 ? SymbolInfoDouble(_Symbol,SYMBOL_BID) : SymbolInfoDouble(_Symbol,SYMBOL_ASK));
   const double sl=PositionGetDouble(POSITION_SL);
   const double tp=PositionGetDouble(POSITION_TP);

   if(ticket!=active_position_ticket || active_initial_risk<=0.0)
     {
      active_position_ticket=ticket;
      active_initial_risk=(tp>0.0 && InpTp2R>0.0 ? MathAbs(tp-entry)/InpTp2R : MathAbs(entry-sl));
      active_tp1_done=false;
     }
   if(active_tp1_done || active_initial_risk<=0.0)
      return;

   const double tp1=entry+direction*InpTp1R*active_initial_risk;
   const bool reached=(direction>0 ? current>=tp1 : current<=tp1);
   if(!reached)
      return;

   const double current_volume=PositionGetDouble(POSITION_VOLUME);
   const double min_volume=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   double close_volume=NormalizeVolume(current_volume*InpTp1ClosePercent/100.0);
   if(close_volume>=min_volume && current_volume-close_volume>=min_volume)
     {
      if(!ReducePosition(close_volume))
         return;
     }
   if(InpMoveStopToBE)
     {
      const int digits=(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS);
      trade.PositionModify(_Symbol,NormalizeDouble(entry,digits),tp);
     }
   active_tp1_done=true;
  }

int OnInit()
  {
   if(InpConfirmBars<1 || InpRiskPercent<0.0 || InpTp2R<=0.0 || InpTp1R<=0.0)
      return INIT_PARAMETERS_INCORRECT;
   macd_handle=iMACD(_Symbol,InpSignalTimeframe,InpMacdFast,InpMacdSlow,InpMacdSignal,PRICE_CLOSE);
   atr_handle=iATR(_Symbol,InpSignalTimeframe,InpAtrPeriod);
   if(macd_handle==INVALID_HANDLE || atr_handle==INVALID_HANDLE)
      return INIT_FAILED;
   trade.SetExpertMagicNumber(InpMagic);
   return INIT_SUCCEEDED;
  }

void OnDeinit(const int reason)
  {
   if(macd_handle!=INVALID_HANDLE) IndicatorRelease(macd_handle);
   if(atr_handle!=INVALID_HANDLE) IndicatorRelease(atr_handle);
  }

void OnTick()
  {
   ManageOpenPosition();
   if(!IsNewSignalBar())
      return;
   if(InpOnePositionOnly && HasManagedPosition())
      return;
   const int signal=FifthElementSignal();
   if(signal!=0)
      OpenSignal(signal);
  }
