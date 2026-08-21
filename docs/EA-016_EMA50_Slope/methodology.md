# Research Methodology

## Purpose

This document defines the research methodology used in the `xauusd-mt5-ea-research` repository.

The objective is to evaluate XAUUSD trading ideas systematically using MetaTrader 5 Expert Advisors and reproducible Strategy Tester evidence.

The methodology is designed to separate:

```text
Trading Idea
↓
EA Implementation
↓
Baseline Backtest
↓
Evidence
↓
Evaluation
↓
Further Experiments
↓
Forward Validation
```

A strategy is not considered successful simply because:

- the trading logic appears reasonable;
- the EA compiles successfully;
- one backtest is profitable;
- an optimized parameter set performs well;
- a historical equity curve looks attractive.

Each stage requires its own evidence.

---

# 1. Research Workflow

Each EA should follow the same basic research process.

```text
1. Define hypothesis
        ↓
2. Implement EA
        ↓
3. Verify implementation
        ↓
4. Define baseline configuration
        ↓
5. Run baseline backtest
        ↓
6. Preserve original evidence
        ↓
7. Evaluate PASS / FAIL
        ↓
8. Identify research questions
        ↓
9. Run controlled experiments
        ↓
10. Validate promising configurations
```

The baseline should be preserved even when it fails.

Failed experiments are research results and should not be deleted simply because later versions perform better.

---

# 2. Define the Trading Hypothesis

Every EA begins with a clearly stated hypothesis.

The hypothesis should explain:

```text
What market behavior is being tested?
What conditions generate an entry?
Why might those conditions contain useful information?
```

The hypothesis should be simple enough to test directly.

Example:

```text
EA-016_EMA50_Slope

Hypothesis:

Rising EMA50 + price above EMA50
may indicate a bullish trend condition.

Falling EMA50 + price below EMA50
may indicate a bearish trend condition.
```

The initial hypothesis should not contain unnecessary filters or optimization unless those components are fundamental to the trading idea.

---

# 3. EA Implementation

Each strategy is implemented as a MetaTrader 5 Expert Advisor.

EA source files are stored under:

```text
EAs/
└── EA-XXX_StrategyName/
    ├── EA-XXX_StrategyName.mq5
    └── README.md
```

The EA README should document:

- strategy purpose;
- BUY logic;
- SELL logic;
- signal timing;
- parameters;
- position-management logic;
- known implementation notes;
- source status.

The README describes what the implementation does.

It should not claim profitability unless supported by test evidence.

---

# 4. Implementation Verification

Before interpreting a backtest, verify that the EA implementation corresponds to the intended hypothesis.

At minimum, check:

```text
Indicator parameters
Entry conditions
BUY / SELL direction
Closed-bar vs current-bar logic
Stop Loss
Take Profit
Position limits
Spread filters
Break Even
Trailing Stop
Magic Number behavior
```

A successful compilation confirms only that the code can compile.

It does not confirm that the trading logic is correct.

---

# 5. Baseline Configuration

Before optimization, establish a baseline configuration.

The baseline is the first controlled reference point for the strategy.

Its purpose is not necessarily to be profitable.

Its purpose is to answer:

> How does the original strategy behave before further modification?

Record all parameters used in the baseline.

Example:

```text
EA-016 Baseline

Symbol:              XAUUSD.PRO
Timeframe:           M1
EMA Period:          50
Minimum Trend Bars:  2
Lot Size:            0.01
Stop Loss:           300 points
Take Profit:         600 points
Maximum Spread:      30 points
Break Even:          OFF
Trailing Stop:       OFF
```

Future experiments should be compared against a known baseline rather than against memory or an undocumented previous test.

---

# 6. Backtest Environment

Every recorded backtest should document its environment.

At minimum:

| Field | Required |
|---|---|
| EA name | Yes |
| Symbol | Yes |
| Timeframe | Yes |
| Test period | Yes |
| Initial deposit | Yes |
| Leverage | Yes |
| Tested parameters | Yes |
| History quality | Yes |
| MT5 report | Yes |

Where available, also preserve:

```text
MT5 Build
Broker / Server
Bars
Ticks
Testing model
```

These details make it easier to reproduce and compare experiments.

---

# 7. Historical Data Quality

Data quality must be recorded with the result.

When available, prefer MetaTrader 5 tests using:

```text
Every tick based on real ticks
```

A high-quality historical test improves the reliability of execution simulation, but it does not eliminate:

- overfitting;
- regime dependence;
- broker differences;
- spread differences;
- slippage differences;
- future market uncertainty.

Therefore:

```text
High data quality
≠
proof of future profitability
```

---

# 8. Preserve Original Evidence

Every backtest used for a research conclusion should preserve the original MetaTrader 5 evidence.

Recommended structure:

```text
Backtest/
└── EA-XXX_StrategyName/
    ├── README.md
    ├── StrategyTesterReport.html
    └── associated report images
```

