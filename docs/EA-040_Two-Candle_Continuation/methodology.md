# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the standard research, implementation, backtesting, and validation methodology used in the **XAUUSD MT5 EA Research** repository.

The primary research market is:

**XAUUSD — Gold**

The objective of this repository is not to collect trading strategies or produce optimized backtests without context.

The objective is to create a reproducible research process that converts trading ideas into explicit rules, executable MetaTrader 5 Expert Advisors, measurable backtest evidence, and documented conclusions.

The standard workflow is:

```text
Trading Idea
    ↓
Research
    ↓
Explicit Trading Rules
    ↓
Minimum Working EA
    ↓
Compile & Functional Test
    ↓
Baseline Backtest
    ↓
Record Evidence
    ↓
PASS / FAIL Evaluation
    ↓
Research Analysis
    ↓
Controlled Modification
    ↓
Retest
    ↓
Validation
```

---

## 2. Core Research Principle

Every EA begins as a hypothesis.

A strategy must not be considered successful simply because:

- The trading idea sounds logical
- The source is credible
- The strategy works visually on selected charts
- One backtest is profitable
- One optimized parameter set performs well

The strategy must be converted into explicit rules and tested using reproducible conditions.

The research process must preserve both successful and failed results.

A failed experiment is valid research evidence when:

```text
Rules are documented
+
Code is preserved
+
Test conditions are known
+
Backtest evidence is preserved
+
Result is measurable
```

---

## 3. Strategy Research

The first stage is to define the trading hypothesis.

Examples of research sources may include:

- Trading books
- Research papers
- Trading-system documentation
- Strategy notes
- Price-action concepts
- Technical-analysis concepts
- Existing trading systems
- Observations derived from market data

A research source alone is not an executable strategy.

The concept must first be converted into deterministic trading rules.

---

## 4. Converting Ideas Into Explicit Rules

Every strategy must define, where applicable:

```text
Market
Timeframe
Trend condition
Entry condition
Exit condition
Stop Loss
Take Profit
Position sizing
Spread filter
Trading session
Break Even
Trailing Stop
Maximum concurrent positions
Other filters
```

Subjective rules should be avoided.

Example of an insufficient rule:

```text
BUY when the market looks strongly bullish.
```

Example of an explicit rule:

```text
Fast SMA > Slow SMA
AND
Candle[1].Close > Candle[1].Open
AND
Candle[2].Close > Candle[2].Open
→ BUY
```

The implementation should reproduce the documented rule without requiring discretionary interpretation.

---

## 5. Minimum Working EA

The first implementation should be the smallest version capable of testing the strategy hypothesis.

Do not begin by building unnecessary complexity.

Preferred sequence:

```text
Minimum Working Strategy
        ↓
Compile
        ↓
Run
        ↓
Verify Entries
        ↓
Backtest
        ↓
Analyze
        ↓
Improve Only If Necessary
```

The purpose of the first EA version is to determine whether the underlying trading concept has measurable potential.

---

## 6. EA Implementation Requirements

Each EA should be stored under:

```text
EAs/
└── EA-XXX_Strategy-Name/
    ├── EA-XXX_Strategy-Name.mq5
    └── README.md
```

The EA README should document at minimum:

```text
Strategy name
Strategy concept
Entry rules
Exit rules
Trend/filter logic
Risk parameters
Position-management logic
Default inputs
Platform
Current research status
```

The source code and README should describe the same strategy.

If strategy logic changes materially, the documentation must also be updated.

---

## 7. Functional Verification

Before evaluating profitability, verify that the EA functions as intended.

At minimum confirm:

```text
EA compiles successfully
EA can run in MT5 Strategy Tester
BUY conditions trigger correctly
SELL conditions trigger correctly
Stop Loss is applied
Take Profit is applied
Position sizing is correct
Filters behave as intended
Position-management logic behaves as intended
No obvious execution errors occur
```

A profitable result does not compensate for incorrect implementation.

If the EA does not execute the intended strategy logic, the backtest is invalid.

---

## 8. Baseline Backtest

Every EA must have a baseline backtest before optimization.

The baseline represents the original implemented strategy using a clearly documented parameter configuration.

The baseline must be preserved.

Its purpose is to answer:

```text
How does the original strategy perform before optimization?
```

The baseline should not be replaced when later versions perform better.

It remains the reference point for future comparisons.

---

## 9. Backtest Environment

