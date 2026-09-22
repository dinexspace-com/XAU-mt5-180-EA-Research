# EA-074 — New York Range Break | Backtest

## Overview

This directory contains the baseline MetaTrader 5 backtest evidence for:

**EA-074_New_York_Range_Break**

The purpose of this test is to establish the unoptimized baseline behavior of the New York Range Break strategy before controlled research, structural modification, or parameter optimization.

The baseline tests a session-range breakout structure using:

```text
Range Formation:
13:00 → 14:00 server time

Breakout Trading:
14:00 → 20:00 server time

Signal Timeframe:
M1
```

All session hours use broker/server time.

The configured hours must not automatically be interpreted as New York local time.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-074_New_York_Range_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $1,000.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols | 1 |
| Broker / Company | ACCM Intl Limited |
| MT5 Build | 6182 |
| Currency | USD |

---

## Baseline Configuration

```text
InpLotSize             = 0.01

InpStopLoss            = 300
InpTakeProfit          = 600

InpMagicNumber         = 123074
InpSlippage            = 10
InpMaxSpread           = 30

InpTimeframe           = M1
InpBreakoutLookback    = 20
InpBreakoutBuffer      = 0

InpUseBreakEven        = true
InpBreakEvenTrigger    = 150
InpBreakEvenOffset     = 0

InpUseTrailingStop     = true
InpTrailingStart       = 200
InpTrailingDistance    = 100
InpTrailingStep        = 10

InpRangeStartHour      = 13
InpRangeEndHour        = 14
InpTradeEndHour        = 20
```

Session structure:

```text
13:00 ───────── 14:00 ───────────────────── 20:00
│                │                           │
│  Build Range   │      Breakout Trading     │
│                │                           │
└────────────────┴───────────────────────────┘
```

---

## Baseline Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$7.69 |
| Gross Profit | $521.09 |
| Gross Loss | -$528.78 |
| Profit Factor | 0.99 |
| Expected Payoff | -$0.02 |
| Recovery Factor | -0.08 |
| Sharpe Ratio | -2.72 |
| Total Trades | 436 |
| Total Deals | 872 |
| Winning Trades | 217 (49.77%) |
| Losing Trades | 219 (50.23%) |
| Long Trades | 248 |
| Long Win Rate | 47.98% |
| Short Trades | 188 |
| Short Win Rate | 52.13% |

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $21.08 |
| Balance Drawdown Maximal | $100.87 (9.27%) |
| Balance Drawdown Relative | 9.27% ($100.87) |
| Equity Drawdown Absolute | $21.29 |
| Equity Drawdown Maximal | $102.10 (9.37%) |
| Equity Drawdown Relative | 9.37% ($102.10) |

The baseline finished slightly below the initial account balance:

```text
Initial Deposit:
$1,000.00

Net Profit:
-$7.69

Approximate Final Balance:
$992.31
```

The strategy therefore finished close to break-even in absolute terms but did not establish positive expectancy.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Winning Trade | $6.93 |
| Largest Losing Trade | -$4.57 |
| Average Winning Trade | $2.40 |
| Average Losing Trade | -$2.41 |
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Losses | 8 |
| Maximum Consecutive Profit | $26.19 |
| Maximum Consecutive Loss | -$21.67 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The average winning and losing trades were nearly symmetrical:

```text
Average Winner:
+$2.40

Average Loser:
-$2.41
```

With a win rate of:

```text
49.77%
```

this produced slightly negative baseline expectancy.

---

## Directional Performance

### SELL

```text
Trades:
188

Win Rate:
52.13%
```

### BUY

```text
Trades:
248

Win Rate:
47.98%
```

The baseline therefore shows directional asymmetry:

```text
SELL Win Rate
52.13%

vs.

BUY Win Rate
47.98%
```

This is an observation from the baseline sample only.

It does not establish that SELL-only trading is superior outside this test period.

Directional behavior should be evaluated as a separate controlled research question.

---

## Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Average Holding Time | 00:01:25 |
| Maximum Holding Time | 00:23:28 |

The average position remained open for only:

```text
1 minute 25 seconds
```

The holding-time distribution also shows that a large proportion of trades were concentrated in short holding periods.

This makes execution conditions especially relevant to future validation.

Important variables include:

```text
Spread

Slippage

Tick quality

Broker stop levels

Broker freeze levels

Execution latency
```

---

