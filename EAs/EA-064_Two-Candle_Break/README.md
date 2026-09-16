# EA-064 — Two-Candle Break

## Overview

**EA-064_Two-Candle_Break** is a MetaTrader 5 Expert Advisor designed to test whether requiring **two consecutive completed candles to close beyond the same historical breakout range** can provide stronger breakout confirmation on XAUUSD.

Unlike a standard one-candle breakout, EA-064 does not enter immediately after the first candle closes outside the reference range.

The strategy requires two consecutive completed candles to confirm the breakout in the same direction.

The default implementation operates on the **M1 timeframe** and supports both BUY and SELL trades.

---

## Strategy Hypothesis

The strategy tests the following hypothesis:

> A breakout that remains confirmed for two consecutive completed candles may provide stronger evidence of directional continuation than a breakout confirmed by only one candle.

The first breakout candle establishes that price has moved beyond the historical range.

The second confirmation candle must also close beyond the **same fixed breakout boundary**.

The reference range excludes both confirmation candles.

---

## Reference Range

The EA constructs a historical price range using:

```text
InpBreakoutLookback = 20
```

completed candles.

For a new signal evaluation:

```text
bars[1] = latest completed candle
bars[2] = previous completed candle
bars[3...] = historical reference candles
```

The reference range begins at:

```text
bars[3]
```

and contains:

```text
InpBreakoutLookback
```

candles.

Therefore, both confirming candles are excluded from the reference range.

The boundaries are:

```text
Upper = Highest High of the reference candles
Lower = Lowest Low of the reference candles
```

Conceptually:

```text
Historical Reference Range
────────────────────────────────────

bars[22] ... bars[3]

Upper ───────────────────────────────
                    │
                    │ bars[2]
                    │ First confirmation
                    │
                    │ bars[1]
                    │ Second confirmation
                    │
Lower ───────────────────────────────
```

Both `bars[2]` and `bars[1]` are compared against the same fixed historical range.

---

## BUY Entry

A BUY signal requires **both completed confirmation candles** to close above the historical Upper boundary.

The implemented condition is:

```text
bars[2].close > Upper + BreakoutBuffer
AND
bars[1].close > Upper + BreakoutBuffer
```

Therefore:

```text
First completed candle  → closes above Upper
Second completed candle → also closes above Upper
```

Only after the second confirmation candle has closed does the EA generate the BUY signal.

Conceptually:

```text
                        Candle 2
                           │
                        ┌──┴──┐
                        │     │
               Candle 1 │     │
                  │     │     │
               ┌──┴──┐  │     │
               │     │  │     │
Upper ─────────┼─────┼──┼─────┼────────
               │     │
               │     │
───────────────────────────────────────
Historical breakout range
```

Both closes must remain above the same historical Upper level.

---

## SELL Entry

A SELL signal requires both completed confirmation candles to close below the historical Lower boundary.

The implemented condition is:

```text
bars[2].close < Lower - BreakoutBuffer
AND
bars[1].close < Lower - BreakoutBuffer
```

Therefore:

```text
First completed candle  → closes below Lower
Second completed candle → also closes below Lower
```

Only after the second confirmation candle has closed does the EA generate the SELL signal.

Conceptually:

```text
Historical breakout range
───────────────────────────────────────
Lower ─────────┼─────┼──┼─────┼────────
               │     │  │     │
               └──┬──┘  │     │
                  │     └──┬──┘
               Candle 1    │
                         Candle 2
```

Both closes must remain below the same historical Lower level.

---

## Breakout Buffer

The breakout threshold can be extended using:

```text
InpBreakoutBuffer
```

Default:

```text
InpBreakoutBuffer = 0
```

For BUY:

```text
Required Close > Upper + (BreakoutBuffer × Point)
```

For SELL:

```text
Required Close < Lower - (BreakoutBuffer × Point)
```

With the baseline value of `0`, no additional distance beyond the historical range is required.

---

## Signal Timing

The EA evaluates entry signals only when a new candle is detected on:

```text
InpTimeframe
```

Default:

```text
PERIOD_M1
```

The signal uses completed candles.

The currently forming candle is not used as either confirmation candle.

The sequence is:

```text
Historical Range
      ↓
First candle closes beyond range
      ↓
Second candle closes beyond same range
      ↓
New candle begins
      ↓
Signal evaluated
      ↓
Market entry
```

This prevents entry based on an unfinished confirmation candle.

---

## Initial Attachment Behaviour

When the EA is initialized, it records the current candle:

```text
last_bar = iTime(_Symbol, InpTimeframe, 0)
```

