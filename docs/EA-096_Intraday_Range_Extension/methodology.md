# Research Methodology

## 1. Purpose

This document defines the methodology used to research and validate EA-096_Intraday_Range_Extension.

The objective is to separate:

* strategy discovery
* baseline measurement
* parameter research
* robustness testing
* out-of-sample validation
* forward testing

---

## 2. Baseline Principle

The first completed test is treated as the baseline:

`EA096-M1-BASELINE-001`

The baseline must remain unchanged.

All future experiments are compared against this reference.

---

## 3. Baseline Test

### Market

* Symbol: XAUUSD.PRO
* Timeframe: M1

### Period

`2026.01.02 – 2026.03.31`

### Data

`100% real ticks`

### Initial Capital

`$1,000`

### Core Strategy Parameters

* ATR Period = 14
* Extension ATR = 1.0
* Minimum Range Bars = 30

### Execution

* Lot = 0.01
* SL = 300 points
* TP = 600 points
* Break-Even = 150 points
* Trailing Start = 200 points
* Trailing Distance = 100 points

---

## 4. Baseline Performance

| Metric          | Baseline |
| --------------- | -------: |
| Net Profit      |  +$30.80 |
| Profit Factor   |     1.37 |
| Expected Payoff |    $0.36 |
| Recovery Factor |     2.11 |
| Sharpe Ratio    |    49.56 |
| Total Trades    |       86 |
| Win Rate        |   53.49% |
| Max Equity DD   |    1.44% |

## The tester report records 86 trades and a maximum equity drawdown of 1.44%.

## 5. Controlled Experiment Principle

A research experiment should change as few variables as possible.

For example:

### Experiment A

Change:

`ExtensionATR`

Keep everything else equal.

### Experiment B

Change:

`InpMinRangeBars`

Keep everything else equal.

### Experiment C

Change:

`StopLoss / TakeProfit`

Keep entry logic unchanged.

This makes it possible to identify which component actually changes performance.

---

## 6. Primary Metrics

Every experiment should record:

### Profitability

* Net Profit
* Gross Profit
* Gross Loss
* Profit Factor
* Expected Payoff

### Risk

* Maximum Balance Drawdown
* Maximum Equity Drawdown
* Relative Drawdown
* Recovery Factor

### Trade Quality

* Total Trades
* Win Rate
* Average Profit Trade
* Average Loss Trade
* Largest Profit Trade
* Largest Loss Trade

### Consistency

* Consecutive wins
* Consecutive losses
* Average holding time
* Long versus short performance

---

## 7. Statistical Discipline

A positive backtest with a small number of trades should not be treated as proof of a stable edge.

The current EA-096 baseline contains:

`86 trades`

Therefore additional data is required before making a strong statistical conclusion.

The research should prioritize increasing the sample size before aggressive parameter optimization.

---

## 8. Parameter Robustness

A robust strategy should continue to perform reasonably when parameters are changed slightly.

For example, if:

`ExtensionATR = 1.0`

produces a strong result but:

`0.9`

and

`1.1`

produce poor results, the strategy may be overly sensitive.

The research should therefore examine parameter neighborhoods rather than searching for one perfect value.

---

## 9. Out-of-Sample Testing

After identifying a candidate configuration:

1. Freeze all parameters.
2. Select data not used during discovery.
3. Run the EA without additional optimization.
4. Record all performance metrics.
5. Compare the result with the baseline.

A configuration should not be accepted solely because it performs well on the data used to discover it.

---

## 10. Walk-Forward Testing

A later research stage should use walk-forward testing.

General process:

`Historical Data`

↓

`Research / Optimization Window`

↓

`Parameter Freeze`

↓

`Out-of-Sample Window`

↓

`Record Result`

↓

`Move Forward`

The objective is to determine whether the strategy can adapt without repeatedly optimizing itself to past data.

---

## 11. Robustness Testing

Robustness should eventually include:

* different historical periods
* different market regimes
* nearby ATR thresholds
* nearby range lengths
* different exit parameters
* BUY versus SELL separation
* trading-session analysis

The purpose is not to find the highest historical profit.

The purpose is to determine whether the strategy's underlying behavior remains stable.

---

## 12. Production Readiness

EA-096 should only be considered production-ready after:

* sufficient historical trade sample
* stable baseline comparison
* parameter robustness
* out-of-sample validation
* walk-forward validation
* forward testing
* acceptable drawdown
* acceptable execution behavior

The current supplied baseline does **not** satisfy all of these requirements.

Current status:

`RESEARCH — NOT PRODUCTION READY`

---

## 13. Current Research Reference

The official baseline for EA-096 is:

`EA096-M1-BASELINE-001`

Current conclusion:

**The supplied test is positive and worth further research, but the sample size of 86 trades is insufficient to establish production-level robustness.**
