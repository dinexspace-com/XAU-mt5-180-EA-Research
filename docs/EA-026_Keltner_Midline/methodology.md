# Research Methodology

This document defines the research and testing methodology used in the `xauusd-mt5-ea-research` repository.

The objective is to evaluate trading ideas systematically and reproducibly rather than selecting strategies based only on favorable backtest results.

---

# 1. Research Workflow

Each strategy follows the same basic process:

```text id="h1g9cm"
Trading Idea
    ↓
Define Rules
    ↓
Implement EA
    ↓
Verify Implementation
    ↓
Baseline Backtest
    ↓
Analyze Results
    ↓
Form Research Hypothesis
    ↓
Controlled Experiment
    ↓
Compare Against Baseline
    ↓
PASS / FAIL
```

Optimization is not the first step.

The original strategy must first be implemented and tested in a reproducible baseline configuration.

---

# 2. Strategy Definition

Before evaluating performance, the strategy must have explicit trading rules.

At minimum, document:

```text id="hgtbdn"
Entry conditions
Exit conditions
Stop Loss
Take Profit
Position sizing
Trading filters
Position management
Indicator parameters
Timeframe
Target symbol
```

Rules should be precise enough to translate directly into MQL5 logic.

Avoid discretionary descriptions such as:

```text id="5om8n6"
Enter when the market looks bullish.
```

Prefer deterministic conditions such as:

```text id="mbp8io"
Price > EMA
AND
EMA[0] > EMA[1]
```

---

# 3. EA Implementation

Each strategy receives its own directory:

```text id="2hnz5l"
EAs/
└── EA-XXX_Strategy_Name/
    ├── EA-XXX_Strategy_Name.mq5
    └── README.md
```

The source code is the authoritative description of what the EA actually executes.

The README should describe the implementation as it exists in the code.

If the intended strategy differs from the implemented strategy, the difference must be documented rather than silently ignored.

---

# 4. Implementation Verification

Before interpreting a backtest as strategy evidence, verify that the EA:

```text id="3c13jd"
Compiles successfully
Runs in MT5 Strategy Tester
Opens trades
Applies the intended entry conditions
Applies SL / TP correctly
Applies position-management rules correctly
Uses the intended symbol and timeframe
Uses the intended input parameters
```

A profitable backtest is meaningless if the implementation does not represent the intended strategy.

Implementation correctness and strategy profitability are separate questions.

---

# 5. Baseline Backtest

Every EA should first receive a baseline test.

The baseline establishes the reference performance of the original implementation before optimization.

Record at minimum:

```text id="i7ad1f"
EA version
Symbol
Timeframe
Test period
Model / tick quality
Initial deposit
Leverage
Lot size
All EA inputs
```

Whenever suitable historical data are available, prefer:

```text id="21ly2n"
Every tick based on real ticks
```

for the primary evidence-producing test.

---

# 6. Preserve the Baseline

The baseline result must be preserved even when performance is poor.

Examples of poor results include:

```text id="x1v95a"
Negative Net Profit
Profit Factor < 1
Negative Expected Payoff
Large Drawdown
Unstable Equity Curve
```

A failed test is still a valid research result.

Do not delete or replace a failed baseline simply because a later parameter combination performs better.

---

# 7. Backtest Storage

Each EA receives its own backtest directory:

```text id="uq1kk5"
Backtest/
└── EA-XXX_Strategy_Name/
```

The directory should contain the evidence necessary to reproduce or inspect the test.

Recommended contents:

```text id="8xeh6s"
README.md
Strategy Tester report
Balance / equity graph
Supporting Strategy Tester images
```

The README summarizes the important configuration and results.

The original Strategy Tester report remains the primary evidence.

---

# 8. Core Metrics

At minimum, evaluate:

| Metric               | Purpose                             |
| -------------------- | ----------------------------------- |
| Net Profit           | Overall monetary result             |
| Profit Factor        | Gross profit relative to gross loss |
| Expected Payoff      | Average expected result per trade   |
| Maximum Drawdown     | Capital risk                        |
| Total Trades         | Sample size                         |
| Win Rate             | Distribution of winning trades      |
| Average Profit Trade | Average winner                      |
| Average Loss Trade   | Average loser                       |
| Sharpe Ratio         | Risk-adjusted behavior              |
| Recovery Factor      | Recovery relative to drawdown       |

No single metric determines whether a strategy is good.

---

# 9. Profit Factor

Profit Factor is an important first-level metric:

```text id="d98xsp"
Profit Factor =
Gross Profit / Gross Loss
```

Interpretation:

```text id="8o0owc"
PF > 1  → Gross profit exceeds gross loss

PF = 1  → Approximate break-even before other considerations

PF < 1  → Gross loss exceeds gross profit
```

Profit Factor should always be considered together with sample size, drawdown and other performance metrics.

---

# 10. Expected Payoff

Expected Payoff represents the average result per trade.

A strategy with:

```text id="bpfqzg"
Expected Payoff < 0
```

has negative expectancy over the tested sample.

A positive Expected Payoff is desirable, but it is not sufficient by itself to establish robustness.

---

# 11. Drawdown

Drawdown is treated as a primary risk metric.

A strategy may generate positive Net Profit while still being unsuitable because of excessive drawdown.

Always record:

```text id="fujocb"
Absolute Drawdown
Maximal Drawdown
Relative Drawdown
```

Performance and risk must be evaluated together.

---

# 12. Sample Size

Results based on a very small number of trades should not be treated as strong evidence.

Record:

```text id="ob8m9k"
Total Trades
Winning Trades
Losing Trades
Long Trades
Short Trades
```

A larger sample provides more information, but a large sample does not automatically make a strategy profitable or robust.

---

