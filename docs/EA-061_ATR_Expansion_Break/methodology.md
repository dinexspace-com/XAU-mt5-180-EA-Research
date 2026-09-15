# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard research, implementation, backtesting and validation methodology used in the **xauusd-mt5-ea-research** repository.

The objective is to evaluate XAUUSD trading ideas in a structured and reproducible way.

The repository is intended to preserve both successful and unsuccessful experiments.

A failed strategy or backtest is retained because negative results are part of the research evidence.

---

## Research Workflow

Each EA should follow the same basic research process:

```text
Trading Idea
    ↓
Define Hypothesis
    ↓
Define Explicit Trading Rules
    ↓
Implement MQL5 EA
    ↓
Compile / Technical Validation
    ↓
Baseline Backtest
    ↓
Analyze Results
    ↓
PASS / FAIL
    ↓
Research Iterations
    ↓
Out-of-Sample Validation
    ↓
Forward Test
    ↓
Live Trading Consideration
```

Optimization does not replace validation.

A strategy must first produce reproducible evidence before more complex development is justified.

---

# 1. Strategy Identification

Each strategy receives a unique identifier.

Example:

```text
EA-061_ATR_Expansion_Break
```

Naming convention:

```text
EA-[ID]_[Strategy_Name]
```

Example repository structure:

```text
EAs/
└── EA-061_ATR_Expansion_Break/
    ├── EA-061_ATR_Expansion_Break.mq5
    └── README.md

Backtest/
└── EA-061_ATR_Expansion_Break/
    ├── README.md
    ├── Strategy Tester HTML report
    └── Strategy Tester charts
```

The EA identifier should remain stable across the research process.

---

# 2. Research Hypothesis

Before optimization, the trading concept should be expressed as a testable hypothesis.

Example:

```text
Price breakouts accompanied by ATR volatility expansion may have
a higher probability of directional continuation than ordinary
range breakouts.
```

A research hypothesis should identify:

- market behavior being tested;
- signal or condition being observed;
- expected market response;
- instrument;
- intended timeframe or timeframe range.

The hypothesis should exist before interpreting the backtest result.

This reduces the risk of inventing explanations after observing historical performance.

---

# 3. Trading Rules

The strategy must be converted into explicit rules that can be implemented programmatically.

At minimum, document:

```text
ENTRY
EXIT
STOP LOSS
TAKE PROFIT
POSITION SIZE
TIMEFRAME
INDICATORS
FILTERS
TRADE MANAGEMENT
```

Rules should avoid discretionary descriptions such as:

```text
Enter when the market looks strong.
```

Prefer measurable conditions such as:

```text
Close[1] > HighestHigh(previous N bars)
AND
Range[1] > ATR[2] × multiplier
```

The objective is reproducibility.

Two implementations using the same documented rules should produce materially consistent trading logic.

---

# 4. Baseline Implementation

The first EA version should be intentionally simple.

The baseline exists to answer:

```text
Does the core trading hypothesis show evidence of an exploitable edge?
```

Avoid adding unnecessary filters before testing the basic idea.

Examples of features that should normally be introduced only when justified include:

- multiple indicators;
- complex market-regime classification;
- session filters;
- adaptive parameters;
- machine-learning models;
- multi-timeframe confirmation;
- complex position sizing.

These may improve a strategy, but introducing them too early makes it difficult to identify the source of performance.

---

# 5. Source Code Preservation

The MQL5 source used for a backtest should be preserved.

Example:

```text
EAs/
└── EA-061_ATR_Expansion_Break/
    └── EA-061_ATR_Expansion_Break.mq5
```

The corresponding README should document:

- strategy concept;
- entry logic;
- exit logic;
- default parameters;
- risk management;
- execution protections;
- platform requirements.

A backtest result should be traceable to the EA implementation that produced it.

---

# 6. Technical Validation

Before performance analysis, the EA should pass basic technical checks.

Minimum technical checks:

```text
MQL5 compilation successful
No unintended duplicate positions
Correct Magic Number behavior
Correct symbol handling
Correct timeframe handling
SL/TP submitted correctly
Spread protection working
Volume validation working
Broker stop-level validation working
Trade-management logic working
```

A technically broken EA should not proceed to performance interpretation.

A profitable backtest does not compensate for incorrect implementation.

---

# 7. Baseline Backtest

The first backtest establishes the reference result.

The following information should be preserved:

```text
EA name
EA version / source
Symbol
Timeframe
Test start date
Test end date
Initial deposit
Leverage
Lot size / sizing method
Strategy parameters
History quality
Broker / server where relevant
MT5 build where relevant
```

For research intended to evaluate execution-sensitive XAUUSD strategies, real-tick testing is preferred when suitable historical data are available.

The exact data quality used must be recorded rather than assumed.

---

# 8. Backtest Evidence

Original MetaTrader 5 Strategy Tester evidence should be preserved.

Typical files include:

```text
Strategy Tester HTML report
Balance / equity chart
Entry distribution chart
MFE / MAE chart
Holding-time chart
README.md
```

