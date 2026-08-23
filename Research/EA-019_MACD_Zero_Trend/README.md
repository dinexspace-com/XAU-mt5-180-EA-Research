# XAUUSD MT5 EA Research

## 1. Purpose

Thư mục `Research/` lưu quá trình nghiên cứu các Expert Advisor trong repository:

```text
xauusd-mt5-ea-research/
```

Mục tiêu là biến kết quả backtest thành các câu hỏi nghiên cứu có thể kiểm chứng, thay vì thay đổi EA dựa trên cảm tính.

Quy trình:

```text
EA
 ↓
Backtest
 ↓
PASS / FAIL
 ↓
Research
 ↓
Hypothesis
 ↓
Controlled Test
 ↓
Evidence
 ↓
Conclusion
```

Research không tự xác nhận một EA là tốt hoặc xấu.

Mỗi kết luận phải dựa trên artifact và kết quả test thực tế.

---

# 2. Research Principles

## 2.1 Evidence First

Không kết luận dựa trên:

* Một vài giao dịch đẹp.
* Một đoạn balance curve ngắn.
* Win Rate riêng lẻ.
* Cảm giác về indicator.
* Một bộ parameter được optimization ra.

Ưu tiên evidence từ:

```text
MT5 Strategy Tester
+
Backtest Report
+
Controlled Comparison
```

---

## 2.2 One Change at a Time

Khi nghiên cứu một hypothesis, ưu tiên thay đổi **một yếu tố chính tại một thời điểm**.

Ví dụ:

```text
Baseline
MACD + Zero Line + EMA50
```

so với:

```text
Variant A
MACD + Zero Line
```

Khi đó có thể đánh giá riêng tác động của EMA50.

Không thay đồng thời:

```text
MACD
EMA
SL
TP
Break Even
Trailing
Timeframe
```

rồi kết luận yếu tố nào tạo ra cải thiện.

---

## 2.3 Baseline Must Be Preserved

Kết quả baseline phải được giữ nguyên.

Không sửa hoặc ghi đè artifact của backtest cũ.

Mỗi test mới phải có kết quả riêng để có thể so sánh:

```text
Baseline
vs
Variant
```

---

## 2.4 Failed Tests Are Valid Research Results

Một EA hoặc hypothesis FAIL vẫn là kết quả nghiên cứu có giá trị.

Không xóa kết quả FAIL.

Không chỉ lưu những backtest có lợi nhuận.

---

## 2.5 No Optimization Before Hypothesis

Không chạy optimization hàng loạt chỉ để tìm parameter có Profit cao.

Trước mỗi experiment phải xác định:

```text
Question
→ Hypothesis
→ Variable
→ Test
→ Evidence
→ Conclusion
```

Optimization chỉ nên thực hiện sau khi strategy có cơ sở nghiên cứu rõ ràng.

---

# 3. Current Research Cases

Hiện tại:

```text
Research Case #001
EA-019_MACD_Zero_Trend
```

Status:

```text
BACKTEST FAIL
→ RESEARCH REQUIRED
```

---

# 4. Research Case #001

## EA

```text
EA-019_MACD_Zero_Trend
```

Source:

```text
EAs/
└── EA-019_MACD_Zero_Trend/
    ├── EA-019_MACD_Zero_Trend.mq5
    └── README.md
```

Backtest evidence:

```text
Backtest/
└── EA-019_MACD_Zero_Trend/
```

---

# 5. Baseline Strategy

EA-019 sử dụng:

```text
MACD
+
MACD Zero Line
+
EMA50 Trend Filter
```

Default MACD:

```text
Fast   = 12
Slow   = 26
Signal = 9
```

Trend filter:

```text
EMA = 50
```

---

# 6. Baseline Entry Logic

## BUY

```text
MACD Main > 0
AND
MACD Main > MACD Signal
AND
Close > EMA50
```

## SELL

```text
MACD Main < 0
AND
MACD Main < MACD Signal
AND
Close < EMA50
```

Signal được lấy từ nến đã đóng.

---

# 7. Important Baseline Behavior

EA hiện tại không yêu cầu một MACD crossover mới xảy ra.

Ví dụ BUY kiểm tra trạng thái:

```text
MACD Main > MACD Signal
```

thay vì event:

```text
Previous MACD Main <= Previous Signal
AND
Current MACD Main > Current Signal
```

Vì vậy baseline hiện tại được xem là:

```text
MACD STATE strategy
```

không phải strict:

```text
MACD CROSSOVER strategy
```

Đây là một biến nghiên cứu quan trọng của EA-019.

---

# 8. Baseline Exit / Risk Logic

```text
Lot Size       = 0.01

Stop Loss      = 300 points
Take Profit    = 600 points

Break Even     = ON
BE Trigger     = 150 points

Trailing       = ON
Trailing Start = 200 points

Max Spread     = 30 points
```

Nominal SL/TP:

```text
300 : 600
≈
1 : 2
```

Tuy nhiên kết quả giao dịch thực tế còn chịu ảnh hưởng của:

* Spread.
* Break Even.
* Trailing Stop.
* Execution.
* Market movement.

