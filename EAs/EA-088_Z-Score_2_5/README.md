# EA-088_Z-Score_2_5

## Overview

**EA-088_Z-Score_2_5** is an MT5 Expert Advisor designed for XAUUSD using a Z-Score based mean-reversion signal.

The EA evaluates the Z-Score of closed candles and opens a market position when the Z-Score moves back through a configured threshold, subject to candle direction and execution filters.

This version uses:

* Z-Score period: `20`
* Z-Score threshold: `2.5`
* Timeframe: `M1`
* Fixed lot size: `0.01`
* Stop Loss: `300`
* Take Profit: `600`
* Break Even: enabled
* Trailing Stop: enabled

---

## Strategy Logic

The EA calculates a Z-Score from closing prices over `InpZPeriod`.

The calculation uses:

* Population standard deviation
* Welford accumulation
* Closed candles
* Current evaluated candle included in the Z-Score calculation

The primary signal uses the two most recent closed candles:

```text
recent = Z-Score of shift 1
older  = Z-Score of shift 2
```

### Buy Signal

A Buy signal is generated when:

```text
older < -InpZThreshold
recent >= -InpZThreshold
bars[1].close > bars[1].open
```

With the default configuration:

```text
older < -2.5
recent >= -2.5
previous closed candle is bullish
```

### Sell Signal

A Sell signal is generated when:

```text
older > InpZThreshold
recent <= InpZThreshold
bars[1].close < bars[1].open
```

With the default configuration:

```text
older > 2.5
recent <= 2.5
previous closed candle is bearish
```

The signal is evaluated once per new bar.

---

## Entry Execution

Before opening a trade, the EA checks:

* Terminal connection
* Trading permission
* Expert trading permission
* Account trading permission
* Existing positions/orders
* Maximum spread
* Symbol trading mode
* Market-order support
* Stop Loss support
* Take Profit support
* Broker stop-distance requirements
* Available margin
* Valid lot size
* Symbol filling mode

The configured Stop Loss and Take Profit are submitted together with the market order.

---

## Position Restriction

The EA is designed to prevent multiple simultaneous positions/orders for the same Magic Number.

On netting accounts, the EA also prevents entry when the symbol already has exposure from another position/order.

Default Magic Number:

```text
123088
```

---

## Stop Loss and Take Profit

Default configuration:

```text
Stop Loss  = 300
Take Profit = 600
```

The EA rounds protective prices according to the symbol tick size and price precision.

Broker stop-level restrictions are checked before entry.

---

## Break Even

Break Even is enabled by default.

```text
InpUseBreakEven      = true
InpBreakEvenTrigger  = 150
InpBreakEvenOffset   = 0
```

Once the configured profit trigger is reached, the EA attempts to move the Stop Loss toward the entry price while respecting broker stop and freeze restrictions.

The EA only improves the existing Stop Loss.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailingStop   = true
InpTrailingStart     = 200
InpTrailingDistance  = 100
InpTrailingStep      = 10
```

The trailing mechanism:

1. Activates after the configured profit threshold.
2. Calculates a new Stop Loss from the current market price.
3. Respects broker stop and freeze levels.
4. Only moves the Stop Loss in the direction of reducing risk.
5. Requires the configured trailing step before modifying an existing Stop Loss.

Position management runs on every tick.

---

## Parameters

| Parameter             |  Default | Description                                          |
| --------------------- | -------: | ---------------------------------------------------- |
| `InpLotSize`          |   `0.01` | Fixed trading volume                                 |
| `InpStopLoss`         |    `300` | Stop Loss distance                                   |
| `InpTakeProfit`       |    `600` | Take Profit distance                                 |
| `InpMagicNumber`      | `123088` | EA identifier                                        |
| `InpSlippage`         |     `10` | Allowed deviation                                    |
| `InpMaxSpread`        |     `30` | Maximum spread                                       |
| `InpTimeframe`        |     `M1` | Signal timeframe                                     |
| `InpBreakoutBuffer`   |      `0` | Declared input; not used in the current signal logic |
| `InpUseBreakEven`     |   `true` | Enable Break Even                                    |
| `InpBreakEvenTrigger` |    `150` | Break Even activation                                |
| `InpBreakEvenOffset`  |      `0` | Break Even offset                                    |
| `InpUseTrailingStop`  |   `true` | Enable trailing                                      |
| `InpTrailingStart`    |    `200` | Trailing activation                                  |
| `InpTrailingDistance` |    `100` | Trailing distance                                    |
| `InpTrailingStep`     |     `10` | Minimum trailing movement                            |
| `InpZPeriod`          |     `20` | Z-Score calculation period                           |
| `InpZThreshold`       |    `2.5` | Z-Score signal threshold                             |

---

## Important Implementation Notes

The current source contains helper functions and an indicator handle declaration that are not used by the active signal calculation:

```text
indicator_handle
ReadIndicator()
ReadValue()
```

The current signal implementation directly calculates the Z-Score from price data.

`InpBreakoutBuffer` is declared and validated but is not applied to the active Buy/Sell signal conditions.

The variable `before` is calculated inside `GetSignal()` but is not currently used in the final Buy/Sell conditions.

These details should be preserved when documenting this exact source version.

---

## Version

```text
Version: 1.00
EA: EA-088_Z-Score_2_5
Magic Number: 123088
```

---

## Research Status

This EA should be treated as a research/backtest version.

The attached Strategy Tester report provides a baseline historical test for the configuration documented in the `Backtest/` directory.

The backtest result should not be interpreted as evidence of live-trading profitability or robustness.

Further optimization, out-of-sample testing and forward testing should be documented separately.
