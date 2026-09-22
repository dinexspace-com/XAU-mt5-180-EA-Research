# EA-073 — London Range Break

## Overview

**EA-073_London_Range_Break** is an intraday range-breakout Expert Advisor developed for MetaTrader 5.

The strategy builds a price range during a predefined London-session window and then monitors completed M1 candles for a confirmed breakout above or below that range.

The baseline implementation uses:

```text
Range Formation:
08:00 → 09:00

Trading Window:
09:00 → 13:00
```

All session hours are **broker/server time**.

The EA does not automatically convert these hours to London local time, UTC, BST, GMT, or any other timezone.

---

## Strategy Concept

The strategy follows this structure:

```text
London Range Formation
08:00 → 09:00
        ↓
Calculate Range High
and Range Low
        ↓
Range Completed
        ↓
Monitor completed M1 candles
        ↓
Break above Range High
        │
        └── BUY

Break below Range Low
        │
        └── SELL
        ↓
No new breakout entries
after 13:00
```

The hypothesis is that price expansion after the configured London range may produce short-term directional continuation.

This is a research hypothesis and does not imply that the strategy is profitable.

---

## Range Construction

The range is built exclusively from completed M1 candles inside the configured range window.

Default:

```text
Range Start = 08:00
Range End   = 09:00
```

The EA retrieves M1 data covering:

```text
08:00:00
→
08:59:00
```

and calculates:

```text
Range High
=
Highest High inside the range

Range Low
=
Lowest Low inside the range
```

Conceptually:

```text
          Range High
──────────────────────────
       │       │
   │   │   │   │
   │   │   │   │
   │ │ │   │ │ │
──────────────────────────
          Range Low

08:00                  09:00
```

The implementation requires complete M1 coverage of the configured range.

If the required historical range is only partially loaded, the EA does not evaluate a breakout signal from incomplete session data.

---

## Breakout Logic

After the range is completed, the EA evaluates completed M1 candles.

### BUY

A BUY breakout requires the previous completed candle to be at or below the upper breakout level and the latest completed candle to close above it.

Conceptually:

```text
Previous Close <= Range High + Buffer

AND

Latest Close > Range High + Buffer
```

Result:

```text
BUY
```

---

### SELL

A SELL breakout requires the previous completed candle to be at or above the lower breakout level and the latest completed candle to close below it.

Conceptually:

```text
Previous Close >= Range Low - Buffer

AND

Latest Close < Range Low - Buffer
```

Result:

```text
SELL
```

This is a crossing condition rather than a simple persistent state outside the range.

---

## Breakout Buffer

The breakout threshold can be displaced from the session boundary using:

```text
InpBreakoutBuffer
```

For BUY:

```text
Breakout Level
=
Range High + Breakout Buffer
```

For SELL:

```text
Breakout Level
=
Range Low - Breakout Buffer
```

Baseline:

```text
InpBreakoutBuffer = 0
```

Therefore the baseline requires a completed candle close beyond the actual range boundary without an additional breakout-distance requirement.

---

## Trading Window

Default configuration:

```text
Range:
08:00 → 09:00

Trading:
09:00 → 13:00
```

The EA does not generate a breakout entry before the range has finished.

It also prevents new breakout entries when the current bar reaches the configured trade cutoff.

Therefore the default daily structure is:

```text
00:00
  │
  │
08:00
  │
  ├── London Range Starts
  │
09:00
  │
  ├── London Range Complete
  │
  ├── Breakout Trading Enabled
  │
13:00
  │
  └── New Breakout Entries End
```

These are **server-time hours**.

---

## Signal Timing

The EA operates on:

```text
PERIOD_M1
```

and validates during initialization that the configured timeframe is M1.

Entry logic is evaluated when a new M1 candle becomes available.

The breakout decision uses completed candles rather than the still-forming candle.

This reduces dependence on temporary intrabar penetration of the London range.

---

## Baseline Inputs

### Execution

| Input | Default |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpMagicNumber` | 123073 |
| `InpSlippage` | 10 |
| `InpMaxSpread` | 30 |
| `InpTimeframe` | M1 |
| `InpBreakoutLookback` | 20 |
| `InpBreakoutBuffer` | 0 |

### Break Even

| Input | Default |
|---|---:|
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenOffset` | 0 |

