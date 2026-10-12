
# EA-111 — Baseline Backtest Report

## 1. Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-111_RSI_70_30_Continuation |
| Baseline ID | `EA111-M1-BASELINE-001` |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Tick Model | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## 2. Performance Results

| Metric | Result |
|---|---:|
| Net Profit | -$716.22 |
| Gross Profit | $1,963.76 |
| Gross Loss | -$2,679.98 |
| Profit Factor | 0.73 |
| Expected Payoff | -$0.36 |
| Recovery Factor | -0.99 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | $716.35 / 71.63% |
| Maximum Equity Drawdown | $720.33 / 71.88% |
| Total Trades | 1,964 |
| Total Deals | 3,928 |

## 3. Trade Statistics

| Metric | Result |
|---|---:|
| Winning Trades | 845 / 43.02% |
| Losing Trades | 1,119 / 56.98% |
| BUY Trades | 965 |
| BUY Win Rate | 44.15% |
| SELL Trades | 999 |
| SELL Win Rate | 41.94% |
| Average Winning Trade | $2.32 |
| Average Losing Trade | -$2.39 |
| Largest Winning Trade | $8.26 |
| Largest Losing Trade | -$7.62 |
| Average Holding Time | 00:02:01 |

## 4. Assessment

**Baseline Classification: `FAIL`**

Reasons:

- Net profit is negative.
- Profit Factor is below 1.00.
- Expected Payoff and Sharpe Ratio are negative.
- Maximum equity drawdown reaches 71.88%.
- Both BUY and SELL sides have win rates below 50%.

The strategy has not demonstrated a positive trading edge under this test configuration.

## 5. Research Decision

- Strategy Code: `REVIEW REQUIRED`
- Baseline Backtest: `COMPLETE`
- Baseline Result: `FAIL`
- Signal Logic Verification: `PRIORITY`
- Parameter Optimization: `BLOCKED`
- Out-of-Sample Test: `NOT STARTED`
- Walk-Forward Test: `NOT STARTED`
- Forward Test: `NOT STARTED`
- Live Trading: `NO`

The next experiment must verify the RSI crossover direction and confirm that the intended closed candles are being compared. Do not treat parameter optimization as a substitute for correcting a possible signal-definition mismatch.
