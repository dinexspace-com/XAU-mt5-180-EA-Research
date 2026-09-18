# EA-068 — Breakout RSI Filter Backtest

## Overview

This directory contains the historical testing evidence for:

```text
EA-068_Breakout_RSI_Filter
```

The EA combines a historical price-range breakout with an RSI momentum filter.

This README documents the first baseline experiment and preserves the result as research evidence regardless of profitability.

---

# Baseline #01

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-068_Breakout_RSI_Filter |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Start | 2026-01-02 |
| Test End | 2026-03-31 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Initial Deposit | $100.00 |
| Currency | USD |
| Leverage | 1:500 |
| Broker | ACCM Intl Limited |
| Server | ACCMIntl-Real |
| MT5 Build | 6182 |

---

## Baseline Parameters

### Execution

```text
Lot Size          = 0.01
Stop Loss         = 300
Take Profit       = 600
Magic Number      = 123068
Slippage          = 10
Maximum Spread    = 30
Timeframe         = M1
Breakout Lookback = 20
Breakout Buffer   = 0
```

### RSI Filter

```text
RSI Period     = 14
RSI Buy Level  = 55
RSI Sell Level = 45
```

### Break Even

```text
Enabled = true
Trigger = 150
Offset  = 0
```

### Trailing Stop

```text
Enabled  = true
Start    = 200
Distance = 100
Step     = 10
```

---

# Results

## Primary Performance

| Metric | Result |
|---|---:|
| Initial Deposit | $100.00 |
| Total Net Profit | **-$93.30** |
| Gross Profit | $357.80 |
| Gross Loss | -$451.10 |
| Profit Factor | **0.79** |
| Expected Payoff | **-$0.25** |
| Recovery Factor | **-0.89** |
| Sharpe Ratio | **-5.00** |

The baseline produced negative historical expectancy.

Gross losses exceeded gross profits, resulting in a Profit Factor below 1.00.

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $93.30 |
| Equity Drawdown Absolute | $93.30 |
| Balance Drawdown Maximal | $104.16 (93.96%) |
| Equity Drawdown Maximal | **$105.17 (94.01%)** |
| Balance Drawdown Relative | 93.96% |
| Equity Drawdown Relative | **94.01%** |

The drawdown is extremely large relative to the $100 initial deposit.

The balance curve shows persistent deterioration during the experiment rather than a stable upward equity progression.

---

# Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | **377** |
| Total Deals | 754 |
| Profitable Trades | 177 (46.95%) |
| Losing Trades | 200 (53.05%) |
| Short Trades | 184 |
| Short Win Rate | 44.57% |
| Long Trades | 193 |
| Long Win Rate | 49.22% |

Overall:

```text
Win Rate  = 46.95%
Loss Rate = 53.05%
```

The strategy generated a sufficient number of trades to expose persistent weaknesses in this baseline configuration.

---

## BUY vs SELL

### Long Trades

```text
Trades   = 193
Win Rate = 49.22%
```

### Short Trades

```text
Trades   = 184
Win Rate = 44.57%
```

BUY trades achieved a higher win rate than SELL trades during this test period.

This directional difference should be investigated separately rather than treated as evidence that BUY-only trading is automatically viable.

---

# Trade Distribution

## Winning Trades

```text
177
46.95%
```

## Losing Trades

```text
200
53.05%
```

The baseline therefore produced:

```text
Losses > Wins
```

while the average losing trade was also slightly larger in absolute value than the average profitable trade.

---

# Average Trade

| Metric | Result |
|---|---:|
| Average Profit Trade | $2.02 |
| Average Loss Trade | -$2.26 |
| Largest Profit Trade | $6.12 |
| Largest Loss Trade | -$3.35 |

The average payoff relationship was:

```text
Average Win  = +$2.02
Average Loss = -$2.26
```

Combined with a win rate below 50%, this produced negative expectancy in the tested configuration.

---

# Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 9 ($10.31) |
| Maximum Consecutive Losses | 8 (-$24.28) |
| Maximal Consecutive Profit | $15.35 (6 trades) |
| Maximal Consecutive Loss | -$24.28 (8 trades) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The maximum losing sequence had a materially larger monetary impact than the corresponding maximum winning sequence.

---

# Position Holding Time

```text
Minimum = 00:00:02
Maximum = 02:03:19
Average = 00:03:52
```

Most positions were short-duration trades.

The average holding time of less than four minutes confirms that the baseline behaves as a high-frequency short-duration M1 strategy rather than a long-hold breakout system.

---

# MFE / MAE

Reported correlations:

```text
Profit vs MFE = 0.95
Profit vs MAE = 0.75
MFE vs MAE    = 0.6335
```

The strong Profit/MFE relationship indicates that favorable excursion is closely associated with realized trade outcome in this sample.

The MFE/MAE charts should be retained as evidence for later exit-management research.

They may help evaluate whether:

```text
Stop Loss
Take Profit
Break Even
Trailing Stop
```

