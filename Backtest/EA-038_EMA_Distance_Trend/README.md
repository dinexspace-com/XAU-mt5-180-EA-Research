# EA-038 — EMA Distance Trend | Backtest

## Backtest Overview

This directory contains the MetaTrader 5 Strategy Tester results for:

**EA-038_EMA_Distance_Trend**

The purpose of this backtest is to evaluate the baseline implementation of the EMA Distance Trend strategy on XAUUSD before further optimization or strategy modification.

---

## Test Configuration

| Parameter | Value |
|---|---|
| Expert Advisor | EA-038_EMA_Distance_Trend |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $1,000 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |

---

## EA Parameters

### General

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 24032025 |
| Slippage | 10 |
| Maximum Spread | 35 points |
| Maximum Positions | 1 |

### Indicators

| Parameter | Value |
|---|---:|
| Fast EMA | 20 |
| Slow EMA | 50 |
| ATR Period | 14 |
| ATR Ratio | 0.5 |

### Trade Management

| Parameter | Value |
|---|---:|
| Break Even | Disabled |
| Break Even Trigger | 150 points |
| Break Even Lock | 0 |
| Trailing Stop | Disabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

---

## Main Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$991.90** |
| Gross Profit | $14,553.90 |
| Gross Loss | -$15,545.80 |
| Profit Factor | **0.94** |
| Expected Payoff | **-$0.14** |
| Recovery Factor | **-0.89** |
| Sharpe Ratio | **-5.00** |
| Balance Drawdown Maximal | **$1,105.73 (99.27%)** |
| Equity Drawdown Maximal | **$1,108.53 (99.27%)** |

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 7,198 |
| Total Deals | 14,396 |
| Winning Trades | 2,334 (32.43%) |
| Losing Trades | 4,864 (67.57%) |
| Short Trades | 3,518 |
| Short Win Rate | 32.89% |
| Long Trades | 3,680 |
| Long Win Rate | 31.98% |
| Largest Profit Trade | $34.90 |
| Largest Loss Trade | -$42.23 |
| Average Profit Trade | $6.24 |
| Average Loss Trade | -$3.20 |
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Losses | 23 |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum | 00:00:01 |
| Maximum | 03:45:55 |
| Average | 00:03:12 |

The strategy generated a high number of short-duration trades on the M1 timeframe.

---

## MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profit, MFE) | 0.84 |
| Correlation (Profit, MAE) | 0.75 |
| Correlation (MFE, MAE) | 0.5518 |

---

## Balance Curve

The balance curve shows substantial deterioration during the test period.

Starting balance:

$1,000

Final result:

$8.10

Net loss:

-$991.90

The strategy experienced a maximal balance drawdown of 99.27%.

---

## Baseline Assessment

**Status: FAILED — Baseline configuration is not suitable for deployment.**

The baseline strategy produced:

- Negative net profit
- Profit Factor below 1.0
- Negative expected payoff
- Negative Sharpe Ratio
- Extremely high drawdown
- More losing trades than winning trades

Although the average winning trade ($6.24) was larger than the average losing trade (-$3.20), the win rate of 32.43% was insufficient to produce positive expectancy under this configuration.

The test therefore provides evidence that the current baseline configuration does not have acceptable performance on:

**XAUUSD.PRO / M1 / 2026-01-02 → 2026-03-31**

This result does not establish that the underlying EMA-distance concept is universally invalid. It establishes that this specific implementation and parameter configuration failed this backtest.

---

## Research Decision

The current version should **not proceed to live trading**.

Further research should investigate whether performance can be improved through changes such as:

- EMA parameters
- ATR distance threshold
- timeframe
- entry filtering
- trading session filtering
- exit logic
- stop-loss / take-profit configuration

Any modified version should be tested separately rather than replacing this baseline result.

This baseline should remain preserved as the reference result for EA-038.

---

## Backtest Files

The directory should preserve the original MetaTrader 5 Strategy Tester report and its associated charts.

Recommended structure:

Backtest/
└── EA-038_EMA_Distance_Trend/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png

---

## Conclusion

The baseline EA-038 EMA Distance Trend strategy **FAILED** this XAUUSD M1 backtest.

Key result:

Profit Factor: 0.94  
Net Profit: -$991.90  
Max Drawdown: 99.27%  
Win Rate: 32.43%  
Total Trades: 7,198

The result should be retained as baseline research evidence before testing any improved version.
