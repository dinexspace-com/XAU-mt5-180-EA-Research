# EA-022 — Supertrend Direction

## Overview

**EA-022_Supertrend_Direction** is a MetaTrader 5 Expert Advisor (EA) that trades based on changes in the direction of the **Supertrend** indicator.

The EA uses **ATR (Average True Range)** and a configurable Supertrend multiplier to determine trend direction.

The strategy is designed to:

* Open a **BUY** position when Supertrend changes from bearish to bullish.
* Open a **SELL** position when Supertrend changes from bullish to bearish.
* Use fixed Stop Loss and Take Profit levels.
* Support Break Even and Trailing Stop management.
* Limit trading based on spread and the maximum number of open positions.
* Evaluate new entry signals only once per completed candle.

---

## Strategy Logic

### Supertrend Calculation

The Supertrend calculation uses:

* ATR Period: `10`
* Multiplier: `3.0`

Default parameters:

```text
ATR Period = 10
Multiplier = 3.0
```

The basic Supertrend bands are calculated from the midpoint of each candle and ATR:

```text
Basic Upper Band = (High + Low) / 2 + Multiplier × ATR

Basic Lower Band = (High + Low) / 2 - Multiplier × ATR
```

The EA then maintains adjusted upper and lower bands and determines the current trend direction from price relative to those bands.

The calculation uses up to **500 historical bars**.

---

## Entry Conditions

Entry signals are evaluated on a **new candle** and use completed candle data.

### BUY

A BUY signal is generated when:

```text
Previous Supertrend Direction = Bearish
Current Supertrend Direction  = Bullish
Previous Candle Close > Supertrend Lower Band
```

In simplified form:

```text
Bearish → Bullish = BUY
```

### SELL

A SELL signal is generated when:

```text
Previous Supertrend Direction = Bullish
Current Supertrend Direction  = Bearish
Previous Candle Close < Supertrend Upper Band
```

In simplified form:

```text
Bullish → Bearish = SELL
```

---

## Position Management

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

---

### Take Profit

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

The default nominal SL/TP distance ratio is therefore:

```text
300 : 600
1 : 2
```

This is the configured price-distance ratio and does not represent expected or tested strategy performance.

---

## Break Even

Break Even is enabled by default.

```text
Break Even = Enabled
Trigger    = 150 points
```

When an open position reaches at least `150 points` of favorable price movement, the EA can move the Stop Loss to the original entry price.

For BUY:

```text
Bid - Entry Price >= 150 points
→ SL moves to Entry Price
```

For SELL:

```text
Entry Price - Ask >= 150 points
→ SL moves to Entry Price
```

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
Trailing Start    = 200 points
Trailing Distance = 200 points
Trailing Step     = 10 points
```

Trailing begins after the position reaches at least `200 points` of favorable price movement.

For BUY:

```text
Trailing SL = Bid - 200 points
```

For SELL:

```text
Trailing SL = Ask + 200 points
```

The Stop Loss is updated only when the new trailing level improves the existing Stop Loss by the configured trailing step.

---

## Risk & Execution Controls

### Fixed Lot Size

Default:

```text
0.01 lot
```

The current version uses a **fixed lot size**.

It does not calculate position size automatically from account balance, equity, or percentage risk.

---

### Maximum Spread

Default:

```text
30 points
```

The EA will not open a new position when:

```text
Current Spread > 30 points
```

Spread filtering applies to new entries.

Open-position management continues to run on every tick.

---

### Maximum Positions

Default:

```text
1 position
```

The EA counts positions matching both:

* Current symbol
* EA Magic Number

If the number of matching positions reaches `InpMaxPositions`, no additional position is opened.

---

### Magic Number

Default:

```text
123456
```

The Magic Number is used to identify positions belonging to this EA.

---

### Slippage / Deviation

Default:

```text
10 points
```

This value is passed to the MT5 trade execution system as the allowed deviation in points.

---

## Default Parameters

| Parameter             | Default | Description                                           |
| --------------------- | ------: | ----------------------------------------------------- |
| `InpLotSize`          |    0.01 | Fixed lot size                                        |
| `InpStopLoss`         |     300 | Stop Loss in points                                   |
| `InpTakeProfit`       |     600 | Take Profit in points                                 |
| `InpMagicNumber`      |  123456 | EA Magic Number                                       |
| `InpSlippage`         |      10 | Allowed deviation in points                           |
| `InpMaxSpread`        |      30 | Maximum spread allowed for entry                      |
| `InpMaxPositions`     |       1 | Maximum positions for current symbol and Magic Number |
| `InpAtrPeriod`        |      10 | ATR period used by Supertrend                         |
| `InpMultiplier`       |     3.0 | Supertrend ATR multiplier                             |
| `InpUseBreakEven`     |    true | Enable Break Even                                     |
| `InpBreakEvenTrigger` |     150 | Break Even trigger in points                          |
| `InpUseTrailingStop`  |    true | Enable Trailing Stop                                  |
| `InpTrailingStart`    |     200 | Profit distance before trailing starts                |
| `InpTrailingDistance` |     200 | Trailing Stop distance                                |
| `InpTrailingStep`     |      10 | Minimum improvement before trailing update            |

---

## Trading Flow

```text
New Tick
   │
   ├── Manage existing positions
   │     ├── Break Even
   │     └── Trailing Stop
   │
   └── New candle?
         │
         ├── No → Stop
         │
         └── Yes
               │
               ├── Check Spread
               │
               ├── Check Maximum Positions
               │
               └── Calculate Supertrend
                     │
                     ├── Bearish → Bullish
                     │        └── BUY
                     │
                     ├── Bullish → Bearish
                     │        └── SELL
                     │
                     └── No direction change
                              └── No Trade
```

---

## Timeframe

The EA uses:

```text
PERIOD_CURRENT
```

Therefore, the strategy operates on the timeframe of the chart to which the EA is attached.

For example:

```text
M5 chart  → M5 signals
M15 chart → M15 signals
H1 chart  → H1 signals
```

The EA does not force a specific timeframe internally.

---

## Symbol

The EA uses:

```text
_Symbol
```

Therefore, it trades the symbol of the chart on which it is running.

The code itself does not restrict execution specifically to XAUUSD.

---

## Files

```text
EA-022_Supertrend_Direction/
│
├── EA-022_Supertrend_Direction.mq5
└── README.md
```

### `EA-022_Supertrend_Direction.mq5`

Main MQL5 source code containing:

* Supertrend calculation
* BUY/SELL signal generation
* Trade execution
* Spread filtering
* Position limiting
* Stop Loss / Take Profit
* Break Even
* Trailing Stop

### `README.md`

Technical documentation describing the strategy and the behavior implemented in the current EA source code.

---

## Current Version

```text
Version: 1.00
Platform: MetaTrader 5
Language: MQL5
Strategy: Supertrend Direction Change
```

---

## Important Notes

This EA is a research implementation.

The current source code does **not** establish that the strategy is profitable or suitable for live trading.

Performance characteristics such as:

* Profit Factor
* Win Rate
* Maximum Drawdown
* Expected Payoff
* Sharpe Ratio
* Recovery Factor
* robustness across market periods

must be established separately through reproducible backtesting and validation.

Backtest results should therefore be stored separately from this strategy documentation.

---

## Disclaimer

This project is intended for **research, development, and educational purposes**.

Historical or backtested performance does not guarantee future results. Trading leveraged financial instruments involves significant risk.

Do not use the EA on a live trading account without independent testing, validation, and appropriate risk assessment.
