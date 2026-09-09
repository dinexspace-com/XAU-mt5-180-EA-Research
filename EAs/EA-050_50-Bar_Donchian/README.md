# EA-050 — 50-Bar Donchian Breakout

## Overview

**EA-050_50-Bar_Donchian** is an MT5 Expert Advisor implementing a Donchian Channel breakout strategy.

The EA identifies breakouts above or below the highest/lowest price of the previous 50 bars and opens a position in the breakout direction.

This EA is part of the **XAUUSD MT5 EA Research** project.

---

## Strategy

The default Donchian lookback period is:

```text
50 bars
```

The EA calculates:

```text
Upper Donchian = Highest High of previous 50 bars
Lower Donchian = Lowest Low of previous 50 bars
```

The current bar is excluded from the Donchian calculation.

### BUY

A BUY signal occurs when:

```text
Current Close > Highest High of previous 50 bars
```

The EA opens a BUY position at the current Ask price.

### SELL

A SELL signal occurs when:

```text
Current Close < Lowest Low of previous 50 bars
```

The EA opens a SELL position at the current Bid price.

---

## Execution Logic

The EA evaluates trading logic only when a **new bar** is detected.

Before looking for a new entry, it checks:

1. A new bar has formed.
2. Current spread does not exceed the configured maximum.
3. No position with the same symbol and Magic Number is already open.

If an existing EA position is found, no new trade is opened.

The EA instead processes its Break Even and Trailing Stop logic.

---

## Default Parameters

### Trade Settings

| Parameter        | Default | Description                 |
| ---------------- | ------: | --------------------------- |
| `InpLotSize`     |    0.01 | Fixed trading lot size      |
| `InpMagicNumber` |  123456 | EA Magic Number             |
| `InpSlippage`    |      10 | Maximum deviation in points |

### Donchian Parameters

| Parameter           | Default | Description                      |
| ------------------- | ------: | -------------------------------- |
| `InpDonchianPeriod` |      50 | Donchian lookback period         |
| `InpMaxSpread`      |      30 | Maximum allowed spread in points |

### Risk Management

| Parameter       | Default | Description           |
| --------------- | ------: | --------------------- |
| `InpStopLoss`   |     300 | Stop Loss in points   |
| `InpTakeProfit` |     600 | Take Profit in points |

### Break Even & Trailing

| Parameter             | Default | Description                                      |
| --------------------- | ------: | ------------------------------------------------ |
| `InpUseBreakEven`     |    true | Enable Break Even                                |
| `InpBreakEvenTrigger` |     150 | Profit in points required to activate Break Even |
| `InpUseTrailingStop`  |    true | Enable Trailing Stop                             |
| `InpTrailingStart`    |     200 | Profit threshold / trailing distance in points   |

---

## Risk Management

### Initial Stop Loss

For BUY:

```text
SL = Entry Price - 300 points
```

For SELL:

```text
SL = Entry Price + 300 points
```

### Initial Take Profit

For BUY:

```text
TP = Entry Price + 600 points
```

For SELL:

```text
TP = Entry Price - 600 points
```

The values above are the default settings and can be changed through EA inputs.

---

## Break Even

Break Even is enabled by default.

When the position reaches:

```text
+150 points
```

the EA attempts to move the Stop Loss to the original entry price.

BUY:

```text
SL → Entry Price
```

SELL:

```text
SL → Entry Price
```

---

## Trailing Stop

Trailing Stop is enabled by default.

It becomes active when the position reaches at least:

```text
+200 points
```

For BUY:

```text
New SL = Current Price - 200 points
```

For SELL:

```text
New SL = Current Price + 200 points
```

The Stop Loss is only modified when the new level improves the existing Stop Loss.

---

## Position Control

The EA counts positions matching both:

```text
Symbol = current chart symbol
Magic Number = InpMagicNumber
```

If at least one matching position already exists, the EA does not open another position.

Therefore, the current implementation is designed to maintain a maximum of one matching EA position at a time for the current symbol and Magic Number.

---

## Spread Filter

Before processing trading logic, the EA calculates:

```text
Spread = (Ask - Bid) / Point
```

Trading logic is skipped when:

```text
Spread > InpMaxSpread
```

Default:

```text
Maximum Spread = 30 points
```

---

## Input Validation

During initialization, the EA rejects invalid configurations when:

```text
Donchian Period < 2
Lot Size <= 0
Stop Loss <= 0
Take Profit <= 0
```

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
EA Version: 1.10
```

The EA uses the standard MQL5:

```text
Trade\Trade.mqh
CTrade
```

for trade execution and position modification.

---

## Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-050_50-Bar_Donchian/
│       ├── EA-050_50-Bar_Donchian.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-050_50-Bar_Donchian/
│
├── Research/
│
└── docs/
```

---

## Research Status

```text
EA implementation: COMPLETE
Baseline backtest: PENDING / UNDER REVIEW
Parameter optimization: PENDING / UNDER REVIEW
Robustness testing: PENDING
Final research conclusion: PENDING
```

Backtest results and optimization results are intentionally kept outside this README and stored under:

```text
Backtest/EA-050_50-Bar_Donchian/
```

---

## Research Objective

The purpose of this EA is to test whether a simple 50-bar Donchian breakout structure can provide a statistically useful trading edge under controlled MT5 backtesting and subsequent robustness testing.

No profitability or robustness claim should be made from the strategy logic alone.

Research conclusions must be based on recorded backtest and validation evidence.
