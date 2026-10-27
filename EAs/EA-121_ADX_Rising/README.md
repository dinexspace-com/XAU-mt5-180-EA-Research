# EA-121_ADX_Rising

## Overview

EA-121_ADX_Rising is an Expert Advisor developed in MQL5 for MetaTrader 5.

The strategy uses the Average Directional Index (ADX) and Directional Indicators (+DI / -DI) to identify potential trading opportunities based on rising trend strength.

The EA supports automated position entry, fixed lot sizing, Stop Loss, Take Profit, Break Even, Trailing Stop, and spread filtering.

## Trading Strategy

**Buy Conditions**
- ADX on the latest closed candle is higher than ADX on the preceding closed candle.
- ADX meets the configured minimum threshold.
- +DI is greater than -DI.
- No existing position with the same symbol and Magic Number.
- Spread is within the configured limit.

**Sell Conditions**
- ADX on the latest closed candle is higher than ADX on the preceding closed candle.
- ADX meets the configured minimum threshold.
- -DI is greater than +DI.
- No existing position with the same symbol and Magic Number.
- Spread is within the configured limit.

Entry signals are evaluated once per new candle using closed-candle indicator values.

## Risk Management

- Fixed lot sizing
- Stop Loss and Take Profit
- Optional Break Even
- Optional Trailing Stop
- Maximum spread filter
- Maximum one matching open position per symbol and Magic Number
- Broker volume limits and minimum stop-distance handling

The EA does not implement percentage-based position sizing, martingale, or grid trading.

## Backtest Configuration

| Parameter | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| ADX Period | 14 |
| Minimum ADX | 0.0 |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| Magic Number | 121123 |

## Backtest Summary

Period: 2026-01-02 to 2026-04-01

- Initial Deposit: $1,000
- Total Trades: 3,840
- Net Profit: -$993.01
- Profit Factor: 0.80
- Equity Drawdown Relative: 99.30%
- Recovery Factor: -1.00
- Winning Trades: 47.06%

## Research Status

**Status: Backtest failed — further research required.**

The tested configuration produced a substantial loss and extreme drawdown.

These results do not support live deployment or capital scaling without additional investigation, strategy modifications, and independent validation.

## Files

- `EA-121_ADX_Rising.mq5` — MQL5 source code
- `README.md` — Strategy documentation

## Disclaimer

This Expert Advisor is provided for research and educational purposes. Historical backtest results do not guarantee future trading performance.
