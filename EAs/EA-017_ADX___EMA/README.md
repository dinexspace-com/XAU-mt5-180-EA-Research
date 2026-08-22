# EA-017 — ADX + EMA

Expert Advisor cho MetaTrader 5 sử dụng giao cắt **EMA nhanh / EMA chậm** kết hợp với **ADX và Directional Indicators (+DI / -DI)** để xác nhận xu hướng trước khi vào lệnh.

## Thông tin cơ bản

* **Platform:** MetaTrader 5
* **Language:** MQL5
* **Version:** 1.00
* **Strategy:** EMA Crossover + ADX Filter
* **Default Fast EMA:** 20
* **Default Slow EMA:** 50
* **Default ADX Period:** 14
* **Default Minimum ADX:** 25
* **Symbol:** Theo chart đang chạy (`_Symbol`)
* **Timeframe:** Theo chart đang chạy (`_Period`)

> Repository này nghiên cứu EA cho XAUUSD. Code hiện tại không hard-code XAUUSD, vì vậy khi sử dụng cần chạy EA trên chart XAUUSD hoặc chọn XAUUSD trong Strategy Tester.

---

## Strategy Logic

EA chỉ kiểm tra tín hiệu khi xuất hiện **nến mới**.

Tín hiệu được tính từ các nến đã đóng, không sử dụng giá trị indicator của nến đang chạy.

### BUY

Lệnh BUY được mở khi đồng thời thỏa mãn:

1. Fast EMA cắt lên Slow EMA:

   * EMA nhanh của nến trước `<=` EMA chậm.
   * EMA nhanh của nến vừa đóng `>` EMA chậm.

2. ADX đủ mạnh:

   * ADX của nến vừa đóng `>= InpMinADX`
   * **hoặc** ADX của nến trước đó `>= InpMinADX`.

3. Directional Indicator xác nhận hướng tăng:

   * `+DI > -DI`

### SELL

Lệnh SELL được mở khi đồng thời thỏa mãn:

1. Fast EMA cắt xuống Slow EMA:

   * EMA nhanh của nến trước `>=` EMA chậm.
   * EMA nhanh của nến vừa đóng `<` EMA chậm.

2. ADX đủ mạnh:

   * ADX của nến vừa đóng `>= InpMinADX`
   * **hoặc** ADX của nến trước đó `>= InpMinADX`.

3. Directional Indicator xác nhận hướng giảm:

   * `-DI > +DI`

---

## Trading Rules

EA sử dụng các quy tắc bổ sung sau:

* Chỉ xử lý tín hiệu khi có nến mới.
* Không vào lệnh nếu spread vượt quá giới hạn cho phép.
* Chỉ cho phép tối đa **1 position đang mở** cho cùng:

  * Symbol.
  * Magic Number.
* Lot hiện tại là **fixed lot**.
* Không có cơ chế risk-based position sizing trong phiên bản hiện tại.
* Không có tín hiệu đóng lệnh dựa trên EMA hoặc ADX.
* Position được bảo vệ bằng Stop Loss và Take Profit.

---

## Default Parameters

| Parameter         | Default | Description                              |
| ----------------- | ------: | ---------------------------------------- |
| `InpLotSize`      |    0.01 | Fixed lot size                           |
| `InpMagicNumber`  |  123456 | Magic Number của EA                      |
| `InpSlippage`     |      10 | Slippage tối đa, tính bằng points        |
| `InpStopLoss`     |     300 | Stop Loss, tính bằng points              |
| `InpTakeProfit`   |     600 | Take Profit, tính bằng points            |
| `InpMaxSpread`    |      30 | Spread tối đa cho phép, tính bằng points |
| `InpFastEMA`      |      20 | Fast EMA period                          |
| `InpSlowEMA`      |      50 | Slow EMA period                          |
| `InpADXPeriod`    |      14 | ADX period                               |
| `InpMinADX`       |    25.0 | ADX tối thiểu                            |
| `InpUseBreakEven` |    true | Bật/tắt Break Even                       |
| `InpBreakEvenPts` |     150 | Mức lợi nhuận kích hoạt Break Even       |
| `InpUseTrailing`  |    true | Bật/tắt Trailing Stop                    |
| `InpTrailingPts`  |     200 | Khoảng cách Trailing Stop                |

