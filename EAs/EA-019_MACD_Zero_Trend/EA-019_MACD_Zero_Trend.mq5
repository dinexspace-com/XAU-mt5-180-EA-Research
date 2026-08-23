//+------------------------------------------------------------------+
//|                                                  MACD_EMA50_EA.mq5 |
//|                                                                  |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
#property version   "1.00"

#include <Trade\Trade.mqh>

//+------------------------------------------------------------------+
//| Input parameters                                                 |
//+------------------------------------------------------------------+
input double   InpLotSize       = 0.01;      // Lot size
input int     InpStopLoss      = 300;       // Stop Loss (points)
input int     InpTakeProfit    = 600;       // Take Profit (points)
input ulong   InpMagicNumber   = 123456;    // Magic number
input int     InpSlippage      = 10;        // Slippage (points)

input bool    InpUseBreakEven  = true;      // Use Break Even
input int     InpBreakEven     = 150;       // Break Even trigger (points)
input bool    InpUseTrailing   = true;      // Use Trailing Stop
input int     InpTrailingStart = 200;       // Trailing start (points)
input int     InpMaxSpread     = 30;        // Max spread allowed (points)

input int     InpMACDFast      = 12;        // MACD Fast EMA
input int     InpMACDSlow      = 26;        // MACD Slow EMA
input int     InpMACDSignal    = 9;         // MACD Signal SMA
input int     InpEMA50Period   = 50;        // EMA 50 period

//+------------------------------------------------------------------+
//| Global variables                                                 |
//+------------------------------------------------------------------+
CTrade          m_trade;
MqlTick         m_tick;
int             m_handleMACD;
int             m_handleEMA50;
double          m_macd[];
double          m_signal[];
double          m_ema50[];
datetime        m_lastBarTime = 0;
ulong           m_magicNumber;
double          m_lotSize;
int             m_slippage;
int             m_slPoints;
int             m_tpPoints;
double          m_point;
int             m_digits;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   // Set magic number
   m_magicNumber = InpMagicNumber;
   m_lotSize = InpLotSize;
   m_slippage = InpSlippage;
   m_slPoints = InpStopLoss;
   m_tpPoints = InpTakeProfit;

   // Get point value
   m_point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   m_digits = (int)SymbolInfoInteger(_Symbol, SYMBOL_DIGITS);

   // Initialize trade object
   m_trade.SetExpertMagicNumber(m_magicNumber);
   m_trade.SetDeviationInPoints(m_slippage);

   // Create MACD handle
   m_handleMACD = iMACD(_Symbol, _Period, InpMACDFast, InpMACDSlow, InpMACDSignal, PRICE_CLOSE);
   if(m_handleMACD == INVALID_HANDLE)
   {
      Print("Failed to create MACD handle. Error: ", GetLastError());
      return INIT_FAILED;
   }

   // Create EMA50 handle
   m_handleEMA50 = iMA(_Symbol, _Period, InpEMA50Period, 0, MODE_EMA, PRICE_CLOSE);
   if(m_handleEMA50 == INVALID_HANDLE)
   {
      Print("Failed to create EMA50 handle. Error: ", GetLastError());
      return INIT_FAILED;
   }

   // Set array as series
   ArraySetAsSeries(m_macd, true);
   ArraySetAsSeries(m_signal, true);
   ArraySetAsSeries(m_ema50, true);

   // Initialize last bar time
   m_lastBarTime = iTime(_Symbol, _Period, 0);

   Print("EA initialized successfully");
   return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   // Release indicators
   if(m_handleMACD != INVALID_HANDLE)
      IndicatorRelease(m_handleMACD);
   if(m_handleEMA50 != INVALID_HANDLE)
      IndicatorRelease(m_handleEMA50);

   Print("EA deinitialized. Reason: ", reason);
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   // New bar check
   datetime currentBarTime = iTime(_Symbol, _Period, 0);
   if(currentBarTime == m_lastBarTime)
      return;
   m_lastBarTime = currentBarTime;

   // Refresh tick data
   if(!SymbolInfoTick(_Symbol, m_tick))
   {
      Print("Failed to get tick data. Error: ", GetLastError());
      return;
   }

   // Check spread
   double spread = (m_tick.ask - m_tick.bid) / m_point;
   if(spread > InpMaxSpread)
   {
      Print("Spread too high: ", spread, " points (max: ", InpMaxSpread, ")");
      return;
   }

   // Check if there is an open position with this magic number
   if(PositionExists())
   {
      // Manage existing position: Break Even and Trailing Stop
      ManageOpenPositions();
      return;
   }

   // Check account conditions
   if(!CheckAccountConditions())
      return;

   // Get indicator values
   if(!GetIndicatorValues())
      return;

   // Check for entry signals
   double macdMain = m_macd[1];
   double macdSignal = m_signal[1];
   double ema50 = m_ema50[1];
   double closePrice = iClose(_Symbol, _Period, 1);

   if(macdMain > 0 && macdMain > macdSignal && closePrice > ema50)
   {
      // BUY signal
      OpenBuyOrder();
   }
   else if(macdMain < 0 && macdMain < macdSignal && closePrice < ema50)
   {
      // SELL signal
      OpenSellOrder();
   }
}

//+------------------------------------------------------------------+
//| Check if position exists                                         |
//+------------------------------------------------------------------+
bool PositionExists()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0 && PositionSelectByTicket(ticket))
      {
         if(PositionGetInteger(POSITION_MAGIC) == m_magicNumber)
         {
            return true;
         }
      }
   }
   return false;
}

