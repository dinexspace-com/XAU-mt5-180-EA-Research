# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the standard research, development, backtesting, and validation methodology for all Expert Advisors in this repository.

The objective is to develop XAUUSD trading strategies through a repeatable process:

Research Idea
→ Define Rules
→ Implement EA
→ Baseline Backtest
→ Analyze
→ Robustness Validation
→ Forward Test
→ Production Candidate

The purpose is not to find the backtest with the highest historical profit.

The purpose is to determine whether a trading hypothesis demonstrates sufficient evidence of a repeatable and robust edge.

---

# 2. Repository Structure

Each strategy should follow the repository structure:

xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-XXX_Strategy_Name/
│       ├── EA-XXX_Strategy_Name.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-XXX_Strategy_Name/
│       ├── README.md
│       └── Strategy Tester artifacts
│
├── Research/
│   └── README.md
│
├── docs/
│   └── methodology.md
│
└── GitHub_Profile/
    └── README.md

---

# 3. Research Principles

## 3.1 Hypothesis First

Every EA must start from a clear market hypothesis.

Example:

Trend
→ Pullback / Consolidation
→ Inside Bar
→ Breakout
→ Trend Continuation

The strategy must explain why a market behavior could create an exploitable opportunity.

Do not begin with parameter optimization.

---

## 3.2 Rules Must Be Programmable

Every trading idea must be converted into explicit rules that can be implemented in MQL5.

Avoid subjective rules such as:

"Strong trend"

"Good setup"

"Beautiful Inside Bar"

"Market looks bullish"

Replace them with measurable definitions.

Example:

Price > EMA(50)

Inside High <= Mother High

Inside Low >= Mother Low

Price > Mother High

→ BUY

---

## 3.3 Simple Baseline First

The first implementation should be the simplest version capable of testing the core hypothesis.

Avoid adding unnecessary filters before the baseline is understood.

Recommended sequence:

Core Entry
+
Basic SL
+
Basic TP
+
Basic Position Control

Only after baseline testing should additional components be evaluated.

Examples:

Session Filter

ATR Filter

Mother Bar Filter

News Filter

Break Even

Trailing Stop

Dynamic Risk Management

---

# 4. EA Identification

Every EA receives a unique identifier.

Format:

EA-XXX_Strategy_Name

Example:

EA-041_Inside_Pullback_Trend

The identifier should remain stable throughout the research lifecycle.

Do not reuse an existing EA number for a different strategy.

---

# 5. Strategy Documentation

Each EA must contain:

EAs/
└── EA-XXX_Strategy_Name/
    ├── EA-XXX_Strategy_Name.mq5
    └── README.md

The README should document at minimum:

- Strategy objective
- Market hypothesis
- Entry logic
- BUY conditions
- SELL conditions
- Exit logic
- Stop Loss
- Take Profit
- Filters
- Position management
- Input parameters
- Known limitations
- Research status

The README describes what the EA is designed to do.

It must not claim profitability that has not been demonstrated by testing.

---

# 6. Implementation Method

## Stage 1 — Define Strategy

Convert the research idea into deterministic rules.

Output:

Strategy Specification

---

## Stage 2 — Implement EA

Translate the rules into MQL5.

Output:

EA-XXX_Strategy_Name.mq5

---

## Stage 3 — Compile

Compile using MetaEditor.

Required result:

0 Errors

Warnings should be reviewed before testing.

Compilation success does NOT validate trading logic.

---

## Stage 4 — Logic Verification

Before large backtests, verify that the EA behaves as intended.

Check:

- Entry conditions
- BUY / SELL direction
- Stop Loss placement
- Take Profit placement
- Position count
- Spread filter
- New-bar logic
- Magic Number
- Trade comments
- Position management

Where practical, visually inspect trades in MT5 Strategy Tester.

---

# 7. Baseline Backtest

Every EA must first receive a baseline test.

The baseline exists to answer:

"Does the simplest implementation show enough evidence to justify further research?"

It is NOT an optimization test.

Record:

- EA version
- Symbol
- Broker symbol
- Timeframe
- Test period
- Modeling / tick quality
- Initial deposit
- Leverage
- Lot size
- Spread constraints
- SL
- TP
- Filters
- Break Even state
- Trailing state

Never report a backtest result without preserving its configuration.

---

# 8. Backtest Evidence