Each baseline backtest should record at minimum:

```text
Expert Advisor
Symbol
Timeframe
Test period
Initial deposit
Currency
Leverage
History quality
Input parameters
Number of trades
```

Where available, use high-quality historical data.

For MetaTrader 5 testing, **real ticks** are preferred when practical.

The exact broker symbol should be recorded because XAUUSD contract specifications, spreads, execution characteristics, and symbol naming can differ between brokers.

---

## 10. Backtest Evidence

Backtest evidence should be stored under:

```text
Backtest/
└── EA-XXX_Strategy-Name/
```

Recommended contents:

```text
README.md
MT5 Strategy Tester HTML report
Balance graph
Trade-distribution charts
MFE / MAE chart
Holding-time chart
Other relevant Strategy Tester artifacts
```

The original MT5 Strategy Tester report should be retained whenever possible.

Screenshots alone should not replace the underlying report when the complete report is available.

---

## 11. Minimum Performance Metrics

Each baseline should record at minimum:

```text
Total Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Maximum Drawdown
Total Trades
Winning Trades
Losing Trades
Win Rate
Average Winning Trade
Average Losing Trade
Maximum Consecutive Losses
Sharpe Ratio
```

Additional metrics may be recorded when useful.

No single metric should be used as the sole proof that a strategy is robust.

---

## 12. Baseline PASS / FAIL

Each baseline test must receive an explicit status:

```text
PASS
or
FAIL
```

The status must be supported by recorded evidence.

A baseline should not be marked PASS simply because:

```text
Net Profit > 0
```

Evaluation should consider the complete performance profile, including:

```text
Profitability
Drawdown
Trade sample size
Expected payoff
Profit Factor
Risk-adjusted performance
Equity behavior
Strategy stability
```

A FAIL result must be preserved.

Do not delete or hide failed strategies.

---

## 13. Research After Baseline

After the baseline is completed, analyze the evidence before modifying the EA.

The process should be:

```text
Observed Result
        ↓
Identify Problem
        ↓
Form Hypothesis
        ↓
Design Controlled Change
        ↓
Implement
        ↓
Retest
        ↓
Compare
```

Example:

```text
Observation:
Large number of losing trades.

Hypothesis:
Entry conditions may be too permissive.

Experiment:
Add one clearly defined entry-quality filter.

Retest:
Compare against baseline.
```

The explanation remains a hypothesis until testing provides evidence.

---

## 14. Controlled Experiments

Whenever practical, modify one logical component at a time.

Preferred:

```text
Baseline
    ↓
Experiment A — Entry Filter
    ↓
Experiment B — Trend Filter
    ↓
Experiment C — Session Filter
    ↓
Experiment D — Exit Logic
```

Avoid:

```text
Change entry
+
Change timeframe
+
Change MA
+
Change SL
+
Change TP
+
Add session filter
+
Optimize everything
```

If many variables change simultaneously, it becomes difficult to determine why performance changed.

---

## 15. Parameter Optimization

Optimization should occur only after the baseline strategy has been understood.

Optimization must not be used to disguise a weak strategy.

The correct order is:

```text
Baseline
    ↓
Understand Weaknesses
    ↓
Improve Strategy Logic
    ↓
Controlled Tests
    ↓
Parameter Optimization
```

Optimization results should always be compared with the original baseline.

Parameter sets that perform exceptionally well only within a narrow historical sample should be treated cautiously.

---

## 16. Avoiding Overfitting

Overfitting occurs when a strategy becomes excessively adapted to historical data rather than capturing a repeatable market behavior.

Warning signs include:

```text
Very narrow profitable parameter ranges
Large performance changes from small parameter adjustments
Excellent in-sample results but poor unseen-data results
Too many filters
Too many optimized parameters
Rules created specifically to eliminate historical losing trades
```

Prefer simpler strategies when two approaches produce similar performance.

Complexity should only be added when evidence demonstrates that it provides meaningful improvement.

---

## 17. In-Sample and Out-of-Sample Testing

When a strategy becomes a promising candidate, historical data should be separated where practical into:

```text
In-Sample
and
Out-of-Sample
```

### In-Sample

Used for:

```text
Research
Parameter exploration
Strategy development
```

### Out-of-Sample

Used for:

```text
Independent validation
```

Out-of-sample data should not be repeatedly used to redesign the strategy, otherwise it effectively becomes part of the development sample.

