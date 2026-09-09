# EA-049 — 20-Bar Donchian Breakout Backtest

## Overview

This directory contains the MetaTrader 5 backtest results for:

**EA-049 — 20-Bar Donchian Breakout**

The purpose of this backtest is to establish a baseline performance result for the EA before further parameter research and optimization.

---

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-049_20-Bar_Donchian |
| Symbol | XAUUSD.PRO |
| Timeframe | M5 |
| Test Period | 2026.01.02 — 2026.04.01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 17,327 |
| Ticks | 40,346,891 |

---

## EA Parameters

### Trade Settings

```text
InpLotSize=0.01
InpMagicNumber=123456
InpSlippage=10
```

### Donchian Parameters

```text
InpDonchianPeriod=20
InpMaxSpread=30
```

### Risk Management

```text
InpStopLoss=300
InpTakeProfit=600
```

### Break Even & Trailing

```text
InpUseBreakEven=true
InpBreakEvenTrigger=150
InpUseTrailingStop=true
InpTrailingStart=200
```

---

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | $14.59 |
| Gross Profit | $87.43 |
| Gross Loss | -$72.84 |
| Profit Factor | 1.20 |
| Expected Payoff | $0.41 |
| Recovery Factor | 0.54 |
| Balance Drawdown Maximal | $26.14 (2.55%) |
| Equity Drawdown Maximal | $27.01 (2.64%) |
| Total Trades | 36 |
| Total Deals | 72 |
| Winning Trades | 16 (44.44%) |
| Losing Trades | 20 (55.56%) |

---

## Long vs Short Performance

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 22 | 68.18% |
| Short | 14 | 7.14% |

A substantial difference is visible between long and short trade performance in this test.

This observation should be investigated in subsequent research rather than treated as a final strategy conclusion.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $6.41 |
| Largest Loss Trade | -$8.69 |
| Average Profit Trade | $5.46 |
| Average Loss Trade | -$3.64 |
| Maximum Consecutive Wins | 4 |
| Maximum Consecutive Losses | 5 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 3 |

---

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum | 00:00:01 |
| Maximum | 00:13:39 |
| Average | 00:02:14 |

The EA therefore produced relatively short-duration trades during this M5 test.

---

## MFE / MAE Correlation

| Metric | Result |
|---|---:|
| Correlation (Profits, MFE) | 0.85 |
| Correlation (Profits, MAE) | 0.79 |
| Correlation (MFE, MAE) | 0.6611 |

These statistics are retained for later analysis of entry quality, stop-loss behavior and exit efficiency.

---

## Baseline Result

The tested configuration produced:

```text
Initial Balance:  $1,000.00
Net Profit:       +$14.59
Profit Factor:     1.20
Max Equity DD:     2.64%
Total Trades:      36
Win Rate:           44.44%
```

This result is recorded as a **baseline backtest**.

It should not be interpreted as evidence that the EA is production-ready or robust.

The sample contains only 36 trades and covers approximately three months of M5 data.

Further research is required before making conclusions about the strategy.

---

## Key Research Observation

The strongest initial observation from this baseline is the difference between BUY and SELL performance:

```text
BUY:
22 trades
68.18% won

SELL:
14 trades
7.14% won
```

This creates a clear research question:

> Is the weak short-side performance structural to the Donchian breakout strategy on XAUUSD M5, specific to this market period, or caused by the current parameter configuration?

This question should be tested rather than assumed.

---

## Files

### Full MT5 Report

```text
ReportTester-952747(20260909-001846).html
```

Contains the complete MetaTrader 5 Strategy Tester report including settings, statistics, orders and deals.

### Balance Curve

```text
ReportTester-952747(20260909-001846).png
```

Balance development across the backtest.

### Trading Distribution

```text
ReportTester-952747-hst(20260909-001846).png
```

Distribution of entries, profits and losses by hour, weekday and month.

### MFE / MAE Analysis

```text
ReportTester-952747-mfemae(20260909-001846).png
```

Maximum Favorable Excursion and Maximum Adverse Excursion analysis.

### Holding Time

```text
ReportTester-952747-holding(20260909-001846).png
```

Trade profit distribution relative to position holding time.

---

## Status

**Stage:** Baseline Backtest

**Result:** Recorded

**Optimization:** Not evaluated in this README

**Robustness:** Not yet validated

**Production readiness:** Not established

The results in this directory are preserved as the baseline evidence for subsequent EA-049 research.
