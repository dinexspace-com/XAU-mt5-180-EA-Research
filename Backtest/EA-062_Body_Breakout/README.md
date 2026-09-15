# EA-062 — Body Breakout — Backtest

## Overview

This directory contains the baseline MetaTrader 5 backtest evidence for:

**EA-062_Body_Breakout**

The purpose of this baseline experiment is to evaluate the initial Body Breakout hypothesis under a fixed and documented configuration before any strategy optimization is performed.

The core hypothesis is:

> Can a price breakout accompanied by a strong candle body relative to the candle's total range produce positive short-term directional expectancy on XAUUSD?

This backtest is treated as the baseline reference experiment for all subsequent EA-062 research.

---

## Experiment ID

```text
EA062-M1-BASELINE-001
```

---

## Test Environment

```text
Expert Advisor : EA-062_Body_Breakout
Symbol         : XAUUSD.PRO
Timeframe      : M1
Test Start     : 2026-01-02
Test End       : 2026-03-31
History Quality: 100% real ticks
Bars           : 85,161
Ticks          : 39,639,179
Symbols        : 1
Initial Deposit: $100.00
Leverage       : 1:500
Currency       : USD
```

---

## Baseline Parameters

```text
Lot Size             : 0.01
Stop Loss            : 300 points
Take Profit          : 600 points
Magic Number         : 123062
Slippage             : 10 points
Maximum Spread       : 30 points

Timeframe             : M1
Breakout Lookback     : 20
Breakout Buffer       : 0 points
Minimum Body Ratio    : 0.70

Break Even            : ON
Break Even Trigger    : 150 points
Break Even Offset     : 0 points

Trailing Stop         : ON
Trailing Start        : 200 points
Trailing Distance     : 100 points
Trailing Step         : 10 points
```

The baseline strategy therefore requires a breakout from the previous 20-bar range together with a minimum candle Body Ratio of:

```text
70%
```

No broad parameter optimization is represented by this experiment.

---

## Baseline Results

| Metric | Result |
|---|---:|
| Initial Deposit | $100.00 |
| Total Net Profit | **-$93.30** |
| Gross Profit | $598.54 |
| Gross Loss | -$691.84 |
| Profit Factor | **0.87** |
| Expected Payoff | **-$0.16** |
| Recovery Factor | **-0.83** |
| Sharpe Ratio | **-5.00** |
| Total Trades | **577** |
| Total Deals | 1,154 |
| Winning Trades | 299 (51.82%) |
| Losing Trades | 278 (48.18%) |
| Maximum Balance Drawdown | **$112.08 (94.36%)** |
| Maximum Equity Drawdown | **$113.09 (94.41%)** |
| Largest Profit Trade | +$11.85 |
| Largest Loss Trade | -$5.34 |
| Average Profit Trade | +$2.00 |
| Average Loss Trade | -$2.49 |
| Maximum Consecutive Wins | 7 |
| Maximum Consecutive Losses | 10 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

---

## Baseline Return

The account started with:

```text
$100.00
```

and generated:

```text
-$93.30
```

in net historical trading results.

Relative to the initial deposit:

```text
Net Profit / Initial Deposit
= -93.30 / 100
= -93.30%
```

Therefore:

```text
Baseline Return ≈ -93.30%
```

This represents severe capital deterioration under the tested configuration.

---

## Profitability Assessment

The baseline produced:

```text
Profit Factor   : 0.87
Expected Payoff : -$0.16
Recovery Factor : -0.83
Sharpe Ratio    : -5.00
Net Profit      : -$93.30
```

A Profit Factor below:

```text
1.00
```

means that gross historical profits were insufficient to compensate for gross historical losses.

The negative Expected Payoff indicates that the average historical outcome per trade was negative.

The negative Recovery Factor and Sharpe Ratio provide additional evidence that the baseline configuration did not produce acceptable historical risk-adjusted performance.

Therefore:

```text
BASELINE PROFITABILITY = FAIL
```

---

## Win Rate

The EA executed:

```text
577 trades
```

consisting of:

```text
Winning Trades : 299
Losing Trades  : 278
```

Overall historical win rate:

```text
51.82%
```

Loss rate:

```text
48.18%
```

The strategy therefore won slightly more trades than it lost.

However, the positive win rate did not translate into positive expectancy.

---

## Payoff Structure

Average profitable trade:

```text
+$2.00
```

Average losing trade:

```text
-$2.49
```

Therefore:

```text
Average Winner < Average Loser
```

Approximate realized average winner/loss magnitude ratio:

```text
2.00 / 2.49 ≈ 0.80
```

This is materially different from the nominal initial SL/TP relationship of:

```text
SL 300
TP 600

Nominal Risk : Reward = 1 : 2
```

