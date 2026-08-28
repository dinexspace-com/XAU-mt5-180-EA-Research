# EA-029 — Ichimoku Kijun Pullback

## Overview

**EA-029_Ichimoku_Kijun_Pullback** is a MetaTrader 5 Expert Advisor (EA) implementing a pullback trading strategy based on the **Kijun-sen line of the Ichimoku Kinko Hyo indicator**.

The EA looks for price to remain on one side of the Kijun-sen, pull back toward the Kijun-sen, and then close back in the direction of the prevailing move.

The strategy supports both BUY and SELL positions and includes fixed Stop Loss / Take Profit, spread filtering, Break Even, Trailing Stop, and position-count control.

---

## Strategy Logic

### BUY Signal

A BUY signal is generated when all of the following conditions are satisfied:

1. The previous completed candle closes above the Kijun-sen.
2. The latest completed candle reaches or touches the Kijun-sen.
3. The latest completed candle closes above the Kijun-sen.
4. The latest completed candle is bullish (`Close > Open`).

Conceptually:

```text
Price above Kijun
        ↓
Pullback toward Kijun
        ↓
Kijun touched
        ↓
Bullish close above Kijun
        ↓
BUY
```

---

### SELL Signal

A SELL signal is generated when all of the following conditions are satisfied:

1. The previous completed candle closes below the Kijun-sen.
2. The latest completed candle reaches or touches the Kijun-sen.
3. The latest completed candle closes below the Kijun-sen.
4. The latest completed candle is bearish (`Close < Open`).

Conceptually:

```text
Price below Kijun
        ↓
Pullback toward Kijun
        ↓
Kijun touched
        ↓
Bearish close below Kijun
        ↓
SELL
```

---

## Signal Evaluation

The EA evaluates new entry signals **once per new bar**.

It uses completed candle data for its trading decisions rather than opening a new trade from every incoming tick.

The EA runs on:

* the symbol of the chart where it is attached (`_Symbol`);
* the timeframe of that chart (`_Period`).

Therefore, the source code does not hard-code XAUUSD or a specific timeframe.

---

## Ichimoku Parameters

Default Ichimoku settings:

| Parameter        | Default | Description          |
| ---------------- | ------: | -------------------- |
| `InpTenkanSen`   |       9 | Tenkan-sen period    |
| `InpKijunSen`    |      26 | Kijun-sen period     |
| `InpSenkouSpanB` |      52 | Senkou Span B period |

Although the EA creates the complete Ichimoku indicator and reads Tenkan-sen, Kijun-sen, Senkou Span A, and Senkou Span B buffers, the current entry conditions are based primarily on **price interaction with the Kijun-sen**.

The current version does **not** require a Tenkan/Kijun crossover or a Kumo/cloud confirmation for entry.

---

## Trading Parameters

| Parameter            | Default | Description                                                         |
| -------------------- | ------: | ------------------------------------------------------------------- |
| `InpLotSize`         |    0.01 | Fixed trading volume                                                |
| `InpStopLoss`        |     300 | Stop Loss in points                                                 |
| `InpTakeProfit`      |     600 | Take Profit in points                                               |
| `InpMagicNumber`     |  123456 | Magic Number used to identify EA positions                          |
| `InpSlippage`        |      10 | Maximum trade deviation in points                                   |
| `InpMaxSpreadPoints` |      30 | Maximum allowed spread                                              |
| `InpMaxPositions`    |       1 | Maximum number of positions opened by this EA on the current symbol |

With the default settings, the initial nominal SL/TP relationship is:

```text
Stop Loss   = 300 points
Take Profit = 600 points

Initial TP / SL ratio = 2.0
```

Actual monetary risk depends on the instrument, broker specifications, point size, lot size, execution price, spread, and trading conditions.

---

## Spread Filter

Before evaluating a new entry, the EA checks the current spread.

Default:

```text
Maximum spread = 30 points
```

If the spread exceeds `InpMaxSpreadPoints`, the EA skips trading for that bar.

