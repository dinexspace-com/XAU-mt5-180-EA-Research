# EA-086_RSI_40_60 — Research

## 1. Research Objective

The purpose of this research is to evaluate the behavior of the EA-086_RSI_40_60 strategy and determine whether the RSI 40/60 reversal concept produces a repeatable trading result on XAUUSD.

The research starts from the documented baseline implementation and baseline backtest before considering any parameter modification.

## 2. Strategy Hypothesis

The strategy is based on the following RSI behavior:

### Buy hypothesis

After RSI moves below 40, a local upward turn may indicate a potential long entry.

The implementation requires:

```text
RSI[2] < 40
RSI[1] > RSI[2]
RSI[2] <= RSI[3]
```

### Sell hypothesis

After RSI moves above 60, a local downward turn may indicate a potential short entry.

The implementation requires:

```text
RSI[2] > 60
RSI[1] < RSI[2]
RSI[2] >= RSI[3]
```

## 3. Baseline

The current baseline configuration is:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
RSI Period: 14
RSI Lower: 40
RSI Upper: 60
Lot Size: 0.01
Stop Loss: 300
Take Profit: 600
Break Even: enabled
Trailing Stop: enabled
```

## 4. Baseline Evidence

The baseline backtest covers:

```text
2026.01.02 – 2026.03.31
100% real ticks
Initial Deposit: USD 1,000
```

The result was:

```text
Net Profit:        -995.01 USD
Profit Factor:      0.88
Max Equity DD:      99.51%
Total Trades:       6,575
Profit Trades:      3,264
Loss Trades:        3,311
```

## 5. Research Observation

The baseline configuration did not produce a positive net result during the tested period.

The number of winning trades was close to the number of losing trades, but the average losing trade was larger than the average winning trade:

```text
Average profit trade:  2.22 USD
Average loss trade:   -2.49 USD
```

The baseline therefore provides evidence that the tested configuration requires further investigation before being treated as a viable configuration.

This observation is limited to the documented test period, symbol, timeframe, broker environment and parameters.

## 6. Research Questions

The next research stages should answer:

1. How sensitive is the result to the RSI lower and upper levels?
2. How sensitive is the result to RSI period?
3. How does the strategy behave with different Stop Loss / Take Profit relationships?
4. What contribution do Break Even and Trailing Stop make to the result?
5. Is the M1 timeframe appropriate for this signal structure?
6. Does the result remain consistent outside the baseline test period?
7. Does the strategy retain its characteristics under out-of-sample testing?

## 7. Research Discipline

Each experiment should change one defined variable or one clearly documented group of variables.

Every experiment should record:

```text
Experiment ID
Date
EA version
Symbol
Timeframe
Test period
Changed parameters
Unchanged parameters
Net Profit
Profit Factor
Maximum Drawdown
Total Trades
Win Rate
Average Profit Trade
Average Loss Trade
Notes
```

Results should not be merged together without preserving the original test configuration.

## 8. Current Research Status

```text
Baseline implementation: COMPLETE
Baseline backtest:       COMPLETE
Baseline result:         DOCUMENTED
Parameter research:      NOT YET DOCUMENTED
Out-of-sample test:      NOT YET DOCUMENTED
```
