# Backtest Report Summary — EA-002

## 1. Môi trường Backtest (Environment)

* **Thiết bị/Sàn:** ACCMIntl-Real (ACCM Intl Limited)
* **Cặp tiền:** XAUUSD.PRO
* **Khung thời gian:** M1 (2026.01.02 - 2026.08.01)
* **Mô hình test:** 100% real ticks
* **Spread:** Max 30 points
* **Vốn ban đầu:** $1,000.00 | **Đòn bẩy:** 1:500

---

## 2. Thông số chạy Backtest (Inputs Used)

| Tham số | Giá trị |
| :--- | :--- |
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 points |
| `InpTakeProfit` | 600 points |
| `InpMAPeriodFast` | 13 |
| `InpMAPeriodSlow` | 34 |
| `InpBreakEvenEnable` | false |
| `InpTrailingEnable` | false |
| `InpMaxSpread` | 30 points |

---

## 3. Chỉ số hiệu suất chính (Key Performance Indicators)

| Chỉ số (Metric) | Kết quả | Tiêu chuẩn đánh giá | Đánh giá nhanh |
| :--- | :--- | :--- | :--- |
| **Total Net Profit** | **-$180.98** | > $0 | ❌ Thua lỗ |
| **Profit Factor (PF)** | **0.40** | > 1.3 | ❌ Quá thấp |
| **Max Drawdown ($ / %)** | **$258.38 (25.41%)** | < 20% | ❌ Vượt mức rủi ro |
| **Total Trades** | **12** | > 100 trades | ⚠️ Mẫu test quá nhỏ |
| **Win Rate (%)** | **16.67%** (2/12) | — | ❌ Tỷ lệ thắng rất thấp |
| **Expected Payoff** | **-$15.08** | > 0 | ❌ Âm mỗi lệnh |
| **Sharpe Ratio** | **-2.27** | > 1.0 | ❌ Hiệu suất kém |

---

## 4. Nhật ký các đợt test (Test History Logs)

| Run ID | Ngày test | Giai đoạn test | Total Profit | Max DD | Nhận xét nhanh | File Report |
| :---: | :---: | :---: | :---: | :---: | :--- | :--- |
| **#01** | 15/08/2026 | 01/2026 - 08/2026 | -$180.98 | 25.41% | Chạy baseline (BE & Trailing = OFF) | `reports/ReportTester-953688.html` |

---

## 5. Phân tích & Hướng tối ưu tiếp theo

* **Nguyên nhân kết quả kém:**
  1. Tỷ lệ thắng quá thấp (16.67%), chỉ thắng 2/12 lệnh.
  2. Mẫu test 7 tháng chỉ có 12 lệnh là quá ít đối với khung M1.
  3. `InpBreakEvenEnable` và `InpTrailingEnable` đang bị tắt (`false`), khiến EA không bảo vệ được lợi nhuận khi giá chạy đúng hướng.
* **Hướng cải thiện:**
  1. Bật `InpBreakEvenEnable = true` và `InpTrailingEnable = true` để kiểm thử lại.
  2. Xem xét thêm bộ lọc xu hướng ở khung lớn hơn (ví dụ H1/H4) để tránh vào lệnh nhiễu ở M1.
