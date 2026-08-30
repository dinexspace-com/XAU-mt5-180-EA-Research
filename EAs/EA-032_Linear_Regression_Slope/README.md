# EA-032 — Linear Regression Slope

## Overview

**EA-032 Linear Regression Slope** is a MetaTrader 5 Expert Advisor (EA) that uses the slope of a linear regression calculation together with the current price position relative to the regression midpoint to determine trade direction.

The EA evaluates signals once per new bar and allows a maximum of one open position per symbol and Magic Number.

---

## Strategy Logic

The EA calculates a linear regression over a configurable number of closing prices.

Default regression period:

```text
20 bars
```

The regression slope is calculated as:

```text
slope = (N × ΣXY - ΣX × ΣY) / (N × ΣX² - (ΣX)²)
```

The EA also calculates `regMid`, defined in the current implementation as the arithmetic mean of closing prices over the regression period.

### Buy Signal

A BUY signal is generated when:

```text
slope > 0
AND
current price > regMid
```

This represents a positive regression slope with price trading above the calculated midpoint.

### Sell Signal

A SELL signal is generated when:

```text
slope < 0
AND
current price < regMid
```

This represents a negative regression slope with price trading below the calculated midpoint.

---

## Trade Execution

Signals are evaluated only when a **new bar** appears on the current chart timeframe.

Before opening a trade, the EA checks:

* A new bar has formed.
* Current tick data is available.
* Spread does not exceed the configured maximum.
* No position with the same symbol and Magic Number is already open.
* Linear regression can be calculated successfully.

The EA therefore allows a maximum of:

```text
1 open position
```

for the same symbol and Magic Number.

---

## Risk & Position Management

Each trade is opened with a predefined:

* Lot size
* Stop Loss
* Take Profit

The EA also includes optional:

* Break Even
* Trailing Stop
* Maximum spread filter

### Break Even

By default, Break Even is enabled.

For BUY positions, once price moves `InpBreakEvenStart` points above the entry price, Stop Loss is moved above the entry price by `InpBreakEvenShift` points.

For SELL positions, the logic is mirrored below the entry price.

### Trailing Stop

Trailing Stop is enabled by default.

Once the trade reaches the configured trailing activation distance, the Stop Loss is adjusted according to `InpTrailingStep`.

---

## Default Parameters

| Parameter           | Default | Description                                 |
| ------------------- | ------: | ------------------------------------------- |
| `InpLotSize`        |    0.01 | Fixed trading lot size                      |
| `InpStopLoss`       |     300 | Stop Loss in points                         |
| `InpTakeProfit`     |     600 | Take Profit in points                       |
| `InpMagicNumber`    |  123456 | EA Magic Number                             |
| `InpSlippage`       |      10 | Maximum deviation in points                 |
| `InpUseBreakEven`   |    true | Enable Break Even                           |
| `InpBreakEvenStart` |     150 | Profit distance before Break Even activates |
| `InpBreakEvenShift` |      10 | Stop Loss offset beyond entry               |
| `InpUseTrailing`    |    true | Enable Trailing Stop                        |
| `InpTrailingStart`  |     200 | Profit distance before trailing activates   |
| `InpTrailingStep`   |      50 | Trailing Stop distance                      |
| `InpMaxSpread`      |      30 | Maximum allowed spread in points            |
| `InpRegPeriod`      |      20 | Linear regression calculation period        |
| `InpSensibility`    |       2 | Slope sensitivity parameter                 |

> Note: `InpSensibility` is declared as an input parameter in the current source code but is not currently used in the signal calculation.

---

## Trading Environment

**Platform:** MetaTrader 5
**Language:** MQL5
**Strategy Type:** Trend / Linear Regression
**Signal Frequency:** Once per new bar
**Position Limit:** One position per symbol and Magic Number

The EA uses `PERIOD_CURRENT`, meaning calculations are performed using the timeframe of the chart on which the EA is running.

---

## Source File

```text
EA-032_Linear_Regression_Slope.mq5
```

Repository structure:

```text
EAs/
└── EA-032_Linear_Regression_Slope/
    ├── EA-032_Linear_Regression_Slope.mq5
    └── README.md
```

---

## Important Implementation Notes

The current source code should be considered the authoritative reference for the strategy implementation.

In particular:

1. `regMid` is calculated as the average closing price of the regression period rather than directly from the calculated regression line.

2. `InpSensibility` exists as an input but is not currently applied to BUY or SELL signal generation.

3. Break Even and Trailing Stop management functions are called from the new-bar execution path, so position-management checks occur when the EA processes a new bar rather than continuously on every incoming tick.

These implementation details should be considered when interpreting future backtest results.

---

## Backtesting

Backtest results are maintained separately from the EA source code:

```text
Backtest/
└── EA-032_Linear_Regression_Slope/
```

Backtest performance should be evaluated independently before drawing conclusions about profitability or robustness.

---

## Disclaimer

This Expert Advisor is provided for research, testing, and educational purposes.

Historical or backtest performance does not guarantee future trading results. Trading leveraged financial instruments involves significant risk.
