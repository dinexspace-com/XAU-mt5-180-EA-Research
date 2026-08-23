# XAUUSD MT5 EA Research Methodology

## 1. Purpose

Tài liệu này định nghĩa phương pháp chuẩn để nghiên cứu, backtest và đánh giá các Expert Advisor trong repository:

```text
xauusd-mt5-ea-research/
```

Mục tiêu chính:

> Đánh giá strategy bằng dữ liệu và evidence có thể kiểm tra lại, thay vì lựa chọn EA dựa trên một backtest đẹp hoặc một bộ parameter được tối ưu.

Mọi EA trong repository nên đi qua cùng một quy trình:

```text
Strategy
   ↓
Implementation
   ↓
Baseline Backtest
   ↓
Research
   ↓
Controlled Experiments
   ↓
Validation
   ↓
PASS / FAIL
```

---

# 2. Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-<>/
│       ├── EA-<>.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-<>/
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

Vai trò của từng khu vực:

### `EAs/`

Lưu:

* Source code `.mq5`
* Strategy specification
* Entry/exit logic
* Input parameters
* Known implementation behavior

### `Backtest/`

Lưu evidence từ MetaTrader 5 Strategy Tester:

* HTML report
* Balance graph
* Statistical graphs
* Các artifact liên quan đến từng test

### `Research/`

Lưu:

* Research questions
* Hypotheses
* Experiment status
* So sánh các variant
* Research conclusions

### `docs/`

Lưu methodology chung được áp dụng cho toàn repository.

---

# 3. Core Principle

Nguyên tắc quan trọng nhất:

```text
Evidence > Assumption
```

Không đánh giá strategy dựa trên:

* Cảm giác.
* Indicator trông hợp lý.
* Một vài trade đẹp.
* Win Rate riêng lẻ.
* Net Profit riêng lẻ.
* Một optimization result đẹp.
* Một equity curve được chọn sau khi thử nhiều parameter.

Mọi kết luận quan trọng phải có:

```text
Hypothesis
+
Test
+
Artifact
+
Metrics
+
Conclusion
```

---

# 4. Research Lifecycle

Mỗi EA đi qua các stage sau.

```text
Stage 1
Strategy Definition

↓

Stage 2
Implementation

↓

Stage 3
Baseline Backtest

↓

Stage 4
Research

↓

Stage 5
Controlled Experiments

↓

Stage 6
Validation

↓

Stage 7
Final Assessment
```

Không bỏ qua baseline để đi thẳng vào optimization.

---

# 5. Stage 1 — Strategy Definition

Trước khi đánh giá EA, phải xác định strategy thực sự đang làm gì.

Tối thiểu cần biết:

```text
Entry Logic
Exit Logic
Indicators
Indicator Parameters
Stop Loss
Take Profit
Position Sizing
Trade Management
Filters
Timeframe
Symbol
```

Nếu code và strategy description khác nhau:

```text
CODE BEHAVIOR
```

phải được ghi nhận riêng.

Không giả định code đang thực hiện đúng strategy chỉ dựa vào tên EA.

---

# 6. Stage 2 — Implementation Review

Trước backtest, kiểm tra implementation ở mức tối thiểu.

Các điểm cần xác nhận:

```text
Does EA compile?
Does EA initialize indicators?
Does EA read closed/current candle correctly?
Does EA open BUY correctly?
Does EA open SELL correctly?
Does EA apply SL/TP?
Does EA manage existing positions?
Does EA respect spread filters?
Does EA identify its own trades correctly?
```

Mục tiêu ở stage này không phải chứng minh profitability.

Mục tiêu là:

```text
Verify that the test is actually testing
the intended implementation.
```

---

# 7. Stage 3 — Baseline Backtest

Mỗi EA phải có một baseline trước khi optimization hoặc thay đổi strategy.

Baseline là:

> Phiên bản EA và parameter set được chọn làm control cho các experiment tiếp theo.

Baseline phải được lưu lại và không ghi đè.

---

# 8. Backtest Environment

Mỗi backtest phải ghi lại tối thiểu:

```text
EA Version
Symbol
Broker / Data Source
Timeframe
Start Date
End Date
History Quality
Initial Deposit
Currency
Leverage
Lot / Risk Model
Input Parameters
```

Nếu một trong các yếu tố quan trọng thay đổi, kết quả phải được xem là một test khác.

---

# 9. Historical Data Quality

Ưu tiên sử dụng:

```text
Every tick based on real ticks
```

khi MetaTrader 5 và broker/data source hỗ trợ.

Report phải ghi lại:

