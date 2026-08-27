# EA-028 — Ichimoku Cloud

## Overview

**EA-028_Ichimoku_Cloud** is a MetaTrader 5 Expert Advisor (EA) implementing a trend-following strategy based on the **Ichimoku Kinko Hyo** indicator.

The EA identifies bullish and bearish market conditions using:

* Price position relative to the Ichimoku Cloud (Kumo)
* Tenkan-sen relative to Kijun-sen

The strategy includes fixed Stop Loss and Take Profit together with optional Break Even and Trailing Stop management.

---

## Strategy Logic

The EA evaluates trading conditions once per newly formed bar on the current chart timeframe.

The Ichimoku indicator uses the standard default periods:

| Component     | Default Period |
| ------------- | -------------: |
| Tenkan-sen    |              9 |
| Kijun-sen     |             26 |
| Senkou Span B |             52 |

The cloud boundaries are defined as:

```text
Cloud Top    = max(Senkou Span A, Senkou Span B)
Cloud Bottom = min(Senkou Span A, Senkou Span B)
```

The current price used for signal evaluation is the midpoint between Bid and Ask:

```text
Current Price = (Ask + Bid) / 2
```

---

## Entry Conditions

### BUY

A BUY signal is generated when:

```text
Current Price > Cloud Top
AND
Tenkan-sen > Kijun-sen
```

This represents a bullish condition where price is trading above the Ichimoku Cloud and the faster Tenkan-sen is above the slower Kijun-sen.

### SELL

A SELL signal is generated when:

```text
Current Price < Cloud Bottom
AND
Tenkan-sen < Kijun-sen
```

This represents a bearish condition where price is trading below the Ichimoku Cloud and the Tenkan-sen is below the Kijun-sen.

### No Trade

No new position is opened when:

* Price is inside the Ichimoku Cloud.
* Price/Cloud direction and Tenkan/Kijun relationship do not agree.
* Spread exceeds the configured maximum.
* An existing position using the same Magic Number is already open.
* Required market or Ichimoku data cannot be obtained.

> **Important:** The current implementation checks the relative position of Tenkan-sen and Kijun-sen. It does not require a new Tenkan/Kijun crossover event to occur on the signal bar.

---

## Position Management

### Stop Loss

Every new trade is opened with a fixed Stop Loss.

Default:

```text
300 points
```

For BUY:

```text
SL = Bid - 300 points
```

For SELL:

```text
SL = Ask + 300 points
```

---

### Take Profit

Every new trade is opened with a fixed Take Profit.

Default:

```text
600 points
```

For BUY:

```text
TP = Bid + 600 points
```

For SELL:

```text
TP = Ask - 600 points
```

With the default SL and TP settings, the nominal distance ratio is:

```text
SL : TP = 300 : 600 = 1 : 2
```

This is a distance ratio only and does not account for spread, slippage, commission, or execution effects.

---

## Break Even

Break Even management is enabled by default.

Default settings:

| Parameter        |      Value |
| ---------------- | ---------: |
| Use Break Even   |       true |
| Trigger          | 150 points |
| Break Even Level |   0 points |

For a BUY position, when Bid reaches:

```text
Open Price + 150 points
```

the Stop Loss can be moved to:

```text
Open Price + Break Even Level
```

With the default Break Even Level of `0`, this corresponds to the original entry price.

For a SELL position, the equivalent logic is applied in the opposite direction.

---

## Trailing Stop

Trailing Stop management is enabled by default.

Default settings:

| Parameter         |      Value |
| ----------------- | ---------: |
| Use Trailing Stop |       true |
| Trailing Start    | 200 points |
| Trailing Step     |  50 points |

For BUY positions, trailing management starts after Bid reaches at least:

```text
Open Price + 200 points
```

The candidate Stop Loss becomes:

```text
Bid - 200 points
```

The EA only modifies the Stop Loss when the new trailing level improves sufficiently relative to the existing Stop Loss according to the configured `Trailing Step`.

SELL positions use the inverse logic.

---

## Spread Filter

Before evaluating a new trading opportunity, the EA checks the current spread.

Default maximum spread:

```text
30 points
```

The spread is calculated as:

```text
(Ask - Bid) / Point
```

If:

```text
Spread > Maximum Spread
```

