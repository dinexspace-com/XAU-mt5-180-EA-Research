# EA-070 — Breakout Volume Filter Research

## 1. Research Objective

EA-070 investigates whether **tick-volume confirmation can improve the quality of price-breakout entries on XAUUSD**.

The baseline strategy combines:

```text
Price Breakout
      +
Tick Volume Confirmation
      ↓
Trade
```

The primary research question is:

> Does requiring the breakout candle to have greater tick volume than the average tick volume of the preceding candles provide a measurable trading edge for XAUUSD breakout entries?

EA-070 is treated as a research strategy.

The objective is not to optimize historical profit immediately.

The objective is to determine whether the underlying volume-confirmation hypothesis has measurable value before broad parameter optimization is allowed.

---

## 2. Core Hypothesis

The baseline hypothesis is:

> A price breakout may have a higher probability of continuation when the breakout occurs during above-average market activity.

EA-070 uses tick volume as the measure of market activity.

Baseline confirmation:

```text
Breakout Candle Tick Volume
>
Average Tick Volume of Previous 20 Bars
```

Therefore:

```text
Price Breakout
AND
Relative Tick Volume > 1.0
        ↓
Entry
```

---

## 3. Volume Definition

EA-070 uses:

```text
MqlRates.tick_volume
```

The strategy therefore evaluates **tick volume**, not centralized exchange-traded volume.

The research interpretation must preserve this distinction.

The volume filter represents activity observed in the broker's XAUUSD price stream.

It should not automatically be interpreted as centralized global gold trading volume.

---

## 4. Baseline Entry Logic

### BUY

```text
Close[1] > Highest High(previous 20 bars)
AND
TickVolume[1] > Average TickVolume(previous 20 bars)
```

### SELL

```text
Close[1] < Lowest Low(previous 20 bars)
AND
TickVolume[1] > Average TickVolume(previous 20 bars)
```

The breakout candle is the most recently completed candle.

The historical breakout range and volume average exclude the breakout candle itself.

---

## 5. Baseline Parameters

| Parameter | Baseline |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| Volume Lookback | 20 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 30 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |
| Magic Number | 123070 |

---

## 6. Baseline Test Environment

```text
Expert:          EA-070_Breakout_Volume_Filter
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 – 2026.03.31

Initial Deposit: $100.00
Leverage:        1:500
Lot Size:        0.01

History Quality: 100% real ticks
Bars:            85,161
Ticks:           39,639,179
```

---

## 7. Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | **-$93.30** |
| Gross Profit | $364.02 |
| Gross Loss | -$457.32 |
| Profit Factor | **0.80** |
| Expected Payoff | **-$0.24** |
| Recovery Factor | **-0.94** |
| Sharpe Ratio | **-5.00** |
| Maximum Balance Drawdown | **93.62%** |
| Maximum Equity Drawdown | **93.71%** |
| Total Trades | **386** |
| Winning Trades | **187 (48.45%)** |
| Losing Trades | **199 (51.55%)** |

---

## 8. Directional Results

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 185 | **50.27%** |
| SELL | 201 | **46.77%** |

Observed difference:

```text
BUY Win Rate  = 50.27%
SELL Win Rate = 46.77%

Difference = 3.50 percentage points
```

This is an observation, not a conclusion that BUY-only trading is superior.

The difference must be investigated through controlled directional testing before any direction is removed.

---

## 9. Trade Payoff Structure

Baseline:

```text
Average Winner = +$1.95
Average Loser  = -$2.30

Win Rate       = 48.45%
Loss Rate      = 51.55%
```

The baseline therefore combines:

```text
Win Rate < 50%
        +
Average Loss > Average Profit
```

which produced:

```text
Expected Payoff = -$0.24
Profit Factor   = 0.80
```

The strategy therefore demonstrated negative historical expectancy under the baseline configuration.

---

## 10. Holding-Time Observation

```text
Minimum Holding Time = 00:00:05
Average Holding Time = 00:03:46
Maximum Holding Time = 02:03:19
```

EA-070 therefore behaves predominantly as a short-duration M1 strategy.

However, the maximum holding time demonstrates that some trades can remain active substantially longer than the typical trade.

This may later be relevant to exit-management research.

---

## 11. MFE / MAE Observation

Baseline MT5 statistics:

```text
Correlation (Profit, MFE) = 0.95
Correlation (Profit, MAE) = 0.72
Correlation (MFE, MAE)    = 0.6031
```

