# EA-045 — Trend Pullback Structure

## Overview

**EA-045 Trend Pullback Structure** is a MetaTrader 5 Expert Advisor designed to trade pullbacks within an established market trend.

The strategy combines:

* Fast and slow EMA trend filtering
* Market swing structure
* Higher-Low / Lower-High validation
* Pullback breakout confirmation
* Fixed Stop Loss and Take Profit
* Spread filtering
* Break Even management
* Trailing Stop management
* Single-position exposure per symbol and Magic Number

The EA is designed as a systematic trend-following strategy rather than a reversal or mean-reversion system.

## Strategy Concept

The core idea is:

**Trend → Pullback → Market Structure → Breakout → Entry**

The EA first determines the prevailing trend using two Exponential Moving Averages.

It then searches recent price structure for swing highs and swing lows.

A trade is considered only when price structure remains consistent with the prevailing trend and price breaks the relevant pullback structure.

### Bullish Concept

```text
EMA Fast > EMA Slow
        ↓
Bullish Trend
        ↓
Higher-Low Structure
        ↓
Pullback
        ↓
Break Previous Swing High
        ↓
BUY
```

### Bearish Concept

```text
EMA Fast < EMA Slow
        ↓
Bearish Trend
        ↓
Lower-High Structure
        ↓
Pullback
        ↓
Break Previous Swing Low
        ↓
SELL
```

## Trend Detection

The EA uses two Exponential Moving Averages calculated from closing prices.

Default configuration:

| Parameter | Default |
| --------- | ------: |
| Fast EMA  |      20 |
| Slow EMA  |      50 |

### Bullish Trend

A bullish environment requires:

```text
EMA Fast > EMA Slow
```

for both the current and previous evaluated EMA values.

### Bearish Trend

A bearish environment requires:

```text
EMA Fast < EMA Slow
```

for both the current and previous evaluated EMA values.

The EMA filter prevents the EA from intentionally taking counter-trend setups.

## Market Structure Detection

The EA searches for recent swing highs and swing lows.

By default:

```text
InpSwingBars = 5
```

A candidate swing point must satisfy the configured number of surrounding bars.

The search is performed within approximately the most recent 20 bars.

### Swing Low

A swing low is a local price low surrounded by higher lows.

```text
        Price
          ╲
           ╲
            ●
           ╱ ╲
          ╱   ╲

        Swing Low
```

### Swing High

A swing high is a local price high surrounded by lower highs.

```text
          ●
         ╱ ╲
        ╱   ╲

      Swing High
```

These swing points are used as structural references for trade confirmation.

## BUY Logic

A BUY setup requires all implemented conditions to pass.

### 1. Bullish EMA Structure

```text
Fast EMA > Slow EMA
```

for both EMA values checked by the EA.

### 2. Higher-Low Condition

The current bar low must remain above the detected previous swing low.

```text
Current Low > Previous Swing Low
```

### 3. Structural High Break

The current high must exceed the detected previous swing high.

```text
Current High > Previous Swing High
```

### 4. Live Price Confirmation

The current Ask price must also be above the previous swing high.

```text
Ask > Previous Swing High
```

### BUY Structure

```text
                 Breakout
                    ↑
                    │
          Swing High┼────────
              ╱     │
             ╱      │
            ╱       │
           ╱        │
          ╲         │
           ╲       ╱
            ╲_____╱
           Higher Low

EMA Fast > EMA Slow

→ BUY
```

## SELL Logic

A SELL setup mirrors the BUY logic.

### 1. Bearish EMA Structure

```text
Fast EMA < Slow EMA
```

for both EMA values checked by the EA.

### 2. Lower-High Condition

The current bar high must remain below the detected previous swing high.

```text
Current High < Previous Swing High
```

### 3. Structural Low Break

The current low must fall below the detected previous swing low.

```text
Current Low < Previous Swing Low
```

### 4. Live Price Confirmation

The current Bid price must also be below the previous swing low.

```text
Bid < Previous Swing Low
```

### SELL Structure

```text
          Lower High
             _____
            ╱     ╲
           ╱       ╲
          ╱         ╲
                     ╲
                      ╲
Previous Swing Low ───┼──────
                      │
                      ↓
                   Breakdown

EMA Fast < EMA Slow

→ SELL
```

## Entry Frequency

Signal evaluation is restricted by the EA's new-bar detection.

The EA does not intentionally perform the full entry evaluation on every incoming tick.

This helps reduce repeated entry attempts during the same candle.

## Position Control

Before opening a new trade, the EA checks existing positions associated with:

