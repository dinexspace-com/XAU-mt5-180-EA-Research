## 9. Controlled Research Before Optimization

Broad parameter optimization must not automatically begin after a baseline test fails.

When an EA introduces a new strategy component, the contribution of that component should first be isolated through a controlled experiment.

Examples:

```text
Breakout Only
      vs
Breakout + EMA Filter
```

or:

```text
Breakout Only
      vs
Breakout + RSI Filter
```

The objective is to determine whether the defining strategy component provides measurable improvement before searching for its optimal parameters.

The preferred workflow is:

```text
Baseline
    ↓
Identify Main Research Question
    ↓
Controlled A/B Experiment
    ↓
Evaluate Evidence
    ↓
Investigate Individual Components
    ↓
Controlled Parameter Research
    ↓
Optimization
```

This prevents optimization from hiding a weak strategy hypothesis behind a historically fitted parameter combination.

---

## 10. Research Question Identification

Each major experiment should have a unique research-question identifier.

Recommended convention:

```text
EA<NUMBER>-RQ<NUMBER>
```

Examples:

```text
EA067-RQ01
EA068-RQ01
EA068-RQ02
```

Each research question should define:

```text
Question
Hypothesis
Control Configuration
Experimental Configuration
Variables Held Constant
Variable Being Tested
Test Period
Required Metrics
Result
Conclusion
```

Only one major conceptual variable should be changed at a time whenever practical.

---

## 11. Controlled Experiment Design

A controlled experiment compares configurations while minimizing unrelated differences.

Example:

```text
Configuration A
Breakout Only

Configuration B
Breakout + RSI Filter
```

If the purpose is to evaluate RSI contribution, the following should remain unchanged where technically possible:

```text
Symbol
Timeframe
Historical Period
Breakout Logic
Breakout Lookback
Breakout Buffer
Lot Size
Stop Loss
Take Profit
Break Even
Trailing Stop
Spread Assumptions
Execution Environment
```

The principal intended difference should be:

```text
RSI Filter
OFF
vs
ON
```

This allows the resulting performance difference to be associated more clearly with the component being investigated.

---

## 12. Experimental Evidence

Every controlled experiment should preserve both the control and experimental results.

Recommended structure:

```text
Backtest/
└── EA-XXX_Strategy_Name/
    │
    ├── Baseline-01/
    │
    ├── RQ01-Control/
    │
    ├── RQ01-Experiment/
    │
    ├── RQ02-Control/
    │
    └── RQ02-Experiment/
```

Each test package should preserve its original Strategy Tester artifacts.

For MT5 HTML reports, referenced PNG files should remain in the same directory as the HTML file unless the HTML references are intentionally updated.

Example:

```text
RQ01-Experiment/
├── ReportTester.html
├── ReportTester.png
├── ReportTester-hst.png
├── ReportTester-mfemae.png
└── ReportTester-holding.png
```

The original evidence must not be overwritten when a later experiment is performed.

---

## 13. Comparison Metrics

Controlled experiments should compare more than Net Profit.

At minimum:

| Category | Metrics |
|---|---|
| Profitability | Net Profit, Gross Profit, Gross Loss |
| Expectancy | Profit Factor, Expected Payoff |
| Risk | Balance Drawdown, Equity Drawdown |
| Recovery | Recovery Factor |
| Activity | Total Trades |
| Outcomes | Win Rate, Average Win, Average Loss |
| Direction | BUY and SELL statistics |
| Stability | Sharpe Ratio where available |
| Behaviour | Holding Time, MFE, MAE where relevant |

The purpose is to determine **how** a strategy component changes behaviour, not merely whether final profit increased.

---

## 14. Directional Research

BUY and SELL results should be recorded separately whenever the Strategy Tester provides directional statistics.

Example:

```text
BUY
Trades
Win Rate

SELL
Trades
Win Rate
```

If material asymmetry is observed, a controlled directional experiment may be justified:

```text
BUY + SELL
vs
BUY Only
vs
SELL Only
```

An observed directional difference is a research signal.

It is not, by itself, evidence that the stronger direction is profitable or should be deployed independently.

---

## 15. Timeframe Research

A baseline result applies only to the tested timeframe.

