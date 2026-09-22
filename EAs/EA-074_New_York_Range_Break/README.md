# EA-074 — New York Range Break

## Overview

**EA-074_New_York_Range_Break** is an intraday session-range breakout Expert Advisor for MetaTrader 5.

The strategy builds a price range during a predefined broker/server-time window and then monitors completed M1 candles for confirmed breaks above or below that range.

The baseline implementation uses:

```text
Range Formation:
13:00 → 14:00 server time

Trading Window:
14:00 → 20:00 server time

Signal Timeframe:
M1
```

The configured hours are **broker/server time**.

They must not automatically be interpreted as New York local time.

---

## Strategy Concept

The EA follows the structure:

```text
13:00
   ↓
Begin Range Formation
   ↓
Collect completed M1 candles
   ↓
14:00
   ↓
Lock Range High / Range Low
   ↓
Monitor completed M1 candles
   ↓
Cross above Range High
        ↓
       BUY

Cross below Range Low
        ↓
       SELL
   ↓
Manage Position
   ↓
Stop accepting new entries at 20:00
```

The strategy therefore separates each trading day into:

```text
Range Formation
13:00 → 14:00

Breakout Trading
14:00 → 20:00
```

---

## Range Construction

For each trading day, the EA creates a range using completed M1 candles between:

```text
InpRangeStartHour = 13

InpRangeEndHour   = 14
```

The EA requests M1 data from:

```text
13:00:00
```

through:

```text
13:59:00
```

for the corresponding broker/server day.

The range boundaries are:

```text
Range High
=
Highest High
inside the configured range window


Range Low
=
Lowest Low
inside the configured range window
```

The EA explicitly requires complete historical coverage of the configured range before using it.

If the required M1 session data is incomplete, the signal is not evaluated until the data becomes available.

---

## Breakout Logic

After the range has been completed, the EA evaluates breakout conditions using completed M1 candles.

The breakout level includes:

```text
Breakout Buffer
```

defined in symbol points.

Baseline:

```text
InpBreakoutBuffer = 0
```

Therefore the baseline breakout boundaries are effectively:

```text
BUY Boundary
=
Range High

SELL Boundary
=
Range Low
```

---

## BUY Signal

A BUY signal requires a confirmed upward crossing of the Range High.

Conceptually:

```text
Previous completed candle:

Close <= Range High + Buffer

AND

Latest completed candle:

Close > Range High + Buffer
```

Equivalent structure:

```text
bars[2].close <= upper + pad

AND

bars[1].close > upper + pad
```

where:

```text
pad
=
InpBreakoutBuffer × Symbol Point
```

This means the EA requires a **crossing event**.

Simply remaining above the Range High does not continuously generate BUY signals.

---

## SELL Signal

A SELL signal requires a confirmed downward crossing of the Range Low.

Conceptually:

```text
Previous completed candle:

Close >= Range Low - Buffer

AND

Latest completed candle:

Close < Range Low - Buffer
```

Equivalent structure:

```text
bars[2].close >= lower - pad

AND

bars[1].close < lower - pad
```

The baseline therefore uses closed-candle confirmation rather than entering solely because an intrabar price temporarily moves outside the range.

---

## Signal Timing

The EA evaluates new entry signals only when a new M1 candle is detected.

The relevant breakout decision uses completed candles:

```text
bars[2]
=
previous completed candle

bars[1]
=
latest completed candle
```

The currently forming candle is not used as the completed breakout confirmation candle.

This reduces direct intrabar signal dependence.

---

## Trading Window

No breakout signal is accepted before the range has finished.

Baseline:

```text
Range End:
14:00
```

New breakout entries are evaluated after range completion until the configured cutoff:

```text
Trade End:
20:00
```

Therefore the baseline daily structure is:

```text
13:00 ───────── 14:00 ───────────────── 20:00
│                │                       │
│  Build Range   │   Breakout Trading    │
│                │                       │
└────────────────┴───────────────────────┘
```

No new entry signal is generated once the trading cutoff is reached.

Existing positions are still managed by the protective position-management logic.

---

## Multiple Breakout Attempts

The current implementation does **not** contain a permanent:

```text
One Trade Per Day
```

or:

```text
First Breakout Only
```

restriction.

The EA prevents another entry while an associated position or order is active.

However, after that position/order is closed or removed, a later valid crossing of the session range can generate another entry during the same trading window.

Conceptually:

```text
Range completed
      ↓
Breakout #1
      ↓
Trade
      ↓
Position closes
      ↓
Price returns across boundary
      ↓
New valid crossing
      ↓
Breakout #2 may be accepted
```