The strong Profit/MFE relationship may justify later investigation of exit management.

However, this observation does not establish that changing TP, Break Even, or Trailing Stop will improve the strategy.

Entry-filter research remains the first priority.

---

# 12. Baseline Assessment

## Result

**BASELINE FAILED**

The baseline does not demonstrate a viable trading edge.

Primary evidence:

```text
Net Profit:            -$93.30
Profit Factor:            0.80
Expected Payoff:        -$0.24
Recovery Factor:          -0.94
Sharpe Ratio:             -5.00
Maximum Equity DD:       93.71%
Win Rate:                48.45%
Total Trades:               386
```

The combination of:

```text
Negative Net Profit
+
Profit Factor < 1
+
Negative Expected Payoff
+
Extremely High Drawdown
```

is sufficient to reject the baseline as a deployment candidate.

---

## 13. What the Baseline Does Establish

The experiment provides evidence that:

> The specific EA-070 baseline configuration did not demonstrate positive expectancy under the documented XAUUSD.PRO M1 test conditions.

The tested combination was:

```text
20-Bar Breakout
        +
Breakout Candle Tick Volume
>
Previous 20-Bar Average Tick Volume
        +
SL 300
        +
TP 600
        +
Break Even
        +
Trailing Stop
```

This configuration failed.

---

## 14. What the Baseline Does NOT Establish

The result does not establish that:

```text
Breakout strategies never work
```

or:

```text
Volume confirmation has no trading value
```

or:

```text
Tick volume contains no useful information
```

or:

```text
EA-070 cannot be improved
```

The baseline only tests one implementation and one parameter configuration over one documented historical period.

The research must therefore proceed through controlled experiments.

---

# 15. Primary Research Problem

The baseline volume condition is:

```text
Breakout Volume > Average Volume
```

This is a relatively weak confirmation requirement.

For example:

```text
Average Volume = 100

Breakout Volume = 101
```

would satisfy the baseline condition.

Therefore the first research question should determine whether the volume confirmation itself needs to be stronger.

This is more directly related to the EA-070 hypothesis than immediately modifying unrelated parameters.

---

# 16. EA070-RQ01 — Relative Volume Strength

## Research Question

> Does requiring a stronger increase in tick volume improve breakout quality?

Instead of:

```text
Breakout Volume > Average Volume
```

define:

```text
Relative Volume =
Breakout Candle Tick Volume
/
Previous Average Tick Volume
```

Baseline:

```text
Relative Volume > 1.00
```

Controlled candidates may later test values such as:

```text
1.10
1.20
1.30
1.50
```

These are experimental candidates, not recommended values.

---

## Hypothesis

If stronger volume expansion represents stronger participation during a breakout, increasing the minimum relative-volume requirement may remove weaker breakout signals.

Potential expected effect:

```text
Higher Volume Requirement
        ↓
Fewer Trades
        ↓
Potentially Higher Signal Quality
```

This hypothesis must be tested.

A reduction in trade count alone is not evidence of improvement.

---

## RQ01 Success Criteria

Compare each candidate against baseline:

```text
Baseline:

Trades            = 386
Net Profit         = -$93.30
Profit Factor      = 0.80
Expected Payoff    = -$0.24
Max Equity DD      = 93.71%
Win Rate           = 48.45%
```

The experiment should examine whether stronger relative volume produces simultaneous improvement in:

- Profit Factor
- Expected Payoff
- Drawdown
- Net Profit
- Win Rate
- Average trade
- Stability

No single metric determines success.

---

# 17. EA070-RQ02 — Directional Evaluation

Baseline directional performance:

```text
BUY:
185 trades
50.27% won

SELL:
201 trades
46.77% won
```

Research question:

> Does the volume-confirmed breakout behave differently for upside and downside breakouts?

Controlled tests:

```text
BUY + SELL
vs
BUY only
vs
SELL only
```

All other major parameters should remain unchanged.

The purpose is to measure directional behavior.

The baseline difference does not justify permanently disabling SELL trades before this experiment is performed.

---

# 18. EA070-RQ03 — Volume Lookback

Baseline:

```text
Volume Lookback = 20
```

Research question:

> How sensitive is the strategy to the period used to define normal tick-volume activity?

Potential controlled candidates may include:

```text
10
20
30
50
```

These values are research candidates only.

The purpose is not to select whichever value produces the largest historical profit.

The objective is to determine whether performance remains stable across reasonable volume-reference windows.

---

# 19. EA070-RQ04 — Breakout Lookback