Backtest artifacts should be stored under:

Backtest/
└── EA-XXX_Strategy_Name/

Preserve the original MetaTrader Strategy Tester report whenever possible.

Recommended artifacts:

README.md

Strategy Tester HTML report

Balance / Equity graph

Trade distribution charts

MFE / MAE chart

Holding-time chart

Additional robustness reports

The README summarizes the result.

The original Strategy Tester report remains the primary evidence.

---

# 9. Core Metrics

At minimum, evaluate:

## Profitability

- Total Net Profit
- Gross Profit
- Gross Loss
- Profit Factor
- Expected Payoff

## Risk

- Balance Drawdown
- Equity Drawdown
- Maximum Drawdown
- Recovery Factor

## Trade Statistics

- Total Trades
- Winning Trades
- Losing Trades
- Win Rate
- Average Winner
- Average Loser
- Largest Winner
- Largest Loser

## Sequence Risk

- Maximum Consecutive Wins
- Maximum Consecutive Losses
- Average Consecutive Wins
- Average Consecutive Losses

## Trade Behavior

Where available:

- MFE
- MAE
- Holding Time
- LONG performance
- SHORT performance

No single metric determines strategy quality.

Metrics must be evaluated together.

---

# 10. Trade Sample Size

Small samples can produce misleading results.

A positive result with only a small number of trades should be treated as preliminary evidence.

Example:

57 trades
+
Profit Factor 1.21

may justify continued research.

It does NOT establish a robust trading edge.

Priority should be given to increasing the number of independent observations before aggressive optimization.

---

# 11. Historical Coverage

After baseline testing, extend the historical period.

Where reliable data is available, research should include multiple market regimes.

Examples:

Trending markets

Range-bound markets

High-volatility periods

Low-volatility periods

Bullish Gold regimes

Bearish / corrective Gold regimes

The objective is to determine whether performance depends excessively on one specific market environment.

---

# 12. Multi-Timeframe Testing

Strategies should be tested on reasonable neighboring timeframes where the logic remains meaningful.

Typical XAUUSD research set:

M1

M5

M15

H1

A strategy does not need identical performance across all timeframes.

However, extreme dependence on one isolated timeframe should be investigated.

---

# 13. Parameter Research

Parameter research begins only after the baseline demonstrates enough evidence to continue.

Possible parameters include:

EMA Period

Stop Loss

Take Profit

ATR Threshold

Pattern Size

Session

Spread

Break Even

Trailing Stop

Do not optimize all parameters simultaneously in the first iteration.

Change one logical component or a small related parameter group at a time.

---

# 14. Parameter Robustness

Do not select a parameter solely because it produces the highest historical profit.

Prefer parameter regions where neighboring values also perform reasonably.

Example:

If:

Parameter 49 → poor

Parameter 50 → exceptional

Parameter 51 → poor

then Parameter 50 may represent overfitting.

A more credible region resembles:

Parameter 45 → acceptable

Parameter 50 → good

Parameter 55 → acceptable

The objective is stability, not a single historical optimum.

---

# 15. In-Sample and Out-of-Sample

After promising parameters are identified, separate research data from validation data.

## In-Sample

Used for:

Research

Parameter development

Strategy improvement

## Out-of-Sample

Used for:

Independent validation

The Out-of-Sample period must not be repeatedly optimized against.

Otherwise it effectively becomes part of the In-Sample dataset.

---

# 16. Walk-Forward Testing

Promising strategies should eventually undergo walk-forward testing.

Concept:

Train / Research
→ Test

Move Window

Train / Research
→ Test

Move Window

Repeat

The objective is to determine whether parameters selected from historical information continue to perform on unseen subsequent data.

---

# 17. Monte Carlo / Robustness Testing

Strategies that survive Out-of-Sample testing should undergo additional robustness analysis where practical.

Possible tests:

- Trade-order randomization
- Spread variation
- Slippage variation
- Execution variation
- Parameter perturbation
- Trade removal
- Return-sequence simulation

The purpose is to estimate how fragile the observed backtest result may be.

---

# 18. Transaction Costs

XAUUSD backtests must account for realistic trading conditions.

Important factors include:

Spread

Commission

Slippage

Execution

Broker symbol specifications

Swap where relevant

A strategy that only works under unrealistically favorable trading costs should not be considered validated.

---

# 19. Broker Dependency

