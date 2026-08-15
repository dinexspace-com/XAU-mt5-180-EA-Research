## 🔬 Research & Hypotheses (Nghiên cứu & Giả thuyết)

### 1. Problem Identification (Nhận diện vấn đề)
Dựa trên kết quả Backtest ban đầu (V1.0):
- **Tín hiệu nhiễu cao:** Khung M1 trên XAUUSD quá nhiều nhiễu, dẫn đến tỷ lệ thua 69.28%.
- **Chi phí giao dịch bào mòn tài khoản:** Với 2,884 lệnh/7 tháng, chi phí Spread/Slippage chiếm tỷ trọng rủi ro lớn.
- **Drawdown quá lớn:** Sụt giảm tài khoản đỉnh điểm lên tới ~64.87%.

---

### 2. Hypotheses for Improvement (Các giả thuyết cải tiến)

- [ ] **Hypothesis 1 (Khung thời gian):** Chuyển từ khung M1 sang M5 hoặc M15 sẽ giảm số lượng tín hiệu giả, nâng Win Rate lên trên 45%.
- [ ] **Hypothesis 2 (Bộ lọc Xu hướng - Trend Filter):** Thêm đường EMA 200 làm bộ lọc xu hướng chính (chỉ BUY khi giá nằm trên EMA 200, chỉ SELL khi giá nằm dưới EMA 200).
- [ ] **Hypothesis 3 (Quản lý lệnh tự động):** Kích hoạt BreakEven (`InpUseBreakEven = true`) khi đạt 150 pips để bảo toàn lợi nhuận, tránh biến lệnh thắng thành lệnh thua.
- [ ] **Hypothesis 4 (Bộ lọc biến động - Volatility Filter):** Sử dụng ATR (Average True Range) để né tránh các giai đoạn thị trường tích lũy (Sideway) có biến động quá thấp.

---

### 3. Proposed Experiments (Kế hoạch thực nghiệm)

| Mã thí nghiệm | Nội dung thay đổi | Mục tiêu cần đạt | Trạng thái |
| :--- | :--- | :--- | :--- |
| **EXP-01** | Test trên khung M5 với tham số cũ | Win Rate > 40%, Drawdown < 30% | ⏳ Pending |
| **EXP-02** | Thêm lọc Trend EMA 200 trên M1/M5 | Profit Factor > 1.2 | ⏳ Pending |
| **EXP-03** | Bật BreakEven + Trailing Stop | Giảm Max Drawdown xuống < 20% | ⏳ Pending |
| **EXP-04** | Tối ưu hóa R:R (SL 150 / TP 300) | Tăng Expected Payoff > 0 | ⏳ Pending |
