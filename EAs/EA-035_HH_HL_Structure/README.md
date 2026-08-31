# EA-035 — HH-HL Structure

## Overview

**EA-035_HH_HL_Structure** is a MetaTrader 5 Expert Advisor (EA) based on basic market structure.

The strategy identifies swing highs and swing lows, then classifies market structure into:

* **HH — Higher High**
* **HL — Higher Low**
* **LH — Lower High**
* **LL — Lower Low**

The EA attempts to trade in the direction of the detected structure:

* **HH + HL → BUY**
* **LH + LL → SELL**

The current implementation uses price structure only and does not rely on external indicators.

---

## Strategy Logic

### Swing Detection

The EA analyzes the most recent **10 bars** on the current chart timeframe.

Swing points are detected using a fractal-style structure with two neighboring bars on each side.

A **Swing High** is detected when:

```text
High[i] > High[i-1]
High[i] > High[i-2]
High[i] > High[i+1]
High[i] > High[i+2]
```

A **Swing Low** is detected when:

```text
Low[i] < Low[i-1]
Low[i] < Low[i-2]
Low[i] < Low[i+1]
Low[i] < Low[i+2]
```

The latest detected swing is compared with the previous swing of the same type.

---

## Market Structure Classification

### Bullish Structure

A **Higher High (HH)** is detected when:

```text
Last Swing High > Previous Swing High
```

A **Higher Low (HL)** is detected when:

```text
Last Swing Low > Previous Swing Low
```

When both conditions are true:

```text
HH + HL
```

the EA considers the market structure bullish and attempts to open a **BUY** position.

### Bearish Structure

A **Lower High (LH)** is detected when:

```text
Last Swing High < Previous Swing High
```

A **Lower Low (LL)** is detected when:

```text
Last Swing Low < Previous Swing Low
```

When both conditions are true:

```text
LH + LL
```

the EA considers the market structure bearish and attempts to open a **SELL** position.

---

## Entry Rules

### BUY

A BUY order is attempted when:

```text
New Higher High = true
AND
New Higher Low = true
```

The order is opened at the current Ask price.

Default protection:

```text
Stop Loss  = Entry - 300 points
Take Profit = Entry + 600 points
```

### SELL

A SELL order is attempted when:

```text
New Lower High = true
AND
New Lower Low = true
```

The order is opened at the current Bid price.

Default protection:

```text
Stop Loss  = Entry + 300 points
Take Profit = Entry - 600 points
```

---

## Position Control

The EA checks existing positions using its **Magic Number**.

If a position with the same Magic Number already exists, the EA does not open another position.

Default Magic Number:

```text
123456
```

This implementation therefore limits the EA to one matching Magic Number position at a time.

---

## Spread Filter

Before processing a new trading signal, the EA checks the current spread.

Default maximum spread:

```text
30 points
```

If:

```text
Current Spread > 30 points
```

the EA skips processing for that tick.

The maximum spread can be changed through:

```text
InpMaxSpread
```

---

## New-Bar Execution

Market structure and trading signals are evaluated only when a **new bar** is detected.

The EA uses:

```text
PERIOD_CURRENT
```

Therefore, the strategy operates on the timeframe of the chart where the EA is attached.

No fixed timeframe is hard-coded into the strategy.

---

## Stop Loss and Take Profit

Default values:

| Parameter   |    Default |
| ----------- | ---------: |
| Stop Loss   | 300 points |
| Take Profit | 600 points |

This gives a nominal initial SL/TP distance ratio of:

```text
300 : 600
1 : 2
```

These values are expressed in MetaTrader **points**, not directly in pips or USD.

---

## Break-Even

Break-even management is enabled by default.

Default settings:

```text
Break Even Trigger = 150 points
Break Even Lock    = 10 points
```

### BUY

When price moves at least 150 points above the entry price, the EA attempts to move Stop Loss to:

```text
Entry Price + 10 points
```

### SELL

When price moves at least 150 points below the entry price, the EA attempts to move Stop Loss to:

```text
Entry Price - 10 points
```

Break-even can be enabled or disabled using:

```text
InpUseBreakEven
```

---

## Trailing Stop

