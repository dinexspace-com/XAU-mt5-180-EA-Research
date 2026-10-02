# EA-094_ATR_Stretch_1_5 — Backtest

## 1. Test Identification

| Item            | Value                   |
| --------------- | ----------------------- |
| Expert          | EA-094_ATR_Stretch_1_5  |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Test Period     | 2026.01.02 – 2026.03.31 |
| Initial Deposit | 1,000 USD               |
| Leverage        | 1:500                   |
| History Quality | 100% real ticks         |
| Bars            | 85,161                  |
| Ticks           | 39,639,179              |
| Symbols         | 1                       |
| Tester          | ACCMIntl-Real           |
| Build           | 6230                    |

---

## 2. Test Parameters

| Parameter          |  Value |
| ------------------ | -----: |
| Lot Size           |   0.01 |
| Stop Loss          |    300 |
| Take Profit        |    600 |
| Magic Number       | 123094 |
| Slippage           |     10 |
| Max Spread         |     30 |
| Timeframe          |     M1 |
| Break Even         |   true |
| Break Even Trigger |    150 |
| Break Even Offset  |      0 |
| Trailing Stop      |   true |
| Trailing Start     |    200 |
| Trailing Distance  |    100 |
| Trailing Step      |     10 |
| EMA Period         |     20 |
| ATR Period         |     14 |
| ATR Multiplier     |    1.5 |

---

## 3. Performance

| Metric          |      Result |
| --------------- | ----------: |
| Initial Deposit |   $1,000.00 |
| Net Profit      |    -$709.62 |
| Gross Profit    |   $9,711.56 |
| Gross Loss      | -$10,421.18 |
| Profit Factor   |        0.93 |
| Expected Payoff |      -$0.08 |
| Recovery Factor |       -0.74 |
| Sharpe Ratio    |       -4.75 |
| Margin Level    |     582.26% |
| LR Correlation  |       -0.92 |

---

## 4. Drawdown

| Metric              |  Result |
| ------------------- | ------: |
| Balance DD Absolute | $943.64 |
| Equity DD Absolute  | $943.87 |
| Balance DD Maximal  | $951.12 |
| Balance DD Relative |  94.41% |
| Equity DD Maximal   | $952.91 |
| Equity DD Relative  |  94.44% |

---

## 5. Trade Statistics

| Metric            | Result |
| ----------------- | -----: |
| Total Trades      |  8,479 |
| Total Deals       | 16,958 |
| Profit Trades     |  4,304 |
| Profit Trade Rate | 50.76% |
| Loss Trades       |  4,175 |
| Loss Trade Rate   | 49.24% |
| Short Trades      |  4,311 |
| Short Win Rate    | 51.22% |
| Long Trades       |  4,168 |
| Long Win Rate     | 50.29% |

---

## 6. Trade Distribution

| Metric                     |              Result |
| -------------------------- | ------------------: |
| Largest Profit Trade       |              $10.84 |
| Largest Loss Trade         |             -$34.19 |
| Average Profit Trade       |               $2.26 |
| Average Loss Trade         |              -$2.50 |
| Maximum Consecutive Wins   |                  12 |
| Maximum Consecutive Losses |                  13 |
| Max Consecutive Profit     |   $29.80 / 7 trades |
| Max Consecutive Loss       | -$39.11 / 13 trades |
| Average Consecutive Wins   |                   2 |
| Average Consecutive Losses |                   2 |

---

## 7. Holding Time

| Metric               |   Result |
| -------------------- | -------: |
| Minimum Holding Time | 1 second |
| Maximum Holding Time |  3:36:03 |
| Average Holding Time |     2:01 |

---

## 8. MFE / MAE Correlation

| Correlation   |  Value |
| ------------- | -----: |
| Profits / MFE |   0.94 |
| Profits / MAE |   0.76 |
| MFE / MAE     | 0.6027 |

---

## 9. Baseline Interpretation

Đây là baseline backtest của EA-094 với bộ parameter được sử dụng trong report.

Kết quả test ghi nhận:

* Net Profit: `-709.62 USD`
* Profit Factor: `0.93`
* Expected Payoff: `-0.08 USD`
* Maximum Balance Drawdown: `94.41%`
* Maximum Equity Drawdown: `94.44%`
* Total Trades: `8,479`

Tỷ lệ winning trades là `50.76%`, nhưng average loss trade (`-2.50 USD`) lớn hơn average profit trade (`2.26 USD`).
Baseline này được lưu để làm reference cho các thử nghiệm parameter và robustness tiếp theo.

---

## 10. Source Report

Strategy Tester report:

```text
ReportTester-952747(20261002-010107).html
```

Test này chỉ đại diện cho cấu hình và khoảng thời gian được ghi nhận trong report; chưa phải kết luận về hiệu quả trong các giai đoạn hoặc điều kiện thị trường khác.
