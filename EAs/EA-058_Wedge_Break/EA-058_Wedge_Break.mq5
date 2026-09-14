#property strict

#include <Trade\Trade.mqh>

CTrade trade;

//+------------------------------------------------------------------+
//| Input Parameters                                                 |
//+------------------------------------------------------------------+
input group "=== General Trading Settings ==="
input double InpLotSize             = 0.01;
input int    InpStopLoss            = 300;      // Stop Loss in points
input int    InpTakeProfit          = 600;      // Take Profit in points
input ulong  InpMagicNumber         = 123456;
input int    InpSlippage            = 10;
input int    InpMaxSpread           = 30;       // Maximum spread in points
input int    InpMaxPositions        = 1;        // Maximum EA positions

input group "=== Wedge Detection ==="
input int    InpWedgeLookback       = 30;       // Bars used to detect wedge
input int    InpPivotStrength       = 2;        // Pivot strength
input int    InpMinPivotDistance    = 3;        // Minimum bars between pivots
input int    InpBreakoutBuffer      = 5;        // Breakout confirmation buffer
input double InpMinContractionRatio = 0.10;     // Minimum wedge contraction
input double InpMaxContractionRatio = 0.80;     // Maximum wedge contraction

input group "=== Break Even ==="
input bool   InpUseBreakEven        = true;
input int    InpBreakEvenTrigger    = 150;      // Profit points before BE
input int    InpBreakEvenOffset     = 0;        // Lock-in points after BE

input group "=== Trailing Stop ==="
input bool   InpUseTrailingStop     = true;
input int    InpTrailingStart       = 200;      // Start trailing after profit
input int    InpTrailingDistance    = 150;      // Trailing distance in points
input int    InpTrailingStep        = 10;       // Minimum SL improvement

//+------------------------------------------------------------------+
//| Global Variables                                                 |
//+------------------------------------------------------------------+
datetime g_lastBarTime = 0;

//+------------------------------------------------------------------+
//| Structure for wedge data                                         |
//+------------------------------------------------------------------+
struct WedgeData
{
   bool     valid;
   double   upperCurrent;
   double   lowerCurrent;
   double   upperPrevious;
   double   lowerPrevious;
   double   upperSlope;
   double   lowerSlope;
   int      highBarOld;
   int      highBarNew;
   int      lowBarOld;
   int      lowBarNew;
};

//+------------------------------------------------------------------+
//| Expert initialization                                            |
//+------------------------------------------------------------------+
int OnInit()
{
   if(InpLotSize <= 0.0)
   {
      Print("Invalid lot size.");
      return(INIT_PARAMETERS_INCORRECT);
   }

   if(InpStopLoss <= 0 || InpTakeProfit <= 0)
   {
      Print("Stop Loss and Take Profit must be greater than zero.");
      return(INIT_PARAMETERS_INCORRECT);
   }

   if(InpWedgeLookback < 10)
   {
      Print("Wedge lookback must be at least 10 bars.");
      return(INIT_PARAMETERS_INCORRECT);
   }

   if(InpPivotStrength < 1)
   {
      Print("Pivot strength must be at least 1.");
      return(INIT_PARAMETERS_INCORRECT);
   }

   if(InpMaxSpread < 0 || InpSlippage < 0)
   {
      Print("Spread and slippage values cannot be negative.");
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
//| Expert deinitialization                                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   Print("EA stopped. Reason: ", reason);
}

//+------------------------------------------------------------------+
//| Expert tick                                                      |
//+------------------------------------------------------------------+
void OnTick()
{
   // Manage existing positions on every tick
   ManageOpenPositions();

   // Trading permission checks
   if(!IsTradingAllowed())
      return;

   // Strategy is evaluated only once per new candle
   if(!IsNewBar())
      return;

   // Spread filter
   if(!IsSpreadAllowed())
      return;

   // Only one position belonging to this EA
   if(CountEAOpenPositions() >= InpMaxPositions)
      return;

   // Enough bars required
   int requiredBars = InpWedgeLookback + InpPivotStrength + 10;
   if(Bars(_Symbol, _Period) < requiredBars)
      return;

   WedgeData wedge;
   if(!DetectWedge(wedge))
      return;

   CheckBreakoutAndTrade(wedge);
}

//+------------------------------------------------------------------+
//| Check whether a new bar has formed                               |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol, _Period, 0);

   if(currentBarTime <= 0)
      return(false);

   if(currentBarTime != g_lastBarTime)
   {
      g_lastBarTime = currentBarTime;
      return(true);
   }

   return(false);
}

