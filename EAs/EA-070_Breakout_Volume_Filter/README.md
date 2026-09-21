# EA-070 — Breakout Volume Filter

## Overview

**EA-070_Breakout_Volume_Filter** is an Expert Advisor for MetaTrader 5 designed to research whether a price breakout accompanied by above-average tick volume can provide a measurable directional trading edge.

The strategy combines:

- Price-range breakout
- Tick-volume confirmation
- Fixed Stop Loss / Take Profit
- Break Even
- Trailing Stop
- Spread filtering
- Single-position / order control

The default research timeframe is **M1**.

---

## Research Hypothesis

The strategy tests the hypothesis:

> A breakout may have a higher probability of continuation when the breakout candle has greater tick volume than the average tick volume of the preceding candles.

The volume filter is therefore used as a confirmation mechanism rather than as an independent directional signal.

Conceptually:

```text
Price Breakout
        +
Breakout Candle Volume > Previous Average Volume
        ↓
Trade
```

---

## Entry Logic

Trading signals are evaluated only when a new candle begins.

The EA uses the most recently completed candle:

```text
bars[1]
```

as the breakout signal candle.

The historical breakout range begins from:

```text
bars[2]
```

This prevents the breakout candle itself from being included in the range used to determine whether a breakout occurred.

---

## Breakout Range

The default breakout lookback is:

```text
20 bars
```

The EA calculates:

```text
Upper = Highest High of bars [2 ... 21]
Lower = Lowest Low of bars [2 ... 21]
```

with the default:

```text
Breakout Lookback = 20
Breakout Buffer = 0
```

---

## BUY Signal

A BUY candidate is generated when:

```text
Close[1] > Upper Range + Breakout Buffer
```

The breakout must then pass the volume filter:

```text
TickVolume[1] > Average Tick Volume of previous 20 candles
```

Therefore the complete baseline BUY condition is:

```text
Close[1] > Highest High(previous 20 bars)
AND
TickVolume[1] > Average TickVolume(previous 20 bars)
```

If both conditions are satisfied, the EA attempts to open a BUY position.

---

## SELL Signal

A SELL candidate is generated when:

```text
Close[1] < Lower Range - Breakout Buffer
```

The breakout must also pass the volume filter:

```text
TickVolume[1] > Average Tick Volume of previous 20 candles
```

Therefore the complete baseline SELL condition is:

```text
Close[1] < Lowest Low(previous 20 bars)
AND
TickVolume[1] > Average TickVolume(previous 20 bars)
```

If both conditions are satisfied, the EA attempts to open a SELL position.

---

## Volume Filter

The default volume lookback is:

```text
InpVolumeLookback = 20
```

The EA calculates average tick volume using only the candles preceding the breakout candle:

```text
bars[2]
bars[3]
...
bars[21]
```

The breakout candle:

```text
bars[1]
```

is deliberately excluded from the historical average.

The implemented condition is:

```text
Breakout Candle Tick Volume > Previous Average Tick Volume
```

Equality is not sufficient.

If:

```text
Breakout Volume <= Average Volume
```

the signal is rejected.

---

## Important Volume Definition

The implementation uses:

```text
MqlRates.tick_volume
```

Therefore the volume filter is based on **tick volume**, not centralized exchange-traded volume.

The EA measures trading-activity changes represented by the broker's XAUUSD tick stream.

This distinction should be preserved when interpreting future backtest results.

---

## Default Parameters

| Parameter | Default |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123070 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| Volume Lookback | 20 |

---

## Break Even

Break Even is enabled by default.

| Parameter | Default |
|---|---:|
| Use Break Even | true |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |

When floating profit reaches:

```text
150 points
```

the EA attempts to move the Stop Loss to the entry price.

With the default offset:

```text
Break Even Offset = 0
```

the target Break Even level is the original entry price.

The EA also checks broker stop and freeze restrictions before modifying the position.

---

## Trailing Stop

Trailing Stop is enabled by default.

| Parameter | Default |
|---|---:|
| Use Trailing Stop | true |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |

Trailing begins when floating profit reaches:

```text
200 points
```

The requested Stop Loss is maintained approximately:

```text
100 points
```

behind the current market price.

