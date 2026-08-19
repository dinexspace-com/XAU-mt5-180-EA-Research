# Strategy Tester Report: EA-010_EMA_50_200_Trend

Báo cáo kết quả backtest chiến lược giao dịch tự động **EA-010_EMA_50_200_Trend** trên cặp tiền **XAUUSD.PRO** (Vàng) khung thời gian **M1**.

---

## 📌 Thông tin tổng quan (Overview)

| Thông số | Giá trị |
| :--- | :--- |
| **Expert Advisor** | `EA-010_EMA_50_200_Trend` |
| **Sản phẩm (Symbol)** | `XAUUSD.PRO` |
| **Khung thời gian (Period)** | `M1 (2026.01.02 - 2026.06.01)` |
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
InpUseBreakEven=false    ; Sử dụng BreakEven (Tắt)
InpUseTrailingStop=false ; Sử dụng Trailing Stop (Tắt)
InpBreakEvenTrigger=150  ; Mức kích hoạt BreakEven (150 points)
InpTrailingStart=200     ; Mức bắt đầu Trailing Stop (200 points)
InpTrailingStop=200      ; Khoảng cách Trailing Stop (200 points)
InpMaxSpread=30          ; Spread tối đa cho phép vào lệnh
InpMaxOrders=1           ; Số lượng lệnh tối đa cùng lúc
InpEmaFast=50           ; Chu kỳ EMA nhanh
InpEmaSlow=200           ; Chu kỳ EMA chậm
```

---

## 📊 Kết quả hiệu suất (Performance Results)

| Tiêu chí | Giá trị |
| :--- | :--- |
| **Tổng Lợi nhuận Ròng (Total Net Profit)** | **-$993.92** |
| **Profit Factor** | **0.94** |
| **Expected Payoff** | **-$0.14** |
| **Sharpe Ratio** | **-5.00** |
| **Sụt giảm tài khoản tối đa (Max Drawdown)** | **$1,112.08 (99.46%)** |
| **Tổng số lệnh (Total Trades)** | **7,354** |
| **Tỷ lệ thắng (Win Rate)** | **32.40%** (2,383 thắng / 4,971 thua) |
| **Short Trades (Win %)** | 3,677 lệnh (32.10%) |
| **Long Trades (Win %)** | 3,677 lệnh (32.70%) |
| **Lợi nhuận trung bình lệnh thắng** | $6.12 |
| **Thua lỗ trung bình lệnh thua** | -$2.93 |
| **Chuỗi thắng liên tiếp tối đa** | 8 lệnh ($51.51) |
| **Chuỗi thua liên tiếp tối đa** | 17 lệnh (-$51.35) |
| **Thời gian giữ lệnh trung bình** | 00:03:18 |

---

## 📝 Đánh giá & Nhận xét kỹ thuật

* **Tần suất giao dịch cực kỳ cao (Overtrading):** Thực hiện 7,354 lệnh trong 5 tháng (~49 lệnh/ngày) trên khung M1 khiến hệ thống liên tục dính nhiễu tín hiệu (whipsaw) do phản ứng quá nhạy với biến động ngắn hạn.
* **Tỷ lệ thắng (Win Rate) quá thấp:** Chỉ đạt 32.40%, do đường EMA 50 và EMA 200 trên khung M1 liên tục cắt nhau qua lại trong các giai đoạn thị trường đi ngang (Sideway), gây ra chuỗi lệnh thua liên tiếp.
* **Không sử dụng tính năng quản lý lệnh động:** Việc tắt BreakEven (`InpUseBreakEven=false`) và Trailing Stop (`InpUseTrailingStop=false`) khiến các lệnh đạt lợi nhuận tạm thời không được bảo vệ, dễ bị quay đầu chạm Stop Loss.
* **Tác động tích lũy từ chi phí:** Số lượng lệnh khổng lồ làm cho chi phí Spread và Slippage tích tụ nhanh chóng, bào mòn gần như toàn bộ tài khoản ($993.92 / $1,000 vốn ban đầu).

---

## 💡 Đề xuất tối ưu (Next Steps)

1. **Bộ lọc xu hướng đa khung thời gian (MTF Filter):** Chỉ cho phép kích hoạt tín hiệu cắt EMA 50/200 trên M1 khi đồng nhất với xu hướng chủ đạo của khung lớn hơn (H1 hoặc H4).
2. **Kích hoạt công cụ quản lý lệnh động:** Bật Break Even và Trailing Stop để khóa lợi nhuận sớm khi giá đi đúng hướng.
3. **Bổ sung bộ lọc biến động (Volatiltiy/Volume):** Sử dụng thêm chỉ báo ATR hoặc ADX để bỏ qua tín hiệu vào lệnh trong những giai đoạn thị trường tích lũy, thanh khoản thấp.
4. **Chuyển sang khung thời gian cao hơn:** Thử nghiệm chiến lược trên khung M5, M15 hoặc H1 để giảm tần suất vào lệnh, loại bỏ nhiễu sóng và giảm thiểu chi phí giao dịch.
