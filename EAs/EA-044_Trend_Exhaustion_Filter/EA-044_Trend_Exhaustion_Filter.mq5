
//+------------------------------------------------------------------+
//|                                                TrendATRFilter.mq5|
//|                                      Senior MQL5 Developer      |
//+------------------------------------------------------------------+
#property copyright "Senior MQL5 Developer"
#property link      ""
#property version   "1.00"
#property strict

#include <Trade\Trade.mqh>

//--- Input Parameters
input double InpLotSize        = 0.01;     // Lot Size
input int    InpStopLoss       = 300;      // Stop Loss (points)
input int    InpTakeProfit     = 600;      // Take Profit (points)
input ulong  InpMagicNumber    = 2024001;  // Magic Number
input int    InpSlippage       = 10;       // Slippage (points)
input int    InpMaxSpread      = 30;       // Maximum Spread (points)

//--- Trend Filter Parameters
input int    InpEMAPeriod      = 200;      // EMA Period
input int    InpATRPeriod      = 14;       // ATR Period
input double InpATRMultiplier  = 2.0;      // ATR Multiplier Filter

//--- Risk Management
input bool   InpUseBreakEven   = true;     // Use Break Even
input int    InpBreakEvenTrigger = 150;    // Break Even Trigger (points)
input int    InpBreakEvenShift = 20;       // Break Even Shift (points)
input bool   InpUseTrailing    = true;     // Use Trailing Stop
input int    InpTrailingStart  = 200;      // Trailing Start (points)
input int    InpTrailingStep   = 50;       // Trailing Step (points)

//--- Global Variables
CTrade  trade;
int     emaHandle;
int     atrHandle;
datetime lastBarTime = 0;
bool    isNewBar = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    //--- Validate inputs
    if(InpLotSize <= 0)
    {
        Print("Invalid Lot Size");
        return(INIT_PARAMETERS_INCORRECT);
    }
    
    if(InpStopLoss <= 0 || InpTakeProfit <= 0)
    {
        Print("Invalid SL/TP");
        return(INIT_PARAMETERS_INCORRECT);
    }
    
    //--- Setup trade object
    trade.SetExpertMagicNumber(InpMagicNumber);
    trade.SetDeviationInPoints(InpSlippage);
    trade.SetTypeFillingBySymbol(_Symbol);
    
    //--- Create indicators
    emaHandle = iMA(_Symbol, PERIOD_CURRENT, InpEMAPeriod, 0, MODE_EMA, PRICE_CLOSE);
    if(emaHandle == INVALID_HANDLE)
    {
        Print("Failed to create EMA indicator");
        return(INIT_FAILED);
    }
    
    atrHandle = iATR(_Symbol, PERIOD_CURRENT, InpATRPeriod);
    if(atrHandle == INVALID_HANDLE)
    {
        Print("Failed to create ATR indicator");
        return(INIT_FAILED);
    }
    
    Print("TrendATRFilter EA initialized successfully");
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    //--- Release indicators
    if(emaHandle != INVALID_HANDLE)
        IndicatorRelease(emaHandle);
    
    if(atrHandle != INVALID_HANDLE)
        IndicatorRelease(atrHandle);
    
    Print("TrendATRFilter EA deinitialized");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    //--- Check for new bar
    if(!CheckNewBar())
        return;
    
    //--- Check spread
    if(!CheckSpread())
        return;
    
    //--- Check existing position
    if(CountOpenPositions() >= 1)
    {
        ManageOpenPositions();
        return;
    }
    
    //--- Get indicator values
    double ema[], atr[], close[];
    ArraySetAsSeries(ema, true);
    ArraySetAsSeries(atr, true);
    ArraySetAsSeries(close, true);
    
    if(CopyBuffer(emaHandle, 0, 1, 3, ema) < 3)
        return;
    
    if(CopyBuffer(atrHandle, 0, 1, 3, atr) < 3)
        return;
    
    if(CopyClose(_Symbol, PERIOD_CURRENT, 1, 3, close) < 3)
        return;
    
    //--- Calculate signals
    double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double currentEMA = ema[0];
    double currentATR = atr[0];
    
    double distanceFromEMA = MathAbs(currentPrice - currentEMA);
    double atrFilter = currentATR * InpATRMultiplier;
    
    //--- Trading signals
    bool bullSignal = false;
    bool bearSignal = false;
    
    if(currentPrice > currentEMA && distanceFromEMA > atrFilter)
        bullSignal = true;
    
    if(currentPrice < currentEMA && distanceFromEMA > atrFilter)
        bearSignal = true;
    
    //--- Execute trades
    if(bullSignal)
    {
        double sl = currentPrice - InpStopLoss * _Point;
        double tp = currentPrice + InpTakeProfit * _Point;
        
        if(trade.Buy(InpLotSize, _Symbol, 0, sl, tp, "TrendATRFilter Buy"))
        {
            Print("Buy order opened successfully");
        }
        else
        {
            Print("Failed to open Buy order: ", trade.ResultRetcode());
        }
    }
    else if(bearSignal)
    {
        double sl = currentPrice + InpStopLoss * _Point;
        double tp = currentPrice - InpTakeProfit * _Point;
        
        if(trade.Sell(InpLotSize, _Symbol, 0, sl, tp, "TrendATRFilter Sell"))
        {
            Print("Sell order opened successfully");
        }
        else
        {
            Print("Failed to open Sell order: ", trade.ResultRetcode());
        }
    }
}

