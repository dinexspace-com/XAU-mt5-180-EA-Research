# EA-073 — London Range Break Research

## Research Objective

EA-073 investigates whether price expansion beyond a range established during the configured London-session window can provide a reproducible short-term trading edge on XAUUSD.

The baseline implementation uses:

```text
Instrument:
XAUUSD.PRO

Timeframe:
M1

Range Formation:
08:00 → 09:00 server time

Trading Window:
09:00 → 13:00 server time

Breakout:
Completed M1 candle crossing
above Range High
or below Range Low
```

The purpose of the research stage is not to optimize the baseline immediately.

The purpose is to identify:

```text
WHY the baseline failed

WHICH structural components
contributed to the failure

WHETHER a measurable edge exists
inside a narrower subset
of the strategy
```

Only after those questions have been investigated should broad parameter optimization be considered.

---

# Baseline Reference

## EA-073 Baseline #01

The baseline test used:

```text
EA:
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
$1,000

Leverage:
1:500

History:
100% real ticks
```

Strategy configuration:

```text
Lot Size             = 0.01

Stop Loss            = 300 points
Take Profit          = 600 points

Breakout Lookback     = 20
Breakout Buffer       = 0

Break Even            = ON
Break Even Trigger    = 150
Break Even Offset     = 0

Trailing Stop         = ON
Trailing Start        = 200
Trailing Distance     = 100
Trailing Step         = 10

Range Start           = 08:00
Range End             = 09:00
Trade End             = 13:00
```

---

# Baseline Result

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

Max Balance DD        = 15.71%
Max Equity DD         = 15.93%
```

Directional results:

```text
SELL:
152 trades
47.37% won

BUY:
124 trades
37.90% won
```

Holding time:

```text
Minimum:
00:00:05

Average:
00:02:27

Maximum:
00:23:39
```

MFE / MAE:

```text
Profit vs MFE:
0.96

Profit vs MAE:
0.80

MFE vs MAE:
0.6962
```

---

# Baseline Classification

```text
BASELINE #01
=
FAIL
```

The tested configuration did not demonstrate positive expectancy.

Evidence:

```text
Net Profit < 0

Profit Factor < 1

Expected Payoff < 0

Recovery Factor < 0

Losing Trades > Winning Trades

Balance trajectory declined
during the test period
```

Therefore:

```text
EA-073 Baseline #01
is NOT a validated strategy.
```

---

# Research Interpretation

The baseline failure does not establish that:

```text
London Range Breakout
=
No Trading Edge
```

It establishes only that:

```text
THIS IMPLEMENTATION
+
THIS SESSION
+
THIS ENTRY BEHAVIOR
+
THIS EXIT MANAGEMENT
+
THIS TEST PERIOD
```

did not demonstrate positive expectancy.

The correct research question is therefore not:

```text
"How do we optimize EA-073?"
```

The correct question is:

```text
"Which component of EA-073
is responsible for the observed behavior,
and does a narrower version of the hypothesis
contain a reproducible edge?"
```

---

# Key Baseline Findings

## Finding 01 — Repeated Breakout Attempts

The baseline can execute multiple breakout trades during the same trading day.

The sequence can be:

```text
Range Completed
      ↓
Breakout
      ↓
Trade #1
      ↓
Trade closes
      ↓
Price returns across range boundary
      ↓
Another valid crossing
      ↓
Trade #2
      ↓
Repeat
```

Therefore:

```text
276 trades
```

does not represent:

```text
276 independent trading days
```

and the baseline is not a simple:

```text
One Range
→
One Breakout
→
One Trade
```

system.

Repeated breakout attempts are therefore the first structural behavior that should be isolated.

---

# Research Question 01

## EA073-RQ01 — First Breakout Only

### Question

Does restricting EA-073 to the first valid breakout attempt of each trading day improve performance compared with allowing repeated breakout entries?

### Hypothesis

Repeated crossings of the London Range boundary may create additional low-quality entries after the initial market expansion has already occurred.

The first valid breakout may contain more information than subsequent crossings.

This is a hypothesis only.

It must be tested.

---

## Control

Use Baseline #01 unchanged:

```text
Range:
08:00 → 09:00

Trade Window:
09:00 → 13:00

SL:
300

TP:
600

Breakout Buffer:
0

Break Even:
ON

Trailing Stop:
ON
```

Baseline allows:

```text
Multiple breakout attempts
per trading day
```

---

## Experimental Variant

Change only:

```text
Maximum breakout entries per day
```

from:

```text
Unlimited repeated valid crossings
```

to:

```text
First valid breakout only
```

After the first BUY or SELL breakout signal is accepted:

```text
No additional breakout entry
for the remainder of that trading day
```

Everything else remains unchanged.

---

## Comparison Metrics

Compare:

```text
Total Trades

