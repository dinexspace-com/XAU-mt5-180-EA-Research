# EA-015 — EMA20 Slope

## Overview

**EA-015_EMA20_Slope** is a MetaTrader 5 Expert Advisor designed to test a simple EMA20 slope-based trend-following strategy on **XAUUSD M1**.

The strategy evaluates the direction of the 20-period Exponential Moving Average (EMA20) using closed candles and combines the EMA direction with the previous candle's closing price relative to EMA20.

The EA includes fixed Stop Loss and Take Profit together with Break Even, Trailing Stop, spread filtering, and a one-position limit.

---

## Strategy

### BUY

A BUY signal is generated when:

1. EMA20 is rising.
2. The previous closed candle closes above EMA20.

With the default setting:

`InpMinTrendBars = 1`

the EMA condition is:

`EMA20[1] > EMA20[2]`

and the price condition is:

`Close[1] > EMA20[1]`

Therefore:

`BUY = EMA20[1] > EMA20[2] AND Close[1] > EMA20[1]`

---

### SELL

A SELL signal is generated when:

1. EMA20 is falling.
2. The previous closed candle closes below EMA20.

With the default setting:

`EMA20[1] < EMA20[2]`

and:

`Close[1] < EMA20[1]`

Therefore:

`SELL = EMA20[1] < EMA20[2] AND Close[1] < EMA20[1]`

---

## Signal Timing

Trading signals are calculated from **closed candles**.

The EA checks for a new entry only when a new bar appears. This prevents multiple entry attempts during the same candle.

Default research setup:

* Symbol: **XAUUSD**
* Timeframe: **M1**
* EMA Period: **20**
* Minimum EMA trend bars: **1**

---

## Default Parameters

| Parameter          |    Default | Description                                |
| ------------------ | ---------: | ------------------------------------------ |
| Lot Size           |       0.01 | Fixed trading volume                       |
| Stop Loss          | 300 points | Initial Stop Loss                          |
| Take Profit        | 600 points | Initial Take Profit                        |
| Magic Number       |     123456 | Identifier for EA positions                |
| Slippage           |  10 points | Maximum order deviation                    |
| Maximum Spread     |  30 points | No new trade above this spread             |
| EMA Period         |         20 | EMA period used for signals                |
| Minimum Trend Bars |          1 | Consecutive EMA rise/fall requirement      |
| Break Even         |    Enabled | Enables Break Even management              |
| Break Even Trigger | 150 points | Profit required before moving SL to entry  |
| Trailing Stop      |    Enabled | Enables Trailing Stop                      |
| Trailing Trigger   | 200 points | Profit threshold for trailing logic        |
| Trailing Step      |  50 points | Minimum SL improvement before modification |
| Debug Mode         |   Disabled | Enables detailed signal logging            |

---

## Position Management

### Stop Loss

Every new position is opened with:

`SL = 300 points`

### Take Profit

Every new position is opened with:

`TP = 600 points`

### Break Even

When the position reaches at least:

`+150 points`

the EA can move the Stop Loss to the position's opening price.

### Trailing Stop

Trailing management becomes active when profit reaches:

`+200 points`

The EA only updates the Stop Loss when the proposed Stop Loss improves the existing Stop Loss by at least:

`50 points`

---

## Trading Filters

### Spread Filter

The EA does not open a new trade when:

`Spread > 30 points`

### Maximum Open Positions

The EA allows a maximum of:

`1 open position`

for the current symbol using the EA's Magic Number.

---

## Execution Flow

On every tick, the EA:

1. Checks whether terminal, account, and Expert Advisor trading are allowed.
2. Manages existing positions using Break Even and Trailing Stop.
3. Waits for a new candle before evaluating a new entry.
4. Checks the current spread.
5. Checks whether an EA position is already open.
6. Reads EMA20 values from closed candles.
7. Evaluates EMA20 direction.
8. Compares the previous candle close with EMA20.
9. Opens BUY or SELL when all corresponding conditions are satisfied.

---

## Purpose

This EA is part of the **XAUUSD MT5 EA Research** project.

Its purpose is to evaluate whether a minimal EMA20 slope signal on XAUUSD M1 has measurable trading value under a standardized trade-management configuration.

Backtest results and conclusions should be stored separately from the EA source code so that the strategy implementation and experimental evidence remain clearly separated.

---

## Files

`EA-015_EMA20_Slope.mq5`
MetaTrader 5 source code for the strategy.

`README.md`
Strategy definition and implementation documentation.

---

## Status

**Implementation:** Completed

**Backtest:** See the corresponding `Backtest/EA-015_EMA20_Slope/` directory.

**Research conclusion:** Not defined in this README. Conclusions should only be made after reviewing backtest evidence.