Baseline:

```text
Breakout Lookback = 20
```

Research question:

> Does the breakout range length materially affect the usefulness of volume confirmation?

Potential candidates may include:

```text
10
20
30
50
```

Volume logic should remain unchanged during this experiment.

---

# 20. EA070-RQ05 — Volume + Breakout Interaction

Volume strength and breakout range may interact.

For example:

```text
Short Breakout Range
+
Strong Volume Requirement
```

may behave differently from:

```text
Long Breakout Range
+
Moderate Volume Requirement
```

However, this interaction should only be investigated after the individual effects of volume strength and breakout lookback are understood.

Avoid broad two-dimensional optimization at the beginning of the research process.

---

# 21. EA070-RQ06 — Timeframe Evaluation

Baseline:

```text
M1
```

Research question:

> Is the volume-confirmed breakout hypothesis sensitive to timeframe and short-term market noise?

Controlled candidates:

```text
M1
M5
M15
```

The objective is not to automatically choose the timeframe with the highest backtest profit.

The objective is to determine whether the underlying hypothesis survives at different market resolutions.

---

# 22. EA070-RQ07 — Trading Session

The baseline allows qualifying entries throughout the available trading period.

Research question:

> Does EA-070 performance vary materially across different XAUUSD trading hours?

Potential session research can investigate:

```text
Asia
Europe
US
```

or controlled broker-time windows.

This should be performed only after the core volume filter has been evaluated.

Session filtering must not be introduced merely because one historical time bucket happened to perform better.

---

# 23. EA070-RQ08 — Breakout Buffer

Baseline:

```text
Breakout Buffer = 0
```

Research question:

> Does requiring price to exceed the breakout range by an additional distance reduce marginal or false breakouts?

Conceptually:

```text
BUY:

Close >
Range High
+
Breakout Buffer
```

and:

```text
SELL:

Close <
Range Low
-
Breakout Buffer
```

Buffer research should be separated from volume-threshold research whenever practical.

---

# 24. EA070-RQ09 — Exit Management

Baseline:

```text
SL = 300
TP = 600

Break Even:
Trigger = 150
Offset  = 0

Trailing:
Start    = 200
Distance = 100
Step     = 10
```

Research question:

> Does the baseline exit structure prevent otherwise valid volume-confirmed breakouts from realizing their available favorable excursion?

Possible later experiments:

```text
Fixed SL/TP only
vs
Break Even
vs
Trailing Stop
vs
Break Even + Trailing Stop
```

Exit research should occur after entry-filter research.

Otherwise improvements caused by entry logic and exit logic become difficult to distinguish.

---

# 25. Research Order

The recommended EA-070 research sequence is:

```text
Baseline
   │
   ▼
EA070-RQ01
Relative Volume Strength
   │
   ▼
EA070-RQ02
BUY vs SELL
   │
   ▼
EA070-RQ03
Volume Lookback
   │
   ▼
EA070-RQ04
Breakout Lookback
   │
   ▼
EA070-RQ05
Volume / Breakout Interaction
   │
   ▼
EA070-RQ06
Timeframe
   │
   ▼
EA070-RQ07
Trading Session
   │
   ▼
EA070-RQ08
Breakout Buffer
   │
   ▼
EA070-RQ09
Exit Management
   │
   ▼
Controlled Optimization
   │
   ▼
Out-of-Sample Validation
   │
   ▼
Forward Testing
```

---

# 26. Controlled Experiment Rule

Whenever practical:

**Change one major research variable at a time.**

Example:

Baseline:

```text
Relative Volume > 1.00
```

RQ01-A:

```text
Relative Volume > 1.10
```

RQ01-B:

```text
Relative Volume > 1.20
```

RQ01-C:

```text
Relative Volume > 1.30
```

Do not simultaneously change:

```text
Volume Threshold
+
Breakout Lookback
+
Stop Loss
+
Take Profit
+
Timeframe
```

because the source of any performance change would become unclear.

---

# 27. Evaluation Framework

