# EA-057 — Flag Break

MT5 Expert Advisor implementing an **Impulse Candle → Flag Consolidation → Breakout** strategy.

The EA identifies a strong directional impulse, waits for a compact consolidation (flag), and enters when price confirms a breakout in the direction of the original impulse.

## Strategy Overview

The strategy consists of three stages:

```text
Impulse Candle
      ↓
Flag Consolidation
      ↓
Confirmed Breakout
      ↓
Market Entry
```

Both bullish and bearish setups are supported.

### 1. Impulse Detection

A candle is considered an impulse when:

* Its range is sufficiently larger than the recent average candle range.
* Its body represents a minimum proportion of the full candle range.
* Its direction determines the expected breakout direction.

Default parameters:

```text
Average Range Period = 20
Impulse Multiplier   = 1.50
Minimum Body Ratio   = 0.65
```

The impulse range must therefore be at least **1.5× the average range of the preceding 20 candles**, while the candle body must occupy at least **65% of its total range**.

### 2. Flag Detection

After the impulse candle, the EA evaluates a configurable number of candles as the consolidation structure.

Default:

```text
Flag Bars = 3
```

The flag must satisfy structural constraints including:

* Flag range ≤ 60% of impulse range.
* Retracement ≤ 60% of impulse range.
* The consolidation must not completely invalidate the original impulse.

Default parameters:

```text
Max Flag / Impulse = 0.60
Max Retracement    = 0.60
```

### 3. Breakout Confirmation

For a bullish setup:

* The impulse must be bullish.
* The flag must remain structurally valid.
* The breakout candle must be bullish.
* The breakout candle must trade above the flag high.
* The breakout candle must **close above** the breakout level.

For a bearish setup, the logic is mirrored:

* The impulse must be bearish.
* The flag must remain structurally valid.
* The breakout candle must be bearish.
* The breakout candle must trade below the flag low.
* The breakout candle must **close below** the breakout level.

Signals are evaluated using completed candles.

Entry logic runs once per new candle.

## Trade Management

### Stop Loss / Take Profit

Default values:

| Parameter   |    Default |
| ----------- | ---------: |
| Stop Loss   | 300 points |
| Take Profit | 600 points |

The EA also respects the broker's minimum stop-distance requirement.

### Break Even

Enabled by default.

```text
Trigger = 150 points
Lock    = 10 points
```

Once the position reaches the configured profit threshold, the stop loss can be moved beyond the entry price to lock a small profit.

### Trailing Stop

Enabled by default.

```text
Start    = 200 points
Distance = 150 points
Step     = 20 points
```

Trailing-stop adjustments are only applied when they improve the existing stop by the configured minimum step.

## Default Parameters

| Parameter              |    Default |
| ---------------------- | ---------: |
| Lot Size               |       0.01 |
| Stop Loss              | 300 points |
| Take Profit            | 600 points |
| Magic Number           |     123456 |
| Slippage               |  10 points |
| Maximum Spread         |  30 points |
| Break Even             |    Enabled |
| Break Even Trigger     | 150 points |
| Break Even Lock        |  10 points |
| Trailing Stop          |    Enabled |
| Trailing Start         | 200 points |
| Trailing Distance      | 150 points |
| Trailing Step          |  20 points |
| Average Range Period   |         20 |
| Impulse Multiplier     |       1.50 |
| Minimum Body Ratio     |       0.65 |
| Flag Bars              |          3 |
| Maximum Flag / Impulse |       0.60 |
| Maximum Retracement    |       0.60 |
| Breakout Buffer        |   0 points |

## Execution Rules

The EA includes several execution safeguards:

* Maximum one open position per symbol and Magic Number.
* Entry evaluation only once per new candle.
* Maximum-spread filter.
* Broker minimum stop-distance handling.
* Trading-permission checks.
* Contradictory BUY/SELL signals are rejected.
* Position management runs on every tick.
* Entries use completed-candle confirmation.

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
Type: Expert Advisor
Strategy: Impulse / Flag / Breakout
Direction: Long & Short
```

The EA operates on the **symbol and timeframe of the chart to which it is attached** (`_Symbol` and `_Period`).

## Source

```text
EA-057_Flag_Break.mq5
```

## Important Notes

The default parameter values are implementation defaults and should **not** be interpreted as optimized or universally recommended settings.

Performance depends on factors including:

* Symbol
* Timeframe
* Broker specifications
* Spread
* Execution conditions
* Historical period
* Parameter configuration

Backtest results, tested configurations, and performance evidence should be stored separately under:

```text
Backtest/EA-057_Flag_Break/
```

## Disclaimer

This repository is intended for research, development, and testing purposes.

Historical or backtested performance does not guarantee future results. Trading leveraged financial instruments involves substantial risk.
