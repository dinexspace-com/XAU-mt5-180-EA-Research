# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard research, implementation, backtesting, and validation methodology used in this repository.

The objective is to develop XAUUSD MetaTrader 5 Expert Advisors through a reproducible research process rather than selecting strategies based only on attractive historical results.

The repository follows a simple principle:

    Research Idea
         ↓
    Define Rules
         ↓
    Build Minimal EA
         ↓
    Baseline Backtest
         ↓
    Analyze Result
         ↓
    Test One Hypothesis
         ↓
    Validate
         ↓
    Accept / Reject

Every EA, including failed experiments, should preserve enough information for another researcher to understand what was tested, reproduce the test, and understand why development continued or stopped.

---

## 1. Research Principles

### 1.1 Start With the Simplest Testable Strategy

The first implementation should contain only the minimum logic required to test the core trading hypothesis.

Do not begin by adding:

- multiple indicators,
- multiple session filters,
- complex risk management,
- parameter optimization,
- machine learning,
- multiple confirmation layers,
- or other unnecessary complexity.

The objective of the baseline is not to produce the best possible backtest.

The objective is to answer:

> Does the core trading hypothesis show evidence of useful behavior?

---

### 1.2 Convert Ideas Into Explicit Rules

A trading idea must be converted into deterministic rules before implementation.

Avoid subjective definitions such as:

    strong trend
    good setup
    strong candle
    important support
    high momentum

Instead, define conditions that can be implemented and reproduced.

Example:

    BUY when:
    Close[1] > Close[2]
    AND
    Close[2] > Close[3]

A valid research rule should allow the same market data and parameters to produce the same trading decision.

---

## 2. EA Identification

Each strategy receives a permanent research identifier.

Format:

    EA-XXX_Strategy_Name

Example:

    EA-042_Three-Bar_Continuation

The identifier should remain stable throughout the research lifecycle.

Modified experiments should remain traceable to the original EA rather than being silently treated as unrelated strategies.

---

## 3. Repository Structure

Each EA source file is stored under:

    EAs/
    └── EA-XXX_Strategy_Name/
        ├── EA-XXX_Strategy_Name.mq5
        └── README.md

Backtest evidence is stored under:

    Backtest/
    └── EA-XXX_Strategy_Name/

Research findings are documented under:

    Research/

Repository-wide methodology is stored under:

    docs/
    └── methodology.md

The EA README describes what the code does.

The Backtest folder stores test evidence and results.

The Research documentation explains what was learned and what should be tested next.

The methodology defines how research should be conducted across the repository.

---

## 4. Strategy Specification

Before backtesting, every EA should have a clearly defined strategy specification.

At minimum, document:

- instrument,
- timeframe,
- BUY conditions,
- SELL conditions,
- Stop Loss,
- Take Profit,
- position sizing,
- maximum simultaneous positions,
- spread restrictions,
- trading-session restrictions if used,
- Break Even logic if used,
- Trailing Stop logic if used,
- additional entry filters,
- exit conditions.

If a condition cannot be described clearly enough to implement deterministically, the strategy specification is incomplete.

---

## 5. Minimal Implementation

The first coded version should be the smallest implementation capable of testing the central hypothesis.

For example, EA-042 begins with:

    Three directional closes
              ↓
       Immediate Entry

rather than immediately introducing:

    Trend Filter
         +
    Session Filter
         +
    ATR Filter
         +
    Pullback Filter
         +
    News Filter
         +
    Complex Exit Logic

Additional components are introduced only when there is a research reason to test them.

This makes it possible to identify which modification actually changes strategy performance.

---

## 6. Compilation and Functional Verification

Before running a performance backtest, verify that the EA functions correctly.

Minimum checks:

    MQ5 source exists
          ↓
    Compile successfully
          ↓
    No compilation errors
          ↓
    EA loads in MT5
          ↓
    Orders are generated
          ↓
    BUY/SELL logic matches specification
          ↓
    SL/TP behavior matches specification
          ↓
    Position limits work
          ↓
    Filters behave as intended

A profitable backtest is meaningless if the implementation does not match the intended strategy.

Code correctness must therefore be checked before performance interpretation.

---

## 7. Baseline Backtest

Every strategy begins with a baseline test.

The baseline acts as the control experiment for later modifications.

Record at minimum:

| Category | Required Information |
|---|---|
| EA | EA identifier/version |
| Instrument | Tested symbol |
| Timeframe | Tested timeframe |
| Period | Start and end date |
| Data | History/tick quality |
| Deposit | Initial capital |
| Leverage | Account leverage |
| Lot | Position size |
| Spread | Spread restriction |
| SL | Stop Loss |
| TP | Take Profit |
| Break Even | Enabled/disabled + settings |
| Trailing | Enabled/disabled + settings |

The exact parameter set used during the test must be preserved.

