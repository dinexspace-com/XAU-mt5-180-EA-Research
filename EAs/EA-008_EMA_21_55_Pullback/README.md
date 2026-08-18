# EA-008: EMA 21/55 First Bounce Pullback Strategy (XAUUSD M1)

## 📌 Tổng quan (Overview)
`EA-008_EMA_21_55_Pullback` là một Expert Advisor (EA) giao dịch tự động trên cặp tiền **XAUUSD (Gold)** khung thời gian **M1**. Chiến lược tập trung vào việc xác định xu hướng chính bằng cặp đường trung bình động hàm mũ **EMA 21** và **EMA 55**, sau đó tìm kiếm điểm vào lệnh ở **cú bật lại đầu tiên (first bounce)** ngay sau khi giá pullback về đường **EMA 21**.

---

## 📐 Quy tắc Giao dịch (Trading Rules)

### 1. Phân tích Xu hướng (Trend Identification)
* **Xu hướng Tăng (Uptrend):** EMA 21 nằm trên EMA 55 ($EMA_{21} > EMA_{55}$).
* **Xu hướng Giảm (Downtrend):** EMA 21 nằm dưới EMA 55 ($EMA_{21} < EMA_{55}$).

### 2. Điều kiện Vào lệnh (Entry Conditions)
* **Lệnh BUY:** 
  * Xu hướng Tăng đang xác lập ($EMA_{21} > EMA_{55}$).
  * Giá pullback hồi về EMA 21 và xuất hiện **cú bật lại đầu tiên (first bounce)**.
  * Thỏa mãn lọc Spread (Spread $\le$ 30 points).
  * Chưa có lệnh nào đang mở (Tối đa 1 lệnh tại một thời điểm).

* **Lệnh SELL:** 
  * Xu hướng Giảm đang xác lập ($EMA_{21} < EMA_{55}$).
  * Giá pullback hồi về EMA 21 và xuất hiện **cú bật lại đầu tiên (first bounce)**.
  * Thỏa mãn lọc Spread (Spread $\le$ 30 points).
  * Chưa có lệnh nào đang mở (Tối đa 1 lệnh tại một thời điểm).

---

## ⚙️ Thông số Cấu hình (Input Parameters)

| Thông số | Giá trị mặc định | Mô tả |
| :--- | :--- | :--- |
| `InpFastEMA` | `21` | Chu kỳ EMA nhanh |
| `InpSlowEMA` | `55` | Chu kỳ EMA chậm |
| `InpStopLoss` | `300` | Cắt lỗ (points) |
| `InpTakeProfit` | `600` | Chốt lời (points) |
| `InpBreakEven` | `150` | Mức dịch SL về Hòa vốn (points) |
| `InpTrailingStop` | `200` | Mức Trailing Stop (points) |
| `InpMaxSpread` | `30` | Spread tối đa cho phép mở lệnh (points) |
| `InpMaxOrders` | `1` | Số lượng lệnh tối đa được mở đồng thời |

---

## 📂 Cấu trúc Lưu trữ Tệp
* **Mã nguồn:** `EAs/EA-008_EMA_21_55_Pullback/EA-008_EMA_21_55_Pullback.mq5`
* **Kết quả Backtest:** `Backtest/EA-008_EMA_21_55_Pullback/`
