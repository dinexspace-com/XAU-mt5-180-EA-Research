# EA-059 — Bollinger Squeeze

## Overview

**EA-059_Bollinger_Squeeze** is a MetaTrader 5 Expert Advisor implementing a Bollinger Bands volatility squeeze breakout strategy.

The EA attempts to identify periods of low volatility by measuring the width of the Bollinger Bands. When a squeeze is detected, it waits for a confirmed candle close outside the Bollinger Bands before opening a position in the breakout direction.

The strategy includes fixed Stop Loss and Take Profit, spread filtering, Break Even management, Trailing Stop management, and a one-position-per-symbol-and-MagicNumber restriction.

---

## Strategy Logic

### 1. Bollinger Bands

The EA uses the standard MetaTrader 5 Bollinger Bands indicator with the following default parameters:

| Parameter     |    Default |
| ------------- | ---------: |
| BB Period     |         20 |
| BB Deviation  |        2.0 |
| Applied Price |      Close |
| Squeeze Width | 150 points |

The Bollinger Band width is calculated as:

```text
Band Width = (Upper Band - Lower Band) / Point
```

A squeeze condition is considered active when:

```text
Band Width <= InpSqueezeWidthPoints
```

The squeeze test is performed on candle **shift 2**, i.e. the candle immediately preceding the breakout candle.

---

## Entry Rules

Signals are evaluated only once per newly opened candle and use closed candles for breakout confirmation.

### BUY

A BUY signal is generated when:

```text
1. Candle shift 2 satisfies the Bollinger squeeze condition.
2. Close[2] <= UpperBand[2].
3. Close[1] > UpperBand[1].
```

In other words, the previous squeeze candle has not already closed above its upper Bollinger Band, and the latest completed candle closes above its own upper Bollinger Band.

The EA then opens a market BUY order.

### SELL

A SELL signal is generated when:

```text
1. Candle shift 2 satisfies the Bollinger squeeze condition.
2. Close[2] >= LowerBand[2].
3. Close[1] < LowerBand[1].
```

The EA then opens a market SELL order.

---

## Position Management

The EA allows a maximum of **one open position for the current symbol and configured Magic Number**.

Positions belonging to another symbol or Magic Number are ignored.

### Stop Loss

Default:

```text
300 points
```

For BUY:

```text
SL = Ask - StopLoss × Point
```

For SELL:

```text
SL = Bid + StopLoss × Point
```

If the configured Stop Loss is smaller than the broker's minimum stop distance, the EA automatically increases it to the broker-required minimum.

### Take Profit

Default:

```text
600 points
```

For BUY:

```text
TP = Ask + TakeProfit × Point
```

For SELL:

```text
TP = Bid - TakeProfit × Point
```

Broker minimum stop-distance restrictions are also respected.

---

## Break Even

Break Even is enabled by default.

Default configuration:

```text
Use Break Even: true
Trigger: 150 points
Lock: 0 points
```

For a BUY position, once profit reaches the trigger:

```text
New SL = Open Price + Lock Points
```

For a SELL position:

```text
New SL = Open Price - Lock Points
```

With the default `Lock Points = 0`, the intended Break Even level is the position's opening price.

---

## Trailing Stop

Trailing Stop is enabled by default.

Default configuration:

```text
Use Trailing Stop: true
Trailing Start: 200 points
Trailing Distance: 150 points
```

For BUY:

```text
New SL = Current Bid - Trailing Distance
```

For SELL:

```text
New SL = Current Ask + Trailing Distance
```

The EA does not intentionally move an existing Stop Loss backwards.

Broker minimum stop-distance requirements are checked before modifying the position.

---

## Spread Filter

The EA prevents new entries when the current spread exceeds:

```text
30 points
```

Calculated as:

```text
Spread = (Ask - Bid) / Point
```

The spread filter applies to new entries. Existing-position Break Even and Trailing Stop management continues to execute on ticks.

---

## Default Parameters

| Input                    | Default | Description                            |
| ------------------------ | ------: | -------------------------------------- |
| `InpLotSize`             |    0.01 | Fixed trading volume                   |
| `InpStopLoss`            |     300 | Stop Loss in points                    |
| `InpTakeProfit`          |     600 | Take Profit in points                  |
| `InpMagicNumber`         |  123456 | EA position identifier                 |
| `InpSlippage`            |      10 | Allowed deviation in points            |
| `InpBBPeriod`            |      20 | Bollinger Bands period                 |
| `InpBBDeviation`         |     2.0 | Bollinger Bands deviation              |
| `InpSqueezeWidthPoints`  |     150 | Maximum BB width considered a squeeze  |
| `InpMaxSpreadPoints`     |      30 | Maximum spread allowed for entry       |
| `InpUseBreakEven`        |    true | Enable Break Even                      |
| `InpBreakEvenTrigger`    |     150 | Profit required before Break Even      |
| `InpBreakEvenLockPoints` |       0 | Profit points locked at Break Even     |
| `InpUseTrailingStop`     |    true | Enable Trailing Stop                   |
| `InpTrailingStart`       |     200 | Profit required before trailing begins |
| `InpTrailingDistance`    |     150 | Trailing Stop distance                 |

---

## Execution Flow

The main execution sequence is:

```text
OnTick
│
├── Manage existing position
│   ├── Break Even
│   └── Trailing Stop
│
└── New candle?
    │
    ├── Check trading permissions
    ├── Check sufficient price/indicator data
    ├── Check spread
    ├── Check existing position
    │
    └── Detect signal
        │
        ├── Bollinger squeeze on shift 2
        │
        ├── Upper-band breakout → BUY
        │
        └── Lower-band breakout → SELL
```

Entry signals are evaluated once per new candle, while position protection is managed on every tick.

---

## Risk Controls

The current implementation includes:

* Fixed lot sizing
* Fixed Stop Loss
* Fixed Take Profit
* Maximum spread filter
* Break Even
* Trailing Stop
* Broker minimum stop-distance validation
* Broker volume min/max/step normalization
* Trading-permission checks
* One open position per symbol and Magic Number
* Closed-candle breakout confirmation

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
EA Version: 1.00
Primary Indicator: Bollinger Bands
Strategy Type: Volatility Squeeze / Breakout
```

The EA operates on the symbol and timeframe of the chart or Strategy Tester configuration on which it is executed.

---

## Files

```text
EA-059_Bollinger_Squeeze/
├── EA-059_Bollinger_Squeeze.mq5
└── README.md
```

`EA-059_Bollinger_Squeeze.mq5` contains the complete Expert Advisor implementation.

---

## Backtesting

Backtest reports and test artifacts are maintained separately under:

```text
Backtest/
└── EA-059_Bollinger_Squeeze/
```

Performance statistics should be taken from the corresponding MetaTrader 5 Strategy Tester results rather than inferred from the strategy logic.

---

## Disclaimer

This repository is intended for strategy research, development, and backtesting.

Historical or backtested performance does not guarantee future trading results. Trading leveraged instruments such as XAUUSD involves substantial risk. Strategy parameters should be independently validated under the intended broker, symbol specification, spread, execution conditions, and timeframe before any live deployment.
