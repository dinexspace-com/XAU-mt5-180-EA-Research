# Research — EA-045 Trend Pullback Structure

## Research Objective

This research documents the strategy hypothesis, observed weaknesses, external evidence, and future experimental directions for:

`EA-045_Trend_Pullback_Structure`

The purpose is not to prove that the strategy is profitable.

The purpose is to determine whether the underlying concept:

**Trend → Pullback → Structure → Continuation**

contains a reproducible trading edge on XAUUSD and, if so, under which market conditions that edge exists.

The current EA implementation and its first baseline backtest are treated as experimental evidence.

## Strategy Hypothesis

EA-045 is based on a trend-continuation hypothesis.

The strategy assumes that after an established directional trend:

1. Price temporarily retraces.
2. The retracement does not invalidate the existing market structure.
3. Price resumes movement in the direction of the trend.
4. A break of recent swing structure provides confirmation of continuation.

Conceptually:

```text
TREND
  ↓
PULLBACK
  ↓
STRUCTURE REMAINS VALID
  ↓
CONTINUATION BREAK
  ↓
ENTRY
```

For bullish conditions:

```text
EMA Fast > EMA Slow
        ↓
Bullish environment
        ↓
Pullback
        ↓
Higher-Low remains valid
        ↓
Break previous Swing High
        ↓
BUY
```

For bearish conditions:

```text
EMA Fast < EMA Slow
        ↓
Bearish environment
        ↓
Pullback
        ↓
Lower-High remains valid
        ↓
Break previous Swing Low
        ↓
SELL
```

The concept belongs to the broader family of systematic trend-following and pullback-continuation strategies.

## Current EA-045 Implementation

The current implementation uses:

```text
Fast EMA      = 20
Slow EMA      = 50
Swing Bars    = 5
Stop Loss     = 300 points
Take Profit   = 600 points
Lot Size      = 0.01
```

The baseline backtest additionally used:

```text
Max Spread    = 35 points
Break Even    = OFF
Trailing Stop = OFF
```

The nominal SL/TP relationship is:

```text
Risk   = 300 points
Reward = 600 points

Nominal R:R = 1:2
```

The EA therefore requires a sufficiently high continuation probability after entry to overcome losing trades and transaction costs.

## Baseline Experiment

Baseline ID:

`EA045-M1-BASELINE-001`

Test environment:

| Parameter | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.04.01 |
| History | 100% real ticks |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Lot | 0.01 |
| EMA Fast | 20 |
| EMA Slow | 50 |
| Swing Bars | 5 |
| SL | 300 points |
| TP | 600 points |
| Break Even | OFF |
| Trailing | OFF |

Results:

| Metric | Result |
|---|---:|
| Total Trades | 3,757 |
| Winning Trades | 1,160 |
| Losing Trades | 2,597 |
| Win Rate | 30.88% |
| Long Win Rate | 31.62% |
| Short Win Rate | 30.17% |
| Net Profit | -$991.65 |
| Profit Factor | 0.88 |
| Expected Payoff | -$0.26 |
| Recovery Factor | -0.99 |
| Sharpe Ratio | -5.00 |
| Maximum Drawdown | 99.17% |
| Average Winner | $6.20 |
| Average Loser | -$3.15 |

Baseline verdict:

```text
TECHNICAL EXECUTION : PASS
TRADING PERFORMANCE : FAIL
PRODUCTION READY     : NO
```

## Primary Baseline Finding

The baseline demonstrates that the current M1 implementation does not produce positive expectancy.

The important relationship is:

```text
Average Winner = $6.20
Average Loser  = $3.15

Average payoff ratio ≈ 1.97
```

This is close to the intended 2:1 reward/risk structure.

However:

```text
Win Rate = 30.88%
```

For an idealized 2:1 reward/risk system, the approximate break-even win rate before costs is:

```text
1 / (1 + 2) ≈ 33.33%
```

Therefore:

```text
Required ≈ 33.33%
Actual   = 30.88%

Actual < Required
```

The first research conclusion is therefore important:

> The primary problem in the baseline is not that winning trades are too small. The strategy does not generate enough successful entries to support its existing reward/risk structure.

