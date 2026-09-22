# Research — EA-074 New York Range Break

## 1. Research Objective

EA-074 investigates whether a systematic breakout of a predefined intraday range can produce a reproducible trading edge in XAUUSD.

The strategy is designed around a simple hypothesis:

```text
Intraday Range Formation
        ↓
Range Boundary Established
        ↓
Price Breaks Range
        ↓
Directional Expansion
        ↓
Potential Momentum Capture
```

The current implementation uses:

```text
Range Formation:
13:00 → 14:00 server time

Trading Window:
14:00 → 20:00 server time

Execution Timeframe:
M1
```

The research objective is not to prove that every range breakout is profitable.

The objective is to determine:

```text
WHEN

WHERE

UNDER WHAT CONDITIONS
```

a post-range breakout may produce positive expectancy.

---

# 2. Research Question

The central research question is:

> Does a breakout of the 13:00–14:00 broker/server-time range contain exploitable information about subsequent XAUUSD price movement?

This is divided into several secondary questions:

```text
Does the first breakout perform differently
from repeated breakout attempts?

Does breakout direction matter?

Does breakout timing matter?

Does range size matter?

Does breakout strength matter?

Does volatility regime matter?

Do Break Even and Trailing Stop
improve or reduce expectancy?

Does the server-time range correctly map
to the intended New York market period?
```

---

# 3. Strategy Hypothesis

The underlying hypothesis is:

```text
Range Formation
        ↓
Temporary Price Compression
        ↓
Range Break
        ↓
Possible Volatility Expansion
        ↓
Directional Continuation
```

Conceptually, the strategy attempts to participate in movement after price leaves a previously established intraday range.

The hypothesis does not assume that every breakout continues.

False breakouts are expected.

The research problem is therefore:

```text
Can useful breakout conditions
be separated from low-quality breakouts
using rules known before entry?
```

---

# 4. Relationship to Opening Range Breakout Research

EA-074 belongs broadly to the family of intraday range-breakout strategies.

Academic research has examined Opening Range Breakout and related technical trading rules.

A relevant study is:

```text
Holmberg, U.
Lönnbark, C.
Lundström, C.

Assessing the profitability of
intraday opening range breakout strategies

Finance Research Letters
Volume 10, Issue 1
2013
Pages 27–33

DOI:
10.1016/j.frl.2012.09.001
```

The study examined whether mechanical breakout rules could identify and exploit large intraday movements.

The conceptual connection to EA-074 is:

```text
Defined Price Reference
        ↓
Threshold / Boundary
        ↓
Price Break
        ↓
Directional Position
```

However:

```text
Academic ORB evidence
≠
Evidence that EA-074 is profitable
```

The referenced research used different:

```text
Markets

Historical periods

Range definitions

Entry thresholds

Exit rules

Execution assumptions
```

Therefore the EA-074 hypothesis must be independently tested on XAUUSD.

---

# 5. Contraction → Expansion Hypothesis

A useful conceptual framework for breakout research is:

```text
CONTRACTION
        ↓
Relatively bounded price movement
        ↓
Range formation
        ↓
BREAKOUT
        ↓
EXPANSION
        ↓
Potential directional movement
```

EA-074 attempts to define the contraction period through:

```text
13:00 → 14:00
```

and trade potential expansion after:

```text
14:00
```

until:

```text
20:00
```

This interpretation remains a hypothesis.

It must be evaluated using the actual distribution of:

```text
Range size

Breakout distance

MFE

MAE

Trade duration

Breakout time

Direction

Volatility
```

---

# 6. Important Timezone Limitation

EA-074 is named:

```text
New York Range Break
```

but the current EA configuration uses:

```text
Broker / Server Time
```

rather than an explicitly normalized New York timezone.

Current baseline:

```text
Range Start:
13:00

Range End:
14:00

Trade End:
20:00
```

Therefore:

```text
13:00 server time
```

must not automatically be interpreted as:

```text
13:00 New York time
```

or any specific New York market event.

Before the strategy can be described as a validated New York-session strategy, research must determine:

```text
Broker UTC offset

New York UTC offset

EST / EDT mapping

Daylight Saving Time behavior
```