```text
History Quality
Bars
Ticks
Test Period
```

Không so sánh trực tiếp hai experiment nếu chất lượng hoặc nguồn dữ liệu khác nhau mà không ghi rõ khác biệt.

---

# 10. Backtest Artifacts

Không chỉ lưu screenshot.

Ưu tiên giữ report gốc từ Strategy Tester.

Ví dụ:

```text
Backtest/
└── EA-019_MACD_Zero_Trend/
    ├── ReportTester-953688.html
    ├── ReportTester-953688.png
    ├── ReportTester-953688-hst.png
    ├── ReportTester-953688-mfemae.png
    ├── ReportTester-953688-holding.png
    └── README.md
```

HTML report là evidence chính vì chứa:

* Test configuration
* Inputs
* Performance statistics
* Orders
* Deals
* Trading history

Graphs là evidence bổ sung.

---

# 11. Minimum Performance Metrics

Mỗi test phải ghi tối thiểu:

```text
Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Maximum Drawdown
Relative Drawdown
Total Trades
Win Rate
Average Profit Trade
Average Loss Trade
```

Nên ghi thêm khi có:

```text
Sharpe Ratio
Recovery Factor
Long Win Rate
Short Win Rate
Maximum Consecutive Wins
Maximum Consecutive Losses
Average Holding Time
MFE
MAE
```

---

# 12. Net Profit

Net Profit trả lời:

> Strategy kiếm hoặc mất bao nhiêu tiền trong sample?

Nhưng:

```text
High Net Profit ≠ Good Strategy
```

Net Profit phải được đọc cùng:

```text
Drawdown
Profit Factor
Expected Payoff
Trade Count
Risk
```

---

# 13. Profit Factor

```text
Profit Factor =
Gross Profit / |Gross Loss|
```

Diễn giải cơ bản:

```text
PF > 1
Gross Profit > Gross Loss

PF = 1
Approximately break-even before other considerations

PF < 1
Gross Profit < Gross Loss
```

Profit Factor không được sử dụng một mình để PASS strategy.

---

# 14. Expected Payoff

Expected Payoff cho biết kết quả trung bình trên mỗi trade trong backtest.

```text
Expected Payoff > 0
```

là điều kiện mong muốn.

Nếu:

```text
Expected Payoff < 0
```

strategy có expectancy âm trong sample được test.

---

# 15. Drawdown

Drawdown là một trong các metric quan trọng nhất.

Phải xem ít nhất:

```text
Balance Drawdown
Equity Drawdown
Relative Drawdown
```

Một strategy tạo profit nhưng phải chịu drawdown quá lớn không được tự động xem là tốt.

Ví dụ:

```text
High Profit
+
Extreme Drawdown
```

không đồng nghĩa:

```text
PASS
```

---

# 16. Win Rate

Win Rate:

```text
Winning Trades / Total Trades
```

Không sử dụng Win Rate một mình.

Strategy có thể:

```text
Low Win Rate
+
Large Average Win
+
Small Average Loss
```

và vẫn có expectancy dương.

Ngược lại:

```text
High Win Rate
+
Small Average Win
+
Large Average Loss
```

vẫn có thể thua.

---

# 17. Average Win / Average Loss

Luôn đọc:

```text
Average Profit Trade
```

cùng:

```text
Average Loss Trade
```

và Win Rate.

Ba metric này giúp giải thích cấu trúc payoff của strategy.

---

# 18. Trade Count

Sample quá nhỏ có thể tạo kết quả thiếu ổn định.

Vì vậy phải luôn ghi:

```text
Total Trades
```

Trade count cao cũng không tự chứng minh strategy tốt.

Nó chỉ cung cấp thêm observations trong sample.

---

# 19. Balance / Equity Curve

Balance và equity curve được dùng để quan sát:

* Xu hướng dài hạn.
* Drawdown periods.
* Recovery periods.
* Sudden jumps.
* Concentration of profit.
* Deterioration theo thời gian.

Không đánh giá curve chỉ bằng việc:

```text
Final Balance > Initial Balance
```

---

# 20. Baseline Verdict

Sau baseline test, trạng thái tối thiểu là:

```text
PASS
FAIL
INCONCLUSIVE
```

### PASS

Chỉ sử dụng khi test đạt acceptance criteria đã xác định cho stage hiện tại.

PASS baseline không có nghĩa:

```text
Ready for live trading
```

Nó chỉ có nghĩa:

```text
Passed current research gate
```

### FAIL

Dùng khi evidence cho thấy strategy không đạt acceptance criteria.

FAIL phải được giữ lại làm research evidence.

