# Research & Backtesting Methodology

## 1. Purpose

This document defines the standard research and backtesting methodology used in the **XAUUSD MT5 EA Research** repository.

The purpose is to ensure that every Expert Advisor is developed, tested, evaluated, and documented using the same process.

The objective is not simply to find profitable historical results.

The objective is to determine whether a trading strategy demonstrates sufficient evidence to justify further research and validation.

---

## 2. Standard Research Workflow

Every EA follows the same research process:

```text
Trading Idea
    ↓
Define Strategy Rules
    ↓
Implement EA
    ↓
Create Baseline
    ↓
Backtest
    ↓
Analyze Results
    ↓
PASS / FAIL
    ↓
Research Improvements
    ↓
Retest
    ↓
Compare With Baseline
```

Each EA receives a unique identifier:

```text
EA-030_Parabolic_SAR
EA-031_<Strategy_Name>
EA-032_<Strategy_Name>
```

The same identifier should be used across source code, backtests, and research documentation.

---

## 3. Strategy Documentation

Before evaluating an EA, its trading logic must be documented.

At minimum:

- Entry logic
- BUY conditions
- SELL conditions
- Exit logic
- Stop Loss
- Take Profit
- Position sizing
- Symbol
- Timeframe
- Indicator parameters
- Spread restrictions
- Position limits
- Trade-management features

The documentation must match the actual EA implementation.

Features available in the EA but disabled during a test must be clearly identified as disabled.

---

## 4. Baseline First

Every strategy must first establish a **baseline**.

The baseline is the simplest implementation representing the original trading hypothesis.

Example:

```text
EA-030 Baseline

Signal:
Parabolic SAR

Risk:
Fixed Lot

Exit:
Fixed SL / TP

Additional Filters:
None
```

The baseline must be preserved even when it fails.

A failed baseline remains useful because future experiments can be measured against it.

---

## 5. Backtest Requirements

Every backtest must document:

| Field | Description |
|---|---|
| Expert Advisor | EA/version tested |
| Symbol | Trading instrument |
| Timeframe | Test timeframe |
| Test Period | Historical test period |
| Initial Deposit | Starting balance |
| Leverage | Account leverage |
| Lot Size | Position size |
| Stop Loss | SL configuration |
| Take Profit | TP configuration |
| Spread Filter | Maximum spread |
| EA Inputs | Strategy parameters |
| Data Quality | Historical data quality |

Whenever possible, high-quality historical data should be used.

---

## 6. Preserve Raw Evidence

Original MetaTrader 5 Strategy Tester results must be retained.

Recommended structure:

```text
Backtest/
└── EA-XXX_Strategy_Name/
    ├── README.md
    ├── Strategy_Tester_Report.html
    ├── Balance_Graph.png
    ├── Trade_Distribution.png
    ├── MFE_MAE.png
    └── Holding_Time.png
```

The Strategy Tester report is the primary numerical evidence.

The Backtest README summarizes and interprets those results.

Negative results should not be deleted.

---

## 7. Core Evaluation Metrics

Every EA should be evaluated using multiple metrics rather than net profit alone.

### Total Net Profit

Overall historical profit or loss generated during the test.

Positive net profit alone does not validate a strategy.

### Profit Factor

```text
Profit Factor = Gross Profit / |Gross Loss|
```

General interpretation:

```text
PF < 1.0 → Losing historical test
PF = 1.0 → Approximately break-even
PF > 1.0 → Gross profit exceeded gross loss
```

Profit Factor must be considered together with drawdown and other metrics.

### Expected Payoff

```text
Expected Payoff = Total Net Profit / Total Trades
```

Measures the average historical result per trade.

### Maximum Drawdown

Both monetary and percentage drawdown should be recorded.

```text
High Profit + Extreme Drawdown
≠ Automatically Acceptable
```

### Win Rate

```text
Win Rate =
Winning Trades / Total Trades × 100
```

Win rate should be considered together with average winner and average loser.

### Average Win / Average Loss

Record:

- Average Profit Trade
- Average Loss Trade

This helps identify the payoff structure of the strategy.

### Consecutive Losses

Record:

- Maximum Consecutive Losses
- Average Consecutive Losses

This helps evaluate strategy stability.

### Sharpe Ratio

Used as an additional measure of historical risk-adjusted performance.

It should not be used alone to determine PASS or FAIL.

### Recovery Factor

Used to evaluate performance relative to experienced drawdown.

---

## 8. Additional Analysis

When available, also analyze:

### Long vs Short

