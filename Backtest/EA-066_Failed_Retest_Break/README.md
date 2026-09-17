# EA-066 — Failed Retest Break Backtest

## Overview

This directory contains the MetaTrader 5 baseline backtest evidence for:

**EA-066_Failed_Retest_Break**

EA-066 tests a more selective breakout-continuation structure than a simple breakout entry.

The strategy sequence is:

```text
Historical Range
        ↓
Initial Breakout
        ↓
Wait for Retest
        ↓
Require Retest Rejection
        ↓
Wait for New Continuation Candle
        ↓
Break Original Breakout-Candle Extreme
        ↓
Entry
```

The purpose of this baseline test is to determine whether this additional confirmation stage improves the behavior of the breakout-retest concept under the original parameter configuration.

The baseline is preserved unchanged as the reference for future research.

---

## Backtest Environment

| Item | Value |
|---|---|
| Expert Advisor | EA-066_Failed_Retest_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $100.00 |
| Leverage | 1:500 |
| Broker / Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols Tested | 1 |

---

## Baseline Parameters

### Execution

```text
InpLotSize            = 0.01
InpStopLoss           = 300
InpTakeProfit         = 600
InpMagicNumber        = 123066
InpSlippage           = 10
InpMaxSpread          = 30
InpTimeframe          = M1
InpBreakoutLookback   = 20
InpBreakoutBuffer     = 0
```

### Retest

```text
InpRetestTolerance    = 20
InpRetestMaxBars      = 10
```

### Break Even

```text
InpUseBreakEven       = true
InpBreakEvenTrigger   = 150
InpBreakEvenOffset    = 0
```

### Trailing Stop

```text
InpUseTrailingStop    = true
InpTrailingStart      = 200
InpTrailingDistance   = 100
InpTrailingStep       = 10
```

---

# Backtest Results

## Core Performance

| Metric | Result |
|---|---:|
| Total Net Profit | **-$92.01** |
| Gross Profit | $415.94 |
| Gross Loss | -$507.95 |
| Profit Factor | **0.82** |
| Expected Payoff | **-$0.24** |
| Recovery Factor | **-1.00** |
| Sharpe Ratio | **-5.00** |
| AHPR | 0.9958 (-0.42%) |
| GHPR | 0.9934 (-0.66%) |
| LR Correlation | **-0.85** |
| LR Standard Error | 10.85 |

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $92.01 |
| Balance Drawdown Maximal | **$92.01 / 92.01%** |
| Balance Drawdown Relative | **92.01%** |
| Equity Drawdown Absolute | $92.01 |
| Equity Drawdown Maximal | **$92.01 / 92.01%** |
| Equity Drawdown Relative | **92.01%** |

The baseline therefore lost approximately 92% of the initial $100 account during the tested period.

---

# Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | **382** |
| Total Deals | 764 |
| Winning Trades | 181 |
| Losing Trades | 201 |
| Win Rate | **47.38%** |
| Loss Rate | 52.62% |
| BUY Trades | 233 |
| BUY Win Rate | **51.50%** |
| SELL Trades | 149 |
| SELL Win Rate | **40.94%** |

---

## Trade Outcome Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | +$7.01 |
| Largest Loss Trade | -$5.34 |
| Average Profit Trade | **+$2.30** |
| Average Loss Trade | **-$2.53** |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 7 |
| Maximal Consecutive Profit | $22.13 / 6 trades |
| Maximal Consecutive Loss | -$21.21 / 7 trades |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

---

# Position Holding Time

```text
Minimum Holding Time = 00:00:01
Average Holding Time = 00:03:54
Maximum Holding Time = 02:03:00
```

The system behaves primarily as a very short-duration intraday strategy.

The average trade lasts less than four minutes.

This makes the strategy particularly sensitive to:

```text
Spread
Execution
Slippage
Tick quality
Broker conditions
Short-term XAUUSD noise
```

---

# MFE / MAE Statistics

