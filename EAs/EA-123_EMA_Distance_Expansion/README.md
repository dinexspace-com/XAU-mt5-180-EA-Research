# EA-123_EMA_Distance_Expansion

## Overview

EA-123_EMA_Distance_Expansion is an Expert Advisor developed in MQL5 for MetaTrader 5.

The strategy identifies potential directional momentum by measuring the expansion of the absolute distance between a fast Exponential Moving Average (EMA) and a slow EMA.

It combines EMA separation expansion with the direction of the fast EMA to generate trading signals.

## Trading Strategy

### Indicators

- Fast EMA: 8 periods
- Slow EMA: 21 periods
- Applied Price: Close
- Expansion Factor: 1.2

### EMA Distance Expansion

The strategy calculates the absolute distance between the fast and slow EMAs on the two most recently completed candles.

- Current completed-candle distance: `D1 = abs(FastEMA[1] - SlowEMA[1])`
- Previous completed-candle distance: `D2 = abs(FastEMA[2] - SlowEMA[2])`

A valid expansion requires:

`D2 > 0` and `D1 >= D2 * ExpansionFactor`

This condition detects increasing EMA separation rather than requiring an EMA crossover.

### Buy Conditions

- The EMA distance expansion condition is satisfied.
- Fast EMA is above Slow EMA.
- Fast EMA on the latest completed candle is higher than its previous value.
- No existing matching position for the symbol and Magic Number.
- Spread is within the configured limit.
- Trading permissions are enabled.

### Sell Conditions

- The EMA distance expansion condition is satisfied.
- Fast EMA is below Slow EMA.
- Fast EMA on the latest completed candle is lower than its previous value.
- No existing matching position for the symbol and Magic Number.
- Spread is within the configured limit.
- Trading permissions are enabled.

Entry conditions are evaluated once per new candle using completed-candle indicator values.

## Risk Management

The EA includes:

- Fixed lot sizing
- Initial Stop Loss and Take Profit
- Optional Break Even
- Optional Trailing Stop
- Maximum spread filter
- Magic Number-based position identification
- One matching open position at a time
- Broker volume normalization
- Broker minimum initial stop-distance handling

Position management runs on every tick.

The source code does not implement martingale, grid trading, or equity-percentage-based position sizing.

## Backtest Configuration

| Parameter | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Fixed Lot | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Fast EMA | 8 |
| Slow EMA | 21 |
| Expansion Factor | 1.2 |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| Slippage | 10 points |
| Magic Number | 123123 |

## Backtest Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000 |
| Net Profit | -$994.33 |
| Profit Factor | 0.88 |
| Equity Drawdown Relative | 99.45% |
| Recovery Factor | -0.96 |
| Total Trades | 6,598 |
| Winning Trades | 46.15% |

Test period: 2026-01-02 to 2026-04-01.

## Research Status

**Status: Backtest Failed — Further Research Required**

The tested configuration produced negative returns and extreme drawdown.

The results do not support live deployment or capital scaling.

## Files

- `EA-123_EMA_Distance_Expansion.mq5` — MQL5 source code
- `README.md` — Strategy documentation

## Disclaimer

This Expert Advisor is provided for research and educational purposes. Historical results do not guarantee future trading performance.