are allowing the strategy to capture favorable price movement efficiently.

No parameter change should be concluded from these correlations alone.

---

# Time Distribution

The Strategy Tester evidence also records:

```text
Entries by hour
Entries by weekday
Entries by month

Profits / losses by hour
Profits / losses by weekday
Profits / losses by month
```

The distribution shows substantial trading activity across multiple intraday hours.

This evidence should later be used for controlled session-filter research rather than retrospectively deleting weak trading hours from the baseline.

---

# Balance Curve

The baseline balance curve demonstrates a persistent long-term decline.

Conceptually:

```text
Initial Balance
     ≈ $100
        ↓
temporary fluctuations
        ↓
repeated drawdowns
        ↓
Final loss
     -$93.30
```

The curve does not demonstrate stable positive expectancy.

The original graph must remain stored with the backtest artifacts.

---

# Baseline Assessment

## Result

```text
STATUS: FAIL
```

Baseline #01 does not satisfy the repository's basic requirement for a viable candidate.

Primary evidence:

```text
Net Profit          = -$93.30
Profit Factor       = 0.79
Expected Payoff     = -$0.25
Equity Drawdown     = 94.01%
Winning Trades      = 46.95%
Recovery Factor     = -0.89
```

The baseline therefore must **not** progress directly to live deployment.

---

# What This Result Establishes

This experiment establishes that the following tested configuration:

```text
20-Bar Breakout
        +
RSI(14)
        +
BUY threshold 55
SELL threshold 45
        +
SL 300
TP 600
        +
Break Even
        +
Trailing Stop
```

did not demonstrate positive expectancy on:

```text
XAUUSD.PRO
M1
2026-01-02 → 2026-03-31
```

under the documented testing environment.

---

# What This Result Does NOT Establish

The result does not establish that:

```text
RSI filtering is ineffective
```

or that:

```text
breakout strategies cannot work
```

or that:

```text
all EA-068 configurations will fail.
```

Only this specific baseline configuration has been tested by this experiment.

---

# Research Interpretation

The baseline provides several research directions.

### 1. RSI Filter Contribution

The first question is whether RSI improves the underlying breakout strategy at all.

Required comparison:

```text
Breakout Only
      vs
Breakout + RSI
```

This should be tested before broad RSI optimization.

### 2. Directional Asymmetry

Observed:

```text
BUY Win Rate  = 49.22%
SELL Win Rate = 44.57%
```

The BUY and SELL components should therefore be evaluated independently.

### 3. Exit Management

Because the system uses:

```text
SL
TP
Break Even
Trailing Stop
```

the entry signal and exit-management logic should not be optimized simultaneously at the beginning.

### 4. Timeframe

The baseline only establishes behavior on:

```text
M1
```

Future research may compare:

```text
M1
M5
M15
```

without assuming that the M1 result transfers to other timeframes.

---

# Next Research Stage

The next controlled experiment should be:

```text
EA068-RQ01
RSI Filter Contribution Evaluation
```

Primary comparison:

```text
A — Breakout without RSI filter

vs

B — Breakout + RSI(14)
    BUY > 55
    SELL < 45
```

All other relevant parameters should remain unchanged where technically possible.

The objective is to answer:

> Does the RSI filter improve the breakout system relative to the corresponding baseline without RSI?

Broad optimization should not begin until this question is answered.

---

# Evidence Files

Preserve the original MetaTrader 5 artifacts together with this README.

Recommended structure:

```text
Backtest/
└── EA-068_Breakout_RSI_Filter/
    ├── README.md
    │
    └── Baseline-01/
        ├── ReportTester-952747.html
        ├── ReportTester-952747.png
        ├── ReportTester-952747-hst.png
        ├── ReportTester-952747-mfemae.png
        └── ReportTester-952747-holding.png
```

The HTML report and its PNG dependencies should remain in the **same directory** so that the original MT5 report continues to render its embedded charts correctly.

---

# Reproducibility

Baseline #01 can be reconstructed from:

```text
EA
EA-068_Breakout_RSI_Filter

Symbol
XAUUSD.PRO

Timeframe
M1

Period
2026-01-02 → 2026-03-31

Model
100% real ticks

Initial Deposit
$100

Leverage
1:500

Lot
0.01

Breakout
Lookback 20
Buffer 0

RSI
Period 14
BUY > 55
SELL < 45

SL / TP
300 / 600

Break Even
ON
150 / 0

Trailing
ON
200 / 100 / 10
```

Original Strategy Tester artifacts remain the authoritative evidence.

---

# Validation Status

```text
EA: EA-068_Breakout_RSI_Filter

Baseline #01: FAIL

Research: IN PROGRESS
Optimization: NOT APPROVED
Out-of-Sample: NOT TESTED
Robustness: NOT TESTED
Forward Test: NOT TESTED

LIVE TRADING: NOT VALIDATED
```

The failed baseline is intentionally preserved as part of the research history.

Future results must not overwrite or replace this experiment.