For short-timeframe XAUUSD research, candidate comparisons may include:

```text
M1
M5
M15
```

When testing timeframe contribution, strategy logic and other major parameters should initially remain controlled where practical.

The research question is not:

```text
Which timeframe made the most money?
```

The research question is:

```text
Does strategy behaviour remain stable
when market sampling frequency changes?
```

---

## 16. Parameter Research

Individual parameters should normally be investigated before broad multi-parameter optimization.

For example:

```text
Breakout Lookback

RSI Period

RSI Threshold

EMA Period

Breakout Buffer

Stop Loss

Take Profit
```

Parameter research should inspect a region rather than a single isolated value.

Example:

```text
RSI Period

7
10
14
18
21
```

The purpose is to determine whether behaviour changes gradually and whether a stable region exists.

---

## 17. Filter Contribution Testing

Indicator-based filters must not be assumed to improve a strategy simply because they reduce the number of trades.

A filter can:

```text
Remove weak trades
Remove profitable trades
Change directional exposure
Change trade frequency
Change market-regime exposure
```

Therefore a filter should be evaluated by comparing the filtered strategy with the corresponding unfiltered strategy.

Examples:

```text
Breakout
vs
Breakout + EMA
```

```text
Breakout
vs
Breakout + RSI
```

Relevant comparison metrics include:

```text
Trade Count
Net Profit
Profit Factor
Expected Payoff
Drawdown
Win Rate
Average Win
Average Loss
BUY Performance
SELL Performance
```

A lower trade count alone is not evidence of improved signal quality.

---

## 18. Exit-System Isolation

Entry research and exit research should be separated whenever practical.

If a baseline simultaneously uses:

```text
Stop Loss
Take Profit
Break Even
Trailing Stop
```

poor performance cannot automatically be attributed to the entry signal.

A controlled exit study may compare:

```text
A
Fixed SL / TP

B
SL / TP + Break Even

C
SL / TP + Trailing Stop

D
SL / TP + Break Even + Trailing Stop
```

Entry logic should remain unchanged during this experiment.

This helps distinguish:

```text
Entry Edge
```

from:

```text
Exit Management Effect
```

---

## 19. MFE / MAE Analysis

Where available, Maximum Favorable Excursion and Maximum Adverse Excursion should be retained as research evidence.

MFE can help investigate:

```text
How far trades move favorably
before they are closed
```

MAE can help investigate:

```text
How far trades move adversely
before final outcome
```

Useful research questions include:

```text
Are profitable excursions being captured?

Does Break Even activate too early?

Does Trailing Stop return too much open profit?

Is Stop Loss placement consistent with observed MAE?

Is Take Profit restricting favorable excursion?
```

MFE/MAE correlations and charts are diagnostic evidence.

They must not be treated as standalone instructions for changing parameters.

---

## 20. Holding-Time Analysis

Position holding time should be recorded when available.

At minimum:

```text
Minimum Holding Time
Maximum Holding Time
Average Holding Time
```

Holding-time behaviour can reveal whether the implemented EA behaves as originally hypothesized.

For example, a strategy described as a breakout continuation system but consistently holding positions for only a few minutes may require investigation into:

```text
Entry Timing
Break Even
Trailing Stop
Stop Loss
Market Noise
```

This is a research observation, not automatically a defect.

---

## 21. Session Research

Entry and profit/loss distributions by hour, weekday, and month should be retained when available.

These distributions may reveal candidate research questions.

However, historical weak periods must not simply be removed retrospectively.

Instead:

```text
Observation
    ↓
Define Session Hypothesis
    ↓
Create Controlled Test
    ↓
Evaluate New Evidence
```

This reduces the risk of constructing session filters solely around historical noise.

---

## 22. Optimization Gate

Broad optimization is permitted only after the important strategy components have been sufficiently investigated.

Before broad optimization, researchers should be able to answer:

```text
What component is being optimized?

Why is it included?

What evidence supports keeping it?

What parameter region is reasonable?

What metrics determine candidate quality?
```

If these questions cannot yet be answered:

```text
Optimization Status:
BLOCKED
```

This status does not mean development has failed.

It means controlled research is still required.

