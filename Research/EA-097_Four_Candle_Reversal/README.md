# Research — EA-097 Four Candle Reversal

## 1. Research Objective

Mục tiêu của EA-097 là kiểm tra giả thuyết:

> Sau một chuỗi 4 nến liên tiếp cùng hướng, một nến đảo chiều có xác nhận về giá đóng cửa có thể tạo ra tín hiệu reversal có lợi thế trên XAUUSD M1.

---

## 2. Baseline Hypothesis

### BUY

```text
4 consecutive bearish candles
        ↓
bullish confirmation candle
        ↓
confirmation close > previous close
        ↓
BUY
```

### SELL

```text
4 consecutive bullish candles
        ↓
bearish confirmation candle
        ↓
confirmation close < previous close
        ↓
SELL
```

Baseline sử dụng:

```text
Timeframe = M1
SL = 300 points
TP = 600 points
Lot = 0.01
Break Even = 150 points
Trailing Start = 200 points
Trailing Distance = 100 points
```

---

## 3. Baseline Result

```text
Research ID: EA097-M1-BASELINE-001

Net Profit: -$487.18
Profit Factor: 0.91
Expected Payoff: -$0.10
Max Equity Drawdown: 61.57%
Total Trades: 4,642
Win Rate: 50.58%
```

Nguồn là Strategy Tester Report của EA-097.

---

## 4. Initial Research Conclusion

Baseline **không có edge rõ ràng**.

Điểm đáng chú ý:

* Win rate gần 50/50.
* Profit Factor < 1.
* Average loss lớn hơn average profit.
* Drawdown rất cao.
* Long và Short đều không cho thấy lợi thế đủ mạnh.
* Kết quả tổng thể âm dù số lượng trade lớn.

Vì vậy không nên chỉ tăng lot hoặc thay đổi risk để cải thiện kết quả.

Vấn đề cần nghiên cứu trước tiên là **chất lượng entry signal và cấu trúc reversal**.

---

## 5. Recommended Research Sequence

### Test 01 — Number of Consecutive Candles

So sánh:

```text
3 candles
4 candles
5 candles
6 candles
```

Mục tiêu: xác định độ dài chuỗi candle nào có khả năng tạo reversal tốt hơn.

---

### Test 02 — Confirmation Candle

Kiểm tra các biến thể:

```text
Close > previous close
Close > previous high
Close vượt midpoint
Body size minimum
Body / range ratio
```

Không thay đổi đồng thời các yếu tố khác.

---

### Test 03 — Candle Shadow Filter

Nghiên cứu:

```text
Maximum upper shadow
Maximum lower shadow
Shadow / body ratio
Shadow / candle range ratio
```

Mục tiêu là loại bỏ các nến reversal có rejection quá yếu hoặc quá nhiễu.

---

### Test 04 — Stop Loss / Take Profit

Baseline:

```text
SL = 300
TP = 600
```

Sau khi entry logic được xác nhận mới kiểm tra:

```text
SL 200 / TP 400
SL 300 / TP 600
SL 400 / TP 800
```

---

### Test 05 — Break Even / Trailing

Giữ nguyên entry logic và kiểm tra riêng:

```text
Break Even ON/OFF
Trailing ON/OFF
Different trigger
Different trailing distance
```

Không tối ưu entry và exit cùng lúc.

---

### Test 06 — Session Analysis

Phân tách kết quả theo thời gian giao dịch để kiểm tra liệu reversal pattern có phụ thuộc session hay không.

---

### Test 07 — Directional Analysis

Phân tích riêng:

```text
BUY
SELL
```

Mục tiêu xác định một phía có edge tốt hơn hay không.

---

### Test 08 — Out-of-Sample

Sau khi xác định được hypothesis có cơ sở:

```text
In-Sample
        ↓
Parameter selection
        ↓
Out-of-Sample
        ↓
Validation
```

Không sử dụng OOS để tiếp tục tối ưu tham số.

---

## 6. Research Rules

### Rule 1 — Preserve Baseline

Không sửa baseline trực tiếp.

Mỗi thay đổi phải tạo một research version mới.

### Rule 2 — One Major Variable

Mỗi experiment chỉ thay đổi một nhóm biến chính.

### Rule 3 — Record Everything

Mỗi test phải ghi:

```text
Version
Parameter
Test Period
Net Profit
Profit Factor
Max Drawdown
Trade Count
Win Rate
Average Win
Average Loss
```

### Rule 4 — Do Not Optimize Profit Alone

Không đánh giá một phiên bản chỉ dựa trên Net Profit.

### Rule 5 — No Premature Production

EA chỉ được xem xét production sau khi vượt qua:

```text
Baseline
+
Robustness
+
Out-of-Sample
+
Walk-forward
+
Risk validation
```

---

## 7. Current Research Status

```text
EA-097
Status: FAIL — Baseline
Next Step: Entry logic research
Production Ready: NO
```
