
# EA-083 — Bollinger Mid Reversion

## Overview

EA-083 is an automated Bollinger Bands mean-reversion strategy for MetaTrader 5.

The strategy identifies rejection candles at the outer Bollinger Bands and attempts to capture a return toward the middle band.

- Instrument: XAUUSD
- Tested symbol: XAUUSD.PRO
- Timeframe: M1
- Strategy: Bollinger Mid Reversion
- Indicator: Bollinger Bands
- Directions: BUY and SELL
- Version: 1.00
- Magic Number: 123083
- Status: BACKTEST FAILED

## 1. Trading Logic

Bollinger Bands:
- Period: 20
- Standard deviation: 2.0
- Applied price: Close

BUY conditions:
1. The completed candle touches or crosses the lower band.
2. The candle closes above the lower band.
3. The candle closes below the middle band.
4. The candle is bullish: Close > Open.
5. The current Ask remains below the middle band.

SELL conditions:
1. The completed candle touches or crosses the upper band.
2. The candle closes below the upper band.
3. The candle closes above the middle band.
4. The candle is bearish: Close < Open.
5. The current Bid remains above the middle band.

Signals are evaluated on completed candles.

## 2. Exit Logic

Middle Band Exit:

BUY positions close when Bid reaches or exceeds the middle band.

SELL positions close when Ask reaches or falls below the middle band.

The middle-band exit uses the indicator value from the most recently completed candle.

Position management also includes the configured SL, TP, Break Even and Trailing Stop.

## 3. Default Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123083 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Buffer | 0 |
| Bollinger Period | 20 |
| Bollinger Deviation | 2.0 |

Break Even:
- Enabled.
- Trigger: 150 points.
- Offset: 0 points.

Trailing Stop:
- Enabled.
- Start: 200 points.
- Distance: 100 points.
- Step: 10 points.

The nominal initial SL:TP ratio is 1:2.

Actual exits may occur earlier because of the middle-band exit, Break Even and Trailing Stop.

## 4. Execution Protection

The source includes:

- Maximum spread filtering.
- Trading permission checks.
- Broker stop-distance validation.
- Margin checks.
- Tick-size price normalization.
- Position and order checks by Magic Number.
- One active position/order per Magic Number across the account.
- Additional symbol-exposure protection on netting accounts.

## 5. Known Implementation Limitations

InpBreakoutBuffer is declared but is not applied to the entry signal.

The strategy does not include a dedicated trend filter, volatility-regime filter or trading-session filter.

The strategy uses fixed lot sizing.

## 6. Initial Backtest

Period: January–March 2026.

- Initial Deposit: $1,000.
- Total Trades: 4,484.
- Net Profit: -$991.84.
- Profit Factor: 0.81.
- Maximum Equity Drawdown: 99.20%.
- Win Rate: 53.93%.

Status: FAILED.

Preserve the original source as the baseline.

Do not overwrite the original EA when developing experimental versions.

Successful compilation and live execution have not been independently verified.
