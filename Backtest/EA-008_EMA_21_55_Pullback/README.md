# Strategy Tester Report: EA-008_EMA_21_55_Pullback

Báo cáo kết quả backtest chiến lược giao dịch tự động **EA-008_EMA_21_55_Pullback** trên cặp tiền **XAUUSD.PRO** (Vàng) khung thời gian **M1**.

---

## 📌 Thông tin tổng quan (Overview)

| Thông số | Giá trị |
| :--- | :--- |
| **Expert Advisor** | `EA-008_EMA_21_55_Pullback` |
| **Sản phẩm (Symbol)** | `XAUUSD.PRO` |
| **Khung thời gian (Period)** | `M1 (2026.01.02 - 2026.05.01)` |
| **Chất lượng dữ liệu (History Quality)** | **100% real ticks** |
| **Môi trường (Broker/Build)** | ACCMIntl-Real (Build 6090) |
| **Vốn ban đầu (Initial Deposit)** | **$1,000.00** |
| **Tỷ lệ đòn bẩy (Leverage)** | 1:500 |
| **Đơn vị tiền tệ** | USD |

---

## ⚙️ Tham số cấu hình (Input Parameters)

```ini
InpLotSize=0.01          ; Kích thước khối lượng giao dịch
InpStopLoss=300          ; Cắt lỗ (300 points)
InpTakeProfit=600        ; Chốt lời (600 points)
InpMagicNumber=123456    ; Mã định danh EA
InpSlippage=10           ; Trượt giá tối đa
InpUseBreakEven=true     ; Sử dụng BreakEven (Bật)
InpUseTrailingStop=true  ; Sử dụng Trailing Stop (Bật)
InpBreakEvenTrigger=150  ; Mức kích hoạt BreakEven (150 points)
InpTrailingStart=200     ; Mức bắt đầu Trailing Stop (200 points)
InpTrailingStop=200      ; Khoảng cách Trailing Stop (200 points)
InpMaxSpread=30          ; Spread tối đa cho phép vào lệnh
InpMaxOrders=1           ; Số lượng lệnh tối đa cùng lúc
InpEmaFast=21            ; Chu kỳ EMA nhanh
InpEmaSlow=55            ; Chu kỳ EMA chậm

## 📊 Kết quả hiệu suất (Performance Results)

| Tiêu chí | Giá trị |
| :--- | :--- |
| **Tổng Lợi nhuận Ròng (Total Net Profit)** | **-$993.28** |
| **Profit Factor** | **0.84** |
| **Expected Payoff** | **-$0.21** |
| **Sharpe Ratio** | **-5.00** |
| **Sụt giảm tài khoản tối đa (Max Drawdown)** | **$1,017.28 (99.34%)** |
| **Tổng số lệnh (Total Trades)** | **4,817** |
| **Tỷ lệ thắng (Win Rate)** | **46.42%** (2,236 thắng / 2,581 thua) |
| **Short Trades (Win %)** | 2,389 lệnh (46.92%) |
| **Long Trades (Win %)** | 2,428 lệnh (45.92%) |
| **Lợi nhuận trung bình lệnh thắng** | $2.30 |
| **Thua lỗ trung bình lệnh thua** | -$2.38 |
| **Chuỗi thắng liên tiếp tối đa** | 10 lệnh ($12.23) |
| **Chuỗi thua liên tiếp tối đa** | 13 lệnh (-$30.46) |
| **Thời gian giữ lệnh trung bình** | 00:03:20 |

---

## 📝 Đánh giá & Nhận xét kỹ thuật

* **Tần suất giao dịch cao (Overtrading):** Thực hiện 4,817 lệnh trong 4 tháng (~40 lệnh/ngày) dẫn đến hệ thống bị quét tín hiệu nhiễu liên tục trên khung M1.
* **Tỷ lệ Risk/Reward bị lệch:** Mặc dù Win Rate đạt 46.42%, nhưng trung bình mỗi lệnh thắng ($2.30) nhỏ hơn lỗ trung bình (-$2.38), làm cho kỳ vọng lợi nhuận âm (-$0.21/lệnh) và dẫn tới sụt giảm tài khoản nghiêm trọng (99.34%).
* **Tác động từ chi phí giao dịch:** Số lượng lệnh quá lớn khiến chi phí Spread và Trượt giá (Slippage) tích tụ, bào mòn toàn bộ tài khoản.

---

## 💡 Đề xuất tối ưu (Next Steps)

1. **Bộ lọc tín hiệu:** Tích hợp bộ lọc xu hướng/biến động như ADX hoặc ATR để tránh vào lệnh trong giai đoạn thị trường sideway.
2. **Tăng khung thời gian:** Chuyển sang khung M5 hoặc M15 để giảm nhiễu tín hiệu và khối lượng lệnh.
3. **Cấu hình lại R:R:** Điều chỉnh lại khoảng cách TakeProfit, BreakEvenTrigger và TrailingStart để tối ưu hóa việc khóa lợi nhuận.
