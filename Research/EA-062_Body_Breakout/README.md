# XAUUSD MT5 EA Research

## Overview

This directory contains the research layer of the **XAUUSD MT5 EA Research** repository.

The objective is to investigate trading hypotheses systematically before modifying, optimizing, or promoting an Expert Advisor.

The research process follows a simple principle:

> Hypothesis → Implementation → Baseline Backtest → Evidence → Research Question → Controlled Experiment → Validation

A strategy is not considered valid simply because it can be coded or produces individual profitable trades.

Every conclusion must be supported by reproducible evidence.

---

# Research Principles

## 1. Baseline First

Every EA must first have a fixed baseline configuration.

The baseline establishes the reference point against which future experiments are compared.

Example:

```text
EA-062_Body_Breakout
        ↓
EA062-M1-BASELINE-001
        ↓
Research Questions
        ↓
Controlled Experiments
```

The baseline must not be overwritten after research begins.

---

## 2. One Major Variable at a Time

Experiments should isolate individual strategy components whenever practical.

Example:

```text
Baseline

Timeframe = M1
Body Ratio = 0.70
Lookback = 20
```

A timeframe experiment may test:

```text
M1
M5
M15
```

while keeping the remaining strategy logic unchanged.

Changing timeframe, Body Ratio, Lookback, SL, TP and trading session simultaneously would make it difficult to determine which variable caused the result.

---

## 3. Evidence Before Conclusion

Research conclusions must be based on measurable evidence.

Important metrics include:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Average Winner
Average Loser
Recovery Factor
Sharpe Ratio
Trade Count
MFE
MAE
Holding Time
```

No strategy component should be accepted only because:

```text
"It looks better on the chart."
```

---

## 4. Failed Experiments Are Retained

Failed experiments are research evidence.

They must not be deleted simply because the strategy lost money.

A failed experiment may reveal:

```text
Weak entry logic
Poor payoff structure
Excessive drawdown
Session dependency
Directional asymmetry
Market-regime dependency
Overtrading
Exit-management problems
```

Therefore:

```text
FAIL ≠ useless experiment
```

A properly documented failure reduces the chance of repeating the same research path later.

---

# Current Research Subject

## EA-062 — Body Breakout

Current EA:

```text
EA-062_Body_Breakout
```

Core research hypothesis:

> Can a breakout accompanied by a strong candle body relative to the candle's total range produce positive short-term directional expectancy on XAUUSD?

The initial implementation uses:

```text
Breakout
+
Candle Body Strength
+
Fixed SL / TP
+
Break Even
+
Trailing Stop
```

---

# Baseline Experiment

Experiment:

```text
EA062-M1-BASELINE-001
```

Baseline environment:

```text
Symbol         : XAUUSD.PRO
Timeframe      : M1
Period         : 2026-01-02 → 2026-03-31
History Quality: 100% real ticks
Initial Deposit: $100
Leverage       : 1:500
Lot Size       : 0.01
```

Core parameters:

```text
Breakout Lookback  = 20
Breakout Buffer    = 0
Minimum Body Ratio = 0.70

Stop Loss          = 300
Take Profit        = 600

Break Even         = ON
Trailing Stop      = ON
```

---

# Baseline Evidence

The first EA-062 baseline produced:

```text
Total Trades            : 577

Winning Trades          : 299
Losing Trades           : 278

Win Rate                : 51.82%

Total Net Profit        : -$93.30
Profit Factor           : 0.87
Expected Payoff         : -$0.16

Maximum Balance DD      : 94.36%
Maximum Equity DD       : 94.41%

Recovery Factor         : -0.83
Sharpe Ratio            : -5.00
```

Directional results:

```text
BUY Trades  : 318
BUY Win %   : 53.46%

