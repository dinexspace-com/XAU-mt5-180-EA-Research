# XAUUSD MT5 EA Research Methodology

## 1. Purpose

Tài liệu này định nghĩa phương pháp chuẩn để nghiên cứu, phát triển và đánh giá các **Expert Advisor (EA) cho XAUUSD trên MetaTrader 5** trong repository này.

Mục tiêu chính:

> Xây dựng EA theo một quy trình có thể kiểm chứng, trong đó strategy logic, source code, backtest evidence và kết luận nghiên cứu được lưu lại rõ ràng.

Một EA không được đánh giá dựa trên một equity curve đẹp hoặc một chỉ số đơn lẻ.

Quy trình nghiên cứu phải cho phép trả lời:

```text
Strategy là gì?
        ↓
EA thực thi strategy như thế nào?
        ↓
Backtest được thực hiện trong điều kiện nào?
        ↓
Kết quả thực tế là gì?
        ↓
Điểm yếu nằm ở đâu?
        ↓
Giả thuyết cải tiến là gì?
        ↓
Kết quả mới có thực sự tốt hơn baseline không?
```

---

# 2. Repository Structure

Cấu trúc chuẩn:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-001_<Strategy>/
│   │   ├── EA-001_<Strategy>.mq5
│   │   └── README.md
│   │
│   ├── EA-002_<Strategy>/
│   └── ...
│
├── Backtest/
│   ├── EA-001_<Strategy>/
│   ├── EA-002_<Strategy>/
│   └── ...
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

Mỗi khu vực có trách nhiệm riêng.

---

# 3. EAs/

`EAs/` chứa source code của từng Expert Advisor.

Ví dụ:

```text
EAs/
└── EA-023_Supertrend_Retest/
    ├── EA-023_Supertrend_Retest.mq5
    └── README.md
```

## Source Code

File `.mq5` là implementation thực tế của strategy.

README của EA phải được viết dựa trên **code thực tế**, không dựa trên strategy mà EA dự kiến sẽ có.

README nên ghi:

* Strategy overview.
* Signal logic.
* Entry conditions.
* Exit conditions.
* Risk management.
* Filters.
* Parameters.
* Symbol/timeframe assumptions.
* Known limitations.
* Development/backtest status.

Nếu một chức năng chưa tồn tại trong source code thì không được mô tả như một chức năng đã triển khai.

---

# 4. Backtest/

`Backtest/` chứa **evidence thực tế từ MetaTrader 5 Strategy Tester**.

Ví dụ:

```text
Backtest/
└── EA-023_Supertrend_Retest/
    ├── README.md
    ├── Strategy Tester Report
    └── Graphs
```

Không thay thế report gốc bằng số liệu ghi thủ công.

Strategy Tester report phải được giữ lại để kết quả có thể được kiểm tra lại.

---

# 5. Baseline First

Mỗi EA phải có một **baseline backtest** trước khi optimization.

Baseline là:

> Kết quả của phiên bản strategy ban đầu với một bộ parameter xác định trước khi thực hiện các thay đổi nhằm cải thiện performance.

Ví dụ baseline của EA-023:

```text
EA:        EA-023_Supertrend_Retest
Symbol:    XAUUSD.PRO
Timeframe: M1
Period:    2026.01.02 – 2026.03.01

Net Profit:      -$18.71
Profit Factor:    0.89
Expected Payoff: -$0.13
Max Equity DD:    5.51%
Total Trades:     139
```

Baseline **không cần profitable**.

Một baseline thất bại vẫn có giá trị vì nó tạo control để so sánh các phiên bản sau.

---

# 6. Preserve Raw Evidence

Không xóa backtest xấu chỉ vì strategy không profitable.

Ví dụ:

```text
Baseline
Net Profit = -$18.71
PF = 0.89
```

vẫn phải được giữ.

Lý do:

```text
Baseline
    ↓
Change
    ↓
New Backtest
    ↓
Comparison
```

Nếu chỉ giữ kết quả tốt nhất, quá trình nghiên cứu mất khả năng truy vết.

---

# 7. Backtest Environment

Mỗi backtest phải ghi tối thiểu:

| Field                   | Required       |
| ----------------------- | -------------- |
| EA                      | Yes            |
| EA version              | When available |
| Symbol                  | Yes            |
| Timeframe               | Yes            |
| Test period             | Yes            |
| Modeling / tick quality | Yes            |
| Initial deposit         | Yes            |
| Currency                | Yes            |
| Leverage                | Yes            |
| EA inputs               | Yes            |

Nếu broker sử dụng symbol khác như:

```text
XAUUSD
XAUUSD.PRO
GOLD
```

phải ghi đúng symbol thực tế đã test.

Không mặc định kết quả giữa các symbol/broker là tương đương.

---

# 8. Data Quality

Ưu tiên backtest bằng dữ liệu có chất lượng cao.

Baseline EA-023 hiện tại sử dụng:

```text
History Quality = 100% real ticks
```

Khi strategy có:

* holding time ngắn,
* trailing stop,
* break even,
* logic phụ thuộc tick,
* entry trên timeframe thấp,

tick quality đặc biệt quan trọng.

---

# 9. Core Metrics

Không đánh giá strategy chỉ bằng `Net Profit`.

Mỗi backtest tối thiểu phải xem:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Total Trades
Win Rate
Average Profit Trade
Average Loss Trade
Recovery Factor
```

Khi phù hợp, xem thêm:

```text
Sharpe Ratio
Consecutive Wins / Losses
MFE
MAE
Holding Time
Long / Short performance
```

---

# 10. Net Profit

Net Profit cho biết tổng kết quả tài chính của test:

```text
Net Profit
=
Gross Profit
+
Gross Loss
```

Net Profit dương là cần thiết đối với một strategy profitable trong sample được kiểm tra.

Tuy nhiên:

```text
Net Profit > 0
```

không đủ để kết luận strategy robust.

---

# 11. Profit Factor

```text
Profit Factor
=
Gross Profit / |Gross Loss|
```

Interpretation:

```text
PF > 1
→ Gross Profit > Gross Loss

PF = 1
→ Break-even trước các yếu tố khác

PF < 1
→ Gross Profit < Gross Loss
```

Ví dụ EA-023 baseline:

```text
PF = 0.89
```

cho thấy baseline hiện tại chưa có positive expectancy.

---

# 12. Expected Payoff

Expected Payoff cho biết lợi nhuận trung bình trên mỗi trade trong sample.

Ví dụ:

```text
EA-023
Expected Payoff = -$0.13
```

Giá trị âm cho thấy trung bình mỗi trade của baseline đang làm giảm kết quả tài khoản.

---

# 13. Drawdown

Drawdown phải được xem cùng profitability.

Một EA có drawdown thấp nhưng:

```text
Net Profit < 0
```

không trở thành strategy tốt chỉ vì drawdown thấp.

Ngược lại, một EA profitable nhưng drawdown quá lớn cũng có thể không phù hợp để triển khai.

Do đó cần xem:

```text
Return
vs
Risk
```

thay vì từng metric riêng lẻ.

---

# 14. Trade Count

Sample size phải luôn được ghi lại.

Ví dụ:

```text
139 trades
```

có nhiều thông tin hơn một test chỉ có vài trade, nhưng vẫn không tự động chứng minh strategy robust.

Khi thêm filter:

```text
Before Filter = 139 trades
After Filter  = 20 trades
```

performance tốt hơn có thể chỉ đến từ việc sample bị thu nhỏ.

Vì vậy luôn so sánh:

```text
Performance improvement
vs
Reduction in sample size
```

---

# 15. Win Rate Is Not Enough

Không sử dụng Win Rate làm metric duy nhất.

Expectancy phụ thuộc vào cả:

```text
Win Rate
+
Average Winner
+
Average Loser
```

Ví dụ baseline EA-023:

```text
Win Rate        = 48.20%
Average Winner  = $2.34
Average Loser   = $2.44
```

Win rate dưới 50% vẫn có thể profitable nếu winner đủ lớn.

Trong baseline này điều đó chưa xảy ra.

---

# 16. Research Process

Khi baseline FAIL, không thay đổi nhiều thành phần cùng lúc.

Quy trình:

```text
Observe
   ↓
Form Hypothesis
   ↓
Define Controlled Test
   ↓
Run Backtest
   ↓
Compare With Baseline
   ↓
Accept / Reject Hypothesis
```

Ví dụ:

```text
Observation:
SELL win rate > BUY win rate