Do not assume that source-code defaults are identical to the parameters used by Strategy Tester.

---

## 8. Required Backtest Metrics

At minimum, record:

- Total Net Profit
- Gross Profit
- Gross Loss
- Profit Factor
- Expected Payoff
- Recovery Factor
- Sharpe Ratio
- Maximum Balance Drawdown
- Maximum Equity Drawdown
- Total Trades
- Winning Trades
- Losing Trades
- Win Rate
- BUY performance
- SELL performance
- Largest Winning Trade
- Largest Losing Trade
- Average Winning Trade
- Average Losing Trade
- Maximum Consecutive Wins
- Maximum Consecutive Losses

When available, also preserve:

- balance/equity curve,
- trade distribution,
- holding-time statistics,
- MFE/MAE information,
- trading-hour statistics,
- complete Strategy Tester report.

Do not evaluate a strategy using Net Profit alone.

---

## 9. Preserve Raw Evidence

Raw Strategy Tester outputs should be preserved whenever possible.

Examples:

    Strategy Tester HTML report
    Balance graph
    Trade distribution graph
    MFE/MAE graph
    Holding-time graph
    Parameter configuration

The purpose is reproducibility.

A README summary does not replace the original test evidence.

---

## 10. PASS / FAIL Evaluation

A strategy should not be marked PASS merely because Total Net Profit is positive.

Evaluation should consider at least:

    Profitability
         +
    Drawdown
         +
    Expectancy
         +
    Trade Sample Size
         +
    Stability
         +
    Risk Characteristics

A result should be considered clearly unsuitable when the evidence demonstrates that the tested configuration has unacceptable profitability or risk characteristics.

Example from EA-042 baseline:

    Net Profit        = -$992.09
    Profit Factor     = 0.92
    Expected Payoff   = -$0.17
    Sharpe Ratio      = -5.00
    Maximum Drawdown  = 99.28%
    Winning Trades    = 32.02%

Result:

    FAIL

A failed result must be preserved.

Do not delete or hide unsuccessful experiments.

Negative results are part of the research record.

---

## 11. Diagnose Before Optimizing

After a failed baseline, do not immediately run large parameter optimizations.

First determine why the strategy may be failing.

Research questions may include:

    Is the signal too frequent?

    Does the signal occur mostly in market noise?

    Does performance differ between BUY and SELL?

    Does performance vary by trading hour?

    Does the strategy require trend context?

    Does volatility affect expectancy?

    Is the entry logic weak?

    Is the exit logic inappropriate?

    Are transaction costs materially affecting results?

The objective is to create a testable hypothesis rather than blindly search parameter combinations.

---

## 12. One Major Variable at a Time

When modifying an EA, change one major strategy component per experiment whenever practical.

Example:

### Experiment 01

    Raw Three-Bar Signal

### Experiment 02

    Raw Three-Bar Signal
            +
       Trend Filter

### Experiment 03

    Previous Candidate
            +
      Volatility Filter

This structure allows researchers to measure the effect of each modification.

Avoid changing entry logic, SL, TP, session, trend filter, and volatility filter simultaneously and then attributing improvement to one component.

---

## 13. Experiment Comparison

Every experiment should be compared against a defined control.

At minimum compare:

| Metric | Baseline | Experiment |
|---|---:|---:|
| Net Profit | | |
| Profit Factor | | |
| Expected Payoff | | |
| Maximum Drawdown | | |
| Sharpe Ratio | | |
| Win Rate | | |
| Total Trades | | |

The purpose is not simply to ask:

> Is the new version profitable?

The more useful question is:

> What changed relative to the previous controlled experiment?

---

## 14. Parameter Optimization

Optimization should occur only after there is evidence that the underlying strategy structure is worth further investigation.

Optimization must not be used as the first method for discovering a strategy.

Avoid selecting parameters solely because they produce the highest historical Net Profit.

A parameter set that performs exceptionally well on one historical sample may represent overfitting rather than a robust trading edge.

Optimization results should therefore be treated as:

    Research Candidates

not:

    Proven Trading Systems

---

## 15. Development and Validation Separation

Where practical, strategy development and final validation should use logically separated data.

Conceptual structure:

    Historical Data
          ↓
    Development / Research
          ↓
    Candidate Strategy
          ↓
    Unseen Validation Period
          ↓
    Final Assessment

The validation period should not repeatedly influence strategy design.

Otherwise, it gradually becomes part of the development dataset.

---

## 16. Robustness Testing

A strategy that survives initial research should later be tested under changing conditions.

Possible robustness checks include:

- different historical periods,
- different volatility regimes,
- different spread conditions,
- parameter sensitivity,
- execution-cost sensitivity,
- out-of-sample periods,
- forward testing.

The objective is to determine whether performance depends on one narrowly selected historical configuration.

Robustness testing occurs after the minimal strategy has demonstrated enough evidence to justify additional work.

