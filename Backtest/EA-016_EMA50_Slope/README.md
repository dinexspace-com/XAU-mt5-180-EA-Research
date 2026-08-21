# EA-016 — EMA50 Slope Backtest

## Overview

This directory contains the MetaTrader 5 Strategy Tester results for:

**EA-016_EMA50_Slope**

The purpose of this backtest is to establish a baseline for the EMA50 Slope strategy before further modification, filtering, or optimization.

The results documented here represent the tested configuration only and should not be interpreted as evidence of future profitability.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | `EA-016_EMA50_Slope` |
| Symbol | `XAUUSD.PRO` |
| Timeframe | `M1` |
| Test Period | `2026.01.02 - 2026.06.08` |
| History Quality | `100% real ticks` |
| Bars | `151,130` |
| Ticks | `65,497,516` |
| Initial Deposit | `$1,000.00` |
| Currency | `USD` |
| Leverage | `1:500` |
| MT5 Build | `6090` |

---

## Tested Parameters

### General Parameters

| Parameter | Value |
|---|---:|
| `InpLotSize` | `0.01` |
| `InpStopLoss` | `300` |
| `InpTakeProfit` | `600` |
| `InpMagicNumber` | `123456` |
| `InpSlippage` | `10` |
| `InpMaxSpread` | `30` |

### Signal Parameters

| Parameter | Value |
|---|---:|
| `InpEMAPeriod` | `50` |
| `InpMinTrendBars` | `2` |
| `InpDebugMode` | `false` |

### Position Management

| Parameter | Value |
|---|---:|
| `InpUseBreakEven` | `false` |
| `InpBreakEvenTrigger` | `150` |
| `InpUseTrailing` | `false` |
| `InpTrailingTrigger` | `200` |
| `InpTrailingStep` | `50` |

Break Even and Trailing Stop were disabled in this baseline test.

Therefore, this run primarily evaluates the EMA50 slope entry logic with fixed Stop Loss and Take Profit.

---

# Backtest Results

## Performance Summary

| Metric | Result |
|---|---:|
| Initial Deposit | `$1,000.00` |
| Total Net Profit | `-$992.38` |
| Gross Profit | `$6,214.27` |
| Gross Loss | `-$7,206.65` |
| Profit Factor | `0.86` |
| Expected Payoff | `-$0.30` |
| Recovery Factor | `-0.94` |
| Sharpe Ratio | `-5.00` |
| AHPR | `0.9989 (-0.11%)` |
| GHPR | `0.9985 (-0.15%)` |
| LR Correlation | `-0.99` |

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | `$992.38` |
| Balance Drawdown Maximal | `$1,048.11 (99.28%)` |
| Balance Drawdown Relative | `99.28% ($1,048.11)` |
| Equity Drawdown Absolute | `$992.38` |
| Equity Drawdown Maximal | `$1,051.10 (99.28%)` |
| Equity Drawdown Relative | `99.28% ($1,051.10)` |

The baseline configuration experienced approximately **99.28% drawdown** during the tested period.

This is the primary failure condition of the current configuration.

---

# Trade Statistics

## Overall

| Metric | Result |
|---|---:|
| Total Trades | `3,338` |
| Total Deals | `6,676` |
| Winning Trades | `1,013 (30.35%)` |
| Losing Trades | `2,325 (69.65%)` |

The strategy generated a large sample of trades during the test period, but losing trades substantially outnumbered winning trades.

---

## Long vs Short

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | `1,739` | `32.72%` |
| Short | `1,599` | `27.77%` |

Long trades performed better than short trades by win rate in this test.

However, neither side demonstrates sufficient standalone evidence of profitability from this report alone.

---

## Winner / Loser Characteristics

| Metric | Result |
|---|---:|
| Largest Profit Trade | `$33.22` |
| Largest Loss Trade | `-$42.47` |
| Average Profit Trade | `$6.13` |
| Average Loss Trade | `-$3.10` |
| Maximum Consecutive Wins | `6 ($37.17)` |
| Maximum Consecutive Losses | `18 (-$58.20)` |
| Average Consecutive Wins | `1` |
| Average Consecutive Losses | `3` |

Average winning trades are larger than average losing trades:

```text
Average Winner = $6.13
Average Loser  = -$3.10
```

However, the win rate of only `30.35%` is insufficient to overcome the frequency of losses under the tested configuration.

---

# Position Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | `00:00:00` |
| Average Holding Time | `00:07:09` |
| Maximum Holding Time | `03:45:55` |

