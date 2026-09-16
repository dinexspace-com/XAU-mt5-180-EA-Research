# EA-063 — Close Location Break

## Overview

**EA-063_Close_Location_Break** is a MetaTrader 5 Expert Advisor built around a price breakout with a close-location confirmation filter.

The EA detects when the most recently closed candle breaks above or below the price range formed by a configurable number of previous candles. A breakout is accepted only when the candle closes sufficiently close to the breakout-side edge of its own range.

The default configuration uses the **M1 timeframe** and supports both BUY and SELL trades.

---

## Strategy Logic

### Reference Range

The EA builds a reference range from the previous `InpBreakoutLookback` completed candles.

Default:

```text
InpBreakoutLookback = 20
```

The range is defined as:

```text
Upper = highest high of the lookback candles
Lower = lowest low of the lookback candles
```

The breakout candle itself is excluded from this reference range.

---

## BUY Entry

A BUY signal first requires the most recently closed candle to break above the reference range:

```text
Close > Upper + BreakoutBuffer
```

The breakout candle must also close near its own high.

The EA calculates:

```text
(High - Close) / (High - Low)
```

The BUY signal is accepted only when:

```text
(High - Close) / (High - Low) <= InpCloseEdgeFraction
```

Default:

```text
InpCloseEdgeFraction = 0.20
```

Therefore, with the default configuration, the breakout candle must close within the upper 20% of its total High-Low range.

Conceptually:

```text
Previous range
        │
Upper ─────────────────
        │
        │       Breakout candle
        │             ┌──── High
        │             │
        │             │ Close ← must remain near High
        │             │
        │             └──── Low
```

---

## SELL Entry

A SELL signal first requires the most recently closed candle to break below the reference range:

```text
Close < Lower - BreakoutBuffer
```

The breakout candle must also close near its own low.

The EA calculates:

```text
(Close - Low) / (High - Low)
```

The SELL signal is accepted only when:

```text
(Close - Low) / (High - Low) <= InpCloseEdgeFraction
```

With the default value of `0.20`, the candle must close within the lower 20% of its total High-Low range.

---

## Signal Evaluation

Signals are evaluated once per newly detected candle on the configured timeframe.

The EA uses completed candle data for the breakout decision rather than entering from the still-forming signal candle.

When the EA is first attached, it records the current candle and waits for the next candle before evaluating an entry. This prevents an immediate trade from being opened from an old signal.

---

## Position Rules

The EA allows at most one position or pending order using its configured Magic Number across the account.

Default Magic Number:

```text
123063
```

On netting accounts, the EA additionally blocks entry when another position or order already exists on the same symbol, preventing its trade from being merged with another EA's exposure.

---

## Stop Loss and Take Profit

Every market entry is submitted together with its protective Stop Loss and Take Profit.

Default values:

```text
Stop Loss  = 300 points
Take Profit = 600 points
```

For BUY:

```text
SL = Entry Price - StopLoss
TP = Entry Price + TakeProfit
```

For SELL:

```text
SL = Entry Price + StopLoss
TP = Entry Price - TakeProfit
```

Prices are normalized according to the symbol's tick size.

The EA checks the broker's minimum stop-distance requirement before submitting the trade.

If the configured SL or TP violates the broker's allowed stop distance, the entry is skipped.

---

## Break Even

Break-even management is enabled by default.

```text
InpUseBreakEven     = true
InpBreakEvenTrigger = 150
InpBreakEvenOffset  = 0
```

When floating profit reaches the configured trigger, the EA attempts to move the Stop Loss toward:

```text
Entry Price ± BreakEvenOffset
```

With the default offset of `0`, this corresponds to the entry price.

The EA checks broker stop and freeze restrictions before modifying the position.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailingStop   = true
InpTrailingStart     = 200
InpTrailingDistance  = 100
InpTrailingStep      = 10
```

Trailing begins after the trade reaches the configured profit threshold.

The new Stop Loss is positioned approximately:

```text
BUY:
Current Bid - TrailingDistance

