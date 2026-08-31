#property copyright "Expert Advisor based on HH-HL / LH-LL structure"
#property link      ""
#property version   "1.00"
#property strict

#include <Trade\Trade.mqh>

//--- input parameters
input double   InpLotSize        = 0.01;      // Lot size
input int      InpStopLoss       = 300;       // Stop Loss (points)
input int      InpTakeProfit     = 600;       // Take Profit (points)
input ulong    InpMagicNumber    = 123456;    // Magic Number
input int      InpSlippage       = 10;        // Slippage (points)
input int      InpMaxSpread      = 30;        // Maximum spread (points)
input bool     InpUseBreakEven   = true;      // Use Break Even
input int      InpBreakEvenTrigger = 150;     // Break Even trigger (points)
input int      InpBreakEvenLock  = 10;        // Break Even lock profit (points)
input bool     InpUseTrailingStop = true;     // Use Trailing Stop
input int      InpTrailingStart  = 200;       // Trailing start (points)
input int      InpTrailingStep   = 50;        // Trailing step (points)

//--- global variables
CTrade  trade;
MqlTick currentTick;
MqlRates currentBar;

//--- structure for swing points
struct SwingPoint
  {
   datetime          time;
   double            price;
   int               index;
  };

//--- variables to track market structure
SwingPoint         lastSwingHigh;
SwingPoint         lastSwingLow;
SwingPoint         previousSwingHigh;
SwingPoint         previousSwingLow;
bool               isNewHH = false;
bool               isNewHL = false;
bool               isNewLH = false;
bool               isNewLL = false;
datetime           lastBarTime = 0;
bool               initialized = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   //--- set magic number and slippage
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   
   //--- reset variables
   lastBarTime = 0;
   initialized = false;
   lastSwingHigh.time = 0;
   lastSwingHigh.price = 0;
   lastSwingHigh.index = -1;
   lastSwingLow.time = 0;
   lastSwingLow.price = 0;
   lastSwingLow.index = -1;
   previousSwingHigh.time = 0;
   previousSwingHigh.price = 0;
   previousSwingHigh.index = -1;
   previousSwingLow.time = 0;
   previousSwingLow.price = 0;
   previousSwingLow.index = -1;
   
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   //--- nothing to do
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   //--- get current tick
   if(!SymbolInfoTick(_Symbol, currentTick))
     {
      Print("Failed to get tick data");
      return;
     }
   
   //--- check spread
   int currentSpread = (int)((currentTick.ask - currentTick.bid) / _Point);
   if(currentSpread > InpMaxSpread)
      return; // spread too high
   
   //--- check for new bar
   if(!IsNewBar())
      return; // not a new bar
   
   //--- update market structure
   UpdateMarketStructure();
   
   //--- check for existing positions
   if(PositionExists())
      return; // already have a position
   
   //--- check for trading signals
   if(isNewHH && isNewHL)
     {
      //--- bullish structure confirmed (HH-HL)
      OpenBuyOrder();
     }
   else if(isNewLH && isNewLL)
     {
      //--- bearish structure confirmed (LH-LL)
      OpenSellOrder();
     }
   
   //--- manage open positions
   if(InpUseBreakEven)
      ApplyBreakEven();
   if(InpUseTrailingStop)
      ApplyTrailingStop();
  }
//+------------------------------------------------------------------+
//| Check if new bar has formed                                      |
//+------------------------------------------------------------------+
bool IsNewBar()
  {
   datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);
   
   if(currentBarTime != lastBarTime)
     {
      lastBarTime = currentBarTime;
      return(true);
     }
   
   return(false);
  }
//+------------------------------------------------------------------+
//| Update market structure (detect swings and structure)            |
//+------------------------------------------------------------------+
void UpdateMarketStructure()
  {
   //--- reset flags
   isNewHH = false;
   isNewHL = false;
   isNewLH = false;
   isNewLL = false;
   
   //--- get recent bars for analysis
   int barsToCheck = 10;
   MqlRates rates[];
   ArraySetAsSeries(rates, true);
   
   if(CopyRates(_Symbol, PERIOD_CURRENT, 0, barsToCheck, rates) < barsToCheck)
      return;
   
   //--- detect swing points (fractals)
   for(int i = 2; i < barsToCheck - 2; i++)
     {
      //--- swing high detection (3-bar fractal)
      if(rates[i].high > rates[i-1].high && rates[i].high > rates[i-2].high &&
         rates[i].high > rates[i+1].high && rates[i].high > rates[i+2].high)
        {
         if(lastSwingHigh.time == 0 || rates[i].time > lastSwingHigh.time)
           {
            previousSwingHigh = lastSwingHigh;
            lastSwingHigh.time = rates[i].time;
            lastSwingHigh.price = rates[i].high;
            lastSwingHigh.index = i;
           }
        }
      
      //--- swing low detection (3-bar fractal)
      if(rates[i].low < rates[i-1].low && rates[i].low < rates[i-2].low &&
         rates[i].low < rates[i+1].low && rates[i].low < rates[i+2].low)
        {
         if(lastSwingLow.time == 0 || rates[i].time > lastSwingLow.time)
           {
            previousSwingLow = lastSwingLow;
            lastSwingLow.time = rates[i].time;
            lastSwingLow.price = rates[i].low;
            lastSwingLow.index = i;
           }
        }
     }
   
   //--- analyze market structure
   if(lastSwingHigh.time > 0 && previousSwingHigh.time > 0)
     {
      if(lastSwingHigh.price > previousSwingHigh.price)
         isNewHH = true; // higher high formed
     }
   
   if(lastSwingLow.time > 0 && previousSwingLow.time > 0)
     {
      if(lastSwingLow.price > previousSwingLow.price)
         isNewHL = true; // higher low formed
     }
   
   if(lastSwingHigh.time > 0 && previousSwingHigh.time > 0)
     {
      if(lastSwingHigh.price < previousSwingHigh.price)
         isNewLH = true; // lower high formed
     }
   
   if(lastSwingLow.time > 0 && previousSwingLow.time > 0)
     {
      if(lastSwingLow.price < previousSwingLow.price)
         isNewLL = true; // lower low formed
     }
   
   //--- initialize flags on first run
   if(!initialized)
     {
      isNewHH = false;
      isNewHL = false;
      isNewLH = false;
      isNewLL = false;
      initialized = true;
     }
  }