The original Strategy Tester report should be treated as the primary source of numerical results.

The Markdown README is a human-readable summary.

If the README and original Strategy Tester report disagree, the original report should be checked before making a conclusion.

Do not manually alter the original Strategy Tester evidence.

---

# 9. Minimum Metrics to Record

Each baseline backtest should record at least:

## Profitability

```text
Total Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
```

## Risk

```text
Balance Drawdown
Equity Drawdown
Maximum Drawdown %
Recovery Factor
```

## Trade Statistics

```text
Total Trades
Winning Trades
Losing Trades
Long Trades
Short Trades
Long Win Rate
Short Win Rate
```

## Trade Distribution

Where useful:

```text
Largest Winner
Largest Loser
Average Winner
Average Loser
Maximum Consecutive Wins
Maximum Consecutive Losses
Average Holding Time
```

## Additional Statistics

Where available:

```text
Sharpe Ratio
AHPR
GHPR
LR Correlation
MFE
MAE
```

No single metric should be interpreted in isolation.

---

# 10. Baseline Evaluation

The baseline should receive an explicit research result.

Use:

```text
PASS
FAIL
INCONCLUSIVE
```

## PASS

A baseline may be marked `PASS` for the current research stage when the recorded evidence satisfies the predefined acceptance criteria for that experiment.

PASS does not mean:

```text
Ready for live trading
```

It only means:

```text
The experiment passed its current research gate.
```

---

## FAIL

Use `FAIL` when the experiment clearly violates the acceptance criteria.

Examples:

```text
Negative expectancy
Profit Factor below required threshold
Unacceptable drawdown
Implementation failure
Insufficient execution reliability
```

A failed baseline should remain in the repository.

---

## INCONCLUSIVE

Use `INCONCLUSIVE` when there is not enough evidence to make a meaningful decision.

Examples:

```text
Too few trades
Incomplete test period
Missing evidence
Incorrect configuration
Suspected implementation issue
```

An inconclusive test should not be treated as either successful or failed.

---

# 11. Acceptance Criteria

Acceptance criteria should ideally be defined before interpreting the result.

The exact thresholds may differ between research stages and strategies.

At minimum, a strategy intended to demonstrate positive historical expectancy should not be considered successful when:

```text
Total Net Profit < 0

or

Profit Factor < 1

or

Expected Payoff < 0
```

Drawdown must also be evaluated independently.

A profitable strategy with unacceptable drawdown should not automatically PASS.

---

# 12. Example — EA-016 Baseline

The first documented baseline in this repository is:

```text
EA-016_EMA50_Slope
```

Test environment:

```text
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 - 2026.06.08
History Quality: 100% real ticks
Initial Deposit: $1,000
Leverage:        1:500
```

Recorded results:

```text
Total Trades:       3,338
Winning Trades:     30.35%
Losing Trades:      69.65%

Net Profit:         -$992.38
Profit Factor:      0.86
Expected Payoff:    -$0.30
Sharpe Ratio:       -5.00
Maximum Drawdown:   99.28%
```

Research verdict:

```text
FAIL
```

The baseline is retained as evidence rather than removed or replaced.

---

# 13. Controlled Experiments

After the baseline, research should proceed through controlled experiments.

Prefer changing one meaningful variable at a time.

Example:

```text
Baseline
    ↓
Change InpMinTrendBars
    ↓
Backtest
    ↓
Compare
```

Then separately:

```text
Baseline
    ↓
BUY only
    ↓
Backtest
    ↓
Compare
```

Then:

```text
Baseline
    ↓
SELL only
    ↓
Backtest
    ↓
Compare
```

This approach makes it easier to determine which modification caused a performance change.

---

# 14. Avoid Changing Everything at Once

Avoid immediately combining:

```text
New timeframe
+
New EMA period
+
Session filter
+
New Stop Loss
+
New Take Profit
+
Break Even
+
Trailing Stop
```

If the resulting backtest improves, it becomes difficult to determine which component created the improvement.

Prefer:

```text
Simple hypothesis
→ controlled change
→ test
→ evidence
→ decision
```

Complexity should be added only when evidence supports it.

---

# 15. Research Questions

A failed baseline should generate specific research questions rather than arbitrary parameter changes.

Example from EA-016:

```text
RQ-01:
Does requiring greater EMA trend persistence improve the signal?

RQ-02:
Do BUY and SELL signals have different expectancy?

RQ-03:
Does the strategy behave differently on M5 or M15?

RQ-04:
Does changing exit logic improve realized profit?

RQ-05:
Does performance vary materially by trading session?
```

Each research question should become a separate controlled experiment where practical.

---

# 16. Parameter Optimization

Optimization should come after the baseline is understood.

Optimization is a research tool.

It is not proof that a strategy works.

A parameter set discovered by searching historical data may be overfitted to that data.

