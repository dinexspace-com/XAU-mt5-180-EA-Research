# EA-100 — Bollinger + RSI

## Strategy Overview

EA-100 kết hợp **Bollinger Bands** và **RSI** để tìm các vùng giá cực trị và thực hiện giao dịch hồi quy.

### BUY

Tín hiệu BUY khi nến Shift 1 thỏa mãn:

* Low chạm hoặc xuyên Lower Bollinger Band.
* RSI Shift 1 < `InpRSILower`.

Điều kiện:

```text
Low[1] <= LowerBand[1]
AND
RSI[1] < InpRSILower
```

### SELL

Tín hiệu SELL khi nến Shift 1 thỏa mãn:

* High chạm hoặc xuyên Upper Bollinger Band.
* RSI Shift 1 > `InpRSIUpper`.

Điều kiện:

```text
High[1] >= UpperBand[1]
AND
RSI[1] > InpRSIUpper
```

EA chỉ đánh giá tín hiệu khi xuất hiện nến mới.

---

## Indicators

### Bollinger Bands

* Period: `20`
* Deviation: `2.0`
* Applied Price: Close

### RSI

* Period: `14`
* Lower: `30`
* Upper: `70`
* Applied Price: Close

---

## Execution

| Parameter         |      Value |
| ----------------- | ---------: |
| Lot               |       0.01 |
| Stop Loss         | 300 points |
| Take Profit       | 600 points |
| Magic Number      |     123100 |
| Slippage          |  10 points |
| Max Spread        |  30 points |
| Timeframe         |         M1 |
| Break Even        |         ON |
| BE Trigger        | 150 points |
| BE Offset         |          0 |
| Trailing Stop     |         ON |
| Trailing Start    | 200 points |
| Trailing Distance | 100 points |
| Trailing Step     |  10 points |

---

## Position Management

EA sử dụng:

* Initial Stop Loss.
* Initial Take Profit.
* Break Even.
* Trailing Stop.
* Kiểm tra spread trước khi vào lệnh.
* Kiểm tra margin trước khi vào lệnh.
* Kiểm tra broker stop/freeze level.
* Không tăng lot tự động nếu lot không hợp lệ.
* Giới hạn position/order theo Magic Number.

Stop Loss và Take Profit được gửi cùng market order.

---

## Baseline Identification

```text
EA100-M1-BASELINE-001
```

### Baseline Status

```text
PASS FOR FURTHER RESEARCH
```

Kết quả baseline cho thấy chiến lược có lợi nhuận dương và các chỉ số hiệu suất tích cực.

Tuy nhiên, kết quả này mới là một historical baseline và **chưa đủ để kết luận EA đã sẵn sàng giao dịch live**.

---

## Main Research Question

> Liệu việc kết hợp Bollinger Band extreme với RSI overbought/oversold có tạo ra một edge ổn định trên XAUUSD M1 hay không?

Các nghiên cứu tiếp theo phải được thực hiện có kiểm soát và giữ nguyên baseline để có thể so sánh.

---

## Important Scope

EA-100 hiện là **research baseline**.

Không được xem kết quả baseline là bằng chứng đủ để triển khai live trading.

Trước khi production cần thực hiện:

1. Parameter evaluation.
2. Out-of-sample test.
3. Robustness test.
4. Walk-forward validation.
5. Forward demo test.
6. Chỉ xem xét live sau khi vượt qua toàn bộ validation pipeline.
