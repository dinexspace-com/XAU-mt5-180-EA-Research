# XAUUSD MT5 EA Research Methodology

## 1. Purpose

Repository này được xây dựng để nghiên cứu, phát triển và đánh giá các **Expert Advisor (EA) cho XAUUSD trên MetaTrader 5** theo một quy trình có thể kiểm chứng và tái lập.

Mục tiêu chính không phải tìm một backtest có lợi nhuận cao nhất, mà là xác định:

* Strategy có thực sự tạo ra trading edge hay không.
* Edge đến từ thành phần nào.
* Mức độ rủi ro của strategy.
* Kết quả có đủ ổn định để tiếp tục nghiên cứu hay không.
* Strategy có vượt qua được các bước kiểm chứng tiếp theo hay không.

Mọi kết quả, bao gồm cả kết quả thất bại, đều được giữ lại như một phần của research history.

---

# 2. Repository Structure

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

Mỗi khu vực có một nhiệm vụ riêng.

### `EAs/`

Lưu source code và documentation của từng EA.

README của EA phải mô tả:

* Strategy logic.
* Entry conditions.
* Exit conditions.
* Filters.
* Risk/position management.
* Inputs.
* Known issues.

---

### `Backtest/`

Lưu bằng chứng backtest của từng EA.

Có thể bao gồm:

```text
Strategy Tester HTML report
Balance / Equity chart
Trade distribution charts
MFE / MAE chart
Holding-time chart
README.md
```

README phải ghi lại chính xác môi trường test, parameters, kết quả và đánh giá PASS/FAIL.

---

### `Research/`

Lưu research findings và experiment history.

Research không chỉ ghi lại strategy nào thắng.

Các thử nghiệm thất bại cũng phải được giữ lại để tránh:

* Lặp lại cùng một thử nghiệm.
* Chỉ lựa chọn kết quả tốt.
* Mất lịch sử phát triển strategy.

---

### `docs/`

Lưu methodology và các quy chuẩn áp dụng cho toàn bộ repository.

---

# 3. Research Workflow

Mỗi strategy đi qua quy trình:

```text
Strategy Idea
      ↓
Define Hypothesis
      ↓
Implement Minimal EA
      ↓
Code Validation
      ↓
Baseline Backtest
      ↓
Evaluate
      ↓
PASS / FAIL
      ↓
Research Findings
      ↓
Controlled Experiment
      ↓
Robustness Validation
      ↓
Forward / Demo Test
      ↓
Live Consideration
```

Không bỏ qua baseline để đi thẳng vào optimization.

---

# 4. Step 1 — Define the Hypothesis

Trước khi viết hoặc sửa EA, strategy phải có giả thuyết rõ ràng.

Ví dụ:

```text
MACD crossover
+
MACD above/below zero
=
Momentum entry aligned with trend
```

Giả thuyết phải trả lời được:

> Tại sao điều kiện này có khả năng tạo ra trading edge?

Không bắt đầu bằng việc thử hàng loạt indicator chỉ để tìm tổ hợp có backtest đẹp.

---

# 5. Step 2 — Build the Minimal EA

Phiên bản đầu tiên phải đơn giản nhất có thể nhưng đủ để kiểm tra hypothesis.

Ưu tiên:

```text
Minimal strategy
→ Compile
→ Verify logic
→ Backtest
→ Evaluate
```

Không ưu tiên:

```text
Complex strategy
+
many indicators
+
many filters
+
parameter optimization
```

trước khi baseline hoạt động và được kiểm chứng.

---

# 6. Step 3 — Code Validation

Trước khi đánh giá strategy performance, phải kiểm tra implementation.

Tối thiểu cần xác nhận:

```text
Entry conditions execute correctly
Exit conditions execute correctly
SL / TP execute correctly
Position counting works correctly
Magic Number filtering works correctly
Spread filter works correctly
Break Even works if enabled
Trailing Stop works if enabled
```

Nếu code không thực thi đúng strategy specification thì backtest không được dùng để kết luận về hypothesis.

### Example

EA-020 baseline phát hiện một vấn đề cần xác minh trong execution flow của position management.

Do đó Break Even và Trailing Stop không được coi là đã hoạt động đúng chỉ vì chúng được bật trong Strategy Tester.

---

# 7. Step 4 — Baseline Backtest

Sau khi implementation được xác minh, chạy baseline.

Baseline là:

> Phiên bản tham chiếu để tất cả thay đổi sau này được so sánh.

