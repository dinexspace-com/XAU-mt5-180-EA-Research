# EA-024 — Donchian Trend

Expert Advisor (EA) cho MetaTrader 5, nghiên cứu chiến lược **trend-following / breakout** dựa trên ý tưởng Donchian Channel.

> **Status:** Research / Experimental
> EA này được lưu phục vụ nghiên cứu và backtest. Chưa được xác nhận phù hợp cho live trading.

---

## 1. Tổng quan

`EA-024_Donchian_Trend` được xây dựng để thử nghiệm một hệ thống giao dịch theo xu hướng dựa trên breakout.

Ý tưởng chiến lược:

* BUY khi giá đóng cửa vượt vùng giá cao của Donchian.
* SELL khi giá đóng cửa phá xuống vùng giá thấp của Donchian.
* Có Stop Loss và Take Profit cố định.
* Có Break Even.
* Có Trailing Stop.
* Có bộ lọc spread.
* Giới hạn số position của EA theo `Magic Number`.

EA chỉ kiểm tra tín hiệu khi xuất hiện **nến mới**.

---

## 2. File

```text
EA-024_Donchian_Trend/
├── EA-024_Donchian_Trend.mq5
└── README.md
```

### `EA-024_Donchian_Trend.mq5`

Source code MQL5 của Expert Advisor.

---

## 3. Logic chiến lược

### Timeframe

EA sử dụng timeframe hiện tại của chart:

```text
PERIOD_CURRENT
```

Do đó timeframe thực tế phụ thuộc vào chart hoặc cấu hình Strategy Tester nơi EA được chạy.

---

## 4. Điều kiện BUY

Theo implementation hiện tại:

```mql5
double donchianHigh = iHigh(
    _Symbol,
    PERIOD_CURRENT,
    InpDonchianPeriod
);

double lastClose = iClose(
    _Symbol,
    PERIOD_CURRENT,
    1
);

if(lastClose > donchianHigh)
{
    OpenBuy();
}
```

EA mở BUY khi:

```text
Close của nến vừa đóng
>
High của nến tại shift = InpDonchianPeriod
```

Lệnh BUY được mở tại giá Ask.

Stop Loss:

```text
Entry Price - InpStopLoss × Point
```

Take Profit:

```text
Entry Price + InpTakeProfit × Point
```

---

## 5. Điều kiện SELL

Theo implementation hiện tại:

```mql5
double donchianLow = iLow(
    _Symbol,
    PERIOD_CURRENT,
    InpDonchianPeriod
);

if(lastClose < donchianLow)
{
    OpenSell();
}
```

EA mở SELL khi:

```text
Close của nến vừa đóng
<
Low của nến tại shift = InpDonchianPeriod
```

Lệnh SELL được mở tại giá Bid.

Stop Loss:

```text
Entry Price + InpStopLoss × Point
```

Take Profit:

```text
Entry Price - InpTakeProfit × Point
```

---

## 6. Input Parameters

### Order Settings

| Parameter        |  Default | Mô tả                        |
| ---------------- | -------: | ---------------------------- |
| `InpLotSize`     |   `0.01` | Khối lượng giao dịch cố định |
| `InpStopLoss`    |    `300` | Stop Loss, tính theo point   |
| `InpTakeProfit`  |    `600` | Take Profit, tính theo point |
| `InpMagicNumber` | `123456` | Magic Number của EA          |
| `InpSlippage`    |     `10` | Deviation/slippage tối đa    |

### Risk Management

| Parameter             | Default | Mô tả                              |
| --------------------- | ------: | ---------------------------------- |
| `InpUseBreakEven`     |  `true` | Bật/tắt Break Even                 |
| `InpBreakEvenTrigger` |   `150` | Mức profit để kích hoạt Break Even |
| `InpBreakEvenLevel`   |     `0` | Vị trí SL mới so với entry         |

Với cấu hình mặc định:

```text
Profit >= 150 points
→ SL dự kiến được đưa về Entry Price
```

---

### Trailing Stop

| Parameter          | Default | Mô tả                                          |
| ------------------ | ------: | ---------------------------------------------- |
| `InpUseTrailing`   |  `true` | Bật/tắt Trailing Stop                          |
| `InpTrailingStart` |   `200` | Mức profit bắt đầu trailing                    |
| `InpTrailingStep`  |    `10` | Khoảng cải thiện SL tối thiểu trước khi update |

Với BUY:

```text
New SL = Current Price - InpTrailingStart × Point
```

Với SELL:

```text
New SL = Current Price + InpTrailingStart × Point
```

---

### Filter Settings

| Parameter           | Default | Mô tả                                             |
| ------------------- | ------: | ------------------------------------------------- |
| `InpMaxSpread`      |    `30` | Spread tối đa cho phép, theo point                |
| `InpDonchianPeriod` |    `20` | Period được sử dụng trong logic Donchian hiện tại |
| `InpMaxPositions`   |     `1` | Số position tối đa của EA trên symbol             |

---

## 7. Spread Filter

Trước khi tìm tín hiệu, EA tính:

```text
Spread = (Ask - Bid) / Point
```

Nếu:

```text
Spread > InpMaxSpread
```

EA không mở giao dịch mới.

Default:

```text
Max Spread = 30 points
```

---

## 8. Position Filter

EA chỉ đếm những position thỏa cả hai điều kiện:

```text
POSITION_SYMBOL == current symbol
```

và:

```text
POSITION_MAGIC == InpMagicNumber
```

Mục đích là tách các position do EA này quản lý khỏi position của EA khác hoặc giao dịch khác.

Default:

```text
InpMaxPositions = 1
```

---

## 9. New-Bar Execution

EA sử dụng:

```mql5
IsNewBar()
```

để chỉ thực thi phần logic chính khi xuất hiện nến mới.

Điều này giúp tránh việc liên tục tạo tín hiệu trên mỗi tick.

---

# 10. Important Implementation Notes

## 10.1 Donchian Channel hiện chưa được tính theo Donchian chuẩn

Đây là điểm quan trọng nhất của version hiện tại.

Code đang sử dụng:

```mql5
iHigh(_Symbol, PERIOD_CURRENT, InpDonchianPeriod);
iLow(_Symbol, PERIOD_CURRENT, InpDonchianPeriod);
```

Trong MQL5, tham số cuối của `iHigh()` và `iLow()` là **bar shift**, không phải số lượng nến dùng để tìm Highest High / Lowest Low.

Do đó với:

```text
InpDonchianPeriod = 20
```

code hiện tại lấy:

```text
High của nến shift 20
Low của nến shift 20
```

chứ chưa tính:

```text
Highest High của 20 nến
Lowest Low của 20 nến
```

Vì vậy EA hiện tại nên được xem là **prototype dựa trên ý tưởng Donchian**, chưa phải implementation hoàn chỉnh của Donchian Channel breakout.

Cần sửa logic này trước khi đánh giá hiệu quả thực sự của chiến lược Donchian.

---

## 10.2 Break Even và Trailing Stop hiện bị chặn khi đủ Max Positions

Trong `OnTick()` hiện tại:

```mql5
if(CountPositions() >= InpMaxPositions)
    return;
```

được thực thi **trước**:

```mql5
ManageBreakEven();
ManageTrailingStop();
```

Với cấu hình mặc định:

```text
InpMaxPositions = 1
```

khi EA đang có 1 position, hàm `OnTick()` sẽ `return` trước khi tới phần quản lý position.

Do đó Break Even và Trailing Stop có thể không được thực thi như mục tiêu thiết kế.

Phần quản lý position cần được tách khỏi điều kiện ngăn mở position mới.

---

## 10.3 Position management chỉ được gọi tại thời điểm new bar

Do đầu `OnTick()` có:

```mql5
if(!IsNewBar())
    return;
```

nên ngay cả sau khi sửa vấn đề trên, Break Even và Trailing Stop theo cấu trúc hiện tại cũng chỉ được kiểm tra tại thời điểm xuất hiện nến mới, không phải trên mọi tick.

Đây là hành vi cần được xác định rõ khi phát triển version tiếp theo.

---

## 11. Input Validation

Khi khởi tạo, EA kiểm tra:

```text
InpLotSize > 0
InpDonchianPeriod > 0
InpStopLoss > 0
InpTakeProfit > 0
```

Nếu không đạt điều kiện, EA trả về:

```text
INIT_PARAMETERS_INCORRECT
```

---

## 12. Current Development Status

| Thành phần              | Trạng thái                          |
| ----------------------- | ----------------------------------- |
| MQL5 source             | Implemented                         |
| BUY / SELL logic        | Implemented                         |
| Fixed SL / TP           | Implemented                         |
| Spread filter           | Implemented                         |
| Magic Number filter     | Implemented                         |
| Position limit          | Implemented                         |
| Break Even code         | Implemented, cần sửa execution flow |
| Trailing Stop code      | Implemented, cần sửa execution flow |
| Donchian Channel chuẩn  | Chưa hoàn thiện                     |
| Backtest validation     | Chưa ghi nhận tại README này        |
| Live trading validation | Chưa thực hiện                      |

---

## 13. Research Scope

Repository này được sử dụng để nghiên cứu:

* Donchian breakout.
* Trend-following.
* Entry logic.
* Stop Loss / Take Profit.
* Break Even.
* Trailing Stop.
* Spread filtering.
* Ảnh hưởng của timeframe.
* Ảnh hưởng của Donchian period.
* Backtest trên XAUUSD / MT5.

Kết quả backtest sẽ được lưu riêng tại:

```text
Backtest/
└── EA-024_Donchian_Trend/
```

để source code và kết quả thực nghiệm không bị trộn lẫn.

---

## 14. Disclaimer

EA này được phát triển cho mục đích **research, development và backtesting**.

Không có kết quả lợi nhuận, độ ổn định hoặc khả năng hoạt động live nào được khẳng định chỉ dựa trên source code hiện tại.

Mọi kết luận về hiệu quả chiến lược phải dựa trên backtest, kiểm tra dữ liệu và validation riêng.
