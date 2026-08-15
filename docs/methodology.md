# 📐 Strategy Methodology & Development Workflow

Tài liệu này mô tả phương pháp luận nghiên cứu và quy trình phát triển cho Robot giao dịch (EA-001) trên thị trường XAUUSD.

---

## 1. Core Trading Strategy (Phương pháp giao dịch cốt lõi)

- **Chiến lược:** Theo xu hướng (Trend Following) dựa trên sự giao cắt của các đường trung bình động mũ (EMA Crossover).
- **Tín hiệu vào lệnh:**
  - **BUY:** Khi đường `Fast EMA` cắt lên trên đường `Slow EMA`.
  - **SELL:** Khi đường `Fast EMA` cắt xuống dưới đường `Slow EMA`.
- **Quản lý rủi ro (Risk Management):**
  - Khối lượng cố định (Fixed Lot): `0.01` lot.
  - Tỷ lệ Risk/Reward cố định với Dừng lỗ (Stop Loss) và Chốt lời (Take Profit) tính theo pips.

---

## 2. Research & Development Workflow (Quy trình nghiên cứu)

Mọi cải tiến cho EA phải tuân theo quy trình 4 bước bên dưới:

1. **Baseline Backtest (Đánh giá ban đầu):** Chạy backtest cài đặt mặc định trên dữ liệu lịch sử chuẩn (100% Real Ticks) để làm mốc so sánh.
2. **Formulate Hypothesis (Đưa ra giả thuyết):** Xác định điểm yếu (vd: Win Rate thấp, Drawdown cao) và đưa ra giải pháp xử lý (vd: thêm bộ lọc xu hướng, đổi khung thời gian).
3. **Run Experiment (Chạy thực nghiệm):** Chạy lại backtest/optimization chỉ với 1 thay đổi duy nhất để kiểm tra tính hiệu quả của giả thuyết.
4. **Evaluate & Iterate (Đánh giá & Cải tiến):** So sánh các chỉ số (Profit Factor, Max Drawdown, Win Rate). Nếu kết quả tốt hơn baseline, chấp nhận cải tiến vào mã nguồn chính.

---

## 3. Evaluation Metrics (Tiêu chuẩn đánh giá EA)

EA được coi là đạt yêu cầu khi đáp ứng đủ các tiêu chí sau:

| Chỉ số (Metric) | Mức tối thiểu (Benchmark) | Mục tiêu (Target) |
| :--- | :--- | :--- |
| **Profit Factor** | > 1.20 | > 1.50 |
| **Win Rate** | > 40.0% | > 50.0% |
| **Max Drawdown** | < 30.0% | < 20.0% |
| **Expected Payoff** | > 0.5 USD / lệnh | > 1.5 USD / lệnh |
