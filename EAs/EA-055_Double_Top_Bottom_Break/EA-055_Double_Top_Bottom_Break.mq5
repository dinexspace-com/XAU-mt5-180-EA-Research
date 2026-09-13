//+------------------------------------------------------------------+
//|                                              DoubleTopBottomEA.mq5|
//|                        Double Top / Double Bottom Neckline Break  |
//+------------------------------------------------------------------+
#property strict
#property version   "1.00"
#property description "EA giao dich breakout neckline cua Double Top / Double Bottom"

#include <Trade\Trade.mqh>

CTrade trade;

//--- General trading inputs
input double InpLotSize              = 0.01;
input int    InpStopLoss             = 300;
input int    InpTakeProfit           = 600;
input ulong  InpMagicNumber          = 123456;
input int    InpSlippage             = 10;

//--- Break Even
input group "=== BREAK EVEN ==="
input bool   InpUseBreakEven         = true;
input int    InpBreakEvenTrigger     = 150;
input int    InpBreakEvenOffset      = 0;

//--- Trailing Stop
input group "=== TRAILING STOP ==="
input bool   InpUseTrailingStop      = true;
input int    InpTrailingStart        = 200;
input int    InpTrailingDistance     = 150;

//--- Strategy filters
input group "=== STRATEGY ==="
input int    InpMaxSpread            = 30;
input int    InpLookbackBars         = 100;
input int    InpSwingStrength        = 2;
input int    InpMinPatternBars       = 5;
input int    InpMaxPatternBars       = 60;
input int    InpPatternTolerance     = 100;
input int    InpBreakoutBuffer       = 0;

//--- Internal variables
datetime g_lastBarTime = 0;

//+------------------------------------------------------------------+
//| Structure containing a detected pattern                          |
//+------------------------------------------------------------------+
struct PatternInfo
{
   bool     valid;
   bool     isDoubleTop;
   int      firstIndex;
   int      secondIndex;
   double   firstPrice;
   double   secondPrice;
   double   neckline;
};

//+------------------------------------------------------------------+
//| Expert initialization                                             |
//+------------------------------------------------------------------+
int OnInit()
{
   if(InpLotSize <= 0.0)
   {
      Print("Invalid lot size.");
      return(INIT_PARAMETERS_INCORRECT);
   }

   if(InpStopLoss < 0 ||
      InpTakeProfit < 0 ||
      InpSlippage < 0 ||
      InpMaxSpread < 0 ||
      InpSwingStrength < 1 ||
      InpLookbackBars < 20 ||
      InpMinPatternBars < 1 ||
      InpMaxPatternBars <= InpMinPatternBars ||
      InpPatternTolerance < 0)
   {
      Print("Invalid input parameters.");
      return(INIT_PARAMETERS_INCORRECT);
   }

   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints((ulong)InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   trade.SetAsyncMode(false);

   g_lastBarTime = iTime(_Symbol, _Period, 0);

   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization                                           |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Print("EA stopped. Reason: ", reason);
}

//+------------------------------------------------------------------+
//| Expert tick                                                       |
//+------------------------------------------------------------------+
void OnTick()
{
   //--- Position management is performed on every tick
   ManageOpenPositions();

   //--- Entry signals are evaluated only once per new candle
   if(!IsNewBar())
      return;

   if(!TradingIsAllowed())
      return;

   if(!IsSpreadAllowed())
      return;

   if(HasOpenPosition())
      return;

   if(Bars(_Symbol, _Period) < InpLookbackBars + InpSwingStrength + 10)
      return;

   CheckTradingSignal();
}

//+------------------------------------------------------------------+
//| New bar detector                                                  |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   const datetime currentBarTime = iTime(_Symbol, _Period, 0);

   if(currentBarTime <= 0)
      return(false);

   if(currentBarTime == g_lastBarTime)
      return(false);

   g_lastBarTime = currentBarTime;
   return(true);
}

//+------------------------------------------------------------------+
//| Check terminal/account trading status                             |
//+------------------------------------------------------------------+
bool TradingIsAllowed()
{
   if(!TerminalInfoInteger(TERMINAL_CONNECTED))
      return(false);

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return(false);

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return(false);

   const long tradeMode = SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE);

   if(tradeMode == SYMBOL_TRADE_MODE_DISABLED)
      return(false);

   return(true);
}

//+------------------------------------------------------------------+
//| Spread filter                                                     |
//+------------------------------------------------------------------+
bool IsSpreadAllowed()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return(false);

   if(tick.ask <= 0.0 || tick.bid <= 0.0)
      return(false);

   const double spreadPoints = (tick.ask - tick.bid) / _Point;

   return(spreadPoints <= (double)InpMaxSpread);
}

