# EA-058 — Wedge Break

**Platform:** MetaTrader 5 (MT5)
**Language:** MQL5
**Strategy:** Contracting Wedge Breakout
**Direction:** BUY & SELL
**Position Management:** Stop Loss, Take Profit, Break Even, Trailing Stop

---

## 1. Overview

`EA-058_Wedge_Break` is a MetaTrader 5 Expert Advisor that identifies contracting wedge formations from recent price pivots and trades confirmed breakouts of the wedge boundaries.

The EA constructs the wedge using two pivot highs and two pivot lows:

* The newer pivot high must be lower than the older pivot high.
* The newer pivot low must be higher than the older pivot low.
* The upper trendline must slope downward.
* The lower trendline must slope upward.
* The distance between the two boundaries must contract within a configurable range.

Once a valid wedge is detected, the EA waits for a closed candle to break beyond one of the projected wedge boundaries before opening a position.

---

## 2. Strategy Logic

### Wedge Detection

The EA searches the most recent `InpWedgeLookback` bars for:

* Two valid pivot highs.
* Two valid pivot lows.
* A minimum distance between consecutive pivots.

A valid contracting wedge requires:

```text
Recent Pivot High < Previous Pivot High
Recent Pivot Low  > Previous Pivot Low
```

This produces:

```text
Upper trendline → descending
Lower trendline → ascending
```

The wedge is accepted only when its calculated contraction ratio falls between:

```text
InpMinContractionRatio
and
InpMaxContractionRatio
```

Default range:

```text
10% – 80%
```

---

## 3. Entry Logic

The trading strategy is evaluated **once per newly formed candle**.

### BUY

A BUY breakout is detected when:

```text
Previous close <= previous upper wedge boundary + breakout buffer

AND

Latest closed candle > current upper wedge boundary + breakout buffer
```

The EA then opens a market BUY order.

### SELL

A SELL breakout is detected when:

```text
Previous close >= previous lower wedge boundary - breakout buffer

AND

Latest closed candle < current lower wedge boundary - breakout buffer
```

The EA then opens a market SELL order.

Only closed candles are used for breakout confirmation.

---

## 4. Position Management

### Initial Stop Loss

Default:

```text
300 points
```

For BUY:

```text
SL = Entry Price - 300 points
```

For SELL:

```text
SL = Entry Price + 300 points
```

### Initial Take Profit

Default:

```text
600 points
```

For BUY:

```text
TP = Entry Price + 600 points
```

For SELL:

```text
TP = Entry Price - 600 points
```

The default nominal SL:TP distance ratio is therefore:

```text
1 : 2
```

Actual order levels may be adjusted automatically when the broker requires a larger minimum stop distance.

---

## 5. Break Even

Break Even is enabled by default.

Default settings:

```text
Trigger = 150 points
Offset  = 0 points
```

Once an open position reaches at least 150 points of profit, the EA attempts to move Stop Loss to the entry price.

The offset parameter can be changed to lock in additional points beyond the entry price.

---

## 6. Trailing Stop

Trailing Stop is enabled by default.

Default configuration:

```text
Start Distance    = 200 points
Trailing Distance = 150 points
Trailing Step     = 10 points
```

Trailing begins once the position reaches the configured profit threshold.

For BUY positions, Stop Loss follows price upward.

For SELL positions, Stop Loss follows price downward.

The EA only modifies the Stop Loss when the improvement satisfies the configured trailing step and broker stop-distance restrictions.

---

## 7. Spread Filter

The EA checks spread before opening a new position.

Default maximum:

```text
30 points
```

If:

```text
Current Spread > InpMaxSpread
```

no new trade is opened.

---

## 8. Position Limit

Default:

```text
InpMaxPositions = 1
```

Positions are counted using both:

* Current symbol
* EA Magic Number

This prevents the EA from opening more than the configured number of its own positions on the same symbol.

---

## 9. Default Parameters

| Parameter                | Default | Description                       |
| ------------------------ | ------: | --------------------------------- |
| `InpLotSize`             |    0.01 | Fixed trading volume              |
| `InpStopLoss`            |     300 | Stop Loss in points               |
| `InpTakeProfit`          |     600 | Take Profit in points             |
| `InpMagicNumber`         |  123456 | EA Magic Number                   |
| `InpSlippage`            |      10 | Maximum deviation in points       |
| `InpMaxSpread`           |      30 | Maximum allowed spread            |
| `InpMaxPositions`        |       1 | Maximum EA positions              |
| `InpWedgeLookback`       |      30 | Bars searched for wedge pivots    |
| `InpPivotStrength`       |       2 | Pivot detection strength          |
| `InpMinPivotDistance`    |       3 | Minimum bars between pivots       |
| `InpBreakoutBuffer`      |       5 | Breakout confirmation buffer      |
| `InpMinContractionRatio` |    0.10 | Minimum wedge contraction         |
| `InpMaxContractionRatio` |    0.80 | Maximum wedge contraction         |
| `InpUseBreakEven`        |    true | Enable Break Even                 |
| `InpBreakEvenTrigger`    |     150 | Profit required before Break Even |
| `InpBreakEvenOffset`     |       0 | Points locked after Break Even    |
| `InpUseTrailingStop`     |    true | Enable Trailing Stop              |
| `InpTrailingStart`       |     200 | Profit required before trailing   |
| `InpTrailingDistance`    |     150 | Trailing Stop distance            |
| `InpTrailingStep`        |      10 | Minimum Stop Loss improvement     |

---

## 10. Execution Flow

```text
New Tick
   │
   ├── Manage existing positions
   │     ├── Break Even
   │     └── Trailing Stop
   │
   ├── Check trading permissions
   │
   ├── Wait for new candle
   │
   ├── Check spread
   │
   ├── Check position limit
   │
   ├── Check sufficient historical bars
   │
   ├── Detect pivot highs / lows
   │
   ├── Validate contracting wedge
   │
   ├── Project wedge boundaries
   │
   ├── Check breakout
   │
   ├── Upper breakout → BUY
   │
   └── Lower breakout → SELL
```

---

## 11. Broker Compatibility

The EA automatically considers the symbol's:

* Minimum trading volume
* Maximum trading volume
* Volume step
* Price digits
* Stop level
* Freeze level
* Order filling mode

Requested lot size is normalized according to the broker's permitted volume settings.

Initial and managed Stop Loss levels are also adjusted where necessary to respect broker minimum-distance requirements.

---

## 12. Files

```text
EA-058_Wedge_Break/
├── EA-058_Wedge_Break.mq5
└── README.md
```

`EA-058_Wedge_Break.mq5` contains the complete MQL5 Expert Advisor source code.

`README.md` documents the implementation and strategy logic represented by the source code.

---

## 13. Important Notes

This directory documents the EA implementation itself.

Backtest performance, optimization results, profitability metrics, drawdown, trade statistics, and XAUUSD test conditions are intentionally not claimed here unless they have been independently tested and recorded.

Historical performance does not guarantee future trading results.

---

## 14. Research Status

**EA ID:** EA-058
**Strategy Family:** Chart Pattern / Breakout
**Pattern:** Contracting Wedge
**Implementation:** MQL5
**Backtest Evidence:** See project `Backtest/EA-058_Wedge_Break/` directory.
