# EA-074 — New York Range Break Research Methodology

## 1. Purpose

This document defines the research, testing, optimization, and validation methodology for:

```text
EA-074_New_York_Range_Break
```

The methodology exists to ensure that every material strategy change remains traceable through:

```text
Hypothesis
    ↓
Controlled Change
    ↓
Source Code
    ↓
Backtest
    ↓
Evidence
    ↓
Decision
    ↓
Next Experiment
```

The objective is not to search for the most profitable historical parameter combination.

The objective is to determine whether the New York Range Break concept contains a reproducible and sufficiently robust trading edge on XAUUSD.

---

# 2. Strategy Under Research

EA-074 is an intraday session-range breakout strategy.

Baseline structure:

```text
13:00
SERVER TIME
    ↓
Begin Range Formation
    ↓
Collect M1 Range Data
    ↓
14:00
    ↓
Lock Range High / Range Low
    ↓
Monitor completed M1 candles
    ↓
Break above Range High
    │
    └── BUY

Break below Range Low
    │
    └── SELL
    ↓
Manage Position
    ↓
20:00
    ↓
Stop New Entries
```

Baseline session configuration:

```text
Range:
13:00 → 14:00

Trading Window:
14:00 → 20:00
```

All configured hours use:

```text
BROKER / SERVER TIME
```

They must not automatically be interpreted as New York local time.

---

# 3. Source of Truth

The executable strategy is defined by:

```text
/EAs/EA-074_New_York_Range_Break/
EA-074_New_York_Range_Break.mq5
```

The MQL5 source code is the authoritative definition of implemented behavior.

Documentation describes the implementation but does not override it.

If:

```text
Documentation
≠
Source Code
```

the implementation must be inspected and the documentation corrected.

Historical performance evidence is defined by the original MetaTrader 5 Strategy Tester output stored under:

```text
/Backtest/EA-074_New_York_Range_Break/
```

Research hypotheses and interpretation are maintained under:

```text
/Research/
```

The research procedure is defined by:

```text
/docs/methodology.md
```

---

# 4. Evidence Structure

EA-074 uses four evidence layers:

```text
Research Hypothesis
        ↓
Research/

Strategy Implementation
        ↓
EAs/EA-074_New_York_Range_Break/

Historical Evidence
        ↓
Backtest/EA-074_New_York_Range_Break/

Research Procedure
        ↓
docs/methodology.md
```

These layers must remain distinct.

```text
Hypothesis
≠
Evidence

Source Code
≠
Profitability Evidence

Profitable Backtest
≠
Live Validation
```

---

# 5. Permanent Baseline

The permanent control experiment is:

```text
EA-074 Baseline #01
```

Baseline configuration:

```text
Symbol                = XAUUSD.PRO
Timeframe             = M1

Lot Size              = 0.01

Stop Loss             = 300 points
Take Profit           = 600 points

Magic Number          = 123074
Slippage              = 10 points
Maximum Spread        = 30 points

Breakout Lookback     = 20
Breakout Buffer       = 0

Break Even            = ON
BE Trigger             = 150 points
BE Offset              = 0

Trailing Stop         = ON
Trailing Start        = 200 points
Trailing Distance     = 100 points
Trailing Step         = 10 points

Range Start           = 13:00
Range End             = 14:00
Trade End             = 20:00
```

Baseline #01 must remain unchanged as the permanent reference experiment.

---

# 6. Baseline Test Environment

Baseline #01 was tested using:

```text
Expert:
EA-074_New_York_Range_Break

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-03-31

Initial Deposit:
$1,000.00

Leverage:
1:500

History Quality:
100% real ticks

Bars:
85,161

Ticks:
39,639,179

Broker:
ACCM Intl Limited

MT5 Build:
6182
```

---

# 7. Baseline Result

Baseline #01 produced:

```text
Total Trades          = 436
Total Deals           = 872

Winning Trades        = 217
Losing Trades         = 219

Win Rate              = 49.77%

Net Profit            = -$7.69

Gross Profit          = +$521.09
Gross Loss            = -$528.78

Profit Factor         = 0.99
Expected Payoff       = -$0.02
Recovery Factor       = -0.08
Sharpe Ratio          = -2.72
```

Drawdown:

```text
Balance DD Absolute   = $21.08
Balance DD Maximum    = $100.87
Balance DD Maximum %  = 9.27%

Equity DD Absolute    = $21.29
Equity DD Maximum     = $102.10
Equity DD Maximum %   = 9.37%
```

Directional result:

```text
SELL

Trades:
188

Win Rate:
52.13%


BUY

Trades:
248

Win Rate:
47.98%
```

Trade outcome:

```text
Largest Winner:
+$6.93

Largest Loser:
-$4.57

Average Winner:
+$2.40

Average Loser:
-$2.41
```

Holding time:

```text
Minimum:
00:00:01

Average:
00:01:25

Maximum:
00:23:28
```

MFE / MAE:

```text
Profit ↔ MFE = 0.96

Profit ↔ MAE = 0.73

MFE ↔ MAE = 0.6284
```

---

# 8. Baseline Classification

Baseline #01 is classified as:

```text
BASELINE TEST
=
COMPLETED

RESULT
=
FAIL

POSITIVE EXPECTANCY
=
NOT CONFIRMED

LIVE VALIDATION
=
NOT VALIDATED
```

The classification follows directly from:

```text
Net Profit < 0

Profit Factor < 1

Expected Payoff < 0

Recovery Factor < 0
```

The result is close to break-even, but:

```text
CLOSE TO BREAK-EVEN
≠
PROFITABLE
```

and:

```text
PROFIT FACTOR 0.99
≠
PROFIT FACTOR 1.00+
```

The baseline must therefore remain classified as FAIL.

---

# 9. Baseline Preservation Rule

Baseline #01 is immutable research evidence.

Do not overwrite it after discovering a better configuration.

Preserve:

```text
Original Source Version

Original Parameters

Original Test Period

Original Broker Environment

Original MT5 HTML Report

Original Charts

Original Performance Statistics

Original FAIL Classification
```

A better-performing configuration must become:

```text
NEW EXPERIMENT
```

not:

```text
REPLACEMENT BASELINE
```

unless a later research decision explicitly establishes a new versioned research baseline.

Even then, Baseline #01 remains preserved.

---

# 10. Research Philosophy

EA-074 follows:

```text
STRUCTURE FIRST
PARAMETERS SECOND
```

The baseline combines several interacting components:

```text
Session Range

Repeated Breakout Attempts

BUY / SELL Direction

Breakout Timing

Range Size

Breakout Strength

Volatility

Break Even

Trailing Stop

SL / TP
```

Optimizing all components simultaneously would make it difficult to determine why performance changes.

Therefore research proceeds through controlled experiments.

---

# 11. Controlled Experiment Rule

Each structural experiment should answer:

```text
ONE PRIMARY RESEARCH QUESTION
```

Preferred process:

```text
Observation
    ↓
Research Question
    ↓
Hypothesis
    ↓
Control
    ↓
One Defined Change
    ↓
Backtest
    ↓
Comparison
    ↓
PASS / FAIL / INCONCLUSIVE
```

Avoid:

```text
Change Direction
+
Change Range
+
Change Trade End
+
Change Buffer
+
Change SL
+
Change TP
+
Change Trailing
```

inside the same first-stage experiment.

Otherwise causal interpretation becomes weak.

---

# 12. Experiment Identification

Use:

```text
EA074-RQXX-EXXX
```

Example:

```text
EA074-RQ01-E001
```

means:

```text
EA074
=
EA-074 New York Range Break

RQ01
=
Research Question 01

E001
=
Experiment 001
```

Each completed experiment must have a unique identifier.

---

# 13. Required Experiment Record

Every controlled experiment should document:

```text
Experiment ID

Date

EA Version

Research Question

Hypothesis

Control

Changed Variable

Fixed Variables

Symbol

Timeframe

Test Period

Broker

History Quality

Initial Deposit

Leverage

Input Parameters

Total Trades

Winning Trades

Losing Trades

Net Profit

Gross Profit

Gross Loss

Profit Factor

Expected Payoff

Maximum Balance Drawdown

Maximum Equity Drawdown

Win Rate

Average Winner

Average Loser

Maximum Consecutive Wins

Maximum Consecutive Losses

BUY Result

SELL Result

MFE / MAE if relevant

Holding Time if relevant

Result Classification

Interpretation

Next Action
```

The original MT5 evidence must remain attached to the experiment whenever available.

---

# 14. Research Decision States

Controlled experiments use:

```text
PASS

FAIL

INCONCLUSIVE
```

These classifications apply only to the research hypothesis being tested.

They do not mean:

```text
PRODUCTION READY
```

or:

```text
LIVE VALIDATED
```

---

# 15. PASS Definition

An experiment does not PASS merely because:

```text
Net Profit
>
Baseline Net Profit
```

