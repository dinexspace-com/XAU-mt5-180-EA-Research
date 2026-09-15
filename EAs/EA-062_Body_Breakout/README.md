# EA-062 — Body Breakout

## Overview

**EA-062_Body_Breakout** is a MetaTrader 5 Expert Advisor designed to test whether a breakout from a recent price range becomes more meaningful when the breakout candle has a large directional body relative to its total candle range.

The strategy combines:

- Recent price-range breakout
- Candle-body strength confirmation
- Fixed Stop Loss and Take Profit
- Break Even management
- Trailing Stop management
- Spread filtering
- Broker execution and position-safety checks

The default configuration operates on the **M1 timeframe**.

---

## Strategy Concept

A simple breakout can occur because of temporary price spikes, wicks, or weak directional movement.

EA-062 adds a candle-body quality requirement to the breakout condition.

The core hypothesis is:

> A breakout candle whose body represents a large proportion of its total High-Low range may indicate stronger directional conviction than a breakout dominated by wicks.

The baseline implementation therefore requires both:

```text
Price Breakout
+
Minimum Candle Body Ratio
```

before generating a trading signal.

---

## Breakout Range

The EA calculates the breakout range from the previous completed candles.

Default:

```text
Breakout Lookback = 20 bars
```

For the signal candle at:

```text
bars[1]
```

the reference breakout range is calculated from:

```text
bars[2] → bars[21]
```

The upper boundary is:

```text
Highest High of previous 20 completed bars
```

The lower boundary is:

```text
Lowest Low of previous 20 completed bars
```

The signal candle itself is therefore excluded from the reference range.

---

## Breakout Condition

A configurable breakout buffer can be added to the range boundaries.

Default:

```text
Breakout Buffer = 0 points
```

### BUY Breakout

A preliminary BUY breakout exists when:

```text
Close[1] > Upper Range + Breakout Buffer
```

### SELL Breakout

A preliminary SELL breakout exists when:

```text
Close[1] < Lower Range - Breakout Buffer
```

A breakout alone is not sufficient to open a trade.

The signal must also pass the candle-body filter.

---

## Candle Body Filter

The EA measures the directional body of the signal candle relative to its complete High-Low range.

The calculation is:

```text
Body Ratio =
ABS(Close[1] - Open[1])
────────────────────────
High[1] - Low[1]
```

Default requirement:

```text
Minimum Body Ratio = 0.70
```

Therefore:

```text
Body Ratio >= 70%
```

is required for a valid signal.

If the candle range is zero or the body represents less than 70% of the total candle range, the breakout signal is rejected.

---

## BUY Signal

A BUY signal requires:

```text
Close[1] > Highest High(previous 20 bars)
```

and:

```text
ABS(Close[1] - Open[1])
──────────────────────── >= 0.70
High[1] - Low[1]
```

With the default Breakout Buffer of zero, this can be summarized as:

```text
20-Bar Upside Breakout
        +
Body Ratio >= 70%
        ↓
      BUY
```

---

## SELL Signal

A SELL signal requires:

```text
Close[1] < Lowest Low(previous 20 bars)
```

and:

```text
ABS(Close[1] - Open[1])
──────────────────────── >= 0.70
High[1] - Low[1]
```

With the default Breakout Buffer of zero:

```text
20-Bar Downside Breakout
        +
Body Ratio >= 70%
        ↓
      SELL
```

---

## Signal Timing

Entry signals are evaluated only after a new candle becomes available.

The EA uses the most recently completed candle as the signal candle:

```text
bars[1]
```

The currently forming candle:

```text
bars[0]
```

is not used as the completed breakout signal.

This avoids generating the baseline signal from an unfinished candle.

Position management remains active on every tick.

---

## Default Parameters

| Parameter | Default | Description |
|---|---:|---|
| Lot Size | 0.01 | Fixed trading volume |
| Stop Loss | 300 points | Initial protective Stop Loss |
| Take Profit | 600 points | Initial Take Profit |
| Magic Number | 123062 | Unique EA identifier |
| Slippage | 10 points | Maximum execution deviation |
| Maximum Spread | 30 points | Maximum spread allowed for new entries |
| Timeframe | M1 | Signal timeframe |
| Breakout Lookback | 20 | Number of completed bars defining breakout range |
| Breakout Buffer | 0 points | Additional distance required beyond breakout boundary |
| Minimum Body Ratio | 0.70 | Minimum candle body / total range ratio |

---

## Risk / Reward

The baseline uses:

```text
Stop Loss  = 300 points
Take Profit = 600 points
```

The nominal fixed SL/TP relationship is therefore:

```text
300 : 600
```

or:

```text
1 : 2
```

This is the configured initial protective structure.

Actual realized trade outcomes can differ because Break Even and Trailing Stop management may close trades before the original Stop Loss or Take Profit is reached.

---

## Position Sizing

The EA uses fixed-lot position sizing.

Default:

```text
Lot Size = 0.01
```

The EA validates the configured volume against the symbol's:

```text
Minimum Volume
Maximum Volume
Volume Step
```

If the configured lot size is invalid for the broker symbol, initialization fails.

The EA does not silently increase the configured lot size to satisfy broker volume requirements.

---

## Break Even

Break Even is enabled by default.

```text
Use Break Even       = true
Break Even Trigger   = 150 points
Break Even Offset    = 0 points
```

When open profit reaches at least:

```text
150 points
```

the EA attempts to move the Stop Loss toward the entry price.

With the default offset:

```text
Break Even SL = Entry Price
```

