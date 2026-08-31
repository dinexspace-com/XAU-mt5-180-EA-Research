# EA-036 — Swing Break Trend

## Overview

**EA-036 — Swing Break Trend** is a MetaTrader 5 Expert Advisor (EA) built around a swing breakout strategy.

The EA identifies confirmed **Swing High** and **Swing Low** levels from historical price data and looks for breakout opportunities:

* **BUY** when price breaks above the detected Swing High.
* **SELL** when price breaks below the detected Swing Low.

The strategy includes fixed Stop Loss and Take Profit, spread filtering, Break Even management, Trailing Stop management, and Magic Number based position tracking.

> **Status:** Research / Backtesting
> **Platform:** MetaTrader 5
> **Language:** MQL5
> **Strategy Type:** Swing Breakout / Trend Following
> **Version:** 1.00

---

## Strategy Logic

The core idea is to trade price expansion after a confirmed market swing level is broken.

The EA operates on the **current chart symbol and timeframe**.

On every tick, the EA:

1. Retrieves the current Bid/Ask price.
2. Checks whether the current spread is within the configured limit.
3. Detects whether a new candle has started.
4. Checks for an existing EA position on the current symbol.
5. Manages the existing position if one is open.
6. Otherwise, searches historical candles for a valid Swing High and Swing Low.
7. Checks whether current price has broken one of these levels.
8. Opens a BUY or SELL position when a valid breakout occurs.

The EA allows a maximum of **one open position per symbol for its configured Magic Number**.

---

## Swing Detection

Swing points are detected using the `InpSwingBars` parameter.

### Swing High

A candle is considered a Swing High when its High is strictly higher than the High of the configured number of candles on both sides.

Conceptually:

```text
Left candles < Swing High > Right candles
```

With:

```text
InpSwingBars = 5
```

the candidate candle must have a higher High than each of the 5 candles before it and the 5 candles after it.

The EA searches historical candles and uses the first valid Swing High found by its search routine.

### Swing Low

A candle is considered a Swing Low when its Low is strictly lower than the Low of the configured number of candles on both sides.

Conceptually:

```text
Left candles > Swing Low < Right candles
```

With:

```text
InpSwingBars = 5
```

the candidate candle must have a lower Low than each of the 5 candles before it and the 5 candles after it.

The EA searches historical candles and uses the first valid Swing Low found by its search routine.

---

## Entry Conditions

Entry evaluation is performed only when the EA detects a **new bar**.

### BUY

A BUY signal occurs when:

```text
Current Ask > Swing High
```

Additional requirements:

* Current spread must not exceed `InpMaxSpread`.
* No existing position with the same Magic Number may be open on the current symbol.
* A valid Swing High must have been detected.

When these conditions are satisfied, the EA sends a market BUY order.

The initial Stop Loss is calculated as:

```text
SL = Ask - InpStopLoss × Point
```

The initial Take Profit is calculated as:

```text
TP = Ask + InpTakeProfit × Point
```

The order comment is:

```text
Swing Break BUY
```

---

### SELL

A SELL signal occurs when:

```text
Current Bid < Swing Low
```

Additional requirements:

* Current spread must not exceed `InpMaxSpread`.
* No existing position with the same Magic Number may be open on the current symbol.
* A valid Swing Low must have been detected.

When these conditions are satisfied, the EA sends a market SELL order.

The initial Stop Loss is calculated as:

```text
SL = Bid + InpStopLoss × Point
```

The initial Take Profit is calculated as:

```text
TP = Bid - InpTakeProfit × Point
```

The order comment is:

```text
Swing Break SELL
```

---

## Position Management

The EA manages positions belonging to:

* The current symbol.
* The configured `InpMagicNumber`.

Position management consists of:

* Break Even.
* Trailing Stop.

Position management is evaluated when the EA processes a new bar.

---

## Break Even

Break Even can be enabled or disabled using:

```text
InpUseBreakEven
```

Default:

```text
true
```

The Break Even mechanism activates after the position reaches the configured unrealized profit threshold.

Default trigger:

```text
InpBreakEvenTrigger = 150 points
```

### BUY Position

Profit in points is calculated as:

```text
Current Bid - Open Price
```

When profit reaches the Break Even trigger:

```text
New SL = Open Price + InpBreakEvenLock × Point
```

### SELL Position

Profit in points is calculated as:

```text
Open Price - Current Ask
```

When profit reaches the Break Even trigger:

```text
New SL = Open Price - InpBreakEvenLock × Point
```

Default Break Even Lock:

```text
InpBreakEvenLock = 0
```

Therefore, with default settings, the Stop Loss is moved to approximately the original entry price when the Break Even condition is satisfied.

---

## Trailing Stop

Trailing Stop can be enabled or disabled using:

```text
InpUseTrailing
```

Default:

```text
true
```

Trailing starts after the position reaches:

```text
InpTrailingStart = 200 points
```

### BUY Position

The EA calculates:

```text
New SL = Current Bid - InpTrailingStep × Point
```

The Stop Loss is modified only when the new level improves the existing Stop Loss.

### SELL Position

The EA calculates:

```text
New SL = Current Ask + InpTrailingStep × Point
```

The Stop Loss is modified only when the new level improves the existing Stop Loss.

Default trailing distance:

```text
InpTrailingStep = 50 points
```

The EA does not intentionally move the Stop Loss backward to increase risk.

---

## Spread Filter

Before processing trading logic, the EA calculates the current spread:

```text
Spread = (Ask - Bid) / Point
```

Trading logic is skipped when:

```text
Spread > InpMaxSpread
```

Default:

```text
InpMaxSpread = 30 points
```

This filter is designed to prevent execution while the Bid/Ask spread is above the configured threshold.

---

## Position Limit

The EA checks positions using both:

```text
Magic Number
+
Current Symbol
```

If one or more matching positions already exist:

```text
CountOpenPositions() >= 1
```

the EA does not search for a new entry.

Instead, it switches to position-management logic.

Therefore, under normal EA operation, the strategy is designed to maintain a maximum of:

```text
1 active EA position per symbol
```

for the configured Magic Number.

---

## Input Parameters

### Lot & Order Settings

| Parameter        |  Default | Description                                |
| ---------------- | -------: | ------------------------------------------ |
| `InpLotSize`     |   `0.01` | Fixed trading lot size                     |
| `InpMagicNumber` | `123456` | Magic Number used to identify EA positions |
| `InpSlippage`    |     `10` | Maximum execution deviation in points      |

### Risk Management

| Parameter       | Default | Description                            |
| --------------- | ------: | -------------------------------------- |
| `InpStopLoss`   |   `300` | Initial Stop Loss distance in points   |
| `InpTakeProfit` |   `600` | Initial Take Profit distance in points |

Default nominal SL/TP relationship:

```text
300 : 600
```

or:

```text
1 : 2
```

This is the configured price-distance relationship before considering spread, execution differences, Break Even, Trailing Stop, commissions, or other trading costs.

### Break Even / Trailing

| Parameter             | Default | Description                                  |
| --------------------- | ------: | -------------------------------------------- |
| `InpUseBreakEven`     |  `true` | Enables Break Even                           |
| `InpBreakEvenTrigger` |   `150` | Profit threshold before Break Even activates |
| `InpBreakEvenLock`    |     `0` | Number of points locked beyond entry         |
| `InpUseTrailing`      |  `true` | Enables Trailing Stop                        |
| `InpTrailingStart`    |   `200` | Profit threshold before trailing begins      |
| `InpTrailingStep`     |    `50` | Trailing distance from current price         |

### Filters

| Parameter      | Default | Description                                        |
| -------------- | ------: | -------------------------------------------------- |
| `InpMaxSpread` |    `30` | Maximum permitted spread in points                 |
| `InpSwingBars` |     `5` | Number of candles required on each side of a swing |

---

## Default Configuration

```text
Lot Size            = 0.01
Magic Number        = 123456
Slippage            = 10 points

Stop Loss           = 300 points
Take Profit         = 600 points

Break Even          = Enabled
BE Trigger          = 150 points
BE Lock             = 0 points

Trailing Stop       = Enabled
Trailing Start      = 200 points
Trailing Distance   = 50 points

Maximum Spread      = 30 points
Swing Bars          = 5
```

---

## Execution Flow

```text
New Tick
   │
   ▼
Get current Bid / Ask
   │
   ▼
Calculate Spread
   │
   ├── Spread > Max Spread
   │       └── Stop processing
   │
   ▼
Check New Bar
   │
   ├── Not New Bar
   │       └── Stop processing
   │
   ▼
Check Existing Position
   │
   ├── Position Exists
   │       │
   │       └── Manage Break Even / Trailing
   │
   ▼
Find Swing High
   │
   ▼
Find Swing Low
   │
   ▼
Check Breakout
   │
   ├── Ask > Swing High
   │       └── BUY
   │
   ├── Bid < Swing Low
   │       └── SELL
   │
   └── No Breakout
           └── Wait
```

