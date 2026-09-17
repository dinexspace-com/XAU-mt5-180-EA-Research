# EA-066 — Failed Retest Break Research

## Research Objective

EA-066 investigates whether adding an additional continuation-confirmation stage after a breakout retest can improve the quality of XAUUSD breakout entries.

The strategy sequence is:

```text
Historical Range
        ↓
Initial Breakout
        ↓
Wait for Retest
        ↓
Retest Rejection
        ↓
Wait for New Candle
        ↓
Break Original Breakout-Candle Extreme
        ↓
Entry
```

The main hypothesis is:

> A breakout that successfully retests the broken range and subsequently breaks the original breakout-candle extreme may provide a higher-quality continuation signal than entering immediately after the retest.

EA-066 is intentionally more selective than a simple breakout-retest entry.

---

# 1. Strategy Hypothesis

A normal breakout can fail because price may temporarily move beyond a historical range without generating sustained continuation.

A retest provides additional confirmation, but even a successful retest can still be followed by weak continuation.

EA-066 therefore adds another requirement:

```text
Breakout
+
Retest
+
Rejection
+
Break of Original Breakout Extreme
```

The research question is whether this additional confirmation improves:

```text
Win Rate
Profit Factor
Expected Payoff
Drawdown
Trade Quality
```

without reducing trade frequency so much that the system loses practical usefulness.

---

# 2. Strategy Structure

## Historical Range

Baseline:

```text
InpBreakoutLookback = 20
```

The EA identifies:

```text
Upper Range = Highest High
Lower Range = Lowest Low
```

from the preceding completed candles.

---

## Initial Breakout

Bullish:

```text
Close > Upper Range + Breakout Buffer
```

Bearish:

```text
Close < Lower Range - Breakout Buffer
```

Baseline:

```text
InpBreakoutBuffer = 0
```

No trade is opened at this stage.

The EA stores the breakout level and the extreme of the original breakout candle.

---

## Retest

After breakout detection, price must return toward the broken range boundary.

Baseline:

```text
InpRetestTolerance = 20 points
InpRetestMaxBars   = 10
```

A valid retest must reject the broken level in the breakout direction.

---

## Continuation Confirmation

After the retest, EA-066 waits for another completed candle.

BUY:

```text
Close > Original Breakout Candle High
```

SELL:

```text
Close < Original Breakout Candle Low
```

This continuation condition is the principal hypothesis being tested by EA-066.

---

# 3. Baseline Configuration

```text
Symbol                  = XAUUSD.PRO
Timeframe               = M1

Lot Size                = 0.01

Stop Loss               = 300 points
Take Profit             = 600 points

Breakout Lookback       = 20
Breakout Buffer         = 0

Retest Tolerance        = 20 points
Retest Maximum Bars     = 10

Break Even              = ON
Break Even Trigger      = 150
Break Even Offset       = 0

Trailing Stop           = ON
Trailing Start          = 200
Trailing Distance       = 100
Trailing Step           = 10

Maximum Spread          = 30
Slippage                = 10
```

---

# 4. Baseline Backtest

```text
EA                      = EA-066_Failed_Retest_Break

Symbol                  = XAUUSD.PRO
Timeframe               = M1

Period                  = 2026-01-02 → 2026-03-31

Initial Deposit         = $100
Leverage                = 1:500

History Quality         = 100% real ticks

Bars                    = 85,161
Ticks                   = 39,639,179
```

Baseline result:

```text
Total Trades            = 382

Winning Trades          = 181
Losing Trades           = 201

Win Rate                = 47.38%
Loss Rate               = 52.62%

BUY Trades              = 233
BUY Win Rate            = 51.50%

SELL Trades             = 149
SELL Win Rate           = 40.94%

Net Profit              = -$92.01

Gross Profit            = $415.94
Gross Loss              = -$507.95

Profit Factor           = 0.82
Expected Payoff         = -$0.24

Recovery Factor         = -1.00
Sharpe Ratio            = -5.00

Maximum Equity DD       = 92.01%

Average Profit Trade    = +$2.30
Average Loss Trade      = -$2.53

Largest Profit Trade    = +$7.01
Largest Loss Trade      = -$5.34

Maximum Consecutive Wins   = 9
Maximum Consecutive Losses = 7
```

Baseline classification:

```text
FAIL
```

---

# 5. Main Baseline Finding

The additional continuation confirmation did not produce positive expectancy.

Baseline:

```text
Win Rate        = 47.38%
Profit Factor   = 0.82
Expected Payoff = -$0.24
```

The average trade relationship was:

```text
Average Winner = +$2.30
Average Loser  = -$2.53
```

Therefore:

```text
Average Winner < Average Loser
```

Using the realized average winner and loser:

```text
Break-Even Win Rate
=
2.53 / (2.30 + 2.53)

≈ 52.38%
```

Actual baseline:

```text
47.38%
```

Difference:

```text
≈ -5.00 percentage points
```

The strategy therefore did not win frequently enough to compensate for its realized average loss size.

---

# 6. Comparison with EA-065

EA-066 was created as a more selective continuation version of the Retest Breakout concept tested by EA-065.

Baseline comparison:

| Metric | EA-065 Retest Breakout | EA-066 Failed Retest Break |
|---|---:|---:|
| Trades | 459 | 382 |
| Win Rate | 51.42% | 47.38% |
| Net Profit | -$94.61 | -$92.01 |
| Profit Factor | 0.84 | 0.82 |
| Expected Payoff | -$0.21 | -$0.24 |
| Max Equity DD | 95.36% | 92.01% |
| Average Winner | +$2.03 | +$2.30 |
| Average Loser | -$2.58 | -$2.53 |

EA-066 generated:

```text
459 - 382 = 77 fewer trades
```

Approximate reduction:

```text
77 / 459 ≈ 16.8%
```

The additional confirmation therefore increased selectivity.

However:

```text
Win Rate:
51.42% → 47.38%

Profit Factor:
0.84 → 0.82

Expected Payoff:
-$0.21 → -$0.24
```

The additional continuation requirement did not improve the baseline trading edge.

It reduced trade frequency without improving profitability.

This is an important negative research result.

---

# 7. Drawdown Comparison

EA-066:

```text
Maximum Equity DD = 92.01%
```

EA-065:

```text
Maximum Equity DD = 95.36%
```

Difference:

```text
95.36% - 92.01% = 3.35 percentage points
```

EA-066 reduced maximum drawdown slightly.

However:

```text
92.01%
```

remains extreme and unacceptable for deployment.

The drawdown reduction is therefore not sufficient evidence of meaningful strategy improvement.

---

# 8. Directional Asymmetry

A significant difference exists between BUY and SELL performance.

```text
BUY Trades    = 233
BUY Win Rate  = 51.50%

SELL Trades   = 149
SELL Win Rate = 40.94%
```

Difference:

```text
51.50% - 40.94%
=
10.56 percentage points
```

This is large enough to justify a controlled directional experiment.

However, the current baseline alone is not sufficient evidence to permanently disable SELL trades.

Required future comparison:

```text
A — BUY + SELL
B — BUY only
C — SELL only
```

All other parameters must remain unchanged during this experiment.

---

# 9. Trade Frequency

EA-066 generated:

```text
382 trades
```

during the baseline period.

The additional continuation confirmation reduced signal frequency compared with EA-065.

However, the sample remains large enough to identify persistent weakness in the baseline configuration.

The failure cannot reasonably be attributed to only one or two isolated trades.

---

# 10. Holding Time

Baseline holding-time statistics:

```text
Minimum Holding Time = 00:00:01
Average Holding Time = 00:03:54
Maximum Holding Time = 02:03:00
```

EA-066 therefore behaves primarily as a short-duration intraday strategy.

Because the average position remains open for less than four minutes, the strategy may be particularly sensitive to:

```text
Spread
Slippage
Execution latency
Broker conditions
Short-term volatility
M1 market noise
```

---

# 11. MFE / MAE Observation

Baseline:

```text
Correlation (Profit, MFE) = 0.96
Correlation (Profit, MAE) = 0.70
Correlation (MFE, MAE)    = 0.6068
```

The strong relationship between realized profit and Maximum Favorable Excursion indicates that trades which move farther in the intended direction generally generate larger realized profits.

However:

```text
Average Winner = +$2.30
Average Loser  = -$2.53
```

The current trade-management structure still produces an unfavorable realized payoff relationship.

Exit management therefore remains a legitimate research variable.

---

# 12. Research Interpretation

The EA-066 baseline rejects the simple assumption:

```text
More Confirmation
=
Better Strategy
```

Under the tested conditions, requiring the market to break the original breakout-candle extreme after the retest:

```text
Reduced Trade Count
```

but also produced:

```text
Lower Win Rate
Lower Profit Factor
Lower Expected Payoff
```

than the simpler EA-065 baseline.

The additional continuation confirmation therefore appears to remove both losing and winning opportunities.

Its net contribution under the baseline conditions is negative.

---

# 13. Primary Research Question

The primary research question specific to EA-066 is:

```text
Does requiring a post-retest break
of the original breakout-candle extreme
improve entry quality,
or does it simply delay entry?
```

This should be investigated before broad parameter optimization.

---

# 14. RQ01 — Continuation Break Requirement

Highest priority.

Compare:

```text
A — Enter after valid retest

vs

B — Enter only after valid retest
    + break of original breakout extreme
```

Keep unchanged:

```text
Timeframe
Lookback
Breakout Buffer
Retest Tolerance
Retest Maximum Bars
Stop Loss
Take Profit
Break Even
Trailing Stop
Lot Size
Spread Filter
```

Compare:

```text
Trade Count
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Average Winner
Average Loser
```

EA-065 provides the existing reference for the simpler retest-entry approach.

EA-066 provides the continuation-confirmation reference.

---

# 15. RQ02 — BUY vs SELL Directionality

Because:

```text
BUY Win Rate  = 51.50%
SELL Win Rate = 40.94%
```

test:

```text
A — BUY + SELL
B — BUY only
C — SELL only
```

Do not modify any other parameter.

Objective:

Determine whether the directional asymmetry persists outside the baseline period.

---

# 16. RQ03 — Timeframe Evaluation

Current:

```text
M1
```

Controlled comparison:

```text
M1
M5
M15
```

The strategy parameters should remain as consistent as technically meaningful.

Research question:

```text
Does the breakout → retest → continuation structure
perform better when short-term M1 noise is reduced?
```

This should be a timeframe comparison, not a full optimization on every timeframe.

---

# 17. RQ04 — Breakout Lookback

Current:

```text
InpBreakoutLookback = 20
```

Possible controlled comparison:

```text
10
20
30
50
```

Research question:

```text
Does historical range length materially affect
the quality of the breakout,
retest,
and final continuation signal?
```

Only the breakout lookback should change in this experiment.

---

# 18. RQ05 — Breakout Buffer

Current:

```text
InpBreakoutBuffer = 0
```

A zero buffer permits a breakout setup when the completed candle closes only marginally beyond the historical range.

Research question:

```text
Does requiring additional distance beyond the range
remove weak or marginal breakouts?
```

This parameter should be tested independently.

---

# 19. RQ06 — Retest Tolerance

Current:

```text
InpRetestTolerance = 20 points
```

Research question:

```text
Is the current retest definition
too tight,
appropriate,
or too permissive?
```

This parameter controls how closely price must return to the broken range boundary.

---

# 20. RQ07 — Retest Maximum Bars

Current:

```text
InpRetestMaxBars = 10
```

Research question:

```text
Does breakout quality deteriorate
when the retest occurs too long
after the original breakout?
```

Possible analysis:

```text
Fast Retest
vs
Delayed Retest
```

The objective is to determine whether old breakout setups become stale.

---

# 21. RQ08 — Trading Session

Baseline trades occurred across most trading hours.

Future analysis should compare:

```text
Asian Session
European Session
US Session
```

Research question:

```text
Does EA-066 perform differently
during specific XAUUSD trading sessions?
```

A session restriction should not be introduced until the historical distribution is quantified.

---

# 22. RQ09 — Break Even

Current:

```text
InpUseBreakEven     = true
InpBreakEvenTrigger = 150
InpBreakEvenOffset  = 0
```

Research question:

```text
Does moving Stop Loss to Break Even at 150 points
reduce the size of potentially profitable continuation trades?
```

Exit research should be performed after the main entry hypothesis has been evaluated.

---

# 23. RQ10 — Trailing Stop

Current:

```text
InpUseTrailingStop    = true
InpTrailingStart      = 200
InpTrailingDistance   = 100
InpTrailingStep       = 10
```

Research question:

```text
Does the current trailing configuration
close trades before the intended breakout continuation develops?
```

This should be investigated separately from entry research.

---

# 24. Research Priority

The research sequence is:

```text
EA066-M1-BASELINE-001
        ↓
RQ01 — Continuation Requirement
        ↓
RQ02 — BUY vs SELL
        ↓
RQ03 — Timeframe
        ↓
RQ04 — Breakout Lookback
        ↓
RQ05 — Breakout Buffer
        ↓
RQ06 — Retest Tolerance
        ↓
RQ07 — Retest Maximum Bars
        ↓
RQ08 — Session Analysis
        ↓
RQ09 — Break Even
        ↓
RQ10 — Trailing Stop
        ↓
Controlled Parameter Optimization
        ↓
Candidate Selection
        ↓
Out-of-Sample Validation
        ↓
Month-by-Month Validation
        ↓
Robustness Test
        ↓
Forward Test
```

