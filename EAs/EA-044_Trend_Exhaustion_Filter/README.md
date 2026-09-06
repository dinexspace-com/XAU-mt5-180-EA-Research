# EA-044 — Trend Exhaustion Filter

## Overview

**EA-044 Trend Exhaustion Filter** is an Expert Advisor (EA) for MetaTrader 5 designed to trade strong price extensions relative to a long-term trend reference.

The strategy combines:

* 200-period Exponential Moving Average (EMA)
* Average True Range (ATR)
* Distance-from-EMA filter
* Fixed Stop Loss and Take Profit
* Spread filter
* Break Even management
* Trailing Stop management
* One-position-at-a-time control

The current implementation is intended for research and backtesting.

---

## Strategy Logic

The EA uses the EMA as the primary trend reference and ATR as a volatility-adjusted distance filter.

### Core indicators

Default configuration:

| Indicator      |     Default |
| -------------- | ----------: |
| EMA            | 200 periods |
| ATR            |  14 periods |
| ATR Multiplier |         2.0 |

The EA calculates:

```text
Distance = abs(Current Price - EMA)

ATR Filter = ATR × ATR Multiplier
```

A trading signal is allowed only when:

```text
Distance > ATR Filter
```

This prevents entries when price remains too close to the EMA.

---

## Buy Condition

A BUY signal is generated when:

```text
Current Price > EMA(200)

AND

abs(Current Price - EMA(200)) > ATR(14) × 2.0
```

In simplified form:

```text
Price
  ↑
  │       BUY zone
  │
  │   > 2 × ATR
  │
EMA 200
```

The EA therefore enters long when price is above the long-term EMA and sufficiently extended away from it according to current volatility.

---

## Sell Condition

A SELL signal is generated when:

```text
Current Price < EMA(200)

AND

abs(Current Price - EMA(200)) > ATR(14) × 2.0
```

In simplified form:

```text
EMA 200
  │
  │   > 2 × ATR
  │
  │       SELL zone
  ↓
Price
```

The EA therefore enters short when price is below the long-term EMA and sufficiently extended away from it according to current volatility.

---

## Entry Frequency

Signal evaluation is performed only when a **new bar** is detected.

The EA does not continuously open trades on every incoming tick.

Before evaluating an entry, it also checks:

1. A new bar has appeared.
2. Current spread is within the configured maximum.
3. There is no existing position for the same symbol and Magic Number.
4. EMA and ATR data are available.
5. The entry conditions are satisfied.

---

## Position Control

The EA allows a maximum of:

```text
1 open position
```

for the current:

```text
Symbol + Magic Number
```

This prevents the strategy from repeatedly stacking positions from consecutive signals.

---

## Default Trade Parameters

| Parameter      |    Default | Description                  |
| -------------- | ---------: | ---------------------------- |
| Lot Size       |       0.01 | Fixed trading volume         |
| Stop Loss      | 300 points | Initial SL                   |
| Take Profit    | 600 points | Initial TP                   |
| Magic Number   |    2024001 | EA position identifier       |
| Slippage       |  10 points | Maximum configured deviation |
| Maximum Spread |  30 points | Entry spread filter          |

The nominal default SL/TP ratio is:

```text
SL = 300 points
TP = 600 points

Reward / Risk = 2 : 1
```

Actual monetary risk depends on the traded symbol, broker specification, lot size, execution price, and account conditions.

---

## Break Even

Break Even is enabled by default.

Default parameters:

```text
Use Break Even      = true
Trigger             = 150 points
Shift               = 20 points
```

When a position reaches at least 150 points of calculated profit, the EA attempts to move Stop Loss beyond the entry price by 20 points.

For BUY:

```text
New SL = Entry Price + 20 points
```

For SELL:

```text
New SL = Entry Price - 20 points
```

---

## Trailing Stop

Trailing Stop is enabled by default.

Default parameters:

```text
Use Trailing Stop   = true
Trailing Start      = 200 points
Trailing Step       = 50 points
```

Once calculated position profit reaches at least 200 points, the EA attempts to maintain the Stop Loss 50 points from the current price.

For BUY:

```text
SL = Current Price - 50 points
```

For SELL:

```text
SL = Current Price + 50 points
```

The Stop Loss is only modified when the new value improves the existing Stop Loss.

---

## Input Parameters

### Trading

```text
InpLotSize          = 0.01
InpStopLoss         = 300
InpTakeProfit       = 600
InpMagicNumber      = 2024001
InpSlippage         = 10
InpMaxSpread        = 30
```

### Trend / Volatility Filter

```text
InpEMAPeriod        = 200
InpATRPeriod        = 14
InpATRMultiplier    = 2.0
```

### Risk Management

```text
InpUseBreakEven       = true
InpBreakEvenTrigger   = 150
InpBreakEvenShift     = 20

InpUseTrailing        = true
InpTrailingStart      = 200
InpTrailingStep       = 50
```

---

## Execution Flow

```text
New Bar
   │
   ▼
Check Spread
   │
   ▼
Existing EA Position?
   │
   ├── YES → Manage Break Even / Trailing Stop
   │
   └── NO
        │
        ▼
     Read EMA + ATR
        │
        ▼
Calculate distance from EMA
        │
        ▼
Distance > ATR × Multiplier?
        │
        ├── NO → No Trade
        │
        └── YES
             │
             ├── Price > EMA → BUY
             │
             └── Price < EMA → SELL
```

---

## Source File

```text
EA-044_Trend_Exhaustion_Filter/
├── EA-044_Trend_Exhaustion_Filter.mq5
└── README.md
```

Source:

`EA-044_Trend_Exhaustion_Filter.mq5`

Platform:

**MetaTrader 5 / MQL5**

Version declared in source:

**1.00**

---

## Research Status

Current status:

```text
Strategy implementation : Available
Source code             : Available
Backtest                : Not documented here
Optimization            : Not documented here
Forward test            : Not documented here
Production validation   : Not established
```

Performance claims should only be added after reproducible backtesting and validation.

---

## Important Note

This repository is intended for quantitative strategy research and software testing.

The existence of trading logic or source code does not establish profitability. Strategy performance should be evaluated using reproducible historical tests, appropriate transaction costs, spread assumptions, execution conditions, and out-of-sample validation before any live deployment.

---

## EA ID

```text
EA-044
```

**Strategy:** Trend Exhaustion Filter
**Platform:** MetaTrader 5
**Language:** MQL5
**Status:** Research / Backtest Candidate