This is a structural research requirement.

---

# 7. Baseline Implementation

The current baseline configuration is:

```text
Lot Size             = 0.01

Stop Loss            = 300
Take Profit          = 600

Magic Number         = 123074
Slippage             = 10
Maximum Spread       = 30

Timeframe             = M1
Breakout Lookback     = 20
Breakout Buffer       = 0

Break Even            = ON
BE Trigger            = 150
BE Offset             = 0

Trailing Stop         = ON
Trailing Start        = 200
Trailing Distance     = 100
Trailing Step         = 10

Range Start           = 13:00
Range End             = 14:00
Trade End             = 20:00
```

All times represent broker/server time.

---

# 8. Baseline Test Environment

The current baseline was tested using:

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
$1,000

Leverage:
1:500

History Quality:
100% real ticks

Broker:
ACCM Intl Limited

MT5 Build:
6182
```

The dataset contained:

```text
Bars:
85,161

Ticks:
39,639,179

Symbols:
1
```

---

# 9. Baseline Results

The baseline produced:

```text
Total Trades:
436

Net Profit:
-$7.69

Gross Profit:
+$521.09

Gross Loss:
-$528.78

Profit Factor:
0.99

Expected Payoff:
-$0.02

Recovery Factor:
-0.08

Sharpe Ratio:
-2.72
```

Trade outcomes:

```text
Winning Trades:
217
49.77%

Losing Trades:
219
50.23%
```

Drawdown:

```text
Maximum Balance Drawdown:
$100.87
9.27%

Maximum Equity Drawdown:
$102.10
9.37%
```

Therefore:

```text
BASELINE EDGE
NOT CONFIRMED
```

---

# 10. Interpretation of Baseline

The baseline is close to break-even but remains negative.

The important relationship is:

```text
Gross Profit
$521.09

vs.

Gross Loss
-$528.78
```

producing:

```text
Profit Factor
0.99
```

and:

```text
Expected Payoff
-$0.02
```

This indicates that the current implementation does not demonstrate positive expectancy over the tested period.

However, the result is sufficiently close to neutral that structural decomposition is useful.

The correct research question is not:

```text
Which parameters maximize profit?
```

The first question should instead be:

```text
Which components of the current
trade population create or destroy expectancy?
```

---

# 11. Balance-Curve Observation

The balance curve does not show a stable monotonic trend.

It contains several distinct phases:

```text
Initial Period
        ↓
Drawdown

Middle Period
        ↓
Recovery

Middle / Later Period
        ↓
Balance above initial capital

Later Period
        ↓
Progressive deterioration

Final Result
        ↓
Below initial capital
```

The approximate peak exceeded:

```text
$1,080
```

before the strategy subsequently gave back those gains.

This suggests:

```text
Strategy performance
may not be stationary
throughout the sample.
```

This observation does not establish the cause.

Possible explanations must be treated as hypotheses and tested independently.

---

# 12. Directional Observation

Baseline directional statistics:

```text
SELL

Trades:
188

Win Rate:
52.13%
```

versus:

```text
BUY

Trades:
248

Win Rate:
47.98%
```

Observed difference:

```text
SELL win rate
>
BUY win rate
```

This is not sufficient evidence to convert EA-074 into a SELL-only system.

Win rate alone does not establish expectancy.

Research must compare:

```text
BUY only

SELL only

BUY + SELL
```

using:

```text
Net Profit

Profit Factor

Expected Payoff

Average Win

Average Loss

Drawdown

Trade Count
```

---

# 13. Breakout-Time Observation

The entry-distribution chart shows the largest concentration of entries immediately after completion of the range.

The strongest entry concentration occurs around:

```text
14:00
```

with progressively fewer trades during later hours.

Baseline trading hours include approximately:

```text
14
15
16
17
18
19
```

This creates an important research hypothesis:

```text
Breakout quality may depend
on elapsed time after range completion.
```

The hypothesis must be tested by segmenting trades according to entry time.

---

# 14. Multiple Breakout Attempts

The raw MT5 order history demonstrates that the current baseline can enter multiple times during the same trading day.

Therefore:

```text
CURRENT BASELINE

