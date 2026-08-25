# EA-023 — Supertrend Retest | Research

## 1. Research Objective

Thư mục này lưu quá trình nghiên cứu của **EA-023_Supertrend_Retest** nhằm xác định:

* Vì sao baseline hiện tại chưa có lợi thế thống kê dương.
* Thành phần nào của strategy đang tạo hoặc làm mất expectancy.
* Những thay đổi nào đáng để kiểm thử tiếp theo.
* Liệu Supertrend Retest có đủ tiềm năng để tiếp tục phát triển trên XAUUSD hay không.

Mọi thay đổi được đề xuất trong Research phải được **backtest riêng** trước khi được xem là cải tiến.

---

## 2. Strategy Under Research

EA-023 sử dụng mô hình:

```text
Supertrend đổi hướng
        ↓
Tạo pending signal
        ↓
Chờ giá retest Supertrend
        ↓
Retest hợp lệ
        ↓
BUY / SELL
        ↓
Fixed SL / TP
        ↓
Break Even
        ↓
Trailing Stop
```

Các thành phần chính cần nghiên cứu:

1. Supertrend signal.
2. Retest condition.
3. Retest timing.
4. BUY / SELL behavior.
5. Stop Loss / Take Profit.
6. Break Even.
7. Trailing Stop.
8. Spread / execution.
9. Trading time.

---

## 3. Baseline

Baseline hiện tại được backtest với:

| Item            | Value                     |
| --------------- | ------------------------- |
| Symbol          | `XAUUSD.PRO`              |
| Timeframe       | `M1`                      |
| Period          | `2026.01.02 – 2026.03.01` |
| Data Quality    | `100% real ticks`         |
| Initial Deposit | `$1,000`                  |
| Lot Size        | `0.01`                    |
| Total Trades    | `139`                     |

### Baseline Results

| Metric                  |      Result |
| ----------------------- | ----------: |
| Net Profit              | **-$18.71** |
| Profit Factor           |    **0.89** |
| Expected Payoff         |  **-$0.13** |
| Recovery Factor         |   **-0.34** |
| Maximum Equity Drawdown |   **5.51%** |
| Win Rate                |  **48.20%** |
| Average Profit Trade    |     `$2.34` |
| Average Loss Trade      |    `-$2.44` |

### Baseline Verdict

**FAIL — Negative expectancy.**

Baseline được giữ nguyên làm mốc so sánh cho tất cả thử nghiệm tiếp theo.

---

# 4. Baseline Findings

## Finding 01 — Expectancy hiện tại âm

Baseline:

```text
Gross Profit =  $156.85
Gross Loss   = -$175.56

Profit Factor = 0.89
Expected Payoff = -$0.13
```

EA tạo được profitable trades nhưng tổng lợi nhuận chưa đủ bù tổng thua lỗ.

### Research implication

Không nên chỉ tìm cách tăng số lượng tín hiệu.

Ưu tiên nghiên cứu:

```text
Trade Quality
+
Entry Quality
+
Exit Quality
```

---

## Finding 02 — Win rate dưới 50%

Baseline:

```text
Winning Trades = 67
Losing Trades  = 72

Win Rate = 48.20%
```

Win rate dưới 50% không tự động có nghĩa strategy không khả thi.

Tuy nhiên baseline đồng thời có:

```text
Average Winner = $2.34
Average Loser  = $2.44
```

Do đó hiện tại:

```text
Win Rate < 50%
AND
Average Winner < Average Loser
```

Đây là vấn đề trực tiếp đối với expectancy.

---

## Finding 03 — SELL tốt hơn BUY trong baseline

Kết quả:

```text
SELL
90 trades
50.00% win rate

BUY
49 trades
44.90% win rate
```

SELL có win rate cao hơn BUY trong mẫu hiện tại.

### Hypothesis

Có thể tồn tại sự bất đối xứng giữa BUY và SELL.

### Chưa được kết luận

Không được kết luận:

```text
SELL-only > BUY+SELL
```

chỉ dựa trên win rate.

Cần backtest riêng BUY-only và SELL-only trước khi quyết định.

---

## Finding 04 — Exit behavior cần được kiểm tra

Baseline:

```text
Average Profit Trade = $2.34
Average Loss Trade   = $2.44
```

Trong khi cấu hình ban đầu:

```text
SL = 300 points
TP = 600 points
```

Nominal TP/SL là:

```text
2 : 1
```

nhưng realized average winner/loss không phản ánh tỷ lệ 2:1 này.

EA còn sử dụng:

```text
Break Even
Trailing Stop
```

### Research question

Cần xác định:

* Break Even có đóng winner quá sớm không?
* Trailing Stop có làm giảm average winner không?
* Fixed TP có thường xuyên đạt được không?
* Các profitable trades có MFE lớn hơn mức profit thực nhận đáng kể không?

Không kết luận nguyên nhân cho đến khi có test riêng.

---

## Finding 05 — Holding time rất ngắn

Baseline:

```text
Minimum = 00:00:02
Average = 00:02:38
Maximum = 00:15:45
```

EA đang hoạt động như một strategy rất ngắn hạn trên M1.

### Research implication

Kết quả có khả năng nhạy với:

* Spread.
* Slippage.
* Tick execution.
* Broker conditions.
* Entry timing.

Baseline sử dụng 100% real ticks, đây là điều phù hợp để tiếp tục nghiên cứu các yếu tố này.

---

# 5. Research Hypotheses

Các hypothesis dưới đây **chưa được chứng minh**.

Chúng chỉ xác định những thứ cần test.

---

## H01 — BUY và SELL có expectancy khác nhau

### Evidence

Baseline:

```text
SELL win rate = 50.00%
BUY win rate  = 44.90%
```

### Test

Chạy riêng:

```text
EA-023 BUY-only
EA-023 SELL-only
```

### Compare

* Net Profit
* Profit Factor
* Expected Payoff
* Drawdown
* Trade Count
* Average Winner
* Average Loser

### PASS

Chỉ xác nhận hypothesis nếu kết quả cho thấy khác biệt đủ rõ và tiếp tục tồn tại trên dữ liệu ngoài baseline.

---

# 6. H02 — Trading Hour ảnh hưởng đến expectancy

Baseline Strategy Tester cho thấy số lượng entry và P/L phân bố không đồng đều theo giờ.

### Hypothesis

Một số giờ giao dịch có thể tạo tín hiệu Supertrend Retest chất lượng thấp hơn các giờ khác.

### Test

Phân tích trade theo:

```text
Hour 00
Hour 01
...
Hour 23
```

Với mỗi giờ tính:

```text
Trades
Wins
Losses
Win Rate
Net Profit
Profit Factor
Average Trade
```

### Rule

Không loại một giờ chỉ vì một vài trade thua.

Cần đủ sample size trước khi sử dụng time filter.

---

# 7. H03 — Trading Session ảnh hưởng đến strategy

Từ dữ liệu theo giờ có thể nhóm thành các trading session để kiểm tra.

Ví dụ nghiên cứu:

```text
Asia
Europe
US
```

Mục tiêu không phải mặc định rằng một session tốt hơn.

Mục tiêu là kiểm tra:

```text
Supertrend Retest
+
XAUUSD
+
M1
```

có tạo expectancy khác nhau giữa các khoảng thời gian giao dịch hay không.

---

# 8. H04 — Retest condition cần được kiểm tra

Baseline:

```text
InpRetestMaxBars = 5
InpRetestBuffer  = 5.0
```

Retest là thành phần cốt lõi phân biệt EA-023 với việc vào lệnh trực tiếp khi Supertrend đổi hướng.

### Research questions

```text
5 bars có quá dài?
5 points buffer có quá nhỏ/lớn?
Retest sớm và retest muộn có cùng chất lượng?
```

### Candidate Tests

Không optimize hàng loạt ngay.

Test từng biến độc lập trước.

Ví dụ:

```text
RetestMaxBars
1
3
5
```

sau đó mới đánh giá có cần mở rộng range hay không.

---

# 9. H05 — Supertrend Parameters ảnh hưởng entry quality

Baseline:

```text
ATR Period = 10
Multiplier = 3.0
```

### Hypothesis

Supertrend hiện tại có thể:

* phản ứng quá nhanh,
* phản ứng quá chậm,
* hoặc tạo flip trong market regime không phù hợp.

### Test Principle

Không chạy optimization grid lớn ngay.

Bắt đầu bằng một số cấu hình có kiểm soát và so sánh với baseline.

Baseline phải luôn giữ:

```text
ATR = 10
Multiplier = 3.0
```

làm control.

---

# 10. H06 — Break Even ảnh hưởng expectancy

Baseline:

```text
Break Even = ON
Trigger = 150 points
```

### Minimum Test

```text
Test A
Break Even = ON

Test B
Break Even = OFF
```

Giữ nguyên tất cả parameter khác.

### Compare

```text
Net Profit
Profit Factor
Average Winner
Average Loser
Drawdown
Win Rate
```

Chỉ thay **một biến** để xác định tác động thực sự của Break Even.

---

# 11. H07 — Trailing Stop ảnh hưởng expectancy

Baseline:

```text
Trailing Stop = ON
Start    = 200
Distance = 200
Step     = 10
```

### Minimum Test

