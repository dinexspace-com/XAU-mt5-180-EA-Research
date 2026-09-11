# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the standard research, implementation, backtesting, validation, and documentation methodology used in the:

```text
xauusd-mt5-ea-research
```

repository.

The objective of the repository is to convert trading ideas into explicit mechanical rules, implement those rules as MetaTrader 5 Expert Advisors, and evaluate them using reproducible historical testing.

The general workflow is:

```text
Trading Idea
     ↓
Research
     ↓
Mechanical Rules
     ↓
MQL5 Implementation
     ↓
Baseline Backtest
     ↓
Performance Analysis
     ↓
Improvement / Optimization
     ↓
Out-of-Sample Validation
     ↓
Forward Test
     ↓
Final Assessment
```

A strategy is not considered validated simply because one historical backtest is profitable.

---

# 2. Repository Structure

The standard repository structure is:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-XXX_Strategy_Name/
│   │   ├── EA-XXX_Strategy_Name.mq5
│   │   └── README.md
│   │
├── Backtest/
│   ├── EA-XXX_Strategy_Name/
│   │   ├── README.md
│   │   ├── Strategy Tester report
│   │   └── Strategy Tester charts
│   │
├── Research/
│   └── README.md
│
├── docs/
│   └── methodology.md
│
└── GitHub_Profile/
    └── README.md
```

Each component has a different responsibility.

```text
EAs/          → strategy implementation
Backtest/     → empirical test evidence
Research/     → research reasoning and findings
docs/         → common research methodology
GitHub_Profile/ → public project/profile presentation
```

---

# 3. Research Principle

The repository follows a simple rule:

```text
Idea → Rule → Code → Test → Evidence → Decision
```

Trading ideas should not remain subjective descriptions.

Before implementation, the strategy should be translated into rules that can be evaluated mechanically.

For example:

```text
Subjective:

"Buy when the market looks bullish."

Not acceptable.
```

Instead:

```text
Mechanical:

IF condition A
AND condition B
AND condition C
THEN BUY
```

The same principle applies to:

```text
Entry
Exit
Stop Loss
Take Profit
Position sizing
Filters
Trade management
```

---

# 4. Strategy Identification

Each strategy receives a unique sequential identifier.

Format:

```text
EA-XXX_Strategy_Name
```

Example:

```text
EA-054_Inside_Bar_Break
```

The identifier should remain stable throughout the research process.

The same identifier should be used for:

```text
MQL5 source
EA directory
Backtest directory
Documentation
Research references
```

This allows the implementation and its evidence to be traced consistently.

---

# 5. Strategy Research

Before or during implementation, the trading concept should be described in `Research/README.md`.

Research should identify:

```text
Strategy hypothesis
Market behavior being exploited
Entry condition
Exit condition
Risk-management logic
Expected market regime
Known weaknesses
Variables requiring testing
```

The purpose of research documentation is not to prove that a strategy works.

Its purpose is to state clearly:

```text
What is being tested?
Why might it work?
How is the hypothesis converted into rules?
What evidence would support or reject it?
```

---

# 6. Mechanical Specification

Every EA must have deterministic entry and exit logic.

A strategy specification should answer:

```text
WHEN is a setup valid?

WHEN is a BUY triggered?

WHEN is a SELL triggered?

WHERE is Stop Loss placed?

WHERE is Take Profit placed?

WHEN is a position modified?

WHEN is a setup invalidated?

HOW MANY positions may exist?

WHAT execution conditions block a trade?
```

If these questions cannot be answered precisely, the strategy is not ready for implementation.

---

# 7. MQL5 Implementation

Strategies are implemented as MetaTrader 5 Expert Advisors using MQL5.

Each EA source should be stored under:

```text
EAs/
└── EA-XXX_Strategy_Name/
    └── EA-XXX_Strategy_Name.mq5
```

The implementation should prioritize:

```text
Clear rules
Simple architecture
Deterministic behavior
Reproducibility
Broker compatibility
Testability
```

Unnecessary complexity should be avoided during the first implementation.

The objective of the first version is:

```text
Correct implementation of the research hypothesis
```

not maximum historical performance.

---

# 8. Basic EA Safety Controls

Where applicable, EAs should include basic execution protection.

Examples include:

```text
Magic Number isolation
Maximum spread
Maximum open positions
Volume normalization
Price normalization
Broker minimum stop-distance validation
Trading-permission checks
```

These controls should remain separate conceptually from the strategy signal.

For example:

```text
Inside Bar
Trend Filter
ATR Filter
```

are strategy rules.

Whereas:

```text
Spread validation
Volume normalization
Broker stop-level validation
```

are execution controls.

This distinction should be preserved during analysis.

---

# 9. Baseline Version

Every strategy should first establish a baseline.

The baseline should be the simplest complete implementation of the strategy hypothesis.

Example:

```text
Raw Strategy
+
Basic Risk Management
+
Basic Execution Protection
=
Baseline
```

The baseline is important because all later improvements require a reference point.

Without a baseline it becomes difficult to determine whether a new filter actually improved the strategy.

---

# 10. Baseline Preservation

Once the baseline backtest has been recorded, its evidence should be preserved.

Do not overwrite historical evidence simply because a newer version performs better.

The baseline provides the reference:

```text
Baseline
    ↓
