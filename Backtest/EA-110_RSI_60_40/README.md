# EA-110_RSI_60_40 — Backtest Report

## 1. Test Configuration

| Item | Value |
|---|---|
| Expert Advisor | EA-110_RSI_60_40 |
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
| RSI Period | 14 |
| Magic Number | 123465 |

## 2. Performance Summary

| Metric | Result |
|---|---:|
| Total Net Profit | +$81.46 |
| Gross Profit | $308.93 |
| Gross Loss | -$227.47 |
| Profit Factor | 1.36 |
| Expected Payoff | $0.40 |
| Recovery Factor | 2.39 |
| Sharpe Ratio | 32.22 |
| Balance Drawdown Absolute | $33.80 |
| Equity Drawdown Absolute | $34.04 |
| Maximum Balance Drawdown | $33.80 (3.38%) |
| Maximum Equity Drawdown | $34.04 (3.40%) |
| Total Trades | 205 |
| Total Deals | 410 |
| Profit Trades | 102 (49.76%) |
| Loss Trades | 103 (50.24%) |

## 3. Trade Statistics

| Metric | Result |
|---|---:|
| Short Trades | 82 |
| Short Win Rate | 56.10% |
| Long Trades | 123 |
| Long Win Rate | 45.53% |
| Largest Profit Trade | $21.43 |
| Largest Loss Trade | -$11.35 |
| Average Profit Trade | $3.03 |
| Average Loss Trade | -$2.21 |
| Maximum Consecutive Wins | 7 ($44.24) |
| Maximum Consecutive Losses | 6 (-$20.20) |
| Average Position Holding Time | 4 minutes 46 seconds |
| Maximum Position Holding Time | 2 hours 19 minutes |

## 4. Initial Assessment

The baseline test is profitable:

- Net profit is positive at $81.46.
- Profit Factor is 1.36.
- Expected Payoff is positive at $0.40 per trade.
- Maximum reported equity drawdown is 3.40%.
- The report records 205 trades across the test period.

The long-side win rate (45.53%) is lower than the short-side win rate (56.10%). This is a reason to investigate directional performance, not proof by itself that long trades should be disabled.

## 5. Important Technical Check

Before comparing optimized versions, audit the RSI array indexing and signal direction in the source code.

The current code uses:

- BUY: `r[2] <= 60 && r[1] > 60`
- SELL: `r[2] >= 40 && r[1] < 40`

Because the RSI buffer is copied into a fixed-size array, the index-to-bar mapping must be verified. Do not assume these conditions implement the intended conventional RSI 60/40 crossing rules without confirming which bar each index represents.

## 6. Baseline Verdict

**PASS FOR FURTHER RESEARCH — NOT APPROVED FOR LIVE TRADING**

The positive baseline metrics justify additional controlled tests. However, this single report does not establish out-of-sample robustness, stability across market regimes, or live execution performance.

## 7. Suggested Record Layout

Store the original Strategy Tester HTML report alongside this README. Preserve the original EA source and input values used for this run so the baseline remains reproducible.
