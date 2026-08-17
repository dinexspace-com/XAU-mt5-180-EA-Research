# EA-004: SMA 10/30 Cross Strategy (XAUUSD M1)

Expert Advisor giao dịch theo tín hiệu giao cắt giữa đường trung bình động đơn giản (SMA) 10 và SMA 30 trên cặp tiền XAUUSD khung thời gian M1.

---

## 📌 Thông tin chung

* **Cặp tiền (Symbol):** XAUUSD (Vàng)
* **Khung thời gian (Timeframe):** M1 (1 Phút)
* **Loại chiến lược:** Trend Following / Moving Average Crossover

---

## 📈 Quy tắc giao dịch (Trading Rules)

### 1. Điều kiện vào lệnh (Entry Conditions)
Tín hiệu giao cắt chỉ được xác nhận khi **nến M1 hoàn tất (đóng cửa)** sau thời điểm giao cắt xảy ra:

* **Lệnh BUY:** 
  * đường SMA 10 cắt lên trên đường SMA 30.
  * Xác nhận khi nến M1 kết thúc.
* **Lệnh SELL:** 
  * Đường SMA 10 cắt xuống dưới đường SMA 30.
  * Xác nhận khi nến M1 kết thúc.

### 2. Quản lý lệnh & Rủi ro (Risk & Trade Management)
* **Số lệnh tối đa (Max Concurrent Positions):** 1 lệnh tại một thời điểm.
* **Lợi nhuận mục tiêu (Take Profit):** 600 points.
* **Dừng lỗ (Stop Loss):** 300 points.
* **Hòa vốn (Break Even):** Kích hoạt khi giá đi đúng hướng **150 points** (dời SL về giá vào lệnh).
* **Bám đuổi giá (Trailing Stop):** Kích hoạt khi giá đi đúng hướng **200 points**.
* **Lọc Spread (Max Spread Limit):** Tối đa **30 points** (nếu spread vượt quá 30 points, EA sẽ bỏ qua tín hiệu).

---

## ⚙️ Bảng tham số đầu vào (Input Parameters)

| Tham số | Giá trị mặc định | Mô tả |
| :--- | :--- | :--- |
| `Fast_SMA_Period` | `10` | Chu kỳ đường SMA nhanh |
| `Slow_SMA_Period` | `30` | Chu kỳ đường SMA chậm |
| `InpTakeProfit` | `600` | Take Profit (Points) |
| `InpStopLoss` | `300` | Stop Loss (Points) |
| `InpBreakEven` | `150` | Mức kích hoạt Break Even (Points) |
| `InpTrailingStop` | `200` | Mức kích hoạt Trailing Stop (Points) |
| `InpMaxSpread` | `30` | Spread tối đa cho phép vào lệnh (Points) |
| `InpMaxPositions` | `1` | Số lượng lệnh tối đa mở đồng thời |
