## EA-117 — Velocity 8 Baseline Experiment

### Experiment ID

`EA-117_Velocity_8_Baseline_01`

### Objective

Đánh giá hiệu quả baseline của chiến lược Price Velocity trên XAUUSD.PRO M1 với cấu hình `VelocityPeriod = 8` và `VelocityThreshold = 0.20%`.

### Test Environment

- Platform: MetaTrader 5
- Broker/Server: ACCMIntl-Real
- MT5 Build: 6230
- Symbol: XAUUSD.PRO
- Timeframe: M1
- Test Period: 2026-01-02 to 2026-04-01
- Initial Deposit: $1,000
- Leverage: 1:500
- History Quality: 100% real ticks

### Baseline Parameters

- Lot Size: 0.01
- Stop Loss: 300 points
- Take Profit: 600 points
- Magic Number: 117001
- Slippage: 10 points
- Break-Even: Enabled
- Break-Even Start: 150 points
- Break-Even Offset: 0 points
- Trailing Stop: Enabled
- Trailing Start: 200 points
- Trailing Distance: 200 points
- Maximum Spread: 30 points
- Velocity Period: 8
- Velocity Threshold: 0.20%

### Baseline Results

- Net Profit: -$992.62
- Gross Profit: $8,752.39
- Gross Loss: -$9,745.01
- Profit Factor: 0.90
- Expected Payoff: -$0.14
- Sharpe Ratio: -5.00
- Relative Drawdown: 99.32%
- Total Trades: 7,128
- Win Rate: 44.46%

### Classification

**FAIL**

Kết quả baseline cho thấy lợi nhuận âm, Profit Factor thấp hơn 1 và drawdown cực kỳ cao. EA-117 không được phê duyệt giao dịch thật dựa trên kết quả hiện tại.

### Research Controls

1. Giữ nguyên mã nguồn và báo cáo baseline.
2. Cấp Experiment ID riêng cho từng thử nghiệm.
3. Thay đổi một nhóm biến chính tại một thời điểm.
4. Ghi đầy đủ các tham số, điều kiện kiểm thử và kết quả.
5. Không trình bày giả thuyết như nguyên nhân đã được xác nhận.
6. Không xem tối ưu hóa trên dữ liệu đã dùng để lựa chọn tham số là kiểm định độc lập.
7. Chỉ tiến hành Out-of-Sample Validation khi có cơ sở rõ ràng từ các thử nghiệm trước.
8. Không phê duyệt live trading nếu chưa có bằng chứng về hiệu quả và kiểm soát rủi ro.

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
