# Research

Thư mục này lưu các ghi chú, giả thuyết và kết luận nghiên cứu của dự án **XAUUSD MT5 EA Research**.

Mục tiêu không phải chứng minh một EA có lợi nhuận bằng một backtest đơn lẻ, mà xây dựng quá trình:

```text
Strategy Idea
    ↓
Implementation
    ↓
Backtest
    ↓
Analyze
    ↓
Identify Problems
    ↓
New Hypothesis
    ↓
Modify
    ↓
Retest
```

Mỗi EA được xem như một **research experiment**.

---

# EA-024 — Donchian Trend

## 1. Research Question

EA-024 nghiên cứu một hệ thống **trend-following / breakout** dựa trên ý tưởng Donchian.

Câu hỏi chính:

> Một hệ thống breakout theo vùng giá Donchian có tạo được lợi thế giao dịch trên XAUUSD hay không?

Các yếu tố được nghiên cứu gồm:

* Breakout entry.
* Donchian period.
* Stop Loss.
* Take Profit.
* Break Even.
* Trailing Stop.
* Spread filter.
* Long/Short behavior.
* Trade frequency.
* Holding time.
* Maximum Favorable Excursion (MFE).
* Maximum Adverse Excursion (MAE).

---

# 2. Baseline Strategy

Phiên bản baseline của EA sử dụng:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
Donchian Period: 20

Lot Size: 0.01

Stop Loss: 300 points
Take Profit: 600 points

Break Even: ON
Trigger: 150 points

Trailing Stop: ON
Start: 200 points

Maximum Spread: 30 points
Maximum Positions: 1
```

Baseline này được sử dụng làm mốc để đánh giá các thay đổi sau này.

---

# 3. Baseline Backtest

Baseline test:

```text
EA: EA-024_Donchian_Trend
Symbol: XAUUSD.PRO
Timeframe: M1

Period:
2026.01.02 → 2026.03.01

Initial Deposit:
$1,000

History Quality:
100% real ticks
```

Kết quả chính:

| Metric                     |   Result |
| -------------------------- | -------: |
| Total Trades               |    9,320 |
| Net Profit                 | -$992.04 |
| Profit Factor              |     0.95 |
| Expected Payoff            |    -0.11 |
| Win Rate                   |   32.79% |
| Loss Rate                  |   67.21% |
| Maximum Drawdown           |   99.26% |
| Average Profit Trade       |    $6.14 |
| Average Loss Trade         |   -$3.15 |
| Maximum Consecutive Losses |       19 |
| Average Holding Time       |   3m 13s |

### Baseline Verdict

```text
FAIL
```

Baseline hiện tại không cho thấy một hệ thống có expectancy dương.

Đặc biệt:

```text
Profit Factor < 1
Expected Payoff < 0
Net Profit < 0
Maximum Drawdown ≈ 99%
```

Do đó EA chưa đủ điều kiện để chuyển sang validation hoặc live testing.

---

# 4. Important Finding — Implementation

Review source code baseline phát hiện một vấn đề quan trọng trong cách Donchian được triển khai.

Implementation hiện tại sử dụng dạng:

```mql5
iHigh(_Symbol, PERIOD_CURRENT, InpDonchianPeriod);
iLow(_Symbol, PERIOD_CURRENT, InpDonchianPeriod);
```

Trong implementation này, `InpDonchianPeriod` đang được sử dụng như **bar shift**.

Với:

```text
InpDonchianPeriod = 20
```

EA đang tham chiếu High/Low của bar ở shift 20.

Nó không tương đương với việc tính:

```text
Highest High của 20 bars trước
Lowest Low của 20 bars trước
```

Vì vậy baseline backtest hiện tại **không nên được sử dụng để kết luận rằng Donchian breakout chuẩn không hoạt động**.

Nó chỉ cho phép kết luận:

> Implementation hiện tại của EA-024 không đạt yêu cầu trong điều kiện backtest đã sử dụng.

---

# 5. Important Finding — Position Management

Source review cũng phát hiện vấn đề trong execution flow.

Logic giới hạn position được kiểm tra trước phần:

```text
Break Even
Trailing Stop
```

Khi:

```text
InpMaxPositions = 1
```

và EA đã có một position, execution có thể thoát trước khi phần quản lý position được chạy.

Do đó cần kiểm tra và sửa execution flow trước vòng nghiên cứu tiếp theo.

---

# 6. New-Bar Management

EA baseline sử dụng new-bar detection.

Điều này có nghĩa phần logic nằm sau điều kiện new bar không được xử lý liên tục trên mọi tick.

Đây là điểm đặc biệt quan trọng đối với:

```text
Break Even
Trailing Stop
Position Management
```

Cần xác định rõ trong version tiếp theo:

```text
Entry logic
→ kiểm tra trên new bar

