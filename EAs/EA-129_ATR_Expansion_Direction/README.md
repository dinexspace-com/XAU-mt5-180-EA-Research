# EA-129_ATR_Expansion_Direction

## Overview

EA-129_ATR_Expansion_Direction is a MetaTrader 5 Expert Advisor written in MQL5.

The strategy combines Average True Range (ATR) expansion with a directional price breakout.

ATR determines whether market volatility has expanded sufficiently, while the close of the latest completed candle determines whether price has broken above or below a historical trading range.

The EA uses fixed lot sizing, initial Stop Loss and Take Profit, optional Break Even, optional Trailing Stop, and a spread filter.

## Strategy Concept

The EA requires two conditions:

1. ATR on the latest completed candle must be at least a configured multiple of ATR on the preceding completed candle.
2. The latest completed candle must close beyond the high or low of a specified number of earlier candles.

The strategy does not require ATR to be below a historical average before expansion.

It also does not require a separate directional indicator such as EMA, MACD, RSI, or ADX.

## ATR Expansion Rule

The indicator is created using:

`iATR(_Symbol, _Period, InpATRPeriod)`

With the default settings:

- ATR period: 14
- ATR expansion factor: 1.1

The code reads:

`ATRCurrent = ATR[1]`

`ATRPrevious = ATR[2]`

The expansion condition is:

`ATRCurrent >= ATRPrevious * InpATRExpansionFactor`

At the default factor of 1.1, the latest completed ATR must be at least 110% of the preceding ATR.

Both values come from completed candles.

The code also requires `ATRPrevious > 0`.

## Historical Breakout Range

The EA calculates the maximum high and minimum low of historical candles beginning at shift 2.

For `InpBreakoutBars = N`:

`RangeHigh = max(High[2], ..., High[N+1])`

`RangeLow = min(Low[2], ..., Low[N+1])`

With the default `N = 10`, the reference range includes candles at shifts 2 through 11.

The latest completed candle, shift 1, is excluded from the reference range.

## Buy Entry

A Buy order is submitted when:

1. Trading is permitted.
2. A new candle is detected.
3. No position with the same symbol and Magic Number is open.
4. Current spread is within the maximum.
5. `InpBreakoutBars >= 2`.
6. ATR values are available and valid.
7. `ATR[2] > 0`.
8. `ATR[1] >= ATR[2] * 1.1`.
9. `Close[1] > RangeHigh`.

The EA submits a market Buy order after the signal candle has completed.

## Sell Entry

A Sell order is submitted under the same execution and ATR conditions when:

`Close[1] < RangeLow`

The EA submits a market Sell order after the signal candle has completed.

No entry occurs when the signal candle closes within the historical range.

## Entry Timing

New entries are evaluated once per newly detected chart candle.

The signal uses completed candles, reducing the risk of relying on an unfinished candle.

Open-position management is performed on every tick before the new-entry checks.

The EA restricts open positions to one matching symbol and Magic Number at a time.

It does not enforce a waiting period after a position closes.

## Position Management

The EA includes:

- Fixed lot size
- Initial Stop Loss
- Initial Take Profit
- Break Even
- Trailing Stop
- Spread filter
- Broker volume normalization
- Initial stop-distance adjustment
- Magic Number-based position identification

The initial nominal Stop Loss-to-Take Profit distance ratio is 1:2.

However, Break Even, Trailing Stop, and execution conditions can alter realized outcomes.

The EA does not use grid trading, martingale, or account-equity-based lot sizing.

## Default Inputs

| Parameter | Default |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 points |
| `InpTakeProfit` | 600 points |
| `InpMagicNumber` | 129123 |
| `InpSlippage` | 10 points |
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 points |
| `InpBreakEvenOffset` | 0 points |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 points |
| `InpTrailingDistance` | 200 points |
| `InpMaxSpread` | 30 points |
| `InpATRPeriod` | 14 |
| `InpATRExpansionFactor` | 1.1 |
| `InpBreakoutBars` | 10 |

All these values match the parameters recorded in the supplied Strategy Tester report.

## Supplied Backtest Summary

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Net Profit | -$653.50 |
| Profit Factor | 0.70 |
| Expected Payoff | -$0.45 |
| Recovery Factor | -0.98 |
| Equity Drawdown Relative | 66.52% |
| Total Trades | 1,463 |
| Win Rate | 41.22% |

## Research Status

**FAILED BACKTEST — NOT VALIDATED**

The supplied backtest demonstrates negative expectancy and substantial capital drawdown.

The current evidence does not support live deployment or capital scaling.

Additional research should focus on entry quality, breakout confirmation, exit behavior, and out-of-sample validation.

## Repository Files

- `EA-129_ATR_Expansion_Direction.mq5`
- `README.md`

## Disclaimer

This Expert Advisor is documented for research and educational purposes.

Historical Strategy Tester results do not guarantee future performance.
