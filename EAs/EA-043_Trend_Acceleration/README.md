# EA-043 — Trend Acceleration

## Overview

**EA-043 Trend Acceleration** is a MetaTrader 5 Expert Advisor designed to trade trend acceleration based on the relationship between a fast EMA and a slow EMA.

The strategy does not rely only on a simple EMA crossover. It evaluates:

* Direction of the fast EMA
* Distance between the fast and slow EMA
* Whether the EMA gap is expanding
* Current spread conditions
* Existing positions belonging to the EA

The default configuration uses:

* Fast EMA: **20**
* Slow EMA: **50**

The EA supports both **BUY** and **SELL** trades.

---

## Strategy Logic

### BUY

A BUY signal is generated when all of the following conditions are satisfied:

1. The fast EMA is moving upward.
2. The fast EMA is above the slow EMA.
3. The distance between the fast EMA and slow EMA is increasing.

Conceptually:

```text
Fast EMA slope > 0
Fast EMA > Slow EMA
Current EMA gap > Previous EMA gap
```

This attempts to identify periods where an existing bullish trend is accelerating.

### SELL

A SELL signal is generated when:

1. The fast EMA is moving downward.
2. The fast EMA is below the slow EMA.
3. The distance between the fast EMA and slow EMA is increasing in the bearish direction.

Conceptually:

```text
Fast EMA slope < 0
Fast EMA < Slow EMA
Current EMA gap < Previous EMA gap
```

This attempts to identify periods where an existing bearish trend is accelerating.

---

## Signal Timing

The EA evaluates new entry signals only when a **new candle** appears.

Indicator calculations use completed candles rather than the currently forming candle.

This helps reduce intrabar signal noise.

---

## Position Management

The EA allows only one position associated with its Magic Number to remain active before considering another entry.

When an existing position is detected, the EA manages that position instead of opening a new trade.

Available position-management functions include:

* Stop Loss
* Take Profit
* Break Even
* Trailing Stop

---

## Break Even

Break Even can be enabled or disabled.

Default configuration:

```text
Use Break Even: true
Trigger: 150 points
Shift: 0 points
```

Once the position reaches the configured profit threshold, the Stop Loss is moved toward the entry price.

`InpBreakEvenShift` can be used to move the Stop Loss beyond the exact entry price.

---

## Trailing Stop

Trailing Stop can also be enabled or disabled.

Default configuration:

```text
Use Trailing Stop: true
Trailing Start: 200 points
Trailing Step: 50 points
```

The EA progressively adjusts the Stop Loss as price moves in the profitable direction.

---

## Spread Filter

The EA contains a spread filter to avoid opening trades when the current spread exceeds the configured limit.

Default:

```text
Maximum Spread: 30 points
```

If the spread exceeds this value, the signal is ignored.

---

## Default Parameters

| Parameter             |  Default | Description                      |
| --------------------- | -------: | -------------------------------- |
| `InpLotSize`          |     0.01 | Fixed trading volume             |
| `InpStopLoss`         |      300 | Stop Loss in points              |
| `InpTakeProfit`       |      600 | Take Profit in points            |
| `InpMagicNumber`      | 20240501 | EA Magic Number                  |
| `InpSlippage`         |       10 | Maximum deviation in points      |
| `InpFastEMA`          |       20 | Fast EMA period                  |
| `InpSlowEMA`          |       50 | Slow EMA period                  |
| `InpMaxSpread`        |       30 | Maximum allowed spread           |
| `InpUseBreakEven`     |     true | Enable Break Even                |
| `InpBreakEvenTrigger` |      150 | Break Even activation threshold  |
| `InpBreakEvenShift`   |        0 | Break Even price shift           |
| `InpUseTrailing`      |     true | Enable Trailing Stop             |
| `InpTrailingStart`    |      200 | Trailing Stop distance           |
| `InpTrailingStep`     |       50 | Minimum trailing adjustment step |

---

## Platform

* **Platform:** MetaTrader 5
* **Language:** MQL5
* **EA type:** Trend-following / Trend acceleration
* **Indicators:** Exponential Moving Average (EMA)
* **Trade directions:** BUY / SELL
* **Position sizing:** Fixed lot
* **Signal evaluation:** New candle

---

## Files

```text
EA-043_Trend_Acceleration/
├── EA-043_Trend_Acceleration.mq5
└── README.md
```

`EA-043_Trend_Acceleration.mq5` contains the complete Expert Advisor source code.

---

## Research Status

This EA is part of the **XAUUSD MT5 EA Research** repository.

The strategy should be evaluated through MetaTrader 5 Strategy Tester before being considered for live trading.

Backtest results are maintained separately under:

```text
Backtest/
└── EA-043_Trend_Acceleration/
```

---

## Disclaimer

This Expert Advisor is provided for research, development, and educational purposes.

Historical backtest performance does not guarantee future trading results. Trading leveraged financial instruments involves significant risk.