### Trailing Stop

| Input | Default |
|---|---:|
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 100 |
| `InpTrailingStep` | 10 |

### Session

| Input | Default |
|---|---:|
| `InpRangeStartHour` | 8 |
| `InpRangeEndHour` | 9 |
| `InpTradeEndHour` | 13 |

---

## Baseline Risk Structure

The default protective configuration is:

```text
Lot Size = 0.01

Stop Loss
= 300 points

Take Profit
= 600 points
```

This creates a nominal SL/TP distance relationship of:

```text
300 : 600
=
1 : 2
```

However, realized trade outcomes do not necessarily maintain this relationship because Break Even and Trailing Stop can modify the Stop Loss after entry.

---

## Position Sizing

EA-073 uses:

```text
FIXED LOT SIZE
```

Baseline:

```text
0.01 lot
```

The current implementation does not calculate position size from:

```text
Account Balance
Account Equity
Risk %
Stop-Loss monetary risk
```

Therefore:

```text
InpLotSize
```

directly controls trade volume.

The EA validates the requested lot against the symbol's:

```text
Minimum Volume
Maximum Volume
Volume Step
```

An invalid lot size causes initialization to fail.

The implementation does not silently increase the requested lot size.

---

## Spread Filter

Before opening a position, the EA calculates the current spread.

Baseline maximum:

```text
InpMaxSpread = 30 points
```

If:

```text
Current Spread > 30 points
```

the entry is rejected.

The spread restriction applies to new entries.

Protective position management continues to run on every tick even when the spread is too high for a new entry.

---

## Stop Loss

Baseline:

```text
InpStopLoss = 300 points
```

For BUY:

```text
SL = Entry Price - 300 points
```

For SELL:

```text
SL = Entry Price + 300 points
```

Protective SL and TP prices are submitted together with the market-order request.

The EA also checks the broker's minimum stop-distance requirements before submitting an entry.

If the configured protective levels violate the broker's required stop distance, the trade is skipped.

---

## Take Profit

Baseline:

```text
InpTakeProfit = 600 points
```

For BUY:

```text
TP = Entry Price + 600 points
```

For SELL:

```text
TP = Entry Price - 600 points
```

Prices are normalized according to the symbol's tick size and price precision.

---

## Break Even

Break Even is enabled by default.

```text
InpUseBreakEven     = true
InpBreakEvenTrigger = 150
InpBreakEvenOffset  = 0
```

When open profit reaches:

```text
150 points
```

the EA attempts to move the Stop Loss toward the entry price.

With the baseline offset:

```text
BreakEvenOffset = 0
```

the target Break Even level is the entry price, subject to tick-size normalization and broker stop/freeze restrictions.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
InpTrailingStart    = 200
InpTrailingDistance = 100
InpTrailingStep     = 10
```

Trailing begins when open profit reaches at least:

```text
200 points
```

The EA then attempts to maintain the Stop Loss approximately:

```text
100 points
```

behind the current executable price.

The existing Stop Loss is only modified when the new trailing level improves it by at least the configured trailing step, subject to broker constraints.

---

## Broker Protection

Before entry, the EA checks:

```text
Terminal connection
Terminal trading permission
MQL trading permission
Account trading permission
Expert Advisor trading permission
```

It also validates:

```text
Symbol trade mode
Market-order support
SL support
TP support
Spread
Broker stop distance
Available margin
Lot-size constraints
```

A trade is skipped when these conditions are not satisfied.

---

## Stop / Freeze-Level Handling

Position management considers both:

```text
SYMBOL_TRADE_STOPS_LEVEL
```

and:

```text
SYMBOL_TRADE_FREEZE_LEVEL
```

when modifying protective stops.

This applies to Break Even and Trailing Stop management.

The EA avoids submitting a new Stop Loss when the requested level conflicts with the broker's current stop/freeze restrictions.

---

## Position / Order Control

EA-073 prevents another entry when an existing position or order associated with:

```text
Magic Number = 123073
```

already exists.

Conceptually:

```text
Existing EA-073 position/order
        ↓
