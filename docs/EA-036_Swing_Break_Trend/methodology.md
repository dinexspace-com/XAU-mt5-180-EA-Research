# Methodology — EA-036 Swing Break Trend

## Purpose

This document defines the research and validation methodology used for **EA-036 — Swing Break Trend**.

The objective is to evaluate the strategy using a controlled, evidence-driven process rather than searching directly for profitable historical parameter combinations.

The research process follows:

**Hypothesis → Implementation → Baseline Backtest → Evidence → Analysis → Controlled Experiment → Validation**

A failed backtest is retained as research evidence.

A successful backtest is not automatically considered suitable for live trading.

---

## Strategy Under Research

EA-036 tests a Swing Break continuation hypothesis.

The core entry concept is:

- Confirm a Swing High
- Confirm a Swing Low
- BUY when price breaks above the confirmed Swing High
- SELL when price breaks below the confirmed Swing Low

The current baseline uses `InpSwingBars = 5`.

The strategy operates on the current chart symbol and timeframe and uses fixed Stop Loss / Take Profit together with optional position-management logic.

---

## Research Principle

The primary rule of this research is:

> Test the trading hypothesis before optimizing the parameters.

Broad optimization is not used as the first step.

Instead, each major component of the strategy should be isolated and tested through controlled experiments.

The purpose is to determine whether a change improves the underlying strategy behavior rather than merely producing a better historical result through curve fitting.

---

## Baseline First

Every research cycle begins with a documented baseline.

The baseline provides the reference configuration against which later experiments are compared.

For EA-036, Baseline #01 is:

    Expert Advisor:       EA-036_Swing_Break_Trend

    Symbol:               XAUUSD.PRO
    Timeframe:            M1
    Period:               2026-01-02 → 2026-04-01
    Historical Data:      100% real ticks

    Initial Deposit:      $1,000
    Leverage:             1:500

    Lot Size:             0.01
    Magic Number:         123456
    Slippage:             10

    Stop Loss:            300
    Take Profit:          600

    Break Even:           OFF
    Break Even Trigger:   150
    Break Even Lock:      0

    Trailing Stop:        ON
    Trailing Start:       200
    Trailing Step:        50

    Maximum Spread:       35
    Swing Bars:           5

The baseline must remain preserved even when it fails.

Its purpose is to establish a fixed benchmark for future experiments.

---

## Baseline #01 Result

The EA-036 baseline produced:

| Metric | Result |
|---|---:|
| Total Trades | 4,573 |
| Net Profit | **-$994.01** |
| Profit Factor | **0.89** |
| Expected Payoff | **-$0.22** |
| Recovery Factor | **-0.97** |
| Sharpe Ratio | **-5.00** |
| Maximum Drawdown | **99.42%** |
| Win Rate | **40.35%** |
| BUY Win Rate | **43.06%** |
| SELL Win Rate | **37.25%** |

Baseline classification:

    FAIL

The baseline does not demonstrate a viable trading edge under the tested conditions.

The failed baseline remains the reference for future controlled experiments.

---

## Evidence Requirements

Every backtest or experiment must retain sufficient evidence to reproduce and review the result.

At minimum, save:

    MT5 Strategy Tester HTML report
    Balance / Equity graph
    Trade distribution graph
    MFE / MAE graph when available
    Holding-time graph when available
    Exact EA version
    Exact test inputs
    Symbol
    Timeframe
    Test period
    Initial deposit
    Leverage
    Historical-data quality

For EA-036, evidence belongs under:

    Backtest/
    └── EA-036_Swing_Break_Trend/

The original MT5 report should be retained unchanged.

README files summarize the result but do not replace the original Strategy Tester evidence.

---

## Reproducibility

A research result must be reproducible.

Each test should document at minimum:

    EA name and version
    Symbol
    Broker / server when relevant
    Timeframe
    Start date
    End date
    Tick model / data quality
    Initial deposit
    Leverage
    Lot size
    Stop Loss
    Take Profit
    Spread filter
    Entry parameters
    Exit parameters
    Position-management settings

