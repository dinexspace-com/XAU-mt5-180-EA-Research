# EA-018_DI_Trend

## 1. Tổng quan

**EA ID:** EA-018
**Tên:** DI Trend
**Platform:** MetaTrader 5
**Ngôn ngữ:** MQL5
**Source:** `EA-018_DI_Trend.mq5`
**Version hiện tại:** `1.00`

EA-018_DI_Trend là Expert Advisor giao dịch theo xu hướng, sử dụng sự tương quan giữa **+DI / -DI của DMI/ADX** kết hợp với **độ dốc EMA** để xác định hướng giao dịch.

EA chỉ xem xét mở lệnh tại thời điểm xuất hiện **nến mới** và sử dụng dữ liệu của các nến đã đóng để tạo tín hiệu.

---

## 2. Ý tưởng chiến lược

Chiến lược dựa trên hai yếu tố chính:

1. **DMI Direction**

   * `+DI > -DI` → thiên hướng tăng.
   * `-DI > +DI` → thiên hướng giảm.

2. **EMA Trend**

   * EMA tăng → xác nhận xu hướng tăng.
   * EMA giảm → xác nhận xu hướng giảm.

EA chỉ giao dịch khi DMI và EMA cùng xác nhận một hướng.

> Lưu ý: logic xác định slope EMA trong source hiện tại cần được xác minh bằng compile/test/backtest để đảm bảo thứ tự dữ liệu `CopyBuffer()` đúng với ý đồ chiến lược.

---

## 3. Indicator sử dụng

### EMA

Mặc định:

```text
Period: 50
Method: EMA
Applied Price: Close
Timeframe: Current chart timeframe
```

Input:

```text
InpEmaPeriod = 50
```

### DMI / ADX

EA sử dụng indicator `iADX()` của MT5.

Mặc định:

```text
ADX/DMI Period: 14
Timeframe: Current chart timeframe
```

Input:

```text
InpAdxPeriod = 14
```

Các buffer được sử dụng:

```text
Buffer 1 = +DI
Buffer 2 = -DI
```

Giá trị ADX chính không được sử dụng làm threshold lọc xu hướng trong phiên bản hiện tại.

---

## 4. Logic BUY

EA xem xét BUY khi:

```text
+DI > -DI
```

và EMA được xác định đang theo hướng tăng.

Theo ý đồ chiến lược:

```text
EMA[nến vừa đóng] > EMA[nến trước đó]
```

Khi cả hai điều kiện đồng thời thỏa mãn:

```text
Signal = BUY
```

EA sau đó mở lệnh BUY nếu:

* chưa đạt giới hạn số position;
* spread không vượt mức cho phép;
* tín hiệu xuất hiện tại nến mới.

---

## 5. Logic SELL

EA xem xét SELL khi:

```text
-DI > +DI
```

và EMA được xác định đang theo hướng giảm.

Theo ý đồ chiến lược:

```text
EMA[nến vừa đóng] < EMA[nến trước đó]
```

Khi cả hai điều kiện đồng thời thỏa mãn:

```text
Signal = SELL
```

EA sau đó mở lệnh SELL nếu:

* chưa đạt giới hạn số position;
* spread không vượt mức cho phép;
* tín hiệu xuất hiện tại nến mới.

---

## 6. Thời điểm kiểm tra tín hiệu

EA không kiểm tra entry liên tục trên từng tick.

Entry chỉ được kiểm tra khi phát hiện:

```text
New Bar
```

Trình tự xử lý trong `OnTick()`:

```text
1. ManageOpenPositions()
2. Kiểm tra số position đang mở
3. Kiểm tra New Bar
4. Kiểm tra Spread
5. Tính Trading Signal
6. BUY / SELL nếu có tín hiệu
```

Việc quản lý position đang mở vẫn được thực hiện trên từng tick.

---

## 7. Stop Loss và Take Profit

Mặc định:

```text
Stop Loss  = 300 points
Take Profit = 600 points
```

Inputs:

```text
InpStopLoss = 300
InpTakeProfit = 600
```

### BUY

```text
SL = Ask - StopLoss × Point
TP = Ask + TakeProfit × Point
```

