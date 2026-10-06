# EA-102 — VWAP + RSI — Research Plan

## 1. Research Objective

Mục tiêu nghiên cứu EA-102 là xác định liệu sự kết hợp:

```text
Daily VWAP
+
RSI Oversold / Overbought
+
RSI Reversal
```

có tạo ra một edge ổn định trên XAUUSD M1 hay không.

Baseline hiện tại có kết quả dương nhưng rất yếu:

```text
Net Profit      +$38.60
Profit Factor   1.02
Sharpe          2.80
Max Equity DD   13.57%
Trades          1,863
```

Do đó cần controlled research trước khi đưa ra kết luận.

---

## 2. Baseline Control

Giữ nguyên toàn bộ baseline trong mỗi experiment nếu parameter đó không thuộc nhóm đang nghiên cứu.

```text
VWAP = Daily VWAP
RSI Period = 14
RSI Oversold = 30
RSI Overbought = 70

BUY:
Close[2] < VWAP
Close[1] < VWAP
RSI[2] < 30
RSI[1] > RSI[2]

SELL:
Close[2] > VWAP
Close[1] > VWAP
RSI[2] > 70
RSI[1] < RSI[2]
```

---

## 3. Research Sequence

### RQ01 — RSI Period

Test:

```text
7
10
14
21
28
```

Mục tiêu:

Xác định RSI nhanh hay chậm phù hợp hơn với VWAP mean reversion.

---

### RQ02 — RSI Oversold / Overbought

Test các cặp:

```text
20 / 80
25 / 75
30 / 70
35 / 65
40 / 60
```

Không thay đổi các parameter khác.

---

### RQ03 — RSI Reversal Confirmation

So sánh:

```text
RSI[1] > RSI[2]
RSI[1] > Oversold
RSI[1] > RSI[2] AND RSI[1] > Oversold
RSI cross threshold
RSI slope confirmation
```

Đối với SELL áp dụng logic đối xứng.

---

### RQ04 — VWAP Relationship

Đánh giá các cách xác định giá nằm ngoài VWAP:

```text
Close below/above VWAP
Open below/above VWAP
High/Low interaction with VWAP
Distance from VWAP in points
Distance from VWAP as percentage
Distance from VWAP normalized by ATR
```

Mục tiêu là xác định khoảng cách VWAP có ảnh hưởng đến chất lượng mean-reversion signal hay không.

---

### RQ05 — VWAP Distance Filter

Test minimum/maximum distance từ VWAP.

Ví dụ:

```text
0 points
25 points
50 points
75 points
100 points
150 points
200 points
```

Chỉ thực hiện sau khi RQ04 xác định được cách đo phù hợp.

---

### RQ06 — Entry Confirmation

Test:

```text
RSI reversal only
Candle direction confirmation
Close toward VWAP
Close beyond previous close
Previous candle reversal
Two-candle reversal
Minimum candle body
```

Mục tiêu giảm các tín hiệu RSI reversal yếu.

---

### RQ07 — BUY vs SELL

Phân tích độc lập:

```text
BUY only
SELL only
BUY + SELL
```

Baseline cho thấy:

```text
BUY win rate  = 54.94%
SELL win rate = 46.24%
```

Do đó BUY và SELL cần được nghiên cứu riêng trước khi quyết định giữ symmetry.

---

### RQ08 — Stop Loss / Take Profit

Chỉ nghiên cứu sau khi entry logic có bằng chứng ổn định.

Test:

```text
SL 200 / TP 400
SL 250 / TP 500
SL 300 / TP 600
SL 400 / TP 800
SL 500 / TP 1000
```

Đánh giá theo:

* Profit Factor
* Expected Payoff
* Max Drawdown
* Recovery Factor
* Stability

---

### RQ09 — Break Even

Test:

```text
OFF
100 points
150 points
200 points
250 points
300 points
```

Giữ nguyên entry logic.

---

### RQ10 — Trailing Stop

Test:

```text
OFF
Start 200 / Distance 100
Start 200 / Distance 200
Start 300 / Distance 150
Start 300 / Distance 200
Start 400 / Distance 200
```

Mục tiêu xác định trailing có thực sự cải thiện expectancy hay chỉ làm giảm lợi nhuận của các lệnh thắng.

---

### RQ11 — Trading Session

Phân tích:

```text
Asian
London
New York
London + New York
All sessions
```

Không tối ưu session trước khi entry logic được đánh giá.

---

### RQ12 — Market Regime

Phân tích performance theo:

```text
Low volatility
High volatility
Trending
Ranging
VWAP compression
VWAP expansion
```

Mục tiêu xác định chiến lược VWAP + RSI hoạt động tốt trong regime nào.

---

### RQ13 — Out-of-Sample

Sau khi hoàn thành nghiên cứu và freeze candidate configuration:

```text
In-Sample
→ Freeze Configuration
→ Out-of-Sample
```

Không thay đổi parameter dựa trên OOS result.

---

### RQ14 — Robustness

Kiểm tra:

* RSI threshold perturbation
* VWAP distance perturbation
* SL/TP perturbation
* Spread increase
* Execution variation
* Different market periods
* BUY/SELL asymmetry

Candidate phải duy trì kết quả chấp nhận được khi parameter bị thay đổi hợp lý.

---

### RQ15 — Walk-Forward

Sau OOS và robustness:

```text
Training Window
→ Optimization / Research
→ Validation Window
→ Roll Forward
→ Repeat
```

Mục tiêu đánh giá khả năng duy trì edge theo thời gian.

---

## 4. Research Rules

1. Mỗi experiment chỉ thay đổi một nhóm biến.
2. Baseline phải được giữ nguyên.
3. Không chọn parameter chỉ dựa trên Net Profit.
4. Không tối ưu đồng thời nhiều nhóm parameter.
5. Không sử dụng OOS để điều chỉnh lại model.
6. Không chuyển sang live chỉ vì một backtest có lợi nhuận.
7. Ưu tiên stability hơn peak performance.
8. Candidate phải vượt qua OOS và robustness trước forward test.

---

## 5. Current Status

| Research Stage         | Status      |
| ---------------------- | ----------- |
| Baseline               | COMPLETE    |
| RSI Parameter Research | NOT STARTED |
| VWAP Distance Research | NOT STARTED |
| Entry Confirmation     | NOT STARTED |
| BUY vs SELL            | NOT STARTED |
| Exit Management        | NOT STARTED |
| Session                | NOT STARTED |
| Market Regime          | NOT STARTED |
| OOS                    | NOT STARTED |
| Robustness             | NOT STARTED |
| Walk-Forward           | NOT STARTED |
| Forward Test           | NOT STARTED |
| Live Trading           | NO          |

**Current Research Status:**

`IN PROGRESS`

**Optimization Status:**

`BLOCKED — Controlled research required before broad optimization`
