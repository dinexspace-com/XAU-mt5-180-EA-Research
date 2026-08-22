# Research Methodology

Phương pháp nghiên cứu, backtest và đánh giá Expert Advisor trong repository:

**xauusd-mt5-ea-research**

Mục tiêu của repository không phải chỉ tìm một backtest có lợi nhuận cao.

Mục tiêu là xây dựng quy trình có thể:

1. Tái lập kết quả.
2. So sánh các phiên bản EA.
3. Xác định thay đổi nào thực sự cải thiện strategy.
4. Hạn chế overfitting.
5. Lưu đầy đủ evidence trước khi đưa ra kết luận.

---

# 1. Research Principle

Nguyên tắc chính:

> **Baseline first → change one factor → backtest → compare → validate → decide**

Không tối ưu nhiều biến cùng lúc ngay từ đầu.

Nếu nhiều thành phần được thay đổi đồng thời, không thể xác định thành phần nào tạo ra thay đổi kết quả.

---

# 2. Research Workflow

Mỗi EA đi qua các bước sau:

```text
Strategy Idea
    ↓
EA Implementation
    ↓
Compile / Code Check
    ↓
Baseline Backtest
    ↓
Baseline Assessment
    ↓
Controlled Experiments
    ↓
Candidate Selection
    ↓
Out-of-Sample Validation
    ↓
Forward Test
```

Không bỏ qua baseline.

Không chuyển thẳng từ một optimization tốt sang live trading.

---

# 3. Stage 0 — Code Validation

Trước khi backtest strategy, EA phải được kiểm tra ở mức implementation.

Tối thiểu:

* Compile thành công.
* Không có compile error.
* Indicator handles được tạo thành công.
* Entry logic đúng với strategy description.
* Stop Loss / Take Profit hoạt động đúng.
* Spread filter hoạt động đúng.
* Magic Number hoạt động đúng.
* Không mở position ngoài logic dự kiến.
* Position management hoạt động đúng nếu được bật.

Nếu phát hiện lỗi implementation:

> Sửa lỗi code trước khi dùng kết quả backtest để đánh giá strategy.

Một lỗi code và một strategy không profitable là hai vấn đề khác nhau.

---

# 4. Stage 1 — Baseline

Mỗi EA phải có một baseline trước khi optimization.

Baseline là phiên bản strategy gốc với một bộ parameter cố định.

Baseline phải được lưu lại ngay cả khi kết quả FAIL.

## Required Evidence

Mỗi baseline tối thiểu phải có:

```text
EAs/
└── EA-XXX/
    └── EA-XXX.mq5

Backtest/
└── EA-XXX/
    ├── README.md
    ├── report.html
    └── screenshots/
```

`report.html` xuất trực tiếp từ MetaTrader 5 là evidence chính của backtest.

---

# 5. Backtest Configuration

Mỗi backtest phải ghi lại tối thiểu:

## Environment

* EA name/version
* Symbol
* Timeframe
* Test start
* Test end
* Broker/data source
* Initial deposit
* Leverage
* Modeling / tick quality

## EA Parameters

* Lot size hoặc risk model
* Stop Loss
* Take Profit
* Indicator parameters
* Spread filter
* Entry filters
* Break Even
* Trailing Stop
* Các parameter khác ảnh hưởng kết quả

Không chấp nhận một backtest nếu không xác định được configuration đã dùng.

---

# 6. Data Quality

Ưu tiên:

**Real ticks / dữ liệu có chất lượng cao nhất có thể trong MT5 Strategy Tester.**

Data quality phải được ghi trong report.

Kết quả từ dữ liệu kém hơn có thể được dùng để thử nhanh hypothesis, nhưng không nên được dùng làm evidence cuối cùng cho strategy.

---

# 7. Metrics

Không đánh giá EA chỉ bằng Net Profit.

Tối thiểu phải xem:

| Metric                 | Purpose                              |
| ---------------------- | ------------------------------------ |
| Total Net Profit       | Tổng lợi nhuận                       |
| Profit Factor          | Quan hệ Gross Profit / Gross Loss    |
| Expected Payoff        | Expectancy trung bình mỗi trade      |
| Max Equity Drawdown    | Rủi ro giảm vốn                      |
| Sharpe Ratio           | Risk-adjusted performance            |
| Total Trades           | Kích thước sample                    |
| Win Rate               | Tỷ lệ thắng                          |
| Average Win            | Lợi nhuận trung bình lệnh thắng      |
| Average Loss           | Thua lỗ trung bình                   |
| Consecutive Losses     | Chuỗi thua                           |
| Balance / Equity Curve | Behavior của strategy theo thời gian |

Có thể bổ sung các metric khác khi research yêu cầu.

---

# 8. Baseline Assessment

Baseline được đánh giá theo hai nhóm.

## Technical PASS

Technical PASS khi:

* Code chạy đúng.
* Strategy Tester hoàn thành.
* Có report.
* Có đủ configuration.
* Có đủ evidence.

Technical PASS **không có nghĩa strategy profitable**.

---

## Strategy PASS

Một baseline chỉ có thể được xem là candidate khi tối thiểu:

```text
Net Profit > 0
Profit Factor > 1.00
Expected Payoff > 0
```

Ngoài ra phải xem:

* Drawdown.
* Sample size.
* Equity curve.
* Stability.
* Risk.

Không sử dụng một metric duy nhất để quyết định.

---

# 9. Controlled Experiments

Sau baseline, mỗi experiment cần có một câu hỏi rõ ràng.

Ví dụ:

```text
Does increasing the ADX threshold improve entry quality?
```

Một experiment phải xác định:

* Hypothesis.
* Variable thay đổi.
* Variables giữ nguyên.
* Test configuration.
* Metrics cần so sánh.
* PASS / FAIL criteria.

---

# 10. One Variable Group at a Time

Ví dụ baseline:

```text
EMA Fast = 20
EMA Slow = 50
ADX Period = 14
ADX Minimum = 25
SL = 300
TP = 600
```

Nếu nghiên cứu ADX threshold:

```text
ADX = 20
ADX = 25
ADX = 30
ADX = 35
```

thì phải giữ nguyên:

```text
EMA
SL
TP
Timeframe
Lot
Entry logic
Position management
```

Không đồng thời thay:

```text
ADX
EMA
SL
TP
Timeframe
```

trong cùng experiment đầu tiên.

Nếu làm như vậy, kết quả không cho biết yếu tố nào tạo ra improvement.

---

# 11. Experiment Naming

Experiment sử dụng format:

```text
EXP-001
EXP-002
EXP-003
...
```

Ví dụ:

```text
EXP-001 — ADX Threshold
EXP-002 — Timeframe
EXP-003 — Position Management
```

Research log được ghi tại:

```text
Research/README.md
```

---

# 12. Candidate Selection

Không chọn configuration chỉ vì:

> Net Profit cao nhất.

Candidate phải được đánh giá tổng hợp.

Ưu tiên configuration có:

* Profit Factor cải thiện.
* Expected Payoff dương.
* Drawdown kiểm soát được.
* Sample đủ lớn.
* Equity behavior hợp lý.
* Không phụ thuộc vào một số rất ít outlier trades.

Một kết quả mạnh nhưng sample quá nhỏ phải được xem xét thận trọng.

---

# 13. Avoiding Overfitting

Optimization có thể tạo ra parameter nhìn rất tốt trên dữ liệu đã dùng để tìm parameter.

Điều này chưa chứng minh strategy có khả năng hoạt động ngoài sample đó.

Vì vậy:

> **Optimization result ≠ validated strategy**

Không được xem một parameter set là final chỉ vì nó đứng đầu Strategy Tester optimization.

---

# 14. Out-of-Sample Validation

Sau khi tìm được candidate:

Không tiếp tục đánh giá candidate chỉ trên đúng dataset đã dùng để tìm nó.

Candidate cần được kiểm tra trên dữ liệu khác.

Ví dụ:

```text
Research / Development period
→ dùng để tìm candidate

Out-of-Sample period
→ dùng để kiểm tra candidate
```

Trong Out-of-Sample test:

* Không tiếp tục chỉnh parameter dựa trên kết quả OOS.
* Nếu chỉnh parameter, dataset đó không còn là OOS độc lập.

---

# 15. Forward Testing

Chỉ thực hiện sau khi candidate vượt qua backtest validation.

Forward test ưu tiên:

```text
Demo Account
↓
Controlled Forward Test
↓
Compare with Backtest Behavior
```

Theo dõi:

* Execution.
* Spread.
* Slippage.
* Trade frequency.
* Win rate.
* Drawdown.
* Strategy behavior.

Backtest PASS không tự động đồng nghĩa Forward Test PASS.

---

# 16. Live Trading

Repository này phục vụ:

**Research / Development / Backtesting**

Không chuyển một EA sang live trading chỉ dựa trên:

* Một backtest.
* Một optimization.
* Một parameter set.
* Một equity curve đẹp.

Live deployment là quyết định riêng sau validation và risk review.

---

# 17. Code Issues vs Strategy Issues

Luôn phân biệt:

## Code Issue

Ví dụ:

* Event không được gọi.
* Indicator đọc sai buffer.
* SL/TP đặt sai.
* Position management không chạy.
* Filter không hoạt động.

## Strategy Issue

Ví dụ:

* Profit Factor < 1.
* Expectancy âm.
* Drawdown cao.
* Entry quality kém.
* Strategy không ổn định.

Code issue phải được sửa và test lại trước khi kết luận strategy.

---

# 18. Reproducibility

Một người khác phải có khả năng tái lập test từ repository.

Vì vậy mỗi test cần cho biết:

```text
EA
Symbol
Timeframe
Date Range
Inputs
Data Quality
Initial Deposit
Leverage
Result
```

Nếu thiếu các thông tin này, test được xem là chưa đủ reproducible.

---

# 19. Evidence Rule

Không đánh dấu một experiment PASS nếu chỉ có ghi chú hoặc nhận xét.

PASS cần có:

```text
EA / code
+
Backtest artifact
+
Configuration
+
Metrics
+
Comparison with baseline
```

Evidence phải được giữ lại trong repository.

---

# 20. EA-017 Current Example

EA hiện tại:

```text
EA-017_ADX_EMA
```

Core strategy:

```text
EMA 20 / EMA 50 crossover
+
ADX 14
+
Minimum ADX 25
+
Directional Indicator confirmation
```

Baseline:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026.01.02 – 2026.06.08
Data: 100% Real Ticks

Lot: 0.01
SL: 300
TP: 600

Break Even: OFF
Trailing Stop: OFF
```

Baseline result:

```text
Net Profit:        -184.67
Profit Factor:        0.95
Expected Payoff:     -0.10
Max Equity DD:       28.26%
Total Trades:         1818
Win Rate:            32.51%
Sharpe Ratio:        -4.45
```

Result:

**FAIL — retained as research baseline**

Baseline không bị xóa hoặc thay thế.

Nó là reference để so sánh các experiment tiếp theo.

---

# 21. Repository Roles

```text
EAs/
```

Chứa source code và documentation của từng EA.

```text
Backtest/
```

Chứa evidence của Strategy Tester.

```text
Research/
```

Chứa hypotheses, experiments và research decisions.

```text
docs/
```

Chứa phương pháp và quy chuẩn chung của repository.

---

# 22. Decision Flow

```text
Does EA compile and run correctly?
│
├── NO → Fix implementation
│
└── YES
     ↓
Is baseline evidence complete?
│
├── NO → Complete baseline
│
└── YES
     ↓
Does baseline pass?
│
├── YES → Validate
│
└── NO
     ↓
Form a research hypothesis
     ↓
Run controlled experiment
     ↓
Compare with baseline
     ↓
Candidate found?
│
├── NO → Next hypothesis
│
└── YES
     ↓
Out-of-Sample Validation
     ↓
Forward Test
```

---

# 23. Core Rule

Quy tắc quan trọng nhất của repository:

> **Không tối ưu để tìm một backtest đẹp. Nghiên cứu để tìm bằng chứng rằng một strategy có edge ổn định.**

Mỗi thay đổi phải có:

**Hypothesis → Test → Evidence → Decision.**
