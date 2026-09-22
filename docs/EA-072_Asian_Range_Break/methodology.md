# Research Methodology

## EA-072 — Asian Range Break

## 1. Purpose

This document defines the research, implementation, backtesting, optimization, and validation methodology used for:

**EA-072_Asian_Range_Break**

The objective is to maintain a reproducible research process in which strategy ideas, source code, test configurations, and results can be traced and independently reviewed.

The methodology is designed to reduce:

- hindsight bias;
- parameter overfitting;
- selective reporting;
- accidental strategy changes between tests;
- confusion between research results and validated results.

A profitable backtest alone is not considered sufficient evidence that a strategy possesses a persistent trading edge.

---

## 2. Repository Evidence Structure

EA-072 is separated into three evidence layers:

```text
/EAs/EA-072_Asian_Range_Break/
        ↓
Strategy implementation

/Backtest/EA-072_Asian_Range_Break/
        ↓
Raw MT5 test evidence

/Research/
        ↓
Research hypotheses and interpretation
```

The methodology governing these layers is stored in:

```text
/docs/methodology.md
```

Each layer has a different purpose and should not replace another.

---

## 3. Source of Truth

The MQL5 source code is the authoritative definition of the implemented trading logic.

For EA-072:

```text
/EAs/EA-072_Asian_Range_Break/
EA-072_Asian_Range_Break.mq5
```

Documentation describes the implementation but does not override it.

If documentation and executable behavior disagree:

```text
SOURCE CODE
takes precedence
```

and the documentation must be corrected.

Backtest reports are the authoritative evidence for historical test results.

Performance statistics must not be manually reconstructed when the original MetaTrader 5 report is available.

---

## 4. Strategy Under Test

EA-072 implements an Asian-session range breakout concept.

Baseline structure:

```text
Asian Range Formation
        ↓
Determine High / Low
        ↓
Range closes
        ↓
Monitor completed M1 candles
        ↓
Break above High
or
Break below Low
        ↓
Entry
        ↓
SL / TP
        ↓
Break Even / Trailing management
```

The baseline session configuration is:

```text
Range Start    = 00:00
Range End      = 08:00
Trade End      = 16:00
```

These times represent broker/server time.

They must not automatically be interpreted as UTC or local geographical session times.

---

## 5. Baseline Definition

Before optimization, a fixed baseline must be established.

The current EA-072 baseline configuration is:

```text
InpLotSize             = 0.01

InpStopLoss            = 300
InpTakeProfit          = 600

InpMagicNumber         = 123072
InpSlippage            = 10
InpMaxSpread           = 30

InpTimeframe           = M1
InpBreakoutLookback    = 20
InpBreakoutBuffer      = 0

InpUseBreakEven        = true
InpBreakEvenTrigger    = 150
InpBreakEvenOffset     = 0

InpUseTrailingStop     = true
InpTrailingStart       = 200
InpTrailingDistance    = 100
InpTrailingStep        = 10

InpRangeStartHour      = 0
InpRangeEndHour        = 8
InpTradeEndHour        = 16
```

The baseline acts as the control configuration for subsequent experiments.

---

## 6. Baseline Backtest

The current baseline test uses:

```text
Expert:
EA-072_Asian_Range_Break

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-03-31

Initial Deposit:
$1,000

Leverage:
1:500

History Quality:
100% real ticks

Broker:
ACCM Intl Limited
```

The baseline produced:

```text
Total Trades          = 265

Net Profit            = -$50.08
Profit Factor         = 0.86
Expected Payoff       = -$0.19

Winning Trades        = 47.55%
Losing Trades         = 52.45%

Balance DD Max        = 9.68%
Equity DD Max         = 9.92%
```

Therefore:

```text
BASELINE PROFITABILITY
NOT CONFIRMED
```

This result remains valid research evidence even though it is negative.

---

## 7. Research Workflow

EA-072 should follow the research pipeline:

```text
Strategy Hypothesis
        ↓
Formal Trading Rules
        ↓
MQL5 Implementation
        ↓
Code Verification
        ↓
Baseline Backtest
        ↓
Baseline Analysis
        ↓
Controlled Experiments
        ↓
Parameter Optimization
        ↓
Robustness Analysis
        ↓
Out-of-Sample Validation
        ↓
Walk-Forward Validation
        ↓
Execution Sensitivity
        ↓
Forward Testing
```

A stage should not be considered validated merely because a later stage produces a profitable result.

---

## 8. Hypothesis-Driven Development

Every material strategy modification should answer a specific research question.

Example:

```text
Observation:

EA-072 generates repeated breakout attempts
after previous trades close.

Hypothesis:

Repeated attempts may contribute
disproportionately to losses.

Experiment:

Baseline
vs.
First breakout only
```

The experiment changes only the feature required to test the hypothesis.

Avoid:

```text
change entry
+
change SL
+
change TP
+
change session
+
change trailing
```

in one experiment.

If several variables change simultaneously, the cause of any performance change becomes difficult to identify.

---

## 9. Controlled Experiment Rule

For structural strategy research:

```text
ONE PRIMARY HYPOTHESIS
        ↓
ONE CONTROLLED CHANGE
        ↓
BACKTEST
        ↓
COMPARE
        ↓
ACCEPT / REJECT / INCONCLUSIVE
```

The baseline remains unchanged unless a modification is explicitly promoted to a new strategy version.

---

## 10. Experiment Comparison

At minimum, each experiment should compare:

| Metric | Purpose |
|---|---|
| Total Trades | Sample size |
| Net Profit | Absolute result |
| Profit Factor | Profit/loss efficiency |
| Expected Payoff | Average expectancy |
| Win Rate | Outcome distribution |
| Average Win | Reward behavior |
| Average Loss | Loss behavior |
| Maximum Drawdown | Risk |
| Long Performance | Directional behavior |
| Short Performance | Directional behavior |
| Consecutive Losses | Loss clustering |

No single metric determines whether a modification is valid.

---

## 11. Entry Research Before Exit Optimization

The baseline Profit Factor is:

```text
0.86
```

Therefore entry quality must remain an important research target.

Aggressive optimization of:

```text
Stop Loss
Take Profit
Break Even
Trailing Stop
```

before understanding entry behavior can create a historically optimized exit structure around weak signals.

Preferred sequence:

```text
ENTRY STRUCTURE
        ↓
SESSION STRUCTURE
        ↓
BREAKOUT QUALITY
        ↓
VOLATILITY FILTER
        ↓
EXIT STRUCTURE
        ↓
RISK PARAMETERS
```

---

## 12. Primary Structural Experiments

The following variables should initially be treated as research hypotheses rather than automatically optimized together.

### First Breakout

Compare:

```text
Multiple breakout attempts
vs.
First breakout only
```

---

### Direction

Compare:

```text
Long + Short

Long only

Short only
```

---

### Breakout Time

Segment entries by time after completion of the Asian range.

Example:

```text
08:00–09:59
10:00–11:59
12:00–13:59
14:00–15:59
```

---

### Asian Range Size

Measure:

```text
Asian High - Asian Low
```

Potentially normalize using volatility:

```text
Asian Range
───────────
ATR
```

---

### Breakout Strength

Baseline:

```text
Breakout Buffer = 0
```

Research whether breakout displacement influences subsequent continuation.

---

### Volatility

Evaluate strategy behavior under different volatility conditions.

A volatility measure such as ATR may be used to normalize market conditions.

---

## 13. Exit Research

Once entry behavior is better understood, exit components should be isolated.

Current baseline:

```text
SL = 300
TP = 600

Break Even = ON

Trailing Stop = ON
```

Required comparisons include:

```text
Fixed SL/TP
        ↓
Fixed SL/TP + Break Even
        ↓
Fixed SL/TP + Trailing
        ↓
Fixed SL/TP + Break Even + Trailing
```

This identifies whether performance originates primarily from the entry signal or from trade management.

---

## 14. MFE / MAE Analysis

EA-072's baseline report contains Maximum Favorable Excursion and Maximum Adverse Excursion information.

Current correlations:

```text
Profit ↔ MFE = 0.96

Profit ↔ MAE = 0.71

MFE ↔ MAE = 0.6159
```

MFE and MAE should be used as diagnostic evidence when studying exits.

They should not be treated as predictive indicators without independent testing.

Potential questions include:

```text
How far do winning trades normally move?

How much adverse excursion occurs
before profitable continuation?

Does Break Even activate too early?

Does trailing stop truncate large winners?

Is the fixed TP located beyond
the typical favorable excursion?
```

---

## 15. Holding-Time Analysis

Baseline holding statistics:

```text
Minimum:
00:00:01

Average:
00:01:29

Maximum:
00:17:55
```

This indicates that the tested EA behaves as a short-duration trading system.

Therefore realistic execution assumptions are particularly important.

Research must consider:

```text
spread
slippage
tick quality
stop level
freeze level
execution latency
broker specifications
```

---

## 16. Optimization Methodology

Optimization should not begin by searching the entire parameter space.

Use staged optimization.

### Stage A — Structural Variables

Examples:

```text
First breakout only
Trading direction
Session cutoff
Breakout confirmation
```

### Stage B — Entry Parameters

Examples:

```text
Breakout Buffer
Range constraints
Volatility thresholds
```

### Stage C — Exit Parameters

Examples:

```text
Stop Loss
Take Profit
Break Even
Trailing Stop
```

### Stage D — Risk Parameters

Position sizing should be evaluated after the underlying strategy behavior has been established.

Changing lot size does not create trading edge.

---

## 17. Parameter Search

When optimization is performed, record:

```text
Parameter
Start
Step
Stop
Optimization criterion
Test period
Symbol
Timeframe
Broker
EA version
```

Example:

```text
Parameter:
Breakout Buffer

Start:
0

Step:
TBD

Stop:
TBD
```

Do not silently alter optimization ranges after observing results.

If ranges are changed, record the new optimization as a separate experiment.

---

## 18. Optimization Selection

Do not automatically select:

```text
Maximum Net Profit
```

as the final parameter set.

Preference should be given to parameter regions where nearby configurations produce similar behavior.

Conceptually:

```text
Weak robustness

loss
loss
loss
HUGE PROFIT
loss
loss


Better robustness

profit
profit
profit
profit
profit
profit
```

A single isolated optimum is more susceptible to historical overfitting than a stable parameter region.

---

## 19. In-Sample and Out-of-Sample

Optimization data and validation data must eventually be separated.

Concept:

```text
Historical Dataset
│
├── In-Sample
│      ↓
│   Research
│   Optimization
│
└── Out-of-Sample
       ↓
    Validation only
```

Out-of-sample data should not repeatedly influence parameter selection.

Otherwise it effectively becomes part of the optimization dataset.

---

## 20. Walk-Forward Validation

After identifying a candidate strategy configuration, use sequential historical windows.

Example structure:

```text
Window 1

Train
───────
Test
───


Window 2

    Train
    ───────
    Test
    ───


Window 3

        Train
        ───────
        Test
        ───
```

The objective is to evaluate whether the strategy can maintain useful behavior as market conditions change.

---

## 21. Market-Regime Testing

A strategy should not be evaluated solely on one favorable period.

Tests should eventually include different environments:

```text
Trending

Range-bound

High volatility

Low volatility

Bullish gold regime

Bearish gold regime

Event-heavy periods

Normal periods
```

The objective is not to require profitability in every regime.

The objective is to understand:

```text
WHERE
WHEN
WHY
```

the strategy succeeds or fails.

---

## 22. Execution Sensitivity

Because EA-072 has short average holding times, execution sensitivity should be explicitly tested.

Possible stress tests:

```text
Higher spread

Higher slippage

Different broker specifications

Different XAUUSD symbol specification

Different server timezone
```

A strategy whose edge disappears after a small deterioration in execution conditions should not be considered robust without further evidence.

---

## 23. Broker-Time Sensitivity

The strategy depends directly on:

```text
Range Start
Range End
Trade End
```

Therefore server timezone is a structural variable.

For every test, record:

```text
Broker
Server timezone if known
Symbol
Session configuration
```

