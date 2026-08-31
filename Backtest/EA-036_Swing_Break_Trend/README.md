# EA-036 — Swing Break Trend — Backtest Report

## Overview

This directory contains the backtest evidence and evaluation of:

**EA-036 — Swing Break Trend**

The test was performed using the MetaTrader 5 Strategy Tester on **XAUUSD.PRO, M1**, using **100% real ticks**.

The purpose of this backtest is to evaluate the baseline behavior of the strategy before further research or optimization.

> **Backtest Status:** FAIL
> **Reason:** The tested configuration produced negative expectancy, Profit Factor below 1.0, and approximately 99% maximum drawdown.

---

## Test Configuration

| Parameter       | Value                      |
| --------------- | -------------------------- |
| Expert Advisor  | `EA-036_Swing_Break_Trend` |
| Symbol          | `XAUUSD.PRO`               |
| Timeframe       | `M1`                       |
| Test Period     | `2026.01.02 – 2026.04.01`  |
| Broker / Server | `ACCMIntl-Real`            |
| MT5 Build       | `6140`                     |
| Company         | `ACCM Intl Limited`        |
| Currency        | `USD`                      |
| Initial Deposit | `$1,000.00`                |
| Leverage        | `1:500`                    |
| History Quality | `100% real ticks`          |
| Bars            | `86,539`                   |
| Ticks           | `40,346,891`               |
| Symbols         | `1`                        |

---

## EA Parameters

### Lot & Order Settings

| Parameter        |    Value |
| ---------------- | -------: |
| `InpLotSize`     |   `0.01` |
| `InpMagicNumber` | `123456` |
| `InpSlippage`    |     `10` |

### Risk Management

| Parameter       | Value |
| --------------- | ----: |
| `InpStopLoss`   | `300` |
| `InpTakeProfit` | `600` |

### Break Even / Trailing

| Parameter             |   Value |
| --------------------- | ------: |
| `InpUseBreakEven`     | `false` |
| `InpBreakEvenTrigger` |   `150` |
| `InpBreakEvenLock`    |     `0` |
| `InpUseTrailing`      |  `true` |
| `InpTrailingStart`    |   `200` |
| `InpTrailingStep`     |    `50` |

### Filters

| Parameter      | Value |
| -------------- | ----: |
| `InpMaxSpread` |  `35` |
| `InpSwingBars` |   `5` |

> Important: this backtest used `InpUseBreakEven=false` and `InpMaxSpread=35`. These settings should be preserved when reproducing this exact test.

---

## Performance Summary

| Metric            |             Result |
| ----------------- | -----------------: |
| Initial Deposit   |        `$1,000.00` |
| Total Net Profit  |       **-$994.01** |
| Gross Profit      |        `$7,676.10` |
| Gross Loss        |       `-$8,670.11` |
| Profit Factor     |           **0.89** |
| Expected Payoff   | **-$0.22 / trade** |
| Recovery Factor   |          **-0.97** |
| Sharpe Ratio      |          **-5.00** |
| AHPR              |  `0.9993 (-0.07%)` |
| GHPR              |  `0.9989 (-0.11%)` |
| LR Correlation    |          **-0.97** |
| LR Standard Error |            `71.28` |
| Margin Level      |           `96.95%` |

The baseline configuration was not profitable during the tested period.

The account lost:

```text
$994.01
```

from an initial:

```text
$1,000.00
```

leaving approximately:

```text
$5.99
```

based on the reported net result.

---

## Drawdown

### Balance Drawdown

| Metric            |               Result |
| ----------------- | -------------------: |
| Absolute Drawdown |            `$994.01` |
| Maximum Drawdown  | `$1,027.43 (99.42%)` |
| Relative Drawdown | `99.42% ($1,027.43)` |

### Equity Drawdown

| Metric            |               Result |
| ----------------- | -------------------: |
| Absolute Drawdown |            `$994.01` |
| Maximum Drawdown  | `$1,027.43 (99.42%)` |
| Relative Drawdown | `99.42% ($1,027.43)` |

Maximum drawdown reached:

```text
99.42%
```

This represents near-total depletion of the tested account.

The balance curve confirms a persistent downward trend across the test, with temporary recoveries failing to reverse the overall decline.

---

## Trade Statistics

| Metric         |           Result |
| -------------- | ---------------: |
| Total Trades   |          `4,573` |
| Total Deals    |          `9,146` |
| Winning Trades | `1,845 (40.35%)` |
| Losing Trades  | `2,728 (59.65%)` |

### BUY / SELL Performance

| Direction |  Trades | Win Rate |
| --------- | ------: | -------: |
| Short     | `2,137` | `37.25%` |
| Long      | `2,436` | `43.06%` |

