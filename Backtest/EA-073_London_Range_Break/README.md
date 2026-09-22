# EA-073 — London Range Break
## Baseline Backtest Report

## Overview

This directory contains the baseline MetaTrader 5 Strategy Tester evidence for:

```text
EA-073_London_Range_Break
```

The purpose of this experiment is to establish the unoptimized reference performance of the London Range Break strategy before controlled research, filtering, or parameter optimization.

The baseline must remain preserved as the reference experiment against which future EA-073 variants are compared.

---

## Test Environment

| Parameter | Value |
|---|---|
| Expert Advisor | EA-073_London_Range_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Start | 2026-01-02 |
| Test End | 2026-03-31 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols | 1 |
| Broker / Company | ACCM Intl Limited |
| Account Currency | USD |
| Initial Deposit | $1,000.00 |
| Leverage | 1:500 |

The experiment covers approximately three months of XAUUSD.PRO M1 historical data.

---

## Baseline Strategy Configuration

### Execution

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123073 |
| Slippage | 10 |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |

### Break Even

| Parameter | Value |
|---|---:|
| Enabled | true |
| Trigger | 150 points |
| Offset | 0 |

### Trailing Stop

| Parameter | Value |
|---|---:|
| Enabled | true |
| Start | 200 points |
| Distance | 100 points |
| Step | 10 points |

### Session

| Parameter | Value |
|---|---:|
| Range Start Hour | 08:00 |
| Range End Hour | 09:00 |
| Trade End Hour | 13:00 |

The tested session structure was therefore:

```text
London Range Formation
08:00 → 09:00
        ↓
Range High / Range Low
        ↓
Breakout Trading Window
09:00 → 13:00
```

All configured session hours are broker/server time.

---

# Backtest Results

## Core Performance

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$143.88** |
| Gross Profit | $265.62 |
| Gross Loss | -$409.50 |
| Profit Factor | **0.65** |
| Expected Payoff | **-$0.52** |
| Recovery Factor | **-0.90** |
| Sharpe Ratio | **-5.00** |
| AHPR | 0.9994 (-0.06%) |
| GHPR | 0.9994 (-0.06%) |
| Z-Score | 0.75 (54.67%) |
| LR Correlation | -0.92 |
| LR Standard Error | 15.92 |
| Margin Level | 8157.33% |

The account started with:

```text
$1,000.00
```

and generated:

```text
-$143.88
```

of net trading result during the tested period.

The approximate final balance implied by the reported net result is:

```text
$856.12
```

before considering any external account activity outside the Strategy Tester experiment.

---

# Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $157.15 |
| Equity Drawdown Absolute | $159.33 |
| Balance Drawdown Maximal | $157.15 (15.71%) |
| Equity Drawdown Maximal | $159.33 (15.93%) |
| Balance Drawdown Relative | 15.71% ($157.15) |
| Equity Drawdown Relative | **15.93% ($159.33)** |

Maximum Equity Drawdown reached:

```text
15.93%
```

while the strategy simultaneously produced negative net profit.

The balance chart shows a persistent overall downward trajectory across the test.

Although temporary recoveries occurred, they were insufficient to reverse the broader decline.

---

# Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | **276** |
| Total Deals | 552 |
| Profit Trades | 119 (43.12%) |
| Loss Trades | 157 (56.88%) |
| Short Trades | 152 |
| Short Win Rate | **47.37%** |
| Long Trades | 124 |
| Long Win Rate | **37.90%** |

Overall:

```text
Winning Trades = 43.12%
Losing Trades  = 56.88%
```

The baseline therefore produced substantially more losing trades than profitable trades.

---

# BUY vs SELL

The report shows a notable directional difference.

```text
SHORT
152 trades
47.37% won

LONG
124 trades
37.90% won
```

Difference:

```text
SHORT win rate = 47.37%
LONG win rate  = 37.90%

Difference = 9.47 percentage points
```

SELL trades therefore achieved a higher historical win rate than BUY trades in this specific test sample.