XAUUSD specifications can differ between brokers.

Record:

Broker

Symbol

Digits

Point size

Contract specifications

Spread behavior

Commission

Leverage

Execution environment

Example:

XAUUSD

and

XAUUSD.PRO

must not automatically be assumed to behave identically.

---

# 20. Risk Management Research

Fixed lot size should generally be used during early strategy research when the objective is to study the trading logic itself.

Example:

Lot = 0.01

This helps separate:

Strategy Edge

from

Position Sizing Effects

Dynamic risk sizing may be introduced later.

Examples:

Fixed % Risk

Volatility-based sizing

ATR-based sizing

Do not use aggressive money management to make a weak strategy appear profitable.

---

# 21. Anti-Overfitting Rules

Avoid:

Testing hundreds of combinations and selecting only the best result.

Adding filters solely because they improve historical profit.

Removing losing periods without a market-based reason.

Selecting one unusually profitable timeframe.

Repeatedly optimizing against the Out-of-Sample period.

Changing strategy rules after every losing backtest.

Prefer:

Simple hypotheses.

Few parameters.

Economic / market rationale.

Large samples.

Stable parameter regions.

Independent validation.

---

# 22. Research Decision States

Each EA should have a clear research state.

Recommended states:

IDEA

IMPLEMENTED

BASELINE TESTED

RESEARCH IN PROGRESS

ROBUSTNESS TESTING

FORWARD TESTING

PRODUCTION CANDIDATE

REJECTED

A positive backtest does not automatically move an EA to PRODUCTION CANDIDATE.

---

# 23. PASS / FAIL Philosophy

Testing should answer specific questions.

Example:

Question:

Does the baseline strategy produce enough evidence to justify further research?

Possible decision:

PASS FOR FURTHER RESEARCH

This does NOT mean:

PASS FOR LIVE TRADING

Different validation stages require different evidence.

---

# 24. Evidence Requirement

A research stage should not be considered complete without evidence.

Evidence may include:

- Source code
- Compilation result
- Strategy Tester report
- Charts
- Parameter configuration
- Research notes
- Out-of-Sample results
- Walk-forward results
- Forward-test records

Claims should be traceable to stored artifacts.

---

# 25. Reproducibility

Another researcher should be able to reproduce the test using:

EA source code

+

Input parameters

+

Symbol

+

Timeframe

+

Historical period

+

Broker/test environment

+

Testing assumptions

If the result cannot reasonably be reproduced, it should not be treated as strong evidence.

---

# 26. Research Workflow

Standard workflow:

IDEA
↓
MARKET HYPOTHESIS
↓
PROGRAMMABLE RULES
↓
MQL5 IMPLEMENTATION
↓
COMPILE
↓
LOGIC CHECK
↓
BASELINE BACKTEST
↓
RESULT ANALYSIS
↓
LONG-HISTORY TEST
↓
MULTI-TIMEFRAME TEST
↓
FILTER RESEARCH
↓
PARAMETER ROBUSTNESS
↓
OUT-OF-SAMPLE
↓
WALK-FORWARD
↓
MONTE CARLO / ROBUSTNESS
↓
FORWARD TEST
↓
PRODUCTION CANDIDATE

At any stage:

Insufficient Evidence
or
Failed Robustness

→ REVISE or REJECT

---

# 27. Current Example — EA-041

EA-041_Inside_Pullback_Trend currently provides the first implementation example for this methodology.

Current completed stages:

Strategy Defined

MQL5 Implementation

Baseline Backtest

Initial Research Analysis

Current baseline:

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-09-03

Net Profit:
+$26.78

Profit Factor:
1.21

Maximum Equity Drawdown:
4.50%

Total Trades:
57

Current interpretation:

BASELINE COMPLETED

RESEARCH CONTINUES

NOT APPROVED FOR LIVE TRADING

The next priority is increasing historical coverage and comparing multiple timeframes before deeper optimization.

---

# 28. Final Principle

The repository should optimize for:

REPRODUCIBLE EVIDENCE

not:

IMPRESSIVE BACKTEST SCREENSHOTS

A strong EA should survive progressively harder validation.

The research process therefore follows:

Simple
→ Test
→ Measure
→ Validate
→ Improve
→ Retest

Only strategies that continue to demonstrate acceptable behavior through independent validation should advance toward live evaluation.
