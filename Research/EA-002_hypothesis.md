# Nghiên cứu & Phân tích Thuật toán EA-002 (XAUUSD M1)

## 1. Giả thuyết Giao dịch Ban đầu (Initial Hypothesis)
* **Ý tưởng cốt lõi:** Khung thời gian M1 của XAUUSD có biến động mạnh. Việc kết hợp sự giao cắt của EMA 13 và EMA 34 cùng với nến tín hiệu đồng màu sẽ giúp bắt sớm xu hướng ngắn hạn và loại bỏ một phần tín hiệu giả (nhiễu).
* **Kỳ vọng:** Tỷ lệ Risk:Reward cố định 1:2 (SL 300 points / TP 600 points) sẽ tạo lợi thế dương ngay cả khi tỷ lệ thắng (Win Rate) đạt ~40%.

---

## 2. Phân tích Kết quả Backtest Đợt 1 (#01)

Dựa trên dữ liệu chạy thử nghiệm giai đoạn 01/2026 - 08/2026:

### a. Vấn đề phát hiện
1. **Tần suất giao dịch quá thấp:** Chỉ xuất hiện 12 lệnh trong vòng 7 tháng trên khung M1. Điều này cho thấy điều kiện vào lệnh (Cross + Nến đồng màu tại thời điểm đóng cửa) xảy ra rất ít hoặc điều kiện lọc Spread (<= 30 points) đã loại bỏ phần lớn cơ hội vào lệnh.
2. **Hiệu suất kém (Win Rate 16.67%):**
   * Lệnh Buy: 0/7 lệnh thắng (0%).
   * Lệnh Sell: 2/5 lệnh thắng (40%).
   * Giá XAUUSD thường xuyên đảo chiều ngay sau khi xảy ra giao cắt EMA ở khung M1 (Hiện tượng Breakout giả / Trap).
3. **Quản lý vị thế chưa tối ưu:** Do tắt hoàn toàn Break Even và Trailing Stop (`InpBreakEvenEnable = false`, `InpTrailingEnable = false`), nhiều lệnh đã đi đúng hướng một khoảng ngắn nhưng sau đó quay đầu dính Stop Loss đầy đủ 300 points.

---

## 3. Đề xuất Cải tiến & Hướng Nghiên cứu Tiếp theo (Action Plan)

* [ ] **Thử nghiệm #02 (Kích hoạt Quản lý lệnh):** Bật `InpBreakEvenEnable = true` (150 points) và `InpTrailingEnable = true` (200 points) để đánh giá khả năng bảo toàn vốn.
* [ ] **Thử nghiệm #03 (Lọc xu hướng khung lớn hơn - Multi-Timeframe Filter):**
  * Chỉ cho phép **BUY** khi giá nằm trên EMA 200 khung H1.
  * Chỉ cho phép **SELL** khi giá nằm dưới EMA 200 khung H1.
* [ ] **Thử nghiệm #04 (Tối ưu hóa tham số - Optimization):** Quét (Scan) bộ thông số EMA (ví dụ Fast: 8-21, Slow: 21-55) để tìm cặp chu kỳ phù hợp hơn với đặc tính của Vàng (XAUUSD).