Net Profit

Profit Factor

Expected Payoff

Win Rate

Gross Profit

Gross Loss

Maximum Balance DD

Maximum Equity DD

Average Profit Trade

Average Loss Trade

Consecutive Losses

BUY Performance

SELL Performance
```

---

## PASS Condition

RQ01 is considered promising if the First-Breakout-Only variant produces a meaningful improvement in strategy quality without introducing unacceptable deterioration elsewhere.

Particular attention should be paid to:

```text
Profit Factor

Expected Payoff

Drawdown

Trade Count

Directional behavior
```

A single improved metric is not sufficient evidence of a robust edge.

---

# Research Question 02

## EA073-RQ02 — BUY vs SELL

Baseline:

```text
SELL
152 trades
47.37% won

BUY
124 trades
37.90% won
```

Difference:

```text
SELL advantage
=
9.47 percentage points
in historical win rate
```

This creates an important directional research question.

---

## Question

Do BUY and SELL London Range breakouts exhibit materially different expectancy?

---

## Required Experiments

Run separately:

```text
Variant A:
BUY only

Variant B:
SELL only

Control:
BUY + SELL
```

Do not change:

```text
Range

Trade Window

SL

TP

Breakout Buffer

Break Even

Trailing Stop
```

during this experiment.

---

## Important

The baseline SELL win rate being higher than the BUY win rate does not prove:

```text
SELL
=
Profitable
```

Win rate alone is insufficient.

Compare:

```text
Net Profit
Profit Factor
Expected Payoff
Drawdown
Average Winner
Average Loser
Trade Count
```

for both directions.

---

# Research Question 03

## EA073-RQ03 — Breakout Time

The baseline permits entries from:

```text
09:00
→
13:00
```

The entry-distribution evidence shows that trades occur across several hours inside this window.

The research question is:

```text
Does breakout quality depend
on how soon the breakout occurs
after the London Range is completed?
```

---

## Candidate Time Buckets

Analyze entries by:

```text
09:00–09:59

10:00–10:59

11:00–11:59

12:00–12:59
```

Do not immediately optimize individual minutes.

First determine whether a broad time-of-day effect exists.

---

## Metrics

For each time bucket calculate:

```text
Trades

Win Rate

Net Profit

Profit Factor

Expected Payoff

Average Winner

Average Loser

Maximum Adverse Excursion

Maximum Favorable Excursion
```

---

# Research Question 04

## EA073-RQ04 — London Range Size

Not all 08:00–09:00 ranges have the same size.

Define:

```text
Range Size
=
Range High - Range Low
```

The hypothesis is that breakout behavior may depend on the size of the preceding range.

---

## Question

Do unusually narrow or unusually wide London ranges produce different breakout expectancy?

---

## Analysis

Record the range size for every trading day.

Then classify days using the observed distribution.

Example research structure:

```text
Small Range

Medium Range

Large Range
```

The thresholds should be derived from the observed sample distribution rather than selected solely because they produce favorable historical results.

---

## Compare

```text
Trade Count

Win Rate

Net Profit

Profit Factor

Expected Payoff

MFE

MAE
```

for each range-size group.

---

# Research Question 05

## EA073-RQ05 — Breakout Displacement

Baseline:

```text
Breakout Buffer = 0
```

Therefore any completed M1 candle crossing beyond the range boundary can trigger the breakout condition.

The research question is whether requiring additional displacement beyond the range reduces false breakouts.

---

## Concept

Instead of:

```text
Close > Range High
```

evaluate:

```text
Close > Range High + Buffer
```

and for SELL:

```text
Close < Range Low - Buffer
```

---

## Research Principle

Do not immediately search hundreds of buffer values.

First test a small, pre-defined experimental grid.

The purpose is to determine whether breakout displacement has a meaningful effect.

Only if a stable relationship appears should a narrower optimization follow.

---

# Research Question 06

## EA073-RQ06 — Breakout Strength

A candle closing barely outside the London Range and a candle closing strongly outside the range are currently treated as the same event.

They may not contain the same information.

Define:

```text
Breakout Displacement
=
Distance between breakout close
and range boundary
```

Possible normalization:

```text
Breakout Displacement
/
London Range Size
```

This allows breakout strength to be compared across days with different range widths.

---

## Question

Does stronger breakout displacement produce better subsequent trade expectancy?

---

# Research Question 07

## EA073-RQ07 — Retest Confirmation

Baseline behavior:

```text
Range Break
      ↓
Completed Candle Confirmation
      ↓
Entry
```

Alternative hypothesis:

```text
Range Break
      ↓
Price Retests Boundary
      ↓
Boundary Holds
      ↓
