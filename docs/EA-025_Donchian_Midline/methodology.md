# Research Methodology

This document defines the research methodology used in the **XAUUSD MT5 EA Research** repository.

The objective is to maintain a consistent, reproducible, and evidence-based process for developing and evaluating Expert Advisors (EAs) on MetaTrader 5.

---

## 1. Research Objective

The primary objective of this repository is to test trading hypotheses systematically.

Each EA represents a specific strategy hypothesis.

The purpose of the first test is **not to optimize a strategy until it becomes profitable**.

The purpose is to answer:

> Does the original strategy hypothesis demonstrate evidence of a trading edge under the tested conditions?

Both successful and failed experiments are preserved.

---

## 2. Research Workflow

Each EA follows the same basic process:

```text
Strategy Hypothesis
        ↓
EA Implementation
        ↓
Code Verification
        ↓
Baseline Backtest
        ↓
Performance Evaluation
        ↓
PASS / FAIL
        ↓
Research Conclusion
```

Optimization or additional strategy variants should only be considered after the baseline result has been documented.

---

## 3. Strategy Definition

Before evaluating an EA, its trading logic must be clearly defined.

At minimum, the EA documentation should identify:

* Entry logic
* Exit logic
* Stop Loss
* Take Profit
* Position sizing
* Trade management
* Filters
* Strategy-specific parameters

The source code used for the test must be preserved in the repository.

---

## 4. EA Identification

Each strategy receives a unique sequential identifier.

Example:

```text
EA-025_Donchian_Midline
```

Naming format:

```text
EA-<ID>_<Strategy_Name>
```

The same identifier should be used consistently across:

```text
EAs/
Backtest/
Research/
```

This allows the source code, test evidence, and research conclusion to be traced back to the same experiment.

---

## 5. Baseline Backtest

The first backtest is treated as the **baseline test**.

Its purpose is to evaluate the original strategy implementation before further optimization.

The following information should be recorded whenever available:

| Category   | Required Information   |
| ---------- | ---------------------- |
| EA         | EA name / version      |
| Instrument | Tested symbol          |
| Timeframe  | Tested timeframe       |
| Period     | Start and end date     |
| Data       | History / tick quality |
| Capital    | Initial deposit        |
| Leverage   | Account leverage       |
| Parameters | EA input parameters    |
| Trades     | Total number of trades |

The original MetaTrader 5 Strategy Tester report should be retained as evidence.

---

## 6. Core Performance Metrics

The following metrics should be reviewed when evaluating an EA.

### Net Profit

Total financial result of the test.

```text
Net Profit = Gross Profit + Gross Loss
```

Positive Net Profit alone is not sufficient to establish that a strategy is viable.

---

### Profit Factor

```text
Profit Factor = Gross Profit / |Gross Loss|
```

General interpretation:

```text
PF > 1.0 → Gross profit exceeds gross loss
PF < 1.0 → Gross loss exceeds gross profit
```

Profit Factor should be considered together with drawdown, trade count, expectancy, and other performance characteristics.

---

### Expected Payoff

Average expected financial result per trade.

```text
Expected Payoff = Net Profit / Total Trades
```

A negative value indicates negative historical expectancy for the tested configuration.

---

### Drawdown

Drawdown measures deterioration from previous account peaks.

Both balance and equity drawdown should be reviewed.

High drawdown may indicate that a strategy carries unacceptable risk even when other performance metrics appear favorable.

---

### Sharpe Ratio

Used as an additional measure of return relative to variability.

It should not be used as the sole criterion for determining whether an EA passes or fails.

---

### Win Rate

```text
Win Rate = Winning Trades / Total Trades
```

Win rate must be interpreted together with average win, average loss, Profit Factor, and expectancy.

A high win rate does not automatically imply a profitable strategy.

---

## 7. Additional Diagnostics

Where available, the following should also be reviewed:

* Long vs Short performance
* Maximum consecutive wins
* Maximum consecutive losses
* Average winning trade
* Average losing trade
* Largest winning trade
* Largest losing trade
* Position holding time
* MFE (Maximum Favorable Excursion)
* MAE (Maximum Adverse Excursion)
* Profit distribution by time
* Balance / equity curve

These diagnostics help identify why a strategy performed as observed.

---

## 8. PASS / FAIL Classification

Every completed baseline experiment receives a research status.

```text
PASS
FAIL
```

### PASS

`PASS` means the baseline result provides sufficient evidence to justify further research.

It does **not** mean the EA is ready for live trading.

A PASS strategy may proceed to additional validation such as:

```text
Baseline
   ↓
Additional Validation
   ↓
Out-of-Sample Test
   ↓
Robustness Testing
   ↓
Forward Test
```

### FAIL

`FAIL` means the tested configuration does not provide sufficient evidence of a viable trading edge.

A failed experiment should still be preserved.

It may provide useful information for future strategy development and prevents the same unsuccessful hypothesis from being repeatedly tested without reference to previous evidence.

---

## 9. Evidence Requirement

A research conclusion should not exist without supporting evidence.

For each completed EA experiment, preserve whenever applicable:

```text
Source Code
    +
EA Documentation
    +
MT5 Strategy Tester Report
    +
Backtest Charts
    +
Key Metrics
    +
Research Conclusion
```

The conclusion must reflect the actual test result.

Negative results must not be removed simply because the strategy failed.

---

## 10. Reproducibility

A third party should be able to understand:

1. What strategy was tested.
2. What code implemented the strategy.
3. What parameters were used.
4. What market and timeframe were tested.
5. What period was tested.
6. What results were obtained.
7. Why the experiment received its research status.

For this reason, original reports and configuration information should be retained whenever possible.

---

## 11. Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-<ID>_<Strategy>/
│       ├── EA-<ID>_<Strategy>.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-<ID>_<Strategy>/
│       ├── README.md
│       └── MT5 test evidence
│
├── Research/
│   └── README.md
│
├── docs/
│   └── methodology.md
│
└── GitHub_Profile/
    └── README.md
```

### `EAs/`

Contains EA source code and documentation describing the implementation.

### `Backtest/`

Contains the original backtest evidence and a summary of the test results.

### `Research/`

Maintains the research conclusions and status of completed experiments.

### `docs/`

Contains the methodology used across the entire research repository.

---

## 12. Research Integrity

The repository follows several basic principles:

1. Preserve both positive and negative results.
2. Do not modify reported results to improve presentation.
3. Keep source code linked to its corresponding test.
4. Document the parameters used in each baseline test.
5. Separate observed results from interpretation.
6. Do not treat a single backtest as proof of future profitability.
7. Do not classify an EA as production-ready based only on historical backtesting.

---

## 13. Current Baseline Example

**EA-025_Donchian_Midline** is the first documented example under this methodology.

Its baseline test used:

```text
Symbol:       XAUUSD.PRO
Timeframe:    M1
Period:       2026-01-02 → 2026-08-24
Data Quality: 100% real ticks
Trades:       37,212
```

The test produced:

```text
Net Profit:      -$9,994.04
Profit Factor:   0.88
Expected Payoff: -$0.27
Sharpe Ratio:    -5.00
Max Drawdown:    99.94%
```

The experiment is therefore recorded as:

```text
EA-025_Donchian_Midline
STATUS: FAIL
```

The failed result is retained as a research baseline rather than discarded.

---

## Disclaimer

This repository is intended for **research and educational purposes**.

Backtested performance is historical and does not guarantee future results. A strategy classified as PASS under this methodology should not be interpreted as suitable for live trading without further independent validation and risk assessment.