A configuration such as:

```text
00:00 → 08:00
```

must not be assumed to represent the same real-world market hours across different brokers.

---

## 24. Data Quality

Backtests intended as primary evidence should use the highest practical historical data quality.

The current baseline reports:

```text
History Quality:
100% real ticks
```

For every backtest preserve:

```text
MT5 HTML report
Balance chart
Entry distribution chart
MFE / MAE chart
Holding-time chart
```

The raw report should be retained even if the result is poor.

---

## 25. Reproducibility Requirements

A backtest is considered reproducible only when another researcher can determine:

```text
EA version
Source code
Symbol
Timeframe
Historical period
Broker
Initial deposit
Leverage
Input parameters
Data quality
Result
```

Whenever possible, preserve the original MetaTrader report instead of copying only summary statistics.

---

## 26. Version Control

A material strategy change should create a traceable version.

Examples:

```text
EA-072 baseline

EA-072 first-breakout experiment

EA-072 volatility-filter experiment

EA-072 validated candidate
```

Do not overwrite evidence from earlier experiments.

The purpose of versioning is to preserve the research path:

```text
Idea
↓
Experiment
↓
Result
↓
Decision
```

---

## 27. Failed Experiments

Failed experiments must be retained.

Examples:

```text
Negative Net Profit

Profit Factor < 1

Higher Drawdown

Unstable parameters

Good In-Sample
but
Poor Out-of-Sample
```

These results remain valuable because they prevent repeated testing of previously rejected hypotheses.

Negative results must not be deleted merely to make repository performance appear better.

---

## 28. Result Classification

Use the following research states:

```text
NOT TESTED

TESTED

INCONCLUSIVE

REJECTED

CANDIDATE

VALIDATION IN PROGRESS

VALIDATED
```

`VALIDATED` should not be assigned solely because an optimization run is profitable.

---

## 29. Current EA-072 Status

At the current stage:

```text
Strategy Specification:
COMPLETED

MQL5 Implementation:
COMPLETED

Baseline Backtest:
COMPLETED

Baseline Profitability:
NOT CONFIRMED

Structural Research:
IN PROGRESS

Optimization:
NOT VALIDATED

Out-of-Sample:
NOT TESTED

Walk-Forward:
NOT TESTED

Execution Stress Test:
NOT TESTED

Forward Test:
NOT TESTED
```

EA-072 must therefore remain classified as:

```text
RESEARCH STRATEGY
```

rather than a validated production strategy.

---

## 30. Evidence Chain

The repository should allow the complete research chain to be reconstructed:

```text
Research Hypothesis
        │
        ▼
Research/README.md
        │
        ▼
Trading Rules
        │
        ▼
EAs/EA-072_Asian_Range_Break/
        │
        ▼
EA-072_Asian_Range_Break.mq5
        │
        ▼
MetaTrader 5 Strategy Tester
        │
        ▼
Backtest/EA-072_Asian_Range_Break/
        │
        ▼
Raw Report + Charts
        │
        ▼
Result Analysis
        │
        ▼
Next Hypothesis
```

This evidence chain is more important than presenting only the best-performing result.

---

## 31. Current Next Experiment

The next controlled structural experiment is:

```text
CONTROL
EA-072 Baseline

Multiple breakout attempts allowed
```

versus:

```text
EXPERIMENT
EA-072 First Breakout Only

Maximum one breakout entry
per trading day
```

Keep unchanged:

```text
Symbol
Timeframe
Test period
Lot size
SL
TP
Break Even
Trailing Stop
Range hours
Trade end hour
Broker environment
```

Primary comparison metrics:

```text
Total Trades
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Average Win
Average Loss
Consecutive Losses
```

The purpose is to isolate whether repeated breakout attempts are contributing materially to the negative baseline expectancy.

---

## 32. Methodology Principle

The project follows one central rule:

> Strategy development is an evidence chain, not a search for the most attractive backtest.

Every change must remain traceable from:

```text
Hypothesis
→ Code
→ Test
→ Evidence
→ Decision
```

This methodology should remain consistent throughout the development of EA-072.
