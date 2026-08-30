//+------------------------------------------------------------------+
//|                                           SAR_EMA_StrategyEA.mq5 |
//|                                    Senior MQL5 Developer         |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Senior MQL5 Developer"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\Trade.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\AccountInfo.mqh>

//--- Input Parameters
input group "=== Lot Size ==="
input double InpLotSize = 0.01;               // Lot size

input group "=== Risk Management ==="
input int    InpStopLoss = 300;               // Stop Loss (points)
input int    InpTakeProfit = 600;             // Take Profit (points)

input group "=== Order Settings ==="
input ulong  InpMagicNumber = 123456;         // Magic Number
input int    InpSlippage = 10;                // Slippage/Deviation (points)

input group "=== Trade Filters ==="
input int    InpMaxSpread = 30;               // Maximum Spread (points)
input int    InpMaxPositions = 1;             // Maximum Open Positions

input group "=== Break Even ==="
input bool   InpUseBreakEven = true;          // Enable Break Even
input int    InpBreakEvenTrigger = 150;       // Break Even Trigger (points)
input int    InpBreakEvenLock = 0;            // Break Even Lock (points)

input group "=== Trailing Stop ==="
input bool   InpUseTrailingStop = true;       // Enable Trailing Stop
input int    InpTrailingStart = 200;          // Trailing Start (points)
input int    InpTrailingStep = 50;            // Trailing Step (points)

//--- Global Variables
CTrade         trade;
CPositionInfo  posInfo;
CAccountInfo   accountInfo;

datetime        lastBarTime = 0;
int             sarHandle = INVALID_HANDLE;
int             emaHandle = INVALID_HANDLE;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   //--- Validate inputs
   if(InpLotSize <= 0)
     {
      Print("Lot size must be greater than 0");
      return(INIT_PARAMETERS_INCORRECT);
     }

   if(InpStopLoss <= 0)
     {
      Print("Stop Loss must be greater than 0");
      return(INIT_PARAMETERS_INCORRECT);
     }

   if(InpTakeProfit <= 0)
     {
      Print("Take Profit must be greater than 0");
      return(INIT_PARAMETERS_INCORRECT);
     }

   if(InpMaxSpread <= 0)
     {
      Print("Maximum spread must be greater than 0");
      return(INIT_PARAMETERS_INCORRECT);
     }

   if(InpMaxPositions < 1)
     {
      Print("Maximum positions must be at least 1");
      return(INIT_PARAMETERS_INCORRECT);
     }

   //--- Initialize indicator handles
   sarHandle = iSAR(_Symbol, PERIOD_CURRENT, 0.02, 0.2);
   if(sarHandle == INVALID_HANDLE)
     {
      Print("Failed to create SAR indicator handle. Error: ", GetLastError());
      return(INIT_FAILED);
     }

   emaHandle = iMA(_Symbol, PERIOD_CURRENT, 50, 0, MODE_EMA, PRICE_CLOSE);
   if(emaHandle == INVALID_HANDLE)
     {
      Print("Failed to create EMA indicator handle. Error: ", GetLastError());
      return(INIT_FAILED);
     }

   //--- Set trade object parameters
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);

   //--- Initialize last bar time
   lastBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);

   Print("SAR & EMA Strategy EA initialized successfully on ", _Symbol);
   Print("Parameters loaded successfully.");
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   //--- Release indicator handles
   if(sarHandle != INVALID_HANDLE)
     {
      IndicatorRelease(sarHandle);
      sarHandle = INVALID_HANDLE;
     }

   if(emaHandle != INVALID_HANDLE)
     {
      IndicatorRelease(emaHandle);
      emaHandle = INVALID_HANDLE;
     }

   Print("SAR & EMA Strategy EA deinitialized. Reason code: ", reason);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   //--- Check if we have enough bars
   if(Bars(_Symbol, PERIOD_CURRENT) < 60)
     {
      Print("Not enough bars loaded, waiting...");
      return;
     }

   //--- Check for new bar
   if(!IsNewBar())
      return;

   //--- Check if market is closed or paused (avoid trading during holidays)
   if(!IsTradingAllowed())
      return;

   //--- Check maximum spread
   if(!CheckSpread())
      return;

   //--- Manage existing positions (Break Even and Trailing Stop)
   ManagePositions();

   //--- Count open positions with our magic number
   int openPositions = CountOpenPositions();

   //--- If we already have maximum positions, skip signal generation
   if(openPositions >= InpMaxPositions)
      return;

   //--- Get indicator values
   double sarBuffer[];
   double emaBuffer[];
   ArraySetAsSeries(sarBuffer, true);
   ArraySetAsSeries(emaBuffer, true);

   if(CopyBuffer(sarHandle, 0, 1, 3, sarBuffer) < 3)
     {
      Print("Failed to copy SAR buffer. Error: ", GetLastError());
      return;
     }

   if(CopyBuffer(emaHandle, 0, 1, 3, emaBuffer) < 3)
     {
      Print("Failed to copy EMA buffer. Error: ", GetLastError());
      return;
     }

   //--- Get current price values
   double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double currentSAR = sarBuffer[0];
   double currentEMA = emaBuffer[0];

   //--- Check for BUY signal: SAR below price AND price above EMA50
   bool buySignal = (currentSAR < currentPrice) && (currentPrice > currentEMA);

   //--- Check for SELL signal: SAR above price AND price below EMA50
   bool sellSignal = (currentSAR > currentPrice) && (currentPrice < currentEMA);

   //--- Execute BUY order
   if(buySignal)
     {
      ExecuteOrder(ORDER_TYPE_BUY);
      return;
     }

   //--- Execute SELL order
   if(sellSignal)
     {
      ExecuteOrder(ORDER_TYPE_SELL);
      return;
     }
  }