A modification must improve the existing Stop Loss by at least the configured Trailing Step.

The EA does not intentionally move an existing protective Stop Loss backward.

---

## Trade Management Frequency

Entry signals are evaluated once per completed candle.

However:

```text
Break Even
and
Trailing Stop
```

are managed on **every tick**.

This means protective position management continues between entry evaluations.

It also continues when the current spread would be too high for a new entry.

---

## Position Control

The EA is designed to prevent multiple simultaneous positions/orders associated with the same Magic Number.

Default Magic Number:

```text
123070
```

Before opening a trade, the EA checks existing:

- Positions
- Pending orders

If another position or order with the same Magic Number exists, a new entry is blocked.

---

## Netting Account Protection

On netting accounts, the EA additionally blocks a new entry when another position or order already exists on the same symbol.

This prevents EA-070 from unintentionally merging its exposure with another strategy operating on the same symbol.

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

The spread filter applies to new entries.

Existing-position Break Even and Trailing Stop management are evaluated independently on every tick.

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
- Broker minimum stop distance
- Available free margin
- Symbol filling mode

If the configured trade cannot satisfy these requirements, the entry is skipped.

---

## Lot Validation

The baseline uses fixed position sizing:

```text
Lot Size = 0.01
```

During initialization, the EA verifies that the configured lot:

- is not below the symbol minimum;
- is not above the symbol maximum;
- conforms to the broker's volume step.

The EA does not silently increase an invalid lot size.

---

## Risk Model

The current implementation uses:

```text
Fixed Lot Size
```

It does not calculate position size from:

- Account Balance
- Account Equity
- Percentage Risk
- Stop Loss monetary risk

Therefore:

```text
Lot Size = 0.01
```

does not represent a fixed percentage of account risk.

---

## Stop Loss and Take Profit

Default protective distances:

```text
Stop Loss = 300 points
Take Profit = 600 points
```

SL and TP are submitted together with the original market-order request.

The EA checks broker stop-distance requirements before sending the order.

If the configured SL or TP cannot satisfy the symbol's minimum stop distance, the trade is skipped.

---

## Signal Timing

The EA initializes using the currently active candle:

```text
last_bar = iTime(...)
```

This prevents the EA from immediately entering from an old historical signal when it is first attached.

After initialization:

```text
New Bar
   ↓
Load Required Historical Bars
   ↓
Calculate Breakout Range
   ↓
Calculate Previous Average Tick Volume
   ↓
Evaluate Closed Breakout Candle
   ↓
Check Volume Confirmation
   ↓
Check Existing Exposure
   ↓
Validate Execution Conditions
   ↓
Open Trade
```

Signals are therefore based on completed candles rather than unfinished intrabar closes.

---

## Baseline Strategy Structure

The baseline can be summarized as:

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
          Breakout Candle Volume
                     >
         Previous 20-Bar Avg Volume
                     │
                     ▼
             Execution Checks
                     │
                     ▼
                  Trade
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
     Break Even 150       Trailing Start 200
                          Distance 100
                          Step 10
```

---

## What EA-070 Is Testing

EA-070 is primarily an **entry-filter experiment**.

The core research question is:

> Does requiring above-average tick volume on the breakout candle improve the quality of a 20-bar XAUUSD breakout signal?

The baseline should therefore be treated as a controlled research experiment rather than as a production trading system.

---

## Current Research Status

Strategy implementation:

**COMPLETE**

Baseline backtest:

**PENDING / NOT DOCUMENTED HERE**

Research classification:

**AWAITING BASELINE BACKTEST**

No conclusion about profitability, robustness, or live-trading suitability should be made from the source code alone.

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
EA Version: 1.00
Default Timeframe: M1
Default Magic Number: 123070
```

---

## Files

```text
EA-070_Breakout_Volume_Filter/
├── EA-070_Breakout_Volume_Filter.mq5
└── README.md
```

---

## Disclaimer

This Expert Advisor is part of an algorithmic trading research project.

The presence of trading logic, risk controls, Break Even, Trailing Stop, or volume confirmation does not establish profitability.

Backtesting, independent validation, robustness testing, and forward testing are required before any live-trading conclusion can be made.

Historical performance does not guarantee future results.