Example:

```text
Backtest/
└── EA-061_ATR_Expansion_Break/
    ├── README.md
    ├── ReportTester-xxxxxx.html
    ├── ReportTester-xxxxxx.png
    ├── ReportTester-xxxxxx-hst.png
    ├── ReportTester-xxxxxx-mfemae.png
    └── ReportTester-xxxxxx-holding.png
```

The original report should not be modified to make an unsuccessful strategy appear successful.

Negative results are research evidence.

---

# 9. Core Performance Metrics

At minimum, evaluate:

```text
Total Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Maximum Drawdown
Relative Drawdown
Total Trades
Win Rate
Average Winning Trade
Average Losing Trade
Maximum Consecutive Wins
Maximum Consecutive Losses
Recovery Factor
Sharpe Ratio
```

No single metric determines strategy quality.

Metrics must be interpreted together.

---

# 10. Profit Factor

Profit Factor is:

```text
Gross Profit
────────────
Gross Loss
```

Conceptually:

```text
PF > 1.0 → historical gross profit exceeded historical gross loss
PF < 1.0 → historical gross loss exceeded historical gross profit
```

A Profit Factor above 1.0 alone is not sufficient to approve a strategy.

Drawdown, trade count, stability and validation results must also be considered.

---

# 11. Expectancy

A useful conceptual representation of trade expectancy is:

```text
Expectancy =
(Win Probability × Average Win)
-
(Loss Probability × Average Loss)
```

A strategy can potentially operate with:

```text
Win Rate < 50%
```

if its average winning trade is sufficiently larger than its average losing trade.

Likewise, a high win rate does not guarantee profitability if losses are disproportionately large.

Therefore evaluate together:

```text
Win Rate
Average Win
Average Loss
Expected Payoff
Profit Factor
```

---

# 12. Drawdown

Drawdown is a primary risk metric.

Always record both balance and equity drawdown when available.

A strategy can produce positive net profit while still carrying unacceptable drawdown.

For this reason:

```text
Positive Net Profit ≠ Automatic PASS
```

Capital preservation must be considered separately from profitability.

---

# 13. Trade Count

A very small sample of trades can produce misleading results.

Example:

```text
10 trades with strong profit
```

does not provide the same evidence as a substantially larger sample.

Trade count should therefore be considered when evaluating confidence in the observed performance.

There is no universal minimum trade count applicable to every strategy.

The required sample depends on trading frequency, market regime coverage and the hypothesis being tested.

---

# 14. Balance and Equity Curve

Do not evaluate a strategy using final profit alone.

Inspect the shape of the balance/equity curve.

Look for:

```text
Persistent upward progression
Long stagnation periods
Large sudden losses
Late-period deterioration
Dependence on a small number of trades
Large regime-specific changes
```

A strategy whose total profit depends on one isolated event should be treated differently from a strategy whose returns are distributed across many trades and market conditions.

---

# 15. Long vs Short Analysis

BUY and SELL performance should be inspected separately.

Record where available:

```text
Long Trades
Long Win Rate
Short Trades
Short Win Rate
```

A strategy may have asymmetric behavior.

For example:

```text
BUY profitable
SELL unprofitable
```

This observation can become a new research hypothesis.

It should not automatically justify deleting losing SELL trades from the historical result.

Any directional restriction must be tested as a separate experiment.

---

# 16. Holding-Time Analysis

Record:

```text
Minimum Holding Time
Average Holding Time
Maximum Holding Time
```

Holding time helps classify actual EA behavior.

A strategy intended as a breakout system may behave like a scalper if most trades remain open only for several minutes.

Short holding periods also increase the importance of:

- spread;
- slippage;
- execution latency;
- tick quality;
- broker conditions.

---

# 17. MFE / MAE Analysis

Where available, preserve:

```text
Maximum Favorable Excursion (MFE)
Maximum Adverse Excursion (MAE)
Profit/MFE relationship
Profit/MAE relationship
```

These measurements can help investigate whether:

- profitable movement is being captured efficiently;
- stops are too close or too wide;
- exits occur prematurely;
- trades experience excessive adverse movement.

MFE/MAE analysis should generate hypotheses.

It should not be treated as proof that a particular exit modification will improve future performance.

---

# 18. Baseline PASS / FAIL

Every baseline should receive an explicit research assessment.

Example:

```text
BASELINE RESULT: PASS
```

or:

```text
BASELINE RESULT: FAIL
```

FAIL results remain in the repository.

A FAIL baseline may still produce useful information for subsequent research.

---

# 19. Minimum Failure Conditions

A baseline should normally be classified as FAIL when the evidence clearly demonstrates one or more critical problems such as:

```text
Negative Total Net Profit
Profit Factor below 1.0
Negative Expected Payoff
Unacceptable drawdown
Severe balance/equity deterioration
Technical implementation failure
Insufficient evidence to support the hypothesis
```

These conditions are research screening rules, not universal claims that every profitable strategy must satisfy one fixed numerical threshold.

