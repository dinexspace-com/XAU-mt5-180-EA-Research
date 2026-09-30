# EA-090_EMA50_Distance

## Overview

`EA-090_EMA50_Distance` is an MT5 Expert Advisor using an EMA distance condition combined with ATR and candle confirmation.

The strategy is configured for the M1 timeframe by default and uses:

* EMA Period: 50
* ATR Period: 14
* Distance Threshold: 1.5 ATR
* Lot Size: 0.01
* Stop Loss: 300 points
* Take Profit: 600 points
* Magic Number: 123090
* Maximum Spread: 30 points

The EA also includes Break Even and Trailing Stop management.

## Entry Logic

The EA evaluates signals when a new bar appears.

### Buy Signal

A Buy signal is generated when all required conditions are satisfied:

1. Bar 2 closes below:
   `EMA(Bar 2) - 1.5 × ATR(Bar 2)`
2. Bar 2 is a bearish candle:
   `Close[2] < Open[2]`
3. Bar 1 is a bullish candle:
   `Close[1] > Open[1]`
4. Bar 1 closes above Bar 2:
   `Close[1] > Close[2]`
5. Bar 1 remains below EMA50:
   `Close[1] < EMA(Bar 1)`

When these conditions are met, the EA generates a Buy direction.

### Sell Signal

A Sell signal is generated when all required conditions are satisfied:

1. Bar 2 closes above:
   `EMA(Bar 2) + 1.5 × ATR(Bar 2)`
2. Bar 2 is a bullish candle:
   `Close[2] > Open[2]`
3. Bar 1 is a bearish candle:
   `Close[1] < Open[1]`
4. Bar 1 closes below Bar 2:
   `Close[1] < Close[2]`
5. Bar 1 remains above EMA50:
   `Close[1] > EMA(Bar 1)`

When these conditions are met, the EA generates a Sell direction.

## Indicators

The EA uses:

* Exponential Moving Average (EMA)
* Average True Range (ATR)

Default configuration:

```text
EMA Period  = 50
ATR Period  = 14
Distance    = 1.5 ATR
```

EMA values are read from shifts 1 and 2, while ATR is read from shift 2.

## Risk and Trade Execution

Default execution parameters:

```text
Lot Size       = 0.01
Stop Loss      = 300 points
Take Profit    = 600 points
Magic Number   = 123090
Slippage       = 10
Maximum Spread = 30 points
Timeframe      = M1
```

The EA validates:

* Trading permissions
* Symbol trading mode
* Market-order support
* Stop Loss and Take Profit distance
* Available margin
* Lot-size constraints
* Current spread

The protective Stop Loss and Take Profit are submitted together with the market order.

## Break Even

Break Even management is enabled by default.

```text
Use Break Even = true
Trigger        = 150 points
Offset         = 0 points
```

When the position reaches the configured profit threshold, the EA attempts to move the Stop Loss to the entry price, subject to broker stop and freeze restrictions.

## Trailing Stop

Trailing Stop is enabled by default.

```text
Use Trailing Stop = true
Start             = 200 points
Distance          = 100 points
Step              = 10 points
```

The EA only modifies the Stop Loss when the new level improves the existing protective level.

## Position Control

The EA prevents simultaneous entries associated with the same Magic Number.

On netting accounts, it also avoids opening a new position when there is already symbol exposure, preventing the EA from unintentionally merging its trade with another position on the same symbol.

## Bar Processing

The EA processes entry signals once per new candle.

Existing positions are managed on every tick so that Break Even and Trailing Stop logic can operate independently of the entry-signal timing.

When the EA is attached, it initializes the current bar reference so that an old signal is not immediately traded.

## Initialisation

During initialization, the EA validates:

* Input parameters
* Symbol point and tick size
* Lot minimum, maximum and step
* EMA period
* ATR period
* ATR distance
* Trading configuration

Indicator handles for EMA and ATR are created during initialization and released when the EA is removed.

## Repository Role

This folder contains the implementation and technical documentation of EA-090.

The corresponding backtest report is stored separately under:

```text
Backtest/EA-090_EMA50_Distance/
```

The research interpretation is stored under:

```text
Research/
```
