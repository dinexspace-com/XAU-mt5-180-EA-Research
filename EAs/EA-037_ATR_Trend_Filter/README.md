# EA-037 — ATR Trend Filter

## Overview

**EA-037_ATR_Trend_Filter** is a MetaTrader 5 Expert Advisor designed to trade trend changes using an EMA crossover combined with an ATR volatility filter.

The strategy attempts to avoid low-volatility market conditions by allowing entries only when the current ATR is greater than its recent average.

**Platform:** MetaTrader 5
**Language:** MQL5
**Primary research market:** XAUUSD
**Strategy type:** Trend Following / EMA Crossover / Volatility Filter

---

## Strategy Logic

The EA combines:

* Fast EMA
* Slow EMA
* Average True Range (ATR)
* ATR average volatility filter
* Spread filter
* Fixed Stop Loss and Take Profit
* Break Even
* Trailing Stop

The EA evaluates new trading signals once per new candle.

### ATR Volatility Filter

The EA calculates:

* Current ATR using `InpATRPeriod`
* Average ATR over `InpATRAveragePeriod`

A trading signal is considered only when:

```text
Current ATR > Average ATR
```

If the current ATR is less than or equal to the average ATR, no new position is opened.

---

## Entry Rules

### BUY

A BUY signal occurs when:

```text
Fast EMA crosses above Slow EMA
AND
Current ATR > Average ATR
AND
Spread <= Max Spread
AND
No existing position for the same symbol and Magic Number
```

EMA crossover condition:

```text
Previous Fast EMA <= Previous Slow EMA
Current Fast EMA > Current Slow EMA
```

### SELL

A SELL signal occurs when:

```text
Fast EMA crosses below Slow EMA
AND
Current ATR > Average ATR
AND
Spread <= Max Spread
AND
No existing position for the same symbol and Magic Number
```

EMA crossover condition:

```text
Previous Fast EMA >= Previous Slow EMA
Current Fast EMA < Current Slow EMA
```

---

## Default Parameters

| Parameter               |  Default | Description                               |
| ----------------------- | -------: | ----------------------------------------- |
| `InpLotSize`            |     0.01 | Fixed trading lot size                    |
| `InpStopLoss`           |      300 | Stop Loss in points                       |
| `InpTakeProfit`         |      600 | Take Profit in points                     |
| `InpMagicNumber`        | 20240721 | EA Magic Number                           |
| `InpSlippage`           |       10 | Slippage parameter                        |
| `InpMAPeriodFast`       |       20 | Fast EMA period                           |
| `InpMAPeriodSlow`       |       50 | Slow EMA period                           |
| `InpATRPeriod`          |       14 | ATR calculation period                    |
| `InpATRAveragePeriod`   |       50 | Number of ATR values used for average ATR |
| `InpMaxSpread`          |       30 | Maximum allowed spread in points          |
| `InpBreakEvenTrigger`   |      150 | Profit threshold for Break Even           |
| `InpBreakEvenPips`      |        0 | Break Even offset from entry              |
| `InpTrailingStop`       |      200 | Trailing Stop distance in points          |
| `InpEnableBreakEven`    |     true | Enable Break Even                         |
| `InpEnableTrailingStop` |     true | Enable Trailing Stop                      |

---

## Position Management

### Stop Loss / Take Profit

Default configuration:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

This gives a nominal SL/TP distance ratio of:

```text
1 : 2
```

before considering spread, execution conditions, Break Even, and Trailing Stop.

### Break Even

When open profit reaches:

```text
InpBreakEvenTrigger = 150 points
```

the EA attempts to move the Stop Loss to the entry price.

The `InpBreakEvenPips` parameter can be used to place the new Stop Loss above or below the entry price depending on position direction.

### Trailing Stop

Trailing Stop is enabled by default.

When profit reaches the configured trailing threshold, the EA attempts to move the Stop Loss behind the current market price while preventing it from moving backward.

---

## Position Restrictions

The EA allows a maximum of one open position for:

```text
Current Symbol + InpMagicNumber
```

New entries are ignored while such a position already exists.

---

## Spread Filter

Before evaluating a new entry, the EA calculates the current spread:

```text
Spread = (Ask - Bid) / Point
```

Trading is skipped when:

```text
Current Spread > InpMaxSpread
```

Default:

```text
InpMaxSpread = 30 points
```

---

## Execution Timing

Trading logic is evaluated only when a new candle is detected.

Indicator data is taken from closed candles rather than the currently forming candle.

This reduces repeated signal execution during the same bar.

---

## Source File

```text
EA-037_ATR_Trend_Filter.mq5
```

---

## Research Status

This EA is part of the **XAUUSD MT5 EA Research** project.

Current source code represents the strategy implementation to be evaluated.

Backtest results, robustness testing, parameter optimization, and final conclusions are maintained separately from this EA source folder.

No profitability or production-readiness claim should be inferred from the presence of this implementation.

---

## Disclaimer

This Expert Advisor is intended for research, development, and testing purposes.

Historical backtest performance does not guarantee future trading results. Trading XAUUSD and other leveraged financial instruments involves substantial risk.