Compare BUY and SELL performance separately.

A difference between BUY and SELL results should first become a research question rather than automatically causing one direction to be removed.

### Holding Time

Record:

- Minimum holding time
- Maximum holding time
- Average holding time

### MFE / MAE

Retain:

- Maximum Favorable Excursion (MFE)
- Maximum Adverse Excursion (MAE)
- Profit/MFE correlation
- Profit/MAE correlation
- MFE/MAE correlation

### Equity Curve

Review the balance/equity curve for:

- Long-term direction
- Large drawdowns
- Recovery behavior
- Persistent deterioration
- Extended flat periods
- Dependence on isolated large trades
- General stability

---

## 9. Controlled Experiments

After establishing the baseline, modifications should be tested through controlled experiments.

Preferred principle:

> Change one major strategy component at a time whenever practical.

Example:

```text
Baseline
    ↓
Add Trend Filter
    ↓
Backtest
    ↓
Compare With Baseline
```

Then separately:

```text
Baseline
    ↓
Add Time Filter
    ↓
Backtest
    ↓
Compare With Baseline
```

Avoid changing many unrelated components simultaneously because it becomes difficult to determine which modification caused the result.

---

## 10. Research Questions

Every experiment should answer a specific research question.

Example:

```text
Research Question:
Does adding a trend filter reduce low-quality
Parabolic SAR entries?

Hypothesis:
Trend filtering improves signal quality.

Modification:
Add trend filter.

Test:
Run backtest under documented conditions.

Result:
Compare with baseline.

Conclusion:
PASS / FAIL hypothesis.
```

The objective is to understand **why** performance changes.

---

## 11. Parameter Optimization

Optimization should not be the first response to a failed strategy.

Preferred sequence:

```text
1. Establish baseline
2. Analyze failure
3. Form hypothesis
4. Modify strategy
5. Retest
6. Compare
7. Optimize parameters only when justified
```

Optimization should answer a research question rather than simply search for the highest historical profit.

---

## 12. Overfitting Control

Avoid repeatedly modifying parameters solely to improve performance on the same historical period.

Warning signs include:

- Excessive parameter combinations
- Very narrow profitable parameter ranges
- Performance dependent on a few trades
- Large improvement only during optimization
- Increasing strategy complexity after every failed test

Simpler strategies should be preferred when they provide comparable results.

---

## 13. PASS / FAIL

Research states:

```text
TODO
TESTING
PASS
FAIL
```

### FAIL

A configuration may FAIL when evidence shows problems such as:

- Negative net performance
- Profit Factor below 1
- Unacceptable drawdown
- Unstable equity curve
- Tested hypothesis not supported

### PASS

PASS means:

> The result provides sufficient evidence to continue to the next research stage.

PASS does **not** mean:

```text
Approved for live trading
```

A successful historical backtest is only one stage of validation.

---

## 14. Compare Every Experiment With Baseline

At minimum compare:

| Metric | Baseline | Experiment |
|---|---:|---:|
| Net Profit | — | — |
| Profit Factor | — | — |
| Expected Payoff | — | — |
| Maximum Drawdown | — | — |
| Win Rate | — | — |
| Total Trades | — | — |
| Sharpe Ratio | — | — |
| Recovery Factor | — | — |

A modification should not be judged using Net Profit alone.

---

## 15. Validation Stages

Research progresses through:

```text
Baseline
    ↓
Controlled Experiments
    ↓
Improved Candidate
    ↓
Robustness Testing
    ↓
Out-of-Sample Validation
    ↓
Forward / Demo Testing
    ↓
Live Consideration
```

Passing one stage only allows the strategy to proceed to the next stage.

---

## 16. Evidence Chain

Every conclusion should be traceable:

```text
EA Source Code
      ↓
Backtest Evidence
      ↓
Research Analysis
      ↓
Conclusion
```

Repository structure:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-XXX_Strategy_Name/
│
├── Backtest/
│   └── EA-XXX_Strategy_Name/
│
├── Research/
│   └── README.md
│
└── docs/
    └── methodology.md
```

---

## 17. Core Principle

> Preserve the evidence, establish a baseline, test one hypothesis at a time, and let the results determine the next experiment.

A failed strategy is still a valid research result when the experiment and evidence are properly documented.

---

## Disclaimer

All strategies, tests, and research contained in this repository are for research and educational purposes.

Historical simulations do not guarantee future performance.

No backtest result should be interpreted as financial advice or as proof that an Expert Advisor is suitable for live trading.
