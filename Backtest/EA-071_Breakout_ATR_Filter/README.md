# EA-071 — Breakout ATR Filter — Baseline Backtest

## Overview

This directory contains the baseline MetaTrader 5 backtest evidence for:

```text
EA-071_Breakout_ATR_Filter
```

EA-071 tests whether a 20-bar XAUUSD breakout combined with above-average ATR volatility can produce a measurable trading edge.

The baseline volatility condition is:

```text
ATR(14)[1]
>
Average ATR(14) of previous 20 bars
```

Conceptually:

```text
20-Bar Breakout
        +
Relative ATR > 1.00
```

The purpose of this experiment is to establish the unmodified baseline before any controlled research or parameter optimization.

---

## Baseline Classification

```text
BASELINE RESULT: FAIL

Live Validation:     NOT VALIDATED
Optimization Status: BLOCKED
Research Status:     REQUIRES CONTROLLED FOLLOW-UP
```

The baseline configuration failed to demonstrate positive expectancy.

It must not be treated as a deployable trading strategy.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-071_Breakout_ATR_Filter |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Start | 2026-01-02 |
| Test End | 2026-03-31 |
| Initial Deposit | $1,000.00 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols | 1 |

---

## Strategy Parameters

### Execution

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123071 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |

### Breakout

| Parameter | Value |
|---|---:|
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |

### ATR Filter

| Parameter | Value |
|---|---:|
| ATR Period | 14 |
| ATR Mean Period | 20 |

### Break Even

| Parameter | Value |
|---|---:|
| Enabled | true |
| Trigger | 150 points |
| Offset | 0 points |

### Trailing Stop

| Parameter | Value |
|---|---:|
| Enabled | true |
| Start | 200 points |
| Distance | 100 points |
| Step | 10 points |

---

## Baseline Strategy Logic

The historical breakout range is calculated from the previous 20 completed candles before the signal candle.

The breakout candle is:

```text
bar[1]
```

The historical range is:

```text
bars[2...21]
```

### BUY

```text
ATR(14)[1]
>
Average ATR(14)[2...21]

AND

Close[1]
>
Highest High[2...21]
```

### SELL

```text
ATR(14)[1]
>
Average ATR(14)[2...21]

AND

Close[1]
<
Lowest Low[2...21]
```

The baseline therefore requires above-average ATR before a price breakout is accepted.

---

# Baseline Results

## Performance Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$992.72** |
| Gross Profit | $4,006.58 |
| Gross Loss | -$4,999.30 |
| Profit Factor | **0.80** |
| Expected Payoff | **-$0.27** |
| Recovery Factor | **-0.99** |
| Sharpe Ratio | **-5.00** |
| AHPR | 0.9988 (-0.12%) |
| GHPR | 0.9987 (-0.13%) |
| Z-Score | -1.91 (94.39%) |
| LR Correlation | -0.98 |
| LR Standard Error | 50.32 |
| Margin Level | 97.44% |

The baseline lost approximately:

```text
99.27%
```

of the original $1,000 deposit in net-profit terms.

---

# Drawdown

## Balance Drawdown

| Metric | Result |
|---|---:|
| Absolute | $992.72 |
| Maximal | $998.82 (99.28%) |
| Relative | 99.28% ($998.82) |

## Equity Drawdown

| Metric | Result |
|---|---:|
| Absolute | $992.72 |
| Maximal | $1,000.33 (99.28%) |
| Relative | 99.28% ($1,000.33) |

The drawdown is catastrophic for deployment purposes.

```text
Maximum Equity Drawdown = 99.28%
```

The account approached complete capital depletion during the test.

---

# Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | **3,669** |
| Total Deals | 7,338 |
| Winning Trades | 1,717 |
| Losing Trades | 1,952 |
| Win Rate | **46.80%** |
| Loss Rate | **53.20%** |

The strategy generated a large sample of trades.

However:

```text
Winning Trades < Losing Trades
```

and the average losing trade was larger than the average winning trade.

---

# BUY vs SELL Performance

## BUY

```text
Long Trades = 1,597
Win Rate    = 49.53%
```

## SELL

```text
Short Trades = 2,072
Win Rate     = 44.69%
```

Difference:

```text
BUY  = 49.53%
SELL = 44.69%

Difference = +4.84 percentage points in favor of BUY
```

This is a meaningful research observation.

It is **not** evidence that BUY-only trading is profitable.

A dedicated directional experiment is required before changing the strategy permanently.

---

# Winner / Loser Structure

