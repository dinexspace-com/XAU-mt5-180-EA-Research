# EA-002: Trend EMA (13, 34) Cross — XAUUSD M1

## 1. Tổng quan chiến lược
* **Mã EA:** EA-002
* **Tên chiến lược:** EMA 13/34 Crossover with Candle Color Filter
* **Cặp tiền:** XAUUSD (Gold)
* **Khung thời gian:** M1
* **Loại chiến lược:** Trend Following (Theo xu hướng)

---

## 2. Quy tắc Giao dịch (Trading Rules)

### Điều kiện MUA (BUY)
1. **Giao cắt:** Đường EMA 13 cắt lên trên đường EMA 34.
2. **Xác nhận nến:** Nến tín hiệu (nến đóng cửa) phải là **Nến Xanh (Tăng)**.

### Điều kiện BÁN (SELL)
1. **Giao cắt:** Đường EMA 13 cắt xuống dưới đường EMA 34.
2. **Xác nhận nến:** Nến tín hiệu (nến đóng cửa) phải là **Nến Đỏ (Giảm)**.

---

## 3. Quản lý Vốn & Rủi ro (Risk Management)

* **Số lệnh tối đa đồng thời:** 1 lệnh (`Max Orders = 1`)
* **Lọc Spread:** Tối đa 30 points (`Max Spread = 30 points`)
* **Stop Loss (SL):** 300 points
* **Take Profit (TP):** 600 points
* **Break Even (BE):** Kích hoạt khi giá chạy đạt 150 points
* **Trailing Stop:** Kích hoạt từ 200 points

---

## 4. Danh sách Tham số Đầu vào (Input Parameters)

| Tham số | Giá trị mặc định | Mô tả |
| :--- | :--- | :--- |
| `InpFastEMAPeriod` | `13` | Chu kỳ EMA nhanh |
| `InpSlowEMAPeriod` | `34` | Chu kỳ EMA chậm |
| `InpStopLoss` | `300` | Stop Loss (points) |
| `InpTakeProfit` | `600` | Take Profit (points) |
| `InpBreakEven` | `150` | Điểm kích hoạt hòa vốn (points) |
| `InpTrailingStart` | `200` | Điểm bắt đầu Trailing Stop (points) |
| `InpMaxSpread` | `30` | Spread tối đa cho phép vào lệnh (points) |
| `InpMaxOrders` | `1` | Số lượng lệnh tối đa |
