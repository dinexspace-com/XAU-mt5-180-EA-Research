# EA-065 — Retest Breakout

## Overview

**EA-065_Retest_Breakout** is an MT5 Expert Advisor implementing a breakout-and-retest trading strategy.

The EA first detects a breakout from a recent price range. It does **not** enter immediately after the breakout. Instead, it waits for price to retest the broken level and confirms that price has rejected that level before opening a market position.

The current implementation uses only price data and does not depend on external indicators.

---

## Strategy Logic

### 1. Define the breakout range

The EA calculates the highest high and lowest low over the previous:

```text
InpBreakoutLookback = 20
```

completed candles.

Default timeframe:

```text
PERIOD_M1
```

The EA uses completed candles only when evaluating a signal.

---

## 2. Detect breakout

### Bullish breakout

A bullish breakout is detected when the previous completed candle closes above:

```text
Range High + Breakout Buffer
```

### Bearish breakout

A bearish breakout is detected when the previous completed candle closes below:

```text
Range Low - Breakout Buffer
```

Default breakout buffer:

```text
InpBreakoutBuffer = 0 points
```

After detecting the breakout, the EA stores the broken range boundary as the retest level.

No trade is opened at this stage.

---

## 3. Wait for retest

After a breakout, the EA waits for price to revisit the breakout level.

Default tolerance:

```text
InpRetestTolerance = 20 points
```

Maximum waiting period:

```text
InpRetestMaxBars = 10 bars
```

If the setup becomes too old, it is discarded.

---

## 4. Setup invalidation

A breakout setup is invalidated if price closes back inside the old range.

For a bullish breakout:

```text
Close <= breakout level
```

For a bearish breakout:

```text
Close >= breakout level
```

When this happens, the stored breakout setup is reset and no trade is opened.

---

## 5. Retest confirmation

### BUY confirmation

A BUY signal requires:

1. A bullish breakout has already occurred.
2. Price retests the breakout level within `InpRetestTolerance`.
3. The confirmation candle closes above the breakout level plus the configured breakout buffer.
4. The confirmation candle is bullish:

```text
Close > Open
```

The EA then opens a BUY market order.

### SELL confirmation

A SELL signal requires:

1. A bearish breakout has already occurred.
2. Price retests the breakout level within `InpRetestTolerance`.
3. The confirmation candle closes below the breakout level minus the configured breakout buffer.
4. The confirmation candle is bearish:

```text
Close < Open
```

The EA then opens a SELL market order.

---

# Default Parameters

## Execution

| Parameter             | Default | Description                                            |
| --------------------- | ------: | ------------------------------------------------------ |
| `InpLotSize`          |    0.01 | Fixed trade volume                                     |
| `InpStopLoss`         |     300 | Stop Loss in points                                    |
| `InpTakeProfit`       |     600 | Take Profit in points                                  |
| `InpMagicNumber`      |  123065 | EA Magic Number                                        |
| `InpSlippage`         |      10 | Maximum deviation in points                            |
| `InpMaxSpread`        |      30 | Maximum spread allowed for new entries                 |
| `InpTimeframe`        |      M1 | Signal timeframe                                       |
| `InpBreakoutLookback` |      20 | Number of candles used to define breakout range        |
| `InpBreakoutBuffer`   |       0 | Additional distance required for breakout confirmation |
| `InpRetestTolerance`  |      20 | Distance around breakout level accepted as a retest    |
| `InpRetestMaxBars`    |      10 | Maximum bars allowed to wait for retest                |

---

# Stop Loss and Take Profit

Every new position is submitted with protective SL and TP in the same market-order request.

Default configuration:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

The EA checks the broker's minimum stop-distance requirements before submitting an order.

If the configured SL or TP is invalid for the symbol, the trade is skipped.

---

# Break-Even

Break-even management is enabled by default.

```text
InpUseBreakEven      = true
InpBreakEvenTrigger  = 150
InpBreakEvenOffset   = 0
```

When floating profit reaches:

```text
150 points
```

the EA attempts to move Stop Loss to the entry price.

With the default offset of `0`, the target break-even level is the original entry price.

Broker stop and freeze-level restrictions are checked before the SL is modified.

---

# Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailingStop    = true
InpTrailingStart      = 200
InpTrailingDistance   = 100
InpTrailingStep       = 10
```

Trailing begins after the position reaches:

```text
200 points profit
```

The EA then attempts to maintain the Stop Loss approximately:

```text
100 points
```

behind current price.

The Stop Loss is only updated when the improvement is at least:

```text
10 points
```

and broker trading restrictions allow the modification.

---

# Position Control

The EA prevents duplicate exposure.

For the configured Magic Number, it allows at most one active position or pending order across the account.

On **netting accounts**, the EA additionally avoids opening a trade if another position or order already exists on the same symbol.

This prevents the EA from unintentionally merging its exposure with another strategy on a netting account.

---

# Spread Filter

Before opening a new trade, the EA checks:

```text
Spread <= InpMaxSpread
```

Default:

```text
InpMaxSpread = 30 points
```

If spread exceeds this value, the entry is skipped.

Break-even and trailing-stop management continue running even when the spread is too high for a new entry.

---

# Execution Safety Checks

Before sending an order, the EA verifies:

* terminal connectivity;
* automated trading permission;
* account trading permission;
* Expert Advisor trading permission;
* symbol trading mode;
* market-order availability;
* SL/TP support;
* broker stop-distance requirements;
* available account margin;
* valid lot size;
* symbol minimum/maximum volume;
* symbol volume step;
* existing EA exposure.

The EA does not automatically increase an invalid lot size.

---

# Signal Evaluation

Signals are evaluated once per newly completed candle on:

```text
InpTimeframe
```

The EA initializes from the next candle after being attached to a chart to avoid entering from an old historical signal.

Position protection management runs on every tick.

---

# Intended Research Market

Repository target:

```text
XAUUSD
```

The source code itself is not hard-coded to `XAUUSD` and uses the MT5 chart symbol through:

```text
_Symbol
```

Therefore, results depend on the symbol, broker specifications, spread, digits, execution conditions, and selected parameter set.

---

# Source File

```text
EA-065_Retest_Breakout.mq5
```

EA version:

```text
1.00
```

MT5 trade library:

```cpp
#include <Trade\Trade.mqh>
```

---

# Files

```text
EA-065_Retest_Breakout/
├── EA-065_Retest_Breakout.mq5
└── README.md
```

---

# Backtesting

Backtest results are intentionally kept outside the EA source directory.

Related test artifacts should be stored under:

```text
Backtest/EA-065_Retest_Breakout/
```

No profitability, drawdown, robustness, or live-performance claim is made in this README until supported by corresponding backtest or validation evidence.

---

# Research Status

```text
EA ID:       EA-065
Strategy:    Retest Breakout
Platform:    MetaTrader 5
Language:    MQL5
Target:      XAUUSD research
Status:      Source implementation available
Validation:  See Backtest/EA-065_Retest_Breakout/
```
