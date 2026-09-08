# Methodology — XAUUSD MT5 EA Research

## Purpose

This document defines the research and validation methodology used in the `xauusd-mt5-ea-research` repository.

The objective is to ensure that every Expert Advisor is evaluated through a consistent, reproducible, evidence-based process.

The repository is designed around one core principle:

**No strategy is considered valid because it compiles, trades, or produces an attractive historical chart.**

A strategy must progress through:

Idea

→ Explicit Rules

→ MQL5 Implementation

→ Baseline Backtest

→ Diagnosis

→ Controlled Research

→ Validation

→ Out-of-Sample Testing

→ Forward Testing

Only after surviving these stages can a strategy be considered a serious candidate for further use.

---

## 1. Research Philosophy

The methodology prioritizes:

Reproducibility

Controlled experimentation

Minimal assumptions

One-variable-at-a-time testing

Evidence over intuition

Preservation of failed experiments

Protection against overfitting

Every EA begins as a hypothesis.

The source code represents the implementation of that hypothesis.

The backtest represents historical evidence.

Research then attempts to explain why the strategy succeeded or failed.

The purpose is not to force every EA to become profitable.

A negative result is still a valid research result.

---

## 2. Repository Research Flow

Each EA follows the same general workflow:

Strategy Concept

↓

Define Mechanical Rules

↓

Implement EA

↓

Compile and Verify Execution

↓

Run Baseline Backtest

↓

Record Raw Tester Evidence

↓

Evaluate Key Metrics

↓

PASS or FAIL Baseline

↓

Identify Weaknesses

↓

Create Testable Hypotheses

↓

Modify One Variable

↓

Backtest Again

↓

Compare Against Baseline

↓

Accept or Reject Hypothesis

↓

Validate on Unseen Data

↓

Forward Test

↓

Candidate Strategy

The process must remain traceable.

Every major conclusion should be supported by source code, tester output, or documented research evidence.

---

## 3. Strategy Definition

Before coding, a strategy should be expressible as explicit rules.

A usable strategy definition should answer:

What market is traded?

What timeframe is used?

What creates a BUY signal?

What creates a SELL signal?

When is entry permitted?

When is entry rejected?

How is Stop Loss calculated?

How is Take Profit calculated?

How is position size calculated?

How many simultaneous positions are allowed?

What conditions close or modify a position?

What filters are used?

What parameters are configurable?

Rules should be mechanical enough that two independent developers could implement substantially the same logic.

Avoid vague instructions such as:

"Buy when the trend looks strong"

"Enter near support"

"Trade when momentum is good"

Instead use measurable conditions.

Example:

BUY when:

Close[1] > HighestHigh(previous 5 completed bars)

or:

ADX(14) > 25

or:

Price > EMA200

The goal is to remove discretionary interpretation from the EA.

---

## 4. Source Code Requirements

Each EA should have its own directory:

EAs/

└── EA-XXX_Strategy_Name/

    ├── EA-XXX_Strategy_Name.mq5

    └── README.md

The README should document the actual implemented logic.

It should not describe features that are not present in the source code.

The source code should ideally expose important strategy parameters as inputs.

Typical parameters include:

Lot Size

Magic Number

Slippage

Stop Loss

Take Profit

Break Even

Trailing Stop

Spread Filter

Session Filter

Indicator Parameters

Lookback Length

Confirmation Thresholds

The source file is the primary technical reference for the strategy implementation.

---

## 5. Baseline Principle

Every strategy must first be tested in a simple baseline configuration.

The baseline exists to answer:

**Does the core strategy contain any measurable historical edge before extensive optimization?**

The baseline should avoid excessive filtering and parameter tuning.

A baseline should preferably use:

Fixed lot size

Clearly defined Stop Loss

Clearly defined Take Profit

Minimal filters

No optimization sweep

No hidden manual intervention

The objective is diagnosis, not maximum historical profit.

---

## 6. Backtest Evidence

Each backtest should preserve the original MetaTrader 5 Strategy Tester output.

