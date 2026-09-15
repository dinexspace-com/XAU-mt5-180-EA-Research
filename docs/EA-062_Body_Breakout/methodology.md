# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard methodology used to research, implement, backtest, evaluate and validate Expert Advisors in the **xauusd-mt5-ea-research** repository.

The objective is not to search for attractive historical equity curves.

The objective is to build a reproducible research process that can answer:

```text
What was the trading hypothesis?
What exactly was implemented?
How was it tested?
What evidence was produced?
Did the baseline pass or fail?
Why did it pass or fail?
What should be tested next?
Does the result survive independent validation?
```

Both successful and unsuccessful experiments are retained.

A failed backtest is valid research evidence when the strategy, parameters, environment and results are documented correctly.

---

# 1. Research Workflow

Every EA should progress through the following stages:

```text
Trading Idea
      ↓
Research Hypothesis
      ↓
Explicit Trading Rules
      ↓
MQL5 Implementation
      ↓
Technical Validation
      ↓
Baseline Backtest
      ↓
Evidence Preservation
      ↓
Baseline PASS / FAIL
      ↓
Controlled Research
      ↓
Candidate Strategy
      ↓
Longer Historical Test
      ↓
Out-of-Sample Validation
      ↓
Robustness Testing
      ↓
Forward Testing
      ↓
Human Review
      ↓
Live Trading Decision
```

A profitable baseline does not allow the strategy to skip validation stages.

A failed baseline does not automatically invalidate the underlying trading hypothesis.

---

# 2. Repository Structure

Standard repository structure:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-<>/
│   │   ├── EA-<>.mq5
│   │   └── README.md
│   │
│
├── Backtest/
│   ├── EA-<>/
│   │   ├── README.md
│   │   ├── MT5 Strategy Tester HTML
│   │   └── MT5 Strategy Tester images
│   │
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

```text
EAs/
    ↓
Strategy implementation

Backtest/
    ↓
Raw experimental evidence

Research/
    ↓
Interpretation and research questions

docs/
    ↓
Repository-wide methodology

GitHub_Profile/
    ↓
Public research summary and project status
```

---

# 3. EA Identification

Each EA receives a permanent identifier.

Format:

```text
EA-[NUMBER]_[STRATEGY_NAME]
```

Examples:

```text
EA-061_ATR_Expansion_Break
EA-062_Body_Breakout
```

The EA identifier should remain stable.

A strategy should not be renamed simply because its backtest result changes.

---

# 4. Research Hypothesis

Every EA begins with a testable hypothesis.

A useful hypothesis should describe:

```text
Market behavior
+
Signal condition
+
Expected response
+
Instrument
+
Timeframe or timeframe range
```

Example for EA-062:

> A breakout accompanied by a strong candle body relative to the candle's total range may provide stronger directional continuation than an ordinary range breakout.

The hypothesis must exist before interpreting the result.

This reduces hindsight bias.

---

# 5. Convert the Hypothesis into Rules

The hypothesis must be converted into explicit machine-readable trading rules.

At minimum define:

```text
ENTRY
EXIT
STOP LOSS
TAKE PROFIT
POSITION SIZE
TIMEFRAME
INDICATORS / PRICE CONDITIONS
FILTERS
TRADE MANAGEMENT
EXECUTION RESTRICTIONS
```

Avoid discretionary rules such as:

```text
BUY when the breakout looks strong.
```

Use measurable rules such as:

```text
Close[1] > HighestHigh(previous N bars)

AND

ABS(Close[1] - Open[1])
──────────────────────── >= Minimum Body Ratio
High[1] - Low[1]
```

The purpose is reproducibility.

---

# 6. Baseline First

The first implementation should be intentionally simple.

The baseline exists to test the core hypothesis before adding complexity.

Example:

```text
EA-062 Baseline

Breakout Lookback  = 20
Breakout Buffer    = 0
Minimum Body Ratio = 0.70

SL = 300
TP = 600

Break Even    = ON
Trailing Stop = ON
```

