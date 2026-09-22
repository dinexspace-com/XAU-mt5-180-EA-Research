# EA-072 — Asian Range Break | Backtest

## Overview

This directory contains the MetaTrader 5 backtest evidence for **EA-072_Asian_Range_Break**.

The purpose of this backtest is to evaluate the baseline implementation of the Asian Range Break strategy on XAUUSD before further optimization or strategy modification.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-072_Asian_Range_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Broker / Company | ACCM Intl Limited |
| MT5 Build | 6182 |

---

## EA Configuration

```text
Lot Size             = 0.01
Stop Loss            = 300 points
Take Profit          = 600 points
Magic Number         = 123072
Slippage             = 10 points
Maximum Spread       = 30 points

Timeframe             = M1
Breakout Lookback     = 20
Breakout Buffer       = 0

Break Even            = true
BE Trigger            = 150 points
BE Offset             = 0 points

Trailing Stop         = true
Trailing Start        = 200 points
Trailing Distance     = 100 points
Trailing Step         = 10 points

Range Start Hour      = 00
Range End Hour        = 08
Trade End Hour        = 16
```

All session hours use broker/server time.

---

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$50.08 |
| Gross Profit | $295.64 |
| Gross Loss | -$345.72 |
| Profit Factor | 0.86 |
| Expected Payoff | -$0.19 |
| Recovery Factor | -0.50 |
| Sharpe Ratio | -5.00 |
| Total Trades | 265 |
| Winning Trades | 126 (47.55%) |
| Losing Trades | 139 (52.45%) |
| Long Trades | 154 |
| Long Win Rate | 49.35% |
| Short Trades | 111 |
| Short Win Rate | 45.05% |

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $80.79 |
| Balance Drawdown Maximal | $98.53 (9.68%) |
| Equity Drawdown Absolute | $83.18 |
| Equity Drawdown Maximal | $100.92 (9.92%) |

The account started with an initial deposit of **$1,000** and generated a **-$50.08** net result during the test period.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Winning Trade | $6.39 |
| Largest Losing Trade | -$3.89 |
| Average Winning Trade | $2.35 |
| Average Losing Trade | -$2.49 |
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Losses | 8 |
| Maximum Consecutive Profit | $16.75 |
| Maximum Consecutive Loss | -$23.28 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

---

## Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Average Holding Time | 00:01:29 |
| Maximum Holding Time | 00:17:55 |

The tested implementation therefore generated predominantly short-duration trades during this test window.

---

## MFE / MAE Analysis

MetaTrader 5 reported:

```text
Correlation (Profit, MFE) = 0.96
Correlation (Profit, MAE) = 0.71
Correlation (MFE, MAE)    = 0.6159
```

The accompanying MFE/MAE charts are retained as part of the raw backtest evidence.

---

## Baseline Assessment

This baseline configuration was **not profitable** during the tested period.

Key observations from the raw MT5 report:

- Total Net Profit: **-$50.08**
- Profit Factor: **0.86**
- Expected Payoff: **-$0.19**
- Winning Trades: **47.55%**
- Losing Trades: **52.45%**
- Maximum Balance Drawdown: **9.68%**
- Maximum Equity Drawdown: **9.92%**
- The final balance remained below the initial account balance.

This test should therefore be treated as a **baseline research result**, not as evidence of a production-ready trading system.

No parameter configuration should be considered validated solely from this test.

---

## Backtest Evidence

The directory retains the original MetaTrader 5 Strategy Tester artifacts:

```text
EA-072_Asian_Range_Break/
├── README.md
├── ReportTester-952747(20260922-024605).html
├── ReportTester-952747(20260922-024605).png
├── ReportTester-952747-hst(20260922-024604).png
├── ReportTester-952747-mfemae(20260922-024604).png
└── ReportTester-952747-holding(20260922-024605).png
```

### HTML Report

`ReportTester-952747(20260922-024605).html`

Original MetaTrader 5 Strategy Tester report containing test settings, performance statistics, orders, deals, and execution evidence.

### Balance Chart

`ReportTester-952747(20260922-024605).png`

Balance evolution across the complete backtest.

### Entry Distribution

`ReportTester-952747-hst(20260922-024604).png`

Distribution of entries and profit/loss by hour, weekday, and month.

### MFE / MAE

`ReportTester-952747-mfemae(20260922-024604).png`

Relationship between trade profit and Maximum Favorable Excursion / Maximum Adverse Excursion.

### Holding Time

`ReportTester-952747-holding(20260922-024605).png`

Distribution of position holding times.

---

## Reproducibility

The original HTML report and associated charts are preserved so that the published result can be independently inspected against the raw MetaTrader 5 output.

This backtest represents the following specific test environment:

```text
Expert:        EA-072_Asian_Range_Break
Symbol:        XAUUSD.PRO
Timeframe:     M1
Period:        2026-01-02 → 2026-03-31
Deposit:       $1,000
Leverage:      1:500
History:       100% real ticks
Broker:        ACCM Intl Limited
```

Results should not be assumed to remain identical under different brokers, symbols, spreads, execution conditions, server timezones, historical periods, or parameter configurations.

---

## Status

**Baseline Backtest: COMPLETED**

**Baseline Profitability: NOT CONFIRMED**

The result is retained as research evidence and as the baseline reference for subsequent strategy analysis and optimization.

---

## Disclaimer

This backtest is provided for quantitative research and software testing purposes.

Historical and simulated performance does not guarantee future trading results. XAUUSD and other leveraged financial instruments involve substantial risk.