the EA does not process a new entry on that bar.

---

## Position Limit

The EA prevents a new trade when at least one open position with the configured Magic Number already exists.

Default Magic Number:

```text
123456
```

Therefore, under normal use with a unique Magic Number, the strategy operates with a maximum of one active EA position at a time.

---

## Inputs

| Input                 | Default | Description                                |
| --------------------- | ------: | ------------------------------------------ |
| `InpLotSize`          |    0.01 | Fixed trading volume                       |
| `InpStopLoss`         |     300 | Stop Loss in points                        |
| `InpTakeProfit`       |     600 | Take Profit in points                      |
| `InpMagicNumber`      |  123456 | Identifier for EA positions                |
| `InpSlippage`         |      10 | Maximum execution deviation in points      |
| `InpMaxSpread`        |      30 | Maximum allowed spread in points           |
| `InpTenkanSen`        |       9 | Tenkan-sen period                          |
| `InpKijunSen`         |      26 | Kijun-sen period                           |
| `InpSenkouSpanB`      |      52 | Senkou Span B period                       |
| `InpUseBreakEven`     |    true | Enable/disable Break Even                  |
| `InpBreakEvenTrigger` |     150 | Profit distance required before Break Even |
| `InpBreakEvenLevel`   |       0 | Break Even SL offset from entry            |
| `InpUseTrailing`      |    true | Enable/disable Trailing Stop               |
| `InpTrailingStart`    |     200 | Profit distance required before trailing   |
| `InpTrailingStep`     |      50 | Minimum trailing improvement step          |

---

## Execution Flow

The EA follows this sequence:

```text
New Tick
   ↓
New Bar?
   ↓ Yes
Check Spread
   ↓
Manage Existing Position
   ├── Break Even
   └── Trailing Stop
   ↓
Existing position with same Magic Number?
   ↓ No
Read Ichimoku values
   ↓
Evaluate Price vs Cloud
   ↓
Evaluate Tenkan vs Kijun
   ↓
BUY / SELL / NO TRADE
```

Signal evaluation therefore occurs once per new bar rather than on every incoming tick.

---

## Timeframe and Symbol

The EA uses:

```text
_Symbol
PERIOD_CURRENT
```

Therefore, the strategy operates on the **symbol and timeframe of the chart to which the EA is attached**.

No timeframe or symbol is hard-coded into the source code.

For XAUUSD research, the intended test symbol and timeframe should therefore be explicitly recorded in the corresponding backtest documentation.

---

## Risk Model

The current version uses a **fixed lot size**.

Default:

```text
0.01 lot
```

It does not currently calculate position size from:

* Account balance
* Account equity
* Percentage risk per trade
* Stop Loss monetary value
* Maximum portfolio exposure

Consequently, changing account size does not automatically change trade volume.

---

## Implementation Notes

The current source code creates a single Ichimoku indicator handle and retrieves:

* Buffer 0 — Tenkan-sen
* Buffer 1 — Kijun-sen
* Buffer 2 — Senkou Span A
* Buffer 3 — Senkou Span B

The strategy uses the current values returned from these buffers for its trading decision.

The following Ichimoku component is **not used** as a trading condition:

```text
Chikou Span
```

The EA also does not currently include additional filters such as:

* Higher-timeframe confirmation
* ATR/volatility filter
* Trading session filter
* News filter
* Daily loss limit
* Equity protection
* Dynamic position sizing

These features should not be assumed when interpreting backtest results.

---

## Research Status

**EA ID:** EA-028
**Strategy:** Ichimoku Cloud
**Platform:** MetaTrader 5
**Language:** MQL5
**Strategy Type:** Trend Following
**Position Sizing:** Fixed Lot
**Source Version:** 1.00

Backtest performance is intentionally not documented in this README.

Test configuration, results, reports, and evidence should be stored separately under:

```text
Backtest/
└── EA-028_Ichimoku_Cloud/
```

Research conclusions should only be made after reproducible backtesting and validation.

---

## Disclaimer

This Expert Advisor is provided for **research, development, and backtesting purposes**.

Historical or simulated performance does not guarantee future results. Trading leveraged financial instruments involves significant risk.

The strategy should be independently tested and validated before any consideration of live trading.
