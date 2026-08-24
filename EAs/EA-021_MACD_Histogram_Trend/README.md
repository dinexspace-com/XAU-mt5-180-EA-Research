# EA-021 — MACD Histogram Trend

## Overview

**EA-021_MACD_Histogram_Trend** is a MetaTrader 5 Expert Advisor (EA) that trades trend continuation signals derived from the MACD histogram.

The EA uses the built-in **OsMA indicator** as the MACD histogram representation and evaluates signals only when a new bar is formed.

The strategy is intentionally simple: it checks whether the histogram is on the same side of the zero line and continues expanding in that direction.

---

## Strategy Logic

### Indicator

The EA uses `iOsMA()` with the following fixed parameters:

| Parameter     | Value |
| ------------- | ----: |
| Fast EMA      |    12 |
| Slow EMA      |    26 |
| Signal Period |     9 |
| Applied Price | Close |

The EA runs on the **current chart symbol and timeframe**.

---

## Entry Conditions

Signals are evaluated **once per new bar** using closed-bar histogram values.

### BUY

A BUY signal is generated when:

* Current histogram value is above `0`
* Previous histogram value is above `0`
* Current histogram value is greater than the previous histogram value

Conceptually:

```text
Histogram Current > 0
AND
Histogram Previous > 0
AND
Histogram Current > Histogram Previous
```

This represents positive MACD histogram momentum that is continuing to increase.

### SELL

A SELL signal is generated when:

* Current histogram value is below `0`
* Previous histogram value is below `0`
* Current histogram value is lower than the previous histogram value

Conceptually:

```text
Histogram Current < 0
AND
Histogram Previous < 0
AND
Histogram Current < Histogram Previous
```

This represents negative MACD histogram momentum that is continuing to decrease.

---

## Trade Filters

### Spread Filter

Before opening a position, the EA checks the current spread.

Default:

```text
Maximum Spread = 30 points
```

No new trade is opened when the spread exceeds the configured maximum.

### Position Limit

The EA allows a maximum of:

```text
1 open position
```

for the current symbol and EA Magic Number.

A new entry signal is ignored while an existing position belonging to the EA remains open.

---

## Initial Risk Parameters

Default trade parameters:

| Parameter    |     Default |
| ------------ | ----------: |
| Lot Size     |        0.01 |
| Stop Loss    |  500 points |
| Take Profit  | 1000 points |
| Slippage     |   10 points |
| Magic Number |      123456 |

For BUY positions:

```text
SL = Entry Price - 500 points
TP = Entry Price + 1000 points
```

For SELL positions:

```text
SL = Entry Price + 500 points
TP = Entry Price - 1000 points
```

With the default configuration, the nominal initial SL/TP distance ratio is:

```text
500 : 1000
```

or approximately:

```text
1 : 2
```

This is a price-distance ratio and does not by itself represent realized risk/reward after spread, execution costs, Break Even, or Trailing Stop adjustments.

---

## Break Even

Break Even is enabled by default.

```text
InpUseBreakEven = true
InpBreakEvenPoints = 150
```

When an open position reaches at least:

```text
+150 points
```

the EA attempts to move the Stop Loss to the original entry price.

For BUY:

```text
SL → Entry Price
```

For SELL:

```text
SL → Entry Price
```

Break Even management is evaluated on every tick.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailing = true
InpTrailingStart = 200
InpTrailingDistance = 200
```

Trailing management starts when the position reaches at least:

```text
+200 points
```

For BUY positions:

```text
New SL = Current Bid - 200 points
```

The Stop Loss is updated only when the new level is higher than the existing Stop Loss.

For SELL positions:

```text
New SL = Current Ask + 200 points
```

The Stop Loss is updated only when the new level is lower than the existing Stop Loss.

Trailing Stop management is evaluated on every tick.

---

## Input Parameters

| Input                 | Default | Description                             |
| --------------------- | ------: | --------------------------------------- |
| `InpLotSize`          |    0.01 | Fixed trading lot size                  |
| `InpStopLoss`         |     500 | Initial Stop Loss in points             |
| `InpTakeProfit`       |    1000 | Initial Take Profit in points           |
| `InpMagicNumber`      |  123456 | Identifier used for EA positions        |
| `InpSlippage`         |      10 | Maximum trade deviation in points       |
| `InpUseBreakEven`     |    true | Enable/disable Break Even               |
| `InpUseTrailing`      |    true | Enable/disable Trailing Stop            |
| `InpBreakEvenPoints`  |     150 | Profit threshold for Break Even         |
| `InpTrailingStart`    |     200 | Profit threshold before trailing begins |
| `InpTrailingDistance` |     200 | Trailing Stop distance                  |
| `InpMaxSpread`        |      30 | Maximum allowed spread in points        |

---

## Execution Flow

```text
New Tick
   │
   ├── Is this a new bar?
   │       │
   │       └── YES
   │            │
   │            ├── Check spread
   │            ├── Check existing EA position
   │            ├── Read OsMA histogram
   │            ├── Evaluate BUY / SELL conditions
   │            └── Open position if valid
   │
   └── Every Tick
           │
           ├── Break Even management
           └── Trailing Stop management
```

Entry logic therefore runs once per new bar, while position-management logic can run on every tick.

---

## Platform

* **Platform:** MetaTrader 5
* **Language:** MQL5
* **Trade library:** `Trade\Trade.mqh`
* **Indicator:** OsMA / MACD Histogram
* **Version:** 1.00

---

## File

```text
EA-021_MACD_Histogram_Trend.mq5
```

---

## Research Status

This EA should be treated as a **research strategy implementation**.

The source code defines the trading rules and trade-management logic, but the strategy's profitability, robustness, drawdown characteristics, and suitability for XAUUSD cannot be determined from the source code alone.

Those characteristics must be evaluated separately through reproducible backtesting and subsequent research.

Backtest results are maintained separately under:

```text
Backtest/EA-021_MACD_Histogram_Trend/
```

---

## Disclaimer

This Expert Advisor is provided for research, testing, and educational purposes.

Historical backtest results do not guarantee future performance. Trading leveraged financial instruments involves substantial risk.