//+------------------------------------------------------------------+
//| Check for new bar                                                |
//+------------------------------------------------------------------+
bool CheckNewBar()
{
    datetime currentBarTime = iTime(_Symbol, PERIOD_CURRENT, 0);
    
    if(currentBarTime != lastBarTime)
    {
        lastBarTime = currentBarTime;
        return true;
    }
    
    return false;
}

//+------------------------------------------------------------------+
//| Check spread                                                     |
//+------------------------------------------------------------------+
bool CheckSpread()
{
    double spread = (SymbolInfoDouble(_Symbol, SYMBOL_ASK) - 
                     SymbolInfoDouble(_Symbol, SYMBOL_BID)) / _Point;
    
    if(spread > InpMaxSpread)
    {
        Print("Spread too high: ", spread, " points");
        return false;
    }
    
    return true;
}

//+------------------------------------------------------------------+
//| Count open positions                                             |
//+------------------------------------------------------------------+
int CountOpenPositions()
{
    int count = 0;
    
    for(int i = PositionsTotal() - 1; i >= 0; i--)
    {
        ulong ticket = PositionGetTicket(i);
        if(ticket > 0)
        {
            if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
               PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
            {
                count++;
            }
        }
    }
    
    return count;
}

//+------------------------------------------------------------------+
//| Manage open positions (Break Even & Trailing)                    |
//+------------------------------------------------------------------+
void ManageOpenPositions()
{
    for(int i = PositionsTotal() - 1; i >= 0; i--)
    {
        ulong ticket = PositionGetTicket(i);
        if(ticket > 0)
        {
            if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
               PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
            {
                double currentSL = PositionGetDouble(POSITION_SL);
                double currentTP = PositionGetDouble(POSITION_TP);
                double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
                double currentPrice = PositionGetDouble(POSITION_PRICE_CURRENT);
                double profitPoints = 0;
                
                if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
                {
                    profitPoints = (currentPrice - openPrice) / _Point;
                }
                else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
                {
                    profitPoints = (openPrice - currentPrice) / _Point;
                }
                
                //--- Break Even
                if(InpUseBreakEven && profitPoints >= InpBreakEvenTrigger)
                {
                    double newSL = 0;
                    
                    if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
                    {
                        newSL = openPrice + InpBreakEvenShift * _Point;
                        if(currentSL < newSL)
                        {
                            trade.PositionModify(ticket, newSL, currentTP);
                        }
                    }
                    else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
                    {
                        newSL = openPrice - InpBreakEvenShift * _Point;
                        if(currentSL > newSL)
                        {
                            trade.PositionModify(ticket, newSL, currentTP);
                        }
                    }
                }
                
                //--- Trailing Stop
                if(InpUseTrailing && profitPoints >= InpTrailingStart)
                {
                    double newSL = 0;
                    
                    if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
                    {
                        newSL = currentPrice - InpTrailingStep * _Point;
                        if(newSL > currentSL)
                        {
                            trade.PositionModify(ticket, newSL, currentTP);
                        }
                    }
                    else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
                    {
                        newSL = currentPrice + InpTrailingStep * _Point;
                        if(newSL < currentSL)
                        {
                            trade.PositionModify(ticket, newSL, currentTP);
                        }
                    }
                }
            }
        }
    }
}
//+------------------------------------------------------------------+