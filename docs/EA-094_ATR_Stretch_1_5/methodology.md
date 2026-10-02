# EA Research Methodology

## 1. Purpose

Tài liệu này định nghĩa phương pháp ghi nhận và đánh giá các EA trong repository.

Mục tiêu là giữ cho quá trình nghiên cứu có thể:

* Reproduce.
* Compare.
* Track parameter changes.
* Separate implementation from research.
* Separate baseline results from later experiments.

---

## 2. EA Definition

Mỗi EA được lưu trong:

```text
EAs/
└── EA-XXX_Name/
    ├── EA-XXX_Name.mq5
    └── README.md
```

README của EA chỉ mô tả:

* Strategy structure.
* Indicators.
* Entry logic.
* Exit logic.
* Execution protection.
* Default parameters.
* Implementation status.

---

## 3. Backtest Definition

Mỗi EA có thư mục riêng:

```text
Backtest/
└── EA-XXX_Name/
    ├── ReportTester-*.html
    └── README.md
```

Backtest README ghi nhận trực tiếp các thông tin từ Strategy Tester report.

Không thay đổi số liệu report khi chuyển sang README.

---

## 4. Baseline Test

Baseline phải ghi rõ:

```text
Symbol
Timeframe
Test Period
Initial Deposit
Leverage
History Quality
EA Parameters
```

Đối với EA-094 baseline:

```text
Symbol      = XAUUSD.PRO
Timeframe   = M1
Period      = 2026.01.02 – 2026.03.31
Deposit     = $1,000
History     = 100% real ticks
```

---

## 5. Core Performance Metrics

Mỗi baseline nên ghi:

```text
Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Recovery Factor
Sharpe Ratio
```

---

## 6. Drawdown Metrics

Ghi riêng:

```text
Balance DD Absolute
Equity DD Absolute
Balance DD Maximal
Balance DD Relative
Equity DD Maximal
Equity DD Relative
```

Không thay thế drawdown bằng một con số duy nhất nếu report cung cấp nhiều loại drawdown.

---

## 7. Trade Metrics

Ghi:

```text
Total Trades
Total Deals
Profit Trades
Loss Trades
Long Trades
Short Trades
Win Rate
Average Profit Trade
Average Loss Trade
Largest Profit Trade
Largest Loss Trade
```

Đồng thời ghi:

```text
Maximum Consecutive Wins
Maximum Consecutive Losses
Average Consecutive Wins
Average Consecutive Losses
```

---

## 8. Holding-Time Analysis

Khi report cung cấp dữ liệu, ghi:

```text
Minimum Holding Time
Maximum Holding Time
Average Holding Time
```

EA-094 baseline:

```text
Minimum = 1 second
Maximum = 3:36:03
Average = 2:01
```

---

## 9. Correlation Analysis

Nếu Strategy Tester cung cấp:

```text
Profits / MFE
Profits / MAE
MFE / MAE
```

thì lưu các giá trị này trong Backtest README.

EA-094 baseline:

```text
Profits / MFE = 0.94
Profits / MAE = 0.76
MFE / MAE     = 0.6027
```

---

## 10. Controlled Experiments

Khi nghiên cứu parameter:

### Experiment A

Chỉ thay đổi:

```text
ATR Multiplier
```

Các parameter khác giữ nguyên baseline.

### Experiment B

Chỉ thay đổi:

```text
EMA Period
```

### Experiment C

Chỉ thay đổi:

```text
ATR Period
```

### Experiment D

Chỉ thay đổi:

```text
SL / TP
```

### Experiment E

Chỉ thay đổi:

```text
Break Even / Trailing Stop
```

Mục tiêu là giảm việc thay đổi đồng thời quá nhiều biến khiến kết quả khó diễn giải.

---

## 11. Out-of-Sample

Sau khi xác định một cấu hình nghiên cứu, cần kiểm tra trên một period khác với period dùng để phát triển parameter.

Không sử dụng kết quả out-of-sample để điều chỉnh lại parameter rồi tiếp tục gọi cùng period đó là out-of-sample.

---

## 12. Robustness Testing

Robustness testing có thể kiểm tra:

* ATR Multiplier gần baseline.
* EMA Period gần baseline.
* ATR Period gần baseline.
* SL/TP gần baseline.
* Execution conditions khác nhau.
* Các giai đoạn thị trường khác nhau.

Mục đích là quan sát mức độ nhạy của kết quả khi parameter thay đổi.

---

## 13. Version Control

Mỗi EA cần có:

```text
EA version
Magic Number
Source file
Backtest report
Research notes
```

EA-094 hiện tại:

```text
EA Version  = 1.00
Magic       = 123094
```

Source code sử dụng EMA và ATR handles, cùng các cơ chế Break Even và Trailing Stop.

---

## 14. Research Record

Mỗi experiment nên có format:

```text
Experiment ID:
EA:
Date:
Symbol:
Timeframe:
Test Period:

Changed Parameters:

Fixed Parameters:

Net Profit:
Profit Factor:
Expected Payoff:
Maximum Drawdown:
Total Trades:
Win Rate:
Average Win:
Average Loss:

Observation:

Next Test:
```

---

## 15. Interpretation Rule

Kết quả backtest được xem là dữ liệu của một test cụ thể.

Không suy diễn từ:

```text
Một test
```

thành:

```text
Future performance
```

Cần phân biệt:

```text
Observed result
```

với:

```text
Research hypothesis
```

và:

```text
Future expectation
```

---

## 16. Current EA-094 Baseline

EA-094 baseline hiện tại:

```text
ATR Multiplier = 1.5
EMA Period     = 20
ATR Period     = 14

SL             = 300
TP             = 600

Break Even     = ON
BE Trigger     = 150

Trailing       = ON
Trailing Start = 200
Trailing Dist  = 100
Trailing Step  = 10
```

Strategy Tester ghi nhận:

```text
Net Profit     = -709.62 USD
Profit Factor  = 0.93
Max Balance DD = 94.41%
Max Equity DD  = 94.44%
Total Trades   = 8,479
```

Baseline này là mốc nghiên cứu của EA-094 và không được xem là kết luận cuối cùng về strategy.