SELL:
Current Ask + TrailingDistance
```

A modification is only attempted when the new Stop Loss improves the existing Stop Loss by at least the configured trailing step and satisfies broker stop/freeze constraints.

The EA never intentionally moves an existing Stop Loss backward.

---

## Spread Filter

New entries are blocked when spread exceeds:

```text
InpMaxSpread = 30 points
```

The spread filter applies to entries.

Existing position management, including Break Even and Trailing Stop, continues to run every tick even when the spread is too high for a new entry.

---

## Default Parameters

| Parameter              | Default | Description                                                  |
| ---------------------- | ------: | ------------------------------------------------------------ |
| `InpLotSize`           |    0.01 | Fixed trading volume                                         |
| `InpStopLoss`          |     300 | Stop Loss in points                                          |
| `InpTakeProfit`        |     600 | Take Profit in points                                        |
| `InpMagicNumber`       |  123063 | EA Magic Number                                              |
| `InpSlippage`          |      10 | Maximum deviation in points                                  |
| `InpMaxSpread`         |      30 | Maximum spread allowed for entry                             |
| `InpTimeframe`         |      M1 | Signal timeframe                                             |
| `InpBreakoutLookback`  |      20 | Number of candles forming the breakout range                 |
| `InpBreakoutBuffer`    |       0 | Additional breakout distance in points                       |
| `InpUseBreakEven`      |    true | Enable Break Even                                            |
| `InpBreakEvenTrigger`  |     150 | Profit required before Break Even                            |
| `InpBreakEvenOffset`   |       0 | Offset from entry for Break Even                             |
| `InpUseTrailingStop`   |    true | Enable Trailing Stop                                         |
| `InpTrailingStart`     |     200 | Profit required before trailing begins                       |
| `InpTrailingDistance`  |     100 | Trailing distance                                            |
| `InpTrailingStep`      |      10 | Minimum SL improvement before modification                   |
| `InpCloseEdgeFraction` |    0.20 | Maximum fraction between close and breakout-side candle edge |

---

## Execution Safety

Before opening a trade, the EA checks:

* MT5 terminal connection status
* Terminal trading permission
* MQL trading permission
* Account trading permission
* Expert Advisor trading permission
* Existing positions/orders
* Account margin mode
* Current spread
* Symbol trading mode
* Market-order support
* SL/TP support
* Broker minimum stop distance
* Available free margin
* Symbol lot minimum, maximum and step
* Symbol tick size and price precision

The EA does not silently increase an invalid lot size.

If the configured lot size is incompatible with the symbol's permitted volume range or volume step, initialization fails.

---

## Intended Research Use

This EA is part of the:

```text
xauusd-mt5-ea-research
```

research repository.

Strategy ID:

```text
EA-063
```

Strategy name:

```text
Close Location Break
```

The implementation is intended for systematic testing of the hypothesis that a breakout candle closing near the extreme of its range may provide useful confirmation of breakout strength.

The existence of the rule does not imply that the strategy is profitable.

Profitability, robustness, parameter stability and suitability for XAUUSD must be evaluated separately through the repository's backtest and research process.

---

## Repository Location

```text
xauusd-mt5-ea-research/
│
└── EAs/
    └── EA-063_Close_Location_Break/
        ├── EA-063_Close_Location_Break.mq5
        └── README.md
```

---

## Status

```text
EA source:        Implemented
BUY logic:        Implemented
SELL logic:       Implemented
Stop Loss:        Implemented
Take Profit:      Implemented
Break Even:       Implemented
Trailing Stop:    Implemented
Spread filter:    Implemented
Backtest result:  See /Backtest/EA-063_Close_Location_Break/
Research result:  Not declared in this README
```

Backtest results and conclusions should be maintained separately from the EA source documentation so that the implementation description remains independent from performance results.
