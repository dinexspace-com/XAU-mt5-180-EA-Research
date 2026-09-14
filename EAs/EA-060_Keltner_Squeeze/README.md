# EA-060 — Keltner Squeeze Breakout

## Overview

**EA-060 Keltner Squeeze Breakout** is a MetaTrader 5 Expert Advisor based on volatility compression and breakout detection using the **Keltner Channel**.

The EA identifies periods where the current Keltner Channel width contracts significantly compared with its recent historical width. When a completed candle subsequently closes outside the Keltner Channel, while the previous candle was still inside the channel, the EA generates a breakout trade signal.

The strategy supports both BUY and SELL trades and includes:

* Keltner Channel breakout detection
* ATR-based volatility squeeze detection
* Spread filtering
* Fixed Stop Loss
* Fixed Take Profit
* Break Even management
* Trailing Stop management
* Magic Number position filtering
* Maximum one active position per symbol for this EA
* New-bar-only entry logic

---

## Strategy Logic

### Keltner Channel

The Keltner Channel is calculated using:

* EMA of closing price
* ATR as the volatility component

Upper band:

```text
Upper = EMA + ATR × ATR Multiplier
```

Lower band:

```text
Lower = EMA - ATR × ATR Multiplier
```

Default parameters:

```text
EMA Period      = 20
ATR Period      = 20
ATR Multiplier  = 1.5
```

---

## Squeeze Detection

The EA defines Keltner Channel width as:

```text
Width = 2 × ATR Multiplier × ATR
```

The current completed candle's Keltner width is compared with the average Keltner width of previous candles.

A squeeze exists when:

```text
Current Width <= Average Historical Width × Squeeze Ratio
```

Default settings:

```text
Squeeze Lookback = 5
Squeeze Ratio    = 0.80
```

This means the current Keltner Channel width must be no greater than **80% of the average width of the previous 5 candles**.

---

## Entry Logic

Entry signals are evaluated only when a **new candle opens**.

The EA uses completed candles for signal generation.

### BUY

A BUY signal is generated when all of the following conditions are true:

1. A valid Keltner squeeze exists.
2. Candle `[2]` closed inside the Keltner Channel.
3. Candle `[1]` closes above the upper Keltner band.
4. Trading is allowed by the terminal, account, MQL environment and symbol.
5. Current spread is within the configured maximum.
6. No position with the same symbol and Magic Number is already open.

Logic:

```text
Close[2] inside Keltner Channel
        +
Keltner squeeze detected
        +
Close[1] > Upper Keltner[1]
        ↓
       BUY
```

---

### SELL

A SELL signal is generated when all of the following conditions are true:

1. A valid Keltner squeeze exists.
2. Candle `[2]` closed inside the Keltner Channel.
3. Candle `[1]` closes below the lower Keltner band.
4. Trading is allowed.
5. Spread is within the configured maximum.
6. No position with the same symbol and Magic Number is already open.

Logic:

```text
Close[2] inside Keltner Channel
        +
Keltner squeeze detected
        +
Close[1] < Lower Keltner[1]
        ↓
       SELL
```

---

## Position Management

Position management is executed on every tick.

### Stop Loss

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

The EA automatically adjusts the stop level when necessary to comply with the broker's minimum stop-distance requirement.

---

## Take Profit

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

The EA also adjusts TP to comply with the broker's minimum stop-distance requirement.

---

## Break Even

Break Even is enabled by default.

Default configuration:

```text
Use Break Even     = true
Break Even Trigger = 150 points
Break Even Offset  = 0 points
```

Once the position reaches at least:

```text
+150 points
```

the EA attempts to move Stop Loss toward the entry price.

With the default offset:

```text
Break Even SL ≈ Entry Price
```

The EA also respects the broker's:

* Stops Level
* Freeze Level

when modifying Stop Loss.

---

## Trailing Stop

Trailing Stop is enabled by default.

Default configuration:

```text
Use Trailing Stop  = true
Trailing Start     = 200 points
Trailing Distance  = 150 points
```

Trailing Stop begins after the trade reaches at least:

```text
+200 points
```

For BUY positions:

```text
Trailing SL = Current Bid - 150 points
```

For SELL positions:

```text
Trailing SL = Current Ask + 150 points
```

The EA only moves the Stop Loss in a direction that improves protection. It will not intentionally move an existing stop farther away from profit protection.

---

## Spread Filter

The EA prevents new trades when spread exceeds:

```text
30 points
```

Default:

```text
InpMaxSpread = 30
```

Spread is calculated as:

```text
(Ask - Bid) / Point
```

This filter applies to new entries only.

Existing positions continue to be managed regardless of the entry spread filter.

---

## Position Limit

The EA allows a maximum of:

```text
1 active position per Symbol + Magic Number
```

Before opening a new trade, the EA checks all active positions.

If a position exists with both:

```text
POSITION_SYMBOL == current symbol
POSITION_MAGIC  == configured Magic Number
```

no additional position will be opened.

---

## Default Parameters

### Trading Parameters

| Parameter        | Default | Description                  |
| ---------------- | ------: | ---------------------------- |
| `InpLotSize`     |    0.01 | Fixed trading volume         |
| `InpStopLoss`    |     300 | Stop Loss in points          |
| `InpTakeProfit`  |     600 | Take Profit in points        |
| `InpMagicNumber` |  123456 | EA Magic Number              |
| `InpSlippage`    |      10 | Maximum deviation in points  |
| `InpMaxSpread`   |      30 | Maximum allowed entry spread |

### Keltner Channel

| Parameter             | Default | Description                           |
| --------------------- | ------: | ------------------------------------- |
| `InpKeltnerEMAPeriod` |      20 | EMA period                            |
| `InpATRPeriod`        |      20 | ATR period                            |
| `InpATRMultiplier`    |     1.5 | ATR multiplier used for channel width |

### Keltner Squeeze

| Parameter            | Default | Description                                                |
| -------------------- | ------: | ---------------------------------------------------------- |
| `InpSqueezeLookback` |       5 | Historical candles used to calculate average channel width |
| `InpSqueezeRatio`    |    0.80 | Required contraction ratio                                 |

### Break Even

| Parameter             | Default | Description                |
| --------------------- | ------: | -------------------------- |
| `InpUseBreakEven`     |    true | Enable Break Even          |
| `InpBreakEvenTrigger` |     150 | Profit threshold in points |
| `InpBreakEvenOffset`  |       0 | Offset from entry price    |

### Trailing Stop

| Parameter             | Default | Description                             |
| --------------------- | ------: | --------------------------------------- |
| `InpUseTrailingStop`  |    true | Enable Trailing Stop                    |
| `InpTrailingStart`    |     200 | Profit threshold before trailing starts |
| `InpTrailingDistance` |     150 | Trailing distance in points             |

---

## Execution Flow

The EA follows this execution sequence:

```text
OnTick
  │
  ├── Manage existing positions
  │     ├── Break Even
  │     └── Trailing Stop
  │
  ├── Detect new candle
  │
  ├── Check trading permissions
  │
  ├── Check spread
  │
  ├── Check existing EA position
  │
  ├── Calculate EMA and ATR
  │
  ├── Detect Keltner squeeze
  │
  ├── Check breakout
  │
  └── Open BUY / SELL
```

---

## Indicators Used

The EA uses native MetaTrader 5 indicators:

```text
iMA()
iATR()
```

EMA configuration:

```text
Method: MODE_EMA
Price:  PRICE_CLOSE
```

Both indicators use:

```text
PERIOD_CURRENT
```

Therefore, the strategy automatically operates on the timeframe of the chart or Strategy Tester configuration where the EA is running.

---

## Trading Environment Validation

Before opening new positions, the EA verifies:

```text
TERMINAL_TRADE_ALLOWED
MQL_TRADE_ALLOWED
ACCOUNT_TRADE_ALLOWED
SYMBOL_TRADE_MODE
```

A new order is not submitted if trading is unavailable.

---

## Broker Compatibility

The EA dynamically reads:

```text
SYMBOL_POINT
SYMBOL_DIGITS
SYMBOL_TRADE_STOPS_LEVEL
SYMBOL_TRADE_FREEZE_LEVEL
```

Prices are normalized according to the symbol's number of digits.

The EA also uses:

```text
trade.SetTypeFillingBySymbol()
```

so the trade filling mode follows the configuration supported by the current symbol.

---

## Files

```text
EA-060_Keltner_Squeeze/
├── EA-060_Keltner_Squeeze.mq5
└── README.md
```

### `EA-060_Keltner_Squeeze.mq5`

Main MetaTrader 5 Expert Advisor source code.

### `README.md`

Technical description of the strategy, parameters, signal generation and position-management logic.

---

## Current Version

```text
Version: 1.00
Platform: MetaTrader 5
Language: MQL5
Strategy: Keltner Squeeze Breakout
```

---

## Validation Status

Source code structure and trading rules are documented from the current `EA-060_Keltner_Squeeze.mq5` implementation.

Performance characteristics such as:

* Net Profit
* Profit Factor
* Drawdown
* Win Rate
* Expected Payoff
* Number of Trades
* Recovery Factor

are **not included here until verified through Strategy Tester results**.

Backtest evidence belongs in the corresponding:

```text
Backtest/EA-060_Keltner_Squeeze/
```
