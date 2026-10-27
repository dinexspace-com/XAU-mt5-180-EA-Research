# EA-125_Breakout_Momentum

## Overview

EA-125_Breakout_Momentum is an MQL5 Expert Advisor developed for MetaTrader 5.

The strategy combines a price breakout of a historical candle range with RSI momentum thresholds and MACD directional confirmation.

Trading signals are evaluated once per new candle using the latest completed candle.

The EA uses fixed lot sizing, initial Stop Loss and Take Profit, optional Break Even, optional Trailing Stop, and a maximum spread filter.

## Trading Strategy

### Indicators and Price Structure

- Relative Strength Index (RSI): 14 periods, applied to Close
- MACD: Fast EMA 12, Slow EMA 26, Signal 9, applied to Close
- Breakout Lookback: 10 candles
- Signal Candle: Shift 1, the most recently completed candle
- Historical Range: Candles at shifts 2 through 11 with the default lookback

The historical range excludes the signal candle.

### Breakout Calculation

For `N = InpBreakoutBars`:

`BreakoutHigh = max(High[2], ..., High[N+1])`

`BreakoutLow = min(Low[2], ..., Low[N+1])`

`SignalClose = Close[1]`

The breakout lookback must be at least two candles.

### Buy Conditions

A Buy order is submitted when all three conditions are true:

1. `Close[1] > BreakoutHigh`
2. `RSI[1] >= 55.0`
3. `MACD_Main[1] > MACD_Signal[1]`

### Sell Conditions

A Sell order is submitted when all three conditions are true:

1. `Close[1] < BreakoutLow`
2. `RSI[1] <= 45.0`
3. `MACD_Main[1] < MACD_Signal[1]`

The MACD filter compares the Main and Signal values. It does not require a new MACD crossover.

## Execution Rules

- Open-position management runs on every tick.
- New entry signals are evaluated once per new candle.
- Trading must be permitted by the terminal, EA, and account.
- The spread must not exceed the configured maximum.
- No matching position may already exist for the same symbol and Magic Number.
- RSI and MACD indicator values must be available and valid.
- The breakout lookback must be at least two candles.
- Orders are submitted using the MQL5 `CTrade` class.

## Risk Management

- Fixed lot size
- Initial Stop Loss and Take Profit
- Optional Break Even
- Optional Trailing Stop
- Maximum spread filter
- Broker volume minimum, maximum, and step normalization
- Broker minimum stop-distance handling for initial orders
- Symbol and Magic Number position identification

The source code does not implement martingale, grid trading, or equity-percentage-based position sizing.

## Default Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 125123 |
| Slippage | 10 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| RSI Period | 14 |
| Buy RSI Threshold | 55.0 |
| Sell RSI Threshold | 45.0 |
| MACD Fast EMA | 12 |
| MACD Slow EMA | 26 |
| MACD Signal Period | 9 |
| Breakout Lookback | 10 candles |

The initial Stop Loss and Take Profit have a nominal distance ratio of 1:2. Realized trade outcomes can differ because of Break Even, Trailing Stop, and execution conditions.

## Backtest Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000 |
| Net Profit | -$992.17 |
| Profit Factor | 0.81 |
| Equity Drawdown Relative | 99.22% |
| Recovery Factor | -1.00 |
| Total Trades | 3,707 |
| Winning Trades | 44.73% |

Test period: 2026-01-02 to 2026-04-01.

## Research Status

**FAILED BACKTEST — Further Research Required**

The tested configuration generated a substantial net loss and near-total equity drawdown.

The available results do not support live deployment or capital scaling.

## Files

- `EA-125_Breakout_Momentum.mq5` — MQL5 source code
- `README.md` — Strategy documentation

## Disclaimer

This Expert Advisor is provided for research and educational purposes. Historical performance does not guarantee future results.
