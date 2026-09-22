# EA-073 — London Range Break Research Methodology

## 1. Purpose

This document defines the research, testing, optimization, and validation methodology for:

```text
EA-073_London_Range_Break
```

The methodology exists to ensure that every strategy modification can be traced through:

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

The objective is to determine whether the London Range Break hypothesis contains a reproducible and sufficiently robust trading edge.

---

# 2. Strategy Under Research

EA-073 is an intraday range-breakout strategy.

Baseline structure:

```text
London Range Formation
08:00 → 09:00
        ↓
Determine Range High / Low
        ↓
Range Complete
        ↓
Monitor completed M1 candles
        ↓
Break above Range High
        │
        ├── BUY
        │
Break below Range Low
        │
        └── SELL
        ↓
Trading ends at 13:00
```

All configured session hours use:

```text
BROKER / SERVER TIME
```

They must not automatically be interpreted as London local time.

---

# 3. Source of Truth

The implemented strategy is defined by:

```text
/EAs/EA-073_London_Range_Break/
EA-073_London_Range_Break.mq5
```

The source code is the authoritative definition of executable behavior.

Documentation explains the strategy but does not override the implementation.

If:

```text
Documentation
≠
Source Code
```

the implementation must be inspected and the documentation corrected.

Historical performance evidence is defined by the original MetaTrader 5 Strategy Tester output stored under:

```text
/Backtest/EA-073_London_Range_Break/
```

Research interpretation is maintained under:

```text
/Research/
```

---

# 4. Evidence Structure

EA-073 uses four evidence layers:

```text
Research Hypothesis
        ↓
/Research/

Implementation
        ↓
/EAs/EA-073_London_Range_Break/

Historical Evidence
        ↓
/Backtest/EA-073_London_Range_Break/

Research Procedure
        ↓
/docs/methodology.md
```

These layers must remain separate.

A research hypothesis is not evidence.

Source code is not proof of profitability.

A profitable backtest is not proof of future profitability.

---

# 5. Baseline Definition

The permanent control experiment is:

```text
EA-073 Baseline #01
```

Baseline configuration:

```text
Symbol                = XAUUSD.PRO
Timeframe             = M1

Lot Size              = 0.01

Stop Loss             = 300 points
Take Profit           = 600 points

Magic Number          = 123073
Slippage              = 10
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

Range Start           = 08:00
Range End             = 09:00
Trade End             = 13:00
```

The baseline must not be overwritten.

Future experiments are compared against this reference.

---

# 6. Baseline Test Environment

Baseline #01 was tested using:

```text
Expert:
EA-073_London_Range_Break

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02
→
2026-03-31

Initial Deposit:
$1,000.00

Leverage:
1:500

History Quality:
100% real ticks

Broker:
ACCM Intl Limited
```

---

# 7. Baseline Result

The permanent baseline result is:

```text
Total Trades          = 276

Winning Trades        = 119
Losing Trades         = 157

Win Rate              = 43.12%

Net Profit            = -$143.88

Gross Profit          = +$265.62
Gross Loss            = -$409.50

Profit Factor         = 0.65
Expected Payoff       = -$0.52
Recovery Factor       = -0.90
Sharpe Ratio          = -5.00

Maximum Balance DD    = 15.71%
Maximum Equity DD     = 15.93%
```

Directional result:

```text
SELL

Trades   = 152
Win Rate = 47.37%


BUY

Trades   = 124
Win Rate = 37.90%
```

Trade outcome:

```text
Average Winner = +$2.23
Average Loser  = -$2.61

Largest Winner = +$7.12
Largest Loser  = -$4.52
```

Holding time:

```text
Minimum = 00:00:05
Average = 00:02:27
Maximum = 00:23:39
```

MFE / MAE:

```text
Profit ↔ MFE = 0.96
Profit ↔ MAE = 0.80
MFE ↔ MAE    = 0.6962
```

Baseline classification:

```text
FAIL
```

Positive expectancy was not demonstrated.

---

# 8. Baseline Preservation Rule

Baseline #01 is immutable research evidence.

Do not replace it after finding a better configuration.

The repository must preserve:

```text
Original source version

Original parameters

Original test period

Original MT5 HTML report

Original charts

Original performance metrics

Original FAIL classification
```

Future improvements must be stored as new experiments.

---

# 9. Research Philosophy

EA-073 follows:

```text
STRUCTURE FIRST
PARAMETERS SECOND
```

The initial baseline contains several interacting components:

```text
Session definition

Repeated breakout attempts

BUY / SELL behavior

Breakout timing

Range size

Breakout displacement

Break Even

Trailing Stop

SL / TP
```

Immediately optimizing all parameters would make it difficult to determine why performance changes.

Therefore research proceeds through controlled experiments.

---

# 10. Controlled Experiment Rule

Each structural experiment should answer:

```text
ONE PRIMARY RESEARCH QUESTION
```

Preferred structure:

```text
Baseline
    ↓
Observation
    ↓
Hypothesis
    ↓
Change one defined component
    ↓
Backtest
    ↓
Compare
    ↓
PASS / FAIL / INCONCLUSIVE
```

Avoid:

```text
Change Range
+
Change Direction
+
Change Buffer
+
Change SL
+
Change TP
+
Change Trailing
```

in one experiment.

---

# 11. Experiment Identification

Use:

```text
EA073-RQXX-EXXX
```

Example:

```text
EA073-RQ01-E001
```

means:

```text
EA073
=
EA-073 London Range Break

RQ01
=
Research Question 01

E001
=
Experiment 001
```

Every saved experiment should have a unique identifier.

---

# 12. Required Experiment Record

Every controlled experiment must document:

```text
Experiment ID

Date

EA Version

Research Question

Hypothesis

Control Configuration

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

Maximum Balance DD

Maximum Equity DD

Average Winner

Average Loser

Maximum Consecutive Wins

Maximum Consecutive Losses

BUY Result

SELL Result

Result Classification

Interpretation

Next Action
```

The original Strategy Tester evidence should be retained with the experiment.

---

# 13. Result Classification

Controlled experiments use:

```text
PASS

FAIL

INCONCLUSIVE
```

These classifications apply to the specific research hypothesis.

They do not mean:

```text
LIVE READY
```

---

# 14. PASS Definition

A structural experiment should not PASS merely because:

```text
Net Profit increased
```

A PASS requires evidence that the tested structural change improves the characteristics relevant to its research hypothesis.

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

Balance Curve
```

A structural improvement should not depend on one isolated statistic.

---

# 15. FAIL Definition

An experiment can be classified:

```text
FAIL
```

when the tested hypothesis does not produce the intended improvement or materially worsens strategy quality.

Examples:

```text
Profit Factor deteriorates

Expected Payoff deteriorates

Drawdown materially increases

Improvement disappears after
accounting for reduced sample size

Balance behavior deteriorates

Hypothesis is contradicted
by the experiment
```

Failed experiments must remain stored.

---

# 16. INCONCLUSIVE Definition

Use:

```text
INCONCLUSIVE
```

when:

```text
Trade count becomes too small

Metrics conflict materially

Improvement is marginal

Test period is insufficient

Execution/data issue exists

Result cannot isolate the hypothesis
```

Do not force every experiment into PASS or FAIL.

---

# 17. Minimum Comparison Set

Every experiment must compare at least:

| Metric | Purpose |
|---|---|
| Total Trades | Sample-size change |
| Net Profit | Absolute result |
| Gross Profit | Positive outcome magnitude |
| Gross Loss | Negative outcome magnitude |
| Profit Factor | Profit/loss efficiency |
| Expected Payoff | Average historical expectancy |
| Win Rate | Outcome frequency |
| Average Winner | Realized reward |
| Average Loser | Realized loss |
| Max Balance DD | Balance risk |
| Max Equity DD | Equity risk |
| Consecutive Losses | Loss clustering |

Where relevant also compare:

```text
BUY

SELL

Hour

Weekday

Range Size

MFE

MAE

Holding Time
```

---

# 18. Research Question Order

The current planned sequence is:

```text
EA073-RQ01
First Breakout Only
        ↓
EA073-RQ02
BUY vs SELL
        ↓