Therefore:

```text
Optimized historical result
≠
validated strategy
```

Optimization results should be separated from baseline results.

Do not overwrite baseline evidence with optimized results.

---

# 17. In-Sample and Out-of-Sample Testing

When a strategy becomes promising, historical data should be separated where practical into:

```text
In-Sample
```

and:

```text
Out-of-Sample
```

The In-Sample period may be used for research and parameter development.

The Out-of-Sample period should be used to evaluate whether the resulting strategy retains useful behavior on data not used to develop the configuration.

A strategy that performs well only on the development period requires further investigation.

---

# 18. Forward Testing

A promising historical result should progress to forward testing before live deployment is considered.

Forward testing evaluates the EA on new market data after the strategy configuration has been selected.

The configuration should not be continuously modified during the same forward-validation period merely to improve reported performance.

Record:

```text
Start date
End date
EA version
Parameters
Symbol
Timeframe
Trades
Profit / Loss
Drawdown
Execution issues
```

---

# 19. Live Validation

Backtesting and forward testing do not automatically authorize live deployment.

Live validation is a separate stage.

Before considering production use, evaluate:

```text
Real spread
Slippage
Execution latency
Broker behavior
Rejected orders
Trading costs
Risk limits
Operational stability
```

Capital exposure should not be justified solely by historical Strategy Tester results.

---

# 20. Versioning Experiments

Each materially different experiment should be identifiable.

A simple naming approach can be used:

```text
EA-016-B00
EA-016-E01
EA-016-E02
EA-016-E03
```

Where:

```text
B00 = baseline

E01 = experiment 01
E02 = experiment 02
E03 = experiment 03
```

Each experiment should record:

```text
What changed?
Why was it changed?
What remained constant?
What was the result?
PASS / FAIL / INCONCLUSIVE?
```

The exact naming system may evolve as the repository grows, but experiments should remain traceable.

---

# 21. No Cherry-Picking

Research should preserve unfavorable results.

Do not:

- delete failed backtests;
- report only profitable periods;
- hide excessive drawdown;
- present the best optimization run as if it were the original strategy;
- change parameters without documenting the change;
- combine results from different configurations as though they were one test.

The purpose of the repository is reproducible research, not presentation of only favorable outcomes.

---

# 22. Separate Evidence from Interpretation

Each research result should distinguish between:

## Evidence

Example:

```text
Profit Factor = 0.86
Net Profit = -$992.38
Drawdown = 99.28%
```

and:

## Interpretation

Example:

```text
The tested baseline does not demonstrate positive expectancy.
```

Evidence should come directly from recorded test results.

Interpretation should clearly describe what that evidence supports without making broader claims than the test can justify.

---

# 23. Repository Structure

The repository separates implementation, evidence, research interpretation, and methodology.

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-XXX_StrategyName/
│       ├── EA-XXX_StrategyName.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-XXX_StrategyName/
│       ├── README.md
│       ├── StrategyTesterReport.html
│       └── report images
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

Responsibilities:

```text
EAs/
Implementation and strategy specification

Backtest/
Original test evidence and backtest summary

Research/
Research status, findings, and experiment direction

docs/methodology.md
Research rules and evaluation process

GitHub_Profile/
Public profile presentation
```

---

# 24. Research Status Flow

A strategy can progress through stages such as:

```text
IDEA
↓
IMPLEMENTED
↓
BASELINE TESTED
↓
RESEARCH
↓
CANDIDATE
↓
OUT-OF-SAMPLE TEST
↓
FORWARD TEST
↓
VALIDATED
```

A failed strategy may remain at:

```text
BASELINE TESTED — FAIL
```

until a new research experiment is justified.

No strategy should skip directly from implementation to a claim of validation.

---

# 25. Documentation Rule

Every important conclusion should be traceable to evidence.

The preferred chain is:

```text
Source Code
    ↓
Exact Parameters
    ↓
Strategy Tester Report
    ↓
Backtest README
    ↓
Research Conclusion
```

If one of these components changes, the relationship between the test and the strategy should be checked again.

---

# 26. Current Repository Baseline

At the current stage, the repository contains the documented research baseline:

```text
EA-016_EMA50_Slope
```

Status:

```text
Implementation:      AVAILABLE
Baseline Backtest:   COMPLETED
Evidence:            AVAILABLE
Baseline Result:     FAIL
Optimization:        NOT VALIDATED
Forward Test:        NOT VALIDATED
Live Validation:     NOT VALIDATED
```

The EA-016 baseline establishes the initial reference point for applying this methodology to subsequent experiments and future EAs.

---

# Disclaimer

This repository is intended for quantitative research, software testing, and educational purposes.

Historical performance does not guarantee future results.

A successful historical backtest does not by itself demonstrate that a trading system will remain profitable under future market conditions or live execution.

Trading leveraged financial instruments involves substantial risk.