Multiple breakout attempts
=
ALLOWED
```

This means one trading day can produce:

```text
Breakout
↓
Trade
↓
Exit
↓
New Breakout
↓
New Trade
↓
Exit
↓
Additional Attempt
```

Repeated entries may have very different expectancy from the first breakout.

This becomes the first structural research priority.

---

# 15. Holding-Time Observation

Baseline holding statistics:

```text
Minimum:
00:00:01

Average:
00:01:25

Maximum:
00:23:28
```

The average trade therefore lasts only:

```text
85 seconds
```

This makes EA-074 highly sensitive to execution assumptions.

Variables requiring later stress testing include:

```text
Spread

Slippage

Latency

Tick sequence

Stop level

Freeze level

Broker execution

Symbol specification
```

A small historical edge may not survive execution deterioration.

---

# 16. MFE / MAE Evidence

The baseline MT5 report contains:

```text
Correlation
Profit ↔ MFE
=
0.96

Correlation
Profit ↔ MAE
=
0.73

Correlation
MFE ↔ MAE
=
0.6284
```

These statistics provide useful diagnostic information for future exit research.

Potential questions include:

```text
How far do winning trades
typically move?

How much adverse excursion occurs
before profitable continuation?

Does Break Even activate
too early?

Does Trailing Stop remove trades
before larger continuation?

Is TP positioned beyond
typical favorable excursion?

Are losing trades identifiable
through early MAE behavior?
```

MFE/MAE must not be used retrospectively to create rules without subsequent independent validation.

---

# 17. Research Hypothesis H1 — First Breakout

## Observation

The baseline permits repeated breakout attempts.

## Hypothesis

The first breakout after range completion may have different expectancy from later breakout attempts.

## Experiment

Compare:

```text
CONTROL

Multiple breakout attempts
```

against:

```text
EXPERIMENT

Maximum one breakout entry
per trading day
```

## Keep Constant

```text
Range hours

Trading cutoff

SL

TP

Break Even

Trailing Stop

Lot size

Symbol

Timeframe

Historical period

Broker environment
```

## Primary Metrics

```text
Trade Count

Net Profit

Profit Factor

Expected Payoff

Maximum Drawdown

Win Rate

Average Win

Average Loss

Consecutive Losses
```

---

# 18. Research Hypothesis H2 — Breakout Direction

## Observation

Baseline:

```text
SELL Win Rate:
52.13%

BUY Win Rate:
47.98%
```

## Hypothesis

Long and short breakouts may have different expectancy.

## Experiment

Compare:

```text
BUY + SELL
```

against:

```text
BUY ONLY
```

and:

```text
SELL ONLY
```

Direction should be evaluated using complete expectancy statistics rather than win rate alone.

---

# 19. Research Hypothesis H3 — Breakout Time

## Observation

Entry frequency is highest near range completion.

## Hypothesis

Breakout expectancy changes according to elapsed time after the range closes.

## Segmentation

```text
14:00–14:59

15:00–15:59

16:00–16:59

17:00–17:59

18:00–18:59

19:00–19:59
```

For every segment calculate:

```text
Trades

Win Rate

Net Profit

Profit Factor

Expected Payoff

Average Win

Average Loss

MFE

MAE
```

Possible future implementation may use a shorter trade window only if the evidence supports it.

---

# 20. Research Hypothesis H4 — Range Size

Define:

```text
RangeSize
=
RangeHigh - RangeLow
```

Hypothesis:

```text
Breakout expectancy depends
on the size of the preceding range.
```

A very narrow range may behave differently from a wide range.

Instead of immediately selecting an arbitrary threshold, first measure the distribution of range size.

Potential segmentation:

```text
Small Range

Medium Range

Large Range
```

A normalized alternative is:

```text
RangeSize
─────────
ATR
```

This allows range width to be evaluated relative to prevailing volatility.

---

# 21. Research Hypothesis H5 — Breakout Strength

Current baseline:

```text
Breakout Buffer
=
0
```

Therefore a breakout can be accepted without requiring additional displacement beyond the range boundary.

Hypothesis:

```text
Weak boundary crossings
may generate more false breakouts
than stronger displacement.
```

Potential experiment:

```text
Buffer = 0

