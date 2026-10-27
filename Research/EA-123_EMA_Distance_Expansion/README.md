# EA-123_EMA_Distance_Expansion — Research

## Research Objective

Evaluate whether the expansion of the distance between two Exponential Moving Averages (EMAs), combined with the directional movement of the fast EMA, can generate profitable short-term trading signals for XAUUSD.

## Research Hypothesis

An increasing distance between a fast EMA and a slow EMA may indicate strengthening directional momentum.

When the fast EMA is above the slow EMA and rising, expanding EMA separation may indicate bullish momentum.

When the fast EMA is below the slow EMA and falling, expanding EMA separation may indicate bearish momentum.

The strategy attempts to capture price continuation during periods of increasing EMA separation.

## Strategy Design

- Primary Indicators: Fast EMA and Slow EMA
- Fast EMA Period: 8
- Slow EMA Period: 21
- Expansion Factor: 1.2
- Signal Type: EMA distance expansion
- Directional Confirmation: Fast EMA slope
- Signal Timing: Completed candles
- Position Sizing: Fixed lot
- Risk Controls: Stop Loss, Take Profit, Break Even, Trailing Stop
- Execution Filter: Maximum spread

## Signal Definition

The absolute EMA distance is calculated for the two most recently completed candles.

`D1 = abs(FastEMA[1] - SlowEMA[1])`

`D2 = abs(FastEMA[2] - SlowEMA[2])`

The expansion condition requires:

`D2 > 0`

`D1 >= 1.2 * D2`

Buy signals require the fast EMA to be above the slow EMA and rising.

Sell signals require the fast EMA to be below the slow EMA and falling.

The strategy does not require a fresh EMA crossover.

## Initial Backtest Findings

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Total Trades | 6,598 |
| Profit Factor | 0.88 |
| Net Profit | -$994.33 |
| Equity Drawdown Relative | 99.45% |
| Win Rate | 46.15% |
| Expected Payoff | -$0.15 |
| Recovery Factor | -0.96 |

## Interpretation

The tested strategy did not demonstrate positive trading expectancy.

The EMA distance expansion condition generated a substantial number of trades, but gross losses exceeded gross profits.

The average winning trade was $2.49, compared with an average losing trade of $2.41.

However, the 46.15% win rate was insufficient to produce overall profitability.

The average position holding time was approximately 2 minutes and 34 seconds, indicating very short-duration trading behavior under the tested configuration.

The available results raise questions about the reliability of EMA expansion as a continuation signal, the impact of frequent entries, and the effectiveness of the exit-management rules.

These potential explanations have not been isolated through controlled experiments.

## Research Limitations

- Only one backtest configuration is provided.
- The evaluated period is approximately three months.
- No independent out-of-sample validation is provided.
- No forward-test or live-trading record is provided for this EA.
- EMA parameter sensitivity has not been established.
- Expansion-factor sensitivity has not been established.
- The individual effects of Break Even and Trailing Stop have not been measured.
- Execution-cost sensitivity has not been independently evaluated.

## Future Research

1. Evaluate alternative fast and slow EMA periods.
2. Test different expansion factors.
3. Investigate whether a minimum absolute EMA distance improves signal quality.
4. Compare results with and without fast EMA slope confirmation.
5. Evaluate trade frequency and transaction-cost sensitivity.
6. Compare alternative Break Even and Trailing Stop configurations.
7. Perform independent out-of-sample testing.

## Research Conclusion

**EA-123_EMA_Distance_Expansion remains an unsuccessful research configuration based on the supplied backtest.**

The available evidence does not establish a profitable or robust trading strategy.

Further controlled testing is required before considering deployment.
