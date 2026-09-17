# EA-066 — Failed Retest Break

## Overview

**EA-066_Failed_Retest_Break** is a MetaTrader 5 Expert Advisor designed to trade a multi-stage breakout continuation structure.

The EA does not enter on the initial breakout.

Instead, it:

```text
Defines a recent price range
        ↓
Detects a breakout
        ↓
Stores the breakout level and breakout-candle extreme
        ↓
Waits for price to retest the broken level
        ↓
Requires the retest candle to reject the level
        ↓
Waits for a later candle to break the original breakout-candle extreme
        ↓
Enters in the breakout direction
```

This additional confirmation stage distinguishes EA-066 from a basic breakout or immediate breakout-retest entry system.

---

## Strategy Type

```text
Strategy Family : Breakout / Retest / Continuation
Platform        : MetaTrader 5
Language        : MQL5
Default TF      : M1
Target Research : XAUUSD
EA ID           : EA-066
Version         : 1.00
```

The implementation itself uses `_Symbol` and is therefore not hard-coded exclusively to XAUUSD.

---

# 1. Range Detection

The EA constructs a historical breakout range using:

```text
InpBreakoutLookback = 20
```

completed candles.

The range is calculated from candles beginning at shift `2`.

This means the breakout signal candle at shift `1` is excluded from the historical range.

The range consists of:

```text
Upper Range = Highest High of previous lookback candles
Lower Range = Lowest Low of previous lookback candles
```

Default:

```text
Lookback = 20 bars
```

---

# 2. Initial Breakout Detection

The latest completed candle is evaluated against the historical range.

## Bullish Breakout

```text
Close[1] > Upper Range + Breakout Buffer
```

## Bearish Breakout

```text
Close[1] < Lower Range - Breakout Buffer
```

Default:

```text
InpBreakoutBuffer = 0 points
```

No trade is opened when the breakout is first detected.

Instead, the EA stores the breakout setup.

---

# 3. Stored Breakout Information

When a breakout occurs, the EA stores:

```text
Breakout Direction
Breakout Time
Broken Range Level
Breakout Candle Extreme
```

For a bullish breakout:

```text
setup_level   = previous Upper Range
setup_extreme = breakout candle High
```

For a bearish breakout:

```text
setup_level   = previous Lower Range
setup_extreme = breakout candle Low
```

The original breakout-candle extreme later becomes the final continuation trigger.

---

# 4. Retest Waiting Stage

After the initial breakout, the EA waits for price to return toward the broken range boundary.

Default parameters:

```text
InpRetestTolerance = 20 points
InpRetestMaxBars   = 10 bars
```

The EA therefore allows price to approach the breakout level within the configured tolerance.

---

# 5. Setup Invalidation

A setup is cancelled if price closes back inside the previous range.

## Bullish Setup

Invalid when:

```text
Close <= setup_level
```

## Bearish Setup

Invalid when:

```text
Close >= setup_level
```

This means the EA requires the broken range level to continue acting as support after a bullish breakout or resistance after a bearish breakout.

The setup is also cancelled when it becomes older than the configured retest window.

---

# 6. Valid Retest

A retest requires both:

```text
Touch
+
Directional rejection
```

## Bullish Retest

The candle must satisfy:

```text
Low <= setup_level + RetestTolerance
```

and:

```text
Close > setup_level + BreakoutBuffer
Close > Open
```

Therefore the candle must:

```text
Return toward the broken resistance
+
Remain above the broken level at close
+
Close bullish
```

## Bearish Retest

The candle must satisfy:

```text
High >= setup_level - RetestTolerance
```

and:

```text
Close < setup_level - BreakoutBuffer
Close < Open
```

Therefore the candle must:

```text
Return toward the broken support
+
Remain below the broken level at close
+
Close bearish
```

When this happens, the EA records:

```text
retest_time
```

No trade is opened on the retest candle.

---

# 7. Separate Continuation Candle Required

EA-066 explicitly requires a new completed candle after the retest candle.

The retest candle itself cannot trigger the entry.

The sequence must therefore be:

```text
Breakout Candle
        ↓
Retest / Rejection Candle
        ↓
Later Continuation Candle
        ↓
Entry
```

---

# 8. Final Entry Trigger

After a valid retest has been recorded, subsequent completed candles are checked against the extreme of the original breakout candle.

## BUY Trigger

```text
Close > breakout candle High + Breakout Buffer
```

## SELL Trigger

```text
Close < breakout candle Low - Breakout Buffer
```

Only after this continuation break does the EA generate a trading direction.

This means the EA requires the market to exceed the original breakout candle's extreme after the retest.

---

# 9. BUY Sequence

The complete BUY structure is:

```text
Historical range identified
        ↓
Completed candle closes above Upper Range
        ↓
Store Upper Range as breakout level
        ↓
Store breakout candle High
        ↓
Wait for later candle
        ↓
Price returns toward breakout level
        ↓
Retest candle remains above level
        ↓
Retest candle closes bullish
        ↓
Wait for a distinct later candle
        ↓
Later candle closes above original breakout candle High
        ↓
BUY
```

---

# 10. SELL Sequence

The complete SELL structure is:

```text
Historical range identified
        ↓
Completed candle closes below Lower Range
        ↓
Store Lower Range as breakout level
        ↓
Store breakout candle Low
        ↓
Wait for later candle
        ↓
Price returns toward breakout level
        ↓
Retest candle remains below level
        ↓
Retest candle closes bearish
        ↓
Wait for a distinct later candle
        ↓
Later candle closes below original breakout candle Low
        ↓
SELL
```

---

# 11. Default Parameters

## Execution

| Parameter | Default | Description |
|---|---:|---|
| `InpLotSize` | 0.01 | Fixed lot size |
| `InpStopLoss` | 300 | Initial Stop Loss in points |
| `InpTakeProfit` | 600 | Initial Take Profit in points |
| `InpMagicNumber` | 123066 | EA Magic Number |
| `InpSlippage` | 10 | Maximum order deviation |
| `InpMaxSpread` | 30 | Maximum entry spread |
| `InpTimeframe` | M1 | Signal timeframe |
| `InpBreakoutLookback` | 20 | Historical range length |
| `InpBreakoutBuffer` | 0 | Breakout confirmation buffer |

## Retest

| Parameter | Default | Description |
|---|---:|---|
| `InpRetestTolerance` | 20 | Allowed distance from breakout level |
| `InpRetestMaxBars` | 10 | Maximum setup lifetime |

## Break Even