---

## 23. Optimization Search

Once the optimization gate is passed, parameter ranges and steps should be declared before reviewing the final optimization result.

Example:

```text
Parameter
Start
Step
Stop
```

Optimization should search for:

```text
Stable Parameter Regions
```

rather than only:

```text
Maximum Historical Profit
```

A desirable pattern is:

```text
Good
Good
Good
Selected
Good
Good
```

rather than:

```text
Poor
Poor
Exceptional
Poor
Poor
```

An isolated optimization peak should be treated cautiously.

---

## 24. Candidate Freeze

Once a candidate is selected for independent validation, its parameters should be frozen.

Record:

```text
EA Version
Source Commit
Parameter Set
Selection Evidence
Selection Date
```

After freezing:

```text
NO PARAMETER CHANGES
```

should be made using the designated Out-of-Sample data.

If parameters are changed after reviewing validation results, the candidate returns to the research stage.

---

## 25. Out-of-Sample Validation

Out-of-Sample data should not participate in selecting the candidate being evaluated.

Workflow:

```text
Research Data
      ↓
Parameter Research
      ↓
Optimization
      ↓
Candidate Selection
      ↓
FREEZE
      ↓
Out-of-Sample Data
      ↓
Independent Result
```

The Out-of-Sample result must be preserved even if it fails.

A failed validation must not be replaced by a newly optimized result using the same validation period.

---

## 26. Temporal Validation

Aggregate results should be decomposed across smaller time periods where appropriate.

For example:

```text
January
February
March
```

The objective is to determine whether performance is:

```text
Persistent
Concentrated
Regime-dependent
Unstable
```

A strategy whose total profit depends primarily on one short historical period requires additional investigation.

---

## 27. Robustness Gate

A candidate that survives Out-of-Sample testing should proceed to robustness testing.

Recommended categories:

```text
Parameter Robustness
Time Robustness
Trading-Cost Robustness
Data Robustness
Execution Robustness
```

The objective is not to prove that future performance is guaranteed.

The objective is to identify configurations that collapse under small realistic changes.

---

## 28. Forward Testing Gate

Only candidates that have completed the required historical validation stages should proceed to forward testing.

Recommended progression:

```text
Research
    ↓
Baseline
    ↓
Controlled Experiments
    ↓
Optimization
    ↓
Candidate Freeze
    ↓
Out-of-Sample
    ↓
Robustness
    ↓
Forward / Demo
```

Forward testing provides additional evidence under data and execution conditions not used during historical parameter selection.

---

## 29. Human Approval

Automated analysis may calculate metrics, compare experiments, detect inconsistencies, and prepare evidence.

However, final approval status must not be assigned solely by an automated process.

Recommended states:

```text
RESEARCH
CANDIDATE
UNDER REVIEW
APPROVED
REJECTED
```

`APPROVED` requires explicit reviewer approval after the required evidence has been examined.

A profitable Strategy Tester result alone does not grant approval.

---

## 30. Research Integrity Rule

The repository must preserve both successful and unsuccessful experiments.

Do not:

```text
Delete failed baselines
Overwrite negative reports
Hide weak months
Select only profitable optimization passes
Change acceptance criteria after seeing results
Reuse Out-of-Sample data as untouched validation
```

Instead:

```text
Preserve
Document
Compare
Learn
Retest
```

The research history is part of the evidence.

---

## 31. Methodology Summary

The standard research pipeline is:

```text
IDEA
  ↓
HYPOTHESIS
  ↓
IMPLEMENTATION
  ↓
BASELINE
  ↓
CONTROLLED RESEARCH
  ↓
COMPONENT VALIDATION
  ↓
PARAMETER RESEARCH
  ↓
OPTIMIZATION
  ↓
CANDIDATE SELECTION
  ↓
CANDIDATE FREEZE
  ↓
OUT-OF-SAMPLE
  ↓
TEMPORAL VALIDATION
  ↓
ROBUSTNESS
  ↓
FORWARD TEST
  ↓
HUMAN REVIEW
```

The central principle is:

> **Do not optimize a component before establishing why that component belongs in the strategy.**

Every stage should produce evidence that can be independently reviewed and reproduced.
