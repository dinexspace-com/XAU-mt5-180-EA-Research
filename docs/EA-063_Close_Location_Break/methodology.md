# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the standard research methodology used in the **xauusd-mt5-ea-research** repository.

The objective is to evaluate trading ideas systematically by converting each hypothesis into an executable MetaTrader 5 Expert Advisor, testing it on XAUUSD data, evaluating its behaviour, and retaining both successful and failed results as research evidence.

The repository is designed to answer a simple question:

> Does a clearly defined trading hypothesis produce a measurable and sufficiently robust edge on XAUUSD?

A profitable backtest alone is not considered sufficient evidence.

The research process separates:

```text
Trading Idea
    ↓
Explicit Rules
    ↓
EA Implementation
    ↓
Baseline Backtest
    ↓
Optimization
    ↓
Forward / Out-of-Sample Validation
    ↓
Robustness Assessment
    ↓
Research Decision
```

---

## 2. Core Research Principles

Every EA in this repository follows the same principles.

### 2.1 Hypothesis Before Optimization

Each EA must begin with a clearly stated trading hypothesis.

Optimization must not be used to invent a strategy from random parameter combinations.

The intended order is:

```text
Hypothesis
→ Rules
→ Code
→ Baseline
→ Optimization
→ Validation
```

not:

```text
Random parameters
→ Find profitable curve
→ Invent explanation afterward
```

---

### 2.2 Reproducibility

Every reported result should be reproducible from retained artifacts.

At minimum, the repository should preserve:

```text
EA source code
Test configuration
Symbol
Timeframe
Test period
Initial capital
Input parameters
MT5 report
Performance metrics
Research conclusion
```

Where available, original MT5 HTML reports and generated graphs should be retained as primary evidence.

---

### 2.3 Failed Results Are Evidence

A failed strategy is not removed from the repository.

Failed experiments help establish:

- which hypotheses were tested;
- which parameter configurations failed;
- which market conditions caused problems;
- which ideas should not be repeated without modification.

Therefore:

```text
FAIL ≠ DELETE
```

A failed EA remains part of the research history.

---

### 2.4 No Automatic Promotion

An EA is never considered successful solely because one backtest or one optimization pass produces a strong result.

The research process requires progressively stronger evidence.

```text
Profitable Backtest
≠
Validated Strategy
```

---

## 3. Repository Structure

The standard repository structure is:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-<>/
│   │   ├── EA-<>.mq5
│   │   └── README.md
│   │
│
├── Backtest/
│   ├── EA-<>/
│   │
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

Each area has a separate responsibility.

```text
/EAs
    Strategy implementation and EA-level documentation.

/Backtest
    Raw MT5 evidence and backtest-specific documentation.

/Research
    Research interpretation, hypothesis tracking and experiment conclusions.

/docs
    Repository-wide methodology.

/GitHub_Profile
    Public presentation of the research project.
```

---

## 4. EA Naming Convention

Each experiment receives a unique sequential identifier.

Example:

```text
EA-063_Close_Location_Break
```

Format:

```text
EA-<ID>_<Strategy_Name>
```

The same identifier should be used consistently across:

```text
source code
EA folder
backtest folder
research records
reports
documentation
```

This allows every artifact to be traced back to the same experiment.

---

## 5. Stage 1 — Trading Hypothesis

Research begins with a falsifiable trading idea.

A hypothesis should explain:

```text
What market behaviour is being tested?
What observable condition represents that behaviour?
Why might that condition contain useful information?
How can the condition be expressed without discretionary interpretation?
```

Example:

```text
Hypothesis:

A breakout candle that closes near the extreme of its own range
may have greater continuation potential than a breakout candle
that closes away from its extreme.
```

The hypothesis is not treated as true.

It is the proposition being tested.

---

## 6. Stage 2 — Rule Definition

The hypothesis must be translated into explicit trading rules.

Rules should define, where applicable:

```text
BUY condition
SELL condition
Entry timing
Stop Loss
Take Profit
Position sizing
Spread restrictions
Exit conditions
Break Even
Trailing Stop
Trading timeframe
Lookback periods
Signal filters
```

Rules must be sufficiently precise that they can be implemented without discretionary interpretation.

If a rule cannot be expressed clearly enough to code, the hypothesis is not yet ready for EA implementation.

