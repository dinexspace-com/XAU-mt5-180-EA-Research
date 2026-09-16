# EA-064 — Two-Candle Break — Research Methodology

## 1. Purpose

This document defines the research methodology used to evaluate:

```text
EA-064_Two-Candle_Break
```

The objective is to determine whether requiring **two consecutive completed candles to close beyond the same historical breakout boundary** provides a measurable and sufficiently robust trading edge on XAUUSD.

The research process follows:

```text
Hypothesis
    ↓
EA Implementation
    ↓
Baseline Backtest
    ↓
Controlled Structural Experiments
    ↓
Parameter Optimization
    ↓
Out-of-Sample Validation
    ↓
Robustness Testing
    ↓
Forward Testing
    ↓
Final Research Decision
```

The methodology deliberately separates strategy discovery from parameter optimization.

Optimization must not be used to manufacture a profitable-looking strategy from an otherwise unexplained parameter search.

---

# 2. Strategy Under Test

Strategy:

```text
EA-064 — Two-Candle Break
```

Primary research instrument:

```text
XAUUSD
```

Baseline timeframe:

```text
M1
```

The strategy requires two consecutive completed candles to confirm a breakout beyond the same historical range.

---

# 3. Core Hypothesis

The primary hypothesis is:

> A breakout that remains confirmed for two consecutive completed candles may provide stronger evidence of directional continuation than a breakout confirmed by only one candle.

The hypothesis is not assumed to be correct.

EA-064 exists specifically to test it.

Possible outcomes include:

```text
Higher breakout quality
Lower false-break frequency
Lower signal frequency
Delayed entry
Reduced remaining price movement
Different BUY / SELL behaviour
No measurable improvement
```

These are research possibilities rather than conclusions.

---

# 4. Historical Reference Range

The baseline strategy constructs a historical price range from:

```text
InpBreakoutLookback = 20
```

completed candles.

The two confirmation candles are excluded from this historical range.

Conceptually:

```text
Historical Reference Candles
        ↓
Highest High → Upper
Lowest Low   → Lower
        ↓
Confirmation Candle #1
        ↓
Confirmation Candle #2
        ↓
Signal
```

Both confirmation candles are evaluated against the same fixed historical boundary.

The second confirmation candle does not redefine the breakout range.

---

# 5. BUY Rule

A BUY signal requires:

```text
Confirmation Candle #1 Close
>
Upper + Breakout Buffer
```

AND:

```text
Confirmation Candle #2 Close
>
Upper + Breakout Buffer
```

Therefore:

```text
Historical Upper Boundary
        ↓
Candle #1 closes above
        ↓
Candle #2 also closes above
        ↓
BUY signal
```

The signal is evaluated only after both confirmation candles have completed.

---

# 6. SELL Rule

A SELL signal requires:

```text
Confirmation Candle #1 Close
<
Lower - Breakout Buffer
```

AND:

```text
Confirmation Candle #2 Close
<
Lower - Breakout Buffer
```

Therefore:

```text
Historical Lower Boundary
        ↓
Candle #1 closes below
        ↓
Candle #2 also closes below
        ↓
SELL signal
```

Both confirmation candles must remain beyond the same historical Lower boundary.

---

# 7. Baseline Experiment

The reference experiment is:

```text
EA064-M1-BASELINE-001
```

Environment:

```text
EA              : EA-064_Two-Candle_Break
Symbol          : XAUUSD.PRO
Timeframe       : M1
Period          : 2026-01-02 → 2026-03-31

History Quality : 100% real ticks
Bars            : 85,161
Ticks           : 39,639,179

Initial Deposit : $100.00
Leverage        : 1:500
Lot Size        : 0.01
```

---

# 8. Baseline Parameters

```text
Breakout Lookback   : 20
Breakout Buffer     : 0

Stop Loss           : 300 points
Take Profit         : 600 points

Maximum Spread      : 30 points

Break Even          : ON
Break Even Trigger  : 150 points
Break Even Offset   : 0

Trailing Stop       : ON
Trailing Start      : 200 points
Trailing Distance   : 100 points
Trailing Step       : 10 points
```

These parameters form the reference configuration.

