//+------------------------------------------------------------------+
//|                                                  EA_VWAP_Pullback|
//|                              Chiến lược: VWAP Pullback Continuation|
//+------------------------------------------------------------------+
#property copyright "Senior MQL5 Developer"
#property version   "1.00"
#property strict

#include <Trade\Trade.mqh>

//+------------------------------------------------------------------+
//| Input Parameters                                                  |
//+------------------------------------------------------------------+
input group "=== Thông số giao dịch chính ==="
input double InpLotSize       = 0.01;       // Khối lượng giao dịch
input int    InpStopLoss      = 300;        // Stop Loss (points)
input int    InpTakeProfit    = 600;        // Take Profit (points)
input int    InpSlippage      = 10;         // Slippage / Deviation

input group "=== Quản lý lệnh ==="
input bool   InpUseBreakEven  = true;       // Sử dụng Break Even
input int    InpBreakEvenTrigger = 150;     // Break Even kích hoạt (points)
input int    InpBreakEvenLock = 0;          // Break Even khóa lợi nhuận (points)
input bool   InpUseTrailingStop = true;     // Sử dụng Trailing Stop
input int    InpTrailingStart = 200;        // Trailing bắt đầu (points)
input int    InpTrailingStep  = 50;         // Trailing bước (points)

input group "=== Bộ lọc giao dịch ==="
input int    InpMaxSpread     = 30;         // Spread tối đa (points)
input int    InpMaxPositions  = 1;          // Số lệnh tối đa

input group "=== Nhận diện EA ==="
input ulong  InpMagicNumber   = 123456;     // Magic Number
input bool   InpUseVWAPFilter = true;       // Lọc theo VWAP

