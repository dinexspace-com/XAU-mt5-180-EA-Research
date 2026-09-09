# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the research methodology used in the **XAUUSD MT5 EA Research** repository.

The objective is to evaluate trading ideas systematically and reproducibly using MetaTrader 5.

The research process is designed to answer one primary question:

> Does the strategy contain a trading edge that remains reasonably stable outside the specific historical sample used to discover it?

A profitable backtest alone is not considered sufficient evidence.

---

## 2. Research Workflow

Each EA follows the same general research process:

```text
Strategy Idea
    ↓
Rule Definition
    ↓
MQL5 Implementation
    ↓
Baseline Backtest
    ↓
Identify Research Questions
    ↓
Controlled Experiments
    ↓
Longer Historical Test
    ↓
Out-of-Sample Test
    ↓
Robustness Test
    ↓
Final Assessment
```

Each stage should preserve its artifacts and results.

Negative results are retained.

---

## 3. Strategy Definition

Before optimization, the strategy must be expressible as explicit trading rules.

At minimum, document:

```text
Market
Timeframe

Entry LONG
Entry SHORT

Exit logic

Stop Loss
Take Profit

Position sizing

Filters

Trade management
```

Rules should be sufficiently explicit that the strategy can be implemented and reproduced without discretionary interpretation.

---

## 4. EA Implementation

Each strategy receives a unique identifier.

Example:

```text
EA-049_20-Bar_Donchian
```

Source code is stored under:

```text
EAs/
└── EA-049_20-Bar_Donchian/
    ├── EA-049_20-Bar_Donchian.mq5
    └── README.md
```

The README documents the implemented trading logic and inputs.

Research conclusions must not be inferred from source code alone.

---

## 5. Baseline Backtest

Every EA begins with a baseline backtest.

The purpose of the baseline is not to prove profitability.

It establishes a reference configuration against which subsequent experiments can be compared.

The following information should be preserved:

```text
EA version
Symbol
Timeframe
Test period
Initial deposit
Leverage
Tick/model quality
Input parameters
MT5 Strategy Tester report
```

Whenever possible, research backtests should use high-quality tick data.

---

## 6. Baseline Metrics

At minimum, record:

| Category | Metrics |
|---|---|
| Return | Net Profit, Gross Profit, Gross Loss |
| Efficiency | Profit Factor, Expected Payoff |
| Risk | Maximum Balance/Equity Drawdown |
| Sample | Total Trades |
| Outcomes | Winning Trades, Losing Trades |
| Direction | Long Trades, Short Trades |
| Trade quality | Average Win, Average Loss |
| Sequence | Consecutive Wins/Losses |

Additional MT5 statistics may be retained when useful.

No single metric determines whether a strategy passes research.

---

## 7. Sample Size

Small samples must be treated cautiously.

For example:

```text
30 profitable trades
```

do not provide the same level of evidence as:

```text
300
1,000
or several thousand trades
```

A short profitable backtest is therefore classified as:

```text
PRELIMINARY EVIDENCE
```

rather than:

```text
VALIDATED EDGE
```

The required sample size depends on the strategy, timeframe, trading frequency and variability of outcomes.

No universal trade-count threshold is assumed to prove profitability.

---

## 8. Research Questions

After establishing the baseline, specific research questions are created.

Example:

```text
RQ-01:
Does LONG performance differ materially from SHORT performance?

RQ-02:
How sensitive is the strategy to the lookback period?

RQ-03:
Does alternative exit logic improve robustness?

RQ-04:
Does volatility-normalized risk management improve stability?
```

Each research question should correspond to a testable hypothesis.

---

## 9. Controlled Experiments

During hypothesis testing, change as few logical components as possible.

Preferred:

```text
Baseline
vs.
Different DonchianPeriod
```

Avoid:

```text
Different DonchianPeriod
+
different SL
+
different TP
+
different trailing
+
different filters
```

when the purpose is to determine whether `DonchianPeriod` matters.

Changing many components simultaneously makes it difficult to determine which change caused the observed result.

---

## 10. Parameter Research

Parameter testing is allowed and necessary.

However, optimization must be distinguished from validation.

A parameter grid may be used to understand the strategy's response surface.

Example:

```text
10
20
30
40
55
80
100
```

A desirable result is not merely one highly profitable parameter.

More useful evidence is a region where neighboring parameter values produce reasonably consistent behavior.

Conceptually:

```text
Poor:

20 → poor
21 → poor
22 → exceptional
23 → poor
24 → poor
```

versus:

```text
More promising:

20 → positive
25 → positive
30 → positive
35 → positive
40 → positive
```

The second pattern provides stronger evidence of parameter stability.

---

## 11. Multi-Parameter Optimization

Multiple inputs may be optimized simultaneously when the research stage requires it.

However, this should normally occur after individual components and reasonable parameter ranges have been understood.

