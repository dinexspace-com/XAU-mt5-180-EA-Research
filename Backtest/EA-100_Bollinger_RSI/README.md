# EA-100 — Bollinger + RSI

## Baseline Backtest

### Test Configuration

| Parameter           | Value                   |
| ------------------- | ----------------------- |
| Expert              | EA-100_Bollinger___RSI  |
| Symbol              | XAUUSD.PRO              |
| Timeframe           | M1                      |
| Period              | 2026.01.02 – 2026.03.31 |
| Initial Deposit     | $1,000                  |
| Leverage            | 1:500                   |
| History Quality     | 100% real ticks         |
| Bars                | 85,161                  |
| Ticks               | 39,639,179              |
| Lot                 | 0.01                    |
| Stop Loss           | 300                     |
| Take Profit         | 600                     |
| Bollinger Period    | 20                      |
| Bollinger Deviation | 2.0                     |
| RSI Period          | 14                      |
| RSI Lower           | 30                      |
| RSI Upper           | 70                      |

---

## Performance Results

| Metric           |             Result |
| ---------------- | -----------------: |
| Total Net Profit |       **+$694.91** |
| Gross Profit     |          $4,086.62 |
| Gross Loss       |         -$3,391.71 |
| Profit Factor    |           **1.20** |
| Expected Payoff  |         **+$0.22** |
| Recovery Factor  |          **11.93** |
| Sharpe Ratio     |          **33.78** |
| Max Balance DD   | $55.57 / **5.32%** |
| Max Equity DD    | $58.27 / **5.57%** |
| Total Trades     |          **3,096** |
| Total Deals      |              6,192 |

Các số liệu trên được lấy trực tiếp từ Strategy Tester Report.

---

## Trade Statistics

| Metric                 |         Result |
| ---------------------- | -------------: |
| Profit Trades          | 1,691 / 54.62% |
| Loss Trades            | 1,405 / 45.38% |
| Short Trades           |          1,367 |
| Short Win Rate         |         51.06% |
| Long Trades            |          1,729 |
| Long Win Rate          |         57.43% |
| Largest Profit Trade   |          $9.25 |
| Largest Loss Trade     |        -$10.33 |
| Average Profit Trade   |          $2.42 |
| Average Loss Trade     |         -$2.41 |
| Max Consecutive Wins   |             12 |
| Max Consecutive Losses |             10 |
| Average Holding Time   |       00:01:22 |

---

## Baseline Assessment

### Classification

```text
PASS FOR FURTHER RESEARCH
```

### Positive Evidence

* Net Profit dương: **+$694.91**.
* Profit Factor > 1: **1.20**.
* Expected Payoff dương: **+$0.22/trade**.
* Recovery Factor cao: **11.93**.
* Sharpe Ratio dương: **33.78**.
* Maximum Equity Drawdown tương đối thấp: **5.57%**.
* Có 3,096 trades, đủ lớn để sử dụng làm baseline nghiên cứu ban đầu.
* Long side có win rate 57.43%, cao hơn Short side 51.06%.

### Risk / Limitation

Kết quả vẫn chỉ là một historical test trên một symbol, một timeframe và một giai đoạn.

Không được kết luận rằng EA có edge ổn định ngoài mẫu chỉ dựa trên baseline này.

---

## Baseline Decision

```text
Strategy Code: COMPLETE
Baseline Backtest: COMPLETE
Baseline Result: PASS FOR FURTHER RESEARCH
Optimization: CONTROLLED RESEARCH ONLY
OOS: NOT STARTED
Walk-Forward: NOT STARTED
Forward Test: NOT STARTED
Live Trading: NO
```