---

## 18. Robustness Testing

A strategy that passes initial research should undergo additional robustness testing before being considered a validated candidate.

Possible tests include:

```text
Different historical periods
Different market regimes
Parameter sensitivity
Spread sensitivity
Execution-cost sensitivity
Alternative XAUUSD data
Alternative timeframes where logically applicable
Out-of-sample testing
Forward testing
```

Not every experiment requires every robustness test.

Robustness testing becomes more important as a strategy progresses toward practical deployment.

---

## 19. Research Stages

Strategies should progress through clearly separated stages:

```text
IDEA
  ↓
RULES DEFINED
  ↓
EA IMPLEMENTED
  ↓
BASELINE TESTED
  ↓
RESEARCH
  ↓
CANDIDATE
  ↓
VALIDATION
  ↓
FORWARD TEST
  ↓
PILOT
```

Progression should depend on evidence.

A strategy must not be promoted merely because further progress is desired.

---

## 20. Evidence Before Approval

A task or strategy stage should not be considered complete based only on an AI-generated conclusion.

Completion requires appropriate evidence.

General principle:

```text
Artifact
+
Test
+
Evidence
+
Required Approval
=
Completed Stage
```

AI may:

```text
Analyze results
Identify anomalies
Generate hypotheses
Compare experiments
Prepare documentation
Recommend next tests
```

AI should not fabricate missing evidence or automatically approve a strategy when human or domain review is required.

---

## 21. Repository Structure

The repository follows this structure:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-XXX_Strategy-Name/
│       ├── EA-XXX_Strategy-Name.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-XXX_Strategy-Name/
│       ├── README.md
│       └── Backtest evidence
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

---

## 22. Role of Each Directory

### `EAs/`

Contains executable MQL5 strategy implementations and strategy-specific documentation.

### `Backtest/`

Contains empirical Strategy Tester results and evidence associated with each EA.

### `Research/`

Documents research principles, current research questions, hypotheses, observations, and the relationship between strategy ideas and experiments.

### `docs/`

Contains repository-level methodology and documentation standards.

### `GitHub_Profile/`

Contains presentation material intended for the public GitHub profile.

---

## 23. Reproducibility

Another researcher should be able to understand:

```text
What was tested?
Why was it tested?
Which code was used?
Which parameters were used?
Which market was tested?
Which period was tested?
What happened?
Why was it marked PASS or FAIL?
What should be tested next?
```

If these questions cannot be answered from the repository, the experiment is insufficiently documented.

---

## 24. EA-040 Example

The current EA-040 research provides an example of the methodology.

```text
Two-Candle Continuation Idea
        ↓
Explicit Rules
        ↓
EA-040_Two-Candle_Continuation.mq5
        ↓
XAUUSD.PRO M1 Baseline
        ↓
4,630 Trades
        ↓
Profit Factor 0.88
        ↓
Net Profit -$993.54
        ↓
Maximum Drawdown 99.37%
        ↓
BASELINE FAIL
        ↓
Research Required
```

The failed baseline is preserved rather than discarded.

Its purpose is to establish measurable evidence and provide a reference for subsequent experiments.

---

## 25. Research Record

For each meaningful experiment, record:

```text
EA:
Version:
Date:

Research Question:

Hypothesis:

Previous/Baseline Configuration:

Change Introduced:

What Was NOT Changed:

Symbol:
Timeframe:
Test Period:
History Quality:
Initial Deposit:

Total Net Profit:
Profit Factor:
Expected Payoff:
Maximum Drawdown:
Total Trades:
Win Rate:
Sharpe Ratio:

Result:
PASS / FAIL

Evidence:

Interpretation:

Conclusion:

Next Experiment:
```

---

## 26. Final Methodology Principle

The repository follows one fundamental cycle:

```text
IDEA
  ↓
RULES
  ↓
CODE
  ↓
TEST
  ↓
EVIDENCE
  ↓
ANALYZE
  ↓
DECIDE
  ↓
ITERATE
```

Do not optimize before establishing a baseline.

Do not hide failed experiments.

Do not treat hypotheses as evidence.

Do not treat backtest profitability as proof of robustness.

Do not add complexity without evidence that it is necessary.

Preserve reproducibility throughout the research process.

The goal is not to produce the best-looking backtest.

The goal is to determine whether a trading hypothesis can survive systematic testing and become a credible XAUUSD automated trading candidate.