```text
Correlation (Profit, MFE) = 0.96
Correlation (Profit, MAE) = 0.70
Correlation (MFE, MAE)    = 0.6068
```

The strong Profit/MFE relationship indicates that larger favorable excursions generally corresponded with larger realized profits.

However, this did not translate into positive overall expectancy.

---

# Baseline Result

```text
FAIL
```

The original EA-066 configuration is not suitable for deployment.

Primary reasons:

```text
Net Profit       = -$92.01

Profit Factor    = 0.82

Expected Payoff  = -$0.24

Equity Drawdown  = 92.01%

Sharpe Ratio     = -5.00

LR Correlation   = -0.85
```

The balance curve shows substantial long-term deterioration and ends close to account exhaustion.

---

# Entry Selectivity Observation

EA-066 introduced an additional confirmation stage compared with a simpler breakout-retest structure.

The intended sequence is:

```text
Breakout
    ↓
Retest
    ↓
Retest Rejection
    ↓
Break Original Breakout Extreme
    ↓
Entry
```

This reduced the trade sample to:

```text
382 trades
```

during the tested period.

However, additional entry confirmation did not produce positive expectancy under the baseline configuration.

The result therefore does not support the assumption that simply adding another continuation confirmation is sufficient to improve the breakout-retest strategy.

---

# Directional Asymmetry

The baseline shows a meaningful difference between BUY and SELL performance.

```text
BUY Trades       = 233
BUY Win Rate     = 51.50%

SELL Trades      = 149
SELL Win Rate    = 40.94%
```

Difference:

```text
BUY Win Rate - SELL Win Rate
≈ 10.56 percentage points
```

BUY trades performed substantially better than SELL trades by win rate.

However, this observation alone is not sufficient evidence to disable SELL trading.

A controlled BUY-vs-SELL experiment is required before making a strategy change.

---

# Realized Payoff Structure

The baseline uses:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

Nominally:

```text
Risk : Reward ≈ 1 : 2
```

Actual realized results were:

```text
Average Winner = +$2.30
Average Loser  = -$2.53
```

Therefore:

```text
Average Winner < Average Loser
```

The realized reward/risk profile differs significantly from the nominal SL/TP configuration.

This indicates that:

```text
Break Even
Trailing Stop
Price behavior
Execution
```

materially affect actual trade outcomes.

---

# Required Break-Even Win Rate

Using the realized average trade sizes:

```text
Average Win  = 2.30
Average Loss = 2.53
```

Approximate break-even win rate:

```text
2.53 / (2.30 + 2.53)

≈ 52.38%
```

Actual baseline win rate:

```text
47.38%
```

Difference:

```text
≈ -5 percentage points
```

The strategy therefore did not win frequently enough to compensate for its realized average loss size.

---

# Balance Curve Observation

The balance curve shows:

```text
Initial balance around $100
        ↓
Early decline
        ↓
Temporary recoveries
        ↓
Continued deterioration
        ↓
Large mid-test recovery
        ↓
Renewed decline
        ↓
Final balance near $8
```

The curve contains several temporary recovery periods but no stable long-term upward progression.

A substantial recovery around the middle of the test did not persist.

This indicates strong sensitivity to changing market conditions.

---

# Trade Distribution

Entries occurred across most trading hours.

The strategy was active across:

```text
Asian session
European session
US session
```

Trades also occurred throughout the normal trading week.

The baseline therefore does not behave as a narrowly session-specific strategy.

This creates a valid future research question:

```text
Would restricting EA-066 to stronger trading sessions improve expectancy?
```

This requires controlled testing.

---

# Comparison Hypothesis

EA-066 was designed to test whether adding another continuation stage after a valid retest could improve entry quality.

The additional logic creates:

```text
Breakout
+
Retest
+
Rejection
+
Continuation break
```

rather than:

```text
Breakout
+
Retest
+
Immediate entry
```

The baseline result:

```text
Profit Factor = 0.82
Net Profit    = -$92.01
```

