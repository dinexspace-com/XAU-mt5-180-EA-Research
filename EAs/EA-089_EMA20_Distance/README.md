# EA-089_EMA20_Distance

## 1. Overview

EA-089_EMA20_Distance is an MQL5 Expert Advisor designed for trading XAUUSD using an EMA-based price-distance condition combined with ATR.

The strategy uses:

* EMA Period: 20
* ATR Period: 14
* Distance Threshold: 1.5 ATR
* Default Timeframe: M1
* Default Lot Size: 0.01
* Stop Loss: 300 points
* Take Profit: 600 points
* Magic Number: 123089

The EA also includes Break Even and Trailing Stop position management.

---

## 2. Entry Logic

The EA evaluates signals when a new candle appears on the configured timeframe.

### Buy Signal

A buy signal is generated when all of the following conditions are satisfied:

1. The close of bar 2 is below EMA by at least 1.5 ATR.
2. Bar 1 closes higher than bar 2.
3. The close of bar 1 remains below EMA.
4. The close of bar 2 is less than or equal to the close of bar 3.

### Sell Signal

A sell signal is generated when all of the following conditions are satisfied:

1. The close of bar 2 is above EMA by at least 1.5 ATR.
2. Bar 1 closes lower than bar 2.
3. The close of bar 1 remains above EMA.
4. The close of bar 2 is greater than or equal to the close of bar 3.

The EA evaluates the completed candles rather than entering from an unfinished candle.

---

## 3. Risk and Trade Execution

Default execution parameters:

| Parameter      |    Default |
| -------------- | ---------: |
| Lot Size       |       0.01 |
| Stop Loss      | 300 points |
| Take Profit    | 600 points |
| Magic Number   |     123089 |
| Slippage       |  10 points |
| Maximum Spread |  30 points |
| Timeframe      |         M1 |

Before opening a position, the EA checks:

* Trading permissions.
* Existing positions and orders.
* Maximum spread.
* Symbol trading mode.
* Market order support.
* SL/TP support.
* Available margin.
* Broker stop-distance requirements.
* Lot-size validity.

The configured SL and TP are submitted together with the market order.

---

## 4. Break Even

Break Even is enabled by default.

Default parameters:

* Break Even Trigger: 150 points
* Break Even Offset: 0 points

When the configured profit threshold is reached, the EA attempts to move the stop loss toward the entry price while respecting the broker's stop and freeze levels.

---

## 5. Trailing Stop

Trailing Stop is enabled by default.

Default parameters:

* Trailing Start: 200 points
* Trailing Distance: 100 points
* Trailing Step: 10 points

Trailing Stop management is performed on every tick.

The EA only modifies the stop loss when the new level improves the existing stop and satisfies broker constraints.

---

## 6. Position Control

The EA limits new entries by checking existing positions and orders.

For the configured Magic Number, another position or order blocks a new entry.

On netting accounts, exposure on the current symbol also prevents a new entry when another position is already present.

---

## 7. Indicators

The EA creates two indicator handles:

* EMA using `MODE_EMA` and `PRICE_CLOSE`.
* ATR using the configured ATR period.

Default configuration:

```text
EMA Period   = 20
ATR Period   = 14
Distance ATR = 1.5
```

---

## 8. Initialisation

At startup, the EA validates:

* Lot size.
* Stop Loss.
* Take Profit.
* Magic Number.
* Slippage.
* Maximum Spread.
* Break Even parameters.
* Trailing Stop parameters.
* EMA period.
* ATR period.
* Distance ATR.

The EA also validates the symbol's volume and tick-size requirements.

---

## 9. Repository Role

This directory contains the source code and documentation for EA-089_EMA20_Distance.

Backtest results are stored separately under:

```text
Backtest/EA-089_EMA20_Distance/
```

Research conclusions are stored under:

```text
Research/README.md
```
