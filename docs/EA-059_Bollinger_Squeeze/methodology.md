# Methodology — EA-059_Bollinger_Squeeze

## Purpose

This document defines the research, implementation, backtesting, evaluation, and evidence methodology used for **EA-059_Bollinger_Squeeze**.

The objective is to maintain a clear separation between:

- Strategy logic
- EA implementation
- Backtest evidence
- Research interpretation
- Validation status

The methodology is designed so that results can be reproduced, reviewed, and compared without relying on undocumented assumptions.

---

## 1. Strategy Definition

EA-059 is based on a Bollinger Bands volatility squeeze and breakout concept.

The working hypothesis is:

> A period of volatility contraction may precede volatility expansion. When price closes outside the Bollinger Bands immediately following a squeeze, the breakout may continue sufficiently far to support a positive reward-to-risk strategy.

The strategy does not predict breakout direction during the squeeze.

Direction is determined by the subsequent confirmed breakout.

---

## 2. Indicator Definition

The strategy uses Bollinger Bands calculated from closing prices.

Baseline indicator parameters:

- Bollinger Period: 20
- Bollinger Deviation: 2.0
- Applied Price: Close

Bollinger Band width is calculated as:

`Band Width = (Upper Band - Lower Band) / Point`

A squeeze is detected when:

`Band Width <= Squeeze Width Threshold`

The benchmark backtest uses:

`Squeeze Width Threshold = 500 points`

---

## 3. Candle Methodology

Entry decisions use completed candles.

The candle references are:

- Shift 0 — current forming candle
- Shift 1 — most recently completed candle
- Shift 2 — candle preceding the breakout candle

The squeeze condition is evaluated on shift 2.

The breakout is confirmed using shift 1.

Execution occurs after the new candle begins.

This prevents the strategy from treating temporary intrabar movement as a confirmed breakout.

---

## 4. BUY Methodology

A BUY setup requires:

`BandWidth[2] <= SqueezeThreshold`

and:

`Close[2] <= UpperBand[2]`

and:

`Close[1] > UpperBand[1]`

Interpretation:

1. The market is compressed during the reference candle.
2. The reference candle has not already closed above its upper Bollinger Band.
3. The next completed candle closes above its upper Bollinger Band.
4. The EA interprets this as a confirmed upside breakout.
5. A BUY market order is submitted.

---

## 5. SELL Methodology

A SELL setup requires:

`BandWidth[2] <= SqueezeThreshold`

and:

`Close[2] >= LowerBand[2]`

and:

`Close[1] < LowerBand[1]`

Interpretation:

1. The market is compressed during the reference candle.
2. The reference candle has not already closed below its lower Bollinger Band.
3. The next completed candle closes below its lower Bollinger Band.
4. The EA interprets this as a confirmed downside breakout.
5. A SELL market order is submitted.

---

## 6. Signal Frequency

New trading signals are evaluated once per new candle.

The methodology intentionally avoids repeatedly evaluating and executing the same breakout signal during every tick of a single candle.

The EA also restricts trading to one active position for the current symbol and Magic Number.

---

## 7. Position Sizing

The current benchmark uses fixed lot sizing.

Baseline:

`Lot Size = 0.01`

The current methodology does not use percentage-risk position sizing.

Therefore, comparisons between tests should preserve the same lot size unless position sizing itself is the variable being tested.

---

## 8. Stop Loss

The benchmark Stop Loss is:

`300 points`

For BUY:

`SL = Ask - 300 × Point`

For SELL:

`SL = Bid + 300 × Point`

The implementation also checks the broker's minimum stop-distance requirements.

If the configured distance is below the broker minimum, the EA adjusts the order to satisfy that restriction.

---

## 9. Take Profit

The benchmark Take Profit is:

`600 points`

For BUY:

`TP = Ask + 600 × Point`

For SELL:

`TP = Bid - 600 × Point`

The nominal reward-to-risk structure is therefore:

`600 / 300 = 2.0`

or approximately:

`2 : 1`

The broker's minimum stop-distance requirements are also respected.

---

## 10. Spread Filter

The strategy includes a maximum spread filter.

Benchmark value:

`Maximum Spread = 30 points`

Spread is calculated as:

`Spread = (Ask - Bid) / Point`

A new position is not opened when the spread exceeds the configured threshold.

This filter applies to entries rather than serving as an exit mechanism.

---

## 11. Break Even

The EA implementation contains optional Break Even functionality.

The source supports:

- Break Even enable/disable
- Break Even trigger
- Break Even lock points

However, the benchmark backtest uses:

`Break Even = OFF`

Therefore, Break Even behavior is not part of the current benchmark performance.

Future tests that enable Break Even must be identified as a different configuration.

---

## 12. Trailing Stop

