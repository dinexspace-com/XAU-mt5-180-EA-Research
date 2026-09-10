# Research & Backtesting Methodology

## 1. Purpose

This document defines the research, implementation, backtesting, evaluation, and validation methodology used in the **XAUUSD MT5 EA Research** repository.

The objective is to evaluate trading ideas systematically and reproducibly rather than selecting strategies based only on attractive historical returns.

The standard workflow is:

    Strategy Idea
        ↓
    Define Explicit Trading Rules
        ↓
    Implement EA in MQL5
        ↓
    Compile & Technical Validation
        ↓
    Baseline Backtest
        ↓
    Performance Evaluation
        ↓
    Research Hypotheses
        ↓
    Controlled Experiments
        ↓
    Robustness Testing
        ↓
    Out-of-Sample Testing
        ↓
    Forward Testing
        ↓
    Final Research Classification

Every EA should follow the same general process so that results can be compared consistently.

---

## 2. Repository Research Principle

The repository follows five core principles:

1. **Reproducibility**
2. **Evidence before conclusions**
3. **Failed experiments are preserved**
4. **One major change at a time**
5. **Optimization is not validation**

A strategy is not considered successful merely because one backtest is profitable.

Likewise, a failed strategy is not removed from the repository.

Both positive and negative experiments provide useful research evidence.

---

## 3. Research Unit

Each Expert Advisor is treated as an independent research experiment.

Each EA receives a unique identifier:

    EA-XXX

Example:

    EA-051_15-Bar_Extremes

The identifier should remain stable throughout the research lifecycle.

The source code, documentation, backtests, and research conclusions should all reference the same EA identifier.

---

## 4. Standard EA Structure

Each strategy should have its own directory under:

    EAs/

Example:

    EAs/
    └── EA-051_15-Bar_Extremes/
        ├── EA-051_15-Bar_Extremes.mq5
        └── README.md

The `.mq5` file contains the executable trading logic.

The strategy README documents:

- strategy concept,
- entry rules,
- exit rules,
- configurable parameters,
- trade management,
- implementation assumptions,
- current research status.

---

## 5. Strategy Definition

Before evaluating performance, the strategy must be expressible as explicit rules.

At minimum, the following must be defined:

### Entry

Specify exactly what conditions create:

    BUY
    SELL

The rules should be sufficiently precise to implement without discretionary interpretation.

### Exit

Define how positions are closed.

Possible mechanisms include:

- Stop Loss,
- Take Profit,
- trailing stop,
- break-even,
- opposite signal,
- time-based exit,
- volatility-based exit,
- channel exit.

### Position Sizing

Specify whether the strategy uses:

- fixed lot,
- fixed monetary risk,
- percentage risk,
- volatility-adjusted sizing.

### Filters

Any filter must be explicitly documented.

Examples:

- spread,
- trading session,
- volatility,
- trend,
- news,
- day of week,
- higher timeframe.

No undocumented discretionary filter should be introduced during testing.

---

## 6. Baseline First

Every strategy should begin with the simplest reasonable implementation of the original hypothesis.

This is the **baseline**.

The baseline exists to answer:

> Does the original trading idea demonstrate evidence of an edge before additional complexity is introduced?

Complex filters should not be added before the baseline has been measured.

For example:

    Original breakout strategy
        ↓
    Baseline test
        ↓
    Analyze weakness
        ↓
    Form hypothesis
        ↓
    Add one justified modification
        ↓
    Retest

This prevents unnecessary strategy complexity and makes research conclusions easier to interpret.

---

## 7. MQL5 Implementation

Expert Advisors are implemented for MetaTrader 5 using MQL5.

The implementation should prioritize:

- deterministic logic,
- readable source code,
- explicit inputs,
- reproducible behavior,
- isolated Magic Number,
- controlled order management,
- clear BUY/SELL rules.

Before a strategy enters the backtesting stage, the EA should compile successfully.

Preferred technical requirement:

    Errors   = 0
    Warnings = 0

A strategy should not be evaluated from a source version known to contain compilation errors.

---

## 8. Version Consistency

The exact EA version used for a backtest must correspond to the strategy being documented.

