# EA-038 — EMA Distance Trend

## Overview

**EA-038_EMA_Distance_Trend** is a MetaTrader 5 Expert Advisor (EA) designed to trade trend continuation based on the distance between a fast and slow Exponential Moving Average (EMA).

Instead of entering solely because the fast EMA is above or below the slow EMA, the EA requires the distance between the two EMAs to exceed a configurable fraction of the Average True Range (ATR).

The ATR-based distance filter is intended to avoid trading when the EMA separation is too small relative to current market volatility.

---

## Strategy Logic

The strategy uses three indicators:

* Fast EMA: **20 periods**
* Slow EMA: **50 periods**
* ATR: **14 periods**

Default minimum EMA distance:

```text
|Fast EMA - Slow EMA| >= ATR × 0.5
```

All periods and the ATR ratio can be changed through the EA input parameters.

---

## Buy Condition

A BUY signal is generated when:

```text
Fast EMA > Slow EMA
```

and:

```text
Fast EMA - Slow EMA >= ATR × ATR Ratio
```

With the default parameters:

```text
EMA20 > EMA50
AND
EMA20 - EMA50 >= ATR(14) × 0.5
```

When both conditions are satisfied and the other trading filters allow entry, the EA opens a BUY position.

---

## Sell Condition

A SELL signal is generated when:

```text
Fast EMA < Slow EMA
```

and:

```text
Slow EMA - Fast EMA >= ATR × ATR Ratio
```

With the default parameters:

```text
EMA20 < EMA50
AND
EMA50 - EMA20 >= ATR(14) × 0.5
```

When both conditions are satisfied and the other trading filters allow entry, the EA opens a SELL position.

---

## Entry Execution

Trading decisions are evaluated only when a **new bar** is detected.

Before opening a position, the EA checks:

1. A new bar has formed.
2. Current spread does not exceed the configured maximum spread.
3. The number of positions opened by this EA on the current symbol is below the configured maximum.
4. EMA and ATR indicator data are available.
5. The EMA distance condition is satisfied.

The EA operates on the **current chart symbol and timeframe**.

---

## Default Parameters

### General Parameters

| Parameter         |    Default | Description                                         |
| ----------------- | ---------: | --------------------------------------------------- |
| Lot Size          |       0.01 | Fixed trading volume                                |
| Stop Loss         | 300 points | Initial stop loss                                   |
| Take Profit       | 600 points | Initial take profit                                 |
| Magic Number      |   24032025 | Identifier for EA positions                         |
| Slippage          |  10 points | Maximum trade deviation                             |
| Maximum Spread    |  30 points | Maximum spread allowed for new entries              |
| Maximum Positions |          1 | Maximum positions for this EA on the current symbol |

### Indicator Parameters

| Parameter       | Default | Description                          |
| --------------- | ------: | ------------------------------------ |
| Fast EMA Period |      20 | Fast EMA calculation period          |
| Slow EMA Period |      50 | Slow EMA calculation period          |
| ATR Period      |      14 | ATR calculation period               |
| ATR Ratio       |     0.5 | Minimum EMA distance relative to ATR |

### Trade Management

| Parameter          |    Default | Description                                 |
| ------------------ | ---------: | ------------------------------------------- |
| Break Even         |    Enabled | Enables break-even management               |
| Break Even Trigger | 150 points | Profit required before break-even activates |
| Break Even Lock    |   0 points | Profit locked when break-even activates     |
| Trailing Stop      |    Enabled | Enables trailing-stop management            |
| Trailing Start     | 200 points | Profit required before trailing starts      |
| Trailing Distance  | 200 points | Distance between price and trailing stop    |

---

## Stop Loss and Take Profit

For BUY positions:

```text
Stop Loss  = Entry Price - StopLoss × Point
Take Profit = Entry Price + TakeProfit × Point
```

For SELL positions:

```text
Stop Loss  = Entry Price + StopLoss × Point
Take Profit = Entry Price - TakeProfit × Point
```

Default configuration:

```text
Stop Loss  = 300 points
Take Profit = 600 points
```

---

## Break-Even Logic

Break-even management is enabled by default.

For a BUY position, when profit reaches the configured trigger:

```text
Current Price - Entry Price >= BreakEvenTrigger
```

the stop loss is moved to:

```text
Entry Price + BreakEvenLock
```

For a SELL position:

```text
Entry Price - Current Price >= BreakEvenTrigger
```

the stop loss is moved to:

```text
Entry Price - BreakEvenLock
```

Default configuration:

```text
Trigger = 150 points
Lock    = 0 points
```

Therefore, under the default settings, the stop loss is moved to approximately the entry price after the position reaches 150 points of profit.

---

## Trailing Stop Logic

Trailing stop management is enabled by default.

Trailing begins after the position reaches:

```text
200 points
```

of profit.

The default trailing distance is:

```text
200 points
```

For BUY positions:

```text
New Stop Loss = Current Bid - Trailing Distance
```

For SELL positions:

```text
New Stop Loss = Current Ask + Trailing Distance
```

The stop loss is only modified when the new level improves the existing stop.

---

## Spread Filter

The EA blocks new trading decisions when:

```text
Current Spread > Maximum Spread
```

Default:

```text
Maximum Spread = 30 points
```

Spread is calculated from the current Ask and Bid prices:

```text
Spread = (Ask - Bid) / Point
```

---

## Position Control

By default, the EA allows a maximum of:

```text
1 position
```

for the current symbol and configured Magic Number.

Positions are identified using:

```text
Magic Number = 24032025
```

The maximum position count can be changed through the input parameters.

---

## Position Sizing

The current version uses **fixed lot sizing**.

Default:

```text
Lot Size = 0.01
```

The requested lot size is automatically adjusted to the broker's:

* Minimum volume
* Maximum volume
* Volume step

The EA currently does not calculate position size from account balance, equity, or percentage risk.

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
File: EA-038_EMA_Distance_Trend.mq5
```

The EA uses the standard MQL5 trade classes:

```text
Trade\Trade.mqh
Trade\PositionInfo.mqh
```

---

## Research Status

This EA is part of the **XAUUSD MT5 EA Research** project.

The source code represents the strategy implementation.

Performance characteristics such as:

* Net Profit
* Profit Factor
* Maximum Drawdown
* Win Rate
* Number of Trades
* Expected Payoff
* Robustness

must be evaluated separately through MetaTrader 5 backtesting and research validation.

No profitability claim should be inferred from the strategy logic alone.

---

## Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-038_EMA_Distance_Trend/
│       ├── EA-038_EMA_Distance_Trend.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-038_EMA_Distance_Trend/
│
├── Research/
│
└── docs/
```

Backtest artifacts and performance evidence for this EA should be stored separately under:

```text
Backtest/EA-038_EMA_Distance_Trend/
```

---

## Disclaimer

This Expert Advisor is provided for research, development, and backtesting purposes.

Trading leveraged financial instruments involves significant risk. Historical or backtested performance does not guarantee future results.