//+------------------------------------------------------------------+
//| Trading permission checks                                        |
//+------------------------------------------------------------------+
bool IsTradingAllowed()
{
   if(!TerminalInfoInteger(TERMINAL_CONNECTED))
      return(false);

   if(!TerminalInfoInteger(TERMINAL_TRADE_ALLOWED))
      return(false);

   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return(false);

   if(!AccountInfoInteger(ACCOUNT_TRADE_ALLOWED))
      return(false);

   return(true);
}

//+------------------------------------------------------------------+
//| Spread filter                                                    |
//+------------------------------------------------------------------+
bool IsSpreadAllowed()
{
   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return(false);

   if(tick.ask <= 0.0 || tick.bid <= 0.0)
      return(false);

   double spreadPoints = (tick.ask - tick.bid) / _Point;

   return(spreadPoints <= (double)InpMaxSpread);
}

//+------------------------------------------------------------------+
//| Count positions for current symbol and Magic Number              |
//+------------------------------------------------------------------+
int CountEAOpenPositions()
{
   int count = 0;
   int total = PositionsTotal();

   for(int i = 0; i < total; i++)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      ulong magic   = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol == _Symbol && magic == InpMagicNumber)
         count++;
   }

   return(count);
}

//+------------------------------------------------------------------+
//| Determine whether bar is a pivot high                            |
//+------------------------------------------------------------------+
bool IsPivotHigh(const int shift)
{
   if(shift <= InpPivotStrength)
      return(false);

   double center = iHigh(_Symbol, _Period, shift);

   if(center <= 0.0)
      return(false);

   for(int j = 1; j <= InpPivotStrength; j++)
   {
      if(iHigh(_Symbol, _Period, shift - j) >= center)
         return(false);

      if(iHigh(_Symbol, _Period, shift + j) >= center)
         return(false);
   }

   return(true);
}

//+------------------------------------------------------------------+
//| Determine whether bar is a pivot low                             |
//+------------------------------------------------------------------+
bool IsPivotLow(const int shift)
{
   if(shift <= InpPivotStrength)
      return(false);

   double center = iLow(_Symbol, _Period, shift);

   if(center <= 0.0)
      return(false);

   for(int j = 1; j <= InpPivotStrength; j++)
   {
      if(iLow(_Symbol, _Period, shift - j) <= center)
         return(false);

      if(iLow(_Symbol, _Period, shift + j) <= center)
         return(false);
   }

   return(true);
}

//+------------------------------------------------------------------+
//| Detect contracting wedge                                         |
//+------------------------------------------------------------------+
bool DetectWedge(WedgeData &wedge)
{
   wedge.valid = false;

   int highNew = -1;
   int highOld = -1;
   int lowNew  = -1;
   int lowOld  = -1;

   // Search from recent bars toward older bars.
   for(int shift = InpPivotStrength + 2;
       shift <= InpWedgeLookback;
       shift++)
   {
      if(highNew < 0 && IsPivotHigh(shift))
      {
         highNew = shift;
      }
      else if(highNew >= 0 &&
              highOld < 0 &&
              IsPivotHigh(shift) &&
              (shift - highNew) >= InpMinPivotDistance)
      {
         highOld = shift;
      }

      if(lowNew < 0 && IsPivotLow(shift))
      {
         lowNew = shift;
      }
      else if(lowNew >= 0 &&
              lowOld < 0 &&
              IsPivotLow(shift) &&
              (shift - lowNew) >= InpMinPivotDistance)
      {
         lowOld = shift;
      }

      if(highOld >= 0 && lowOld >= 0)
         break;
   }

   if(highNew < 0 || highOld < 0 || lowNew < 0 || lowOld < 0)
      return(false);

   double highPriceNew = iHigh(_Symbol, _Period, highNew);
   double highPriceOld = iHigh(_Symbol, _Period, highOld);

   double lowPriceNew  = iLow(_Symbol, _Period, lowNew);
   double lowPriceOld  = iLow(_Symbol, _Period, lowOld);

   // Contracting wedge requirement:
   // recent pivot high should be lower than old pivot high,
   // recent pivot low should be higher than old pivot low.
   if(highPriceNew >= highPriceOld)
      return(false);

   if(lowPriceNew <= lowPriceOld)
      return(false);

   int highDeltaBars = highOld - highNew;
   int lowDeltaBars  = lowOld - lowNew;

   if(highDeltaBars <= 0 || lowDeltaBars <= 0)
      return(false);

   // Slope expressed as price change per bar moving toward present.
   double upperSlope =
      (highPriceNew - highPriceOld) / (double)highDeltaBars;

   double lowerSlope =
      (lowPriceNew - lowPriceOld) / (double)lowDeltaBars;

   // Upper trendline must descend and lower trendline must ascend.
   if(upperSlope >= 0.0)
      return(false);

   if(lowerSlope <= 0.0)
      return(false);

   // Project trendlines to closed bar 1 and bar 2.
   double upperBar1 =
      highPriceNew + upperSlope * (double)(highNew - 1);

   double upperBar2 =
      highPriceNew + upperSlope * (double)(highNew - 2);

   double lowerBar1 =
      lowPriceNew + lowerSlope * (double)(lowNew - 1);

   double lowerBar2 =
      lowPriceNew + lowerSlope * (double)(lowNew - 2);

   if(upperBar1 <= lowerBar1 || upperBar2 <= lowerBar2)
      return(false);

   double oldWidth = highPriceOld - lowPriceOld;
   double newWidth = upperBar1 - lowerBar1;

   if(oldWidth <= 0.0 || newWidth <= 0.0)
      return(false);

   double contraction =
      1.0 - (newWidth / oldWidth);

   if(contraction < InpMinContractionRatio)
      return(false);

   if(contraction > InpMaxContractionRatio)
      return(false);

   wedge.valid         = true;
   wedge.upperCurrent  = NormalizePrice(upperBar1);
   wedge.lowerCurrent  = NormalizePrice(lowerBar1);
   wedge.upperPrevious = NormalizePrice(upperBar2);
   wedge.lowerPrevious = NormalizePrice(lowerBar2);
   wedge.upperSlope    = upperSlope;
   wedge.lowerSlope    = lowerSlope;
   wedge.highBarOld    = highOld;
   wedge.highBarNew    = highNew;
   wedge.lowBarOld     = lowOld;
   wedge.lowBarNew     = lowNew;

   return(true);
}

