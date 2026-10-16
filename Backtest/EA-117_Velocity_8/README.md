# EA-117 — Velocity 8 Backtest Report

## 1. Test Information

| Item | Value |
|---|---|
| Expert Advisor | EA-117_Velocity_8 |
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
| Symbols Tested | 1 |

## 2. Input Configuration

| Parameter | Value |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpMagicNumber` | 117001 |
| `InpSlippage` | 10 |
| `InpUseBreakEven` | true |
| `InpBreakEvenStart` | 150 |
| `InpBreakEvenOffset` | 0 |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 200 |
| `InpMaxSpread` | 30 |
| `InpVelocityPeriod` | 8 |
| `InpVelocityThreshold` | 0.20 |

## 3. Financial Results

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | -$992.62 |
| Gross Profit | $8,752.39 |
| Gross Loss | -$9,745.01 |
| Profit Factor | 0.90 |
| Expected Payoff | -$0.14 |
| Recovery Factor | -0.92 |
| Sharpe Ratio | -5.00 |
| Margin Level | 103.43% |

## 4. Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $992.62 |
| Balance Drawdown Maximal | $1,075.48 (99.32%) |
| Balance Drawdown Relative | 99.32% |
| Equity Drawdown Absolute | $992.62 |
| Equity Drawdown Maximal | $1,077.35 (99.32%) |
| Equity Drawdown Relative | 99.32% |

Drawdown gần 100% là mức rủi ro cực kỳ nghiêm trọng. Đây là một trong những lý do chính khiến cấu hình này không được chấp nhận.

## 5. Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 7,128 |
| Total Deals | 14,256 |
| Winning Trades | 3,169 (44.46%) |
| Losing Trades | 3,959 (55.54%) |
| Long Trades | 3,484 |
| Long Win Rate | 44.49% |
| Short Trades | 3,644 |
| Short Win Rate | 44.43% |
| Largest Profit Trade | $29.77 |
| Largest Loss Trade | -$11.35 |
| Average Profit Trade | $2.76 |
| Average Loss Trade | -$2.46 |
| Maximum Consecutive Wins | 12 ($34.26) |
| Maximum Consecutive Losses | 14 (-$45.71) |

## 6. Additional Metrics

| Metric | Result |
|---|---:|
| AHPR | 0.9994 (-0.06%) |
| GHPR | 0.9993 (-0.07%) |
| LR Correlation | -0.73 |
| LR Standard Error | 202.18 |
| Z-Score | -1.29 (80.29%) |
| Profit/MFE Correlation | 0.96 |
| Profit/MAE Correlation | 0.70 |
| MFE/MAE Correlation | 0.6311 |
| Minimum Holding Time | 2 seconds |
| Maximum Holding Time | 2h 06m 01s |
| Average Holding Time | 35 seconds |

## 7. Result Analysis

### Finding 1 — Negative Profitability

Net Profit là -$992.62. Gross Loss vượt Gross Profit, dẫn đến Profit Factor 0.90.

### Finding 2 — Severe Drawdown

Relative Drawdown đạt 99.32%. Chiến lược không bảo toàn được vốn trong cấu hình đã kiểm thử.

### Finding 3 — Low Win Rate

Tỷ lệ thắng tổng thể là 44.46%. Cả lệnh BUY và SELL đều có tỷ lệ thắng dưới 45%.

### Finding 4 — High Trade Frequency

EA thực hiện 7,128 giao dịch với thời gian giữ lệnh trung bình 35 giây. Cần nghiên cứu ảnh hưởng của spread, slippage và chi phí giao dịch. Báo cáo hiện tại chưa đủ để xác định riêng mức đóng góp của từng loại chi phí vào khoản lỗ.

## 8. Final Decision

**Baseline #01: FAIL**

- Baseline Backtest: Completed.
- Strategy Assessment: Failed.
- Parameter Optimization: Not started.
- Out-of-Sample Validation: Not completed.
- Forward Testing: Not completed.
- Live Trading Approval: Not approved.

## 9. Next Experiment Requirements

1. Lưu kết quả baseline làm mốc so sánh.
2. Kiểm tra riêng Velocity Period và Velocity Threshold.
3. Thử nghiệm riêng nhóm Stop Loss/Take Profit.
4. Đánh giá riêng Break-Even và Trailing Stop.
5. Ghi lại các tham số và chỉ số kết quả cho từng thử nghiệm.
6. Nếu có cấu hình triển vọng, kiểm định trên dữ liệu ngoài mẫu trước khi cân nhắc forward testing.

Không kết luận chiến lược đã cải thiện cho đến khi có báo cáo thử nghiệm hỗ trợ.
