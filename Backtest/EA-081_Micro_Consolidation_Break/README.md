
# EA-081 — Backtest Report

## Test Configuration

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Broker Server | ACCMIntl-Real |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-03-31 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| Modeling | Every tick based on real ticks |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |

## Performance Results

| Metric | Result |
|---|---:|
| Total Net Profit | $11.23 |
| Gross Profit | $312.67 |
| Gross Loss | -$301.44 |
| Profit Factor | 1.04 |
| Expected Payoff | $0.05 |
| Recovery Factor | 0.29 |
| Sharpe Ratio | 5.29 |
| Maximum Balance Drawdown | $37.57 (3.59%) |
| Maximum Equity Drawdown | $38.84 (3.71%) |
| Total Trades | 246 |
| Winning Trades | 124 (50.41%) |
| Losing Trades | 122 (49.59%) |
| Long Trades | 121 |
| Short Trades | 125 |
| Largest Profit Trade | $6.44 |
| Largest Loss Trade | -$3.44 |
| Average Profit Trade | $2.52 |
| Average Loss Trade | -$2.47 |

## Holding Time

| Metric | Duration |
|---|---|
| Minimum | 00:00:01 |
| Maximum | 00:38:30 |
| Average | 00:02:52 |

## Charts

### Balance

![Balance](balance.png)

### Entry Distribution

![Entries](entries.png)

### MFE and MAE

![MFE and MAE](mfe-mae.png)

### Holding Time

![Holding Time](holding-time.png)

## Original Report

[Open the complete MT5 Strategy Tester report](report.html)

The HTML report contains the original test settings, performance metrics and transaction records.

## Result Interpretation

The test produced a small positive net profit of $11.23 on $1,000 initial capital.

The Profit Factor of 1.04 indicates that gross profits only marginally exceeded gross losses.

The maximum reported equity drawdown was 3.71%.

Although the test contains 246 trades, this single three-month sample is insufficient to establish long-term robustness.

Status: BACKTEST COMPLETED — RESEARCH PENDING.
