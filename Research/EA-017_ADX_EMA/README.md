# EA-017_ADX_EMA — Research

Research log cho chiến lược:

**EMA Crossover + ADX + Directional Indicator**

Mục tiêu của thư mục này là ghi lại:

* Baseline.
* Vấn đề đã phát hiện.
* Giả thuyết cần kiểm tra.
* Các thử nghiệm tiếp theo.
* Kết quả PASS / FAIL của từng thử nghiệm.

Không dùng thư mục này để chứng minh strategy profitable khi chưa có backtest evidence.

---

# 1. Baseline Strategy

EA-017 sử dụng:

* Fast EMA: 20
* Slow EMA: 50
* ADX Period: 14
* Minimum ADX: 25
* Stop Loss: 300 points
* Take Profit: 600 points
* Fixed Lot: 0.01
* Maximum Spread: 30 points

## BUY

BUY khi:

1. EMA20 cắt lên EMA50.
2. ADX đạt ngưỡng.
3. +DI > -DI.

## SELL

SELL khi:

1. EMA20 cắt xuống EMA50.
2. ADX đạt ngưỡng.
3. -DI > +DI.

EA chỉ kiểm tra entry trên nến mới và sử dụng dữ liệu indicator của nến đã đóng.

---

# 2. Baseline Test

Baseline hiện tại:

| Parameter       | Value                   |
| --------------- | ----------------------- |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Period          | 2026.01.02 – 2026.06.08 |
| Initial Deposit | $1,000                  |
| Leverage        | 1:500                   |
| Data            | 100% Real Ticks         |
| Break Even      | OFF                     |
| Trailing Stop   | OFF                     |

Backtest evidence:

`../Backtest/EA-017_ADX_EMA/report.html`

---

# 3. Baseline Result

| Metric                     |   Result |
| -------------------------- | -------: |
| Net Profit                 | -$184.67 |
| Profit Factor              |     0.95 |
| Expected Payoff            |   -$0.10 |
| Sharpe Ratio               |    -4.45 |
| Max Equity Drawdown        |   28.26% |
| Total Trades               |    1,818 |
| Win Rate                   |   32.51% |
| Long Win Rate              |   31.95% |
| Short Win Rate             |   33.05% |
| Average Win                |    $6.11 |
| Average Loss               |   -$3.09 |
| Maximum Consecutive Losses |       26 |

**Baseline Status: FAIL**

---

# 4. Main Research Observation

## Observation 01 — Strategy is close to break-even

Average trade:

* Average Winner = $6.11
* Average Loser = $3.09

Tỷ lệ Average Win / Average Loss xấp xỉ:

**1.98 : 1**

Với tỷ lệ này, win rate hòa vốn lý thuyết xấp xỉ:

**33.6%**

Win rate thực tế:

**32.51%**

Khoảng cách chỉ khoảng:

**1.1 percentage points**

### Interpretation

Điều này cho thấy vấn đề chính có thể không nằm ở việc Reward/Risk quá thấp.

Giả thuyết nghiên cứu ưu tiên là:

> Có thể strategy cần cải thiện chất lượng entry để loại bớt một phần tín hiệu thua, thay vì thay đổi toàn bộ strategy.

Đây mới là **research hypothesis**, chưa phải kết luận.

---

# 5. Observation 02 — BUY và SELL đều yếu

Baseline:

* BUY Win Rate: 31.95%
* SELL Win Rate: 33.05%

Chênh lệch không lớn.

Vì vậy hiện tại:

**Không loại BUY.**

**Không loại SELL.**

Chưa có evidence đủ mạnh để kết luận một hướng giao dịch là nguyên nhân chính gây thua lỗ.

---

# 6. Observation 03 — Trade Frequency

Baseline tạo:

**1,818 trades**

trong khoảng hơn 5 tháng trên M1.

Average holding time:

**00:09:03**

Điều này cho thấy EA đang tạo số lượng tín hiệu tương đối lớn và giữ position ngắn.

Research cần kiểm tra liệu giảm số lượng tín hiệu nhưng tăng chất lượng entry có cải thiện expectancy hay không.

---

# 7. Observation 04 — Exit Management chưa được kiểm tra

Baseline chạy với:

* Break Even = OFF
* Trailing Stop = OFF

Do đó baseline hiện tại chủ yếu đánh giá:

**Entry logic + Fixed SL + Fixed TP**

Chưa thể kết luận Break Even hoặc Trailing Stop có cải thiện strategy hay không.