//+------------------------------------------------------------------+
//| Check for new bar                                                |
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
//| Check if trading is allowed                                      |
//+------------------------------------------------------------------+
bool IsTradingAllowed()
  {
   //--- Check if auto trading is allowed
   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
     {
      Print("Auto trading is not allowed. Please enable 'Algo Trading' in MT5 settings.");
      return(false);
     }

   //--- Check if trading for the symbol is allowed
   if(!SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE))
     {
      Print("Trading is not allowed for symbol ", _Symbol);
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
//| Check maximum spread                                             |
//+------------------------------------------------------------------+
bool CheckSpread()
  {
   double currentSpread = (SymbolInfoDouble(_Symbol, SYMBOL_ASK) - 
                           SymbolInfoDouble(_Symbol, SYMBOL_BID)) / _Point;

   if(currentSpread > InpMaxSpread)
     {
      Print("Spread too high: ", currentSpread, " points (max: ", InpMaxSpread, ")");
      return(false);
     }

   return(true);
  }
//+------------------------------------------------------------------+
//| Count open positions with our magic number                       |
//+------------------------------------------------------------------+
int CountOpenPositions()
  {
   int count = 0;

   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      if(posInfo.SelectByIndex(i))
        {
         if(posInfo.Symbol() == _Symbol && posInfo.Magic() == InpMagicNumber)
           {
            count++;
           }
        }
     }

   return(count);
  }