```text
Test A
Trailing = ON

Test B
Trailing = OFF
```

Các parameter còn lại giữ nguyên.

Nếu có khác biệt đáng kể mới nghiên cứu sâu hơn:

```text
Trailing Start
Trailing Distance
Trailing Step
```

---

# 12. H08 — Fixed SL/TP chưa phù hợp với mọi market condition

Baseline:

```text
SL = 300 points
TP = 600 points
```

Đây là khoảng cách cố định.

Trong khi volatility của XAUUSD thay đổi theo thời gian.

### Hypothesis

Fixed SL/TP có thể hoạt động khác nhau giữa các volatility regime.

### Status

**Chưa kiểm chứng.**

Không chuyển sang ATR-based SL/TP cho đến khi xác định fixed exit hiện tại thực sự là vấn đề cần giải quyết.

---

# 13. MFE / MAE Research

Baseline report:

```text
Correlation (Profits, MFE) = 0.96
Correlation (Profits, MAE) = 0.71
Correlation (MFE, MAE)     = 0.6313
```

Đây là dữ liệu đáng giữ lại để nghiên cứu exit behavior.

### Research Goal

Kiểm tra:

```text
Winner đi được bao xa trước khi đóng?
Loser từng đi đúng hướng bao xa?
Winner bị trả lại bao nhiêu profit?
Break Even / Trailing có đang đóng trade ở vị trí hợp lý?
```

Không thay exit logic trước khi có bằng chứng từ trade-level analysis hoặc controlled backtest.

---

# 14. Research Order

Để tránh thay nhiều thứ cùng lúc, thứ tự nghiên cứu:

```text
Baseline
   ↓
BUY vs SELL
   ↓
Trading Hour / Session
   ↓
Break Even ON/OFF
   ↓
Trailing ON/OFF
   ↓
Retest Parameters
   ↓
Supertrend Parameters
   ↓
SL / TP
```

Nguyên tắc:

> Thay một nhóm logic tại một thời điểm và luôn so với baseline.

---

# 15. What Not To Do Yet

Ở giai đoạn hiện tại chưa:

* Machine Learning.
* AI prediction.
* Neural Network.
* Genetic optimization diện rộng.
* Multi-indicator stacking.
* Thêm nhiều filter cùng lúc.
* Tối ưu hàng chục parameter đồng thời.
* Chọn parameter chỉ vì backtest đẹp nhất.
* Live trading dựa trên baseline hiện tại.

Mục tiêu trước mắt là xác định:

```text
EA-023 có edge thực sự ở đâu?
```

---

# 16. Research Validation Rules

Một thay đổi không được coi là cải tiến chỉ vì:

```text
Net Profit tăng
```

Ít nhất phải xem đồng thời:

```text
Profit Factor
Expected Payoff
Drawdown
Trade Count
Win Rate
Average Winner
Average Loser
```

Và phải kiểm tra nguy cơ:

```text
Overfitting
Low sample size
Period-specific result
```

---

# 17. Research Status

| ID      | Research Item         | Status   |
| ------- | --------------------- | -------- |
| BASE    | Baseline              | COMPLETE |
| H01     | BUY vs SELL           | TODO     |
| H02     | Trading Hour          | TODO     |
| H03     | Trading Session       | TODO     |
| H04     | Retest Parameters     | TODO     |
| H05     | Supertrend Parameters | TODO     |
| H06     | Break Even            | TODO     |
| H07     | Trailing Stop         | TODO     |
| H08     | SL / TP               | TODO     |
| MFE/MAE | Exit Analysis         | TODO     |

---

# 18. Current Conclusion

Baseline hiện tại chứng minh rằng EA có thể:

```text
Detect Supertrend flip
→ Wait for retest
→ Execute trades
→ Manage positions
```

nhưng **chưa chứng minh strategy có edge dương**.

Baseline:

```text
Net Profit      = -$18.71
Profit Factor   = 0.89
Expected Payoff = -$0.13
Max Equity DD   = 5.51%
Trades          = 139
```

Do đó trạng thái nghiên cứu hiện tại:

**STRATEGY REQUIRES FURTHER RESEARCH**

Mục tiêu tiếp theo không phải optimize toàn bộ EA.

Mục tiêu là tìm ra **thành phần nào đang tạo hoặc phá hủy expectancy**, sau đó kiểm chứng từng thay đổi bằng controlled backtest.

---

## Related Files

```text
EAs/
└── EA-023_Supertrend_Retest/
    ├── EA-023_Supertrend_Retest.mq5
    └── README.md

Backtest/
└── EA-023_Supertrend_Retest/
    ├── README.md
    └── Strategy Tester evidence

Research/
└── README.md
```
