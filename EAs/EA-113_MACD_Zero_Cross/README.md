
# EA-113 — MACD Zero Cross

## Overview

**EA Name:** EA-113 MACD Zero Cross  
**Symbol:** XAUUSD.PRO  
**Baseline Timeframe:** M1  
**Strategy Type:** MACD Zero-Line Crossover  
**Baseline ID:** `EA113-M1-BASELINE-001`

## Strategy Logic

The EA uses the MACD main line to detect zero-line crossovers.

- **BUY:** Previous closed MACD value is less than or equal to zero, and the latest closed MACD value is greater than zero.
- **SELL:** Previous closed MACD value is greater than or equal to zero, and the latest closed MACD value is less than zero.

The EA evaluates entry conditions when a new candle begins, using closed-candle MACD values.

## Indicator Parameters

| Parameter | Baseline Value |
|---|---:|
| Fast EMA | 12 |
| Slow EMA | 26 |
| Signal Period | 9 |

The entry conditions use the MACD main line crossing zero; they do not use a MACD/signal-line crossover.

## Trading Parameters

| Parameter | Baseline Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 113001 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Break-even | Enabled |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

## Execution and Risk Management

- Processes entry logic once per new candle.
- Checks terminal and EA trading permissions.
- Applies a maximum-spread filter.
- Restricts the EA to one open position per symbol and Magic Number.
- Places initial Stop Loss and Take Profit with market orders.
- Manages break-even and trailing stop on every tick.

## Baseline Status

**Result:** `FAIL`

The baseline produced negative net profit, a Profit Factor below 1.00, and high equity drawdown.

The strategy is not validated for live trading. Further work should focus on establishing whether the entry logic has a measurable edge before broad parameter optimization.
