# EA-108 — VWAP Crossback Backtest

## 1. Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-108_VWAP_Crossback |
| Baseline ID | `EA108-M1-BASELINE-001` |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123463 |
| Maximum Spread | 30 points |
| Rejection Buffer | 0 points |

## 2. Performance Summary

| Metric | Result |
|---|---:|
| Total Net Profit | -$992.86 |
| Gross Profit | $4,565.28 |
| Gross Loss | -$5,558.14 |
| Profit Factor | 0.82 |
| Expected Payoff | -$0.22 |
| Recovery Factor | -0.97 |
| Sharpe Ratio | -5.00 |
| Max Balance Drawdown | $1,017.25 (99.30%) |
| Max Equity Drawdown | $1,019.18 (99.30%) |
| Absolute Balance Drawdown | $992.86 |
| Absolute Equity Drawdown | $992.86 |
| Total Trades | 4,557 |
| Total Deals | 9,114 |
| Winning Trades | 2,158 (47.36%) |
| Losing Trades | 2,399 (52.64%) |

## 3. Directional Results

| Direction | Trades | Win Rate |
|---|---:|---:|
| SELL | 3,120 | 46.19% |
| BUY | 1,437 | 49.90% |

The BUY side had a higher reported win rate than the SELL side, but both directions require separate validation. Win rate alone does not establish profitability.

## 4. Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $34.29 |
| Largest Loss Trade | -$16.62 |
| Average Profit Trade | $2.12 |
| Average Loss Trade | -$2.32 |
| Maximum Consecutive Wins | 9 ($18.41) |
| Maximum Consecutive Losses | 12 (-$25.26) |
| Average Position Holding Time | 00:03:42 |
| Linear Regression Correlation | -0.98 |

## 5. Assessment

**Classification: FAIL**

The baseline lost almost the entire initial deposit and recorded a 99.30% maximum equity drawdown. The Profit Factor of 0.82 indicates that gross losses exceeded gross profits.

The 4,557-trade sample is large enough to identify a serious problem in this specific test configuration, but it does not establish how the strategy will perform on other periods or market conditions.

## 6. Decision

- **Live trading:** Not approved.
- **Broad parameter optimization:** Blocked until the entry logic and baseline behavior are reviewed.
- **Next step:** Verify signal implementation, inspect trade distribution, and test one research variable at a time.
- **Baseline integrity:** Preserve this report as `EA108-M1-BASELINE-001`.

## 7. Reproducibility

Store the original `.mq5` file and the Strategy Tester HTML report alongside this README. Record any code changes, input changes, test-period changes, and resulting reports as separate experiments.