Entry
```

---

## Question

Does requiring a retest of the broken London Range boundary improve trade quality?

This is a structural strategy experiment.

It should not be combined with other major modifications during the same test.

---

# Research Question 08

## EA073-RQ08 — Volatility Regime

Breakout behavior may differ between low- and high-volatility environments.

Possible volatility measures include:

```text
ATR

Pre-session volatility

London Range size

Recent realized range
```

The first experiment should use one clearly defined volatility measure.

Do not combine multiple volatility filters initially.

---

## Question

Does London Range Break performance depend on the volatility regime present before or during the breakout?

---

# Research Question 09

## EA073-RQ09 — Break Even

Baseline:

```text
Break Even:
ON

Trigger:
150 points

Offset:
0
```

The baseline realized:

```text
Average Winner:
+$2.23

Average Loser:
-$2.61
```

despite the nominal:

```text
SL = 300

TP = 600
```

Therefore active trade management materially affects the realized payoff distribution.

---

## Controlled Experiment

Compare:

```text
Variant A:
Break Even ON

Variant B:
Break Even OFF
```

Keep all other parameters unchanged.

Only after determining whether Break Even itself is beneficial should the trigger distance be optimized.

---

# Research Question 10

## EA073-RQ10 — Trailing Stop

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

The high:

```text
Profit vs MFE correlation
=
0.96
```

makes exit efficiency an important research area.

However, this correlation alone does not prove that the current trailing mechanism is good or bad.

---

## Controlled Experiment

Compare:

```text
Variant A:
Trailing ON

Variant B:
Trailing OFF
```

Keep:

```text
Entry Logic
SL
TP
Break Even
Session
```

unchanged.

If Trailing ON shows an advantage, then investigate its parameters separately.

---

# Research Question 11

## EA073-RQ11 — Exit Architecture

After Break Even and Trailing Stop have been isolated, compare exit structures such as:

```text
Fixed SL + Fixed TP

Fixed SL + Break Even

Fixed SL + Trailing

Fixed SL + Break Even + Trailing
```

The objective is to determine which exit component contributes positively to expectancy.

Avoid optimizing every exit parameter simultaneously.

---

# Research Question 12

## EA073-RQ12 — Timeframe

Baseline:

```text
M1
```

M1 provides high signal frequency but can also expose the strategy to:

```text
Market noise
Spread sensitivity
Execution sensitivity
Repeated boundary crossings
```

Future experiments may evaluate:

```text
M5
M15
```

but timeframe research should occur only after the core entry behavior has been understood.

Otherwise a timeframe change can obscure the original source of baseline failure.

---

# Research Question 13

## EA073-RQ13 — Server-Time Mapping

The current EA defines the range using:

```text
08:00 → 09:00
SERVER TIME
```

This is a critical research variable.

It does not automatically mean:

```text
08:00 → 09:00
London local time
```

Therefore the strategy may be studying a broker-time interval rather than a stable London-market interval.

---

## Required Research

Document:

```text
Broker server timezone

UTC offset

DST behavior

London GMT/BST relationship
```

Then determine which real-world market interval the configured range actually represents.

Do not change the baseline record.

Any corrected session mapping must be treated as a new experimental variant.

---

# Experiment Order

The recommended controlled research sequence is:

```text
BASELINE #01
      ↓
RQ01
First Breakout Only
      ↓
RQ02
BUY vs SELL
      ↓
RQ03
Breakout Time
      ↓
RQ04
Range Size
      ↓
RQ05
Breakout Buffer
      ↓
RQ06
Breakout Strength
      ↓
RQ07
Retest Confirmation
      ↓
RQ08
Volatility Regime
      ↓
RQ09
Break Even
      ↓
RQ10
Trailing Stop
      ↓
RQ11
Exit Architecture
      ↓
RQ12
Timeframe
      ↓
RQ13
Server-Time Mapping
```

The sequence may be adjusted when an earlier experiment provides strong evidence that changes the next research priority.

Every change must remain documented.

---

# Research Rules

## Rule 1 — Preserve the Baseline

Never overwrite:

```text
Baseline #01
```

It remains the permanent control experiment.

---

## Rule 2 — One Research Question at a Time

Do not change:

```text
Direction
+
Session
+
Breakout Buffer
+
SL
+
TP
+
Trailing
```

simultaneously.

Otherwise the source of any performance change cannot be identified reliably.

---

## Rule 3 — Record Failed Experiments

Negative results remain part of the repository.

Do not delete an experiment because it performs poorly.

A failed hypothesis is still research evidence.

---

## Rule 4 — No Selection by Net Profit Alone

Do not approve a variant solely because:

```text
Net Profit > Baseline
```

Evaluate at minimum:

```text
Net Profit

Profit Factor

Expected Payoff

Drawdown

Trade Count

