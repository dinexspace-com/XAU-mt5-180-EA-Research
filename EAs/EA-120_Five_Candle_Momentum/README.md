# EA-120: Five Candle Momentum

## Overview

EA-120_Five_Candle_Momentum is an experimental MetaTrader 5 Expert Advisor developed in MQL5 for automated trading on the XAUUSD market.

The current implementation calculates a linear regression slope from recent closing prices and uses the slope direction to determine trade entries. It also includes spread filtering, fixed Stop Loss and Take Profit settings, break-even management, and trailing-stop management.

**Current status:** Research and backtesting. The available test results do not demonstrate profitability.

## Strategy Implementation

The EA currently implements the following logic:

1. Detect a new chart bar before evaluating a new entry.
2. Check whether automated trading is permitted.
3. Check whether a position with the same symbol and Magic Number already exists.
4. Reject new entries when the spread exceeds the configured limit.
5. Calculate the linear regression slope from the configured number of recently closed candles.
6. Submit a market order according to the calculated slope:
   - Negative slope: BUY.
   - Positive slope: SELL.
   - Zero slope: No new order.
7. Manage open positions using break-even and trailing-stop logic when enabled.

**Important:** The current source code does not explicitly implement a condition requiring five consecutive bullish or bearish candles. The strategy name should not be interpreted as proof that such a condition is implemented.

## Default Parameters

| Parameter | Default | Description |
|---|---:|---|
| `InpLotSize` | 0.01 | Fixed trading volume |
| `InpStopLoss` | 300 | Stop Loss distance in points |
| `InpTakeProfit` | 600 | Take Profit distance in points |
| `InpMagicNumber` | 120001 | EA position identifier |
| `InpSlippage` | 10 | Maximum configured price deviation in points |
| `InpUseBreakEven` | true | Enable break-even management |
| `InpBreakEvenStart` | 150 | Profit threshold for break-even, in points |
| `InpBreakEvenOffset` | 0 | Break-even offset, in points |
| `InpUseTrailingStop` | true | Enable trailing-stop management |
| `InpTrailingStart` | 200 | Profit threshold for trailing stop, in points |
| `InpTrailingDistance` | 200 | Trailing-stop distance, in points |
| `InpMaxSpread` | 30 | Maximum permitted spread, in points |
| `InpSlopePeriod` | 5 | Number of closed candles used for slope calculation |

Point-based distances depend on the symbol's price precision and point size. They should not be assumed to represent a fixed dollar movement.

## Risk Management

The EA includes the following mechanisms:

- Fixed lot size.
- Initial Stop Loss and Take Profit.
- Break-even adjustment.
- Trailing-stop adjustment.
- Maximum-spread filter.
- One-position-at-a-time restriction for the same symbol and Magic Number.

These mechanisms do not guarantee capital preservation or profitability.

## Current Backtest

The supplied Strategy Tester report records the following configuration:

- Symbol: `XAUUSD.PRO`
- Timeframe: M1
- Test period: 2026-01-02 to 2026-04-01
- Initial deposit: USD 1,000
- Model quality: 100% real ticks

Key results:

| Metric | Result |
|---|---:|
| Net profit | -USD 992.60 |
| Profit factor | 0.84 |
| Maximum balance drawdown | 99.28% |
| Total trades | 5,012 |
| Winning trades | 48.16% |
| Losing trades | 51.84% |

The tested configuration produced a substantial loss and should not be considered ready for live trading.

## Limitations

- The current entry logic is based on regression slope rather than an explicit five-candle confirmation rule.
- The relationship between the intended strategy and the implemented BUY/SELL direction requires verification.
- The supplied backtest does not establish robustness across different market periods or execution conditions.
- Parameter optimization and out-of-sample validation have not been documented in the supplied materials.

## Reproducibility

Use the supplied `.mq5` source and record the complete Strategy Tester configuration for each experiment.

Each new test should have its own report and documented parameter settings.

## Disclaimer

This project is for research and educational purposes. Backtest performance does not guarantee future results. No live-trading profitability is claimed.
