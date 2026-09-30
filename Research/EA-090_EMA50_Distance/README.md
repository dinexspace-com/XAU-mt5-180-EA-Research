# EA-090_EMA50_Distance Research

## Research Objective

The purpose of this research entry is to document the observed behavior of `EA-090_EMA50_Distance` using the supplied MT5 Strategy Tester report.

The research is limited to the tested configuration:

```text
Symbol      = XAUUSD.PRO
Timeframe   = M1
Period      = 2026.01.02 - 2026.03.31
Deposit     = 1,000 USD
Model       = 100% real ticks
```

## Strategy Structure

The EA combines:

* EMA50
* ATR14
* 1.5 ATR distance condition
* Two-candle confirmation
* Fixed Stop Loss
* Fixed Take Profit
* Break Even
* Trailing Stop

The strategy looks for price movement away from EMA50 by the configured ATR distance, followed by a candle reversal/confirmation condition.

## Observed Backtest Result

The supplied test produced:

```text
Net Profit       = -992.55 USD
Profit Factor    = 0.89
Expected Payoff  = -0.14 USD
Sharpe Ratio     = -5.00
```

The test therefore ended with a negative balance result for the supplied period.

## Trade Distribution

The test generated:

```text
Total Trades = 7,170
Total Deals  = 14,340
```

Direction distribution:

```text
Short Trades = 3,970
Long Trades  = 3,200
```

The reported winning rates were:

```text
Short Win Rate = 49.12%
Long Win Rate  = 50.16%
```

Overall:

```text
Profit Trades = 3,555 (49.58%)
Loss Trades   = 3,615 (50.42%)
```

These values show that the negative result was not produced simply by an absence of winning trades; the report also shows a difference between average winning and losing trade size.

## Profit and Loss Structure

The report records:

```text
Average Profit Trade =  2.26 USD
Average Loss Trade   = -2.49 USD

Largest Profit Trade =  11.62 USD
Largest Loss Trade   = -38.88 USD
```

The average losing trade therefore had a larger absolute value than the average winning trade in this test.

This relationship is relevant when evaluating why a strategy with a win rate close to 50% can still produce a negative aggregate result.

## Drawdown Observation

The test recorded:

```text
Balance Drawdown Maximal = 993.08 USD (99.26%)
Equity Drawdown Maximal  = 994.33 USD (99.26%)
```

The initial deposit was 1,000 USD.

The reported drawdown therefore consumed almost the entire initial test capital during this particular simulation.

## Trade Frequency

With 7,170 trades during the supplied test period, the EA generated a high number of transactions relative to the approximately three-month testing window.

The average position holding time was:

```text
0:02:22
```

The minimum was:

```text
0:00:01
```

and the maximum was:

```text
3:36:03
```

This indicates that the tested implementation generally operated with short holding periods, while allowing some substantially longer positions.

## Consecutive Results

The report records:

```text
Maximum Consecutive Wins   = 11
Maximum Consecutive Losses = 15

Maximum Consecutive Profit =  28.25 USD
Maximum Consecutive Loss   = -48.62 USD
```

Average consecutive wins and losses were both reported as 2.

The longest losing sequence was therefore longer than the longest winning sequence in this particular test.

## MFE / MAE Observation

The Strategy Tester reports:

```text
Profits / MFE = 0.92
Profits / MAE = 0.75
MFE / MAE     = 0.5562
```

These statistics are recorded as descriptive characteristics of the supplied test and are not treated as evidence of future behavior.

## Current Research Status

Based on the supplied backtest alone, the recorded observations are:

1. The test ended with negative net profit.
2. Profit Factor was below 1.
3. Maximum reported drawdown was approximately 99.26%.
4. The overall winning-trade percentage was 49.58%.
5. Average loss exceeded average profit in absolute value.
6. The strategy generated 7,170 trades.
7. Average position holding time was 2 minutes 22 seconds.

These are observations from one supplied backtest and should remain separated from conclusions about live-market or future performance.

## Research Limitation

No conclusion about robustness, optimization quality, out-of-sample performance, or future profitability is made from this single test.

Additional tests would constitute separate research records rather than being silently combined with the current result.

## Source

```text
EA-090_EMA50_Distance.mq5
ReportTester-952747(7).html
```
