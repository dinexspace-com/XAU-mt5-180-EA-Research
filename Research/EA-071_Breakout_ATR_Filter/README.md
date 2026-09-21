# EA-071 Research — Breakout ATR Filter

## Research Status

```text
EA:                    EA-071_Breakout_ATR_Filter
Symbol:                XAUUSD.PRO
Baseline Timeframe:    M1
Baseline Period:       2026-01-02 → 2026-03-31

Baseline:              COMPLETE
Baseline Result:       FAIL

Primary Research:      ATR Confirmation Strength
Research Stage:        RQ01
Broad Optimization:    BLOCKED
Out-of-Sample Test:    NOT STARTED
Forward Test:          NOT STARTED
Live Validation:       NOT VALIDATED
```

---

## Research Objective

EA-071 investigates whether volatility expansion can improve the quality of XAUUSD breakout signals.

The baseline hypothesis is:

```text
20-Bar Price Breakout
        +
Above-Average ATR
        ↓
Higher-Quality Breakout
```

The baseline volatility condition is:

```text
ATR(14)[1]
>
Average ATR(14)[2...21]
```

This can be expressed as:

```text
Relative ATR =
ATR[1]
────────────
Average ATR

Baseline Requirement:

Relative ATR > 1.00
```

The baseline test failed.

The research objective is therefore not to immediately optimize every parameter.

The next objective is to determine:

> Does the ATR filter contain useful information if the required volatility expansion is made materially stronger?

---

# Baseline Experiment

## Baseline ID

```text
EA071-BL01
```

## Strategy

```text
Breakout:
20-Bar Price Breakout

Volatility Confirmation:
ATR(14)[1] > Previous 20-Bar Average ATR

Direction:
Breakout Above Range → BUY
Breakout Below Range → SELL
```

---

## Baseline Environment

```text
Expert:
EA-071_Breakout_ATR_Filter

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

History:
100% real ticks

Bars:
85,161

Ticks:
39,639,179
```

---

## Baseline Parameters

```text
Lot Size:              0.01

Stop Loss:             300
Take Profit:           600

Maximum Spread:        30
Slippage:              10

Breakout Lookback:     20
Breakout Buffer:       0

ATR Period:            14
ATR Mean Period:       20

Break Even:            ON
BE Trigger:            150
BE Offset:             0

Trailing Stop:         ON
Trailing Start:        200
Trailing Distance:     100
Trailing Step:         10

Magic Number:          123071
```

---

# Baseline Results

```text
Initial Deposit:       $1,000.00

Net Profit:            -$992.72

Gross Profit:          $4,006.58
Gross Loss:            -$4,999.30

Profit Factor:         0.80

Expected Payoff:       -$0.27

Recovery Factor:       -0.99

Sharpe Ratio:          -5.00

Maximum Balance DD:    99.28%
Maximum Equity DD:     99.28%

Total Trades:          3,669
Total Deals:           7,338

Winning Trades:        1,717
Losing Trades:         1,952

Win Rate:              46.80%
Loss Rate:             53.20%

Average Winner:        +$2.33
Average Loser:         -$2.56

Largest Winner:        +$29.45
Largest Loser:         -$7.23
```

Baseline classification:

```text
FAIL
```

---

# Baseline Failure

EA071-BL01 failed because the strategy produced:

```text
Negative Net Profit
        +
Profit Factor < 1
        +
Negative Expected Payoff
        +
Negative Recovery Factor
        +
Negative Sharpe Ratio
        +
~99% Maximum Drawdown
```

This is not a marginal failure.

The tested configuration nearly depleted the initial account balance.

Therefore:

```text
EA071-BL01
≠
Live Candidate
```

and:

```text
EA071-BL01
≠
Optimization Candidate Yet
```

The strategy must first pass controlled hypothesis research.

---

# Important Baseline Observation

EA-071 produced:

```text
3,669 trades
```

in approximately three months.

For a strategy intended to filter breakouts using volatility expansion, this is a very large number of accepted signals.

The baseline ATR rule is:

```text
ATR[1] > Average ATR
```

