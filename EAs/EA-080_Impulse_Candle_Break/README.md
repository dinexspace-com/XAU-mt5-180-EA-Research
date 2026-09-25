
# EA-080 — Impulse Candle Break

**Platform:** MetaTrader 5 / MQL5  
**Instrument:** XAUUSD  
**Timeframe:** M1  
**Strategy:** Momentum / Impulse Candle Breakout  
**Status:** Experimental — Baseline Failed

## Strategy Overview

EA-080 is an automated trading strategy that identifies strong impulse candles using Average True Range (ATR) and candle-body strength. It then waits for a subsequent candle to close beyond the impulse candle's high or low.

The strategy uses closed-candle confirmation rather than entering immediately when an impulse candle appears.

## Entry Logic

### BUY

1. Identify a bullish impulse candle.
2. Confirm that its range exceeds ATR(14) × 1.5.
3. Confirm that its body represents at least 70% of its total range.
4. Record the impulse candle's high and low.
5. Enter BUY when a subsequent candle closes above the impulse high plus the breakout buffer.

### SELL

1. Identify a bearish impulse candle.
2. Apply the same ATR and candle-body requirements.
3. Record the impulse candle's high and low.
4. Enter SELL when a subsequent candle closes below the impulse low minus the breakout buffer.

Impulse signals remain valid for a maximum of 20 bars. A close beyond the opposite side of the impulse candle invalidates the signal.

## Baseline Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123080 |
| Maximum Slippage | 10 |
| Maximum Spread | 30 |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| ATR Period | 14 |
| Impulse ATR Multiplier | 1.5 |
| Impulse Body Ratio | 0.70 |
| Impulse Max Bars | 20 |
| Break Even | Enabled |
| Break Even Trigger | 150 |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 |
| Trailing Distance | 100 |
| Trailing Step | 10 |

## Risk Management

The EA includes fixed lot sizing, initial SL/TP, break-even protection, trailing stops, spread filtering and margin checks.

It restricts concurrent exposure using its magic number and applies additional symbol-exposure restrictions on netting accounts.

The breakout lookback parameter controls historical data retrieval. The active entry logic is based on impulse candles rather than a rolling high-low breakout.

## Source Code

`EA-080_Impulse_Candle_Break.mq5`

## Current Status

The initial backtest did not demonstrate profitability. The EA remains experimental and has not been approved for live trading.
