# EA-127_ATR_High_Regime

## Overview

EA-127_ATR_High_Regime is a MetaTrader 5 Expert Advisor written in MQL5.

The strategy identifies high-volatility market conditions using Average True Range (ATR) and determines trade direction using the relative position of two Exponential Moving Averages (EMAs).

The EA attempts to trade in the direction of the EMA-defined trend only when recent ATR is sufficiently elevated relative to its historical average.

It includes fixed lot sizing, initial Stop Loss and Take Profit, optional Break Even, optional Trailing Stop, and a maximum spread filter.

## Strategy Logic

### Indicators

| Indicator | Default Setting | Purpose |
|---|---|---|
| ATR | 14 periods, M1 | Measure volatility |
| ATR Lookback | 50 historical ATR values | Establish baseline volatility |
| High ATR Factor | 1.3 | Define high-volatility regime |
| Fast EMA | 20 periods | Determine trend direction |
| Slow EMA | 50 periods | Determine trend direction |

ATR is explicitly calculated on `PERIOD_M1`.

The EMAs are calculated on the chart timeframe (`_Period`). In the supplied backtest, that timeframe was M1.

### High-Volatility Regime

The EA reads the most recently completed ATR value:

`CurrentATR = ATR[1]`

It calculates the historical ATR baseline using 50 values:

`AverageATR = (ATR[2] + ATR[3] + ... + ATR[51]) / 50`

A high-volatility regime is confirmed when:

`CurrentATR >= AverageATR * 1.3`

The reference average excludes ATR at shift 1.

### Buy Conditions

A Buy order is eligible when:

1. The high-volatility regime condition is satisfied.
2. `EMA20[1] > EMA50[1]`.
3. No matching position already exists for the symbol and Magic Number.
4. Spread and trading-permission checks pass.

### Sell Conditions

A Sell order is eligible when:

1. The high-volatility regime condition is satisfied.
2. `EMA20[1] < EMA50[1]`.
3. No matching position already exists for the symbol and Magic Number.
4. Spread and trading-permission checks pass.

When the two EMA values are equal, no order is submitted.

The strategy does not require a fresh EMA crossover, a candle breakout, or an additional momentum confirmation.

## Entry Timing

The EA evaluates new entries once per new chart candle.

ATR and EMA signals are read from completed candles.

Open-position management is performed on every tick, before the new-entry checks.

If a qualifying regime persists, the EA may open another trade on a subsequent candle after the previous matching position has closed.

## Risk Management

The EA includes:

- Fixed lot position sizing
- Initial Stop Loss and Take Profit
- Optional Break Even
- Optional Trailing Stop
- Maximum spread filter
- Broker volume-step normalization
- Broker minimum stop-distance handling for initial orders
- Symbol and Magic Number position filtering

The EA does not implement grid trading, martingale, or percentage-based risk sizing.

## Default Input Parameters

| Parameter | Default |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 points |
| `InpTakeProfit` | 600 points |
| `InpMagicNumber` | 127123 |
| `InpSlippage` | 10 points |
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 points |
| `InpBreakEvenOffset` | 0 points |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 points |
| `InpTrailingDistance` | 200 points |
| `InpMaxSpread` | 30 points |
| `InpATRPeriod` | 14 |
| `InpATRLookback` | 50 |
| `InpHighATRFactor` | 1.3 |
| `InpFastEMA` | 20 |
| `InpSlowEMA` | 50 |

The nominal initial Stop Loss-to-Take Profit distance ratio is 1:2.

Actual realized results may differ because of execution conditions and dynamic Stop Loss management.

## Backtest Summary

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Net Profit | -$904.38 |
| Profit Factor | 0.90 |
| Equity Drawdown Relative | 92.25% |
| Recovery Factor | -0.98 |
| Total Trades | 6,698 |
| Winning Trades | 3,092 (46.16%) |

## Research Status

**FAILED BACKTEST — Further Research Required**

The tested configuration produced a substantial loss, negative expectancy, and severe equity drawdown.

The available evidence does not support live deployment or capital scaling.

## Repository Files

- `EA-127_ATR_High_Regime.mq5` — MQL5 source code
- `README.md` — Strategy documentation

## Disclaimer

This Expert Advisor is intended for research and educational purposes.

Historical backtest results do not guarantee future trading performance.