This means that even a very small increase above average volatility qualifies.

Example:

```text
Average ATR = 5.00
Current ATR = 5.01

5.01 > 5.00

Signal passes.
```

Relative ATR:

```text
5.01 / 5.00 = 1.002
```

Therefore a volatility increase of only approximately:

```text
0.2%
```

would satisfy the filter in this example.

This suggests an important research question:

> Is `ATR > Average ATR` too permissive to represent meaningful volatility expansion?

This is a hypothesis.

It is not yet a conclusion.

---

# Research Hypothesis

## H0 — Null Hypothesis

Increasing ATR confirmation strength does not materially improve the breakout strategy.

Conceptually:

```text
Stronger ATR Threshold
        ↓
No meaningful improvement
in expectancy / PF / drawdown
```

If this occurs consistently, ATR expansion may not provide useful filtering information for this breakout architecture.

---

## H1 — Research Hypothesis

A stronger ATR expansion requirement improves breakout quality.

Conceptually:

```text
Weak Volatility Expansion
        ↓
Many Low-Quality Breakouts

Strong Volatility Expansion
        ↓
Fewer Signals
        +
Potentially Better Breakouts
```

The experiment must determine whether this actually occurs.

---

# Primary Research Variable

Define:

```text
Relative ATR =
Current ATR
───────────
Average ATR
```

Instead of:

```text
Current ATR > Average ATR
```

future experimental versions should support:

```text
Current ATR
>
Average ATR × ATRMultiplier
```

The baseline becomes:

```text
ATRMultiplier = 1.00
```

---

# RQ01 — ATR Confirmation Strength

## Research Question

> Does increasing the minimum relative ATR requirement improve XAUUSD M1 breakout quality?

This is the highest-priority research question for EA-071.

---

## Controlled Variable

Change only:

```text
ATR Multiplier
```

Keep unchanged:

```text
Symbol
Timeframe
Breakout Lookback
ATR Period
ATR Mean Period
Lot Size
Stop Loss
Take Profit
Break Even
Trailing Stop
Spread Filter
Test Period
```

---

## Experimental Matrix

Initial controlled matrix:

| Test ID | ATR Multiplier | Status |
|---|---:|---|
| EA071-BL01 | 1.00 | COMPLETE |
| EA071-RQ01-A | 1.10 | PENDING |
| EA071-RQ01-B | 1.20 | PENDING |
| EA071-RQ01-C | 1.30 | PENDING |
| EA071-RQ01-D | 1.50 | PENDING |

Conceptually:

```text
1.00
 ↓
1.10
 ↓
1.20
 ↓
1.30
 ↓
1.50
```

These values are research points.

They are not recommended trading parameters.

---

# RQ01 Evaluation Metrics

Every experiment must record:

```text
Net Profit

Gross Profit
Gross Loss

Profit Factor

Expected Payoff

Maximum Balance Drawdown
Maximum Equity Drawdown

Recovery Factor

Sharpe Ratio

Total Trades

Winning Trades
Losing Trades

Win Rate

Average Winner
Average Loser

BUY Trades
BUY Win Rate

SELL Trades
SELL Win Rate

Maximum Consecutive Wins
Maximum Consecutive Losses

Average Holding Time
```

---

# RQ01 Primary Comparison

The most important relationship is:

```text
ATR Threshold
        ↓
Trade Count
        ↓
Profit Factor
        ↓
Expected Payoff
        ↓
Drawdown
```

Research should determine whether increasing ATR selectivity causes:

```text
Trade Count ↓

while

Profit Factor ↑
Expected Payoff ↑
Drawdown ↓
```

If that pattern does not appear, stronger ATR filtering may not be solving the baseline problem.

---

# RQ01 Decision Logic

A stronger ATR filter should not be selected merely because:

```text
Net Profit improves
```

For example:

```text
Baseline:
Net Profit = -$992

Candidate:
Net Profit = -$600
```

does not establish a viable strategy.

The candidate is simply:

```text
Less Negative
```

The purpose of RQ01 is first to determine whether the filter produces a meaningful structural improvement.

