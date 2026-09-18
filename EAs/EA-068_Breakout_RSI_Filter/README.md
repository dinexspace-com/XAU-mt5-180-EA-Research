# EA-068 — Breakout RSI Filter

## Overview

**EA-068_Breakout_RSI_Filter** is an Expert Advisor for MetaTrader 5 written in MQL5.

The EA investigates whether an RSI momentum filter can improve the quality of price-range breakout entries.

The strategy combines:

```text
Price Breakout
      +
RSI Momentum Filter
      ↓
Trading Signal
```

The implementation is designed for systematic research and backtesting.

It should not be considered validated for live trading based on source code alone.

---

## Strategy

EA-068 first identifies a historical price range.

The range is calculated from completed candles preceding the signal candle:

```text
Upper Range = Highest High
Lower Range = Lowest Low
```

using:

```text
Breakout Lookback = 20
```

The latest completed candle is then evaluated for a breakout.

The breakout itself is not sufficient to open a trade.

The signal must also satisfy the RSI momentum filter.

---

## BUY Logic

A BUY candidate requires the latest completed candle to close above the historical Upper Range:

```text
Close[1] > Upper Range + Breakout Buffer
```

The RSI filter must then satisfy:

```text
RSI[1] > RSI Buy Level
```

Default:

```text
RSI Buy Level = 55
```

Therefore:

```text
20-Bar Upper Range Break
          +
      RSI(14) > 55
          ↓
      BUY Candidate
```

---

## SELL Logic

A SELL candidate requires the latest completed candle to close below the historical Lower Range:

```text
Close[1] < Lower Range - Breakout Buffer
```

The RSI filter must then satisfy:

```text
RSI[1] < RSI Sell Level
```

Default:

```text
RSI Sell Level = 45
```

Therefore:

```text
20-Bar Lower Range Break
          +
      RSI(14) < 45
          ↓
      SELL Candidate
```

---

## RSI Configuration

Default RSI parameters:

```text
RSI Period     = 14
RSI Buy Level  = 55
RSI Sell Level = 45
Applied Price  = Close
```

The RSI is used as a momentum confirmation filter.

It is not used as an overbought/oversold reversal signal in this implementation.

---

## Breakout Calculation

The signal candle is:

```text
bar[1]
```

The breakout reference range begins from:

```text
bar[2]
```

and extends backward for:

```text
InpBreakoutLookback
```

completed candles.

With the default configuration:

```text
Signal Candle:
bar[1]

Reference Range:
bar[2] → bar[21]
```

This keeps the signal candle outside the range used to calculate the breakout boundary.

---

## Signal Timing

The default strategy timeframe is:

```text
M1
```

Entry logic is evaluated when a new candle is detected.

The EA therefore evaluates the completed candle rather than repeatedly generating entry signals from the same candle.

At initialization, the current candle is recorded so that attaching the EA does not immediately execute an old signal.

---

## Default Inputs

### Execution

| Parameter | Default |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123068 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |

### RSI Filter

| Parameter | Default |
|---|---:|
| RSI Period | 14 |
| RSI Buy Level | 55 |
| RSI Sell Level | 45 |

### Break Even

| Parameter | Default |
|---|---:|
| Use Break Even | true |
| Trigger | 150 points |
| Offset | 0 |

### Trailing Stop

| Parameter | Default |
|---|---:|
| Use Trailing Stop | true |
| Start | 200 points |
| Distance | 100 points |
| Step | 10 points |

---

## Position Management

EA-068 includes two dynamic position-management mechanisms:

```text
Break Even
+
Trailing Stop
```

Position management is evaluated on every tick.

This is independent from entry-signal evaluation, which occurs on new candles.

---

## Break Even

Default:

```text
Enabled = true
Trigger = 150 points
Offset  = 0
```

When unrealized profit reaches the configured trigger, the EA attempts to move the Stop Loss toward the entry price.

With the default offset:

```text
New SL ≈ Entry Price
```

The implementation checks broker stop/freeze restrictions before modifying the position.

---

## Trailing Stop

Default:

```text
Enabled  = true
Start    = 200 points
Distance = 100 points
Step     = 10 points
```