Hypothesis:
BUY và SELL có expectancy khác nhau

Test:
BUY-only
SELL-only

Result:
Compare metrics

Conclusion:
Accept / Reject / Inconclusive
```

---

# 17. One Variable at a Time

Ưu tiên thay đổi một biến hoặc một nhóm logic có quan hệ trực tiếp.

Ví dụ muốn kiểm tra Break Even:

```text
Test A
Break Even = ON

Test B
Break Even = OFF
```

Các parameter khác giữ nguyên.

Không làm:

```text
Change Break Even
+
Change Supertrend
+
Change SL
+
Add Session Filter
```

trong cùng một test.

Nếu kết quả thay đổi, sẽ không biết yếu tố nào tạo ra khác biệt.

---

# 18. Research Before Optimization

Không bắt đầu bằng việc chạy optimization hàng nghìn parameter combinations.

Trước tiên phải hiểu:

```text
Strategy đang thua ở đâu?
```

Ví dụ có thể nghiên cứu:

```text
BUY vs SELL
Trading Hour
Trading Session
Entry quality
Retest behavior
Break Even
Trailing Stop
MFE / MAE
```

Sau khi xác định thành phần có ảnh hưởng rõ ràng mới optimize parameter của thành phần đó.

---

# 19. Optimization

Optimization có mục đích:

> Tìm vùng parameter hợp lý để nghiên cứu, không phải tìm một combination có backtest đẹp nhất.

Không chọn parameter chỉ dựa vào:

```text
Highest Net Profit
```

Cần xem sự ổn định của vùng parameter.

Ví dụ nếu:

```text
Parameter 9  → FAIL
Parameter 10 → Excellent
Parameter 11 → FAIL
```

thì `10` có nguy cơ là một isolated optimum.

Một vùng như:

```text
Parameter 8  → Good
Parameter 9  → Good
Parameter 10 → Good
Parameter 11 → Good
Parameter 12 → Good
```

đáng nghiên cứu hơn.

---

# 20. Overfitting

Một trong những rủi ro lớn nhất của EA research là overfitting.

Overfitting xảy ra khi strategy được điều chỉnh quá sát với historical data.

Dấu hiệu cần chú ý:

* Quá nhiều parameters.
* Quá nhiều filters.
* Sample size giảm mạnh.
* Một parameter combination vượt trội bất thường.
* Performance chỉ tốt trên một khoảng thời gian.
* Optimization rất tốt nhưng test ngoài sample thất bại.

Nguyên tắc:

> Strategy càng phức tạp thì càng cần nhiều evidence để chứng minh complexity đó có giá trị.

---

# 21. In-Sample / Out-of-Sample

Khi strategy bắt đầu cho kết quả khả quan, không tiếp tục đánh giá trên cùng dữ liệu đã dùng để nghiên cứu.

Tách dữ liệu thành:

```text
In-Sample
→ Research / Optimization

Out-of-Sample
→ Independent Validation
```

Không điều chỉnh strategy dựa trên kết quả Out-of-Sample rồi tiếp tục gọi chính khoảng dữ liệu đó là Out-of-Sample.

Nếu đã dùng nó để ra quyết định, nó trở thành một phần của quá trình development.

---

# 22. Robustness

Sau khi strategy vượt baseline và Out-of-Sample test, có thể thực hiện robustness testing.

Ví dụ:

```text
Different periods
Different market regimes
Parameter perturbation
Spread sensitivity
Execution sensitivity
```

Mục tiêu:

> Kiểm tra edge có tồn tại khi điều kiện thay đổi hay chỉ tồn tại trong một cấu hình rất cụ thể.

---

# 23. MFE / MAE Analysis

MFE và MAE được sử dụng để nghiên cứu hành vi của trade.

### MFE

Maximum Favorable Excursion:

```text
Trade từng đi được bao xa theo hướng có lợi?
```

### MAE

Maximum Adverse Excursion:

```text
Trade từng đi ngược bao xa?
```

Có thể sử dụng để nghiên cứu:

* Stop Loss.
* Take Profit.
* Break Even.
* Trailing Stop.
* Exit timing.

Không thay exit chỉ dựa trên một scatter plot.

MFE/MAE phải được xem cùng trade outcome và backtest comparison.

---

# 24. Long / Short Analysis

BUY và SELL phải được kiểm tra riêng khi có dấu hiệu khác biệt.

Ví dụ EA-023 baseline:

```text
SELL
90 trades
Win Rate = 50.00%

