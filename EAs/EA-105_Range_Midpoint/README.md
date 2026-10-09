# EA-105 — Range Midpoint

## Overview

**EA ID:** EA-105
**Strategy:** Range Boundary Rejection
**Symbol:** XAUUSD.PRO
**Timeframe:** M1
**Baseline ID:** `EA105-M1-BASELINE-001`
**Status:** `FAIL — BASELINE`

EA-105 identifies a recent price range and looks for rejection candles near its upper or lower boundary.

## Strategy Logic

The EA calculates the highest high and lowest low over the previous `InpRangeBars` candles, starting from shift 2. The current signal uses the completed candle at shift 1.

### BUY Entry

A BUY signal is generated when all conditions are met:

* Signal candle low reaches the lower 10% zone of the calculated range.
* Lower wick / candle range ≥ `InpRejectionWickRatio`.
* Signal candle closes bullish.

### SELL Entry

A SELL signal is generated when all conditions are met:

* Signal candle high reaches the upper 10% zone of the calculated range.
* Upper wick / candle range ≥ `InpRejectionWickRatio`.
* Signal candle closes bearish.

## Default Parameters

| Parameter            | Baseline Value |
| -------------------- | -------------: |
| Lot Size             |           0.01 |
| Stop Loss            |     300 points |
| Take Profit          |     600 points |
| Magic Number         |         123460 |
| Slippage             |      10 points |
| Maximum Spread       |      30 points |
| Range Bars           |             20 |
| Rejection Wick Ratio |            0.5 |
| Break-even           |        Enabled |
| Break-even Trigger   |     150 points |
| Break-even Offset    |       0 points |
| Trailing Stop        |        Enabled |
| Trailing Start       |     200 points |
| Trailing Distance    |     200 points |

## Trade Management

* Evaluates entries once per new candle.
* Allows no additional EA position for the same symbol and magic number while one is open.
* Checks trading permissions and maximum spread.
* Applies initial Stop Loss and Take Profit to market orders.
* Manages break-even and trailing stop on ticks.
* Checks broker stop-level requirements before submitting orders.

## Baseline Assessment

**Result:** `FAIL`

The baseline produced negative net profit, a Profit Factor below 1.0 and high equity drawdown. The strategy is not validated for live trading.

See `Backtest/EA-105_Range_Midpoint/README.md` for the recorded test results and `Research/EA-105_Range_Midpoint/README.md` for the controlled research plan.

## Research Policy

Preserve this baseline unchanged. Test one parameter group at a time and retain all experiment results, including failed configurations.

**Live Trading:** Not approved.
