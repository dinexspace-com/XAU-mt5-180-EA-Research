# EA-078 — Previous Week High/Low Backtest

## 1. Test Configuration

| Parameter | Value |
|---|---|
| Expert Advisor | EA-078_Previous_Week_High_Low |
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| Symbol | XAUUSD.PRO |
| Test Period | 2026-01-02 to 2026-03-31 |
| Tester Timeframe | M15 |
| EA Signal Timeframe | M1 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| Modeling Quality | 100% real ticks |
| Bars | 5,688 |
| Ticks | 39,639,179 |

## 2. Performance Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000 |
| Final Balance | $977.03 |
| Total Net Profit | -$22.97 |
| Gross Profit | $301.84 |
| Gross Loss | -$324.81 |
| Profit Factor | 0.93 |
| Expected Payoff | -$0.09 |
| Recovery Factor | -0.44 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | $50.35 (4.92%) |
| Maximum Equity Drawdown | $51.76 (5.05%) |
| Total Trades | 263 |
| Total Deals | 526 |

## 3. Trade Statistics

| Metric | Result |
|---|---:|
| Winning Trades | 133 (50.57%) |
| Losing Trades | 130 (49.43%) |
| Long Trades | 124 |
| Long Win Rate | 54.84% |
| Short Trades | 139 |
| Short Win Rate | 46.76% |
| Largest Winning Trade | $6.81 |
| Largest Losing Trade | -$5.12 |
| Average Winning Trade | $2.27 |
| Average Losing Trade | -$2.50 |
| Maximum Consecutive Wins | 7 |
| Maximum Consecutive Losses | 7 |

## 4. Balance Curve

![Balance Curve](ReportTester-952747(20260924-062957).png)

The balance curve fluctuated around the initial deposit during the test.

The strategy experienced an early profitable period, followed by declining performance.

The final balance was $977.03.

## 5. Entry Distribution

![Entry Distribution](ReportTester-952747-hst(20260924-062955).png)

The charts show entries and profit/loss distributions by hour, weekday and month.

Trading activity is unevenly distributed across the tested period.

The report covers January through March 2026 only. The charts should not be interpreted as evidence of full-year seasonality.

## 6. MFE and MAE Analysis

![MFE and MAE](ReportTester-952747-mfemae(20260924-062956).png)

| Correlation | Value |
|---|---:|
| Profit / MFE | 0.96 |
| Profit / MAE | 0.73 |
| MFE / MAE | 0.6290 |

These measurements describe the relationship between realized profit and favorable/adverse price excursions during the historical test.

They do not independently establish which exit mechanism should be changed.

## 7. Holding Time

![Holding Time](ReportTester-952747-holding(20260924-062956).png)

| Metric | Result |
|---|---|
| Minimum Holding Time | 1 second |
| Average Holding Time | 1 minute 13 seconds |
| Maximum Holding Time | 10 minutes 4 seconds |

The short average holding time makes execution conditions an important subject for further investigation.

## 8. Baseline Evaluation

| Research Criterion | Requirement | Actual | Result |
|---|---|---:|---|
| Trade Count | >200 | 263 | PASS |
| Net Profit | >$0 | -$22.97 | FAIL |
| Maximum Equity DD | <20% | 5.05% | PASS |

**Overall baseline status: FAIL.**

The strategy has not demonstrated positive profitability under this configuration.

## 9. Original MT5 Evidence

- [Original Strategy Tester Report](ReportTester-952747(20260924-062956).html)
- [Balance Curve](ReportTester-952747(20260924-062957).png)
- [Entry Distribution](ReportTester-952747-hst(20260924-062955).png)
- [MFE and MAE](ReportTester-952747-mfemae(20260924-062956).png)
- [Holding Time](ReportTester-952747-holding(20260924-062956).png)

Preserve these original files alongside this README without renaming or replacing their contents.