If trading logic changes materially, the new result should not silently replace the previous experiment.

Changes such as the following should be tracked:

- entry logic,
- exit logic,
- lookback period,
- filters,
- risk management,
- Stop Loss,
- Take Profit,
- trailing logic,
- break-even logic.

Historical results should remain traceable to the implementation that generated them.

---

## 9. Backtesting Platform

The primary testing environment is:

    MetaTrader 5 Strategy Tester

Whenever possible, historical tests should use:

    100% real ticks

The Strategy Tester report should be preserved as evidence rather than manually transcribing only selected statistics.

The original HTML report is preferred because it contains:

- settings,
- inputs,
- performance metrics,
- orders,
- deals,
- charts,
- trade history.

---

## 10. Baseline Backtest Configuration

Each backtest must record at least:

| Field | Required |
|---|---|
| EA | Yes |
| Symbol | Yes |
| Timeframe | Yes |
| Test period | Yes |
| Initial deposit | Yes |
| Leverage | Yes |
| Lot/risk model | Yes |
| Stop Loss | Yes |
| Take Profit | Yes |
| Spread configuration | Yes |
| Major filters | Yes |
| Data quality | Yes |

This information makes the experiment reproducible.

---

## 11. XAUUSD Symbol Handling

Broker symbol names may differ.

Examples may include:

    XAUUSD
    XAUUSD.PRO
    GOLD
    XAUUSDm

The exact symbol used in each test must therefore be recorded.

Results from different broker symbols should not automatically be assumed to be identical because:

- spreads may differ,
- tick data may differ,
- contract specifications may differ,
- execution assumptions may differ,
- trading sessions may differ.

The tested symbol is part of the experiment definition.

---

## 12. Timeframe Handling

The exact timeframe must always be documented.

Examples:

    M1
    M5
    M15
    H1
    H4

Performance on one timeframe must not be assumed to transfer to another timeframe.

If a strategy is tested across multiple timeframes, each timeframe should be treated as a separate experiment or comparison.

---

## 13. Backtest Evidence

Each EA should have a corresponding directory under:

    Backtest/

Example:

    Backtest/
    └── EA-051_15-Bar_Extremes/
        ├── ReportTester-952747.html
        ├── ReportTester-952747.png
        ├── ReportTester-952747-hst.png
        ├── ReportTester-952747-mfemae.png
        ├── ReportTester-952747-holding.png
        └── README.md

The original MetaTrader 5 output should be preserved whenever possible.

Charts should not replace the original report.

The HTML report remains the primary source of numerical backtest evidence.

---

## 14. Core Performance Metrics

A strategy must not be evaluated using Net Profit alone.

At minimum, review the following metrics.

### Total Net Profit

    Net Profit = Gross Profit + Gross Loss

Positive Net Profit is necessary for a profitable historical experiment but is not sufficient evidence of robustness.

### Profit Factor

    Profit Factor = Gross Profit / |Gross Loss|

Interpretation:

    PF > 1  → historical gross profit exceeded gross loss
    PF = 1  → approximately break-even
    PF < 1  → historical gross loss exceeded gross profit

Profit Factor should always be interpreted together with sample size and drawdown.

### Expected Payoff

Expected Payoff estimates the average result per trade.

A negative value indicates negative historical expectancy for the tested sample.

### Drawdown

Both balance and equity drawdown should be reviewed.

Important measures include:

    Absolute Drawdown
    Maximal Drawdown
    Relative Drawdown

High drawdown may make a strategy unacceptable even when Net Profit is positive.

### Recovery Factor

Recovery Factor provides information about profit relative to drawdown.

Negative Recovery Factor is a clear warning sign when Net Profit is negative.

### Sharpe Ratio

Sharpe Ratio provides a risk-adjusted performance measure.

It should not be used as the sole strategy-selection criterion.

### Win Rate

    Win Rate = Winning Trades / Total Trades

Win rate must be evaluated together with average winner and average loser.

A low-win-rate strategy may still be profitable when winners are sufficiently larger than losses.

### Average Winner / Average Loser

A useful payoff measure is:

    Payoff Ratio =
    Average Profit Trade / |Average Loss Trade|

