# EA-035 — HH/HL Structure

**Platform:** MetaTrader 5
**Language:** MQL5
**Version:** 1.00
**Strategy Type:** Market Structure / Price Action
**Primary Structure:** HH–HL / LH–LL

---

## 1. Overview

**EA-035_HH_HL_Structure** is a MetaTrader 5 Expert Advisor designed to trade automatically based on basic market structure.

The strategy identifies recent swing highs and swing lows and compares them with previous swing points to classify price structure as:

* **HH — Higher High**
* **HL — Higher Low**
* **LH — Lower High**
* **LL — Lower Low**

The EA interprets:

* **HH + HL** as bullish market structure.
* **LH + LL** as bearish market structure.

When the required structure is detected and no existing position belonging to the EA is open, the EA can automatically execute a market order.

The EA also includes:

* Fixed Stop Loss
* Fixed Take Profit
* Spread filter
* Magic Number identification
* Break Even
* Trailing Stop
* One-position-at-a-time control

---

## 2. Strategy Concept

The strategy is based on the idea that directional price movement can be described through sequences of swing highs and swing lows.

### Bullish Structure

A bullish structure is characterized by:

```text
Higher High (HH)
        ↑
        │
        │
Higher Low (HL)
```

The EA looks for both:

```text
Latest Swing High > Previous Swing High

AND

Latest Swing Low > Previous Swing Low
```

When both conditions are true:

```text
HH + HL → BUY
```

---

### Bearish Structure

A bearish structure is characterized by:

```text
Lower High (LH)
        │
        ↓
Lower Low (LL)
```

The EA looks for both:

```text
Latest Swing High < Previous Swing High

AND

Latest Swing Low < Previous Swing Low
```

When both conditions are true:

```text
LH + LL → SELL
```

---

## 3. Swing Detection

The EA detects swing points from recent price bars.

On every new bar, it retrieves:

```text
10 recent bars
```

The swing detection logic uses two bars on each side of the candidate bar.

### Swing High

A bar is classified as a Swing High when its high is greater than the highs of the two bars before and two bars after it.

Conceptually:

```text
          Swing High
              ▲
              │
        ┌─────┴─────┐
       /             \
      /               \
```

Condition:

```text
High[i] > High[i-1]
High[i] > High[i-2]
High[i] > High[i+1]
High[i] > High[i+2]
```

---

### Swing Low

A bar is classified as a Swing Low when its low is lower than the lows of the two bars before and two bars after it.

Condition:

```text
Low[i] < Low[i-1]
Low[i] < Low[i-2]
Low[i] < Low[i+1]
Low[i] < Low[i+2]
```

---

## 4. Market Structure Classification

After detecting swing points, the EA compares the latest swing with the previous swing.

### Higher High — HH

```text
Last Swing High > Previous Swing High
```

Result:

```text
isNewHH = true
```

---

### Higher Low — HL

```text
Last Swing Low > Previous Swing Low
```

Result:

```text
isNewHL = true
```

---

### Lower High — LH

```text
Last Swing High < Previous Swing High
```

Result:

```text
isNewLH = true
```

---

### Lower Low — LL

```text
Last Swing Low < Previous Swing Low
```

Result:

```text
isNewLL = true
```

---

## 5. Entry Logic

The EA evaluates trading signals only when a new bar is detected.

### BUY

A BUY signal requires:

```text
isNewHH == true
AND
isNewHL == true
```

Therefore:

```text
HH + HL
   ↓
Bullish Structure
   ↓
BUY
```

The BUY order is opened at the current Ask price.

Order comment:

```text
Buy HH-HL
```

---

### SELL

A SELL signal requires:

```text
isNewLH == true
AND
isNewLL == true
```

Therefore:

```text
LH + LL
   ↓
Bearish Structure
   ↓
SELL
```

The SELL order is opened at the current Bid price.

Order comment:

```text
Sell LH-LL
```

---

## 6. Position Control

Before opening a new trade, the EA checks existing MT5 positions.

