# Research & Backtesting Methodology

## 1. Purpose

This document defines the research and backtesting methodology used in the **xauusd-mt5-ea-research** repository.

The objective is to maintain a consistent and transparent process for developing, testing, and documenting Expert Advisor (EA) ideas for XAUUSD in MetaTrader 5.

The repository records both successful and failed experiments.

A strategy is not considered successful simply because it has been implemented or produces profitable individual trades. Conclusions must be supported by reproducible backtest evidence.

---

## 2. Research Workflow

Each EA follows the same basic research process:

```text
Trading Idea
    ↓
Define Hypothesis
    ↓
Implement EA
    ↓
Compile & Verify
    ↓
Run Baseline Backtest
    ↓
Preserve Test Evidence
    ↓
Evaluate Results
    ↓
PASS / FAIL
    ↓
Document Conclusion
```

The baseline should remain as simple as possible.

Additional filters, optimization, or complex trade-management logic should not be introduced before the original hypothesis has been tested.

---

## 3. Research Hypothesis

Every EA begins with a clearly defined trading hypothesis.

A hypothesis should describe:

* What market behavior is being tested
* What indicator or price condition represents that behavior
* What triggers an entry
* What invalidates or exits the trade
* Which market and timeframe are being evaluated

Example:

```text
Hypothesis:

An expanding MACD histogram may represent strengthening
directional momentum and may therefore provide a
trend-continuation trading signal.
```

The hypothesis should be defined before evaluating the backtest result.

---

## 4. EA Implementation

Each strategy is implemented as an independent MetaTrader 5 Expert Advisor.

Repository structure:

```text
EAs/
└── EA-XXX_Strategy_Name/
    ├── EA-XXX_Strategy_Name.mq5
    └── README.md
```

The source-code README should document:

* Strategy concept
* Indicator configuration
* BUY conditions
* SELL conditions
* Exit logic
* Risk parameters
* Trade filters
* Input parameters
* Execution behavior

The documentation should describe the actual implementation rather than an intended future version of the strategy.

---

## 5. Baseline First

The first test of an EA should be a baseline experiment.

The purpose of the baseline is to answer:

> Does the basic trading hypothesis demonstrate an edge before additional complexity is introduced?

Where practical, the baseline should avoid unnecessary:

* Additional indicators
* Multiple confirmation layers
* Parameter optimization
* Session filters
* Complex position sizing
* Complex exit management

This creates a clear reference point for later experiments.

---

## 6. Backtesting Platform

Backtests are performed using:

**MetaTrader 5 Strategy Tester**

For each test, the following information should be preserved:

* Expert Advisor
* Symbol
* Timeframe
* Test period
* Input parameters
* Initial deposit
* Leverage
* Data / history quality
* Number of bars
* Number of ticks
* Number of trades

These settings are necessary to understand and reproduce the experiment.

---

## 7. Market Data

Whenever available, testing should use:

```text
100% real ticks
```

The data quality used in each test must be recorded in the corresponding backtest documentation.

A result produced with different data quality, broker data, symbol specification, spread conditions, or execution assumptions should not automatically be treated as equivalent to another test.

---

## 8. Backtest Evidence

Every completed baseline backtest should preserve the original Strategy Tester evidence.

Recommended structure:

```text
Backtest/
└── EA-XXX_Strategy_Name/
    ├── README.md
    ├── Strategy Tester Report
    └── Generated Charts
```

The original report should be retained whenever possible.

The README summarizes the result but does not replace the original Strategy Tester report.

---

## 9. Core Evaluation Metrics

At minimum, the following metrics should be recorded when available:

| Metric               | Purpose                                             |
| -------------------- | --------------------------------------------------- |
| Total Net Profit     | Overall financial result                            |
| Gross Profit         | Total profit from winning trades                    |
| Gross Loss           | Total loss from losing trades                       |
| Profit Factor        | Gross Profit relative to Gross Loss                 |
| Expected Payoff      | Average expected result per trade                   |
| Maximum Drawdown     | Largest observed account decline                    |
| Sharpe Ratio         | Risk-adjusted performance statistic reported by MT5 |
| Total Trades         | Size of the tested trade sample                     |
| Win Rate             | Percentage of profitable trades                     |
| Average Profit Trade | Average winning-trade result                        |
| Average Loss Trade   | Average losing-trade result                         |
| Consecutive Wins     | Winning-streak behavior                             |
| Consecutive Losses   | Losing-streak behavior                              |

Additional statistics such as MFE, MAE, holding time, BUY/SELL performance, and time distribution may also be retained when useful.

---

## 10. PASS / FAIL Classification

Each completed experiment receives a research classification.

### PASS

A PASS means that the tested configuration produced evidence strong enough to justify continued investigation.

PASS does **not** mean:

```text
Ready for live trading
```

It means:

```text
Promising enough for the next research stage
```

A PASS decision should consider multiple metrics rather than net profit alone.

Relevant evidence includes:

* Positive net result
* Profit Factor above 1
* Positive expectancy
* Acceptable drawdown
* Sufficient number of trades
* Reasonable balance/equity behavior
* No obvious dependence on a very small number of trades

The reason for the PASS decision must be documented.

### FAIL

A FAIL means the tested configuration does not provide sufficient evidence to continue treating the current version as a successful strategy.

Examples include:

* Negative net profit
* Profit Factor below 1
* Negative expectancy
* Excessive drawdown
* Persistent deterioration of the balance/equity curve
* Insufficient evidence of a repeatable trading edge

The reason for the FAIL decision must also be documented.

---

## 11. Failed Experiments

Failed experiments must not be hidden simply because the result is negative.

A failed EA can still provide valuable information.

Example:

```text
Hypothesis
    ↓
Implementation
    ↓
8,000+ trades
    ↓
Profit Factor < 1
    ↓
FAIL
```

This result demonstrates that the tested hypothesis/configuration did not produce the expected edge under those conditions.

Preserving failed experiments reduces the risk of repeating the same research later.

---

## 12. Avoiding Result-Based Rewriting

The original hypothesis should not be rewritten after observing the backtest result simply to make the experiment appear successful.

For example:

```text
Hypothesis A
    ↓
Backtest A
    ↓
FAIL
```

should remain recorded as a failed experiment.

If a new idea is introduced:

```text
Hypothesis B
```

it should be treated as a new experiment or clearly identified strategy revision.

This preserves the research history.

---

## 13. Strategy Modification

A modification should answer a specific research question.

Example:

```text
Baseline
    ↓
Problem identified
    ↓
New hypothesis
    ↓
One defined modification
    ↓
New backtest
    ↓
Compare with baseline
```

Where practical, avoid changing many unrelated strategy components simultaneously.

If several components are changed at once, it becomes difficult to determine which modification caused the result.

---

## 14. Optimization

Optimization should not replace hypothesis testing.

The preferred sequence is:

```text
Simple Strategy
    ↓
Baseline Test
    ↓
Identify Weakness
    ↓
Form New Hypothesis
    ↓
Test Modification
    ↓
Only Then Consider Optimization
```

A large parameter search can produce attractive historical results even when the underlying strategy has little robust edge.

For this reason, optimized results should be documented separately from the original baseline.

---

## 15. Comparison With Baseline

Future EA revisions should be compared against the baseline.

Useful comparisons include:

| Metric           | Baseline | New Experiment |
| ---------------- | -------: | -------------: |
| Net Profit       |        — |              — |
| Profit Factor    |        — |              — |
| Expected Payoff  |        — |              — |
| Maximum Drawdown |        — |              — |
| Sharpe Ratio     |        — |              — |
| Total Trades     |        — |              — |
| Win Rate         |        — |              — |

The objective is not merely to produce a profitable backtest.

The objective is to determine whether the modification produces a measurable improvement over the original experiment.

---

## 16. Reproducibility

A research result should contain enough information for the experiment to be repeated.

At minimum, preserve:

```text
EA source code
+
EA version
+
Symbol
+
Timeframe
+
Test period
+
Input parameters
+
Data quality
+
Strategy Tester report
+
Result summary
```

If these elements are missing, the result should not be treated as fully reproducible research evidence.

---

## 17. Repository Evidence Chain

Each EA should maintain a simple evidence chain:

```text
Research Hypothesis
        ↓
EAs/EA-XXX/
        ↓
Source Code
        ↓
Backtest/EA-XXX/
        ↓
Strategy Tester Evidence
        ↓
Research Conclusion
```

The source code answers:

> What exactly was tested?

The backtest report answers:

> What happened when it was tested?

The research documentation answers:

> What did we learn from the experiment?

---

## 18. Example — EA-021

EA-021 provides the first documented example of this methodology.

```text
EA-021_MACD_Histogram_Trend

Hypothesis
    ↓
MACD histogram expansion may identify
momentum continuation

Implementation
    ↓
MetaTrader 5 Expert Advisor

Baseline
    ↓
XAUUSD.PRO
M1
2026.01.02 – 2026.08.01
100% real ticks

Sample
    ↓
8,367 trades

Result
    ↓
Net Profit: -$994.28
Profit Factor: 0.94
Expected Payoff: -$0.12
Maximum Drawdown: 99.45%

Decision
    ↓
FAIL
```

The EA-021 baseline remains in the repository because the failed result is itself research evidence.

---

## 19. Research Status vs Live Trading

Repository research status and live-trading readiness are separate concepts.

```text
FAIL
    = Current experiment rejected

PASS
    = Continue research

PASS
    ≠ Production Ready
```

A successful historical backtest alone is not sufficient evidence for live deployment.

Further validation would be required before making a live-trading decision.

---

## 20. Principle

The repository follows one central rule:

> Test the simplest version of the idea first, preserve the evidence, and let the result determine the next research question.

The purpose of this repository is not to prove that every trading idea works.

The purpose is to determine, through reproducible experiments, **which ideas survive testing and which do not**.
