# XAUUSD MT5 EA Research — Methodology

Tài liệu này định nghĩa phương pháp nghiên cứu, phát triển và đánh giá Expert Advisor (EA) trong repository **XAUUSD MT5 EA Research**.

Mục tiêu của repository không phải tìm một backtest đẹp nhất, mà xây dựng một quy trình nghiên cứu có thể:

* Lặp lại.
* Kiểm chứng.
* So sánh giữa các EA.
* Lưu cả kết quả thành công và thất bại.
* Hạn chế overfitting.
* Phân biệt rõ strategy idea, implementation và empirical result.

---

# 1. Research Philosophy

Mỗi EA trong repository được xem như một **research experiment**.

Quy trình cơ bản:

```text
Strategy Idea
    ↓
Define Hypothesis
    ↓
Implement EA
    ↓
Code Review
    ↓
Baseline Backtest
    ↓
Analyze Results
    ↓
PASS / FAIL
    ↓
Form Next Hypothesis
    ↓
Modify
    ↓
Retest
```

Nguyên tắc chính:

> Một strategy idea, một implementation và một backtest result là ba thứ khác nhau.

Một implementation thất bại không tự động chứng minh strategy concept thất bại.

Ngược lại, một backtest tốt cũng không tự động chứng minh strategy có khả năng hoạt động trong tương lai.

---

# 2. Repository Structure

Mỗi loại artifact có vị trí riêng:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-XXX_Strategy_Name/
│       ├── EA-XXX_Strategy_Name.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-XXX_Strategy_Name/
│       ├── README.md
│       └── test artifacts
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

### `EAs/`

Lưu source code và tài liệu mô tả implementation.

### `Backtest/`

Lưu bằng chứng thực nghiệm:

* Strategy Tester Report.
* Balance chart.
* Trade statistics.
* MFE/MAE chart.
* Holding-time chart.
* Các artifact liên quan đến từng test.

### `Research/`

Lưu:

* Research questions.
* Hypotheses.
* Findings.
* Experiment history.
* Hướng nghiên cứu tiếp theo.

### `docs/`

Lưu methodology và các quy chuẩn chung của repository.

---

# 3. EA Naming Convention

EA sử dụng format:

```text
EA-XXX_Strategy_Name
```

Ví dụ:

```text
EA-024_Donchian_Trend
```

Trong đó:

```text
EA-024
```

là ID cố định của experiment/strategy.

Tên EA không nên thay đổi chỉ vì một parameter hoặc implementation được điều chỉnh.

Các thay đổi cần được quản lý bằng version hoặc experiment record thay vì tạo tên EA tùy tiện.

---

# 4. Stage 1 — Strategy Definition

Trước khi đánh giá một EA cần xác định strategy đang cố kiểm chứng điều gì.

Tối thiểu phải xác định:

```text
Market
Timeframe
Entry Logic
Exit Logic
Stop Loss
Take Profit
Position Management
Filters
Risk Model
```

Đồng thời phải có một research question.

Ví dụ:

> Một Donchian breakout system có tạo được positive expectancy trên XAUUSD hay không?

Không bắt đầu bằng câu hỏi:

> Parameter nào tạo lợi nhuận cao nhất?

Câu hỏi thứ hai dễ dẫn trực tiếp đến optimization mà chưa xác nhận strategy có logic hợp lý hay không.

---

# 5. Stage 2 — Define Hypothesis

Mỗi experiment cần một hypothesis rõ ràng.

Ví dụ:

```text
Hypothesis:

Sử dụng Highest High / Lowest Low của 20 bars
cho Donchian breakout sẽ tạo behavior khác
so với implementation baseline.
```

Một hypothesis tốt phải có khả năng:

```text
Test
→ Measure
→ Compare
→ Accept / Reject / Inconclusive
```

Không thay đổi EA chỉ với mục tiêu:

```text
"làm backtest đẹp hơn"
```

mà không biết đang kiểm chứng điều gì.

---

# 6. Stage 3 — Implementation

Source code được lưu tại:

```text
EAs/EA-XXX_Strategy_Name/
```

README của EA phải mô tả **implementation thực tế trong code**, không chỉ mô tả strategy theo lý thuyết.

Nếu code và strategy concept khác nhau, phải ghi rõ sự khác biệt.

Ví dụ:

```text
Strategy Concept:
Highest High of N bars

Implementation:
High at shift N
```

Không được mô tả implementation như thể nó đã thực hiện đúng concept khi source code không hỗ trợ kết luận đó.

---

# 7. Stage 4 — Code Review

Trước khi sử dụng backtest để đánh giá strategy concept, cần kiểm tra implementation.

Các nhóm cần review:

```text
Entry logic
Exit logic
Indicator calculation
Bar indexing
New-bar detection
Position counting
Magic Number
Stop Loss
Take Profit
Break Even
Trailing Stop
Spread filter
Order execution
```

