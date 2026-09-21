# EA-071 — Breakout ATR Filter

## Overview

**EA-071_Breakout_ATR_Filter** is an Expert Advisor for MetaTrader 5 designed to research whether a price breakout occurring during above-average volatility can provide a measurable trading edge on XAUUSD.

The strategy combines:

- Price-range breakout
- ATR volatility confirmation
- Fixed Stop Loss / Take Profit
- Break Even
- Trailing Stop
- Spread filtering
- Single-position / order control
- Broker execution validation

The default research timeframe is:

```text
M1
```

EA-071 is an experimental research strategy.

The source code alone does not establish profitability or suitability for live trading.

---

## Research Hypothesis

EA-071 tests the hypothesis:

> A breakout may have a higher probability of continuation when it occurs during a period of volatility that is greater than the recent average volatility.

The strategy therefore combines:

```text
Price Breakout
        +
Current ATR > Previous Average ATR
        ↓
Trade
```

ATR is used as a **volatility confirmation filter**.

It does not determine trade direction.

Direction is determined entirely by the price breakout.

---

## Core Strategy Structure

The baseline strategy can be summarized as:

```text
                 XAUUSD M1
                     │
                     ▼
          Previous 20-Bar Range
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
   Close > Range High    Close < Range Low
          │                     │
          ▼                     ▼
     BUY Candidate        SELL Candidate
          │                     │
          └──────────┬──────────┘
                     ▼
                 ATR(14)
                     >
       Previous 20-Bar Average ATR
                     │
                     ▼
             Execution Checks
                     │
                     ▼
                   Trade
```

---

## Signal Timing

Entry signals are evaluated only when a new candle begins.

The strategy uses the most recently completed candle:

```text
bars[1]
```

as the breakout signal candle.

The historical breakout range begins from:

```text
bars[2]
```

Therefore the signal candle itself is excluded from the historical range used to define the breakout.

This prevents the breakout candle from contributing to the range it is attempting to break.

---

## Breakout Range

The default breakout lookback is:

```text
InpBreakoutLookback = 20
```

The EA calculates:

```text
Upper = Highest High of bars [2 ... 21]

Lower = Lowest Low of bars [2 ... 21]
```

Default breakout parameters:

```text
Breakout Lookback = 20
Breakout Buffer   = 0
```

---

## Breakout Direction

The function:

```text
BreakDirection()
```

determines trade direction.

### BUY Breakout

A BUY breakout exists when:

```text
Close[1] > Upper Range + Breakout Buffer
```

With the default buffer:

```text
Breakout Buffer = 0
```

the condition becomes:

```text
Close[1] > Highest High(previous 20 bars)
```

---

### SELL Breakout

A SELL breakout exists when:

```text
Close[1] < Lower Range - Breakout Buffer
```

With the default buffer:

```text
Breakout Buffer = 0
```

the condition becomes:

```text
Close[1] < Lowest Low(previous 20 bars)
```

---

## ATR Filter

EA-071 creates an ATR indicator using:

```text
iATR(_Symbol, InpTimeframe, InpATRPeriod)
```

Default:

```text
ATR Period = 14
```

The ATR value of the breakout candle is read using:

```text
shift = 1
```

Therefore:

```text
Current ATR = ATR[1]
```

which corresponds to the most recently completed candle.

---

## ATR Historical Average

The strategy calculates the historical ATR average from:

```text
ATR[2]
ATR[3]
...
ATR[21]
```

when:

```text
ATR Mean Period = 20
```

Conceptually:

```text
ATR Mean =
(
 ATR[2]
+ ATR[3]
+ ...
+ ATR[21]
)
/
20
```

The breakout candle ATR:

```text
ATR[1]
```

is excluded from the historical average.

This is important because the EA compares the breakout candle's volatility against volatility that existed before the breakout.

---

## ATR Confirmation Rule

The baseline volatility condition is:

```text
ATR[1] > Average ATR[2...21]
```

Only when this condition is true does the EA evaluate breakout direction.

The implemented sequence is:

```text
Read ATR[1]
      ↓
Calculate Average ATR[2...21]
      ↓
ATR[1] > Average ATR?
      │
   ┌──┴──┐
   │     │
  NO    YES
   │     │
Reject   ▼
       Evaluate
       Breakout
```

Equality is not sufficient.

If:

```text
ATR[1] <= Average ATR
```

no trade signal is generated.

---

## Complete BUY Logic

The baseline BUY logic is:

```text
ATR(14)[1]
>
Average ATR(14) of previous 20 bars

AND

Close[1]
>
Highest High of previous 20 bars
+
Breakout Buffer
```

With the default Breakout Buffer of zero:

```text
ATR(14)[1] > Previous 20-Bar Average ATR(14)

AND

Close[1] > Highest High(previous 20 bars)
```

If both conditions are satisfied, the EA attempts to open a BUY position.

---

## Complete SELL Logic

The baseline SELL logic is:

```text
ATR(14)[1]
>
Average ATR(14) of previous 20 bars

AND

Close[1]
<
Lowest Low of previous 20 bars
-
Breakout Buffer
```

With the default Breakout Buffer of zero:

```text
ATR(14)[1] > Previous 20-Bar Average ATR(14)

AND

Close[1] < Lowest Low(previous 20 bars)
```

If both conditions are satisfied, the EA attempts to open a SELL position.

---

## Important ATR Interpretation

ATR measures volatility.

It does not directly measure:

```text
Bullish Direction
or
Bearish Direction
```

Therefore EA-071 uses ATR only as a volatility filter.

For example:

```text
High ATR
```

means that recent price movement is relatively large.

It does not independently indicate whether price should rise or fall.

Trade direction remains determined by:

```text
Breakout Above Range → BUY

Breakout Below Range → SELL
```

---

## Default Parameters

| Parameter | Default |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123071 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| ATR Period | 14 |
| ATR Mean Period | 20 |
| Break Even | true |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | true |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |

---

## Baseline Volatility Threshold

The baseline condition can also be expressed conceptually as:

```text
Current ATR
─────────── > 1.00
Average ATR
```

Therefore the baseline effectively requires:

```text
Relative ATR > 1.00
```

The EA does not currently expose a separate ATR multiplier input.

For example:

```text
ATR[1] = 5.01
Average ATR = 5.00
```

would satisfy the baseline volatility filter.

This characteristic may become important during future controlled research.

---

## Break Even

Break Even is enabled by default.

```text
Use Break Even      = true
Break Even Trigger  = 150 points
Break Even Offset   = 0 points
```

When floating profit reaches:

```text
150 points
```

the EA attempts to move Stop Loss to:

```text
Entry Price
```

because:

```text
Break Even Offset = 0
```

The EA checks broker stop and freeze restrictions before modifying the position.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
Use Trailing Stop   = true
Trailing Start      = 200 points
Trailing Distance   = 100 points
Trailing Step       = 10 points
```

Trailing begins when floating profit reaches:

```text
200 points
```

The requested Stop Loss is positioned approximately:

```text
100 points
```

behind the current market price.

A trailing modification must improve the existing Stop Loss by at least:

```text
10 points
```

subject to symbol tick-size and broker restrictions.

---

## Protective Stop Behavior

The EA evaluates both:

```text
Break Even
and
Trailing Stop
```

and selects the protective Stop Loss that provides the stronger valid improvement.

The EA does not intentionally move an existing Stop Loss backward.

For BUY positions:

```text
New SL must be higher than existing SL
```

For SELL positions:

```text
New SL must be lower than existing SL
```

---

## Trade Management Frequency

Entry signals are evaluated on new bars.

However:

```text
ManagePositions()
```

runs on every tick.

Therefore:

```text
Break Even
+
Trailing Stop
```

continue to operate between entry evaluations.

Protective management also runs before the EA checks whether a new bar is available.

---

## Spread Filter

New entries are allowed only when:

```text
Current Spread <= InpMaxSpread
```

Default:

```text
Maximum Spread = 30 points
```

If the spread exceeds the configured maximum:

```text
New Entry = Blocked
```

Existing-position Break Even and Trailing Stop management are not disabled merely because spread is too high for a new entry.

---

## Position Control

EA-071 is designed to prevent multiple simultaneous positions or orders associated with the same Magic Number.

Default:

```text
Magic Number = 123071
```

Before opening a new trade, the EA checks existing:

```text
Positions
+
Pending Orders
```

If an existing position or order uses:

```text
Magic Number = 123071
```

the new entry is blocked.

---

## Netting Account Protection

The EA detects whether the account is operating in a non-hedging / netting mode.

On a netting account, it additionally blocks a new entry if another position or order already exists on the same symbol.

Conceptually:

```text
Netting Account
      +
