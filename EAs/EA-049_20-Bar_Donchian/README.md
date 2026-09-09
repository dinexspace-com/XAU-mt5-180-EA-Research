# EA-049 — 20-Bar Donchian Breakout

## Overview

**EA-049 — 20-Bar Donchian Breakout** is a MetaTrader 5 Expert Advisor (EA) implementing a systematic Donchian Channel breakout strategy.

The EA monitors the highest high and lowest low of the previous bars and attempts to enter when price breaks outside the Donchian range.

This EA is part of the **XAUUSD MT5 EA Research** repository, which focuses on implementing and testing systematic trading strategies on XAUUSD using MetaTrader 5.

---

## Strategy

The default Donchian lookback period is:

```text
20 bars
```

The EA calculates:

```text
Upper Donchian = Highest High of previous 20 bars
Lower Donchian = Lowest Low of previous 20 bars
```

The current bar is excluded from the Donchian calculation.

### BUY

A BUY signal occurs when:

```text
Current bar close > Highest High of previous 20 bars
```

The EA then attempts to open a BUY position at the current Ask price.

### SELL

A SELL signal occurs when:

```text
Current bar close < Lowest Low of previous 20 bars
```

The EA then attempts to open a SELL position at the current Bid price.

---

## Execution Logic

The EA evaluates its trading logic only when a **new bar** is detected.

Before opening a new position, it checks:

1. A new bar has started.
2. Current spread does not exceed `InpMaxSpread`.
3. There is no existing position on the same symbol using the EA's Magic Number.
4. A valid Donchian breakout signal exists.

Only one matching position is allowed at a time.

---

## Risk Management

The EA uses fixed-distance Stop Loss and Take Profit levels.

Default parameters:

| Parameter          |    Default | Description                               |
| ------------------ | ---------: | ----------------------------------------- |
| Lot Size           |       0.01 | Fixed trading volume                      |
| Stop Loss          | 300 points | Distance from entry                       |
| Take Profit        | 600 points | Distance from entry                       |
| Break Even Trigger | 150 points | Profit required before moving SL to entry |
| Trailing Start     | 200 points | Profit threshold for trailing logic       |
| Maximum Spread     |  30 points | Maximum permitted spread                  |

All distances are expressed in MetaTrader **points**, not pips or USD.

Actual price distance therefore depends on the symbol specification and broker.

---

## Break Even

Break-even protection is enabled by default.

```text
InpUseBreakEven = true
InpBreakEvenTrigger = 150
```

When unrealized profit reaches at least 150 points, the EA attempts to move the Stop Loss to the original entry price.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailingStop = true
InpTrailingStart = 200
```

Once profit reaches the configured threshold, the EA attempts to move the Stop Loss in the profitable direction.

For BUY positions:

```text
New SL = Current Price - Trailing Start
```

For SELL positions:

```text
New SL = Current Price + Trailing Start
```

The Stop Loss is only modified when the calculated level improves the existing Stop Loss.

---

## Input Parameters

### Trade Settings

```text
InpLotSize       = 0.01
InpMagicNumber   = 123456
InpSlippage      = 10
```

### Donchian Parameters

```text
InpDonchianPeriod = 20
InpMaxSpread      = 30
```

### Risk Management

```text
InpStopLoss   = 300
InpTakeProfit = 600
```

### Break Even & Trailing

```text
InpUseBreakEven     = true
InpBreakEvenTrigger = 150

InpUseTrailingStop  = true
InpTrailingStart    = 200
```

---

## Position Control

The EA identifies its own positions using:

```text
Symbol + Magic Number
```

Default Magic Number:

```text
123456
```

If an existing matching position is detected, the EA will not open another position.

Instead, it executes the position-management logic for Break Even and Trailing Stop.

---

## Intended Research Market

Primary research instrument:

```text
XAUUSD
```

Platform:

```text
MetaTrader 5
```

Language:

```text
MQL5
```

The EA uses `PERIOD_CURRENT`, so the strategy operates on the timeframe of the chart or Strategy Tester configuration on which it is executed.

---

## Source File

```text
EA-049_20-Bar_Donchian.mq5
```

Main components implemented in the source code:

* New-bar detection
* Spread filter
* Donchian Channel calculation
* Long breakout entry
* Short breakout entry
* Fixed Stop Loss
* Fixed Take Profit
* Break Even
* Trailing Stop
* Magic Number position filtering

---

## Research Status

This implementation should be treated as a **research EA**, not as a validated profitable trading system.

Strategy performance must be evaluated through controlled MetaTrader 5 backtests and subsequent robustness testing.

Backtest results for this EA are maintained separately in:

```text
Backtest/EA-049_20-Bar_Donchian/
```

Research findings and conclusions should not be inferred from the source code alone.

---

## Disclaimer

This Expert Advisor is provided for research and educational purposes.

Historical backtest results do not guarantee future performance. Trading XAUUSD and other leveraged financial instruments involves substantial risk.