---

## Stop Loss / Take Profit

### BUY

* Stop Loss:
  `Entry Price - InpStopLoss × Point`
* Take Profit:
  `Entry Price + InpTakeProfit × Point`

### SELL

* Stop Loss:
  `Entry Price + InpStopLoss × Point`
* Take Profit:
  `Entry Price - InpTakeProfit × Point`

Với cấu hình mặc định:

* Stop Loss = 300 points
* Take Profit = 600 points

Khoảng cách TP/SL danh nghĩa tương ứng tỷ lệ **2:1** trước khi tính spread, commission và slippage.

> Giá trị thực tế của `point`, spread và khoảng cách giá trên XAUUSD phụ thuộc vào specification của broker.

---

## Break Even / Trailing Stop

Code hiện tại đã có hàm:

`ManageOpenPositions()`

và logic cho:

* Break Even.
* Trailing Stop.

Tuy nhiên, hàm này được gọi từ:

`OnTimer()`

trong khi phiên bản hiện tại **chưa khởi tạo timer bằng `EventSetTimer()` trong `OnInit()`**.

Do đó:

> **Break Even và Trailing Stop hiện chưa được xác nhận là hoạt động trong phiên bản 1.00 hiện tại.**

Cho đến khi timer được kích hoạt và kiểm thử, kết quả backtest nên được hiểu là chủ yếu dựa trên Stop Loss và Take Profit cố định.

---

## Spread Filter

EA không mở position mới khi:

`Current Spread > InpMaxSpread`

Default:

`InpMaxSpread = 30 points`

Spread được lấy trực tiếp từ:

`SYMBOL_SPREAD`

---

## Position Identification

EA chỉ đếm và quản lý position có:

* Cùng `_Symbol`.
* Cùng `InpMagicNumber`.

Magic Number mặc định:

`123456`

Điều này giúp phân biệt position của EA với các position khác trên tài khoản.

---

## Current Implementation Status

| Component                  | Status                                |
| -------------------------- | ------------------------------------- |
| EMA Fast / Slow            | Implemented                           |
| EMA Crossover Entry        | Implemented                           |
| ADX Filter                 | Implemented                           |
| +DI / -DI Confirmation     | Implemented                           |
| New Bar Filter             | Implemented                           |
| Spread Filter              | Implemented                           |
| Fixed Stop Loss            | Implemented                           |
| Fixed Take Profit          | Implemented                           |
| Fixed Lot                  | Implemented                           |
| Magic Number Filter        | Implemented                           |
| Maximum 1 Position         | Implemented                           |
| Break Even Logic           | Implemented but timer not initialized |
| Trailing Stop Logic        | Implemented but timer not initialized |
| Risk-based Position Sizing | Not implemented                       |
| Backtest Validation        | Pending                               |

---

## Known Limitations

1. Break Even và Trailing Stop chưa hoạt động đúng thiết kế cho đến khi timer được khởi tạo và kiểm thử.
2. Lot size đang cố định, chưa tính lot theo % risk.
3. Symbol không được hard-code thành XAUUSD.
4. Timeframe không cố định và phụ thuộc chart hoặc Strategy Tester.
5. Giá trị point và spread của XAUUSD có thể khác nhau giữa các broker.
6. Strategy chưa được xác nhận hiệu quả cho đến khi hoàn thành backtest.

---

## Files

```text
EA-017_ADX_EMA/
├── EA-017_ADX_EMA.mq5
└── README.md
```

---

## Validation

Trước khi đánh giá EA cần thực hiện tối thiểu:

1. Compile bằng MetaEditor.
2. Xác nhận không có compile error.
3. Backtest trên XAUUSD.
4. Lưu report và thông số test.
5. Kiểm tra trade list.
6. Kiểm tra lại Break Even / Trailing Stop sau khi sửa timer.
7. Đánh giá kết quả trước khi thay đổi hoặc tối ưu strategy.

---

## Disclaimer

EA này được phát triển cho mục đích **research, development và backtesting**.

Kết quả backtest trong quá khứ không đảm bảo hiệu suất giao dịch trong tương lai.
