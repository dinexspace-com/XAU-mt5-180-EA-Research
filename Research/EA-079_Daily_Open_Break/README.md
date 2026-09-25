
# EA-079 — Daily Open Break Research

## Research Objective

Investigate whether price crossings of the daily opening level can provide a statistically useful trading signal for XAUUSD.

The initial experiment uses M1 closed-candle confirmation, fixed position sizing and automated exit management.

## Strategy Hypothesis

The daily opening price may act as a reference level for intraday market direction.

A candle closing across this level could indicate a change in short-term price direction. However, repeated crossings during sideways markets may produce false signals and frequent losses.

This hypothesis requires empirical validation.

## Initial Experiment

The first documented backtest used:

- XAUUSD.PRO
- M1 timeframe
- January–March 2026
- 100% real-tick modeling
- 0.01 fixed lot
- 300-point stop loss
- 600-point take profit
- Break-even and trailing-stop protection

## Initial Findings

The strategy generated 940 trades, with a win rate of 46.06%, a profit factor of 0.78 and a net loss of $282.20.

Maximum equity drawdown reached 31.05%.

The historical results do not support deploying the tested configuration.

## Research Questions

### R01 — Entry Signal

Does requiring additional confirmation after crossing the daily opening price reduce false entries?

Potential experiments:
- Candle-close confirmation.
- Minimum breakout distance.
- Retest confirmation.

### R02 — Trading Sessions

Does restricting entries to specific trading sessions change the strategy's performance?

Compare Asian, European and US trading hours using the broker's server time.

### R03 — Exit Management

How do break-even and trailing-stop settings affect trade outcomes?

Test these mechanisms separately before combining them.

### R04 — Risk and Reward

Does changing the stop-loss and take-profit relationship improve the distribution of trade outcomes?

Evaluate profitability, drawdown and trade frequency rather than win rate alone.

### R05 — Market Conditions

Does the strategy behave differently during trending and sideways markets?

Investigate volatility and trend filters only after establishing a reproducible baseline.

## Research Limitations

The current evidence is limited to one supplied historical test covering approximately three months.

The report does not establish:
- Out-of-sample profitability.
- Forward-test performance.
- Robustness across brokers.
- Performance under alternative execution costs.
- Stability across different market regimes.

## Next Research Stage

Reproduce the baseline result before changing the strategy.

Then test one variable at a time, retain all failed experiments and compare results against the unchanged baseline.

No optimization result should be considered validated solely because it improves performance on the original test period.

## Current Status

**Research ongoing — baseline backtest failed.**