The strategy behaves as a short-duration M1 trading system in this test, with an average position duration of approximately seven minutes.

---

# MFE / MAE Analysis

The Strategy Tester reported:

| Correlation | Result |
|---|---:|
| Profit vs MFE | `0.82` |
| Profit vs MAE | `0.65` |
| MFE vs MAE | `0.3858` |

The relatively strong Profit/MFE correlation indicates that favorable price movement is meaningfully associated with realized trade profit.

These values are descriptive statistics from this backtest and are not sufficient by themselves to establish a strategy improvement.

---

# Equity / Balance Behavior

The balance curve shows a persistent downward trajectory across the test.

The account begins with approximately:

```text
$1,000
```

and loses almost the entire initial balance by the end of the tested period.

This behavior is consistent with:

```text
Total Net Profit = -$992.38
Profit Factor    = 0.86
Drawdown         = 99.28%
LR Correlation   = -0.99
```

The strongly negative LR Correlation is also consistent with the visually persistent downward balance trend.

---

# Baseline Assessment

## Result: FAIL

The tested configuration does **not** pass the baseline profitability test.

Primary evidence:

```text
Net Profit      = -$992.38
Profit Factor   = 0.86
Expected Payoff = -$0.30
Max Drawdown    = 99.28%
Sharpe Ratio    = -5.00
```

The account effectively approaches depletion during the tested period.

Therefore:

**EA-016_EMA50_Slope in this tested configuration is not suitable for live deployment.**

This result should be treated as a research baseline rather than a production-ready strategy.

---

# Important Research Observation

The test used:

```text
InpEMAPeriod     = 50
InpMinTrendBars  = 2
Break Even       = OFF
Trailing Stop    = OFF
```

This is important because the backtest is not identical to every default value documented in the EA source/README.

The result belongs specifically to this tested parameter set.

Any future modification must be recorded as a separate test rather than replacing or reinterpreting this baseline result.

---

# Source Metadata Note

Although the tested Expert Advisor is:

```text
EA-016_EMA50_Slope
```

and the tested EMA parameter is:

```text
InpEMAPeriod = 50
```

the Strategy Tester order comments still contain legacy text such as:

```text
EMA20 Trend EA Buy
EMA20 Trend EA Sell
```

These comments are legacy source metadata and should not be interpreted as evidence that the backtest used EMA20.

The Strategy Tester settings explicitly record:

```text
InpEMAPeriod = 50
```

---

# Evidence Files

The original MetaTrader 5 Strategy Tester report and its associated charts should be preserved in this directory.

Recommended structure:

```text
Backtest/
└── EA-016_EMA50_Slope/
    ├── README.md
    ├── ReportTester-953688(1).html
    ├── ReportTester-953688(1).png
    ├── ReportTester-953688-hst(1).png
    ├── ReportTester-953688-mfemae(1).png
    └── ReportTester-953688-holding(1).png
```

### Evidence Description

`ReportTester-953688(1).html`

- Original MetaTrader 5 Strategy Tester report.
- Primary source for test settings, performance statistics, orders, and deals.

`ReportTester-953688(1).png`

- Balance curve.

`ReportTester-953688-hst(1).png`

- Entry distribution and profit/loss distribution by hour, weekday, and month.

`ReportTester-953688-mfemae(1).png`

- MFE / MAE analysis.

`ReportTester-953688-holding(1).png`

- Position holding-time distribution.

The original evidence files should remain unchanged so that the reported results can be independently checked against the Strategy Tester output.

---

# Research Status

```text
EA:                  EA-016_EMA50_Slope
Baseline Backtest:   COMPLETED
History Quality:     100% real ticks
Sample Size:         3,338 trades

Baseline Result:     FAIL

Reason:
- Net Profit < 0
- Profit Factor < 1
- Expected Payoff < 0
- Drawdown ≈ 99%
- Persistent declining balance curve

Optimization:        NOT EVALUATED HERE
Forward Test:        NOT EVALUATED
Live Validation:     NOT EVALUATED
```

---

# Conclusion

The baseline test provides a sufficiently large trade sample to demonstrate that the tested configuration has a negative expectancy over this specific XAUUSD.PRO M1 test period.

The key issue is not a lack of trading opportunities.

The EA generated:

```text
3,338 trades
```

but only:

```text
30.35% winning trades
```

resulting in:

```text
Profit Factor = 0.86
Net Profit    = -$992.38
Drawdown      = 99.28%
```

Therefore, the current baseline should be retained as a **failed research result** and used as a reference point for subsequent EA-016 experiments.

No live-trading claim is supported by this backtest.
