# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard methodology used to research, backtest, compare, optimize, and validate XAUUSD Expert Advisors in this repository.

The objective is not to maximize historical backtest profit.

The objective is to determine whether a strategy demonstrates a reproducible and sufficiently robust trading edge.

The standard research sequence is:

```text
Strategy Definition
        ↓
Source Implementation
        ↓
Baseline Backtest
        ↓
Baseline Assessment
        ↓
Failure Analysis
        ↓
Controlled Research Questions
        ↓
Controlled Experiments
        ↓
Parameter Optimization
        ↓
Candidate Selection
        ↓
Out-of-Sample Validation
        ↓
Month-by-Month Validation
        ↓
Robustness Testing
        ↓
Forward Testing
        ↓
Final Research Decision
```

---

# 1. Core Research Principle

Every EA begins with a fixed baseline.

The baseline consists of:

```text
Original Strategy Logic
+
Original Source Code
+
Original Parameters
+
Defined Symbol
+
Defined Timeframe
+
Defined Backtest Period
+
MT5 Strategy Tester Evidence
```

Once recorded, the baseline must remain unchanged.

Future experiments must never overwrite the original baseline.

This ensures that every modification can be compared against the same reference.

---

# 2. Repository Structure

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
│       ├── README.md
│       └── Strategy Tester evidence
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

---

# 3. EAs Directory

The `EAs/` directory contains the actual MQL5 implementation.

Example:

```text
EAs/
└── EA-066_Failed_Retest_Break/
    ├── EA-066_Failed_Retest_Break.mq5
    └── README.md
```

The EA README documents:

```text
Strategy Logic
Entry Rules
Exit Rules
Risk Management
Trade Management
Default Inputs
Execution Restrictions
Implementation Details
```

The EA README must not claim profitability unless supported by backtest evidence.

---

# 4. Backtest Directory

The `Backtest/` directory contains primary testing evidence.

Example:

```text
Backtest/
└── EA-066_Failed_Retest_Break/
    ├── README.md
    ├── Strategy Tester HTML
    └── Strategy Tester Images
```

The original Strategy Tester HTML report is the primary numerical evidence.

Images may include:

```text
Balance Curve
Entry Distribution
MFE / MAE
Holding Time
Optimization Results
```

The backtest README summarizes the test.

It does not replace the original Strategy Tester report.

---

# 5. Research Directory

The `Research/` directory contains interpretation and research planning.

It answers:

```text
Why did the baseline PASS or FAIL?

What does the result establish?

What does the result not establish?

What is the next controlled research question?

Which variable should change next?

When is optimization allowed?

Which configurations may proceed to validation?
```

Research conclusions must remain traceable to evidence.

---

# 6. Baseline Backtest

Every EA must first undergo a baseline test before optimization.

Record at minimum:

```text
EA Name
EA Version
Symbol
Timeframe
Test Period
Initial Deposit
Leverage
Lot Size
Data Quality
Broker Environment
Input Parameters
```

Performance metrics should include:

```text
Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Recovery Factor
Sharpe Ratio
Balance Drawdown
Equity Drawdown
Total Trades
Win Rate
Average Winner
Average Loser
```

When available also record:

```text
BUY Trades
SELL Trades
Directional Win Rates
Consecutive Wins
Consecutive Losses
MFE
MAE
Holding Time
Hourly Distribution
Weekday Distribution
Monthly Distribution
```

---

# 7. Data Quality

Real tick data should be preferred whenever available.

Example:

```text
History Quality = 100% real ticks
```

Results generated using different historical data quality should not automatically be treated as equivalent.

Data quality must always be documented.

---

# 8. Baseline Classification

The baseline must be explicitly classified.

Possible statuses:

```text
PASS FOR FURTHER RESEARCH

FAIL

INVALID TEST
```

A baseline should generally be classified as FAIL when:

```text
Net Profit <= 0

Profit Factor <= 1

Expected Payoff <= 0

Drawdown is excessive

Balance curve shows persistent deterioration
```

However, a failed baseline does not automatically invalidate the underlying trading idea.

It establishes only that:

```text
Strategy Implementation
+
Tested Parameters
+
Tested Market
+
Tested Period
```

did not demonstrate a viable edge.

---

# 9. Technical PASS vs Performance PASS

Technical execution and trading performance are separate assessments.

Example:

```text
Technical Execution = PASS
Baseline Performance = FAIL
```

This means:

```text
The EA executed according to its intended logic,
but the resulting trading performance was not viable.
```

