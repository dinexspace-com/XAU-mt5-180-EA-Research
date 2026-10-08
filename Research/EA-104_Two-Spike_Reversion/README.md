# EA-104 — Two-Spike Reversion

## Research Log

## Research Objective

Determine whether the **Two-Spike Reversion** setup contains a repeatable statistical edge on XAUUSD M1.

The baseline currently fails:

```text
Net Profit: -$129.77
Profit Factor: 0.83
Max Equity DD: 16.08%
```

Therefore, research must focus on identifying whether the entry concept can be improved without introducing uncontrolled curve fitting.

---

## Baseline

**Baseline ID:** `EA104-M1-BASELINE-001`

**Symbol:** XAUUSD.PRO

**Timeframe:** M1

**Period:** 2026.01.02 – 2026.04.01

**Initial Deposit:** $1,000

**Model:** 100% real ticks

**Baseline Result:** `FAIL`

---

# Controlled Research Sequence

## RQ01 — Spike ATR Threshold

### Objective

Test whether the definition of an abnormal spike is too loose or too strict.

### Baseline

```text
Spike ATR Multiplier = 1.5
```

### Candidate Values

```text
1.25
1.50
1.75
2.00
2.25
2.50
3.00
```

Do not optimize other parameters simultaneously.

---

## RQ02 — ATR Period

### Objective

Determine whether ATR reacts appropriately to the changing volatility of XAUUSD M1.

### Baseline

```text
ATR Period = 14
```

### Candidate Values

```text
7
10
14
21
28
```

---

## RQ03 — Spike Sequence

### Objective

Test whether requiring exactly two consecutive spikes is appropriate.

Investigate:

* two consecutive spikes,
* three consecutive spikes,
* different spike-strength relationships,
* second spike stronger than first,
* second spike weaker than first.

The baseline must remain unchanged as the reference.

---

## RQ04 — Spike Candle Structure

### Objective

Determine whether total candle range alone is sufficient to define a spike.

Investigate:

* body-to-range ratio,
* upper/lower shadow ratio,
* body size,
* close location within candle,
* relationship between first and second spike.

This research should determine whether a large-range candle is actually a directional spike or merely a high-volatility candle.

---

## RQ05 — Reversal Confirmation

### Baseline

```text
BUY:
Candle[1] bullish
AND Close[1] > Close[2]

SELL:
Candle[1] bearish
AND Close[1] < Close[2]
```

### Candidate Confirmations

Test individually:

1. Reversal candle direction only.
2. Close beyond previous candle close.
3. Close beyond previous candle midpoint.
4. Close inside previous spike body.
5. Reversal candle body minimum.
6. Reversal candle body/range ratio.
7. Reversal candle close-location requirement.

Only one confirmation concept should be changed per experiment.

---

## RQ06 — BUY vs SELL

### Objective

Determine whether the two directions have different expectancy.

Analyze separately:

```text
BUY-only
SELL-only
```

The baseline report already shows different win rates between long and short trades.

Do not remove one direction permanently based only on the baseline sample.

---

## RQ07 — Stop Loss / Take Profit

### Objective

Determine whether the entry concept has an edge but the fixed exit structure prevents profitability.

### Baseline

```text
SL = 300 points
TP = 600 points
```

Test controlled alternatives around the baseline.

Evaluate:

* expectancy,
* profit factor,
* drawdown,
* average trade,
* trade count,
* stability.

Do not select parameters based on Net Profit alone.

---

## RQ08 — Break Even

### Baseline

```text
Break Even Start = 150 points
Offset = 0
```

Test whether Break Even improves or damages the natural reversion behavior.

Compare:

```text
BE OFF
BE ON
```

Then test controlled trigger distances.

---

## RQ09 — Trailing Stop

### Baseline

```text
Trailing Start = 200
Trailing Distance = 200
```

Test:

* trailing OFF,
* different activation distances,
* different trailing distances.

The purpose is to determine whether the strategy requires a fixed target or benefits from allowing profitable reversions to develop further.

---

## RQ10 — Trading Session

### Objective

Determine whether the Two-Spike Reversion setup is dependent on specific market sessions.

Analyze separately:

* Asian session,
* London session,
* New York session,
* London/New York overlap,
* full session.

Session filtering must be evaluated after the entry logic is understood.

---

## RQ11 — Market Regime

### Objective

Determine whether the strategy works only under particular volatility or market conditions.

Investigate:

* low volatility,
* normal volatility,
* high volatility,
* expanding volatility,
* contracting volatility,
* trending conditions,
* ranging conditions.

The goal is to identify the environment in which two consecutive spikes are more likely to revert.

---

## RQ12 — Out-of-Sample Validation

Only after a stable research hypothesis has been identified.

The selected configuration must be frozen before OOS testing.

No parameter changes should be made using OOS results.

---

## RQ13 — Robustness Testing

Evaluate whether the result survives reasonable changes in:

* ATR period,
* spike threshold,
* reversal confirmation,
* SL,
* TP,
* Break Even,
* trailing,
* trading session.

The objective is to identify a **stable parameter region**, not a single optimal value.

---

## RQ14 — Walk-Forward Validation

If the strategy survives OOS and robustness testing:

1. Define training period.
2. Define validation period.
3. Optimize only inside the training period.
4. Freeze parameters.
5. Test on the next unseen period.
6. Repeat across multiple windows.
7. Evaluate consistency.

---

# Research Rules

## Rule 1 — Preserve the Baseline

`EA104-M1-BASELINE-001` must never be overwritten.

---

## Rule 2 — One Logical Variable Group

Each experiment should change one logical factor at a time.

Avoid simultaneous optimization of:

```text
ATR
Entry
SL
TP
Session
Trailing
```

because the cause of performance changes would become unclear.

---

## Rule 3 — Net Profit Is Not Enough

Every experiment must consider:

* Profit Factor
* Expected Payoff
* Max Drawdown
* Recovery Factor
* Sharpe Ratio
* Win Rate
* Average Win
* Average Loss
* Trade Count
* Stability

---

## Rule 4 — Avoid Curve Fitting

A parameter is not considered validated simply because it produces the highest historical profit.

Prefer broad stable regions over isolated peaks.

---

## Rule 5 — OOS Must Remain Independent

OOS data must not be used to select or modify parameters.

---

# Current Research Status

| Research Stage           | Status        |
| ------------------------ | ------------- |
| Strategy Code            | COMPLETE      |
| Baseline Backtest        | COMPLETE      |
| Baseline Assessment      | FAIL          |
| Spike Threshold Research | NOT STARTED   |
| ATR Period Research      | NOT STARTED   |
| Spike Structure Research | NOT STARTED   |
| Reversal Confirmation    | NOT STARTED   |
| BUY vs SELL              | NOT STARTED   |
| Exit Research            | NOT STARTED   |
| Session Research         | NOT STARTED   |
| Market Regime            | NOT STARTED   |
| OOS Validation           | NOT STARTED   |
| Robustness               | NOT STARTED   |
| Walk-forward             | NOT STARTED   |
| Forward Test             | NOT STARTED   |
| Live Trading             | NOT VALIDATED |

---

## Current Research Conclusion

EA-104 remains an **experimental research candidate**.

The baseline does not demonstrate sufficient evidence of a positive edge.

The next research step is:

```text
RQ01 — Spike ATR Threshold
```

No broad optimization should be performed before the controlled research sequence establishes evidence of a stable edge.
