## EA-116 — Velocity 3: Experiment Record

### Experiment ID

`EA-116_Velocity_3_Baseline_01`

### Objective

Đánh giá hiệu quả ban đầu của chiến lược Price Velocity trên XAUUSD.PRO, khung thời gian M1, bằng cấu hình tham số mặc định của EA-116.

### Baseline Configuration

- Velocity Period: 3
- Velocity Threshold: 0.10%
- Lot Size: 0.01
- Stop Loss: 300 points
- Take Profit: 600 points
- Break-Even: Enabled
- Break-Even Start: 150 points
- Trailing Stop: Enabled
- Trailing Start: 200 points
- Trailing Distance: 200 points
- Maximum Spread: 30 points

### Test Environment

- Platform: MetaTrader 5
- Symbol: XAUUSD.PRO
- Timeframe: M1
- Test Period: 2026-01-02 to 2026-04-01
- Initial Deposit: $1,000
- Leverage: 1:500
- History Quality: 100% real ticks

### Baseline Results

- Net Profit: -$994.08
- Profit Factor: 0.91
- Expected Payoff: -$0.12
- Sharpe Ratio: -5.00
- Relative Drawdown: 99.47%
- Total Trades: 8,025
- Win Rate: 45.05%

### Decision

**Classification: FAIL**

Cấu hình baseline không đạt yêu cầu do lợi nhuận âm, Profit Factor dưới 1, Sharpe Ratio âm và drawdown quá cao.

EA-116 chưa được phê duyệt cho giao dịch thực. Chưa có thử nghiệm tối ưu hóa hoặc kiểm định ngoài mẫu nào được xác nhận hoàn thành trong hồ sơ này.

### Research Protocol

1. Giữ nguyên mã nguồn và kết quả baseline để đối chiếu.
2. Mỗi thử nghiệm phải có ID, mục tiêu, cấu hình và báo cáo riêng.
3. Chỉ thay đổi một nhóm biến chính trong mỗi thử nghiệm.
4. Ghi lại cả kết quả tích cực lẫn tiêu cực.
5. Không xem kết quả tối ưu hóa trên cùng tập dữ liệu là bằng chứng đủ để triển khai live.
6. Thực hiện kiểm định ngoài mẫu trước khi cân nhắc forward testing.
7. Chỉ đánh giá khả năng giao dịch thực sau khi có đủ bằng chứng về lợi nhuận, drawdown, chi phí và độ ổn định.

### Status Tracking

| Stage | Status |
|---|---|
| Source Code Recorded | Completed |
| Baseline Backtest | Completed |
| Baseline Assessment | FAIL |
| Diagnostic Research | Pending |
| Parameter Optimization | Not Started |
| Out-of-Sample Validation | Not Completed |
| Forward Testing | Not Completed |
| Live Trading Approval | Not Approved |
