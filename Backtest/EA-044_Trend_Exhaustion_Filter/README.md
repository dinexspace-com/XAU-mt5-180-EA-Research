# Backtest — EA-044 Trend Exhaustion Filter

## Overview

This folder contains the MetaTrader 5 backtest results for **EA-044 — Trend Exhaustion Filter**.

The purpose of this test is to evaluate the original strategy implementation before optimization or modification.

## Test Environment

| Parameter | Value |
|---|---|
| Expert Advisor | EA-044_Trend_Exhaustion_Filter |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000 |
| Account Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 2024001 |
| Slippage | 10 |
| Maximum Spread | 30 points |
| EMA Period | 200 |
| ATR Period | 14 |
| ATR Multiplier | 2.0 |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Shift | 20 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Step | 50 points |

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$991.88** |
| Gross Profit | $15,110.65 |
| Gross Loss | -$16,102.53 |
| Profit Factor | **0.94** |
| Expected Payoff | **-$0.11** |
| Recovery Factor | **-0.92** |
| Sharpe Ratio | **-5.00** |
| Maximum Balance Drawdown | **$1,074.07 (99.25%)** |
| Maximum Equity Drawdown | **$1,074.07 (99.25%)** |
| Total Trades | **8,742** |
| Total Deals | 17,484 |
| Winning Trades | 3,808 (43.56%) |
| Losing Trades | 4,934 (56.44%) |
| Short Trades | 3,963 |
| Short Win Rate | 39.99% |
| Long Trades | 4,779 |
| Long Win Rate | 46.52% |

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $32.74 |
| Largest Loss Trade | -$8.69 |
| Average Profit Trade | $3.97 |
| Average Loss Trade | -$3.26 |
| Maximum Consecutive Wins | 19 |
| Maximum Consecutive Losses | 19 |
| Maximum Consecutive Profit | $58.59 |
| Maximum Consecutive Loss | -$61.25 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:27:03 |
| Average Holding Time | 00:02:17 |

The strategy therefore behaves as a very short-term, high-frequency strategy under the tested M1 configuration.

## MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profit, MFE) | 0.89 |
| Correlation (Profit, MAE) | 0.79 |
| Correlation (MFE, MAE) | 0.6576 |

## Balance Curve

The balance curve shows that the original strategy configuration is not profitable over the tested period.

Although there are periods of recovery, the overall balance trend is strongly negative and ultimately approaches depletion of the initial $1,000 account.

## Result Assessment

### Status: FAIL

The original EA configuration does **not** pass the baseline profitability test.

Primary reasons:

- Total Net Profit: **-$991.88**
- Profit Factor: **0.94**
- Expected Payoff: **-$0.11 per trade**
- Maximum Drawdown: **99.25%**
- Sharpe Ratio: **-5.00**
- Losing trades exceed winning trades.
- Balance curve deteriorates substantially over the test period.

The strategy therefore has **no demonstrated positive expectancy in this baseline configuration**.

## Research Interpretation

The test contains **8,742 trades**, providing a substantial number of observations for examining the behavior of the current rule set.

The result suggests that the basic **EMA trend direction + ATR distance filter** is not sufficient by itself to produce a robust trading system under the tested configuration.

The EA generates a very large number of trades on M1, while the resulting edge is slightly negative.

The strategy should therefore remain a **research candidate**, rather than being considered ready for live trading.

## Baseline Conclusion

EA ID: **EA-044**  
Strategy: **Trend Exhaustion Filter**  
Symbol: **XAUUSD.PRO**  
Timeframe: **M1**  
Initial Capital: **$1,000**  
Trades: **8,742**  
Net Profit: **-$991.88**  
Profit Factor: **0.94**  
Max Drawdown: **99.25%**  
Win Rate: **43.56%**  
Baseline Result: **FAIL**

This backtest establishes the baseline performance of EA-044 before further research, filtering, parameter testing, or strategy modification.

No profitability claim should be made based on the current version.

## Files

Backtest/
└── EA-044_Trend_Exhaustion_Filter/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png

## Research Status

**Baseline Backtest:** Completed  
**Baseline Result:** FAIL  
**Optimization:** Not evaluated in this report  
**Forward Test:** Not performed  
**Live Validation:** Not performed
