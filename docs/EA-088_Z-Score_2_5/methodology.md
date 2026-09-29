# Research Methodology

## 1. Purpose

This document defines the methodology used to document, backtest and research MT5 Expert Advisors in this repository.

The purpose is to keep EA development reproducible and to separate:

1. Source-code development
2. Baseline backtesting
3. Parameter research
4. Optimization
5. Out-of-sample validation
6. Forward testing
7. Live testing

---

# 2. EA Identification

Each Expert Advisor receives a unique identifier.

For the current research version:

```text
EA ID       = EA-088
EA Name     = EA-088_Z-Score_2_5
Magic Number = 123088
```

The EA source file is stored under:

```text
EAs/EA-088_Z-Score_2_5/
```

---

# 3. Strategy Definition

EA-088_Z-Score_2_5 uses a Z-Score based signal.

The Z-Score is calculated from closing prices using:

```text
InpZPeriod = 20
```

The configured threshold is:

```text
InpZThreshold = 2.5
```

The strategy evaluates closed candles.

---

# 4. Buy Condition

The current implementation generates a Buy signal when:

```text
ZScore[2] < -InpZThreshold
ZScore[1] >= -InpZThreshold
Close[1] > Open[1]
```

With the baseline configuration:

```text
ZScore[2] < -2.5
ZScore[1] >= -2.5
Close[1] > Open[1]
```

---

# 5. Sell Condition

The current implementation generates a Sell signal when:

```text
ZScore[2] > InpZThreshold
ZScore[1] <= InpZThreshold
Close[1] < Open[1]
```

With the baseline configuration:

```text
ZScore[2] > 2.5
ZScore[1] <= 2.5
Close[1] < Open[1]
```

---

# 6. Signal Timing

The EA detects a new bar using the configured timeframe.

The signal is evaluated only after a new candle is detected.

The strategy therefore does not continuously generate new entries from the same completed candle.

Position protection, however, is managed on every tick.

---

# 7. Entry Controls

Before an entry is submitted, the EA checks:

* Trading permissions
* Account permissions
* Existing positions
* Existing orders
* Spread
* Symbol trading mode
* Market order support
* SL/TP support
* Broker stop distance
* Available margin
* Lot-size validity
* Symbol filling mode

The configured SL and TP are submitted with the market order.

---

# 8. Position Management

The baseline configuration uses:

```text
Stop Loss  = 300
Take Profit = 600
```

Break Even:

```text
Enabled = true
Trigger = 150
Offset  = 0
```

Trailing Stop:

```text
Enabled  = true
Start    = 200
Distance = 100
Step     = 10
```

The EA respects broker stop and freeze levels when modifying protective orders.

---

# 9. Baseline Backtest

The baseline test for EA-088_Z-Score_2_5 uses:

```text
Symbol          = XAUUSD.PRO
Timeframe       = M1
Period          = 2026-01-02 to 2026-03-31
Initial Deposit = 1,000 USD
Leverage        = 1:500
History Quality = 100% real ticks
```

The tester processed:

```text
Bars  = 85,161
Ticks = 39,639,179
```

The Strategy Tester report records these settings and test conditions.

---

# 10. Baseline Result

The baseline result is:

```text
Net Profit          = -123.57 USD
Gross Profit        = 1,717.00 USD
Gross Loss          = -1,840.57 USD
Profit Factor       = 0.93
Expected Payoff     = -0.08 USD
Max Equity Drawdown = 18.79%
Sharpe Ratio        = -5.00
Total Trades        = 1,484
```

These values are taken from the attached Strategy Tester report.

---

# 11. Trade Distribution

The baseline report records:

```text
Profit Trades = 772 (52.02%)
Loss Trades   = 712 (47.98%)

Short Trades = 592
Short Win %  = 52.70%

Long Trades = 892
Long Win %  = 51.57%
```

A win rate above 50% does not by itself determine profitability because the average winning and losing trade sizes must also be considered.

For this baseline:

```text
Average Profit Trade = 2.22 USD
Average Loss Trade   = -2.59 USD
```

---

# 12. Optimization Method

Optimization should be performed as a controlled experiment.

The preferred procedure is:

1. Establish a fixed baseline.
2. Select one research variable.
3. Define a parameter range.
4. Run the optimization.
5. Record all relevant results.
6. Select candidate configurations for validation.
7. Test candidates on data not used for optimization.

Optimization results must not overwrite the baseline.

---

# 13. Parameter Research

The principal strategy parameters are:

```text
InpZPeriod
InpZThreshold
```

Exit and management parameters include:

```text
InpStopLoss
InpTakeProfit
InpBreakEvenTrigger
InpBreakEvenOffset
InpTrailingStart
InpTrailingDistance
InpTrailingStep
```

Execution parameters include:

```text
InpLotSize
InpMaxSpread
InpSlippage
InpTimeframe
```

---

# 14. One-Variable-at-a-Time Research

When investigating the effect of a specific variable, all other parameters should remain fixed whenever practical.

Example:

```text
Baseline:
ZPeriod = 20
ZThreshold = 2.5
```

A threshold experiment should change only:

```text
ZThreshold
```

while preserving the remaining configuration.

This makes the effect of the tested variable easier to identify.

---

# 15. Out-of-Sample Testing

Optimization and validation must be separated.

The data used to identify a parameter configuration should not be treated as proof that the configuration will work on unseen data.

An out-of-sample test should use a separate period that was not used to select the configuration.

---

# 16. Forward Testing

After historical testing, a candidate configuration may be evaluated using forward testing.

Forward-test records should document:

```text
Start Date
End Date
Symbol
Timeframe
EA Version
Parameters
Initial Balance
Final Balance
Net Result
Drawdown
Trade Count
Execution Conditions
```

Forward-test results should remain separate from historical Strategy Tester results.

---

# 17. Reproducibility

Every backtest should preserve:

* EA source version
* Parameter values
* Symbol
* Timeframe
* Test period
* Initial deposit
* Leverage
* History quality
* Tester report

The original tester report should not be modified.

---

# 18. Current Source-Code Notes

For EA-088_Z-Score_2_5, the following implementation details are part of the documented source version:

```text
InpBreakoutBuffer
```

is declared but is not used in the active signal conditions.

The `GetSignal()` function calculates:

```text
recent
older
before
```

but `before` is not used in the final Buy/Sell conditions.

The source also contains unused indicator helper components:

```text
indicator_handle
ReadIndicator()
ReadValue()
```

These details should be considered when comparing future versions of the EA.

---

# 19. Result Interpretation

The baseline result should be described using objective metrics.

For EA-088_Z-Score_2_5:

```text
Net Profit          = -123.57 USD
Profit Factor       = 0.93
Maximum Equity DD   = 18.79%
Total Trades        = 1,484
```

The baseline therefore provides a negative historical test result for the documented configuration.

This result is a research observation and should not be treated as a live-trading performance claim.

---

# 20. Research Status

Current status:

```text
Source Code              = AVAILABLE
Baseline Backtest        = COMPLETED
Optimization             = NOT RECORDED
Out-of-Sample Validation = NOT RECORDED
Forward Test             = NOT RECORDED
Live Test                = NOT RECORDED
```

Future research results should be added as separate experiment records rather than replacing the baseline.
