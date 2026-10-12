# EA-112 — MACD Histogram Expansion

## Overview

EA-112 is an experimental MetaTrader 5 Expert Advisor for XAUUSD. It uses MACD histogram expansion to identify directional momentum and enter BUY or SELL positions.

**Current Status:** FAIL — Baseline  
**Baseline ID:** `EA112-M1-BASELINE-001`  
**Platform:** MetaTrader 5  
**Symbol:** XAUUSD.PRO  
**Timeframe:** M1  
**Version:** 1.01

## Strategy Logic

### BUY Setup

The EA checks the three most recent closed MACD histogram values.

A BUY signal is generated when:

- The latest closed histogram value is positive.
- The latest value is greater than the preceding value.
- The preceding value is greater than the older value.

In simplified form:

`a > 0 && a > b && b > c`

This represents a positive histogram that is expanding across the checked closed candles.

### SELL Setup

A SELL signal is generated when:

- The latest closed histogram value is negative.
- The latest value is lower than the preceding value.
- The preceding value is lower than the older value.

In simplified form:

`a < 0 && a < b && b < c`

This represents a negative histogram that is expanding in the negative direction.

## Default Parameters

| Parameter | Default |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 112001 |
| Slippage | 10 points |
| Fast EMA | 12 |
| Slow EMA | 26 |
| Signal Period | 9 |
| Maximum Spread | 30 points |
| Break-even | Enabled |
| Break-even Start | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

## Trade Management

- Entry conditions are evaluated once per new candle.
- Existing positions are managed on every tick.
- The EA allows one open position per symbol and magic number.
- Break-even and trailing-stop logic can modify the stop loss.
- Entries are filtered by the configured maximum spread.
- Initial stop loss and take profit are submitted with the order.

## Baseline Assessment

The first baseline test produced a negative net profit and a maximum equity drawdown of 99.33%. The current strategy is not suitable for live trading.

The next step is to investigate signal behavior and trade management before attempting parameter optimization.

## Research Links

- Backtest: `Backtest/EA-112_MACD_Histogram_Expansion/README.md`
- Research: `Research/EA-112_MACD_Histogram_Expansion/README.md`
- Methodology: `docs/methodology.md`

## Disclaimer

This EA is experimental research software. A successful compilation or completed backtest does not establish profitability or readiness for live trading.