---

# 9. Baseline Test

## Environment

```text
Symbol       = XAUUSD.PRO
Timeframe    = M1

Period:
2026-01-02
→
2026-04-01

Initial Deposit = $1,000
Leverage        = 1:500

History Quality = 100% real ticks
```

Sample:

```text
Bars  = 86,539
Ticks = 40,346,891
```

---

# 10. Baseline Results

| Metric              |       Result |
| ------------------- | -----------: |
| Net Profit          | **-$992.55** |
| Profit Factor       |     **0.91** |
| Expected Payoff     |   **-$0.17** |
| Sharpe Ratio        |    **-5.00** |
| Recovery Factor     |    **-0.97** |
| Max Equity Drawdown |   **99.27%** |
| Total Trades        |    **5,695** |
| Winning Trades      |   **39.82%** |
| Losing Trades       |   **60.18%** |

Direction:

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| BUY       |  2,852 |   41.76% |
| SELL      |  2,843 |   37.88% |

Average trade:

```text
Average Win  = $4.24
Average Loss = -$3.10
```

Maximum consecutive losses:

```text
15
```

Average holding time:

```text
00:03:17
```

---

# 11. Baseline Verdict

```text
RESULT: FAIL
```

Evidence:

```text
Net Profit      < 0
Profit Factor   < 1
Expected Payoff < 0
Sharpe Ratio    < 0

Max Drawdown ≈ 99%
```

EA-019 với cấu hình baseline hiện tại không đạt yêu cầu để chuyển sang forward/live validation.

Kết quả này chỉ áp dụng cho configuration và test sample đã thực hiện.

Nó chưa chứng minh rằng toàn bộ ý tưởng MACD Zero Trend không có edge.

---

# 12. Main Research Problem

Câu hỏi nghiên cứu chính:

> Vì sao EA-019_MACD_Zero_Trend có expectancy âm trên XAUUSD.PRO M1 trong baseline test?

Hiện tại chưa có đủ evidence để xác định một nguyên nhân duy nhất.

Do đó không sửa strategy ngay.

Trước tiên phải cô lập từng thành phần.

---

# 13. Research Variables

Các nhóm biến cần được nghiên cứu:

## A. Entry Logic

```text
MACD state
vs
MACD crossover
```

---

## B. Zero-Line Filter

```text
With Zero-Line filter
vs
Without Zero-Line filter
```

---

## C. EMA50 Filter

```text
With EMA50
vs
Without EMA50
```

---

## D. Exit Logic

```text
Fixed SL/TP
Break Even
Trailing Stop
```

---

## E. Direction

```text
BUY only
SELL only
BUY + SELL
```

Baseline cho thấy:

```text
BUY Win Rate  = 41.76%
SELL Win Rate = 37.88%
```

Đây chỉ là dấu hiệu cần nghiên cứu thêm.

Win Rate riêng lẻ chưa đủ để kết luận BUY tốt hơn SELL về expectancy.

---

## F. Timeframe

Baseline:

```text
M1
```

Các timeframe khác chưa được kiểm chứng trong Research Case #001.

---

# 14. Research Hypotheses

Các hypothesis dưới đây là **câu hỏi cần test**, không phải kết luận.

---

## H01 — MACD State May Produce Excess Entries

Baseline sử dụng:

```text
MACD Main > Signal
```

hoặc:

```text
MACD Main < Signal
```

thay vì chỉ entry khi crossover mới xuất hiện.

### Hypothesis

Việc sử dụng MACD state có thể tạo nhiều entry hơn strict crossover và có thể góp phần làm giảm chất lượng entry.

### Required Test

```text
Baseline:
MACD State

vs

Variant:
MACD Crossover
```

Giữ các thành phần khác không đổi.

### Status

```text
NOT TESTED
```

---

# 15. H02 — EMA50 Filter Effect

### Question

EMA50 có thực sự cải thiện strategy hay không?

### Test

```text
Baseline:
MACD + Zero + EMA50

vs

Variant:
MACD + Zero
```

Giữ nguyên:

```text
MACD parameters
SL
TP
Break Even
Trailing
Symbol
Timeframe
Test period
```

### Status

```text
NOT TESTED
```

---

# 16. H03 — Zero-Line Filter Effect

### Question

Điều kiện:

```text
BUY  → MACD > 0
SELL → MACD < 0
```

có cải thiện expectancy không?

### Test

```text
With Zero Line
vs
Without Zero Line
```

Các yếu tố khác giữ nguyên.

### Status

```text
NOT TESTED
```

---

# 17. H04 — Break Even Effect

Baseline:

```text
Break Even = ON
Trigger    = 150 points
```

### Question

Break Even có:

```text
Reduce losses
```

hay:

```text
Cut potential winners too early
```

?

### Test

```text
Break Even ON
vs
Break Even OFF
```

Các yếu tố khác giữ nguyên.

### Status

```text
NOT TESTED
```

---

# 18. H05 — Trailing Stop Effect

Baseline:

```text
Trailing Stop = ON
Start         = 200 points
```

### Question

