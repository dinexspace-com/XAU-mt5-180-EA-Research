# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the research methodology used in the `xauusd-mt5-ea-research` repository.

The objective is to evaluate MetaTrader 5 Expert Advisors for XAUUSD through a structured and reproducible process.

The methodology separates:

```text
Strategy Implementation
        ↓
Baseline Backtest
        ↓
Research
        ↓
Controlled Experiments
        ↓
Validation
        ↓
Final Assessment
```

A strategy is not considered successful simply because one backtest is profitable.

Likewise, a failed baseline does not automatically mean the research idea should be discarded.

Every conclusion should be supported by reproducible test evidence.

---

# 2. Repository Structure

Each part of the repository has a separate responsibility.

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

Contains the actual MQL5 implementation and documentation describing what the EA does.

The EA README should document:

* Strategy concept
* Entry logic
* Exit logic
* Risk management
* Inputs
* Position management
* Known implementation characteristics

It should describe the source code as implemented rather than how the strategy was theoretically intended to work.

---

### `Backtest/`

Contains reproducible Strategy Tester evidence for each EA.

Examples:

```text
Backtest/
└── EA-028_Ichimoku_Cloud/
    ├── README.md
    ├── ReportTester-XXXXXX.html
    ├── ReportTester-XXXXXX.png
    ├── ReportTester-XXXXXX-hst.png
    ├── ReportTester-XXXXXX-mfemae.png
    └── ReportTester-XXXXXX-holding.png
```

Original test evidence should be retained.

Later tests must not silently replace earlier results.

---

### `Research/`

Contains:

* Observations
* Research questions
* Hypotheses
* Experiment plans
* Experiment conclusions

Research hypotheses must be clearly separated from findings supported by evidence.

---

### `docs/`

Contains repository-wide methodology and standards.

This file belongs here because the methodology applies to all EAs rather than one specific strategy.

---

# 3. Research Workflow

Every EA should follow the same basic workflow.

## Stage 1 — Strategy Definition

Define exactly what the strategy is intended to test.

Record:

* Indicator or strategy concept
* Entry conditions
* Exit conditions
* Position sizing
* Stop Loss
* Take Profit
* Trade management
* Filters
* Relevant parameters

At this stage, no profitability claim should be made.

---

# 4. Source Code Review

Before interpreting a backtest, inspect the actual `.mq5` implementation.

The objective is to answer:

> What does the EA actually execute?

This distinction is important because the implemented strategy may differ from the conceptual strategy.

For example:

```text
Tenkan > Kijun
```

is not equivalent to:

```text
Tenkan crosses above Kijun
```

The first describes a persistent state.

The second describes an event.

Research documentation should reflect the implemented behavior.

---

# 5. Baseline Backtest

Every EA begins with a baseline test.

The baseline establishes the reference result against which future experiments are compared.

The baseline should use a documented configuration and should not be optimized after seeing the result.

At minimum record:

| Category   | Required Information   |
| ---------- | ---------------------- |
| EA         | EA name/version        |
| Symbol     | Tested symbol          |
| Timeframe  | Tested timeframe       |
| Period     | Start/end dates        |
| Data       | History/model quality  |
| Deposit    | Initial capital        |
| Leverage   | Account leverage       |
| Inputs     | Complete EA parameters |
| Trades     | Number of trades       |
| Profit     | Net Profit             |
| PF         | Profit Factor          |
| Expectancy | Expected Payoff        |
| DD         | Maximum Drawdown       |
| Evidence   | Original tester report |

---

# 6. Baseline Evidence

The original MetaTrader 5 Strategy Tester report should be preserved.

Where available, retain:

```text
HTML report
Balance chart
Trade distribution charts
MFE / MAE chart
Holding-time chart
```

The purpose is reproducibility.

A README summary is not a replacement for the original Strategy Tester evidence.

---

# 7. Baseline Assessment

A baseline should be classified according to the evidence.

Possible states:

```text
PASS
FAIL
INCONCLUSIVE
```

### PASS

The baseline satisfies the predefined acceptance criteria for the research stage.

PASS does **not** mean the EA is ready for live trading.

---

### FAIL

The baseline fails one or more critical acceptance criteria.

A failed baseline may still continue into research if there is a clear hypothesis worth testing.

---

### INCONCLUSIVE

The available evidence is insufficient to make a reliable assessment.

Examples include:

* Insufficient trade sample
* Incomplete historical data
* Invalid test configuration
* Missing evidence
* Execution errors

---

# 8. Research After Baseline

After the baseline, identify the main research problem.

Example:

```text
Observation:
Profit Factor = 0.92

Research question:
Why does the strategy have negative expectancy?
```

Do not convert an observation directly into an unsupported explanation.

Incorrect:

```text
The EA loses because M1 is noisy.
```

unless an experiment has demonstrated this.

