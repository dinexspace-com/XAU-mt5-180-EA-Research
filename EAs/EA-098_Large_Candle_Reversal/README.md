# EA-098 — Large Candle Reversal

## Strategy Overview

EA-098 is an XAUUSD M1 reversal strategy based on large-candle detection using ATR(14).

The EA identifies a completed candle whose total range exceeds a configurable ATR multiple. When the large candle condition is met, the EA evaluates the relationship between the candle close and its midpoint, then uses the following candle to confirm the reversal direction.

### BUY Condition

The setup is based on a bearish large candle:

* Previous signal candle is bearish.
* Signal candle close is below its midpoint.
* Confirmation candle closes above the signal candle midpoint.
* EA opens a BUY position.

### SELL Condition

The setup is based on a bullish large candle:

* Previous signal candle is bullish.
* Signal candle close is above its midpoint.
* Confirmation candle closes below the signal candle midpoint.
* EA opens a SELL position.

The EA evaluates signals on a new M1 bar and limits exposure to one active position/order for the EA magic number.

## Baseline Configuration

| Parameter                   |      Value |
| --------------------------- | ---------: |
| Symbol                      | XAUUSD.PRO |
| Timeframe                   |         M1 |
| Lot Size                    |       0.01 |
| Stop Loss                   | 300 points |
| Take Profit                 | 600 points |
| ATR Period                  |         14 |
| Large Candle ATR Multiplier |        2.0 |
| Maximum Spread              |  30 points |
| Break Even                  |         ON |
| Break Even Trigger          | 150 points |
| Break Even Offset           |          0 |
| Trailing Stop               |         ON |
| Trailing Start              | 200 points |
| Trailing Distance           | 100 points |
| Trailing Step               |  10 points |
| Magic Number                |     123098 |

## Research Status

`BASELINE FAILED — RESEARCH IN PROGRESS`

The baseline is retained as the reference implementation for controlled research.

The EA is **not validated for live trading**.

Broad parameter optimization is blocked until the core reversal hypothesis demonstrates sufficient robustness.
