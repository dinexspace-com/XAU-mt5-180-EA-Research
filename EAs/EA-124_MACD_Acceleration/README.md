# EA-124_MACD_Acceleration

## Overview

EA-124_MACD_Acceleration is an MQL5 Expert Advisor developed for MetaTrader 5.

The strategy uses the MACD histogram to identify directional momentum through zero-line transitions and consecutive histogram changes.

The EA evaluates completed candles and manages open positions using fixed lot sizing, Stop Loss, Take Profit, optional Break Even, and optional Trailing Stop.

## Trading Strategy

### Indicator

- Indicator: Moving Average Convergence Divergence (MACD)
- Fast EMA Period: 12
- Slow EMA Period: 26
- Signal Period: 9
- Applied Price: Close

### MACD Histogram Calculation

The EA reads MACD Main and Signal values from the three most recently completed candles.

`H1 = MACD_Main[1] - MACD_Signal[1]`

`H2 = MACD_Main[2] - MACD_Signal[2]`

`H3 = MACD_Main[3] - MACD_Signal[3]`

Here, index 1 refers to the latest completed candle.

### Buy Conditions

A Buy signal is generated when either condition is satisfied:

**Condition A — Positive Zero-Line Transition**

`H1 > 0 && H2 <= 0 && H1 > H2`

**Condition B — Consecutive Positive Acceleration**

`H1 > 0 && H1 > H2 && H2 > H3`

### Sell Conditions

A Sell signal is generated when either condition is satisfied:

**Condition A — Negative Zero-Line Transition**

`H1 < 0 && H2 >= 0 && H1 < H2`

**Condition B — Consecutive Negative Acceleration**

`H1 < 0 && H1 < H2 && H2 < H3`

The conditions are evaluated in the order implemented in the source code.

## Execution Rules

- Entry evaluation occurs once per new candle.
- Signals use completed candles only.
- Trading permissions must be enabled.
- The spread must not exceed the configured maximum.
- The EA permits no new entry while a matching symbol/Magic Number position exists.
- Positions are identified by symbol and Magic Number.
- Market orders are submitted using `CTrade`.

## Risk Management

- Fixed lot size
- Initial Stop Loss and Take Profit
- Optional Break Even
- Optional Trailing Stop
- Maximum spread filter
- Broker volume normalization
- Broker minimum initial stop-distance handling
- Per-tick position management

The EA does not implement grid trading, martingale, or percentage-based equity risk sizing.

## Default Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 124123 |
| Slippage | 10 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| Fast EMA | 12 |
| Slow EMA | 26 |
| Signal Period | 9 |

The initial Stop Loss and Take Profit distances have a nominal 1:2 ratio. Actual trade outcomes may differ because of position management and execution conditions.

## Backtest Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000 |
| Net Profit | -$992.01 |
| Profit Factor | 0.80 |
| Equity Drawdown Relative | 99.20% |
| Recovery Factor | -1.00 |
| Total Trades | 3,860 |
| Winning Trades | 48.06% |

Test period: 2026-01-02 to 2026-04-01.

## Research Status

**FAILED BACKTEST — Further Research Required**

The tested configuration generated negative returns and extreme equity drawdown.

These results do not support live deployment or capital scaling.

## Files

- `EA-124_MACD_Acceleration.mq5` — MQL5 source code
- `README.md` — Strategy documentation

## Disclaimer

This Expert Advisor is provided for research and educational purposes. Historical results do not guarantee future performance.
