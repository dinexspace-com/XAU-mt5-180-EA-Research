# Research — EA-018_DI_Trend

## 1. Research Target

**EA:** `EA-018_DI_Trend`
**Market:** XAUUSD
**Platform:** MetaTrader 5
**Strategy Family:** Trend Following
**Core Indicators:** DMI / ADX + EMA

Mục tiêu nghiên cứu:

> Kiểm tra liệu việc kết hợp hướng `+DI / -DI` với EMA trend có tạo ra trading edge đủ ổn định trên XAUUSD hay không.

Research được thực hiện theo thứ tự:

```text
Strategy idea
    ↓
EA implementation
    ↓
Baseline backtest
    ↓
Diagnose
    ↓
Hypothesis
    ↓
Retest
    ↓
Optimization
    ↓
Validation
```

Không optimization trước khi xác nhận logic chiến lược và implementation hoạt động đúng.

---

# 2. Strategy Hypothesis

Giả thuyết ban đầu:

### BUY

```text
+DI > -DI
AND
EMA đang tăng
→ BUY
```

### SELL

```text
-DI > +DI
AND
EMA đang giảm
→ SELL
```

Ý tưởng cơ bản:

* DMI xác định bên mua hoặc bên bán đang chiếm ưu thế.
* EMA xác nhận hướng trend.
* Chỉ giao dịch khi hai tín hiệu cùng hướng.

---

# 3. Current Implementation

Version hiện tại:

```text
EA-018_DI_Trend v1.00
```

Các thành phần chính:

| Component        | Current       |
| ---------------- | ------------- |
| EMA              | 50            |
| DMI / ADX Period | 14            |
| Stop Loss        | 300 points    |
| Take Profit      | 600 points    |
| Lot              | 0.01          |
| Spread Filter    | 30 points     |
| Max Positions    | 1             |
| Entry Evaluation | New bar       |
| Symbol           | Current chart |
| Timeframe        | Current chart |

EA sử dụng `iADX()` nhưng hiện tại chủ yếu sử dụng:

```text
+DI
-DI
```

Giá trị ADX chính chưa được sử dụng làm minimum trend-strength filter.

---

# 4. Baseline Test

Baseline đầu tiên đã hoàn thành.

```text
Symbol      : XAUUSD.PRO
Timeframe   : M1
Period      : 2026-01-02 → 2026-06-08
Data        : 100% real ticks
Deposit     : $1,000
Leverage    : 1:500
Lot         : 0.01
```

Baseline sử dụng:

```text
Break Even    = false
Trailing Stop = false
```

History Quality:

```text
100% real ticks
151,130 bars
65,497,516 ticks
```

---

# 5. Baseline Result

## Result: ❌ FAIL

| Metric           |       Result |
| ---------------- | -----------: |
| Net Profit       | **-$993.61** |
| Profit Factor    |     **0.89** |
| Expected Payoff  |   **-$0.24** |
| Maximum Drawdown |   **99.36%** |
| Sharpe Ratio     |    **-5.00** |
| Recovery Factor  |    **-1.00** |
| Total Trades     |    **4,096** |
| Win Rate         |   **31.20%** |
| Losing Trades    |   **68.80%** |

Balance curve giảm rõ ràng trong toàn bộ quá trình test.

Baseline gần như mất toàn bộ initial deposit.

---

# 6. Long vs Short

Baseline:

```text
Short Trades = 2,235
Win Rate     = 30.16%

Long Trades  = 1,861
Win Rate     = 32.46%
```

Cả BUY và SELL đều có win rate thấp.

Chưa có bằng chứng từ baseline cho thấy vấn đề chỉ nằm ở một phía BUY hoặc SELL.

---

# 7. Reward / Risk Observation

Kết quả trung bình:

```text
Average Profit Trade = +$6.15
Average Loss Trade   = -$3.14
```

Average winner lớn hơn average loser.

Tuy nhiên:

```text
Winning Trades = 31.20%
Losing Trades  = 68.80%
```

Tần suất thua quá cao khiến expectancy tổng thể âm:

```text
Expected Payoff = -$0.24
Profit Factor   = 0.89
```

