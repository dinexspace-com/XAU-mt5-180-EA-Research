
# EA-079 — Daily Open Break

## Overview

EA-079 is an automated trading strategy developed in MQL5 for MetaTrader 5. It trades price crossings of the current daily opening price, using closed candles for signal confirmation.

The strategy is designed for research on XAUUSD and includes fixed stop-loss and take-profit levels, break-even protection, trailing stops, spread filtering and position management.

**Research status:** Experimental — current backtest failed.

## Trading Logic

The EA retrieves the opening price of the current D1 candle and uses it as the reference level.

A BUY signal occurs when:
- The previous closed candle was at or below the daily opening price.
- The latest closed candle closes above the daily opening price.

A SELL signal occurs when:
- The previous closed candle was at or above the daily opening price.
- The latest closed candle closes below the daily opening price.

Signals are evaluated once per newly formed candle on the selected trading timeframe. The EA does not open a trade from an old signal immediately after being attached.

A breakout buffer can be applied to the daily opening level. The current default buffer is zero.

Although the source includes a breakout lookback parameter and range-calculation functions, the active entry logic uses the daily opening price rather than a rolling high-low breakout.

## Risk Management

The EA includes:
- Fixed lot sizing.
- Fixed stop loss and take profit.
- Break-even protection.
- Trailing stop management.
- Maximum spread filtering.
- Broker stop-distance validation.
- Available-margin verification.
- One active position or order per EA magic number across the account.

The EA does not use martingale, grid trading or automatic lot multiplication.

## Default Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123079 |
| Maximum Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |

The breakout lookback parameter is currently unused by the active signal logic.

## Backtest Summary

The supplied MT5 backtest covers January 2 to March 31, 2026, on XAUUSD.PRO, M1.

- Initial deposit: $1,000
- Net profit: -$282.20
- Profit factor: 0.78
- Total trades: 940
- Winning trades: 433 (46.06%)
- Maximum equity drawdown: 31.05%

The current configuration has not demonstrated profitability in the supplied test.

## Source Code

`EA-079_Daily_Open_Break.mq5`

The source is provided for strategy research, testing and further development. The supplied materials do not establish successful independent compilation or live-trading performance.

## Disclaimer

This EA is experimental research software. Historical backtest results do not guarantee future performance. It should not be considered validated for live deployment.
