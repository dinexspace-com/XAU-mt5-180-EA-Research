# EA-069 — Breakout ADX Filter

Expert Advisor (EA) cho MetaTrader 5 sử dụng chiến lược **Breakout** kết hợp bộ lọc **ADX (Average Directional Index)** để chỉ giao dịch khi thị trường có đủ độ mạnh xu hướng.

## Strategy Overview

EA xác định vùng giá cao nhất và thấp nhất của một số lượng nến trước đó.

Tín hiệu giao dịch chỉ được xét khi một nến đã đóng phá ra khỏi vùng này:

* **BUY:** Giá đóng cửa vượt lên trên mức cao nhất của vùng breakout.
* **SELL:** Giá đóng cửa xuống dưới mức thấp nhất của vùng breakout.
* **ADX Filter:** Chỉ cho phép tín hiệu khi ADX lớn hơn ngưỡng được cấu hình.

Logic tổng quát:

```text
Breakout Up + ADX > Threshold
        ↓
       BUY

Breakout Down + ADX > Threshold
        ↓
       SELL
```

EA đánh giá tín hiệu trên **nến đã đóng**, không sử dụng nến hiện tại để xác nhận breakout.

---

## Entry Logic

### BUY

EA tạo tín hiệu BUY khi:

```text
Close[1] > Highest High của N nến trước + Breakout Buffer
AND
ADX[1] > ADX Threshold
```

### SELL

EA tạo tín hiệu SELL khi:

```text
Close[1] < Lowest Low của N nến trước - Breakout Buffer
AND
ADX[1] > ADX Threshold
```

Mặc định:

```text
Breakout Lookback = 20
ADX Period        = 14
ADX Threshold     = 25
Timeframe         = M1
```

EA kiểm tra tín hiệu khi xuất hiện **nến mới**.

---

## Default Parameters

| Parameter             | Default | Description                        |
| --------------------- | ------: | ---------------------------------- |
| `InpLotSize`          |    0.01 | Khối lượng giao dịch               |
| `InpStopLoss`         |     300 | Stop Loss, tính theo point         |
| `InpTakeProfit`       |     600 | Take Profit, tính theo point       |
| `InpMagicNumber`      |  123069 | Magic Number của EA                |
| `InpSlippage`         |      10 | Độ lệch giá tối đa                 |
| `InpMaxSpread`        |      30 | Spread tối đa cho phép mở lệnh     |
| `InpTimeframe`        |      M1 | Timeframe dùng tính tín hiệu       |
| `InpBreakoutLookback` |      20 | Số nến dùng xác định vùng breakout |
| `InpBreakoutBuffer`   |       0 | Khoảng đệm breakout                |
| `InpADXPeriod`        |      14 | Chu kỳ ADX                         |
| `InpADXThreshold`     |    25.0 | Ngưỡng ADX tối thiểu               |

---

## Break Even

Break Even được bật mặc định.

| Parameter             | Default |
| --------------------- | ------: |
| `InpUseBreakEven`     |    true |
| `InpBreakEvenTrigger` |     150 |
| `InpBreakEvenOffset`  |       0 |

Khi lợi nhuận đạt **150 points**, EA có thể di chuyển Stop Loss về mức hòa vốn.

`InpBreakEvenOffset` cho phép đặt Stop Loss lệch khỏi giá vào lệnh một số point theo hướng có lợi nhuận.

---

## Trailing Stop

Trailing Stop được bật mặc định.

| Parameter             | Default |
| --------------------- | ------: |
| `InpUseTrailingStop`  |    true |
| `InpTrailingStart`    |     200 |
| `InpTrailingDistance` |     100 |
| `InpTrailingStep`     |      10 |

Trailing Stop bắt đầu hoạt động khi vị thế đạt ít nhất **200 points lợi nhuận**.

Khoảng cách trailing mặc định là **100 points** và Stop Loss chỉ được cập nhật khi mức mới cải thiện ít nhất theo `TrailingStep`.

---

## Position Control

EA giới hạn việc mở lệnh để tránh chồng vị thế.

Với cùng `Magic Number`, EA chỉ cho phép tối đa một position/order đang tồn tại trên tài khoản.

Trên tài khoản **netting**, EA cũng tránh mở lệnh nếu symbol hiện tại đã có exposure nhằm tránh trộn vị thế với EA khác.

---

## Execution Protection

Trước khi mở lệnh, EA kiểm tra:

* Terminal đang kết nối.
* Algo Trading được cho phép.
* Tài khoản cho phép Expert Advisor giao dịch.
* Spread không vượt `InpMaxSpread`.
* Symbol cho phép Market Order.
* Hướng BUY/SELL được broker cho phép.
* Broker hỗ trợ SL và TP.
* Khoảng cách SL/TP đáp ứng giới hạn stop level của broker.
* Free Margin đủ để mở khối lượng yêu cầu.
* Lot size hợp lệ theo minimum, maximum và volume step của symbol.

EA **không tự động tăng lot size** nếu lot được cấu hình không hợp lệ.

Stop Loss và Take Profit được gửi cùng market-order request.

---

## Signal Timing

EA không giao dịch ngay trên tín hiệu cũ khi vừa được gắn vào chart.

Khi khởi tạo, EA ghi nhận nến hiện tại và bắt đầu đánh giá từ nến tiếp theo.

Breakout và ADX được đọc từ **nến đã đóng (`shift = 1`)**.

---

## Risk Management

Phiên bản hiện tại sử dụng **fixed lot size**.

EA không có cơ chế tự động tính lot theo:

* % Account Balance
* % Account Equity
* Risk per Trade

Do đó, việc lựa chọn `InpLotSize`, Stop Loss và mức vốn phù hợp phải được kiểm tra bằng backtest và đánh giá rủi ro riêng trước khi sử dụng.

---

## Files

```text
EA-069_Breakout_ADX_Filter/
├── EA-069_Breakout_ADX_Filter.mq5
└── README.md
```

---

## Platform

```text
Platform : MetaTrader 5
Language : MQL5
Type     : Expert Advisor
Strategy : Breakout + ADX Filter
Version  : 1.00
```

---

## Important

Kết quả backtest hoặc hiệu suất trong quá khứ không đảm bảo kết quả giao dịch trong tương lai.

Các tham số mặc định trong source code là cấu hình của EA, không tự động đồng nghĩa với cấu hình tối ưu cho mọi broker, symbol hoặc điều kiện thị trường.