Recommended structure:

Backtest/

└── EA-XXX/

    ├── ReportTester-XXXX.html

    ├── ReportTester-XXXX.png

    ├── ReportTester-XXXX-hst.png

    ├── ReportTester-XXXX-mfemae.png

    ├── ReportTester-XXXX-holding.png

    └── README.md

The HTML report should be preserved as the primary evidence source.

Screenshots are supporting evidence.

The README should summarize the test but must not replace the raw tester report.

---

## 7. Required Backtest Environment Information

Every backtest should record at least:

EA Name

Symbol

Timeframe

Test Period

Broker / Server

Tester Model

History Quality

Initial Deposit

Deposit Currency

Leverage

Lot Size

Stop Loss

Take Profit

Spread Filter

Important Strategy Inputs

MT5 Build where available

Example:

Expert:

EA-047_5-Bar_Range_Break

Symbol:

XAUUSD.PRO

Timeframe:

M5

Period:

2026.01.02 — 2026.04.01

Initial Deposit:

$1,000

Leverage:

1:500

History Quality:

100% real ticks

These details are required because backtest results can change materially with different broker specifications and historical data.

---

## 8. Historical Data Quality

Whenever possible, XAUUSD testing should use high-quality tick data.

Preferred:

**100% real ticks**

This improves realism for:

Entry timing

Spread behavior

Stop Loss execution

Take Profit execution

Intrabar movement

Short-duration trades

Strategies operating on M1, M5, or other low timeframes are especially sensitive to data quality.

Low-quality generated ticks may create misleading performance.

History quality should always be recorded.

---

## 9. Baseline Metrics

At minimum, evaluate:

Total Net Profit

Gross Profit

Gross Loss

Profit Factor

Expected Payoff

Total Trades

Winning Trades

Losing Trades

Win Rate

Maximum Balance Drawdown

Maximum Equity Drawdown

Recovery Factor

Average Profit Trade

Average Loss Trade

Largest Profit Trade

Largest Loss Trade

Maximum Consecutive Wins

Maximum Consecutive Losses

Long Trades

Short Trades

Sharpe Ratio where available

Equity Curve

Trade Holding Time

No single metric should determine whether a strategy is good.

---

## 10. Profit Factor

Profit Factor is calculated conceptually as:

Gross Profit / Absolute Gross Loss

Interpretation:

PF > 1.0

Gross profits exceed gross losses.

PF = 1.0

Historical break-even before considering other practical issues.

PF < 1.0

Gross losses exceed gross profits.

A Profit Factor slightly above 1.0 should not automatically be considered robust.

Transaction costs, execution changes, unseen data, and parameter instability can eliminate a weak historical edge.

---

## 11. Expected Payoff

Expected Payoff measures average historical result per trade.

Conceptually:

Net Profit / Total Trades

Positive Expected Payoff indicates positive historical average trade expectancy.

Negative Expected Payoff indicates negative historical expectancy.

However, Expected Payoff should always be evaluated alongside:

Trade Count

Drawdown

Win Rate

Average Winner

Average Loser

Profit Factor

A positive value from a very small sample is weak evidence.

---

## 12. Win Rate and Reward-to-Risk

Win rate alone is not sufficient.

A strategy can be profitable with a low win rate if winners are sufficiently larger than losers.

Approximate break-even win rate:

Break-even Win Rate = 1 / (1 + Reward/Risk)

Example:

Reward/Risk = 2

Break-even Win Rate ≈ 33.33%

Therefore a 30% win rate may fail with a 2:1 payoff structure, while a 40% win rate could potentially produce positive expectancy.

Real trading requires additional margin because of:

Spread

Slippage

Commission

Execution uncertainty

Therefore theoretical break-even should not be treated as an acceptable performance target.

---

## 13. Drawdown

Drawdown is a critical risk metric.

Evaluate:

Balance Drawdown Absolute

Balance Drawdown Maximal

Balance Drawdown Relative

Equity Drawdown Absolute

