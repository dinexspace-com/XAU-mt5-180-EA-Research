# EA-060 — Keltner Squeeze Backtest

## Test Information

| Item | Value |
|---|---|
| Expert Advisor | EA-060_Keltner_Squeeze |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 - 2026.04.01 |
| Initial Deposit | $1,000.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## Parameters Used

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 |
| Take Profit | 600 |
| Magic Number | 123456 |
| Slippage | 10 |
| Max Spread | 30 |
| Keltner EMA Period | 20 |
| ATR Period | 20 |
| ATR Multiplier | 2 |
| Squeeze Lookback | 2 |
| Squeeze Ratio | 1.5 |
| Break Even | true |
| Break Even Trigger | 150 |
| Break Even Offset | 0 |
| Trailing Stop | true |
| Trailing Start | 200 |
| Trailing Distance | 150 |

## Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$921.69 |
| Gross Profit | $3,929.48 |
| Gross Loss | -$4,851.17 |
| Profit Factor | 0.81 |
| Expected Payoff | -$0.25 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Maximal | $935.93 (92.45%) |
| Equity Drawdown Maximal | $936.18 (92.48%) |
| Total Trades | 3,642 |
| Total Deals | 7,284 |
| Winning Trades | 1,717 (47.14%) |
| Losing Trades | 1,925 (52.86%) |

## Long / Short Results

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | 1,853 | 47.33% |
| Long | 1,789 | 46.95% |

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $8.80 |
| Largest Loss Trade | -$5.62 |
| Average Profit Trade | $2.29 |
| Average Loss Trade | -$2.52 |
| Maximum Consecutive Wins | 12 ($26.59) |
| Maximum Consecutive Losses | 10 (-$31.33) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum | 00:00:01 |
| Maximum | 02:04:00 |
| Average | 00:02:07 |

## Correlations

| Metric | Result |
|---|---:|
| Profit / MFE | 0.97 |
| Profit / MAE | 0.71 |
| MFE / MAE | 0.6272 |

## Result Assessment

**Status: FAILED BACKTEST**

This configuration does not demonstrate a profitable trading edge.

Primary evidence:

- Total Net Profit: -$921.69
- Profit Factor: 0.81
- Expected Payoff: -$0.25 per trade
- Maximum Balance Drawdown: 92.45%
- Maximum Equity Drawdown: 92.48%
- Win Rate: 47.14%
- Recovery Factor: -0.98
- Sharpe Ratio: -5.00

The balance curve shows persistent deterioration over the test period.

This parameter configuration should therefore NOT be considered production-ready.

The result is retained as research evidence and as a baseline for subsequent strategy analysis or modification.

## Evidence Files

- `ReportTester-952747.html` — Original MetaTrader 5 Strategy Tester report
- `ReportTester-952747.png` — Balance curve
- `ReportTester-952747-hst.png` — Entry/profit distribution statistics
- `ReportTester-952747-mfemae.png` — MFE/MAE analysis
- `ReportTester-952747-holding.png` — Position holding-time analysis

## Reproducibility

All reported performance metrics above are taken directly from the original MetaTrader 5 Strategy Tester report.

The original HTML report and its associated graphs are retained in this directory so the test result can be independently inspected.
