
# EA-107 — Previous Day Extreme Reversion

## Overview

EA-107 is an XAUUSD Expert Advisor for MetaTrader 5 that trades potential reversals around the previous day's high and low.

The EA evaluates the previous completed candle on the chart timeframe and compares its price extremes and closing price with the previous day's range.

## Strategy Logic

### SELL Setup

Open a SELL position when:

- The previous candle's high exceeds the previous day's high.
- The previous candle closes below the previous day's high.

Condition:

`High[1] > PreviousDayHigh AND Close[1] < PreviousDayHigh`

### BUY Setup

Open a BUY position when:

- The previous candle's low falls below the previous day's low.
- The previous candle closes above the previous day's low.

Condition:

`Low[1] < PreviousDayLow AND Close[1] > PreviousDayLow`

The EA checks signals on a new bar and allows only one open position with the configured magic number on the current symbol.

## Baseline Configuration

| Parameter | Value |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123462 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Break-even | Enabled |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

## Baseline Reference

`EA107-M1-BASELINE-001`

## Baseline Status

**Result: FAIL**

The baseline backtest produced negative net profit, a Profit Factor below 1.0, and an equity drawdown of 18.51%.

The strategy is not validated for live trading. Further work should focus on entry quality and controlled research before considering parameter optimization.

## Limitations

- The baseline uses a single symbol and timeframe.
- The previous-day high/low reversal condition does not include an additional confirmation filter.
- The current result does not establish out-of-sample robustness.
- Backtest performance does not guarantee future results.