Do đó vấn đề hiện tại không đơn giản chỉ là kích thước TP/SL.

Entry quality cần được kiểm tra trước.

---

# 8. Trade Frequency

Baseline tạo:

```text
4,096 trades
```

trong khoảng:

```text
2026-01-02 → 2026-06-08
```

Timeframe:

```text
M1
```

Average holding time:

```text
00:04:56
```

Minimum:

```text
00:00:01
```

Maximum:

```text
04:10:59
```

Đây là tần suất giao dịch cao đối với một strategy được định hướng là trend-following.

### Research Question

Cần xác minh:

> EA có đang coi trạng thái `+DI > -DI` / `-DI > +DI` là tín hiệu entry mới quá thường xuyên hay không?

---

# 9. Primary Suspect — EMA Slope

Source hiện tại sử dụng dữ liệu EMA thông qua `CopyBuffer()`.

Điều kiện trong implementation cần được kiểm tra để đảm bảo thứ tự dữ liệu đúng với strategy intent.

Strategy intent phải là:

### BUY

```text
EMA của nến vừa đóng
>
EMA của nến trước đó
```

### SELL

```text
EMA của nến vừa đóng
<
EMA của nến trước đó
```

### Status

```text
EMA SLOPE IMPLEMENTATION
STATUS: NOT VERIFIED
```

Đây là vấn đề cần kiểm tra **trước optimization**.

Nếu EMA slope bị đảo ngược thì baseline hiện tại không đại diện đúng cho strategy hypothesis ban đầu.

---

# 10. DMI Signal Question

Implementation hiện tại về cơ bản sử dụng trạng thái:

```text
+DI > -DI
```

hoặc:

```text
-DI > +DI
```

Điều này khác với yêu cầu bắt buộc phải có **DI crossover mới**.

Ví dụ:

```text
+DI > -DI
```

có thể tồn tại nhiều nến liên tục.

EA vì vậy có khả năng tiếp tục tìm entry mới khi position trước đã đóng nhưng trạng thái DI vẫn chưa thay đổi.

### Research Question

Cần so sánh ít nhất hai hypothesis:

**H1 — DI State**

```text
BUY  = +DI > -DI
SELL = -DI > +DI
```

**H2 — DI Crossover**

```text
BUY:
+DI vừa cross lên -DI

SELL:
-DI vừa cross lên +DI
```

Chưa kết luận H2 tốt hơn cho đến khi backtest.

---

# 11. ADX Strength Filter

EA sử dụng indicator ADX nhưng hiện chưa yêu cầu:

```text
ADX > threshold
```

Do đó DMI có thể tạo tín hiệu ngay cả khi trend strength yếu.

### Research Hypothesis

Có thể kiểm tra:

```text
ADX >= threshold
```

nhằm loại bỏ market condition không có trend đủ mạnh.

Ví dụ threshold phải được nghiên cứu bằng test, không tự mặc định là tối ưu.

### Status

```text
NOT TESTED
```

---

# 12. M1 Suitability

Baseline hiện chỉ xác nhận:

```text
EA-018_DI_Trend
+
XAUUSD.PRO
+
M1
+
Current parameters
=
FAIL
```

Nó chưa chứng minh strategy thất bại trên mọi timeframe.

Do đó cần tách:

```text
Strategy failure
```

khỏi:

```text
M1 configuration failure
```

### Candidate Timeframes

Sau khi xác nhận implementation đúng, có thể kiểm tra:

```text
M5
M15
M30
H1
```

Không optimization parameter ở giai đoạn này.

Mục đích chỉ là kiểm tra sensitivity theo timeframe.

---

# 13. Current Research Questions

Các câu hỏi hiện tại theo thứ tự ưu tiên:

### RQ-01 — EMA implementation

```text
EMA slope có đang được đọc đúng chiều không?
```

**Priority:** CRITICAL

---

### RQ-02 — Entry frequency

```text
EA có đang re-entry quá nhiều khi DI vẫn giữ nguyên trạng thái không?
```

**Priority:** HIGH

---

### RQ-03 — DI crossover

```text
DI crossover có cải thiện chất lượng entry so với DI state không?
```