The EA checks broker stop-distance and freeze-level restrictions before modifying the position.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
Use Trailing Stop   = true
Trailing Start      = 200 points
Trailing Distance   = 100 points
Trailing Step       = 10 points
```

Trailing management begins when open profit reaches at least:

```text
200 points
```

The new Stop Loss is calculated approximately:

For BUY:

```text
Current Bid - 100 points
```

For SELL:

```text
Current Ask + 100 points
```

A trailing modification must improve the existing Stop Loss by at least the configured Trailing Step while also respecting broker stop and freeze restrictions.

---

## Position Management

Protective position management runs on every tick.

This includes:

```text
Break Even
Trailing Stop
```

Entry evaluation, however, occurs only when a new signal candle becomes available.

This separates:

```text
ENTRY LOGIC
    ↓
New Bar

POSITION MANAGEMENT
    ↓
Every Tick
```

---

## Duplicate Exposure Protection

The EA prevents uncontrolled duplicate exposure.

For the configured Magic Number:

```text
Magic Number = 123062
```

the EA allows at most one active position or pending order associated with that Magic Number across the account.

On netting accounts, the EA additionally prevents opening a new trade when another position or order already exists on the same symbol.

---

## Spread Filter

New trades are allowed only when:

```text
Spread <= Maximum Spread
```

Default:

```text
Maximum Spread = 30 points
```

If spread exceeds this threshold, no new entry is submitted.

Existing position management is still evaluated independently.

---

## Execution Validation

Before opening a position, the EA checks:

```text
Terminal connection
Terminal automated-trading permission
MQL trading permission
Account trading permission
Expert Advisor trading permission
Symbol trading mode
BUY / SELL direction permission
Market-order support
Stop Loss support
Take Profit support
Maximum spread
Broker stop distance
Available margin
Lot minimum
Lot maximum
Lot step
Tick size
```

A trade is skipped when the required execution conditions are not satisfied.

---

## Protective Order Submission

The initial Stop Loss and Take Profit are submitted together with the market order.

Conceptually:

```text
Market Entry
+
Initial SL
+
Initial TP
```

are included in the same trade request.

This reduces the period in which a newly opened position could exist without its configured initial protective prices.

---

## Broker Price Handling

The EA uses the symbol's:

```text
Point Size
Tick Size
Price Digits
Stop Level
Freeze Level
```

when calculating and modifying protective prices.

Prices are rounded according to the broker's valid tick size.

The EA also verifies that Stop Loss and Take Profit distances satisfy broker requirements before submitting the entry.

---

## Initialization Validation

The EA rejects invalid configurations during initialization.

Examples include:

```text
Lot Size <= 0
Stop Loss <= 0
Take Profit <= 0
Magic Number = 0
Negative Slippage
Negative Maximum Spread
Breakout Lookback < 2
Breakout Lookback > 10000
Negative Breakout Buffer
Invalid Break Even settings
Invalid Trailing Stop settings
Minimum Body Ratio <= 0
Minimum Body Ratio > 1
Invalid broker lot size
Invalid symbol point / tick properties
```

This prevents several invalid parameter combinations from reaching trading execution.

---

## Attachment Behavior

When the EA is first attached to a chart, it records the current candle time.

It does not immediately execute an entry based on an old historical signal.

The EA begins evaluating entries from the next available candle.

---

## Baseline Strategy Summary

The complete baseline signal can be represented as:

```text
              XAUUSD
                 │
                 ▼
          M1 Completed Bar
                 │
                 ▼
      Previous 20-Bar Range
                 │
          ┌──────┴──────┐
          │             │
          ▼             ▼
 Close > Upper     Close < Lower
          │             │
          └──────┬──────┘
                 ▼
        Candle Body Filter
                 │
        Body / Range >= 70%
                 │
          ┌──────┴──────┐
          │             │
          ▼             ▼
         BUY           SELL
          │             │
          └──────┬──────┘
                 ▼
       SL 300 / TP 600
                 │
                 ▼
         Break Even 150
                 │
                 ▼
      Trailing Start 200
```

---

## Files

```text
EA-062_Body_Breakout/
├── EA-062_Body_Breakout.mq5
└── README.md
```

### `EA-062_Body_Breakout.mq5`

Contains the complete MQL5 implementation of the strategy.

### `README.md`

Documents the strategy hypothesis, implemented trading rules, baseline parameters, trade management and execution protections.

---

## Platform

```text
EA ID:            EA-062
EA Name:          Body Breakout
Platform:         MetaTrader 5
Language:         MQL5
Primary Market:   XAUUSD
Default Timeframe:M1
Strategy Family:  Breakout
Signal Filter:    Candle Body Ratio
Position Sizing:  Fixed Lot
```

---

## Research Relationship

EA-062 isolates a different breakout-confirmation hypothesis from ATR-based volatility confirmation.

Its defining condition is:

```text
Breakout
+
Large Candle Body
```

The strategy should therefore be evaluated according to the actual Body Breakout implementation rather than assuming results from other breakout EAs apply to EA-062.

Backtest evidence should be stored separately under:

```text
Backtest/EA-062_Body_Breakout/
```

---

## Research Status

```text
Strategy Implementation : COMPLETE
Source Code             : AVAILABLE
Baseline Backtest       : NOT DOCUMENTED HERE
Research Assessment     : PENDING BACKTEST EVIDENCE
Live Trading Approval   : NO
```

The source-code implementation alone is not sufficient to classify the trading strategy as profitable or suitable for live deployment.

---

## Disclaimer

This Expert Advisor is provided for algorithmic-trading research, development and testing.

Historical backtests, simulations and research results do not guarantee future performance.

Trading XAUUSD involves financial risk.

Any transition from research to forward testing or live trading requires separate validation and human approval.
