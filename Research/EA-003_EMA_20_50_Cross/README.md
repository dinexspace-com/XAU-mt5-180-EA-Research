# Quantitative Research & Optimization Journal

Thư mục ghi nhận kết quả nghiên cứu định lượng, phân tích hiệu suất và lộ trình cải tiến các thuật toán EA cho thị trường XAUUSD.

---

## 1. Ongoing EA Evaluations

### **EA-003: Trend EMA 20/50 Cross (M1)**
- **Trạng thái:** Đã hoàn thành Backtest giai đoạn 1 (01/2026 - 08/2026).
- **Đánh giá sơ bộ:** 
  - Profit Factor đạt **1.05**, Win Rate **57.14%**.
  - Tần suất giao dịch rất thấp (**7 lệnh / 7 tháng**), cho thấy điều kiện vào lệnh trùng khớp (EMA Crossover + Price Filters + Spread Limit) trên M1 quá khắt khe hoặc thiếu dữ liệu kích hoạt.
- **Hướng tối ưu (Next Steps):**
  1. **Nới lỏng điều kiện lọc:** Thử nghiệm loại bỏ điều kiện bắt buộc `Price > EMA20 > EMA50` tại nến đóng cửa để tăng tần suất lệnh.
  2. **Tối ưu hóa tham số (Optimization):** Chạy Optimization cho bộ tham số SL/TP và chu kỳ EMA (ví dụ: EMA 10/30 hoặc EMA 20/100).
  3. **Thử nghiệm đa khung thời gian:** Mở rộng backtest sang M5 và M15 để so sánh hiệu suất thu được.

---

## 2. Methodology & Guidelines
- Tất cả thử nghiệm backtest đều phải thực hiện trên dữ liệu **100% Real Ticks**.
- Quản lý rủi ro cố định per trade, kiểm soát spread $\le 30$ points trước khi khớp lệnh.
- Mọi thay đổi về logic hoặc tham số tối ưu đều phải được ghi lại trong thư mục `Backtest/` tương ứng trước khi cập nhật mã nguồn chính tại `EAs/`.
