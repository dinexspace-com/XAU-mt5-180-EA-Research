# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the research methodology used in this repository for developing, testing, and evaluating MetaTrader 5 Expert Advisors for XAUUSD.

The objective is to maintain a simple and reproducible research process:

```text
Strategy Idea
    ↓
EA Implementation
    ↓
Baseline Backtest
    ↓
Result Analysis
    ↓
Research Hypothesis
    ↓
Controlled Experiment
    ↓
Validation
```

The purpose is not to find the best-looking backtest.

The purpose is to determine whether a trading idea demonstrates a repeatable and measurable edge under controlled testing.

---

# 2. Repository Structure

Each part of the repository has a specific responsibility.

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-XXX_<Strategy_Name>/
│       ├── EA-XXX_<Strategy_Name>.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-XXX_<Strategy_Name>/
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

Contains the actual MQL5 implementation.

Each EA folder should contain:

```text
EA-XXX_<Strategy_Name>.mq5
README.md
```

The `.mq5` source code is the authoritative source for implemented trading logic.

The README explains the strategy in human-readable form.

---

### `Backtest/`

Contains Strategy Tester evidence.

Each EA should have its own folder:

```text
Backtest/
└── EA-XXX_<Strategy_Name>/
```

This may contain:

```text
README.md
Strategy Tester HTML report
Balance chart
Trade-distribution charts
MFE / MAE charts
Holding-time charts
Other supporting test artifacts
```

The original Strategy Tester report is the authoritative source for numerical backtest results.

---

### `Research/`

Contains research conclusions and experimental hypotheses derived from the EA implementation and backtest evidence.

Research documentation should distinguish clearly between:

```text
FACT
HYPOTHESIS
EXPERIMENT
RESULT
```

A hypothesis must never be presented as a confirmed finding before it has been tested.

---

### `docs/`

Contains repository-level documentation such as this methodology.

It defines **how research is performed**, rather than documenting the performance of a particular EA.

---

# 3. Research Principles

## 3.1 Start With the Simplest Testable Strategy

The initial EA should implement the smallest version of the trading hypothesis that can be tested.

Avoid adding multiple filters, indicators, position-management systems, or optimization layers before the baseline strategy has been measured.

Preferred sequence:

```text
Simple idea
→ Working EA
→ Baseline test
→ Evidence
→ Improve
```

Not:

```text
Idea
→ Many indicators
→ Many filters
→ Optimization
→ Good-looking result
```

---

## 3.2 Establish a Baseline First

Every strategy must have a baseline.

The baseline provides the reference against which future modifications are evaluated.

Record at minimum:

```text
Symbol
Timeframe
Testing period
Historical-data quality

Initial deposit
Leverage

Strategy parameters

Net Profit
Profit Factor
Expected Payoff
Win Rate
Maximum Drawdown
Total Trades
```

Without a baseline, improvements cannot be measured objectively.

---

# 4. Backtest Procedure

## Step 1 — Compile the EA

The EA should compile successfully in MetaEditor before testing.

Any compilation errors must be resolved before the test is considered valid.

---

## Step 2 — Record Test Configuration

Before evaluating results, record:

```text
EA version
Symbol
Timeframe
Date range
Initial deposit
Leverage
Input parameters
Historical-data quality
```

This allows the experiment to be reproduced later.

---

## Step 3 — Run Strategy Tester

Where available, use high-quality tick data.

For the current XAUUSD research workflow, **100% real ticks** is preferred for baseline and validation tests.

The exact broker symbol and trading conditions should also be retained because XAUUSD specifications can differ between brokers.

---

## Step 4 — Save Evidence

Do not keep only screenshots of selected statistics.

Preserve the original Strategy Tester report whenever possible.

Recommended artifacts:

```text
Strategy Tester HTML report
Balance / equity graph
Trade-distribution graph
MFE / MAE graph
Holding-time graph
README analysis
```

This preserves both the numerical results and supporting evidence.

---

# 5. Core Evaluation Metrics

No strategy should be evaluated using Net Profit alone.

## Net Profit

```text
Net Profit = Gross Profit + Gross Loss
```

Shows the final monetary result of the test.

Positive Net Profit alone does not prove that a strategy is robust.

---

## Profit Factor

```text
Profit Factor =
Gross Profit / |Gross Loss|
```

Interpretation:

```text
PF < 1.0 → Losing test
PF = 1.0 → Approximately break-even
PF > 1.0 → Positive historical expectancy
```

Profit Factor should always be considered together with trade count and drawdown.

---

## Expected Payoff

