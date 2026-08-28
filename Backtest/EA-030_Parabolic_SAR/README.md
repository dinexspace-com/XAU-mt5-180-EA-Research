# EA-030 Parabolic SAR — Backtest Results

## Overview

This directory contains the MetaTrader 5 backtest results for:

**EA-030_Parabolic_SAR**

The purpose of this backtest is to evaluate the baseline Parabolic SAR strategy under historical XAUUSD market conditions before further optimization or strategy development.

---

## Test Environment

| Parameter | Value |
|---|---|
| Expert Advisor | EA-030_Parabolic_SAR |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.03.01 |
| Initial Deposit | $100.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 56,115 |
| Ticks | 25,190,686 |

---

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 60 points |
| Maximum Positions | 1 |
| Slippage | 10 points |
| Magic Number | 123456 |
| Break Even | Disabled |
| Break Even Start | 150 points |
| Trailing Stop | Disabled |
| Trailing Start | 200 points |
| SAR Step | 0.02 |
| SAR Maximum | 0.2 |

Break Even and Trailing Stop parameters were present in the EA configuration but were disabled during this test.

---

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$92.43** |
| Gross Profit | $786.31 |
| Gross Loss | -$878.74 |
| Profit Factor | **0.89** |
| Expected Payoff | -$0.23 |
| Recovery Factor | -0.90 |
| Sharpe Ratio | -5.00 |
| Total Trades | 410 |
| Total Deals | 820 |
| Winning Trades | 124 (30.24%) |
| Losing Trades | 286 (69.76%) |
| Maximum Balance Drawdown | **$102.35 (93.11%)** |
| Maximum Equity Drawdown | **$102.35 (93.11%)** |

---

## Long vs Short Performance

A total of **410 trades** were executed.

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 206 | 34.47% |
| Short | 204 | 25.98% |

Long positions performed better than short positions in terms of win rate during this test.

However, neither side produced sufficient overall performance to make the complete strategy profitable under the tested configuration.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $34.93 |
| Largest Loss Trade | -$4.92 |
| Average Profit Trade | $6.34 |
| Average Loss Trade | -$3.07 |
| Maximum Consecutive Wins | 4 |
| Maximum Consecutive Losses | 12 |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

The average winning trade was approximately twice the size of the average losing trade.

However, the low overall win rate prevented this payoff advantage from producing a positive result.

---

## Position Holding Time

| Metric | Time |
|---|---:|
| Minimum Holding Time | 00:00:03 |
| Maximum Holding Time | 02:37:03 |
| Average Holding Time | 00:09:19 |

The strategy therefore behaved primarily as a short-duration intraday system during this M1 test.

---

## MFE / MAE Analysis

MetaTrader 5 reported the following correlations:

| Correlation | Value |
|---|---:|
| Profit vs MFE | 0.86 |
| Profit vs MAE | 0.82 |
| MFE vs MAE | 0.6431 |

These statistics are retained as part of the baseline research data for later comparison with modified versions of the strategy.

---

## Equity Curve

The balance curve was unstable throughout the test.

Although the strategy experienced several periods of recovery and reached temporary balance highs, these gains were not sustained.

The latter portion of the test shows a pronounced deterioration in performance, with the account balance eventually approaching depletion.

This behavior is consistent with the reported:

- Total Net Profit: **-$92.43**
- Profit Factor: **0.89**
- Maximum Drawdown: **93.11%**
- Sharpe Ratio: **-5.00**

---

## Baseline Assessment

### Result: FAIL

This configuration does **not** demonstrate acceptable standalone performance.

Primary reasons:

- Negative total net profit
- Profit Factor below 1.0
- 69.76% losing trades
- Extremely high 93.11% maximum drawdown
- Negative Expected Payoff
- Negative Recovery Factor
- Negative Sharpe Ratio
- Balance curve deteriorates substantially toward the end of the test

The strategy should therefore **not be considered validated or suitable for live deployment based on this test**.

---

## Research Value

Although the backtest failed from a performance perspective, it provides a useful **baseline result**.

The test establishes the behavior of the basic Parabolic SAR strategy before optimization.

Future versions can be compared against this baseline to determine whether changes actually improve:

- Profit Factor
- Expected Payoff
- Drawdown
- Win Rate
- Equity curve stability
- Long/Short performance
- Risk-adjusted return

The objective of future research should not simply be to maximize historical profit, but to determine whether additional filters or modifications can produce a more robust strategy.

---

## Backtest Files

This directory should retain the original MetaTrader 5 Strategy Tester artifacts associated with this test.

Example structure:

```text
Backtest/
└── EA-030_Parabolic_SAR/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