This is a research observation only.

It does not establish that a SELL-only version of EA-073 is profitable.

Directional behavior must be isolated in a controlled experiment before any permanent strategy change is authorized.

---

# Trade Outcome Distribution

| Metric | Result |
|---|---:|
| Largest Profit Trade | +$7.12 |
| Largest Loss Trade | -$4.52 |
| Average Profit Trade | +$2.23 |
| Average Loss Trade | -$2.61 |
| Maximum Consecutive Wins | 7 (+$14.88) |
| Maximum Consecutive Losses | 9 (-$24.93) |
| Maximal Consecutive Profit | +$16.47 (4 trades) |
| Maximal Consecutive Loss | -$24.93 (9 trades) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The realized average trade structure was:

```text
Average Winner = +$2.23
Average Loser  = -$2.61
```

Therefore:

```text
Average Winner
<
Average Loser in absolute magnitude
```

combined with:

```text
Win Rate = 43.12%
```

This produced negative historical expectancy.

The nominal strategy configuration uses:

```text
SL = 300 points
TP = 600 points
```

but the realized average winner/loss relationship does not resemble a simple 2:1 payoff structure.

This is expected because the EA also uses active:

```text
Break Even
+
Trailing Stop
```

which can modify exits before the original TP or SL is reached.

---

# Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:05 |
| Maximum Holding Time | 00:23:39 |
| Average Holding Time | **00:02:27** |

The average trade remained open for only:

```text
2 minutes 27 seconds
```

despite the strategy using a multi-hour market-session framework.

The holding-time chart also shows that many trades are concentrated at short durations, while a smaller number remain open considerably longer.

This makes execution-related variables particularly relevant to future validation:

```text
Spread
Slippage
Tick quality
Execution latency
Broker specifications
Stop / freeze levels
```

---

# MFE / MAE Analysis

The Strategy Tester reports:

| Correlation | Result |
|---|---:|
| Profit vs MFE | **0.96** |
| Profit vs MAE | **0.80** |
| MFE vs MAE | **0.6962** |

The strongest reported relationship is:

```text
Correlation (Profit, MFE)
=
0.96
```

The MFE chart shows a strong positive relationship between favorable excursion and realized trade profit.

The MAE chart also shows a relationship between adverse excursion and final trade outcome.

These statistics are useful for studying trade management and exit behavior.

They do **not** establish a predictive entry signal.

---

# Entry Distribution

The supplied entry-distribution chart shows trades concentrated inside the intended post-range trading period.

The primary entry activity occurs around:

```text
09:00
10:00
11:00
12:00
```

with the largest concentration occurring near the beginning of the trading window.

This is consistent with the configured structure:

```text
Range:
08:00 → 09:00

Trading:
09:00 → 13:00
```

The report's order history also confirms that multiple entries can occur during the same trading day.

For example, after one position closes, another qualifying breakout can subsequently generate another entry.

Therefore the baseline is not:

```text
One breakout
per day
```

but rather:

```text
Breakout condition
        ↓
Trade
        ↓
Position closes
        ↓
Another valid crossing may occur
        ↓
Another trade
```

This behavior is important for subsequent research.

---

# Weekday Distribution

Trades occurred across:

```text
Monday
Tuesday
Wednesday
Thursday
Friday
```

with no weekend trading.

The supplied chart shows different entry frequencies between weekdays.

However, entry count alone does not establish whether any particular weekday has a superior trading edge.

Weekday behavior should be evaluated using normalized performance metrics rather than simply selecting the day with the highest historical profit or trade count.

---

# Monthly Distribution

The experiment contains trades during:

```text
January 2026
February 2026
March 2026
```

which corresponds to the documented test period.

The supplied monthly profit/loss chart indicates that losses exceeded profits across the tested months.

This supports the broader observation from the balance curve that the weakness was not produced solely by one isolated end-of-test event.

However, a three-month sample is still insufficient to establish long-term regime robustness.

---

# Equity / Balance Behavior