Correct:

```text
Hypothesis:
M1 may contain too much noise for this strategy.

Required test:
Compare the same strategy across multiple timeframes.
```

---

# 9. Hypothesis-Driven Testing

Every significant strategy modification should correspond to a research hypothesis.

Recommended format:

```text
Hypothesis
    ↓
Experiment
    ↓
Evidence
    ↓
Result
    ↓
Conclusion
```

Example:

```text
H1:
The strategy performs poorly because M1 produces excessive low-quality signals.

Experiment:
Run the unchanged strategy on M1, M5, M15 and H1.

Evidence:
MT5 Strategy Tester reports.

Conclusion:
Accept or reject H1 based on the results.
```

---

# 10. One Variable at a Time

During diagnostic research, change as few variables as possible.

Avoid:

```text
Change timeframe
+ change indicator settings
+ change SL/TP
+ add ATR
+ add session filter
+ change trailing stop
```

in a single experiment.

If performance changes, the cause would be unclear.

Prefer:

```text
Baseline
   ↓
Change one component
   ↓
Compare
   ↓
Record result
```

This rule can be relaxed later during explicit optimization stages, but not during initial diagnosis.

---

# 11. Experiment Identification

Experiments should have unique IDs.

Recommended format:

```text
EXP-<EA ID>-<Experiment Number>_<Description>
```

Example:

```text
EXP-028-001_Timeframe
EXP-028-002_Crossover
EXP-028-003_Regime
EXP-028-004_ExitManagement
EXP-028-005_Session
EXP-028-006_VolatilityExit
```

This makes experiments traceable to their evidence.

---

# 12. Experiment Record

Every experiment should record at least:

```text
Experiment ID
EA Version
Hypothesis
Symbol
Timeframe
Test Period
History Quality
Parameters
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Total Trades
Evidence
Result
Conclusion
```

A result without its configuration is not considered reproducible research evidence.

---

# 13. Backtest Comparison

Experiments should primarily be compared against their designated baseline or control.

Important metrics include:

### Profitability

```text
Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
```

### Risk

```text
Maximum Balance Drawdown
Maximum Equity Drawdown
Recovery Factor
```

### Trade Behavior

```text
Total Trades
Win Rate
Average Winner
Average Loser
Consecutive Wins
Consecutive Losses
Holding Time
```

### Stability

Where appropriate:

```text
Sharpe Ratio
Balance curve behavior
Performance by period
Performance by direction
Performance by session
```

No single metric should be used as the sole evidence of strategy quality.

---

# 14. Profit Factor

Profit Factor is calculated conceptually as:

```text
Gross Profit
────────────
Gross Loss
```

A Profit Factor below `1.0` means gross losses exceed gross profits.

A value above `1.0` means gross profits exceed gross losses.

However:

> Profit Factor > 1 does not by itself prove that a strategy is robust.

It must be evaluated together with drawdown, trade count, test period and other performance characteristics.

---

# 15. Drawdown

Drawdown is treated as a critical risk metric.

A profitable strategy with unacceptable drawdown should not automatically PASS.

Research should consider:

```text
Return
AND
Risk
```

rather than maximizing profit alone.

Very high drawdown may indicate that the strategy is not practically survivable even when final net profit is positive.

---

# 16. Trade Sample Size

A very small number of trades can produce misleading performance statistics.

Trade count should therefore always be reported.

There is no universal minimum number of trades that proves a strategy is valid.

Instead, sample adequacy should be considered together with:

* Strategy frequency
* Test duration
* Market coverage
* Distribution of trades
* Stability of results

---

# 17. Parameter Optimization

Parameter optimization should not be the first response to a failed baseline.

The preferred sequence is:

```text
Understand failure
        ↓
Form hypothesis
        ↓
Test hypothesis
        ↓
Identify useful behavior
        ↓
Then optimize
```

Optimization performed too early increases the risk of fitting parameters to historical noise.

---

# 18. Overfitting Control

A strategy should not be accepted merely because an optimized parameter set performs well on the same historical data used to discover it.

Research should distinguish between:

```text
Development Data
```

and:

```text
Validation Data
```

Parameters developed using one historical sample should later be evaluated on data that was not used to select those parameters.

---

# 19. In-Sample and Out-of-Sample Testing

Once a strategy shows enough promise to justify validation, historical data should be separated conceptually into:

### In-Sample

Used for:

* Strategy development
* Hypothesis testing
* Parameter selection

### Out-of-Sample

Used to evaluate the resulting strategy without further adjustment.

If the strategy performs well in-sample but fails substantially out-of-sample, the research result should not be considered robust.

---

# 20. Robustness Testing

After a candidate strategy survives initial research, additional validation may include:

```text
Different historical periods
Different market regimes
Parameter sensitivity
Spread sensitivity
Execution assumptions
Out-of-sample testing
Forward testing
```