Trailing begins after the position reaches the configured profit threshold.

The Stop Loss is only changed when the proposed level improves the existing Stop Loss by the required trailing step.

---

## Initial Stop Loss and Take Profit

For BUY:

```text
SL = Entry Price - 300 points
TP = Entry Price + 600 points
```

For SELL:

```text
SL = Entry Price + 300 points
TP = Entry Price - 600 points
```

SL and TP are submitted together with the original market-order request.

The EA also checks the broker's minimum stop-distance requirements before submitting an entry.

---

## Spread Filter

A new trade is rejected when:

```text
Current Spread > InpMaxSpread
```

Default:

```text
Maximum Spread = 30 points
```

The spread filter applies to new entries.

Existing-position management can continue even when spread is too high for a new entry.

---

## Position / Order Protection

The EA uses:

```text
Magic Number = 123068
```

The implementation prevents another entry when an existing position or pending order using the same Magic Number is detected.

Additional protection is included for netting accounts to avoid merging the EA's symbol exposure with another position on the same symbol.

---

## Execution Validation

Before opening a position, the EA checks several execution conditions.

These include:

```text
Terminal connection
Trading permission
EA trading permission
Account trading permission
Symbol trading mode
Market-order support
SL/TP support
Spread
Broker stop distance
Available margin
Lot-size validity
```

If these requirements are not satisfied, the entry is skipped.

---

## Lot Size Validation

The EA does not silently increase an invalid lot size.

The configured lot is checked against:

```text
Minimum Volume
Maximum Volume
Volume Step
```

If:

```text
InpLotSize
```

does not satisfy the symbol specification, initialization fails rather than silently changing the requested position size.

---

## Strategy Flow

```text
New M1 Candle
      ↓
Load Completed Bars
      ↓
Calculate Previous 20-Bar Range
      ↓
Check Close[1] Breakout
      ↓
Read RSI(14)
      ↓
┌───────────────────────────┐
│ Bullish Break + RSI > 55  │
│             OR            │
│ Bearish Break + RSI < 45  │
└───────────────────────────┘
      ↓
Check Existing Exposure
      ↓
Check Trading Permission
      ↓
Check Spread
      ↓
Check Broker Restrictions
      ↓
Check Margin
      ↓
Submit Market Order
with SL + TP
      ↓
Manage Position Every Tick
      ↓
Break Even / Trailing Stop
```

---

## Source File

```text
EA-068_Breakout_RSI_Filter.mq5
```

Repository location:

```text
EAs/
└── EA-068_Breakout_RSI_Filter/
    ├── EA-068_Breakout_RSI_Filter.mq5
    └── README.md
```

---

## Research Question

The primary research question for EA-068 is:

> Does adding an RSI momentum filter to a price-range breakout strategy improve entry quality and historical expectancy?

The implementation provides a controlled framework for comparing:

```text
Breakout Only
      vs
Breakout + RSI Filter
```

Further research can separately investigate:

```text
RSI Period
RSI Buy Threshold
RSI Sell Threshold
Breakout Lookback
Breakout Buffer
Timeframe
Trading Session
Break Even
Trailing Stop
```

These variables should be evaluated through controlled experiments rather than assuming that the default configuration is optimal.

---

## Validation Status

```text
EA: EA-068_Breakout_RSI_Filter
Platform: MetaTrader 5
Language: MQL5
Primary Instrument: XAUUSD
Default Timeframe: M1

Source Code: AVAILABLE
Baseline Backtest: NOT DOCUMENTED HERE
Optimization: NOT VALIDATED
Out-of-Sample: NOT VALIDATED
Forward Test: NOT VALIDATED
Live Trading: NOT VALIDATED
```

The source code defines the trading hypothesis and implementation.

Profitability and robustness must be established separately through documented testing evidence stored under:

```text
Backtest/EA-068_Breakout_RSI_Filter/
```

---

## Disclaimer

This EA is maintained for algorithmic trading research and testing.

Historical backtest results, when available, do not guarantee future performance.

The existence of source code or a successful compilation does not establish that the strategy is profitable, robust, or suitable for live trading.
