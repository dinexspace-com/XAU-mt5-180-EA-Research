# EA-089_EMA20_Distance — Research

## 1. Research Objective

This research documents the observed behaviour of EA-089_EMA20_Distance using the available Strategy Tester result.

The research focuses on:

* Entry logic.
* Trade frequency.
* Profit and loss distribution.
* Drawdown.
* Directional trade statistics.
* Position holding time.
* MFE/MAE relationships.
* Limitations of the current test.

---

## 2. Strategy Structure

EA-089_EMA20_Distance uses an EMA and ATR combination.

The default configuration is:

```text
EMA Period   = 20
ATR Period   = 14
Distance ATR = 1.5
```

The strategy looks for price conditions where the previous completed candle is sufficiently distant from EMA and then checks for a directional reversal condition.

The EA operates on the M1 timeframe by default.

---

## 3. Observed Backtest Result

The available test covers:

```text
Symbol      : XAUUSD.PRO
Timeframe   : M1
Period      : 2026.01.02 – 2026.03.31
Initial     : USD 1,000
Data        : 100% real ticks
```

The test produced:

```text
Net Profit       : -597.97 USD
Profit Factor    : 0.93
Sharpe Ratio     : -5.00
Equity Drawdown  : 80.66%
Total Trades     : 7,313
```

These values describe this specific backtest configuration and period only.

---

## 4. Trade Distribution

The test produced:

```text
Short Trades : 3,759
Short Win %  : 51.32%

Long Trades  : 3,554
Long Win %   : 50.03%
```

Overall:

```text
Profit Trades : 3,707 (50.69%)
Loss Trades   : 3,606 (49.31%)
```

The number of profitable trades was therefore close to the number of losing trades, while the average loss was larger than the average profit.

---

## 5. Profit and Loss Structure

The test reported:

```text
Average Profit Trade :  2.25 USD
Average Loss Trade   : -2.48 USD

Largest Profit Trade :   7.95 USD
Largest Loss Trade   : -18.35 USD
```

Gross results:

```text
Gross Profit :  8,333.49 USD
Gross Loss   : -8,931.46 USD
```

The resulting net profit was:

```text
-597.97 USD
```

---

## 6. Drawdown Observation

The reported maximum equity drawdown was:

```text
812.56 USD
80.66%
```

The initial deposit for the test was:

```text
1,000 USD
```

Therefore, the observed drawdown represented a substantial portion of the initial test capital.

This is an observation of the supplied backtest and is not a prediction of future performance.

---

## 7. Trade Frequency

The EA generated:

```text
7,313 trades
14,626 deals
```

during the tested period.

The average position holding time was:

```text
0:02:11
```

The minimum holding time was:

```text
0:00:01
```

The maximum holding time was:

```text
3:36:03
```

This indicates that the tested configuration generated a high number of short-duration trades.

---

## 8. Consecutive Results

The maximum consecutive losing sequence was:

```text
11 trades
```

with a reported consecutive loss of:

```text
-33.09 USD
```

The maximum consecutive winning sequence was:

```text
11 trades
```

with a reported consecutive profit of:

```text
39.28 USD
```

---

## 9. MFE / MAE Observation

The Strategy Tester reported:

```text
Profits / MFE : 0.94
Profits / MAE : 0.76
MFE / MAE     : 0.6245
```

These values are retained as statistical observations from the test report.

They should not be interpreted independently as proof of causality or future performance.

---

## 10. Current Research Status

Based on the supplied backtest, the current configuration produced a negative net result and a high maximum drawdown.

The research therefore records the current configuration as a test result requiring further investigation rather than treating the result as evidence of a stable trading edge.

No conclusion about future profitability is made from this single backtest.

---

## 11. Source

Primary research source:

```text
Backtest/EA-089_EMA20_Distance/ReportTester-952747(6).html
```

EA source:

```text
EAs/EA-089_EMA20_Distance/EA-089_EMA20_Distance.mq5
```
