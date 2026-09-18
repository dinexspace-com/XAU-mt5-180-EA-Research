# EA-068 — Breakout RSI Filter Research

## Research Objective

EA-068 investigates whether an RSI momentum filter can improve the quality and historical expectancy of a price-range breakout strategy on XAUUSD.

The central hypothesis is:

> A breakout confirmed by directional RSI momentum may contain more useful information than an unfiltered price breakout.

The strategy combines:

```text
Historical Price Range
        ↓
Price Breakout
        ↓
RSI Momentum Confirmation
        ↓
BUY / SELL Signal
```

The baseline experiment is not treated as proof that RSI filtering works.

Its purpose is to establish a reference configuration from which the contribution of each component can be tested systematically.

---

## Strategy Hypothesis

Breakout strategies attempt to capture price expansion after the market moves beyond a recent historical range.

A basic breakout can be represented as:

```text
Close > Previous Range High
        ↓
BUY

Close < Previous Range Low
        ↓
SELL
```

The problem is that not every breakout develops into sustained directional movement.

EA-068 introduces RSI as a momentum confirmation layer.

The research hypothesis is:

```text
Price Breakout
      +
Directional Momentum
      ↓
Potentially Higher-Quality Breakout
```

The hypothesis must be tested empirically.

---

# Baseline Strategy

The baseline uses the previous 20 completed candles to define the breakout range.

```text
Breakout Lookback = 20
Breakout Buffer   = 0
```

The signal candle is evaluated against this historical range.

---

## BUY Hypothesis

A bullish breakout requires:

```text
Close[1] > Upper Range
```

and:

```text
RSI(14)[1] > 55
```

Therefore:

```text
Upper Range Break
        +
RSI > 55
        ↓
BUY
```

The RSI requirement is intended to reject bullish breakouts that occur without sufficient positive momentum.

---

## SELL Hypothesis

A bearish breakout requires:

```text
Close[1] < Lower Range
```

and:

```text
RSI(14)[1] < 45
```

Therefore:

```text
Lower Range Break
        +
RSI < 45
        ↓
SELL
```

The RSI requirement is intended to reject bearish breakouts that occur without sufficient negative momentum.

---

# Baseline Configuration

```text
Instrument: XAUUSD.PRO
Timeframe: M1

Breakout Lookback: 20
Breakout Buffer: 0

RSI Period: 14
RSI BUY Level: 55
RSI SELL Level: 45

Lot Size: 0.01

Stop Loss: 300
Take Profit: 600

Break Even: ON
Trigger: 150
Offset: 0

Trailing Stop: ON
Start: 200
Distance: 100
Step: 10

Maximum Spread: 30
```

The baseline should remain unchanged as the reference experiment.

Future experiments must not overwrite the original baseline.

---

# Baseline Experiment

## Test Period

```text
2026-01-02
to
2026-03-31
```

Testing environment:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
History Quality: 100% real ticks
Initial Deposit: $100
Leverage: 1:500
```

---

# Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 377 |
| Net Profit | **-$93.30** |
| Gross Profit | $357.80 |
| Gross Loss | -$451.10 |
| Profit Factor | **0.79** |
| Expected Payoff | **-$0.25** |
| Recovery Factor | **-0.89** |
| Maximum Equity Drawdown | **94.01%** |
| Winning Trades | **46.95%** |
| Losing Trades | 53.05% |
| Sharpe Ratio | -5.00 |

Baseline classification:

```text
FAIL
```

The tested configuration does not demonstrate positive historical expectancy.

---

# Initial Research Finding

The first EA-068 experiment provides no evidence that the tested combination:

```text
20-Bar Breakout
        +
RSI(14)
        +
55 / 45 Threshold
        +
Current Exit Management
```

creates a viable strategy under the tested conditions.

However:

```text
Baseline Failure
        ≠
RSI Hypothesis Rejected
```

The baseline contains several interacting components.

A negative combined result does not identify which component is responsible for the failure.

Therefore the next stage must isolate variables.

---

# Directional Observation

The baseline produced:

```text
BUY Trades
193
Win Rate = 49.22%

SELL Trades
184
Win Rate = 44.57%
```

There is an observed directional difference:

```text
BUY WR > SELL WR
```

This observation is sufficient to justify a controlled directional experiment.

It is not sufficient to conclude that BUY-only trading has positive expectancy.

Win rate alone does not determine strategy profitability.

---

# Research Questions

EA-068 research will proceed through explicitly numbered research questions.

---

## EA068-RQ01 — RSI Filter Contribution

### Question

Does the RSI filter improve the breakout strategy?

### Comparison

```text
A
Breakout Only