Approximate break-even win rate can then be estimated as:

    Break-even Win Rate =
    1 / (1 + Payoff Ratio)

The actual win rate can be compared with this threshold.

---

## 15. Trade Sample Size

A result based on very few trades should be treated cautiously.

For example:

    10 trades

provides substantially less evidence than:

    1,000 trades

However, a large number of trades does not automatically make a strategy profitable or robust.

Trade count affects confidence in the observed behavior, not the quality of the strategy itself.

---

## 16. Balance Curve Analysis

The shape of the balance curve should be reviewed alongside summary metrics.

Look for:

- persistent growth,
- persistent decline,
- long stagnation,
- sudden isolated gains,
- sudden catastrophic losses,
- regime-dependent behavior.

A strategy whose entire historical profit depends on a very small number of exceptional trades requires additional investigation.

Likewise, a persistent downward curve suggests a structural weakness rather than one isolated bad event.

---

## 17. Long and Short Analysis

BUY and SELL performance should be inspected separately whenever the Strategy Tester provides sufficient information.

Record:

    Long Trades
    Long Win Rate

    Short Trades
    Short Win Rate

If one direction performs substantially differently from the other, this can become a research hypothesis.

However, the weaker side should not automatically be deleted.

Directional filtering must be tested as a new experiment.

---

## 18. Time Distribution Analysis

Where available, analyze trades by:

- hour,
- weekday,
- month,
- holding time.

These distributions can reveal potential areas for further investigation.

However:

> A historical concentration of profitable trades during a particular hour is not sufficient justification for immediately creating a session filter.

The observation should first become a hypothesis and then be independently tested.

---

## 19. MFE and MAE Analysis

Maximum Favorable Excursion (MFE) and Maximum Adverse Excursion (MAE) can help analyze trade behavior.

MFE measures how far a trade moved favorably while open.

MAE measures how far a trade moved adversely while open.

These statistics can help investigate:

- Stop Loss placement,
- Take Profit placement,
- premature exits,
- excessive stop distance,
- potential trailing behavior.

MFE/MAE observations should be used to generate hypotheses rather than directly optimize the EA against individual historical trades.

---

## 20. Holding-Time Analysis

Record:

    Minimum Holding Time
    Average Holding Time
    Maximum Holding Time

This helps classify the actual behavior of the EA.

For example, a strategy with an average holding time of only several minutes should be treated as a short-term trading system even if its conceptual origin comes from longer-term trend-following research.

Execution costs and market microstructure become increasingly important at shorter horizons.

---

## 21. Baseline Classification

After the baseline backtest, assign a research classification.

Recommended states:

    PASS
    FAIL
    INCONCLUSIVE

### PASS

A baseline may proceed to robustness research when it demonstrates sufficiently promising behavior to justify further testing.

PASS does NOT mean production-ready.

### FAIL

Use FAIL when evidence clearly rejects the tested configuration.

Examples include:

- negative Net Profit,
- Profit Factor below 1,
- unacceptable drawdown,
- persistent declining balance,
- clearly negative expectancy.

A failed baseline should remain in the repository.

### INCONCLUSIVE

Use when the available evidence is insufficient.

Examples:

- very small sample,
- incomplete historical data,
- incorrect testing configuration,
- technical problems,
- unreliable data quality.

INCONCLUSIVE should not be converted to PASS simply to continue development.

---

## 22. Failure Is Research Evidence

A failed backtest is a valid research result.

Do not:

- delete the EA,
- hide the result,
- modify the historical report,
- report only favorable metrics,
- relabel the test as successful.

Instead:

    Record failure
        ↓
    Identify measurable weakness
        ↓
    Form new hypothesis
        ↓
    Create controlled experiment

This preserves the integrity of the research process.

---

## 23. Hypothesis-Driven Improvement

Strategy modifications should address an observed weakness.

Example:

    Observation:
    Breakout EA has favorable winner/loser ratio
    but excessive losing trades.

    Hypothesis:
    Too many weak breakouts are being accepted.

    Experiment:
    Add a breakout-strength filter.

    Compare:
    Baseline vs modified strategy.

