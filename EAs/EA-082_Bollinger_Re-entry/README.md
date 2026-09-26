
# EA-082 — Bollinger Re-entry

## Overview

EA-082 is an automated mean-reversion trading strategy for MetaTrader 5.

The strategy detects price returning inside the Bollinger Bands after a previous candle closed outside a band or the signal candle crossed beyond a band.

- Instrument: XAUUSD
- Tested symbol: XAUUSD.PRO
- Timeframe: M1
- Indicator: Bollinger Bands
- Strategy: Bollinger Re-entry
- Directions: BUY and SELL
- Version: 1.00
- Status: BACKTEST FAILED

## 1. Trading Logic

Bollinger Bands:
- Period: 20
- Standard deviation: 2.0
- Applied price: Close

BUY conditions:
1. The completed signal candle closes inside the bands.
2. Either the previous candle closed below the lower band or the signal candle's low crossed below the lower band.
3. No conflicting SELL signal exists.

SELL conditions:
1. The completed signal candle closes inside the bands.
2. Either the previous candle closed above the upper band or the signal candle's high crossed above the upper band.
3. No conflicting BUY signal exists.

Signals are evaluated once per completed candle. Entry is attempted at the start of the following candle.

A candle producing both BUY and SELL conditions is ignored.

## 2. Default Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123082 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Buffer | 0 |
| Bollinger Period | 20 |
| Bollinger Deviation | 2.0 |

## 3. Position Management

Break Even:
- Enabled.
- Trigger: 150 points.
- Offset: 0 points.

Trailing Stop:
- Enabled.
- Start: 200 points.
- Distance: 100 points.
- Step: 10 points.

The initial nominal reward-to-risk ratio is 2:1.

Actual trade outcomes depend on execution, Break Even and Trailing Stop.

## 4. Execution Protection

The source includes:

- Maximum spread filtering.
- Broker stop-distance validation.
- Margin checks.
- Trading permission checks.
- Tick-size price normalization.
- Position and order checks using Magic Number.
- Position management on every tick.

The source limits exposure to one active position/order per Magic Number across the account.

On netting accounts, existing exposure on the same symbol also blocks new entries.

## 5. Implementation Notes

The Breakout Buffer input exists in the source but is not applied in GetSignal().

It must not be treated as an active signal filter in this version.

The EA does not contain a dedicated trend filter, volatility-regime filter or trading-session filter.

## 6. Backtest Status

Initial test:
- Period: January–March 2026.
- Trades: 6,504.
- Net Profit: -$994.17.
- Profit Factor: 0.88.
- Maximum Equity Drawdown: 99.43%.

Status: FAILED.

Preserve this source as the original baseline.

Do not overwrite the original source when developing experimental versions.

Compilation and live execution have not been independently verified in this documentation.