Every subsequent experiment must identify explicitly what changed relative to this baseline.

---

# 9. Baseline Evidence

The baseline produced:

```text
Total Trades        : 543

Winning Trades      : 276 (50.83%)
Losing Trades       : 267 (49.17%)

Net Profit          : -$91.91
Gross Profit        : +$560.33
Gross Loss          : -$652.24

Profit Factor       : 0.86
Expected Payoff     : -$0.17
Recovery Factor     : -0.94
Sharpe Ratio        : -5.00

Max Equity Drawdown : $97.56 (92.34%)
LR Correlation      : -0.89
```

Result:

```text
EA064-M1-BASELINE-001 = FAIL
```

The baseline remains the permanent reference experiment.

---

# 10. Baseline Payoff Structure

Trade statistics:

```text
Average Winner : +$2.03
Average Loser  : -$2.44

Largest Winner : +$6.19
Largest Loser  : -$5.43
```

The realized average payoff ratio is approximately:

```text
2.03 / 2.44
≈ 0.83
```

Therefore:

```text
Average Winner < Average Loser
```

Despite:

```text
Win Rate = 50.83%
```

the realized payoff distribution produces negative expectancy.

This is one of the primary baseline problems to investigate.

---

# 11. Directional Baseline

BUY:

```text
Trades   : 300
Win Rate : 50.33%
```

SELL:

```text
Trades   : 243
Win Rate : 51.44%
```

The baseline does not demonstrate a sufficiently large directional difference to justify removing BUY or SELL.

Directional filtering must be tested separately.

---

# 12. Holding-Time Baseline

```text
Minimum Holding Time : 00:00:01
Average Holding Time : 00:03:57
Maximum Holding Time : 02:03:02
```

The strategy therefore behaves primarily as a short-duration M1 breakout system under the baseline configuration.

Execution conditions may consequently become important during later robustness testing.

---

# 13. MFE / MAE Baseline

MT5 reported:

```text
Correlation (Profit, MFE) : 0.94
Correlation (Profit, MAE) : 0.74
Correlation (MFE, MAE)    : 0.6050
```

These statistics are retained as diagnostic evidence.

They may help guide later exit-management experiments.

They must not be interpreted independently as proof that changing the exit logic will improve profitability.

---

# 14. Research Principle — Baseline First

The original baseline must never be replaced by an optimized result.

Required structure:

```text
BASELINE
    ↓
EXPERIMENT
    ↓
COMPARISON
    ↓
DECISION
```

Not:

```text
BASELINE
    ↓
OPTIMIZATION
    ↓
DELETE FAILED RESULT
```

The failed baseline is part of the research evidence.

---

# 15. Research Principle — One Major Change at a Time

Where practical, controlled experiments should modify only one major strategy component relative to the reference configuration.

Example:

```text
BASELINE

Lookback = 20
Buffer   = 0
SL       = 300
TP       = 600
BE       = ON
Trailing = ON
```

Lookback experiment:

```text
CHANGE:

Lookback

KEEP FIXED:

Buffer
SL
TP
BE
Trailing
Timeframe
Execution rules
```

This allows observed changes to be associated more clearly with the variable being tested.

---

# 16. Research Sequence

EA-064 should follow:

```text
EA064-M1-BASELINE-001
        ↓
EA064-RQ01
Breakout Lookback
        ↓
EA064-RQ02
Breakout Buffer
        ↓
EA064-RQ03
Timeframe
        ↓
EA064-RQ04
Trading Session
        ↓
EA064-RQ05
BUY vs SELL
        ↓
EA064-RQ06
Exit Management
        ↓
Optimization
        ↓
Out-of-Sample Validation
        ↓
Robustness Testing
        ↓
Forward Testing
```

Broad optimization should not precede the primary structural research.

---

# 17. RQ01 — Breakout Lookback

Research question:

> How does historical breakout-range length affect Two-Candle Break performance?

Baseline:

```text
InpBreakoutLookback = 20
```

Only:

```text
InpBreakoutLookback
```

should be changed during the first controlled lookback experiment.

Evaluate:

```text
Trade Count
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Average Winner
Average Loser
BUY performance
SELL performance
Balance behaviour
```

