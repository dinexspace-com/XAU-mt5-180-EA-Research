//+------------------------------------------------------------------+
//|                                                  IchimokuEA.mq5 |
//|                                    Senior MQL5 Developer         |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Senior MQL5 Developer"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#include <Trade\Trade.mqh>

//--- Input Parameters
input double   InpLotSize       = 0.01;       // Lot Size
input int      InpStopLoss      = 300;        // Stop Loss (points)
input int      InpTakeProfit    = 600;        // Take Profit (points)
input ulong    InpMagicNumber   = 123456;     // Magic Number
input int      InpSlippage      = 10;         // Slippage (points)
input int      InpMaxSpread     = 30;         // Maximum Spread (points)
input int      InpTenkanSen     = 9;          // Tenkan-sen Period
input int      InpKijunSen      = 26;         // Kijun-sen Period
input int      InpSenkouSpanB   = 52;         // Senkou Span B Period

//--- Break Even & Trailing Stop Groups
input group "Break Even Settings"
input bool     InpUseBreakEven  = true;       // Use Break Even
input int      InpBreakEvenTrigger = 150;     // Break Even Trigger (points)
input int      InpBreakEvenLevel   = 0;       // Break Even Level (points)

input group "Trailing Stop Settings"
input bool     InpUseTrailing   = true;       // Use Trailing Stop
input int      InpTrailingStart = 200;        // Trailing Start (points)
input int      InpTrailingStep  = 50;         // Trailing Step (points)

//--- Global Variables
CTrade  trade;
MqlTick currentTick;
datetime lastBarTime = 0;
int      tenkanHandle = INVALID_HANDLE;
int      kijunHandle = INVALID_HANDLE;
int      senkouSpanAHandle = INVALID_HANDLE;
int      senkouSpanBHandle = INVALID_HANDLE;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   //--- Set magic number and slippage
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetTypeFillingBySymbol(_Symbol);
   
   //--- Initialize Ichimoku indicator handles
   tenkanHandle = iIchimoku(_Symbol, PERIOD_CURRENT, InpTenkanSen, InpKijunSen, InpSenkouSpanB);
   if(tenkanHandle == INVALID_HANDLE)
     {
      Print("Failed to create Ichimoku indicator handle");
      return(INIT_FAILED);
     }
   
   //--- Validate inputs
   if(InpLotSize <= 0)
     {
      Print("Invalid Lot Size");
      return(INIT_PARAMETERS_INCORRECT);
     }
   
   if(InpStopLoss <= 0 || InpTakeProfit <= 0)
     {
      Print("Invalid SL/TP values");
      return(INIT_PARAMETERS_INCORRECT);
     }
   
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   //--- Release indicator handles
   if(tenkanHandle != INVALID_HANDLE)
      IndicatorRelease(tenkanHandle);
   if(kijunHandle != INVALID_HANDLE)
      IndicatorRelease(kijunHandle);
   if(senkouSpanAHandle != INVALID_HANDLE)
      IndicatorRelease(senkouSpanAHandle);
   if(senkouSpanBHandle != INVALID_HANDLE)
      IndicatorRelease(senkouSpanBHandle);
  }

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   //--- Check if new bar has formed
   if(!IsNewBar())
      return;
   
   //--- Check maximum spread
   if(!CheckSpread())
      return;
   
   //--- Manage existing positions (Break Even & Trailing)
   ManagePositions();
   
   //--- Check if we already have open position with this magic number
   if(CountOpenPositions() >= 1)
      return;
   
   //--- Get trading signals
   int signal = GetTradingSignal();
   
   //--- Execute trades based on signal
   if(signal > 0)
     {
      OpenBuyPosition();
     }
   else if(signal < 0)
     {
      OpenSellPosition();
     }
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
//| Check maximum spread                                             |
//+------------------------------------------------------------------+
bool CheckSpread()
  {
   if(!SymbolInfoTick(_Symbol, currentTick))
      return(false);
   
   double spread = (currentTick.ask - currentTick.bid) / _Point;
   
   if(spread > InpMaxSpread)
      return(false);
   
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
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
        {
         if(PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
           {
            count++;
           }
        }
     }
   
   return(count);
  }

//+------------------------------------------------------------------+
//| Get Ichimoku values                                              |
//+------------------------------------------------------------------+
bool GetIchimokuValues(double &tenkan, double &kijun, double &spanA, double &spanB)
  {
   double tenkanBuffer[], kijunBuffer[], spanABuffer[], spanBBuffer[];
   
   ArraySetAsSeries(tenkanBuffer, true);
   ArraySetAsSeries(kijunBuffer, true);
   ArraySetAsSeries(spanABuffer, true);
   ArraySetAsSeries(spanBBuffer, true);
   
   if(CopyBuffer(tenkanHandle, 0, 0, 3, tenkanBuffer) < 3)
      return(false);
   if(CopyBuffer(tenkanHandle, 1, 0, 3, kijunBuffer) < 3)
      return(false);
   if(CopyBuffer(tenkanHandle, 2, 0, 3, spanABuffer) < 3)
      return(false);
   if(CopyBuffer(tenkanHandle, 3, 0, 3, spanBBuffer) < 3)
      return(false);
   
   tenkan = tenkanBuffer[0];
   kijun = kijunBuffer[0];
   spanA = spanABuffer[0];
   spanB = spanBBuffer[0];
   
   return(true);
  }