The EA therefore waits for the next new candle before evaluating a trading signal.

This prevents an old historical signal from immediately triggering an entry when the EA is attached to a chart or Strategy Tester begins execution.

---

## Position Rules

The EA allows at most one position or pending order associated with its Magic Number across the account.

Default:

```text
InpMagicNumber = 123064
```

Before opening a new trade, the EA checks existing positions and orders.

If a position or order already exists with:

```text
Magic Number = 123064
```

the new entry is blocked.

---

## Netting Account Protection

On netting accounts, MT5 combines exposure for the same symbol into a single position.

To prevent EA-064 from unintentionally merging its exposure with another EA or manually opened position, the EA additionally blocks entry when another position or pending order already exists on the same symbol.

Therefore:

```text
Hedging account:
Block same Magic Number exposure.

Netting account:
Block same Magic Number exposure
+
Block existing exposure on the same symbol.
```

---

## Stop Loss and Take Profit

Every market order is submitted together with its protective Stop Loss and Take Profit.

Baseline:

```text
InpStopLoss  = 300 points
InpTakeProfit = 600 points
```

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

Protective prices are normalized according to the symbol's tick size.

The EA checks the broker's minimum permitted stop distance before submitting the order.

If the configured SL or TP cannot satisfy the broker's stop-distance requirements:

```text
Entry skipped
```

The EA does not intentionally open an unprotected market position and add SL/TP afterward.

SL and TP are submitted in the same market-order request.

---

## Break Even

Break Even is enabled by default.

```text
InpUseBreakEven     = true
InpBreakEvenTrigger = 150
InpBreakEvenOffset  = 0
```

When floating profit reaches:

```text
150 points
```

the EA attempts to move the Stop Loss toward:

```text
Entry Price ± BreakEvenOffset
```

With:

```text
BreakEvenOffset = 0
```

the target Break Even level corresponds to the original entry price.

For BUY:

```text
BE SL = Entry Price + Offset
```

For SELL:

```text
BE SL = Entry Price - Offset
```

The EA checks broker stop and freeze restrictions before modifying the position.

A Break Even modification is only accepted when it improves the existing Stop Loss.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailingStop  = true
InpTrailingStart    = 200
InpTrailingDistance = 100
InpTrailingStep     = 10
```

Trailing management begins after the position reaches:

```text
200 points
```

of floating profit.

For BUY:

```text
Candidate SL = Current Bid - 100 points
```

For SELL:

```text
Candidate SL = Current Ask + 100 points
```

The Stop Loss is only modified when the candidate improves the existing Stop Loss by at least:

```text
10 points
```

subject to tick-size and broker restrictions.

The EA does not intentionally move an existing Stop Loss backward.

---

## Break Even and Trailing Interaction

Break Even and Trailing Stop are evaluated during the same position-management cycle.

When both generate valid candidate Stop Loss levels, the EA retains the level that provides greater protection.

Conceptually for BUY:

```text
Current SL
    ↓
Break Even candidate
    ↓
Trailing candidate
    ↓
Choose highest valid protective SL
```

For SELL, the inverse applies.

Position management runs on every tick.

It is not restricted to new-candle events.

---

## Spread Filter

New entries are blocked when:

```text
Current Spread > InpMaxSpread
```

Baseline:

```text
InpMaxSpread = 30 points
```

The spread filter applies to **new entries**.

Position protection continues to operate every tick even when current spread exceeds the entry limit.

Therefore:

```text
High Spread
    ↓