The purpose is not simply to identify the most profitable lookback.

The objective is to understand whether a stable region exists.

---

# 18. RQ02 — Breakout Buffer

Research question:

> Does requiring additional distance beyond the historical range improve breakout quality?

Baseline:

```text
InpBreakoutBuffer = 0
```

Potential effects include:

```text
Larger Buffer
      ↓
Fewer Signals
      ↓
Potentially Stronger Confirmation
```

but also:

```text
Larger Buffer
      ↓
Later Entry
      ↓
Potentially Less Remaining Movement
```

Neither outcome is assumed before testing.

---

# 19. RQ03 — Timeframe

Research question:

> Does Two-Candle Break behaviour materially change across intraday timeframes?

Baseline:

```text
M1
```

Initial research may compare:

```text
M1
M5
M15
```

The strategy structure should remain equivalent across timeframe experiments.

Timeframe comparison should consider both performance and trade frequency.

---

# 20. RQ04 — Trading Session

Research question:

> Does the Two-Candle Break structure exhibit materially different behaviour across trading periods?

Possible categories:

```text
Asia
Europe
US
```

Exact session definitions must be specified before testing.

Session boundaries must not be retrospectively adjusted simply to isolate historically profitable hours.

Compare:

```text
Trade Count
Profit Factor
Expected Payoff
Drawdown
Average Winner
Average Loser
BUY / SELL distribution
```

---

# 21. RQ05 — BUY vs SELL

Research question:

> Do BUY and SELL Two-Candle Break signals have materially different expectancy?

Baseline:

```text
BUY
300 trades
50.33% won

SELL
243 trades
51.44% won
```

Controlled tests may compare:

```text
BUY + SELL
BUY only
SELL only
```

A direction should not be removed solely because its baseline win rate is slightly lower.

---

# 22. RQ06 — Exit Management

Research question:

> How much of the baseline negative expectancy is associated with the entry structure versus position management?

Baseline exits:

```text
SL = 300
TP = 600

Break Even = ON
Trigger    = 150
Offset     = 0

Trailing Stop = ON
Start         = 200
Distance      = 100
Step          = 10
```

Recommended controlled sequence:

```text
Experiment A
Fixed SL / TP only

        ↓

Experiment B
Fixed SL / TP
+
Break Even

        ↓

Experiment C
Fixed SL / TP
+
Trailing Stop

        ↓

Experiment D
Fixed SL / TP
+
Break Even
+
Trailing Stop
```

This isolates the effect of the position-management components.

---

# 23. Experiment Identification

Every experiment receives a unique ID.

Format:

```text
EA064-[CATEGORY]-[NUMBER]
```

Examples:

```text
EA064-M1-BASELINE-001

EA064-LOOKBACK-001
EA064-LOOKBACK-002

EA064-BUFFER-001
EA064-BUFFER-002

EA064-TIMEFRAME-001

EA064-SESSION-001

EA064-DIRECTION-001

EA064-EXIT-001

EA064-OPT-001

EA064-OOS-001

EA064-ROBUST-001

EA064-FWD-001
```

The experiment ID should be referenced by all related evidence.

---

# 24. Required Experiment Record

Every retained experiment should document:

```text
Experiment ID

EA version
Symbol
Timeframe
Historical period
History quality

Reference experiment
Changed variable
Old value
New value

Initial deposit
Leverage
Lot size

Total trades

Net profit
Gross profit
Gross loss

Profit factor
Expected payoff
Recovery factor
Maximum drawdown

Win rate
Average winner
Average loser

BUY trades
BUY win rate

SELL trades
SELL win rate

Holding time

Evidence files

Result
Interpretation
Next action
```

Without the underlying evidence, an experiment should not be considered complete.

---

# 25. Evidence Hierarchy

Preferred evidence order:

```text
1. EA source code

2. Original MT5 Strategy Tester HTML

3. Original MT5 Optimization Report

4. Forward / Out-of-Sample reports

5. MT5 supporting graphs

6. Backtest README

7. Research README

8. Summary documentation
```

README files summarize evidence.

They do not replace the original MT5 reports.

---

# 26. Core Evaluation Metrics

Every experiment should evaluate at least:

```text
Total Trades
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Average Winner
Average Loser
```

