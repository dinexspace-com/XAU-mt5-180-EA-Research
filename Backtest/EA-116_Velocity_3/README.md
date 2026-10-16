# EA-116 — Velocity 3 Backtest Report

## 1. Experiment Information

| Item | Value |
|---|---|
| EA | EA-116 — Velocity 3 |
| Source File | `EA-116_Velocity_3.mq5` |
| Experiment | Baseline #01 |
| Platform | MetaTrader 5 |
| Broker/Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## 2. Performance Summary

| Metric | Result |
|---|---:|
| Net Profit | -$994.08 |
| Gross Profit | $9,729.61 |
| Gross Loss | -$10,723.69 |
| Profit Factor | 0.91 |
| Expected Payoff | -$0.12 |
| Sharpe Ratio | -5.00 |
| Recovery Factor | -0.90 |
| Balance/Equity Drawdown | $1,108.31 |
| Relative Drawdown | 99.47% |
| Margin Level | 119.92% |
| Total Trades | 8,025 |
| Total Deals | 16,050 |

## 3. Trade Statistics

| Metric | Result |
|---|---:|
| Winning Trades | 3,615 (45.05%) |
| Losing Trades | 4,410 (54.95%) |
| Long Trades | 3,989 |
| Long Win Rate | 45.55% |
| Short Trades | 4,036 |
| Short Win Rate | 44.55% |
| Largest Profit Trade | $10.43 |
| Largest Loss Trade | -$11.90 |
| Average Profit Trade | $2.69 |
| Average Loss Trade | -$2.43 |
| Maximum Consecutive Wins | 10 ($32.36) |
| Maximum Consecutive Losses | 13 (-$35.10) |

## 4. Trade Duration and Correlation

| Metric | Result |
|---|---:|
| Minimum Holding Time | 3 seconds |
| Maximum Holding Time | 2h 03m 18s |
| Average Holding Time | 51 seconds |
| Profit/MFE Correlation | 0.96 |
| Profit/MAE Correlation | 0.69 |
| MFE/MAE Correlation | 0.6241 |
| Linear Regression Correlation | -0.36 |
| Linear Regression Standard Error | 240.33 |
| Z-Score | 0.53 (40.39%) |

## 5. Result Assessment

**Final Classification: FAIL**

Các chỉ số chính cho thấy chiến lược không đạt yêu cầu trong lần kiểm thử này:

1. Net Profit âm $994.08 trên vốn ban đầu $1,000.
2. Profit Factor 0.91, cho thấy tổng lợi nhuận gộp thấp hơn tổng thua lỗ gộp.
3. Expected Payoff âm $0.12 mỗi giao dịch.
4. Sharpe Ratio âm -5.00.
5. Relative Drawdown đạt 99.47%, phản ánh mức suy giảm vốn cực kỳ nghiêm trọng.

Tỷ lệ thắng 45.05% không đủ để bù đắp kết quả tổng thể trong cấu hình đã kiểm thử.

## 6. Decision

- **Baseline #01:** Completed.
- **Result:** FAIL.
- **Live Trading Approval:** Rejected.
- **Optimization:** Not started.
- **Further Research:** Diagnostic analysis only.

Không nên triển khai EA-116 trên tài khoản thật hoặc tài khoản có vốn đáng kể dựa trên kết quả hiện tại.

## 7. Next Experiment Requirements

Trước khi chạy thử nghiệm tiếp theo:

- Giữ nguyên và lưu lại kết quả baseline #01.
- Kiểm tra logic Velocity và thời điểm phát tín hiệu.
- Kiểm tra ảnh hưởng của spread, chi phí giao dịch và thời gian giữ lệnh.
- Chỉ thay đổi một nhóm biến trong mỗi thử nghiệm.
- Ghi lại toàn bộ tham số và chỉ số kết quả.
- Đánh giá trên giai đoạn dữ liệu khác trước khi cân nhắc kiểm định ngoài mẫu.

Mọi kết quả cải thiện trong các thử nghiệm tiếp theo phải được xác minh bằng dữ liệu; chưa có bằng chứng hiện tại cho thấy EA-116 đã được cải thiện.