Equity Drawdown Maximal

Equity Drawdown Relative

Equity drawdown is particularly important because it includes unrealized loss.

A strategy that produces good Net Profit with excessive drawdown may not be practically usable.

Drawdown should always be evaluated relative to:

Initial Capital

Net Profit

Average Trade

Loss Sequence

Position Size

---

## 14. Recovery Factor

Recovery Factor compares profitability with drawdown.

A negative Recovery Factor indicates that the tested strategy lost money.

A higher positive value generally indicates a better relationship between profit and drawdown.

However, it should not be used as a standalone selection metric.

---

## 15. Trade Count

Trade count matters because small samples can create misleading conclusions.

For example:

10 profitable trades

do not provide the same confidence as:

500 profitable trades

assuming comparable market coverage.

There is no universal minimum trade count because it depends on strategy frequency.

However, every research conclusion must consider whether the sample is large enough to support the claim being made.

---

## 16. Long and Short Analysis

BUY and SELL trades should be evaluated separately whenever possible.

Record:

Long Trade Count

Long Win Rate

Long Net Profit

Short Trade Count

Short Win Rate

Short Net Profit

Large directional imbalance may indicate:

Market regime bias

Strategy asymmetry

Implementation issue

Trend dependency

Symbol behavior

This does not automatically imply that one direction should be disabled.

It creates a research question that must be tested.

---

## 17. Equity Curve Analysis

The equity or balance curve should be inspected for:

Consistent growth

Long stagnation

Large regime changes

Sudden dependence on a small number of trades

Late-period deterioration

Clustered losses

Deep recovery periods

A strategy with the same Net Profit can have very different quality depending on the shape of its equity curve.

Prefer stable performance over profit concentrated in isolated events.

---

## 18. Losing Sequences

Maximum consecutive losses are important for both risk and strategy quality.

A long losing sequence may indicate:

Weak entry selectivity

Regime dependency

Poor range-market behavior

Insufficient filtering

Random-like signal generation

It also determines the psychological and capital requirements of live trading.

For example:

19 consecutive losses

is materially different from:

4 consecutive losses

even if final Net Profit were identical.

---

## 19. MFE and MAE

MFE:

Maximum Favorable Excursion

MAE:

Maximum Adverse Excursion

These metrics help investigate whether trades:

Move strongly in the expected direction before reversing

Experience excessive adverse movement before becoming profitable

Reach significant unrealized profit that is later surrendered

Have stops placed too close or too far away

MFE / MAE analysis may support research into:

Take Profit

Stop Loss

Break Even

Trailing Stop

Partial Exit

Exit Timing

However, correlation alone does not prove that a new exit rule will improve performance.

The modification must still be backtested.

---

## 20. Holding Time

Record:

Minimum Holding Time

Maximum Holding Time

Average Holding Time

Holding-time analysis helps classify the strategy.

For example:

Seconds to minutes

Very short-term / scalping-like behavior

Minutes to hours

Intraday behavior

Days

Swing behavior

Short-duration strategies are usually more sensitive to:

Spread

Slippage

Latency

Tick quality

Broker execution

Therefore realistic test conditions become more important.

---

## 21. Baseline PASS / FAIL

The repository uses a simple research classification.

### PASS

A baseline may be marked PASS when historical evidence demonstrates positive expectancy with acceptable risk and sufficient sample quality.

Typical supporting evidence may include:

Positive Net Profit

Profit Factor above 1

Positive Expected Payoff

Reasonable Drawdown

Adequate Trade Count

Stable Equity Behavior

No single metric is sufficient.

### FAIL

A baseline should be marked FAIL when evidence clearly indicates negative expectancy.

Examples:

Negative Net Profit

Profit Factor below 1

Negative Expected Payoff

Persistent declining equity curve

Unacceptable drawdown

A FAIL result does not mean the research is unsuccessful.

It means the baseline hypothesis was not supported.

The result should be preserved.

---

## 22. Root-Cause Research

After a FAIL result, do not immediately run broad optimization.