Block new entry
```

Therefore the EA allows at most one position/order associated with its Magic Number across the account at a time.

---

## Netting Account Protection

The implementation explicitly checks whether the account is operating in netting mode.

On a netting account, the EA blocks entry if another position or order already exists on the same symbol.

This prevents EA-073 from unintentionally merging its XAUUSD exposure with another strategy's position on the same symbol.

---

## Margin Check

Before submitting a trade, the EA calculates required margin using:

```text
OrderCalcMargin()
```

and compares it with available account free margin.

If:

```text
Required Margin
>
Free Margin
```

the entry is skipped.

---

## Session Data Validation

The EA explicitly verifies that the complete configured M1 range has been loaded.

For the default session it expects coverage from:

```text
08:00
through
08:59
```

before calculating the range.

This prevents a partially loaded historical session from creating an incorrect London High or London Low.

---

## Attachment Behavior

When the EA is initialized, it records the current candle as the starting reference.

Therefore it waits for the next candle before evaluating a new signal.

This prevents the EA from immediately entering based on an old breakout signal that existed before the EA was attached to the chart.

---

## Instrument

The EA operates using:

```text
_Symbol
```

rather than hard-coding a broker-specific symbol name.

The research target for this repository is:

```text
XAUUSD
```

Broker symbol names may differ, for example:

```text
XAUUSD
XAUUSD.PRO
XAUUSDm
GOLD
```

Symbol specifications must therefore be checked when reproducing tests across brokers.

---

## Timezone Warning

The following defaults:

```text
08:00
09:00
13:00
```

are **server hours**.

They are not automatically converted into London local time.

Therefore:

```text
08:00 server time
≠ necessarily
08:00 London time
```

Broker timezone and daylight-saving behavior can materially change which real-world market period is captured by the configured range.

Any backtest or live evaluation must document the broker/server-time relationship.

---

## Research Hypothesis

EA-073 tests the following hypothesis:

> A breakout beyond a price range established during the configured London-session window may contain information about subsequent short-term directional movement in XAUUSD.

The implementation separates the day into:

```text
Range Formation
        ↓
Range Completion
        ↓
Breakout Detection
        ↓
Directional Entry
```

The hypothesis must be evaluated empirically.

The existence of a session breakout does not by itself establish a profitable trading edge.

---

## Research Questions

EA-073 is intended to provide a reproducible baseline for questions including:

```text
Does London Range breakout
produce positive expectancy?

Does range size matter?

Does breakout time matter?

Does breakout displacement matter?

Are BUY and SELL results symmetric?

Does the first breakout behave differently
from repeated breakout attempts?

Does volatility affect breakout quality?

Does breakout retest improve entry quality?

Which server-time mapping best represents
the intended London market period?

How sensitive is the strategy to
Break Even and Trailing Stop?
```

These questions should be tested independently through controlled experiments rather than changing many strategy components simultaneously.

---

## Current Status

```text
EA:
EA-073_London_Range_Break

Source Code:
COMPLETED

Strategy Documentation:
COMPLETED

Baseline Backtest:
NOT DOCUMENTED HERE

Baseline Profitability:
NOT YET DETERMINED

Optimization:
NOT VALIDATED

Out-of-Sample:
NOT TESTED

Walk-Forward:
NOT TESTED

Forward Test:
NOT TESTED
```

No profitability conclusion is made in this README because this file documents the **strategy implementation**, not the results of a Strategy Tester run.

Backtest evidence should be maintained separately under:

```text
/Backtest/EA-073_London_Range_Break/
```

---

## Files

```text
EAs/
└── EA-073_London_Range_Break/
    ├── EA-073_London_Range_Break.mq5
    └── README.md
```

---

## Related Repository Sections

Implementation:

```text
/EAs/EA-073_London_Range_Break/
```

Backtest evidence:

```text
/Backtest/EA-073_London_Range_Break/
```

Research:

```text
/Research/
```

Research methodology:

```text
/docs/methodology.md
```

---

## Disclaimer

This Expert Advisor is maintained for quantitative strategy research, software development, and historical testing.

Backtests, simulations, and historical observations do not guarantee future performance.

EA-073 should not be considered validated for live trading until the required research and validation stages have been completed.
