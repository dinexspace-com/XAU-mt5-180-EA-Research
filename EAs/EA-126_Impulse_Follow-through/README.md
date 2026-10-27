# EA-126_Impulse_Follow-through

## Overview

EA-126_Impulse_Follow-through is an MQL5 Expert Advisor for MetaTrader 5.

The strategy identifies unusually large directional candle bodies relative to Average True Range (ATR), then waits for the following completed candle to confirm price continuation beyond the impulse candle's high or low.

Entry signals are evaluated once per new candle, while open positions are managed on every tick.

The EA uses fixed lot sizing, initial Stop Loss and Take Profit, optional Break Even, optional Trailing Stop, and a maximum spread filter.

## Trading Strategy

### Indicator

- Average True Range (ATR)
- Default ATR Period: 14
- Default Impulse ATR Multiplier: 1.5
- ATR Buffer: 0
- ATR Reference Candle: Shift 2

### Candle Structure

- Impulse Candle: Shift 2
- Confirmation Candle: Shift 1
- Entry Evaluation: First eligible tick of the new candle at shift 0

The impulse candle and confirmation candle are both completed candles.

### Impulse Detection

Define:

`ImpulseBody = abs(Close[2] - Open[2])`

`ImpulseThreshold = ATR[2] * InpImpulseATRMultiplier`

The impulse condition is satisfied when:

`ImpulseBody >= ImpulseThreshold`

The strategy compares the **candle body**, not the full high-to-low candle range, against the ATR threshold.

### Buy Conditions

A Buy order may be submitted when all conditions are true:

1. `abs(Close[2] - Open[2]) >= ATR[2] * 1.5`
2. `Close[2] > Open[2]`
3. `Close[1] > High[2]`

The impulse candle must be bullish, and the following completed candle must close above its high.

### Sell Conditions

A Sell order may be submitted when all conditions are true:

1. `abs(Close[2] - Open[2]) >= ATR[2] * 1.5`
2. `Close[2] < Open[2]`
3. `Close[1] < Low[2]`

The impulse candle must be bearish, and the following completed candle must close below its low.

The source code does not require the confirmation candle itself to have a bullish or bearish body.

## Execution Rules

- Open positions are managed on every tick.
- New entries are evaluated once per new candle.
- Terminal, EA, and account trading permissions must be enabled.
- No existing position may match the current symbol and Magic Number.
- The current spread must be within the configured maximum.
- ATR data at shift 2 must be valid and positive.
- The impulse candle body must satisfy the ATR multiplier threshold.
- The confirmation candle must close beyond the impulse candle's directional extreme.
- Orders are submitted through the MQL5 `CTrade` class.

## Risk Management

The EA includes:

- Fixed lot sizing
- Initial Stop Loss and Take Profit
- Optional Break Even
- Optional Trailing Stop
- Maximum spread filter
- Broker minimum/maximum volume and volume-step normalization
- Broker minimum stop-distance handling for initial orders
- Symbol and Magic Number position identification

The EA does not implement martingale, grid trading, or percentage-based position sizing.

## Default Parameters

| Parameter | Default Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 126123 |
| Slippage | 10 points |
| Use Break Even | true |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Use Trailing Stop | true |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| ATR Period | 14 |
| Impulse ATR Multiplier | 1.5 |

The initial nominal Stop Loss-to-Take Profit distance ratio is 1:2.

Actual trade outcomes can differ because of Break Even, Trailing Stop, broker stop-distance requirements, and execution conditions.

## Backtest Summary

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Net Profit | -$211.69 |
| Profit Factor | 0.85 |
| Equity Drawdown Relative | 24.46% |
| Recovery Factor | -0.83 |
| Total Trades | 1,085 |
| Winning Trades | 496 (45.71%) |

## Research Status

**FAILED BACKTEST — Further Research Required**

The tested configuration generated negative net profit and negative expected payoff.

Although drawdown was materially lower than in some preceding EA experiments, the supplied results do not demonstrate a profitable trading edge.

The current configuration is not supported for live deployment or capital scaling.

## Files

- `EA-126_Impulse_Follow-through.mq5` — Expert Advisor source code
- `README.md` — Strategy documentation

## Disclaimer

This Expert Advisor is provided for research and educational purposes.

Historical performance does not guarantee future results.