//+------------------------------------------------------------------+
//| Open buy order                                                   |
//+------------------------------------------------------------------+
void OpenBuyOrder()
  {
   double price = currentTick.ask;
   double sl = price - InpStopLoss * _Point;
   double tp = price + InpTakeProfit * _Point;
   
   //--- normalize prices
   price = NormalizeDouble(price, _Digits);
   sl = NormalizeDouble(sl, _Digits);
   tp = NormalizeDouble(tp, _Digits);
   
   if(trade.Buy(InpLotSize, _Symbol, price, sl, tp, "Buy HH-HL"))
     {
      Print("Buy order opened successfully");
     }
   else
     {
      Print("Failed to open buy order. Error: ", trade.ResultRetcode());
     }
  }
//+------------------------------------------------------------------+
//| Open sell order                                                  |
//+------------------------------------------------------------------+
void OpenSellOrder()
  {
   double price = currentTick.bid;
   double sl = price + InpStopLoss * _Point;
   double tp = price - InpTakeProfit * _Point;
   
   //--- normalize prices
   price = NormalizeDouble(price, _Digits);
   sl = NormalizeDouble(sl, _Digits);
   tp = NormalizeDouble(tp, _Digits);
   
   if(trade.Sell(InpLotSize, _Symbol, price, sl, tp, "Sell LH-LL"))
     {
      Print("Sell order opened successfully");
     }
   else
     {
      Print("Failed to open sell order. Error: ", trade.ResultRetcode());
     }
  }
//+------------------------------------------------------------------+
//| Check if position exists for this EA                             |
//+------------------------------------------------------------------+
bool PositionExists()
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong positionTicket = PositionGetTicket(i);
      if(positionTicket > 0)
        {
         ulong magic = PositionGetInteger(POSITION_MAGIC);
         if(magic == InpMagicNumber)
            return(true);
        }
     }
   
   return(false);
  }
//+------------------------------------------------------------------+
//| Apply break even logic                                           |
//+------------------------------------------------------------------+
void ApplyBreakEven()
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong positionTicket = PositionGetTicket(i);
      if(positionTicket > 0)
        {
         ulong magic = PositionGetInteger(POSITION_MAGIC);
         if(magic != InpMagicNumber)
            continue;
         
         long positionType = PositionGetInteger(POSITION_TYPE);
         double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
         double currentSL = PositionGetDouble(POSITION_SL);
         
         if(positionType == POSITION_TYPE_BUY)
           {
            double newSL = openPrice + InpBreakEvenLock * _Point;
            if(currentTick.bid - openPrice >= InpBreakEvenTrigger * _Point)
              {
               if(currentSL < newSL)
                 {
                  trade.PositionModify(positionTicket, newSL, PositionGetDouble(POSITION_TP));
                 }
              }
           }
         else if(positionType == POSITION_TYPE_SELL)
           {
            double newSL = openPrice - InpBreakEvenLock * _Point;
            if(openPrice - currentTick.ask >= InpBreakEvenTrigger * _Point)
              {
               if(currentSL > newSL)
                 {
                  trade.PositionModify(positionTicket, newSL, PositionGetDouble(POSITION_TP));
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Apply trailing stop logic                                        |
//+------------------------------------------------------------------+
void ApplyTrailingStop()
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong positionTicket = PositionGetTicket(i);
      if(positionTicket > 0)
        {
         ulong magic = PositionGetInteger(POSITION_MAGIC);
         if(magic != InpMagicNumber)
            continue;
         
         long positionType = PositionGetInteger(POSITION_TYPE);
         double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
         double currentSL = PositionGetDouble(POSITION_SL);
         
         if(positionType == POSITION_TYPE_BUY)
           {
            double newSL = currentTick.bid - InpTrailingStep * _Point;
            if(currentTick.bid - openPrice >= InpTrailingStart * _Point)
              {
               if(newSL > currentSL)
                 {
                  trade.PositionModify(positionTicket, newSL, PositionGetDouble(POSITION_TP));
                 }
              }
           }
         else if(positionType == POSITION_TYPE_SELL)
           {
            double newSL = currentTick.ask + InpTrailingStep * _Point;
            if(openPrice - currentTick.ask >= InpTrailingStart * _Point)
              {
               if(newSL < currentSL)
                 {
                  trade.PositionModify(positionTicket, newSL, PositionGetDouble(POSITION_TP));
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+