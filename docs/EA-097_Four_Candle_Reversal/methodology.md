# EA Research Methodology

## EA-097 — Four Candle Reversal

## 1. Baseline Principle

EA-097 được đánh giá trước tiên bằng một baseline cố định:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026.01.02 - 2026.03.31
Initial Deposit: $1,000
Lot Size: 0.01
SL: 300 points
TP: 600 points
```

Backtest sử dụng **100% real ticks**.

Baseline phải được giữ nguyên để mọi experiment sau đó có thể so sánh trực tiếp.

---

## 2. Controlled Experiment

Mỗi experiment chỉ thay đổi một nhóm biến.

Ví dụ:

```text
Baseline
   ↓
Change candle count
   ↓
Backtest
   ↓
Compare
   ↓
Accept / Reject
```

Không thay đổi đồng thời:

```text
Entry
+
SL
+
TP
+
Trailing
```

vì sẽ không xác định được yếu tố nào tạo ra thay đổi kết quả.

---

## 3. Primary Metrics

Các metric chính:

### Net Profit

Đo lợi nhuận tuyệt đối của strategy.

### Profit Factor

```text
Profit Factor = Gross Profit / Gross Loss
```

PF < 1 là tín hiệu baseline không có profitability trong mẫu test.

### Maximum Drawdown

Đánh giá mức suy giảm vốn lớn nhất.

### Expected Payoff

Đo lợi nhuận kỳ vọng trên mỗi trade.

### Trade Count

Dùng để đánh giá độ lớn của sample.

---

## 4. Secondary Metrics

Có thể theo dõi:

```text
Win Rate
Average Profit Trade
Average Loss Trade
Recovery Factor
Sharpe Ratio
Consecutive Wins
Consecutive Losses
Holding Time
Long Win Rate
Short Win Rate
```

Không sử dụng một metric đơn lẻ để quyết định production.

---

## 5. EA-097 Baseline Assessment

Kết quả baseline:

```text
Net Profit = -$487.18
Profit Factor = 0.91
Expected Payoff = -$0.10
Max Equity DD = 61.57%
Total Trades = 4,642
```

Kết luận:

```text
BASELINE = FAIL
```

Baseline không được dùng làm production configuration.

---

## 6. Parameter Robustness

Không tìm kiếm một parameter duy nhất tạo ra kết quả tốt nhất.

Thay vào đó kiểm tra vùng tham số:

```text
Candle Count
Confirmation Rule
SL
TP
Break Even
Trailing
```

Mục tiêu là tìm vùng hoạt động ổn định thay vì một điểm tối ưu duy nhất.

---

## 7. Out-of-Sample Testing

Sau khi xác định hypothesis từ In-Sample:

```text
In-Sample
    ↓
Research
    ↓
Parameter range
    ↓
Freeze configuration
    ↓
Out-of-Sample
```

OOS không được sử dụng để tiếp tục tối ưu.

---

## 8. Walk-Forward Testing

Sau OOS, sử dụng walk-forward để kiểm tra tính ổn định theo thời gian:

```text
Train
  ↓
Test
  ↓
Move Window
  ↓
Train
  ↓
Test
```

Một strategy chỉ được xem là robust khi kết quả không phụ thuộc vào một khoảng thời gian duy nhất.

---

## 9. Production Readiness

EA-097 hiện **chưa đạt production readiness**.

Các bước bắt buộc trước production:

```text
1. Improve / validate entry hypothesis
2. Controlled parameter research
3. Robustness test
4. Out-of-sample test
5. Walk-forward test
6. Risk validation
7. Final review
```

Không sử dụng kết quả baseline hiện tại để tăng risk hoặc tăng lot.

---

## 10. Research Record

```text
EA ID: EA-097
Strategy: Four Candle Reversal
Baseline ID: EA097-M1-BASELINE-001
Status: FAIL
Next Research Focus: Entry Confirmation
```