Không chỉnh nhiều tham số trước khi baseline được lưu.

---

# 8. Backtest Data Quality

Ưu tiên sử dụng:

```text
100% real ticks
```

khi dữ liệu phù hợp có sẵn.

Mỗi backtest phải ghi lại tối thiểu:

```text
EA version
Symbol
Broker / data source
Timeframe
Test period
History quality
Initial deposit
Leverage
Inputs
```

Kết quả không có thông tin môi trường test không được xem là đầy đủ để tái lập.

---

# 9. Core Evaluation Metrics

Không đánh giá strategy chỉ bằng Net Profit.

Mỗi baseline hoặc experiment nên ghi tối thiểu:

| Metric             | Purpose                   |
| ------------------ | ------------------------- |
| Total Trades       | Sample size               |
| Net Profit         | Absolute performance      |
| Gross Profit       | Total winning result      |
| Gross Loss         | Total losing result       |
| Profit Factor      | Profitability             |
| Expected Payoff    | Expectancy per trade      |
| Win Rate           | Entry/result distribution |
| Average Win        | Reward characteristics    |
| Average Loss       | Risk characteristics      |
| Maximum Drawdown   | Capital risk              |
| Consecutive Losses | Losing-streak risk        |
| Sharpe Ratio       | Risk-adjusted performance |

Các metric khác có thể được thêm nếu chúng phục vụ một hypothesis cụ thể.

---

# 10. Baseline Evaluation

Baseline phải được phân loại rõ:

```text
PASS
FAIL
INCONCLUSIVE
```

### PASS

Strategy cho thấy kết quả đủ tích cực để tiếp tục validation.

PASS **không có nghĩa strategy đã sẵn sàng live**.

### FAIL

Strategy không cho thấy edge đủ tốt trong điều kiện test.

FAIL không đồng nghĩa với xóa strategy.

Kết quả được giữ lại để:

* Làm baseline.
* Phân tích nguyên nhân.
* So sánh với experiment tiếp theo.

### INCONCLUSIVE

Dùng khi chưa đủ bằng chứng để kết luận.

Ví dụ:

* Sample quá nhỏ.
* Test period quá ngắn.
* Code chưa được xác minh.
* Data quality không phù hợp.
* Execution có vấn đề.

---

# 11. Controlled Experiments

Sau baseline, mỗi experiment nên kiểm tra **một primary hypothesis**.

Recommended:

```text
Baseline
   ↓
Change ONE primary variable
   ↓
Backtest
   ↓
Compare
   ↓
PASS / FAIL
```

Ví dụ:

```text
EA-020 Baseline
        ↓
Add higher-timeframe trend filter
        ↓
Backtest
        ↓
Compare with EA-020 Baseline
```

Không nên đồng thời:

```text
Change MACD settings
+ Add EMA filter
+ Add session filter
+ Change SL
+ Change TP
```

vì nếu kết quả thay đổi sẽ khó xác định nguyên nhân.

---

# 12. Experiment Documentation

Mỗi experiment phải ghi:

```text
Hypothesis
Change made
Parameters
Test environment
Result
Comparison with baseline
Conclusion
```

Nếu experiment FAIL, vẫn lưu kết quả.

Không xóa failed experiments.

---

# 13. Entry Analysis

Nếu baseline thất bại do tỷ lệ losing trades cao, ưu tiên nghiên cứu entry quality.

Có thể nghiên cứu từng yếu tố:

```text
Trend strength
Volatility
Trading session
Higher-timeframe direction
Indicator momentum
Distance from reference level
Market regime
```

Các yếu tố trên chỉ là research candidates.

Không thêm tất cả vào EA cùng lúc.

---

# 14. Exit Analysis

Exit optimization nên được tách khỏi entry research khi có thể.

Có thể nghiên cứu:

```text
Stop Loss
Take Profit
Break Even
Trailing Stop
Time-based exit
Signal-based exit
```

Mỗi thay đổi phải được so với baseline phù hợp.

---

# 15. Time Analysis

Strategy Tester có thể cung cấp phân phối giao dịch theo:

```text
Hour
Weekday
Month
```

Các biểu đồ này được sử dụng để tạo hypothesis.

Ví dụ:

> Strategy có thể hoạt động kém trong một trading session cụ thể.

Tuy nhiên biểu đồ không tự chứng minh rằng session đó nên bị loại bỏ.

Cần tạo một experiment riêng và backtest lại.

