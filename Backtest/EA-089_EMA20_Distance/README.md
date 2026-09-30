# EA-089_EMA20_Distance — Backtest

## 1. Test Configuration

| Parameter       | Value                   |
| --------------- | ----------------------- |
| Expert Advisor  | EA-089_EMA20_Distance   |
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

---

## 2. EA Parameters

| Parameter          |  Value |
| ------------------ | -----: |
| Lot Size           |   0.01 |
| Stop Loss          |    300 |
| Take Profit        |    600 |
| Magic Number       | 123089 |
| Slippage           |     10 |
| Maximum Spread     |     30 |
| Timeframe          |     M1 |
| Breakout Buffer    |      0 |
| Use Break Even     |   true |
| Break Even Trigger |    150 |
| Break Even Offset  |      0 |
| Use Trailing Stop  |   true |
| Trailing Start     |    200 |
| Trailing Distance  |    100 |
| Trailing Step      |     10 |
| EMA Period         |     20 |
| ATR Period         |     14 |
| Distance ATR       |    1.5 |

---

## 3. Performance Results

| Metric           |          Result |
| ---------------- | --------------: |
| Total Net Profit |     -597.97 USD |
| Gross Profit     |    8,333.49 USD |
| Gross Loss       |   -8,931.46 USD |
| Profit Factor    |            0.93 |
| Expected Payoff  |       -0.08 USD |
| Recovery Factor  |           -0.74 |
| Sharpe Ratio     |           -5.00 |
| AHPR             | 0.9999 (-0.01%) |
| GHPR             | 0.9999 (-0.01%) |
| LR Correlation   |           -0.90 |

---

## 4. Drawdown

| Metric                    |              Result |
| ------------------------- | ------------------: |
| Balance Drawdown Absolute |          804.93 USD |
| Equity Drawdown Absolute  |          805.14 USD |
| Balance Drawdown Maximal  | 810.79 USD (80.61%) |
| Equity Drawdown Maximal   | 812.56 USD (80.66%) |
| Balance Drawdown Relative |              80.61% |
| Equity Drawdown Relative  |              80.66% |

---

## 5. Trade Statistics

| Metric               |         Result |
| -------------------- | -------------: |
| Total Trades         |          7,313 |
| Total Deals          |         14,626 |
| Short Trades         |          3,759 |
| Short Win Rate       |         51.32% |
| Long Trades          |          3,554 |
| Long Win Rate        |         50.03% |
| Profit Trades        | 3,707 (50.69%) |
| Loss Trades          | 3,606 (49.31%) |
| Largest Profit Trade |       7.95 USD |
| Largest Loss Trade   |     -18.35 USD |
| Average Profit Trade |       2.25 USD |
| Average Loss Trade   |      -2.48 USD |

---

## 6. Consecutive Results

| Metric                     |     Result |
| -------------------------- | ---------: |
| Maximum Consecutive Wins   |         11 |
| Maximum Consecutive Losses |         11 |
| Maximum Consecutive Profit |  39.28 USD |
| Maximum Consecutive Loss   | -33.09 USD |
| Average Consecutive Wins   |          2 |
| Average Consecutive Losses |          2 |

---

## 7. Position Holding Time

| Metric               |  Result |
| -------------------- | ------: |
| Minimum Holding Time | 0:00:01 |
| Maximum Holding Time | 3:36:03 |
| Average Holding Time | 0:02:11 |

---

## 8. MFE / MAE Statistics

| Metric                     | Result |
| -------------------------- | -----: |
| Correlation: Profits / MFE |   0.94 |
| Correlation: Profits / MAE |   0.76 |
| Correlation: MFE / MAE     | 0.6245 |

---

## 9. Backtest Record

The original Strategy Tester report is retained in this directory:

```text
ReportTester-952747(6).html
```

The report is the source record for the numerical results documented in this README.