//+------------------------------------------------------------------+
//| Check existing position belonging to this EA                      |
//+------------------------------------------------------------------+
bool HasOpenPosition()
{
   const int total = PositionsTotal();

   for(int i = total - 1; i >= 0; i--)
   {
      const ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      const string symbol = PositionGetString(POSITION_SYMBOL);
      const ulong magic   = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol == _Symbol && magic == InpMagicNumber)
         return(true);
   }

   return(false);
}

//+------------------------------------------------------------------+
//| Check trading signal                                              |
//+------------------------------------------------------------------+
void CheckTradingSignal()
{
   PatternInfo topPattern;
   PatternInfo bottomPattern;

   ResetPattern(topPattern);
   ResetPattern(bottomPattern);

   const bool hasDoubleTop    = FindDoubleTop(topPattern);
   const bool hasDoubleBottom = FindDoubleBottom(bottomPattern);

   const double close1 = iClose(_Symbol, _Period, 1);
   const double close2 = iClose(_Symbol, _Period, 2);

   if(close1 <= 0.0 || close2 <= 0.0)
      return;

   //--- SELL: previous candle was above neckline and latest
   //--- closed candle breaks below the neckline
   if(hasDoubleTop)
   {
      const double breakoutLevel =
         topPattern.neckline - ((double)InpBreakoutBuffer * _Point);

      if(close2 >= breakoutLevel && close1 < breakoutLevel)
      {
         OpenSell(topPattern);
         return;
      }
   }

   //--- BUY: previous candle was below neckline and latest
   //--- closed candle breaks above the neckline
   if(hasDoubleBottom)
   {
      const double breakoutLevel =
         bottomPattern.neckline + ((double)InpBreakoutBuffer * _Point);

      if(close2 <= breakoutLevel && close1 > breakoutLevel)
      {
         OpenBuy(bottomPattern);
      }
   }
}

//+------------------------------------------------------------------+
//| Reset pattern                                                     |
//+------------------------------------------------------------------+
void ResetPattern(PatternInfo &pattern)
{
   pattern.valid       = false;
   pattern.isDoubleTop = false;
   pattern.firstIndex  = -1;
   pattern.secondIndex = -1;
   pattern.firstPrice  = 0.0;
   pattern.secondPrice = 0.0;
   pattern.neckline    = 0.0;
}

//+------------------------------------------------------------------+
//| Detect swing high                                                 |
//+------------------------------------------------------------------+
bool IsSwingHigh(const int shift)
{
   if(shift <= InpSwingStrength)
      return(false);

   const double center = iHigh(_Symbol, _Period, shift);

   if(center <= 0.0)
      return(false);

   for(int j = 1; j <= InpSwingStrength; j++)
   {
      const double newerHigh = iHigh(_Symbol, _Period, shift - j);
      const double olderHigh = iHigh(_Symbol, _Period, shift + j);

      if(center <= newerHigh || center < olderHigh)
         return(false);
   }

   return(true);
}

//+------------------------------------------------------------------+
//| Detect swing low                                                  |
//+------------------------------------------------------------------+
bool IsSwingLow(const int shift)
{
   if(shift <= InpSwingStrength)
      return(false);

   const double center = iLow(_Symbol, _Period, shift);

   if(center <= 0.0)
      return(false);

   for(int j = 1; j <= InpSwingStrength; j++)
   {
      const double newerLow = iLow(_Symbol, _Period, shift - j);
      const double olderLow = iLow(_Symbol, _Period, shift + j);

      if(center >= newerLow || center > olderLow)
         return(false);
   }

   return(true);
}