Trailing Stop is enabled by default.

Default settings:

```text
Trailing Start = 200 points
Trailing Step  = 50 points
```

### BUY

After price moves at least 200 points above entry:

```text
New SL = Current Bid - 50 points
```

The Stop Loss is updated only when the new Stop Loss is higher than the existing Stop Loss.

### SELL

After price moves at least 200 points below entry:

```text
New SL = Current Ask + 50 points
```

The Stop Loss is updated only when the new Stop Loss is lower than the existing Stop Loss.

Trailing Stop can be enabled or disabled using:

```text
InpUseTrailingStop
```

---

## Input Parameters

| Input                 |  Default | Description                                     |
| --------------------- | -------: | ----------------------------------------------- |
| `InpLotSize`          |   `0.01` | Fixed trading lot size                          |
| `InpStopLoss`         |    `300` | Stop Loss in points                             |
| `InpTakeProfit`       |    `600` | Take Profit in points                           |
| `InpMagicNumber`      | `123456` | Magic Number used to identify EA positions      |
| `InpSlippage`         |     `10` | Maximum trade deviation in points               |
| `InpMaxSpread`        |     `30` | Maximum allowed spread in points                |
| `InpUseBreakEven`     |   `true` | Enable/disable Break-Even                       |
| `InpBreakEvenTrigger` |    `150` | Profit distance required before Break-Even      |
| `InpBreakEvenLock`    |     `10` | Profit distance locked after Break-Even         |
| `InpUseTrailingStop`  |   `true` | Enable/disable Trailing Stop                    |
| `InpTrailingStart`    |    `200` | Profit distance required before trailing begins |
| `InpTrailingStep`     |     `50` | Trailing Stop distance in points                |

---

## Risk Management

The current version uses a **fixed lot size**.

Default:

```text
0.01 lot
```

The EA does not currently implement:

* Percentage-based risk sizing
* Balance-based position sizing
* Equity-based position sizing
* ATR-based Stop Loss
* Daily loss limits
* Maximum drawdown protection

Risk therefore depends directly on the selected lot size, symbol specifications, and Stop Loss distance.

---

## Strategy Flow

```text
New Tick
   ↓
Get current market price
   ↓
Check spread
   ↓
Detect new bar
   ↓
Update swing highs / swing lows
   ↓
Classify HH / HL / LH / LL
   ↓
Check existing EA position
   ↓
HH + HL ? ── YES → BUY
   │
   NO
   ↓
LH + LL ? ── YES → SELL
   ↓
Position Management
   ├── Break Even
   └── Trailing Stop
```

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
EA Version: 1.00
```

The EA uses the standard MQL5 trading library:

```cpp
#include <Trade\Trade.mqh>
```

and the `CTrade` class for trade execution and position modification.

---

## Current Implementation Notes

This repository contains the current research implementation of the strategy.

Important characteristics of the current version:

* Swing detection uses only the latest 10 bars.
* Swing identification is based on a fractal-style five-bar comparison.
* Structure is determined by comparing consecutive swing highs and swing lows.
* Entries are evaluated on new bars.
* The strategy uses the current chart symbol.
* The strategy uses the current chart timeframe.
* Position size is fixed.
* SL and TP are fixed point distances.
* Spread filtering is included.
* Break-Even is included.
* Trailing Stop is included.
* Existing positions are identified using the Magic Number.

---

## Backtesting

Backtest results are intentionally kept separate from the EA source folder.

Results for this EA should be stored under:

```text
Backtest/
└── EA-035_HH_HL_Structure/
```

Backtest performance should not be inferred from the strategy logic alone.

Profitability, drawdown, robustness, and suitable parameter values must be established through testing.

---

## Repository Structure

```text
EAs/
└── EA-035_HH_HL_Structure/
    ├── EA-035_HH_HL_Structure.mq5
    └── README.md

Backtest/
└── EA-035_HH_HL_Structure/
```

---

## Disclaimer

This Expert Advisor is provided for research, development, and backtesting purposes.

Historical or simulated performance does not guarantee future results. Trading leveraged financial instruments involves significant risk. Strategy behavior should be independently tested and validated before any live deployment.
