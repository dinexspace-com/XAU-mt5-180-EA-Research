
# EA-080 — Backtest Report

**Test Date:** September 25, 2026  
**Result:** FAIL

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-080_Impulse_Candle_Break |
| Broker Server | ACCMIntl-Real |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 to 2026-03-31 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Modeling Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |

## Performance

| Metric | Result |
|---|---:|
| Net Profit | -$774.76 |
| Gross Profit | $3,496.90 |
| Gross Loss | -$4,271.66 |
| Profit Factor | 0.82 |
| Expected Payoff | -$0.24 |
| Recovery Factor | -0.94 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | 78.98% |
| Maximum Equity Drawdown | 79.02% |
| Total Trades | 3,206 |
| Winning Trades | 1,522 |
| Losing Trades | 1,684 |
| Win Rate | 47.47% |

## Directional Performance

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 1,597 | 48.59% |
| SELL | 1,609 | 46.36% |

## Trade Statistics

| Metric | Result |
|---|---:|
| Average Win | $2.30 |
| Average Loss | -$2.54 |
| Largest Win | $9.79 |
| Largest Loss | -$7.04 |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 10 |
| Minimum Holding Time | 2 seconds |
| Average Holding Time | 2 min 17 sec |
| Maximum Holding Time | 2 hr 14 min 10 sec |

## Balance Curve

![Balance Curve](ReportTester-952747(20260925-003138).png)

The balance curve shows a sustained decline during the test period, ending substantially below the initial deposit.

## Trade Distribution

![Trade Distribution](ReportTester-952747-hst(20260925-003138).png)

The chart displays entry distribution and profit/loss by hour, weekday and month.

## MFE and MAE

![MFE and MAE](ReportTester-952747-mfemae(20260925-003139).png)

Reported correlations:

- Profit / MFE: 0.96
- Profit / MAE: 0.76
- MFE / MAE: 0.6529

## Holding Time

![Holding Time](ReportTester-952747-holding(20260925-003138).png)

Average position holding time was 2 minutes and 17 seconds.

## Conclusion

**Baseline: FAIL**

The strategy generated 3,206 trades but produced negative net profit, a profit factor below 1 and a maximum equity drawdown of 79.02%.

The current configuration is not validated for live trading.

## Original Report

`ReportTester-952747(20260925-003140).html`
