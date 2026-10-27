# EA-122_DI_Cross — Research

## Research Objective

Evaluate whether crossovers between the Positive Directional Indicator (+DI) and Negative Directional Indicator (-DI), combined with an EMA trend filter, can generate profitable short-term trading signals for XAUUSD.

## Research Hypothesis

A crossover between +DI and -DI may indicate a change in directional market momentum.

Combining the crossover with an EMA filter may help align trade entries with the prevailing short-term price direction.

The strategy attempts to capture directional movements following confirmed indicator crossovers.

## Strategy Design

- Primary Indicator: Directional Indicators (+DI / -DI)
- DI Period: 14
- Trend Filter: Exponential Moving Average (EMA)
- EMA Period: 20
- Signal Type: DI crossover
- Signal Timing: Closed candles
- Position Sizing: Fixed lot
- Risk Controls: SL, TP, Break Even, Trailing Stop
- Execution Filter: Maximum spread

## Initial Backtest Findings

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Total Trades | 3,647 |
| Profit Factor | 0.79 |
| Net Profit | -$992.57 |
| Equity Drawdown Relative | 99.30% |
| Win Rate | 45.13% |
| Expected Payoff | -$0.27 |

## Interpretation

The tested strategy did not demonstrate a positive trading edge during the evaluated period.

The DI crossover signals combined with the EMA filter generated 3,647 trades, but gross losses exceeded gross profits.

The observed win rate and average trade outcomes were insufficient to produce positive expectancy.

The results raise questions about crossover signal quality, false signals, trade frequency, and exit management.

The available backtest does not isolate the individual contribution of these factors.

## Research Limitations

- Only one backtest configuration is provided.
- The evaluated period is approximately three months.
- No independent out-of-sample test is provided.
- No forward-test or live-trading record is provided for this EA.
- Parameter sensitivity has not been established.
- The standalone contribution of the EMA filter has not been measured.
- Results from alternative market conditions are not available.

## Future Research

1. Investigate the impact of different DI periods.
2. Evaluate the effectiveness of the EMA trend filter.
3. Compare alternative EMA periods.
4. Analyze the impact of spread and execution costs.
5. Compare Break Even and Trailing Stop configurations.
6. Perform independent out-of-sample testing.

## Research Conclusion

**EA-122_DI_Cross remains an unsuccessful research configuration based on the supplied backtest.**

The available evidence does not establish a profitable or robust trading strategy.

Further testing is required to determine whether DI crossover signals combined with EMA filtering have predictive value.