Change ONE meaningful variable
    ↓
Backtest
    ↓
Compare
```

This makes strategy development traceable.

---

# 11. Backtest Environment

Backtests are performed using MetaTrader 5 Strategy Tester.

For every documented test, record at minimum:

```text
EA
Symbol
Timeframe
Test period
Initial deposit
Leverage
Lot size
History quality
EA inputs
```

Where available, also preserve:

```text
Broker / company
MT5 build
Number of bars
Number of ticks
Spread settings
Execution-related settings
```

These details are necessary because results can vary between test environments.

---

# 12. Historical Data Quality

Whenever possible, baseline and validation tests should use:

```text
100% real ticks
```

The history quality reported by MetaTrader 5 must be preserved in the backtest documentation.

Data quality is part of the evidence.

A result obtained from lower-quality modeling should not be silently presented as equivalent to a real-tick test.

---

# 13. Original Evidence

The original MetaTrader 5 Strategy Tester report should be retained.

Preferred evidence includes:

```text
HTML Strategy Tester report
Balance graph
MFE / MAE graph
Holding-time graph
Hourly / weekday / monthly statistics
Other Strategy Tester output
```

The original report is more important than a manually written summary because it allows the test to be inspected independently.

---

# 14. Backtest README

Each EA backtest directory should contain:

```text
README.md
```

The README should summarize the original MT5 evidence.

Recommended sections:

```text
Test Environment
EA Parameters
Performance Summary
Drawdown
Trade Statistics
Long / Short Statistics
Winner / Loser Statistics
Holding Time
MFE / MAE
Balance Curve
Assessment
Evidence Files
Reproducibility
```

Numbers must come from the original test evidence.

Do not invent missing statistics.

---

# 15. Core Performance Metrics

The following metrics should normally be recorded.

## Profit

```text
Total Net Profit
Gross Profit
Gross Loss
```

## Risk

```text
Balance Drawdown
Equity Drawdown
Maximum Drawdown %
```

## Efficiency

```text
Profit Factor
Expected Payoff
Recovery Factor
Sharpe Ratio
```

## Trade Distribution

```text
Total Trades
Winning Trades
Losing Trades
Win Rate
Long Trades
Short Trades
Long Win Rate
Short Win Rate
```

## Trade Outcome

```text
Largest Winner
Largest Loser
Average Winner
Average Loser
Maximum Consecutive Wins
Maximum Consecutive Losses
```

Where available:

```text
MFE
MAE
Holding Time
Time Distribution
```

should also be retained.

---

# 16. Profit Factor

Profit Factor is calculated conceptually as:

```text
Gross Profit
────────────
Gross Loss
```

Interpretation should be made together with other metrics.

A profitable test with:

```text
Profit Factor ≈ 1
```

has very little historical margin between gross profits and gross losses.

Profit Factor should never be evaluated alone.

---

# 17. Drawdown

Drawdown measures the decline from previous account peaks.

Both:

```text
Balance Drawdown
Equity Drawdown
```

should be examined.

Equity drawdown is particularly important because it includes unrealized changes in open positions.

A strategy may produce positive final profit while still experiencing unacceptable drawdown.

Therefore:

```text
Positive Net Profit ≠ Acceptable Risk
```

---

# 18. Recovery Factor

Recovery Factor provides information about the relationship between profit and drawdown.

A low Recovery Factor indicates that the strategy generated relatively little profit compared with the drawdown required to achieve it.

This metric should be evaluated together with:

```text
Net Profit
Maximum Drawdown
Profit Factor
Balance Curve
```

---

# 19. Sharpe Ratio

Where reported by MetaTrader 5, the Sharpe Ratio should be retained as part of the Strategy Tester evidence.

It should not be used as the sole acceptance criterion.

Strategy evaluation should remain multi-metric.

---

# 20. Win Rate

Win rate is calculated as:

```text
Winning Trades
──────────────
Total Trades
```

A high win rate does not automatically indicate a profitable strategy.

The relationship between:

```text
Average Winner
Average Loser
Win Rate
```

must also be considered.

For example:

```text
High Win Rate
+
Large Average Loss
=
Potentially weak strategy
```

---

# 21. Trade Sample Size

The number of trades must always be reported.

A result generated from a small number of trades carries substantially less statistical evidence than a result generated from a large sample.

However:

```text
Large sample ≠ automatically robust
```

A large sample can still be overfit or concentrated in one market regime.

Trade count is therefore evidence quantity, not proof of strategy quality.

---

# 22. Balance Curve

The balance curve should be inspected in addition to summary statistics.

Look for:

```text
Consistent growth
Extended stagnation
Large declines
Sudden isolated gains
Repeated recovery cycles
Dependence on a small number of trades
```

A positive final balance does not necessarily mean the strategy produced stable returns throughout the test.

---

# 23. MFE / MAE Analysis

When available, Maximum Favorable Excursion and Maximum Adverse Excursion should be retained.

```text
MFE = Maximum favorable movement during a trade
MAE = Maximum adverse movement during a trade
```

These statistics can help investigate:

```text
Stop Loss placement
Take Profit placement
Break Even behavior
Trailing Stop behavior
Exit efficiency
```

MFE / MAE should primarily be treated as research evidence for future experiments.

---

# 24. Holding-Time Analysis

Position holding time should be documented when available.

Record:

```text
Minimum holding time
Maximum holding time
Average holding time
```

This helps classify actual EA behavior.

For example:

```text
Very short holding time
+
Large number of trades
```

indicates that execution costs and broker conditions may materially affect results.

---

# 25. Transaction and Execution Sensitivity

High-frequency strategies require particular attention to:

```text
Spread
Commission
Slippage
Latency
Execution quality
Broker conditions
```

A strategy with only a small statistical edge may lose that edge when real execution costs are introduced.

This risk should be considered before forward or live deployment.

---

# 26. Optimization Principle

Optimization should begin only after the baseline has been established.

The preferred process is:

```text
Baseline
   ↓