---

# 16. MFE / MAE Analysis

Khi có dữ liệu, sử dụng:

**MFE — Maximum Favorable Excursion**

để nghiên cứu mức giá từng di chuyển có lợi cho position.

**MAE — Maximum Adverse Excursion**

để nghiên cứu mức giá từng di chuyển bất lợi cho position.

MFE/MAE có thể hỗ trợ nghiên cứu:

```text
Stop Loss placement
Take Profit placement
Exit efficiency
Entry quality
```

Nhưng không thay đổi SL/TP chỉ dựa trên biểu đồ mà không chạy controlled backtest.

---

# 17. Avoiding Overfitting

Một strategy không được coi là mạnh chỉ vì đã được tối ưu tốt trên một dataset.

Cần đặc biệt tránh:

```text
Testing many parameters
→ selecting the best result
→ declaring strategy profitable
```

Đây có thể chỉ là curve fitting.

Optimization được xem là bước tạo candidate, không phải bằng chứng cuối cùng về robustness.

---

# 18. In-Sample and Out-of-Sample

Khi strategy đã vượt baseline research, dữ liệu nên được tách thành:

```text
In-Sample
    ↓
Develop / Optimize

Out-of-Sample
    ↓
Validate
```

Out-of-Sample data không nên được sử dụng liên tục để sửa strategy, vì khi đó nó dần trở thành một phần của development data.

---

# 19. Robustness Validation

Một candidate strategy chỉ nên tiếp tục nếu kết quả không phụ thuộc hoàn toàn vào một bộ parameter duy nhất.

Các validation có thể bao gồm:

```text
Different time periods
Different market regimes
Parameter sensitivity
Out-of-Sample testing
Forward testing
```

Các phương pháp nâng cao hơn chỉ được thêm khi cần thiết.

---

# 20. Forward Testing

Backtest tốt chưa đủ để chuyển sang live trading.

Candidate strategy nên được kiểm tra trong môi trường:

```text
Demo / Forward Test
```

Mục tiêu là so sánh:

```text
Backtest behavior
vs
Forward behavior
```

và phát hiện các vấn đề liên quan đến:

* Spread.
* Slippage.
* Execution.
* Broker conditions.
* Live market behavior.

---

# 21. Research Integrity Rules

Toàn bộ repository tuân theo các nguyên tắc:

1. Không xóa failed backtests chỉ vì kết quả xấu.
2. Không chỉ công bố experiment tốt nhất.
3. Không thay đổi nhiều biến mà không ghi lại.
4. Không đánh giá strategy chỉ bằng Net Profit.
5. Không tăng lot size để che giấu negative expectancy.
6. Không coi optimization là bằng chứng về robustness.
7. Không coi một backtest duy nhất là bằng chứng đủ cho live trading.
8. Luôn lưu parameters và test environment.
9. Luôn giữ evidence gốc khi có thể.
10. Kết luận phải dựa trên dữ liệu đã test.

---

# 22. Current Baseline Example — EA-020

EA-020 hiện là một ví dụ về quy trình baseline.

```text
EA-020_MACD_Signal_Trend
        ↓
XAUUSD.PRO / M1
        ↓
2026.01.02 – 2026.08.01
        ↓
100% Real Ticks
        ↓
2,813 Trades
        ↓
Profit Factor: 0.84
        ↓
Net Profit: -$993.58
        ↓
Maximum Drawdown: 99.38%
        ↓
BASELINE FAIL
```

Baseline này không bị xóa.

Nó trở thành điểm tham chiếu cho các experiment tiếp theo.

---

# 23. Research Progression

Mỗi EA nên tiến triển theo các stage:

```text
IDEA
 ↓
IMPLEMENTED
 ↓
BASELINE TESTED
 ↓
RESEARCH
 ↓
CANDIDATE
 ↓
VALIDATED
 ↓
FORWARD TEST
 ↓
LIVE CONSIDERATION
```

Không tự động chuyển stage chỉ vì một metric cải thiện.

Mỗi stage phải có evidence tương ứng.

---

# 24. Core Principle

Nguyên tắc trung tâm của repository:

> **Hypothesis → Implementation → Test → Evidence → Decision**

Không tối ưu để chứng minh strategy đúng.

Test được sử dụng để xác định strategy **đúng hay sai so với hypothesis đã đặt ra**.

Một kết quả FAIL có evidence đầy đủ vẫn là một research result hợp lệ.
