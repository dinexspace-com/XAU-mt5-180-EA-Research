# EA-122_DI_Cross

## Overview

EA-122_DI_Cross is an Expert Advisor developed in MQL5 for MetaTrader 5.

The strategy uses crossovers between the Positive Directional Indicator (+DI) and Negative Directional Indicator (-DI), combined with an Exponential Moving Average (EMA) trend filter.

The EA supports automated position entry, fixed lot sizing, Stop Loss, Take Profit, Break Even, Trailing Stop, and spread filtering.

## Trading Strategy

**Buy Conditions**
- On the preceding closed candle, +DI was less than or equal to -DI.
- On the latest closed candle, +DI crosses above -DI.
- The latest closed candle's closing price is above the EMA.
- No existing position with the same symbol and Magic Number.
- Spread is within the configured limit.

**Sell Conditions**
- On the preceding closed candle, -DI was less than or equal to +DI.
- On the latest closed candle, -DI crosses above +DI.
- The latest closed candle's closing price is below the EMA.
- No existing position with the same symbol and Magic Number.
- Spread is within the configured limit.

Entry signals are evaluated once per new candle using closed-candle indicator values.

The ADX main line is not used as an entry threshold. The strategy uses the +DI and -DI buffers from the ADX indicator.

## Risk Management

- Fixed lot sizing
- Stop Loss and Take Profit
- Optional Break Even
- Optional Trailing Stop
- Maximum spread filter
- Maximum one matching open position per symbol and Magic Number
- Broker volume limits and minimum initial stop-distance handling

The EA does not implement percentage-based position sizing, martingale, or grid trading.

## Backtest Configuration

| Parameter | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| DI Period | 14 |
| EMA Period | 20 |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| Slippage | 10 points |
| Magic Number | 122123 |

## Backtest Summary

Period: 2026-01-02 to 2026-04-01

- Initial Deposit: $1,000
- Total Trades: 3,647
- Net Profit: -$992.57
- Profit Factor: 0.79
- Equity Drawdown Relative: 99.30%
- Recovery Factor: -0.94
- Winning Trades: 45.13%

## Research Status

**Status: Backtest failed — further research required.**

The tested configuration produced substantial losses and extreme drawdown.

The results do not support live deployment or capital scaling without additional investigation and independent validation.

## Files

- `EA-122_DI_Cross.mq5` — MQL5 source code
- `README.md` — Strategy documentation

## Disclaimer

This Expert Advisor is provided for research and educational purposes. Historical backtest results do not guarantee future trading performance.