---

# RQ01 Interpretation Scenarios

## Scenario A — Clear Improvement

Example pattern:

```text
ATR Threshold ↑

Trade Count ↓
Profit Factor ↑
Expected Payoff ↑
Drawdown ↓
```

Interpretation:

```text
ATR Strength may contain useful filtering information.
```

Proceed to refine the ATR threshold.

---

## Scenario B — Fewer Trades, Same Expectancy

Example:

```text
Trade Count ↓↓↓

Profit Factor ≈ 0.80
Expected Payoff remains negative
```

Interpretation:

```text
ATR filter is reducing frequency
without improving signal quality.
```

Do not continue optimizing ATR aggressively.

---

## Scenario C — Performance Deteriorates

Example:

```text
ATR Threshold ↑

Profit Factor ↓
Expected Payoff ↓
```

Interpretation:

```text
Stronger ATR expansion does not support
the research hypothesis.
```

---

## Scenario D — Isolated Excellent Result

Example:

```text
1.10 = poor
1.20 = poor
1.30 = excellent
1.50 = poor
```

Interpretation:

```text
Potential parameter instability
or overfitting risk.
```

Do not immediately select:

```text
1.30
```

Additional nearby tests and out-of-sample validation would be required.

---

# RQ02 — Directional Asymmetry

Baseline:

```text
BUY Trades:
1,597

BUY Win Rate:
49.53%

SELL Trades:
2,072

SELL Win Rate:
44.69%
```

Difference:

```text
BUY - SELL
=
+4.84 percentage points
```

This creates the second research question:

> Does ATR-filtered breakout behavior differ materially between bullish and bearish XAUUSD breakouts?

---

## RQ02 Test Structure

After RQ01:

```text
BUY + SELL
vs
BUY Only
vs
SELL Only
```

All other variables remain unchanged.

---

## Important Limitation

The baseline does **not** prove:

```text
BUY Only = Profitable
```

because:

```text
49.53% BUY win rate
```

alone does not establish positive expectancy.

The directional result must be evaluated using complete trade statistics.

---

# RQ03 — ATR Mean Period

Baseline:

```text
ATR Mean Period = 20
```

Research question:

> How much historical volatility should define "normal" volatility?

Potential controlled values:

```text
10
20
30
50
```

Baseline:

```text
20
```

Only this variable should change during RQ03.

---

# RQ04 — ATR Period

Baseline:

```text
ATR Period = 14
```

Research question:

> Does a faster or slower ATR measurement improve volatility-expansion detection?

Possible research candidates can later include:

```text
7
10
14
21
```

These are experimental values only.

---

# RQ05 — Breakout Lookback

Baseline:

```text
20 bars
```

Research question:

> Does volatility confirmation behave differently with shorter or longer breakout structures?

Potential controlled candidates:

```text
10
20
30
50
```

This research should occur after ATR behavior is understood.

---

# RQ06 — Timeframe

Baseline:

```text
M1
```

Observed:

```text
3,669 trades

Average Holding Time:
00:01:54
```

Research question:

> Is M1 generating excessive breakout noise?

Potential comparison:

```text
M1
M5
M15
```

The same logical architecture should be maintained when comparing timeframes.

---

# RQ07 — Session Filter

The baseline entry distribution shows activity across multiple trading hours.

Future research may divide trading into:

```text
Asia
Europe
US
```

Research question:

> Does ATR-confirmed breakout expectancy differ across major XAUUSD liquidity regimes?

Session removal must not be based solely on visual chart inspection.

Each session must be measured independently.

---

# RQ08 — Exit Management

Baseline exits:

```text
SL = 300
TP = 600

Break Even:
150 / 0

Trailing:
200 / 100 / 10
```

Nominal initial reward/risk:

```text
600 / 300
=
2.00
```

But realized averages were:

```text
Average Winner = $2.33
Average Loser  = $2.56
```

Realized average payoff ratio:

```text
2.33 / 2.56
≈
0.91
```

This indicates that actual trade management produces a payoff structure substantially different from the nominal TP/SL ratio.

