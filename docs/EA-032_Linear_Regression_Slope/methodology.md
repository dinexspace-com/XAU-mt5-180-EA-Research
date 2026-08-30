# Research Methodology

## Purpose

This repository is designed to research, test, compare and document MetaTrader 5 Expert Advisors for XAUUSD.

The methodology is intentionally simple:

```text
Strategy idea
    ↓
Implement EA
    ↓
Run reproducible baseline backtest
    ↓
Review results
    ↓
Identify one specific weakness
    ↓
Run controlled research experiment
    ↓
Compare against baseline
    ↓
PASS / FAIL
```

The objective is not to optimize every EA immediately.

The objective is to determine whether the underlying trading logic has sufficient merit to justify further development.

---

# Repository Research Structure

Each EA is separated into three main layers:

```text
EAs/
Backtest/
Research/
```

These layers serve different purposes.

---

## 1. EAs

Location:

```text
EAs/
└── EA-XXX_Strategy_Name/
```

Each EA folder should contain:

```text
EA-XXX_Strategy_Name.mq5
README.md
```

### Purpose

The EA folder contains the actual trading implementation.

The `.mq5` source file is the authoritative reference for:

* Entry logic
* Exit logic
* Position management
* Risk parameters
* Filters
* Trading conditions

The README explains what the current code actually does.

It should not claim profitability unless supported by backtest evidence.

---

# 2. Backtest

Location:

```text
Backtest/
└── EA-XXX_Strategy_Name/
```

This folder contains the empirical Strategy Tester evidence for the EA.

Recommended contents:

```text
README.md
Strategy Tester HTML report
Balance graph
Trade statistics graphs
MFE / MAE graph
Holding-time graph
```

The exact graph files may vary depending on the MetaTrader report.

---

## Baseline Backtest

Every EA should first receive a baseline test before any optimization.

The baseline test exists to answer:

```text
Does the current implementation work under a clearly defined test configuration?
```

A baseline should use one fixed parameter set.

Do not optimize multiple variables before the baseline is recorded.

---

# Backtest Configuration

Every backtest README should record at minimum:

| Category        | Required Information            |
| --------------- | ------------------------------- |
| EA              | EA name/version                 |
| Symbol          | Trading instrument              |
| Timeframe       | Test timeframe                  |
| Start Date      | Beginning of test               |
| End Date        | End of test                     |
| Data Quality    | Strategy Tester history quality |
| Initial Deposit | Starting account balance        |
| Currency        | Account currency                |
| Leverage        | Test leverage                   |
| Lot Size        | Position size                   |
| Stop Loss       | SL configuration                |
| Take Profit     | TP configuration                |
| Spread Filter   | If applicable                   |
| Strategy Inputs | Relevant EA parameters          |

This is required so another researcher can reproduce the test.

---

# Data Quality

Whenever possible, the primary baseline should use:

```text
100% real ticks
```

when supported by MetaTrader 5 and available broker history.

The reported history quality must always be documented.

Do not describe a result as comparable if two tests use materially different data quality without explicitly noting that difference.

---

# Core Evaluation Metrics

The following metrics should be recorded for every baseline test.

## Total Net Profit

```text
Total Net Profit
```

Shows the net result after all winning and losing trades in the Strategy Tester simulation.

Net Profit alone is not sufficient to determine strategy quality.

---

## Profit Factor

```text
Profit Factor = Gross Profit / |Gross Loss|
```

General interpretation:

```text
PF < 1.00
```

indicates that gross losses exceeded gross profits during the test.

A Profit Factor above `1.00` is necessary for a profitable historical test, but is not sufficient by itself to establish robustness.

---

## Expected Payoff

Expected Payoff represents the average historical result per trade in the Strategy Tester report.

A negative Expected Payoff is a direct warning that the tested configuration had negative expectancy over the sample.

---

## Maximum Drawdown

Both balance and equity drawdown should be recorded where available.

Drawdown is one of the primary risk metrics.

A strategy with positive net profit but extreme drawdown should not automatically be considered successful.

---

## Win Rate

Record:

```text
Winning Trades
Losing Trades
Win Rate
Loss Rate
```

Where useful, also separate:

```text
Long win rate
Short win rate
```

This can help identify asymmetric behavior between BUY and SELL signals.

---

## Average Winner / Average Loser

Record:

```text
Average Profit Trade
Average Loss Trade
```

These values help evaluate the actual payoff structure of the strategy.

---

## Consecutive Losses

Record:

```text
Maximum consecutive losses
Average consecutive losses
```

This helps evaluate whether the trading system produces risk clusters that may be difficult to tolerate operationally.

---

## Holding Time

Where available, record:

```text
Minimum holding time
Maximum holding time
Average holding time
```

Holding duration helps identify whether the EA behaves primarily as:

```text
scalping
short-term
intraday
swing
```

The classification should only be used descriptively and should not replace the actual reported holding-time data.

---

# MFE and MAE

MetaTrader may report:

```text
MFE = Maximum Favorable Excursion
MAE = Maximum Adverse Excursion
```

These metrics can be useful for understanding how trades behave before they close.

They may help investigate:

* Stop Loss placement
* Take Profit placement
* Premature exits
* Large adverse excursions
* Unrealized profit before reversal

MFE and MAE should be treated as diagnostic tools rather than standalone proof of strategy quality.

---

# PASS / FAIL Framework

Every baseline receives a research status.

The status is not the same as approval for live trading.

---

## Baseline FAIL

A baseline should normally be classified as FAIL when one or more major problems are present, such as:

```text
Negative Total Net Profit
Profit Factor < 1.00
Negative Expected Payoff
Extremely high drawdown
Severe balance deterioration
```

The exact reason should be documented.

Do not modify the result to make the EA appear successful.

---