If any of these values differ from the baseline, the difference should be explicitly recorded.

A result that cannot be reproduced should not be used as reliable evidence.

---

## Controlled Experiment Method

Controlled experiments should change one research variable at a time whenever practical.

Example:

    Baseline:
    BUY + SELL

    Experiment:
    BUY ONLY

All unrelated settings should remain unchanged.

This allows the result to answer a specific research question.

Avoid experiments such as:

    Change timeframe
    + change SwingBars
    + change Stop Loss
    + change Take Profit
    + enable Break Even
    + change session filter

in a single test.

Such a result would not identify which change caused the performance difference.

---

## Research Question Before Experiment

Each experiment must begin with a defined question.

Example:

    RQ-01:
    Does BUY performance differ materially from SELL performance?

The experiment should then be designed specifically to answer that question.

A good experiment should define:

    Question
    Baseline
    Variable being changed
    Values being tested
    Metrics to compare
    Result
    Interpretation
    PASS / FAIL
    Next action

Experiments should not begin with:

> Find the most profitable settings.

That is optimization, not controlled research.

---

## Current EA-036 Research Sequence

The current research order is:

    Baseline #01
         │
         ▼
    RQ-01 — BUY vs SELL
         │
         ▼
    RQ-02 — Timeframe
         │
         ▼
    RQ-03 — Swing Strength
         │
         ▼
    RQ-04 — Trend Filter
         │
         ▼
    RQ-05 — Trading Session
         │
         ▼
    RQ-06 — Exit Logic
         │
         ▼
    Robustness Testing
         │
         ▼
    Out-of-Sample Testing
         │
         ▼
    Forward Testing
         │
         ▼
    Live Deployment Review

Broad parameter optimization remains blocked until the main strategy components have been investigated.

---

## RQ-01 — Directional Evaluation

Baseline observation:

    BUY Win Rate  = 43.06%
    SELL Win Rate = 37.25%

The first controlled experiment should compare:

    A — BUY + SELL
        Baseline #01

    B — BUY ONLY

    C — SELL ONLY

All unrelated settings should remain identical.

The purpose is to determine whether the performance difference between BUY and SELL represents meaningful expectancy differences rather than only differences in win rate.

The following metrics should be compared:

    Net Profit
    Profit Factor
    Expected Payoff
    Maximum Drawdown
    Sharpe Ratio
    Total Trades
    Win Rate
    Average Win
    Average Loss

---

## RQ-02 — Timeframe Evaluation

Baseline timeframe:

    M1

Candidate comparison:

    M1
    M5
    M15

The core Swing Break logic should remain unchanged.

The research question is:

> Does the Swing Break concept become more effective when tested on higher timeframes with potentially less short-term market noise?

Performance should not be judged using Net Profit alone.

Trade-count reduction must also be considered when comparing results.

---

## RQ-03 — Swing Strength Evaluation

Baseline:

    InpSwingBars = 5

Candidate controlled values:

    3
    5
    7
    10

The objective is to determine whether requiring a stronger structural swing improves breakout quality.

The best historical value should not automatically be accepted.

Results should be evaluated for consistency and stability across neighboring parameter values.

---

## RQ-04 — Trend Filter Evaluation

The baseline does not require independent trend confirmation.

A future experiment may test whether Swing Break signals perform better when aligned with a broader trend.

Only the trend-confirmation condition should be added or changed in that experiment.

The baseline entry logic, money management and unrelated parameters should remain unchanged where practical.

---

## RQ-05 — Trading Session Evaluation

The baseline trades throughout much of the trading day.

Possible controlled groups include:

    Asia
    Europe
    USA

Exact server-time definitions must be documented before testing.

A session should not be removed based only on visual inspection.

The test must show whether restricting trading hours materially improves expectancy and risk-adjusted performance.

---

## RQ-06 — Exit Logic Evaluation

Baseline:

    Stop Loss     = 300
    Take Profit   = 600
    Break Even    = OFF
    Trailing Stop = ON

