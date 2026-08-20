# EA-012_Triple_EMA_5_20_50 (XAUUSD - M1)

## 1. Tổng quan (Overview)
* **Tên EA:** EA-012_Triple_EMA_5_20_50
* **Cặp tiền giao dịch:** XAUUSD (Gold)
* **Khung thời gian (Timeframe):** M1
* **Chiến lược:** Trend Following (Đi theo xu hướng sử dụng bộ 3 đường EMA 5, 20, 50)

---

## 2. Logic giao dịch (Trading Logic)

### Điều kiện BUY (Buy Signal)
* **Thứ tự đường EMA:** `EMA(5) > EMA(20) > EMA(50)` (Thể hiện xu hướng tăng rõ ràng).
* **Điều kiện lọc:**
  * Spread thị trường <= 30 points (3.0 pips).
  * Số lệnh đang chạy (Open Position Count) = 0 (Tối đa 1 lệnh tại một thời điểm).

### Điều kiện SELL (Sell Signal)
* **Thứ tự đường EMA:** `EMA(5) < EMA(20) < EMA(50)` (Thể hiện xu hướng giảm rõ ràng).
* **Điều kiện lọc:**
  * Spread thị trường <= 30 points (3.0 pips).
  * Số lệnh đang chạy (Open Position Count) = 0 (Tối đa 1 lệnh tại một thời điểm).

---

## 3. Thông số Quản lý lệnh & Rủi ro (Risk & Trade Management)

* **Stop Loss (SL):** 300 points (30 pips)
* **Take Profit (TP):** 600 points (60 pips)
* **Break Even (BE):** Di chuyển SL về Ký quỹ/Giá vào lệnh khi lợi nhuận đạt từ **150 points** (15 pips).
* **Trailing Stop:** Bắt đầu Trailing từ **200 points** (20 pips).
* **Max Spread:** 30 points (3.0 pips).
* **Max Concurrent Orders:** 1 lệnh.
