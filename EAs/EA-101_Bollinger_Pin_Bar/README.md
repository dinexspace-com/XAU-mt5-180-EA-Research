# EA-101 — Bollinger Pin Bar

## 1. Overview

**EA-101 — Bollinger Pin Bar** is an XAUUSD M1 mean-reversion Expert Advisor combining:

* Bollinger Bands
* Pin Bar / candle-shadow structure
* Fixed Stop Loss / Take Profit
* Break-even
* Trailing Stop
* Spread protection
* One-position control

The strategy attempts to trade price rejection near the outer Bollinger Bands.

---

## 2. Entry Logic

### BUY

A BUY signal is generated when the Shift 1 candle satisfies all conditions:

```text
Lower Shadow >= 2.0 × Candle Body
AND
Lower Shadow >= 50% of Candle Range
AND
Candle is Bullish
AND
Candle Low <= Lower Bollinger Band
```

Conceptually:

```text
Bullish Pin Bar
        +
Lower Band Touch / Penetration
        ↓
       BUY
```

### SELL

A SELL signal is generated when the Shift 1 candle satisfies all conditions:

```text
Upper Shadow >= 2.0 × Candle Body
AND
Upper Shadow >= 50% of Candle Range
AND
Candle is Bearish
AND
Candle High >= Upper Bollinger Band
```

Conceptually:

```text
Bearish Pin Bar
        +
Upper Band Touch / Penetration
        ↓
       SELL
```

---

## 3. Bollinger Bands

| Parameter     | Baseline |
| ------------- | -------: |
| Period        |       20 |
| Deviation     |      2.0 |
| Applied Price |    Close |
| Timeframe     |       M1 |

---

## 4. Pin Bar Definition

### BUY Pin Bar

```text
Body = abs(Close - Open)

Lower Shadow =
min(Open, Close) - Low

Range =
High - Low
```

Required:

```text
Lower Shadow >= Body × 2.0
Lower Shadow >= Range × 0.50
Close > Open
Low <= Lower Band
```

### SELL Pin Bar

```text
Upper Shadow =
High - max(Open, Close)
```

Required:

```text
Upper Shadow >= Body × 2.0
Upper Shadow >= Range × 0.50
Close < Open
High >= Upper Band
```

---

## 5. Execution

| Parameter      |   Baseline |
| -------------- | ---------: |
| Lot Size       |       0.01 |
| Stop Loss      | 300 points |
| Take Profit    | 600 points |
| Maximum Spread |  30 points |
| Slippage       |  10 points |
| Magic Number   |     123456 |
| Timeframe      |         M1 |

The EA evaluates signals on a new bar.

Only one active position with the configured Magic Number is allowed.

---

## 6. Position Management

### Break-even

```text
Enabled: Yes
Start: 150 points
Offset: 0 points
```

### Trailing Stop

```text
Enabled: Yes
Start: 200 points
Distance: 200 points
```

---

## 7. Baseline

**Baseline ID:**

```text
EA101-M1-BASELINE-001
```

**Baseline classification:**

```text
FAIL
```

The baseline is not validated for live trading.

---

## 8. Research Status

| Item                   | Status      |
| ---------------------- | ----------- |
| Strategy Code          | COMPLETE    |
| Baseline Backtest      | COMPLETE    |
| Baseline Assessment    | FAIL        |
| Research Documentation | COMPLETE    |
| Parameter Evaluation   | NOT STARTED |
| OOS Validation         | NOT STARTED |
| Walk-Forward           | NOT STARTED |
| Forward Test           | NOT STARTED |
| Live Trading           | NO          |

---

## 9. Research Principle

EA-101 will be evaluated through controlled experiments.

One parameter group should be changed at a time while preserving the baseline configuration as the control.

Broad optimization is blocked until evidence of a stable trading edge is established.