First determine the likely weakness.

Possible categories:

Entry quality

False breakouts

Trend dependency

Volatility dependency

Time-of-day dependency

Weekday dependency

Directional asymmetry

Stop Loss structure

Take Profit structure

Poor reward/risk relationship

Spread sensitivity

Overtrading

Regime dependency

The goal is to convert observed weaknesses into testable hypotheses.

---

## 23. Hypothesis Design

A good research hypothesis should contain:

Observed Problem

Proposed Cause

Proposed Modification

Expected Effect

Metrics to Measure

PASS / FAIL Criteria

Example:

Observed Problem:

Low breakout win rate.

Hypothesis:

Small price penetrations create false entries.

Modification:

Require breakout distance of 0.2 ATR.

Expected Effect:

Lower trade count but higher entry quality.

Measure:

Profit Factor

Expected Payoff

Win Rate

Trade Count

Drawdown

This structure prevents random parameter experimentation.

---

## 24. One-Variable-at-a-Time Rule

During early research, modify one major factor at a time.

Example sequence:

Baseline

↓

Add Close Confirmation

↓

Compare

Then:

Baseline

↓

Add ATR Filter

↓

Compare

Do not initially test:

Close Confirmation

+

ATR

+

EMA

+

ADX

+

Session Filter

+

Trailing Stop

simultaneously.

If performance improves, it would be impossible to determine which component created the improvement.

Controlled experiments preserve causal interpretability.

---

## 25. Experimental Comparison

Each experiment should be compared against the same baseline environment whenever possible.

Keep unchanged:

Symbol

Timeframe

Historical Period

Initial Deposit

Lot Size

Leverage

Execution Model

Data Quality

Other Parameters

Only the intended test variable should change.

This creates a valid A/B comparison.

---

## 26. Research Metrics Table

Each experiment should ideally be recorded in a comparison table.

Example:

| Variant | Trades | Net Profit | PF | Win Rate | Expected Payoff | Max DD |
|---|---:|---:|---:|---:|---:|---:|
| Baseline | 424 | -89.70 | 0.90 | 30.66% | -0.21 | 13.18% |
| Close Confirmation | TBD | TBD | TBD | TBD | TBD | TBD |
| ATR Buffer | TBD | TBD | TBD | TBD | TBD | TBD |

The purpose is to make improvement or deterioration immediately visible.

---

## 27. Optimization Policy

Optimization should occur only after a credible strategy hypothesis exists.

Optimization is not research if thousands of random combinations are searched until one produces a good historical result.

Avoid starting with:

Very large parameter grids

Extremely narrow parameter increments

Dozens of simultaneous variables

Selection based only on Net Profit

Prefer:

Small logical parameter ranges

Economically meaningful values

Parameter stability

Repeatable performance

---

## 28. Parameter Stability

A robust strategy should not require one exact parameter value to work.

Example:

If:

ATR multiplier = 0.21

is highly profitable,

but:

0.20

and:

0.22

both fail badly,

the result may be overfitted.

Prefer regions where nearby parameter values produce similar behavior.

Stable parameter zones are generally more credible than isolated peaks.

---

## 29. Overfitting Risk

Overfitting occurs when a strategy is tuned too closely to historical data.

Common warning signs:

Too many filters

Too many parameters

Thousands of optimization combinations

Very precise parameter values

Excellent in-sample results

Poor unseen-data results

Performance dependent on a few trades

Sharp optimization peaks

Research must actively attempt to reject overfitted strategies.

---

## 30. In-Sample and Out-of-Sample Testing

Historical data should eventually be separated.

### In-Sample

Used to:

Develop hypotheses

Adjust the strategy

Perform controlled optimization

### Out-of-Sample

Data not used during development.

Used to test whether the discovered edge persists.

Example:

Development:

2024 — 2025

Validation:

2026 Q1

This is only an example.

Exact periods depend on available data and market regime coverage.

A strategy that performs well only on development data should not progress.

---

## 31. Walk-Forward Thinking

