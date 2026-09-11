# Backtest — EA-054 Inside Bar Break

## Overview

This directory contains the MetaTrader 5 Strategy Tester results for:

**EA-054 — Inside Bar Break**

The EA implements a Mother Bar / Inside Bar breakout strategy on XAUUSD. A completed Inside Bar must remain within the range of the preceding Mother Bar. The EA then waits for price to break above or below the Mother Bar range before entering a position.

This backtest represents the baseline test of the strategy using the EA configuration recorded in the original MetaTrader 5 Strategy Tester report.

---

## Test Environment

| Parameter | Value |
|---|---|
| Expert Advisor | EA-054_Inside_Bar_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $1,000.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols | 1 |
| Platform | MetaTrader 5 |
| Broker / Company | ACCM Intl Limited |
| Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| Account Currency | USD |

---

## EA Parameters

### General Trading Settings

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123456 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Maximum Positions | 1 |

### Break Even

| Parameter | Value |
|---|---:|
| Enabled | Yes |
| Trigger | 150 points |
| Offset | 0 points |

### Trailing Stop

| Parameter | Value |
|---|---:|
| Enabled | Yes |
| Trailing Start | 200 points |
| Trailing Distance | 150 points |

### Mother Bar / Inside Bar

| Parameter | Value |
|---|---|
| Require Inside Bar | Yes |

---

# Backtest Results

## Performance Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **+$75.40** |
| Gross Profit | $8,415.15 |
| Gross Loss | -$8,339.75 |
| Profit Factor | **1.01** |
| Expected Payoff | $0.01 |
| Recovery Factor | **0.21** |
| Sharpe Ratio | **1.08** |
| AHPR | 1.0000 (0.00%) |
| GHPR | 1.0000 (0.00%) |
| LR Correlation | 0.37 |
| LR Standard Error | 113.21 |
| Margin Level | 6609.10% |
| Z-Score | -0.72 (52.85%) |

The test finished with a positive net result, but the Profit Factor of 1.01 shows that gross profit and gross loss were almost equal.

This should therefore be treated as a baseline research result rather than evidence of a production-ready trading system.

---

# Drawdown

## Balance Drawdown

| Metric | Result |
|---|---:|
| Absolute Drawdown | $308.33 |
| Maximal Drawdown | $356.08 (33.99%) |
| Relative Drawdown | 33.99% ($356.08) |

## Equity Drawdown

| Metric | Result |
|---|---:|
| Absolute Drawdown | $308.54 |
| Maximal Drawdown | $357.80 (34.10%) |
| Relative Drawdown | **34.10% ($357.80)** |

Maximum equity drawdown reached approximately one-third of the initial account balance.

Compared with the final net profit of $75.40, the strategy required substantially more drawdown than the profit ultimately retained during this test period.

---

# Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | **7,172** |
| Total Deals | 14,344 |
| Winning Trades | 3,707 (51.69%) |
| Losing Trades | 3,465 (48.31%) |
| Short Trades | 3,185 |
| Short Win Rate | 52.90% |
| Long Trades | 3,987 |
| Long Win Rate | 50.71% |

The EA generated a very large trade sample during the approximately three-month M1 test.

The overall win rate was:

**51.69%**

Short positions performed slightly better by win rate than long positions:

```text
Short win rate = 52.90%
Long win rate  = 50.71%
```

---

# Winning vs Losing Trades

| Metric | Result |
|---|---:|
| Largest Profit Trade | +$35.96 |
| Largest Loss Trade | -$33.78 |
| Average Profit Trade | +$2.27 |
| Average Loss Trade | -$2.41 |

Although winning trades occurred slightly more often than losing trades, the average losing trade was larger than the average winning trade.

```text
Average Winner = +$2.27
Average Loser  = -$2.41
```

This helps explain why a win rate above 50% resulted in only a Profit Factor of 1.01.

---

# Consecutive Trades

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 14 |
| Profit During Maximum Win Sequence | +$39.91 |
| Maximum Consecutive Losses | 16 |
| Loss During Maximum Loss Sequence | -$34.77 |
| Maximal Consecutive Profit | +$39.91 (14 trades) |
| Maximal Consecutive Loss | -$34.77 (16 trades) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The longest losing sequence was:

**16 consecutive trades**

while the longest winning sequence was:

**14 consecutive trades**

---

# Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 03:37:13 |
| Average Holding Time | **00:02:44** |

The average position remained open for only 2 minutes and 44 seconds.

This confirms that, under this M1 configuration, EA-054 behaves as a high-frequency short-duration breakout strategy rather than a long-duration trend-following system.

---

# MFE / MAE Analysis

MetaTrader 5 reported the following correlations:

| Correlation | Result |
|---|---:|
| Profit vs MFE | **0.95** |
| Profit vs MAE | **0.70** |
| MFE vs MAE | 0.5442 |

The very high correlation between Profit and Maximum Favorable Excursion (MFE) indicates that profitable outcomes were strongly associated with favorable price movement after entry.

