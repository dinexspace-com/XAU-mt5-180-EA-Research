# EA-124_MACD_Acceleration — Research

## Research Objective

Evaluate whether MACD histogram zero-line transitions and consecutive directional changes can generate profitable short-term trading signals for XAUUSD.

## Research Hypothesis

A MACD histogram transition from non-positive to positive territory may indicate strengthening bullish momentum.

A transition from non-negative to negative territory may indicate strengthening bearish momentum.

Similarly, consecutive increases or decreases in histogram values may indicate continuation of directional momentum.

The strategy attempts to exploit these conditions through short-term market entries.

## Strategy Design

- Primary Indicator: MACD
- Fast EMA Period: 12
- Slow EMA Period: 26
- Signal Period: 9
- Applied Price: Close
- Signal Type: Histogram zero-line transition or consecutive directional change
- Signal Timing: Completed candles
- Position Sizing: Fixed lot
- Position Management: Stop Loss, Take Profit, Break Even, Trailing Stop
- Execution Filter: Maximum spread

## Signal Definition

The MACD histogram is calculated as:

`H = MACD_Main - MACD_Signal`

The EA evaluates three completed candles:

`H1 = Main[1] - Signal[1]`

`H2 = Main[2] - Signal[2]`

`H3 = Main[3] - Signal[3]`

### Bullish Signals

Positive zero-line transition:

`H1 > 0 && H2 <= 0 && H1 > H2`

Consecutive bullish acceleration:

`H1 > 0 && H1 > H2 && H2 > H3`

### Bearish Signals

Negative zero-line transition:

`H1 < 0 && H2 >= 0 && H1 < H2`

Consecutive bearish acceleration:

`H1 < 0 && H1 < H2 && H2 < H3`

The acceleration conditions represent consecutive histogram changes, not a separately calculated second derivative.

## Initial Backtest Findings

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Total Trades | 3,860 |
| Profit Factor | 0.80 |
| Net Profit | -$992.01 |
| Equity Drawdown Relative | 99.20% |
| Win Rate | 48.06% |
| Expected Payoff | -$0.26 |
| Recovery Factor | -1.00 |

## Interpretation

The initial backtest did not demonstrate positive expectancy.

Although the strategy produced 1,855 winning trades, the 2,005 losing trades and larger average loss size resulted in negative overall performance.

The Profit Factor of 0.80 indicates that the tested configuration failed to generate sufficient gross profit to offset gross losses.

The high trading frequency and short average holding time warrant further investigation of execution costs and signal quality.

However, the supplied test does not independently establish the contribution of spread, slippage, signal selection, or position-management rules to the observed losses.

The extreme drawdown indicates that the tested configuration is unsuitable for capital scaling.

## Research Limitations

- Only one backtest configuration is supplied.
- The test period covers approximately three months.
- No independent out-of-sample results are provided.
- No forward-test or live-trading evidence is provided for EA-124.
- MACD parameter sensitivity has not been established.
- Zero-line transition and acceleration signals have not been evaluated separately.
- Break Even and Trailing Stop effects have not been isolated.
- Execution-cost sensitivity has not been independently tested.

## Future Research

1. Test zero-line transition signals independently from acceleration signals.
2. Evaluate alternative MACD fast, slow, and signal periods.
3. Investigate minimum histogram magnitude filters.
4. Compare different histogram acceleration definitions.
5. Evaluate trading frequency and transaction-cost sensitivity.
6. Compare results with Break Even and Trailing Stop enabled or disabled.
7. Conduct independent out-of-sample validation.
8. Investigate performance differences across market sessions and volatility conditions.

## Research Conclusion

**EA-124_MACD_Acceleration remains an unsuccessful research configuration based on the supplied backtest.**

The available evidence does not establish a profitable or robust trading strategy.

Further controlled research is required before considering deployment.