//+------------------------------------------------------------------+
//| Find latest valid Double Top                                      |
//| Array/bar index: smaller index = more recent                      |
//+------------------------------------------------------------------+
bool FindDoubleTop(PatternInfo &pattern)
{
   int secondTop = -1;
   int firstTop  = -1;

   //--- Find most recent confirmed swing high
   for(int shift = InpSwingStrength + 1;
       shift <= InpLookbackBars;
       shift++)
   {
      if(IsSwingHigh(shift))
      {
         secondTop = shift;
         break;
      }
   }

   if(secondTop < 0)
      return(false);

   //--- Find previous/older swing high
   const int startShift = secondTop + InpMinPatternBars;
   const int endShift   = MathMin(secondTop + InpMaxPatternBars,
                                  InpLookbackBars);

   for(int shift = startShift; shift <= endShift; shift++)
   {
      if(!IsSwingHigh(shift))
         continue;

      const double recentTopPrice = iHigh(_Symbol, _Period, secondTop);
      const double olderTopPrice  = iHigh(_Symbol, _Period, shift);
      const double difference =
         MathAbs(recentTopPrice - olderTopPrice) / _Point;

      if(difference <= (double)InpPatternTolerance)
      {
         firstTop = shift;
         break;
      }
   }

   if(firstTop < 0)
      return(false);

   //--- Neckline = lowest low between the two tops
   double neckline = DBL_MAX;

   for(int shift = secondTop + 1; shift < firstTop; shift++)
   {
      const double low = iLow(_Symbol, _Period, shift);

      if(low > 0.0 && low < neckline)
         neckline = low;
   }

   if(neckline == DBL_MAX || neckline <= 0.0)
      return(false);

   const double top1 = iHigh(_Symbol, _Period, firstTop);
   const double top2 = iHigh(_Symbol, _Period, secondTop);

   //--- Neckline must actually be below both tops
   if(neckline >= top1 || neckline >= top2)
      return(false);

   pattern.valid       = true;
   pattern.isDoubleTop = true;
   pattern.firstIndex  = firstTop;
   pattern.secondIndex = secondTop;
   pattern.firstPrice  = top1;
   pattern.secondPrice = top2;
   pattern.neckline    = neckline;

   return(true);
}

//+------------------------------------------------------------------+
//| Find latest valid Double Bottom                                   |
//+------------------------------------------------------------------+
bool FindDoubleBottom(PatternInfo &pattern)
{
   int secondBottom = -1;
   int firstBottom  = -1;

   //--- Find most recent confirmed swing low
   for(int shift = InpSwingStrength + 1;
       shift <= InpLookbackBars;
       shift++)
   {
      if(IsSwingLow(shift))
      {
         secondBottom = shift;
         break;
      }
   }

   if(secondBottom < 0)
      return(false);

   //--- Find previous/older swing low
   const int startShift = secondBottom + InpMinPatternBars;
   const int endShift   = MathMin(secondBottom + InpMaxPatternBars,
                                  InpLookbackBars);

   for(int shift = startShift; shift <= endShift; shift++)
   {
      if(!IsSwingLow(shift))
         continue;

      const double recentBottomPrice =
         iLow(_Symbol, _Period, secondBottom);

      const double olderBottomPrice =
         iLow(_Symbol, _Period, shift);

      const double difference =
         MathAbs(recentBottomPrice - olderBottomPrice) / _Point;

      if(difference <= (double)InpPatternTolerance)
      {
         firstBottom = shift;
         break;
      }
   }

   if(firstBottom < 0)
      return(false);

   //--- Neckline = highest high between the two bottoms
   double neckline = -DBL_MAX;

   for(int shift = secondBottom + 1; shift < firstBottom; shift++)
   {
      const double high = iHigh(_Symbol, _Period, shift);

      if(high > neckline)
         neckline = high;
   }

   if(neckline == -DBL_MAX || neckline <= 0.0)
      return(false);

   const double bottom1 = iLow(_Symbol, _Period, firstBottom);
   const double bottom2 = iLow(_Symbol, _Period, secondBottom);

   //--- Neckline must actually be above both bottoms
   if(neckline <= bottom1 || neckline <= bottom2)
      return(false);

   pattern.valid        = true;
   pattern.isDoubleTop  = false;
   pattern.firstIndex   = firstBottom;
   pattern.secondIndex  = secondBottom;
   pattern.firstPrice   = bottom1;
   pattern.secondPrice  = bottom2;
   pattern.neckline     = neckline;

   return(true);
}

//+------------------------------------------------------------------+
//| Normalize volume to broker requirements                           |
//+------------------------------------------------------------------+
double NormalizeVolume(const double requestedVolume)
{
   const double minVolume =
      SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);

   const double maxVolume =
      SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);

   const double volumeStep =
      SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);

   if(minVolume <= 0.0 || maxVolume <= 0.0 || volumeStep <= 0.0)
      return(0.0);

   double volume = requestedVolume;

   volume = MathMax(volume, minVolume);
   volume = MathMin(volume, maxVolume);

   volume =
      MathFloor((volume - minVolume) / volumeStep + 0.5) *
      volumeStep + minVolume;

   volume = MathMax(volume, minVolume);
   volume = MathMin(volume, maxVolume);

   return(NormalizeDouble(volume, 8));
}