Long positions performed better than short positions in terms of win rate:

```text
Long:  43.06%
Short: 37.25%
```

However, neither direction produced a sufficiently high win rate to make the complete tested configuration profitable.

---

## Winning vs Losing Trades

```text
Winning trades: 1,845
Losing trades:  2,728
```

Distribution:

```text
Wins   = 40.35%
Losses = 59.65%
```

The strategy therefore lost more trades than it won during this test.

---

## Trade Profit / Loss Characteristics

| Metric               |    Result |
| -------------------- | --------: |
| Largest Profit Trade |  `$34.34` |
| Largest Loss Trade   | `-$27.60` |
| Average Profit Trade |   `$4.16` |
| Average Loss Trade   |  `-$3.18` |

The average winning trade was larger than the average losing trade:

```text
Average Win  = $4.16
Average Loss = $3.18
```

Approximate average win/loss magnitude ratio:

```text
4.16 / 3.18 ≈ 1.31
```

However, this payoff advantage was insufficient to compensate for the `40.35%` overall win rate.

The final Profit Factor remained:

```text
0.89
```

which means gross losses exceeded gross profits.

---

## Consecutive Results

| Metric                     |               Result |
| -------------------------- | -------------------: |
| Maximum Consecutive Wins   |         `8 ($32.33)` |
| Maximum Consecutive Losses |       `16 (-$52.63)` |
| Maximal Consecutive Profit |  `$39.75 (7 trades)` |
| Maximal Consecutive Loss   | `-$54.75 (8 trades)` |
| Average Consecutive Wins   |                  `2` |
| Average Consecutive Losses |                  `3` |

The strategy experienced a maximum losing sequence of:

```text
16 consecutive trades
```

compared with:

```text
8 consecutive winning trades
```

Average losing sequences were also longer:

```text
Average wins sequence   = 2
Average losses sequence = 3
```

---

## Position Holding Time

| Metric               |     Result |
| -------------------- | ---------: |
| Minimum Holding Time | `00:00:33` |
| Maximum Holding Time | `02:28:03` |
| Average Holding Time | `00:03:04` |

The strategy therefore operated as a relatively high-frequency short-duration system in this M1 test.

Most positions were held for only a few minutes on average.

---

## MFE / MAE Analysis

The Strategy Tester reported:

| Correlation   |   Result |
| ------------- | -------: |
| Profit vs MFE |   `0.87` |
| Profit vs MAE |   `0.78` |
| MFE vs MAE    | `0.6100` |

### Profit vs MFE

```text
Correlation = 0.87
```

There is a strong positive relationship between Maximum Favorable Excursion and final trade profit in this test.

Trades that moved further in the favorable direction generally produced better realized outcomes.

### Profit vs MAE

```text
Correlation = 0.78
```

The tester also reports a relatively strong correlation between profit and Maximum Adverse Excursion.

These correlations describe the tested trade population but do not by themselves establish a profitable trading edge.

---

## Balance Curve

The balance curve is the clearest failure signal in this test.

Starting balance:

```text
≈ $1,000
```

Ending balance based on reported net profit:

```text
≈ $5.99
```

The curve shows a predominantly declining trajectory across the approximately 4,573 trades.

There are several temporary recovery periods, but none produces a sustained reversal.

This behavior is consistent with the reported:

```text
Profit Factor      = 0.89
Expected Payoff    = -$0.22
Sharpe Ratio       = -5.00
LR Correlation     = -0.97
Maximum Drawdown   = 99.42%
```

---

## Entry Distribution

The Strategy Tester charts show that the EA generated trades throughout much of the trading day.

Activity is not evenly distributed by hour.

The test also contains trading activity across the normal weekday trading sessions, with Monday through Friday accounting for the overwhelming majority of entries.

The report covers:

```text
January 2026
February 2026
March 2026
```

with the test ending on:

```text
2026.04.01
```

The monthly chart indicates substantially more entries in January than in February and very little activity represented for March.

This section is descriptive only. The chart alone is not sufficient evidence that a particular hour, weekday, or month should be removed from the strategy.

---

## Key Findings

### 1. Baseline strategy failed profitability

The strongest result is:

```text
Profit Factor = 0.89
```

Gross Profit:

```text
$7,676.10
```

was lower than Gross Loss:

```text
$8,670.11
```

The tested system therefore had negative expectancy.

---

### 2. Drawdown is unacceptable

Maximum balance and equity drawdown reached:

```text
99.42%
```

This alone makes the tested configuration unsuitable for deployment.

---

### 3. Trade frequency is very high

The EA executed:

```text
4,573 trades
```