This is preferable to randomly adding indicators until historical performance improves.

---

## 24. One Major Change at a Time

Whenever practical, modify one major component per experiment.

Example sequence:

    Baseline
        ↓
    Lookback modification
        ↓
    Breakout filter
        ↓
    Volatility filter
        ↓
    Session filter
        ↓
    Trend filter
        ↓
    Exit modification

Changing several components simultaneously makes it difficult to determine which change caused the observed result.

---

## 25. Parameter Sensitivity

A parameter should not be accepted solely because one exact value produces the highest historical return.

Test neighboring values.

Example:

    Lookback = 10
    Lookback = 15
    Lookback = 20
    Lookback = 30
    Lookback = 50

The goal is to identify stable regions.

A result such as:

    Parameter 29 → profitable
    Parameter 30 → profitable
    Parameter 31 → profitable

is generally more interesting than:

    Parameter 29 → loss
    Parameter 30 → exceptional profit
    Parameter 31 → loss

An isolated optimum may indicate curve fitting.

---

## 26. Optimization Policy

MetaTrader 5 optimization can be used for research, but optimization output is not proof of a trading edge.

Optimization should answer questions such as:

> Is there a stable region of reasonable parameter values?

It should not simply answer:

> Which parameter combination produced the largest historical profit?

Avoid selecting configurations based only on:

    Maximum Net Profit

Instead compare:

- Profit Factor,
- drawdown,
- expectancy,
- trade count,
- stability,
- neighboring parameter behavior.

---

## 27. Overfitting Risk

Repeatedly testing many combinations increases the probability of finding a historically profitable configuration by chance.

Common sources of overfitting include:

- excessive parameters,
- many indicators,
- narrow trading hours selected after observing results,
- exact parameter values with no neighboring stability,
- repeated optimization on the same dataset,
- selecting only the best historical run.

Complexity must therefore be justified by evidence.

The preferred sequence is:

    Simple
        ↓
    Test
        ↓
    Measure
        ↓
    Add only justified complexity

---

## 28. In-Sample and Out-of-Sample Testing

The same historical data should not be used indefinitely for both strategy development and final validation.

Where sufficient data exists, separate:

    In-Sample (IS)

and:

    Out-of-Sample (OOS)

The In-Sample period may be used for:

- strategy development,
- parameter research,
- hypothesis testing.

The Out-of-Sample period should remain unseen during development whenever possible.

After selecting a candidate configuration:

    Freeze strategy
        ↓
    Run OOS test
        ↓
    Evaluate without modification

If the strategy fails OOS, the failure must be recorded.

Do not repeatedly tune the strategy on the OOS period and continue calling it out-of-sample.

Once used for development, that dataset effectively becomes part of the research sample.

---

## 29. Multi-Period Validation

A strategy should eventually be evaluated across different market conditions.

Possible periods may contain:

- strong trends,
- ranges,
- high volatility,
- low volatility,
- major macroeconomic events.

A strategy that performs only during one narrow market regime requires additional caution.

---

## 30. Forward Testing

Historical backtesting should eventually be followed by forward testing.

Preferred progression:

    Historical Baseline
        ↓
    Research
        ↓
    Robustness
        ↓
    Out-of-Sample
        ↓
    Demo Forward Test
        ↓
    Review
        ↓
    Further decision

Forward testing helps reveal issues not fully represented by historical simulation.

Examples include:

- live spread behavior,
- slippage,
- execution latency,
- broker conditions,
- trading-session differences.

A profitable historical test should not automatically trigger live deployment.

---

## 31. Production Readiness

A research PASS is not equivalent to production approval.

Suggested lifecycle:

    RESEARCH
        ↓
    BASELINE PASS
        ↓
    ROBUSTNESS PASS
        ↓
    OOS PASS
        ↓
    FORWARD TEST PASS
        ↓
    CANDIDATE

Production or live-capital decisions require a separate risk review.

---

## 32. Research Status Tracking

Each EA should clearly show its current state.

Example:

| Stage | Status |
|---|---|
| Strategy Definition | COMPLETE |
| MQL5 Implementation | COMPLETE |
| Compile Validation | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Evaluation | FAIL |
| Parameter Research | NOT TESTED |
| Robustness Test | NOT TESTED |
| Out-of-Sample Test | NOT TESTED |
| Forward Test | NOT TESTED |
| Production Ready | NO |

Status must reflect actual evidence.

Do not mark a stage COMPLETE or PASS when the required test has not been performed.

---

## 33. Naming Convention

Recommended EA naming:

    EA-XXX_Strategy_Name

Example:

    EA-051_15-Bar_Extremes

Backtest directories should use the same identifier:

    Backtest/
    └── EA-051_15-Bar_Extremes/

This creates a direct relationship between:

    Source
    Research
    Backtest
    Documentation

---

## 34. Artifact Preservation

Research artifacts should not be overwritten simply because a newer result is better.

Important artifacts include:

- MQL5 source,
- README documentation,
- MT5 HTML report,
- balance graph,
- trade-distribution graph,
- MFE/MAE graph,
- holding-time graph,
- research conclusions.

When multiple significant experiments are performed, their outputs should remain distinguishable.

This makes it possible to reconstruct how the strategy evolved.

---

## 35. Evidence Hierarchy

When documenting results, use the following priority:

    Original MT5 Strategy Tester report
        ↓
    Generated MT5 charts
        ↓
    Repository README summary
        ↓
    Research interpretation

Numerical metrics should be taken from the original report whenever possible.

Interpretation must not silently replace raw evidence.

---

## 36. Research Integrity

The repository should document both favorable and unfavorable findings.

Do not:

- cherry-pick profitable periods without disclosure,
- remove losing trades,
- hide drawdown,
- omit failed configurations,
- alter Strategy Tester output,
- claim robustness without robustness testing,
- claim OOS validation when the period was used for optimization.

The objective is not to make every EA appear profitable.

The objective is to determine which ideas survive systematic testing.

---

## 37. Current Example — EA-051

EA-051 provides the first documented example of this methodology.

Baseline:

    Strategy      = 15-Bar Extremes
    Symbol        = XAUUSD.PRO
    Timeframe     = M1
    Period        = 2026-01-02 → 2026-03-31
    Initial       = $1,000
    Lot           = 0.01
    SL            = 300
    TP            = 600
    Real Ticks    = 100%

Observed:

    Total Trades     = 2,046
    Net Profit       = -$743.41
    Profit Factor    = 0.84
    Expected Payoff  = -$0.36
    Win Rate         = 29.96%
    Equity Drawdown  = 77.75%

Classification:

    EA-051 BASELINE = FAIL

This classification applies only to the tested baseline configuration.

It does not establish that all breakout systems or all 15-bar configurations are invalid.

The result becomes the reference baseline for future EA-051 experiments.

---

## 38. Standard Research Workflow

For future EAs, use the following process:

    01. Define strategy hypothesis
    02. Convert hypothesis into explicit rules
    03. Implement MQL5 EA
    04. Compile with 0 errors
    05. Document inputs
    06. Run baseline test
    07. Preserve original MT5 report
    08. Extract core metrics
    09. Analyze balance curve
    10. Analyze win/loss structure
    11. Analyze long/short behavior
    12. Analyze time distribution
    13. Analyze MFE/MAE where available
    14. Assign PASS / FAIL / INCONCLUSIVE
    15. Record observations
    16. Create one research hypothesis
    17. Modify one major component
    18. Retest
    19. Compare against baseline
    20. Test parameter stability
    21. Perform robustness testing
    22. Freeze candidate configuration
    23. Perform out-of-sample test
    24. Perform forward test
    25. Make final research decision

---

## 39. Final Principle

The purpose of this repository is not to prove that a trading strategy works.

The purpose is to attempt to disprove it through increasingly demanding tests.

A strategy becomes more interesting only when it continues to survive those tests.

The research standard is therefore:

    IDEA
      ≠
    EDGE

    PROFITABLE BACKTEST
      ≠
    ROBUST STRATEGY

    OPTIMIZED RESULT
      ≠
    VALIDATION

    RESEARCH PASS
      ≠
    PRODUCTION READY

Only reproducible evidence should move an EA to the next stage.