A position is considered to belong to this EA when:

```text
POSITION_MAGIC == InpMagicNumber
```

If a matching position already exists:

```text
No new position is opened
```

Therefore, the current implementation is designed to maintain a maximum of one active position for the configured Magic Number.

---

## 7. Stop Loss

Stop Loss is defined in points.

Default:

```text
InpStopLoss = 300
```

### BUY

```text
SL = Entry Price - StopLoss × Point
```

### SELL

```text
SL = Entry Price + StopLoss × Point
```

---

## 8. Take Profit

Take Profit is also defined in points.

Default:

```text
InpTakeProfit = 600
```

### BUY

```text
TP = Entry Price + TakeProfit × Point
```

### SELL

```text
TP = Entry Price - TakeProfit × Point
```

With the default settings, the nominal SL/TP distance ratio is:

```text
300 : 600
1 : 2
```

This describes the configured price-distance ratio only and does not account for spread, slippage, commissions, execution differences, Break Even, or Trailing Stop.

---

## 9. Spread Filter

Before processing a new-bar trading cycle, the EA calculates:

```text
Current Spread = (Ask - Bid) / Point
```

Default maximum:

```text
InpMaxSpread = 30 points
```

If:

```text
Current Spread > InpMaxSpread
```

the EA immediately stops processing that tick.

No new trade is evaluated under that condition.

---

## 10. Break Even

Break Even can be enabled or disabled.

Default:

```text
InpUseBreakEven = true
```

Trigger:

```text
InpBreakEvenTrigger = 150 points
```

Locked profit:

```text
InpBreakEvenLock = 10 points
```

### BUY

Once:

```text
Bid - Entry >= 150 points
```

the EA attempts to move Stop Loss to:

```text
Entry + 10 points
```

### SELL

Once:

```text
Entry - Ask >= 150 points
```

the EA attempts to move Stop Loss to:

```text
Entry - 10 points
```

The EA only modifies the Stop Loss when the proposed level improves the existing Stop Loss.

---

## 11. Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailingStop = true
```

Trailing activation:

```text
InpTrailingStart = 200 points
```

Trailing distance used by the implementation:

```text
InpTrailingStep = 50 points
```

### BUY

Once profit reaches at least:

```text
200 points
```

the proposed Stop Loss becomes:

```text
Current Bid - 50 points
```

The Stop Loss is modified only when the proposed value is higher than the existing Stop Loss.

### SELL

Once profit reaches at least:

```text
200 points
```

the proposed Stop Loss becomes:

```text
Current Ask + 50 points
```

The Stop Loss is modified only when the proposed value is lower than the existing Stop Loss.

---

## 12. Input Parameters

| Parameter             |  Default | Description                                                 |
| --------------------- | -------: | ----------------------------------------------------------- |
| `InpLotSize`          |   `0.01` | Fixed trading lot size                                      |
| `InpStopLoss`         |    `300` | Stop Loss distance in points                                |
| `InpTakeProfit`       |    `600` | Take Profit distance in points                              |
| `InpMagicNumber`      | `123456` | Identifier used for EA positions                            |
| `InpSlippage`         |     `10` | Maximum trade deviation in points                           |
| `InpMaxSpread`        |     `30` | Maximum allowed spread in points                            |
| `InpUseBreakEven`     |   `true` | Enables Break Even                                          |
| `InpBreakEvenTrigger` |    `150` | Profit distance required before Break Even                  |
| `InpBreakEvenLock`    |     `10` | Profit distance locked after Break Even                     |
| `InpUseTrailingStop`  |   `true` | Enables Trailing Stop                                       |
| `InpTrailingStart`    |    `200` | Profit distance required before trailing starts             |
| `InpTrailingStep`     |     `50` | Distance from current price used for the trailing Stop Loss |

---

## 13. EA Execution Flow

The current execution flow is:

```text
OnTick()
   │
   ├── Get current market tick
   │
   ├── Calculate spread
   │
   ├── Spread > Maximum?
   │       └── YES → Stop processing
   │
   ├── New bar?
   │       └── NO → Stop processing
   │
   ├── Update Market Structure
   │       │
   │       ├── Detect Swing High
   │       ├── Detect Swing Low
   │       │
   │       └── Classify:
   │             HH
   │             HL
   │             LH
   │             LL
   │
   ├── Existing position with Magic Number?
   │       └── YES → Stop processing
   │
   ├── HH + HL?
   │       └── BUY
   │
   ├── LH + LL?
   │       └── SELL
   │
   ├── Apply Break Even
   │
   └── Apply Trailing Stop