At minimum evaluate:

```text
Net Profit

Profit Factor

Expected Payoff

Maximum Drawdown

Trade Count

Win Rate

Average Winner

Average Loser

Consecutive Losses

Balance Behavior
```

Where relevant also evaluate:

```text
BUY vs SELL

Breakout Hour

Range Size

MFE

MAE

Holding Time
```

A PASS should indicate that the tested hypothesis produced meaningful evidence in the intended direction without creating an obviously unacceptable deterioration elsewhere.

---

# 16. FAIL Definition

An experiment may be classified:

```text
FAIL
```

when:

```text
The hypothesis is contradicted

or

Strategy quality materially deteriorates

or

The intended structural improvement
does not appear
```

Examples include:

```text
Lower Profit Factor

Lower Expected Payoff

Higher Drawdown

Worse loss clustering

No meaningful improvement

Structural hypothesis contradicted
```

Failed experiments remain part of the repository.

---

# 17. INCONCLUSIVE Definition

Use:

```text
INCONCLUSIVE
```

when evidence is insufficient to reasonably classify the hypothesis.

Examples:

```text
Trade count becomes too small

Metrics conflict materially

Improvement is marginal

Test period is insufficient

Data problem exists

Implementation issue exists

The experiment changes
more than one important variable
```

Do not force every result into PASS or FAIL.

---

# 18. Minimum Comparison Set

Every experiment must compare at least:

| Metric | Purpose |
|---|---|
| Total Trades | Sample size |
| Net Profit | Absolute historical result |
| Gross Profit | Winning magnitude |
| Gross Loss | Losing magnitude |
| Profit Factor | Profit/loss efficiency |
| Expected Payoff | Average historical expectancy |
| Win Rate | Outcome frequency |
| Average Winner | Reward distribution |
| Average Loser | Loss distribution |
| Maximum Balance DD | Balance risk |
| Maximum Equity DD | Equity risk |
| Consecutive Losses | Loss clustering |

No single metric determines strategy validity.

---

# 19. Current Research Sequence

The current controlled research sequence is:

```text
EA074-RQ01
First Breakout Only

        ↓

EA074-RQ02
BUY vs SELL

        ↓

EA074-RQ03
Breakout Time

        ↓

EA074-RQ04
Range Size

        ↓

EA074-RQ05
Breakout Strength / Buffer

        ↓

EA074-RQ06
Volatility Regime

        ↓

EA074-RQ07
Break Even

        ↓

EA074-RQ08
Trailing Stop

        ↓

EA074-RQ09
Server-Time Mapping

        ↓

EA074-RQ10
Exit Architecture

        ↓

Candidate Structure

        ↓

Controlled Optimization
```

RQ09 should also be investigated as early as practical because session mapping affects the interpretation of the strategy itself.

---

# 20. RQ01 — First Breakout Only

The first controlled experiment is:

```text
EA074-RQ01-E001
```

Research question:

> Does restricting EA-074 to the first valid breakout attempt of each trading day improve strategy behavior compared with allowing repeated breakout attempts?

Control:

```text
EA-074 Baseline #01

Multiple breakout attempts
allowed
```

Experimental variant:

```text
Maximum accepted breakout entries
per trading day
=
1
```

After the first accepted BUY or SELL breakout:

```text
No additional breakout entry
until the next trading day
```

Keep unchanged:

```text
Symbol

Timeframe

Test Period

Broker

Range Start

Range End

Trade End

Lot Size

SL

TP

Breakout Buffer

Maximum Spread

Break Even

Trailing Stop
```

Only:

```text
Daily Breakout Entry Limit
```

may change.

---

# 21. RQ01 Comparison

Compare:

| Metric | Baseline #01 | RQ01-E001 | Change |
|---|---:|---:|---:|
| Total Trades | 436 | TBD | TBD |
| Net Profit | -$7.69 | TBD | TBD |
| Profit Factor | 0.99 | TBD | TBD |
| Expected Payoff | -$0.02 | TBD | TBD |
| Win Rate | 49.77% | TBD | TBD |
| Average Winner | +$2.40 | TBD | TBD |
| Average Loser | -$2.41 | TBD | TBD |
| Max Balance DD | 9.27% | TBD | TBD |
| Max Equity DD | 9.37% | TBD | TBD |
| SELL Win Rate | 52.13% | TBD | TBD |
| BUY Win Rate | 47.98% | TBD | TBD |

After the experiment:

```text
PASS

FAIL

or

INCONCLUSIVE
```

must be recorded with the reason.