vs

B
Breakout + RSI Filter
```

For configuration B:

```text
RSI Period = 14

BUY:
RSI > 55

SELL:
RSI < 45
```

All other relevant parameters should remain identical.

### Objective

Measure changes in:

```text
Net Profit
Profit Factor
Expected Payoff
Drawdown
Trade Count
Win Rate
BUY performance
SELL performance
```

This is the highest-priority research question.

---

## EA068-RQ02 — Directional Evaluation

### Question

Does EA-068 behave materially differently between BUY and SELL signals?

Test:

```text
A — BUY + SELL

B — BUY Only

C — SELL Only
```

The purpose is not to select the configuration with the highest historical profit automatically.

The purpose is to determine whether the observed directional asymmetry persists.

---

## EA068-RQ03 — Timeframe Evaluation

Baseline:

```text
M1
```

Candidate research timeframes:

```text
M1
M5
M15
```

Question:

> Is the breakout + RSI hypothesis more stable when market noise is reduced through a higher timeframe?

All major strategy parameters should initially remain controlled.

---

## EA068-RQ04 — Breakout Lookback

Baseline:

```text
20
```

Research should test whether the strategy is sensitive to the definition of the historical breakout range.

Example controlled region:

```text
10
15
20
25
30
```

The objective is not simply to find the most profitable lookback.

The objective is to determine whether a stable region exists.

---

## EA068-RQ05 — RSI Period

Baseline:

```text
RSI Period = 14
```

This experiment investigates whether momentum measurement length materially changes breakout behavior.

Example research region:

```text
7
10
14
18
21
```

Parameter ranges may be refined before execution.

---

## EA068-RQ06 — RSI Thresholds

Baseline:

```text
BUY > 55
SELL < 45
```

Research may compare progressively stronger momentum requirements.

For example:

```text
52 / 48
55 / 45
58 / 42
60 / 40
```

The research question is:

> Does requiring stronger RSI momentum improve trade quality enough to compensate for the reduction in trade frequency?

---

## EA068-RQ07 — Breakout Buffer

Baseline:

```text
Buffer = 0
```

A zero buffer accepts a breakout immediately beyond the historical range.

Future experiments may test whether requiring additional distance beyond the boundary reduces weak breakouts.

Conceptually:

```text
Range Boundary
      ↓
      │
      │ Buffer
      ↓
Entry Qualification
```

---

## EA068-RQ08 — Trading Session

The baseline allows signals across the available trading day.

The Strategy Tester distribution indicates that entries occur across multiple hours.

Future experiments may evaluate:

```text
All Sessions
Asia
Europe
US
Selected Session Combinations
```

The session experiment must be performed prospectively.

Weak historical hours should not simply be deleted after observing the baseline.

---

## EA068-RQ09 — Exit Management

Current baseline:

```text
SL = 300
TP = 600

Break Even:
150 / 0

Trailing:
200 / 100 / 10
```

EA-068 combines several exit mechanisms.

Research should determine whether performance is being affected primarily by:

```text
Entry Quality
        or
Exit Management
```

Possible controlled comparisons include:

```text
Fixed SL/TP only

vs

SL/TP + Break Even

vs

SL/TP + Trailing

vs

SL/TP + Break Even + Trailing
```

Entry parameters should remain unchanged during this experiment.

---

# MFE / MAE Research

Baseline correlations:

```text
Profit / MFE = 0.95
Profit / MAE = 0.75
MFE / MAE    = 0.6335
```

These values justify further examination of trade excursion behavior.

Research questions include:

```text
How much favorable excursion occurs before reversal?

Are profitable excursions being converted efficiently into realized profit?

Does Break Even close trades too early?

Does Trailing Stop improve or reduce captured MFE?

Is the initial Stop Loss unnecessarily wide or narrow?
```

The correlations themselves do not provide the answers.

Trade-level analysis is required before changing exit parameters.

---

# Holding-Time Research

Baseline:

```text
Minimum Holding = 00:00:02
Average Holding = 00:03:52
Maximum Holding = 02:03:19
```

The average trade lasts less than four minutes.

This raises an important research question:

> Is EA-068 actually capturing sustained breakouts, or mainly short-term post-breakout price movement?

This should be investigated together with MFE/MAE and exit-management behavior.

---

# Optimization Policy

Broad optimization is currently:

```text
BLOCKED
```

EA-068 should not immediately optimize:

```text
Lookback
RSI Period
RSI Threshold
SL
TP
Break Even
Trailing Stop
Session
Timeframe
```

simultaneously.

Doing so would make it difficult to determine which component actually improves the strategy and would increase the risk of selecting a historically fitted parameter combination.

Instead:

```text
Research Question
       ↓
