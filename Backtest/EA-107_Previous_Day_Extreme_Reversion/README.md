
# EA-107 — Previous Day Extreme Reversion

## 1. Test Information

| Item | Value |
|---|---|
| EA | EA-107_Previous_Day_Extreme_Reversion |
| Baseline ID | `EA107-M1-BASELINE-001` |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Total Trades | 693 |
| Total Deals | 1,386 |

## 2. Performance Results

| Metric | Result |
|---|---:|
| Net Profit | -$152.75 |
| Gross Profit | $742.70 |
| Gross Loss | -$895.45 |
| Profit Factor | 0.83 |
| Expected Payoff | -$0.22 |
| Recovery Factor | -0.82 |
| Sharpe Ratio | -5.00 |
| Max Balance Drawdown | 18.33% |
| Max Equity Drawdown | 18.51% |
| Equity Drawdown Absolute | $175.37 |
| Winning Trades | 309 (44.59%) |
| Losing Trades | 384 (55.41%) |

## 3. Directional Analysis

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 333 | 43.84% |
| SELL | 360 | 45.28% |

Both directions had win rates below 50%. SELL performed slightly better by win rate, but this does not establish a profitable standalone short strategy.

## 4. Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $9.97 |
| Largest Loss Trade | -$6.94 |
| Average Profit Trade | $2.40 |
| Average Loss Trade | -$2.33 |
| Maximum Consecutive Wins | 7 |
| Maximum Consecutive Losses | 10 |
| Average Holding Time | 1 minute 29 seconds |

## 5. Assessment

**Baseline Classification: FAIL**

Reasons:

- Net profit is negative.
- Profit Factor is below 1.0.
- Expected Payoff is negative.
- Sharpe Ratio is negative.
- Maximum equity drawdown reached 18.51%.
- Both BUY and SELL win rates were below 50%.

The average winning trade was slightly larger than the average losing trade, but this advantage was insufficient to offset the frequency of losing trades.

## 6. Research Decision

| Stage | Status |
|---|---|
| Strategy Code | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Assessment | FAIL |
| Controlled Research | REQUIRED |
| Broad Optimization | BLOCKED |
| Out-of-Sample Validation | NOT STARTED |
| Walk-Forward Validation | NOT STARTED |
| Forward Test | NOT STARTED |
| Live Trading | NOT APPROVED |

## 7. Conclusion

EA-107 has not demonstrated a profitable baseline under the tested conditions. Preserve this report as the reference experiment and investigate the entry conditions before changing exit parameters or conducting broad optimization.