Where sufficient data exist, research should eventually use multiple sequential periods.

Example:

Train A

→ Test A

Train B

→ Test B

Train C

→ Test C

This helps determine whether strategy behavior persists as market conditions change.

The purpose is not to continuously optimize the past.

The purpose is to evaluate temporal stability.

---

## 32. Market Regime Validation

XAUUSD behavior varies across market environments.

Candidate strategies should eventually be tested during:

Trending periods

Range-bound periods

High volatility

Low volatility

Bullish gold regimes

Bearish gold regimes

Crisis periods where available

Calmer market conditions

A strategy that works only in one narrow regime should be documented as regime-dependent.

---

## 33. Spread Sensitivity

Spread is especially important for short-term XAUUSD strategies.

Research should consider testing different maximum spreads.

Example:

20 points

25 points

30 points

35 points

40 points

The objective is not automatically to choose the tightest setting.

The objective is to determine whether historical expectancy survives realistic spread variation.

---

## 34. Slippage and Execution

Backtests cannot perfectly reproduce live execution.

Candidate strategies should therefore be evaluated for sensitivity to:

Slippage

Spread widening

Broker stop levels

Symbol digit format

Contract specifications

Execution delay

Market gaps

Short-duration systems are particularly exposed.

A strategy with only a tiny statistical edge may not survive real execution costs.

---

## 35. Fixed Lot During Research

Initial research should generally use fixed lot size.

Example:

0.01 lot

Reason:

It separates strategy expectancy from money-management effects.

Compounding, martingale, grid size escalation, or variable risk can distort interpretation.

First determine:

Does the entry/exit logic work?

Only later investigate:

How should capital be allocated?

---

## 36. Money Management

Money management must not be used to convert a negative-expectancy strategy into an apparently profitable one.

Examples that can hide strategy weakness:

Martingale

Loss recovery

Aggressive lot multiplication

Grid averaging

Excessive leverage

A strategy should demonstrate acceptable expectancy before complex position sizing is considered.

---

## 37. Break Even Research

Break Even should be treated as an experiment, not an automatic improvement.

Possible outcomes:

Reduced average loss

Reduced drawdown

More zero-result trades

Lower average winner

Reduced Take Profit hit rate

Therefore compare:

BE OFF

vs

BE ON

while keeping everything else unchanged.

---

## 38. Trailing Stop Research

Trailing Stop can:

Protect open profit

Reduce large reversals

But may also:

Cut winners early

Reduce reward/risk

Increase exit noise

Therefore trailing should normally be tested after entry quality has been studied.

---

## 39. Stop Loss / Take Profit Research

SL and TP can be tested using:

Fixed Points

ATR Multiples

Range Multiples

Recent Swing Structure

Initial experiments should use small logical grids.

Example:

SL:

200

250

300

350

400

TP:

1.5R

2.0R

2.5R

3.0R

Evaluation must consider more than Net Profit.

---

## 40. Time-of-Day Analysis

XAUUSD liquidity and volatility vary across the day.

Research may segment trades by:

Hour

Asia Session

London Session

New York Session

London / New York Overlap

For each segment evaluate:

Trade Count

Net Profit

Profit Factor

Win Rate

Expected Payoff

Drawdown

Do not remove a session solely because it has fewer trades.

Frequency is not profitability.

---

## 41. Weekday Analysis

Research may compare:

Monday

Tuesday

Wednesday

Thursday

Friday

Evaluate:

Trade Count

Net Profit

Profit Factor

Win Rate

Expected Payoff

A weekday filter should only be introduced when there is evidence of persistent underperformance.

---

## 42. Directional Analysis

Analyze BUY and SELL independently.

Possible experiment:

Long only

Short only

Both directions

This can reveal whether strategy expectancy is directionally asymmetric.

However, a result from one historical period may simply reflect the dominant market trend.

Directional filters should therefore be validated across other periods.

---

## 43. Volatility Filters

ATR is one possible volatility measure.

Possible research questions:

Does the strategy work better when ATR is high?

Does breakout quality improve during volatility expansion?

Does a minimum breakout distance relative to ATR reduce false signals?

Example conditions:

ATR > ATR Moving Average

Breakout Distance > 0.2 ATR

Range Size between 1 ATR and 3 ATR

These are hypotheses, not default truths.

---

## 44. Trend Filters

Trend filters may include:

EMA

SMA

ADX

Price Structure

Possible tests:

BUY only above EMA200

SELL only below EMA200

ADX > 20

ADX > 25

EMA50 > EMA200 for BUY

Every filter increases complexity.

Therefore it must demonstrate measurable value.

---

## 45. Breakout Confirmation

Breakout strategies should distinguish:

Price penetration

from:

Confirmed breakout

Possible confirmation techniques:

Close beyond level

Minimum distance beyond level

ATR buffer

Retest

Momentum confirmation

Volume confirmation where appropriate

Each should be tested independently.

---

## 46. False Breakout Analysis

A false breakout can be operationally defined for research.

Example:

Price exceeds breakout level

↓

Entry occurs

↓

Price reverses

↓

Stop Loss reached before meaningful favorable excursion

Researchers can quantify:

Number of immediate stop-outs

MFE before losing trades

Time to stop

Breakout penetration distance

Range width before entry

This can help identify whether false breakouts are the true source of losses.

---

## 47. Research Logging

Every experiment should be recorded.

Recommended fields:

Experiment ID

EA Version

Date

Hypothesis

Code Change

Parameters

Test Period

Trades

Net Profit

Profit Factor

Expected Payoff

Win Rate

Max Drawdown

Result

PASS / FAIL

Notes

Failed experiments should remain documented.

This prevents repeated testing of previously rejected ideas.

---

## 48. Versioning

Meaningful strategy modifications should produce identifiable versions.

Example:

EA-047

Baseline

EA-047A

Close Confirmation

EA-047B

ATR Buffer

EA-047C

Trend Filter

Alternatively maintain one EA number and use experiment labels.

The important requirement is traceability between:

Source Code

Parameters

Backtest

Research Conclusion

---

## 49. Evidence Hierarchy

Within this repository, evidence should be prioritized approximately as follows:

1. Original MT5 Strategy Tester Report

2. Source Code

3. Reproducible Backtest

4. Research Comparison

5. Screenshots / Graphs

6. External Strategy Literature

External literature can generate hypotheses.

It does not prove that an EA works.

The EA's own reproducible evidence remains the deciding factor.

---

## 50. External Research

External references may be used to investigate:

Breakout logic

Trend following

Volatility filters

ATR

ADX

Market microstructure

Risk management

Exit strategies

Overfitting

Walk-forward validation

However, external ideas should be converted into specific mechanical hypotheses before being added to an EA.

Avoid directly copying complex systems without understanding their role.

---

## 51. XAUUSD-Specific Considerations

XAUUSD can exhibit:

High intraday volatility

Fast directional movements

Sharp reversals

Session-dependent liquidity

Spread expansion

Strong reaction to macroeconomic events

Large regime changes

Therefore XAUUSD strategies should be tested with particular attention to:

Tick quality

Spread

Slippage

Volatility

Time of day

News-sensitive periods

Drawdown

Directional regime

No XAUUSD strategy should be assumed robust from a short historical period alone.

---

## 52. Baseline Example — EA-047

EA-047 provides an example of this methodology.

Strategy:

5-Bar Range Breakout

Market:

XAUUSD.PRO

Timeframe:

M5

Period:

2026.01.02 — 2026.04.01

History:

100% real ticks

Trades:

424

Net Profit:

-$89.70

Profit Factor:

0.90

Expected Payoff:

-$0.21

Win Rate:

30.66%

Maximum Equity Drawdown:

13.18%

Result:

FAIL

The correct next step is not to hide this result.

The correct next step is:

Preserve Baseline

↓

Analyze Weakness

↓

Form Hypothesis

↓

