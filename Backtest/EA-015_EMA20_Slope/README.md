# EA-015 — EMA20 Slope — Backtest

## Overview

This directory contains backtest evidence for **EA-015_EMA20_Slope**, an EMA20 slope-based Expert Advisor tested on **XAUUSD.PRO M1** using MetaTrader 5 Strategy Tester.

The results documented below correspond specifically to **Backtest Run #1**.

> Important: The parameters used in this run are not identical to all default parameters of the EA. Results must therefore be interpreted as evidence for this specific test configuration only.

---

## Backtest Run #1

### Test Environment

| Setting         | Value                   |
| --------------- | ----------------------- |
| Expert Advisor  | EA-015_EMA20_Slope      |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Test Period     | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000                  |
| Currency        | USD                     |
| Leverage        | 1:500                   |
| History Quality | 100% real ticks         |
| Bars            | 86,539                  |
| Ticks           | 40,346,891              |

---

## Parameters

### General Parameters

| Parameter      |      Value |
| -------------- | ---------: |
| Lot Size       |       0.01 |
| Stop Loss      | 300 points |
| Take Profit    | 600 points |
| Magic Number   |     123456 |
| Slippage       |  10 points |
| Maximum Spread |  30 points |

### Signal Parameters

| Parameter          | Value |
| ------------------ | ----: |
| EMA Period         |    20 |
| Minimum Trend Bars |     3 |
| Debug Mode         | false |

### Risk Management

| Parameter          |      Value |
| ------------------ | ---------: |
| Break Even         |   Disabled |
| Break Even Trigger | 150 points |
| Trailing Stop      |   Disabled |
| Trailing Trigger   | 200 points |
| Trailing Step      |  50 points |

Because Break Even and Trailing Stop were disabled, their trigger and step values did not actively manage positions during this run.

---

## Results

| Metric                   |                 Result |
| ------------------------ | ---------------------: |
| Total Net Profit         |           **-$992.93** |
| Gross Profit             |              $6,550.19 |
| Gross Loss               |             -$7,543.12 |
| Profit Factor            |               **0.87** |
| Expected Payoff          |             **-$0.28** |
| Recovery Factor          |                  -0.96 |
| Sharpe Ratio             |              **-5.00** |
| Maximum Balance Drawdown | **$1,026.13 / 99.32%** |
| Maximum Equity Drawdown  | **$1,029.12 / 99.32%** |
| Total Trades             |              **3,508** |
| Total Deals              |                  7,016 |

---

## Trade Statistics

### Overall

| Metric               |     Result |
| -------------------- | ---------: |
| Winning Trades       |      1,074 |
| Losing Trades        |      2,434 |
| Win Rate             | **30.62%** |
| Loss Rate            | **69.38%** |
| Average Profit Trade |      $6.10 |
| Average Loss Trade   |     -$3.10 |
| Largest Profit Trade |     $33.22 |
| Largest Loss Trade   |    -$26.90 |

### BUY vs SELL

| Direction    | Trades |   Win Rate |
| ------------ | -----: | ---------: |
| BUY / Long   |  1,805 | **33.30%** |
| SELL / Short |  1,703 | **27.77%** |

BUY trades performed better than SELL trades by win rate in this test, but neither side produced a profitable overall system.

---

## Consecutive Results

| Metric                     |  Result |
| -------------------------- | ------: |
| Maximum Consecutive Wins   |       8 |
| Maximum Consecutive Losses |      18 |
| Maximum Consecutive Profit |  $47.68 |
| Maximum Consecutive Loss   | -$59.42 |
| Average Consecutive Wins   |       1 |
| Average Consecutive Losses |       3 |

---

## Holding Time

| Metric               |       Result |
| -------------------- | -----------: |
| Minimum Holding Time |     00:00:00 |
| Maximum Holding Time |     03:45:55 |
| Average Holding Time | **00:06:33** |

---

## Equity / Balance Observation

The balance curve shows a persistent downward trend over the test period.

The initial balance of approximately $1,000 was almost completely depleted by the end of the test.

This behavior is consistent with:

* Profit Factor below 1.0
* Negative Expected Payoff
* Negative Sharpe Ratio
* 69.38% losing trades
* Approximately 99.32% maximum drawdown

There is no evidence from this run that the tested configuration has a positive trading expectancy.

---

## Run #1 Assessment

### Result: FAIL

This configuration does **not** meet the minimum requirements for a viable trading strategy.

Primary reasons:

1. Profit Factor is below 1.0.
2. Expected Payoff is negative.
3. Net Profit is strongly negative.
4. Maximum Drawdown reaches approximately 99%.
5. Losing trades significantly outnumber winning trades.
6. The balance curve demonstrates persistent capital deterioration.

This result applies only to the parameters tested in **Run #1**.

It does **not** establish that every possible configuration of EA-015_EMA20_Slope will produce the same result.

---

## Important Configuration Note

Run #1 used:

`InpMinTrendBars = 3`

and:

`InpUseBreakEven = false`

`InpUseTrailing = false`

Therefore, this test should **not** be presented as a test of a configuration using Break Even and Trailing Stop.

Any future comparison must record the exact parameter set used for each run.

---

## Evidence Files

The original MetaTrader 5 Strategy Tester report should be retained as the primary evidence for this backtest.

Recommended directory structure:

```text
Backtest/
└── EA-015_EMA20_Slope/
    ├── README.md
    ├── ReportTester-953688.html
    ├── ReportTester-953688.png
    ├── ReportTester-953688-hst.png
    ├── ReportTester-953688-mfemae.png
    └── ReportTester-953688-holding.png
```

The HTML report is the primary source of numerical backtest results.

The PNG files contain the associated Strategy Tester charts.

---

## Current Status

**Backtest Run #1:** FAIL

**Test quality:** 100% real ticks

**Reason for failure:** Negative expectancy and unacceptable drawdown.

**EA research status:** Not concluded from this run alone.

Further tests, if performed, must be stored as separate runs with their exact parameters and results documented independently.