Trailing Stop hiện tại cải thiện hay làm giảm expectancy?

### Test

```text
Trailing ON
vs
Trailing OFF
```

Các yếu tố khác giữ nguyên.

### Status

```text
NOT TESTED
```

---

# 19. H06 — BUY vs SELL Asymmetry

Baseline:

```text
BUY:
2,852 trades
41.76% won

SELL:
2,843 trades
37.88% won
```

### Hypothesis

BUY và SELL có thể có performance khác nhau trên sample hiện tại.

### Required Test

```text
BUY only

vs

SELL only

vs

BUY + SELL
```

So sánh expectancy và drawdown, không chỉ Win Rate.

### Status

```text
NOT TESTED
```

---

# 20. H07 — M1 May Be Too Noisy

Baseline chạy trên:

```text
M1
```

với:

```text
5,695 trades
```

và average holding time:

```text
3 minutes 17 seconds
```

### Hypothesis

Timeframe M1 có thể tạo nhiều tín hiệu ngắn hạn và strategy có thể có hành vi khác trên timeframe cao hơn.

### Required Test

Ví dụ:

```text
M1
M5
M15
H1
```

Không kết luận timeframe nào tốt hơn trước khi có test.

### Status

```text
NOT TESTED
```

---

# 21. Research Priority

Không test tất cả cùng lúc.

Thứ tự hiện tại:

```text
R01
MACD State vs MACD Crossover

↓

R02
EMA50 ON vs OFF

↓

R03
Zero-Line ON vs OFF

↓

R04
Break Even ON vs OFF

↓

R05
Trailing ON vs OFF

↓

R06
BUY vs SELL

↓

R07
Timeframe comparison
```

Mỗi experiment phải hoàn thành và lưu evidence trước khi chuyển sang kết luận.

---

# 22. Research Test Template

Mỗi experiment nên ghi theo format:

```text
Research ID:
EA:
Question:
Hypothesis:

Baseline:
Variant:

Changed Variable:

Fixed Variables:

Symbol:
Timeframe:
Period:
History Quality:

Baseline Result:
Variant Result:

Net Profit:
Profit Factor:
Expected Payoff:
Max Drawdown:
Total Trades:
Win Rate:
Average Win:
Average Loss:

Evidence:

Conclusion:

PASS / FAIL / INCONCLUSIVE:

Next Action:
```

---

# 23. Minimum Comparison Metrics

Khi so sánh hai variant, tối thiểu phải xem:

```text
Net Profit
Profit Factor
Expected Payoff
Max Drawdown
Total Trades
Win Rate
Average Win
Average Loss
```

Không chọn strategy chỉ dựa trên:

```text
Net Profit
```

Một variant có Profit cao hơn nhưng Drawdown cực lớn chưa chắc tốt hơn.

---

# 24. Research Status Table

| ID           | Research Question        | Status     |
| ------------ | ------------------------ | ---------- |
| BASE-019-001 | Original EA-019 baseline | **FAIL**   |
| R01          | MACD State vs Crossover  | NOT TESTED |
| R02          | EMA50 ON vs OFF          | NOT TESTED |
| R03          | Zero-Line ON vs OFF      | NOT TESTED |
| R04          | Break Even ON vs OFF     | NOT TESTED |
| R05          | Trailing ON vs OFF       | NOT TESTED |
| R06          | BUY vs SELL              | NOT TESTED |
| R07          | Timeframe Comparison     | NOT TESTED |

---

# 25. Current Evidence

Hiện tại Research Case #001 có:

```text
Source Code
    ↓
EAs/EA-019_MACD_Zero_Trend/

Backtest Evidence
    ↓
Backtest/EA-019_MACD_Zero_Trend/

Baseline Result
    ↓
FAIL

Research
    ↓
OPEN
```

Các chỉ số baseline quan trọng:

```text
Net Profit          = -$992.55
Profit Factor       = 0.91
Expected Payoff     = -$0.17
Max Equity Drawdown = 99.27%
Total Trades        = 5,695
Win Rate            = 39.82%
```

---

# 26. Current Conclusion

Tại thời điểm hiện tại:

```text
EA-019_MACD_Zero_Trend
        ↓
Implementation complete
        ↓
Baseline backtest complete
        ↓
Baseline FAIL
        ↓
Research OPEN
```

Chưa có evidence để xác nhận:

```text
MACD is the problem
EMA50 is the problem
Zero Line is the problem
SL/TP is the problem
Break Even is the problem
Trailing is the problem
M1 is the problem
```

Do đó:

```text
DO NOT GUESS
DO NOT RANDOMLY OPTIMIZE
TEST EACH HYPOTHESIS
```

---

# 27. Next Research Action

Research experiment tiếp theo:

```text
R01 — MACD State vs MACD Crossover
```

Mục tiêu:

```text
Xác định việc chuyển từ MACD state
sang strict MACD crossover
có cải thiện chất lượng strategy hay không.
```

Baseline phải được giữ nguyên làm control.

Chỉ thay đổi logic signal cần nghiên cứu.

Kết quả R01 phải có Strategy Tester artifact trước khi đưa ra kết luận.
