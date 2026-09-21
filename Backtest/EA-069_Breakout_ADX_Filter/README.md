# EA-069 — Breakout ADX Filter Backtest

Backtest results for:

**EA-069_Breakout_ADX_Filter**

Strategy: Breakout + ADX Filter  
Platform: MetaTrader 5

---

## Test Configuration

| Parameter | Value |
|---|---|
| Expert | EA-069_Breakout_ADX_Filter |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.03.31 |
| Initial Deposit | $100.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Lot Size | 0.01 |

---

## Strategy Parameters

| Parameter | Value |
|---|---:|
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Max Spread | 30 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| ADX Period | 14 |
| ADX Threshold | 25.0 |
| Break Even | Enabled |
| Break Even Trigger | 150 |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 |
| Trailing Distance | 100 |
| Trailing Step | 10 |

---

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$94.14** |
| Gross Profit | $199.94 |
| Gross Loss | -$294.08 |
| Profit Factor | **0.68** |
| Expected Payoff | -$0.44 |
| Recovery Factor | -1.00 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | **$94.14 (94.14%)** |
| Maximum Equity Drawdown | **$94.14 (94.14%)** |
| Total Trades | 214 |
| Total Deals | 428 |
| Winning Trades | 91 (42.52%) |
| Losing Trades | 123 (57.48%) |

---

## Long / Short Performance

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 121 | 47.11% |
| Short | 93 | 36.56% |

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $6.09 |
| Largest Loss Trade | -$3.35 |
| Average Profit Trade | $2.20 |
| Average Loss Trade | -$2.39 |
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Losses | 7 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 3 |

---

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum | 00:00:04 |
| Average | 00:03:42 |
| Maximum | 00:26:19 |

The backtest therefore represents a short-duration trading strategy on the M1 timeframe.

---

## Result

**Status: FAIL**

This baseline configuration does not demonstrate a profitable or sufficiently robust strategy over the tested period.

Primary evidence:

- Net Profit: **-$94.14**
- Profit Factor: **0.68**
- Expected Payoff: **-$0.44 per trade**
- Win Rate: **42.52%**
- Maximum Drawdown: **94.14%**
- Final balance is close to depletion of the original $100 account.

The current result should therefore be treated as a **baseline research result**, not as evidence of a production-ready trading system.

---

## Research Value

This backtest is retained intentionally.

Negative backtest results are part of the research process and provide evidence about how the original Breakout + ADX configuration behaves under the tested XAUUSD M1 conditions.

Future variants can be compared against this baseline to determine whether changes actually improve:

- Profit Factor
- Expected Payoff
- Drawdown
- Win Rate
- Net Profit
- Stability across longer test periods

The baseline result must not be overwritten by later optimization results.

---

## Files

This directory contains the original MetaTrader 5 Strategy Tester report and its associated charts.

Recommended structure:

EA-069_Breakout_ADX_Filter/
├── README.md
├── ReportTester-952747.html
├── ReportTester-952747.png
├── ReportTester-952747-hst.png
├── ReportTester-952747-mfemae.png
└── ReportTester-952747-holding.png

---

## Reproducibility

The original MT5 HTML Strategy Tester report should be preserved unchanged.

It contains the complete test configuration, input parameters, orders, deals, execution records and performance statistics required to audit this backtest.

---

## Disclaimer

Backtest results represent historical simulation under the specified test conditions.

They do not guarantee future trading performance.