Therefore exit behavior deserves a separate experiment.

It should not be mixed into ATR-filter research.

---

# MFE / MAE Research Observation

Baseline correlations:

```text
Profit ↔ MFE = 0.96

Profit ↔ MAE = 0.73

MFE ↔ MAE = 0.6057
```

The strong Profit–MFE relationship makes exit behavior a potentially important later research area.

However:

```text
Correlation
≠
Proof of causal improvement
```

Therefore the research sequence remains:

```text
Entry Filter First
Exit Management Later
```

---

# Holding-Time Observation

Baseline:

```text
Minimum:
00:00:01

Average:
00:01:54

Maximum:
02:07:01
```

Most trades are very short relative to the maximum observed duration.

This reinforces the need to investigate whether:

```text
M1 Breakout
+
Weak ATR Threshold
```

is producing excessive short-lived breakout activity.

Again, this is a research hypothesis rather than a conclusion.

---

# Baseline vs EA-070 Observation

EA-070 and EA-071 investigate two different confirmation concepts:

```text
EA-070
Breakout
+
Tick Volume Confirmation
```

versus:

```text
EA-071
Breakout
+
ATR Volatility Confirmation
```

EA-071 should not be judged merely by which EA has the higher baseline net profit.

The purpose of the research series is to determine:

```text
Which market-state filters
contain useful information
for breakout selection.
```

Controlled experiments must therefore preserve the identity of each research branch.

---

# Research Sequence

The authorized research sequence for EA-071 is:

```text
EA071-BL01
Baseline
   ↓
EA071-RQ01
ATR Confirmation Strength
   ↓
EA071-RQ02
BUY / SELL Direction
   ↓
EA071-RQ03
ATR Mean Period
   ↓
EA071-RQ04
ATR Period
   ↓
EA071-RQ05
Breakout Lookback
   ↓
EA071-RQ06
Timeframe
   ↓
EA071-RQ07
Trading Session
   ↓
EA071-RQ08
Exit Management
   ↓
Controlled Optimization
   ↓
Candidate Selection
   ↓
Out-of-Sample Validation
   ↓
Robustness Testing
   ↓
Forward Testing
```

---

# Optimization Gate

Broad optimization is currently:

```text
BLOCKED
```

It becomes appropriate only after controlled research establishes that one or more variables show meaningful and reasonably stable improvement.

Do not immediately optimize:

```text
ATR Period
ATR Mean
ATR Multiplier
Breakout Lookback
SL
TP
Break Even
Trailing
Timeframe
```

simultaneously.

Doing so would make it difficult to determine which change created the result and would increase overfitting risk.

---

# Candidate Evaluation

A future candidate must be evaluated as a complete performance profile.

Required metrics:

```text
Profitability
+
Expected Payoff
+
Profit Factor
+
Drawdown
+
Recovery
+
Trade Count
+
Directional Stability
+
Parameter Stability
```

No candidate should advance solely because it has the highest:

```text
Net Profit
```

---

# Parameter Stability

A useful research result should ideally exist across a neighborhood of parameter values.

Prefer patterns such as:

```text
1.15 → improvement
1.20 → improvement
1.25 → improvement
1.30 → improvement
```

over:

```text
1.15 → poor
1.20 → poor
1.25 → exceptional
1.30 → poor
```

The second structure may indicate a fragile parameter island.

---

# Out-of-Sample Gate

No optimized candidate should be considered validated using only:

```text
2026-01-02
to
2026-03-31
```

That period is the current baseline research sample.

Once a candidate is selected, it must be tested on data not used to select its parameters.

Conceptually:

```text
Research / Development Data
        ↓
Candidate Selection
        ↓
Unseen Data
        ↓
Out-of-Sample Test
```

---

# Robustness Testing

Candidates surviving out-of-sample testing should later be tested under altered execution assumptions.

Examples:

```text
Higher Spread

Execution Delay

Different Test Period

Different Market Regime

Nearby Parameter Values

Alternative Broker Data
```