//+------------------------------------------------------------------+
//| Broker minimum stop distance                                      |
//+------------------------------------------------------------------+
double MinimumStopDistance()
{
   const long stopsLevel =
      SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);

   return((double)stopsLevel * _Point);
}

//+------------------------------------------------------------------+
//| Open BUY                                                          |
//+------------------------------------------------------------------+
void OpenBuy(const PatternInfo &pattern)
{
   if(!pattern.valid)
      return;

   if(HasOpenPosition())
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   const double volume = NormalizeVolume(InpLotSize);

   if(volume <= 0.0)
   {
      Print("BUY rejected: invalid normalized volume.");
      return;
   }

   const double ask             = tick.ask;
   const double minStopDistance = MinimumStopDistance();

   double sl = 0.0;
   double tp = 0.0;

   if(InpStopLoss > 0)
   {
      const double requestedSL =
         ask - ((double)InpStopLoss * _Point);

      const double maximumAllowedSL =
         ask - minStopDistance;

      sl = MathMin(requestedSL, maximumAllowedSL);
      sl = NormalizeDouble(sl, _Digits);
   }

   if(InpTakeProfit > 0)
   {
      const double requestedTP =
         ask + ((double)InpTakeProfit * _Point);

      const double minimumAllowedTP =
         ask + minStopDistance;

      tp = MathMax(requestedTP, minimumAllowedTP);
      tp = NormalizeDouble(tp, _Digits);
   }

   const bool result =
      trade.Buy(volume,
                _Symbol,
                0.0,
                sl,
                tp,
                "DoubleBottom_Breakout");

   if(!result)
   {
      Print("BUY failed. Retcode=",
            trade.ResultRetcode(),
            " Description=",
            trade.ResultRetcodeDescription());
   }
   else
   {
      Print("BUY opened. Double Bottom neckline=",
            DoubleToString(pattern.neckline, _Digits),
            " Deal=",
            trade.ResultDeal());
   }
}

//+------------------------------------------------------------------+
//| Open SELL                                                         |
//+------------------------------------------------------------------+
void OpenSell(const PatternInfo &pattern)
{
   if(!pattern.valid)
      return;

   if(HasOpenPosition())
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   const double volume = NormalizeVolume(InpLotSize);

   if(volume <= 0.0)
   {
      Print("SELL rejected: invalid normalized volume.");
      return;
   }

   const double bid             = tick.bid;
   const double minStopDistance = MinimumStopDistance();

   double sl = 0.0;
   double tp = 0.0;

   if(InpStopLoss > 0)
   {
      const double requestedSL =
         bid + ((double)InpStopLoss * _Point);

      const double minimumAllowedSL =
         bid + minStopDistance;

      sl = MathMax(requestedSL, minimumAllowedSL);
      sl = NormalizeDouble(sl, _Digits);
   }

   if(InpTakeProfit > 0)
   {
      const double requestedTP =
         bid - ((double)InpTakeProfit * _Point);

      const double maximumAllowedTP =
         bid - minStopDistance;

      tp = MathMin(requestedTP, maximumAllowedTP);
      tp = NormalizeDouble(tp, _Digits);
   }

   const bool result =
      trade.Sell(volume,
                 _Symbol,
                 0.0,
                 sl,
                 tp,
                 "DoubleTop_Breakout");

   if(!result)
   {
      Print("SELL failed. Retcode=",
            trade.ResultRetcode(),
            " Description=",
            trade.ResultRetcodeDescription());
   }
   else
   {
      Print("SELL opened. Double Top neckline=",
            DoubleToString(pattern.neckline, _Digits),
            " Deal=",
            trade.ResultDeal());
   }
}

