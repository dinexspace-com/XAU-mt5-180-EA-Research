
# EA-081 — Research Notes

## Research Objective

Evaluate the performance and robustness of a micro-consolidation breakout strategy on XAUUSD M1.

The initial experiment uses four consolidation candles and an ATR-based range filter.

## Initial Findings

### 1. Profitability

The initial backtest generated:

- 246 trades.
- 50.41% winning trades.
- $11.23 net profit.
- Profit Factor: 1.04.

The strategy was marginally profitable during the tested period.

However, the small difference between gross profit and gross loss indicates limited observed profitability.

### 2. Risk and Drawdown

Maximum equity drawdown: 3.71%.

Recovery Factor: 0.29.

The relatively small drawdown should be considered alongside the low net profit.

### 3. Trade Management

The strategy uses both Break Even and Trailing Stop.

Average winning trade: $2.52.
Average losing trade: -$2.47.

Although the initial SL/TP configuration has a nominal 2:1 reward-to-risk ratio, the observed average winning and losing trade amounts are similar.

The effects of Break Even and Trailing Stop require separate testing.

### 4. Holding Time

Average holding time: 2 minutes 52 seconds.

Maximum holding time: 38 minutes 30 seconds.

This is a short-duration strategy, making execution quality and trading costs important research variables.

### 5. Equity Curve

The balance curve rises during the early portion of the test, reaches a peak and subsequently declines.

The test ends with a small net profit.

This suggests that performance stability across different market periods requires further investigation.

## Research Questions

The next experiments should investigate:

1. Whether Break Even improves net profitability.
2. Whether Trailing Stop reduces realized profits.
3. How different consolidation widths affect breakout quality.
4. Whether entry-hour filtering improves performance.
5. Whether results remain consistent across additional historical periods.
6. How higher spreads and slippage affect the strategy.

These are research hypotheses, not confirmed improvements.

## Next Experiment

Run an isolated comparison of position management configurations:

- Baseline: Current settings.
- Test A: Break Even disabled.
- Test B: Trailing Stop disabled.
- Test C: Both disabled.

Keep the instrument, timeframe, historical period, lot size and entry logic unchanged.

Compare:

- Net Profit.
- Profit Factor.
- Maximum Equity Drawdown.
- Total Trades.
- Average Win and Loss.

Do not select a new configuration based on one metric alone.

## Current Status

Initial backtest: Completed.

Independent reproduction: Pending.

Additional-period validation: Pending.

Forward testing: Pending.

Live trading validation: Not performed.