A technically correct implementation should not be classified as a successful trading system solely because the code functions correctly.

---

# 10. Failed Baselines Are Evidence

Failed experiments must not be deleted.

A failed baseline provides useful information.

It can establish that:

```text
A specific hypothesis did not work under tested conditions.

A filter did not improve expectancy.

An additional confirmation reduced trade quality.

A timeframe may contain excessive noise.

A particular exit configuration may be inappropriate.
```

Negative results reduce repeated research and help narrow future experiments.

---

# 11. Controlled Research Before Optimization

Broad optimization should not automatically follow a failed baseline.

The preferred process is:

```text
Baseline
        ↓
Identify Primary Weakness
        ↓
Define One Research Question
        ↓
Change One Major Component
        ↓
Backtest
        ↓
Compare with Baseline
```

This is controlled research.

Only after important strategy components are understood should broad parameter optimization begin.

---

# 12. One Major Variable Per Experiment

Whenever practical:

```text
Change one major strategy component at a time.
```

For example:

```text
Experiment 1:
Change Timeframe Only

Experiment 2:
Change Breakout Lookback Only

Experiment 3:
Change Retest Tolerance Only
```

Avoid:

```text
Change Lookback
+
Timeframe
+
Stop Loss
+
Take Profit
+
Trailing Stop
+
Session Filter
```

in one experiment.

If too many variables change simultaneously, the source of improvement cannot be identified.

---

# 13. Research Question Format

Each research experiment should have an explicit question.

Example:

```text
RQ01

Does requiring price to break
the original breakout-candle extreme
after a valid retest improve entry quality?
```

The question should define:

```text
What changes?

What remains fixed?

Which metrics determine the result?
```

---

# 14. Experiment Identification

Experiments should use identifiable names.

Example:

```text
EA066-M1-BASELINE-001

EA066-RQ01-CONTINUATION-001

EA066-RQ02-BUYONLY-001

EA066-RQ03-M5-001
```

The identifier should allow the experiment to be traced to:

```text
EA Version
Research Question
Configuration
Evidence
Result
```

---

# 15. Strategy Comparison

When two related EAs test different versions of the same hypothesis, they may be compared directly if the test conditions are sufficiently similar.

Example:

```text
EA-065
Breakout → Retest → Entry

vs

EA-066
Breakout → Retest → Continuation Break → Entry
```

Compare:

```text
Trade Count
Win Rate
Net Profit
Profit Factor
Expected Payoff
Drawdown
Average Winner
Average Loser
```

The purpose is to determine whether the added logic actually contributes useful information.

---

# 16. More Confirmation Does Not Automatically Mean Better

An important research rule is:

```text
More Filters
or
More Confirmation
≠
Better Strategy
```

Additional confirmation can:

```text
Remove bad trades
```

but it can also:

```text
Remove good trades
Delay entry
Reduce reward potential
Increase adverse entry price
Reduce sample size
```

Every additional filter must therefore demonstrate measurable benefit.

---

# 17. Trade Selectivity

When a new condition reduces trade count, compare:

```text
Trade Reduction
vs
Quality Improvement
```

For example:

```text
Original:
500 trades

Filtered:
350 trades
```

The filtered system should ideally show measurable improvement in metrics such as:

```text
Profit Factor
Expected Payoff
Drawdown
Average Trade
Out-of-Sample Stability
```

Reducing trade count alone is not an improvement.

---

# 18. Directional Analysis

BUY and SELL results should be reviewed separately whenever data is available.

Record:

```text
BUY Trades
BUY Win Rate

SELL Trades
SELL Win Rate
```

If significant asymmetry appears, create a controlled experiment:

```text
BUY + SELL

vs

BUY Only

vs

SELL Only
```

Do not permanently disable one direction based solely on one historical period.

Directional asymmetry is a research hypothesis until independently validated.

---

# 19. Timeframe Research

Many strategy concepts behave differently across timeframes.

Recommended controlled comparison may include:

```text
M1
M5
M15
```

The first timeframe experiment should preserve strategy logic and parameters as much as technically meaningful.

The objective is to answer:

```text
Does reducing short-term market noise improve the strategy?
```

Do not optimize each timeframe independently during the initial comparison.

---

# 20. Entry Research Before Exit Optimization

When the baseline entry logic is clearly weak, entry research should generally occur before large exit optimization.

Preferred sequence:

```text
Entry Quality
        ↓
Market Regime
        ↓
Timeframe
        ↓
Direction
        ↓
Session
        ↓
Exit Management
```

