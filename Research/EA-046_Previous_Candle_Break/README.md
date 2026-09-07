# Research — EA-046 Previous Candle Break

## Research Objective

EA-046 investigates whether a simple Previous Candle Break rule can produce a measurable trading edge on XAUUSD.

The baseline concept is intentionally simple:

- BUY when price closes above the previous candle High.
- SELL when price closes below the previous candle Low.
- Use fixed Stop Loss and Take Profit.
- Apply spread protection.
- Apply Break Even and Trailing Stop.
- Allow only one active position for the same symbol and Magic Number.

The purpose of the first implementation is not to optimize the strategy immediately. It is to establish a reproducible baseline and determine whether the raw breakout condition contains enough edge to justify further research.

## Baseline Strategy

Strategy:

**Previous Candle Break**

Instrument:

**XAUUSD.PRO**

Baseline timeframe:

**M1**

Entry logic:

**BUY**
Current Close > Previous Candle High

**SELL**
Current Close < Previous Candle Low

The EA evaluates the signal on a new bar.

Baseline parameters:

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 35 points |
| Break Even | Enabled |
| Break Even Start | 150 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Step | 50 points |

## Baseline Test

The first documented backtest used:

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Total Trades | 2,760 |

## Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | -$592.81 |
| Gross Profit | $4,098.96 |
| Gross Loss | -$4,691.77 |
| Profit Factor | 0.87 |
| Expected Payoff | -$0.21 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | 59.79% |
| Maximum Equity Drawdown | 59.88% |
| Winning Trades | 39.67% |
| Losing Trades | 60.33% |
| Long Win Rate | 40.03% |
| Short Win Rate | 39.29% |

## Baseline Verdict

**FAIL**

The baseline Previous Candle Break implementation does not demonstrate a positive trading edge under the tested configuration.

The most important evidence is:

- Profit Factor below 1.0.
- Negative net profit.
- Negative expected payoff.
- Approximately 60% maximum drawdown.
- Losing trades substantially exceed winning trades.
- Both BUY and SELL sides have win rates around 40%.
- The balance curve trends downward across the test.

The sample contains 2,760 trades, so the negative result is not based on only a handful of trades.

The baseline must therefore be preserved as a negative research result.

It should not be optimized retrospectively and then presented as if the original strategy were profitable.

## What the Baseline Tells Us

The test rejects the following working hypothesis for this specific configuration:

> Breaking the immediately previous M1 candle High or Low is sufficient by itself to create a profitable XAUUSD trading strategy.

The raw signal produces many trades but does not adequately distinguish meaningful momentum continuation from market noise and failed breakouts.

This is especially important because the strategy uses only one previous candle as the breakout structure.

A previous candle High or Low can be a very weak structural level.

Therefore, the next stage should investigate whether the breakout concept becomes useful only after adding market context.

## Main Research Problem

The primary research problem for EA-046 is:

**How can meaningful XAUUSD breakouts be separated from low-quality or false breakouts without overfitting the strategy?**

The research should not add many filters simultaneously.

Each hypothesis should be tested independently against the EA-046 baseline whenever possible.

The baseline remains the control strategy.

## Research Hypothesis H1 — Higher Timeframe

The first hypothesis is that M1 contains excessive noise for a one-candle breakout strategy.

Test the same core strategy without changing its fundamental entry concept on:

- M5
- M15
- H1

Compare each timeframe against the M1 baseline.

Primary metrics:

- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Drawdown
- Number of Trades
- Win Rate
- Average Profit Trade
- Average Loss Trade

### PASS Condition

A timeframe becomes a candidate for further research if it materially improves the baseline while maintaining a meaningful number of trades.

A positive Profit Factor alone is not sufficient evidence.

The equity curve and drawdown must also improve.

## Research Hypothesis H2 — Trend Filter

The raw strategy trades breakouts in both directions regardless of the prevailing trend.

Hypothesis:

**Previous-candle breakouts aligned with the prevailing trend may perform better than unrestricted breakouts.**

A simple EMA-based filter should be tested before considering more complicated trend models.

Example research variant:

BUY breakout allowed only when market structure indicates an uptrend.

SELL breakout allowed only when market structure indicates a downtrend.

The exact EMA configuration must be defined before testing and kept fixed during the experiment.

The purpose is to test whether trend alignment improves the signal, not to search through many EMA combinations until a profitable backtest appears.

## Research Hypothesis H3 — Breakout Distance / ATR Filter

The baseline accepts any close beyond the previous candle High or Low.

A very small penetration can therefore trigger a trade.

Hypothesis:

**Requiring a breakout to exceed the previous level by a volatility-adjusted minimum distance may reduce weak breakouts.**

ATR is a candidate because it adjusts the threshold according to current volatility.

Conceptual BUY condition:

Current Close > Previous High + ATR-based threshold

Conceptual SELL condition:

Current Close < Previous Low - ATR-based threshold

The ATR period and multiplier must be defined before each controlled test.

## Research Hypothesis H4 — Breakout Candle Quality

The baseline only checks whether Close is outside the previous candle range.

It does not measure the strength of the breakout candle.

Potential confirmation variables include:

- candle body size,
- total candle range,
- close location within the candle,
- candle range relative to ATR.

Hypothesis:

**Strong breakout candles may have better continuation probability than marginal closes outside the previous candle range.**

This hypothesis should initially be tested using one simple candle-strength definition.

Multiple candle conditions should not be introduced simultaneously.

## Research Hypothesis H5 — Confirmation

The baseline enters immediately after the breakout condition is confirmed.