because Break Even, Trailing Stop and actual market execution affect realized trade outcomes.

The baseline therefore demonstrates an important issue:

```text
Win Rate = 51.82%
        +
Average Winner = $2.00
        <
Average Loser = $2.49
        ↓
Negative Historical Expectancy
```

The candle-body breakout filter generated a win rate above 50%, but the realized payoff distribution was insufficient to produce profitability.

---

## BUY vs SELL

Directional results:

```text
Long Trades  : 318
Long Won     : 53.46%

Short Trades : 259
Short Won    : 49.81%
```

BUY signals therefore achieved a higher historical win rate than SELL signals during this baseline period.

Difference:

```text
53.46% - 49.81% = 3.65 percentage points
```

This suggests a possible directional asymmetry in the tested sample.

However:

```text
DO NOT disable SELL based only on this baseline.
```

BUY-only and SELL-only behavior must be evaluated through separate controlled experiments before drawing a conclusion.

---

## Drawdown

The most important risk result is the extremely high drawdown.

```text
Maximum Balance Drawdown:
$112.08 (94.36%)

Maximum Equity Drawdown:
$113.09 (94.41%)
```

With an initial deposit of only:

```text
$100
```

the baseline experienced near-total capital deterioration.

Therefore:

```text
DRAWDOWN = UNACCEPTABLE
```

and the baseline configuration is unsuitable for live deployment.

---

## Consecutive Results

Maximum consecutive winning trades:

```text
7
```

Maximum consecutive losing trades:

```text
10
```

Maximum consecutive loss:

```text
-$27.56 across 10 trades
```

Average consecutive wins:

```text
2
```

Average consecutive losses:

```text
2
```

A 10-trade losing sequence is particularly significant for a system tested with a $100 initial account.

Future research must therefore evaluate not only profitability but also loss clustering and drawdown behavior.

---

## Holding Time

Position holding statistics:

```text
Minimum Holding Time : 00:00:04
Maximum Holding Time : 02:08:02
Average Holding Time : 00:04:23
```

The average trade remained open for approximately:

```text
4 minutes 23 seconds
```

This confirms that the tested EA behaves as a short-duration trading system on M1.

Execution conditions, spread, breakout timing and trade-management behavior are therefore potentially important research variables.

---

## MFE / MAE

The MT5 report produced:

```text
Correlation (Profits, MFE) : 0.95
Correlation (Profits, MAE) : 0.73
Correlation (MFE, MAE)     : 0.6073
```

The strong Profit/MFE correlation indicates that favorable excursion is closely associated with realized profitable outcomes in this sample.

This does not by itself establish a new trading rule.

The MFE/MAE results should instead be retained as evidence for later exit-management research.

---

## Equity Curve Assessment

The balance curve is unstable across the baseline period.

The test initially experiences periods of growth and recovery, but these gains are not sustained.

The later portion of the experiment shows substantial deterioration, eventually reducing the account close to depletion.

This behavior is consistent with the reported:

```text
Net Profit              : -$93.30
Maximum Equity Drawdown : 94.41%
Profit Factor           : 0.87
```

Therefore the strategy does not demonstrate a stable positive equity trajectory under the baseline configuration.

---

## What This Baseline Establishes

This experiment establishes that:

```text
Body Breakout
+
20-Bar Lookback
+
Minimum Body Ratio 0.70
+
M1
+
Current Exit Management
```

did **not** demonstrate acceptable historical profitability under the documented test conditions.

Specifically:

```text
577 trades
51.82% win rate
Profit Factor 0.87
Expected Payoff -$0.16
Net Profit -$93.30
Maximum Equity Drawdown 94.41%
```

The baseline therefore fails both profitability and risk requirements.

---

## What This Baseline Does NOT Establish

This result does not prove that:

```text
Body Breakout has no trading edge.
```

It establishes only that:

```text
EA062-M1-BASELINE-001
```

failed under the documented configuration and test period.

The experiment does not independently answer whether performance could materially differ under:

```text
Different timeframes
Different Body Ratio thresholds
Different breakout lookbacks
Different trading sessions
Different market regimes
BUY-only or SELL-only execution
Different exit management
Longer historical periods
Out-of-sample data
```

These questions require separate controlled experiments.

---

## Baseline Verdict

```text
Experiment ID          : EA062-M1-BASELINE-001

Technical Execution    : PASS
Trade Sample Generated : PASS
History Quality        : PASS
Profitability          : FAIL
Risk / Drawdown        : FAIL
Positive Expectancy    : FAIL
Production Ready       : NO
```

### Final Baseline Classification

```text
FAIL
```

Primary reasons:

```text
Net Profit              = -$93.30
Profit Factor           = 0.87
Expected Payoff         = -$0.16
Recovery Factor         = -0.83
Sharpe Ratio            = -5.00
Maximum Equity Drawdown = 94.41%
```

