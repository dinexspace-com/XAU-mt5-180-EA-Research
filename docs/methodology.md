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

---

## EA-037 — MACD Fifth Element Research Methodology

- [x] Strategy code and technical specification: `EAs/EA-037_MACD_Fifth_Element/`
- [x] Four technical backtests preserved: `Backtest/EA-037_MACD_Fifth_Element/`
- [x] Research record: `Research/EA-037_MACD_Fifth_Element/`
- [x] Current result: **FAIL / RESEARCH ONLY**
- [ ] Complete real-tick retest
- [ ] Exposure-normalized stop comparison
- [ ] IS/OOS and walk-forward validation

The baseline tests four same-sign MACD 12/26/9 histogram bars and evaluates entry at the fifth bar. Stop models are the previous opposite histogram-wave price extreme and ATR(14) × 2.0. Position management uses 50% partial close at 1R, final target at 2R and break-even after TP1.

M15 wave baseline: Net Profit -$1,711.25, Profit Factor 0.99 and Equity Drawdown 83.29%. M15 ATR, H1 wave and H1 ATR produced positive nominal profit in their recorded runs, but Equity Drawdown remained 88.72%, 52.46% and 68.34%, respectively. All variants fail the risk requirement.

Broad optimization remains blocked. The next sequence is exposure normalization, complete real-tick testing, controlled direction/timeframe/stop/exit experiments, parameter-neighborhood analysis, out-of-sample validation and walk-forward testing.
