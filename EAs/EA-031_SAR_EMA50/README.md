# EA-031 — SAR + EMA50

## Overview

**EA-031_SAR_EMA50** is a MetaTrader 5 Expert Advisor (EA) that combines **Parabolic SAR** with a **50-period Exponential Moving Average (EMA50)** to identify trading opportunities.

The strategy uses:

* **Parabolic SAR** to identify price direction.
* **EMA50** as a trend filter.
* Fixed Stop Loss and Take Profit.
* Spread filtering.
* Maximum position control.
* Break Even protection.
* Trailing Stop management.

The EA evaluates trading signals once per new bar.

---

## Strategy Logic

### Indicators

The EA uses two indicators on the **current chart symbol and timeframe**.

**Parabolic SAR**

```text
Step    = 0.02
Maximum = 0.20
```

**EMA**

```text
Period      = 50
Method      = Exponential Moving Average (EMA)
Applied to  = Close Price
```

---

## Entry Conditions

### BUY

A BUY signal is generated when:

```text
Parabolic SAR < Current Price
AND
Current Price > EMA50
```

In simplified form:

```text
SAR below price
+
Price above EMA50
=
BUY
```

---

### SELL

A SELL signal is generated when:

```text
Parabolic SAR > Current Price
AND
Current Price < EMA50
```

In simplified form:

```text
SAR above price
+
Price below EMA50
=
SELL
```

---

## Signal Execution

The EA checks signals only when a **new bar** appears.

Before opening a position, the EA verifies:

1. At least 60 bars are available.
2. Algorithmic trading is enabled.
3. Trading is allowed for the current symbol.
4. Current spread does not exceed the configured maximum.
5. The number of EA positions has not reached the configured maximum.

Positions are identified using the configured **Magic Number**.

---

## Position Management

### Stop Loss

Default:

```text
300 points
```

For BUY:

```text
SL = Entry Price - 300 points
```

For SELL:

```text
SL = Entry Price + 300 points
```

---

### Take Profit

Default:

```text
600 points
```

For BUY:

```text
TP = Entry Price + 600 points
```

For SELL:

```text
TP = Entry Price - 600 points
```

The default SL/TP relationship is therefore:

```text
Risk : Reward = 1 : 2
```

before considering spread, execution costs, Break Even, and Trailing Stop.

---

## Break Even

Break Even is enabled by default.

Default configuration:

```text
Enable Break Even = true
Trigger           = 150 points
Lock              = 0 points
```

When price moves **150 points in favor of the position**, the EA attempts to move the Stop Loss to the entry price.

With the default lock value:

```text
New SL = Entry Price
```

The `InpBreakEvenLock` parameter can be used to lock additional points beyond the entry price.

---

## Trailing Stop

Trailing Stop is enabled by default.

Default configuration:

```text
Enable Trailing Stop = true
Trailing Start       = 200 points
Trailing Step        = 50 points
```

Trailing Stop starts after the position has moved at least **200 points in profit**.

For BUY positions:

```text
New SL = Current Bid - 50 points
```

For SELL positions:

```text
New SL = Current Ask + 50 points
```

The EA only moves the Stop Loss in the profitable direction and does not intentionally move it backward.

---

## Default Parameters

| Parameter             | Default | Description                            |
| --------------------- | ------: | -------------------------------------- |
| `InpLotSize`          |    0.01 | Fixed trading lot size                 |
| `InpStopLoss`         |     300 | Stop Loss in points                    |
| `InpTakeProfit`       |     600 | Take Profit in points                  |
| `InpMagicNumber`      |  123456 | EA Magic Number                        |
| `InpSlippage`         |      10 | Maximum deviation in points            |
| `InpMaxSpread`        |      30 | Maximum allowed spread in points       |
| `InpMaxPositions`     |       1 | Maximum number of open positions       |
| `InpUseBreakEven`     |    true | Enable Break Even                      |
| `InpBreakEvenTrigger` |     150 | Profit distance before Break Even      |
| `InpBreakEvenLock`    |       0 | Points locked after Break Even         |
| `InpUseTrailingStop`  |    true | Enable Trailing Stop                   |
| `InpTrailingStart`    |     200 | Profit distance before trailing starts |
| `InpTrailingStep`     |      50 | Trailing distance from current price   |

---

## Position Control

By default, the EA allows:

```text
Maximum Open Positions = 1
```

The position counter only includes positions matching:

```text
Current Symbol
+
EA Magic Number
```

Default Magic Number:

```text
123456
```

---

## Spread Filter

The EA will not generate a new trade when:

```text
Current Spread > InpMaxSpread
```

Default:

```text
Maximum Spread = 30 points
```

This value is expressed in **MT5 points**, not directly in USD or pips.

---

## Timeframe

The EA does not hard-code a timeframe.

Both indicators use:

```text
PERIOD_CURRENT
```

Therefore, the strategy runs according to the timeframe of the chart on which the EA is attached.

For example:

```text
M5 chart  → SAR + EMA50 calculated on M5
M15 chart → SAR + EMA50 calculated on M15
H1 chart  → SAR + EMA50 calculated on H1
```

Backtest results should therefore always record the timeframe used.

---

## Symbol

The EA uses:

```text
_Symbol
```

Therefore, the trading symbol is determined by the chart or Strategy Tester configuration.

Although this EA is stored as part of the **XAUUSD MT5 EA Research** project, the source code itself does not hard-code `XAUUSD`.

Broker-specific XAUUSD symbol names, digits, point size, spread, and trading conditions may affect results.

---

## Important Implementation Notes

### Signal Price

The strategy compares SAR and EMA values with the current **Bid price** when evaluating entry conditions.

### Indicator Data

Indicator buffers are requested starting from shift `1`, meaning indicator values are obtained from completed bars rather than directly from the forming bar.

### Fixed Lot Size

The EA currently uses a fixed lot size:

```text
InpLotSize = 0.01
```

There is no percentage-based account risk sizing in this version.

### No Trading Session Filter

The current version does not contain explicit filters for:

* Asian session
* London session
* New York session
* Specific trading hours

### No News Filter

The current version does not contain a news or economic-calendar filter.

---

## Requirements

* MetaTrader 5
* MQL5-compatible broker
* Algo Trading enabled
* Historical data available for the selected symbol/timeframe

---

## File

```text
EA-031_SAR_EMA50.mq5
```

---

## Research Status

This EA is part of an experimental XAUUSD strategy research repository.

The existence of the EA or its source code does **not** indicate that the strategy is profitable or production-ready.

Performance must be evaluated separately through reproducible backtesting and, where appropriate, forward testing.

Backtest evidence should be stored separately under:

```text
Backtest/
└── EA-031_SAR_EMA50/
```

---

## Disclaimer

This project is intended for research, testing, and educational purposes.

Historical or backtested performance does not guarantee future results. Trading leveraged financial instruments involves substantial risk.

Do not use this EA with real capital solely on the basis of the source code or repository documentation.