---

# 22. RQ02 — Direction

Baseline:

```text
SELL

188 trades
52.13% won


BUY

248 trades
47.98% won
```

The difference is an observation.

It is not sufficient evidence to disable BUY.

Required variants:

```text
CONTROL

BUY + SELL
```

```text
VARIANT A

BUY ONLY
```

```text
VARIANT B

SELL ONLY
```

Compare:

```text
Net Profit

Profit Factor

Expected Payoff

Maximum Drawdown

Average Winner

Average Loser

Trade Count
```

rather than win rate alone.

---

# 23. RQ03 — Breakout Time

Baseline trading window:

```text
14:00 → 20:00
```

Initial analytical segmentation:

```text
14:00–14:59

15:00–15:59

16:00–16:59

17:00–17:59

18:00–18:59

19:00–19:59
```

The baseline chart shows the largest entry concentration near the beginning of the trading window.

First determine whether expectancy varies by broad hourly segment.

Do not optimize individual minutes before establishing whether a meaningful time-of-day relationship exists.

For each segment measure:

```text
Trades

Win Rate

Net Profit

Profit Factor

Expected Payoff

Average Winner

Average Loser

MFE

MAE
```

---

# 24. RQ04 — Range Size

Define:

```text
Range Size
=
Range High - Range Low
```

First collect the daily range-size distribution.

Do not immediately choose a fixed threshold because it creates the best historical result.

Initial research may classify observations into:

```text
Small Range

Medium Range

Large Range
```

using a predefined statistical method.

A normalized measure may also be investigated:

```text
Range Size
──────────
ATR
```

The purpose is to determine whether breakout behavior changes systematically with the preceding range width.

---

# 25. RQ05 — Breakout Strength

Baseline:

```text
Breakout Buffer
=
0
```

Therefore the baseline does not require additional displacement beyond the range boundary.

Research question:

```text
Does requiring stronger displacement
beyond the range improve
breakout quality?
```

Possible measurement:

```text
Breakout Close
-
Range Boundary
```

Potential normalization:

```text
Breakout Displacement
─────────────────────
Range Size
```

Initial testing should use a small predefined set of values.

Do not begin with a large brute-force search.

---

# 26. RQ06 — Volatility Regime

The baseline balance curve changes materially through the test period.

This creates the hypothesis that:

```text
Strategy expectancy
may depend on volatility regime.
```

Possible volatility variables include:

```text
ATR

Range Size

Range Size / ATR

Previous-Day Range

Recent Realized Volatility
```

Use one clearly defined volatility measure during the initial experiment.

Avoid combining several volatility filters simultaneously.

---

# 27. RQ07 — Break Even

Baseline:

```text
Break Even:
ON

Trigger:
150

Offset:
0
```

First experiment:

```text
CONTROL

Break Even ON
```

versus:

```text
VARIANT

Break Even OFF
```

Keep all other variables fixed.

Only after Break Even itself demonstrates useful behavior should:

```text
Trigger

Offset
```

be optimized.

---

# 28. RQ08 — Trailing Stop

Baseline:

```text
Trailing:
ON

Start:
200

Distance:
100

Step:
10
```

First comparison:

```text
Trailing ON
```

versus:

```text
Trailing OFF
```

Keep:

```text
Entry Logic

Range

Direction

SL

TP

Break Even

Trade Window
```

unchanged.

Only after the trailing mechanism demonstrates a useful effect should its numerical parameters be optimized.

---

# 29. RQ09 — Server-Time Mapping

This is a critical structural issue for EA-074.

The strategy is named:

```text
New York Range Break
```

while the implementation uses:

```text
13:00 → 14:00
BROKER / SERVER TIME
```

These are not automatically equivalent.

The research must establish:

```text
Broker Server UTC Offset

New York UTC Offset

EST State

EDT State

Daylight Saving Time Transitions
```

The relationship should be documented as:

```text
Broker Server Time
        ↓
UTC
        ↓
America/New_York
        ↓
Actual New York Local Time
```

---

# 30. DST Requirement

New York does not use one constant UTC offset throughout the year.

Therefore a fixed server-time range may correspond to different New York local hours depending on:

```text
Broker DST Policy

US Daylight Saving Time

Broker Server Offset
```

Research must determine whether:

```text
13:00 server time
```

maps consistently to the intended New York market interval.

If not:

```text
Fixed Server Hours
```

and:

```text
Fixed New York Session
```

represent different strategy definitions.

---

# 31. Time-Mapping Change Rule

