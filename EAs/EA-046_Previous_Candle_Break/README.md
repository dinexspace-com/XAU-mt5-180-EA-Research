# EA-046 — Previous Candle Break

## Overview

**EA-046 Previous Candle Break** is a MetaTrader 5 Expert Advisor based on a simple previous-candle breakout concept.

The EA looks for price breaking beyond the **High or Low of the previous candle** and opens a position in the breakout direction.

The strategy includes fixed Stop Loss and Take Profit, spread protection, Break Even, and Trailing Stop management.

---

## Strategy Logic

### BUY

A BUY signal is generated when:

```text
Current Close > Previous Candle High
```

The EA opens a market BUY position using the current Ask price.

### SELL

A SELL signal is generated when:

```text
Current Close < Previous Candle Low
```

The EA opens a market SELL position using the current Bid price.

### No Trade

No new position is opened when:

```text
Previous Low <= Current Close <= Previous High
```

---

## Timeframe

The EA uses:

```text
PERIOD_CURRENT
```

Therefore, the strategy operates on the timeframe of the chart to which the EA is attached.

For example:

* M5 chart → M5 signals
* M15 chart → M15 signals
* H1 chart → H1 signals

The EA does not hard-code a specific timeframe.

---

## New Bar Processing

Trading logic is evaluated only when the EA detects a new bar.

The EA compares the current bar time with the previously stored bar time before continuing with its trading logic.

This prevents the main signal logic from being repeatedly executed on every incoming tick.

---

## Position Rules

The EA allows a maximum of:

```text
1 open position
```

per:

```text
Symbol + Magic Number
```

Before opening a new trade, the EA checks whether an existing position with the same symbol and Magic Number is already open.

---

## Default Parameters

| Parameter           | Default | Description                                  |
| ------------------- | ------: | -------------------------------------------- |
| `InpLotSize`        |    0.01 | Fixed trading volume                         |
| `InpStopLoss`       |     300 | Stop Loss in points                          |
| `InpTakeProfit`     |     600 | Take Profit in points                        |
| `InpMagicNumber`    |  123456 | EA Magic Number                              |
| `InpSlippage`       |      10 | Maximum deviation in points                  |
| `InpMaxSpread`      |      30 | Maximum allowed spread in points             |
| `InpUseBreakEven`   |    true | Enable Break Even                            |
| `InpBreakEvenStart` |     150 | Break Even activation threshold in points    |
| `InpUseTrailing`    |    true | Enable Trailing Stop                         |
| `InpTrailingStart`  |     200 | Trailing Stop activation threshold in points |
| `InpTrailingStep`   |      50 | Minimum trailing adjustment step in points   |

---

## Stop Loss & Take Profit

### BUY

```text
Stop Loss   = Entry Price - 300 points
Take Profit = Entry Price + 600 points
```

using the default settings.

### SELL

```text
Stop Loss   = Entry Price + 300 points
Take Profit = Entry Price - 600 points
```

using the default settings.

The default nominal SL/TP relationship is therefore:

```text
300 : 600
```

or:

```text
1 : 2
```

before considering spread, slippage, execution differences, Break Even, or Trailing Stop.

---

## Spread Filter

Before processing a trade, the EA calculates the current spread:

```text
Spread = (Ask - Bid) / Point
```

Trading is blocked when:

```text
Current Spread > InpMaxSpread
```

Default maximum:

```text
30 points
```

---

## Break Even

Break Even is enabled by default.

Default activation:

```text
150 points
```

When a position reaches the required favorable price movement, the EA attempts to move the Stop Loss to the original entry price.

For BUY:

```text
Current Price - Open Price >= 150 points
```

For SELL:

```text
Open Price - Current Price >= 150 points
```

New Stop Loss:

```text
SL = Open Price
```

---

## Trailing Stop

Trailing Stop is enabled by default.

Default settings:

```text
Trailing Start = 200 points
Trailing Step  = 50 points
```

Trailing management begins after price has moved at least 200 points in the profitable direction.

For BUY positions, the EA calculates:

```text
New SL = Current Bid - 200 points
```

For SELL positions:

```text
New SL = Current Ask + 200 points
```

The Stop Loss is only modified when the new level improves the existing Stop Loss by the required trailing step.

---

## Risk Management

The current version uses:

```text
Fixed Lot Size
```

Default:

```text
0.01 lot
```

The EA does **not** currently implement automatic position sizing based on:

* account balance,
* account equity,
* percentage risk,
* Stop Loss monetary risk.

Therefore, lot size must be selected manually.

---

## Current Filters

Implemented:

* Maximum spread filter
* One-position-per-symbol-and-Magic-Number restriction
* New-bar processing

Not implemented in the current version:

* News filter
* Trading session filter
* Trend filter
* Volatility filter
* Daily loss limit
* Maximum drawdown protection
* Risk-per-trade position sizing

---

## Execution

The EA uses the standard MQL5:

```text
CTrade
```

class for trade execution and position modification.

Order filling mode is selected according to the traded symbol using:

```text
SetTypeFillingBySymbol()
```

---

## Source File

```text
EA-046_Previous_Candle_Break.mq5
```

Expected repository structure:

```text
EAs/
└── EA-046_Previous_Candle_Break/
    ├── EA-046_Previous_Candle_Break.mq5
    └── README.md
```

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
EA Version: 1.00
Strategy Type: Previous Candle Breakout
Position Sizing: Fixed Lot
```

---

## Research Status

This EA represents an implementation of the **Previous Candle Break** strategy concept.

Strategy profitability should not be inferred from the source code alone.

Backtest results, test conditions, datasets, and performance metrics should be stored separately under:

```text
Backtest/EA-046_Previous_Candle_Break/
```

---

## Disclaimer

This Expert Advisor is provided for research, development, and testing purposes.

Historical or backtested performance does not guarantee future trading results. Trading leveraged financial instruments involves significant risk.