Where relevant:

```text
Recovery Factor
Sharpe Ratio
BUY / SELL statistics
MFE / MAE
Holding Time
Balance / Equity Curve
```

No single metric should determine the research decision.

---

# 27. Profit Factor

Profit Factor is:

```text
Gross Profit
────────────
Gross Loss
```

Baseline:

```text
560.33 / 652.24
≈ 0.86
```

A Profit Factor below:

```text
1.00
```

indicates that gross historical losses exceeded gross historical profits.

A Profit Factor above 1.00 is necessary for positive gross profitability but is not by itself sufficient for strategy validation.

---

# 28. Expected Payoff

Baseline:

```text
Expected Payoff = -$0.17
```

Expected Payoff provides a useful per-trade summary of historical expectancy.

A viable candidate should demonstrate positive expectancy.

However, Expected Payoff must be considered alongside:

```text
Trade Count
Drawdown
Profit Factor
Balance Stability
```

---

# 29. Drawdown

Drawdown is treated as a primary risk metric.

EA-064 baseline:

```text
Maximum Equity Drawdown = 92.34%
```

This is unacceptable for deployment.

A strategy must not be promoted simply because it becomes profitable while retaining extreme drawdown.

Research must consider:

```text
Return
AND
Risk
```

---

# 30. Trade Count

EA-064 baseline produced:

```text
543 trades
```

Trade count must always accompany performance statistics.

A very profitable result generated from a very small number of trades requires additional evidence.

No universal minimum trade count is imposed.

Required sample size depends on:

```text
Strategy frequency
Timeframe
Available data
Research stage
Market conditions
```

---

# 31. Balance and Equity Behaviour

Numerical metrics must be supplemented by curve inspection.

Look for:

```text
Persistent growth
Persistent decline
Large isolated jumps
Long stagnation
Sudden regime changes
Late-period collapse
Dependence on a few trades
```

EA-064 baseline exhibits a persistent overall decline.

This visual evidence is consistent with:

```text
LR Correlation = -0.89
```

---

# 32. Optimization Gate

Optimization begins only after controlled structural research provides a justified parameter search space.

Required progression:

```text
Baseline
    ↓
Structural Research
    ↓
Identify Relevant Parameters
    ↓
Define Search Ranges
    ↓
Optimization
```

The objective of optimization is not:

```text
Find highest historical profit
```

The objective is:

```text
Find whether a stable,
repeatable parameter region exists.
```

---

# 33. Optimization Range

Each optimized input should have a documented:

```text
Start
Step
Stop
```

Example structure:

```text
Parameter : InpBreakoutLookback

Start : ...
Step  : ...
Stop  : ...
```

Ranges should be derived from previous research where possible.

Arbitrarily large parameter searches should be avoided.

---

# 34. Parameter Stability

A strong optimization candidate should not depend on one isolated parameter combination.

Conceptually:

```text
Weak:

FAIL
FAIL
FAIL
HUGE PROFIT
FAIL
FAIL
FAIL
```

versus:

```text
Stronger:

PASS
PASS
GOOD
GOOD
GOOD
PASS
PASS
```

The second pattern indicates a broader stable region.

The first requires additional scrutiny for parameter sensitivity or overfitting.

---

# 35. Candidate Selection

Optimization candidates should be selected using multiple criteria.

Consider:

```text
Positive Net Profit
Profit Factor > 1
Positive Expected Payoff
Controlled Drawdown
Adequate Trade Count
Stable Neighboring Parameters
Reasonable Equity Curve
BUY / SELL Behaviour
```

The highest-profit optimization pass is not automatically the preferred candidate.

---

# 36. Out-of-Sample Validation

A parameter configuration selected using one historical dataset must subsequently be tested on data not used for its selection.

Workflow:

```text
Research / Optimization Data
        ↓
Candidate Selected
        ↓
Separate Historical Data
        ↓
Out-of-Sample Test
```

The candidate should retain acceptable behaviour outside the development sample.

---

# 37. Out-of-Sample Comparison

Compare:

```text
In-Sample
vs
Out-of-Sample
```

using:

```text
Profit Factor
Expected Payoff
Drawdown
Trade Count
Win Rate
Average Winner
Average Loser
BUY / SELL behaviour
Balance Curve
```

A major collapse outside the development period is evidence against robustness.

---

# 38. Robustness Testing

After a candidate passes initial out-of-sample evaluation, robustness testing may begin.

Potential tests include:

```text
Parameter perturbation
Spread sensitivity
Slippage sensitivity
Different periods
Execution sensitivity
Directional decomposition
```

Only relevant tests should be added.

The methodology intentionally avoids unnecessary complexity before a viable candidate exists.

---

# 39. Parameter Perturbation

For a selected parameter:

```text
P
```

test nearby values:

```text
P - step
P
P + step
```

A strategy that collapses after a very small parameter change requires additional scrutiny.

The objective is not to require identical results.

The objective is to determine whether performance depends excessively on an exact parameter value.

---

# 40. Spread Sensitivity

Because EA-064 operates primarily as a short-duration M1 strategy, spread may materially affect performance.

Once a viable candidate exists, compare reasonable spread assumptions.

The purpose is to determine whether the candidate depends on unusually favorable transaction costs.

Spread testing should not replace structural strategy research.

---

# 41. Slippage Sensitivity

Short-duration systems may also be sensitive to execution price.

After a viable candidate exists, slippage sensitivity may be evaluated.

A strategy whose edge disappears under small execution deterioration requires additional scrutiny before forward testing.

---

# 42. Forward Testing

Historical validation does not establish live profitability.

A candidate that passes:

```text
Structural Research
Optimization
Out-of-Sample
Robustness
```

may proceed to forward testing.

Forward testing should preserve:

```text
Strategy version
Parameter set
Symbol
Timeframe
Risk configuration
Start date
Execution environment
```

The candidate should not be modified silently during the forward-test period.

---

# 43. Forward-Test Comparison

Forward results should be compared with historical expectations.

Compare:

```text
Trade Frequency
Win Rate
Average Winner
Average Loser
Profit Factor
Expected Payoff
Drawdown
BUY / SELL distribution
```

Differences must be documented.

A forward result should not be altered or discarded merely because it performs worse than historical testing.

---

# 44. Research Decision States

EA-064 may progress through:

```text
BASELINE FAIL
RESEARCH ACTIVE
STRUCTURAL CANDIDATE
OPTIMIZATION CANDIDATE
OOS CANDIDATE
ROBUSTNESS PASS
FORWARD TEST
VALIDATED / REJECTED
```

A failed stage does not require deletion of previous evidence.

---

# 45. MODIFY Decision

Use:

```text
MODIFY
```

when evidence suggests the underlying hypothesis remains worth investigating but a documented structural change is required.

Examples:

```text
Change confirmation rule
Add a justified filter
Modify exit architecture
Restrict trading session
Change timeframe
```

A structural modification creates a new experiment.

It must not silently replace the baseline.

---

# 46. REJECT Decision

Use:

```text
REJECT
```

when accumulated evidence no longer justifies additional research on the tested formulation.

A rejected strategy remains in the repository.

Required principle:

```text
REJECT
≠
DELETE
```

The failed experiment remains useful research evidence.

---

# 47. Validation Rule

A strategy must not be labeled validated solely because:

```text
one backtest is profitable
```

or:

```text
one optimization pass is profitable
```

Validation requires progressively stronger evidence.

Conceptually:

```text
Profitable Historical Result
        ↓
Stable Parameters
        ↓
Out-of-Sample Evidence
        ↓
Robustness
        ↓
Forward Evidence
        ↓
Validation Decision
```

---

# 48. No Silent Changes

Any meaningful change to the strategy must be documented.

Examples:

```text
Changing breakout definition
Changing confirmation count
Removing BUY
Removing SELL
Adding session restrictions
Adding candle filters
Changing exit logic
Changing risk model
```

The research history must make it possible to determine exactly how the strategy evolved.

---

# 49. Artifact Policy

An experiment is not complete without retained evidence.

Minimum artifact set:

```text
EA source / version reference
        +
MT5 report
        +
Test configuration
        +
Result summary
        +
Research interpretation
```

Where available, supporting MT5 graphs should also be retained.

---