SELL Trades : 259
SELL Win %  : 49.81%
```

Average trade outcomes:

```text
Average Winner : +$2.00
Average Loser  : -$2.49
```

Baseline verdict:

```text
FAIL
```

The baseline does not demonstrate acceptable profitability or risk characteristics.

---

# Important Observation

The strategy achieved:

```text
Win Rate = 51.82%
```

but remained unprofitable.

The realized payoff structure was:

```text
Average Winner = $2.00
Average Loser  = $2.49
```

Therefore:

```text
Win Rate > 50%
```

was not sufficient to generate positive expectancy.

This creates an important research direction:

> Determine whether the weakness comes primarily from entry quality, market conditions, directional behavior, or exit management.

---

# Research Questions

The baseline creates seven primary research questions.

---

## EA062-RQ01 — Timeframe

### Question

Does Body Breakout performance change materially across lower trading timeframes?

Candidate comparison:

```text
M1
M5
M15
```

### Variables Held Constant

Keep the strategy logic unchanged wherever possible:

```text
Body Ratio
Breakout logic
Risk configuration
Exit logic
```

### Objective

Determine whether M1 contains excessive noise for the Body Breakout hypothesis.

---

## EA062-RQ02 — Minimum Body Ratio

Current baseline:

```text
Minimum Body Ratio = 0.70
```

### Question

Does requiring a stronger candle body improve breakout quality?

Conceptually:

```text
Small body
    ↓
Potential weak breakout

Large body
    ↓
Potential stronger directional conviction
```

### Objective

Measure whether Body Ratio materially affects:

```text
Profit Factor
Expected Payoff
Trade Count
Drawdown
Win Rate
```

Candidate thresholds must be treated as experiments rather than assumed improvements.

---

## EA062-RQ03 — Breakout Lookback

Current baseline:

```text
Breakout Lookback = 20
```

### Question

Does breakout range length affect signal quality?

A shorter lookback may:

```text
Increase signal frequency
Increase market noise
```

A longer lookback may:

```text
Reduce trade frequency
Require stronger structural breakout
```

### Objective

Determine whether the baseline 20-bar breakout window is appropriate.

---

## EA062-RQ04 — Trading Session

XAUUSD behavior can vary substantially throughout the trading day.

### Question

Does EA-062 performance depend on trading session?

Research should separate performance by time window.

Example categories:

```text
Asia
Europe
US
```

### Metrics

Compare:

```text
Trade Count
Win Rate
Net Profit
Profit Factor
Expected Payoff
Drawdown
```

The objective is not to automatically remove a session.

The objective is to determine whether a statistically meaningful performance difference exists.

---

## EA062-RQ05 — Market Regime

### Question

Does Body Breakout work differently under different market conditions?

Candidate regimes:

```text
Trending
Ranging

High Volatility
Normal Volatility
Low Volatility
```

A breakout strategy may behave differently depending on market structure.

### Objective

Determine whether market-regime filtering is justified by evidence.

No regime filter should be added before this relationship is tested.

---

## EA062-RQ06 — Directional Asymmetry

Baseline:

```text
BUY Win Rate  = 53.46%
SELL Win Rate = 49.81%
```

Difference:

```text
3.65 percentage points
```

### Question

Does the strategy possess different expectancy for BUY and SELL signals?

Required comparison:

```text
BUY only
SELL only
BUY + SELL
```

### Important

The baseline difference alone is insufficient evidence to disable SELL trades.

Directional filtering requires a separate controlled experiment.

---

## EA062-RQ07 — Exit Management

Baseline configuration:

```text
SL = 300
TP = 600
```

Nominal initial Risk : Reward:

```text
1 : 2
```

However, realized outcomes were:

```text
Average Winner = +$2.00
Average Loser  = -$2.49
```

This suggests that actual trade management materially changes the realized payoff distribution.

Current management includes:

```text
Break Even
Trailing Stop
```

### Question

Does the current exit-management system reduce realized profitable excursions too aggressively?

Research variables may include:

```text
Break Even
Trailing Start
Trailing Distance
Trailing Step
SL
TP
```

These variables should not initially be optimized simultaneously.

---

# MFE / MAE Research

Baseline report:

```text
Correlation (Profit, MFE) = 0.95
Correlation (Profit, MAE) = 0.73
Correlation (MFE, MAE)    = 0.6073
```

MFE:

```text
Maximum Favorable Excursion
```

represents how far price moved favorably during a trade.

MAE:

```text
Maximum Adverse Excursion
```

represents how far price moved against the position.

The strong relationship between Profit and MFE makes trade-exit behavior an important future research subject.

However:

```text
Correlation ≠ trading rule
```

MFE/MAE observations must be validated before they are converted into exit logic.

---

# Holding-Time Research

Baseline:

```text
Minimum Holding Time : 00:00:04
Average Holding Time : 00:04:23
Maximum Holding Time : 02:08:02
```

The strategy therefore behaves primarily as a short-duration trading system.

This makes several factors potentially important:

```text
Spread
Execution
Market session
Volatility
Breakout timing
Exit timing
```

These factors may be investigated only when supported by a defined research question.

---

# Research Sequence

Research should proceed in controlled stages.

```text
EA062-M1-BASELINE-001
        │
        ▼