Measures average profit or loss per trade.

```text
Expected Payoff > 0
```

is required for a positive historical expectancy in the tested sample.

---

## Win Rate

```text
Win Rate =
Winning Trades / Total Trades
```

Win Rate should never be evaluated independently.

A low-win-rate strategy can still be profitable if winners are sufficiently larger than losers.

Likewise, a high-win-rate strategy can still lose money if losses are disproportionately large.

---

## Average Win / Average Loss

Compare:

```text
Average Winning Trade
vs
Average Losing Trade
```

This helps explain the relationship between Win Rate and overall expectancy.

---

## Maximum Drawdown

Drawdown measures the decline from a previous account peak.

Both balance and equity drawdown should be reviewed.

A profitable strategy with extreme drawdown may still be unsuitable for practical deployment.

---

## Sharpe Ratio

Sharpe Ratio provides additional information about risk-adjusted performance.

It should be treated as one diagnostic metric rather than a standalone acceptance criterion.

---

## Recovery Factor

Recovery Factor helps evaluate profit relative to drawdown.

A strategy that produces profit only by accepting extreme drawdown should not automatically be considered successful.

---

## Trade Count

Sample size matters.

A result based on very few trades provides less evidence than a result based on a sufficiently large sample.

There is no universal minimum trade count that guarantees validity.

Trade count should therefore be evaluated together with strategy frequency, test duration and market coverage.

---

# 6. Diagnostic Analysis

After the headline statistics, examine how the strategy behaves.

## BUY vs SELL

Compare directional performance separately where possible.

Differences between BUY and SELL can generate a research hypothesis.

They do not automatically justify disabling one direction.

---

## Time Analysis

Analyze performance by:

```text
Hour
Weekday
Month
Market session
```

This may reveal periods in which the strategy behaves differently.

Time filters should only be introduced after this difference has been tested.

---

## MFE

Maximum Favorable Excursion measures how far price moved favorably while a trade was open.

MFE can help investigate whether:

```text
Take Profit is too close
Take Profit is too far
Profitable moves are being exited inefficiently
```

---

## MAE

Maximum Adverse Excursion measures adverse movement while the trade was open.

MAE can help investigate whether:

```text
Stop Loss is too tight
Stop Loss is unnecessarily wide
Losing trades can be identified earlier
```

MFE and MAE should generate hypotheses.

They should not automatically determine new SL/TP parameters.

---

## Holding Time

Analyze:

```text
Minimum holding time
Average holding time
Maximum holding time
Profit vs holding time
```

This helps characterize whether the EA behaves as a short-duration, intraday, or longer-duration strategy.

---

# 7. From Result to Hypothesis

After the baseline test, identify the most important weakness.

Example:

```text
OBSERVATION
High number of losing trades

        ↓

QUESTION
Are weak breakout signals being accepted?

        ↓

HYPOTHESIS
A trend filter may improve entry quality.

        ↓

EXPERIMENT
Baseline + one trend filter

        ↓

COMPARE
Experiment vs Baseline
```

This distinction is important.

An observation is evidence.

A hypothesis is an explanation that still requires testing.

---

# 8. One Major Variable at a Time

Whenever practical, change one major strategy component per experiment.

Preferred:

```text
Baseline
vs
Baseline + Filter A
```

Avoid initially testing:

```text
New Indicator
+ New Stop Loss
+ New Take Profit
+ Session Filter
+ Trailing Stop
+ New Keltner Settings
```

all at once.

If the result improves, changing many variables simultaneously makes it difficult to determine why.

---

# 9. Experiment Naming

Experiments should be identifiable and reproducible.

Example:

```text
EA-027_BASELINE
EA-027_H1_BUY_ONLY
EA-027_H1_SELL_ONLY
EA-027_H2_TREND_FILTER
EA-027_H3_BREAKOUT_THRESHOLD
```

The name should identify:

```text
EA
Experiment
Major variable being tested
```

---

# 10. Experiment Comparison

Each experiment should be compared directly with its baseline.

Example:

| Metric          | Baseline | Experiment |
| --------------- | -------: | ---------: |
| Net Profit      |        — |          — |
| Profit Factor   |        — |          — |
| Expected Payoff |        — |          — |
| Win Rate        |        — |          — |
| Max Drawdown    |        — |          — |
| Total Trades    |        — |          — |

The question is not simply:

> Did the experiment make more money?

The correct question is:

> Did the modification improve the strategy's risk/return characteristics sufficiently to justify further validation?

---

# 11. Research PASS / FAIL

