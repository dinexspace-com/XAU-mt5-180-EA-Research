# EA-086_RSI_40_60 — Backtest

## 1. Test Identification

| Item            | Value                   |
| --------------- | ----------------------- |
| Expert Advisor  | EA-086_RSI_40_60        |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Test Period     | 2026.01.02 – 2026.03.31 |
| Initial Deposit | USD 1,000               |
| Currency        | USD                     |
| Leverage        | 1:500                   |
| History Quality | 100% real ticks         |
| Bars            | 85,161                  |
| Ticks           | 39,639,179              |
| Symbols         | 1                       |

## 2. Tested Parameters

| Parameter          |  Value |
| ------------------ | -----: |
| Lot Size           |   0.01 |
| Stop Loss          |    300 |
| Take Profit        |    600 |
| Magic Number       | 123086 |
| Slippage           |     10 |
| Maximum Spread     |     30 |
| Timeframe          |     M1 |
| Breakout Buffer    |      0 |
| Break Even         |   true |
| Break Even Trigger |    150 |
| Break Even Offset  |      0 |
| Trailing Stop      |   true |
| Trailing Start     |    200 |
| Trailing Distance  |    100 |
| Trailing Step      |     10 |
| RSI Period         |     14 |
| RSI Lower          |     40 |
| RSI Upper          |     60 |

## 3. Results

| Metric                        |                Result |
| ----------------------------- | --------------------: |
| Total Net Profit              |           -995.01 USD |
| Gross Profit                  |          7,251.24 USD |
| Gross Loss                    |         -8,246.25 USD |
| Profit Factor                 |                  0.88 |
| Expected Payoff               |             -0.15 USD |
| Recovery Factor               |                 -0.99 |
| Sharpe Ratio                  |                 -5.00 |
| Balance Drawdown Maximal      | 1,006.47 USD (99.51%) |
| Equity Drawdown Maximal       | 1,007.51 USD (99.51%) |
| Total Trades                  |                 6,575 |
| Profit Trades                 |        3,264 (49.64%) |
| Loss Trades                   |        3,311 (50.36%) |
| Short Trades                  |    3,531 (49.11% won) |
| Long Trades                   |    3,044 (50.26% won) |
| Average Profit Trade          |              2.22 USD |
| Average Loss Trade            |             -2.49 USD |
| Largest Profit Trade          |              7.95 USD |
| Largest Loss Trade            |            -38.89 USD |
| Maximum Consecutive Wins      |                    11 |
| Maximum Consecutive Losses    |                    16 |
| Average Position Holding Time |               0:02:21 |
| Maximum Position Holding Time |               3:36:03 |

## 4. Baseline Interpretation

This report represents the current baseline test for EA-086_RSI_40_60.

The tested configuration produced a negative net result of USD 995.01 on an initial USD 1,000 deposit.

The maximum equity drawdown was 99.51%.

Profit Factor was 0.88, with 3,264 profitable trades and 3,311 losing trades.

The report therefore records a negative baseline result for the tested period and configuration.

## 5. Original Report

The complete MetaTrader 5 Strategy Tester report is stored alongside this README:

```text
ReportTester-952747(2).html
```

No optimization result is included in this directory unless a separate test report is produced and documented.
