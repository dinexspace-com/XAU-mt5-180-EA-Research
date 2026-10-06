#property strict
#include <Trade\Trade.mqh>
input double InpLotSize=0.01;
input int InpStopLoss=300;
input int InpTakeProfit=600;
input ulong InpMagicNumber=123456;
input int InpSlippage=10;
input group "Break Even & Trailing Stop"
input bool InpUseBreakEven=true;
input int InpBreakEvenStart=150;
input int InpBreakEvenOffset=0;
input bool InpUseTrailingStop=true;
input int InpTrailingStart=200;
input int InpTrailingDistance=200;
input int InpMaxSpreadPoints=30;
CTrade trade;
datetime g_bar_time=0;
int g_bands=INVALID_HANDLE;
bool NewBar(){datetime t=iTime(_Symbol,_Period,0);if(t==0||t==g_bar_time)return false;g_bar_time=t;return true;}
bool TradingAllowed(){return MQLInfoInteger(MQL_TRADE_ALLOWED)&&TerminalInfoInteger(TERMINAL_TRADE_ALLOWED)&&AccountInfoInteger(ACCOUNT_TRADE_ALLOWED);}
bool SpreadOK(){MqlTick t;if(!SymbolInfoTick(_Symbol,t))return false;return(t.ask-t.bid)/_Point<=InpMaxSpreadPoints;}
bool HasPosition(){for(int i=PositionsTotal()-1;i>=0;--i){ulong x=PositionGetTicket(i);if(x&&PositionSelectByTicket(x)&&PositionGetString(POSITION_SYMBOL)==_Symbol&&(ulong)PositionGetInteger(POSITION_MAGIC)==InpMagicNumber)return true;}return false;}
double NP(double x){return NormalizeDouble(x,(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS));}
bool StopsValid(ENUM_ORDER_TYPE y,double s,double q){MqlTick t;if(!SymbolInfoTick(_Symbol,t))return false;double d=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL)*_Point;return y==ORDER_TYPE_BUY?(t.bid-s>=d&&q-t.bid>=d):(s-t.ask>=d&&t.ask-q>=d);}
void ManagePosition(){for(int i=PositionsTotal()-1;i>=0;--i){ulong x=PositionGetTicket(i);if(!x||!PositionSelectByTicket(x)||PositionGetString(POSITION_SYMBOL)!=_Symbol||(ulong)PositionGetInteger(POSITION_MAGIC)!=InpMagicNumber)continue;ENUM_POSITION_TYPE y=(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);double o=PositionGetDouble(POSITION_PRICE_OPEN),c=y==POSITION_TYPE_BUY?SymbolInfoDouble(_Symbol,SYMBOL_BID):SymbolInfoDouble(_Symbol,SYMBOL_ASK),s=PositionGetDouble(POSITION_SL),q=PositionGetDouble(POSITION_TP),p=y==POSITION_TYPE_BUY?(c-o)/_Point:(o-c)/_Point,n=s;bool m=false;if(InpUseBreakEven&&p>=InpBreakEvenStart){double b=NP(y==POSITION_TYPE_BUY?o+InpBreakEvenOffset*_Point:o-InpBreakEvenOffset*_Point);if((y==POSITION_TYPE_BUY&&(s==0||b>s))||(y==POSITION_TYPE_SELL&&(s==0||b<s))){n=b;m=true;}}if(InpUseTrailingStop&&p>=InpTrailingStart){double z=NP(y==POSITION_TYPE_BUY?c-InpTrailingDistance*_Point:c+InpTrailingDistance*_Point);if((y==POSITION_TYPE_BUY&&(n==0||z>n))||(y==POSITION_TYPE_SELL&&(n==0||z<n))){n=z;m=true;}}if(m&&((y==POSITION_TYPE_BUY&&n<c)||(y==POSITION_TYPE_SELL&&n>c))&&!trade.PositionModify(x,n,q))Print("PositionModify failed. Retcode=",trade.ResultRetcode());}}
bool OpenBuy(){MqlTick t;if(!SymbolInfoTick(_Symbol,t))return false;double s=NP(t.ask-InpStopLoss*_Point),q=NP(t.ask+InpTakeProfit*_Point);if(!StopsValid(ORDER_TYPE_BUY,s,q))return false;if(!trade.Buy(InpLotSize,_Symbol,0,s,q,"EA-101 BUY")){Print("Buy failed. Retcode=",trade.ResultRetcode());return false;}return true;}
bool OpenSell(){MqlTick t;if(!SymbolInfoTick(_Symbol,t))return false;double s=NP(t.bid+InpStopLoss*_Point),q=NP(t.bid-InpTakeProfit*_Point);if(!StopsValid(ORDER_TYPE_SELL,s,q))return false;if(!trade.Sell(InpLotSize,_Symbol,0,s,q,"EA-101 SELL")){Print("Sell failed. Retcode=",trade.ResultRetcode());return false;}return true;}
int OnInit(){trade.SetExpertMagicNumber(InpMagicNumber);trade.SetDeviationInPoints(InpSlippage);g_bands=iBands(_Symbol,_Period,20,0,2.0,PRICE_CLOSE);return g_bands==INVALID_HANDLE?INIT_FAILED:INIT_SUCCEEDED;}
void OnDeinit(const int reason){if(g_bands!=INVALID_HANDLE)IndicatorRelease(g_bands);}
void OnTick(){ManagePosition();if(!TradingAllowed()||!NewBar()||HasPosition()||!SpreadOK())return;MqlRates r[3];if(CopyRates(_Symbol,_Period,0,3,r)!=3)return;double upper[3],middle[3],lower[3];if(CopyBuffer(g_bands,0,0,3,upper)!=3||CopyBuffer(g_bands,1,0,3,middle)!=3||CopyBuffer(g_bands,2,0,3,lower)!=3)return;double body=MathAbs(r[1].close-r[1].open),range=r[1].high-r[1].low;if(range<=0)return;double lw=MathMin(r[1].open,r[1].close)-r[1].low,uw=r[1].high-MathMax(r[1].open,r[1].close);if(lw>=body*2.0&&lw>=range*0.5&&r[1].close>r[1].open&&r[1].low<=lower[1])OpenBuy();else if(uw>=body*2.0&&uw>=range*0.5&&r[1].close<r[1].open&&r[1].high>=upper[1])OpenSell();}