The EA implementation contains optional Trailing Stop functionality.

The source supports:

- Trailing Stop enable/disable
- Trailing activation threshold
- Trailing distance

However, the benchmark backtest uses:

`Trailing Stop = OFF`

Therefore, Trailing Stop behavior is not part of the current benchmark performance.

Future tests that enable Trailing Stop must be compared separately against the baseline.

---

## 13. Benchmark Configuration

The current reference configuration is:

Expert Advisor:

`EA-059_Bollinger_Squeeze`

Symbol:

`XAUUSD.PRO`

Timeframe:

`M1`

Test Period:

`2026-01-02 → 2026-04-01`

Initial Deposit:

`$1,000`

Leverage:

`1:500`

Lot Size:

`0.01`

Stop Loss:

`300 points`

Take Profit:

`600 points`

Magic Number:

`123456`

Slippage:

`10 points`

Bollinger Period:

`20`

Bollinger Deviation:

`2.0`

Squeeze Width:

`500 points`

Maximum Spread:

`30 points`

Break Even:

`OFF`

Trailing Stop:

`OFF`

Historical Data:

`100% real ticks`

This configuration serves as the benchmark against which later EA-059 experiments should be compared.

---

## 14. Backtesting Methodology

The benchmark test is executed using MetaTrader 5 Strategy Tester.

The supplied benchmark report records:

- Symbol: XAUUSD.PRO
- Timeframe: M1
- Period: 2026-01-02 → 2026-04-01
- Initial Deposit: $1,000
- Leverage: 1:500
- History Quality: 100% real ticks
- Bars: 86,539
- Ticks: 40,346,891

The original Strategy Tester HTML report is treated as the primary numerical evidence.

Screenshots and graphs are supporting evidence.

README files summarize the evidence but do not replace the original Strategy Tester report.

---

## 15. Primary Evaluation Metrics

The strategy is evaluated using multiple metrics rather than net profit alone.

Primary metrics include:

- Total Net Profit
- Return
- Profit Factor
- Maximum Balance Drawdown
- Maximum Equity Drawdown
- Recovery Factor
- Expected Payoff
- Total Trades
- Win Rate
- Average Profit Trade
- Average Loss Trade
- Maximum Consecutive Losses
- Position Holding Time

Supporting metrics include:

- Sharpe Ratio
- MFE
- MAE
- Long/Short trade distribution
- Time-of-day distribution
- Equity/balance curve behavior

No single metric should independently determine strategy robustness.

---

## 16. Benchmark Result

The current benchmark produced:

`Initial Deposit = $1,000.00`

`Net Profit = +$64.47`

`Return = +6.447%`

`Profit Factor = 1.05`

`Maximum Balance Drawdown = 9.62%`

`Maximum Equity Drawdown = 9.97%`

`Recovery Factor = 0.55`

`Sharpe Ratio = 3.93`

`Total Trades = 588`

`Winning Trades = 199`

`Losing Trades = 389`

`Win Rate = 33.84%`

`Maximum Consecutive Losses = 19`

These figures define the current performance baseline.

---

## 17. Result Interpretation

A backtest is treated as evidence of behavior under a specific configuration and historical period.

It is not treated as proof of future profitability.

The current benchmark is classified as:

**PROFITABLE BACKTEST**

because:

`Net Profit > 0`

and:

`Profit Factor > 1`

However, it is simultaneously classified as:

**NOT YET ROBUSTNESS-VALIDATED**

because the current evidence covers only a limited test period and configuration.

Profitability and robustness are therefore treated as separate concepts.

---

## 18. Evidence Hierarchy

When conflicting information exists, evidence should be prioritized in the following order:

1. Original EA source code
2. Original MetaTrader 5 Strategy Tester HTML report
3. Strategy Tester-generated charts
4. Backtest README
5. Research README
6. Other descriptive documentation

The original source code defines what the EA actually implements.

The original Strategy Tester report defines what the recorded backtest actually produced.

Documentation should describe these artifacts rather than override them.

---

## 19. Artifact Preservation

Original evidence should not be modified.

The following should be preserved:

`EAs/EA-059_Bollinger_Squeeze/EA-059_Bollinger_Squeeze.mq5`

and the original Strategy Tester files under:

`Backtest/EA-059_Bollinger_Squeeze/`

The HTML report is the primary backtest artifact.

Associated MT5-generated images should remain beside the HTML file so that its graphical references continue to work.

---

## 20. Reproducibility Rule

A result should only be considered directly comparable with the benchmark when the relevant test conditions are documented.

At minimum, record:

- EA version
- Symbol
- Timeframe
- Test period
- Historical data model
- Initial deposit
- Leverage
- Lot size
- Stop Loss
- Take Profit
- Bollinger parameters
- Squeeze threshold
- Spread threshold
- Break Even configuration
- Trailing Stop configuration

