#property strict
#property version "1.00"
#include <Trade\Trade.mqh>

input double InpLotSize = 0.01;
input int InpStopLoss = 300;
input int InpTakeProfit = 600;
input ulong InpMagicNumber = 129123;
input int InpSlippage = 10;
input bool InpUseBreakEven = true;
input int InpBreakEvenTrigger = 150;
input int InpBreakEvenOffset = 0;
input bool InpUseTrailingStop = true;
input int InpTrailingStart = 200;
input int InpTrailingDistance = 200;
input int InpMaxSpread = 30;

input int InpATRPeriod=14;
input double InpATRExpansionFactor=1.1;
input int InpBreakoutBars=10;
int g_atr=INVALID_HANDLE;
bool ReadValue(int h,int b,int s,double &v){double a[1];if(CopyBuffer(h,b,s,1,a)!=1)return false;v=a[0];return MathIsValidNumber(v);}

CTrade trade;
datetime g_lastBar = 0;

bool IsNewBar()
{
   datetime t = iTime(_Symbol, _Period, 0);
   if(t == 0 || t == g_lastBar) return false;
   g_lastBar = t;
   return true;
}
bool SpreadAllowed()
{
   MqlTick t;
   return SymbolInfoTick(_Symbol, t) && (t.ask - t.bid) / _Point <= InpMaxSpread;
}
int CountMine()
{
   int n = 0;
   for(int i = PositionsTotal() - 1; i >= 0; --i)
      if(PositionGetTicket(i) > 0 &&
         PositionGetString(POSITION_SYMBOL) == _Symbol &&
         (ulong)PositionGetInteger(POSITION_MAGIC) == InpMagicNumber) ++n;
   return n;
}
double NormalizeVolume()
{
   double step = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
   if(step <= 0.0) return 0.0;
   double v = MathMax(SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN),
                      MathMin(SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX), InpLotSize));
   return NormalizeDouble(MathFloor(v / step + 1e-8) * step, 8);
}
bool OpenPosition(ENUM_ORDER_TYPE type, string comment)
{
   MqlTick t;
   if(!SymbolInfoTick(_Symbol, t)) return false;
   double volume = NormalizeVolume();
   if(volume <= 0.0) return false;
   double price = (type == ORDER_TYPE_BUY) ? t.ask : t.bid;
   double minStop = (double)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL) * _Point;
   double slDist = MathMax((double)InpStopLoss * _Point, minStop);
   double tpDist = MathMax((double)InpTakeProfit * _Point, minStop);
   double sl = NormalizeDouble(price + ((type == ORDER_TYPE_BUY) ? -slDist : slDist), _Digits);
   double tp = NormalizeDouble(price + ((type == ORDER_TYPE_BUY) ? tpDist : -tpDist), _Digits);
   bool ok = (type == ORDER_TYPE_BUY)
      ? trade.Buy(volume, _Symbol, 0.0, sl, tp, comment)
      : trade.Sell(volume, _Symbol, 0.0, sl, tp, comment);
   if(!ok) Print("Order failed: ", trade.ResultRetcode(), " ", trade.ResultRetcodeDescription());
   return ok;
}
void ManagePositions()
{
   MqlTick t;
   if(!SymbolInfoTick(_Symbol, t)) return;
   for(int i = PositionsTotal() - 1; i >= 0; --i)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0 || PositionGetString(POSITION_SYMBOL) != _Symbol ||
         (ulong)PositionGetInteger(POSITION_MAGIC) != InpMagicNumber) continue;
      ENUM_POSITION_TYPE type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
      double open = PositionGetDouble(POSITION_PRICE_OPEN);
      double oldSL = PositionGetDouble(POSITION_SL);
      double tp = PositionGetDouble(POSITION_TP);
      double current = (type == POSITION_TYPE_BUY) ? t.bid : t.ask;
      double profitPoints = (type == POSITION_TYPE_BUY) ? (current-open)/_Point : (open-current)/_Point;
      double newSL = oldSL;
      bool modify = false;
      if(InpUseBreakEven && profitPoints >= InpBreakEvenTrigger)
      {
         double be = NormalizeDouble(open + ((type == POSITION_TYPE_BUY) ? 1.0 : -1.0) * InpBreakEvenOffset * _Point, _Digits);
         if(type == POSITION_TYPE_BUY && (oldSL == 0.0 || be > newSL) && be < t.bid)
         { newSL = be; modify = true; }
         else if(type == POSITION_TYPE_SELL && (oldSL == 0.0 || be < newSL) && be > t.ask)
         { newSL = be; modify = true; }
      }
      if(InpUseTrailingStop && profitPoints >= InpTrailingStart)
      {
         double tr = NormalizeDouble(current + ((type == POSITION_TYPE_BUY) ? -1.0 : 1.0) * InpTrailingDistance * _Point, _Digits);
         if(type == POSITION_TYPE_BUY && tr < t.bid && (newSL == 0.0 || tr > newSL))
         { newSL = tr; modify = true; }
         else if(type == POSITION_TYPE_SELL && tr > t.ask && (newSL == 0.0 || tr < newSL))
         { newSL = tr; modify = true; }
      }
      if(modify && !trade.PositionModify(ticket, newSL, tp))
         Print("PositionModify failed: ", trade.ResultRetcode(), " ", trade.ResultRetcodeDescription());
   }
}
int OnInit()
{
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   g_atr=iATR(_Symbol,_Period,InpATRPeriod);
   if(g_atr==INVALID_HANDLE) return INIT_FAILED;
   return INIT_SUCCEEDED;
}
void OnDeinit(const int reason)
{
   if(g_atr!=INVALID_HANDLE) IndicatorRelease(g_atr);
}
void OnTick()
{
   ManagePositions();
   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) ||
      !MQLInfoInteger(MQL_TRADE_ALLOWED) ||
      !AccountInfoInteger(ACCOUNT_TRADE_ALLOWED)) return;
   if(!IsNewBar() || CountMine() >= 1 || !SpreadAllowed()) return;
   if(InpBreakoutBars<2) return;
   double a,b;
   if(!ReadValue(g_atr,0,1,a)||!ReadValue(g_atr,0,2,b)||b<=0.0||a<b*InpATRExpansionFactor) return;
   double hi=-DBL_MAX,lo=DBL_MAX;
   for(int i=2;i<2+InpBreakoutBars;i++){hi=MathMax(hi,iHigh(_Symbol,_Period,i));lo=MathMin(lo,iLow(_Symbol,_Period,i));}
   double c=iClose(_Symbol,_Period,1);
   if(c>hi) OpenPosition(ORDER_TYPE_BUY,"EA-129 BUY");
   else if(c<lo) OpenPosition(ORDER_TYPE_SELL,"EA-129 SELL");
}