vs.

Small Buffer

vs.

Moderate Buffer
```

The buffer range should be determined systematically rather than selected after viewing the most profitable historical result.

---

# 22. Research Hypothesis H6 — Volatility Regime

The balance curve changes substantially across the test period.

Hypothesis:

```text
EA-074 expectancy may depend
on volatility regime.
```

Possible variables:

```text
ATR

Asian / prior-session volatility

Range Size

Range Size / ATR

Previous-day range

Current realized volatility
```

Research should determine whether:

```text
Low Volatility
Medium Volatility
High Volatility
```

produce materially different breakout behavior.

---

# 23. Research Hypothesis H7 — Break Even

Baseline:

```text
Break Even:
ON

Trigger:
150

Offset:
0
```

Hypothesis:

```text
Break Even may reduce losses

but

may also prematurely close
trades that later continue.
```

Controlled comparison:

```text
Baseline
Break Even ON
```

versus:

```text
Break Even OFF
```

Keep all other parameters unchanged.

Compare:

```text
Net Profit

Profit Factor

Expected Payoff

Average Win

Average Loss

MFE

MAE

Holding Time
```

---

# 24. Research Hypothesis H8 — Trailing Stop

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

Hypothesis:

```text
Trailing Stop may protect
open profit

but

may truncate the right tail
of breakout continuation.
```

Controlled comparison:

```text
Trailing ON
```

versus:

```text
Trailing OFF
```

This experiment should be conducted separately from Break Even research.

---

# 25. Research Hypothesis H9 — Server-Time Mapping

This is a structural issue specific to EA-074.

Current strategy:

```text
Range:
13:00 → 14:00 server time
```

The EA name implies a relationship with:

```text
New York
```

but this relationship must be explicitly verified.

Research must document:

```text
ACCM server UTC offset

New York UTC offset

EST period

EDT period

DST transition dates
```

Then determine what real-world New York interval corresponds to:

```text
13:00 → 14:00
```

on the broker server.

If the mapping changes seasonally:

```text
Fixed Server Hours
≠
Fixed New York Hours
```

This could materially alter the strategy definition.

---

# 26. Research Hypothesis H10 — Exit Structure

Current baseline combines:

```text
Fixed SL

Fixed TP

Break Even

Trailing Stop
```

simultaneously.

Therefore baseline results cannot determine which exit component contributes positively or negatively.

Required controlled sequence:

```text
Experiment A

Fixed SL / TP only
```

then:

```text
Experiment B

Fixed SL / TP
+
Break Even
```

then:

```text
Experiment C

Fixed SL / TP
+
Trailing
```

then:

```text
Experiment D

Fixed SL / TP
+
Break Even
+
Trailing
```

This separates entry quality from trade-management effects.

---

# 27. Research Priority

Experiments should not all be performed simultaneously.

Current priority:

```text
1
First Breakout Only

        ↓

2
Breakout Direction

        ↓

3
Breakout Time

        ↓

4
Range Size

        ↓

5
Breakout Strength

        ↓

6
Volatility Regime

        ↓

7
Break Even

        ↓

8
Trailing Stop

        ↓

9
SL / TP Structure

        ↓

10
Parameter Optimization
```

Server-time mapping should be verified in parallel as a strategy-definition requirement.

---

# 28. Why Entry Structure Comes First

The baseline produced:

```text
Profit Factor:
0.99

Expected Payoff:
-$0.02
```

This means the current trade population does not demonstrate positive expectancy.

Immediately optimizing:

```text
SL

TP

Break Even

Trailing
```

could produce a historically attractive result without demonstrating that the breakout signal itself contains persistent information.

Research therefore prioritizes:

```text
WHO gets traded?

WHEN?

WHICH breakout?

WHICH direction?

UNDER WHICH market condition?
```

before aggressively optimizing exits.

---

# 29. Optimization Policy

Optimization is not the current research stage.

Do not begin with:

```text
Maximum Net Profit
        ↓
Choose Best Pass
        ↓
