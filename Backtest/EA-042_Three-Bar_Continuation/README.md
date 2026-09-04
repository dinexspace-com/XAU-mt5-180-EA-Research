# EA-042 — Three-Bar Continuation
## Backtest Results

## Test Status

**Result: FAIL**

The baseline implementation of EA-042 Three-Bar Continuation did not demonstrate a profitable or acceptable risk profile under the tested XAUUSD conditions.

This test should be treated as a baseline research result and not as evidence of a production-ready trading strategy.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-042_Three-Bar_Continuation |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

---

## Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 20240001 |
| Slippage | 10 points |
| Maximum Spread | 35 points |
| Maximum Positions | 1 |
| Break Even | Disabled |
| Break Even Start | 150 points |
| Trailing Stop | Disabled |
| Trailing Start | 200 points |
| Trailing Step | 50 points |

---

## Performance Summary

| Metric | Result |
|---|---:|
| Total Net Profit | **-$992.09** |
| Gross Profit | $11,590.64 |
| Gross Loss | -$12,582.73 |
| Profit Factor | **0.92** |
| Expected Payoff | **-$0.17** |
| Recovery Factor | **-0.91** |
| Sharpe Ratio | **-5.00** |
| Maximum Balance Drawdown | **$1,095.51 (99.28%)** |
| Maximum Equity Drawdown | **$1,095.51 (99.28%)** |
| Total Trades | 5,815 |
| Total Deals | 11,630 |

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Winning Trades | 1,862 (32.02%) |
| Losing Trades | 3,953 (67.98%) |
| Short Trades | 2,846 |
| Short Win Rate | 31.13% |
| Long Trades | 2,969 |
| Long Win Rate | 32.87% |
| Largest Winning Trade | $35.33 |
| Largest Losing Trade | -$42.23 |
| Average Winning Trade | $6.22 |
| Average Losing Trade | -$3.18 |
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Losses | 26 |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum | 00:00:01 |
| Maximum | 02:48:02 |
| Average | 00:04:18 |

---

## Baseline Assessment

### FAIL

The tested configuration fails the baseline profitability and risk evaluation.

Primary reasons:

- Total Net Profit is negative.
- Profit Factor is below 1.0.
- Expected Payoff is negative.
- Sharpe Ratio is negative.
- Maximum drawdown reached 99.28%.
- 67.98% of all trades were losing trades.
- The balance curve shows substantial deterioration over the test period.

The initial $1,000 account was effectively depleted during the test.

---

## Research Interpretation

This result does **not** establish that the general Three-Bar Continuation concept is invalid.

It establishes that the currently tested combination of:

- entry logic,
- M1 timeframe,
- XAUUSD.PRO,
- SL = 300 points,
- TP = 600 points,
- no Break Even,
- no Trailing Stop,
- and the current execution/filter logic

does not provide an acceptable trading system under this test.

The result should therefore be preserved as the **baseline backtest** for EA-042.

---

## Conclusion

**EA-042_Three-Bar_Continuation — Baseline Backtest: FAIL**

The current version should **not proceed to live trading** based on this result.

Further research or modification is required before the EA can be considered for another validation stage.
