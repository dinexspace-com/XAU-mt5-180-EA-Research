# EA-094_ATR_Stretch_1_5 — Research

## 1. Research Objective

Nghiên cứu EA-094 tập trung vào mô hình giao dịch dựa trên việc giá mở rộng ra khỏi vùng được xác định bởi:

```text
EMA ± ATR × Multiplier
```

Sau khi xuất hiện trạng thái stretch, EA yêu cầu một candle xác nhận chuyển động hồi trước khi mở position.

---

## 2. Strategy Hypothesis

Mô hình được triển khai theo cấu trúc:

```text
Price stretches beyond ATR band
            ↓
Previous candle confirms reversal direction
            ↓
Price remains on the stretched side of EMA
            ↓
Enter trade
            ↓
Fixed SL / TP
            ↓
Break Even / Trailing Stop
```

Đây là hypothesis được thể hiện qua logic source code, không phải kết luận rằng mô hình có lợi thế giao dịch.

---

## 3. Signal Structure

### Buy

```text
Close[2] < EMA[2] - ATR[2] × 1.5
AND
Close[1] > Open[1]
AND
Close[1] > Close[2]
AND
Close[1] < EMA[1]
```

### Sell

```text
Close[2] > EMA[2] + ATR[2] × 1.5
AND
Close[1] < Open[1]
AND
Close[1] < Close[2]
AND
Close[1] > EMA[1]
```

Signal được đánh giá trên candle đã hoàn thành.

---

## 4. Baseline Configuration

```text
EMA Period        = 20
ATR Period        = 14
ATR Multiplier    = 1.5

Stop Loss         = 300
Take Profit       = 600

Break Even        = ON
BE Trigger        = 150
BE Offset         = 0

Trailing Stop     = ON
Trailing Start    = 200
Trailing Distance = 100
Trailing Step     = 10
```

---

## 5. Baseline Backtest

Baseline:

```text
Symbol      = XAUUSD.PRO
Timeframe   = M1
Period      = 2026.01.02 – 2026.03.31
Deposit     = $1,000
Data        = 100% real ticks
```

Kết quả:

```text
Net Profit       = -$709.62
Profit Factor    = 0.93
Expected Payoff  = -$0.08
Max Balance DD   = 94.41%
Max Equity DD    = 94.44%
Total Trades     = 8,479
Win Rate         = 50.76%
```

---

## 6. Initial Observations

### 6.1 Win Rate

Profit trades chiếm `50.76%` tổng số trade.

Short win rate:

```text
51.22%
```

Long win rate:

```text
50.29%
```

### 6.2 Average Trade Result

Average winning trade:

```text
+$2.26
```

Average losing trade:

```text
-$2.50
```

Do đó, trong baseline, average loss lớn hơn average profit.

### 6.3 Drawdown

Maximum balance drawdown:

```text
94.41%
```

Maximum equity drawdown:

```text
94.44%
```

### 6.4 Trading Frequency

EA tạo:

```text
8,479 trades
16,958 deals
```

Average holding time:

```text
2 minutes 1 second
```

---

## 7. Research Questions

Các biến cần được nghiên cứu riêng biệt:

### Indicator Parameters

* EMA Period
* ATR Period
* ATR Multiplier

### Entry Logic

* Stretch threshold
* Candle confirmation
* Khoảng cách giữa candle stretch và candle confirmation
* Điều kiện close so với EMA

### Exit Logic

* Stop Loss
* Take Profit
* Break Even Trigger
* Break Even Offset
* Trailing Start
* Trailing Distance
* Trailing Step

### Direction

* Long-only
* Short-only
* Long + Short

---

## 8. Research Discipline

Mỗi experiment cần thay đổi một nhóm biến có kiểm soát.

Record cần bao gồm:

```text
Experiment ID
Parameter Change
Test Period
Symbol
Timeframe
Net Profit
Profit Factor
Expected Payoff
Max Drawdown
Total Trades
Win Rate
Average Win
Average Loss
```

Không sử dụng kết quả của một experiment để kết luận cho các parameter chưa được kiểm tra.

---

## 9. Baseline Status

```text
Implementation       : Complete
Baseline Backtest    : Complete
Parameter Research   : Not completed
Out-of-Sample Test   : Not completed
Robustness Test      : Not completed
Walk-Forward Test    : Not completed
```

Baseline hiện tại được dùng làm reference point cho các nghiên cứu tiếp theo.

---

## 10. Research Boundary

Không đưa ra kết luận về khả năng sinh lời trong tương lai chỉ dựa trên baseline test này.

Kết quả hiện tại chỉ mô tả hành vi của EA với cấu hình, symbol, timeframe và khoảng thời gian được ghi nhận trong Strategy Tester report.