The risk of searching many combinations is:

```text
More parameters
×
More parameter values
=
More combinations
=
Greater opportunity to fit historical noise
```

Therefore multi-parameter optimization is a research tool, not proof of robustness.

The best optimization result must subsequently be validated on unseen data.

---

## 12. Discovery and Validation Data

Data used to discover parameters should be separated from data used for final validation whenever practical.

Conceptually:

```text
Historical Data
│
├── In-Sample
│     Research / parameter discovery
│
└── Out-of-Sample
      Independent validation
```

Parameters are developed using the In-Sample period.

They are then frozen before evaluating the Out-of-Sample period.

The Out-of-Sample result must not be repeatedly used to redesign the strategy, otherwise it gradually becomes part of the optimization process.

---

## 13. Out-of-Sample Testing

An Out-of-Sample test evaluates the strategy on historical data that was not used to select the configuration.

Procedure:

```text
1. Research on IS data
2. Select configuration
3. Freeze parameters
4. Run OOS
5. Compare behavior
```

Compare:

```text
Profit Factor
Expectancy
Drawdown
Trade count
Win/Loss characteristics
LONG/SHORT behavior
```

The objective is not to require identical performance.

The objective is to determine whether the strategy's behavior remains reasonably consistent.

---

## 14. Walk-Forward Research

For strategies that survive initial Out-of-Sample testing, walk-forward research may be performed.

Concept:

```text
Train → Test
       Train → Test
              Train → Test
```

This evaluates whether a research or optimization process remains useful across changing market periods.

Walk-forward testing is a later research stage and is not required for the initial EA implementation.

---

## 15. Robustness Testing

A strategy that survives basic OOS testing should be subjected to robustness tests.

Possible tests include:

### Parameter Sensitivity

Change parameters around the selected configuration.

```text
Selected = 30

Test:
25
28
30
32
35
```

A strategy that fails after very small parameter changes requires additional investigation.

### Different Historical Periods

Test across:

```text
different years
different volatility regimes
bullish periods
bearish periods
sideways periods
```

### Execution Conditions

Where appropriate, investigate sensitivity to:

```text
Spread
Slippage
Execution assumptions
Broker symbol specifications
```

### Directional Robustness

Analyze:

```text
LONG only
SHORT only
LONG + SHORT
```

when directional asymmetry appears in the data.

---

## 16. Risk Management Research

Risk management must be evaluated separately from entry quality where possible.

Possible approaches include:

```text
Fixed points
ATR / volatility-based distances
Fixed lot
Percentage risk
Structural exits
Trailing exits
```

A profitable risk-management configuration does not automatically demonstrate that the underlying entry signal contains an edge.

---

## 17. Avoiding Overfitting

The following practices should be avoided:

```text
Selecting only the most profitable run

Testing hundreds of combinations
and reporting only the winner

Changing multiple rules after every loss

Adding filters solely because
they improve one historical period

Removing losing market periods

Repeatedly optimizing against
the same validation period
```

Instead, prefer:

```text
Simple hypotheses
Small controlled experiments
Parameter stability
Long historical samples
Out-of-sample evidence
Robustness tests
```

---

## 18. Evidence Preservation

Research artifacts should be preserved.

Example:

```text
Backtest/
└── EA-049_20-Bar_Donchian/
    ├── README.md
    ├── Strategy Tester HTML
    └── Strategy Tester charts
```

Failed experiments should not automatically be deleted.

They provide evidence about what was tested and help prevent repeating unsuccessful research paths.

---

## 19. Research Classification

EA research may be classified using the following stages:

### Stage 0 — IMPLEMENTED

```text
EA compiles and executes.
```

### Stage 1 — BASELINE

```text
Baseline backtest completed.
```

### Stage 2 — RESEARCH

```text
Parameters and hypotheses under investigation.
```

### Stage 3 — OOS

```text
Configuration tested on unseen historical data.
```

### Stage 4 — ROBUSTNESS

```text
Sensitivity and robustness tests completed.
```

### Stage 5 — CANDIDATE

```text
Sufficient evidence exists to justify
the next validation stage.
```

`CANDIDATE` does not mean guaranteed profitable or production-safe.

---

## 20. Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-<>/
│       ├── EA-<>.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-<>/
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

Contains MQL5 implementations and strategy-level documentation.

### `Backtest/`

Contains raw MetaTrader 5 backtest evidence and baseline results.

### `Research/`

Contains research questions, hypotheses, observations and experiment progression.

### `docs/`

Contains repository-wide research methodology.

### `GitHub_Profile/`

Contains the public GitHub profile README.

---

## 21. Core Principle

The methodology follows one central rule:

> Optimize only after understanding what is being tested, and validate every promising result outside the data used to discover it.

The research target is not the highest historical profit.

The research target is a strategy whose behavior remains sufficiently stable when market period, parameters and testing conditions change.