### SELL

```text
SL = Bid + StopLoss × Point
TP = Bid - TakeProfit × Point
```

Các thông số trên được tính theo **MT5 points**, không phải trực tiếp theo USD hoặc pip.

---

## 8. Position Size

Phiên bản hiện tại sử dụng Fixed Lot.

Mặc định:

```text
InpLotSize = 0.01
```

EA hiện chưa có:

* Risk % theo Equity;
* Risk % theo Balance;
* Auto lot theo khoảng cách Stop Loss.

---

## 9. Break Even

Break Even mặc định được bật:

```text
InpUseBreakEven = true
```

Điểm kích hoạt:

```text
InpBreakEvenStartPoints = 150
```

Khi position đạt lợi nhuận ít nhất:

```text
150 points
```

EA cố gắng chuyển Stop Loss về:

```text
Entry Price
```

### BUY

Nếu:

```text
Current SL < Entry Price
```

thì:

```text
SL → Entry Price
```

### SELL

Nếu:

```text
Current SL > Entry Price
```

hoặc chưa có SL:

```text
SL → Entry Price
```

Phiên bản hiện tại không cộng thêm spread, commission hoặc Break-Even Offset.

---

## 10. Trailing Stop

Trailing Stop được khai báo:

```text
InpUseTrailingStop = true
InpTrailingStartPoints = 200
InpTrailingDistancePoints = 0
```

Trailing bắt đầu được xem xét khi lợi nhuận đạt:

```text
200 points
```

Nếu cấu hình:

```text
InpTrailingDistancePoints > 0
```

EA sử dụng khoảng cách cố định này để trailing SL.

### BUY

```text
New SL = Current Price - Trailing Distance
```

SL chỉ được phép di chuyển lên.

### SELL

```text
New SL = Current Price + Trailing Distance
```

SL chỉ được phép di chuyển xuống.

### Trạng thái hiện tại

Mặc định:

```text
InpTrailingDistancePoints = 0
```

Trong source code hiện tại, khi giá trị này bằng `0`, hàm Trailing Stop sẽ thoát mà không thay đổi Stop Loss.

Do đó mặc dù:

```text
InpUseTrailingStop = true
```

Trailing Stop **không hoạt động với bộ Input mặc định hiện tại**.

Comment trong source nói `0 = tự động dùng 50% khoảng cách hiện tại`, nhưng chức năng tự động 50% chưa được implement.

---

## 11. Spread Filter

EA không mở position mới nếu spread vượt:

```text
InpMaxSpreadPoints = 30
```

Spread được tính:

```text
(Ask - Bid) / Point
```

Nếu:

```text
Current Spread > 30 points
```

EA bỏ qua tín hiệu tại nến đó.

---

## 12. Giới hạn Position

Mặc định:

```text
InpMaxOpenPositions = 1
```

EA chỉ đếm các position đáp ứng đồng thời:

```text
POSITION_MAGIC == InpMagicNumber
POSITION_SYMBOL == Current Symbol
```

Do đó các lệnh thủ công hoặc EA khác có Magic Number khác không được tính vào giới hạn này.

---

## 13. Magic Number

Magic Number mặc định:

```text
InpMagicNumber = 2024001
```

Magic Number được sử dụng để nhận diện các position thuộc EA.

---

## 14. Slippage

Mặc định:

```text
InpSlippage = 10 points
```

EA sử dụng:

```text
trade.SetDeviationInPoints(InpSlippage)
```

---

## 15. Input Parameters

| Input                       | Default | Chức năng                          |
| --------------------------- | ------: | ---------------------------------- |
| `InpLotSize`                |    0.01 | Fixed lot                          |
| `InpMagicNumber`            | 2024001 | Magic Number                       |
| `InpSlippage`               |      10 | Slippage tối đa theo points        |
| `InpEmaPeriod`              |      50 | Chu kỳ EMA                         |
| `InpAdxPeriod`              |      14 | Chu kỳ ADX/DMI                     |
| `InpStopLoss`               |     300 | Stop Loss theo points              |
| `InpTakeProfit`             |     600 | Take Profit theo points            |
| `InpUseBreakEven`           |    true | Bật/tắt Break Even                 |
| `InpBreakEvenStartPoints`   |     150 | Profit kích hoạt Break Even        |
| `InpUseTrailingStop`        |    true | Bật/tắt Trailing Stop              |
| `InpTrailingStartPoints`    |     200 | Profit kích hoạt Trailing          |
| `InpTrailingDistancePoints` |       0 | Khoảng cách Trailing               |
| `InpMaxSpreadPoints`        |      30 | Spread tối đa                      |
| `InpMaxOpenPositions`       |       1 | Position tối đa của EA trên symbol |

