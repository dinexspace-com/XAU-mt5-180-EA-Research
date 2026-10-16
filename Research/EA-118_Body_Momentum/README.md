# EA-118 Body Momentum — Research Notes

## Research Objective

Investigate whether a large candle body combined with a close near the candle extreme can provide a useful momentum entry signal on XAUUSD.PRO M1.

The current baseline is unsuccessful and should be used as a reference point for controlled experiments.

## Baseline Hypothesis

The strategy assumes that a candle with a body substantially larger than recent candle bodies, closing near its high or low, may indicate directional momentum.

This is a hypothesis, not a demonstrated market edge.

## Baseline Findings

| Observation | Evidence |
|---|---|
| Negative profitability | Net profit: -$992.26 |
| Negative expectancy | Expected payoff: -$0.34 |
| Profitability ratio below 1 | Profit Factor: 0.74 |
| Severe capital drawdown | Relative equity drawdown: 99.24% |
| Negative risk-adjusted result | Sharpe Ratio: -5.00 |
| Frequent trading | 2,911 trades during the test period |
| Win rate below 50% | 45.89% overall |

The average winning trade was $2.07, while the average losing trade was -$2.38. The current results therefore indicate that the entry and exit combination did not generate a profitable outcome in the tested sample.

## Research Questions

1. Does the current body multiplier select meaningful momentum candles or merely increase exposure to short-term noise?
2. Does the close-near-extreme filter improve trade quality?
3. Is the strategy sensitive to spread and execution costs?
4. Does break-even management reduce losses or prematurely close profitable trades?
5. Does the trailing stop improve the distribution of winners and losers?
6. Does performance change across different market regimes?
7. Can any improvement persist on data not used for parameter selection?

## Proposed Experiments

These experiments are proposals only. No results should be recorded until each test has actually been run.

| Experiment | Variable | Objective |
|---|---|---|
| R01 | Baseline reproduction | Verify that the original result can be reproduced |
| R02 | Body multiplier | Test whether stricter candle-body requirements improve signal quality |
| R03 | Extreme close ratio | Evaluate the effect of requiring a close nearer to the candle extreme |
| R04 | Average body period | Examine sensitivity to the lookback period |
| R05 | Break-even enabled/disabled | Isolate the effect of break-even management |
| R06 | Trailing stop enabled/disabled | Isolate the effect of trailing-stop management |
| R07 | SL/TP configurations | Examine the relationship between average win, average loss, and drawdown |
| R08 | Spread and execution sensitivity | Assess whether results deteriorate under less favorable trading costs |
| R09 | Out-of-sample evaluation | Check whether any promising configuration generalizes to unseen data |

## Experimental Rules

- Change one major variable at a time during initial tests.
- Keep the baseline source and report unchanged.
- Record the exact parameter values, test period, symbol, timeframe, and modeling quality.
- Compare net profit, Profit Factor, expected payoff, drawdown, trade count, and Sharpe Ratio.
- Avoid selecting a configuration based on net profit alone.
- Treat a small improvement as inconclusive until it survives additional testing.
- Separate in-sample parameter selection from out-of-sample evaluation.
- Do not claim robustness based solely on a single historical test.

## Acceptance Criteria

Before an experimental version can advance, it should demonstrate:

- Positive net profit after realistic trading costs.
- Profit Factor above 1 with a meaningful margin of safety.
- Drawdown within a predefined risk limit.
- Results that are not dependent on one narrow parameter setting.
- Acceptable out-of-sample performance.
- Successful forward testing on a demo environment.

These are proposed research gates, not results achieved by EA-118.

## Current Decision

**FAIL — Baseline.**

The current evidence does not support live deployment. Continue only if controlled experiments identify a repeatable improvement without excessive drawdown.