Existing XAUUSD Exposure
      ↓
Block New EA-071 Entry
```

This is intended to prevent EA-071 from unintentionally merging its exposure with another strategy trading the same symbol.

---

## Fixed Lot Model

EA-071 uses:

```text
Lot Size = 0.01
```

by default.

Position size is not calculated dynamically from:

- Account balance
- Account equity
- Percentage risk
- Monetary Stop Loss risk

Therefore:

```text
0.01 lot
```

does not represent a fixed percentage-risk model.

---

## Lot Validation

During initialization, the EA validates the configured lot against:

```text
SYMBOL_VOLUME_MIN
SYMBOL_VOLUME_MAX
SYMBOL_VOLUME_STEP
```

An invalid lot causes initialization failure.

The EA explicitly does not silently increase an invalid lot size.

---

## Stop Loss and Take Profit

Default:

```text
Stop Loss  = 300 points
Take Profit = 600 points
```

The initial nominal relationship is therefore:

```text
TP : SL = 600 : 300
        = 2 : 1
```

This describes the configured price-distance relationship only.

It does not guarantee a realized 2:1 average payoff because positions may be modified by Break Even and Trailing Stop.

---

## Protective Prices at Entry

SL and TP are submitted in the same market-order request as the trade.

Conceptually:

```text
Market Entry
    +
Stop Loss
    +
Take Profit
```

are sent together.

The EA checks the broker's minimum stop-distance requirement before submitting the order.

If the configured SL or TP violates that requirement:

```text
Entry = Skipped
```

---

## Broker / Execution Validation

Before opening a trade, the EA checks:

- Terminal connection
- Terminal trading permission
- MQL trading permission
- Account trading permission
- Expert Advisor trading permission
- Current Bid / Ask validity
- Maximum spread
- Symbol trading mode
- BUY / SELL permission
- Market-order support
- Stop Loss support
- Take Profit support
- Minimum stop distance
- Available free margin
- Symbol filling mode

If the required conditions are not satisfied, the EA does not submit the new entry.

---

## Margin Validation

Before sending an order, the EA calculates required margin using:

```text
OrderCalcMargin()
```

If:

```text
Required Margin > Available Free Margin
```

the trade is skipped.

A failed margin calculation also prevents entry.

---

## Price Normalization

EA-071 uses the symbol's:

```text
Point Size
Tick Size
Price Digits
```

when constructing protective prices.

Helper functions:

```text
RoundDown()
RoundUp()
```

align Stop Loss and Take Profit prices with the symbol's valid tick structure.

---

## Indicator Initialization

ATR is created during:

```text
OnInit()
```

using:

```text
iATR(
   _Symbol,
   InpTimeframe,
   InpATRPeriod
)
```

Default:

```text
Symbol     = Current Chart Symbol
Timeframe  = M1
ATR Period = 14
```

If the ATR handle cannot be created:

```text
Initialization = Failed
```

The indicator handle is released during:

```text
OnDeinit()
```

---

## Parameter Validation

Initialization rejects invalid configurations including:

```text
Lot Size <= 0