## Research Question 1 — Is Trend Detection Too Weak?

The current EA defines direction primarily through:

```text
EMA20 > EMA50 → bullish
EMA20 < EMA50 → bearish
```

This determines relative short-term trend direction but does not necessarily distinguish between:

```text
Strong Trend
Weak Trend
Transition
Range
Choppy Market
```

Two moving averages can remain directionally aligned while price is moving sideways.

Therefore:

```text
EMA alignment ≠ guaranteed trending regime
```

This is particularly important on M1 where short-term noise can produce repeated apparent continuation structures.

Research hypothesis:

> EA-045 may be trading valid-looking pullback structures during market regimes that do not contain sufficient directional persistence.

Status:

```text
HYPOTHESIS — NOT YET VALIDATED
```

## Research Question 2 — Is M1 Too Noisy?

The baseline produced:

```text
3,757 trades
```

in approximately three months.

Average holding time:

```text
00:04:23
```

This indicates that EA-045 behaves as a very short-term XAUUSD system under the baseline configuration.

At this frequency, small structural movements can repeatedly satisfy the EA's conditions.

The system therefore becomes highly exposed to:

```text
Microstructure noise
False breakouts
Spread
Slippage
Short-lived momentum
Intrabar volatility
Rapid regime changes
```

Research hypothesis:

> The Trend Pullback Structure concept may require a higher execution timeframe or higher-timeframe trend confirmation to reduce false continuation signals.

Status:

```text
HYPOTHESIS — TEST REQUIRED
```

## Research Question 3 — Does the EA Detect a Real Pullback?

The intended strategy is:

```text
Trend
  ↓
Pullback
  ↓
Continuation
```

But a crucial distinction exists between:

```text
A real corrective pullback
```

and:

```text
Any local swing fluctuation
```

The current structure logic relies heavily on recent swing highs and lows.

This can classify very small price oscillations as meaningful structure.

A stronger pullback definition could require objective evidence that price actually retraced before continuation.

Examples to investigate include:

```text
Touch / approach EMA
ATR-normalized retracement
Minimum retracement distance
Minimum pullback duration
Maximum pullback duration
Previous impulse retracement percentage
```

These are experimental candidates, not validated improvements.

## Research Question 4 — Is Breakout Confirmation Too Weak?

The strategy attempts to enter when price breaks recent swing structure.

On XAUUSD M1, however:

```text
Price touches level
```

is not necessarily equivalent to:

```text
Confirmed breakout
```

Possible false-break behavior includes:

```text
Swing High
──────────────
          ↑
          │ wick
          │
          ↓
price returns below level
```

A more conservative continuation model could require:

```text
Candle close beyond structure
```

instead of relying primarily on intrabar penetration.

Another candidate is:

```text
Break
  ↓
Close confirmation
  ↓
Continuation / retest
  ↓
Entry
```

Research hypothesis:

> Requiring closed-bar confirmation may reduce false structural breakouts at the cost of later entries.

Status:

```text
HYPOTHESIS — TEST REQUIRED
```

## Research Question 5 — Should Trend and Entry Use Different Timeframes?

A common systematic architecture separates:

```text
Trend timeframe
```

from:

```text
Entry timeframe
```

For example:

```text
H1 → Trend regime
M5 → Pullback structure
M5 → Entry
```

or:

```text
M15 → Trend regime
M5  → Pullback
M5  → Entry
```

This prevents every small fluctuation on the execution timeframe from redefining the main trend.

Research hypothesis:

> Higher-timeframe directional filtering may reduce M1/M5 false continuation trades.

This should be tested rather than assumed.

## Research Question 6 — Should Trend Strength Be Measured?

EMA direction answers:

```text
Which direction?
```

It does not necessarily answer:

```text
Is the market trending strongly enough to trade?
```

Possible regime-strength variables for controlled experiments include:

```text
EMA slope
EMA separation
ADX
ATR expansion
Price distance from long-term EMA
Higher-timeframe structure
```

These variables should not all be added simultaneously.

Each represents a separate hypothesis.