The baseline should not be silently modified after its result is known.

It becomes the permanent reference experiment.

---

# 7. Baseline Experiment ID

Each baseline should receive a unique experiment identifier.

Recommended format:

```text
EA<NUMBER>-<TIMEFRAME>-BASELINE-<SEQUENCE>
```

Example:

```text
EA062-M1-BASELINE-001
```

Future controlled experiments must use separate IDs.

Examples:

```text
EA062-TF-M5-001
EA062-TF-M15-001

EA062-BODY-001
EA062-BODY-002

EA062-LOOKBACK-001

EA062-SESSION-ASIA-001
EA062-SESSION-EU-001
EA062-SESSION-US-001

EA062-DIRECTION-BUY-001
EA062-DIRECTION-SELL-001

EA062-EXIT-001
```

Experiment IDs must not be reused.

---

# 8. Source Code Preservation

The exact MQL5 implementation used for research must be preserved.

Example:

```text
EAs/
└── EA-062_Body_Breakout/
    ├── EA-062_Body_Breakout.mq5
    └── README.md
```

The EA README should document:

```text
Strategy concept
Entry rules
Exit rules
Default parameters
Risk management
Trade management
Execution protections
Platform
Research status
```

The objective is to make every backtest traceable to the implementation that generated it.

---

# 9. Technical Validation

Performance analysis is meaningless if the implementation is technically incorrect.

Before interpreting profitability, verify:

```text
EA compiles successfully
Correct Magic Number behavior
Correct symbol handling
Correct timeframe handling
No unintended duplicate exposure
Entry logic uses intended bars
SL submitted correctly
TP submitted correctly
Break Even behaves as intended
Trailing Stop behaves as intended
Spread filter operates correctly
Volume validation works
Broker stop restrictions are respected
Trade permissions are checked
```

Technical validation and strategy profitability are separate questions.

Possible result:

```text
Technical Execution : PASS
Strategy Performance: FAIL
```

This is a valid research outcome.

---

# 10. Backtest Environment

Every baseline must document its environment.

At minimum:

```text
EA
Symbol
Timeframe
Start Date
End Date
History Quality
Initial Deposit
Currency
Leverage
Lot Size / Position Sizing
Strategy Parameters
```

Where relevant also record:

```text
Broker / Server
MT5 Build
Bars
Ticks
Spread assumptions
Execution settings
```

The environment must be documented because results can differ across brokers, data sources and symbol specifications.

---

# 11. Historical Data Quality

For execution-sensitive XAUUSD strategies, real-tick testing is preferred when suitable data are available.

The actual test quality must be recorded.

Example:

```text
History Quality: 100% real ticks
```

Never assume that two historical datasets are equivalent simply because they cover the same dates.

---

# 12. Evidence Preservation

Original MetaTrader 5 Strategy Tester evidence should be preserved.

Typical package:

```text
Backtest/
└── EA-062_Body_Breakout/
    ├── README.md
    ├── Strategy Tester HTML report
    ├── Balance chart
    ├── Entry distribution chart
    ├── MFE / MAE chart
    └── Holding-time chart
```

The HTML report is the primary machine-generated evidence.

Original evidence should not be edited to make a failed strategy appear successful.

---

# 13. Core Performance Metrics

At minimum evaluate:

```text
Total Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Recovery Factor
Sharpe Ratio

Balance Drawdown
Equity Drawdown

Total Trades
Winning Trades
Losing Trades
Win Rate

Average Winner
Average Loser
Largest Winner
Largest Loser

Maximum Consecutive Wins
Maximum Consecutive Losses

BUY Performance
SELL Performance

Holding Time
MFE
MAE
```

No single metric determines strategy validity.

---

# 14. Profit Factor

Profit Factor compares gross profit with gross loss.

Conceptually:

```text
PF =
Gross Profit
────────────
Gross Loss
```