during approximately three months of M1 testing.

Average position duration was only:

```text
3 minutes 4 seconds
```

This indicates that the Swing Break logic on M1 generated frequent short-duration trades.

---

### 4. Loss frequency exceeds win frequency

Overall:

```text
Win Rate  = 40.35%
Loss Rate = 59.65%
```

Although the average winner was larger than the average loser, the difference was insufficient to overcome the frequency of losing trades.

---

### 5. Long side performed better than short side

```text
Long Win Rate  = 43.06%
Short Win Rate = 37.25%
```

This is a measurable difference in the test results.

It may justify separate research of BUY and SELL behavior, but this backtest alone is not sufficient to conclude that short trades should be disabled.

---

### 6. Balance deterioration was persistent

The reported:

```text
LR Correlation = -0.97
```

is consistent with the visibly strong downward trend in the balance curve.

The strategy did not fail because of only one isolated loss event.

Performance deteriorated across a large number of trades.

---

## Backtest Verdict

```text
BACKTEST RESULT: FAIL
```

### Reasons

```text
[FAIL] Total Net Profit < 0
[FAIL] Profit Factor < 1.00
[FAIL] Expected Payoff < 0
[FAIL] Sharpe Ratio < 0
[FAIL] Maximum Drawdown ≈ 99%
[FAIL] Balance curve has strong negative trend
```

The tested configuration does **not** demonstrate a viable trading edge.

---

## What This Test Does Prove

This test provides useful evidence even though the result failed.

It demonstrates that the EA:

```text
✓ executes trades
✓ produces both BUY and SELL positions
✓ applies SL / TP
✓ operates over real-tick historical data
✓ generates a large statistical sample
✓ can complete an extended MT5 Strategy Tester run
```

The sample contains:

```text
4,573 trades
40,346,891 ticks
86,539 bars
```

Therefore, the test is useful as a **baseline research result**.

---

## What This Test Does Not Prove

This backtest does not establish:

```text
✗ profitability
✗ robustness
✗ optimal parameters
✗ out-of-sample performance
✗ forward performance
✗ suitability for live trading
```

It also does not prove that changing one individual parameter will make the strategy profitable.

Further tests must be evaluated independently.

---

## Research Decision

The current configuration should **not proceed to live trading**.

Status:

```text
EA-036
│
├── Code execution       → TESTED
├── MT5 backtest         → COMPLETED
├── Real tick dataset    → 100%
│
└── Strategy performance → FAIL
```

The result should be retained rather than discarded because it establishes the baseline performance of the current strategy configuration.

---

## Backtest Evidence

The original MetaTrader 5 Strategy Tester artifacts should be stored in this directory.

Recommended structure:

```text
Backtest/
└── EA-036_Swing_Break_Trend/
    │
    ├── README.md
    │
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

### Evidence Files

`ReportTester-952747.html`

Full MetaTrader 5 Strategy Tester report containing configuration, performance statistics, orders, deals, and detailed test records.

`ReportTester-952747.png`

Balance curve generated by MetaTrader 5.

`ReportTester-952747-hst.png`

Distribution of entries and profit/loss by hour, weekday, and month.

`ReportTester-952747-mfemae.png`

MFE / MAE analysis.

`ReportTester-952747-holding.png`

Trade holding-time distribution.

These original files should remain unchanged so that the reported statistics can be independently checked against the MT5 Strategy Tester output.

---

## Reproduction Reference

To reproduce this baseline test, use:

```text
Expert:               EA-036_Swing_Break_Trend
Symbol:               XAUUSD.PRO
Timeframe:            M1

Period:
2026.01.02 - 2026.04.01

Initial Deposit:      1000 USD
Leverage:             1:500

Lot Size:             0.01
Magic Number:         123456
Slippage:             10

Stop Loss:            300
Take Profit:          600

Break Even:           false
BE Trigger:           150
BE Lock:              0

Trailing Stop:        true
Trailing Start:       200
Trailing Step:        50

Maximum Spread:       35
Swing Bars:           5

History Quality:
100% real ticks
```

---

## Final Status

```text
EA:          EA-036_Swing_Break_Trend
Market:      XAUUSD.PRO
Timeframe:   M1
Period:      2026.01.02 - 2026.04.01
Trades:      4,573

Net Profit:  -$994.01
PF:          0.89
Win Rate:    40.35%
Max DD:      99.42%

RESULT:      FAIL
```

**Conclusion:** EA-036 successfully executed its Swing Break strategy over a substantial real-tick test sample, but the tested M1 configuration showed negative expectancy and near-total account drawdown. This configuration must therefore be treated as a failed baseline rather than a deployable trading system.
