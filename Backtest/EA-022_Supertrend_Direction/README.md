# EA-022 — Supertrend Direction — Backtest

## Overview

This directory contains the MetaTrader 5 backtest results for:

**EA-022_Supertrend_Direction**

The purpose of this backtest is to evaluate the baseline implementation of the Supertrend Direction strategy before further research or optimization.

> **Backtest Status: FAIL**

The tested configuration does not demonstrate a viable trading edge and should **not** be considered suitable for live trading in its current form.

---

## Test Environment

| Setting          | Value                         |
| ---------------- | ----------------------------- |
| Expert Advisor   | `EA-022_Supertrend_Direction` |
| Symbol           | `XAUUSD.PRO`                  |
| Timeframe        | `M1`                          |
| Test Period      | `2026.01.02 – 2026.08.01`     |
| Initial Deposit  | `$1,000.00`                   |
| Account Currency | `USD`                         |
| Leverage         | `1:500`                       |
| History Quality  | `100% real ticks`             |
| Bars             | `205,636`                     |
| Ticks            | `87,255,913`                  |
| Symbols          | `1`                           |

The test used MetaTrader 5 Strategy Tester with real-tick historical data.

---

## Tested Parameters

### Risk Management

```text
InpLotSize=0.01
InpStopLoss=300
InpTakeProfit=600
InpMagicNumber=123456
InpSlippage=10
InpMaxSpread=50
InpMaxPositions=1
```

### Supertrend

```text
InpAtrPeriod=10
InpMultiplier=3.0
```

### Break Even & Trailing Stop

```text
InpUseBreakEven=false
InpBreakEvenTrigger=150

InpUseTrailingStop=true
InpTrailingStart=200
InpTrailingDistance=200
InpTrailingStep=10
```

**Important:** Break Even was disabled in this backtest even though the trigger parameter remained configured.

---

## Backtest Results

### Core Performance

| Metric           |         Result |
| ---------------- | -------------: |
| Initial Deposit  |    `$1,000.00` |
| Total Net Profit |   **-$992.78** |
| Gross Profit     |    `$2,806.41` |
| Gross Loss       | **-$3,799.19** |
| Profit Factor    |       **0.74** |
| Expected Payoff  |     **-$0.41** |
| Recovery Factor  |      **-1.00** |
| Sharpe Ratio     |      **-5.00** |
| Total Trades     |        `2,429` |
| Total Deals      |        `4,858` |

The EA lost approximately **99.3% of the initial $1,000 test balance** during the tested period.

---

## Drawdown

| Metric                    |             Result |
| ------------------------- | -----------------: |
| Balance Drawdown Absolute |          `$992.78` |
| Balance Drawdown Maximal  | `$993.49 (99.28%)` |
| Balance Drawdown Relative | `99.28% ($993.49)` |
| Equity Drawdown Absolute  |          `$992.78` |
| Equity Drawdown Maximal   | `$995.52 (99.28%)` |
| Equity Drawdown Relative  | `99.28% ($995.52)` |

### Assessment

**FAIL**

A drawdown of approximately `99.28%` represents near-total depletion of the test account.

The balance curve also shows a persistent downward trajectory across the test rather than a temporary isolated drawdown.

---

## Trade Statistics

### Overall

| Metric               |           Result |
| -------------------- | ---------------: |
| Total Trades         |          `2,429` |
| Winning Trades       | `1,140 (46.93%)` |
| Losing Trades        | `1,289 (53.07%)` |
| Average Profit Trade |          `$2.46` |
| Average Loss Trade   |         `-$2.95` |
| Largest Profit Trade |         `$33.85` |
| Largest Loss Trade   |        `-$40.44` |

The strategy has both:

```text
Win Rate < 50%
```

and:

```text
Average Loss > Average Win
```

This combination produces negative expectancy under the tested configuration.

---

## Long vs Short

| Direction |  Trades | Win Rate |
| --------- | ------: | -------: |
| Short     | `1,218` | `48.85%` |
| Long      | `1,211` | `45.00%` |

Short trades performed better than long trades by win rate, but neither side establishes sufficient evidence of profitability in this test.

The long side was weaker:

```text
Long Win Rate = 45.00%
```

compared with:

```text
Short Win Rate = 48.85%
```

---

## Consecutive Results

| Metric                     |               Result |
| -------------------------- | -------------------: |
| Maximum Consecutive Wins   |        `10 ($22.76)` |
| Maximum Consecutive Losses |       `11 (-$30.02)` |
| Maximal Consecutive Profit |  `$41.91 (4 trades)` |
| Maximal Consecutive Loss   | `-$40.49 (2 trades)` |
| Average Consecutive Wins   |                  `2` |
| Average Consecutive Losses |                  `2` |

The strategy experienced up to **11 consecutive losing trades** during the test.

---

## Holding Time

| Metric               |     Result |
| -------------------- | ---------: |
| Minimum Holding Time | `00:00:01` |
| Maximum Holding Time | `02:12:00` |
| Average Holding Time | `00:03:32` |

The strategy therefore operates as a short-duration M1 trading system under this configuration.

Average position duration was approximately:

```text
3 minutes 32 seconds
```

---

## MFE / MAE Statistics

The Strategy Tester reports:

| Correlation   |    Value |
| ------------- | -------: |
| Profit vs MFE |   `0.93` |
| Profit vs MAE |   `0.69` |
| MFE vs MAE    | `0.5213` |

These values are retained as part of the baseline research record.

They should not independently be interpreted as evidence that the strategy is profitable.

---

## Equity / Balance Observation

The balance graph shows a strong and persistent decline over the test.

The account begins at:

```text
$1,000
```

and loses:

```text
$992.78
```

leaving only a very small fraction of the original balance.

The reported linear-regression correlation is:

```text
LR Correlation = -0.99
```

This is consistent with the strongly declining balance curve observed in this specific test.

---

## Baseline Assessment

### Result: ❌ FAIL

The baseline configuration fails the backtest.

Primary evidence:

```text
Net Profit       = -$992.78
Profit Factor    = 0.74
Expected Payoff  = -$0.41
Sharpe Ratio     = -5.00
Max Drawdown     = 99.28%
Winning Trades   = 46.93%
Losing Trades    = 53.07%
LR Correlation   = -0.99
```

The most important issue is not merely the negative final profit.

The strategy exhibits a persistent deterioration of capital across a large sample of:

```text
2,429 trades
```

Therefore this baseline should be preserved as a **failed experimental result**, rather than optimized results being substituted for it.

---

## Research Interpretation

This test establishes a useful baseline:

> The current Supertrend Direction implementation with ATR `10`, multiplier `3.0`, fixed SL `300`, TP `600`, trailing stop enabled, Break Even disabled, and execution on XAUUSD.PRO M1 does not demonstrate a profitable edge over the tested period.

This does **not** establish that every possible Supertrend strategy is unprofitable.

It only establishes that this specific EA configuration failed under this specific test environment.

Further modifications should therefore be treated as new experiments and compared against this baseline.

---

## Backtest Verdict

```text
EA:             EA-022_Supertrend_Direction
Symbol:         XAUUSD.PRO
Timeframe:      M1
Period:         2026.01.02 – 2026.08.01
Trades:         2,429

Net Profit:     -$992.78
Profit Factor:  0.74
Max Drawdown:   99.28%
Win Rate:       46.93%

RESULT:         FAIL
```

### Decision

**Do not proceed to live trading with this configuration.**

The result should be retained as the baseline reference for subsequent research.

---

## Source Files

The original MetaTrader 5 Strategy Tester report and its associated charts should be retained in this directory as evidence for the reported results.

Recommended structure:

```text
Backtest/
└── EA-022_Supertrend_Direction/
    ├── README.md
    ├── ReportTester-953688.html
    ├── ReportTester-953688.png
    ├── ReportTester-953688-hst.png
    ├── ReportTester-953688-mfemae.png
    └── ReportTester-953688-holding.png
```

The HTML report is the primary source of numerical backtest data.

The images preserve the Strategy Tester visual output, including:

* Balance curve
* Entry and profit/loss distributions
* MFE / MAE analysis
* Position holding-time distribution

---

## Disclaimer

This backtest is maintained for research and documentation purposes.

Backtest performance does not guarantee future trading results. This particular test produced a severe loss and should not be interpreted as evidence supporting live deployment.