//+------------------------------------------------------------------+
//| Execute order                                                    |
//+------------------------------------------------------------------+
void ExecuteOrder(ENUM_ORDER_TYPE orderType)
  {
   double price = 0.0;
   double sl = 0.0;
   double tp = 0.0;
   double point = _Point;

   //--- Prepare price, SL and TP values
   if(orderType == ORDER_TYPE_BUY)
     {
      price = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      sl = price - InpStopLoss * point;
      tp = price + InpTakeProfit * point;
     }
   else if(orderType == ORDER_TYPE_SELL)
     {
      price = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      sl = price + InpStopLoss * point;
      tp = price - InpTakeProfit * point;
     }

   //--- Normalize price values
   price = NormalizeDouble(price, _Digits);
   sl = NormalizeDouble(sl, _Digits);
   tp = NormalizeDouble(tp, _Digits);

   //--- Execute trade based on order type
   bool result = false;

   if(orderType == ORDER_TYPE_BUY)
     {
      result = trade.Buy(InpLotSize, _Symbol, price, sl, tp, "SAR & EMA BUY Signal");
     }
   else if(orderType == ORDER_TYPE_SELL)
     {
      result = trade.Sell(InpLotSize, _Symbol, price, sl, tp, "SAR & EMA SELL Signal");
     }

   //--- Check result
   if(result)
     {
      Print("Order executed successfully: ", EnumToString(orderType), 
            " | Price: ", price, " | SL: ", sl, " | TP: ", tp);
     }
   else
     {
      Print("Order execution failed for ", EnumToString(orderType), 
            " | Error: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
     }
  }
//+------------------------------------------------------------------+
//| Manage existing positions (Break Even and Trailing Stop)         |
//+------------------------------------------------------------------+
void ManagePositions()
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      if(posInfo.SelectByIndex(i))
        {
         //--- Only manage positions from this EA
         if(posInfo.Symbol() == _Symbol && posInfo.Magic() == InpMagicNumber)
           {
            //--- Apply Break Even
            if(InpUseBreakEven)
               ApplyBreakEven(posInfo.Ticket());

            //--- Apply Trailing Stop
            if(InpUseTrailingStop)
               ApplyTrailingStop(posInfo.Ticket());
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Apply Break Even to position                                     |
//+------------------------------------------------------------------+
void ApplyBreakEven(ulong ticket)
  {
   if(!posInfo.SelectByTicket(ticket))
      return;

   double currentPrice = 0.0;
   double openPrice = posInfo.PriceOpen();
   double currentSL = posInfo.StopLoss();
   double point = _Point;
   double breakEvenLevel = 0.0;

   //--- Determine current price and break even level
   if(posInfo.PositionType() == POSITION_TYPE_BUY)
     {
      currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      breakEvenLevel = openPrice + InpBreakEvenTrigger * point;

      //--- Check if price moved enough for break even
      if(currentPrice >= breakEvenLevel && currentSL < openPrice + InpBreakEvenLock * point)
        {
         double newSL = openPrice + InpBreakEvenLock * point;
         newSL = NormalizeDouble(newSL, _Digits);

         if(newSL != currentSL)
           {
            if(trade.PositionModify(ticket, newSL, posInfo.TakeProfit()))
              {
               Print("Break Even applied to position ", ticket, " | New SL: ", newSL);
              }
            else
              {
               Print("Failed to apply Break Even to position ", ticket, 
                     " | Error: ", trade.ResultRetcode());
              }
           }
        }
     }
   else if(posInfo.PositionType() == POSITION_TYPE_SELL)
     {
      currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      breakEvenLevel = openPrice - InpBreakEvenTrigger * point;

      //--- Check if price moved enough for break even
      if(currentPrice <= breakEvenLevel && currentSL > openPrice - InpBreakEvenLock * point)
        {
         double newSL = openPrice - InpBreakEvenLock * point;
         newSL = NormalizeDouble(newSL, _Digits);

         if(newSL != currentSL)
           {
            if(trade.PositionModify(ticket, newSL, posInfo.TakeProfit()))
              {
               Print("Break Even applied to position ", ticket, " | New SL: ", newSL);
              }
            else
              {
               Print("Failed to apply Break Even to position ", ticket, 
                     " | Error: ", trade.ResultRetcode());
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//| Apply Trailing Stop to position                                  |
//+------------------------------------------------------------------+
void ApplyTrailingStop(ulong ticket)
  {
   if(!posInfo.SelectByTicket(ticket))
      return;

   double currentPrice = 0.0;
   double currentSL = posInfo.StopLoss();
   double openPrice = posInfo.PriceOpen();
   double point = _Point;
   double newSL = 0.0;
   double trailingLevel = 0.0;

   //--- Determine current price and trailing level
   if(posInfo.PositionType() == POSITION_TYPE_BUY)
     {
      currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      trailingLevel = openPrice + InpTrailingStart * point;

      //--- Check if price moved enough to start trailing
      if(currentPrice >= trailingLevel)
        {
         newSL = currentPrice - InpTrailingStep * point;
         newSL = NormalizeDouble(newSL, _Digits);

         //--- Only move SL forward (never backward)
         if(newSL > currentSL && newSL > openPrice)
           {
            if(trade.PositionModify(ticket, newSL, posInfo.TakeProfit()))
              {
               Print("Trailing Stop applied to position ", ticket, " | New SL: ", newSL);
              }
            else
              {
               Print("Failed to apply Trailing Stop to position ", ticket, 
                     " | Error: ", trade.ResultRetcode());
              }
           }
        }
     }
   else if(posInfo.PositionType() == POSITION_TYPE_SELL)
     {
      currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      trailingLevel = openPrice - InpTrailingStart * point;

      //--- Check if price moved enough to start trailing
      if(currentPrice <= trailingLevel)
        {
         newSL = currentPrice + InpTrailingStep * point;
         newSL = NormalizeDouble(newSL, _Digits);

         //--- Only move SL forward (never backward)
         if(newSL < currentSL && newSL < openPrice)
           {
            if(trade.PositionModify(ticket, newSL, posInfo.TakeProfit()))
              {
               Print("Trailing Stop applied to position ", ticket, " | New SL: ", newSL);
              }
            else
              {
               Print("Failed to apply Trailing Stop to position ", ticket, 
                     " | Error: ", trade.ResultRetcode());
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+