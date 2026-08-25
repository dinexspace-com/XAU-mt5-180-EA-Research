# EA-023 — Supertrend Retest

## Overview

**EA-023 Supertrend Retest** là Expert Advisor (EA) dành cho **MetaTrader 5 (MT5)**, giao dịch dựa trên sự thay đổi xu hướng của **Supertrend** kết hợp cơ chế **chờ giá retest đường Supertrend trước khi vào lệnh**.

Khác với cách vào lệnh ngay khi Supertrend đổi hướng, EA-023 ghi nhận tín hiệu trước, sau đó chờ giá quay lại retest vùng Supertrend trong một số lượng nến giới hạn.

EA sử dụng:

* Supertrend tính từ ATR.
* Retest sau khi Supertrend đổi hướng.
* Stop Loss và Take Profit cố định theo point.
* Break Even.
* Trailing Stop.
* Spread filter.
* Giới hạn số position theo Magic Number.

---

## Strategy Logic

Quy trình giao dịch cơ bản:

```text
Supertrend đổi hướng
        ↓
Ghi nhận BUY/SELL signal
        ↓
Chờ giá retest Supertrend
        ↓
Retest hợp lệ?
   ├── Không → tiếp tục chờ
   │
   └── Có
        ↓
Kiểm tra Spread + Max Positions
        ↓
Mở Position
        ↓
SL + TP
        ↓
Break Even / Trailing Stop
```

Tín hiệu retest chỉ tồn tại trong:

```text
InpRetestMaxBars
```

Nếu quá số nến cho phép mà không xuất hiện retest hợp lệ, tín hiệu pending sẽ bị hủy.

---

## Supertrend Calculation

Supertrend được tính trực tiếp bên trong EA.

### ATR

```text
ATR Period = InpAtrPeriod
```

Mặc định:

```text
InpAtrPeriod = 10
```

### Supertrend Multiplier

```text
InpMultiplier = 3.0
```

Basic bands:

```text
Basic Upper =
(High + Low) / 2 + Multiplier × ATR

Basic Lower =
(High + Low) / 2 - Multiplier × ATR
```

EA tiếp tục tính Final Upper / Lower Band dựa trên band và giá đóng cửa của nến trước.

Hướng Supertrend:

```text
Close > Upper Band
→ Uptrend

Close < Lower Band
→ Downtrend
```

---

## Signal Detection

EA kiểm tra sự thay đổi hướng Supertrend trên các **nến đã đóng**.

### BUY Signal

BUY signal xuất hiện khi:

```text
Previous Supertrend Direction < 0
AND
Current Supertrend Direction > 0
```

Tức:

```text
Downtrend → Uptrend
```

EA **không BUY ngay lập tức**.

Một pending BUY signal được tạo và EA bắt đầu chờ retest.

### SELL Signal

SELL signal xuất hiện khi:

```text
Previous Supertrend Direction > 0
AND
Current Supertrend Direction < 0
```

Tức:

```text
Uptrend → Downtrend
```

EA **không SELL ngay lập tức**.

Một pending SELL signal được tạo và EA bắt đầu chờ retest.

---

## Retest Logic

### BUY Retest

Sau BUY signal, EA theo dõi:

```text
Supertrend Lower Line
```

Retest BUY có thể được xác nhận khi giá Bid nằm trong vùng:

```text
Lower Line ± Retest Buffer
```

hoặc khi Low của nến đã đóng chạm/xuyên vùng Supertrend và giá hiện tại quay trở lại phía trên Lower Line.

Sau khi retest hợp lệ:

```text
→ Open BUY
```

---

### SELL Retest

Sau SELL signal, EA theo dõi:

```text
Supertrend Upper Line
```

Retest SELL có thể được xác nhận khi giá Ask nằm trong vùng:

```text
Upper Line ± Retest Buffer
```

hoặc khi High của nến đã đóng chạm/xuyên vùng Supertrend và giá hiện tại quay trở lại phía dưới Upper Line.

Sau khi retest hợp lệ:

```text
→ Open SELL
```

---

## Retest Window

EA không chờ retest vô thời hạn.

Input:

```text
InpRetestMaxBars = 5
```

Mặc định EA cho phép tối đa **5 bars** để chờ retest.

Nếu vượt quá giới hạn:

```text
Retest window expired
→ Cancel pending signal
```

---

## Retest Buffer

Khoảng dung sai quanh Supertrend:

```text
InpRetestBuffer = 5.0 points
```

Buffer giúp EA không yêu cầu giá phải chạm chính xác tuyệt đối vào giá trị của đường Supertrend.

---

## Entry

### BUY

Khi BUY retest được xác nhận:

```text
Entry = Ask
SL    = Ask - InpStopLoss × Point
TP    = Ask + InpTakeProfit × Point
```

Comment:

```text
Supertrend Retest Buy
```

### SELL

Khi SELL retest được xác nhận:

```text
Entry = Bid
SL    = Bid + InpStopLoss × Point
TP    = Bid - InpTakeProfit × Point
```

Comment:

```text
Supertrend Retest Sell
```

---

## Risk Management

EA hiện sử dụng **Fixed Lot Size**.

Mặc định:

```text
InpLotSize = 0.01
```

EA chưa có position sizing tự động theo:

* % Equity
* % Balance
* Risk per trade
* Khoảng cách SL

---

## Stop Loss & Take Profit

Mặc định:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

Tỷ lệ khoảng cách TP/SL mặc định:

```text
600 / 300 = 2.0
```

Các giá trị này được tính theo `_Point` của symbol đang giao dịch.

