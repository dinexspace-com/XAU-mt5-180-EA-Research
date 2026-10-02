# EA-094_ATR_Stretch_1_5

## 1. Overview

`EA-094_ATR_Stretch_1_5` là Expert Advisor cho XAUUSD sử dụng EMA và ATR để xác định trạng thái giá bị kéo giãn khỏi vùng trung bình, sau đó tìm tín hiệu hồi trở lại về phía EMA.

EA chạy trên timeframe được cấu hình mặc định là M1.

Strategy sử dụng:

* EMA 20 làm đường trung bình.
* ATR 14 để đo biến động.
* ATR Multiplier = 1.5.
* Tín hiệu được xác nhận bằng nến đã hoàn thành.
* Fixed Stop Loss.
* Fixed Take Profit.
* Break Even.
* Trailing Stop.

---

## 2. Default Configuration

| Parameter          |    Default |
| ------------------ | ---------: |
| Lot Size           |       0.01 |
| Stop Loss          | 300 points |
| Take Profit        | 600 points |
| Magic Number       |     123094 |
| Slippage           |         10 |
| Max Spread         |  30 points |
| Timeframe          |         M1 |
| Break Even         |    Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset  |          0 |
| Trailing Stop      |    Enabled |
| Trailing Start     | 200 points |
| Trailing Distance  | 100 points |
| Trailing Step      |  10 points |
| EMA Period         |         20 |
| ATR Period         |         14 |
| ATR Multiplier     |        1.5 |

---

## 3. Indicator Model

EA tạo hai indicator handle:

* EMA: `iMA(... MODE_EMA, PRICE_CLOSE)`
* ATR: `iATR(...)`

ATR được sử dụng để tạo vùng stretch quanh EMA:

```text
Upper Stretch = EMA + ATR × 1.5
Lower Stretch = EMA - ATR × 1.5
```

EA không vào lệnh chỉ vì giá chạm vùng stretch. Tín hiệu còn yêu cầu nến tiếp theo thể hiện chuyển động hồi về EMA.

---

## 4. Buy Signal

Buy signal được tạo khi đồng thời thỏa mãn:

1. Close của nến thứ hai nằm dưới:

```text
EMA[2] - ATR[2] × ATRMultiplier
```

2. Nến đã hoàn thành gần nhất là nến tăng:

```text
Close[1] > Open[1]
```

3. Close của nến gần nhất cao hơn close của nến trước:

```text
Close[1] > Close[2]
```

4. Close của nến gần nhất vẫn nằm dưới EMA:

```text
Close[1] < EMA[1]
```

Khi toàn bộ điều kiện đúng, EA tạo hướng giao dịch Buy.

---

## 5. Sell Signal

Sell signal được tạo khi đồng thời thỏa mãn:

1. Close của nến thứ hai nằm trên:

```text
EMA[2] + ATR[2] × ATRMultiplier
```

2. Nến đã hoàn thành gần nhất là nến giảm:

```text
Close[1] < Open[1]
```

3. Close của nến gần nhất thấp hơn close của nến trước:

```text
Close[1] < Close[2]
```

4. Close của nến gần nhất vẫn nằm trên EMA:

```text
Close[1] > EMA[1]
```

Khi toàn bộ điều kiện đúng, EA tạo hướng giao dịch Sell.

---

## 6. Execution Logic

EA chỉ đánh giá tín hiệu khi xuất hiện candle mới.

Các dữ liệu được sử dụng cho signal lấy từ các candle đã hoàn thành.

Khi EA được attach, `last_bar` được khởi tạo bằng candle hiện tại nhằm tránh việc sử dụng một signal cũ ngay khi EA bắt đầu chạy.

Trước khi mở lệnh, EA kiểm tra:

* Terminal có kết nối.
* Trading được cho phép.
* Expert trading được cho phép.
* Spread không vượt quá `InpMaxSpread`.
* Symbol cho phép loại giao dịch tương ứng.
* Market order được hỗ trợ.
* SL/TP được hỗ trợ.
* Khoảng cách SL/TP phù hợp với broker.
* Margin khả dụng.
* Lot size phù hợp với symbol.
* Không tồn tại position/order bị chặn bởi logic `EntryBlocked()`.

---

## 7. Position Restriction

EA giới hạn tối đa một position/order liên quan đến Magic Number `123094`.

Trên tài khoản netting, EA cũng chặn việc mở position mới nếu symbol đã có exposure khác.

Mục đích là tránh việc EA tự merge hoặc can thiệp vào exposure của EA/position khác trên cùng symbol.

---

## 8. Stop Loss / Take Profit

Mỗi market order được gửi cùng lúc với protective SL và TP.

Default:

```text
Stop Loss  = 300 points
Take Profit = 600 points
```

Giá SL/TP được làm tròn theo tick size của symbol.

---

## 9. Break Even

Break Even được bật mặc định.

Khi position đạt:

```text
+150 points
```

EA có thể đưa Stop Loss về mức break-even.

Default offset:

```text
0 points
```

EA kiểm tra stop distance và freeze level của broker trước khi sửa SL.

---

## 10. Trailing Stop

Trailing Stop được bật mặc định.

Bắt đầu trailing khi position đạt:

```text
+200 points
```

Khoảng cách trailing:

```text
100 points
```

Bước dịch chuyển tối thiểu:

```text
10 points
```

EA chỉ sửa SL nếu mức SL mới thực sự cải thiện SL hiện tại và đáp ứng các giới hạn giao dịch của symbol.

---

## 11. Order Protection

EA sử dụng:

* Maximum spread filter.
* Broker stop-distance validation.
* Freeze-level validation.
* Margin validation.
* Symbol trade-mode validation.
* Lot-size validation.
* Tick-size rounding.
* Market/SL/TP capability checks.

SL và TP được gửi ngay trong market-order request.

---

## 12. Implementation Status

### Implemented

* EMA indicator.
* ATR indicator.
* ATR stretch calculation.
* Buy signal.
* Sell signal.
* M1 default execution.
* Fixed SL/TP.
* Break Even.
* Trailing Stop.
* Spread filter.
* Margin check.
* Position/order restriction.
* Broker stop/freeze validation.
* Magic Number `123094`.

### Current Research Status

EA đã có baseline implementation và baseline Strategy Tester report.

Việc xác định robustness, out-of-sample performance hoặc khả năng duy trì kết quả trong tương lai chưa được thực hiện trong tài liệu hiện tại.