Possible controlled comparisons:

    A — Fixed SL / TP only

    B — Fixed SL / TP
        + Break Even

    C — Fixed SL / TP
        + Trailing Stop

    D — Fixed SL / TP
        + Break Even
        + Trailing Stop

Exit research should be performed after the entry behavior has been sufficiently investigated.

A complex exit system should not be used to hide a weak entry hypothesis.

---

## Minimum Metrics

Every experiment should record at least:

    Total Net Profit
    Gross Profit
    Gross Loss
    Profit Factor
    Expected Payoff
    Recovery Factor
    Sharpe Ratio
    Maximum Balance Drawdown
    Maximum Equity Drawdown
    Total Trades
    Winning Trades
    Losing Trades
    Win Rate
    Average Winning Trade
    Average Losing Trade
    Maximum Consecutive Wins
    Maximum Consecutive Losses
    Average Holding Time

When relevant, also record:

    BUY trade count
    BUY win rate
    SELL trade count
    SELL win rate
    MFE / MAE relationships
    Trading-hour distribution

---

## PASS / FAIL Method

An experiment must not PASS simply because:

    Net Profit > 0

A result should be evaluated using several dimensions.

### Profitability

Important metrics include:

    Net Profit
    Profit Factor
    Expected Payoff

### Risk

Important metrics include:

    Maximum Drawdown
    Recovery Factor
    Consecutive Losses

### Stability

Review:

    Balance curve behavior
    Trade distribution
    Sensitivity to parameter changes
    Sample size

### Statistical Sample

A result based on very few trades should not be treated as equivalent to a result based on a large trade sample.

No single metric determines strategy validity.

---

## Comparison Against Baseline

Every controlled experiment should be compared directly with Baseline #01.

A simple comparison table should be maintained:

| Metric | Baseline | Experiment | Change |
|---|---:|---:|---:|
| Net Profit |  |  |  |
| Profit Factor |  |  |  |
| Expected Payoff |  |  |  |
| Maximum Drawdown |  |  |  |
| Sharpe Ratio |  |  |  |
| Total Trades |  |  |  |
| Win Rate |  |  |  |

The experiment should answer:

1. Did expectancy improve?
2. Did drawdown improve or deteriorate?
3. Did trade count remain sufficient?
4. Did the balance curve improve?
5. Is the improvement logically connected to the tested hypothesis?

---

## Failed Experiments

Failed experiments must remain in the repository.

A failed experiment is useful evidence because it shows:

    What was tested
    Under which conditions
    What did not work
    What should not be repeated without a new reason

Failed tests should not be deleted simply to make repository performance appear better.

The research history should preserve both successful and unsuccessful experiments.

This evidence-driven process is consistent with the repository research philosophy: **Hypothesis → Implementation → Backtest → Evidence → Analysis → Controlled Experiment**. :contentReference[oaicite:0]{index=0}

---

## Optimization Policy

Broad optimization is currently:

    BLOCKED

Do not run large simultaneous sweeps across:

    SwingBars
    Stop Loss
    Take Profit
    Spread
    Break Even
    Trailing Stop
    Timeframe
    Session
    Trend Filter

until the core strategy components have been individually researched.

Optimization may be considered only after evidence indicates that the underlying strategy has a potentially valid edge.

Optimization should refine a validated hypothesis.

It should not be used to create the hypothesis.

---

## Overfitting Control

When optimization eventually begins, avoid selecting one isolated parameter combination only because it produced the highest historical profit.

Prefer parameter regions where neighboring values produce reasonably consistent behavior.

Warning signs include:

    One parameter value dramatically outperforming nearby values
    Very small trade sample
    Large increase in drawdown
    Profit concentrated in one short historical period
    Performance dependent on one direction or one unusual market event

Such results require further validation before acceptance.

---

## Out-of-Sample Validation

A strategy that performs acceptably during research must later be tested on historical data that was not used to develop or select its parameters.

The research period and validation period should be separated.