EA062-RQ01
TIMEFRAME
        │
        ▼
EA062-RQ02
BODY RATIO
        │
        ▼
EA062-RQ03
BREAKOUT LOOKBACK
        │
        ▼
EA062-RQ04
TRADING SESSION
        │
        ▼
EA062-RQ05
MARKET REGIME
        │
        ▼
EA062-RQ06
DIRECTION
        │
        ▼
EA062-RQ07
EXIT MANAGEMENT
        │
        ▼
LONGER HISTORICAL TEST
        │
        ▼
OUT-OF-SAMPLE TEST
        │
        ▼
ROBUSTNESS TEST
        │
        ▼
FORWARD TEST
```

This sequence may be adjusted when an earlier experiment produces evidence that invalidates a later research question.

---

# Experiment Naming Convention

Every controlled experiment should receive a unique ID.

Format:

```text
EA<NUMBER>-<RESEARCH>-<TEST>
```

Examples:

```text
EA062-M1-BASELINE-001

EA062-TF-M5-001
EA062-TF-M15-001

EA062-BODY-001
EA062-BODY-002

EA062-LOOKBACK-001

EA062-SESSION-ASIA-001
EA062-SESSION-EU-001
EA062-SESSION-US-001

EA062-DIRECTION-BUY-001
EA062-DIRECTION-SELL-001

EA062-EXIT-001
```

Experiment IDs should never be reused.

---

# Experiment Record

Every research experiment should record:

```text
Experiment ID
EA Version
Research Question
Hypothesis
Independent Variable
Controlled Variables
Symbol
Timeframe
Historical Period
Data Quality
Parameters
Trade Count
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Average Winner
Average Loser
Recovery Factor
Sharpe Ratio
Result
Evidence Location
Conclusion
```

---

# PASS / FAIL

A research experiment should not be marked PASS simply because:

```text
Net Profit > 0
```

The result must be evaluated relative to the research question.

Example:

```text
Question:
Does M5 improve performance relative to M1?

Baseline PF:
0.87

M5 PF:
1.02
```

This may indicate improvement, but it does not automatically prove that the strategy is robust or production-ready.

Therefore distinguish:

```text
EXPERIMENT PASS
```

from:

```text
STRATEGY VALIDATED
```

and:

```text
PRODUCTION READY
```

These are different states.

---

# Validation Hierarchy

Research maturity should progress through:

```text
LEVEL 0
Strategy Idea

        ↓

LEVEL 1
Implemented EA

        ↓

LEVEL 2
Baseline Backtest

        ↓

LEVEL 3
Controlled Research

        ↓

LEVEL 4
Improved Candidate

        ↓

LEVEL 5
Long Historical Backtest

        ↓

LEVEL 6
Out-of-Sample Validation

        ↓

LEVEL 7
Robustness Testing

        ↓

LEVEL 8
Forward Testing

        ↓

