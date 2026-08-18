# EA-009 (EMA 34/89 Pullback - M1 / M5)

## 📌 Tổng quan Chiến lược
Chiến lược giao dịch theo xu hướng kết hợp tín hiệu hồi quy (pullback). Sử dụng đường EMA 34 và EMA 89 để xác định xu hướng chủ đạo, sau đó tìm kiếm điểm vào lệnh khi giá quay về chạm hoặc nén quanh vùng hỗ trợ/kháng cự của hai đường EMA.

## 📐 Thông số Kỹ thuật & Tín hiệu
* **Cặp tiền:** XAUUSD
* **Khung thời gian:** M1 / M5
* **Chỉ báo:** 
  * Exponential Moving Average (EMA) 34
  * Exponential Moving Average (EMA) 89
* **Điều kiện Buy:**
  1. EMA 34 nằm trên EMA 89 (Xu hướng tăng xác định).
  2. Giá hồi về (pullback) vùng giữa EMA 34 và EMA 89.
  3. Xuất hiện nến đảo chiều tăng / xác nhận tại vùng giá này.
* **Điều kiện Sell:**
  1. EMA 34 nằm dưới EMA 89 (Xu hướng giảm xác định).
  2. Giá hồi về (pullback) vùng giữa EMA 34 và EMA 89.
  3. Xuất hiện nến đảo chiều giảm / xác nhận tại vùng giá này.

## 🛡 Quản lý Rủi ro & Lệnh
* **Stop Loss (SL):** Đặt tại đỉnh/đáy gần nhất hoặc cố định theo Pips/Points.
* **Take Profit (TP):** Theo tỷ lệ R:R cố định hoặc nến mục tiêu.
* **Break Even (BE):** Tự động dời SL về Huề vốn khi đạt $N$ points lợi nhuận.
* **Trailing Stop:** Dời dừng lỗ theo sóng hoặc theo khoảng cách points cố định.
* **Bộ lọc Spread:** Không vào lệnh khi Spread lớn hơn ngưỡng quy định.