EA073-RQ03
Breakout Time
        ↓
EA073-RQ04
London Range Size
        ↓
EA073-RQ05
Breakout Buffer
        ↓
EA073-RQ06
Breakout Strength
        ↓
EA073-RQ07
Retest Confirmation
        ↓
EA073-RQ08
Volatility Regime
        ↓
EA073-RQ09
Break Even
        ↓
EA073-RQ10
Trailing Stop
        ↓
EA073-RQ11
Exit Architecture
        ↓
EA073-RQ12
Timeframe
        ↓
EA073-RQ13
Server-Time Mapping
```

This sequence can change only when earlier evidence creates a clear reason to change research priority.

The change must be documented.

---

# 19. RQ01 Methodology — First Breakout Only

The first authorized experiment is:

```text
EA073-RQ01-E001
```

Research question:

> Does restricting EA-073 to the first valid breakout of each trading day improve strategy behavior compared with allowing repeated breakout attempts?

Control:

```text
EA-073 Baseline #01
```

Experimental change:

```text
Maximum accepted breakout entries
per trading day
=
1
```

After the first accepted breakout:

```text
Block all additional breakout entries
until the next trading day
```

Keep unchanged:

```text
Symbol

Timeframe

Test period

Range Start

Range End

Trade End

Breakout Buffer

SL

TP

Lot

Break Even

Trailing Stop

Spread Filter
```

This isolates:

```text
Repeated Entry Behavior
```

from all other strategy components.

---

# 20. RQ02 Methodology — Direction

Baseline evidence shows:

```text
SELL Win Rate = 47.37%

BUY Win Rate  = 37.90%
```

This difference is an observation.

It is not sufficient evidence to disable BUY.

Required controlled variants:

```text
CONTROL
BUY + SELL

VARIANT A
BUY only

VARIANT B
SELL only
```

Compare complete expectancy rather than win rate alone.

---

# 21. RQ03 Methodology — Breakout Time

Baseline trading window:

```text
09:00 → 13:00
```

Initial analytical buckets:

```text
09:00–09:59

10:00–10:59

11:00–11:59

12:00–12:59
```

First analyze historical behavior by bucket.

Do not optimize individual minutes before establishing whether a broader time effect exists.

---

# 22. RQ04 Methodology — Range Size

Define:

```text
London Range Size
=
Range High - Range Low
```

Do not arbitrarily choose a historically profitable fixed threshold initially.

First inspect the observed range-size distribution.

Then create pre-defined groups such as:

```text
Small

Medium

Large
```

Compare strategy behavior across the groups.

If range size demonstrates a stable relationship with expectancy, a subsequent threshold experiment may be authorized.

---

# 23. RQ05 Methodology — Breakout Buffer

Baseline:

```text
Breakout Buffer = 0
```

RQ05 tests whether additional displacement beyond the range boundary changes breakout quality.

Use a small predefined parameter grid first.

Avoid broad brute-force optimization.

The objective is:

```text
Detect relationship
```

before:

```text
Find optimum
```

---

# 24. RQ06 Methodology — Breakout Strength

Define breakout strength using a normalized measure.

Example:

```text
Breakout Displacement
─────────────────────
London Range Size
```

This allows days with different range sizes to be compared more consistently.

The experiment should determine whether stronger closes beyond the range have different continuation behavior.

---

# 25. RQ07 Methodology — Retest

Baseline:

```text
Break
↓
Completed-candle confirmation
↓
Entry
```

Retest experiment:

```text
Break
↓
Retest boundary
↓
Boundary holds
↓
Entry
```

Retest logic is a structural change.

Do not simultaneously alter:

```text
SL

TP

Session

Direction

Trailing
```

when first testing it.

---

# 26. RQ08 Methodology — Volatility

Use one volatility definition initially.

Possible research variable:

```text
ATR
```

or:

```text
Normalized London Range Size
```

Do not combine multiple volatility indicators during the first test.

First establish whether volatility regime itself changes strategy behavior.

---

# 27. RQ09 Methodology — Break Even

Baseline:

```text
Break Even = ON

Trigger = 150