## MFE / MAE Analysis

MetaTrader 5 reported:

```text
Correlation (Profit, MFE)
=
0.96

Correlation (Profit, MAE)
=
0.73

Correlation (MFE, MAE)
=
0.6284
```

The Profit/MFE relationship is visually strong in the supplied report.

The MFE/MAE evidence should be retained for later exit-management research, particularly when evaluating:

```text
Stop Loss

Take Profit

Break Even

Trailing Stop
```

These correlations are descriptive statistics from this backtest and should not be interpreted as independent evidence of predictive edge.

---

## Entry Distribution

The entry-distribution chart shows that baseline entries occurred during the configured post-range trading window.

The strongest concentration of entries occurred immediately after range completion.

Visually:

```text
14:00
=
Highest entry concentration
```

with progressively fewer entries later in the trading window.

Entries were also present during:

```text
15:00
16:00
17:00
18:00
19:00
```

This creates a useful structural research question:

```text
Does breakout quality deteriorate
as time from range completion increases?
```

Breakout-time segmentation should therefore be tested separately rather than immediately optimizing the entire trading window.

---

## Weekday Distribution

Trades occurred across all normal trading weekdays:

```text
Monday
Tuesday
Wednesday
Thursday
Friday
```

The supplied distribution chart shows differing trade counts across weekdays.

This is descriptive evidence only.

No weekday filter should be introduced solely from visual inspection of this baseline chart.

Any weekday restriction must be tested as an independent hypothesis.

---

## Monthly Distribution

The baseline period covers:

```text
January 2026
February 2026
March 2026
```

Trade activity was present in all three months.

The balance curve changed materially during the test:

```text
Early period
        ↓
Initial decline

Middle period
        ↓
Strong recovery / expansion

Later period
        ↓
Extended deterioration

End
        ↓
Below initial balance
```

This suggests substantial variation in strategy behavior across the three-month sample.

The observation should be investigated through regime and time-segment analysis rather than interpreted as proof of a specific market cause.

---

## Balance Curve Analysis

The balance curve is not a smooth persistent upward trajectory.

It contains several distinct phases.

### Phase 1 — Initial Drawdown

The strategy initially declined from approximately:

```text
$1,000
```

toward the high-$970 / low-$980 region.

### Phase 2 — Recovery

The strategy subsequently recovered and moved above the starting balance.

### Phase 3 — Expansion

The strongest portion of the test pushed the balance above:

```text
$1,080
```

at its approximate peak.

### Phase 4 — Deterioration

The later portion of the sample gave back the previous gains.

The test finished near:

```text
$992
```

consistent with the MT5-reported:

```text
Net Profit = -$7.69
```

The balance curve therefore provides an important research signal:

```text
The strategy demonstrated periods
of positive performance,

but those gains were not retained
across the complete baseline period.
```

This does not establish why performance changed.

Regime dependence must be tested rather than inferred from the balance curve alone.

---

## Repeated Breakout Behavior

The raw MT5 order history confirms that the baseline can generate multiple breakout trades during the same trading day.

For example, the report contains repeated entries during individual sessions at different times after the range is complete.

Therefore this baseline is classified as:

```text
MULTIPLE BREAKOUT ATTEMPTS ALLOWED
```

rather than:

```text
FIRST BREAKOUT ONLY
```

This behavior is important because repeated attempts can materially change:

```text
Trade Count

Win Rate

Transaction Costs

Drawdown

Loss Clustering

Daily Exposure

Expectancy
```

The effect must be measured directly.

---

## Baseline Assessment

The baseline result is:

```text
Total Net Profit:
-$7.69

Profit Factor:
0.99

Expected Payoff:
-$0.02

Recovery Factor:
-0.08

Win Rate:
49.77%

Maximum Balance Drawdown:
9.27%

Maximum Equity Drawdown:
9.37%
```

Therefore:

```text
BASELINE PROFITABILITY
NOT CONFIRMED
```

The strategy came close to break-even during this specific test but remained slightly negative.

A Profit Factor of:

```text
0.99
```

means gross profit was nearly equal to gross loss:

```text
Gross Profit:
+$521.09

Gross Loss:
-$528.78
```

The result should not be rounded conceptually into a profitable system.

---

## Baseline Classification

The baseline is classified as:

```text
BASELINE TEST
=
COMPLETED

RESULT
=
FAIL

TRADING EDGE
=
NOT CONFIRMED

LIVE VALIDATION
=
NOT VALIDATED
```

`FAIL` means that this exact baseline configuration did not satisfy positive-expectancy requirements in the documented test.

It does **not** mean that the broader New York Range Break research hypothesis has been rejected.

The distinction is:

```text
Baseline Configuration
        ↓
FAILED

Broader Strategy Hypothesis
        ↓
REQUIRES FURTHER TESTING
```

---

## Why This Baseline Is Important

Despite the negative final result, EA-074 differs materially from a deeply negative baseline.

The measured result was close to neutral:

```text
Profit Factor:
0.99

Expected Payoff:
-$0.02

Net Profit:
-$7.69
```

At the same time, the strategy experienced:

```text
Maximum Equity Drawdown:
9.37%
```

and substantial variation across the test period.

This combination makes structural analysis important before broad parameter optimization.

The next stage should determine whether identifiable components of the baseline are producing the negative expectancy.

---

## Primary Research Questions

The baseline generates several testable questions.

### RQ01 — First Breakout Only

Current baseline:

```text
Multiple breakout attempts allowed
```

Experiment:

```text
Maximum one breakout entry
per trading day
```

Question:

```text
Do repeated breakout attempts
reduce expectancy?
```

---

### RQ02 — Directional Asymmetry

Baseline:

```text
SELL
188 trades
52.13% won

BUY
248 trades
47.98% won
```

Required comparison:

```text
BUY + SELL
vs.
BUY only
vs.
SELL only
```

The purpose is to determine whether the observed directional difference is persistent or sample-specific.

---

### RQ03 — Breakout Time

The entry chart shows the largest concentration of entries near the beginning of the trading window.

Required segmentation:

```text
14:00–14:59

15:00–15:59

16:00–16:59

17:00–17:59

18:00–18:59

19:00–19:59
```

Question:

```text
Does expectancy change
with time after range completion?
```

---

### RQ04 — Range Size

Measure:

```text
Range High - Range Low
```

for every trading day.

Question:

```text
Does breakout performance depend
on the size of the preceding range?
```

---

### RQ05 — Breakout Strength

Baseline:

```text
Breakout Buffer = 0
```

Question:

```text
Does requiring additional displacement
outside the range improve signal quality?
```

---

### RQ06 — Volatility Regime

Evaluate whether performance changes under different volatility conditions.

Potential normalization:

```text
Range Size
──────────
ATR
```

or other predefined volatility measurements.

---

### RQ07 — Break Even

Baseline:

```text
Break Even:
ON

Trigger:
150

Offset:
0
```

Compare against a controlled configuration without Break Even.

---

### RQ08 — Trailing Stop

Baseline:

```text
Trailing Stop:
ON

Start:
200

Distance:
100

Step:
10
```

Evaluate whether trailing improves or degrades the underlying breakout distribution.

---

### RQ09 — Server-Time Mapping

The baseline uses:

```text
13:00 → 14:00
```

as broker/server time.

The research must establish how these server hours map to actual New York market hours under:

```text
Broker UTC offset

EST

EDT

Daylight Saving Time transitions
```

before the strategy is described as a validated New York-session implementation.

---

## Next Controlled Experiment

The first structural experiment should compare:

```text
CONTROL

EA-074 Baseline

Multiple breakout attempts
allowed during the trading day
```

against:

```text
EXPERIMENT

EA-074
First Breakout Only

Maximum one accepted breakout
entry per trading day
```

Keep unchanged:

```text
Symbol

Timeframe

Historical period

Broker

Range hours

Trade cutoff

Lot size

SL

TP

Breakout Buffer

Maximum Spread

Break Even

Trailing Stop
```

Primary comparison metrics:

```text
Total Trades

Net Profit

Profit Factor

Expected Payoff

Maximum Drawdown

Win Rate

Average Winner

Average Loser

Consecutive Losses

BUY performance

SELL performance
```

This experiment isolates the effect of repeated breakout attempts.

---

## Backtest Evidence

The directory contains the original MetaTrader 5 Strategy Tester evidence:

```text
Backtest/
└── EA-074_New_York_Range_Break/
    ├── README.md
    ├── ReportTester-952747(20260922-030227).html
    ├── ReportTester-952747(20260922-030228).png
    ├── ReportTester-952747-hst(20260922-030228).png
    ├── ReportTester-952747-mfemae(20260922-030227).png
    └── ReportTester-952747-holding(20260922-030227).png
```

