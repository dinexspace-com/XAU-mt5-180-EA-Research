# XAUUSD MT5 EA Research — Methodology

## 1. Mục đích

Repository này được sử dụng để nghiên cứu, kiểm thử và đánh giá các Expert Advisor (EA) giao dịch **XAUUSD trên MetaTrader 5**.

Mục tiêu của methodology là đảm bảo mỗi EA được đánh giá theo cùng một quy trình:

```text
Strategy
    ↓
Implementation
    ↓
Code Verification
    ↓
Baseline Backtest
    ↓
Diagnosis
    ↓
Hypothesis Testing
    ↓
Optimization
    ↓
Validation
```

Nguyên tắc chính:

> Không đánh giá EA chỉ dựa trên ý tưởng chiến lược hoặc một kết quả backtest đơn lẻ.

---

# 2. Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-<ID>_<NAME>/
│       ├── EA-<ID>_<NAME>.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-<ID>_<NAME>/
│
├── Research/
│   └── README.md
│
├── docs/
│   └── methodology.md
│
└── GitHub_Profile/
    └── README.md
```

Mỗi nhóm thư mục có một nhiệm vụ riêng.

---

# 3. `EAs/`

Lưu source code và tài liệu kỹ thuật của từng EA.

Ví dụ:

```text
EAs/
└── EA-018_DI_Trend/
    ├── EA-018_DI_Trend.mq5
    └── README.md
```

README của EA cần mô tả:

* Strategy logic
* Entry logic
* Exit logic
* Indicators
* Inputs
* Risk / position sizing
* Trade management
* Filters
* Implementation notes
* Known issues
* Current status

README phải phản ánh **code thực tế**, không chỉ strategy intent.

Nếu strategy intent và implementation khác nhau, phải ghi rõ.

---

# 4. `Backtest/`

Lưu bằng chứng kiểm thử thực tế của từng EA.

Ví dụ:

```text
Backtest/
└── EA-018_DI_Trend/
    ├── README.md
    ├── report.html
    └── report images
```

Backtest README phải ghi tối thiểu:

```text
EA
Symbol
Timeframe
Test period
Broker
Initial deposit
Leverage
Data quality
Inputs
Net Profit
Profit Factor
Drawdown
Expected Payoff
Sharpe Ratio
Total Trades
Win Rate
PASS / FAIL
```

Không tự điền hoặc ước lượng số liệu không tồn tại trong Strategy Tester Report.

---

# 5. `Research/`

Lưu quá trình nghiên cứu và các hypothesis cần kiểm chứng.

Research không chỉ trả lời:

```text
EA có lời hay không?
```

Mà phải trả lời:

```text
Tại sao EA có kết quả như vậy?
```

và:

```text
Hypothesis nào cần kiểm tra tiếp?
```

Ví dụ:

```text
RQ-01 — Indicator implementation đúng chưa?

RQ-02 — Entry có quá thường xuyên không?

RQ-03 — Crossover có tốt hơn state condition không?

RQ-04 — Trend-strength filter có cần thiết không?

RQ-05 — Strategy phù hợp timeframe nào?
```

---

# 6. Research Principle

Mỗi thay đổi phải bắt đầu bằng một hypothesis.

Không làm:

```text
Backtest FAIL
→ thay hàng loạt parameter
→ chạy optimization
→ chọn kết quả đẹp nhất
```

Thay vào đó:

```text
Observation
    ↓
Hypothesis
    ↓
One controlled change
    ↓
Backtest
    ↓
Compare
    ↓
Accept / Reject hypothesis
```

---

# 7. Stage 1 — Strategy Definition

Trước khi code hoặc sửa EA, phải xác định strategy intent.

Tối thiểu cần biết:

```text
Market
Timeframe hypothesis
Entry BUY
Entry SELL
Exit
Stop Loss
Take Profit
Position sizing
Trade filters
```

Ví dụ:

```text
BUY:
Condition A
AND
Condition B