Interpretation:

```text
PF > 1.0
Historical gross profit exceeded historical gross loss

PF < 1.0
Historical gross loss exceeded historical gross profit
```

A Profit Factor above 1.0 is not sufficient by itself to validate a strategy.

---

# 15. Expected Payoff

Expected Payoff helps evaluate the average historical outcome per trade.

Conceptually:

```text
Positive Expected Payoff
        ↓
Positive historical average trade outcome

Negative Expected Payoff
        ↓
Negative historical average trade outcome
```

Expected Payoff should be evaluated together with:

```text
Trade Count
Profit Factor
Average Winner
Average Loser
Win Rate
Drawdown
```

---

# 16. Win Rate

Win rate alone is not evidence of profitability.

Conceptually:

```text
Expectancy =
(Probability of Win × Average Win)
-
(Probability of Loss × Average Loss)
```

Therefore:

```text
Win Rate > 50%
```

can still produce losses.

Likewise:

```text
Win Rate < 50%
```

can potentially be profitable if winners are sufficiently larger than losers.

---

# 17. Realized Payoff

Always compare:

```text
Average Winner
vs
Average Loser
```

Do not assume the configured SL/TP ratio equals the realized payoff ratio.

For example:

```text
Configured:

SL = 300
TP = 600

Nominal Risk : Reward = 1 : 2
```

does not guarantee:

```text
Average Winner = 2 × Average Loser
```

because actual results can be affected by:

```text
Break Even
Trailing Stop
Spread
Execution
Early exits
Market behavior
```

Realized trade statistics are more important than the nominal SL/TP relationship when evaluating historical behavior.

---

# 18. Drawdown

Drawdown is a primary risk metric.

Always inspect both:

```text
Balance Drawdown
Equity Drawdown
```

A strategy can produce positive Net Profit while still exposing the account to unacceptable drawdown.

Therefore:

```text
Positive Net Profit
        ≠
Automatic PASS
```

Risk must be evaluated separately from profitability.

---

# 19. Trade Count

Trade count provides context for the reliability of observed results.

A strategy producing:

```text
10 trades
```

does not provide the same amount of evidence as one producing:

```text
500 trades
```

However, there is no universal minimum trade count.

Required sample size depends on:

```text
Strategy frequency
Market coverage
Regime coverage
Research question
```

Trade count should always be reported.

---

# 20. Balance and Equity Curve

Do not evaluate a strategy using final Net Profit alone.

Inspect the path taken to reach the result.

Look for:

```text
Stable progression
Large drawdowns
Long stagnation
Sudden collapses
Late-period deterioration
Recovery behavior
Dependence on isolated winning trades
Regime-specific changes
```

The shape of the equity curve provides information that a final profit number cannot.

---

# 21. BUY vs SELL Analysis

Directional behavior should be evaluated separately.

Record:

```text
BUY Trades
BUY Win Rate

SELL Trades
SELL Win Rate
```

If one direction performs better, create a research question.

Do not immediately remove the weaker direction.

Example:

```text
BUY better than SELL
        ↓
Create Directional Research Question
        ↓
Test BUY only
Test SELL only
Test BUY + SELL
```

This avoids hindsight filtering.

---

# 22. Holding-Time Analysis

Record:

```text
Minimum Holding Time
Average Holding Time
Maximum Holding Time
```

Holding time helps identify how the EA actually behaves.

A strategy described as a breakout system may operationally behave like a scalper when average trades last only a few minutes.

Short-duration strategies are particularly sensitive to:

```text
Spread
Slippage
Execution delay
Broker conditions
Intraday liquidity
```

---

# 23. MFE / MAE Analysis

Where available, preserve:

```text
Maximum Favorable Excursion
Maximum Adverse Excursion

Profit vs MFE correlation
Profit vs MAE correlation
MFE vs MAE correlation
```

MFE/MAE can help generate research questions concerning:

```text
Stop placement
Profit capture
Break Even
Trailing Stop
Exit timing
```

However:

```text
Correlation ≠ causation
Correlation ≠ trading rule
```

Any exit modification must be independently tested.

---

# 24. Baseline PASS / FAIL

Every baseline receives an explicit classification.

```text
PASS
```

or:

```text
FAIL
```

The classification must be supported by evidence.

A failed baseline remains in the repository.

---

# 25. Baseline Failure Conditions

A baseline should normally be classified as FAIL when critical evidence includes one or more of:

```text
Negative Total Net Profit
Profit Factor below 1.0
Negative Expected Payoff
Unacceptable Drawdown
Severe Equity Deterioration
Technical Failure
Insufficient Evidence for the Hypothesis
```

These are screening principles rather than universal numerical guarantees of future performance.

---

# 26. Controlled Research

After the baseline, research should investigate specific questions.

Preferred approach:

```text
One Research Question
        ↓
One Major Variable
        ↓
Controlled Experiment
        ↓
Evidence
        ↓
Conclusion
```

Avoid:

```text
Change everything
        ↓
Backtest
        ↓
Keep profitable combination
```

That process creates high overfitting risk and weak research evidence.

---

# 27. Research Question Format

Each research question should contain:

```text
Research ID
Question
Hypothesis
Independent Variable
Controlled Variables
Test Configuration
Metrics
PASS / FAIL Criteria
Evidence
Conclusion
Next Step
```

Example:

```text
EA062-RQ01

Question:
Does Body Breakout perform differently on M5 than M1?

Independent Variable:
Timeframe

Controlled Variables:
Body Ratio
Breakout Lookback
Exit logic
Risk configuration
```

---

# 28. One Major Variable at a Time

Where practical, only one major strategy dimension should change per experiment.

Example:

```text
Baseline:
M1 / Body Ratio 0.70 / Lookback 20

Experiment:
M5 / Body Ratio 0.70 / Lookback 20
```

This provides much stronger evidence than:

```text
M5 / Body Ratio 0.85 / Lookback 50 / New SL / New TP / Session Filter
```

because the latter does not reveal which change caused the result.

---

# 29. Parameter Research

Parameter research must answer a defined question.

Example:

```text
Question:
Does stronger candle-body confirmation improve breakout quality?

Candidate Body Ratios:

0.60
0.70
0.80
0.90
```

Compare:

```text
Trade Count
Net Profit
Profit Factor
Expected Payoff
Drawdown
Win Rate
Average Winner
Average Loser
```

Do not select a parameter only because it has the highest historical Net Profit.

---

# 30. Overfitting Control

Overfitting occurs when a strategy adapts excessively to historical data.

Warning signs include:

```text
Hundreds of parameter combinations tested
One isolated parameter producing exceptional results
Very few trades
Performance concentrated in a short period
Large degradation outside development data
Many filters added after inspecting losing trades
Multiple variables optimized simultaneously
```

Prefer:

```text
Stable parameter regions
```

over:

```text
Single perfect parameter
```

---

# 31. Research vs Optimization

These are separate stages.

```text
RESEARCH

Does this trading concept appear to contain useful information?
```

versus:

```text
OPTIMIZATION

What parameter configuration best expresses an already-supported concept?
```

Broad optimization should not be the first response to a failed baseline.

First determine why the baseline failed.

---

# 32. Candidate Strategy

A strategy becomes a research candidate only after controlled experiments provide sufficient evidence to justify further validation.

Candidate status does not mean:

```text
Production Ready
```

It means:

```text
Worth validating further
```

---

# 33. Longer Historical Testing

A candidate should be tested across a longer historical period.

The objective is to expose the strategy to more:

```text
Market regimes
Volatility conditions
Trend conditions
Range conditions
Trading sessions
Economic environments
```

Performance should not depend entirely on one short historical window.

---

# 34. In-Sample and Out-of-Sample

Development and validation data should be separated.

