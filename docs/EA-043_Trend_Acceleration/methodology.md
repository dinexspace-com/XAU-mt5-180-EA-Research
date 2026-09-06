# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard research, implementation, backtesting, and evaluation methodology used in the **xauusd-mt5-ea-research** repository.

The objective of the repository is to systematically research trading ideas for XAUUSD, convert those ideas into explicit trading rules, implement them as MetaTrader 5 Expert Advisors, and evaluate them using reproducible backtests.

The research process is designed to preserve both successful and failed experiments.

A failed EA is still considered useful research evidence if:

- the trading hypothesis is clearly defined;
- the implementation represents that hypothesis correctly;
- the backtest is reproducible;
- the results are preserved;
- and the reason for rejection is documented.

---

# 1. Research Workflow

Each EA follows the same basic research pipeline:

```text
Trading Idea
    ↓
Define Hypothesis
    ↓
Convert Hypothesis Into Explicit Rules
    ↓
Implement MT5 EA
    ↓
Verify EA Behavior
    ↓
Run Baseline Backtest
    ↓
Evaluate Results
    ↓
PASS / FAIL
    ↓
Research Improvements
    ↓
Retest
```

The process should remain simple during the initial research stage.

Complex filters, optimization, machine learning, or additional strategy components should not be introduced before the basic trading hypothesis has been implemented and tested.

---

# 2. Strategy Identification

Each strategy receives a unique EA number.

Example:

```text
EA-043_Trend_Acceleration
```

Naming convention:

```text
EA-<NUMBER>_<STRATEGY_NAME>
```

Example directory:

```text
EAs/
└── EA-043_Trend_Acceleration/
```

The EA number should remain permanent even if the strategy fails.

Failed strategies should not be deleted or reused for unrelated strategies.

This preserves the research history of the repository.

---

# 3. Research Hypothesis

Before implementation, each EA should have a clearly defined hypothesis.

A valid hypothesis should answer:

```text
What market behavior is being exploited?

Why might this behavior create a trading opportunity?

What observable conditions define the setup?

What causes an entry?

What causes an exit?
```

The hypothesis should be specific enough to convert into deterministic trading rules.

Avoid descriptions such as:

```text
Buy when the market looks bullish.
```

Prefer explicit rules such as:

```text
Fast EMA > Slow EMA
Fast EMA slope > 0
EMA separation is increasing
```

The goal is to remove subjective interpretation before coding.

---

# 4. Minimal Baseline Strategy

The first implementation should be the simplest version capable of testing the core hypothesis.

The baseline should avoid unnecessary complexity.

Do not immediately add multiple:

- indicators;
- session filters;
- volatility filters;
- market-regime filters;
- higher-timeframe filters;
- dynamic position-sizing systems;
- optimization layers.

The purpose of the baseline is not to create the final EA.

The purpose is to answer:

> Does the underlying trading idea show evidence of a usable edge?

---

# 5. EA Implementation

Expert Advisors are implemented in:

```text
MQL5
```

for:

```text
MetaTrader 5
```

Each strategy is stored under:

```text
EAs/
└── EA-<NUMBER>_<STRATEGY_NAME>/
```

Minimum structure:

```text
EA-<NUMBER>_<STRATEGY_NAME>/
├── EA-<NUMBER>_<STRATEGY_NAME>.mq5
└── README.md
```

The source code should contain the complete trading logic required to reproduce the strategy.

---

# 6. EA README

Each EA directory should contain a README documenting the implementation.

At minimum, it should describe:

```text
Strategy concept
Entry logic
Exit logic
Indicators
Trading parameters
Position management
Spread/filter logic
Platform
Current research status
```

The README must describe what the code actually does.

It should not describe intended features that are not implemented.

---

# 7. Baseline Verification

Before accepting a backtest as research evidence, verify that the EA behaves according to its intended rules.

At minimum, confirm:

```text
EA compiles successfully
BUY entries can execute
SELL entries can execute
Stop Loss is applied correctly
Take Profit is applied correctly
Lot size is correct
Spread filter behaves correctly
Position-management logic behaves correctly
No obvious execution errors occur
```