### INCONCLUSIVE

Dùng khi:

* Test configuration không hợp lệ.
* Data không đủ.
* EA có implementation issue.
* Evidence không đủ để kết luận.

---

# 21. Stage 4 — Research

Nếu baseline FAIL hoặc có behavior cần nghiên cứu:

```text
Do not randomly optimize.
```

Chuyển sang:

```text
Research Question
```

Ví dụ:

```text
Does EMA50 improve expectancy?
```

hoặc:

```text
Does strict MACD crossover outperform
continuous MACD state entry?
```

---

# 22. Hypothesis

Mỗi experiment cần một hypothesis rõ ràng.

Format:

```text
Research ID:

Question:

Hypothesis:

Baseline:

Variant:

Changed Variable:

Fixed Variables:
```

Hypothesis phải có khả năng kiểm chứng bằng backtest.

---

# 23. Controlled Experiment

Nguyên tắc:

```text
Change one major variable at a time.
```

Ví dụ đúng:

```text
TEST A
MACD + Zero Line + EMA50

vs

TEST B
MACD + Zero Line
```

Changed variable:

```text
EMA50 filter
```

Các yếu tố khác giữ nguyên.

---

# 24. Avoid Multi-Variable Changes

Không nên thực hiện:

```text
Baseline
↓
Change MACD
Change EMA
Change SL
Change TP
Disable BE
Change timeframe
↓
Backtest
```

Nếu kết quả tốt hơn, không thể xác định yếu tố nào tạo ra improvement.

Đây là confounded experiment.

---

# 25. Control Variables

Khi test một hypothesis, cố gắng giữ nguyên:

```text
Symbol
Data Source
Historical Period
Timeframe
Initial Deposit
Leverage
Lot Size
Spread Conditions
Unrelated Strategy Parameters
```

Chỉ thay variable đang được nghiên cứu.

---

# 26. Experiment Naming

Mỗi experiment nên có ID.

Ví dụ:

```text
BASE-019-001
R01-019
R02-019
R03-019
```

Trong đó:

```text
BASE
= Baseline

R
= Research Experiment

019
= EA number
```

Tên có thể được mở rộng khi repository phát triển, nhưng phải đảm bảo mỗi experiment có thể truy ngược về artifact tương ứng.

---

# 27. Experiment Comparison

Mỗi comparison phải có tối thiểu:

| Metric          | Baseline | Variant |
| --------------- | -------: | ------: |
| Net Profit      |          |         |
| Profit Factor   |          |         |
| Expected Payoff |          |         |
| Max Drawdown    |          |         |
| Total Trades    |          |         |
| Win Rate        |          |         |
| Average Win     |          |         |
| Average Loss    |          |         |

Không kết luận dựa trên một metric duy nhất.

---

# 28. Research Result

Mỗi experiment kết thúc bằng:

```text
PASS
FAIL
INCONCLUSIVE
```

và phải có:

```text
Evidence
Conclusion
Next Action
```

Không ghi:

```text
Looks better
```

mà không có số liệu.

---

# 29. Optimization

Optimization không phải bước đầu tiên.

Chỉ optimization sau khi:

```text
Baseline exists
+
Strategy behavior understood
+
Research hypothesis tested
```

Mục tiêu optimization:

> Nghiên cứu độ nhạy và vùng parameter hợp lý.

Không phải:

> Tìm duy nhất bộ parameter có Net Profit cao nhất.

---

# 30. Parameter Robustness

Một parameter tốt không nên chỉ hoạt động tại một giá trị cực kỳ cụ thể.

Ví dụ:

```text
SL 290 → FAIL
SL 300 → Excellent
SL 310 → FAIL
```

có thể là dấu hiệu của parameter instability.

Ưu tiên tìm:

```text
Stable Parameter Region
```

thay vì:

```text
Single Best Parameter
```

---

# 31. Overfitting Risk

Overfitting xảy ra khi strategy được điều chỉnh quá sát historical sample.

Các dấu hiệu cần cảnh giác:

* Quá nhiều parameters.
* Quá nhiều optimization iterations.
* Chọn result tốt nhất trong hàng nghìn combinations.
* Performance chỉ tốt trong một giai đoạn.
* Performance sụp đổ khi thay đổi nhẹ parameters.
* Out-of-sample performance kém.

Do đó:

```text
Optimization Result
≠
Validation Result
```

---

# 32. In-Sample vs Out-of-Sample

Sau khi strategy có candidate configuration, historical data nên được phân biệt:

```text
In-Sample
```

và:

```text
Out-of-Sample
```

### In-Sample