Position management
→ kiểm tra trên tick hay new bar?
```

Hai chức năng này không nên mặc nhiên được xem là cùng một loại execution.

---

# 7. What the Baseline Tells Us

Baseline FAIL không đồng nghĩa với việc ý tưởng Donchian Trend đã bị bác bỏ.

Baseline hiện tại cho biết:

### Finding 1

Implementation cần được xác minh trước khi đánh giá strategy concept.

### Finding 2

EA giao dịch rất nhiều:

```text
9,320 trades
```

trong khoảng hai tháng trên M1.

Trade frequency cần được nghiên cứu.

### Finding 3

Win rate thấp:

```text
32.79%
```

nhưng:

```text
Average Win  = $6.14
Average Loss = $3.15
```

Average winner lớn gần gấp đôi average loser.

Điều này cho thấy vấn đề không thể chỉ được đánh giá bằng win rate.

Cần nghiên cứu đồng thời:

```text
Win Rate
×
Average Win
×
Average Loss
×
Trade Frequency
```

### Finding 4

Profit Factor:

```text
0.95
```

nằm dưới mức hòa vốn.

Baseline vì vậy đang có negative expectancy, nhưng khoảng cách tới `1.0` cũng là thông tin hữu ích cho các experiment tiếp theo.

### Finding 5

Drawdown:

```text
99.26%
```

là vấn đề nghiêm trọng nhất của baseline.

Bất kỳ version tiếp theo nào cũng phải đánh giá drawdown cùng profitability.

Không chấp nhận cải thiện Net Profit bằng cách làm risk tăng mất kiểm soát.

---

# 8. MFE / MAE Observation

Baseline ghi nhận:

```text
Correlation (Profit, MFE) = 0.84
Correlation (Profit, MAE) = 0.72
```

Profit/MFE correlation cao là tín hiệu đáng để nghiên cứu thêm về exit behavior.

Các câu hỏi cần kiểm tra sau khi implementation được sửa:

```text
Winning trades có bị thoát quá sớm không?

Take Profit hiện tại có phù hợp không?

Break Even có làm mất những trade đáng lẽ trở thành winner không?

Trailing Stop có giữ được phần đủ lớn của favorable excursion không?
```

Đây hiện là **research questions**, chưa phải kết luận.

---

# 9. Market-Regime Observation

Balance curve baseline không giảm đều từ đầu đến cuối.

Có giai đoạn:

```text
Drawdown
    ↓
Strong Recovery
    ↓
New Balance High
    ↓
Long Decline
```

Điều này tạo ra một research question quan trọng:

> EA có hoạt động tốt trong một số market regimes nhưng thất bại trong những regime khác hay không?

Hiện chưa đủ bằng chứng để kết luận nguyên nhân.

Không thêm regime filter trước khi implementation cơ bản được sửa và retest.

---

# 10. Research Priority

Không optimize hàng loạt parameters ở thời điểm hiện tại.

Thứ tự nghiên cứu:

```text
1. Correct implementation
        ↓
2. Retest same baseline
        ↓
3. Analyze behavior
        ↓
4. Form one hypothesis
        ↓
5. Change one major variable
        ↓
6. Retest
        ↓
7. Compare
```

Mục tiêu là xác định **nguyên nhân**, không tìm một bộ parameter đẹp bằng brute-force optimization.

---

# 11. Experiment 01 — Correct Donchian Calculation

## Hypothesis

Nếu Donchian Channel được tính bằng:

```text
Highest High của N bars
Lowest Low của N bars
```

thì behavior của EA sẽ khác đáng kể baseline hiện tại.

## Change

Chỉ sửa cách tính Donchian Channel.

Không optimize:

```text
SL
TP
Lot
Break Even
Trailing
Spread
```

trong experiment này.

## Test

Giữ nguyên:

```text
Symbol
Timeframe
Test period
Initial deposit
Trading parameters
Data quality
```

để so sánh trực tiếp với baseline.

## Compare

So sánh:

```text
Trade Count
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Average Win
Average Loss
```

---

# 12. Experiment 02 — Correct Position Management

Sau khi Donchian implementation được xác nhận, kiểm tra execution của:

```text
Break Even
Trailing Stop
```

Position management phải tiếp tục hoạt động khi EA đã đạt:

```text
InpMaxPositions
```

Đồng thời cần xác định rõ management chạy:

```text
Every Tick
```

hay:

```text
New Bar Only
```

Không thay đổi nhiều cơ chế cùng lúc nếu việc đó làm mất khả năng xác định nguyên nhân cải thiện hoặc suy giảm kết quả.

---

# 13. Later Research

Chỉ sau khi core implementation được xác nhận mới nghiên cứu tiếp:

```text
Donchian Period
Timeframe
Stop Loss
Take Profit
Break Even
Trailing Stop
Spread Filter
Trading Session
Long vs Short
Market Regime
```

Không optimize toàn bộ cùng lúc.

---

# 14. Research Rules

Để tránh overfitting:

### Rule 1

Không thay đổi nhiều biến mà không có hypothesis rõ ràng.

### Rule 2

Mỗi experiment phải lưu lại:

```text
Hypothesis
Code Version
Parameters
Test Period
Result
Conclusion
```

### Rule 3

Một backtest profitable không đủ để PASS strategy.

### Rule 4

Không chọn parameter chỉ vì nó hoạt động tốt nhất trên cùng một dataset.

### Rule 5

Sau khi có candidate strategy cần kiểm tra trên dữ liệu ngoài giai đoạn development.

### Rule 6

FAIL result không bị xóa.

Negative results là một phần của research history.

---

# 15. Current Research Status

```text
EA-024_Donchian_Trend

Baseline:
❌ FAIL

Evidence:
Net Profit        = -$992.04
Profit Factor     = 0.95
Expected Payoff   = -0.11
Maximum Drawdown  = 99.26%
Trades            = 9,320

Important:
Baseline contains implementation issues.

Therefore:

DONCHIAN STRATEGY
≠
REJECTED

CURRENT IMPLEMENTATION
=
FAILED BASELINE
```

---

# 16. Next Experiment

```text
EA-024
│
├── Baseline Backtest
│   └── ❌ FAIL
│
├── Code Review
│   ├── Donchian calculation issue
│   └── Position-management execution issue
│
└── NEXT
    └── Fix Donchian implementation
        ↓
       Retest using same conditions
        ↓
       Compare against baseline
```

**Next research task:**

> Correct Donchian calculation and establish a clean EA-024 baseline before parameter optimization.