Declare Strategy Valid
```

Instead:

```text
Structural Hypothesis
        ↓
Controlled Experiment
        ↓
Evidence
        ↓
Retain / Reject
        ↓
Next Hypothesis
```

Only after structural behavior is understood should numerical optimization begin.

---

# 30. Parameter Robustness

When optimization eventually begins, a single profitable parameter combination should not be treated as sufficient evidence.

Avoid selecting isolated peaks such as:

```text
LOSS
LOSS
LOSS
HUGE PROFIT
LOSS
LOSS
LOSS
```

Prefer investigating stable neighborhoods such as:

```text
PROFIT
PROFIT
PROFIT
PROFIT
PROFIT
PROFIT
```

The research target is:

```text
ROBUST REGION
```

rather than:

```text
BEST HISTORICAL PASS
```

---

# 31. Overfitting Control

To reduce overfitting:

```text
Do not optimize every parameter simultaneously.

Do not repeatedly modify rules
after inspecting the same test period.

Do not discard negative experiments.

Do not select parameters only
because they maximize historical profit.

Do not use future information
inside entry decisions.

Do not repeatedly use
out-of-sample data for optimization.
```

Every material strategy change should have:

```text
Hypothesis

Implementation

Test

Result

Decision
```

---

# 32. Validation Pipeline

A candidate EA-074 configuration should eventually pass:

```text
Baseline
        ↓
Structural Research
        ↓
Controlled Experiments
        ↓
Parameter Optimization
        ↓
Robustness Analysis
        ↓
Out-of-Sample Test
        ↓
Walk-Forward Test
        ↓
Execution Stress Test
        ↓
Broker / Timezone Test
        ↓
Forward Test
```

A profitable optimization result is not sufficient to skip these stages.

---

# 33. Out-of-Sample Validation

Historical data should eventually be separated into:

```text
IN-SAMPLE

Used for:
Research
Development
Optimization
```

and:

```text
OUT-OF-SAMPLE

Used for:
Independent validation
```

Once out-of-sample data has repeatedly influenced strategy changes, it should no longer be treated as truly unseen data.

---

# 34. Walk-Forward Validation

A future candidate should be tested through sequential windows:

```text
Window 1

TRAIN
──────
TEST
───


Window 2

    TRAIN
    ──────
    TEST
    ───


Window 3

        TRAIN
        ──────
        TEST
        ───
```

The objective is to determine whether useful behavior persists through changing market conditions.

---

# 35. Execution Stress Testing

EA-074 has:

```text
Average Holding Time:
00:01:25
```

Therefore execution stress testing is mandatory before any production classification.

Candidate configurations should eventually be tested under:

```text
Higher Spread

Higher Slippage

Different Tick Conditions

Different Broker

Different XAUUSD Specification

Different Server Time

Execution Delay
```

A strategy whose small historical edge disappears under minor execution deterioration should not be classified as robust.

---

# 36. Evidence Preservation

Every research experiment should preserve:

```text
EA source version

MT5 HTML report

Balance chart

Entry-distribution chart

MFE / MAE chart

Holding-time chart

Parameter configuration

Test period

Broker

Symbol

Timeframe

Result classification
```

Negative experiments must remain in the repository.

---

# 37. Experiment Naming

Use traceable experiment identifiers.

Recommended structure:

```text
EA074-RQ01-FirstBreakout

EA074-RQ02-Direction

EA074-RQ03-BreakoutTime

EA074-RQ04-RangeSize

EA074-RQ05-BreakoutStrength

EA074-RQ06-Volatility

EA074-RQ07-BreakEven

EA074-RQ08-Trailing

EA074-RQ09-Timezone

EA074-RQ10-ExitStructure
```

Each experiment should preserve its own evidence.

---

# 38. Research Decision States

Use:

```text
NOT TESTED

TESTED

INCONCLUSIVE

REJECTED

CANDIDATE

VALIDATION IN PROGRESS

VALIDATED
```

Do not classify an experiment as:

```text
VALIDATED
```

solely because it improves historical Net Profit.

---

# 39. Current Research Status

```text
EA:
EA-074_New_York_Range_Break

Strategy Implementation:
COMPLETED