---

## HTML Report

```text
ReportTester-952747(20260922-030227).html
```

Original MetaTrader 5 Strategy Tester report.

It contains:

```text
Test configuration

EA inputs

Performance statistics

Drawdown

Trade statistics

Orders

Deals

Execution evidence
```

This report is the primary source of truth for the published baseline statistics.

---

## Balance Chart

```text
ReportTester-952747(20260922-030228).png
```

Shows the balance evolution across all 436 baseline trades.

The chart visually demonstrates:

```text
Initial drawdown
        ↓
Mid-test recovery
        ↓
Balance expansion above $1,080
        ↓
Later deterioration
        ↓
Finish below $1,000
```

---

## Entry Distribution

```text
ReportTester-952747-hst(20260922-030228).png
```

Contains:

```text
Entries by hour

Entries by weekday

Entries by month

Profit / loss by hour

Profit / loss by weekday

Profit / loss by month
```

This chart is retained as evidence for subsequent time-segment and regime research.

---

## MFE / MAE

```text
ReportTester-952747-mfemae(20260922-030227).png
```

Shows the relationship between:

```text
Profit

Maximum Favorable Excursion

Maximum Adverse Excursion
```

The raw chart is retained for future exit-management analysis.

---

## Holding Time

```text
ReportTester-952747-holding(20260922-030227).png
```

Shows the distribution of position duration.

MT5 reports:

```text
Minimum:
00:00:01

Average:
00:01:25

Maximum:
00:23:28
```

---

## Reproducibility

This baseline is defined by:

```text
Expert:
EA-074_New_York_Range_Break

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-03-31

Deposit:
$1,000

Leverage:
1:500

History:
100% real ticks

Broker:
ACCM Intl Limited

Range:
13:00 → 14:00 server time

Trade End:
20:00 server time

Lot:
0.01

SL:
300

TP:
600

Breakout Buffer:
0

Break Even:
ON

Trailing:
ON
```

Results should not be assumed to remain identical under different:

```text
Historical periods

Brokers

XAUUSD symbol specifications

Spreads

Slippage

Execution conditions

Server timezones

Session mappings

Parameter configurations
```

---

## Research Integrity

This baseline is intentionally retained even though it is not profitable.

The repository does not remove negative experiments or publish only favorable backtests.

The evidence chain is:

```text
Source Code
        ↓
Fixed Baseline
        ↓
Raw MT5 Backtest
        ↓
Measured Result
        ↓
FAIL
        ↓
Research Questions
        ↓
Controlled Experiments
```

The objective is not to search immediately for the parameter set with the highest historical profit.

The objective is to determine whether a reproducible structural trading edge exists.

---

## Status

```text
Source Code:
COMPLETED

Baseline Backtest:
COMPLETED

History Quality:
100% REAL TICKS

Baseline Result:
FAIL

Baseline Net Profit:
-$7.69

Baseline Profit Factor:
0.99

Baseline Expected Payoff:
-$0.02

Baseline Maximum Equity Drawdown:
9.37%

Trading Edge:
NOT CONFIRMED

Controlled Research:
NEXT STAGE

Optimization:
NOT VALIDATED

Out-of-Sample:
NOT TESTED

Walk-Forward:
NOT TESTED

Forward Test:
NOT TESTED

Live Trading:
NOT VALIDATED
```

---

## Conclusion

EA-074's baseline did not demonstrate positive expectancy over the tested XAUUSD.PRO M1 period.

However, the baseline finished close to break-even:

```text
Net Profit:
-$7.69

Profit Factor:
0.99

Expected Payoff:
-$0.02
```

while producing:

```text
436 trades
```

and showing materially different behavior across portions of the test period.

The correct next step is therefore not to declare the strategy profitable and not to broadly optimize every parameter.

The next step is controlled structural research beginning with:

```text
EA074-RQ01

MULTIPLE BREAKOUT ATTEMPTS
vs.
FIRST BREAKOUT ONLY
```

All other baseline conditions should remain unchanged during that experiment.

---

## Disclaimer

This backtest is provided for quantitative research and software-testing purposes.

Historical and simulated performance does not guarantee future trading results.

EA-074 is not validated for live trading.

XAUUSD and other leveraged financial instruments involve substantial risk.