---

## 16. Symbol và Timeframe

Source code không hard-code symbol hoặc timeframe.

EA sử dụng:

```text
Symbol    = _Symbol
Timeframe = PERIOD_CURRENT
```

Do đó EA chạy trên symbol và timeframe của chart nơi EA được attach.

### Research target

Repository hiện được sử dụng để nghiên cứu chiến lược trên:

```text
XAUUSD
```

Timeframe tối ưu chưa được coi là xác nhận cho đến khi hoàn thành backtest.

---

## 17. Điều kiện dữ liệu tối thiểu

EA chỉ tính tín hiệu nếu số lượng bar đủ lớn:

```text
Bars >= max(EMA Period, ADX Period) + 5
```

Với cấu hình mặc định:

```text
EMA = 50
ADX = 14
```

cần ít nhất khoảng:

```text
55 bars
```

---

## 18. Order Comment

BUY:

```text
ADX/EMA BUY
```

SELL:

```text
ADX/EMA SELL
```

---

## 19. Những chức năng chưa có

Version `1.00` hiện chưa implement:

* ADX minimum threshold;
* DI crossover bắt buộc tại đúng nến tín hiệu;
* Trading session filter;
* News filter;
* Day-of-week filter;
* Maximum daily loss;
* Maximum daily trades;
* Equity protection;
* Percentage risk position sizing;
* ATR-based Stop Loss;
* ATR-based Take Profit;
* Spread trung bình/dynamic spread filter;
* Partial close;
* Time-based exit;
* Close khi xuất hiện tín hiệu đảo chiều.

Đây không được coi là lỗi; chúng đơn giản là chưa thuộc logic của phiên bản hiện tại.

---

## 20. Các điểm cần xác minh

### 20.1 EMA slope

Source sử dụng:

```mql5
CopyBuffer(emaHandle, 0, 1, 2, ema50)
```

sau đó BUY kiểm tra:

```mql5
ema50[0] > ema50[1]
```

và SELL:

```mql5
ema50[0] < ema50[1]
```

Cần xác minh thứ tự dữ liệu trong array sau `CopyBuffer()` để đảm bảo:

```text
BUY  = EMA hiện tại đã đóng > EMA trước
SELL = EMA hiện tại đã đóng < EMA trước
```

Không coi logic này là PASS cho đến khi được test.

### 20.2 Trailing Stop mặc định

Comment của Input:

```text
0 = tự động dùng 50% khoảng cách hiện tại
```

nhưng implementation hiện tại:

```text
TrailingDistance <= 0 → return
```

Do đó chức năng Auto Trailing 50% chưa tồn tại trong version này.

---

## 21. Build

Mở file:

```text
EA-018_DI_Trend.mq5
```

bằng MetaEditor.

Compile:

```text
F7
```

Điều kiện build PASS:

```text
0 errors
```

Warnings cần được ghi nhận riêng nếu có.

---

## 22. Test Status

Trạng thái repository tại thời điểm tạo README:

```text
Source review : DONE
Compile test  : NOT VERIFIED
Backtest      : NOT VERIFIED
Optimization  : NOT VERIFIED
Forward test  : NOT VERIFIED
```

EA chưa được coi là chiến lược đã xác nhận chỉ dựa trên source code.

---

## 23. Repository Location

```text
xauusd-mt5-ea-research/
└── EAs/
    └── EA-018_DI_Trend/
        ├── EA-018_DI_Trend.mq5
        └── README.md
```

---

## 24. Current Version

```text
EA      : EA-018_DI_Trend
Version : 1.00
Status  : Research / Pre-Backtest
```