Example:

```text
EMA20 > EMA50
+
EMA50 slope > minimum threshold
```

or:

```text
EMA20 > EMA50
+
ADX > threshold
```

The purpose would be to reject weak or sideways regimes.

## Research Question 7 — Fixed Stop vs Volatility

The current baseline uses:

```text
SL = 300 points
TP = 600 points
```

regardless of current volatility.

XAUUSD volatility is not constant.

Therefore the same 300-point stop can represent very different market conditions.

Conceptually:

```text
LOW VOLATILITY

300 points = relatively wide

HIGH VOLATILITY

300 points = relatively tight
```

This creates a potential mismatch between market behavior and risk distance.

A future experiment should compare the fixed-distance model against volatility-normalized alternatives such as:

```text
SL = ATR × multiplier
TP = SL × target R
```

Example architecture:

```text
ATR(14)
  ↓
Determine current volatility
  ↓
SL = ATR × N
  ↓
TP = SL × R
```

This is a research direction only.

## Research Question 8 — Structural Stop Loss

Another alternative is to place the stop where the trade hypothesis becomes structurally invalid.

For BUY:

```text
Entry
  ↑
Breakout
  ↑
Pullback
  ↓
Swing Low ← Structural invalidation
```

For SELL:

```text
Swing High ← Structural invalidation
  ↑
Pullback
  ↓
Breakdown
  ↓
Entry
```

The principle is:

> If the setup depends on a Higher-Low or Lower-High remaining valid, the stop could be related to that structural invalidation point.

This may be more logically consistent with the entry hypothesis than an arbitrary fixed-distance stop.

It must nevertheless be tested because structural stops can become excessively wide or narrow.

## Research Question 9 — Session Dependence

The baseline contains thousands of trades distributed across many hours.

XAUUSD behavior changes across global trading sessions.

A future experiment should therefore classify trades by:

```text
Asia
London
New York
London/New York overlap
Other / rollover periods
```

The research objective is not to assume one session is better.

Instead:

```text
All trades
    ↓
Group by session
    ↓
Calculate:
Win Rate
Profit Factor
Expectancy
Drawdown
Trade count
    ↓
Determine whether edge is session-dependent
```

Only after this analysis should a session filter be considered.

## Research Question 10 — Long vs Short Asymmetry

Baseline results:

```text
Long win rate  = 31.62%
Short win rate = 30.17%
```

The difference is small.

Therefore the baseline does not provide strong evidence for eliminating either direction.

A future directional analysis should compare:

```text
LONG only
SHORT only
LONG + SHORT
```

using:

```text
Net expectancy
Profit Factor
Drawdown
Trade count
Stability across periods
```

Direction should not be removed merely because one side has a slightly lower raw win rate.

## External Research — EMA Trend Following

EMA-based trend following has a legitimate quantitative research foundation, but trend-following systems do not automatically generate positive expectancy merely because moving averages are used.

Trend-following return distributions are commonly characterized by many relatively small losses and fewer larger winners.

Transaction costs and strategy timescale are also important because increasing turnover can materially change strategy performance.

This is directly relevant to EA-045 because its M1 baseline generates very high turnover.

The implication is:

```text
Trend concept
      ≠
Profitable implementation
```

The actual edge depends on:

```text
Trend definition
Entry timing
Market regime
Exit structure
Transaction costs
Timeframe
Risk management
```

## External Research — XAUUSD Regime Filtering

Recent rule-based XAUUSD research provides a useful comparison architecture.

One published framework separates several functions:

```text
EMA200 → regime classification
VWAP   → structural/session reference
EMA50  → pullback area
Price confirmation → entry
ATR → risk normalization
```

The important research lesson for EA-045 is not to copy those parameters.

The important principle is:

> Direction, pullback, confirmation, volatility, and risk can be treated as separate components instead of asking EMA20/50 and local swings to perform all functions simultaneously.

This provides a useful architecture for future controlled experiments.

## External Research — Higher-Timeframe Filtering

Other systematic trend-pullback implementations also commonly separate dominant trend from lower-timeframe entry logic.

Typical architecture:

```text
Higher Timeframe
      ↓
Determine dominant direction
      ↓
Lower Timeframe
      ↓
Wait for pullback
      ↓
Continuation confirmation
      ↓
Entry
```

This architecture directly addresses one of the suspected weaknesses of EA-045's M1 baseline:

```text
Trend detection and entry detection currently occur at essentially the same market scale.
```

A higher-timeframe filter is therefore a high-priority research candidate.

## External Research — Controlled Experiments

Quantitative trend research also demonstrates the importance of isolating variables.

For example:

```text
Baseline strategy
       ↓
Add one filter
       ↓
Measure change
```

rather than:

```text
Change EMA
+ Change timeframe
+ Add ADX
+ Add ATR
+ Add session
+ Change TP
+ Change SL
       ↓
Unknown cause of result
```

EA-045 research will follow the first approach.

## Research Priority

Based on the baseline evidence, research should focus first on reducing false entries.

Priority:

```text
1. Market regime
2. Timeframe
3. Pullback quality
4. Breakout confirmation
5. Volatility normalization
6. Session behavior
7. Exit optimization
```

Risk-management modifications should not be used to hide a fundamentally negative entry expectancy.

## Experiment Roadmap

### EXP-001 — Higher Timeframe Baseline

Objective:

Determine whether the strategy concept performs differently when market noise is reduced.

Test:

```text
Current strategy logic
EMA20 / EMA50
SwingBars = 5
SL = 300
TP = 600
BE = OFF
Trailing = OFF
```

Timeframes:

```text
M1
M5
M15
```

Keep other parameters unchanged where technically meaningful.

Compare:

```text
Trades
Win Rate
Profit Factor
Expected Payoff
Net Profit
Maximum Drawdown
```

PASS condition:

```text
A higher timeframe demonstrates materially better expectancy
without relying on an extremely small trade sample.
```

### EXP-002 — Higher-Timeframe Trend Filter

Objective:

Determine whether dominant-trend confirmation reduces false pullback trades.

Candidate architecture:

```text
HTF trend
    ↓
EMA regime
    ↓
Execution timeframe
    ↓
Pullback structure
    ↓
Breakout
```

Compare against EXP-001.

Do not simultaneously change SL/TP.

### EXP-003 — Closed-Bar Breakout

Objective:

Determine whether confirmed candle closes reduce false breakouts.

Baseline:

```text
Structural penetration
```

Experiment:

```text
Close beyond Swing High → BUY confirmation
Close below Swing Low   → SELL confirmation
```

Measure:

```text
Trade reduction
Win Rate
Profit Factor
Expectancy
Drawdown
```

### EXP-004 — Explicit Pullback Requirement

Objective:

Determine whether requiring a measurable retracement improves signal quality.

Possible first test:

```text
Trend valid
+
Price retraces toward EMA
+
Structure remains valid
+
Continuation break
```

Only one pullback definition should be tested initially.

### EXP-005 — Volatility-Normalized Risk

Only after entry improvements are evaluated:

```text
ATR-based SL
+
R-multiple TP
```

Compare against fixed 300/600-point exits.

### EXP-006 — Session Analysis

Do not initially add a session filter.

First calculate performance by session.

Then determine whether a session exclusion has empirical justification.

## Optimization Rules

EA-045 should not be optimized by blindly searching thousands of parameter combinations.

The research process should be:

```text
Hypothesis
    ↓
Single controlled modification
    ↓
Backtest
    ↓
Compare with baseline
    ↓
PASS / FAIL
    ↓
Retain or reject hypothesis
```

Each experiment must preserve:

```text
Code version
Parameter set
Test period
Symbol
Timeframe
Broker/data source
Result report
Charts
Research conclusion
```

## Overfitting Control

A profitable optimized backtest alone is insufficient.

If an improved configuration is discovered, validation should progress through:

```text
Development / In-Sample
        ↓
Out-of-Sample
        ↓
Walk-Forward
        ↓
Parameter Stability
        ↓
Different Market Regimes
        ↓
Forward Test
```

A strategy should not be considered validated if profitability exists only at one narrow parameter combination.