Another possibility is to require additional confirmation.

Candidate experiments:

**Variant A — Consecutive Close Confirmation**

Require more than one close outside the breakout level.

**Variant B — Breakout + Retest**

Wait for price to break the level and then retest it before entering.

These approaches may reduce trade frequency significantly.

Therefore, improvement must be evaluated using expectancy and drawdown rather than win rate alone.

## Research Hypothesis H6 — Session Filter

The baseline can trade throughout available market hours.

XAUUSD behavior varies significantly across trading sessions.

Potential research segmentation:

- Asia
- London
- New York
- London/New York overlap

Before implementing a session filter, the existing trade history should be analyzed by hour.

The goal is to determine whether specific periods systematically contribute disproportionate losses.

A session should not be removed simply because it performed poorly in one small sample.

Any session hypothesis should subsequently be validated on additional data.

## Research Hypothesis H7 — Volatility Regime

The same breakout distance is currently applied regardless of market volatility.

Hypothesis:

**Previous Candle Break may behave differently during low-, normal-, and high-volatility regimes.**

ATR can be used to classify volatility.

Possible experiment:

Compare strategy performance by ATR regime before modifying the entry rules.

This analysis should determine whether a volatility filter is justified.

## Research Hypothesis H8 — Stop Loss and Exit Logic

The baseline uses:

Stop Loss = 300 points

Take Profit = 600 points

Break Even Start = 150 points

Trailing Start = 200 points

Trailing Step = 50 points

Although the nominal initial SL/TP relationship is 1:2, Break Even and Trailing Stop modify the realized payoff distribution.

The backtest shows:

Average winning trade = $3.74

Average losing trade = -$2.82

Therefore, the realized average win/loss relationship differs materially from the nominal fixed TP/SL relationship.

Future research should separate entry quality from exit behavior.

Controlled comparisons should include:

- Fixed SL/TP only
- Fixed SL/TP + Break Even
- Fixed SL/TP + Trailing
- Fixed SL/TP + Break Even + Trailing

Only the exit mechanism should change during this experiment.

## Research Hypothesis H9 — Structural Breakout Level

The previous candle High/Low may not represent a sufficiently meaningful market structure.

A later research branch can compare:

- Previous 1 candle High/Low
- Previous N-bar High/Low
- Session High/Low
- Swing High/Low
- Consolidation range High/Low

This should occur only after the simpler timeframe and filter experiments.

Increasing structural complexity too early would make it difficult to identify which component actually changes performance.

## Research Priority

Research should proceed in the following order:

1. Timeframe comparison
2. Trend filter
3. ATR breakout-distance filter
4. Breakout candle quality
5. Session analysis
6. Confirmation / retest
7. Exit-system comparison
8. Structural breakout levels

This order keeps each experiment interpretable and reduces the risk of overfitting.

## Experimental Method

EA-046 should follow a controlled research process.

For every experiment:

1. Keep the baseline EA unchanged.
2. Create a clearly identified variant.
3. Change one major variable at a time whenever possible.
4. Run the backtest.
5. Save the original Strategy Tester report.
6. Record all parameters.
7. Compare results against the baseline.
8. Record PASS or FAIL.
9. Preserve failed experiments.
10. Do not delete negative results.

## Required Metrics

Every important experiment should record at least:

- Symbol
- Timeframe
- Test period
- History quality
- Initial deposit
- Leverage
- Parameters
- Total trades
- Net profit
- Gross profit
- Gross loss
- Profit Factor
- Expected Payoff
- Maximum Balance Drawdown
- Maximum Equity Drawdown
- Win Rate
- Average Winning Trade
- Average Losing Trade
- Recovery Factor
- Sharpe Ratio

## Anti-Overfitting Rules

A profitable backtest is not automatically evidence of a valid strategy.

The research process should avoid:

- searching hundreds of parameter combinations and selecting only the best result,
- modifying several strategy components simultaneously,
- deleting failed variants,
- selecting a timeframe only because it produces the highest historical profit,
- selecting sessions after observing the same data and treating them as independently validated,
- judging strategy quality from win rate alone,
- judging strategy quality from net profit alone.

All meaningful strategy improvements should eventually be tested on data that was not used to develop the modification.

## Validation Roadmap

The intended research progression is:

Baseline
→ Controlled Variants
→ Identify Candidate
→ In-Sample Evaluation
→ Out-of-Sample Test
→ Walk-Forward Evaluation
→ Robustness Test
→ Forward/Demo Test
→ Final Research Verdict

Parameter optimization should only begin after a strategy variant demonstrates a plausible underlying edge.

## Current Research Status

EA-046 Baseline:

**COMPLETE**

Baseline result:

**FAIL**

Current evidence:

The unrestricted Previous Candle Break strategy on XAUUSD.PRO M1, using the documented configuration and 100% real-tick backtest from 2026.01.02 to 2026.04.01, does not demonstrate a profitable edge.

Research conclusion:

**The raw concept should not be accepted as a viable strategy in its current form.**

The failure is useful because it establishes a reproducible benchmark against which future variants can be measured.

## Next Experiment

**EA-046-R01 — Timeframe Comparison**

Keep the strategy logic and parameters unchanged as far as technically appropriate.

Run independent tests on:

- M5
- M15
- H1

Compare each result against the existing M1 baseline.

Do not add EMA, ATR, session, news, RSI, ADX, or other filters during this experiment.

The objective of R01 is only to answer:

**Does the Previous Candle Break concept perform materially differently when market noise is reduced by using higher timeframes?**

Only after R01 is complete should the next strategy modification be selected.