Offset = 0
```

First experiment:

```text
BE ON
vs.
BE OFF
```

Do not optimize the trigger immediately.

If Break Even demonstrates a beneficial effect, parameter sensitivity can then be investigated.

---

# 28. RQ10 Methodology — Trailing Stop

Baseline:

```text
Trailing = ON

Start    = 200
Distance = 100
Step     = 10
```

First comparison:

```text
Trailing ON
vs.
Trailing OFF
```

Keep the entry structure fixed.

Only after demonstrating a useful effect should:

```text
Start

Distance

Step
```

be optimized.

---

# 29. RQ11 Methodology — Exit Architecture

After Break Even and Trailing have been individually evaluated, compare:

```text
A
Fixed SL / TP

B
Fixed SL / TP
+
Break Even

C
Fixed SL / TP
+
Trailing

D
Fixed SL / TP
+
Break Even
+
Trailing
```

This experiment separates:

```text
Entry Edge
```

from:

```text
Exit Management
```

as much as practical.

---

# 30. RQ12 Methodology — Timeframe

Baseline:

```text
M1
```

Alternative research candidates may include:

```text
M5

M15
```

A timeframe change is a structural strategy change.

Do not interpret an M5 or M15 result as a direct continuation of the M1 baseline without identifying it as a separate experiment.

---

# 31. RQ13 Methodology — Server-Time Mapping

EA-073 currently uses:

```text
08:00 → 09:00
```

in broker/server time.

This does not automatically equal:

```text
08:00 → 09:00
London local time
```

Before interpreting the range as a specific real-world London market interval, document:

```text
Broker server UTC offset

DST behavior

London GMT/BST state

Actual UTC range represented
by the EA configuration
```

Any session-time correction must be stored as a separate experiment.

Do not rewrite Baseline #01.

---

# 32. Entry Research Before Exit Optimization

Baseline:

```text
Profit Factor = 0.65

Expected Payoff = -$0.52
```

The strategy therefore does not currently demonstrate a strong entry edge.

Research priority is:

```text
ENTRY STRUCTURE
        ↓
SESSION STRUCTURE
        ↓
BREAKOUT QUALITY
        ↓
EXIT STRUCTURE
        ↓
PARAMETER OPTIMIZATION
```

Optimizing SL/TP aggressively before understanding entry quality risks fitting exits to weak historical signals.

---

# 33. Optimization Authorization

Broad optimization is blocked during the initial structural research stage.

Optimization becomes appropriate only after evidence identifies a candidate structure worth refining.

Before optimization:

```text
Research Question
must be defined

Candidate structure
must be documented

Optimization variables
must be explicitly authorized

Optimization ranges
must be recorded
```

---

# 34. Optimization Record

For every optimized parameter record:

```text
Parameter

Start

Step

Stop

Optimization criterion

Symbol

Timeframe

Period

EA version

Broker

Fixed parameters
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

Do not silently change the optimization range after inspecting the result.

A changed search range is a new optimization experiment.

---

# 35. Parameter-Surface Rule

Do not select a candidate solely because it is:

```text
BEST SINGLE RESULT
```

Preferred evidence is a stable region.

Weak pattern:

```text
FAIL
FAIL
FAIL
HUGE PROFIT
FAIL
FAIL
FAIL
```

More robust pattern:

```text
PASS
PASS
PASS
PASS
PASS
PASS
```

across neighboring parameter values.

An isolated optimum should be treated as a potential overfitting warning.

---

# 36. In-Sample / Out-of-Sample Separation

After a candidate structure has been established, separate:

```text
IN-SAMPLE
```

from:

```text
OUT-OF-SAMPLE
```

Concept:

```text
Historical Data
│
├── Development Data
│      ↓
│   Research
│   Optimization
│
└── Unseen Validation Data
       ↓
    Validation
```

Out-of-sample data must not repeatedly influence parameter selection.

If it does, it is no longer genuinely out-of-sample.

---

# 37. Walk-Forward Validation

A candidate surviving out-of-sample testing should be evaluated across sequential windows.

Concept:

```text
Window 1

Development
───────────
Validation
────


Window 2

    Development
    ───────────
    Validation
    ────


Window 3

        Development
        ───────────
        Validation
        ────
```

