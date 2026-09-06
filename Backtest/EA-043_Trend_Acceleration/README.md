# EA-043 — Trend Acceleration Backtest

## Overview

This directory contains the baseline MetaTrader 5 backtest results for **EA-043_Trend_Acceleration**.

The purpose of this test is to evaluate the original strategy implementation before further optimization or modification.

> **Status: FAILED — Baseline strategy is not profitable under the tested configuration.**

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-043_Trend_Acceleration |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

---

## Parameters

### Trading

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Slippage | 10 |
| Magic Number | 20240501 |

### EMA Signal

| Parameter | Value |
|---|---:|
| Fast EMA | 20 |
| Slow EMA | 50 |
| Maximum Spread | 35 points |

### Position Management

| Parameter | Value |
|---|---:|
| Break Even | Disabled |
| Break Even Trigger | 150 |
| Break Even Shift | 0 |
| Trailing Stop | Disabled |
| Trailing Start | 200 |
| Trailing Step | 50 |

---

## Main Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$991.99** |
| Gross Profit | $9,819.99 |
| Gross Loss | -$10,811.98 |
| Profit Factor | **0.91** |
| Expected Payoff | **-$0.20** |
| Recovery Factor | **-0.93** |
| Sharpe Ratio | **-5.00** |
| Balance Drawdown Maximal | **$1,066.40 (99.25%)** |
| Equity Drawdown Maximal | **$1,071.10 (99.26%)** |

The EA lost almost the entire initial deposit during the test period.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 4,961 |
| Total Deals | 9,922 |
| Winning Trades | 1,569 (31.63%) |
| Losing Trades | 3,392 (68.37%) |
| Short Trades | 2,534 |
| Short Win Rate | 31.69% |
| Long Trades | 2,427 |
| Long Win Rate | 31.56% |
| Largest Profit Trade | $34.14 |
| Largest Loss Trade | -$42.23 |
| Average Profit Trade | $6.26 |
| Average Loss Trade | -$3.19 |

### Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Losses | 20 |
| Maximum Consecutive Profit | $49.58 |
| Maximum Consecutive Loss | -$66.35 |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum | 00:00:05 |
| Average | 00:03:51 |
| Maximum | 02:35:03 |

The strategy behaves as a high-frequency short-duration intraday system on the M1 timeframe.

---

## MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profit, MFE) | 0.84 |
| Correlation (Profit, MAE) | 0.71 |
| Correlation (MFE, MAE) | 0.4928 |

---

## Equity Curve

The balance curve shows a persistent long-term decline during the test.

Although there are several temporary recovery periods, the strategy fails to maintain positive expectancy and eventually loses almost the entire initial balance.

---

## Baseline Assessment

### FAIL

The baseline version of EA-043 does **not** meet the requirements for a viable XAUUSD trading strategy.

Primary evidence:

- Profit Factor below 1.0
- Negative Expected Payoff
- Negative Net Profit
- Negative Sharpe Ratio
- Approximately 99% drawdown
- 68.37% losing trades
- Strong downward balance curve

The result indicates that the current trend-acceleration entry logic generates too many losing signals relative to profitable signals under the tested M1 market conditions.

---

## Important Observation

The average winning trade ($6.26) is substantially larger than the average losing trade (-$3.19).

However, the win rate of only 31.63% is insufficient to produce positive expectancy under the tested configuration.

This suggests that future research should focus primarily on improving **entry quality / signal filtering**, rather than simply increasing the reward-to-risk ratio.

---

## Conclusion

EA-043_Trend_Acceleration successfully executes its intended EMA-based trading logic and produces a large enough trade sample for initial evaluation.

However, the baseline strategy is **not suitable for live trading** based on this test.

This backtest should therefore be preserved as the **baseline reference** for future research and strategy improvements.

---

## Files

```text
Backtest/
└── EA-043_Trend_Acceleration/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

The HTML file contains the complete MetaTrader 5 Strategy Tester report.

The PNG files contain the associated balance, trade distribution, MFE/MAE, and holding-time charts.

---

## Disclaimer

Backtest results represent historical simulation only and do not guarantee future performance.

This EA is currently maintained for research and development purposes and should not be considered production-ready or suitable for live trading.