Therefore the baseline should be considered a:

```text
MULTIPLE BREAKOUT ATTEMPT
```

implementation rather than a strict one-breakout-per-day system.

---

## Default Inputs

### Execution

| Parameter | Default |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123074 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |

---

## Session Inputs

| Parameter | Default |
|---|---:|
| Range Start Hour | 13 |
| Range End Hour | 14 |
| Trade End Hour | 20 |

Baseline session:

```text
Range:
13:00 → 14:00

Trading:
14:00 → 20:00
```

All hours use broker/server time.

---

## Break Even

Break Even is enabled by default.

```text
Use Break Even:
true

Trigger:
150 points

Offset:
0 points
```

When floating profit reaches:

```text
150 points
```

the EA can move the Stop Loss toward the entry price, subject to broker stop/freeze restrictions.

With:

```text
BreakEvenOffset = 0
```

the target Break Even level corresponds to the entry price.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
Use Trailing Stop:
true

Trailing Start:
200 points

Trailing Distance:
100 points

Trailing Step:
10 points
```

Trailing begins only after floating profit reaches:

```text
200 points
```

The candidate Stop Loss is maintained approximately:

```text
100 points
```

behind the current executable market price, subject to:

```text
Broker Stop Level

Broker Freeze Level

Tick Size

Trailing Step
```

constraints.

The EA only modifies the Stop Loss when the candidate level improves the existing protection.

---

## Position Management

Protective position management runs:

```text
EVERY TICK
```

rather than only once per new M1 candle.

This includes:

```text
Break Even

Trailing Stop
```

management.

Entry signals, by contrast, are evaluated on new-bar detection.

The architecture therefore separates:

```text
ENTRY LOGIC
=
New M1 candle

POSITION MANAGEMENT
=
Every tick
```

---

## Stop Loss / Take Profit

Baseline:

```text
Stop Loss:
300 points

Take Profit:
600 points
```

The EA calculates protective prices directly from the market-entry price.

For BUY:

```text
SL = Entry - 300 points

TP = Entry + 600 points
```

For SELL:

```text
SL = Entry + 300 points

TP = Entry - 600 points
```

Protective SL and TP prices are submitted with the original market-order request.

---

## Broker Stop Validation

Before opening a trade, the EA checks the symbol's:

```text
SYMBOL_TRADE_STOPS_LEVEL
```

and ensures the configured SL/TP distances satisfy broker requirements.

If the protective levels are invalid for the broker's minimum stop distance:

```text
Entry is skipped
```

rather than opening an unprotected position.

---

## Spread Filter

Baseline:

```text
Maximum Spread
=
30 points
```

Before entry:

```text
Spread
=
Ask - Bid
```

is converted into symbol points.

If:

```text
Current Spread
>
30 points
```

the entry is rejected.

The spread filter applies to new entries.

Protective position management can continue even when the spread is too high for a new entry.

---

## Fixed Position Size

The baseline uses:

```text
Lot Size = 0.01
```

Position size is fixed.

The EA does not currently calculate lot size from:

```text
Account Balance

Account Equity

Risk Percentage

Stop-Loss Risk
```

Therefore:

```text
Lot Size
≠
Risk-based position sizing
```

---

## Lot Validation

During initialization, the EA validates the configured lot against the symbol's:

```text
Minimum Volume

Maximum Volume

Volume Step
```

An invalid lot size causes initialization to fail.

The EA does not silently increase the configured lot to the broker minimum.

---

## Entry Blocking

Before opening a new position, the EA checks existing positions and orders.

For the configured Magic Number:

```text
123074
```

the EA permits at most one associated active position/order across the account.

Therefore:

```text
Existing EA-074 position/order
        ↓
New EA-074 entry blocked
```

---

## Netting Account Protection

The implementation also detects whether the account uses a netting margin mode.

On a netting account, if another position already exists on the same symbol:

```text
New EA-074 entry is blocked
```

This behavior is intended to prevent EA-074 from unintentionally merging its exposure with another strategy's position on the same symbol.

---

## Magic Number

Baseline:

```text
InpMagicNumber = 123074
```

The Magic Number is used to identify EA-074 positions and orders.

Position-management logic applies only to positions matching:

```text
Current Symbol

AND

Magic Number 123074
```

---

## Trade Permissions

Before trading, the EA verifies that automated trading is allowed by:

```text
Terminal

MQL program

Trading account

Expert Advisor permissions
```

If trading is unavailable, the EA does not attempt to open or manage trades.

---

## Symbol Trading Mode

Before entry, the EA checks the symbol's trading permissions.

Entries are rejected when the symbol is:

```text
Trading Disabled

