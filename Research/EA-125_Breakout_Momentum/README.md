# EA-125_Breakout_Momentum — Research

## Research Objective

Evaluate whether price breakouts confirmed by RSI momentum and MACD direction can produce profitable short-term trading signals for XAUUSD.

## Research Hypothesis

A candle closing above the highest high of a recent historical range may indicate bullish price momentum.

A candle closing below the lowest low of that range may indicate bearish price momentum.

RSI thresholds and MACD directional confirmation are intended to filter breakout signals by requiring supporting momentum conditions.

The strategy attempts to capture continuation after a completed-candle breakout.

## Strategy Design

- Primary Signal: Historical price-range breakout
- Breakout Lookback: 10 candles
- Momentum Filter: RSI (14)
- Directional Confirmation: MACD (12, 26, 9)
- Signal Timing: Latest completed candle
- Position Sizing: Fixed lot
- Position Management: Stop Loss, Take Profit, Break Even, Trailing Stop
- Execution Filter: Maximum spread

## Signal Definition

For a breakout lookback of `N` candles:

`RangeHigh = max(High[2] ... High[N+1])`

`RangeLow = min(Low[2] ... Low[N+1])`

The signal is evaluated using `Close[1]`, RSI shift 1, and MACD shift 1.

### Bullish Signal

All conditions must be satisfied:

`Close[1] > RangeHigh`

`RSI[1] >= 55.0`

`MACD_Main[1] > MACD_Signal[1]`

### Bearish Signal

All conditions must be satisfied:

`Close[1] < RangeLow`

`RSI[1] <= 45.0`

`MACD_Main[1] < MACD_Signal[1]`

The breakout condition compares the latest completed candle against the preceding historical range.

The MACD condition checks relative indicator position, not a fresh crossover event.

## Initial Backtest Findings

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Total Trades | 3,707 |
| Profit Factor | 0.81 |
| Net Profit | -$992.17 |
| Equity Drawdown Relative | 99.22% |
| Win Rate | 44.73% |
| Expected Payoff | -$0.27 |
| Recovery Factor | -1.00 |

## Interpretation

The initial backtest did not demonstrate positive expectancy.

The strategy generated 1,658 winning trades and 2,049 losing trades.

Average winning and losing trade sizes were nearly identical, while the frequency of losing trades was substantially higher.

The Profit Factor of 0.81 indicates that the tested configuration failed to generate sufficient gross profits to offset gross losses.

The average holding time of 2 minutes and 34 seconds warrants further investigation of execution-cost sensitivity.

However, the supplied test does not independently establish whether the observed losses were primarily caused by false breakouts, indicator filters, execution costs, or exit-management behavior.

The extreme equity drawdown makes the tested configuration unsuitable for capital scaling.

## Research Limitations

- Only one backtest configuration is supplied.
- The test period covers approximately three months.
- No independent out-of-sample test is provided.
- No forward-test or live-trading evidence is provided for EA-125.
- Breakout lookback sensitivity has not been established.
- RSI threshold sensitivity has not been established.
- MACD filter effectiveness has not been isolated.
- Break Even and Trailing Stop effects have not been isolated.
- Transaction-cost sensitivity has not been independently tested.
- Performance across different volatility regimes has not been established.

## Future Research

1. Test the price breakout condition without RSI and MACD filters.
2. Add the RSI filter independently to measure its contribution.
3. Add the MACD filter independently to measure its contribution.
4. Compare different breakout lookbacks.
5. Evaluate alternative RSI thresholds.
6. Investigate breakout magnitude and volatility filters.
7. Compare Break Even and Trailing Stop configurations.
8. Analyze spread and execution-cost sensitivity.
9. Compare trading sessions and market regimes.
10. Conduct independent out-of-sample and forward validation.

## Research Conclusion

**EA-125_Breakout_Momentum remains an unsuccessful research configuration based on the supplied backtest.**

The available evidence does not establish a profitable or robust breakout strategy.

Further controlled experiments are required before considering deployment.