These tests belong to a later validation stage.

They should not be added before the basic strategy has demonstrated enough evidence to justify them.

---

# 21. Parameter Sensitivity

A potentially robust strategy should not depend entirely on one exact parameter combination.

For example, if:

```text
Parameter = 26
```

is profitable while:

```text
25
and
27
```

fail dramatically, the result deserves additional investigation.

Broad regions of acceptable performance are generally more informative than one isolated historical optimum.

---

# 22. Transaction Costs

XAUUSD strategies can be sensitive to execution conditions.

Where relevant, research should document:

```text
Spread
Commission
Slippage
Execution assumptions
Broker symbol specifications
```

This is particularly important for strategies with:

```text
High trade frequency
+
Short holding time
```

because transaction costs can materially affect expectancy.

---

# 23. Failed Experiments

Failed experiments must be retained.

A failed experiment provides information about what was tested and prevents the same unsupported idea from being repeatedly rediscovered.

Therefore:

```text
FAIL ≠ Delete
```

Instead:

```text
FAIL
 ↓
Record evidence
 ↓
Record conclusion
 ↓
Decide whether another hypothesis is justified
```

---

# 24. Evidence Rule

A research claim should be traceable to evidence.

Preferred relationship:

```text
Claim
 ↓
Experiment ID
 ↓
Test configuration
 ↓
Original MT5 report
```

If evidence is missing, the claim should be marked as:

```text
UNVERIFIED
```

rather than treated as established fact.

---

# 25. Version Control

Changes to trading logic should result in an identifiable EA version or experiment reference.

Avoid changing source code and then overwriting the evidence from the previous version.

The intended relationship is:

```text
EA Version
    ↕
Experiment
    ↕
Backtest Evidence
```

This allows a result to be reproduced later.

---

# 26. Research Decision Levels

The following levels are used to avoid confusing a successful experiment with a production-ready system.

```text
LEVEL 0 — IMPLEMENTED
EA compiles and executes.

LEVEL 1 — BASELINE TESTED
A reproducible baseline exists.

LEVEL 2 — RESEARCH CANDIDATE
There is enough evidence to justify further investigation.

LEVEL 3 — CANDIDATE STRATEGY
Controlled research shows potentially useful behavior.

LEVEL 4 — VALIDATED CANDIDATE
The strategy survives additional robustness and out-of-sample testing.

LEVEL 5 — FORWARD TEST CANDIDATE
The strategy is approved for controlled forward/demo testing.

LEVEL 6 — PRODUCTION CANDIDATE
Evidence is sufficient for a separate decision about live deployment.
```

Progression between levels requires evidence.

A profitable backtest alone does not automatically advance an EA to production.

---

# 27. Current Example — EA-028

EA-028 provides the first documented example of this methodology.

Baseline:

```text
EA:            EA-028_Ichimoku_Cloud
Symbol:        XAUUSD.PRO
Timeframe:     M1
Period:        2026.01.02 – 2026.03.01
Real Ticks:    100%
Trades:        6,457

Net Profit:    -$953.45
Profit Factor: 0.92
Expected:      -$0.15
Equity DD:     95.63%
```

The correct conclusion is:

```text
BASELINE = FAIL
```

The incorrect conclusion would be:

```text
Ichimoku does not work on XAUUSD.
```

The baseline only establishes that:

> This implementation, using this configuration, on this symbol/timeframe and historical period, failed the baseline test.

Further claims require further evidence.

---

# 28. EA-028 Current Research Path

The current planned sequence is:

```text
EA-028 Baseline
      ↓
EXP-028-001
Timeframe Comparison
      ↓
EXP-028-002
Entry / Crossover Test
      ↓
EXP-028-003
Market Regime Analysis
      ↓
EXP-028-004
Exit Management
      ↓
EXP-028-005
Session Analysis
      ↓
EXP-028-006
Volatility Exit
      ↓
Candidate?
   ↙       ↘
 NO        YES
Stop /     Validation
Archive
```

Each stage should only proceed when the preceding evidence justifies the next experiment.

---

# 29. Core Research Principles

The repository follows five core rules:

```text
1. Preserve original evidence.

2. Separate observation from hypothesis.

3. Change one major variable at a time during diagnosis.

4. Do not optimize before understanding the baseline.

5. Do not claim robustness without independent validation.
```

---

# 30. Final Standard

The purpose of this repository is not to produce the highest possible historical backtest result.

The purpose is to answer:

> **Does the trading idea demonstrate a repeatable and sufficiently robust edge to justify further testing?**

Every EA should therefore progress through:

```text
IMPLEMENT
   ↓
TEST
   ↓
UNDERSTAND
   ↓
EXPERIMENT
   ↓
VALIDATE
   ↓
DECIDE
```

with the original evidence preserved at every stage.