If one of these variables changes, the new result should be treated as a separate experiment.

---

## 21. Parameter Testing Rule

The benchmark parameters must be retained as the control configuration.

When testing a parameter change, the preferred methodology is to modify a limited number of variables while preserving the remaining baseline conditions.

Example:

Baseline:

`Squeeze Width = 500`

Experiment:

`Squeeze Width = alternative value`

The new result should then be compared against the baseline using the same primary evaluation metrics.

The original benchmark should not be overwritten by an optimized result.

---

## 22. Overfitting Control

Parameter optimization alone is not considered sufficient evidence of strategy quality.

A parameter combination that performs well only on the period used to select it may represent overfitting.

Therefore, optimized parameters should remain classified as experimental until they are tested outside the data used for optimization.

The current benchmark has not yet completed this process.

---

## 23. Out-of-Sample Validation

Out-of-sample testing is not yet documented for EA-059.

When performed, development and validation data should be separated.

Parameters selected using one historical segment should subsequently be evaluated on historical data that was not used to select those parameters.

The out-of-sample result should be stored separately rather than merged with the benchmark.

---

## 24. Walk-Forward Validation

Walk-forward validation is not currently documented.

If performed later, each cycle should separate:

1. Parameter-development period
2. Forward validation period

Results from multiple forward periods can then be evaluated to determine whether the strategy behavior persists across changing market conditions.

---

## 25. Market-Regime Validation

The current balance curve suggests that performance may vary across market conditions.

Future validation may therefore examine behavior during different environments such as:

- Trending markets
- Range-bound markets
- High-volatility periods
- Low-volatility periods
- Repeated false-breakout periods

These regime classifications must be tested with evidence before being incorporated into EA trading rules.

They should not be added solely because they appear theoretically useful.

---

## 26. Long vs Short Validation

The current benchmark records:

`Long Win Rate = 37.19%`

`Short Win Rate = 30.69%`

BUY trades therefore performed better by win rate during this particular test.

This observation alone is not sufficient evidence to disable SELL trades.

Any directional filter must first be tested independently and compared with the unchanged baseline.

---

## 27. Exit-System Validation

The current benchmark uses fixed SL/TP exits with:

`Break Even = OFF`

`Trailing Stop = OFF`

Because the EA already supports both features, they can later be evaluated as separate experiments.

Possible comparisons include:

`Baseline Fixed SL/TP`

versus:

`Fixed SL/TP + Break Even`

versus:

`Fixed SL/TP + Trailing Stop`

versus:

`Fixed SL/TP + Break Even + Trailing Stop`

Results should not be combined unless the configuration is explicitly documented.

---

## 28. Robustness Status

Current status:

`Strategy Implemented: YES`

`MT5 Backtest Completed: YES`

`100% Real Tick Benchmark: YES`

`Positive Benchmark Result: YES`

`Out-of-Sample Validation: NOT DOCUMENTED`

`Walk-Forward Validation: NOT DOCUMENTED`

`Parameter Stability Validation: NOT DOCUMENTED`

`Multi-Period Validation: NOT DOCUMENTED`

`Live/Forward Validation: NOT DOCUMENTED`

Therefore:

**EA-059 is currently a research candidate, not a robustness-validated production strategy.**

---

## 29. Project Structure

The methodology applies to the following project structure:

`EAs/EA-059_Bollinger_Squeeze/`

Contains the MQL5 implementation and EA-specific README.

`Backtest/EA-059_Bollinger_Squeeze/`

Contains original MetaTrader 5 Strategy Tester evidence and backtest documentation.

`Research/README.md`

Contains strategy research, hypothesis, observations, strengths, weaknesses, and current research conclusion.

`docs/methodology.md`

Contains the methodology and validation rules defined in this document.

---

## 30. Current Methodology Status

The current evidence chain is:

`Strategy hypothesis`

→ `MQL5 implementation`

→ `MT5 real-tick backtest`

→ `Backtest evidence preservation`

→ `Research interpretation`

→ `Methodology documentation`

The current validated conclusion is limited to:

**EA-059_Bollinger_Squeeze produced a positive result in the supplied XAUUSD.PRO M1 benchmark backtest from 2026-01-02 to 2026-04-01 using the documented configuration and 100% real tick data.**

No stronger claim should be made until additional validation evidence exists.

## Disclaimer

This methodology is intended for systematic trading research and software validation.

Historical backtests cannot guarantee future performance. XAUUSD trading involves leverage, execution risk, spread variation, slippage, liquidity changes, and changing market behavior.

Any future production or live-trading decision should be based on additional validation beyond the current benchmark.
