# Research Methodology

## 1. Purpose

This document defines the methodology used to research `EA-087_Z-Score_2`.

The purpose is to keep the research reproducible and to separate:

* EA implementation
* Baseline backtest
* Parameter experiments
* Optimization
* Validation
* Out-of-sample testing
* Forward testing

---

## 2. EA Identification

```text
EA: EA-087_Z-Score_2
Platform: MetaTrader 5
Primary Symbol: XAUUSD
```

The current implementation uses a Z-Score signal calculated from closing prices.

---

## 3. Signal Definition

The EA calculates a Z-Score over a configurable number of closed candles.

The default configuration is:

```text
Z-Score Period = 20
Z-Score Threshold = 2.0
```

The signal is evaluated once when a new timeframe bar becomes available.

The strategy uses the closed-candle Z-Score sequence rather than making the entry decision from the currently forming candle.

---

## 4. Buy Condition

The baseline buy condition is based on an extreme negative Z-Score followed by a reversal.

Conceptually:

```text
Older Z-Score < -Threshold
AND
Recent Z-Score > Older Z-Score
AND
Older Z-Score <= Before Z-Score
```

This represents a negative Z-Score extreme followed by an upward reversal in the Z-Score sequence.

---

## 5. Sell Condition

The baseline sell condition is based on an extreme positive Z-Score followed by a reversal.

Conceptually:

```text
Older Z-Score > Threshold
AND
Recent Z-Score < Older Z-Score
AND
Older Z-Score >= Before Z-Score
```

This represents a positive Z-Score extreme followed by a downward reversal in the Z-Score sequence.

---

## 6. Entry Rules

The EA uses market execution.

Before an entry is allowed, the implementation checks:

* Trading permissions
* Existing positions and orders
* Spread
* Symbol trading mode
* Order capabilities
* Stop-distance requirements
* Available margin
* Lot-size validity

The market order is submitted together with the configured Stop Loss and Take Profit.

---

## 7. Position Management

The baseline uses both Break Even and Trailing Stop.

### Break Even

```text
Enabled: true
Trigger: 150
Offset: 0
```

### Trailing Stop

```text
Enabled: true
Start: 200
Distance: 100
Step: 10
```

Position management runs on every tick while signal evaluation is restricted to new bars.

---

## 8. Baseline Backtest

The first research reference is the following Strategy Tester run:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026-01-02 to 2026-03-31
History Quality: 100% real ticks
Initial Deposit: 1,000 USD
Leverage: 1:500
```

The baseline configuration is:

```text
Lot Size: 0.01
Stop Loss: 300
Take Profit: 600
Maximum Spread: 30

Break Even:
Enabled = true
Trigger = 150
Offset = 0

Trailing Stop:
Enabled = true
Start = 200
Distance = 100
Step = 10

Z-Score:
Period = 20
Threshold = 2.0
```

---

## 9. Baseline Result

The recorded baseline produced:

```text
Net Profit: -634.42 USD
Profit Factor: 0.90
Sharpe Ratio: -5.00
Maximum Equity Drawdown: 75.22%
Total Trades: 5,136
```

The baseline result is stored for comparison and must not be overwritten.

---

## 10. Experiment Procedure

Each experiment must change a defined parameter set and record the result separately.

Minimum information to record:

```text
Experiment ID
EA version
Symbol
Timeframe
Test period
Initial deposit
Input parameters
History quality
Total trades
Net profit
Profit factor
Maximum drawdown
Sharpe ratio
Notes
```

---

## 11. Parameter Research

Parameter research should be performed one logical group at a time.

Primary groups:

```text
1. Z-Score Period
2. Z-Score Threshold
3. Stop Loss
4. Take Profit
5. Break Even
6. Trailing Stop
7. Spread / Execution
```

A parameter experiment should not be interpreted independently from the test period and market conditions used for that experiment.

---

## 12. Optimization

Optimization results should be treated as exploratory results.

An optimized parameter set must not automatically replace the baseline.

For every selected parameter set, record:

```text
Optimization range
Optimization step
Optimization period
Optimization criterion
Selected parameter values
Number of tested combinations
Result metrics
```

The optimization report should be retained with the experiment.

---

## 13. Validation

After optimization, the selected parameter set should be tested on data that was not used to select the parameters.

The validation test must use:

```text
Same EA logic
Same trading rules
Same symbol
Same timeframe
New test period
```

The validation result must be stored separately from the optimization result.

---

## 14. Out-of-Sample Testing

Out-of-sample testing is used to evaluate whether the selected configuration continues to behave under data that was not used during parameter selection.

The out-of-sample report must not be mixed with the optimization report.

Suggested record:

```text
In-Sample Period:
Out-of-Sample Period:
Parameter Set:
Net Profit:
Profit Factor:
Drawdown:
Trades:
Sharpe Ratio:
```

---

## 15. Reproducibility

Every backtest should preserve:

* EA source version
* Tester report
* Input parameters
* Symbol
* Timeframe
* Test dates
* Initial deposit
* Account currency
* History quality
* Relevant broker/tester conditions

The objective is that another researcher can reproduce the same test configuration.

---

## 16. Result Interpretation

The following metrics should be reviewed together:

```text
Net Profit
Profit Factor
Maximum Drawdown
Sharpe Ratio
Number of Trades
Win Rate
Average Profit Trade
Average Loss Trade
Maximum Consecutive Losses
Holding Time
```

No single metric should be used as the only basis for accepting a research result.

---

## 17. Research Status

Current status:

```text
Baseline Backtest: Recorded
Parameter Optimization: Not recorded
Validation: Not recorded
Out-of-Sample Test: Not recorded
Forward Test: Not recorded
Live Test: Not recorded
```

The repository should clearly distinguish between historical backtest evidence and any later validation or live-trading evidence.
