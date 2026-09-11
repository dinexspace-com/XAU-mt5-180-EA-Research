# EA-053 — Compression Break

## Overview

**EA-053_Compression_Break** is a MetaTrader 5 Expert Advisor based on a **range compression → breakout** strategy.

The EA identifies a sequence of candles whose trading ranges progressively contract. After a valid compression structure is detected, the EA waits for a completed candle to break and close outside the compression zone before opening a position.

The strategy is designed for systematic breakout research and backtesting.

---

## Strategy Logic

### 1. Range Compression

The EA examines a configurable number of completed candles.

For a valid compression structure, each newer candle must have a smaller high-to-low range than the preceding candle.

For the default configuration:

```text
InpCompressionBars = 4
```

the structure is:

```text
Oldest candle
    ↓
Large range
    ↓
Smaller range
    ↓
Smaller range
    ↓
Smallest range
    ↓
Breakout candle
```

The minimum required decrease between consecutive ranges can be controlled with:

```text
InpMinRangeDecreasePct
```

Default:

```text
0.0%
```

Therefore, with the default configuration, every newer compression candle must simply have a strictly smaller range than the previous candle.

---

## Compression Zone

After a valid compression pattern is detected, the EA constructs a compression zone from the compression candles.

```text
Zone High = highest High of the compression candles
Zone Low  = lowest Low of the compression candles
```

The most recently completed candle is treated as the breakout candle and is not part of the compression zone.

---

## BUY Signal

A BUY signal is generated when the completed breakout candle satisfies all of the following conditions:

1. A valid range compression pattern exists.
2. The breakout candle trades above `Zone High`.
3. The breakout candle closes above `Zone High`.
4. The breakout candle is bullish:

```text
Close > Open
```

Conceptually:

```text
Compression
     ↓
┌──────────── Zone High
│
│  shrinking ranges
│
└──────────── Zone Low
          ↗
       bullish breakout
          ↓
         BUY
```

---

## SELL Signal

A SELL signal is generated when the completed breakout candle satisfies all of the following conditions:

1. A valid range compression pattern exists.
2. The breakout candle trades below `Zone Low`.
3. The breakout candle closes below `Zone Low`.
4. The breakout candle is bearish:

```text
Close < Open
```

Conceptually:

```text
┌──────────── Zone High
│
│  shrinking ranges
│
└──────────── Zone Low
          ↘
       bearish breakout
          ↓
         SELL
```

---

## Entry Timing

Signal evaluation is performed only once when a **new candle begins**.

The EA evaluates the previously completed candle (`shift 1`) as the breakout candle.

This prevents repeated entries from the same breakout candle.

---

## Position Limit

The EA allows a maximum of:

```text
1 active position per Magic Number
```

Before opening a new trade, it checks all active positions and prevents another entry if a position using the configured Magic Number already exists.

---

## Initial Stop Loss and Take Profit

Stop Loss and Take Profit are defined in **MT5 points**.

Default parameters:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

For BUY:

```text
SL = Ask - StopLoss × Point
TP = Ask + TakeProfit × Point
```

For SELL:

```text
SL = Bid + StopLoss × Point
TP = Bid - TakeProfit × Point
```

The actual price distance represented by a point depends on the symbol and broker specification.

---

## Break Even

Break Even management is enabled by default.

Default configuration:

```text
Use Break Even     = true
Break Even Trigger = 150 points
Break Even Lock    = 0 points
```

Once unrealized profit reaches the trigger level, the EA attempts to move Stop Loss to the entry price plus or minus the configured lock.

BUY:

```text
BE Stop = Entry + BreakEvenLock
```

SELL:

```text
BE Stop = Entry - BreakEvenLock
```

Broker minimum stop-distance requirements are checked before modification.

---

## Trailing Stop

Trailing Stop is enabled by default.

Default configuration:

```text
Use Trailing Stop = true
Trailing Start    = 200 points
Trailing Distance = 150 points
Trailing Step     = 10 points
```

Trailing begins after the position reaches the configured profit threshold.

For BUY:

```text
Trailing SL = Bid - TrailingDistance
```

For SELL:

```text
Trailing SL = Ask + TrailingDistance
```

The Stop Loss is updated only when the new level improves the existing Stop Loss by the required trailing step and satisfies broker stop-distance requirements.

---

## Spread Filter

The EA prevents new entries when the current spread exceeds:

```text
InpMaxSpread
```

Default:

```text
30 points
```

The spread filter applies to new entries. Existing position management continues to run on every tick.

---

## Default Parameters

| Parameter                | Default | Description                                |
| ------------------------ | ------: | ------------------------------------------ |
| `InpLotSize`             |    0.01 | Fixed trading volume                       |
| `InpStopLoss`            |     300 | Initial Stop Loss in points                |
| `InpTakeProfit`          |     600 | Initial Take Profit in points              |
| `InpMagicNumber`         |  123456 | EA position identifier                     |
| `InpSlippage`            |      10 | Maximum deviation in points                |
| `InpCompressionBars`     |       4 | Number of candles used for compression     |
| `InpMinRangeDecreasePct` |     0.0 | Minimum range contraction percentage       |
| `InpMaxSpread`           |      30 | Maximum allowed spread in points           |
| `InpUseBreakEven`        |    true | Enable Break Even                          |
| `InpBreakEvenTrigger`    |     150 | Profit required before Break Even          |
| `InpBreakEvenLock`       |       0 | Profit locked at Break Even                |
| `InpUseTrailingStop`     |    true | Enable Trailing Stop                       |
| `InpTrailingStart`       |     200 | Profit required before trailing begins     |
| `InpTrailingDistance`    |     150 | Trailing Stop distance                     |
| `InpTrailingStep`        |      10 | Minimum improvement before SL modification |

---

## Execution Flow

```text
New Tick
   │
   ├── Manage existing position
   │      ├── Break Even
   │      └── Trailing Stop
   │
   └── New candle?
          │
          ├── No → Stop
          │
          └── Yes
               │
               ├── Trading allowed?
               ├── Spread acceptable?
               ├── Existing EA position?
               │
               └── Detect compression
                        │
                        ├── No compression → Stop
                        │
                        └── Compression found
                               │
                               ├── Bullish breakout → BUY
                               ├── Bearish breakout → SELL
                               └── Otherwise → No trade
```

---

## Files

```text
EA-053_Compression_Break/
├── EA-053_Compression_Break.mq5
└── README.md
```

`EA-053_Compression_Break.mq5` contains the MetaTrader 5 implementation of the strategy.

---

## Research Status

EA-053 is part of the XAUUSD MT5 EA research repository.

Strategy source code and strategy documentation are stored in this directory.

Backtest reports, test configurations, and performance evidence should be stored separately under:

```text
Backtest/EA-053_Compression_Break/
```

Backtest performance should not be inferred from the strategy logic alone.

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
EA Type: Compression / Breakout
Position sizing: Fixed lot
Signal evaluation: Completed candles
Position management: Break Even + Trailing Stop
```

---

## Disclaimer

This Expert Advisor is provided for research, development, and backtesting purposes.

Historical or backtested performance does not guarantee future trading results. Trading leveraged financial instruments involves significant risk.
