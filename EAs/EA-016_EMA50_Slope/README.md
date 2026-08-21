# EA-016 — EMA50 Slope

## Overview

EA-016_EMA50_Slope is a MetaTrader 5 Expert Advisor based on the direction of the EMA50 and the position of the latest closed candle relative to the EMA.

The EA checks signals once per new candle and allows a maximum of one open position for the current symbol and Magic Number.

This repository is intended for research and backtesting purposes.

---

## Strategy Logic

### BUY

A BUY signal is generated when:

1. EMA50 is rising.
2. The latest closed candle closes above EMA50.
3. Spread is within the configured maximum limit.
4. There is no existing position using the same symbol and Magic Number.

With the default setting:

```text
InpMinTrendBars = 1
```

the EMA slope condition is:

```text
EMA[1] > EMA[2]
```

and the complete BUY condition is:

```text
EMA[1] > EMA[2]
AND
Close[1] > EMA[1]
```

### SELL

A SELL signal is generated when:

1. EMA50 is falling.
2. The latest closed candle closes below EMA50.
3. Spread is within the configured maximum limit.
4. There is no existing position using the same symbol and Magic Number.

With the default setting:

```text
InpMinTrendBars = 1
```

the EMA slope condition is:

```text
EMA[1] < EMA[2]
```

and the complete SELL condition is:

```text
EMA[1] < EMA[2]
AND
Close[1] < EMA[1]
```

---

## Signal Timing

Signals are evaluated only when a new candle appears.

The EA uses completed candles for signal generation:

```text
Close[1]
EMA[1]
EMA[2]
```

This prevents repeated entries from being generated multiple times during the same candle.

---

## Default Parameters

### General Parameters

| Parameter | Default | Description |
|---|---:|---|
| `InpLotSize` | 0.01 | Fixed trade volume |
| `InpStopLoss` | 300 points | Initial Stop Loss |
| `InpTakeProfit` | 600 points | Initial Take Profit |
| `InpMagicNumber` | 123456 | EA Magic Number |
| `InpSlippage` | 10 points | Maximum trade deviation |
| `InpMaxSpread` | 30 points | Maximum allowed spread |

### Signal Parameters

| Parameter | Default | Description |
|---|---:|---|
| `InpEMAPeriod` | 50 | EMA period |
| `InpMinTrendBars` | 1 | Number of consecutive EMA slope bars required |
| `InpDebugMode` | false | Enables signal/debug logging |

### Risk Management

| Parameter | Default | Description |
|---|---:|---|
| `InpUseBreakEven` | true | Enables Break Even |
| `InpBreakEvenTrigger` | 150 points | Profit required before moving SL to entry |
| `InpUseTrailing` | true | Enables Trailing Stop |
| `InpTrailingTrigger` | 200 points | Profit required before Trailing Stop becomes active |
| `InpTrailingStep` | 50 points | Minimum SL improvement before another modification |

---

## Position Management

### Maximum Open Positions

The EA allows a maximum of:

```text
1 position
```

for the current:

```text
Symbol + Magic Number
```

A new entry will not be opened while an existing EA position is active.

---

## Break Even

When enabled, the EA moves the Stop Loss to the entry price after the position reaches the configured profit threshold.

Default:

```text
Break Even Trigger = 150 points
```

---

## Trailing Stop

When enabled, Trailing Stop management begins after the position reaches:

```text
200 points
```

of unrealized profit by default.

The Stop Loss is only modified when the new level improves the existing Stop Loss by at least:

```text
50 points
```

---

## Spread Filter

Before opening a new trade, the EA calculates:

```text
Spread = (Ask - Bid) / Point
```

A signal is rejected when:

```text
Spread > InpMaxSpread
```

Default maximum spread:

```text
30 points
```

---

## Current Research Configuration

The core strategy under investigation is:

```text
Indicator: EMA
Period: 50

BUY:
EMA slope > 0
Close above EMA50

SELL:
EMA slope < 0
Close below EMA50
```

The current source code includes additional execution and position-management components:

```text
Fixed Stop Loss
Fixed Take Profit
Spread Filter
Break Even
Trailing Stop
Single-position restriction
```

These components should be evaluated independently during backtesting where appropriate.

---

## Source File

```text
EA-016_EMA50_Slope.mq5
```

Platform:

```text
MetaTrader 5
MQL5
```

---

## Known Source Metadata Issue

The current source code contains legacy references to:

```text
EMA20
```

inside the EA description and trade comments.

The actual signal parameter in the current implementation is:

```text
InpEMAPeriod = 50
```

Therefore, the implemented strategy is currently treated as **EMA50 Slope** for research purposes.

The legacy EMA20 labels should not be interpreted as part of the strategy logic.

---

## Backtesting

Backtest results are stored separately under:

```text
Backtest/
└── EA-016_EMA50_Slope/
```

Backtest results should be used to evaluate:

- Profitability
- Drawdown
- Trade frequency
- BUY/SELL behavior
- Spread sensitivity
- Stop Loss / Take Profit behavior
- Break Even impact
- Trailing Stop impact
- Robustness across testing periods

No profitability claim should be made based solely on the strategy logic.

---

## Status

```text
Strategy implementation: Available
Source review: Available
Backtest evidence: Pending / stored separately
Optimization: Not assumed
Live-trading validation: Not assumed
```

---

## Disclaimer

This Expert Advisor is provided for research, testing, and educational purposes.

Historical backtest performance does not guarantee future trading results.

Trading leveraged financial instruments involves substantial risk.