---

# 25. Optimization Status

Current status:

```text
BLOCKED
```

Broad parameter optimization should not begin yet.

Do not simultaneously optimize:

```text
Breakout Lookback
Breakout Buffer
Retest Tolerance
Retest Maximum Bars
Stop Loss
Take Profit
Break Even
Trailing Stop
```

before controlled research identifies which components materially influence the strategy.

The immediate goal is to understand the strategy.

The immediate goal is not to maximize historical Net Profit.

---

# 26. Optimization Candidate Requirements

A future parameter configuration may proceed to validation only when it demonstrates:

```text
Net Profit > 0

Profit Factor > 1

Expected Payoff > 0

Drawdown materially lower than baseline

Adequate Trade Count

No isolated optimization spike

Reasonable neighboring parameter stability
```

Meeting these requirements means:

```text
Candidate for Validation
```

not:

```text
Approved for Live Trading
```

---

# 27. Out-of-Sample Requirement

Any parameter set selected from research data must be frozen before independent validation.

Sequence:

```text
Research / In-Sample
        ↓
Candidate Selected
        ↓
Parameters Frozen
        ↓
Out-of-Sample Test
```

Do not modify the candidate after observing the out-of-sample result while continuing to classify the test as independent validation.

Any parameter modification creates a new research iteration.

---

# 28. Month-by-Month Validation

A successful candidate should also be evaluated across separate periods.

Example:

```text
January
February
March
April
...
```

For each period record:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Trades
Win Rate
```

The objective is to determine whether performance is distributed across time or concentrated in one exceptional period.

---

# 29. Robustness Requirements

A candidate should not receive final research validation based only on positive Net Profit.

Review:

```text
Positive Expectancy

Reasonable Drawdown

Adequate Trade Count

Neighboring Parameter Stability

Out-of-Sample Performance

Month-to-Month Stability

BUY / SELL Stability

No Dependence on One Exceptional Trade

No Dependence on One Exceptional Period
```

---

# 30. Evidence Policy

The baseline evidence must remain unchanged.

Current evidence:

```text
EAs/
└── EA-066_Failed_Retest_Break/
    ├── EA-066_Failed_Retest_Break.mq5
    └── README.md

Backtest/
└── EA-066_Failed_Retest_Break/
    ├── README.md
    ├── ReportTester-952747(20260917-063457).html
    ├── ReportTester-952747(20260917-063457).png
    ├── ReportTester-952747-hst(20260917-063458).png
    ├── ReportTester-952747-mfemae(20260917-063458).png
    └── ReportTester-952747-holding(20260917-063457).png
```

Any future experiment must create new evidence rather than overwrite the baseline.

---

# 31. Baseline Status

```text
EA ID                  = EA-066

Strategy               = Failed Retest Break

Source Code            = COMPLETE

Baseline Backtest      = COMPLETE

Technical Execution    = PASS

Baseline Performance   = FAIL

Total Trades           = 382

Win Rate               = 47.38%

BUY Win Rate           = 51.50%

SELL Win Rate          = 40.94%

Net Profit             = -$92.01

Profit Factor          = 0.82

Expected Payoff        = -$0.24

Maximum Equity DD      = 92.01%

Research               = IN PROGRESS

Broad Optimization     = BLOCKED

Candidate Selection    = NOT STARTED

Out-of-Sample          = NOT STARTED

Month Validation       = NOT STARTED

Robustness Test        = NOT STARTED

Forward Test           = NOT STARTED

Live Trading           = NOT APPROVED
```

---

# 32. Current Research Conclusion

EA-066 successfully implements a more selective breakout-retest-continuation hypothesis.

The additional confirmation reduced the number of trades compared with EA-065.

However, the baseline did not demonstrate an improvement in trading edge.

Compared with EA-065:

```text
Trades:
459 → 382

Win Rate:
51.42% → 47.38%

Profit Factor:
0.84 → 0.82

Expected Payoff:
-$0.21 → -$0.24

Maximum Equity DD:
95.36% → 92.01%
```

The additional continuation requirement therefore reduced trade frequency and slightly reduced drawdown, but did not improve profitability or expectancy.

The current evidence does not justify broad optimization.

The next controlled research question is:

```text
EA066-RQ01

Does requiring a break of the original breakout-candle extreme
after a valid retest provide useful confirmation,
or does it simply create a later and less efficient entry?
```

EA-066 remains:

```text
UNDER RESEARCH
```

and is:

```text
NOT VALIDATED FOR LIVE TRADING
```