Conceptually:

    Development Data
          │
          ▼
    Build / Research
          │
          ▼
    Freeze Strategy
          │
          ▼
    Out-of-Sample Data
          │
          ▼
    Independent Evaluation

Parameters should not be modified after seeing out-of-sample results and then still call that same period out-of-sample.

If modifications are made, a new unseen validation period is required.

---

## Forward Testing

A successful historical research result is not enough for live approval.

The strategy should progress to forward testing.

Forward testing should evaluate behavior under conditions including:

    Current spreads
    Real-time price flow
    Broker execution
    Slippage
    Trading-session changes
    Market regime changes

Forward testing should use controlled risk.

A successful backtest does not automatically authorize real-money deployment. The repository's existing research philosophy also requires promising configurations to progress through robustness, out-of-sample and forward-testing stages before live deployment is considered. :contentReference[oaicite:1]{index=1}

---

## Live Deployment Gate

EA-036 should not be considered ready for live trading until all required research stages are completed.

Current state:

    Strategy Implementation     COMPLETE
    Baseline Backtest           COMPLETE
    Baseline Result             FAIL
    Controlled Research         IN PROGRESS
    Optimization                BLOCKED
    Robustness Testing          NOT STARTED
    Out-of-Sample Testing       NOT STARTED
    Forward Testing             NOT STARTED
    Live Deployment             NOT APPROVED

A strategy must not bypass these stages simply because one later backtest becomes profitable.

---

## File Structure

Research artifacts for EA-036 are organized as:

    xauusd-mt5-ea-research/
    │
    ├── EAs/
    │   └── EA-036_Swing_Break_Trend/
    │       ├── EA-036_Swing_Break_Trend.mq5
    │       └── README.md
    │
    ├── Backtest/
    │   └── EA-036_Swing_Break_Trend/
    │       ├── README.md
    │       └── MT5 Strategy Tester evidence
    │
    ├── Research/
    │   └── README.md
    │
    └── docs/
        └── methodology.md

The responsibilities of these directories are:

    EAs/
    Source code and technical strategy documentation

    Backtest/
    Original test evidence and backtest summaries

    Research/
    Strategy-specific hypotheses, findings and research roadmap

    docs/
    Research methodology and validation rules

---

## Current EA-036 Methodology Status

    EA-036 — Swing Break Trend
    │
    ├── Hypothesis
    │      └── DEFINED
    │
    ├── Implementation
    │      └── COMPLETE
    │
    ├── Baseline
    │      └── COMPLETE
    │             │
    │             └── FAIL
    │
    ├── Evidence
    │      └── SAVED
    │
    ├── Analysis
    │      └── COMPLETE
    │
    ├── Controlled Research
    │      └── IN PROGRESS
    │             │
    │             └── NEXT: RQ-01 BUY vs SELL
    │
    ├── Optimization
    │      └── BLOCKED
    │
    ├── Out-of-Sample
    │      └── NOT STARTED
    │
    ├── Forward Test
    │      └── NOT STARTED
    │
    └── Live Deployment
           └── NOT APPROVED

---

## Next Methodology Action

The next approved research action is:

**RQ-01 — BUY vs SELL Directional Evaluation**

Run:

    Baseline — BUY + SELL
    Variant A — BUY ONLY
    Variant B — SELL ONLY

All unrelated settings should remain unchanged.

After the three results are available:

1. Save the original MT5 evidence.
2. Record the metrics.
3. Compare each result against Baseline #01.
4. Determine whether directional asymmetry materially affects expectancy.
5. Update `Research/README.md`.
6. Decide the next controlled experiment.

Do not begin broad optimization before this research question is resolved.

---

## Final Methodology Principle

The research standard for EA-036 is:

> Preserve the baseline, change one hypothesis at a time, keep the evidence, compare against the reference, and do not confuse historical optimization with proof of a trading edge.

Current conclusion:

    BASELINE        = FAIL
    RESEARCH        = IN PROGRESS
    OPTIMIZATION    = BLOCKED
    NEXT TEST       = BUY vs SELL
    LIVE TRADING    = NOT APPROVED