Conceptually:

```text
Historical Dataset
│
├── In-Sample
│   └── Research / Development
│
└── Out-of-Sample
    └── Independent Validation
```

The out-of-sample period should not be repeatedly used to tune parameters.

Otherwise it becomes part of the development process.

---

# 35. Out-of-Sample Validation

The candidate must demonstrate acceptable behavior on data not used to create the configuration.

Compare:

```text
In-Sample
vs
Out-of-Sample
```

Look for:

```text
Profitability persistence
Drawdown stability
Trade-frequency stability
Directional stability
Payoff stability
Parameter stability
```

Major deterioration is evidence of possible overfitting.

---

# 36. Robustness Testing

A promising candidate should be tested for sensitivity.

Possible tests include:

```text
Nearby parameter values
Different market periods
Different spread conditions
Different execution assumptions
Different market regimes
Different broker data where appropriate
```

The objective is not to force every test to be profitable.

The objective is to determine whether the strategy is fragile.

---

# 37. Forward Testing

Only candidates that survive historical validation should proceed to forward testing.

Forward testing helps expose conditions that historical simulation may not fully reproduce:

```text
Live spread variation
Slippage
Execution latency
Broker behavior
Runtime stability
Market-data differences
Operational failures
```

Forward testing should initially use controlled risk.

---

# 38. Live Trading Approval

No EA is automatically approved for live trading.

Required progression:

```text
Implementation
        ↓
Baseline
        ↓
Controlled Research
        ↓
Candidate
        ↓
Long Historical Test
        ↓
Out-of-Sample
        ↓
Robustness
        ↓
Forward Test
        ↓
Human Review
        ↓
Live Trading Decision
```

The repository provides evidence.

Human approval remains required for capital deployment.

---

# 39. Experiment Record

Every important experiment should record:

```text
Experiment ID
EA ID
EA Source / Version
Research Question
Hypothesis

Independent Variable
Controlled Variables

Symbol
Timeframe
Historical Period
History Quality
Initial Deposit
Leverage

Parameters

Total Trades
Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Maximum Drawdown
Recovery Factor
Sharpe Ratio

Win Rate
Average Winner
Average Loser

BUY Statistics
SELL Statistics

Holding Time
MFE / MAE

PASS / FAIL
Evidence Location
Conclusion
Next Experiment
```

This is the minimum research record required to reconstruct the experiment.

---

# 40. Evidence Chain

Every conclusion should be traceable through:

```text
EA ID
    ↓
Research Hypothesis
    ↓
Source Code
    ↓
Experiment ID
    ↓
Test Configuration
    ↓
MT5 Raw Evidence
    ↓
Backtest README
    ↓
Research Interpretation
    ↓
PASS / FAIL
    ↓
Next Research Question
```

If this chain cannot be reconstructed, the experiment is insufficiently documented.

---

# 41. Never Overwrite Baseline Evidence

A failed baseline must remain unchanged.

Do not replace:

```text
EA062-M1-BASELINE-001
```

with a later profitable configuration.

Instead create:

```text
EA062-M1-BASELINE-001
EA062-TF-M5-001
EA062-BODY-001
EA062-EXIT-001
...
```

The repository must preserve the actual research history.

---

# 42. Research Status Levels

Use clear states:

```text
NOT STARTED
IN PROGRESS
COMPLETE
PASS
FAIL
BLOCKED
```

Strategy maturity may additionally use:

```text
IMPLEMENTED
BASELINE TESTED
RESEARCHING
CANDIDATE
VALIDATING
FORWARD TESTING
LIVE REVIEW
```

Do not use:

```text
VALIDATED
```

unless the required validation evidence actually exists.

---

# 43. Current Case Study — EA-062

Current strategy:

```text
EA-062_Body_Breakout
```

Baseline experiment:

```text
EA062-M1-BASELINE-001
```

Test environment:

```text
Symbol          : XAUUSD.PRO
Timeframe       : M1
Period          : 2026-01-02 → 2026-03-31
History Quality : 100% real ticks
Initial Deposit : $100
Leverage        : 1:500
```

Baseline strategy parameters:

```text
Breakout Lookback  : 20
Breakout Buffer    : 0
Minimum Body Ratio : 0.70

Lot Size           : 0.01
SL                 : 300
TP                 : 600

Break Even         : ON
BE Trigger         : 150
BE Offset          : 0

Trailing Stop      : ON
Trailing Start     : 200
Trailing Distance  : 100
Trailing Step      : 10
```

Baseline results:

```text
Total Trades            : 577

Winning Trades          : 299
Losing Trades           : 278
Win Rate                : 51.82%

Net Profit              : -$93.30
Gross Profit            : $598.54
Gross Loss              : -$691.84

Profit Factor           : 0.87
Expected Payoff         : -$0.16
Recovery Factor         : -0.83
Sharpe Ratio            : -5.00

Maximum Balance DD      : 94.36%
Maximum Equity DD       : 94.41%

Average Winner          : +$2.00
Average Loser           : -$2.49

BUY Trades              : 318
BUY Win Rate            : 53.46%

SELL Trades             : 259
SELL Win Rate           : 49.81%

Average Holding Time    : 00:04:23
```

Baseline classification:

```text
FAIL
```

The failure is caused by the combination of:

```text
Negative Net Profit
+
Profit Factor < 1
+
Negative Expected Payoff
+
Average Winner < Average Loser
+
Extremely High Drawdown
```

despite:

```text
Win Rate > 50%
```

This is an important example of why win rate alone must never be used to judge EA quality.

---

# 44. EA-062 Research Sequence

The current authorized research sequence is:

```text
EA062-M1-BASELINE-001
        │
        ▼
EA062-RQ01
Timeframe Evaluation
M1 / M5 / M15
        │
        ▼
EA062-RQ02
Minimum Body Ratio
        │
        ▼
EA062-RQ03
Breakout Lookback
        │
        ▼
EA062-RQ04
Trading Session
        │
        ▼
EA062-RQ05
Market Regime
        │
        ▼
EA062-RQ06
BUY vs SELL
        │
        ▼
EA062-RQ07
Exit Management
        │
        ▼
Long Historical Test
        │
        ▼
Out-of-Sample
        │
        ▼
Robustness
        │
        ▼
Forward Test
```

Broad optimization should not begin before controlled research provides evidence that the underlying Body Breakout hypothesis warrants further development.

---

# 45. Current EA-062 Status

```text
Strategy Code             : COMPLETE
Technical Implementation  : PASS

Baseline Backtest         : COMPLETE
Baseline Result           : FAIL

Research                  : IN PROGRESS

EA062-RQ01                : NOT STARTED
EA062-RQ02                : NOT STARTED
EA062-RQ03                : NOT STARTED
EA062-RQ04                : NOT STARTED
EA062-RQ05                : NOT STARTED
EA062-RQ06                : NOT STARTED
EA062-RQ07                : NOT STARTED

Broad Optimization        : BLOCKED

Long Historical Test      : NOT STARTED
Out-of-Sample Validation  : NOT STARTED
Robustness Testing        : NOT STARTED
Forward Testing           : NOT STARTED

Live Trading Approval     : NO
```

---

# 46. Research Principle

The repository follows one central rule:

> Preserve the hypothesis, implementation, parameters, test environment, raw evidence, result and research conclusion — whether the experiment passes or fails.

The objective is not:

```text
Make every EA look profitable.
```

The objective is:

```text
Build a transparent,
reproducible,
evidence-driven
XAUUSD algorithmic-trading research process.
```

---

## Disclaimer

This repository contains algorithmic-trading research and historical experiments.

Historical backtests do not guarantee future performance.

A PASS research experiment does not automatically authorize live trading.

Deployment of real capital requires separate validation, forward testing and human approval.
