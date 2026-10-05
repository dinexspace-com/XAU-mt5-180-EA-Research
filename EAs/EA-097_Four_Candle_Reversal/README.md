# EA-097 — Four Candle Reversal

## 1. Overview

EA-097 — Four Candle Reversal là Expert Advisor giao dịch trên **XAUUSD.PRO**, timeframe mặc định **M1**.

Chiến lược sử dụng cấu trúc gồm:

* 4 nến trước đó cùng hướng.
* Nến xác nhận hiện tại đảo chiều.
* Nến xác nhận phải tiếp tục đóng cửa theo hướng đảo chiều so với nến tham chiếu.
* Khi điều kiện thỏa mãn, EA mở lệnh theo hướng đảo chiều.

EA sử dụng market order với Stop Loss, Take Profit, Break Even và Trailing Stop.

---

## 2. Entry Logic

### BUY

Điều kiện:

1. Các nến từ `bars[2]` đến `bars[5]` đều là nến giảm.
2. Nến tín hiệu `bars[1]` là nến tăng.
3. `bars[1].close > bars[2].close`.

Logic:

```text
4 previous candles = bearish
+
confirmation candle = bullish
+
confirmation close > previous candle close
=
BUY
```

### SELL

Điều kiện:

1. Các nến từ `bars[2]` đến `bars[5]` đều là nến tăng.
2. Nến tín hiệu `bars[1]` là nến giảm.
3. `bars[1].close < bars[2].close`.

Logic:

```text
4 previous candles = bullish
+
confirmation candle = bearish
+
confirmation close < previous candle close
=
SELL
```

---

## 3. Execution Parameters

| Parameter    |    Default |
| ------------ | ---------: |
| Lot Size     |       0.01 |
| Stop Loss    | 300 points |
| Take Profit  | 600 points |
| Magic Number |     123097 |
| Slippage     |         10 |
| Max Spread   |  30 points |
| Timeframe    |         M1 |

---

## 4. Break Even

Break Even được bật mặc định.

| Parameter      |      Value |
| -------------- | ---------: |
| Use Break Even |       true |
| Trigger        | 150 points |
| Offset         |   0 points |

Khi lợi nhuận đạt trigger, EA có thể đưa Stop Loss về vùng Break Even.

---

## 5. Trailing Stop

Trailing Stop được bật mặc định.

| Parameter         |      Value |
| ----------------- | ---------: |
| Use Trailing Stop |       true |
| Start             | 200 points |
| Distance          | 100 points |
| Step              |  10 points |

Trailing Stop chỉ được cập nhật khi Stop Loss mới cải thiện so với Stop Loss hiện tại.

---

## 6. Position Protection

EA có các lớp kiểm soát trước khi vào lệnh:

* Kiểm tra terminal và trading permission.
* Kiểm tra spread.
* Kiểm tra symbol trade mode.
* Kiểm tra market order / SL / TP support.
* Kiểm tra broker stop distance.
* Kiểm tra margin.
* Kiểm tra position/order hiện tại.
* Sử dụng Magic Number `123097`.
* Không âm thầm tăng lot khi lot không hợp lệ.

---

## 7. Processing Model

EA đánh giá tín hiệu khi xuất hiện **bar mới** trên timeframe được cấu hình.

EA sử dụng 6 bars để đảm bảo có đủ dữ liệu cho:

```text
bars[1] → confirmation candle
bars[2] → candle immediately before confirmation
bars[3]
bars[4]
bars[5] → oldest candle in the four-candle sequence
```

Position management được thực hiện trên từng tick, độc lập với điều kiện spread vào lệnh.

---

## 8. Research Identifier

```text
EA097-M1-BASELINE-001
```

---

## 9. Current Status

**FAIL — Baseline không đạt yêu cầu nghiên cứu.**

Kết quả baseline cho thấy Profit Factor dưới 1 và drawdown rất cao. EA cần được nghiên cứu tiếp trước khi xem xét các bước tối ưu hóa hoặc production deployment.