//+------------------------------------------------------------------+
//| Check account conditions                                         |
//+------------------------------------------------------------------+
bool CheckAccountConditions()
{
   // Check margin and free margin
   double marginFree = AccountInfoDouble(ACCOUNT_MARGIN_FREE);
   double marginRequired = m_lotSize * SymbolInfoDouble(_Symbol, SYMBOL_MARGIN_INITIAL) * 2;

   if(marginFree < marginRequired)
   {
      Print("Insufficient free margin. Required: ", marginRequired, ", Available: ", marginFree);
      return false;
   }

   // Check lot size limits
   double minLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double maxLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   double stepLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);

   if(m_lotSize < minLot || m_lotSize > maxLot)
   {
      Print("Lot size out of range. Min: ", minLot, ", Max: ", maxLot);
      return false;
   }

   // Normalize lot size
   m_lotSize = NormalizeLot(m_lotSize);

   return true;
}

//+------------------------------------------------------------------+
//| Normalize lot size                                               |
//+------------------------------------------------------------------+
double NormalizeLot(double lot)
{
   double stepLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
   double minLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double maxLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);

   lot = MathRound(lot / stepLot) * stepLot;
   lot = MathMax(minLot, MathMin(maxLot, lot));

   return NormalizeDouble(lot, 2);
}

//+------------------------------------------------------------------+
//| Get indicator values                                             |
//+------------------------------------------------------------------+
bool GetIndicatorValues()
{
   // Get MACD values
   if(CopyBuffer(m_handleMACD, 0, 0, 3, m_macd) < 3)
   {
      Print("Failed to copy MACD buffer. Error: ", GetLastError());
      return false;
   }
   if(CopyBuffer(m_handleMACD, 1, 0, 3, m_signal) < 3)
   {
      Print("Failed to copy Signal buffer. Error: ", GetLastError());
      return false;
   }

   // Get EMA50 values
   if(CopyBuffer(m_handleEMA50, 0, 0, 3, m_ema50) < 3)
   {
      Print("Failed to copy EMA50 buffer. Error: ", GetLastError());
      return false;
   }

   return true;
}

//+------------------------------------------------------------------+
//| Open BUY order                                                   |
//+------------------------------------------------------------------+
void OpenBuyOrder()
{
   // Calculate SL and TP in price
   double sl = m_tick.ask - m_slPoints * m_point;
   double tp = m_tick.ask + m_tpPoints * m_point;

   // Normalize prices
   sl = NormalizeDouble(sl, m_digits);
   tp = NormalizeDouble(tp, m_digits);

   // Open order
   if(m_trade.Buy(m_lotSize, _Symbol, m_tick.ask, sl, tp, "MACD_EMA50 BUY"))
   {
      Print("BUY order opened. Ticket: ", m_trade.ResultDeal());
   }
   else
   {
      Print("Failed to open BUY order. Error: ", m_trade.ResultRetcode());
   }
}

//+------------------------------------------------------------------+
//| Open SELL order                                                  |
//+------------------------------------------------------------------+
void OpenSellOrder()
{
   // Calculate SL and TP in price
   double sl = m_tick.bid + m_slPoints * m_point;
   double tp = m_tick.bid - m_tpPoints * m_point;

   // Normalize prices
   sl = NormalizeDouble(sl, m_digits);
   tp = NormalizeDouble(tp, m_digits);

   // Open order
   if(m_trade.Sell(m_lotSize, _Symbol, m_tick.bid, sl, tp, "MACD_EMA50 SELL"))
   {
      Print("SELL order opened. Ticket: ", m_trade.ResultDeal());
   }
   else
   {
      Print("Failed to open SELL order. Error: ", m_trade.ResultRetcode());
   }
}

//+------------------------------------------------------------------+
//| Manage open positions                                            |
//+------------------------------------------------------------------+
void ManageOpenPositions()
{
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0 && PositionSelectByTicket(ticket))
      {
         if(PositionGetInteger(POSITION_MAGIC) != m_magicNumber)
            continue;

         double currentSL = PositionGetDouble(POSITION_SL);
         double currentTP = PositionGetDouble(POSITION_TP);
         double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
         double currentPrice = PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY ?
                               m_tick.bid : m_tick.ask;
         double profitPoints = PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY ?
                               (currentPrice - openPrice) / m_point :
                               (openPrice - currentPrice) / m_point;

         // Break Even
         if(InpUseBreakEven && currentSL == 0)
         {
            if(profitPoints >= InpBreakEven)
            {
               double newSL = PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY ?
                              openPrice + m_point * 10 :
                              openPrice - m_point * 10;
               newSL = NormalizeDouble(newSL, m_digits);

               m_trade.PositionModify(ticket, newSL, currentTP);
               Print("Break Even triggered for ticket: ", ticket);
            }
         }

         // Trailing Stop
         if(InpUseTrailing && currentSL != 0)
         {
            double priceSL = 0;
            bool shouldTrail = false;

            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
            {
               double trailLevel = openPrice + InpTrailingStart * m_point;
               if(currentPrice >= trailLevel && (currentSL < currentPrice - InpTrailingStart * m_point))
               {
                  priceSL = currentPrice - InpTrailingStart * m_point;
                  shouldTrail = true;
               }
            }
            else
            {
               double trailLevel = openPrice - InpTrailingStart * m_point;
               if(currentPrice <= trailLevel && (currentSL > currentPrice + InpTrailingStart * m_point))
               {
                  priceSL = currentPrice + InpTrailingStart * m_point;
                  shouldTrail = true;
               }
            }

            if(shouldTrail)
            {
               priceSL = NormalizeDouble(priceSL, m_digits);
               if(priceSL != currentSL)
               {
                  m_trade.PositionModify(ticket, priceSL, currentTP);
                  Print("Trailing Stop updated for ticket: ", ticket, " to: ", priceSL);
               }
            }
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+