Run Controlled Experiments

This is the intended research process for every EA in the repository.

---

## 53. EA-047 Example Research Direction

EA-047 demonstrates:

Average Profit Trade:

$6.47

Average Loss Trade:

-$3.16

The winner / loser size relationship is approximately:

2.05 : 1

However:

Win Rate:

30.66%

The main initial research question therefore becomes:

Can entry quality be improved without destroying the favorable payoff relationship?

Candidate experiments:

Candle Close Confirmation

Breakout Buffer

ATR Confirmation

Range Size Filter

Trend Filter

Session Analysis

Bars Count

Break Even

Trailing Stop

SL / TP Research

These should be tested sequentially.

---

## 54. Experiment PASS Criteria

An experiment should not be accepted only because:

Net Profit increased.

A stronger evaluation requires improvement in a combination of:

Profit Factor

Expected Payoff

Drawdown

Equity Stability

Win Rate

Trade Quality

Sample Size

Out-of-Sample Behavior

The exact thresholds may depend on the strategy.

However, an experiment should demonstrate a meaningful and explainable improvement over baseline.

---

## 55. Experiment FAIL Criteria

Reject or defer a modification when:

Profit Factor deteriorates

Expected Payoff remains negative

Drawdown increases materially without sufficient return

Trade count collapses

Performance depends on a few isolated trades

Equity curve becomes unstable

Improvement disappears on unseen data

The hypothesis may be revised later.

Do not delete the evidence.

---

## 56. Out-of-Sample Requirement

A historically optimized configuration should not be labeled validated until tested on data excluded from development.

The out-of-sample test should ideally use:

Same EA

Same fixed parameters

No retuning

New historical period

The question is:

**Does the edge survive when the strategy sees data it was not optimized against?**

---

## 57. Forward Testing

After successful historical validation, the next stage is forward testing.

Possible environments:

MT5 Demo

Cent Account where appropriate

Small controlled live account

Forward testing should verify:

Signal timing

Broker compatibility

Spread behavior

Execution

Slippage

Position management

Difference between tester and live behavior

A strategy should not move directly from optimization to meaningful live capital.

---

## 58. Live Candidate Classification

A strategy should only become a live candidate after evidence exists for:

Positive historical expectancy

Reasonable drawdown

Sufficient sample size

Parameter stability

Out-of-sample performance

Acceptable forward-test behavior

Operational reliability

Even then, live performance is not guaranteed.

---

## 59. Research Status Labels

Recommended labels:

IDEA

Strategy concept exists.

CODED

EA implementation complete.

BASELINE TESTED

Initial backtest complete.

FAIL

Baseline or experiment rejected.

RESEARCHING

Active hypothesis testing.

CANDIDATE

Promising configuration identified.

OOS PASS

Passed out-of-sample test.

FORWARD TEST

Currently being forward-tested.

VALIDATED CANDIDATE

Passed defined research stages.

RETIRED

Research discontinued.

These labels help prevent unfinished experiments from being mistaken for validated strategies.

---

## 60. Final Principle

The repository is not intended to collect only profitable backtests.

It is intended to build a transparent research history.

A failed EA can reveal:

Which market assumptions were wrong

Which entry logic is weak

Which filters matter

Which parameters are unstable

Which ideas should not be repeated

The desired process is:

**Build → Test → Measure → Learn → Modify → Validate**

not:

**Optimize until a profitable chart appears.**

The final objective is not the best historical result.

The final objective is a strategy whose behavior can be explained, reproduced, challenged, and validated across unseen market conditions.

---

## Disclaimer

All Expert Advisors, backtests, research findings, and methodology documented in this repository are intended for research, educational, and software-development purposes.

Historical performance does not guarantee future results.

Trading XAUUSD and other leveraged financial instruments involves substantial financial risk.

Backtest results can vary due to broker conditions, historical data, spread, slippage, leverage, contract specifications, execution, and parameter settings.

No strategy should be deployed with meaningful live capital solely on the basis of historical backtesting.
