# EA-075 — Backtest Report

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-075_Session_Transition_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 to 2026-03-31 |
| Broker / Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Lot Size | 0.01 |

## Performance Summary

| Metric | Result |
|---|---:|
| Total Net Profit | -$9.67 |
| Gross Profit | $59.74 |
| Gross Loss | -$69.41 |
| Profit Factor | 0.86 |
| Expected Payoff | -$0.18 |
| Recovery Factor | -0.24 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | $37.27 (3.69%) |
| Maximum Equity Drawdown | $40.82 (4.04%) |
| Total Trades | 54 |
| Winning Trades | 22 (40.74%) |
| Losing Trades | 32 (59.26%) |
| Long Trades | 33 (42.42% won) |
| Short Trades | 21 (38.10% won) |
| Average Winning Trade | $2.72 |
| Average Losing Trade | -$2.17 |
| Largest Winning Trade | $6.27 |
| Largest Losing Trade | -$3.40 |
| Maximum Consecutive Wins | 5 |
| Maximum Consecutive Losses | 6 |

## Position Holding Time

| Metric | Duration |
|---|---|
| Minimum | 00:00:01 |
| Average | 00:02:26 |
| Maximum | 00:16:08 |

## Charts

The accompanying MT5 charts document:

- Balance curve.
- Entry distribution and profit/loss by hour, weekday and month.
- Profit versus maximum favorable and adverse excursion (MFE/MAE).
- Profit versus position holding time.

The report shows entries concentrated in the configured morning trading window.

## Findings

The supplied configuration produced a negative net profit over the three-month test.

Although maximum reported equity drawdown was 4.04%, gross losses exceeded gross profits and the profit factor was below 1.0.

The sample contains 54 trades, which is insufficient by itself to establish long-term robustness.

The strategy requires further investigation before deployment.

## Validation Status

- Historical MT5 report: Available
- Original chart images: Available
- Independent reproduction: Pending
- Out-of-sample validation: Pending
- Forward testing: Pending
- Live trading validation: Not established

**Conclusion:** The supplied backtest documents a negative result. It is retained as a research baseline, not as evidence of a profitable trading system.

## Source Files

Preserve the original MT5 HTML report and its accompanying PNG images without modification. The original report contains the full orders and deals history and the exact tested input configuration.