Ngoài ra code hiện tại có `ManageOpenPositions()` được gọi qua `OnTimer()`, nhưng timer chưa được khởi tạo trong `OnInit()`.

Vì vậy phải sửa và xác nhận chức năng này trước khi nghiên cứu Break Even / Trailing Stop.

---

# 8. Research Questions

Các câu hỏi nghiên cứu cho EA-017:

### RQ-01

ADX threshold hiện tại có đang cho phép quá nhiều EMA crossover chất lượng thấp?

### RQ-02

M1 có phải timeframe phù hợp nhất cho EMA20/50 + ADX14 trên XAUUSD hay không?

### RQ-03

Break Even hoặc Trailing Stop có cải thiện expectancy và drawdown hay không?

### RQ-04

Có thể cải thiện strategy mà vẫn giữ nguyên core logic:

**EMA crossover + ADX + DI confirmation**

hay không?

---

# 9. Research Priority

Thực hiện theo thứ tự.

Không thay nhiều nhóm biến cùng một lúc.

## EXP-001 — ADX Threshold

### Mục tiêu

Kiểm tra ảnh hưởng của `InpMinADX`.

### Giữ nguyên

* XAUUSD.PRO
* M1
* EMA20 / EMA50
* ADX Period 14
* SL 300
* TP 600
* Lot 0.01
* Break Even OFF
* Trailing OFF

### Test

```text
ADX Min = 20
ADX Min = 25  ← Baseline
ADX Min = 30
ADX Min = 35
```

### So sánh

* Net Profit
* Profit Factor
* Expected Payoff
* Max Drawdown
* Total Trades
* Win Rate

### PASS

Chưa PASS chỉ vì một configuration có Net Profit dương.

Candidate chỉ được giữ lại nếu đồng thời cho thấy cải thiện hợp lý ở:

* Profit Factor
* Expected Payoff
* Drawdown
* Trade sample

và cần tiếp tục validation trước khi xem là strategy improvement.

---

# 10. EXP-002 — Timeframe

Chỉ thực hiện sau EXP-001.

Test core strategy trên:

```text
M1  ← Baseline
M5
M15
```

Không thay EMA, ADX, SL/TP đồng thời với timeframe trong lần test đầu tiên.

Mục tiêu:

Xác định behavior của cùng một strategy khi giảm market noise và frequency.

Đây là hypothesis test, không giả định trước rằng timeframe lớn hơn sẽ tốt hơn.

---

# 11. EXP-003 — Position Management

Chỉ thực hiện sau khi:

1. Sửa timer.
2. Compile thành công.
3. Xác nhận Break Even / Trailing thực sự chạy.

Sau đó test riêng:

```text
A. BE OFF / Trailing OFF    ← Baseline
B. BE ON  / Trailing OFF
C. BE OFF / Trailing ON
D. BE ON  / Trailing ON
```

Không thay entry logic trong cùng experiment.

---

# 12. Research Rules

Mỗi experiment phải tuân thủ:

1. Có baseline.
2. Chỉ thay nhóm biến đang nghiên cứu.
3. Lưu MT5 report gốc.
4. Ghi chính xác inputs.
5. Không chọn kết quả chỉ vì Net Profit cao nhất.
6. Không gọi một configuration là profitable chỉ từ một backtest.
7. Không chuyển sang live trading chỉ vì một optimization PASS.
8. Candidate tốt phải tiếp tục được validation ngoài sample nghiên cứu.

---

# 13. Current Research Status

| ID       | Research              | Status                       |
| -------- | --------------------- | ---------------------------- |
| BASELINE | EMA20/50 + ADX14/25   | ✅ COMPLETED                  |
| EXP-001  | ADX Threshold         | ⏳ NEXT                       |
| EXP-002  | Timeframe             | NOT STARTED                  |
| EXP-003  | Break Even / Trailing | BLOCKED — timer fix required |

---

# 14. Current Conclusion

Baseline của EA-017:

**FAIL**

Nhưng baseline đang tương đối gần vùng break-even:

* Profit Factor = 0.95
* Average Win / Loss ≈ 1.98
* Win Rate = 32.51%

Vì vậy chưa cần thay toàn bộ strategy.

Bước nghiên cứu đầu tiên là:

**EXP-001 — kiểm tra ADX threshold trong khi giữ nguyên toàn bộ các biến còn lại.**

---

# Research Status

**BASELINE COMPLETE**

**NEXT: EXP-001 — ADX THRESHOLD**