---

## Break Even

Break Even được bật mặc định:

```text
InpUseBreakEven = true
```

Trigger:

```text
InpBreakEvenTrigger = 150 points
```

Khi position đạt lợi nhuận tối thiểu 150 points, EA có thể chuyển Stop Loss về:

```text
Entry Price
```

---

## Trailing Stop

Trailing Stop được bật mặc định:

```text
InpUseTrailingStop = true
```

Thông số:

```text
Trailing Start    = 200 points
Trailing Distance = 200 points
Trailing Step     = 10 points
```

Trailing chỉ bắt đầu sau khi position đạt mức lợi nhuận được quy định bởi `InpTrailingStart`.

Stop Loss sau đó được dịch chuyển theo giá với khoảng cách `InpTrailingDistance`.

`InpTrailingStep` hạn chế việc cập nhật Stop Loss khi mức thay đổi chưa đủ lớn.

---

## Spread Filter

EA kiểm tra spread trước khi xử lý entry.

Mặc định:

```text
InpMaxSpread = 30 points
```

Nếu:

```text
Current Spread > InpMaxSpread
```

EA không thực hiện logic entry tại thời điểm đó.

---

## Maximum Positions

Mặc định:

```text
InpMaxPositions = 1
```

EA đếm position dựa trên:

```text
Symbol
+
Magic Number
```

Nếu số position đã đạt giới hạn, EA không mở thêm position và pending signal hiện tại được reset.

---

## Magic Number

Mặc định:

```text
InpMagicNumber = 123456
```

Magic Number được sử dụng để nhận diện các position thuộc EA.

---

## Slippage / Deviation

Mặc định:

```text
InpSlippage = 10 points
```

Giá trị này được truyền cho `CTrade` thông qua:

```text
SetDeviationInPoints()
```

---

## Default Parameters

| Parameter             | Default | Description                      |
| --------------------- | ------: | -------------------------------- |
| `InpLotSize`          |    0.01 | Fixed lot size                   |
| `InpStopLoss`         |     300 | Stop Loss (points)               |
| `InpTakeProfit`       |     600 | Take Profit (points)             |
| `InpMagicNumber`      |  123456 | EA Magic Number                  |
| `InpSlippage`         |      10 | Maximum deviation (points)       |
| `InpMaxSpread`        |      30 | Maximum allowed spread           |
| `InpMaxPositions`     |       1 | Maximum positions                |
| `InpAtrPeriod`        |      10 | ATR period                       |
| `InpMultiplier`       |     3.0 | Supertrend multiplier            |
| `InpRetestMaxBars`    |       5 | Maximum bars waiting for retest  |
| `InpRetestBuffer`     |     5.0 | Retest tolerance (points)        |
| `InpUseBreakEven`     |    true | Enable Break Even                |
| `InpBreakEvenTrigger` |     150 | Break Even trigger               |
| `InpUseTrailingStop`  |    true | Enable Trailing Stop             |
| `InpTrailingStart`    |     200 | Start trailing after this profit |
| `InpTrailingDistance` |     200 | Trailing Stop distance           |
| `InpTrailingStep`     |      10 | Minimum trailing adjustment      |

---

## Timeframe

EA sử dụng:

```text
PERIOD_CURRENT
```

Do đó EA hoạt động theo timeframe của chart mà EA được attach.

Code hiện tại không khóa EA vào một timeframe cụ thể.

---

## Symbol

EA sử dụng:

```text
_Symbol
```

Do đó EA hoạt động trên symbol của chart hiện tại.

Code không hard-code `XAUUSD`.

Nếu nghiên cứu EA này cho XAUUSD, cần attach EA hoặc backtest trên symbol XAUUSD tương ứng của broker.

---

## Position Management

Position đang mở được quản lý trên **mỗi tick**.

EA thực hiện:

```text
ManageOpenPositions()
```

trước logic tìm tín hiệu mới.

Các chức năng quản lý gồm:

```text
Break Even
Trailing Stop
```

---

## Known Limitations

Phiên bản hiện tại chưa bao gồm:

* Risk sizing theo % tài khoản.
* Session filter.
* News filter.
* Day-of-week filter.
* Time-of-day filter.
* ATR-based Stop Loss.
* ATR-based Take Profit.
* Daily loss limit.
* Maximum drawdown protection.
* Consecutive loss protection.
* Multi-timeframe confirmation.
* Additional trend filter.
* Automatic optimization logic.

Các tính năng trên **không được giả định là một phần của EA-023** cho đến khi được triển khai và kiểm thử.

---

## Backtest Status

Backtest được quản lý riêng tại:

```text
Backtest/
└── EA-023_Supertrend_Retest/
```

README này mô tả **logic của source code EA hiện tại**.

Kết quả hiệu suất như:

* Net Profit
* Profit Factor
* Expected Payoff
* Maximum Drawdown
* Number of Trades
* Win Rate
* Recovery Factor

chỉ nên được bổ sung sau khi có kết quả backtest thực tế.

---

## Source

```text
EAs/
└── EA-023_Supertrend_Retest/
    ├── EA-023_Supertrend_Retest.mq5
    └── README.md
```

---

## Research Status

**EA ID:** EA-023
**Strategy:** Supertrend Retest
**Platform:** MetaTrader 5
**Language:** MQL5
**Version:** 1.01
**Status:** Research / Backtesting

---

## Disclaimer

This Expert Advisor is developed for research and backtesting purposes.

Historical backtest results do not guarantee future performance. Trading leveraged financial instruments involves significant risk.
