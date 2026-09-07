# Backtest — EA-046 Previous Candle Break

## Overview

This directory contains the MetaTrader 5 Strategy Tester results for **EA-046 — Previous Candle Break**. The test evaluates the baseline implementation of the Previous Candle Break strategy on XAUUSD.

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-046_Previous_Candle_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Symbols | 1 |

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123456 |
| Slippage | 10 points |
| Maximum Spread | 35 points |
| Break Even | Enabled |
| Break Even Start | 150 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Step | 50 points |

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$592.81** |
| Gross Profit | $4,098.96 |
| Gross Loss | -$4,691.77 |
| Profit Factor | **0.87** |
| Expected Payoff | -$0.21 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Maximal | $605.15 (59.79%) |
| Equity Drawdown Maximal | $607.27 (59.88%) |
| Total Trades | 2,760 |
| Total Deals | 5,520 |

## Trade Statistics

| Metric | Result |
|---|---:|
| Winning Trades | 1,095 (39.67%) |
| Losing Trades | 1,665 (60.33%) |
| Largest Winning Trade | $47.71 |
| Largest Losing Trade | -$33.39 |
| Average Winning Trade | $3.74 |
| Average Losing Trade | -$2.82 |
| Long Trades | 1,439 |
| Long Win Rate | 40.03% |
| Short Trades | 1,321 |
| Short Win Rate | 39.29% |
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Losses | 13 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 3 |
| Maximal Consecutive Profit | $55.48 (2 trades) |
| Maximal Consecutive Loss | -$37.72 (12 trades) |

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum | 00:00:01 |
| Maximum | 02:18:03 |
| Average | 00:04:13 |

The test therefore represents a high-frequency, short-duration implementation of the breakout concept on the M1 timeframe.

## MFE / MAE Statistics

| Correlation | Result |
|---|---:|
| Profit vs MFE | 0.91 |
| Profit vs MAE | 0.68 |
| MFE vs MAE | 0.5442 |

## Equity / Balance Observation

The balance curve shows a persistent downward trend over the tested period. Starting balance was **$1,000**, while the test produced **-$592.81** net profit. Maximum balance drawdown reached **59.79%** and maximum equity drawdown reached **59.88%**. The baseline configuration therefore failed to maintain capital over this test period.

## Baseline Assessment

**Result: FAIL**

The tested configuration is not profitable.

Primary evidence:

- Profit Factor: **0.87**
- Net Profit: **-$592.81**
- Expected Payoff: **-$0.21**
- Winning Trades: **39.67%**
- Losing Trades: **60.33%**
- Maximum Equity Drawdown: **59.88%**
- Recovery Factor: **-0.98**
- Sharpe Ratio: **-5.00**

The strategy generated a sample of **2,760 trades**, but the baseline configuration did not demonstrate a positive statistical edge during this test. This result is retained as a negative research result for comparison with future variants.

## Research Interpretation

This backtest establishes a baseline for the Previous Candle Break concept. The current test indicates that a raw previous-candle breakout applied continuously to XAUUSD.PRO M1 with the tested parameters is insufficient by itself. This does not establish that every variation of the Previous Candle Break concept is unprofitable. It establishes that this specific implementation, parameter set, symbol, timeframe, broker environment, and test period produced a negative result. Future variants can be compared against this baseline.

## Reproducibility

EA: EA-046_Previous_Candle_Break  
Symbol: XAUUSD.PRO  
Timeframe: M1  
Period: 2026.01.02 - 2026.04.01  
Initial Deposit: 1000 USD  
Leverage: 1:500  
LotSize: 0.01  
StopLoss: 300  
TakeProfit: 600  
MagicNumber: 123456  
Slippage: 10  
MaxSpread: 35  
BreakEven: true  
BreakEvenStart: 150  
TrailingStop: true  
TrailingStart: 200  
TrailingStep: 50  
History Quality: 100% real ticks

## Files

Backtest/  
└── EA-046_Previous_Candle_Break/  
    ├── README.md  
    ├── ReportTester-952747.html  
    ├── ReportTester-952747.png  
    ├── ReportTester-952747-hst.png  
    ├── ReportTester-952747-mfemae.png  
    └── ReportTester-952747-holding.png

The HTML Strategy Tester report is the primary source of numerical backtest results. The PNG files provide the associated balance, trade-distribution, MFE/MAE, and holding-time visualizations.

## Status

**Baseline Backtest: FAIL**

Reason: the EA produced negative net profit, Profit Factor below 1.0, negative expected payoff, and approximately 60% maximum drawdown under the tested configuration. The result is retained for research, comparison, and future strategy development.

## Disclaimer

Backtest results are historical simulations and do not guarantee future performance. Results may vary with broker conditions, spread, execution, symbol specification, historical data, timeframe, and EA parameters.