---

## Timeframe

The EA uses:

```text
PERIOD_CURRENT
```

Therefore, the trading timeframe is determined by the chart or Strategy Tester timeframe on which the EA is running.

The source code does not enforce a specific timeframe.

Any preferred timeframe for XAUUSD should therefore be established through research and backtesting rather than assumed from the EA implementation.

---

## Symbol

The EA uses:

```text
_Symbol
```

Therefore, it trades the symbol of the chart on which it is attached.

Although this repository is focused on **XAUUSD EA research**, the source code itself does not hard-code `XAUUSD`.

Broker-specific symbol naming may therefore also be used, for example:

```text
XAUUSD
XAUUSDm
GOLD
```

provided the EA is attached to that symbol and the broker supports trading it.

---

## Important Note About Points

All distance-based parameters in this EA are expressed in **MetaTrader points**, not directly in USD or pips.

Examples include:

```text
InpStopLoss
InpTakeProfit
InpBreakEvenTrigger
InpBreakEvenLock
InpTrailingStart
InpTrailingStep
InpMaxSpread
InpSlippage
```

Their actual price distance depends on the symbol's `_Point` value provided by the broker.

For example:

```text
Price Distance = Parameter × _Point
```

Therefore, the same numerical parameter may represent a different effective price distance depending on broker symbol specifications.

This must be considered when comparing backtests across different brokers or XAUUSD symbol configurations.

---

## Installation

Place:

```text
EA-036_Swing_Break_Trend.mq5
```

inside the MetaTrader 5 Expert Advisors directory:

```text
MQL5/Experts/
```

Open the file in MetaEditor and compile it.

After successful compilation, attach the EA to the required chart or select it from the MetaTrader 5 Strategy Tester.

---

## Backtesting

Backtesting should be performed through the MetaTrader 5 Strategy Tester.

At minimum, record:

```text
EA version
Symbol
Broker / data source
Timeframe
Test period
Model / tick mode
Initial deposit
Leverage
Lot size
Input parameters
Spread conditions
Net profit
Maximum drawdown
Profit factor
Number of trades
Win rate
```

Backtest results are maintained separately under:

```text
Backtest/EA-036_Swing_Break_Trend/
```

Backtest performance should not be inferred from the strategy logic alone.

---

## Current Limitations

The current `v1.00` implementation is intentionally simple.

Based on the source code, it currently does **not** implement:

* Dynamic lot sizing based on account risk percentage.
* ATR-based Stop Loss or Take Profit.
* Trend confirmation using moving averages or other indicators.
* Trading-session filters.
* News filters.
* Daily loss limits.
* Maximum drawdown protection.
* Maximum trades per day.
* Partial position closing.
* Multi-timeframe confirmation.
* Explicit XAUUSD-only symbol validation.
* Broker normalization layer for different gold symbol specifications.

These features should not be considered part of EA-036 unless they are added to the source code and tested.

---

## Research Status

EA-036 should be treated as a **research strategy**, not as a validated profitable trading system.

The presence of:

```text
Swing Breakout
Stop Loss
Take Profit
Break Even
Trailing Stop
Spread Filter
```

does not establish profitability or robustness.

Validation requires separate backtesting and analysis.

At minimum, future research should determine:

```text
Expected return
Maximum drawdown
Profit factor
Win rate
Trade frequency
Sensitivity to spread
Sensitivity to timeframe
Parameter stability
Out-of-sample performance
```

---

## File

```text
EAs/
└── EA-036_Swing_Break_Trend/
    ├── EA-036_Swing_Break_Trend.mq5
    └── README.md
```

---

## Version

```text
EA ID:       EA-036
Name:        Swing Break Trend
Version:     1.00
Platform:    MetaTrader 5
Language:    MQL5
Status:      Research / Backtesting
```

---

## Disclaimer

This Expert Advisor is provided for research, development, and backtesting purposes.

Historical or simulated performance does not guarantee future results. Trading leveraged financial instruments involves substantial risk. Strategy behavior can vary due to broker execution, spreads, commissions, slippage, liquidity, symbol specifications, and market conditions.

Do not treat this EA or its backtest results as financial advice.