SELL:
Condition C
AND
Condition D
```

Logic phải đủ rõ để có thể kiểm tra implementation có đúng hay không.

---

# 8. Stage 2 — Implementation Review

Trước khi đánh giá performance, kiểm tra source code.

Mục tiêu:

> Xác nhận EA đang thực hiện đúng strategy được mô tả.

Kiểm tra tối thiểu:

### Indicators

```text
Indicator handle
Buffer
Period
Timeframe
Applied price
Data indexing
```

### Entry

```text
BUY condition
SELL condition
New-bar logic
Re-entry behavior
Position limit
```

### Exit

```text
Stop Loss
Take Profit
Break Even
Trailing Stop
Other exit conditions
```

### Execution

```text
Lot size
Magic Number
Spread filter
Slippage
Price normalization
```

---

# 9. Implementation Verification Gate

Nếu phát hiện một vấn đề có khả năng làm implementation khác strategy intent:

```text
IMPLEMENTATION STATUS = NOT VERIFIED
```

Không chuyển trực tiếp sang optimization.

Phải:

```text
Identify
    ↓
Verify
    ↓
Fix if confirmed
    ↓
Compile
    ↓
Run baseline again
```

---

# 10. Stage 3 — Baseline Backtest

Baseline là backtest đầu tiên dùng để tạo điểm tham chiếu.

Baseline không nhằm tìm parameter tốt nhất.

Mục tiêu:

```text
Establish reference performance
```

Các input phải được ghi lại đầy đủ.

Không thay đổi parameter sau test rồi vẫn gọi đó là cùng một baseline.

---

# 11. Backtest Data

Ưu tiên:

```text
Every tick based on real ticks
```

Khi sử dụng real ticks, phải lưu History Quality từ Strategy Tester Report.

Ví dụ:

```text
History Quality = 100% real ticks
```

Nếu dữ liệu có hạn chế, phải ghi rõ trong README.

---

# 12. Backtest Evidence

Mỗi baseline cần giữ Strategy Tester Report gốc.

Tối thiểu:

```text
report.html
```

Nếu MT5 tạo graph đi kèm, giữ cùng report.

Ví dụ:

```text
Backtest/
└── EA-XXX/
    ├── README.md
    ├── report.html
    ├── balance.png
    ├── hst.png
    ├── mfemae.png
    └── holding.png
```

Report gốc là evidence.

README chỉ là bản tóm tắt.

---

# 13. Performance Metrics

Các metric chính được theo dõi:

## Profitability

```text
Total Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
```

## Risk

```text
Balance Drawdown
Equity Drawdown
Relative Drawdown
Recovery Factor
```

## Risk-adjusted Performance

```text
Sharpe Ratio
```

## Trade Statistics

```text
Total Trades
Winning Trades
Losing Trades
Long Win Rate
Short Win Rate
Average Winner
Average Loser
Consecutive Wins
Consecutive Losses
```

---

# 14. Profit Factor

Profit Factor:

```text
Gross Profit
────────────
Gross Loss
```

Interpretation cơ bản:

```text
PF < 1
→ strategy mất tiền trong sample

PF = 1
→ gần break-even trước khi xem xét thêm chi phí

PF > 1
→ gross profit lớn hơn gross loss
```

Profit Factor không được sử dụng một mình để kết luận EA tốt.

Phải xem cùng:

```text
Drawdown
Number of trades
Expected Payoff
Sharpe
Equity / Balance curve
```

---

# 15. Drawdown

Drawdown là metric bắt buộc.

Một EA có Net Profit dương nhưng drawdown quá cao vẫn có thể không phù hợp để tiếp tục.

Luôn ghi:

```text
Balance Drawdown
Equity Drawdown
Relative Drawdown
```

Không đánh giá EA chỉ dựa trên final profit.

---

# 16. Sample Size

Số lượng trade phải được ghi lại trong mọi backtest.

Ví dụ:

```text
Total Trades = N
```

Kết quả từ sample quá nhỏ không đủ để kết luận strategy ổn định.

Không đặt một ngưỡng trade duy nhất cho mọi strategy vì frequency phụ thuộc:

```text
Timeframe
Strategy type
Holding period
Test duration
```

---

# 17. Balance / Equity Curve

Không chỉ đọc số liệu cuối cùng.

Phải kiểm tra hình dạng curve.

Một curve có thể cho thấy:

```text
Steady growth
Long stagnation
Large isolated winner
Progressive deterioration
Sudden drawdown
Regime dependency
```

Curve được sử dụng để tạo research question, không dùng riêng để chứng minh nguyên nhân.

---

# 18. Stage 4 — Diagnosis

Sau baseline, phân loại kết quả.

```text
PASS
FAIL
INCONCLUSIVE
```

### PASS

Baseline đủ tốt để tiếp tục nghiên cứu sâu hơn.

### FAIL

Có bằng chứng rõ ràng configuration hiện tại không đạt yêu cầu.

### INCONCLUSIVE

Dữ liệu hoặc implementation chưa đủ tin cậy để kết luận.

---

# 19. FAIL Không Đồng Nghĩa Strategy Vô Giá Trị

Một baseline FAIL chỉ chứng minh:

```text
Strategy implementation
+
Parameters
+
Symbol
+
Timeframe
+
Test period
=
FAIL
```

Không được tự suy rộng thành:

```text
Toàn bộ strategy concept = FAIL
```

Muốn kết luận rộng hơn phải có thêm test.

---

# 20. Stage 5 — Research Question

Sau baseline, mỗi vấn đề phải chuyển thành Research Question.

Format:

```text
RQ-ID:
Question:

Observation:
Evidence:

Hypothesis:

Change:

Expected result:

Result:
PASS / FAIL / INCONCLUSIVE
```

Ví dụ:

```text
RQ-01

Question:
Entry frequency có quá cao không?

Observation:
EA tạo số lượng trade rất lớn.

Hypothesis:
State-based entry gây repeated re-entry.

Change:
Chuyển sang crossover-only entry.

Result:
NOT TESTED
```

---

# 21. One Change at a Time

Trong giai đoạn diagnosis, ưu tiên thay đổi một yếu tố chính mỗi test.

Không làm:

```text
EMA 50 → 200
ADX 14 → 25
SL 300 → 800
TP 600 → 1500
thêm session filter
thêm crossover
```

trong cùng một test rồi kết luận nguyên nhân cải thiện.

Ưu tiên:

```text
Baseline
    ↓
Change A
    ↓
Test
    ↓
Compare
```

Sau đó mới sang Change B.

---

# 22. Timeframe Testing

Không mặc định một strategy hoạt động giống nhau trên mọi timeframe.

Timeframe test nên được thực hiện sau khi implementation đã được xác minh.

Ví dụ:

```text
M1
M5
M15
M30
H1
```

Ở bước này mục tiêu là tìm:

```text
Timeframe sensitivity
```

chứ chưa phải tìm bộ parameter tối ưu.

---

# 23. Stage 6 — Optimization Gate

Không optimization chỉ vì baseline FAIL.

Optimization được mở khi:

```text
Implementation verified
AND
Strategy logic testable
AND
Có lý do hợp lý để tiếp tục nghiên cứu
```

Nếu implementation còn nghi vấn:

```text
OPTIMIZATION = BLOCKED
```

---

# 24. Optimization

Khi optimization được phép, parameter range phải được ghi lại.

Ví dụ:

```text
EMA:
Start
Step
Stop

ADX:
Start
Step
Stop

SL:
Start
Step
Stop

TP:
Start
Step
Stop
```

Không chỉ lưu "best result".

Phải giữ đủ thông tin để tái tạo experiment.

---

# 25. Overfitting Control

Không chọn parameter chỉ vì tạo ra Net Profit cao nhất trên cùng dataset.

Một candidate tốt cần được xem xét trên nhiều yếu tố:

```text
Profit Factor
Drawdown
Expected Payoff
Sharpe
Trade count
Curve stability
Parameter stability
```

Ưu tiên vùng parameter có kết quả tương đối ổn định hơn một điểm parameter đơn lẻ có performance bất thường.

---

# 26. In-Sample và Out-of-Sample

Sau khi có candidate đáng nghiên cứu:

```text
Historical Data
│
├── In-Sample
│      ↓
│   Research / Optimization
│
└── Out-of-Sample
       ↓
    Validation