LEVEL 9
Candidate for Live Evaluation
```

No EA should skip directly from:

```text
Baseline Backtest
```

to:

```text
Live Trading
```

---

# Overfitting Control

Research must distinguish between:

```text
Research
```

and:

```text
Parameter Optimization
```

Repeatedly searching parameter combinations until a profitable backtest appears creates significant overfitting risk.

Avoid:

```text
Test hundreds of combinations
        ↓
Select highest profit
        ↓
Declare strategy successful
```

Instead:

```text
Define hypothesis
        ↓
Define variable
        ↓
Run controlled experiment
        ↓
Evaluate evidence
        ↓
Form next hypothesis
```

Optimization should begin only after the underlying trading hypothesis demonstrates sufficient evidence to justify it.

---

# Out-of-Sample Validation

A candidate that survives controlled research must eventually be evaluated on data not used to develop the strategy.

Conceptually:

```text
Development Data
        ↓
Research

Separate Data
        ↓
Validation
```

The validation period must not be repeatedly used to tune the strategy.

Otherwise it effectively becomes part of the development dataset.

---

# Robustness Testing

A promising strategy should later be tested for sensitivity to changes in:

```text
Market period
Spread
Execution assumptions
Parameters
Timeframe
Market regime
```

A strategy that works only under one exact parameter combination may be fragile.

Research should therefore look for:

```text
Stable regions
```

rather than a single:

```text
Perfect parameter
```

---

# Forward Testing

Only candidates that survive:

```text
Baseline
+
Controlled Research
+
Historical Validation
+
Out-of-Sample Testing
+
Robustness Testing
```

should proceed to forward testing.

Forward testing must remain separate from live capital deployment approval.

---

# Research Evidence

Research conclusions should reference original evidence stored in:

```text
Backtest/
```

Example:

```text
Backtest/
└── EA-062_Body_Breakout/
    ├── README.md
    ├── ReportTester-952747(20260915-021809).html
    ├── ReportTester-952747(20260915-021809).png
    ├── ReportTester-952747-hst(20260915-021809).png
    ├── ReportTester-952747-mfemae(20260915-021809).png
    └── ReportTester-952747-holding(20260915-021809).png
```

Original MT5 Strategy Tester evidence should not be manually modified.

---

# Repository Relationship

```text
EAs/
│
│   Trading logic
│
▼
Backtest/
│
│   Experimental evidence
│
▼
Research/
│
│   Interpretation
│   Research questions
│   Controlled experiments
│
▼
docs/
    Methodology
    Validation rules
    Repository-wide standards
```

Each directory has a separate responsibility.

---

# Current EA-062 Research Status

```text
EA-062 Implementation       : COMPLETE

EA062-M1-BASELINE-001       : COMPLETE
Baseline Result             : FAIL

EA062-RQ01 Timeframe        : NOT STARTED
EA062-RQ02 Body Ratio       : NOT STARTED
EA062-RQ03 Breakout Lookback: NOT STARTED
EA062-RQ04 Trading Session  : NOT STARTED
EA062-RQ05 Market Regime    : NOT STARTED
EA062-RQ06 Direction        : NOT STARTED
EA062-RQ07 Exit Management  : NOT STARTED

Long Historical Validation : NOT STARTED
Out-of-Sample Validation    : NOT STARTED
Robustness Testing          : NOT STARTED
Forward Testing             : NOT STARTED
Live Trading                : NOT APPROVED
```

---

# Current Conclusion

The EA-062 baseline provides sufficient evidence to reject the current configuration as a viable final strategy.

It does **not** provide sufficient evidence to reject the underlying Body Breakout hypothesis.

Current research state:

```text
Strategy Hypothesis : OPEN
Baseline             : COMPLETE
Baseline Result      : FAIL
Research             : REQUIRED
Optimization         : NOT YET JUSTIFIED
Production           : NOT APPROVED
```

The next objective is not to search immediately for the most profitable parameter combination.

The next objective is to determine:

> Why did the baseline fail, and which strategy component should be tested first?

---

## Disclaimer

This repository contains quantitative trading research and historical experiments.

Backtest results are not guarantees of future performance.

No EA documented in this research directory should be considered suitable for live trading unless it has completed the required validation process.