//+------------------------------------------------------------------+
//| Check wedge breakout                                             |
//+------------------------------------------------------------------+
void CheckBreakoutAndTrade(const WedgeData &wedge)
{
   if(!wedge.valid)
      return;

   double close1 = iClose(_Symbol, _Period, 1);
   double close2 = iClose(_Symbol, _Period, 2);

   if(close1 <= 0.0 || close2 <= 0.0)
      return;

   double buffer = (double)InpBreakoutBuffer * _Point;

   bool buyBreakout =
      close2 <= (wedge.upperPrevious + buffer) &&
      close1 >  (wedge.upperCurrent + buffer);

   bool sellBreakout =
      close2 >= (wedge.lowerPrevious - buffer) &&
      close1 <  (wedge.lowerCurrent - buffer);

   if(buyBreakout && !sellBreakout)
   {
      OpenBuy();
      return;
   }

   if(sellBreakout && !buyBreakout)
   {
      OpenSell();
      return;
   }
}

//+------------------------------------------------------------------+
//| Open BUY                                                         |
//+------------------------------------------------------------------+
void OpenBuy()
{
   if(CountEAOpenPositions() >= InpMaxPositions)
      return;

   if(!IsSpreadAllowed())
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   double lot = NormalizeVolume(InpLotSize);

   if(lot <= 0.0)
      return;

   double sl = NormalizePrice(
      tick.ask - (double)InpStopLoss * _Point
   );

   double tp = NormalizePrice(
      tick.ask + (double)InpTakeProfit * _Point
   );

   AdjustStopsForBroker(ORDER_TYPE_BUY, tick.ask, sl, tp);

   ResetLastError();

   bool result = trade.Buy(
      lot,
      _Symbol,
      0.0,
      sl,
      tp,
      "Wedge Breakout BUY"
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
   }
   else
   {
      Print(
         "BUY opened successfully. Order=",
         trade.ResultOrder(),
         ", Deal=",
         trade.ResultDeal()
      );
   }
}

//+------------------------------------------------------------------+
//| Open SELL                                                        |
//+------------------------------------------------------------------+
void OpenSell()
{
   if(CountEAOpenPositions() >= InpMaxPositions)
      return;

   if(!IsSpreadAllowed())
      return;

   MqlTick tick;

   if(!SymbolInfoTick(_Symbol, tick))
      return;

   double lot = NormalizeVolume(InpLotSize);

   if(lot <= 0.0)
      return;

   double sl = NormalizePrice(
      tick.bid + (double)InpStopLoss * _Point
   );

   double tp = NormalizePrice(
      tick.bid - (double)InpTakeProfit * _Point
   );

   AdjustStopsForBroker(ORDER_TYPE_SELL, tick.bid, sl, tp);

   ResetLastError();

   bool result = trade.Sell(
      lot,
      _Symbol,
      0.0,
      sl,
      tp,
      "Wedge Breakout SELL"
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
   }
   else
   {
      Print(
         "SELL opened successfully. Order=",
         trade.ResultOrder(),
         ", Deal=",
         trade.ResultDeal()
      );
   }
}