```

Không sử dụng Out-of-Sample để tiếp tục chỉnh parameter rồi vẫn gọi nó là validation độc lập.

Nếu dùng OOS để chỉnh strategy:

```text
OOS → trở thành research data
```

và cần validation mới.

---

# 27. Forward Test

EA vượt historical validation chưa được coi là hoàn tất.

Bước tiếp theo:

```text
Forward Test
```

Mục tiêu:

* kiểm tra execution thực tế;
* spread thực tế;
* slippage;
* broker behavior;
* signal timing;
* EA stability.

Ưu tiên demo hoặc môi trường kiểm thử trước live capital.

---

# 28. Reproducibility

Mọi kết quả quan trọng phải có khả năng tái tạo.

Cần biết:

```text
EA version
Symbol
Timeframe
Period
Inputs
Broker
MT5 environment
Data quality
Result
```

Nếu thiếu các thông tin quan trọng trên, kết quả phải được đánh dấu là chưa đủ evidence.

---

# 29. Naming Convention

EA:

```text
EA-<ID>_<StrategyName>
```

Ví dụ:

```text
EA-018_DI_Trend
```

Source:

```text
EA-018_DI_Trend.mq5
```

Backtest artifact nên chứa ít nhất:

```text
EA ID
Timeframe
Period
```

khi cần phân biệt nhiều experiment.

Ví dụ:

```text
EA-018_DI_Trend_M15_2025-01-01_2025-12-31.html
```

---

# 30. Research Status

Các trạng thái chuẩn:

```text
NOT STARTED
IN PROGRESS
BLOCKED
DONE
```

Kết quả experiment:

```text
PASS
FAIL
INCONCLUSIVE
```

Không sử dụng `DONE` thay cho `PASS`.

Ví dụ:

```text
Baseline execution : DONE
Baseline result    : FAIL
```

có nghĩa test đã hoàn thành nhưng strategy configuration không đạt.

---

# 31. Evidence Rule

Một kết luận nghiên cứu phải có:

```text
Hypothesis
+
Artifact
+
Result
+
Evidence
```

Không ghi:

```text
PASS
```

chỉ dựa trên cảm nhận hoặc quan sát không được lưu lại.

Evidence có thể bao gồm:

```text
Source code
Strategy Tester HTML
Graph
Input configuration
Comparison table
Forward-test record
```

---

# 32. Research Decision Rule

Quy trình quyết định:

```text
Is implementation verified?
        │
        ├── NO
        │    ↓
        │  Verify / Fix
        │
        └── YES
             ↓
       Run Baseline
             ↓
       Is baseline useful?
        │
        ├── NO
        │    ↓
        │  Diagnose
        │    ↓
        │  Test hypothesis
        │
        └── YES
             ↓
       Controlled Research
             ↓
         Optimization
             ↓
        Out-of-Sample
             ↓
         Forward Test
```

---

# 33. EA-018 Example

EA-018 hiện là ví dụ đầu tiên áp dụng methodology.

```text
EA:
EA-018_DI_Trend

Baseline:
XAUUSD.PRO
M1
2026-01-02 → 2026-06-08
100% real ticks
```

Baseline result:

```text
Net Profit     : -$993.61
Profit Factor  : 0.89
Max Drawdown   : 99.36%
Total Trades   : 4,096
Win Rate       : 31.20%
Sharpe Ratio   : -5.00

Result:
FAIL
```

Baseline này không được chuyển thẳng sang optimization.

Research hiện ưu tiên xác minh implementation trước.

---

# 34. Workflow Summary

```text
┌───────────────────────┐
│   STRATEGY DEFINITION │
└───────────┬───────────┘
            ↓
┌───────────────────────┐
│ IMPLEMENTATION REVIEW │
└───────────┬───────────┘
            ↓
┌───────────────────────┐
│   VERIFY CODE LOGIC   │
└───────────┬───────────┘
            ↓
┌───────────────────────┐
│   BASELINE BACKTEST   │
└───────────┬───────────┘
            ↓
┌───────────────────────┐
│       DIAGNOSIS       │
└───────────┬───────────┘
            ↓
┌───────────────────────┐
│  HYPOTHESIS TESTING   │
└───────────┬───────────┘
            ↓
┌───────────────────────┐
│     OPTIMIZATION      │
│   only after gate     │
└───────────┬───────────┘
            ↓
┌───────────────────────┐
│ OUT-OF-SAMPLE TESTING │
└───────────┬───────────┘
            ↓
┌───────────────────────┐
│     FORWARD TEST      │
└───────────────────────┘
```

---

# 35. Core Rule

```text
VERIFY FIRST
↓
TEST
↓
MEASURE
↓
UNDERSTAND
↓
THEN OPTIMIZE
```

Không tối ưu một EA khi chưa biết implementation có đúng strategy intent hay không.

Không thay nhiều biến cùng lúc khi đang tìm nguyên nhân.

Không kết luận strategy từ một backtest duy nhất.

Không công nhận kết quả nếu không có evidence đủ để tái tạo.