Do not silently correct Baseline #01 after discovering a timezone mismatch.

Baseline #01 must remain:

```text
13:00 → 14:00 SERVER TIME
```

If a different range is required to represent the intended New York period, create:

```text
NEW CONTROLLED EXPERIMENT
```

Example:

```text
EA074-RQ09-E001
```

This preserves the historical evidence chain.

---

# 32. RQ10 — Exit Architecture

The baseline combines:

```text
Fixed SL

Fixed TP

Break Even

Trailing Stop
```

Therefore the baseline alone cannot determine which exit component contributes positively or negatively.

Required controlled structure:

```text
A

Fixed SL / TP
```

```text
B

Fixed SL / TP
+
Break Even
```

```text
C

Fixed SL / TP
+
Trailing Stop
```

```text
D

Fixed SL / TP
+
Break Even
+
Trailing Stop
```

The objective is to separate:

```text
ENTRY QUALITY
```

from:

```text
EXIT MANAGEMENT
```

as much as practical.

---

# 33. Entry Research Before Exit Optimization

Baseline:

```text
Profit Factor:
0.99

Expected Payoff:
-$0.02
```

Positive entry expectancy has not been established.

Research priority is therefore:

```text
BREAKOUT STRUCTURE
        ↓
DIRECTION
        ↓
BREAKOUT TIME
        ↓
RANGE CHARACTERISTICS
        ↓
BREAKOUT QUALITY
        ↓
VOLATILITY
        ↓
EXIT STRUCTURE
        ↓
PARAMETER OPTIMIZATION
```

Do not aggressively optimize SL/TP merely because the baseline is close to break-even.

---

# 34. Optimization Authorization

Broad parameter optimization is blocked during the initial structural research stage.

Before optimization begins:

```text
Candidate Structure
must exist

Research Question
must be documented

Optimization Variables
must be authorized

Search Ranges
must be recorded

Fixed Variables
must be recorded

Optimization Objective
must be defined
```

---

# 35. Optimization Record

Every optimization should record:

```text
Optimization ID

EA Version

Parameter

Start

Step

Stop

Fixed Parameters

Optimization Criterion

Symbol

Timeframe

Test Period

Broker

History Quality
```

Example:

```text
Parameter:
Breakout Buffer

Start:
X

Step:
Y

Stop:
Z
```

If the search range changes after inspecting results:

```text
NEW OPTIMIZATION RUN
```

must be recorded.

Do not silently extend the search until a favorable result appears.

---

# 36. Optimization Objective

Do not select a final candidate solely using:

```text
Maximum Net Profit
```

Candidate evaluation should consider:

```text
Profit Factor

Expected Payoff

Maximum Drawdown

Trade Count

Average Winner

Average Loser

Loss Clustering

Parameter Stability

Balance / Equity Behavior
```

The objective is not:

```text
BEST PASS
```

but:

```text
ROBUST PARAMETER REGION
```

---

# 37. Parameter-Surface Rule

A weak parameter surface may look like:

```text
LOSS
LOSS
LOSS
LOSS
HUGE PROFIT
LOSS
LOSS
LOSS
```

This can indicate an unstable optimum.

A more desirable pattern is:

```text
PROFIT
PROFIT
PROFIT
PROFIT
PROFIT
PROFIT
```

across neighboring parameter combinations.

Therefore:

```text
Stable Neighborhood
>
Isolated Historical Maximum
```

for candidate selection.

---

# 38. Sample-Size Rule

The baseline contains:

```text
436 trades
```

A structural filter may reduce the trade count substantially.

Example:

```text
Baseline:
436 trades

Variant:
25 trades
```

Even if the variant reports:

```text
Higher Profit Factor
```

the smaller sample must be considered.

Evaluate:

```text
Performance
+
Trade Count
+
Stability
```

together.

A small number of favorable trades should not automatically be interpreted as stronger evidence.

---

# 39. In-Sample / Out-of-Sample Separation

Once a candidate structure exists, historical data should be divided conceptually into:

```text
Historical Data
│
├── IN-SAMPLE
│      ↓
│   Research
│   Development
│   Optimization
│
└── OUT-OF-SAMPLE
       ↓
    Independent Validation
```

Out-of-sample data should not repeatedly influence parameter selection.

Otherwise:

```text
OUT-OF-SAMPLE
```

effectively becomes:

```text
IN-SAMPLE
```

---

# 40. Out-of-Sample Rule

An out-of-sample test should answer:

```text
Does the candidate retain
acceptable behavior on data
that did not determine
its rules or parameters?
```

Do not:

```text
Run OOS
↓
Inspect Failure
↓
Tune Parameters to OOS
↓
Call Same Period OOS Again
```

Once used for tuning, that data is no longer independently unseen.

---

# 41. Walk-Forward Validation

A candidate surviving initial OOS testing should be evaluated using sequential windows.

Concept:

```text
WINDOW 1

Development
───────────
Validation
────


WINDOW 2

    Development
    ───────────
    Validation
    ────


WINDOW 3

        Development
        ───────────
        Validation
        ────
```

The objective is to evaluate whether strategy behavior remains usable as market conditions change.

---

# 42. Market-Regime Validation

Future testing should include materially different XAUUSD environments.

Examples:

```text
High Volatility

Low Volatility

Strong Trend

Range-Bound Market

Bullish Gold Regime

Bearish Gold Regime

Event-Heavy Period

Normal Period
```

The objective is not to require equal profitability in every regime.

The objective is to identify:

```text
WHERE

WHEN

WHY
```

strategy behavior changes.

---

# 43. Balance-Curve Regime Observation

Baseline #01 contains materially different performance phases:

```text
Initial Drawdown
        ↓
Recovery
        ↓
Strong Expansion
        ↓
Peak Above Initial Capital
        ↓
Extended Deterioration
        ↓
Negative Final Result
```

This suggests that:

```text
Aggregate Result
```

may hide:

```text
Different Market Regimes
```

However:

```text
Visual Balance Curve
≠
Proof of Regime Cause
```

Any regime explanation must be tested using measurable market variables.

---

# 44. Execution Sensitivity

Baseline average holding time:

```text
00:01:25
```

This is short.

Therefore execution sensitivity is a major validation requirement.

Future stress tests should evaluate:

```text
Higher Spread

Higher Slippage

Execution Delay

Different Tick Conditions

Different Stop Levels

Different Freeze Levels

Different XAUUSD Specifications

Different Broker
```

A small historical edge that disappears under minor realistic execution deterioration should not be classified as robust.

---

# 45. Spread Sensitivity

Baseline uses:

```text
Maximum Spread:
30 points
```

Future candidate testing should determine whether results depend heavily on this threshold.

Spread testing must not be used only to remove historically losing trades.

The purpose is to understand:

```text
Execution-Cost Sensitivity
```

---

# 46. Broker Sensitivity

Different brokers may have different:

```text
XAUUSD Symbol Names

Digits

Point Size

Tick Size

Contract Size

Spread Behavior

Stops Level

Freeze Level

Execution Conditions

Server Timezone
```

Therefore:

```text
Same EA Parameters
```

do not guarantee:

```text
Same Economic Strategy
```

across brokers.

Every important validation test should record the broker environment.

---

# 47. MFE / MAE Methodology

Baseline:

```text
Profit ↔ MFE = 0.96

Profit ↔ MAE = 0.73

MFE ↔ MAE = 0.6284
```

MFE and MAE should be used diagnostically when researching:

```text
SL Placement

TP Placement

Break Even

Trailing Stop

Exit Timing
```

Questions include:

```text
How far do winners typically move?

How much adverse movement occurs
before profitable continuation?

Does Break Even activate too early?

Does Trailing Stop truncate
larger winners?

Does fixed TP align with
the favorable-excursion distribution?
```

MFE/MAE statistics should not be converted directly into optimized rules without subsequent independent testing.

---

# 48. Holding-Time Methodology

Baseline:

```text
Minimum:
00:00:01

Average:
00:01:25

Maximum:
00:23:28
```

Future experiments should compare:

```text
Average Holding Time

Winner Holding Time

Loser Holding Time

Holding-Time Distribution
```

when relevant.

A structural modification that changes average holding time may also change:

```text
Execution Sensitivity

Spread Exposure

Slippage Exposure

Market-Regime Exposure
```

and must be interpreted accordingly.

---

# 49. Directional Analysis Rule

Baseline:

```text
SELL:
188 trades
52.13% won

BUY:
248 trades
47.98% won
```

Important future experiments should preserve separate BUY and SELL statistics where practical.

Combined statistics can hide directional asymmetry.

However:

```text
Higher Directional Win Rate
≠
Higher Directional Expectancy
```

Therefore complete trade economics must be evaluated.

---

# 50. Time-of-Day Analysis Rule

Baseline entries occur across approximately:

```text
14:00 → 19:59
```

with the largest concentration near 14:00.