The purpose is to test whether strategy behavior remains usable as market conditions change.

---

# 38. Market-Regime Validation

Future validation should include materially different XAUUSD environments.

Examples:

```text
High volatility

Low volatility

Trending market

Range-bound market

Strong bullish period

Strong bearish period

Event-heavy period

Normal market period
```

The purpose is not to require identical profitability in every environment.

The objective is to understand where the strategy's behavior changes.

---

# 39. Execution Sensitivity

EA-073's baseline average holding time is:

```text
00:02:27
```

Therefore execution assumptions are important.

Future robustness tests should investigate sensitivity to:

```text
Spread

Slippage

Execution delay

Tick quality

Stops level

Freeze level

Broker specifications
```

A strategy whose apparent edge disappears after small realistic execution deterioration requires additional investigation.

---

# 40. Broker Sensitivity

Different brokers may use different:

```text
XAUUSD symbol names

Tick sizes

Digits

Contract sizes

Spread behavior

Server timezone

Session structure
```

Therefore cross-broker results must not be assumed identical.

When reproducing EA-073, document the broker environment.

---

# 41. MFE / MAE Methodology

Baseline:

```text
Profit ↔ MFE = 0.96

Profit ↔ MAE = 0.80

MFE ↔ MAE = 0.6962
```

Use MFE / MAE diagnostically when studying:

```text
SL placement

TP placement

Break Even

Trailing Stop

Exit timing
```

Do not use the correlations alone as evidence that a predictive signal exists.

---

# 42. Holding-Time Methodology

Baseline:

```text
Minimum = 00:00:05

Average = 00:02:27

Maximum = 00:23:39
```

Future experiments should compare whether structural modifications materially change:

```text
Average Holding Time

Winner Holding Time

Loser Holding Time

Execution Exposure
```

This is especially relevant if filters substantially reduce trade frequency or alter the character of the strategy.

---

# 43. Directional Analysis

Because baseline directional win rates differ:

```text
SELL = 47.37%

BUY  = 37.90%
```

all important future experiments should retain separate BUY and SELL statistics where practical.

A combined result can hide directional asymmetry.

---

# 44. Sample-Size Warning

A configuration can appear improved simply because it eliminates most trades.

Example:

```text
Baseline:
276 trades

Variant:
12 trades
```

A high Profit Factor from a very small number of trades is not automatically stronger evidence.

Always evaluate:

```text
Performance
+
Sample Size
+
Stability
```

together.

---

# 45. Anti-Overfitting Rules

EA-073 research follows these rules:

### Rule 1

Do not optimize many unrelated parameters simultaneously during structural research.

### Rule 2

Do not select a configuration solely because it has maximum historical profit.

### Rule 3

Do not delete failed experiments.

### Rule 4

Do not repeatedly inspect out-of-sample data and then modify the strategy against it.

### Rule 5

Do not change the test period simply because another period gives a better result.

### Rule 6

Do not treat one profitable month as proof of robustness.

### Rule 7

Do not treat a high win rate as proof of positive expectancy.

### Rule 8

Do not treat a profitable optimization result as live validation.

### Rule 9

Document every material strategy change.

### Rule 10

Preserve the original baseline permanently.

---

# 46. Reproducibility Requirements

A test is considered reproducible only when another researcher can determine:

```text
EA

EA version

Experiment ID

Source code

Symbol

Timeframe

Historical period

Broker

Initial deposit

Leverage

History quality

Input parameters

Changed variable

Fixed variables

Result
```

The original MT5 HTML report should be preserved whenever available.

---

# 47. Evidence Requirements

Each completed experiment should retain, when generated:

```text
MT5 HTML Strategy Tester report

Balance chart

Entry distribution chart

MFE / MAE chart

Holding-time chart
```

The evidence should be stored under the corresponding EA-073 backtest structure.

Do not preserve only manually copied summary numbers when the raw Strategy Tester report is available.

---

# 48. Research Decision Chain

Each RQ should produce:

```text
Research Question
        ↓
Experiment
        ↓
Evidence
        ↓
PASS / FAIL / INCONCLUSIVE
        ↓
Decision
        ↓
Next Authorized Experiment
```