shows that the tested confirmation structure did not produce a viable standalone configuration.

This does **not** establish that the broader idea is invalid.

It establishes only that:

```text
EA-066
+
current implementation
+
current parameters
+
XAUUSD.PRO
+
M1
+
2026-01-02 → 2026-03-31
```

did not demonstrate positive expectancy.

---

# Main Research Findings

The baseline provides several useful observations.

## Finding 1 — Additional Confirmation Was Not Sufficient

The extra continuation confirmation reduced trade frequency but did not generate positive expectancy.

---

## Finding 2 — BUY Performed Better Than SELL

```text
BUY Win Rate  = 51.50%
SELL Win Rate = 40.94%
```

Directional asymmetry should therefore be investigated.

---

## Finding 3 — Exit Structure Remains Problematic

Despite nominal:

```text
SL 300
TP 600
```

the realized statistics were:

```text
Average Win  = +$2.30
Average Loss = -$2.53
```

Exit management remains an important research variable.

---

## Finding 4 — Drawdown Remains Extreme

```text
Maximum Equity Drawdown = 92.01%
```

The current configuration exposes nearly the entire account.

This is unacceptable for deployment.

---

## Finding 5 — Market-Regime Dependence Is Visible

The balance curve contains temporary profitable phases followed by renewed deterioration.

The strategy may behave differently across market regimes.

This requires further controlled testing.

---

# Baseline Classification

```text
Strategy Code        = COMPLETE
Baseline Backtest    = COMPLETE
Technical Execution  = PASS
Baseline Performance = FAIL

Net Profit           = -$92.01
Profit Factor        = 0.82
Expected Payoff      = -$0.24
Maximum Equity DD    = 92.01%
Win Rate             = 47.38%

Deployment           = NOT APPROVED
```

---

# Evidence Files

Recommended directory structure:

```text
Backtest/
└── EA-066_Failed_Retest_Break/
    ├── README.md
    ├── ReportTester-952747(20260917-063457).html
    ├── ReportTester-952747(20260917-063457).png
    ├── ReportTester-952747-hst(20260917-063458).png
    ├── ReportTester-952747-mfemae(20260917-063458).png
    └── ReportTester-952747-holding(20260917-063457).png
```

The HTML Strategy Tester report is the primary numerical evidence.

The PNG files provide visual evidence for:

```text
Balance development
Entry distribution
Profit / loss distribution
MFE / MAE behavior
Holding-time behavior
```

---

# Research Status

```text
EA ID                  = EA-066

Strategy               = Failed Retest Break

Symbol                 = XAUUSD.PRO
Timeframe              = M1

Test Period            = 2026-01-02 → 2026-03-31

Initial Capital        = $100
Lot Size               = 0.01

History Quality        = 100% real ticks

Total Trades           = 382

Win Rate               = 47.38%

BUY Win Rate           = 51.50%
SELL Win Rate          = 40.94%

Net Profit             = -$92.01

Profit Factor          = 0.82

Expected Payoff        = -$0.24

Maximum Equity DD      = 92.01%

Baseline Result        = FAIL

Research               = REQUIRED

Live Trading           = NOT APPROVED
```

---

# Next Research Step

The baseline should remain unchanged.

The next stage should investigate the strategy through controlled experiments before broad parameter optimization.

Primary research questions:

```text
RQ01 — Breakout Lookback

RQ02 — Breakout Buffer

RQ03 — Retest Tolerance

RQ04 — Retest Maximum Bars

RQ05 — Continuation Break Requirement

RQ06 — Timeframe

RQ07 — Trading Session

RQ08 — BUY vs SELL Directionality

RQ09 — Break Even

RQ10 — Trailing Stop
```

The key question specific to EA-066 is:

```text
Does requiring price to break the original breakout-candle extreme
after a successful retest actually improve entry quality?
```

This condition should be evaluated independently before additional filters or broad optimization are introduced.

EA-066 remains a research strategy.

It is **not validated for live trading**.