Every time-of-day analysis should record:

```text
Trade Count

Win Rate

Net Profit

Profit Factor

Expected Payoff

Average Win

Average Loss

MFE

MAE
```

A lower-frequency time bucket should not be preferred solely because it contains a few large winners.

---

# 51. Anti-Overfitting Rules

EA-074 follows these rules:

### Rule 1

Do not optimize many unrelated parameters simultaneously during structural research.

### Rule 2

Do not select a configuration solely because it has the highest historical Net Profit.

### Rule 3

Do not delete failed experiments.

### Rule 4

Do not repeatedly tune against out-of-sample data.

### Rule 5

Do not change the historical period simply because another period gives a better result.

### Rule 6

Do not treat one profitable month as proof of robustness.

### Rule 7

Do not treat high win rate as proof of positive expectancy.

### Rule 8

Do not treat Profit Factor slightly above 1 as sufficient live validation.

### Rule 9

Do not treat an optimized backtest as forward validation.

### Rule 10

Do not silently alter server-time mapping.

### Rule 11

Document every material strategy change.

### Rule 12

Preserve Baseline #01 permanently.

---

# 52. Reproducibility Requirements

A test is considered reproducible only when another researcher can determine:

```text
EA

EA Version

Experiment ID

Source Code

Symbol

Timeframe

Historical Period

Broker

Server-Time Configuration

Initial Deposit

Leverage

History Quality

Input Parameters

Changed Variable

Fixed Variables

Result
```

The original MT5 report should be preserved whenever available.

---

# 53. Evidence Requirements

Each completed experiment should retain, when generated:

```text
MT5 HTML Strategy Tester Report

Balance Chart

Entry Distribution Chart

MFE / MAE Chart

Holding-Time Chart
```

The raw evidence is preferred over manually copied statistics.

---

# 54. Failed Experiment Preservation

Negative experiments remain valid research evidence.

Examples:

```text
Negative Net Profit

Profit Factor < 1

Higher Drawdown

Lower Expected Payoff

Unstable Parameter Region

Good In-Sample
but
Poor Out-of-Sample

Good Backtest
but
Poor Execution Stress Test
```

Do not remove these results because they make the repository appear less profitable.

They document which hypotheses were tested and rejected.

---

# 55. Version Control

Material strategy changes should create traceable versions.

Examples:

```text
EA-074 Baseline

EA-074 First-Breakout Variant

EA-074 Direction Variant

EA-074 Time Filter Variant

EA-074 Range Filter Variant

EA-074 Candidate

EA-074 OOS Candidate
```

Do not overwrite earlier evidence.

The research history should remain:

```text
Idea
↓
Experiment
↓
Evidence
↓
Decision
↓
Next Version
```

---

# 56. Validation Levels

EA-074 uses the following progression:

```text
LEVEL 0
Implementation Complete

        ↓

LEVEL 1
Baseline Tested

        ↓

LEVEL 2
Controlled Structural Research

        ↓

LEVEL 3
Candidate Structure

        ↓

LEVEL 4
Parameter Sensitivity / Optimization

        ↓

LEVEL 5
Out-of-Sample Validation

        ↓

LEVEL 6
Walk-Forward Validation

        ↓

LEVEL 7
Execution / Broker / Timezone Robustness

        ↓

LEVEL 8
Forward Testing

        ↓

LEVEL 9
Live Validation
```

Passing one level does not automatically imply passing the next.

---

# 57. Research Evidence Chain

The complete evidence chain is:

```text
Research Question
        │
        ▼
Research/README.md
        │
        ▼
Formal Strategy Rule
        │
        ▼
EAs/EA-074_New_York_Range_Break/
        │
        ▼
EA-074_New_York_Range_Break.mq5
        │
        ▼
MetaTrader 5 Strategy Tester
        │
        ▼
Backtest/EA-074_New_York_Range_Break/
        │
        ▼
Raw Report + Charts
        │
        ▼
Measured Result
        │
        ▼
PASS / FAIL / INCONCLUSIVE
        │
        ▼
Next Research Question
```

This chain must remain reconstructable.

---

# 58. Current EA-074 Status