A profitable backtest is meaningless if the EA does not implement the intended strategy correctly.

---

# 8. Backtesting

Baseline backtests are performed using the MetaTrader 5 Strategy Tester.

Where available, use:

```text
100% real ticks
```

to improve the quality of historical simulation.

The test configuration must be preserved.

At minimum record:

```text
EA
Symbol
Timeframe
Test period
Initial deposit
Leverage
Lot size
Stop Loss
Take Profit
Indicator parameters
Spread settings
Position-management settings
History quality
```

This allows another researcher to understand and reproduce the experiment.

---

# 9. Backtest Evidence

Backtest evidence is stored separately from EA source code.

Structure:

```text
Backtest/
└── EA-<NUMBER>_<STRATEGY_NAME>/
```

Recommended contents:

```text
README.md
Strategy Tester HTML report
Balance graph
Trade distribution charts
MFE / MAE charts
Holding-time charts
Other relevant Strategy Tester evidence
```

Example:

```text
Backtest/
└── EA-043_Trend_Acceleration/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

The original Strategy Tester evidence should be preserved whenever possible.

---

# 10. Core Evaluation Metrics

Every EA should be evaluated using multiple metrics.

Do not judge a strategy using Net Profit alone.

Minimum metrics:

| Metric | Purpose |
|---|---|
| Net Profit | Overall financial result |
| Profit Factor | Relationship between gross profit and gross loss |
| Expected Payoff | Average expected result per trade |
| Maximum Drawdown | Primary downside-risk measurement |
| Total Trades | Statistical sample size |
| Win Rate | Percentage of profitable trades |
| Average Win | Average profitable trade |
| Average Loss | Average losing trade |
| Sharpe Ratio | Risk-adjusted performance indicator |
| Recovery Factor | Ability to recover relative to drawdown |

Additional metrics may be used when relevant.

---

# 11. Equity Curve Review

Numerical metrics should be reviewed together with the equity or balance curve.

Look for:

```text
Persistent upward or downward trend
Long stagnation periods
Sudden dependence on a small number of trades
Large drawdown clusters
Unstable recovery periods
Changes in performance over time
```

A strategy with attractive headline profit but an unstable equity curve requires further investigation.

---

# 12. Trade Distribution

Analyze whether performance depends disproportionately on:

```text
BUY trades
SELL trades
Specific hours
Specific weekdays
Specific months
Specific market sessions
Very short holding periods
Very long holding periods
```

This can identify where a strategy works or fails.

However, these observations should initially be treated as research hypotheses rather than immediate optimization rules.

---

# 13. MFE / MAE Analysis

Where available, review:

```text
MFE — Maximum Favorable Excursion
MAE — Maximum Adverse Excursion
```

These measurements help investigate how price behaves after entry.

Possible research questions include:

```text
Do winning trades move favorably soon after entry?

Do losing trades experience large adverse movement immediately?

Are Take Profit levels too conservative?

Are Stop Loss levels too wide or too narrow?

Could exit management capture more favorable excursion?
```

MFE/MAE analysis should be used to generate hypotheses.

It should not automatically be interpreted as proof of an exploitable edge.

---

# 14. Baseline Decision

After the baseline backtest, assign a research result:

```text
PASS
```

or:

```text
FAIL
```

A FAIL result does not mean the experiment should be deleted.

It means the current implementation does not satisfy the research requirements.

The baseline remains part of the repository as evidence.

---

# 15. Failed Strategies

Failed strategies are preserved.

Example:

```text
EA-043_Trend_Acceleration

Baseline:
Net Profit: -$991.99
Profit Factor: 0.91
Maximum Drawdown: ~99%
Result: FAIL
```

This information is valuable because it prevents the same unsuccessful hypothesis from being repeatedly rediscovered without reference to previous evidence.

Failed results can also reveal specific weaknesses worth investigating.

---

# 16. Research After Baseline Failure

When a baseline fails, identify the primary weakness before modifying the EA.

Possible categories:

```text
Poor entry quality
Poor exit logic
Excessive trading frequency
Weak trend detection
Sideways-market exposure
Volatility sensitivity
Session sensitivity
Asymmetric BUY / SELL behavior
Poor risk management
```

Do not modify everything simultaneously.

Select one research hypothesis at a time.

---

# 17. One Main Change at a Time

Whenever practical:

```text
Baseline
    ↓