or

Close Only
```

Direction-specific restrictions are also respected:

```text
Long Only

Short Only
```

The EA additionally verifies support for:

```text
Market Orders

Stop Loss

Take Profit
```

before sending an entry.

---

## Margin Validation

Before opening a trade, the EA calculates the estimated required margin.

Entry is skipped when:

```text
Required Margin
>
Free Margin
```

or when margin calculation fails.

---

## Price Normalization

SL, TP, Break Even, and Trailing Stop prices are normalized according to:

```text
Symbol Tick Size

Symbol Digits
```

The implementation uses directional rounding functions:

```text
RoundDown()

RoundUp()
```

to generate broker-compatible price levels.

---

## Broker Stop / Freeze Protection

Position modifications account for:

```text
SYMBOL_TRADE_STOPS_LEVEL

SYMBOL_TRADE_FREEZE_LEVEL
```

The EA does not intentionally move protective levels into invalid broker zones.

Existing SL/TP freeze conditions are also checked before modification.

---

## Initialization Protection

The EA validates important inputs during initialization.

Invalid configurations are rejected.

Examples include:

```text
Lot Size <= 0

Stop Loss <= 0

Take Profit <= 0

Magic Number = 0

Negative Slippage

Negative Maximum Spread

Invalid Breakout Lookback

Negative Breakout Buffer

Invalid Break Even configuration

Invalid Trailing configuration

Invalid Session Hours

Non-M1 Timeframe
```

---

## Timeframe Restriction

Although the timeframe is represented by an input:

```text
InpTimeframe
```

the current implementation explicitly requires:

```text
InpTimeframe = PERIOD_M1
```

during initialization.

Therefore EA-074 is currently an:

```text
M1-only implementation
```

unless the source code is modified.

---

## Server-Time Warning

The source code explicitly treats:

```text
13:00 → 14:00
```

as server hours.

Therefore:

```text
13:00 server time
```

must not automatically be interpreted as:

```text
13:00 New York time
```

The actual market session represented by these hours depends on:

```text
Broker server timezone

UTC offset

Daylight Saving Time

New York EST / EDT state
```

This is an important variable for subsequent research.

---

## Important Implementation Detail

The session range itself is constructed from:

```text
PERIOD_M1
```

completed candles.

The source explicitly verifies that the copied session data covers the entire configured range from:

```text
Range Start
```

through:

```text
Range End - 1 minute
```

before calculating the session High and Low.

This prevents a partially loaded session range from being treated as a complete range.

---

## Baseline Strategy Summary

```text
EA:
EA-074_New_York_Range_Break

Platform:
MetaTrader 5

Language:
MQL5

Strategy:
Session Range Breakout

Timeframe:
M1

Range:
13:00 → 14:00 server time

Trading Window:
14:00 → 20:00 server time

BUY:
Completed-candle crossing
above Range High

SELL:
Completed-candle crossing
below Range Low

Breakout Buffer:
0

Lot:
0.01

SL:
300 points

TP:
600 points

Maximum Spread:
30 points

Break Even:
ON
150 / 0

Trailing:
ON
200 / 100 / 10

Magic:
123074
```

---

## Current Research State

At this stage:

```text
Source Code:
AVAILABLE

Implementation Documentation:
COMPLETED

Baseline Backtest:
PENDING

Baseline Performance:
NOT YET CLASSIFIED

Research Analysis:
PENDING

Optimization:
NOT STARTED

Out-of-Sample Validation:
NOT STARTED

Walk-Forward Validation:
NOT STARTED

Forward Test:
NOT STARTED

Live Validation:
NOT STARTED
```

No profitability conclusion should be made from the source code alone.

---

## Repository Structure

```text
EAs/
└── EA-074_New_York_Range_Break/
    ├── EA-074_New_York_Range_Break.mq5
    └── README.md
```

The source file contains the executable strategy implementation.

This README documents the behavior of that implementation.

---

## Next Evidence Stage

The next stage is the baseline MetaTrader 5 backtest.

Required evidence should include:

```text
Original MT5 Strategy Tester HTML report

Balance chart

Entry distribution chart

MFE / MAE chart

Holding-time chart
```

After the raw backtest evidence is available, the baseline can be classified and the controlled research stage can begin.

---

## Disclaimer

EA-074 is currently a quantitative research implementation.

The presence of source code does not establish profitability or suitability for live trading.

Historical backtests, when subsequently performed, will not guarantee future performance.

XAUUSD and other leveraged financial instruments involve substantial risk.
