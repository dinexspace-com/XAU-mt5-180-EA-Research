# EA-042 — Three-Bar Continuation

## Overview

**EA-042 Three-Bar Continuation** is a MetaTrader 5 Expert Advisor (EA) that trades a simple three-bar price continuation pattern.

The EA evaluates the closing prices of the three most recently completed candles and opens a position when three consecutive closes move in the same direction.

The current implementation includes fixed Stop Loss and Take Profit, spread filtering, position limits, Break Even, and Trailing Stop management.

---

## Platform

* Platform: MetaTrader 5
* Language: MQL5
* EA Type: Trend / Momentum Continuation
* Signal Type: Three-Bar Closing Price Pattern
* Signal Evaluation: New bar only
* Timeframe: Current chart timeframe
* Symbol: Current chart symbol

---

## Trading Logic

The EA evaluates the three most recently completed candles:

* `Bar 1` — most recent completed candle
* `Bar 2` — previous completed candle
* `Bar 3` — oldest candle in the three-bar pattern

The currently forming candle (`Bar 0`) is not used for signal generation.

### BUY Signal

A BUY signal is generated when:

```text
Close[1] > Close[2] > Close[3]
```

This means the three completed candles have consecutively higher closing prices.

When the condition is satisfied, the EA attempts to open a BUY position at the current Ask price.

### SELL Signal

A SELL signal is generated when:

```text
Close[1] < Close[2] < Close[3]
```

This means the three completed candles have consecutively lower closing prices.

When the condition is satisfied, the EA attempts to open a SELL position at the current Bid price.

---

## Entry Frequency

Trading signals are evaluated only when a new candle begins.

The EA does not repeatedly evaluate and enter trades on every tick of the same candle.

Before opening a new position, the EA also checks:

1. Current spread.
2. Number of existing positions for the current symbol and Magic Number.
3. Three-bar continuation signal.

---

## Default Parameters

### Trade Settings

| Parameter        |  Default | Description                       |
| ---------------- | -------: | --------------------------------- |
| `InpLotSize`     |     0.01 | Fixed trading lot size            |
| `InpStopLoss`    |      300 | Stop Loss in points               |
| `InpTakeProfit`  |      600 | Take Profit in points             |
| `InpMagicNumber` | 20240001 | EA Magic Number                   |
| `InpSlippage`    |       10 | Maximum order deviation in points |

### Risk Filters

| Parameter         | Default | Description                      |
| ----------------- | ------: | -------------------------------- |
| `InpMaxSpread`    |      30 | Maximum allowed spread in points |
| `InpMaxPositions` |       1 | Maximum concurrent positions     |

### Trade Management

| Parameter           | Default | Description                                              |
| ------------------- | ------: | -------------------------------------------------------- |
| `InpUseBreakEven`   |    true | Enable Break Even                                        |
| `InpBreakEvenStart` |     150 | Profit distance in points before Break Even              |
| `InpUseTrailing`    |    true | Enable Trailing Stop                                     |
| `InpTrailingStart`  |     200 | Profit distance in points before Trailing Stop activates |
| `InpTrailingStep`   |      50 | Trailing Stop distance in points                         |

---

## Stop Loss and Take Profit

### BUY

For BUY positions:

```text
Stop Loss  = Entry Price - 300 points
Take Profit = Entry Price + 600 points
```

using the default settings.

### SELL

For SELL positions:

```text
Stop Loss  = Entry Price + 300 points
Take Profit = Entry Price - 600 points
```

using the default settings.

All distances are expressed in MetaTrader **points**, not pips or absolute price values.

---

## Spread Filter

Before generating a new trade, the EA checks the current symbol spread.

A trade is allowed only when:

```text
Current Spread <= InpMaxSpread
```

Default:

```text
InpMaxSpread = 30 points
```

If the spread exceeds this threshold, no new trade is opened on that bar.

---

## Position Limit

The EA counts positions matching both:

* Current chart symbol
* EA Magic Number

By default:

```text
InpMaxPositions = 1
```

Therefore, the EA will not open another position while one matching position is already active.

---

## Break Even

Break Even is enabled by default.

### BUY

When price reaches:

```text
Open Price + 150 points
```

the Stop Loss is moved to the original entry price.

### SELL

When price reaches:

```text
Open Price - 150 points
```

the Stop Loss is moved to the original entry price.

Default:

```text
InpUseBreakEven   = true
InpBreakEvenStart = 150
```

---

## Trailing Stop

Trailing Stop is enabled by default.

It activates after the position reaches a predefined profit distance.

Default:

```text
InpUseTrailing   = true
InpTrailingStart = 200 points
InpTrailingStep  = 50 points
```

### BUY

After price moves at least 200 points above the entry price:

```text
New SL = Current Bid - 50 points
```

The Stop Loss is only moved upward.

### SELL

After price moves at least 200 points below the entry price:

```text
New SL = Current Ask + 50 points
```

The Stop Loss is only moved downward.

---

## Execution Flow

The current EA follows this sequence:

```text
New Tick
   ↓
New Bar?
   ↓
Check Spread
   ↓
Check Existing Position Count
   ↓
Read Close[1], Close[2], Close[3]
   ↓
Higher Closes → BUY
Lower Closes  → SELL
   ↓
Set SL / TP
   ↓
Manage Break Even
   ↓
Manage Trailing Stop
```

---

## File

```text
EA-042_Three-Bar_Continuation.mq5
```

Main MQL5 source code for the Expert Advisor.

---

## Current Research Status

This EA should currently be treated as a **research and backtesting implementation**, not as a validated production trading system.

The trading logic, parameters, robustness, profitability, and suitability for XAUUSD must be evaluated through controlled backtesting and subsequent validation before any production use.

Backtest results should be stored separately under:

```text
Backtest/
└── EA-042_Three-Bar_Continuation/
```

---

## Disclaimer

This repository is intended for quantitative research, strategy development, and educational purposes.

Historical or backtested performance does not guarantee future trading results. The EA should not be considered production-ready until its behavior and risk characteristics have been independently validated.