Stop Loss <= 0

Take Profit <= 0

Magic Number = 0

Slippage < 0

Maximum Spread < 0

Breakout Lookback < 2

Breakout Lookback > 10000

Breakout Buffer < 0

ATR Period < 2

ATR Period > 10000

ATR Mean Period < 2

ATR Mean Period > 10000
```

Break Even parameters are also validated when Break Even is enabled.

Trailing Stop parameters are validated when Trailing Stop is enabled.

---

## New-Bar Processing

At initialization:

```text
last_bar = iTime(...)
```

is set to the currently active candle.

This prevents the EA from immediately entering from an old signal when first attached.

The normal processing sequence is:

```text
Tick
 │
 ▼
Trading Allowed?
 │
 ▼
Manage Existing Position
 │
 ▼
New Bar?
 │
 ▼
Load Historical Bars
 │
 ▼
Read ATR[1]
 │
 ▼
Calculate Previous ATR Average
 │
 ▼
ATR[1] > Average ATR?
 │
 ▼
Evaluate Breakout Direction
 │
 ▼
Check Existing Exposure
 │
 ▼
Validate Execution
 │
 ▼
Open Trade
```

---

## Historical Data Requirement

For breakout calculation, the EA loads:

```text
InpBreakoutLookback + 3
```

bars.

With the default:

```text
Breakout Lookback = 20
```

the requested price history is:

```text
23 bars
```

The ATR calculation separately requires sufficient indicator history for:

```text
ATR[1]
+
20 historical ATR values
```

If the required ATR data are not ready, signal processing is deferred.

---

## Signal Evaluation Behavior

The function:

```text
GetSignal()
```

returns a valid evaluation only when the required ATR data are available.

Once the signal data are successfully evaluated for the new bar:

```text
last_bar = current_bar
```

is updated.

Therefore the ready signal for that bar is evaluated once.

If indicator data are temporarily unavailable, the EA can retry on subsequent ticks of the same bar until the data become available.

---

## Unused CrossLevel Function

The source code contains:

```text
CrossLevel()
```

which can detect a transition across the breakout level.

However, the current EA-071 signal path does **not** use this function.

The active entry logic uses:

```text
BreakDirection()
```

instead.

Therefore the baseline strategy does not require a strict transition from inside the range to outside the range between `bars[2]` and `bars[1]`.

The actual implemented breakout requirement is based on the closing position of:

```text
bars[1]
```

relative to the historical range.

This distinction should be preserved when interpreting or reproducing the strategy.

---

## What EA-071 Is Testing

EA-071 is primarily a **volatility-filter experiment**.

The central research question is:

> Does requiring the breakout candle's ATR to exceed recent average ATR improve the quality of a 20-bar XAUUSD breakout signal?

The baseline comparison is conceptually:

```text
20-Bar Price Breakout
        +
ATR(14)[1]
>
20-Bar Historical ATR Average
```

The EA is therefore investigating whether above-average volatility provides useful confirmation of breakout activity.

---

## What EA-071 Is Not Testing

The baseline does not independently establish:

```text
Whether ATR predicts direction
```

because ATR is non-directional.

It also does not establish:

```text
Whether higher ATR always improves breakout quality
```

or:

```text
Whether ATR > Average ATR is the optimal threshold
```

or:

```text
Whether M1 is the optimal timeframe
```

or:

```text
Whether ATR Period 14 is optimal
```

or:

```text
Whether ATR Mean Period 20 is optimal
```

Those questions require separate controlled experiments.

---

## Potential Research Variables

After the baseline backtest is documented, controlled research may investigate variables such as:

```text
ATR Strength / Relative ATR Threshold

ATR Period

ATR Mean Period

BUY vs SELL Direction

Breakout Lookback

Breakout Buffer