```

---

## 14. Timeframe

The EA uses:

```mql5
PERIOD_CURRENT
```

for both new-bar detection and price-history analysis.

Therefore, market structure is calculated using the timeframe of the chart on which the EA is running.

Examples:

```text
EA attached to M5  → M5 structure
EA attached to M15 → M15 structure
EA attached to H1  → H1 structure
```

No dedicated timeframe is hard-coded in the current version.

---

## 15. Symbol

The EA uses:

```mql5
_Symbol
```

Therefore, orders and market-structure calculations operate on the symbol of the chart where the EA is attached.

Although this repository is intended for XAUUSD EA research, the current source code does not hard-code `XAUUSD`.

---

## 16. Files

```text
EA-035_HH_HL_Structure/
│
├── EA-035_HH_HL_Structure.mq5
└── README.md
```

### `EA-035_HH_HL_Structure.mq5`

Main Expert Advisor source code containing:

* Market data processing
* Swing detection
* HH/HL/LH/LL classification
* BUY/SELL execution
* Spread filtering
* Position identification
* Break Even
* Trailing Stop

### `README.md`

Technical documentation describing the behavior of the current EA implementation.

---

## 17. Current Implementation Characteristics

The current version uses a deliberately simple market-structure model.

Key characteristics:

```text
Structure window:     10 recent bars
Swing confirmation:   2 bars on each side
Signal evaluation:    New bar only
Position sizing:      Fixed lot
Stop Loss:            Fixed points
Take Profit:          Fixed points
Position limit:       One per Magic Number
Break Even:           Supported
Trailing Stop:        Supported
Trend filter:         Not implemented
ATR filter:           Not implemented
Session filter:       Not implemented
News filter:          Not implemented
Dynamic lot sizing:   Not implemented
```

---

## 18. Important Implementation Notes

### Position management runs inside the new-bar execution path

In the current source, `OnTick()` returns when `IsNewBar()` is false.

As a result, the Break Even and Trailing Stop functions are reached only during the processing of a new bar, rather than continuously on every incoming tick.

Additionally, when `PositionExists()` returns `true`, `OnTick()` returns before reaching the Break Even and Trailing Stop calls.

Therefore, the current source structure should be reviewed carefully when validating whether Break Even and Trailing Stop are actually being applied to an already-open EA position as intended.

This README documents the current source behavior and does not assume functionality beyond the implementation.

---

### Point values depend on broker symbol specification

Parameters such as:

```text
Stop Loss = 300 points
Take Profit = 600 points
Maximum Spread = 30 points
```

use MetaTrader `_Point`.

Their actual price distance therefore depends on the symbol specification and number of digits provided by the broker.

They should not automatically be interpreted as a fixed USD movement in XAUUSD.

---

## 19. Research Status

**EA ID:** EA-035
**Strategy:** HH/HL Market Structure
**Implementation:** Available
**Backtest validation:** To be documented separately
**Optimization:** Not documented in this README
**Production readiness:** Not established

This README describes the EA implementation only.

Profitability, robustness, parameter stability, and live-trading suitability must be established through separate backtesting and research evidence.

---

## 20. Disclaimer

This Expert Advisor is intended for research, development, and testing purposes.

Historical or backtested performance does not guarantee future trading results.

Market conditions, broker execution, spread, slippage, commissions, symbol specifications, liquidity, and other factors may cause live results to differ significantly from historical simulations.

The EA should be independently tested and validated before any live trading use.
