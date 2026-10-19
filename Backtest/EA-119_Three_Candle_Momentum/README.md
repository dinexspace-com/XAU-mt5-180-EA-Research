# EA-119 — Three Candle Momentum Backtest

## 1. Test Information

| Item | Value |
|---|---|
| EA | EA-119_Three_Candle_Momentum |
| Baseline ID | `EA119-M1-BASELINE-001` |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Lot Size | 0.01 |

## 2. Performance Results

| Metric | Result |
|---|---:|
| Net Profit | -$992.47 |
| Gross Profit | $2,436.15 |
| Gross Loss | -$3,428.62 |
| Profit Factor | 0.71 |
| Expected Payoff | -$0.37 |
| Recovery Factor | -0.97 |
| Sharpe Ratio | -5.00 |
| Max Balance Drawdown | 99.27% |
| Max Equity Drawdown | 99.27% |
| Total Trades | 2,650 |
| Total Deals | 5,300 |
| Winning Trades | 1,218 (45.96%) |
| Losing Trades | 1,432 (54.04%) |

## 3. Directional Results

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 1,317 | 47.76% |
| SELL | 1,333 | 44.19% |

Both directions show weak results in this baseline. The BUY side has a higher reported win rate, but this alone does not establish a profitable trading edge.

## 4. Trade Quality

| Metric | Result |
|---|---:|
| Largest Winning Trade | $35.33 |
| Largest Losing Trade | -$33.31 |
| Average Winning Trade | $2.00 |
| Average Losing Trade | -$2.39 |
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Losses | 10 |
| Average Holding Time | 00:04:48 |

The average loss exceeds the average win, while the overall win rate is below 50%. These results are consistent with the negative expectancy reported by the tester.

## 5. Baseline Assessment

**Classification: `FAIL`**

Reasons:

- Net profit is negative.
- Profit Factor is 0.71, below the break-even threshold of 1.
- Expected Payoff is negative.
- Sharpe Ratio is negative.
- Maximum equity drawdown reaches 99.27% of the initial account scale.

The test indicates a severe capital-preservation problem. The baseline must not be treated as evidence of a viable trading strategy.

## 6. Research Decision

| Stage | Status |
|---|---|
| Strategy Code | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Assessment | FAIL |
| Controlled Research | REQUIRED |
| Broad Optimization | BLOCKED |
| Out-of-Sample Test | NOT STARTED |
| Walk-Forward Test | NOT STARTED |
| Forward Test | NOT STARTED |
| Live Trading | NOT APPROVED |

Retain this report as the immutable baseline record. Any later experiment must document its changes and results separately.