The balance curve is one of the clearest weaknesses of Baseline #01.

Conceptually:

```text
$1,000
   │
   ├── Early decline
   │
   ├── Temporary recoveries
   │
   ├── Continued lower balance
   │
   └── approximately $856 final balance
```

The balance curve does not show a stable upward equity-generation pattern.

Instead, the overall historical trajectory is downward.

This observation is consistent with:

```text
Net Profit      = -$143.88
Profit Factor   = 0.65
Expected Payoff = -$0.52
Recovery Factor = -0.90
LR Correlation  = -0.92
```

---

# Baseline Assessment

## Result

```text
BASELINE #01
FAIL
```

The tested configuration did not demonstrate positive expectancy.

Primary evidence:

```text
Net Profit      = -$143.88
Profit Factor   = 0.65
Expected Payoff = -$0.52

Profit Trades   = 43.12%
Loss Trades     = 56.88%

Maximum Equity DD
= 15.93%
```

The baseline therefore fails the initial profitability requirement.

---

# What This Result Establishes

The experiment establishes that the specific tested combination:

```text
XAUUSD.PRO
        +
M1
        +
London Range 08:00–09:00
        +
Trading Window 09:00–13:00
        +
Breakout Lookback 20
        +
Breakout Buffer 0
        +
SL 300
        +
TP 600
        +
Break Even
        +
Trailing Stop
```

did **not** demonstrate a positive historical trading edge during:

```text
2026-01-02
→
2026-03-31
```

under the documented broker/test conditions.

---

# What This Result Does NOT Establish

This baseline does **not** establish that:

```text
London Range Breakout
has no trading edge
```

in general.

It also does not establish that:

```text
all London-session definitions fail

all breakout times fail

all range lengths fail

all breakout buffers fail

all BUY trades fail

all SELL trades fail

all exit configurations fail
```

Only the documented baseline configuration has been tested here.

Therefore the correct research conclusion is:

```text
EA-073 Baseline #01
=
FAILED CONFIGURATION
```

not:

```text
London Range Break
=
INVALID STRATEGY
```

---

# Important Baseline Observations

Several structural observations should be retained for later controlled research.

### 1. Negative expectancy

```text
Profit Factor   = 0.65
Expected Payoff = -$0.52
```

The current implementation loses money historically under the tested configuration.

### 2. Directional asymmetry

```text
SELL Win Rate = 47.37%
BUY Win Rate  = 37.90%
```

SELL signals behaved materially differently from BUY signals during this sample.

This requires controlled directional testing.

### 3. Repeated breakout attempts

The order history demonstrates that the EA can execute multiple breakout trades during the same trading day after previous trades close.

Repeated range crossings may therefore contribute materially to total performance.

This must be isolated experimentally rather than assumed to be beneficial or harmful.

### 4. Very short average holding period

```text
Average Holding
=
00:02:27
```

Execution quality may therefore have a meaningful effect on realized results.

### 5. Exit management materially affects realized payoff

Despite:

```text
SL = 300
TP = 600
```

the realized averages were:

```text
Winner = +$2.23
Loser  = -$2.61
```

Break Even and Trailing Stop behavior therefore require separate investigation.

### 6. Session definition requires careful interpretation

The EA uses:

```text
08:00 → 09:00
```

as the London Range based on broker/server time.

This is not automatically equivalent to:

```text
08:00 → 09:00 London local time
```

Future session research must preserve and document the broker/server timezone relationship.

---

# Controlled Research Direction

Broad optimization should **not** begin immediately.

The baseline contains several interacting variables:

```text
Range Time
Trading Window
Direction
Repeated Entries
Breakout Buffer
SL
TP
Break Even
Trailing Stop
```

Optimizing all variables simultaneously would make it difficult to identify which structural change actually improves or damages the strategy.

The next stage should therefore use controlled experiments.

Initial research candidates include:

```text
First Breakout Only
        ↓
BUY vs SELL
        ↓
Range Time
        ↓
Breakout Time
        ↓
Range Size
        ↓
Breakout Displacement
        ↓
Volatility Regime
        ↓
Retest Confirmation
        ↓
Break Even
        ↓
Trailing Stop
        ↓
Timeframe
```

Each experiment should modify one defined strategy dimension while preserving the remaining baseline conditions.

---

# Baseline Preservation Rule

The original baseline evidence must not be overwritten by future tests.

Baseline #01 remains:

```text
EA-073_London_Range_Break
XAUUSD.PRO
M1

2026-01-02
→
2026-03-31

Range:
08:00 → 09:00

Trade End:
13:00

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

Break Even:
ON

Trailing Stop:
ON
```

Result:

```text
Net Profit      = -$143.88
Profit Factor   = 0.65
Expected Payoff = -$0.52
Max Equity DD   = 15.93%
Trades          = 276
Win Rate        = 43.12%
```

This configuration is the control reference for subsequent EA-073 research.

---

# Backtest Evidence

This directory contains the original MT5 Strategy Tester evidence:

```text
Backtest/
└── EA-073_London_Range_Break/
    ├── README.md
    ├── ReportTester-952747(20260922-025429).html
    ├── ReportTester-952747(20260922-025429).png
    ├── ReportTester-952747-hst(20260922-025428).png
    ├── ReportTester-952747-mfemae(20260922-025429).png
    └── ReportTester-952747-holding(20260922-025429).png
```

### Evidence Files

**HTML Report**

```text
ReportTester-952747(20260922-025429).html
```

Primary source for:

```text
Test settings
Inputs
Performance metrics
Drawdown
Trade statistics
Orders
Deals
MFE / MAE
Holding time
```

**Balance Chart**

```text
ReportTester-952747(20260922-025429).png
```

Visual record of the balance trajectory.

**Distribution Chart**

```text
ReportTester-952747-hst(20260922-025428).png
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

**MFE / MAE Chart**

```text
ReportTester-952747-mfemae(20260922-025429).png
```

Visualizes favorable/adverse excursion against realized trade profit.

**Holding-Time Chart**

```text
ReportTester-952747-holding(20260922-025429).png
```

Visualizes realized profit against position holding duration.

---

# Reproducibility

A baseline reproduction should preserve:

```text
EA version
Symbol
Broker data
Timeframe
Historical period
Initial deposit
Leverage

Lot size
SL
TP

Breakout settings

Range start
Range end
Trade end

Break Even settings
Trailing Stop settings
Spread restriction
```

A test that changes any of these variables should be recorded as a separate experiment rather than silently replacing Baseline #01.

---

# Status

```text
EA:
EA-073_London_Range_Break

Baseline Backtest:
COMPLETED

Baseline Result:
FAIL

Baseline Profitability:
NOT CONFIRMED

Positive Expectancy:
NOT DEMONSTRATED

Optimization:
NOT AUTHORIZED AS BASELINE EVIDENCE

Out-of-Sample Validation:
NOT COMPLETED

Walk-Forward Validation:
NOT COMPLETED

Robustness Validation:
NOT COMPLETED

Forward Test:
NOT COMPLETED

Live Trading Validation:
NOT COMPLETED
```

---

## Conclusion

EA-073 Baseline #01 produced:

```text
276 trades
119 winners
157 losers

Net Profit      = -$143.88
Profit Factor   = 0.65
Expected Payoff = -$0.52

Maximum Equity Drawdown
= 15.93%
```

The baseline therefore **fails** as a profitable reference configuration.

The experiment remains valuable because it establishes a reproducible control case for subsequent London Range Break research.

The strategy should remain classified as:

```text
RESEARCH
```

rather than:

```text
VALIDATED
```

until controlled experiments and subsequent out-of-sample, walk-forward, robustness, execution-sensitivity, and forward validation have been completed.

---

## Disclaimer

This backtest documents historical strategy behavior under the specified test conditions.

Historical results do not guarantee future performance.

Nothing in this repository should be considered financial or investment advice.