Mục tiêu của code review không phải tối ưu performance.

Mục tiêu là xác nhận:

> EA có thực hiện đúng experiment mà chúng ta nghĩ mình đang test hay không?

---

# 8. Stage 5 — Baseline Backtest

Mỗi EA cần ít nhất một baseline.

Baseline là điểm tham chiếu để so sánh các experiment sau.

Phải lưu:

```text
EA version
Symbol
Timeframe
Test period
Initial deposit
Leverage
Data quality
Inputs
Results
```

Không sửa hoặc xóa baseline chỉ vì kết quả xấu.

FAIL là một kết quả nghiên cứu hợp lệ.

---

# 9. Backtest Evidence

Một backtest chỉ được xem là có evidence khi lưu được artifact thực tế.

Tối thiểu nên có:

```text
Strategy Tester Report
Balance / Equity graph
Parameters
Performance statistics
Trade statistics
```

Nếu MT5 xuất thêm:

```text
MFE / MAE
Holding Time
Hourly Distribution
Weekday Distribution
```

cũng nên giữ lại.

Không chỉ ghi thủ công một vài metric rồi xóa report gốc.

---

# 10. Core Metrics

Các EA phải được đánh giá ít nhất theo các nhóm metric sau.

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
Maximum Balance Drawdown
Maximum Equity Drawdown
Relative Drawdown
```

## Trade Behavior

```text
Total Trades
Win Rate
Loss Rate
Average Profit Trade
Average Loss Trade
Largest Win
Largest Loss
Consecutive Wins
Consecutive Losses
```

## Risk-adjusted Performance

Khi report cung cấp:

```text
Sharpe Ratio
Recovery Factor
```

## Trade Dynamics

Khi dữ liệu có sẵn:

```text
Holding Time
MFE
MAE
Profit/MFE Correlation
Profit/MAE Correlation
```

Không đánh giá EA chỉ bằng `Net Profit`.

---

# 11. PASS / FAIL

Không có một metric duy nhất quyết định toàn bộ strategy.

Tuy nhiên baseline phải được đánh dấu rõ:

```text
PASS
FAIL
INCONCLUSIVE
```

### FAIL

Một EA có thể được đánh dấu FAIL khi evidence cho thấy các vấn đề nghiêm trọng như:

```text
Negative Net Profit
Profit Factor < 1
Negative Expected Payoff
Unacceptable Drawdown
Implementation Error
Invalid Test
```

### INCONCLUSIVE

Dùng khi chưa đủ evidence để kết luận, ví dụ:

```text
Test period quá ngắn
Trade sample quá nhỏ
Implementation chưa được xác minh
Data quality không phù hợp
```

### PASS

PASS không đồng nghĩa với:

```text
Ready for Live Trading
```

PASS chỉ có nghĩa EA đã đạt tiêu chí của **stage/experiment hiện tại**.

---

# 12. Implementation Failure vs Strategy Failure

Đây là distinction bắt buộc trong repository.

Nếu phát hiện implementation error:

```text
Baseline FAIL
```

không được diễn giải thành:

```text
Strategy concept FAIL
```

Ví dụ với EA-024:

```text
Donchian concept
        ↓
Implementation
        ↓
Implementation issue discovered
        ↓
Baseline backtest FAIL
```

Kết luận hợp lệ:

```text
Current implementation failed.
```

Không phải:

```text
Donchian breakout does not work.
```

---

# 13. Experiment Design

Sau baseline, mỗi experiment nên thay đổi càng ít yếu tố càng tốt.

Ưu tiên:

```text
Baseline
   ↓
Change A
   ↓
Retest
   ↓
Compare
```

thay vì:

```text
Baseline
   ↓
Change A+B+C+D+E
   ↓
Better result
   ↓
Unknown cause
```

Nếu nhiều yếu tố được thay đổi cùng lúc thì phải có lý do rõ ràng.

---

# 14. Same-Condition Retest

Khi sửa một implementation bug, vòng test tiếp theo nên giữ nguyên tối đa:

```text
Symbol
Timeframe
Period
Deposit
Lot
SL
TP
Filters
Data
```

Chỉ thay đổi phần implementation cần kiểm chứng.

Mục đích:

```text
Before
vs
After
```

có thể so sánh trực tiếp.

---

# 15. Parameter Optimization

Không bắt đầu optimization trước khi:

```text
Core implementation verified
        +
Baseline established
```

Optimization chỉ được thực hiện khi có câu hỏi nghiên cứu rõ ràng.

Ví dụ:

```text
Donchian Period:
10
20
40
55
```

tốt hơn việc chạy một search space rất lớn chỉ để tìm combination có lợi nhuận cao nhất.

---

# 16. Overfitting Control

Một kết quả tốt trên development period chưa đủ để kết luận strategy có edge.

Quy trình nghiên cứu nên tiến tới:

```text
Development
    ↓