## Baseline FAIL

A baseline should normally be classified as failed when the tested configuration demonstrates negative expectancy, such as:

```text
Net Profit < 0
Profit Factor < 1
Expected Payoff < 0
```

or when the risk profile is clearly unacceptable.

A failed baseline is still useful research evidence.

---

## Experimental PASS

A preliminary experimental PASS should require at least:

```text
Net Profit > 0
Profit Factor > 1
Expected Payoff > 0
```

together with acceptable drawdown and a meaningful trade sample.

PASS means:

```text
Worth further validation
```

It does **not** mean:

```text
Ready for live trading
```

---

## Experimental FAIL

An experiment should fail when it:

```text
Maintains negative expectancy
Produces unacceptable drawdown
Improves returns only by substantially increasing risk
Uses an insufficient sample
Does not materially improve the baseline
```

Failed experiments should remain documented.

---

# 12. Avoid Overfitting

Parameter optimization creates a significant risk of fitting the strategy to historical noise.

Therefore:

### Do not optimize everything simultaneously.

### Do not select parameters only because they produce the highest historical profit.

### Do not repeatedly modify the same historical period until an attractive equity curve appears.

### Do not treat one profitable backtest as validation.

Optimization should begin only after the underlying strategy shows evidence worth developing.

---

# 13. Validation Stages

A promising strategy should progress through increasingly demanding stages.

```text
Baseline Backtest
      ↓
Controlled Experiments
      ↓
Candidate Strategy
      ↓
Out-of-Sample Test
      ↓
Robustness Tests
      ↓
Forward / Demo Test
      ↓
Pilot
      ↓
Live consideration
```

Not every strategy needs to reach the final stage.

A strategy should stop progressing when evidence no longer supports it.

---

# 14. Out-of-Sample Testing

Once parameters or rules have been developed using one dataset, evaluate them on data that was not used to design the strategy.

Conceptually:

```text
Historical Data
│
├── Development / In-Sample
│
└── Validation / Out-of-Sample
```

The Out-of-Sample period should not be repeatedly used to redesign the strategy.

Otherwise it effectively becomes part of the development sample.

---

# 15. Robustness Testing

Strategies that survive initial Out-of-Sample testing can be subjected to additional robustness checks.

Depending on the strategy, these may include:

```text
Different historical periods
Different market regimes
Spread variation
Execution/slippage assumptions
Parameter sensitivity
Nearby parameter values
Different broker data
```

The objective is not to prove that the strategy will remain profitable.

The objective is to determine whether results depend excessively on one narrow historical configuration.

---

# 16. Forward Testing

Before live deployment, promising candidates should be observed using new market data.

Preferred progression:

```text
Backtest
→ Out-of-Sample
→ Forward / Demo
→ Small Pilot
→ Scale only after evidence
```

Forward testing should preserve the strategy rules established before the forward period begins.

---

# 17. Evidence Rule

Every important research conclusion should be traceable to evidence.

Preferred structure:

```text
Claim
↓
Test configuration
↓
Original Strategy Tester report
↓
Metrics / charts
↓
Research conclusion
```

Do not declare a strategy successful without preserving the underlying test artifact.

---

# 18. Version Discipline

The research repository should preserve the relationship between:

```text
EA source code
    ↕
Parameters
    ↕
Backtest
    ↕
Research conclusion
```

If strategy logic changes materially, the new result should be treated as a new experiment or version.

Do not silently replace the source code associated with an existing historical backtest.

---

# 19. Research Workflow

The standard workflow for each EA is:

```text
01 — Define strategy hypothesis

02 — Implement minimal EA

03 — Verify EA logic

04 — Run baseline backtest

05 — Save original evidence

06 — Record baseline metrics

07 — PASS / FAIL baseline

08 — Identify the largest weakness

09 — Define one testable hypothesis

10 — Modify one major variable

11 — Backtest experiment

12 — Compare against baseline

13 — Record PASS / FAIL

14 — Repeat only when evidence justifies it

15 — Validate promising candidate

16 — Forward test before live consideration
```

---

# 20. Research Standard

The repository follows one central principle:

> **Code defines what was tested. Evidence shows what happened. Research explains what should be tested next.**

The goal is not to produce impressive historical charts.

The goal is to build a transparent research trail in which every strategy decision can be traced back to an implementation, a test and supporting evidence.

---

## Disclaimer

All Expert Advisors, backtests and research contained in this repository are for quantitative research and development purposes.

Historical and simulated results do not guarantee future performance. Trading leveraged financial instruments involves substantial risk.