The purpose is to determine whether performance depends on unusually precise historical conditions.

---

# Forward Testing

Only after:

```text
Controlled Research
        +
Candidate Selection
        +
Out-of-Sample Validation
        +
Robustness Testing
```

should EA-071 proceed to:

```text
Forward Testing
```

Forward testing should occur before any live-capital conclusion.

---

# Research Evidence

Preserve the original EA071-BL01 evidence:

```text
Backtest/
└── EA-071_Breakout_ATR_Filter/
    ├── README.md
    ├── ReportTester-952747(20260921-002735).html
    ├── ReportTester-952747(20260921-002735).png
    ├── ReportTester-952747-hst(20260921-002735).png
    ├── ReportTester-952747-mfemae(20260921-002735).png
    └── ReportTester-952747-holding(20260921-002735).png
```

The baseline evidence must never be replaced by later experimental results.

---

# Experiment Naming Convention

Use:

```text
EA071-BL01
```

for the original baseline.

Controlled research:

```text
EA071-RQ01-A
EA071-RQ01-B
EA071-RQ01-C
...
```

Example:

```text
EA071-RQ01-A_ATR-Multiplier-1.10
EA071-RQ01-B_ATR-Multiplier-1.20
EA071-RQ01-C_ATR-Multiplier-1.30
EA071-RQ01-D_ATR-Multiplier-1.50
```

This keeps every experiment traceable to its research question.

---

# Research Log

| ID | Experiment | Status | Result |
|---|---|---|---|
| EA071-BL01 | ATR > Average ATR | COMPLETE | FAIL |
| EA071-RQ01-A | ATR Multiplier 1.10 | PENDING | — |
| EA071-RQ01-B | ATR Multiplier 1.20 | PENDING | — |
| EA071-RQ01-C | ATR Multiplier 1.30 | PENDING | — |
| EA071-RQ01-D | ATR Multiplier 1.50 | PENDING | — |
| EA071-RQ02 | Direction | BLOCKED | — |
| EA071-RQ03 | ATR Mean Period | BLOCKED | — |
| EA071-RQ04 | ATR Period | BLOCKED | — |
| EA071-RQ05 | Breakout Lookback | BLOCKED | — |
| EA071-RQ06 | Timeframe | BLOCKED | — |
| EA071-RQ07 | Trading Session | BLOCKED | — |
| EA071-RQ08 | Exit Management | BLOCKED | — |

---

# Current Research Decision

The EA-071 baseline provides enough evidence to reject the current configuration as a live candidate.

However, it does not yet justify abandoning the ATR-filter hypothesis.

The most important structural weakness to investigate first is:

```text
ATR[1] > Average ATR
```

because this threshold requires only marginally above-average volatility.

Therefore the next experiment is:

```text
EA071-RQ01
ATR Confirmation Strength
```

The first controlled candidate is:

```text
EA071-RQ01-A

ATR Multiplier:
1.10
```

All other baseline parameters remain unchanged.

---

# Current Research Summary

```text
EA:
EA-071_Breakout_ATR_Filter

Baseline:
COMPLETE

Baseline Classification:
FAIL

Baseline Net Profit:
-$992.72

Profit Factor:
0.80

Expected Payoff:
-$0.27

Maximum Equity DD:
99.28%

Trades:
3,669

Win Rate:
46.80%

BUY Win Rate:
49.53%

SELL Win Rate:
44.69%

Primary Problem:
Negative expectancy
+
Extreme drawdown
+
High trade frequency
+
Weak ATR selectivity

Primary Research Question:
Does stronger ATR expansion improve
breakout signal quality?

Next Experiment:
EA071-RQ01-A

Change:
ATR Multiplier 1.00 → 1.10

All Other Parameters:
UNCHANGED

Broad Optimization:
BLOCKED

Live Validation:
NOT VALIDATED
```

---

## Research Principle

```text
Do not search for the best parameter first.

Determine whether the variable contains useful information first.
```

EA-071 will proceed through controlled experiments before optimization.

The failed baseline remains permanently preserved as the reference point for every subsequent experiment.