| Metric | Result |
|---|---:|
| Largest Winning Trade | +$29.45 |
| Largest Losing Trade | -$7.23 |
| Average Winning Trade | **+$2.33** |
| Average Losing Trade | **-$2.56** |
| Maximum Consecutive Wins | 11 |
| Maximum Consecutive Losses | 12 |
| Maximal Consecutive Profit | $29.50 (8 trades) |
| Maximal Consecutive Loss | -$36.38 (11 trades) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The realized payoff structure was unfavorable:

```text
Average Winner = +$2.33
Average Loser  = -$2.56
```

Therefore:

```text
Average Winner / Average Loser
≈
0.91
```

At the same time:

```text
Win Rate = 46.80%
```

This combination produces negative expectancy.

---

# Expected Payoff Structure

A simplified expectancy check is:

```text
P(win)  = 0.4680
P(loss) = 0.5320

Average Win  = $2.33
Average Loss = $2.56
```

Conceptually:

```text
Expectancy
≈
(0.4680 × 2.33)
-
(0.5320 × 2.56)
```

which is negative and consistent with the Strategy Tester result:

```text
Expected Payoff = -$0.27 per trade
```

Therefore the baseline problem is not simply a low win rate.

It combines:

```text
Win Rate < 50%
        +
Average Loss > Average Win
        +
High Trade Frequency
```

resulting in persistent capital erosion.

---

# Consecutive Trades

```text
Maximum Consecutive Wins   = 11
Maximum Consecutive Losses = 12
```

Maximum consecutive monetary loss:

```text
-$36.38 across 11 trades
```

Average streak length:

```text
Wins   = 2
Losses = 2
```

The presence of winning streaks was insufficient to offset the strategy's negative overall expectancy.

---

# Position Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:07:01 |
| Average Holding Time | **00:01:54** |

The strategy operates predominantly as a very short-duration breakout system.

Average trade duration was less than two minutes:

```text
Average Holding Time = 1 minute 54 seconds
```

The holding-time distribution also shows a small number of significantly longer trades.

This should be preserved as a research observation rather than interpreted as an edge.

---

# MFE / MAE Analysis

Strategy Tester reported:

| Correlation | Result |
|---|---:|
| Profit vs MFE | **0.96** |
| Profit vs MAE | **0.73** |
| MFE vs MAE | **0.6057** |

Where:

```text
MFE = Maximum Favorable Excursion
MAE = Maximum Adverse Excursion
```

The very high:

```text
Profit ↔ MFE correlation = 0.96
```

shows a strong relationship between favorable price excursion and realized trade result.

This is expected to be relevant when later investigating exit management.

However, correlation alone does not establish that changing TP, Break Even, or Trailing Stop will improve expectancy.

Those changes require controlled tests.

---

# Equity / Balance Curve Observation

The baseline balance curve is strongly downward over the test period.

The broad structure is:

```text
Initial Balance
      │
      ▼
Repeated Drawdown
      │
      ▼
Partial Recoveries
      │
      ▼
Further Decline
      │
      ▼
Near Account Depletion
```

There is no sustained upward equity regime visible in the baseline result.

The curve therefore supports the quantitative classification:

```text
FAIL
```

rather than suggesting that the loss resulted from a single isolated event.

---

# Trade Frequency

EA-071 generated:

```text
3,669 trades
```

during the approximately three-month test window.

This is substantially more activity than would be expected from a highly selective breakout filter.

The baseline ATR condition is:

```text
ATR[1] > Average ATR
```

or conceptually:

```text
Relative ATR > 1.00
```

This means even a very small increase above average ATR qualifies as volatility confirmation.

For example:

```text
Average ATR = 5.00
Current ATR = 5.01

Relative ATR = 1.002
```

would pass the baseline volatility condition.

This creates an important research question:

> Is the baseline ATR threshold too weak to distinguish genuine volatility expansion from ordinary above-average fluctuation?

This question should be tested rather than assumed.

---

# Baseline Failure Analysis

The baseline failed on all major deployment criteria.

## Profitability

```text
Net Profit = -$992.72
```

Result:

```text
FAIL
```

---

## Profit Factor

```text
Profit Factor = 0.80
```

Gross losses exceeded gross profits.

Result:

```text
FAIL
```

---

## Expected Payoff

```text
Expected Payoff = -$0.27
```

The average trade had negative expectancy.

Result:

```text
FAIL
```

---

## Drawdown

```text
Maximum Equity Drawdown = 99.28%
```

Result:

```text
FAIL
```

---

## Recovery

```text
Recovery Factor = -0.99
```

Result:

```text
FAIL
```

---

## Risk-Adjusted Performance

```text
Sharpe Ratio = -5.00
```

Result:

```text
FAIL
```

---

# Baseline Classification

Based on the documented MT5 Strategy Tester result:

```text
EA-071 BASELINE = FAIL
```

This classification applies only to the exact tested configuration.