The next experiment should be based on evidence from the previous stage rather than arbitrary parameter searching.

---

# 49. Validation Levels

EA-073 uses the following progression:

```text
LEVEL 0
Implementation Complete

        ↓

LEVEL 1
Baseline Tested

        ↓

LEVEL 2
Controlled Research

        ↓

LEVEL 3
Candidate Structure

        ↓

LEVEL 4
Parameter Sensitivity

        ↓

LEVEL 5
Out-of-Sample

        ↓

LEVEL 6
Walk-Forward

        ↓

LEVEL 7
Robustness / Execution

        ↓

LEVEL 8
Forward Test

        ↓

LEVEL 9
Live Validation
```

Passing one level does not automatically imply passing the next.

---

# 50. Current EA-073 Status

```text
EA:
EA-073_London_Range_Break

Implementation:
COMPLETE

Baseline:
COMPLETE

Baseline Result:
FAIL

Baseline Net Profit:
-$143.88

Baseline Profit Factor:
0.65

Baseline Expected Payoff:
-$0.52

Baseline Maximum Equity DD:
15.93%

Controlled Research:
ACTIVE

Current Research Question:
EA073-RQ01

Optimization:
BLOCKED PENDING STRUCTURAL RESEARCH

Out-of-Sample:
NOT TESTED

Walk-Forward:
NOT TESTED

Robustness:
NOT TESTED

Forward Test:
NOT TESTED

Live Validation:
NOT TESTED
```

---

# 51. Next Authorized Experiment

The next authorized experiment is:

```text
EA073-RQ01-E001
```

### Research Question

```text
Does limiting EA-073 to the first
valid breakout of each trading day
improve strategy behavior?
```

### Control

```text
EA-073 Baseline #01

Multiple valid breakout attempts
allowed during the trading window
```

### Experimental Variant

```text
FIRST BREAKOUT ONLY

Maximum accepted breakout
entries per trading day = 1
```

### Fixed Variables

```text
Symbol             = XAUUSD.PRO

Timeframe          = M1

Period             = 2026-01-02
                     → 2026-03-31

Range              = 08:00 → 09:00

Trade End          = 13:00

Lot                = 0.01

SL                 = 300

TP                 = 600

Breakout Lookback  = 20

Breakout Buffer    = 0

Break Even         = ON

BE Trigger         = 150

BE Offset          = 0

Trailing           = ON

Trailing Start     = 200

Trailing Distance  = 100

Trailing Step      = 10

Maximum Spread     = 30
```

### Changed Variable

Only:

```text
Daily breakout-entry limit
```

may change.

---

# 52. RQ01 Comparison Table

When `EA073-RQ01-E001` is completed, compare it directly against Baseline #01:

| Metric | Baseline #01 | RQ01-E001 | Change |
|---|---:|---:|---:|
| Total Trades | 276 | TBD | TBD |
| Net Profit | -$143.88 | TBD | TBD |
| Profit Factor | 0.65 | TBD | TBD |
| Expected Payoff | -$0.52 | TBD | TBD |
| Win Rate | 43.12% | TBD | TBD |
| Average Winner | +$2.23 | TBD | TBD |
| Average Loser | -$2.61 | TBD | TBD |
| Max Balance DD | 15.71% | TBD | TBD |
| Max Equity DD | 15.93% | TBD | TBD |
| SELL Win Rate | 47.37% | TBD | TBD |
| BUY Win Rate | 37.90% | TBD | TBD |

After the evidence is available, classify:

```text
PASS

FAIL

or

INCONCLUSIVE
```

and document the reason.

---

# 53. Methodology Principle

EA-073 follows one central rule:

> Every strategy change must have a reason, every reason must be tested, and every conclusion must remain traceable to evidence.

The complete research chain is:

```text
Hypothesis
→
Controlled Change
→
Code
→
Backtest
→
Evidence
→
Decision
→
Validation
```

The objective is not to manufacture a profitable historical backtest.

The objective is to determine whether EA-073 contains a trading effect that survives controlled testing and subsequent validation.