The baseline configuration must not be treated as validated for live trading.

---

## Research Questions Created by the Baseline

The failed baseline creates the following controlled research questions.

### EA062-RQ01 — Timeframe

Does Body Breakout behave differently on:

```text
M1
M5
M15
```

---

### EA062-RQ02 — Minimum Body Ratio

Does changing:

```text
Minimum Body Ratio
```

improve breakout quality?

Candidate thresholds should be tested only through controlled experiments.

---

### EA062-RQ03 — Breakout Lookback

Does changing:

```text
Breakout Lookback = 20
```

improve signal quality and payoff distribution?

---

### EA062-RQ04 — Trading Session

Does performance differ materially across major XAUUSD trading sessions?

---

### EA062-RQ05 — Market Regime

Does the Body Breakout hypothesis behave differently during:

```text
Trending markets
Ranging markets
High-volatility conditions
Low-volatility conditions
```

---

### EA062-RQ06 — Direction

The baseline produced:

```text
BUY  : 318 trades / 53.46% won
SELL : 259 trades / 49.81% won
```

Does directional filtering improve expectancy?

This must be tested independently.

---

### EA062-RQ07 — Exit Management

Does the current combination of:

```text
SL / TP
Break Even
Trailing Stop
```

cause profitable price excursions to be converted into insufficient realized payoff?

This question is particularly relevant because:

```text
Average Winner = $2.00
Average Loser  = $2.49
```

despite the initial nominal:

```text
1 : 2
```

SL/TP configuration.

---

## Controlled Research Sequence

The recommended sequence is:

```text
EA062-M1-BASELINE-001
        ↓
EA062-RQ01
Timeframe Evaluation
        ↓
EA062-RQ02
Body Ratio Evaluation
        ↓
EA062-RQ03
Breakout Lookback Evaluation
        ↓
EA062-RQ04
Trading Session Evaluation
        ↓
EA062-RQ05
Market-Regime Evaluation
        ↓
EA062-RQ06
BUY vs SELL Evaluation
        ↓
EA062-RQ07
Exit Management Evaluation
        ↓
Longer Historical Backtest
        ↓
Out-of-Sample Validation
        ↓
Robustness Testing
        ↓
Forward Testing
```

Only one major strategy component should be changed per controlled experiment.

Broad optimization is not authorized at the baseline stage.

---

## Evidence Files

The baseline evidence package contains the original MetaTrader 5 Strategy Tester report and associated charts.

Recommended repository structure:

```text
Backtest/
└── EA-062_Body_Breakout/
    ├── README.md
    ├── ReportTester-952747(20260915-021809).html
    ├── ReportTester-952747(20260915-021809).png
    ├── ReportTester-952747-hst(20260915-021809).png
    ├── ReportTester-952747-mfemae(20260915-021809).png
    └── ReportTester-952747-holding(20260915-021809).png
```

The original HTML Strategy Tester report should be retained unchanged as the primary machine-generated evidence.

The PNG files provide visual evidence for:

```text
Balance Curve
Trade Distribution
MFE / MAE
Holding Time
Hourly / Weekday / Monthly Distribution
```

---

## Reproducibility

To reproduce the baseline:

```text
EA       : EA-062_Body_Breakout
Symbol   : XAUUSD.PRO
Timeframe: M1
Period   : 2026-01-02 → 2026-03-31
Model    : Real Ticks
Deposit  : $100
Leverage : 1:500
```

Use:

```text
Lot Size          = 0.01
Stop Loss         = 300
Take Profit       = 600
Maximum Spread    = 30

Breakout Lookback = 20
Breakout Buffer   = 0
Minimum Body Ratio= 0.70

Break Even        = true
BE Trigger        = 150
BE Offset         = 0

Trailing Stop     = true
Trailing Start    = 200
Trailing Distance = 100
Trailing Step     = 10
```

Any future experiment that changes one or more of these values must receive a separate experiment ID and must not overwrite this baseline evidence.

---

## Current Status

```text
EA-062 Strategy Code    : COMPLETE
Baseline Backtest #01   : COMPLETE
Baseline Evidence       : AVAILABLE
Baseline Assessment     : FAIL
Research                : NEXT
Optimization            : BLOCKED
Out-of-Sample Validation: NOT STARTED
Forward Testing         : NOT STARTED
Live Trading            : NOT APPROVED
```

The next stage is controlled research based on the evidence produced by this baseline.

---

## Disclaimer

This backtest is a historical research experiment.

Historical performance does not guarantee future performance.

The baseline result is explicitly classified as **FAIL** and must not be presented as evidence that EA-062 is profitable or suitable for live trading.
