# EA-087_Z-Score_2

## Overview

`EA-087_Z-Score_2` is an MT5 Expert Advisor for XAUUSD that uses a Z-Score based mean-reversion signal.

The EA evaluates the Z-Score of the closed candles and opens a position when the Z-Score reaches an extreme level and subsequently shows a reversal condition.

The implementation is designed for MT5 and uses `CTrade` for market execution and position management.

---

## Strategy Logic

The EA calculates a Z-Score using the closing prices of the configured timeframe.

Default parameters:

* Z-Score period: `20`
* Z-Score threshold: `2.0`
* Timeframe: `M1`

The signal is evaluated using closed candles.

### Buy signal

A buy signal is generated when:

1. The previous closed candle has a Z-Score below `-InpZThreshold`.
2. The latest closed candle has a higher Z-Score than the previous candle.
3. The previous Z-Score is at or below the Z-Score of the candle before it.

### Sell signal

A sell signal is generated when:

1. The previous closed candle has a Z-Score above `InpZThreshold`.
2. The latest closed candle has a lower Z-Score than the previous candle.
3. The previous Z-Score is at or above the Z-Score of the candle before it.

The EA therefore does not simply trade whenever the threshold is crossed. It requires an extreme Z-Score condition followed by a reversal in the Z-Score sequence.

---

## Entry Execution

The EA uses market orders.

Default execution parameters:

| Parameter       | Default |
| --------------- | ------: |
| Lot size        |    0.01 |
| Stop Loss       |     300 |
| Take Profit     |     600 |
| Magic Number    |  123087 |
| Slippage        |      10 |
| Maximum Spread  |      30 |
| Timeframe       |      M1 |
| Breakout Buffer |       0 |

The configured Stop Loss and Take Profit are submitted together with the market order.

The EA checks:

* Trading permissions
* Symbol trading mode
* Maximum spread
* Broker stop-distance requirements
* Available margin
* Valid lot size
* Order execution capability

---

## Position Management

### Break Even

Break-even management is enabled by default.

| Parameter | Default |
| --------- | ------: |
| Enabled   |  `true` |
| Trigger   |     150 |
| Offset    |       0 |

When the configured profit trigger is reached, the EA attempts to move the Stop Loss to the entry price plus the configured offset.

### Trailing Stop

Trailing Stop is enabled by default.

| Parameter | Default |
| --------- | ------: |
| Enabled   |  `true` |
| Start     |     200 |
| Distance  |     100 |
| Step      |      10 |

The trailing stop is updated only when the new Stop Loss improves the existing Stop Loss by at least the configured step.

Broker stop and freeze levels are also respected.

---

## Position Restrictions

The EA prevents additional entries when an existing position or order is associated with the EA's Magic Number.

On netting accounts, the EA also prevents entry when there is exposure on the current symbol.

The intended behaviour is to maintain a single active exposure for this strategy rather than continuously stacking positions.

---

## Risk and Execution Controls

The EA contains several execution safeguards:

* Maximum spread filter
* Margin availability check
* Valid lot-size check
* Broker stop-level validation
* Freeze-level validation
* Symbol trading-mode validation
* Trading-permission validation
* Tick-size price rounding
* Synchronous trade execution
* Magic Number identification

Protective position management is executed on every tick while entry signals are evaluated once per new configured timeframe bar.

---

## Parameters

### Execution

```text
InpLotSize       = 0.01
InpStopLoss      = 300
InpTakeProfit    = 600
InpMagicNumber   = 123087
InpSlippage      = 10
InpMaxSpread     = 30
InpTimeframe     = PERIOD_M1
InpBreakoutBuffer = 0
```

### Break Even

```text
InpUseBreakEven      = true
InpBreakEvenTrigger  = 150
InpBreakEvenOffset   = 0
```

### Trailing Stop

```text
InpUseTrailingStop   = true
InpTrailingStart     = 200
InpTrailingDistance  = 100
InpTrailingStep      = 10
```

### Z-Score

```text
InpZPeriod           = 20
InpZThreshold        = 2.0
```

---

## Version

Current version:

```text
1.00
```

Magic Number:

```text
123087
```

---

## Research Status

This EA is part of the `xauusd-mt5-ea-research` project.

The current implementation and its backtest results should be treated as a research baseline. Parameter optimization, robustness testing, out-of-sample testing and further validation are separate research stages and are not implied by this README.