```text
Current Symbol
+
Magic Number
```

If an existing matching position is found:

```text
No additional position is opened.
```

Therefore, the current implementation is designed around a maximum of one EA-managed position per symbol and Magic Number.

## Spread Filter

Trades are rejected when the current spread exceeds the configured maximum.

Default:

```text
Maximum Spread = 30 points
```

Calculation:

```text
Spread = (Ask - Bid) / Point
```

Condition:

```text
Spread <= InpMaxSpread
```

If the spread is too high, no new trade is opened.

## Stop Loss

The EA uses a fixed Stop Loss measured in symbol points.

Default:

```text
Stop Loss = 300 points
```

### BUY

```text
SL = Entry Price - 300 points
```

### SELL

```text
SL = Entry Price + 300 points
```

The actual price distance represented by a point depends on the symbol specification provided by the broker.

## Take Profit

The EA uses a fixed Take Profit measured in points.

Default:

```text
Take Profit = 600 points
```

### BUY

```text
TP = Entry Price + 600 points
```

### SELL

```text
TP = Entry Price - 600 points
```

Based purely on the default SL/TP distances:

```text
SL = 300 points
TP = 600 points

Nominal Reward / Risk = 2 : 1
```

This describes the configured distance ratio only and does not account for spread, slippage, execution differences, Break Even, or Trailing Stop behavior.

## Position Size

The current version uses a fixed lot size.

Default:

```text
Lot Size = 0.01
```

Position size is not dynamically calculated from:

* Account balance
* Account equity
* Percentage risk
* Stop Loss monetary value

Therefore:

```text
Risk per trade is NOT automatically normalized as a percentage of account equity.
```

Users must configure lot size according to their own account size, symbol specification, and risk policy.

## Break Even

Break Even functionality is implemented and enabled by default.

```text
InpUseBreakEven = true
```

Default trigger:

```text
150 points
```

### BUY

When price reaches:

```text
Entry + 150 points
```

the EA attempts to move Stop Loss to:

```text
Entry Price
```

### SELL

When price reaches:

```text
Entry - 150 points
```

the EA attempts to move Stop Loss to:

```text
Entry Price
```

The objective is to reduce remaining directional risk after the trade has moved sufficiently in favor of the position.

## Trailing Stop

Trailing Stop functionality is implemented and enabled by default.

Default settings:

```text
Trailing Start = 200 points
Trailing Step  = 10 points
```

The EA attempts to move the Stop Loss progressively when the trade has moved sufficiently into profit.

For BUY positions, the Stop Loss can only move upward.

For SELL positions, the Stop Loss can only move downward.

The trailing logic is intended to protect accumulated profit while allowing a favorable trend to continue.

## Default Parameters

### Lot & Risk

| Input           | Default | Description              |
| --------------- | ------: | ------------------------ |
| `InpLotSize`    |    0.01 | Fixed trading volume     |
| `InpStopLoss`   |     300 | Stop Loss in points      |
| `InpTakeProfit` |     600 | Take Profit in points    |
| `InpMaxSpread`  |      30 | Maximum permitted spread |

### Order Management

| Input            | Default | Description                            |
| ---------------- | ------: | -------------------------------------- |
| `InpMagicNumber` |  123456 | EA trade identifier                    |
| `InpSlippage`    |      10 | Maximum configured deviation in points |

### Break Even & Trailing

| Input                 | Default | Description                            |
| --------------------- | ------: | -------------------------------------- |
| `InpUseBreakEven`     |    true | Enable Break Even                      |
| `InpBreakEvenTrigger` |     150 | Break Even trigger                     |
| `InpUseTrailing`      |    true | Enable Trailing Stop                   |
| `InpTrailingStart`    |     200 | Trailing activation/distance parameter |
| `InpTrailingStep`     |      10 | Minimum SL movement step               |

### Indicators & Structure

| Input              | Default | Description             |
| ------------------ | ------: | ----------------------- |
| `InpEmaFastPeriod` |      20 | Fast EMA period         |
| `InpEmaSlowPeriod` |      50 | Slow EMA period         |
| `InpSwingBars`     |       5 | Swing confirmation bars |

## Timeframe

The EA uses:

```text
PERIOD_CURRENT
```

Therefore, indicator calculations and market-structure analysis operate on the timeframe of the chart to which the EA is attached.

The source code does not hard-code a specific timeframe.

Any recommended XAUUSD timeframe should therefore be established through backtesting and validation rather than assumed from the source code.

## Symbol

The EA uses:

```text
_Symbol
```

