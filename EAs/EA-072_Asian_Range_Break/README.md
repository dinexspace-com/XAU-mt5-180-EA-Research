# EA-072 — Asian Range Break

## Overview

**EA-072 Asian Range Break** is a MetaTrader 5 Expert Advisor (EA) that trades breakouts of a price range formed during a configurable Asian-session time window.

The EA builds the session range from completed **M1 candles**, identifies the session high and low, and waits for price to close outside that range after the range-building period has finished.

Both bullish and bearish breakouts are supported.

---

## Strategy Logic

### 1. Build the Asian Range

The EA defines a daily range using:

* `InpRangeStartHour`
* `InpRangeEndHour`

Default configuration:

```text
Range Start: 00:00
Range End:   08:00
```

These hours are based on the **broker/server time**.

The range is calculated from completed M1 candles between the configured start and end times:

```text
Asian High = Highest High during the range period
Asian Low  = Lowest Low during the range period
```

The EA requires complete M1 data for the configured session before accepting the range.

---

## 2. Breakout Entry

After the range period ends, the EA monitors completed M1 candles for a confirmed breakout.

### BUY

A BUY signal occurs when the previous candle was not above the Asian High and the latest completed candle closes above:

```text
Asian High + Breakout Buffer
```

### SELL

A SELL signal occurs when the previous candle was not below the Asian Low and the latest completed candle closes below:

```text
Asian Low - Breakout Buffer
```

This means the strategy uses a **close-based range crossing**, rather than entering merely because price temporarily touches or penetrates the range.

---

## 3. Trading Window

Default server-time configuration:

```text
Asian Range: 00:00 → 08:00
Trading ends: 16:00
```

No new breakout entry is generated before the Asian range is complete.

New signals are no longer accepted after the configured trade cutoff.

> Important: these values represent broker/server hours. They are not automatically converted from UTC, London, New York, Tokyo, or the user's local timezone.

---

## Default Parameters

| Parameter             | Default | Description                            |
| --------------------- | ------: | -------------------------------------- |
| `InpLotSize`          |    0.01 | Fixed trading volume                   |
| `InpStopLoss`         |     300 | Stop Loss in points                    |
| `InpTakeProfit`       |     600 | Take Profit in points                  |
| `InpMagicNumber`      |  123072 | EA Magic Number                        |
| `InpSlippage`         |      10 | Maximum execution deviation in points  |
| `InpMaxSpread`        |      30 | Maximum spread allowed for new entries |
| `InpTimeframe`        |      M1 | Signal timeframe                       |
| `InpBreakoutLookback` |      20 | Internal candle-history requirement    |
| `InpBreakoutBuffer`   |       0 | Additional breakout distance in points |
| `InpRangeStartHour`   |       0 | Range start hour                       |
| `InpRangeEndHour`     |       8 | Range end hour                         |
| `InpTradeEndHour`     |      16 | New-entry cutoff hour                  |

The current implementation requires `InpTimeframe = PERIOD_M1`.

---

## Stop Loss & Take Profit

Default protective levels:

```text
Stop Loss  = 300 points
Take Profit = 600 points
```

This gives a nominal SL:TP distance ratio of:

```text
1 : 2
```

Protective SL and TP prices are submitted together with the initial market-order request.

The EA also validates the broker's minimum stop-distance requirements before submitting an order.

---

## Break Even

Break Even management is enabled by default.

```text
Use Break Even:     true
Trigger:            150 points
Offset:             0 points
```

When floating profit reaches the configured trigger, the EA attempts to move the Stop Loss toward the entry price plus/minus the configured offset.

Broker stop and freeze levels are respected.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
Use Trailing Stop:  true
Start:              200 points
Distance:           100 points
Step:               10 points
```

Trailing management runs on every tick once the required profit threshold has been reached.

The Stop Loss is only changed when the new level improves the existing protective stop by at least the configured trailing step.

---

## Entry Protection

The EA includes several execution safeguards.

A new trade can be rejected when:

* terminal trading is unavailable;
* Expert Advisor trading is disabled;
* account trading is unavailable;
* spread exceeds `InpMaxSpread`;
* broker trading mode does not permit the required direction;
* market orders or SL/TP are unsupported;
* configured SL/TP violates broker stop-distance rules;
* available margin is insufficient;
* another position/order using the same Magic Number already exists.

On netting accounts, the EA also avoids merging its trade with another position already open on the same symbol.

---

## Position Control

The strategy is designed to maintain at most one active position/order associated with its Magic Number across the account.

Default Magic Number:

```text
123072
```

This helps isolate EA-072 trades from other Expert Advisors when each strategy uses its own Magic Number.

---

## Signal Timing

Signals are evaluated on **new M1 candles**.

The EA uses completed candles for breakout confirmation rather than making the breakout decision continuously from an unfinished candle.

When the EA is first attached to a chart, it waits for the next candle instead of immediately trading an old breakout signal.

---

## Intended Research Instrument

Primary research target:

```text
XAUUSD
```

The EA itself uses `_Symbol`, so it is technically able to operate on the chart symbol to which it is attached.

Results from one symbol, broker, spread environment, or server timezone should not be assumed to apply to another without separate testing.

---

## Files

```text
EA-072_Asian_Range_Break/
├── EA-072_Asian_Range_Break.mq5
└── README.md
```

### `EA-072_Asian_Range_Break.mq5`

MQL5 source code for the Expert Advisor.

### `README.md`

Technical description of the strategy logic, default parameters, execution rules, and risk-management behavior.

---

## Research Status

```text
Strategy implementation: Available
Source code:             Available
Backtest validation:     See /Backtest/EA-072_Asian_Range_Break/
Research evidence:       See /Research/
```

Backtest results should be evaluated separately from the strategy implementation. No profitability claim is implied by the existence of the EA source code.

---

## Disclaimer

This project is intended for quantitative strategy research, software development, and backtesting.

Historical or simulated performance does not guarantee future results. Trading leveraged instruments such as XAUUSD involves substantial risk.