Win Rate

Average Winner

Average Loser

Consecutive Losses

Balance / Equity behavior
```

---

## Rule 5 — Avoid Premature Optimization

Structural research comes before broad parameter optimization.

The sequence is:

```text
Baseline
   ↓
Identify structural weakness
   ↓
Controlled experiment
   ↓
Confirm repeatable improvement
   ↓
Parameter optimization
   ↓
Out-of-sample validation
   ↓
Walk-forward validation
   ↓
Robustness testing
   ↓
Forward testing
```

---

# Experiment Naming Convention

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
London Range Break

RQ01
First Breakout Only

E001
Experiment 001
```

---

# Experiment Record Template

Every experiment should record:

```text
Experiment ID:

Research Question:

Hypothesis:

Control:

Changed Variable:

Fixed Variables:

Symbol:

Timeframe:

Test Period:

History Quality:

Parameters:

Total Trades:

Net Profit:

Profit Factor:

Expected Payoff:

Maximum Balance DD:

Maximum Equity DD:

Win Rate:

Average Winner:

Average Loser:

Result:

PASS / FAIL / INCONCLUSIVE

Interpretation:

Next Action:
```

---

# Validation Pipeline

A promising research variant is not immediately classified as a validated EA.

It must progress through:

```text
1. Baseline comparison

2. Controlled research

3. Parameter sensitivity

4. Out-of-sample test

5. Walk-forward validation

6. Robustness testing

7. Execution sensitivity

8. Forward test

9. Live validation
```

Failure at a later stage must remain documented.

---

# Current Research Status

```text
EA:
EA-073_London_Range_Break

Baseline:
COMPLETED

Baseline Result:
FAIL

Net Profit:
-$143.88

Profit Factor:
0.65

Expected Payoff:
-$0.52

Maximum Equity DD:
15.93%

Research Stage:
ACTIVE

Current Research Question:
EA073-RQ01

Current Hypothesis:
First Breakout Only

Optimization:
NOT STARTED

Out-of-Sample:
NOT STARTED

Walk-Forward:
NOT STARTED

Robustness:
NOT STARTED

Forward Test:
NOT STARTED

Live Validation:
NOT STARTED
```

---

# Next Experiment

## EA073-RQ01-E001

```text
Research Question:
Does limiting EA-073 to the first valid
London Range breakout of each trading day
improve the baseline?

CONTROL:
Current EA-073 baseline

VARIANT:
First Breakout Only

CHANGE:
Maximum accepted breakout entries
per trading day = 1

KEEP FIXED:
XAUUSD.PRO
M1
08:00–09:00 Range
13:00 Trade End
SL 300
TP 600
Breakout Buffer 0
Break Even ON
Trailing Stop ON

COMPARE:
Trade Count
Net Profit
Profit Factor
Expected Payoff
Win Rate
Maximum Equity DD
Average Winner
Average Loser
BUY performance
SELL performance
```

No other strategy component should be changed during this experiment.

---

# Research Status Summary

| Stage | Status |
|---|---|
| EA Implementation | ✅ COMPLETE |
| Baseline Backtest | ✅ COMPLETE |
| Baseline Analysis | ✅ COMPLETE |
| Baseline Result | ❌ FAIL |
| Controlled Research | 🔬 ACTIVE |
| RQ01 — First Breakout Only | ⏳ NEXT |
| RQ02 — BUY vs SELL | ⏳ PENDING |
| RQ03 — Breakout Time | ⏳ PENDING |
| RQ04 — Range Size | ⏳ PENDING |
| RQ05 — Breakout Buffer | ⏳ PENDING |
| RQ06 — Breakout Strength | ⏳ PENDING |
| RQ07 — Retest Confirmation | ⏳ PENDING |
| RQ08 — Volatility Regime | ⏳ PENDING |
| RQ09 — Break Even | ⏳ PENDING |
| RQ10 — Trailing Stop | ⏳ PENDING |
| RQ11 — Exit Architecture | ⏳ PENDING |
| RQ12 — Timeframe | ⏳ PENDING |
| RQ13 — Server-Time Mapping | ⏳ PENDING |
| Optimization | ⏳ NOT STARTED |
| Out-of-Sample | ⏳ NOT STARTED |
| Walk-Forward | ⏳ NOT STARTED |
| Robustness | ⏳ NOT STARTED |
| Forward Test | ⏳ NOT STARTED |
| Live Validation | ⏳ NOT STARTED |

---

## Research Principle

EA-073 is currently a research system.

The objective is not to force the strategy to become profitable through repeated parameter searching.

The objective is to determine whether the London Range Break hypothesis contains a reproducible and explainable trading edge.

If controlled experiments fail to demonstrate such an edge, that negative result must also be preserved as a valid research conclusion.
