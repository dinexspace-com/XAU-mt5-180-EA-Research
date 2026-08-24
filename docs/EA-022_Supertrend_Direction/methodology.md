# EA Research Methodology

## 1. Purpose

This document defines the standard methodology used to develop, backtest, evaluate, and document Expert Advisors (EAs) in this repository.

The objective is to maintain a research process that is:

* Reproducible
* Evidence-based
* Easy to audit
* Resistant to overfitting
* Consistent across different EAs

The general workflow is:

```text
Trading Idea
    ↓
Define Strategy Rules
    ↓
Implement EA
    ↓
Compile & Verify
    ↓
Baseline Backtest
    ↓
Evaluate Results
    ↓
Research / Controlled Experiments
    ↓
Validation
    ↓
Decision
```

A strategy is not considered successful simply because the EA compiles or produces profitable trades.

Every conclusion must be supported by test evidence.

---

# 2. Repository Structure

The repository separates implementation, test evidence, research, and methodology.

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

Each directory has a different purpose.

### `EAs/`

Contains the EA source code and technical documentation describing the implemented strategy.

### `Backtest/`

Contains Strategy Tester reports and evidence generated from actual tests.

### `Research/`

Contains research questions, observations, experiment results, and conclusions.

### `docs/`

Contains repository-wide methodology and standards.

The methodology should remain independent from the performance of any single EA.

---

# 3. Research Principle

The core research principle is:

> Test the simplest implementation of an idea before increasing strategy complexity.

The preferred progression is:

```text
Simple hypothesis
      ↓
Minimal EA
      ↓
Baseline test
      ↓
Understand failure/success
      ↓
Controlled modification
      ↓
Retest
```

Additional indicators, filters, optimization, money-management systems, or other complexity should not be introduced merely to improve historical results.

Each modification should answer a specific research question.

---

# 4. Define the Strategy Before Testing

Before backtesting, the strategy should have explicit rules.

At minimum, define:

```text
Entry condition
Exit condition
Stop Loss
Take Profit
Position sizing
Maximum positions
Spread restrictions
Trade management
Timeframe
Symbol
```

The implemented `.mq5` source code is the authoritative definition of what the EA actually executes.

The EA README should describe those implemented rules.

---

# 5. EA Implementation

Each EA receives a unique identifier.

Example:

```text
EA-022_Supertrend_Direction
```

Recommended structure:

```text
EAs/
└── EA-022_Supertrend_Direction/
    ├── EA-022_Supertrend_Direction.mq5
    └── README.md
```

The README should document:

* Strategy purpose
* Entry rules
* Exit rules
* Risk-management behavior
* Input parameters
* Trade-management logic
* Timeframe behavior
* Symbol behavior
* Known limitations

Documentation should describe the actual source code rather than the intended strategy if the two differ.

---

# 6. Baseline Test

Every EA should first receive a baseline backtest.

The baseline is the reference experiment against which later modifications are compared.

Once recorded, the baseline should not be replaced simply because a later configuration performs better.

Example:

```text
EA-022
│
├── Baseline → FAIL
│
├── Experiment 01
│
├── Experiment 02
│
└── ...
```

A failed baseline is still a valid research result.

---

# 7. Backtest Evidence

Backtest conclusions should be supported by the original MetaTrader 5 Strategy Tester output.

For the current EA-022 baseline, the test used:

```text
EA:              EA-022_Supertrend_Direction
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 – 2026.08.01
History Quality: 100% real ticks
Initial Deposit: $1,000
Leverage:        1:500
```

The test processed:

```text
205,636 bars
87,255,913 ticks
2,429 trades
```

These values should be preserved with the corresponding test evidence.

---

# 8. Backtest Parameters

The exact EA inputs used for each important test must be recorded.

For example, the EA-022 baseline used:

```text
Lot Size          = 0.01
Stop Loss         = 300
Take Profit       = 600
Maximum Spread    = 50
Maximum Positions = 1

ATR Period         = 10
Multiplier         = 3.0

Break Even         = OFF

Trailing Stop      = ON
Trailing Start     = 200
Trailing Distance  = 200
Trailing Step      = 10
```

Parameter values recorded in the Strategy Tester report take precedence when documenting a specific backtest.

This prevents confusion between:

```text
EA default settings
```

and:

```text
Settings actually used in a test
```

---

# 9. Minimum Performance Metrics

Every meaningful backtest should record at least:

| Metric               | Purpose                             |
| -------------------- | ----------------------------------- |
| Total Net Profit     | Overall financial result            |
| Profit Factor        | Gross profit relative to gross loss |
| Expected Payoff      | Average expected result per trade   |
| Maximum Drawdown     | Capital risk observed during test   |
| Total Trades         | Statistical sample size             |
| Winning Trades       | Winning-trade percentage            |
| Losing Trades        | Losing-trade percentage             |
| Average Profit Trade | Typical winning trade               |
| Average Loss Trade   | Typical losing trade                |
| Sharpe Ratio         | Risk-adjusted performance indicator |

Additional Strategy Tester metrics may be recorded when relevant.

---

# 10. PASS / FAIL Evaluation

A backtest result must not be classified solely from Net Profit.

The complete performance profile should be considered.

At minimum, evaluate:

```text
Profitability
+
Drawdown
+
Expectancy
+
Trade distribution
+
Sample size
+
Equity / balance behavior
```

A configuration showing severe capital destruction or clearly negative expectancy should be classified as:

```text
FAIL
```

even if isolated profitable periods or individual profitable trades exist.

---

# 11. Example — EA-022 Baseline

The EA-022 baseline produced:

```text
Total Trades      = 2,429
Net Profit        = -$992.78
Profit Factor     = 0.74
Expected Payoff   = -$0.41
Sharpe Ratio      = -5.00
Maximum Drawdown  = 99.28%
Winning Trades    = 46.93%
Losing Trades     = 53.07%
```

Result:

```text
FAIL
```

This baseline remains useful because it establishes the performance of the original implementation before further research.

---

# 12. Controlled Experiments

After the baseline, changes should be tested systematically.

The preferred rule is:

> Change one major variable at a time whenever practical.

For example:

```text
Baseline
    ↓
Disable Trailing Stop
    ↓
Compare
```

rather than:

```text
Change ATR
+ Change Multiplier
+ Change SL
+ Change TP
+ Add Filter
+ Change Timeframe
        ↓
      Retest
```

Changing many variables simultaneously makes it difficult to determine which modification caused the result.

---

# 13. Research Questions

Each experiment should answer a clear question.

Example:

```text
RQ-01

Question:
Does disabling the Trailing Stop improve the baseline?

Control:
EA-022 baseline

Change:
Trailing Stop ON → OFF

Everything else:
Unchanged
```

The result should then be compared against the baseline.

---

# 14. Experiment Record

Each meaningful experiment should record:

```text
Experiment ID
EA version
Research question
Changed variable
Control configuration
Test environment
Test period
Input parameters
Result metrics
Evidence
Conclusion
PASS / FAIL
```

This allows the experiment to be reproduced later.

---

# 15. Preserve Failed Experiments

Failed tests should not be deleted merely because they perform poorly.

Example:

```text
Baseline       FAIL
Experiment 01  FAIL
Experiment 02  FAIL
Experiment 03  PASS
```

All four results contain useful research information.

Removing failed tests creates survivorship bias and makes the research history difficult to audit.

---

# 16. Optimization

Optimization should occur only after the baseline behavior is understood.

The objective of optimization is not:

> Find the parameter combination with the highest historical profit.

The objective is to investigate whether a **stable parameter region** exists.

Avoid relying only on a single historical optimum.

Example:

```text
Multiplier

2.5   weak
2.7   good
2.9   good
3.0   good
3.1   good
3.3   weak
```

A broad stable region is generally more informative for research than one isolated result such as:

```text
Multiplier = 2.873
```

with dramatically better historical performance.

---

# 17. Avoid Overfitting

Repeatedly modifying a strategy against the same historical period increases the risk of fitting the strategy to historical noise.

Warning signs include:

* Excessive numbers of parameters
* Many entry filters
* Extremely specific parameter values
* Narrow trading windows selected from historical performance
* Repeated optimization against the same dataset
* Large historical improvement from small parameter changes

Such results require stronger validation.

---

# 18. Development vs Validation

Data used to develop or optimize the strategy should not be treated as independent validation evidence.

Conceptually:

```text
Historical Data
│
├── Development
│
└── Validation
```

A strategy should demonstrate acceptable behavior outside the data used to design or optimize it before stronger conclusions are made.

---

# 19. Robustness

A promising strategy should eventually be tested under changes such as:

```text
Different historical periods
Different market conditions
Different parameter values
Different spreads / execution assumptions
Different timeframes where relevant
```

The objective is not for every test to produce identical results.

The objective is to determine whether the apparent edge survives reasonable changes in test conditions.

---

# 20. Research Decision Levels

Use the following progression:

```text
IDEA
 ↓
IMPLEMENTED
 ↓
BASELINE TESTED
 ↓
RESEARCHING
 ↓
CANDIDATE
 ↓
VALIDATING
 ↓
VALIDATED
```

A profitable baseline does not automatically mean:

```text
VALIDATED
```

Likewise:

```text
Backtest PASS
```

does not automatically mean:

```text
LIVE READY
```

Those decisions require additional evidence.

---

# 21. Evidence Hierarchy

Research conclusions should be traceable through:

```text
Source Code
    ↓
EA Documentation
    ↓
Strategy Tester Report
    ↓
Backtest README
    ↓
Research Conclusion
```

For example:

```text
EAs/
└── EA-022_Supertrend_Direction/
        ↓
Backtest/
└── EA-022_Supertrend_Direction/
        ↓
Research/
└── README.md
```

The original test report remains the primary evidence for numerical backtest results.

---

# 22. Documentation Rules

Do not report performance metrics that were not produced by actual testing.

Do not describe planned functionality as implemented functionality.

Do not convert assumptions into research conclusions.

Clearly distinguish:

```text
Implemented
Tested
Observed
Hypothesized
Planned
```

This distinction should remain visible throughout the repository.

---

# 23. Current EA-022 Research State

At the time of the documented baseline:

```text
EA-022_Supertrend_Direction

Strategy implemented      YES
Source documented          YES
Baseline completed         YES
Real-tick history          YES
Baseline result            FAIL
Further research           REQUIRED
Validated                  NO
Live-ready                 NO
```

The baseline failure should remain preserved as the starting point for subsequent EA-022 research.

---

# 24. Core Methodology

The repository follows this research loop:

```text
1. Define hypothesis
        ↓
2. Implement simplest testable EA
        ↓
3. Verify implementation
        ↓
4. Run baseline backtest
        ↓
5. Preserve evidence
        ↓
6. Analyze results
        ↓
7. Define one research question
        ↓
8. Change one major variable
        ↓
9. Retest
        ↓
10. Compare with baseline
        ↓
11. PASS / FAIL
        ↓
12. Repeat only when evidence justifies it
```

The goal is not to make every EA profitable.

The goal is to determine, through reproducible evidence, whether a trading idea contains a sufficiently robust edge to justify further development.

---

## Current Example

```text
EA-022 Supertrend Direction
          │
          ▼
   Baseline Backtest
          │
          ▼
        FAIL
          │
          ▼
 Controlled Research
          │
          ▼
    Next Experiment
```

The current EA-022 baseline therefore remains a **research starting point**, not a finished trading system.
