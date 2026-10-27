# EA-126_Impulse_Follow-through — Research

## Research Objective

Evaluate whether an unusually large directional candle, followed by a confirmed close beyond that candle's extreme, can identify profitable short-term continuation opportunities in XAUUSD.

## Research Hypothesis

A large candle body relative to recent Average True Range may indicate unusually strong directional price movement.

If the following candle closes beyond the impulse candle's high or low, the continuation may indicate sustained buying or selling pressure.

The strategy attempts to capture this follow-through after both candles have closed.

## Strategy Design

- Primary Pattern: Large directional impulse candle
- Volatility Reference: ATR
- ATR Period: 14
- Impulse Threshold: 1.5 × ATR
- Impulse Candle: Shift 2
- Confirmation Candle: Shift 1
- Entry Timing: New candle following confirmation
- Position Sizing: Fixed lot
- Position Management: Stop Loss, Take Profit, Break Even, Trailing Stop
- Execution Filter: Maximum spread

## Signal Definition

### Impulse Qualification

`BodySize = abs(Close[2] - Open[2])`

`ATRReference = ATR[2]`

An impulse is recognized when:

`BodySize >= ATRReference * 1.5`

### Bullish Follow-through

The impulse candle must be bullish:

`Close[2] > Open[2]`

The confirmation candle must close above the impulse candle's high:

`Close[1] > High[2]`

When both conditions are satisfied, the EA may submit a Buy order.

### Bearish Follow-through

The impulse candle must be bearish:

`Close[2] < Open[2]`

The confirmation candle must close below the impulse candle's low:

`Close[1] < Low[2]`

When both conditions are satisfied, the EA may submit a Sell order.

## Initial Backtest Findings

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Total Trades | 1,085 |
| Winning Trades | 496 (45.71%) |
| Net Profit | -$211.69 |
| Profit Factor | 0.85 |
| Expected Payoff | -$0.20 |
| Equity Drawdown Relative | 24.46% |
| Recovery Factor | -0.83 |

## Interpretation

The initial test did not establish a profitable impulse-follow-through strategy.

The 1,085 completed trades provide a meaningful initial sample of trade outcomes for this particular configuration, but do not establish robustness across other periods or market conditions.

The winning trade rate of 45.71%, combined with an average winning trade of $2.51 and average losing trade of $2.47, resulted in negative expectancy.

Short trades exhibited a higher win rate than long trades, but the available summary does not establish separate directional net profitability.

The drawdown was substantially lower than that of EA-125 in the supplied reports, but the strategy still lost money and incurred a 24.46% relative equity drawdown.

The results do not establish whether the principal weakness comes from impulse selection, follow-through confirmation, exit management, or transaction costs.

## Research Limitations

- Only one tested parameter configuration is provided.
- The backtest covers approximately three months.
- No independent out-of-sample test is supplied.
- No live-trading or forward-test evidence is supplied for EA-126.
- ATR period sensitivity has not been evaluated.
- Impulse ATR multiplier sensitivity has not been evaluated.
- Alternative confirmation rules have not been tested.
- Long and short profitability has not been independently evaluated.
- Break Even and Trailing Stop contributions have not been isolated.
- Spread and execution-cost sensitivity has not been independently established.
- Performance across different market regimes remains unknown.

## Future Research

1. Compare impulse multipliers such as 1.2, 1.5, and 2.0 using controlled tests.
2. Evaluate alternative ATR periods.
3. Compare candle-body qualification against full-range qualification.
4. Test follow-through confirmation using different close-distance requirements.
5. Evaluate confirmation candle body direction and strength.
6. Analyze long and short trades separately.
7. Compare configurations with and without Break Even.
8. Compare configurations with and without Trailing Stop.
9. Evaluate trading-session and volatility-regime effects.
10. Perform out-of-sample and forward validation before any deployment decision.

These are proposed experiments, not demonstrated improvements.

## Research Conclusion

**EA-126_Impulse_Follow-through: FAILED BACKTEST — Further Research Required**

The initial results indicate negative expectancy and substantial drawdown.

The impulse-follow-through hypothesis remains unvalidated under the supplied configuration.

The source code, original settings, and backtest report should be retained to support reproducible research.
