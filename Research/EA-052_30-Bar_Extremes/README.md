# Research — EA-052 30-Bar Extremes

## Research ID

**EA-052_30-Bar_Extremes**

## Research Objective

Evaluate whether a simple 30-bar High/Low breakout structure can provide a repeatable trading edge on XAUUSD when implemented as a MetaTrader 5 Expert Advisor.

The purpose of this research is not to assume that breakout trading is profitable, but to convert the trading hypothesis into deterministic rules, implement those rules in MQL5, and evaluate the resulting strategy using reproducible backtesting.

---

## Strategy Family

**N-Bar High/Low Breakout / Price Extremes Breakout**

The strategy belongs to the general family of breakout and trend-following systems that define a rolling price range from previous bars and attempt to trade when price moves beyond that range.

The core reference levels are:

- Highest High of the previous N bars
- Lowest Low of the previous N bars

For EA-052:

**N = 30 bars**

Conceptually:

Upper Extreme = Highest High of previous 30 bars

Lower Extreme = Lowest Low of previous 30 bars

A movement above the upper extreme represents a potential bullish breakout.

A movement below the lower extreme represents a potential bearish breakout.

---

## Research Hypothesis

The hypothesis tested by EA-052 is:

> When XAUUSD breaks beyond the extreme High or Low established by the previous 30 bars and the breakout candle closes strongly in the breakout direction, price may have sufficient momentum to continue moving in that direction.

The strategy therefore attempts to capture short-term momentum immediately after price leaves its recent trading range.

This is a hypothesis to be tested, not an assumption of profitability.

---

## Signal Construction

EA-052 examines the previous 30 bars to establish the breakout boundaries.

### Bullish Breakout

A potential Buy setup occurs when price breaks above the Highest High of the previous 30 bars.

The breakout candle must also demonstrate directional strength by closing near its High.

The implementation requires the distance between the candle Close and High to be no greater than approximately 25% of the candle range.

Conceptually:

Current High > Previous 30-Bar Highest High

and

Distance(Close, High) <= 25% of candle range

The purpose of the close-location condition is to avoid treating every temporary penetration of the previous High as a valid bullish breakout.

---

## Bearish Breakout

A potential Sell setup occurs when price breaks below the Lowest Low of the previous 30 bars.

The breakout candle must also close near its Low.

Conceptually:

Current Low < Previous 30-Bar Lowest Low

and

Distance(Close, Low) <= 25% of candle range

This condition attempts to distinguish directional breakout candles from bars that briefly move outside the range and then reverse.

---

## Research Variables

The initial implementation evaluates the breakout concept together with fixed trade-management parameters.

### Baseline Parameters

| Variable | Baseline |
|---|---:|
| Lookback | 30 bars |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 30 points |
| Slippage | 10 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Lock | 0 points |
| Trailing Stop | Enabled |
| Trailing Distance | 200 points |
| Trailing Step | 50 points |

These values represent the baseline implementation and should not be interpreted as optimized parameters.

---

## Baseline Experiment

The first recorded backtest was performed using:

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.03.31 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |

The purpose of this test was to establish a baseline before attempting optimization or adding additional filters.

---

## Baseline Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$369.82 |
| Profit Factor | 0.85 |
| Expected Payoff | -$0.24 |
| Recovery Factor | -0.96 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | 37.81% |
| Maximum Equity Drawdown | 37.93% |
| Total Trades | 1,511 |
| Winning Trades | 611 (40.44%) |
| Losing Trades | 900 (59.56%) |
| Long Win Rate | 40.46% |
| Short Win Rate | 40.42% |

---

## Baseline Finding

**Result: FAIL**

The initial implementation did not demonstrate a profitable trading edge during the tested period.

The strategy generated a large sample of 1,511 trades, but the combination of win rate, average trade outcome and losses resulted in:

Profit Factor < 1

Expected Payoff < 0

Net Profit < 0

High Drawdown

Negative Sharpe Ratio

The balance curve also declined over the test period.

Therefore, the current baseline configuration must not be classified as profitable or production-ready.