//+------------------------------------------------------------------+
//| Global Variables                                                  |
//+------------------------------------------------------------------+
CTrade trade;
datetime lastBarTime = 0;
int vwapHandle = INVALID_HANDLE;
bool isLongPosition = false;
bool isShortPosition = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                    |
//+------------------------------------------------------------------+
int OnInit()
{
   // Khởi tạo đối tượng giao dịch
   trade.SetExpertMagicNumber(InpMagicNumber);
   trade.SetDeviationInPoints(InpSlippage);
   trade.SetAsyncMode(false);
   
   // Kiểm tra thông số đầu vào
   if(InpLotSize <= 0)
   {
      Print("Lỗi: Lot size phải lớn hơn 0");
      return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(InpStopLoss <= 0 || InpTakeProfit <= 0)
   {
      Print("Lỗi: Stop Loss và Take Profit phải lớn hơn 0");
      return(INIT_PARAMETERS_INCORRECT);
   }
   
   if(InpTrailingStart <= InpBreakEvenTrigger)
   {
      Print("Cảnh báo: Trailing Start nên lớn hơn Break Even Trigger");
   }
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   // Giải phóng handle nếu đã tạo
   if(vwapHandle != INVALID_HANDLE)
   {
      IndicatorRelease(vwapHandle);
      vwapHandle = INVALID_HANDLE;
   }
}

//+------------------------------------------------------------------+
//| Expert tick function                                              |
//+------------------------------------------------------------------+
void OnTick()
{
   // Kiểm tra nến mới
   if(!IsNewBar())
      return;
   
   // Cập nhật trạng thái vị thế
   UpdatePositionStatus();
   
   // Kiểm tra điều kiện giao dịch
   if(!CheckTradingConditions())
      return;
   
   // Kiểm tra tín hiệu giao dịch
   if(IsTradingAllowed())
   {
      int signal = GetTradingSignal();
      
      if(signal > 0 && !isLongPosition)
      {
         OpenLongPosition();
      }
      else if(signal < 0 && !isShortPosition)
      {
         OpenShortPosition();
      }
   }
   
   // Quản lý lệnh đang mở
   ManageOpenPositions();
}

//+------------------------------------------------------------------+
//| Kiểm tra nến mới                                                 |
//+------------------------------------------------------------------+
bool IsNewBar()
{
   datetime currentBarTime = iTime(_Symbol, _Period, 0);
   
   if(currentBarTime != lastBarTime)
   {
      lastBarTime = currentBarTime;
      return true;
   }
   
   return false;
}

//+------------------------------------------------------------------+
//| Cập nhật trạng thái vị thế                                      |
//+------------------------------------------------------------------+
void UpdatePositionStatus()
{
   isLongPosition = false;
   isShortPosition = false;
   
   for(int i = PositionsTotal() - 1; i >= 0; i--)
   {
      ulong ticket = PositionGetTicket(i);
      if(ticket > 0)
      {
         if(PositionGetString(POSITION_SYMBOL) == _Symbol && 
            PositionGetInteger(POSITION_MAGIC) == InpMagicNumber)
         {
            if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
               isLongPosition = true;
            else if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
               isShortPosition = true;
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Kiểm tra điều kiện giao dịch                                     |
//+------------------------------------------------------------------+
bool CheckTradingConditions()
{
   // Kiểm tra spread
   double spread = GetCurrentSpread();
   if(spread > InpMaxSpread)
      return false;
   
   // Kiểm tra tài khoản
   if(!IsTradingAllowed())
      return false;
   
   return true;
}

//+------------------------------------------------------------------+
//| Kiểm tra quyền giao dịch                                         |
//+------------------------------------------------------------------+
bool IsTradingAllowed()
{
   // Kiểm tra kết nối
   if(!TerminalInfoInteger(TERMINAL_CONNECTED))
      return false;
   
   // Kiểm tra giao dịch tự động
   if(!MQLInfoInteger(MQL_TRADE_ALLOWED))
      return false;
   
   // Kiểm tra số lệnh tối đa
   if(CountOpenPositions() >= InpMaxPositions)
      return false;
   
   return true;
}

//+------------------------------------------------------------------+
//| Đếm số lệnh đang mở                                             |
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
//| Lấy spread hiện tại                                              |
//+------------------------------------------------------------------+
double GetCurrentSpread()
{
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   
   if(ask <= 0 || bid <= 0 || point <= 0)
      return 9999;
   
   return (ask - bid) / point;
}

//+------------------------------------------------------------------+
//| Tính toán tín hiệu giao dịch dựa trên VWAP                      |
//+------------------------------------------------------------------+
int GetTradingSignal()
{
   double vwap = GetVWAPValue();
   double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double previousPrice = iClose(_Symbol, _Period, 1);
   
   if(vwap <= 0 || currentPrice <= 0)
      return 0;
   
   // Kiểm tra điều kiện VWAP
   if(InpUseVWAPFilter)
   {
      double vwapDistance = MathAbs(currentPrice - vwap) / _Point;
      
      // Chỉ giao dịch khi giá gần VWAP (trong phạm vi cho phép)
      if(vwapDistance > 100) // Tùy chỉnh phạm vi
         return 0;
   }
   
   // Kiểm tra tín hiệu tiếp diễn
   if(previousPrice > vwap && currentPrice >= previousPrice)
   {
      // Giá đang trên VWAP và có nến tiếp diễn tăng
      return 1; // Tín hiệu mua
   }
   else if(previousPrice < vwap && currentPrice <= previousPrice)
   {
      // Giá đang dưới VWAP và có nến tiếp diễn giảm
      return -1; // Tín hiệu bán
   }
   
   return 0; // Không có tín hiệu
}

//+------------------------------------------------------------------+
//| Lấy giá trị VWAP                                                  |
//+------------------------------------------------------------------+
double GetVWAPValue()
{
   // Tính toán VWAP thủ công (trong ngày)
   double sumTypicalPriceVolume = 0.0;
   double sumVolume = 0.0;
   
   // Lấy thời gian bắt đầu ngày
   MqlDateTime dt;
   TimeToStruct(TimeCurrent(), dt);
   datetime dayStart = StringToTime(StringFormat("%04d.%02d.%02d 00:00", dt.year, dt.mon, dt.day));
   
   // Lấy dữ liệu
   for(int i = 0; i < 1000; i++)
   {
      datetime barTime = iTime(_Symbol, _Period, i);
      if(barTime < dayStart)
         break;
      
      double high = iHigh(_Symbol, _Period, i);
      double low = iLow(_Symbol, _Period, i);
      double close = iClose(_Symbol, _Period, i);
      long volume = iVolume(_Symbol, _Period, i);
      
      if(high <= 0 || low <= 0 || close <= 0)
         break;
      
      double typicalPrice = (high + low + close) / 3.0;
      sumTypicalPriceVolume += typicalPrice * (double)volume;
      sumVolume += (double)volume;
   }
   
   if(sumVolume <= 0)
      return 0.0;
   
   return sumTypicalPriceVolume / sumVolume;
}

//+------------------------------------------------------------------+
//| Mở lệnh mua                                                      |
//+------------------------------------------------------------------+
void OpenLongPosition()
{
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double sl = InpStopLoss > 0 ? ask - InpStopLoss * _Point : 0;
   double tp = InpTakeProfit > 0 ? ask + InpTakeProfit * _Point : 0;
   
   if(trade.Buy(InpLotSize, _Symbol, ask, sl, tp, "VWAP Pullback Buy"))
   {
      Print("Mở lệnh BUY thành công: ", ask, " SL: ", sl, " TP: ", tp);
   }
   else
   {
      Print("Lỗi mở lệnh BUY: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
   }
}

//+------------------------------------------------------------------+
//| Mở lệnh bán                                                      |
//+------------------------------------------------------------------+
void OpenShortPosition()
{
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double sl = InpStopLoss > 0 ? bid + InpStopLoss * _Point : 0;
   double tp = InpTakeProfit > 0 ? bid - InpTakeProfit * _Point : 0;
   
   if(trade.Sell(InpLotSize, _Symbol, bid, sl, tp, "VWAP Pullback Sell"))
   {
      Print("Mở lệnh SELL thành công: ", bid, " SL: ", sl, " TP: ", tp);
   }
   else
   {
      Print("Lỗi mở lệnh SELL: ", trade.ResultRetcode(), " - ", trade.ResultRetcodeDescription());
   }
}

//+------------------------------------------------------------------+
//| Quản lý các lệnh đang mở                                        |
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
            ManagePosition(ticket);
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Quản lý một lệnh cụ thể                                         |
//+------------------------------------------------------------------+
void ManagePosition(ulong ticket)
{
   double currentPrice = PositionGetDouble(POSITION_PRICE_CURRENT);
   double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
   double stopLoss = PositionGetDouble(POSITION_SL);
   double takeProfit = PositionGetDouble(POSITION_TP);
   long positionType = PositionGetInteger(POSITION_TYPE);
   
   // Break Even
   if(InpUseBreakEven)
   {
      if(positionType == POSITION_TYPE_BUY)
      {
         if(currentPrice - openPrice >= InpBreakEvenTrigger * _Point)
         {
            double newSL = openPrice + InpBreakEvenLock * _Point;
            if(newSL > stopLoss)
            {
               trade.PositionModify(ticket, newSL, takeProfit);
            }
         }
      }
      else if(positionType == POSITION_TYPE_SELL)
      {
         if(openPrice - currentPrice >= InpBreakEvenTrigger * _Point)
         {
            double newSL = openPrice - InpBreakEvenLock * _Point;
            if(newSL < stopLoss || stopLoss == 0)
            {
               trade.PositionModify(ticket, newSL, takeProfit);
            }
         }
      }
   }
   
   // Trailing Stop
   if(InpUseTrailingStop)
   {
      if(positionType == POSITION_TYPE_BUY)
      {
         if(currentPrice - openPrice >= InpTrailingStart * _Point)
         {
            double newSL = currentPrice - InpTrailingStart * _Point;
            
            if(newSL > stopLoss || stopLoss == 0)
            {
               // Thêm bước trailing
               if(stopLoss > 0)
               {
                  double stepDistance = newSL - stopLoss;
                  if(stepDistance >= InpTrailingStep * _Point)
                  {
                     trade.PositionModify(ticket, newSL, takeProfit);
                  }
               }
               else
               {
                  trade.PositionModify(ticket, newSL, takeProfit);
               }
            }
         }
      }
      else if(positionType == POSITION_TYPE_SELL)
      {
         if(openPrice - currentPrice >= InpTrailingStart * _Point)
         {
            double newSL = currentPrice + InpTrailingStart * _Point;
            
            if(newSL < stopLoss || stopLoss == 0)
            {
               // Thêm bước trailing
               if(stopLoss > 0)
               {
                  double stepDistance = stopLoss - newSL;
                  if(stepDistance >= InpTrailingStep * _Point)
                  {
                     trade.PositionModify(ticket, newSL, takeProfit);
                  }
               }
               else
               {
                  trade.PositionModify(ticket, newSL, takeProfit);
               }
            }
         }
      }
   }
}

//+------------------------------------------------------------------+