This prevents exit optimization from hiding a poor entry edge.

---

# 21. Exit Management

After entry logic has been investigated, evaluate:

```text
Stop Loss
Take Profit
Break Even
Trailing Stop
```

These components must be tested separately where practical.

---

# 22. Nominal vs Realized Risk/Reward

Configured SL/TP does not necessarily equal actual trade reward/risk.

Example:

```text
SL = 300
TP = 600
```

suggests:

```text
Nominal R:R = 1:2
```

However, actual results may differ because of:

```text
Break Even
Trailing Stop
Spread
Execution
Market Movement
```

Therefore always examine:

```text
Average Profit Trade
Average Loss Trade
```

These represent the realized payoff behavior.

---

# 23. Break-Even Win Rate

A useful diagnostic is the approximate break-even win rate.

Formula:

```text
Break-Even Win Rate
=
Average Loss
/
(Average Win + Average Loss)
```

Example:

```text
Average Win  = 2.30
Average Loss = 2.53

Break-Even Win Rate
=
2.53 / (2.30 + 2.53)

≈ 52.38%
```

This can then be compared with actual win rate.

It is a diagnostic tool, not a complete strategy-validation metric.

---

# 24. Break Even Research

Break Even can protect capital but may also reduce large winners.

Research questions include:

```text
Is Break Even activated too early?

Does Break Even reduce average winner?

Does the strategy benefit from no Break Even?

Should the offset be positive?
```

Test Break Even separately from other major exit changes.

---

# 25. Trailing Stop Research

Trailing Stop can protect unrealized profit but may also terminate trades before continuation develops.

Relevant variables include:

```text
Trailing Start
Trailing Distance
Trailing Step
```

Research should determine whether trailing behavior improves:

```text
Expected Payoff
Average Winner
Drawdown
Profit Factor
```

rather than assuming trailing always improves performance.

---

# 26. MFE / MAE Analysis

Where available:

```text
MFE = Maximum Favorable Excursion

MAE = Maximum Adverse Excursion
```

MFE can help determine:

```text
Whether winners travel much farther than realized profit

Whether TP is realistic

Whether Break Even activates prematurely

Whether trailing exits too early
```

MAE can help determine:

```text
Whether Stop Loss is excessively wide

Whether successful trades normally experience large adverse movement
```

MFE / MAE analysis supports experiment design.

It does not replace independent backtesting.

---

# 27. Holding Time

Record:

```text
Minimum Holding Time
Average Holding Time
Maximum Holding Time
```

Short holding times increase sensitivity to:

```text
Spread
Slippage
Execution latency
Broker feed
Tick behavior
```

A system averaging only a few minutes per trade requires particularly careful execution analysis.

---

# 28. Trading Session Analysis

Before introducing a trading-session filter, measure existing performance by time.

Potential groups:

```text
Asia
Europe
US
```

Compare:

```text
Trade Count
Win Rate
Net Profit
Expected Payoff
```

A session should only be removed when evidence supports the restriction.

---

# 29. Market Regime

XAUUSD behavior varies across:

```text
Trend
Range
High Volatility
Low Volatility
News Expansion
Choppy Conditions
```

A strategy does not have to perform equally in every regime.

However, dependence on a specific regime should be documented.

Future filters may be tested only when there is a clear research hypothesis.

---

# 30. Optimization

Optimization is allowed only after controlled research identifies meaningful parameters.

Do not optimize every input simply because MetaTrader supports it.

Optimization should answer:

```text
Where is the stable parameter region?
```

not:

```text
Which single parameter combination gives the highest profit?
```

---

# 31. Optimization Surface

A candidate is more interesting when nearby parameter values also produce acceptable behavior.

Example:

```text
Lookback 18 → acceptable
Lookback 20 → acceptable
Lookback 22 → acceptable
```

is generally more robust than:

```text
Lookback 19 → poor
Lookback 20 → exceptional
Lookback 21 → poor
```

The second example may indicate an isolated optimization spike.

---

# 32. Optimization Metrics

Do not select candidates using only:

```text
Net Profit
```

Review:

```text
Net Profit
Profit Factor
Expected Payoff
Drawdown
Recovery Factor
Trade Count
Balance Curve
Neighbor Stability
```

---

# 33. Candidate Selection

After optimization, reduce results to a small number of candidate configurations.

Example:

```text
Candidate A
Candidate B
Candidate C
```

Record:

```text
Parameter Set
Net Profit
Profit Factor
Expected Payoff
Drawdown
Trade Count
Win Rate
```

Candidates must be frozen before independent validation.

---

# 34. Out-of-Sample Validation

Optimization and validation data must be separated.

Sequence:

```text
In-Sample Research
        ↓
Candidate Selected
        ↓
Parameters Frozen
        ↓
Out-of-Sample Test
```

Do not alter parameters after observing out-of-sample results while continuing to classify the test as independent.

Changing parameters begins a new research iteration.

---

# 35. Month-by-Month Validation

Aggregated results can hide unstable behavior.

Where practical, evaluate candidates separately by month.

Record:

```text
Net Profit
Profit Factor
Expected Payoff
Drawdown
Trades
Win Rate
```

The objective is to identify whether total profitability depends on one exceptional period.

---

# 36. Robustness Testing

A candidate should not receive research validation from one profitable test.

Review:

```text
Neighbor Parameter Stability

Different Historical Periods

Out-of-Sample Data

Monthly Stability

Directional Stability

Trade Sample Size

Execution Sensitivity

No Single-Trade Dependency

No Single-Month Dependency
```

---

# 37. Forward Testing

Only candidates that survive historical validation should proceed to forward testing.

Forward testing should use:

```text
Frozen EA Version
Frozen Parameters
Documented Broker Environment
No Historical Re-Optimization During Test
```

Any parameter change begins a new forward-test version.

---

# 38. Fixed Lot During Strategy Research

Keep lot size fixed during core strategy comparison whenever possible.

Example:

```text
Lot = 0.01
```

This isolates strategy behavior from position-sizing effects.

Risk-based sizing should be evaluated only after a viable strategy edge is established.

---

# 39. Strategy Edge vs Money Management

Research should separate:

```text
Strategy Edge
```

from:

```text
Position Sizing
```

Preferred order:

```text
Find Positive Expectancy
        ↓
Validate Strategy
        ↓
Then Research Position Sizing
```

A poor entry strategy should not be disguised by aggressive money management.

---

# 40. Drawdown

Drawdown is a primary risk metric.

Always review:

```text
Balance Drawdown
Equity Drawdown
```

Extreme drawdown can invalidate a configuration even when final Net Profit is positive.

Drawdown must be evaluated relative to:

```text
Initial Capital
Net Profit
Strategy Frequency
Expected Return
```

---

# 41. Profit Factor

Profit Factor:

```text
Gross Profit / Absolute Gross Loss
```

Basic interpretation:

```text
PF < 1
Gross Loss > Gross Profit

PF = 1
Approximately break-even

PF > 1
Gross Profit > Gross Loss
```

Profit Factor must be considered with:

```text
Trade Count
Drawdown
Expected Payoff
Validation Period
```

---

# 42. Expected Payoff

Expected Payoff represents average historical result per trade in the Strategy Tester report.

A negative Expected Payoff indicates negative historical expectancy for the tested configuration.

A future candidate should normally require:

```text
Expected Payoff > 0
```

before proceeding to deeper validation.

---

# 43. Balance Curve

Always visually inspect the balance curve.

Look for:

```text
Stable Growth

Persistent Decline

Large Recovery Cycles

Long Stagnation

Single Profit Spike

Late-Test Collapse

Regime Dependence
```

A final positive balance alone does not establish robustness.

---

# 44. Evidence Policy

No research stage should be marked complete without evidence.

Accepted artifacts include:

```text
.mq5 source
.set parameter file
MT5 HTML report
Optimization XML
Strategy Tester screenshots
CSV exports
Research README
Experiment notes
```

Claims such as:

```text
Profitable
Optimized
Robust
Validated
```

require supporting evidence.

---

# 45. Source Versioning

If strategy logic changes materially, preserve traceability.

Possible versioning:

```text
EA-066
EA-066A
EA-066B
```

or another consistent naming convention.

Do not silently replace the original source implementation.

Every backtest must be attributable to the exact EA version that generated it.

---

# 46. Reproducibility

A valid experiment should be reproducible from:

```text
EA Source
+
Input Parameters
+
Symbol
+
Timeframe
+
Test Period
+
Data Quality
+
Broker Environment
```

If any component is unknown, document the limitation.

---

# 47. PASS / FAIL Policy

A task is not PASS simply because a file exists.

Research PASS requires:

```text
Artifact
+
Test
+
Evidence
+
Review
```

A baseline PASS means only:

```text
Suitable for additional research.
```

