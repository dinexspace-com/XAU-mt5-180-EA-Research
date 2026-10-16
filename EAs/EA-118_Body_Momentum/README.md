# EA-118 — Body Momentum

## Overview

EA-118 Body Momentum is an experimental MetaTrader 5 Expert Advisor designed to identify strong candlestick momentum on the current chart timeframe.

The EA compares the body of the most recently closed candle with the average candle body over a configurable lookback period. It also checks whether the candle closes near its high or low before opening a trade.

**Current status: FAIL — Baseline**

The initial backtest showed a substantial loss and an extremely high drawdown. This version is retained for research and debugging only.

## Strategy Logic

### BUY Conditions

A BUY signal is generated when all conditions are satisfied:

- The previous candle is bullish.
- Its body is at least `InpBodyMultiplier` times the average body of the preceding candles.
- Its closing price is sufficiently close to the candle high, according to `InpExtremeCloseRatio`.
- The spread is within the configured limit.
- No existing position with the same symbol and magic number is detected.
- Trading is permitted and a new bar is detected.

### SELL Conditions

A SELL signal is generated when all conditions are satisfied:

- The previous candle is bearish.
- Its body is at least `InpBodyMultiplier` times the average body of the preceding candles.
- Its closing price is sufficiently close to the candle low.
- The spread and trading-permission checks pass.
- No existing position with the same symbol and magic number is detected.
- A new bar is detected.

## Default Parameters

| Parameter | Default |
|---|---:|
| Lot size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 118001 |
| Slippage | 10 points |
| Break-even | Enabled |
| Break-even trigger | 150 points |
| Break-even offset | 0 points |
| Trailing Stop | Enabled |
| Trailing trigger | 200 points |
| Trailing distance | 200 points |
| Maximum spread | 30 points |
| Average body period | 20 candles |
| Body multiplier | 1.50 |
| Extreme close ratio | 0.75 |

## Position Management

- Only one position per symbol and magic number is permitted by the entry logic.
- Break-even management is applied after the configured profit threshold.
- Trailing-stop management is applied after its configured trigger.
- Stop Loss and Take Profit are set when a trade is opened.
- Position management runs on incoming ticks.

## Baseline Backtest Summary

- Symbol: XAUUSD.PRO
- Timeframe: M1
- Test period: 2026-01-02 to 2026-04-01
- Initial deposit: $1,000
- Net profit: -$992.26
- Profit Factor: 0.74
- Maximum equity drawdown: 99.24%
- Total trades: 2,911
- History quality: 100% real ticks

## Limitations

The baseline result does not support live deployment. The strategy requires further investigation into entry quality, transaction costs, exit management, and sensitivity to market conditions.

No optimization, out-of-sample validation, or forward-test success is claimed.

## Development Decision

**FAIL — Baseline only.**

Keep the source for reproducible research. Do not treat the current parameters as validated or production-ready.