These statistics are retained as part of the baseline evidence for later strategy analysis and optimization.

---

# Balance Curve

The MT5 balance graph shows a highly variable equity path.

The strategy experienced several major phases:

```text
Initial decline
      ↓
Large recovery
      ↓
New equity high
      ↓
Extended drawdown / oscillation
      ↓
Second major decline
      ↓
Recovery toward the end of the test
```

Although the test ended above the initial $1,000 balance, the path was not consistently upward.

This behavior is consistent with the reported:

```text
Profit Factor       = 1.01
Recovery Factor     = 0.21
Max Equity Drawdown = 34.10%
```

---

# Baseline Assessment

## Positive observations

The baseline test demonstrates several useful properties:

- 100% real-tick history quality.
- Large sample of 7,172 trades.
- Positive final net profit.
- Overall win rate above 50%.
- Both BUY and SELL logic generated substantial trade samples.
- Sharpe Ratio remained positive at 1.08.
- Profit/MFE correlation was high at 0.95.
- Strategy completed the entire test period without exhausting the account.

## Main weaknesses

The baseline also exposes significant weaknesses:

- Profit Factor is only 1.01.
- Recovery Factor is only 0.21.
- Maximum equity drawdown reached 34.10%.
- $75.40 net profit was achieved while experiencing $357.80 maximal equity drawdown.
- Average losing trade (-$2.41) exceeds average winning trade (+$2.27).
- Balance growth is unstable.
- Long and short trades both operate close to the break-even boundary.
- The strategy executes more than 7,000 trades in approximately three months, making spread, commission, slippage and execution quality important factors.

---

# Baseline Verdict

```text
Strategy:       EA-054 Inside Bar Break
Symbol:         XAUUSD.PRO
Timeframe:      M1
Period:         2026-01-02 → 2026-03-31
Initial Capital: $1,000

Net Profit:      +$75.40
Profit Factor:    1.01
Win Rate:         51.69%
Max Equity DD:    34.10%
Recovery Factor:  0.21
Sharpe Ratio:     1.08
Trades:           7,172
```

### Research verdict

**BASELINE TEST COMPLETED — NOT YET ACCEPTED AS A ROBUST TRADING CONFIGURATION**

The strategy demonstrated that the Inside Bar / Mother Bar breakout logic can produce a slightly positive result over this test sample.

However, the current configuration has insufficient performance margin:

```text
Profit Factor ≈ 1
+
High Drawdown
+
Low Recovery Factor
+
Large Trade Count
```

The baseline therefore provides useful evidence for further research, but it should not by itself be interpreted as validation for live deployment.

---

# Backtest Evidence

The original MetaTrader 5 Strategy Tester files should be preserved in this directory.

```text
Backtest/
└── EA-054_Inside_Bar_Break/
    ├── README.md
    ├── ReportTester-952747(20260911-004220).html
    ├── ReportTester-952747(20260911-004219).png
    ├── ReportTester-952747-hst(20260911-004219).png
    ├── ReportTester-952747-mfemae(20260911-004219).png
    └── ReportTester-952747-holding(20260911-004219).png
```

### Evidence files

**Main Strategy Tester Report**

`ReportTester-952747(20260911-004220).html`

Contains the complete MT5 Strategy Tester configuration, performance statistics, orders, deals and test results.

**Balance Curve**

`ReportTester-952747(20260911-004219).png`

Shows the balance evolution throughout the backtest.

**Holding-Time Analysis**

`ReportTester-952747-holding(20260911-004219).png`

Shows trade profit relative to position holding time.

**Hourly / Weekday / Monthly Statistics**

`ReportTester-952747-hst(20260911-004219).png`

Shows trade frequency and profit/loss distribution by hour, weekday and month.

**MFE / MAE Analysis**

`ReportTester-952747-mfemae(20260911-004219).png`

Shows trade outcomes relative to Maximum Favorable Excursion and Maximum Adverse Excursion.

---

# Reproducibility

The original MT5 HTML report is retained so that the reported metrics can be independently inspected.

Core test configuration:

```text
EA               = EA-054_Inside_Bar_Break
Symbol           = XAUUSD.PRO
Timeframe        = M1
Period           = 2026-01-02 → 2026-03-31
History Quality  = 100% real ticks
Initial Deposit  = $1,000
Leverage         = 1:500
Lot Size         = 0.01
Stop Loss        = 300 points
Take Profit      = 600 points
Max Spread       = 30 points
Max Positions    = 1
Break Even       = Enabled
BE Trigger       = 150 points
Trailing Stop    = Enabled
Trailing Start   = 200 points
Trailing Distance= 150 points
Inside Bar       = Required
```

---

# Important Note

This backtest is a historical simulation and represents only the tested symbol, timeframe, period, broker data and EA parameters.

Results should not be generalized to other periods, brokers, spreads or market conditions without additional testing.

Backtest performance does not guarantee future trading performance.