Dùng để:

* Research.
* Develop.
* Compare.
* Tune.

### Out-of-Sample

Dùng để kiểm tra strategy trên dữ liệu không được sử dụng trực tiếp để lựa chọn configuration.

Không tiếp tục tune trên out-of-sample rồi vẫn gọi nó là untouched out-of-sample.

---

# 33. Forward Validation

Một strategy vượt qua historical validation vẫn chưa tự động sẵn sàng cho real capital.

Bước tiếp theo có thể là:

```text
Demo / Forward Test
```

Mục tiêu:

* Kiểm tra execution thực tế.
* Spread thực tế.
* Slippage.
* Broker behavior.
* EA stability.
* Difference giữa tester và runtime.

---

# 34. Live Trading Gate

Không chuyển trực tiếp:

```text
Good Backtest
→
Real Money
```

Quy trình mong muốn:

```text
Research
↓
Backtest
↓
Controlled Experiments
↓
Out-of-Sample
↓
Forward Test
↓
Review
↓
Live Decision
```

Quyết định sử dụng vốn thật phải là quyết định riêng sau validation.

---

# 35. Reproducibility

Một người khác phải có khả năng xác định:

```text
Which EA?
Which version?
Which parameters?
Which symbol?
Which timeframe?
Which period?
Which data?
Which report?
What result?
```

Nếu không thể trả lời các câu hỏi này, test chưa được document đầy đủ.

---

# 36. Artifact Rule

Một research result chỉ được xem là hoàn chỉnh khi có:

```text
EA / Variant
+
Test Configuration
+
Strategy Tester Report
+
Metrics
+
Conclusion
```

Screenshot đơn lẻ không đủ thay thế Strategy Tester report nếu report gốc còn có thể lưu.

---

# 37. Preserve Negative Results

Không xóa:

```text
Failed EA
Failed Parameter Set
Failed Hypothesis
Failed Backtest
```

Negative result giúp tránh lặp lại experiment cũ và tạo lịch sử nghiên cứu minh bạch.

---

# 38. Current Application — EA-019

Methodology này hiện đang được áp dụng cho:

```text
EA-019_MACD_Zero_Trend
```

Baseline:

```text
Symbol    = XAUUSD.PRO
Timeframe = M1

Period:
2026-01-02 → 2026-04-01

History Quality = 100% real ticks
```

Baseline result:

```text
Net Profit          = -$992.55
Profit Factor       = 0.91
Expected Payoff     = -$0.17
Sharpe Ratio        = -5.00
Max Equity Drawdown = 99.27%
Total Trades        = 5,695
Win Rate            = 39.82%
```

Verdict:

```text
FAIL
```

EA-019 hiện được chuyển sang Research để cô lập nguyên nhân và kiểm chứng từng hypothesis.

---

# 39. EA-019 Current Research Sequence

Research sequence hiện tại:

```text
BASE-019-001
Original Baseline
        ↓
       FAIL
        ↓
R01
MACD State vs Crossover
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
Timeframe Comparison
```

Thứ tự có thể thay đổi nếu experiment trước tạo ra evidence làm thay đổi research question.

---

# 40. Standard Research Record

Template chuẩn:

```text
Research ID:

EA:
EA Version:

Research Question:

Hypothesis:

BASELINE
---------

Configuration:

VARIANT
-------

Configuration:

CHANGED VARIABLE
----------------

FIXED VARIABLES
---------------

TEST ENVIRONMENT
----------------

Symbol:
Broker / Data:
Timeframe:
Period:
History Quality:
Initial Deposit:
Leverage:

RESULTS
-------

Metric              Baseline     Variant

Net Profit
Profit Factor
Expected Payoff
Max Drawdown
Total Trades
Win Rate
Average Win
Average Loss

EVIDENCE
--------

Strategy Tester Report:

Additional Artifacts:

CONCLUSION
----------

PASS / FAIL / INCONCLUSIVE:

Finding:

NEXT ACTION
-----------
```

---

# 41. Final Rule

Toàn bộ repository tuân theo nguyên tắc:

```text
DEFINE
↓
IMPLEMENT
↓
TEST
↓
MEASURE
↓
COMPARE
↓
VALIDATE
↓
THEN DECIDE
```

Không đảo thành:

```text
OPTIMIZE
↓
FIND A GOOD CURVE
↓
DECLARE SUCCESS
```

Mục tiêu của repository không phải tìm backtest đẹp nhất.

Mục tiêu là xây dựng một quá trình nghiên cứu EA:

```text
Reproducible
Evidence-based
Comparable
Auditable
```
