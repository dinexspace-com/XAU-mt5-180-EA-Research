# Research

## Project

This repository is used to document systematic research and testing of XAUUSD MT5 Expert Advisors.

Each EA is treated as a separate research subject and receives its own source code, backtest records and research history.

---

# EA-088_Z-Score_2_5

## Baseline Configuration

The current baseline is:

```text
EA                  = EA-088_Z-Score_2_5
Symbol              = XAUUSD.PRO
Timeframe           = M1
Test Period         = 2026-01-02 to 2026-03-31
Initial Deposit     = 1,000 USD
Lot Size            = 0.01

Z Period            = 20
Z Threshold         = 2.5

Stop Loss           = 300
Take Profit         = 600

Break Even          = ON
Break Even Trigger  = 150
Break Even Offset   = 0

Trailing Stop       = ON
Trailing Start      = 200
Trailing Distance   = 100
Trailing Step       = 10
```

---

## Baseline Result

The current baseline Strategy Tester result is:

```text
Net Profit          = -123.57 USD
Profit Factor       = 0.93
Total Trades        = 1,484
Profit Trades       = 772
Loss Trades         = 712
Max Equity Drawdown = 18.79%
Sharpe Ratio        = -5.00
```

The baseline result is negative and is therefore preserved as the reference point for further experiments.

---

# Research Objective

The research objective is to determine how the EA's parameters and signal structure affect:

* Net Profit
* Profit Factor
* Drawdown
* Trade frequency
* Average trade
* Win/Loss distribution
* Holding time
* Stability across different market periods

The research should separate parameter optimization from validation.

---

# Primary Research Variables

## Z-Score Parameters

```text
InpZPeriod
InpZThreshold
```

These parameters directly control the Z-Score calculation and signal threshold.

---

## Risk and Exit Parameters

```text
InpStopLoss
InpTakeProfit
InpBreakEvenTrigger
InpBreakEvenOffset
InpTrailingStart
InpTrailingDistance
InpTrailingStep
```

These parameters affect trade exits and position management.

---

## Execution Parameters

```text
InpLotSize
InpMaxSpread
InpSlippage
InpTimeframe
```

These parameters affect execution and test conditions.

---

# Signal Structure

The current EA uses the Z-Score of closed candles.

Buy:

```text
older < -InpZThreshold
recent >= -InpZThreshold
previous closed candle is bullish
```

Sell:

```text
older > InpZThreshold
recent <= InpZThreshold
previous closed candle is bearish
```

The signal is checked once when a new candle appears.

---

# Important Source-Code Observations

The current implementation declares:

```text
InpBreakoutBuffer
```

but does not use it in the active signal calculation.

The function `GetSignal()` calculates:

```text
recent
older
before
```

but the current Buy/Sell conditions use `recent` and `older`; `before` is not used in the final conditions.

The source also contains unused indicator helper components:

```text
indicator_handle
ReadIndicator()
ReadValue()
```

These observations should be considered when comparing this EA with earlier or later versions.

---

# Experiment Rules

Each experiment should change only the intended research variable whenever possible.

For example:

```text
Baseline:
ZPeriod=20
ZThreshold=2.5
```

A threshold experiment should keep other parameters unchanged.

Example:

```text
EA088_Z25_T20
EA088_Z30_T20
EA088_Z20_T20
```

The exact naming convention can be adapted, but each experiment should clearly identify the changed parameter.

---

# Recommended Research Record

Each completed experiment should record:

```text
Experiment ID
EA Version
Symbol
Timeframe
Test Period
Initial Deposit

Changed Parameters
Unchanged Parameters

Net Profit
Profit Factor
Max Drawdown
Sharpe Ratio
Total Trades
Win Rate
Average Profit Trade
Average Loss Trade
Maximum Consecutive Losses

Observations
Decision
```

---

# Research Status

```text
Baseline Backtest       = COMPLETED
Parameter Optimization  = NOT RECORDED
Out-of-Sample Test      = NOT RECORDED
Forward Test             = NOT RECORDED
Live Test                = NOT RECORDED
```

---

# Baseline Preservation Rule

The baseline result must not be overwritten.

Every optimization or modification should create a new research record.

The original EA source and original Strategy Tester report should remain unchanged.

This allows future experiments to be compared against the same reference configuration.

---

# Current Baseline

```text
EA-088_Z-Score_2_5
ZPeriod    = 20
ZThreshold = 2.5

Net Profit = -123.57 USD
PF         = 0.93
Max DD     = 18.79%
Trades     = 1,484
```

This is the current research reference for EA-088.