//+------------------------------------------------------------------+
//| Manage Break Even and Trailing Stop                              |
//+------------------------------------------------------------------+
void ManageOpenPositions()
{
   int total = PositionsTotal();

   for(int i = total - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);

      if(ticket == 0)
         continue;

      if(!PositionSelectByTicket(ticket))
         continue;

      string symbol = PositionGetString(POSITION_SYMBOL);
      ulong magic   = (ulong)PositionGetInteger(POSITION_MAGIC);

      if(symbol != _Symbol || magic != InpMagicNumber)
         continue;

      ENUM_POSITION_TYPE positionType =
         (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);

      double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      double currentSL = PositionGetDouble(POSITION_SL);
      double currentTP = PositionGetDouble(POSITION_TP);

      MqlTick tick;

      if(!SymbolInfoTick(symbol, tick))
         continue;

      if(positionType == POSITION_TYPE_BUY)
      {
         ManageBuyPosition(
            ticket,
            openPrice,
            currentSL,
            currentTP,
            tick.bid
         );
      }
      else if(positionType == POSITION_TYPE_SELL)
      {
         ManageSellPosition(
            ticket,
            openPrice,
            currentSL,
            currentTP,
            tick.ask
         );
      }
   }
}

//+------------------------------------------------------------------+
//| Manage BUY                                                       |
//+------------------------------------------------------------------+
void ManageBuyPosition(
   const ulong ticket,
   const double openPrice,
   const double currentSL,
   const double currentTP,
   const double currentBid
)
{
   double profitPoints =
      (currentBid - openPrice) / _Point;

   double newSL = currentSL;
   bool modifyNeeded = false;

   // Break Even
   if(InpUseBreakEven &&
      profitPoints >= (double)InpBreakEvenTrigger)
   {
      double breakEvenSL =
         NormalizePrice(
            openPrice +
            (double)InpBreakEvenOffset * _Point
         );

      if((currentSL == 0.0 || breakEvenSL > currentSL) &&
         breakEvenSL < currentBid)
      {
         newSL = breakEvenSL;
         modifyNeeded = true;
      }
   }

   // Trailing Stop
   if(InpUseTrailingStop &&
      profitPoints >= (double)InpTrailingStart)
   {
      double trailingSL =
         NormalizePrice(
            currentBid -
            (double)InpTrailingDistance * _Point
         );

      double referenceSL = newSL;

      if(referenceSL == 0.0 ||
         trailingSL >
         referenceSL +
         (double)InpTrailingStep * _Point)
      {
         if(trailingSL > openPrice && trailingSL < currentBid)
         {
            newSL = trailingSL;
            modifyNeeded = true;
         }
      }
   }

   if(!modifyNeeded)
      return;

   double minDistance = GetBrokerStopDistance();

   if((currentBid - newSL) < minDistance)
      newSL = NormalizePrice(currentBid - minDistance);

   if(newSL <= 0.0 || newSL >= currentBid)
      return;

   if(currentSL > 0.0 &&
      newSL <= currentSL + (_Point * 0.5))
      return;

   ModifyPositionStops(ticket, newSL, currentTP);
}

//+------------------------------------------------------------------+
//| Manage SELL                                                      |
//+------------------------------------------------------------------+
void ManageSellPosition(
   const ulong ticket,
   const double openPrice,
   const double currentSL,
   const double currentTP,
   const double currentAsk
)
{
   double profitPoints =
      (openPrice - currentAsk) / _Point;

   double newSL = currentSL;
   bool modifyNeeded = false;

   // Break Even
   if(InpUseBreakEven &&
      profitPoints >= (double)InpBreakEvenTrigger)
   {
      double breakEvenSL =
         NormalizePrice(
            openPrice -
            (double)InpBreakEvenOffset * _Point
         );

      if((currentSL == 0.0 || breakEvenSL < currentSL) &&
         breakEvenSL > currentAsk)
      {
         newSL = breakEvenSL;
         modifyNeeded = true;
      }
   }

   // Trailing Stop
   if(InpUseTrailingStop &&
      profitPoints >= (double)InpTrailingStart)
   {
      double trailingSL =
         NormalizePrice(
            currentAsk +
            (double)InpTrailingDistance * _Point
         );

      double referenceSL = newSL;

      if(referenceSL == 0.0 ||
         trailingSL <
         referenceSL -
         (double)InpTrailingStep * _Point)
      {
         if(trailingSL < openPrice && trailingSL > currentAsk)
         {
            newSL = trailingSL;
            modifyNeeded = true;
         }
      }
   }

   if(!modifyNeeded)
      return;

   double minDistance = GetBrokerStopDistance();

   if((newSL - currentAsk) < minDistance)
      newSL = NormalizePrice(currentAsk + minDistance);

   if(newSL <= currentAsk)
      return;

   if(currentSL > 0.0 &&
      newSL >= currentSL - (_Point * 0.5))
      return;

   ModifyPositionStops(ticket, newSL, currentTP);
}

