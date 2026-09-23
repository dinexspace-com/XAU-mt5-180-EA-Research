
# EA-076 — Backtest Report

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-076_Round_Number_Break |
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
| Round Number Step | 10.0 |

## Performance Summary

| Metric | Result |
|---|---:|
| Total Net Profit | -$994.48 |
| Gross Profit | $12,390.83 |
| Gross Loss | -$13,385.31 |
| Profit Factor | 0.93 |
| Expected Payoff | -$0.10 |
| Recovery Factor | -0.97 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | $1,029.29 (99.47%) |
| Maximum Equity Drawdown | $1,030.41 (99.47%) |
| Total Trades | 10,326 |
| Total Deals | 20,652 |
| Winning Trades | 5,061 (49.01%) |
| Losing Trades | 5,265 (50.99%) |
| Long Trades | 5,299 (49.03% won) |
| Short Trades | 5,027 (49.00% won) |
| Average Winning Trade | $2.45 |
| Average Losing Trade | -$2.54 |
| Largest Winning Trade | $18.21 |
| Largest Losing Trade | -$18.35 |
| Maximum Consecutive Wins | 15 |
| Maximum Consecutive Losses | 13 |

## Position Holding Time

| Metric | Duration |
|---|---|
| Minimum | 00:00:01 |
| Average | 00:01:13 |
| Maximum | 03:33:14 |

## Charts

The accompanying MT5 charts document:

- Balance curve.
- Entry distribution and profit/loss by hour, weekday and month.
- Profit versus maximum favorable and adverse excursion (MFE/MAE).
- Profit versus position holding time.

The balance curve shows substantial fluctuations during the test period, followed by a sustained decline and near-total depletion of the initial account balance.

Trading activity is distributed across multiple trading hours, with notable concentrations around 13:00–16:00 in the report's recorded time.

## Findings

The baseline generated 10,326 trades over the three-month test.

Despite the large sample of completed trades, the strategy recorded negative net profit and a Profit Factor below 1.0.

The average losing trade exceeded the average winning trade in absolute value.

The maximum reported equity drawdown reached 99.47%, indicating near-total account depletion under the tested configuration.

The average holding time of 1 minute and 13 seconds makes execution conditions and transaction costs important areas for further investigation.

## Validation Status

- Original MT5 report: Available
- Original chart images: Available
- Independent reproduction: Pending
- Parameter optimization: Pending
- Out-of-sample validation: Pending
- Forward testing: Pending
- Live trading validation: Not established

**Conclusion:** Baseline #01 — FAIL.

The original results are preserved as the research baseline. The tested configuration is not suitable for live deployment without substantial further investigation and validation.

## Source Files

Preserve the original MT5 HTML report and its accompanying chart images without modification. The original report contains the complete orders and deals history and the exact tested input configuration.
