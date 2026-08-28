# EA-030 — Parabolic SAR

## Overview

**EA-030 Parabolic SAR** is a MetaTrader 5 Expert Advisor based on the **Parabolic SAR (Stop and Reverse)** indicator.

The EA determines market direction by comparing the current price with the Parabolic SAR value and automatically executes BUY or SELL orders accordingly.

The strategy includes fixed Stop Loss and Take Profit, spread filtering, position limits, Break Even, and Trailing Stop management.

---

## Strategy Logic

The EA uses the standard MetaTrader 5 **Parabolic SAR** indicator.

### BUY Signal

A BUY signal is generated when:

```text
Parabolic SAR < Current Close Price
```

In other words, when the SAR value is below the current market price, the EA interprets the market as bullish.

### SELL Signal

A SELL signal is generated when:

```text
Parabolic SAR > Current Close Price
```

When the SAR value is above the current market price, the EA interprets the market as bearish.

The EA evaluates trading conditions only when a **new candle/bar** is detected.

---

## Parabolic SAR Settings

Default indicator parameters:

| Parameter       | Default | Description                     |
| --------------- | ------: | ------------------------------- |
| `InpSarStep`    |    0.02 | Parabolic SAR acceleration step |
| `InpSarMaximum` |     0.2 | Maximum acceleration factor     |

The indicator operates on:

```text
Symbol: Current chart symbol
Timeframe: Current chart timeframe
```

---

## Trading Parameters

| Parameter         | Default | Description                                                           |
| ----------------- | ------: | --------------------------------------------------------------------- |
| `InpLotSize`      |    0.01 | Fixed trading lot size                                                |
| `InpStopLoss`     |     300 | Stop Loss in points                                                   |
| `InpTakeProfit`   |     600 | Take Profit in points                                                 |
| `InpMagicNumber`  |  123456 | Unique Magic Number used to identify EA positions                     |
| `InpSlippage`     |      10 | Maximum deviation in points                                           |
| `InpMaxSpread`    |      30 | Maximum allowed spread in points                                      |
| `InpMaxPositions` |       1 | Maximum number of positions managed by this EA for the current symbol |

---

## Entry Process

On every new bar, the EA performs the following sequence:

```text
New Bar
   ↓
Check Spread
   ↓
Check Existing Positions
   ↓
Read Parabolic SAR
   ↓
Compare SAR with Current Close
   ↓
SAR < Price → BUY
SAR > Price → SELL
   ↓
Open Position
   ↓
Manage Break Even / Trailing Stop
```

No new trade is opened when the number of positions with the same Magic Number and symbol has reached `InpMaxPositions`.

---

## Stop Loss & Take Profit

The EA uses fixed Stop Loss and Take Profit distances measured in **points**.

Default configuration:

```text
Stop Loss  = 300 points
Take Profit = 600 points
```

### BUY

```text
SL = Entry Price - Stop Loss
TP = Entry Price + Take Profit
```

### SELL

```text
SL = Entry Price + Stop Loss
TP = Entry Price - Take Profit
```

Setting either parameter to `0` disables that respective SL or TP calculation.

---

## Spread Filter

Before evaluating a new trading opportunity, the EA checks the current spread.

Default:

```text
Maximum Spread = 30 points
```

If:

```text
Current Spread > InpMaxSpread
```

the EA does not process a new entry on that bar.

---

## Break Even

Break Even is enabled by default.

```text
InpUseBreakEven   = true
InpBreakEvenStart = 150 points
```

When an open position reaches at least **150 points of profit**, the EA attempts to move the Stop Loss to the original entry price.

### BUY

```text
Profit >= 150 points
→ SL = Entry Price
```

### SELL

```text
Profit >= 150 points
→ SL = Entry Price
```

Break Even can be disabled by setting:

```text
InpUseBreakEven = false
```

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailing   = true
InpTrailingStart = 200 points
```

Once the position reaches at least **200 points of profit**, the EA calculates a new Stop Loss based on the current market price.

### BUY

```text
New SL = Current Price - 200 points
```

### SELL

```text
New SL = Current Price + 200 points
```

The Stop Loss is only modified when the new calculated level improves the existing Stop Loss.

---

## Position Management

The EA identifies its own positions using:

```text
Magic Number + Current Symbol
```

Default Magic Number:

```text
123456
```

Default maximum number of positions:

```text
1
```

This prevents the EA from continuously opening additional positions while an existing EA position is active on the same symbol.

---

## Execution Frequency

Trading logic is evaluated only once when a **new bar** appears.

The EA therefore does not continuously generate entry signals on every incoming tick.

The actual trading frequency depends on the timeframe of the chart where the EA is running.

For example:

```text
M5  → evaluation on each new 5-minute candle
M15 → evaluation on each new 15-minute candle
H1  → evaluation on each new hourly candle
```

---

## Default Configuration

```text
Lot Size          = 0.01
Stop Loss         = 300 points
Take Profit       = 600 points

Magic Number      = 123456
Slippage          = 10 points
Maximum Spread    = 30 points
Maximum Positions = 1

Break Even        = Enabled
Break Even Start  = 150 points

Trailing Stop     = Enabled
Trailing Start    = 200 points

SAR Step          = 0.02
SAR Maximum       = 0.2
```

---

## File

```text
EA-030_Parabolic_SAR/
├── EA-030_Parabolic_SAR.mq5
└── README.md
```

`EA-030_Parabolic_SAR.mq5` contains the complete MQL5 implementation of the strategy.

---

## Important Notes

This repository contains an **experimental algorithmic trading strategy intended for research and backtesting**.

The current implementation uses:

* Fixed lot sizing
* Fixed Stop Loss and Take Profit
* Parabolic SAR direction as the entry signal
* Spread filtering
* Maximum-position control
* Break Even management
* Trailing Stop management
* New-bar execution

Performance should be evaluated through controlled backtesting and validation before considering any live trading environment.

---

## Disclaimer

This Expert Advisor is provided for **research and educational purposes only**.

Historical or backtested performance does not guarantee future results. Trading XAUUSD, forex, CFDs, or other leveraged financial instruments involves substantial risk.

Users are responsible for independently evaluating the strategy and its suitability before any real-money deployment.