Identify Weakness
   ↓
Form Hypothesis
   ↓
Change Limited Variables
   ↓
Backtest
   ↓
Compare With Baseline
```

Avoid adding many filters simultaneously.

If several changes are introduced at once, it becomes difficult to identify which change produced the result.

---

# 27. Candidate Optimization Variables

Depending on the strategy, research may test:

```text
Trend filter
Volatility filter
ATR filter
Session filter
Spread filter
Entry confirmation
Breakout buffer
Pattern size
Stop Loss
Take Profit
Break Even
Trailing Stop
Trade direction
Setup expiration
```

These are candidates for experiments, not assumptions that they will improve performance.

---

# 28. Avoiding Overfitting

A parameter set should not be selected simply because it produces the highest historical profit.

Warning signs include:

```text
Very narrow profitable parameter range
Extreme sensitivity to small parameter changes
Excellent in-sample result
Poor neighboring configurations
Poor performance outside development period
```

A more stable parameter region is generally more useful for further validation than a single isolated optimum.

---

# 29. In-Sample Testing

The development period is used to:

```text
Build the strategy
Debug implementation
Identify weaknesses
Test hypotheses
Select candidate configurations
```

This is:

```text
In-Sample
```

Performance during this stage is not sufficient for final validation because the strategy was developed using information from the same data.

---

# 30. Out-of-Sample Testing

After selecting a candidate configuration, test it on historical data that was not used to choose the parameters.

This is:

```text
Out-of-Sample
```

The candidate should be tested without modifying its rules in response to the new dataset.

If the strategy fails, return to research.

Do not continually adjust the same configuration against the validation dataset until it passes, because that effectively turns the validation period into additional development data.

---

# 31. Forward Testing

A strategy that survives historical validation should proceed to forward testing.

Preferred progression:

```text
Historical Backtest
        ↓
Out-of-Sample
        ↓
Demo / Controlled Forward Test
        ↓
Evaluate Execution Differences
```

Forward testing helps expose factors that historical testing may not reproduce perfectly.

Examples:

```text
Live spread variation
Slippage
Execution delay
Broker behavior
Real-time market conditions
```

---

# 32. Strategy Comparison

When comparing versions, do not compare only:

```text
Net Profit
```

Compare a set of metrics.

Example:

```text
Version A
vs
Version B