**Priority:** HIGH

---

### RQ-04 — ADX strength

```text
Có cần minimum ADX threshold để loại bỏ weak trend không?
```

**Priority:** MEDIUM

---

### RQ-05 — Timeframe

```text
Trend logic này có phù hợp hơn với M5/M15/M30/H1 thay vì M1 không?
```

**Priority:** MEDIUM

---

### RQ-06 — Exit

```text
SL 300 / TP 600 có phù hợp với volatility của XAUUSD không?
```

**Priority:** LATER

Chưa nghiên cứu exit trước khi entry logic được xác nhận.

---

# 14. Research Order

Không test mọi thứ cùng lúc.

Thứ tự:

```text
STEP 1
Verify EMA slope implementation
        ↓
STEP 2
Re-run identical M1 baseline
        ↓
STEP 3
Compare DI State vs DI Crossover
        ↓
STEP 4
Test ADX strength filter
        ↓
STEP 5
Test timeframe sensitivity
        ↓
STEP 6
Only if edge appears:
research SL / TP
        ↓
STEP 7
Optimization
        ↓
STEP 8
Out-of-sample / Forward validation
```

Mỗi bước chỉ thay đổi **một nhóm giả thuyết chính** để có thể xác định nguyên nhân kết quả thay đổi.

---

# 15. Optimization Gate

Optimization hiện tại:

```text
BLOCKED
```

Không chạy parameter optimization khi:

```text
EMA implementation chưa verified
AND
Baseline expectancy < 0
AND
Profit Factor < 1
AND
Drawdown ≈ 99%
```

Optimization chỉ được mở sau khi có một implementation hợp lệ và baseline cho thấy tín hiệu đủ đáng nghiên cứu tiếp.

---

# 16. Current Evidence

Source:

```text
EAs/
└── EA-018_DI_Trend/
    ├── EA-018_DI_Trend.mq5
    └── README.md
```

Baseline evidence:

```text
Backtest/
└── EA-018_DI_Trend/
    ├── README.md
    ├── ReportTester-953688(3).html
    ├── ReportTester-953688(3).png
    ├── ReportTester-953688-hst(3).png
    ├── ReportTester-953688-mfemae(3).png
    └── ReportTester-953688-holding(3).png
```

---

# 17. Research Status

```text
EA                : EA-018_DI_Trend
Strategy          : DI + EMA Trend
Market            : XAUUSD
Platform          : MT5

Source Review     : DONE
Baseline          : DONE
Baseline Result   : FAIL

EMA Verification  : REQUIRED
DI State Test     : DONE — FAIL on current baseline
DI Crossover Test : NOT STARTED
ADX Filter Test   : NOT STARTED
Timeframe Test    : NOT STARTED
SL/TP Research    : NOT STARTED
Optimization      : BLOCKED
Forward Test      : NOT STARTED
```

---

# 18. Current Conclusion

Baseline hiện tại **không chứng minh strategy DI + EMA hoàn toàn không có edge**.

Nó chứng minh rằng implementation/configuration hiện tại trên:

```text
XAUUSD.PRO
M1
2026-01-02 → 2026-06-08
```

không đạt yêu cầu:

```text
Net Profit      = -$993.61
Profit Factor   = 0.89
Max Drawdown    = 99.36%
Win Rate        = 31.20%
```

Không nên optimization từ baseline này.

Ưu tiên nghiên cứu tiếp theo là:

```text
VERIFY EMA SLOPE IMPLEMENTATION
```

Sau khi xác minh implementation, chạy lại cùng baseline để tạo phép so sánh trực tiếp.

---

# 19. Next Research Task

```text
TASK: RQ-01
NAME: Verify EMA Slope Implementation

INPUT:
EAs/EA-018_DI_Trend/EA-018_DI_Trend.mq5

CHECK:
- CopyBuffer indexing
- EMA bar 1
- EMA bar 2
- BUY slope direction
- SELL slope direction

OUTPUT:
Kết luận PASS / FAIL cho EMA slope implementation.

STOP:
Không thay đổi strategy.
Không optimization.
Không thêm filter.
Không chỉnh SL/TP.
```
