# XAUUSD.PRO M1 Strategy - Methodology & Backtest Analysis

## 1. Thông số Kỹ thuật (System Specifications)
* **Công cụ giao dịch (Symbol):** XAUUSD.PRO (Vàng)[cite: 1]
* **Khung thời gian (Timeframe):** M1 (1 phút)[cite: 1]
* **Thời gian kiểm thử (Period):** 2026.01.02 – 2026.07.01 (6 tháng)[cite: 1]
* **Vốn ban đầu (Initial Deposit):** $1,000.00 USD[cite: 1]
* **Loại chiến lược:** Scalping / Trend-Following (SMA 20 & SMA 100 Crossover)[cite: 1]

---

## 2. Kết quả Thực nghiệm (Backtest Performance Summary)
* **Tổng lợi nhuận ròng (Net Profit):** -$689.15 USD (Thua lỗ ~68.9%)[cite: 1]
* **Mức sụt giảm tài khoản tối đa (Max Drawdown):** 71.47% (-$718.62 USD)[cite: 1]
* **Hệ số lợi nhuận (Profit Factor):** 0.82[cite: 1]
* **Tỷ số Sharpe (Sharpe Ratio):** -5.00[cite: 1]
* **Tổng số lệnh thực hiện:** 2,329 lệnh[cite: 1]
* **Tỷ lệ thắng (Win Rate):** 40.36% (940 lệnh thắng / 1,389 lệnh thua)[cite: 1]

---

## 3. Phân tích Nguyên nhân Thất bại (Root Cause Analysis)
1. **Giao dịch quá tần suất (Severe Over-trading Drag):**
   * Tổng cộng 2,329 lệnh trong 6 tháng (~18 lệnh/ngày) trên khung M1 làm cho phí Spread và Commission tích lũy cực kỳ lớn, ăn mòn nghiêm trọng vốn ban đầu[cite: 1].
2. **Nhiễu thị trường ở khung M1 (Market Whipsaws):**
   * Khung M1 có quá nhiều tín hiệu cắt giả. Tỷ lệ thua 59.64% và chuỗi 13 lệnh thua liên tiếp cho thấy thuật toán bị dính cắt lỗ liên tục trong các giai đoạn thị trường đi ngang (sideway)[cite: 1].
3. **Mức sụt giảm tài khoản lớn (High Drawdown Risk):**
   * Drawdown chạm mốc 71.47% cho thấy chiến lược không có khả năng bảo toàn vốn khi gặp chuỗi thị trường xấu[cite: 1].

---

## 4. Kế hoạch Cải tiến (Action Plan & Optimization)
* **Khung thời gian:** Chuyển giao dịch từ M1 lên khung M15, H1 hoặc H4 để giảm nhiễu giá và kiểm soát số lượng lệnh.
* **Bộ lọc xu hướng:** Tích hợp bộ lọc Trend (như EMA 200 H1 hoặc ADX > 25) để loại bỏ tín hiệu vào lệnh vùng thị trường đi ngang.
* **Tối ưu chỉ báo:** Thay thế SMA bằng EMA để tăng tốc độ phản ứng với giá, giảm độ trễ tín hiệu.
* **Quản lý rủi ro:** Lập trình EA tự động tính khối lượng (Lot size) theo % rủi ro cố định (1-2%/lệnh) thay vì dùng Lot cố định[cite: 1].

---

## 5. Nhật ký Phiên bản (Versioning Log)
* **v1.0.0 (2026-07-01):** Thử nghiệm bản EA-005 gốc trên M1. Trạng thái: **THẤT BẠI** (Net Profit: -$689.15, Drawdown: 71.47%)[cite: 1].
* **v1.1.0 (Dự kiến):** Chuyển sang khung M15/H1, đổi SMA sang EMA, bổ sung bộ lọc ADX và quản lý vốn theo % rủi ro.