Net Profit
Profit Factor
Maximum Drawdown
Recovery Factor
Sharpe Ratio
Trade Count
Win Rate
Average Winner
Average Loser
Balance Stability
```

The objective is:

```text
Better risk-adjusted robustness
```

not simply the highest historical profit.

---

# 33. PASS / FAIL Philosophy

A research task should only be considered complete when evidence exists.

General principle:

```text
Implementation
+
Test
+
Evidence
=
Task completion
```

Different stages have different meanings.

Example:

```text
IMPLEMENTATION: PASS

means:

EA was implemented and can execute the intended rules.
```

It does NOT mean:

```text
STRATEGY PROFITABILITY: PASS
```

Similarly:

```text
BASELINE BACKTEST: PASS
```

means the baseline test was successfully executed and documented.

It does NOT mean:

```text
LIVE READY
```

---

# 34. Suggested Strategy Status

Strategies may use statuses such as:

```text
RESEARCH
IMPLEMENTED
BASELINE TESTED
OPTIMIZATION
OUT-OF-SAMPLE TESTING
FORWARD TESTING
VALIDATED
REJECTED
```

A strategy should move through stages based on evidence rather than expectation.

---

# 35. Rejection Is a Valid Result

A strategy does not need to become profitable to be useful research.

If testing demonstrates:

```text
No measurable edge
Excessive drawdown
Unstable performance
Execution-cost sensitivity
Failure outside development data
```

the strategy can be marked:

```text
REJECTED
```

The evidence should still remain in the repository.

A documented failed hypothesis is part of the research record.

---

# 36. Reproducibility

Another researcher should be able to understand:

```text
What was tested
Which EA was used
Which parameters were used
Which symbol was tested
Which timeframe was tested
Which period was tested
What result was obtained
Where the original evidence is stored
```

Therefore never rely only on screenshots or manually typed performance claims.

Preserve the original report whenever possible.

---

# 37. Documentation Integrity

Documentation must distinguish between:

```text
Observed Result
Interpretation
Hypothesis
Future Experiment
```

Example:

```text
Observed:
Profit Factor = 1.01

Interpretation:
Historical gross profit and gross loss were almost equal.

Hypothesis:
A volatility filter may remove weak breakouts.

Experiment:
Backtest the same baseline with an ATR filter.
```

Do not present a hypothesis as if it were an observed result.

---

# 38. EA-054 Example

EA-054 demonstrates the methodology.

```text
Research hypothesis:
Inside Bar compression may precede directional expansion.

        ↓

Mechanical rule:
Inside Bar must remain inside Mother Bar.

        ↓

Entry:
Break Mother High → BUY
Break Mother Low  → SELL

        ↓

Implementation:
EA-054_Inside_Bar_Break.mq5

        ↓

Baseline:
XAUUSD.PRO
M1
2026-01-02 → 2026-03-31
100% real ticks

        ↓

Evidence:
7,172 trades
+$75.40 Net Profit
1.01 Profit Factor
34.10% Max Equity Drawdown
0.21 Recovery Factor

        ↓

Assessment:
Implementation works.
Baseline is slightly profitable.
Risk-adjusted performance is weak.
Further research required.
```

This is the intended repository workflow:

```text
Do not hide weak results.

Measure them.
Document them.
Use them to define the next experiment.
```

---

# 39. Standard EA Research Cycle

For every new EA:

```text
STEP 1
Select strategy hypothesis

STEP 2
Define mechanical rules

STEP 3
Create EA source

STEP 4
Compile and verify implementation

STEP 5
Run baseline backtest

STEP 6
Preserve original MT5 evidence

STEP 7
Create Backtest README

STEP 8
Analyze weaknesses

STEP 9
Document research findings

STEP 10
Test improvements

STEP 11
Perform out-of-sample validation

STEP 12
Perform controlled forward testing

STEP 13
Make final research decision
```

---

# 40. Final Principle

The repository follows one central principle:

```text
Do not search for a beautiful backtest.

Search for a trading hypothesis
that survives attempts to break it.
```

The purpose of the research process is not to prove that every EA works.

The purpose is to create a transparent chain:

```text
Hypothesis
    ↓
Rules
    ↓
Code
    ↓
Test
    ↓
Evidence
    ↓
Validation
    ↓
Decision
```

Every strategy in this repository should be judged by that chain rather than by a single performance number.

---

## Disclaimer

All Expert Advisors, research documents, backtests, and results in this repository are provided for research, development, and educational purposes.

Historical performance does not guarantee future results.

Backtests are simulations and may differ materially from live trading because of spreads, commissions, slippage, liquidity, latency, broker execution, and changing market conditions.

No strategy should be considered suitable for live capital solely because it produced a profitable historical backtest.
