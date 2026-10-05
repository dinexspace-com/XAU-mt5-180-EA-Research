# EA-099 — Spike Reversion — Baseline Backtest

## Test Configuration

| Item             | Value                   |
| ---------------- | ----------------------- |
| EA               | EA-099_Spike_Reversion  |
| Symbol           | XAUUSD.PRO              |
| Timeframe        | M1                      |
| Test Period      | 2026.01.02 – 2026.03.31 |
| Initial Deposit  | $1,000                  |
| Leverage         | 1:500                   |
| Modeling         | 100% real ticks         |
| ATR Period       | 14                      |
| Large ATR        | 2.0                     |
| Spike Body Ratio | 0.70                    |
| Momentum Ratio   | 0.50                    |
| Lot              | 0.01                    |
| Stop Loss        | 300 points              |
| Take Profit      | 600 points              |

Nguồn test ghi nhận 100% real ticks và 85,161 bars / 39,639,179 ticks.

---

## Performance Summary

| Metric           |           Result |
| ---------------- | ---------------: |
| Total Net Profit |      **-$24.50** |
| Gross Profit     |          $994.25 |
| Gross Loss       |       -$1,018.75 |
| Profit Factor    |         **0.98** |
| Expected Payoff  |       **-$0.03** |
| Recovery Factor  |            -0.19 |
| Sharpe Ratio     |            -3.55 |
| Total Trades     |              864 |
| Total Deals      |            1,728 |
| Profit Trades    |     442 / 51.16% |
| Loss Trades      |     422 / 48.84% |
| Max Balance DD   | $127.60 / 12.74% |
| Max Equity DD    | $129.52 / 12.91% |

## Các chỉ số trên được lấy trực tiếp từ Strategy Tester Report.

## Trade Distribution

### Short

* Trades: 376
* Win rate: 50.80%

### Long

* Trades: 488
* Win rate: 51.43%

---

## Trade Quality

| Metric                 |   Result |
| ---------------------- | -------: |
| Largest Profit         |    $7.67 |
| Largest Loss           |   -$5.60 |
| Average Profit         |    $2.25 |
| Average Loss           |   -$2.41 |
| Max Consecutive Wins   |        9 |
| Max Consecutive Losses |        9 |
| Average Holding Time   | 00:02:19 |

---

## Baseline Assessment

**Classification:** `FAIL`

### Reason

* Net Profit < 0.
* Profit Factor < 1.
* Expected Payoff < 0.
* Sharpe Ratio < 0.
* Average losing trade lớn hơn average winning trade.
* Kết quả chưa chứng minh được edge đủ mạnh để chuyển sang live validation.

### Decision

`OPTIMIZATION BLOCKED`

Không thực hiện broad parameter optimization ở baseline này.

EA-099 cần được nghiên cứu theo từng biến kiểm soát trước khi thực hiện optimization diện rộng.