BUY
49 trades
Win Rate = 44.90%
```

Đây là **observation**, không phải bằng chứng rằng SELL-only tốt hơn.

Bước đúng:

```text
Observation
→ Hypothesis
→ Separate Test
→ Comparison
→ Conclusion
```

---

# 25. Time Analysis

Nếu performance phân bố khác nhau theo thời gian, có thể nghiên cứu:

```text
Hour
Weekday
Session
Month
```

Không tạo time filter chỉ vì một giờ hoặc một ngày có P/L âm trong một backtest.

Cần xem:

```text
Number of Trades
+
Performance
+
Consistency across periods
```

trước khi thêm filter.

---

# 26. PASS / FAIL

Mỗi test phải có kết luận rõ:

```text
PASS
FAIL
INCONCLUSIVE
```

### PASS

Có evidence cho thấy hypothesis hoặc thay đổi đang được kiểm tra cải thiện strategy theo tiêu chí đã xác định.

### FAIL

Test không đạt tiêu chí hoặc làm strategy xấu hơn.

### INCONCLUSIVE

Sample hoặc evidence chưa đủ để đưa ra kết luận.

`FAIL` không có nghĩa file bị xóa.

Kết quả FAIL vẫn là research evidence.

---

# 27. No Automatic Promotion

Một test PASS không tự động biến phiên bản đó thành strategy chính.

Quy trình tối thiểu:

```text
Baseline
   ↓
Research Test
   ↓
PASS
   ↓
Independent Validation
   ↓
Robustness Check
   ↓
Decision
```

Việc thay đổi phiên bản chính phải là một quyết định có evidence.

---

# 28. Research Documentation

Mỗi research finding nên có cấu trúc:

```text
Observation

Hypothesis

Test

Result

Evidence

Conclusion

Next Step
```

Không ghi:

```text
"This seems better."
```

mà không có backtest evidence.

---

# 29. Reproducibility

Một người khác phải có khả năng nhìn repository và xác định:

```text
EA version nào được test?
Parameter nào được dùng?
Symbol nào?
Timeframe nào?
Period nào?
Data quality nào?
Kết quả nào?
Report gốc ở đâu?
```

Nếu không thể trả lời những câu hỏi trên thì test chưa được document đầy đủ.

---

# 30. Development Stages

Quy trình tổng thể:

```text
IDEA
 ↓
IMPLEMENTATION
 ↓
BASELINE BACKTEST
 ↓
RESEARCH
 ↓
CONTROLLED TESTS
 ↓
OPTIMIZATION
 ↓
OUT-OF-SAMPLE
 ↓
ROBUSTNESS
 ↓
FORWARD / DEMO TEST
 ↓
REVIEW
```

Không bỏ qua validation chỉ vì optimization cho kết quả tốt.

---

# 31. Current Reference Case

EA-023 hiện là một ví dụ về baseline research:

```text
EA:
EA-023_Supertrend_Retest

Market:
XAUUSD.PRO

Timeframe:
M1

Data:
100% real ticks

Trades:
139

Net Profit:
-$18.71

Profit Factor:
0.89

Expected Payoff:
-$0.13

Maximum Equity Drawdown:
5.51%
```

Kết luận:

```text
BASELINE = FAIL
```

Điều này không đồng nghĩa concept Supertrend Retest bị bác bỏ.

Nó chỉ có nghĩa:

> Implementation + parameters + market conditions của baseline hiện tại chưa chứng minh được positive expectancy.

Bước tiếp theo phải là research có kiểm soát thay vì optimization mù.

---

# 32. Core Principle

Quy trình của repository tuân theo nguyên tắc:

```text
Build
↓
Test
↓
Measure
↓
Understand
↓
Change
↓
Test Again
```

Mỗi kết luận phải quay về được:

```text
Source Code
+
Backtest
+
Evidence
```

Mục tiêu cuối cùng không phải tạo ra backtest đẹp nhất.

Mục tiêu là xác định liệu strategy có một **repeatable and robust trading edge** hay không.