//+------------------------------------------------------------------+
//| Modify position SL/TP by ticket                                  |
//+------------------------------------------------------------------+
bool ModifyPositionStops(
   const ulong ticket,
   const double stopLoss,
   const double takeProfit
)
{
   MqlTradeRequest request;
   MqlTradeResult  result;

   ZeroMemory(request);
   ZeroMemory(result);

   request.action   = TRADE_ACTION_SLTP;
   request.position = ticket;
   request.symbol   = _Symbol;
   request.magic    = InpMagicNumber;
   request.sl       = NormalizePrice(stopLoss);
   request.tp       = NormalizePrice(takeProfit);

   ResetLastError();

   if(!OrderSend(request, result))
   {
      Print(
         "Position modification failed. Ticket=",
         ticket,
         ", Error=",
         GetLastError()
      );

      return(false);
   }

   if(result.retcode != TRADE_RETCODE_DONE &&
      result.retcode != TRADE_RETCODE_DONE_PARTIAL)
   {
      Print(
         "Position modification rejected. Ticket=",
         ticket,
         ", Retcode=",
         result.retcode,
         ", Comment=",
         result.comment
      );

      return(false);
   }

   return(true);
}

//+------------------------------------------------------------------+
//| Adjust initial SL/TP to broker minimum distance                  |
//+------------------------------------------------------------------+
void AdjustStopsForBroker(
   const ENUM_ORDER_TYPE orderType,
   const double entryPrice,
   double &stopLoss,
   double &takeProfit
)
{
   double minDistance = GetBrokerStopDistance();

   if(orderType == ORDER_TYPE_BUY)
   {
      if((entryPrice - stopLoss) < minDistance)
         stopLoss = NormalizePrice(entryPrice - minDistance);

      if((takeProfit - entryPrice) < minDistance)
         takeProfit = NormalizePrice(entryPrice + minDistance);
   }
   else if(orderType == ORDER_TYPE_SELL)
   {
      if((stopLoss - entryPrice) < minDistance)
         stopLoss = NormalizePrice(entryPrice + minDistance);

      if((entryPrice - takeProfit) < minDistance)
         takeProfit = NormalizePrice(entryPrice - minDistance);
   }
}

//+------------------------------------------------------------------+
//| Get minimum broker stop distance                                 |
//+------------------------------------------------------------------+
double GetBrokerStopDistance()
{
   long stopsLevel =
      SymbolInfoInteger(_Symbol, SYMBOL_TRADE_STOPS_LEVEL);

   long freezeLevel =
      SymbolInfoInteger(_Symbol, SYMBOL_TRADE_FREEZE_LEVEL);

   long requiredLevel = MathMax(stopsLevel, freezeLevel);

   if(requiredLevel < 1)
      requiredLevel = 1;

   return((double)requiredLevel * _Point);
}

//+------------------------------------------------------------------+
//| Normalize price                                                  |
//+------------------------------------------------------------------+
double NormalizePrice(const double price)
{
   int digits =
      (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);

   return(NormalizeDouble(price, digits));
}

//+------------------------------------------------------------------+
//| Normalize trading volume                                         |
//+------------------------------------------------------------------+
double NormalizeVolume(const double requestedVolume)
{
   double minVolume =
      SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);

   double maxVolume =
      SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);

   double volumeStep =
      SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);

   if(minVolume <= 0.0 ||
      maxVolume <= 0.0 ||
      volumeStep <= 0.0)
   {
      return(0.0);
   }

   double volume =
      MathMax(minVolume, MathMin(maxVolume, requestedVolume));

   volume =
      MathFloor(volume / volumeStep + 0.0000001) * volumeStep;

   volume =
      MathMax(minVolume, MathMin(maxVolume, volume));

   int volumeDigits = 0;
   double tempStep = volumeStep;

   while(tempStep < 1.0 && volumeDigits < 8)
   {
      tempStep *= 10.0;
      volumeDigits++;
   }

   return(NormalizeDouble(volume, volumeDigits));
}