Timeframe

Trading Session

Exit Management
```

These are research dimensions only.

No parameter should be considered superior before testing.

---

## Relative ATR Research Concept

The current baseline effectively tests:

```text
Relative ATR > 1.00
```

where:

```text
Relative ATR =
Current ATR
───────────
Average ATR
```

A future controlled implementation could investigate stronger volatility expansion, conceptually:

```text
Current ATR
>
Average ATR × ATR Multiplier
```

For example, research candidates could later be defined as:

```text
Relative ATR > 1.10
Relative ATR > 1.20
Relative ATR > 1.30
Relative ATR > 1.50
```

These are examples of possible experimental thresholds only.

They are not validated or recommended settings.

---

## Research Discipline

The baseline should be tested before modifying multiple parameters.

The preferred research process is:

```text
Baseline
   ↓
Record Result
   ↓
Identify Weakness
   ↓
Form Research Question
   ↓
Change One Major Variable
   ↓
Backtest
   ↓
Compare Against Baseline
```

Broad parameter optimization should not replace controlled hypothesis testing.

---

## Baseline Preservation

Once the baseline backtest is completed, it should remain unchanged.

Future EA-071 variants should not overwrite the original baseline.

Recommended structure:

```text
EA-071 Baseline
      │
      ├── Research Question 01
      ├── Research Question 02
      ├── Research Question 03
      └── ...
```

The baseline provides the reference required to determine whether later modifications produce measurable improvement.

---

## Current Research Status

```text
Strategy Code:       COMPLETE

Baseline Backtest:   PENDING

Baseline Assessment: PENDING

Research Status:     AWAITING BASELINE

Optimization Status: BLOCKED

Live Validation:     NOT VALIDATED
```

No profitability conclusion should be made from the source code alone.

---

## Platform

```text
Platform:             MetaTrader 5
Language:             MQL5
EA Version:           1.00

EA:                   EA-071_Breakout_ATR_Filter

Default Timeframe:    M1
Default Magic Number: 123071
```

---

## Files

```text
EA-071_Breakout_ATR_Filter/
├── EA-071_Breakout_ATR_Filter.mq5
└── README.md
```

---

## Baseline Configuration Summary

```text
EA:                    EA-071_Breakout_ATR_Filter

Strategy:
20-Bar Breakout
+
ATR Volatility Filter

Timeframe:             M1

Breakout Lookback:     20
Breakout Buffer:       0

ATR Period:            14
ATR Mean Period:       20

ATR Rule:
ATR[1] > Average ATR[2...21]

Lot Size:              0.01

Stop Loss:             300 points
Take Profit:           600 points

Maximum Spread:        30 points
Slippage:              10 points

Break Even:            ON
BE Trigger:            150 points
BE Offset:             0 points

Trailing Stop:         ON
Trailing Start:        200 points
Trailing Distance:     100 points
Trailing Step:         10 points

Magic Number:          123071
```

---

## Conclusion

EA-071 implements a controlled **Breakout + ATR Volatility Filter** research strategy.

The baseline hypothesis is:

```text
Price Breakout
        +
Above-Average ATR
        ↓
Potentially Higher-Quality Breakout
```

The implemented volatility condition is:

```text
ATR(14)[1]
>
Average ATR(14) of previous 20 bars
```

ATR determines whether volatility is sufficiently elevated.

Price breakout determines trade direction.

The next required step is to run and preserve the baseline MetaTrader 5 Strategy Tester experiment before drawing any conclusion about the strategy.

---

## Disclaimer

This Expert Advisor is part of an algorithmic trading research project.

The presence of ATR filtering, breakout logic, Stop Loss, Take Profit, Break Even, Trailing Stop, spread controls, or execution safeguards does not establish profitability.

Backtesting, controlled experimentation, out-of-sample validation, robustness testing, and forward testing are required before any live-trading conclusion can be made.

Historical performance does not guarantee future results.