Candidate
    ↓
Out-of-Sample
    ↓
Robustness
    ↓
Forward / Demo
```

Không liên tục điều chỉnh EA dựa trên cùng một dataset rồi dùng chính dataset đó làm bằng chứng cuối cùng.

---

# 17. Out-of-Sample Validation

Sau khi có candidate strategy:

```text
Development Period
```

và:

```text
Validation Period
```

phải được tách biệt.

Không sử dụng validation period để liên tục tune parameter.

Nếu parameter được sửa dựa trên validation result, dữ liệu đó không còn hoàn toàn out-of-sample.

---

# 18. Robustness

Một candidate EA cần được kiểm tra xem performance có phụ thuộc quá mạnh vào một cấu hình duy nhất hay không.

Có thể kiểm tra:

```text
Nearby Parameters
Different Periods
Different Market Regimes
Spread Conditions
Execution Conditions
```

Mục tiêu không phải yêu cầu EA profitable trong mọi hoàn cảnh.

Mục tiêu là phát hiện:

> Kết quả có biến mất ngay khi điều kiện thay đổi nhẹ hay không?

---

# 19. Transaction Costs

Đối với EA có trade frequency cao, transaction cost đặc biệt quan trọng.

Cần chú ý:

```text
Spread
Commission
Slippage
Execution
```

Một strategy có edge nhỏ trước chi phí có thể trở thành negative expectancy sau chi phí.

Do đó không đánh giá high-frequency EA chỉ dựa trên raw signal behavior.

---

# 20. Risk Management

Risk management không được dùng để che giấu strategy expectancy yếu.

Thứ tự nghiên cứu ưu tiên:

```text
Entry / Exit Logic
        ↓
Strategy Behavior
        ↓
Risk Management
        ↓
Position Sizing
```

Không tăng lot hoặc leverage để biến một strategy yếu thành backtest có Net Profit lớn hơn.

---

# 21. Experiment Record

Mỗi experiment nên ghi tối thiểu:

```text
Experiment ID:
EA:
Date:

Research Question:
Hypothesis:

Code Version:

Change:

Constants:

Symbol:
Timeframe:
Period:

Parameters:

Result:

Net Profit:
Profit Factor:
Expected Payoff:
Max Drawdown:
Trades:
Win Rate:

Verdict:

Finding:

Next Question:
```

Điều này giúp experiment có thể được đọc lại mà không phụ thuộc vào trí nhớ của người thực hiện.

---

# 22. Negative Results

Không xóa experiment thất bại.

Negative result giúp xác định:

```text
What was tested
What failed
Under which conditions
What should not be repeated
```

Một repository research tốt không chỉ chứa EA profitable.

Nó phải thể hiện được quá trình loại bỏ các giả thuyết yếu.

---

# 23. Research Progression

Quy trình chuẩn:

```text
IDEA
 ↓
IMPLEMENT
 ↓
VERIFY CODE
 ↓
BASELINE
 ↓
ANALYZE
 ↓
HYPOTHESIS
 ↓
EXPERIMENT
 ↓
COMPARE
 ↓
VALIDATE
 ↓
ROBUSTNESS
 ↓
FORWARD / DEMO
```

Chỉ sau các bước này mới xem xét:

```text
LIVE
```

---

# 24. Live Trading

Backtest PASS không phải authorization cho live trading.

Trước live cần có validation riêng về:

```text
Execution
Broker conditions
Spread
Commission
Slippage
Position sizing
Operational risk
Forward performance
```

Live deployment nằm ngoài phạm vi của một baseline backtest.

---

# 25. Current Example — EA-024

EA-024 hiện đóng vai trò ví dụ đầu tiên cho methodology này.

Baseline test ghi nhận:

```text
EA: EA-024_Donchian_Trend
Symbol: XAUUSD.PRO
Timeframe: M1

Trades: 9,320

Net Profit: -$992.04
Profit Factor: 0.95
Expected Payoff: -0.11
Maximum Drawdown: 99.26%
```

Verdict:

```text
BASELINE: FAIL
```

Code review đồng thời phát hiện implementation cần được kiểm tra/sửa trước khi đánh giá Donchian concept.

Do đó bước tiếp theo không phải parameter optimization.

Bước tiếp theo là:

```text
Fix implementation
      ↓
Retest same conditions
      ↓
Compare with baseline
```

---

# 26. Core Rule

Nguyên tắc quan trọng nhất của repository:

> **Không cố chứng minh EA hoạt động. Hãy cố tìm bằng chứng xem nó thực sự có hoạt động hay không.**

Một experiment FAIL nhưng giúp loại bỏ một giả thuyết sai vẫn là một experiment có giá trị.