---

## Long vs Short Observation

The baseline produced almost identical win rates between trade directions:

Long Win Rate: 40.46%

Short Win Rate: 40.42%

This indicates that the baseline weakness was not obviously isolated to only one trade direction.

Simply disabling Buy or Sell trades is therefore not supported as a solution by this baseline result alone.

Further directional testing would require separate controlled experiments.

---

## Research Interpretation

The negative baseline is still a valid research result.

It demonstrates that a simple 30-bar extreme breakout combined with the current candle confirmation and trade-management configuration is insufficient to establish a profitable XAUUSD M1 strategy over the tested dataset.

This result should be preserved rather than overwritten.

Future modifications must be compared against this baseline to determine whether they actually improve the strategy.

---

## Potential Research Questions

Future experiments may investigate:

1. Whether 30 bars is an appropriate lookback period for XAUUSD.

2. Whether M1 generates excessive breakout noise.

3. Whether breakout quality changes by trading session or hour.

4. Whether volatility filtering improves signal quality.

5. Whether the 25% close-location requirement provides useful confirmation.

6. Whether breakout distance should be normalized using volatility rather than raw price movement.

7. Whether fixed Stop Loss and Take Profit distances are appropriate across different XAUUSD volatility regimes.

8. Whether Break Even or Trailing Stop management improves or reduces expectancy.

9. Whether requiring a retest after the breakout reduces false breakout entries.

10. Whether higher-timeframe trend confirmation improves the baseline.

These are research directions only.

None should be considered an improvement until independently implemented and backtested.

---

## Research Method

Changes to EA-052 should be evaluated incrementally.

Recommended process:

Baseline
→ identify one hypothesis
→ change one logical component
→ backtest
→ compare against baseline
→ record result
→ PASS / FAIL
→ continue or reject hypothesis

Avoid changing multiple major variables simultaneously because the source of any performance improvement would become difficult to identify.

---

## Research Integrity Rules

The following rules apply to EA-052 research:

- Preserve the original baseline backtest.
- Do not delete negative results.
- Do not overwrite baseline evidence with optimized results.
- Do not claim profitability from a single favorable test.
- Keep strategy changes versioned.
- Record test parameters for every experiment.
- Preserve the original MT5 Strategy Tester report.
- Prefer real-tick testing where available.
- Separate in-sample optimization from validation.
- Do not treat optimization results as independent validation.
- Test robustness before considering deployment.

---

## Current Research Status

EA implementation: **COMPLETED**

Baseline backtest: **COMPLETED**

Baseline result: **FAIL**

Profitability demonstrated: **NO**

Optimization validated: **NO**

Out-of-sample validation: **NOT YET PERFORMED**

Robustness validation: **NOT YET PERFORMED**

Live validation: **NOT YET PERFORMED**

Production readiness: **NO**

---

## Source Status

The exact original publication, book, paper, or author from which EA-052 was derived has not been documented in the current repository evidence.

Therefore, no specific external source is claimed as the origin of EA-052.

The strategy is currently classified generically as an:

**N-Bar High/Low Breakout / Price Extremes Breakout**

If the original strategy source is identified later, it should be added here without rewriting or deleting the existing experimental history.

---

## Related Repository Evidence

Source implementation:

EAs/EA-052_30-Bar_Extremes/EA-052_30-Bar_Extremes.mq5

EA documentation:

EAs/EA-052_30-Bar_Extremes/README.md

Baseline backtest:

Backtest/EA-052_30-Bar_Extremes/

Original Strategy Tester evidence:

Backtest/EA-052_30-Bar_Extremes/ReportTester-952747(20260910-063533).html

---

## Research Conclusion

The EA-052 experiment successfully converted the 30-Bar Extremes breakout hypothesis into a testable MT5 Expert Advisor and produced a reproducible baseline result.

The baseline failed the profitability test.

This is a useful research outcome because it establishes a quantitative reference point for subsequent experiments.

**Current verdict: BASELINE FAIL — RETAIN FOR FURTHER RESEARCH.**