# 50. Directory Structure

EA-064 evidence should remain organized as:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-064_Two-Candle_Break/
│       ├── EA-064_Two-Candle_Break.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-064_Two-Candle_Break/
│       ├── README.md
│       ├── ReportTester-*.html
│       └── supporting MT5 graphs
│
├── Research/
│   └── README.md
│
└── docs/
    └── methodology.md
```

Each directory has a distinct responsibility:

```text
EAs
→ implementation

Backtest
→ raw test evidence

Research
→ experiment interpretation

docs
→ research methodology
```

---

# 51. Reproducibility Checklist

Before accepting an experiment record:

```text
[ ] Experiment ID exists
[ ] EA version is identifiable
[ ] Symbol is recorded
[ ] Timeframe is recorded
[ ] Historical period is recorded
[ ] History quality is recorded
[ ] Initial deposit is recorded
[ ] Leverage is recorded
[ ] Lot size is recorded
[ ] Input parameters are recorded
[ ] Changed variable is identified
[ ] Reference experiment is identified
[ ] Total trades are recorded
[ ] Net Profit is recorded
[ ] Profit Factor is recorded
[ ] Expected Payoff is recorded
[ ] Drawdown is recorded
[ ] Win rate is recorded
[ ] BUY / SELL statistics are retained
[ ] Original MT5 evidence exists
[ ] Result is documented
[ ] Next action is documented
```

If critical evidence is missing:

```text
EXPERIMENT NOT COMPLETE
```

---

# 52. EA-064 Research Workflow

```text
┌──────────────────────────────┐
│ Two-Candle Break Hypothesis  │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ EA-064 Implementation        │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ EA064-M1-BASELINE-001        │
│ 543 Trades                   │
│ PF 0.86                      │
│ DD 92.34%                    │
│ Result: FAIL                 │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ Controlled Structural Tests  │
│                              │
│ Lookback                     │
│ Buffer                       │
│ Timeframe                    │
│ Session                      │
│ Direction                    │
│ Exit Management              │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ Define Search Space          │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ MT5 Optimization             │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ Candidate Selection          │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ Out-of-Sample Validation     │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ Robustness Testing           │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ Forward Testing              │
└──────────────┬───────────────┘
               ↓
┌──────────────────────────────┐
│ Final Research Decision      │
└──────────────────────────────┘
```

---

# 53. Current Status

```text
Strategy ID          : EA-064
Strategy Name        : Two-Candle Break

Hypothesis           : DEFINED
EA Implementation    : COMPLETE

Baseline Experiment  : EA064-M1-BASELINE-001
Baseline Backtest    : COMPLETE
Baseline Evidence    : RETAINED
Baseline Result      : FAIL

Trades               : 543
Win Rate             : 50.83%
Net Profit           : -$91.91
Profit Factor        : 0.86
Expected Payoff      : -$0.17
Max Equity Drawdown  : 92.34%

Structural Research  : NEXT

Optimization         : NOT STARTED
Out-of-Sample        : NOT STARTED
Robustness           : NOT STARTED
Forward Test         : NOT STARTED

Validated            : NO
Production Ready     : NO
```

---

# 54. Methodology Conclusion

EA-064 currently provides a failed but useful baseline.

The baseline establishes:

```text
Two-Candle Break
        ↓
543 historical trades
        ↓
50.83% winning trades
        ↓
Average Winner +$2.03
Average Loser  -$2.44
        ↓
Profit Factor 0.86
        ↓
Expected Payoff -$0.17
        ↓
Maximum Equity Drawdown 92.34%
        ↓
BASELINE FAIL
```

The correct next step is not deployment and not immediate unrestricted optimization.

The research sequence remains:

```text
Baseline Evidence
        ↓
Controlled Structural Research
        ↓
Defined Parameter Search Space
        ↓
Optimization
        ↓
Out-of-Sample Validation
        ↓
Robustness
        ↓
Forward Test
        ↓
Final Decision
```

Until those stages produce supporting evidence:

```text
EA-064 STATUS

RESEARCH ONLY
NOT VALIDATED
NOT PRODUCTION READY
```

All future EA-064 conclusions must remain traceable to retained artifacts and documented experiments.