| Parameter | Default |
|---|---:|
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenOffset` | 0 |

## Trailing Stop

| Parameter | Default |
|---|---:|
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 100 |
| `InpTrailingStep` | 10 |

---

# 12. Initial Stop Loss and Take Profit

Default protection:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

The protective SL and TP are submitted together with the initial market order.

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

Before submitting the trade, the EA checks whether the configured protective levels satisfy the broker's minimum stop-distance requirements.

If the SL or TP is invalid, the entry is skipped.

---

# 13. Break Even

Break Even is enabled by default.

```text
InpUseBreakEven     = true
InpBreakEvenTrigger = 150
InpBreakEvenOffset  = 0
```

When the open position reaches at least:

```text
150 points profit
```

the EA attempts to move Stop Loss toward:

```text
Entry Price + Offset
```

With the default offset:

```text
Offset = 0
```

the Break Even target is the original entry price.

Broker Stop Level and Freeze Level restrictions are checked before modification.

---

# 14. Trailing Stop

Trailing Stop is enabled by default.

```text
InpTrailingStart    = 200
InpTrailingDistance = 100
InpTrailingStep     = 10
```

Trailing management begins after:

```text
200 points profit
```

The EA then attempts to maintain SL approximately:

```text
100 points
```

behind the current market price.

The Stop Loss must improve by at least:

```text
10 points
```

before another modification is submitted.

The EA never intentionally moves an existing Stop Loss backward.

---

# 15. Spread Filter

New entries require:

```text
Current Spread <= InpMaxSpread
```

Default:

```text
InpMaxSpread = 30 points
```

If spread exceeds this threshold:

```text
No new trade is opened.
```

Existing-position management continues to operate independently.

---

# 16. Position Control

EA-066 prevents duplicate exposure.

For its own Magic Number:

```text
123066
```

the EA allows at most one active position or pending order across the account.

On netting accounts, the EA also blocks a new entry if another position or order already exists on the same symbol.

This prevents accidental merging of EA-066 exposure with another strategy on a netting account.

---

# 17. Signal Timing

Strategy signals are evaluated only when a new candle begins.

The analysis therefore uses completed candles.

Default:

```text
InpTimeframe = M1
```

Trade-management functions such as:

```text
Break Even
Trailing Stop
```

run on every tick.

---

# 18. Startup Protection

When the EA is first attached to a chart, it records the current candle time.

It does not immediately evaluate and trade an old historical signal.

Signal processing begins from subsequent candles.

---

# 19. Execution Safety

Before opening a trade, EA-066 checks:

```text
Terminal connection
Terminal trading permission
MQL trading permission
Account trading permission
EA trading permission
Symbol trading mode
Market-order support
Stop Loss support
Take Profit support
Current spread
Existing EA exposure
Broker stop distance
Available margin
Configured lot size
Symbol minimum lot
Symbol maximum lot
Symbol volume step
```

If a configured lot size is invalid, the EA returns an initialization error.

It does not silently increase the position size.

---

# 20. Order Execution

The EA uses:

```cpp
#include <Trade\Trade.mqh>
```

and the MetaTrader `CTrade` class.

Orders are submitted synchronously.

Trade comment:

```text
EA-066
```

Magic Number:

```text
123066
```

---

# 21. Strategy Characteristics

EA-066 is intentionally more selective than a simple breakout entry.

It requires three distinct structural stages:

```text
1. Initial breakout
2. Retest and rejection
3. Break of original breakout extreme
```

The final entry therefore occurs only after price demonstrates renewed continuation following the retest.

Whether this additional confirmation improves expectancy must be determined through backtesting.

No profitability claim is made from the strategy logic alone.

---

# 22. Important Implementation Detail

The final continuation trigger uses:

```text
setup_extreme
```

which is defined from the **original breakout candle**.

For BUY:

```text
setup_extreme = breakout candle High
```

For SELL:

```text
setup_extreme = breakout candle Low
```

It does **not** use the High or Low of the retest candle as the final breakout threshold.

This distinction should be preserved when reproducing or modifying EA-066.

---

# 23. Setup Lifecycle

The internal setup follows:

```text
NO SETUP
   ↓
BREAKOUT DETECTED
   ↓
WAITING FOR RETEST
   ↓
RETEST RECORDED
   ↓
WAITING FOR BREAKOUT-EXTREME BREAK
   ↓
SIGNAL
   ↓
RESET
```

The setup also resets if:

```text
Price closes back inside the old range

or

The setup exceeds InpRetestMaxBars
```

---

# 24. Source File

```text
EA-066_Failed_Retest_Break.mq5
```

Version:

```text
1.00
```

Description:

```text
EA-066 Failed_Retest_Break
```

---

# 25. Files

```text
EAs/
└── EA-066_Failed_Retest_Break/
    ├── EA-066_Failed_Retest_Break.mq5
    └── README.md
```

---

# 26. Backtest Evidence

Backtest evidence should be stored separately under:

```text
Backtest/
└── EA-066_Failed_Retest_Break/
```

The EA source directory should document implementation and default configuration.

Performance conclusions belong in the Backtest and Research directories.

---

# 27. Current Status

```text
EA ID              = EA-066
Strategy           = Failed Retest Break
Platform           = MetaTrader 5
Language           = MQL5
Default Timeframe  = M1
Target Research    = XAUUSD
Source Code        = AVAILABLE
Backtest Status    = PENDING / SEE BACKTEST DIRECTORY
Research Status    = NOT YET VALIDATED
Live Trading       = NOT APPROVED
```

The source implementation is available.

No conclusion regarding profitability, robustness, or live suitability should be made until supported by Strategy Tester evidence and subsequent validation.