New Entry       → BLOCKED
Break Even      → CONTINUES
Trailing Stop   → CONTINUES
```

---

## Lot Size

Baseline trading volume:

```text
InpLotSize = 0.01
```

During initialization, the EA validates the configured lot against:

```text
SYMBOL_VOLUME_MIN
SYMBOL_VOLUME_MAX
SYMBOL_VOLUME_STEP
```

An invalid lot configuration causes initialization to fail.

The EA does not silently increase a lot size that is below the broker's permitted minimum.

---

## Margin Check

Before submitting a market order, the EA calculates required margin using:

```text
OrderCalcMargin()
```

The trade is skipped when:

```text
Required Margin > Free Margin
```

or when the margin calculation fails.

---

## Broker Execution Checks

Before opening a trade, the EA verifies:

```text
Terminal connected
Terminal trading enabled
MQL trading enabled
Account trading enabled
Expert Advisor trading enabled
Valid Bid / Ask
Spread within limit
Symbol trading mode
Direction permitted
Market orders supported
Stop Loss supported
Take Profit supported
Broker stop distance
Available margin
Valid lot size
Valid tick size
```

These checks are execution safeguards.

They do not affect the underlying Two-Candle Break signal hypothesis.

---

## Default Parameters

| Parameter | Default | Description |
|---|---:|---|
| `InpLotSize` | 0.01 | Fixed trading volume |
| `InpStopLoss` | 300 | Stop Loss in points |
| `InpTakeProfit` | 600 | Take Profit in points |
| `InpMagicNumber` | 123064 | EA Magic Number |
| `InpSlippage` | 10 | Maximum execution deviation |
| `InpMaxSpread` | 30 | Maximum spread for new entry |
| `InpTimeframe` | M1 | Signal timeframe |
| `InpBreakoutLookback` | 20 | Historical range length |
| `InpBreakoutBuffer` | 0 | Additional breakout distance |
| `InpUseBreakEven` | true | Enable Break Even |
| `InpBreakEvenTrigger` | 150 | Profit before Break Even |
| `InpBreakEvenOffset` | 0 | Break Even offset |
| `InpUseTrailingStop` | true | Enable Trailing Stop |
| `InpTrailingStart` | 200 | Profit before trailing begins |
| `InpTrailingDistance` | 100 | Distance between market price and trailing SL |
| `InpTrailingStep` | 10 | Minimum SL improvement before modification |

---

## Core Difference From a One-Candle Breakout

The defining feature of EA-064 is the two-candle confirmation requirement.

A standard one-candle breakout can be represented as:

```text
Historical Range
      ↓
Breakout Candle
      ↓
ENTRY
```

EA-064 requires:

```text
Historical Range
      ↓
Breakout Candle #1
      ↓
Breakout Candle #2
      ↓
ENTRY
```

Both confirmation candles must close beyond the same fixed historical boundary.

This makes the strategy more selective than an otherwise equivalent one-candle breakout rule.

Whether this additional confirmation improves expectancy must be determined through backtesting.

---

## Important Implementation Detail

The historical breakout range deliberately excludes **both confirming candles**.

The implementation uses:

```text
GetRange(bars, 3, upper, lower)
```

The signal then evaluates:

```text
bars[2]
bars[1]
```

against that same range.

Therefore, the second confirmation candle does not redefine the breakout boundary.

This preserves the intended Two-Candle Break structure:

```text
Fixed Historical Range
        ↓
Confirmation #1
        ↓
Confirmation #2
```

rather than:

```text
Moving Range
→ Confirmation #1 changes range
→ Confirmation #2 tested against new range
```

---

## Research Objective

EA-064 is designed to isolate and test the effect of requiring persistent breakout confirmation across two completed candles.

The primary research question is:

> Does requiring two consecutive closes beyond the same historical range improve the quality of XAUUSD breakout entries?

Potential outcomes include:

```text
Higher signal quality
Lower false-break frequency
Lower trade frequency
Delayed entry
Reduced reward potential after confirmation
Different BUY / SELL behaviour
```

These are research possibilities, not conclusions.

They must be measured from backtest evidence.

---

## Research Scope

The baseline implementation currently tests:

```text
Instrument class: XAUUSD research
Primary timeframe: M1
Breakout lookback: 20
Confirmation: 2 completed candles
Breakout buffer: 0
SL: 300
TP: 600
Break Even: ON
Trailing Stop: ON
```

No profitability claim is made by the source implementation.

---

## Repository Location

```text
xauusd-mt5-ea-research/
│
└── EAs/
    └── EA-064_Two-Candle_Break/
        ├── EA-064_Two-Candle_Break.mq5
        └── README.md
```

---

## Status

```text
EA:                 EA-064_Two-Candle_Break
Strategy ID:        EA-064
Strategy:           Two-Candle Break
BUY Logic:          IMPLEMENTED
SELL Logic:         IMPLEMENTED
Two-Candle Confirm: IMPLEMENTED
Fixed Range:        IMPLEMENTED
Stop Loss:          IMPLEMENTED
Take Profit:        IMPLEMENTED
Break Even:         IMPLEMENTED
Trailing Stop:      IMPLEMENTED
Spread Filter:      IMPLEMENTED
Execution Checks:   IMPLEMENTED
Baseline Backtest:  NOT DOCUMENTED HERE
Optimization:       NOT DOCUMENTED HERE
Deployment Ready:   NOT DETERMINED
```

This README documents the EA implementation only.

Backtest results must be stored separately under:

```text
/Backtest/EA-064_Two-Candle_Break/
```

Research interpretation and conclusions must be based on retained test evidence rather than assumptions from the strategy logic.