This filter is intended to reduce entries during unfavorable spread conditions.

---

## Position Control

The EA counts positions matching:

* the current chart symbol; and
* `InpMagicNumber`.

By default:

```text
InpMaxPositions = 1
```

Therefore, the EA will not open another position while the maximum permitted number of matching positions is already open.

---

## Break Even

Break Even management is enabled by default.

| Parameter             | Default | Description                                    |
| --------------------- | ------: | ---------------------------------------------- |
| `InpUseBreakEven`     |    true | Enable Break Even                              |
| `InpBreakEvenTrigger` |     150 | Profit distance required to trigger Break Even |
| `InpBreakEvenLock`    |       5 | Profit points locked after Break Even          |

### BUY

When price moves at least **150 points** above the entry price:

```text
New SL = Entry Price + 5 points
```

### SELL

When price moves at least **150 points** below the entry price:

```text
New SL = Entry Price - 5 points
```

---

## Trailing Stop

Trailing Stop management is enabled by default.

| Parameter            | Default | Description                                     |
| -------------------- | ------: | ----------------------------------------------- |
| `InpUseTrailingStop` |    true | Enable Trailing Stop                            |
| `InpTrailingStart`   |     200 | Profit distance required before trailing starts |
| `InpTrailingStep`    |      20 | Minimum improvement required before updating SL |

For BUY positions, once the required profit distance is reached:

```text
New SL = Current Bid - TrailingStart
```

For SELL positions:

```text
New SL = Current Ask + TrailingStart
```

The Stop Loss is only modified when the new level improves the existing Stop Loss by the configured trailing step.

---

## Trade Management Flow

```text
New bar detected
        ↓
Check spread
        ↓
Manage existing positions
(Break Even / Trailing Stop)
        ↓
Check maximum open positions
        ↓
Evaluate Kijun pullback signal
        ↓
No Signal ─────────────→ Wait
        ↓
BUY / SELL Signal
        ↓
Open position
        ↓
Initial SL + TP
```

---

## Default Configuration

```text
Lot Size             = 0.01

Stop Loss            = 300 points
Take Profit          = 600 points

Magic Number         = 123456
Slippage             = 10 points
Maximum Spread       = 30 points
Maximum Positions    = 1

Tenkan-sen            = 9
Kijun-sen             = 26
Senkou Span B         = 52

Break Even            = Enabled
BE Trigger            = 150 points
BE Lock               = 5 points

Trailing Stop         = Enabled
Trailing Start        = 200 points
Trailing Step         = 20 points
```

---

## Files

```text
EA-029_Ichimoku_Kijun_Pullback/
│
├── EA-029_Ichimoku_Kijun_Pullback.mq5
└── README.md
```

### `EA-029_Ichimoku_Kijun_Pullback.mq5`

MQL5 source code containing:

* Ichimoku initialization
* Kijun-sen pullback detection
* BUY / SELL signal generation
* Market order execution
* Stop Loss / Take Profit
* Spread filtering
* Position-count control
* Break Even management
* Trailing Stop management

### `README.md`

Technical documentation describing the implemented strategy and EA parameters.

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
EA Version: 1.00
Indicator: Ichimoku Kinko Hyo
Primary Signal: Kijun-sen Pullback
Order Type: Market execution
Direction: BUY / SELL
```

---

## Important Notes

This repository documents the strategy as implemented in the current source code.

The default parameters are configuration values and should **not** be interpreted as evidence of profitability or as optimized settings.

Performance characteristics such as:

* Net Profit
* Profit Factor
* Maximum Drawdown
* Win Rate
* Expected Payoff
* Number of Trades
* robustness across periods

must be established separately through reproducible backtesting and validation.

No profitability claim is made by this README.

---

## Disclaimer

This Expert Advisor is provided for research, development, and testing purposes.

Algorithmic trading involves financial risk. Historical or backtested performance does not guarantee future results. Users are responsible for validating the EA and its parameters before any live deployment.