---

## 7. Stage 3 — EA Implementation

The strategy is implemented as an MT5 Expert Advisor.

Each EA folder contains:

```text
EAs/
└── EA-<>/
    ├── EA-<>.mq5
    └── README.md
```

The EA README documents the actual implementation.

It should describe:

```text
Strategy logic
BUY rules
SELL rules
Inputs
Position management
SL / TP
Break Even
Trailing Stop
Execution restrictions
Known implementation assumptions
```

The README describes what the code does.

It must not claim profitability simply because the strategy has been implemented.

---

## 8. Stage 4 — Baseline Backtest

The first test of an EA is the baseline test.

The baseline uses the initial parameter configuration before optimization.

Its purpose is to establish a reference result.

The baseline answers:

```text
How does the original implementation behave
before searching for better parameters?
```

The baseline must be retained even if later optimization dramatically improves performance.

---

## 9. Baseline Evidence

Each EA receives its own backtest directory.

Example:

```text
Backtest/
└── EA-063_Close_Location_Break/
    ├── README.md
    ├── ReportTester-*.html
    └── supporting MT5 graphs
```

The original MT5 HTML report is the primary raw backtest evidence when available.

Supporting graphs may include:

```text
Balance / Equity
Trade distribution
MFE / MAE
Holding time
Hourly distribution
Weekday distribution
Monthly distribution
```

The README summarizes the test but does not replace the raw report.

---

## 10. Baseline Test Record

Every baseline should record at least:

```text
EA
Symbol
Timeframe
Date range
Initial deposit
Leverage
History quality
Lot size
Input parameters
Number of trades
Net profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win rate
BUY / SELL distribution
```

Additional MT5 statistics should be retained where useful.

---

## 11. Baseline Assessment

The baseline is evaluated as an experiment, not as a final strategy.

A baseline may be classified:

```text
BASELINE PASS
```

or:

```text
BASELINE FAIL
```

A baseline failure means:

> The original parameter configuration does not satisfy the research requirements on the tested dataset.

It does **not** automatically mean:

> The underlying hypothesis has no edge.

That distinction is important.

---

## 12. Example — EA-063 Baseline

EA-063 currently provides an example of a failed baseline.

Test:

```text
EA:              EA-063_Close_Location_Break
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 — 2026.03.31
Initial Deposit: $100
Leverage:        1:500
History Quality: 100% real ticks
```

Result:

```text
Total Trades:     269
Net Profit:       -$92.09
Profit Factor:    0.74
Expected Payoff:  -$0.34
Max Drawdown:     92.97%
Win Rate:         45.72%
```

Therefore:

```text
EA-063 BASELINE = FAIL
```

The result is retained as research evidence.

---

## 13. Stage 5 — Optimization

If the baseline does not settle the research question, selected EA parameters may be optimized.

Optimization has two purposes:

```text
1. Determine whether better parameter regions exist.
2. Determine how sensitive the strategy is to its parameters.
```

The objective is **not** simply to find the single parameter combination with the highest profit.

---

## 14. Optimization Priority

Optimization should begin with parameters directly related to the hypothesis.

For example, EA-063 contains structural parameters such as:

```text
InpBreakoutLookback
InpBreakoutBuffer
InpCloseEdgeFraction
```

These directly influence the definition of the Close Location Break signal.

Trade-management parameters include:

```text
InpStopLoss
InpTakeProfit
InpBreakEvenTrigger
InpTrailingStart
InpTrailingDistance
InpTrailingStep
```

Structural parameters should normally be investigated before creating unnecessarily large combinations of secondary parameters.

This reduces search complexity and makes results easier to interpret.

---

## 15. Parameter Search Discipline

Optimization ranges should be defined intentionally.

Each optimized parameter should have:

```text
Start
Step
Stop
```

Ranges should be broad enough to reveal parameter behaviour but not arbitrarily large.

The repository should retain the optimization configuration whenever the optimization result is used to support a research decision.

---

## 16. Optimization Evaluation

The highest-profit optimization pass is not automatically the best candidate.

Optimization results should be examined for **parameter stability**.

A stronger result is one where neighboring parameter combinations also produce acceptable behaviour.

Conceptually:

```text
Weak evidence:

FAIL
FAIL
FAIL
VERY HIGH PROFIT
FAIL
FAIL


Stronger evidence:

PASS
PASS
GOOD
GOOD
PASS
PASS
```

The second pattern suggests a more stable parameter region.

The first may indicate an isolated result that requires additional scrutiny.

---

## 17. Optimization Metrics

Optimization should not be judged using Net Profit alone.

Relevant metrics include:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Recovery Factor
Sharpe Ratio
Number of Trades
Win Rate
BUY / SELL distribution
Equity Curve
Parameter Stability
```

A configuration with high profit but extreme drawdown may be unsuitable.

A configuration with excellent metrics but very few trades may provide insufficient evidence.

Metrics must therefore be interpreted together.

---

## 18. Stage 6 — Candidate Selection

After optimization, candidate configurations may be selected for additional testing.

A candidate should have evidence of:

```text
Positive expectancy
Acceptable drawdown
Sufficient number of trades
Reasonable Profit Factor
Stable neighboring parameter combinations
No obvious dependence on a single abnormal trade
Both BUY and SELL behaviour understood
```

The exact thresholds may depend on the experiment and must be documented when used.

Candidates should not be selected solely because they appear at the top of the optimization table.

---

## 19. Stage 7 — Forward / Out-of-Sample Validation

Optimization uses historical data to search parameter combinations.

This creates a risk that a parameter set fits the optimization period unusually well without representing a persistent market relationship.

Therefore promising candidates require additional validation.

The intended workflow is:

```text
Historical Data
      │
      ├── Optimization / In-Sample
      │
      └── Forward / Out-of-Sample
```

The candidate is developed using the optimization portion.

Its behaviour is then evaluated on data not used to select the parameters.

---

## 20. Forward Test Objective

Forward testing asks:

> Does the candidate retain useful behaviour when evaluated outside the data used to select its parameters?

Relevant comparisons include:

```text
Profit Factor
Expected Payoff
Drawdown
Trade count
Win rate
Equity behaviour
BUY / SELL behaviour
```

A large collapse between optimization and forward performance is a warning sign.

---

## 21. Stage 8 — Robustness Assessment

A strategy should not be considered robust because it passes one forward period.

Where data permits, additional checks may include:

```text
Different time periods
Different market regimes
Parameter perturbation
Spread sensitivity
Execution sensitivity
BUY / SELL decomposition
Trade concentration
Outlier dependence
```

These checks are performed only when relevant to the research stage.

The methodology does not require unnecessary complexity before the simpler tests have produced useful evidence.

---

## 22. Parameter Perturbation

A useful robustness question is:

> Does the strategy still behave reasonably if the selected parameters are changed slightly?

For a candidate parameter:

```text
P
```

neighboring configurations such as:

```text
P - step
P
P + step
```

can be compared.

A strategy that collapses after very small parameter changes requires additional scrutiny.

---

## 23. Trade Count

Trade count matters because performance statistics based on very few observations can be unstable.

The number of trades must always be reported with performance results.

A candidate should not be promoted solely because it produces attractive metrics from a very small sample.

No universal minimum trade count is imposed by this methodology.

The required evidence depends on:

```text
strategy frequency
test duration
timeframe
market behaviour
research objective
```

---

## 24. Drawdown

Drawdown is treated as a primary research metric.

A strategy can be profitable and still fail research requirements because its drawdown is unacceptable.

The repository should distinguish between:

```text
Profitability
```

and:

```text
Risk viability
```

Both must be evaluated.

---

## 25. BUY and SELL Analysis

Unless the strategy hypothesis explicitly defines a one-direction system, BUY and SELL logic should both be tested.

Directional statistics should be examined separately.

For example:

```text
BUY trades
BUY win rate