Each experiment should record at minimum:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Balance Drawdown
Maximum Equity Drawdown
Recovery Factor
Sharpe Ratio
Win Rate
Trade Count
Average Profit Trade
Average Loss Trade
BUY Performance
SELL Performance
Holding Time
```

Comparison should be made against the baseline.

---

# 28. Improvement Rule

A candidate is not considered improved merely because:

```text
Net Profit increased
```

or:

```text
Win Rate increased
```

The research should look for improvement across multiple dimensions.

Example of potentially meaningful improvement:

```text
Profit Factor ↑
Expected Payoff ↑
Drawdown ↓
Net Profit ↑
Trade Count remains meaningful
```

A candidate that improves one metric while severely damaging another should not automatically advance.

---

# 29. Trade-Count Rule

Baseline:

```text
386 trades
```

A stronger volume filter will probably reduce the number of qualifying signals.

Therefore future experiments must track the relationship:

```text
Signal Selectivity
vs
Sample Size
```

For example, a configuration producing excellent statistics from only a very small number of trades should not automatically be considered stronger than the baseline.

---

# 30. Optimization Rule

Broad parameter optimization is currently:

**BLOCKED**

Optimization should not begin until controlled research identifies whether the core volume-confirmation hypothesis has useful behavior.

The research process should first determine:

```text
Does stronger relative volume help?
        ↓
Does direction matter?
        ↓
Does the result survive different lookbacks?
        ↓
Does the result survive different timeframes?
```

Only then should broader optimization be considered.

---

# 31. Overfitting Control

If a promising EA-070 configuration is discovered using:

```text
2026.01.02 – 2026.03.31
```

that period becomes development evidence.

The selected configuration should then be evaluated on historical data not used to select its parameters.

Workflow:

```text
Development Period
        ↓
Candidate Selection
        ↓
Out-of-Sample Period
        ↓
Month-by-Month Validation
        ↓
Robustness Testing
        ↓
Forward Testing
```

Parameters should not be repeatedly adjusted using the out-of-sample period.

---

# 32. Broker-Data Dependency

EA-070 uses broker tick volume.

Therefore later robustness testing should consider whether the strategy is sensitive to the specific tick-volume stream used during development.

The baseline evidence comes from:

```text
XAUUSD.PRO
ACCM Intl Limited
```

A future strategy should not automatically be assumed to reproduce identical volume behavior on another broker or symbol specification.

---

# 33. Baseline Preservation

The baseline must remain unchanged.

Do not overwrite the failed result after discovering a better configuration.

The baseline is research evidence.

It establishes the reference:

```text
EA-070 Baseline #01

Net Profit       = -$93.30
Profit Factor    = 0.80
Expected Payoff  = -$0.24
Max Equity DD    = 93.71%
Win Rate         = 48.45%
Trades           = 386
```

Every future EA-070 experiment should be traceable back to this reference.

---

# 34. Research Evidence Structure

Recommended future structure:

```text
EA-070
│
├── Baseline #01
│
│   └── Breakout + Volume > Average
│
├── EA070-RQ01
│   └── Relative Volume Strength
│
├── EA070-RQ02
│   └── BUY vs SELL
│
├── EA070-RQ03
│   └── Volume Lookback
│
├── EA070-RQ04
│   └── Breakout Lookback
│
├── EA070-RQ05
│   └── Volume / Breakout Interaction
│
├── EA070-RQ06
│   └── Timeframe
│
├── EA070-RQ07
│   └── Trading Session
│
├── EA070-RQ08
│   └── Breakout Buffer
│
└── EA070-RQ09
    └── Exit Management
```

---

# 35. Current Research Status

```text
EA:                  EA-070_Breakout_Volume_Filter

Strategy Code:       COMPLETE
Baseline Backtest:   COMPLETE
Baseline Assessment: COMPLETE

Baseline Result:     FAIL

Research Status:     IN PROGRESS
Live Validation:     NOT VALIDATED
Optimization:        BLOCKED

Next Research Stage:
EA070-RQ01 — Relative Volume Strength
```

---

# 36. Current Conclusion

EA-070 Baseline #01 failed.

The baseline produced:

```text
386 trades
48.45% Win Rate
Profit Factor 0.80
Expected Payoff -$0.24
Net Profit -$93.30
Maximum Equity Drawdown 93.71%
```

The tested rule:

```text
Breakout
+
Breakout Tick Volume > Previous Average Tick Volume
```

did not provide sufficient historical edge under the documented XAUUSD.PRO M1 conditions.

However, the experiment does not invalidate the broader volume-confirmation hypothesis.

The most direct unresolved question is whether:

```text
Volume > Average
```

is too weak a confirmation condition.

Therefore the next authorized experiment is:

**EA070-RQ01 — Relative Volume Strength**

The purpose of RQ01 is to determine whether requiring materially stronger-than-average tick volume improves breakout quality before any broad optimization is performed.