---

# 20. Research Iterations

After the baseline, modifications should be treated as separate experiments.

Where practical, change one major dimension at a time.

Example:

```text
Baseline
    ↓
Timeframe Experiment
    ↓
ATR Threshold Experiment
    ↓
Breakout Lookback Experiment
    ↓
Session Experiment
    ↓
Exit Experiment
    ↓
Market-Regime Experiment
```

This makes it easier to determine which change affected performance.

---

# 21. Parameter Testing

Parameter testing should answer a research question rather than search blindly for the highest historical profit.

Example:

```text
Question:
Does ATR multiplier materially affect breakout quality?

Test:
ATR Multiplier = 1.0
ATR Multiplier = 1.25
ATR Multiplier = 1.5
ATR Multiplier = 1.75
ATR Multiplier = 2.0
```

Compare:

```text
Net Profit
Profit Factor
Drawdown
Trade Count
Expected Payoff
Stability
```

Do not select a parameter solely because it produces the highest historical profit.

---

# 22. Avoiding Overfitting

Optimization introduces overfitting risk.

A configuration may perform extremely well because it has adapted to historical noise.

Warning signs include:

```text
One exact parameter combination dramatically outperforming nearby values
Very high profit with very few trades
Performance concentrated in a short period
Large degradation outside the optimization sample
Many parameters optimized simultaneously
```

Prefer parameter regions that remain reasonably stable across neighboring values rather than isolated historical peaks.

---

# 23. In-Sample and Out-of-Sample Testing

Development and validation data should be separated when practical.

Example:

```text
Historical Data
│
├── In-Sample
│   └── Strategy development / parameter research
│
└── Out-of-Sample
    └── Independent validation
```

The out-of-sample period should not be used repeatedly to tune the strategy.

Otherwise it gradually becomes part of the development sample.

---

# 24. Forward Testing

A strategy that survives historical validation should proceed to forward testing before live deployment.

Forward testing helps evaluate conditions that historical simulation may not fully represent, including:

```text
Live spread variation
Slippage
Execution delay
Broker behavior
Market-data differences
Operational stability
EA runtime behavior
```

Forward testing should preferably occur in a controlled demo or otherwise explicitly limited environment before real capital is considered.

---

# 25. Live Trading Approval

Backtest profitability alone does not authorize live trading.

The research progression is:

```text
Baseline
    ↓
Research
    ↓
Validation
    ↓
Out-of-Sample
    ↓
Forward Test
    ↓
Human Review
    ↓
Live Trading Decision
```

The repository documents evidence.

It does not automatically authorize deployment of capital.

---

# 26. Reproducibility

Every important result should be reproducible as far as the available environment permits.

A researcher should be able to identify:

```text
Which EA produced the result?
Which parameters were used?
Which symbol was tested?
Which timeframe was tested?
Which historical period was tested?
Which deposit and leverage were used?
Which Strategy Tester report contains the evidence?
```

If these questions cannot be answered, the experiment is insufficiently documented.

Broker data and execution properties can differ, so reproduction on another broker may not produce identical results.

Such differences should be recorded rather than hidden.

---

# 27. Evidence Preservation

Never overwrite a failed experiment with a successful optimization result.

Prefer:

```text
Baseline
Iteration 01
Iteration 02
Iteration 03
...
```

This preserves the research history.

The repository should show:

```text
What was tested
What happened
What changed
Why it changed
What happened next
```

---

# 28. Repository Structure

Standard structure:

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
│       ├── MT5 Strategy Tester report
│       └── Strategy Tester images
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

# 29. EA Research Record

For every EA, the repository should make it possible to reconstruct:

```text
EA ID
    ↓
Research Hypothesis
    ↓
Trading Rules
    ↓
Source Code
    ↓
Parameters
    ↓
Backtest Environment
    ↓
Raw Evidence
    ↓
Performance Metrics
    ↓
PASS / FAIL
    ↓
Research Findings
    ↓
Next Experiment
```

This chain is the core research record.

---

# 30. Current Example — EA-061

EA-061 provides an example of the methodology.

```text
EA:
EA-061_ATR_Expansion_Break

Market:
XAUUSD.PRO

Timeframe:
M1

Baseline Period:
2026-01-02 → 2026-03-31

Initial Deposit:
$100

History:
100% real ticks

Trades:
494

Net Profit:
-$92.25

Profit Factor:
0.85

Expected Payoff:
-$0.19

Maximum Equity Drawdown:
93.51%

Baseline:
FAIL
```

The baseline is retained even though the strategy failed.

The correct research action is not to remove the result.

The next action is to formulate and test new hypotheses while preserving EA-061's original baseline as evidence.

---

# Research Principle

The repository follows one central principle:

> **Preserve the hypothesis, implementation, test conditions, raw evidence and result — whether the result succeeds or fails.**

The purpose of the repository is not to make every EA appear profitable.

The purpose is to build a transparent and reproducible body of XAUUSD algorithmic-trading research.