---

## 17. XAUUSD-Specific Research

This repository focuses primarily on XAUUSD.

Gold can exhibit substantially different behavior across:

- trading sessions,
- volatility regimes,
- major market events,
- liquidity conditions,
- broker specifications.

Therefore, research should record the exact tested symbol and broker-specific configuration.

For example:

    XAUUSD.PRO

must not automatically be assumed to have identical point size, spread behavior, contract specification, or execution conditions to every other broker's XAUUSD symbol.

Backtest parameters must therefore be interpreted together with the tested environment.

---

## 18. Transaction Costs

Spread and execution conditions are part of strategy performance.

They should not be treated as irrelevant external details.

High-frequency strategies are particularly sensitive to:

- spread,
- slippage,
- commission,
- execution latency,
- frequent entries.

A strategy that generates thousands of short-duration trades must be evaluated with realistic execution assumptions.

---

## 19. Avoid Overfitting

Warning signs include:

- excessive numbers of filters,
- highly specific parameter combinations,
- very narrow trading windows selected after inspecting historical results,
- repeated optimization on the same period,
- large performance deterioration after small parameter changes,
- excellent historical performance with weak economic or market rationale.

The preferred strategy is not necessarily the strategy with the highest historical profit.

Preference should be given to strategies with simpler rules and more stable behavior.

---

## 20. Research Documentation

Each research cycle should answer:

### What was tested?

Describe the exact strategy modification.

### Why was it tested?

State the hypothesis.

### What changed?

Identify the variable relative to the control.

### What was the result?

Record objective metrics.

### PASS or FAIL?

State the research decision.

### What was learned?

Explain what the experiment contributes to understanding the strategy.

### What happens next?

Define the next experiment or stop the research branch.

---

## 21. Failed Experiments

Failed experiments must remain part of the repository.

A failed strategy can provide valuable information about:

- ineffective signals,
- unsuitable timeframes,
- poor filters,
- bad parameter assumptions,
- market conditions where the hypothesis breaks down.

Repository research should therefore preserve both:

    PASS

and

    FAIL

results.

The purpose is to build research knowledge, not a collection containing only attractive backtests.

---

## 22. Research Lifecycle

The standard lifecycle is:

    IDEA
      ↓
    RULE DEFINITION
      ↓
    MINIMAL EA
      ↓
    COMPILE
      ↓
    FUNCTIONAL TEST
      ↓
    BASELINE BACKTEST
      ↓
    ANALYZE
      ↓
    PASS / FAIL
      ↓
    RESEARCH HYPOTHESIS
      ↓
    ONE CONTROLLED MODIFICATION
      ↓
    RETEST
      ↓
    COMPARE
      ↓
    VALIDATE
      ↓
    ROBUSTNESS TEST
      ↓
    FORWARD TEST
      ↓
    PRODUCTION CANDIDATE

Not every EA should reach the final stage.

Research should stop when evidence no longer justifies further development.

---

## 23. Current EA-042 Example

EA-042 provides the first example of this methodology.

### Core hypothesis

    Three consecutive directional closes
                    ↓
          Momentum Continuation

### Minimal implementation

    Three directional closes
                    ↓
             Immediate Entry

### Baseline

    XAUUSD.PRO
    M1
    2026-01-02 → 2026-04-01
    100% real ticks
    5,815 trades

### Result

    Net Profit        = -$992.09
    Profit Factor     = 0.92
    Expected Payoff   = -$0.17
    Maximum Drawdown  = 99.28%
    Sharpe Ratio      = -5.00

### Decision

    FAIL

### Research interpretation

The raw Three-Bar signal does not demonstrate sufficient standalone performance under the tested configuration.

### Next hypothesis

    Three-Bar Signal
            +
       Trend Filter

Only the trend-filter variable should be introduced in the next primary experiment.

The result should then be compared directly against the preserved baseline.

---

## 24. Definition of Research Success

The objective of this repository is not:

    Find the backtest with the highest profit.

The objective is:

    Find repeatable trading hypotheses
                ↓
    Convert them into deterministic rules
                ↓
    Test them with realistic data
                ↓
    Reject weak hypotheses
                ↓
    Improve promising hypotheses carefully
                ↓
    Validate outside development data
                ↓
    Evaluate robustness
                ↓
    Produce evidence-backed EA candidates

A strategy remains a research candidate until sufficient validation evidence exists.

---

## Final Methodology Rule

    SIMPLE FIRST
         ↓
    TEST REAL DATA
         ↓
    PRESERVE EVIDENCE
         ↓
    CHANGE ONE MAJOR VARIABLE
         ↓
    COMPARE
         ↓
    REJECT OR CONTINUE
         ↓
    VALIDATE BEFORE PRODUCTION

A successful backtest is not the end of research.

It is the beginning of validation.