It does **not** establish that:

```text
ATR filtering is ineffective
```

or that:

```text
Breakout trading is ineffective
```

or that:

```text
XAUUSD breakout strategies cannot be profitable
```

It establishes only that:

```text
EA-071
+
Current Baseline Parameters
+
XAUUSD.PRO
+
M1
+
2026-01-02 → 2026-03-31
```

failed to demonstrate positive expectancy.

---

# Research Interpretation

The central baseline hypothesis was:

```text
Breakout
+
Above-Average ATR
=
Potentially Better Breakout
```

The baseline result does not support that hypothesis in its current form.

The tested condition:

```text
ATR[1] > Average ATR[2...21]
```

produced:

```text
3,669 trades
PF 0.80
Expected Payoff -$0.27
Net Profit -$992.72
Maximum Equity DD 99.28%
```

Therefore simple above-average ATR was insufficient to convert the tested breakout logic into a profitable strategy.

The next research stage should investigate **the strength of ATR expansion** before broad optimization.

---

# Research Question 01 — ATR Strength

## Question

Does requiring materially stronger ATR expansion improve breakout quality?

The baseline condition is effectively:

```text
Relative ATR > 1.00
```

where:

```text
Relative ATR =
Current ATR
───────────
Average ATR
```

Future controlled experiments can introduce:

```text
Current ATR
>
Average ATR × ATR Multiplier
```

Potential research levels may include:

```text
1.00  ← Baseline
1.10
1.20
1.30
1.50
```

These values are experimental candidates only.

They are not validated settings.

### Research Objective

Determine whether increasing ATR confirmation strength:

```text
reduces low-quality trades
        ↓
improves Profit Factor
        ↓
improves Expected Payoff
        ↓
reduces Drawdown
```

without destroying the useful breakout sample.

---

# Research Question 02 — BUY vs SELL

Observed baseline:

```text
BUY Win Rate  = 49.53%
SELL Win Rate = 44.69%
```

Research question:

> Does ATR-filtered breakout behavior differ materially between bullish and bearish XAUUSD breakouts?

Controlled tests should compare:

```text
BUY + SELL
BUY Only
SELL Only
```

while keeping other parameters unchanged.

The baseline directional difference must not be interpreted as proof that BUY-only is profitable.

---

# Research Question 03 — ATR Mean Period

Baseline:

```text
ATR Mean Period = 20
```

Research question:

> Is a 20-bar ATR average an appropriate volatility reference for XAUUSD M1 breakout detection?

Potential controlled values may later include:

```text
10
20
30
50
```

Only one research dimension should be changed at a time.

---

# Research Question 04 — ATR Period

Baseline:

```text
ATR Period = 14
```

Research question:

> Does ATR sensitivity materially affect breakout confirmation quality?

Possible controlled experiments may compare different ATR periods while keeping the historical ATR averaging method unchanged.

---

# Research Question 05 — Breakout Lookback

Baseline:

```text
Breakout Lookback = 20
```

Research question:

> Does the ATR filter behave differently with shorter or longer breakout structures?

The breakout lookback should be investigated only after the primary ATR-filter hypothesis has been evaluated.

---

# Research Question 06 — Timeframe

Baseline:

```text
M1
```

The baseline produced:

```text
3,669 trades
```

with an average holding time of:

```text
1 minute 54 seconds
```

Research question:

> Is M1 generating excessive noise for the Breakout + ATR hypothesis?

Future controlled comparison may include:

```text
M1
M5
M15
```

using equivalent strategy logic.

---

# Research Question 07 — Trading Session

The entry-distribution charts show that trades occur across multiple trading hours.

Research should determine whether the strategy behaves differently across major XAUUSD liquidity regimes.

Possible controlled session categories:

```text
Asia
Europe
US
```

Session filtering must be evaluated empirically.

No session should be removed solely from visual inspection of the chart.

---

# Research Question 08 — Exit Management

Baseline:

```text
SL = 300

TP = 600

Break Even:
Trigger = 150
Offset  = 0

Trailing:
Start    = 200
Distance = 100
Step     = 10
```

The realized trade statistics were:

```text
Average Winner = +$2.33
Average Loser  = -$2.56
```

despite the nominal:

```text
TP : SL = 2 : 1
```

This confirms that realized payoff behavior is materially affected by trade management and market execution.

Exit-management research should therefore be conducted separately from entry-filter research.

---

# Research Priority

The preferred sequence for EA-071 is:

```text
Baseline
   ↓
ATR Confirmation Strength
   ↓
BUY vs SELL Direction
   ↓
ATR Mean Period
   ↓
ATR Period
   ↓
Breakout Lookback
   ↓
Timeframe
   ↓
Trading Session
   ↓
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

This sequence prevents broad optimization from hiding whether the ATR hypothesis itself contributes useful information.

---

# Comparison Rule

Every controlled experiment should be compared against this baseline using at least:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Equity Drawdown
Recovery Factor
Sharpe Ratio
Total Trades
Win Rate
Average Winner
Average Loser
BUY Win Rate
SELL Win Rate
```

A candidate should not be judged solely by:

```text
Net Profit
```

because a change may increase profit while also creating unacceptable drawdown or reducing robustness.

---

# Baseline Preservation

This backtest must remain unchanged as:

```text
EA-071 Baseline #01
```

Future experiments should be stored separately.

Example:

```text
EA-071_Breakout_ATR_Filter/
│
├── Baseline-01/
│
├── RQ01_ATR_Strength/
│
├── RQ02_Direction/
│
├── RQ03_ATR_Mean_Period/
│
├── RQ04_ATR_Period/
│
├── RQ05_Breakout_Lookback/
│
├── RQ06_Timeframe/
│
├── RQ07_Session/
└── RQ08_Exit_Management/
```

Do not overwrite the original failed baseline with later improved configurations.

A failed baseline is part of the research evidence.

---

# Evidence Files

The baseline Strategy Tester package includes:

```text
ReportTester-952747(20260921-002735).html

ReportTester-952747(20260921-002735).png

ReportTester-952747-hst(20260921-002735).png

ReportTester-952747-mfemae(20260921-002735).png

ReportTester-952747-holding(20260921-002735).png
```

These files should be preserved together with this README.

Recommended structure:

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

---

# Reproducibility

To reproduce Baseline #01, use:

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

Lot:
0.01

Stop Loss:
300

Take Profit:
600

Maximum Spread:
30

Breakout Lookback:
20

Breakout Buffer:
0

ATR Period:
14

ATR Mean Period:
20

Break Even:
ON

Break Even Trigger:
150

Break Even Offset:
0

Trailing Stop:
ON

Trailing Start:
200

Trailing Distance:
100

Trailing Step:
10

Magic Number:
123071
```

Historical data quality:

```text
100% real ticks
```

---

# Baseline Summary

```text
EA: EA-071_Breakout_ATR_Filter

Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026-01-02 → 2026-03-31

Initial Deposit: $1,000
Leverage: 1:500
History Quality: 100% real ticks

Breakout Lookback: 20
ATR Period: 14
ATR Mean Period: 20

Trades: 3,669
Deals: 7,338

Winning Trades: 1,717
Losing Trades: 1,952

Win Rate: 46.80%

BUY:
1,597 trades
49.53% won

SELL:
2,072 trades
44.69% won

Net Profit: -$992.72

Gross Profit: $4,006.58
Gross Loss: -$4,999.30

Profit Factor: 0.80
Expected Payoff: -$0.27

Recovery Factor: -0.99
Sharpe Ratio: -5.00

Maximum Balance DD:
$998.82 / 99.28%

Maximum Equity DD:
$1,000.33 / 99.28%

Average Winner:
+$2.33

Average Loser:
-$2.56

Maximum Consecutive Wins:
11

Maximum Consecutive Losses:
12

Minimum Holding Time:
00:00:01

Average Holding Time:
00:01:54

Maximum Holding Time:
02:07:01

Profit ↔ MFE:
0.96

Profit ↔ MAE:
0.73

MFE ↔ MAE:
0.6057

Classification:
FAIL

Live Trading:
NOT VALIDATED
```

---

# Conclusion

EA-071 Baseline #01 failed.

The combination:

```text
20-Bar Breakout
        +
ATR(14)[1] > Previous 20-Bar Average ATR
        +
Break Even
        +
Trailing Stop
```

did not demonstrate positive expectancy on XAUUSD.PRO M1 during the tested period.

The baseline produced:

```text
Net Profit             = -$992.72
Profit Factor          = 0.80
Expected Payoff        = -$0.27
Maximum Equity DD      = 99.28%
Total Trades           = 3,669
Win Rate               = 46.80%
```

The strategy therefore cannot proceed directly to live validation.

However, the failed baseline provides useful research evidence.

The primary unresolved question is whether:

```text
ATR > Average ATR
```

is too weak a volatility-expansion requirement.

The next authorized research stage is therefore:

```text
EA071-RQ01
ATR Confirmation Strength
```

before broad parameter optimization.

The original baseline must remain unchanged for comparison.

---

## Disclaimer

This backtest is part of an algorithmic trading research project.

Historical backtest performance does not guarantee future performance.

A failed backtest does not prove that the underlying strategy concept can never work, and an improved backtest does not prove that a strategy will remain profitable in live markets.

EA-071 is not validated for live trading.