Add one modification
    ↓
Backtest
    ↓
Compare
    ↓
Keep / Reject
```

Example:

```text
EA-043 Baseline
    ↓
Add minimum EMA acceleration threshold
    ↓
Backtest
    ↓
Compare with baseline
```

If the modification improves the strategy consistently, it may be retained for the next experiment.

If it does not, reject it and preserve the result.

---

# 18. Avoid Blind Optimization

Parameter optimization can easily produce attractive historical results that do not generalize.

Therefore, optimization should not be the first response to a failed baseline.

Avoid searching thousands of parameter combinations simply to maximize historical profit.

First determine whether there is a logical reason for changing a parameter.

The preferred sequence is:

```text
Hypothesis
    ↓
Implementation
    ↓
Test
    ↓
Evidence
```

rather than:

```text
Optimization
    ↓
Find highest historical profit
    ↓
Assume strategy works
```

---

# 19. Avoid Overfitting

A strategy should not be considered robust simply because it performs well on one historical period.

Warning signs include:

```text
Extremely specific parameters
Very narrow profitable parameter ranges
Large performance changes from small parameter changes
Performance concentrated in a short historical period
Dependence on a few unusually profitable trades
Large number of filters added after examining historical results
```

The more decisions made using the same historical dataset, the greater the risk of overfitting.

---

# 20. Further Validation

A promising baseline or improved strategy requires additional validation before being considered production-ready.

Depending on the research stage, this may include:

```text
Longer historical backtest
Different market regimes
Out-of-sample testing
Walk-forward testing
Parameter sensitivity analysis
Different XAUUSD data sources / brokers
Forward testing
Demo testing
Execution-cost analysis
Slippage analysis
Spread sensitivity
```

These tests should be introduced after the basic strategy demonstrates sufficient potential.

---

# 21. Production Readiness

The following states should remain separate:

```text
Research idea
↓
Implemented EA
↓
Baseline tested
↓
Research candidate
↓
Validated candidate
↓
Forward-tested candidate
↓
Production candidate
```

Passing one backtest does not make an EA production-ready.

Live deployment requires additional validation and explicit approval.

---

# 22. Repository Structure

The repository uses the following structure:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-<NUMBER>_<STRATEGY_NAME>/
│   │   ├── EA-<NUMBER>_<STRATEGY_NAME>.mq5
│   │   └── README.md
│
├── Backtest/
│   ├── EA-<NUMBER>_<STRATEGY_NAME>/
│   │   ├── README.md
│   │   └── Strategy Tester evidence
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

Each directory has a separate responsibility.

### `EAs/`

Contains strategy source code and implementation documentation.

### `Backtest/`

Contains reproducible Strategy Tester evidence and backtest results.

### `Research/`

Contains research hypotheses, findings, failed experiments, and future research directions.

### `docs/`

Contains repository-wide research methodology and standards.

### `GitHub_Profile/`

Contains the public-facing GitHub profile README.

---

# 23. Research Record

For every EA, the repository should make it possible to answer:

```text
What was the idea?

How was the idea converted into trading rules?

What code implemented those rules?

How was it tested?

What parameters were used?

What happened?

Why did it PASS or FAIL?

What should be investigated next?
```

If these questions can be answered from the repository, the experiment is reproducible and useful even when the strategy fails.

---

# 24. Core Principle

The central methodology of this repository is:

> **Idea → Rule → Code → Backtest → Evidence → Decision → Next Experiment**

Do not hide failed results.

Do not replace evidence with assumptions.

Do not optimize before establishing a baseline.

Do not treat historical profitability as proof of future profitability.

The objective is not to make every EA appear successful.

The objective is to build a structured and reproducible body of XAUUSD algorithmic-trading research.
