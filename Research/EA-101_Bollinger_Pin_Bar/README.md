# EA-101 — Bollinger Pin Bar — Research

## 1. Research Objective

Determine whether the Bollinger Pin Bar concept contains a stable trading edge on XAUUSD M1.

Baseline result:

```text
EA101-M1-BASELINE-001
FAIL
```

The objective is to identify whether the negative baseline is caused by:

* Pin Bar definition
* Bollinger parameters
* Entry confirmation
* Candle structure
* Directional asymmetry
* Exit management
* Trading session
* Market regime

---

## 2. Baseline Control

The baseline must remain unchanged as the control experiment.

```text
Bollinger Period = 20
Bollinger Deviation = 2.0

Lower Shadow >= 2.0 × Body
Lower Shadow >= 50% Range

Upper Shadow >= 2.0 × Body
Upper Shadow >= 50% Range

BUY  = Bullish Pin Bar + Lower Band Touch
SELL = Bearish Pin Bar + Upper Band Touch

SL = 300
TP = 600

Break-even = 150
Trailing Start = 200
Trailing Distance = 200
```

---

# 3. Controlled Research Sequence

## RQ01 — Pin Bar Shadow / Body Ratio

Test:

```text
1.0
1.5
2.0
2.5
3.0
4.0
```

Question:

> Does a stronger rejection candle improve expectancy?

---

## RQ02 — Shadow / Range Requirement

Current baseline:

```text
Shadow >= 50% of Range
```

Test:

```text
30%
40%
50%
60%
70%
```

Question:

> Is the 50% range requirement too strict or too weak?

---

## RQ03 — Candle Direction Requirement

Baseline:

```text
BUY  = bullish candle
SELL = bearish candle
```

Research alternatives:

* Keep direction requirement
* Remove direction requirement
* Require stronger candle body
* Require close location near candle extreme

---

## RQ04 — Bollinger Band Interaction

Baseline:

```text
Low <= Lower Band
High >= Upper Band
```

Test:

* Touch
* Penetration by fixed points
* Penetration by percentage of candle range
* Close relative to band
* Wick-only band penetration
* Body penetration

---

## RQ05 — Bollinger Period

Test:

```text
10
15
20
25
30
40
50
```

Only change the Bollinger Period.

---

## RQ06 — Bollinger Deviation

Test:

```text
1.5
1.75
2.0
2.25
2.5
3.0
```

Only change Bollinger Deviation.

---

## RQ07 — Entry Confirmation

Evaluate additional confirmation rules:

* Pin Bar close above/below previous close
* Close outside/inside Bollinger Band
* Close location within candle range
* Minimum candle body
* Minimum candle range
* Previous candle direction
* Two-candle reversal confirmation

---

## RQ08 — BUY vs SELL

Evaluate the two directions independently.

Questions:

* Is BUY structurally profitable?
* Is SELL structurally profitable?
* Is one side responsible for the baseline loss?
* Does removing one direction improve robustness?

Do not combine directional optimization with other parameter changes.

---

## RQ09 — Stop Loss / Take Profit

After entry logic demonstrates improvement, evaluate:

```text
SL / TP
```

Candidate R:R structures:

```text
1:1
1:1.5
1:2
1:2.5
1:3
```

Exit research must not be used to hide a fundamentally weak entry signal.

---

## RQ10 — Break-even

Evaluate:

```text
OFF
ON at 100
ON at 150
ON at 200
ON at 250
```

Compare:

* Net Profit
* Profit Factor
* Expected Payoff
* Drawdown
* Average trade

---

## RQ11 — Trailing Stop

Evaluate:

* OFF
* Different start distances
* Different trailing distances
* Fixed trailing vs wider trailing

Do not optimize trailing stop before entry logic has demonstrated positive expectancy.

---

## RQ12 — Trading Session

Evaluate performance by session/time block.

Objective:

> Determine whether the Pin Bar setup works only during specific market conditions.

---

## RQ13 — Market Regime

Separate results into:

* Trending conditions
* Ranging conditions
* High volatility
* Low volatility
* Strong expansion
* Compression

The goal is to identify the environment in which Bollinger Pin Bar reversal signals are most effective.

---

## RQ14 — Out-of-Sample Validation

Only after a research candidate demonstrates sufficient improvement:

```text
Development Sample
        ↓
Freeze Parameters
        ↓
Out-of-Sample Test
```

The OOS period must not be used for parameter selection.

---

## RQ15 — Robustness Testing

Evaluate:

* Small parameter perturbations
* Spread sensitivity
* Execution sensitivity
* SL/TP perturbations
* Shadow threshold perturbations
* Different market periods

The objective is to determine whether performance is stable rather than optimized around a single parameter combination.

---

## RQ16 — Walk-Forward

After OOS and robustness evidence:

```text
Training Window
      ↓
Optimization / Selection
      ↓
Validation Window
      ↓
Next Window
      ↓
Repeat
```

---

# 4. Research Rules

### Rule 1 — One variable group at a time

Do not change Bollinger, Pin Bar, SL/TP and trailing parameters simultaneously.

### Rule 2 — Preserve the baseline

Every experiment must be compared against:

```text
EA101-M1-BASELINE-001
```

### Rule 3 — Do not select by Net Profit alone

Evaluate:

* Profit Factor
* Expected Payoff
* Drawdown
* Sharpe
* Trade count
* Average profit/loss
* Directional consistency
* Robustness

### Rule 4 — Avoid overfitting

A parameter combination that performs well only in one historical sample is not considered validated.

### Rule 5 — OOS remains independent

Do not use OOS results to select parameters.

---

# 5. Current Status

| Research Stage       | Status      |
| -------------------- | ----------- |
| Code                 | COMPLETE    |
| Baseline             | COMPLETE    |
| Baseline Assessment  | FAIL        |
| Pin Bar Parameters   | NOT STARTED |
| Bollinger Parameters | NOT STARTED |
| Entry Confirmation   | NOT STARTED |
| BUY vs SELL          | NOT STARTED |
| Exit Management      | NOT STARTED |
| Session Analysis     | NOT STARTED |
| Market Regime        | NOT STARTED |
| OOS                  | NOT STARTED |
| Robustness           | NOT STARTED |
| Walk-Forward         | NOT STARTED |
| Forward Test         | NOT STARTED |
| Live Trading         | NO          |

**Current Research Status:**

```text
IN PROGRESS
```

**Optimization Status:**

```text
BLOCKED — Controlled research required
```