## Baseline PASS

A baseline may progress to further validation when it demonstrates:

```text
Positive historical expectancy
Acceptable drawdown
Sufficient trade sample
No obvious structural failure
```

A PASS means:

```text
worthy of additional research
```

It does NOT mean:

```text
ready for live trading
```

---

# Research Process After Baseline

After the baseline, research should focus on one hypothesis at a time.

Example:

```text
Baseline problem:
Too many weak signals

Hypothesis:
A minimum slope threshold may remove weak entries

Experiment:
Change only the slope filter

Compare:
Baseline vs Experiment
```

This makes it possible to understand what caused the result to change.

---

# One Variable at a Time

Whenever practical, early research experiments should change only one primary variable.

Example:

```text
Baseline:
RegPeriod = 20
No slope threshold

Experiment A:
RegPeriod = 20
Slope threshold added
```

Avoid simultaneously changing:

```text
Regression period
Stop Loss
Take Profit
Trailing Stop
Trading session
Slope threshold
```

because it becomes difficult to determine which change caused the improvement or deterioration.

---

# Research Experiment Naming

Recommended experiment naming:

```text
EXP-001
EXP-002
EXP-003
```

Example:

```text
EA-032
├── BASELINE
├── EXP-001_Slope_Threshold
├── EXP-002_RegPeriod
└── EXP-003_Time_Filter
```

Each experiment should have:

```text
Objective
Hypothesis
Changed variable
Fixed variables
Backtest configuration
Result
Comparison with baseline
PASS / FAIL
Conclusion
```

---

# Optimization Policy

Optimization should not be the first step.

Use this order:

```text
1. Baseline
2. Identify structural weakness
3. Controlled experiment
4. Validate whether signal improves
5. Only then perform parameter optimization
```

Large parameter searches can create misleading results if the underlying trading logic is weak.

Optimization should therefore come after the strategy demonstrates basic merit.

---

# Avoiding Overfitting

A profitable backtest is not sufficient evidence that an EA is robust.

Research should watch for:

* Excessive parameter tuning
* Very narrow profitable parameter ranges
* Large performance changes from small parameter changes
* Excellent performance only in one short historical period
* Very small trade samples
* Selection of only favorable test periods

A robust strategy should ideally remain reasonably stable when assumptions change moderately.

---

# In-Sample and Out-of-Sample Testing

After a strategy produces a promising result, historical data should eventually be separated into:

```text
In-Sample
Out-of-Sample
```

### In-Sample

Used for:

```text
research
parameter development
optimization
```

### Out-of-Sample

Used for:

```text
independent validation
```

The Out-of-Sample period should not be repeatedly optimized against.

---

# Forward Testing

A strategy that survives historical validation should eventually progress to forward testing.

Recommended progression:

```text
Backtest
    ↓
Out-of-Sample
    ↓
Demo / Forward Test
    ↓
Small controlled live test
```

Moving to the next stage requires explicit review.

A historical PASS does not automatically authorize live deployment.

---

# Source Code Review

Before interpreting a backtest, verify that the EA implementation matches the intended strategy.

Review at minimum:

```text
Entry conditions
Exit conditions
SL / TP calculation
Position counting
Magic Number filtering
Spread filter
New-bar / tick execution
Break Even logic
Trailing Stop logic
Unused inputs
```

If the source code contains an implementation issue, document it before attributing the backtest result entirely to the trading concept.

---

# Reproducibility

Every important research result should be reproducible.

Keep:

```text
EA source
Exact EA parameters
Test symbol
Timeframe
Date range
Broker / server where relevant
Strategy Tester report
Charts
Research conclusion
```

If the result cannot be reproduced, it should not be treated as strong research evidence.

---

# Documentation Rule

Repository documentation should separate three things clearly:

### Code facts

What the `.mq5` source actually implements.

### Backtest facts

What MetaTrader Strategy Tester actually reported.

### Research interpretation

What is inferred from those results.

Interpretation must never be presented as if it were raw Strategy Tester data.

---

# Research Workflow

Standard workflow:

```text
STEP 1
Create / receive EA source
        ↓

STEP 2
Review implementation
        ↓

STEP 3
Document EA
        ↓

STEP 4
Run baseline backtest
        ↓

STEP 5
Save Strategy Tester evidence
        ↓

STEP 6
Document baseline
        ↓

STEP 7
Research failure / strength
        ↓

STEP 8
Define one experiment
        ↓

STEP 9
Modify EA
        ↓

STEP 10
Run the same test conditions
        ↓

STEP 11
Compare against baseline
        ↓

STEP 12
PASS / FAIL experiment
```

---

# Minimum Evidence Requirement

A research result should not be considered complete without evidence.

Minimum evidence:

```text
EA source
+
Strategy Tester report
+
documented test parameters
+
key performance metrics
+
research conclusion
```

Screenshots alone should not replace the original Strategy Tester report when the report is available.

---

# Current Example — EA-032

The first documented case in this repository is:

```text
EA-032_Linear_Regression_Slope
```

Its baseline was tested using:

```text
XAUUSD.PRO
M1
2026.01.02 - 2026.04.01
100% real ticks
```

The baseline produced:

```text
Net Profit       = -$993.19
Profit Factor    = 0.91
Win Rate         = 31.40%
Maximum Drawdown = 99.36%
Total Trades     = 5,039
```

Therefore:

```text
EA-032 BASELINE = FAIL
```

This result serves as the reference point for subsequent EA-032 research experiments.

---

# Repository Principle

The repository follows one primary principle:

```text
Build
→ Test
→ Measure
→ Understand
→ Change one thing
→ Test again
```

Do not optimize a strategy before understanding its baseline behavior.

Do not claim a strategy works without reproducible evidence.

Do not treat a successful backtest as proof of future profitability.