SELL trades
SELL win rate
```

A weaker direction is not automatically removed.

Removing one side changes the strategy and therefore requires evidence and a new research justification.

---

## 26. Equity Curve Analysis

Summary metrics do not fully describe strategy behaviour.

The equity or balance curve should also be inspected.

Relevant patterns include:

```text
Persistent growth
Long stagnation
Large isolated jumps
Persistent decline
Sudden regime failure
Dependence on a small number of trades
```

Visual evidence should be retained when available.

---

## 27. MFE / MAE

Maximum Favorable Excursion and Maximum Adverse Excursion may be used as diagnostic information.

They can help investigate:

```text
whether profitable trades have additional unused movement;
whether losing trades move strongly against the entry;
whether exit distances appear structurally mismatched;
whether trade management deserves further investigation.
```

MFE / MAE relationships do not by themselves establish a profitable edge.

---

## 28. Research Decision

After sufficient evidence exists, an experiment may receive one of the following research outcomes:

```text
CONTINUE
MODIFY
REJECT
VALIDATION CANDIDATE
```

### CONTINUE

Evidence is promising enough to justify the next research stage.

### MODIFY

The hypothesis remains interesting, but implementation or rules require a documented structural change.

### REJECT

Available evidence does not justify additional research under the tested formulation.

### VALIDATION CANDIDATE

Optimization and preliminary testing have produced a candidate worthy of independent validation.

These states describe research progress.

They are not guarantees of future profitability.

---

## 29. No Silent Strategy Changes

Any meaningful change to strategy logic must be documented.

Examples:

```text
Adding an entry filter
Removing SELL
Changing breakout definition
Adding session filters
Changing exit logic
Changing position sizing methodology
```

A modified strategy should not silently replace the original experiment.

The repository must preserve enough history to understand how the strategy evolved.

---

## 30. Evidence Hierarchy

Research conclusions should be based on retained evidence.

Preferred hierarchy:

```text
1. EA source code
2. Original MT5 reports
3. Optimization reports
4. Forward-test reports
5. Supporting MT5 graphs
6. Repository README summaries
7. Research interpretation
```

Documentation summarizes evidence.

It does not replace the underlying artifacts.

---

## 31. Reproducibility Checklist

Before treating a test as documented, verify that the following can be determined:

```text
[ ] Which EA was tested?
[ ] Which source version was used?
[ ] Which symbol was tested?
[ ] Which timeframe was used?
[ ] Which historical period was used?
[ ] What was the initial capital?
[ ] What leverage was used?
[ ] What input parameters were used?
[ ] What data quality was used?
[ ] How many trades occurred?
[ ] What were the principal performance metrics?
[ ] Is the original test report retained?
[ ] Is the research conclusion documented?
```

If critical information is missing, the result should not be treated as fully reproducible.

---

## 32. Research Workflow

The standard workflow for every EA is:

```text
┌─────────────────────────────┐
│ 1. Trading Hypothesis       │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│ 2. Explicit Trading Rules   │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│ 3. MT5 EA Implementation    │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│ 4. Baseline Backtest        │
└──────────────┬──────────────┘
               ↓
        ┌──────┴──────┐
        │             │
        ↓             ↓
  Baseline PASS   Baseline FAIL
        │             │
        └──────┬──────┘
               ↓
┌─────────────────────────────┐
│ 5. Parameter Research       │
│    / Optimization           │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│ 6. Candidate Selection      │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│ 7. Forward / OOS Test       │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│ 8. Robustness Assessment    │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│ 9. Research Decision        │
└─────────────────────────────┘
```

---

## 33. Current EA-063 Position

At the time of this methodology record:

```text
EA-063_Close_Location_Break

Hypothesis Defined:       YES
Rules Defined:            YES
EA Implemented:           YES
Baseline Completed:       YES
Baseline Data:            100% real ticks
Baseline Trades:          269
Baseline Result:          FAIL
Optimization:             PENDING
Forward Validation:       NOT STARTED
Final Research Decision:  NOT AVAILABLE
Deployment Ready:         NO
```

EA-063 therefore remains a research experiment.

Its failed baseline is preserved rather than hidden or replaced.

The next evidence required for EA-063 is the optimization result.

---

## 34. Repository Standard

Every EA added to this repository should follow the same fundamental chain:

```text
HYPOTHESIS
    ↓
CODE
    ↓
BASELINE
    ↓
EVIDENCE
    ↓
OPTIMIZATION
    ↓
VALIDATION
    ↓
DECISION
```

No stage should claim evidence that has not yet been produced.

No failed result should be silently removed.

No optimized result should replace its baseline.

No strategy should be considered validated solely because historical optimization finds a profitable parameter combination.

The repository exists to preserve the complete research process — including hypotheses, code, evidence, failures, improvements and validated findings.