Therefore, it technically operates on the symbol of the chart where it is attached.

This repository entry is being researched as part of the:

```text
XAUUSD MT5 EA Research
```

project.

Any claim that a particular XAUUSD broker specification, timeframe, or parameter set is optimal requires separate backtest evidence.

## Execution Flow

The main entry flow is:

```text
New Bar
   ↓
Check Spread
   ↓
Existing EA Position?
   ├── YES → Stop
   │
   └── NO
        ↓
Read Fast EMA / Slow EMA
        ↓
Check BUY Structure
        ├── PASS → Execute BUY
        │
        └── FAIL
              ↓
        Check SELL Structure
              ├── PASS → Execute SELL
              └── FAIL → No Trade
```

## Trade Management Flow

The source contains position-management logic for:

```text
Open Position
     ↓
Break Even
     ↓
Trailing Stop
     ↓
SL / TP / Market Exit
```

Position management is invoked from `OnTradeTransaction()` for selected trade transaction events.

This implementation detail is important when validating the EA because the presence of Break Even and Trailing Stop functions in the source code does not by itself prove that they behave continuously as intended under all live tick conditions.

Their actual runtime behavior should be verified separately in Strategy Tester and/or forward testing.

## Important Implementation Notes

### Fixed Lot Risk

The EA uses fixed volume rather than percentage-based risk sizing.

### Broker Point Dependency

SL, TP, spread, Break Even, Trailing Stop, and slippage parameters are specified in points.

Their real price and monetary meaning therefore depends on the broker's XAUUSD symbol specification.

### Current Candle Usage

The signal logic references bar index `0` for several calculations.

Bar `0` is the currently forming candle.

Although the main signal evaluation is triggered by new-bar detection, this implementation should be examined carefully during backtesting to determine whether the intended structural confirmation matches the actual execution behavior.

### Swing Search

Swing highs and lows are searched within a limited recent window.

The default swing confirmation requirement is:

```text
5 bars on each side
```

This makes the strategy dependent on local market structure rather than arbitrary single-candle highs and lows.

### Position Management Validation Required

`ManagePositions()` is not called directly on every tick in `OnTick()`.

It is triggered through selected `OnTradeTransaction()` events.

Therefore, Break Even and Trailing Stop behavior must be explicitly tested before treating these features as validated continuous trade-management mechanisms.

## Research Hypothesis

The strategy is based on the hypothesis that:

> A pullback occurring inside an established EMA-defined trend may offer a continuation opportunity when market structure remains aligned with the trend and price subsequently breaks the relevant pullback structure.

This hypothesis must be evaluated using historical and forward-testing evidence.

## Backtest Requirements

At minimum, research for this EA should record:

```text
Symbol
Broker / data source
Timeframe
Testing period
Model / tick quality
Initial deposit
Leverage
Lot size
Spread assumptions
Number of trades
Net profit
Profit factor
Expected payoff
Maximum drawdown
Relative drawdown
Win rate
Average winning trade
Average losing trade
Largest winning trade
Largest losing trade
Recovery factor
```

Parameter sets should also be preserved so results can be reproduced.

## Validation Status

```text
Source Code Review : COMPLETED
Compilation        : NOT VERIFIED HERE
Backtest           : PENDING / SEPARATE EVIDENCE REQUIRED
Forward Test       : NOT VERIFIED
Production Ready   : NOT VERIFIED
```

The existence of source code does not constitute evidence of strategy profitability or production readiness.

## Repository Structure

```text
EAs/
└── EA-045_Trend_Pullback_Structure/
    ├── EA-045_Trend_Pullback_Structure.mq5
    └── README.md

Backtest/
└── EA-045_Trend_Pullback_Structure/
```

Backtest reports, parameter sets, charts, and supporting evidence should be stored separately under the corresponding `Backtest` directory.

## Research Principles

This EA should be evaluated according to the following principles:

```text
Strategy Idea
      ↓
Formal Trading Rules
      ↓
MQL5 Implementation
      ↓
Compile / Technical Test
      ↓
Historical Backtest
      ↓
Robustness Validation
      ↓
Forward Test
      ↓
Evaluation
```

No profitability claim should be made without reproducible evidence.

## Disclaimer

This Expert Advisor is provided for research, development, and educational purposes.

Historical backtest results do not guarantee future performance.

Trading XAUUSD and other leveraged financial instruments involves substantial risk. Strategy behavior can vary significantly depending on broker specifications, spread, slippage, liquidity, execution conditions, leverage, market regime, and parameter configuration.

Always independently test and validate an Expert Advisor before considering live deployment.