Controlled Experiment
       ↓
Evidence
       ↓
Conclusion
       ↓
Next Research Question
```

Only after the major components are understood should controlled multi-parameter optimization begin.

---

# Candidate Selection

A candidate must not be selected solely because it produces:

```text
Highest Net Profit
```

Candidate evaluation should consider:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Recovery Factor
Trade Count
Directional Stability
Monthly Stability
Parameter Stability
```

Stable parameter regions are more informative than isolated historical peaks.

---

# Out-of-Sample Validation

Any candidate produced by parameter research must subsequently be tested on data not used to select those parameters.

Conceptually:

```text
IN-SAMPLE
Research + Parameter Selection
        ↓
Freeze Parameters
        ↓
OUT-OF-SAMPLE
Independent Evaluation
```

If parameters are changed after observing Out-of-Sample results, that period can no longer be treated as untouched validation data.

MetaTrader 5 also supports forward testing by dividing historical data so that optimization is performed on one portion and candidate parameters are checked on another. :contentReference[oaicite:1]{index=1}

---

# Month-by-Month Validation

The baseline period spans:

```text
January 2026
February 2026
March 2026
```

Aggregate performance alone is insufficient for assessing temporal stability.

Promising candidates should therefore be examined separately across monthly periods.

The objective is to identify whether performance is:

```text
Consistent
Regime-dependent
Concentrated
or
Unstable
```

---

# Robustness Testing

A candidate that survives Out-of-Sample testing should undergo additional robustness checks.

These may include:

### Parameter Perturbation

```text
Selected parameter
        ↓
Nearby values
        ↓
Compare behavior
```

### Different Historical Periods

Test whether behavior persists outside the original research window.

### Trading-Cost Stress

Evaluate more conservative spread/execution assumptions where possible.

### Broker / Data Variation

Compare results using different suitable XAUUSD data environments when available.

### Execution Stress

Evaluate sensitivity to execution assumptions where technically appropriate.

---

# Evidence Policy

Every research conclusion must be traceable to evidence.

EA-068 evidence should be stored under:

```text
Backtest/
└── EA-068_Breakout_RSI_Filter/
```

The original artifacts should be retained.

Examples:

```text
MT5 HTML reports
PNG charts
Optimization XML
SET files
Research summaries
```

Negative experiments must also be preserved.

---

# Research Sequence

Current planned sequence:

```text
Baseline #01
      ↓
EA068-RQ01
RSI Contribution
      ↓
EA068-RQ02
Directional Evaluation
      ↓
EA068-RQ03
Timeframe Evaluation
      ↓
EA068-RQ04
Breakout Lookback
      ↓
EA068-RQ05
RSI Period
      ↓
EA068-RQ06
RSI Threshold
      ↓
EA068-RQ07
Breakout Buffer
      ↓
EA068-RQ08
Session Evaluation
      ↓
EA068-RQ09
Exit Management
      ↓
Controlled Optimization
      ↓
Candidate Selection
      ↓
Out-of-Sample
      ↓
Month-by-Month Validation
      ↓
Robustness
      ↓
Forward Test
```

---

# Current Research Status

```text
EA: EA-068_Breakout_RSI_Filter

Baseline #01: COMPLETE
Baseline Result: FAIL

Current Stage:
CONTROLLED RESEARCH

Next Experiment:
EA068-RQ01 — RSI Filter Contribution Evaluation

Broad Optimization:
BLOCKED

Candidate Selected:
NO

Out-of-Sample:
NOT STARTED

Robustness:
NOT STARTED

Forward Test:
NOT STARTED

Live Trading:
NOT VALIDATED
```

---

# Current Conclusion

EA-068 currently has **no validated trading edge**.

Baseline #01 demonstrates that the tested:

```text
Breakout Lookback 20
+
RSI(14)
+
55 / 45 Threshold
+
Current Exit Management
```

configuration failed to produce positive expectancy on the documented XAUUSD.PRO M1 historical period.

The correct next step is not broad optimization.

The next step is to isolate the contribution of the defining EA-068 component:

```text
RSI FILTER
```

through:

```text
EA068-RQ01
Breakout Only
vs
Breakout + RSI
```

Only after controlled experiments identify which components contribute useful behavior should EA-068 progress toward parameter optimization and independent validation.
