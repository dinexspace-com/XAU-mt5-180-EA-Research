# EA-100 — Bollinger + RSI Research

## Research Objective

Xác định liệu tín hiệu kết hợp:

```text
Bollinger Band Extreme
+
RSI Overbought / Oversold
```

có tạo ra lợi thế giao dịch ổn định trên XAUUSD M1 hay không.

Baseline hiện tại sử dụng:

```text
Bollinger Period = 20
Bollinger Deviation = 2.0
RSI Period = 14
RSI Lower = 30
RSI Upper = 70
```

---

## Baseline

```text
EA100-M1-BASELINE-001
```

Baseline result:

```text
PASS FOR FURTHER RESEARCH
```

Kết quả:

* Net Profit: +$694.91
* Profit Factor: 1.20
* Max Equity DD: 5.57%
* Trades: 3,096
* Win Rate: 54.62%
* Expected Payoff: +$0.22

---

# Controlled Research Sequence

Không tối ưu toàn bộ parameter cùng lúc.

Mỗi research question phải được test độc lập và so sánh với baseline.

---

## RQ01 — Bollinger Band Period

Mục tiêu:

Xác định sensitivity của strategy đối với chu kỳ Bollinger.

Test:

```text
10
15
20
25
30
40
50
```

Giữ nguyên các parameter khác.

---

## RQ02 — Bollinger Deviation

Mục tiêu:

Xác định mức độ extreme cần thiết để tạo tín hiệu.

Test:

```text
1.5
1.75
2.0
2.25
2.5
3.0
```

---

## RQ03 — RSI Period

Test:

```text
7
10
14
21
28
```

Mục tiêu là xác định RSI nhanh hay chậm phù hợp hơn với XAUUSD M1.

---

## RQ04 — RSI Threshold

### Lower / Upper pairs

```text
20 / 80
25 / 75
30 / 70
35 / 65
40 / 60
```

Không thay đổi Bollinger trong experiment này.

---

## RQ05 — Entry Confirmation

Baseline hiện tại vào lệnh chỉ dựa trên:

```text
Low <= Lower Band + RSI < Lower
```

hoặc:

```text
High >= Upper Band + RSI > Upper
```

Các biến thể cần nghiên cứu:

1. Close outside band.
2. Close back inside band.
3. Candle reversal confirmation.
4. Bullish/Bearish candle requirement.
5. Close location relative to candle range.
6. Previous candle confirmation.

Mục tiêu là xác định liệu confirmation có giảm false signals hay không.

---

## RQ06 — Shadow / Candle Structure

Nghiên cứu cấu trúc nến tại vùng Bollinger extreme:

* Upper shadow.
* Lower shadow.
* Body size.
* Shadow / Body ratio.
* Body / Range ratio.

Đặc biệt kiểm tra liệu một rejection wick mạnh có cải thiện chất lượng tín hiệu hay không.

---

## RQ07 — BUY vs SELL

Baseline cho thấy:

```text
BUY win rate  = 57.43%
SELL win rate = 51.06%
```

Cần kiểm tra độc lập:

```text
BUY only
SELL only
BUY + SELL
```

Mục tiêu không phải chỉ chọn phía có profit cao hơn, mà xác định liệu directional asymmetry có ổn định hay chỉ là đặc điểm của sample hiện tại.

---

## RQ08 — Stop Loss / Take Profit

Baseline:

```text
SL = 300
TP = 600
```

Nghiên cứu:

```text
SL:
200
250
300
350
400
500

TP:
400
500
600
700
800
1000
```

Không được tối ưu SL và TP đồng thời với toàn bộ indicator parameters ở vòng đầu.

---

## RQ09 — Break Even / Trailing Stop

Baseline:

```text
Break Even = ON
BE Trigger = 150
BE Offset = 0

Trailing = ON
Start = 200
Distance = 100
Step = 10
```

Test riêng:

1. BE OFF / Trailing OFF.
2. BE ON / Trailing OFF.
3. BE OFF / Trailing ON.
4. BE + Trailing.
5. Các trigger/distance khác nhau.

Mục tiêu là xác định contribution thực sự của exit management.

---

## RQ10 — Trading Session

Phân tích kết quả theo:

```text
Asian
London
New York
London + New York overlap
```

Mục tiêu:

* Xác định session có edge.
* Xác định session gây drawdown.
* Kiểm tra stability của edge theo thời gian trong ngày.

---

## RQ11 — Market Regime

Phân loại kết quả theo:

* Low volatility.
* Normal volatility.
* High volatility.
* Narrow Bollinger Band.
* Wide Bollinger Band.

Mục tiêu là xác định EA hoạt động tốt trong regime nào.

---

## RQ12 — Out-of-Sample

Sau khi hoàn thành controlled research:

```text
IN-SAMPLE
      ↓
Parameter Selection
      ↓
OUT-OF-SAMPLE
```

Không sử dụng OOS để tiếp tục điều chỉnh parameter.

---

## RQ13 — Robustness

Sau OOS:

* Parameter perturbation.
* Spread variation.
* Execution/slippage sensitivity.
* Different market periods.
* Different XAUUSD broker specifications.
* Monte Carlo / trade sequence analysis nếu có dữ liệu phù hợp.

---

## RQ14 — Walk-Forward

Mục tiêu:

Kiểm tra liệu strategy có giữ được performance khi parameter được chọn từ một historical window và áp dụng cho window tiếp theo hay không.

---

# Research Rules

### Rule 1 — One Variable Group at a Time

Mỗi experiment chỉ thay đổi một nhóm parameter.

### Rule 2 — Preserve Baseline

Không overwrite baseline.

### Rule 3 — Do Not Optimize Net Profit Alone

Không chọn parameter chỉ vì Net Profit cao nhất.

Theo dõi tối thiểu:

* Profit Factor.
* Expected Payoff.
* Max Drawdown.
* Recovery Factor.
* Sharpe.
* Trade Count.
* Win Rate.
* Average Win / Average Loss.
* Stability giữa các period.

### Rule 4 — Avoid Overfitting

Một parameter set chỉ tốt trên một historical sample không được xem là robust.

### Rule 5 — OOS Must Remain Independent

Không được dùng OOS để tiếp tục tuning.

### Rule 6 — No Live Deployment From Baseline Alone

Baseline tốt chỉ là điều kiện để nghiên cứu tiếp, không phải giấy phép live trading.

---

# Current Research Status

| Item                 | Status                    |
| -------------------- | ------------------------- |
| Strategy Code        | COMPLETE                  |
| Baseline Backtest    | COMPLETE                  |
| Baseline Assessment  | PASS FOR FURTHER RESEARCH |
| Parameter Evaluation | NOT STARTED               |
| Exit Evaluation      | NOT STARTED               |
| Session Analysis     | NOT STARTED               |
| OOS                  | NOT STARTED               |
| Robustness           | NOT STARTED               |
| Walk-Forward         | NOT STARTED               |
| Forward Test         | NOT STARTED               |
| Live Trading         | NO                        |

## Current Verdict

```text
RESEARCH IN PROGRESS
```

EA-100 có baseline đáng để nghiên cứu tiếp, nhưng chưa được xác nhận là production-ready.
