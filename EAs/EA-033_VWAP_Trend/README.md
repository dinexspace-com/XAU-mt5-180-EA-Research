# EA-033 — VWAP Trend

## Overview

**EA-033_VWAP_Trend** is a MetaTrader 5 Expert Advisor based on a rolling **Volume Weighted Average Price (VWAP)** trend-following strategy.

The EA uses the relationship between the current market price and VWAP together with the direction of the VWAP slope to identify BUY and SELL opportunities.

The strategy is designed to participate in directional market movement while using fixed Stop Loss / Take Profit and optional Break Even and Trailing Stop management.

---

## Strategy Logic

The EA calculates VWAP using a rolling window of historical bars.

Typical Price:

```text
Typical Price = (High + Low + Close) / 3
```

VWAP:

```text
VWAP = Σ(Typical Price × Tick Volume) / Σ(Tick Volume)
```

Default VWAP period:

```text
20 bars
```

The implementation uses MetaTrader 5 **tick volume** from `MqlRates`.

---

## Entry Conditions

### BUY

A BUY signal is generated when:

```text
Ask > Current VWAP
AND
Current VWAP > Previous VWAP
```

Interpretation:

* Price is trading above VWAP.
* VWAP is rising.
* The EA interprets this as bullish trend conditions.

### SELL

A SELL signal is generated when:

```text
Bid < Current VWAP
AND
Current VWAP < Previous VWAP
```

Interpretation:

* Price is trading below VWAP.
* VWAP is falling.
* The EA interprets this as bearish trend conditions.

---

## Signal Frequency

Entry logic is evaluated only when the EA detects a **new bar** on the current chart timeframe.

```text
iTime(_Symbol, PERIOD_CURRENT, 0)
```

The EA therefore does not evaluate new entry signals on every incoming tick.

The VWAP calculation timeframe can be configured separately through `InpVWAPTimeframe`.

---

## Trade Filters

Before opening a new position, the EA checks:

### Spread Filter

A trade is rejected when:

```text
Current Spread > InpMaxSpread
```

Default:

```text
30 points
```

### Maximum Positions

The EA limits the number of positions associated with its Magic Number.

Default:

```text
1 position
```

The position count is based on:

```text
POSITION_MAGIC == InpMagicNumber
```

---

## Risk & Order Settings

| Parameter         | Default | Description                                        |
| ----------------- | ------: | -------------------------------------------------- |
| `InpLotSize`      |    0.01 | Fixed trade size                                   |
| `InpStopLoss`     |     300 | Stop Loss in points                                |
| `InpTakeProfit`   |     600 | Take Profit in points                              |
| `InpMagicNumber`  |  202411 | EA Magic Number                                    |
| `InpSlippage`     |      10 | Maximum deviation in points                        |
| `InpMaxSpread`    |      30 | Maximum allowed spread                             |
| `InpMaxPositions` |       1 | Maximum positions associated with the Magic Number |

With the default settings, the initial nominal SL/TP distance ratio is:

```text
SL = 300 points
TP = 600 points

TP / SL = 2.0
```

This describes only the configured price distances and does not represent expected strategy profitability.

---

## VWAP Settings

| Parameter          |        Default | Description                         |
| ------------------ | -------------: | ----------------------------------- |
| `InpVWAPPeriod`    |             20 | Rolling VWAP calculation period     |
| `InpVWAPTimeframe` | PERIOD_CURRENT | Timeframe used for VWAP calculation |

The VWAP implementation is calculated internally by the EA and does not require an external indicator.

---

## Break Even

Break Even is enabled by default.

| Parameter             | Default | Description                             |
| --------------------- | ------: | --------------------------------------- |
| `InpUseBreakEven`     |    true | Enable Break Even                       |
| `InpBreakEvenTrigger` |     150 | Profit required before activation       |
| `InpBreakEvenLock`    |       0 | Distance from entry used for the new SL |

With default settings:

```text
Profit >= 150 points
→ Stop Loss moves to entry price
```

For BUY positions:

```text
New SL = Open Price + BreakEvenLock
```

For SELL positions:

```text
New SL = Open Price - BreakEvenLock
```

---

## Trailing Stop

Trailing Stop is enabled by default.

| Parameter          | Default | Description                            |
| ------------------ | ------: | -------------------------------------- |
| `InpUseTrailing`   |    true | Enable Trailing Stop                   |
| `InpTrailingStart` |     200 | Profit required before trailing starts |
| `InpTrailingStep`  |      50 | SL distance from current price         |

For BUY positions, after the trailing threshold is reached:

```text
New SL = Current Price - TrailingStep
```

For SELL positions:

```text
New SL = Current Price + TrailingStep
```

The EA only modifies the Stop Loss when the new level improves the existing Stop Loss.

---

## Position Management

The EA manages positions matching both:

```text
POSITION_MAGIC == InpMagicNumber
AND
POSITION_SYMBOL == _Symbol
```

Position management includes:

* Break Even
* Trailing Stop

No additional indicator-based exit condition is implemented in the current version.

Positions are primarily exited through:

* Stop Loss
* Take Profit
* Break Even-adjusted Stop Loss
* Trailing Stop

---

## Default Configuration

```text
Lot Size              = 0.01
Stop Loss             = 300 points
Take Profit           = 600 points

Magic Number          = 202411
Slippage              = 10 points
Maximum Spread        = 30 points
Maximum Positions     = 1

VWAP Period           = 20
VWAP Timeframe        = Current

Break Even            = Enabled
Break Even Trigger    = 150 points
Break Even Lock       = 0 points

Trailing Stop         = Enabled
Trailing Start        = 200 points
Trailing Step         = 50 points
```

---

## Implementation Notes

### Volume Source

VWAP uses:

```text
tick_volume
```

rather than exchange-reported centralized volume.

### Price Source

VWAP uses Typical Price:

```text
(High + Low + Close) / 3
```

### Position Size

The current implementation uses a fixed lot size.

There is no percentage-of-equity or percentage-of-balance risk calculation in this version.

### Trading Session

There is currently no explicit:

* Trading-hours filter
* London session filter
* New York session filter
* Asian session filter
* Day-of-week filter

### News Filter

No economic-news filter is implemented.

---

## Files

```text
EA-033_VWAP_Trend/
├── EA-033_VWAP_Trend.mq5
└── README.md
```

`EA-033_VWAP_Trend.mq5` contains the complete Expert Advisor source code.

`README.md` documents the implemented strategy logic and default configuration.

---

## Research Status

The source code defines the strategy implementation, but source code alone does not establish trading performance.

Metrics such as:

* Net Profit
* Profit Factor
* Maximum Drawdown
* Win Rate
* Expected Payoff
* Recovery Factor
* Number of Trades
* Robustness across periods

must be established separately through reproducible backtesting and validation.

Backtest evidence for this EA should be stored under:

```text
Backtest/
└── EA-033_VWAP_Trend/
```

---

## Disclaimer

This repository is intended for quantitative strategy research, software development, and backtesting.

Historical or backtested performance does not guarantee future results. Trading leveraged financial instruments involves substantial risk.