//+------------------------------------------------------------------+
//| Get trading signal                                               |
//+------------------------------------------------------------------+
int GetTradingSignal()
  {
   double tenkan, kijun, spanA, spanB;
   
   if(!GetIchimokuValues(tenkan, kijun, spanA, spanB))
      return(0);
   
   if(!SymbolInfoTick(_Symbol, currentTick))
      return(0);
   
   double currentPrice = (currentTick.ask + currentTick.bid) / 2.0;
   
   //--- Define cloud boundaries
   double cloudTop = MathMax(spanA, spanB);
   double cloudBottom = MathMin(spanA, spanB);
   
   //--- Check BUY signal: Price above cloud and Tenkan > Kijun
   if(currentPrice > cloudTop && tenkan > kijun)
     {
      return(1);
     }
   
   //--- Check SELL signal: Price below cloud and Tenkan < Kijun
   if(currentPrice < cloudBottom && tenkan < kijun)
     {
      return(-1);
     }
   
   return(0);
  }

//+------------------------------------------------------------------+
//| Open Buy position                                                |
//+------------------------------------------------------------------+
void OpenBuyPosition()
  {
   if(!SymbolInfoTick(_Symbol, currentTick))
      return;
   
   double sl = currentTick.bid - InpStopLoss * _Point;
   double tp = currentTick.bid + InpTakeProfit * _Point;
   
   if(trade.Buy(InpLotSize, _Symbol, 0.0, sl, tp, "Ichimoku BUY"))
     {
      Print("BUY order opened successfully. Ticket: ", trade.ResultOrder());
     }
   else
     {
      Print("Failed to open BUY order. Error: ", trade.ResultRetcode());
     }
  }

//+------------------------------------------------------------------+
//| Open Sell position                                               |
//+------------------------------------------------------------------+
void OpenSellPosition()
  {
   if(!SymbolInfoTick(_Symbol, currentTick))
      return;
   
   double sl = currentTick.ask + InpStopLoss * _Point;
   double tp = currentTick.ask - InpTakeProfit * _Point;
   
   if(trade.Sell(InpLotSize, _Symbol, 0.0, sl, tp, "Ichimoku SELL"))
     {
      Print("SELL order opened successfully. Ticket: ", trade.ResultOrder());
     }
   else
     {
      Print("Failed to open SELL order. Error: ", trade.ResultRetcode());
     }
  }

//+------------------------------------------------------------------+
//| Manage positions (Break Even & Trailing Stop)                    |
//+------------------------------------------------------------------+
void ManagePositions()
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
        {
         if(PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
           {
            if(PositionGetString(POSITION_SYMBOL) == _Symbol)
              {
               if(InpUseBreakEven)
                  ApplyBreakEven(ticket);
               
               if(InpUseTrailing)
                  ApplyTrailingStop(ticket);
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| Apply Break Even                                                 |
//+------------------------------------------------------------------+
void ApplyBreakEven(ulong ticket)
  {
   if(!PositionSelectByTicket(ticket))
      return;
   
   double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double currentSL = PositionGetDouble(POSITION_SL);
   double currentTP = PositionGetDouble(POSITION_TP);
   
   if(!SymbolInfoTick(_Symbol, currentTick))
      return;
   
   long positionType = PositionGetInteger(POSITION_TYPE);
   
   if(positionType == POSITION_TYPE_BUY)
     {
      double breakEvenPrice = openPrice + InpBreakEvenLevel * _Point;
      
      if(currentTick.bid >= openPrice + InpBreakEvenTrigger * _Point)
        {
         if(currentSL < breakEvenPrice)
           {
            if(trade.PositionModify(ticket, breakEvenPrice, currentTP))
              {
               Print("Break Even applied to BUY position #", ticket);
              }
           }
        }
     }
   else if(positionType == POSITION_TYPE_SELL)
     {
      double breakEvenPrice = openPrice - InpBreakEvenLevel * _Point;
      
      if(currentTick.ask <= openPrice - InpBreakEvenTrigger * _Point)
        {
         if(currentSL > breakEvenPrice || currentSL == 0)
           {
            if(trade.PositionModify(ticket, breakEvenPrice, currentTP))
              {
               Print("Break Even applied to SELL position #", ticket);
              }
           }
        }
     }
  }

//+------------------------------------------------------------------+
//| Apply Trailing Stop                                              |
//+------------------------------------------------------------------+
void ApplyTrailingStop(ulong ticket)
  {
   if(!PositionSelectByTicket(ticket))
      return;
   
   double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double currentSL = PositionGetDouble(POSITION_SL);
   double currentTP = PositionGetDouble(POSITION_TP);
   
   if(!SymbolInfoTick(_Symbol, currentTick))
      return;
   
   long positionType = PositionGetInteger(POSITION_TYPE);
   
   if(positionType == POSITION_TYPE_BUY)
     {
      double trailingLevel = currentTick.bid - InpTrailingStart * _Point;
      
      if(currentTick.bid >= openPrice + InpTrailingStart * _Point)
        {
         if(trailingLevel > currentSL + InpTrailingStep * _Point || currentSL == 0)
           {
            if(trade.PositionModify(ticket, trailingLevel, currentTP))
              {
               Print("Trailing Stop applied to BUY position #", ticket);
              }
           }
        }
     }
   else if(positionType == POSITION_TYPE_SELL)
     {
      double trailingLevel = currentTick.ask + InpTrailingStart * _Point;
      
      if(currentTick.ask <= openPrice - InpTrailingStart * _Point)
        {
         if(trailingLevel < currentSL - InpTrailingStep * _Point || currentSL == 0)
           {
            if(trade.PositionModify(ticket, trailingLevel, currentTP))
              {
               Print("Trailing Stop applied to SELL position #", ticket);
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+