Baseline Backtest:
COMPLETED

History Quality:
100% REAL TICKS

Baseline Trades:
436

Baseline Net Profit:
-$7.69

Baseline Profit Factor:
0.99

Baseline Expected Payoff:
-$0.02

Maximum Equity Drawdown:
9.37%

Baseline Profitability:
NOT CONFIRMED

Trading Edge:
NOT CONFIRMED

Structural Research:
IN PROGRESS

Optimization:
NOT VALIDATED

Out-of-Sample:
NOT TESTED

Walk-Forward:
NOT TESTED

Execution Stress:
NOT TESTED

Forward Test:
NOT TESTED
```

Current classification:

```text
RESEARCH STRATEGY
```

---

# 40. Current Next Experiment

The next experiment is:

```text
EA074-RQ01
FIRST BREAKOUT ONLY
```

## Control

```text
EA-074 Baseline

Multiple breakout attempts
allowed per trading day
```

## Experiment

```text
EA-074 First Breakout Only

Maximum one accepted breakout
entry per trading day
```

## Everything Else Remains Fixed

```text
Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-03-31

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

Breakout Buffer:
0

Break Even:
ON

Trailing:
ON
```

## Compare

```text
Total Trades

Net Profit

Profit Factor

Expected Payoff

Maximum Drawdown

Win Rate

Average Winner

Average Loser

Maximum Consecutive Losses

BUY Performance

SELL Performance
```

Decision:

```text
If improvement is observed
        ↓
Do not immediately accept.

Verify whether improvement
is structurally consistent.

        ↓

Continue independent validation.
```

---

# 41. Research Evidence Chain

The project follows:

```text
Research Hypothesis
        │
        ▼
Research/README.md
        │
        ▼
Formal Trading Rules
        │
        ▼
EAs/EA-074_New_York_Range_Break/
        │
        ▼
EA-074_New_York_Range_Break.mq5
        │
        ▼
MetaTrader 5
        │
        ▼
Backtest/EA-074_New_York_Range_Break/
        │
        ▼
Raw MT5 Evidence
        │
        ▼
Measured Result
        │
        ▼
Research Decision
        │
        ▼
Next Controlled Experiment
```

The evidence chain must remain traceable.

---

# 42. Research Principle

EA-074 follows one central rule:

> A strategy is not validated because a profitable parameter combination can be found. It is validated only after its behavior survives controlled testing and independent validation.

The development process is therefore:

```text
HYPOTHESIS
        ↓
CODE
        ↓
TEST
        ↓
EVIDENCE
        ↓
DECISION
        ↓
VALIDATION
```

not:

```text
OPTIMIZE
        ↓
FIND BEST RESULT
        ↓
DECLARE SUCCESS
```

---

# 43. Current Conclusion

The baseline EA-074 result is:

```text
Net Profit:
-$7.69

Profit Factor:
0.99

Expected Payoff:
-$0.02

Maximum Equity Drawdown:
9.37%

Trades:
436
```

Therefore:

```text
EA-074
NEW YORK RANGE BREAK

BASELINE EDGE
NOT CONFIRMED
```

The baseline nevertheless provides sufficient trade observations to begin structural decomposition.

The first research target is:

```text
Does limiting the system
to the first breakout attempt
improve expectancy?
```

This question should be answered before broad parameter optimization begins.

---

# References

## Opening Range Breakout

Holmberg, U., Lönnbark, C., & Lundström, C. (2013).

**Assessing the profitability of intraday opening range breakout strategies.**

Finance Research Letters, 10(1), 27–33.

DOI:

```text
10.1016/j.frl.2012.09.001
```

This reference provides theoretical and empirical context for intraday Opening Range Breakout research.

It does not validate EA-074 or XAUUSD profitability.

---

## Repository Evidence

EA-074 implementation:

```text
EAs/
└── EA-074_New_York_Range_Break/
```

Baseline evidence:

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

# Disclaimer

This research is intended for quantitative strategy development, software testing, and educational purposes.

Historical and simulated results do not guarantee future performance.

EA-074 has not been validated for live trading.

XAUUSD and other leveraged financial instruments involve substantial risk.