Example warning pattern:

```text
EMA Fast

18 → FAIL
19 → FAIL
20 → HIGH PROFIT
21 → FAIL
22 → FAIL
```

This may indicate parameter instability.

A healthier result would show a broader region of acceptable behavior.

## Required Metrics

Every experiment should record at minimum:

```text
Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Maximum Drawdown
Relative Drawdown
Recovery Factor
Sharpe Ratio
Total Trades
Win Rate
Long Win Rate
Short Win Rate
Average Winner
Average Loser
Maximum Consecutive Losses
Average Holding Time
```

Where possible, also analyze:

```text
Performance by hour
Performance by session
Performance by weekday
Performance by month
MFE
MAE
```

## Research Acceptance Criteria

An experiment is not automatically considered successful merely because:

```text
Net Profit > 0
```

Minimum research evidence should include:

```text
Positive expectancy
Profit Factor > 1
Manageable drawdown
Adequate number of trades
Stable performance across time
No obvious single-period dependency
Reproducible configuration
```

These are research gates rather than guarantees of future profitability.

## Current Research Status

```text
EA-045 TREND PULLBACK STRUCTURE

Strategy concept       : DOCUMENTED
Source implementation  : DOCUMENTED
Baseline backtest      : COMPLETED
Baseline execution     : PASS
Baseline profitability : FAIL
Baseline PF            : 0.88
Baseline DD            : 99.17%
Production validation  : FAIL

Primary issue:
INSUFFICIENT ENTRY EXPECTANCY

Primary research target:
REDUCE FALSE / LOW-QUALITY ENTRIES
```

## Current Working Hypothesis

The current working hypothesis is:

> Trend Pullback Structure may remain a viable research concept, but EMA20/50 alignment plus local M1 swing breakout is insufficient to distinguish high-quality XAUUSD continuation setups from short-term noise.

The next experiments should therefore investigate:

```text
Higher timeframe
+
Stronger trend regime
+
Explicit pullback
+
Closed-bar continuation confirmation
```

without introducing all modifications simultaneously.

## Research Decision

The baseline EA should **not** be discarded.

It should be frozen as:

```text
EA045-M1-BASELINE-001
```

and used as the comparison point for every subsequent experiment.

The correct research path is:

```text
EA045-M1-BASELINE-001
        ↓
Identify weakness
        ↓
Form hypothesis
        ↓
Change one major component
        ↓
Backtest
        ↓
Compare
        ↓
PASS / FAIL
        ↓
Repeat
```

## Final Research Conclusion

The first EA-045 experiment successfully falsified the assumption that the current EMA20/50 + local swing structure implementation is sufficient for profitable XAUUSD M1 trading.

The baseline produced:

```text
3,757 trades
30.88% win rate
0.88 Profit Factor
-$991.65 net profit
99.17% maximum drawdown
```

The approximately 2:1 winner-to-loser relationship was insufficient because successful continuation signals occurred too infrequently.

Therefore the next phase should focus on **signal quality and market regime selection**, not cosmetic parameter optimization.

Research priority:

```text
FIRST:
Find conditions where Trend Pullback Structure has positive expectancy.

THEN:
Optimize risk and exits.

THEN:
Test robustness.

THEN:
Forward test.

ONLY AFTER VALIDATION:
Consider live deployment.
```

Current verdict:

```text
STRATEGY IDEA        : RESEARCH CONTINUES
CURRENT M1 VERSION   : FAIL
CURRENT PARAMETERS   : REJECTED FOR LIVE USE
BASELINE EVIDENCE    : VALID
NEXT STAGE           : CONTROLLED EXPERIMENTS
```

## References

External research used to frame future hypotheses includes quantitative work on EMA trend-following behavior, rule-based XAUUSD regime/pullback systems, higher-timeframe trend filtering, volatility-aware risk management, and controlled trend-strategy experiments.

External examples are used only to generate testable hypotheses.

They are **not** evidence that EA-045 will become profitable.

All EA-045 conclusions must ultimately be supported by its own reproducible backtests, out-of-sample tests, robustness tests, and forward-test evidence.