It does not mean:

```text
Approved for live trading.
```

---

# 48. Research Status Labels

Use explicit statuses:

```text
PENDING
RUNNING
COMPLETE
PASS
FAIL
BLOCKED
IN PROGRESS
NOT STARTED
NOT APPROVED
```

Example:

```text
Strategy Code        = COMPLETE
Baseline Backtest    = COMPLETE
Technical Execution  = PASS
Baseline Performance = FAIL
Research             = IN PROGRESS
Optimization         = BLOCKED
Out-of-Sample        = NOT STARTED
Forward Test         = NOT STARTED
Live Trading         = NOT APPROVED
```

---

# 49. EA-066 Methodology Example

Current EA:

```text
EA-066_Failed_Retest_Break
```

Strategy:

```text
Historical Range
        ↓
Breakout
        ↓
Retest
        ↓
Retest Rejection
        ↓
Break Original Breakout Extreme
        ↓
Entry
```

Baseline environment:

```text
Symbol             = XAUUSD.PRO
Timeframe          = M1
Period             = 2026-01-02 → 2026-03-31
Initial Deposit    = $100
Lot                = 0.01
History Quality    = 100% real ticks
```

Baseline performance:

```text
Trades             = 382

Win Rate           = 47.38%

BUY Win Rate       = 51.50%

SELL Win Rate      = 40.94%

Net Profit         = -$92.01

Profit Factor      = 0.82

Expected Payoff    = -$0.24

Max Equity DD      = 92.01%

Average Winner     = +$2.30

Average Loser      = -$2.53
```

Classification:

```text
Baseline Performance = FAIL
```

---

# 50. EA-066 Primary Finding

EA-066 adds an additional continuation requirement after a successful retest.

Compared with the simpler EA-065 structure:

```text
EA-065:
Breakout
→ Retest
→ Entry

EA-066:
Breakout
→ Retest
→ Continuation Break
→ Entry
```

The added condition reduced trade frequency.

However, under the baseline conditions it did not improve:

```text
Win Rate
Profit Factor
Expected Payoff
```

This demonstrates an important methodological principle:

```text
A strategy modification must demonstrate measurable value.

Additional complexity is not automatically an improvement.
```

---

# 51. EA-066 Research Sequence

The authorized research sequence is:

```text
EA066-M1-BASELINE-001
        ↓
RQ01 — Continuation Break Requirement
        ↓
RQ02 — BUY vs SELL Directionality
        ↓
RQ03 — Timeframe Evaluation
        ↓
RQ04 — Breakout Lookback
        ↓
RQ05 — Breakout Buffer
        ↓
RQ06 — Retest Tolerance
        ↓
RQ07 — Retest Maximum Bars
        ↓
RQ08 — Trading Session
        ↓
RQ09 — Break Even
        ↓
RQ10 — Trailing Stop
        ↓
Controlled Optimization
        ↓
Candidate Selection
        ↓
Out-of-Sample Validation
        ↓
Month-by-Month Validation
        ↓
Robustness Test
        ↓
Forward Test
```

Broad optimization is currently:

```text
BLOCKED
```

until the primary controlled research questions are evaluated.

---

# 52. EA-066 Current Status

```text
EA ID                  = EA-066

Strategy               = Failed Retest Break

Source Code            = COMPLETE

Baseline Backtest      = COMPLETE

Technical Execution    = PASS

Baseline Performance   = FAIL

Research               = IN PROGRESS

Broad Optimization     = BLOCKED

Candidate Selection    = NOT STARTED

Out-of-Sample          = NOT STARTED

Month Validation       = NOT STARTED

Robustness Test        = NOT STARTED

Forward Test           = NOT STARTED

Live Trading           = NOT APPROVED
```

---

# 53. Final Methodology Rule

The repository follows this principle:

```text
Preserve the baseline.

Test the simplest hypothesis first.

Do not change multiple major variables without reason.

Do not assume more confirmation means better entries.

Do not optimize before understanding the strategy.

Do not select candidates using profit alone.

Search for stable parameter regions.

Validate outside optimization data.

Check multiple periods.

Separate entry edge from exit management.

Separate strategy edge from position sizing.

Preserve failed experiments.

Require evidence for every conclusion.

Do not approve an EA from one historical backtest.
```

The objective of this methodology is not to create the best-looking historical equity curve.

The objective is to determine whether a trading hypothesis survives controlled testing, independent validation, and robustness analysis before it is considered for any further deployment stage.
