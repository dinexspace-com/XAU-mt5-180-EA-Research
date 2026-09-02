# EA-037 — ATR Trend Filter Backtest

## Backtest Overview

This folder contains the MetaTrader 5 backtest results for:

**EA:** EA-037_ATR_Trend_Filter  
**Market:** XAUUSD.PRO  
**Timeframe:** M1  
**Test Period:** 2026-01-02 to 2026-03-31  
**Initial Deposit:** $1,000  
**Leverage:** 1:500  
**History Quality:** 100% real ticks

---

## Test Configuration

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 |
| Take Profit | 600 |
| Fast EMA | 20 |
| Slow EMA | 50 |
| ATR Period | 14 |
| ATR Average Period | 50 |
| Maximum Spread | 35 |
| Break Even Trigger | 150 |
| Break Even Pips | 0 |
| Trailing Stop | 200 |
| Break Even | Disabled |
| Trailing Stop | Disabled |

---

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$26.73 |
| Gross Profit | $1,270.08 |
| Gross Loss | -$1,296.81 |
| Profit Factor | 0.98 |
| Expected Payoff | -$0.04 |
| Recovery Factor | -0.21 |
| Sharpe Ratio | -2.24 |
| Total Trades | 621 |
| Total Deals | 1,242 |
| Winning Trades | 206 (33.17%) |
| Losing Trades | 415 (66.83%) |
| Short Trades | 365 |
| Short Win Rate | 31.51% |
| Long Trades | 256 |
| Long Win Rate | 35.55% |
| Largest Profit Trade | $8.63 |
| Largest Loss Trade | -$7.04 |
| Average Profit Trade | $6.17 |
| Average Loss Trade | -$3.12 |

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $111.09 |
| Balance Drawdown Maximal | $123.17 (12.17%) |
| Balance Drawdown Relative | 12.17% |
| Equity Drawdown Absolute | $111.36 |
| Equity Drawdown Maximal | $125.66 (12.39%) |
| Equity Drawdown Relative | 12.39% |

---

## Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Profit | $36.94 |
| Maximum Consecutive Losses | 16 |
| Maximum Consecutive Loss | -$49.29 |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum | 00:00:02 |
| Maximum | 03:44:00 |
| Average | 00:06:26 |

---

## Result Summary

This configuration did not produce a profitable result during the tested period.

Key observations:

- Net Profit: **-$26.73**
- Profit Factor: **0.98**
- Win Rate: **33.17%**
- Maximum Equity Drawdown: **12.39%**
- Sharpe Ratio: **-2.24**
- 621 trades provide a meaningful initial sample for evaluating the strategy behavior.

The result indicates that the current EMA + ATR filter configuration does not yet demonstrate a positive trading edge on XAUUSD.PRO M1 for the tested period.

This backtest should therefore be treated as a research baseline rather than a production-ready configuration.

---

## Test Status

**Status: BASELINE / NOT PROFITABLE**

The EA requires further research and validation before being considered for live trading.

No optimization result or production-readiness claim is made from this test.

---

## Source

Generated using the MetaTrader 5 Strategy Tester.

Expert:

`EA-037_ATR_Trend_Filter`

Test environment:

`XAUUSD.PRO / M1 / 2026-01-02 — 2026-03-31`