# 13. Trade Distribution

Do not evaluate only the final account balance.

When available, inspect performance by:

```text id="0axuh7"
BUY vs SELL
Hour
Weekday
Month
Holding Time
MFE
MAE
```

These distributions can identify hypotheses for further investigation.

They should not automatically become trading filters.

---

# 14. MFE and MAE

Maximum Favorable Excursion (MFE) measures how far a trade moved favorably while open.

Maximum Adverse Excursion (MAE) measures how far a trade moved against the position while open.

These metrics can help investigate:

```text id="gdtuzx"
Exit efficiency
Stop placement
Profit-taking behavior
Trailing Stop behavior
Break Even behavior
```

MFE/MAE observations generate hypotheses.

They do not prove that changing an exit rule will improve future performance.

---

# 15. Research After Baseline

After the baseline, identify the largest observed weakness.

Examples:

```text id="76sm1x"
Poor entry quality
Weak BUY or SELL side
Excessive trade frequency
Poor reward/risk realization
Excessive drawdown
Session-dependent behavior
Exit inefficiency
```

Then formulate a specific research question.

Example:

```text id="yy6tn0"
Observation:
SELL win rate is lower than BUY win rate.

Research question:
Does SELL contribute disproportionately to negative expectancy?

Experiment:
Test BUY-only and SELL-only separately.
```

Observation and conclusion must remain separate until the experiment is completed.

---

# 16. Controlled Experiments

Change one major hypothesis at a time whenever practical.

Example:

```text id="7wec3v"
Baseline
    ↓
Experiment A — BUY only
    ↓
Experiment B — SELL only
```

Avoid simultaneously changing:

```text id="gdh8jm"
Entry logic
Stop Loss
Take Profit
Time filter
Indicator period
Trailing Stop
```

because the source of any performance change would become difficult to identify.

---

# 17. Compare Against Baseline

Every experiment should be compared with the preserved baseline.

At minimum compare:

```text id="nbsn23"
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Total Trades
Win Rate
Average Winner
Average Loser
```

The question is not simply:

```text id="d17mnj"
Did the new version make money?
```

The more useful question is:

```text id="z8pywg"
Did the tested change improve the strategy
relative to the baseline without creating
an unacceptable new weakness?
```

---

# 18. Avoid Premature Optimization

Do not begin by searching hundreds or thousands of parameter combinations.

First determine whether the underlying strategy logic shows evidence worth investigating.

Preferred sequence:

```text id="odjfl4"
Baseline
    ↓
Identify weakness
    ↓
Form hypothesis
    ↓
Controlled experiment
    ↓
Confirm improvement
    ↓
Only then consider optimization
```

Parameter optimization cannot replace a valid trading hypothesis.

---

# 19. Avoid Overfitting

Historical performance can be improved simply by searching enough combinations.

Therefore, do not select parameters solely because they produced the best historical Net Profit.

Warning signs include:

```text id="wdygxi"
Very narrow profitable parameter ranges
Large performance changes from small parameter changes
Filters selected after inspecting the same test data
Excellent results on only one short period
Large optimization searches with few robust regions
```

The purpose of research is to find behavior that may generalize beyond the data used to discover it.

---

# 20. Version Experiments

Material strategy changes should create a new identifiable version rather than overwrite the baseline implementation.

Example:

```text id="so1ptp"
EA-026_Keltner_Midline
    ↓
EA-026A_BUY_Only
    ↓
EA-026B_Full_Keltner
```

Exact naming may vary, but each experiment must remain traceable to:

```text id="ukuv4c"
Source code
Parameters
Backtest
Result
Research hypothesis
```

---

# 21. PASS / FAIL

A backtest execution and a strategy evaluation are different statuses.

Example:

```text id="xfqfvu"
Backtest execution: PASS
Strategy result:    FAIL
```

A backtest execution can PASS when:

```text id="6h36io"
EA runs successfully
Test completes
Report is generated
Required evidence is saved
```

while the strategy itself can FAIL because:

```text id="krz7uc"
Negative expectancy
Unacceptable drawdown
Insufficient evidence of an edge
```

Never mark a strategy PASS merely because the Strategy Tester completed successfully.

---

# 22. Evidence Requirement

A research conclusion requires evidence.

Minimum evidence:

```text id="6czmhh"
EA source
Exact parameters
Strategy Tester report
Recorded metrics
Research conclusion
```

Do not classify a strategy based only on memory, screenshots without context, or a manually reported profit number.

---

# 23. Research Record

The repository should preserve the chain:

```text id="4s7khc"
Idea
  ↓
EA source
  ↓
Baseline
  ↓
Evidence
  ↓
Finding
  ↓
Hypothesis
  ↓
Experiment
  ↓
Evidence
  ↓
Conclusion
```

This makes failed strategies useful because their results remain available for future comparison.

---

# 24. Validation Before Live Use

A successful baseline or experiment is not automatically live-ready.

A strategy showing promising historical results should undergo additional validation before deployment.

At minimum, later research should consider:

```text id="onrrm3"
Different historical periods
Out-of-sample data
Parameter stability
Different market regimes
Trading costs
Spread sensitivity
Execution assumptions
Forward testing
```

The exact validation process depends on the strategy and should only be expanded when the strategy has first demonstrated sufficient potential to justify further work.

---

# 25. Repository Principle

The repository prioritizes:

```text id="1k16a9"
Reproducibility
    >
Attractive backtest screenshots
```

and:

```text id="3rq7bl"
Evidence
    >
Assumption
```

and:

```text id="90unbv"
Simple test
    →
Measure
    →
Learn
    →
Next experiment
```

The objective is not to prove that every EA works.

The objective is to determine, with preserved evidence, **which trading ideas survive testing and which do not**.