//+------------------------------------------------------------------+
//| Manage Break Even and Trailing Stop                               |
//+------------------------------------------------------------------+
void ManageOpenPositions()
{
   const int total = PositionsTotal();

   for(int i = total - 1; i >= 0; i--)
   {
      const ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      const string symbol =
         PositionGetString(POSITION_SYMBOL);

      const ulong magic =
         (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol != _Symbol || magic != InpMagicNumber)
         continue;

      const ENUM_POSITION_TYPE positionType =
         (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

      const double openPrice =
         PositionGetDouble(POSITION_PRICE_OPEN);

      const double currentSL =
         PositionGetDouble(POSITION_SL);

      const double currentTP =
         PositionGetDouble(POSITION_TP);

      MqlTick tick;

      if(!SymbolInfoTick(_Symbol, tick))
         continue;

      if(positionType == POSITION_TYPE_BUY)
      {
         ManageBuyPosition(ticket,
                           openPrice,
                           currentSL,
                           currentTP,
                           tick.bid);
      }
      else if(positionType == POSITION_TYPE_SELL)
      {
         ManageSellPosition(ticket,
                            openPrice,
                            currentSL,
                            currentTP,
                            tick.ask);
      }
   }
}

//+------------------------------------------------------------------+
//| Manage BUY position                                               |
//+------------------------------------------------------------------+
void ManageBuyPosition(const ulong ticket,
                       const double openPrice,
                       const double currentSL,
                       const double currentTP,
                       const double currentPrice)
{
   const double profitPoints =
      (currentPrice - openPrice) / _Point;

   double desiredSL = currentSL;
   bool modify      = false;

   //--- Break Even
   if(InpUseBreakEven &&
      InpBreakEvenTrigger > 0 &&
      profitPoints >= (double)InpBreakEvenTrigger)
   {
      const double breakEvenSL =
         openPrice + ((double)InpBreakEvenOffset * _Point);

      if((currentSL == 0.0 || breakEvenSL > desiredSL) &&
         breakEvenSL < currentPrice)
      {
         desiredSL = breakEvenSL;
         modify    = true;
      }
   }

   //--- Trailing Stop
   if(InpUseTrailingStop &&
      InpTrailingStart > 0 &&
      InpTrailingDistance > 0 &&
      profitPoints >= (double)InpTrailingStart)
   {
      const double trailingSL =
         currentPrice -
         ((double)InpTrailingDistance * _Point);

      if((desiredSL == 0.0 || trailingSL > desiredSL) &&
         trailingSL < currentPrice)
      {
         desiredSL = trailingSL;
         modify    = true;
      }
   }

   if(!modify)
      return;

   const double minStopDistance = MinimumStopDistance();
   const double maxAllowedSL    = currentPrice - minStopDistance;

   desiredSL = MathMin(desiredSL, maxAllowedSL);
   desiredSL = NormalizeDouble(desiredSL, _Digits);

   if(desiredSL <= 0.0)
      return;

   if(currentSL > 0.0 &&
      desiredSL <= currentSL + (_Point * 0.5))
      return;

   if(!trade.PositionModify(ticket, desiredSL, currentTP))
   {
      Print("BUY SL modification failed. Ticket=",
            ticket,
            " Retcode=",
            trade.ResultRetcode(),
            " Description=",
            trade.ResultRetcodeDescription());
   }
}

//+------------------------------------------------------------------+
//| Manage SELL position                                              |
//+------------------------------------------------------------------+
void ManageSellPosition(const ulong ticket,
                        const double openPrice,
                        const double currentSL,
                        const double currentTP,
                        const double currentPrice)
{
   const double profitPoints =
      (openPrice - currentPrice) / _Point;

   double desiredSL = currentSL;
   bool modify      = false;

   //--- Break Even
   if(InpUseBreakEven &&
      InpBreakEvenTrigger > 0 &&
      profitPoints >= (double)InpBreakEvenTrigger)
   {
      const double breakEvenSL =
         openPrice - ((double)InpBreakEvenOffset * _Point);

      if((currentSL == 0.0 || breakEvenSL < desiredSL) &&
         breakEvenSL > currentPrice)
      {
         desiredSL = breakEvenSL;
         modify    = true;
      }
   }

   //--- Trailing Stop
   if(InpUseTrailingStop &&
      InpTrailingStart > 0 &&
      InpTrailingDistance > 0 &&
      profitPoints >= (double)InpTrailingStart)
   {
      const double trailingSL =
         currentPrice +
         ((double)InpTrailingDistance * _Point);

      if((desiredSL == 0.0 || trailingSL < desiredSL) &&
         trailingSL > currentPrice)
      {
         desiredSL = trailingSL;
         modify    = true;
      }
   }

   if(!modify)
      return;

   const double minStopDistance = MinimumStopDistance();
   const double minAllowedSL    = currentPrice + minStopDistance;

   desiredSL = MathMax(desiredSL, minAllowedSL);
   desiredSL = NormalizeDouble(desiredSL, _Digits);

   if(desiredSL <= 0.0)
      return;

   if(currentSL > 0.0 &&
      desiredSL >= currentSL - (_Point * 0.5))
      return;

   if(!trade.PositionModify(ticket, desiredSL, currentTP))
   {
      Print("SELL SL modification failed. Ticket=",
            ticket,
            " Retcode=",
            trade.ResultRetcode(),
            " Description=",
            trade.ResultRetcodeDescription());
   }
}
//+------------------------------------------------------------------+