```text
EA:
EA-074_New_York_Range_Break

Implementation:
COMPLETED

Source Documentation:
COMPLETED

Baseline Backtest:
COMPLETED

Baseline Analysis:
COMPLETED

Research Framework:
COMPLETED

Research Methodology:
COMPLETED

Baseline Result:
FAIL

Baseline Net Profit:
-$7.69

Baseline Profit Factor:
0.99

Baseline Expected Payoff:
-$0.02

Baseline Maximum Equity DD:
9.37%

Positive Expectancy:
NOT CONFIRMED

Controlled Research:
ACTIVE

Optimization:
BLOCKED PENDING STRUCTURAL RESEARCH

Out-of-Sample:
NOT TESTED

Walk-Forward:
NOT TESTED

Execution Robustness:
NOT TESTED

Timezone Robustness:
NOT TESTED

Forward Test:
NOT TESTED

Live Validation:
NOT TESTED
```

Current classification:

```text
RESEARCH STRATEGY
```

---

# 59. Next Authorized Experiment

The next authorized experiment is:

```text
EA074-RQ01-E001
```

Research question:

```text
Does restricting EA-074
to the first valid breakout
of each trading day improve
strategy behavior?
```

Control:

```text
EA-074 Baseline #01

Multiple breakout attempts
allowed
```

Variant:

```text
FIRST BREAKOUT ONLY

Maximum accepted breakout
entries per trading day = 1
```

---

# 60. RQ01 Fixed Variables

The following must remain unchanged:

```text
Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-03-31

Initial Deposit:
$1,000

Leverage:
1:500

Range:
13:00 → 14:00

Trade End:
20:00

Lot:
0.01

SL:
300

TP:
600

Breakout Lookback:
20

Breakout Buffer:
0

Maximum Spread:
30

Break Even:
ON

BE Trigger:
150

BE Offset:
0

Trailing:
ON

Trailing Start:
200

Trailing Distance:
100

Trailing Step:
10
```

Changed variable:

```text
Daily Breakout Entry Limit
```

and nothing else.

---

# 61. RQ01 Result Template

After `EA074-RQ01-E001` is completed:

| Metric | Baseline #01 | RQ01-E001 | Change |
|---|---:|---:|---:|
| Total Trades | 436 | TBD | TBD |
| Net Profit | -$7.69 | TBD | TBD |
| Profit Factor | 0.99 | TBD | TBD |
| Expected Payoff | -$0.02 | TBD | TBD |
| Win Rate | 49.77% | TBD | TBD |
| Average Winner | +$2.40 | TBD | TBD |
| Average Loser | -$2.41 | TBD | TBD |
| Max Balance DD | 9.27% | TBD | TBD |
| Max Equity DD | 9.37% | TBD | TBD |
| SELL Win Rate | 52.13% | TBD | TBD |
| BUY Win Rate | 47.98% | TBD | TBD |

Then record:

```text
RQ01 RESULT:

PASS
or
FAIL
or
INCONCLUSIVE
```

with a documented interpretation.

---

# 62. Next-Experiment Rule

Do not automatically proceed to parameter optimization after RQ01.

The sequence is:

```text
RQ01 Result
    ↓
Interpret Evidence
    ↓
Determine Next Structural Question
    ↓
Authorize Next Experiment
```

If RQ01 fails:

```text
FAIL
≠
STOP ALL RESEARCH
```

It means only that:

```text
First Breakout Only
```

did not demonstrate the intended improvement under the tested conditions.

The next structural hypothesis may still be investigated.

---

# 63. Methodology Principle

EA-074 follows one central rule:

> Every strategy change must have a documented reason, every reason must be tested through controlled evidence, and every conclusion must remain reproducible.

The development process is:

```text
HYPOTHESIS
    ↓
CONTROLLED CHANGE
    ↓
CODE
    ↓
BACKTEST
    ↓
EVIDENCE
    ↓
DECISION
    ↓
VALIDATION
```

The development process is not:

```text
OPTIMIZE EVERYTHING
    ↓
SELECT BEST RESULT
    ↓
DECLARE SUCCESS
```

---

# 64. Final Methodology State

At the current stage:

```text
EA-074
New York Range Break

Baseline:
LOCKED

Baseline Result:
FAIL

Positive Expectancy:
NOT CONFIRMED

Research:
ACTIVE

Current Experiment:
EA074-RQ01-E001

Current Target:
FIRST BREAKOUT ONLY

Broad Optimization:
NOT AUTHORIZED

Out-of-Sample:
NOT STARTED

Walk-Forward:
NOT STARTED

Execution Validation:
NOT STARTED

Timezone Validation:
NOT COMPLETED

Forward Test:
NOT STARTED

Live Validation:
NOT VALIDATED
```

EA-074 remains a:

```text
QUANTITATIVE RESEARCH STRATEGY
```

until the complete evidence chain supports a stronger classification.
