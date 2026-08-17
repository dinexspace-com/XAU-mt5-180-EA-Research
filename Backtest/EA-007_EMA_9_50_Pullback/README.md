# Strategy Tester Report: EA-007_EMA_9_50_Pullback

Báo cáo kết quả backtest chiến lược giao dịch tự động **EA-007_EMA_9_50_Pullback**[cite: 1] trên cặp tiền **XAUUSD.PRO** (Vàng)[cite: 1] khung thời gian **M1**[cite: 1].

---

## 📌 Thông tin tổng quan (Overview)

| Thông số | Giá trị |
| :--- | :--- |
| **Expert Advisor** | `EA-007_EMA_9_50_Pullback`[cite: 1] |
| **Sản phẩm (Symbol)** | `XAUUSD.PRO`[cite: 1] |
| **Khung thời gian (Period)** | `M1 (2026.01.02 - 2026.05.01)`[cite: 1] |
| **Chất lượng dữ liệu (History Quality)** | **100% real ticks**[cite: 1] |
| **Môi trường (Broker/Build)** | ACCMIntl-Real (Build 6090)[cite: 1] |
| **Vốn ban đầu (Initial Deposit)** | **$1,000.00**[cite: 1] |
| **Tỷ lệ đòn bẩy (Leverage)** | 1:500[cite: 1] |
| **Đơn vị tiền tệ** | USD[cite: 1] |

---

## ⚙️ Tham số cấu hình (Input Parameters)

```ini
InpLotSize=0.01          ; Kích thước khối lượng giao dịch
InpStopLoss=300          ; Cắt lỗ (300 points)
InpTakeProfit=600        ; Chốt lời (600 points)
InpMagicNumber=123456    ; Mã định danh EA
InpSlippage=10           ; Trượt giá tối đa
InpUseBreakEven=true     ; Sử dụng BreakEven (Bật)
InpBreakEvenTrigger=150  ; Mức kích hoạt BreakEven (150 points)
InpUseTrailingStop=true  ; Sử dụng Trailing Stop (Bật)
InpTrailingStart=200     ; Mức bắt đầu Trailing Stop (200 points)
InpTrailingStop=200      ; Khoảng cách Trailing Stop (200 points)
InpMaxSpread=30          ; Spread tối đa cho phép vào lệnh
InpMaxOrders=1           ; Số lượng lệnh tối đa cùng lúc
InpEmaFast=9             ; Chu kỳ EMA nhanh
InpEmaSlow=50            ; Chu kỳ EMA chậm
```[cite: 1]

---

## 📊 Kết quả hiệu suất (Performance Results)

| Tiêu chí | Giá trị |
| :--- | :--- |
| **Tổng Lợi nhuận Ròng (Total Net Profit)** | **-$993.19**[cite: 1] |
| **Profit Factor** | **0.85**[cite: 1] |
| **Expected Payoff** | **-$0.20**[cite: 1] |
| **Sharpe Ratio** | **-5.00**[cite: 1] |
| **Sụt giảm tài khoản tối đa (Max Drawdown)** | **$994.86 (99.32%)**[cite: 1] |
| **Tổng số lệnh (Total Trades)** | **5,048**[cite: 1] |
| **Tỷ lệ thắng (Win Rate)** | **46.14%** (2,329 thắng / 2,719 thua)[cite: 1] |
| **Short Trades (Win %)** | 2,566 lệnh (46.57%)[cite: 1] |
| **Long Trades (Win %)** | 2,482 lệnh (45.69%)[cite: 1] |
| **Lợi nhuận trung bình lệnh thắng** | $2.37[cite: 1] |
| **Thua lỗ trung bình lệnh thua** | -$2.40[cite: 1] |
| **Chuỗi thắng liên tiếp tối đa** | 11 lệnh ($26.31)[cite: 1] |
| **Chuỗi thua liên tiếp tối đa** | 15 lệnh (-$36.70)[cite: 1] |
| **Thời gian giữ lệnh trung bình** | 00:03:01[cite: 1] |

---

## 📝 Đánh giá & Nhận xét kỹ thuật

* **Tần suất giao dịch cao (Overtrading):** Thực hiện 5,048 lệnh trong 4 tháng[cite: 1] (~40-50 lệnh/ngày) dẫn đến hệ thống bị quét tín hiệu nhiễu liên tục trên khung M1.
* **Tỷ lệ Risk/Reward bị lệch:** Mặc dù Win Rate đạt 46.14%[cite: 1], nhưng trung bình mỗi lệnh thắng ($2.37) nhỏ hơn lỗ trung bình (-$2.40)[cite: 1], làm cho kỳ vọng lợi nhuận âm (-$0.20/lệnh)[cite: 1] và dẫn tới sụt giảm tài khoản nghiêm trọng (99.32%)[cite: 1].
* **Tác động từ chi phí giao dịch:** Số lượng lệnh quá lớn khiến chi phí Spread và Trượt giá (Slippage) tích tụ, bào mòn toàn bộ tài khoản.

---

## 💡 Đề xuất tối ưu (Next Steps)

1. **Bộ lọc tín hiệu:** Tích hợp bộ lọc xu hướng/biến động như ADX hoặc ATR để tránh vào lệnh trong giai đoạn thị trường sideway.
2. **Tăng khung thời gian:** Chuyển sang khung M5 hoặc M15 để giảm nhiễu tín hiệu và khối lượng lệnh.
3. **Cấu hình lại R:R:** Điều chỉnh lại khoảng cách TakeProfit, BreakEvenTrigger và TrailingStart để tối ưu hóa việc khóa lợi nhuận.
