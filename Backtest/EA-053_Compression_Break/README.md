# EA-053 — Compression Break

## Backtest Report

This directory contains the MetaTrader 5 backtest evidence for **EA-053_Compression_Break**.

## Test Environment

| Item | Value |
|---|---|
| Expert Advisor | EA-053_Compression_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $1,000 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |

## Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Slippage | 20 points |
| Compression Bars | 4 |
| Minimum Range Decrease | 0.0% |
| Maximum Spread | 35 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Lock | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 150 points |
| Trailing Step | 10 points |

## Performance Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$239.65** |
| Gross Profit | $1,238.71 |
| Gross Loss | -$1,478.36 |
| Profit Factor | **0.84** |
| Expected Payoff | **-$0.21** |
| Recovery Factor | **-0.90** |
| Sharpe Ratio | **-5.00** |
| Balance Drawdown Maximal | **$263.54 (26.35%)** |
| Equity Drawdown Maximal | **$266.48 (26.61%)** |
| Total Trades | 1,133 |
| Total Deals | 2,266 |

## Trade Statistics

| Metric | Result |
|---|---:|
| Winning Trades | 558 (49.25%) |
| Losing Trades | 575 (50.75%) |
| Long Trades | 628 |
| Long Win Rate | 50.80% |
| Short Trades | 505 |
| Short Win Rate | 47.33% |
| Largest Winning Trade | $8.77 |
| Largest Losing Trade | -$12.16 |
| Average Winning Trade | $2.22 |
| Average Losing Trade | -$2.57 |
| Maximum Consecutive Wins | 7 |
| Maximum Consecutive Losses | 8 |

## Holding Time

| Metric | Result |
|---|---:|
| Minimum | 00:00:03 |
| Average | 00:02:50 |
| Maximum | 01:08:04 |

The strategy operates as a short-duration M1 breakout system, with the average position remaining open for less than three minutes.

## Result

### ❌ BASELINE BACKTEST: FAIL

The current configuration does **not** demonstrate a profitable trading edge.

Primary reasons:

- Total Net Profit is negative: **-$239.65**
- Profit Factor is below 1.0: **0.84**
- Expected Payoff is negative: **-$0.21/trade**
- Sharpe Ratio is negative: **-5.00**
- Maximum equity drawdown reaches **26.61%**
- Final balance is substantially below the $1,000 initial deposit
- Losing trades exceed winning trades
- Average loss ($2.57) is larger than average win ($2.22)

The balance curve shows a persistent downward trend across the test period rather than a stable positive equity progression.

## Interpretation

This backtest should be treated as the **baseline test of the original EA-053 Compression Break hypothesis**.

The compression-breakout concept successfully generates a large sample of trades: **1,133 trades over approximately three months**.

Therefore, signal frequency is sufficient for further statistical research.

However, the current entry and exit configuration does not produce positive expectancy on XAUUSD.PRO M1 during this test period.

The baseline implementation should therefore **not be considered production-ready or validated for live trading**.

## Research Decision

Strategy implementation: TESTED  
Backtest execution: PASS  
History quality: PASS — 100% real ticks  
Sample size: PASS — 1,133 trades  

Profitability: FAIL  
Profit Factor: FAIL  
Expected Payoff: FAIL  
Risk-adjusted return: FAIL  
Equity curve: FAIL  

OVERALL BASELINE: FAIL

The result is retained intentionally as research evidence.

A failed baseline is not removed or rewritten because it provides the reference point for future modifications and optimization.

## Evidence Files

This directory should retain the original MT5 Strategy Tester output and its associated charts.

Backtest/  
└── EA-053_Compression_Break/  
    ├── README.md  
    ├── ReportTester-952747(20260911-003258).html  
    ├── ReportTester-952747(20260911-003258).png  
    ├── ReportTester-952747-hst(20260911-003258).png  
    ├── ReportTester-952747-mfemae(20260911-003258).png  
    └── ReportTester-952747-holding(20260911-003258).png  

The HTML Strategy Tester report is the primary source of numerical backtest results.

The PNG files provide supporting visual evidence including:

- Balance curve
- Entry distribution
- Profit/loss distribution
- MFE/MAE analysis
- Position holding-time distribution

## Reproducibility

This backtest represents a specific EA version, parameter configuration, symbol, timeframe, broker environment, and historical period.

Future optimized or modified versions should be tested separately rather than replacing this baseline evidence.

## Status

**Research / Baseline Failed**

EA-053 requires further research before it can progress toward validation, forward testing, or live deployment.
