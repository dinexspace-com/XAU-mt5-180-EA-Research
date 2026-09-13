# EA-056 — Triangle Break

## Overview

`EA-056_Triangle_Break` là Expert Advisor cho MetaTrader 5, giao dịch theo mô hình **price contraction / convergence zone breakout**.

EA tìm một vùng giá đang co hẹp so với giai đoạn trước đó, sau đó chờ cây nến đã đóng phá ra khỏi biên trên hoặc biên dưới của vùng để xác nhận giao dịch.

Chiến lược hiện tại hỗ trợ cả:

* BUY breakout
* SELL breakout
* Fixed lot size
* Fixed Stop Loss / Take Profit
* Break-even
* Trailing Stop
* Spread filter
* Maximum open positions
* New-bar-only signal processing

---

## File

```text
EAs/
└── EA-056_Triangle_Break/
    ├── EA-056_Triangle_Break.mq5
    └── README.md
```

---

## Platform

* Platform: MetaTrader 5
* Language: MQL5
* EA version: `1.00`
* Trading symbol: sử dụng symbol của chart hiện tại (`_Symbol`)
* Timeframe: sử dụng timeframe của chart hiện tại (`_Period`)

EA không khóa cứng timeframe trong source code.

---

# Strategy Logic

## 1. Convergence Zone

EA chia dữ liệu quá khứ thành hai vùng.

### Recent Zone

Vùng hội tụ hiện tại sử dụng:

```text
InpZoneBars
```

cây nến đã đóng.

Mặc định:

```text
InpZoneBars = 10
```

Cây nến số `1` không được tính vào vùng này vì nó được dùng làm breakout confirmation candle.

Do đó vùng convergence được tính từ:

```text
candle #2
→ candle #(InpZoneBars + 1)
```

EA xác định:

```text
zoneHigh = Highest High
zoneLow  = Lowest Low
```

trong vùng này.

---

## 2. Comparison Zone

EA sử dụng thêm một nhóm nến cũ hơn để xác định liệu giá có thực sự đang co hẹp hay không.

Số nến:

```text
InpCompareBars
```

Mặc định:

```text
InpCompareBars = 10
```

EA tính:

```text
olderRange = oldHigh - oldLow
recentRange = zoneHigh - zoneLow
```

---

## 3. Convergence Condition

Vùng hiện tại chỉ hợp lệ nếu:

```text
recentRange <= olderRange × InpConvergenceRatio
```

Mặc định:

```text
InpConvergenceRatio = 0.70
```

Có nghĩa là vùng giá gần nhất phải nhỏ hơn hoặc bằng khoảng `70%` range của vùng trước đó.

Ví dụ:

```text
Older Range  = 1000 points
Ratio        = 0.70

Maximum Recent Range = 700 points
```

Nếu recent range lớn hơn mức này, EA không coi thị trường đang hội tụ.

---

## 4. Zone Size Filter

Convergence zone phải nằm trong giới hạn:

```text
InpMinZonePoints <= Zone Height <= InpMaxZonePoints
```

Giá trị mặc định:

```text
InpMinZonePoints = 30
InpMaxZonePoints = 500
```

Điều này giúp loại bỏ:

* vùng quá nhỏ;
* vùng quá rộng;
* cấu trúc không phù hợp với breakout setup.

---

# Entry Logic

EA dùng **cây nến đã đóng gần nhất — candle #1** để xác nhận breakout.

Một breakout buffer được thêm vào ngoài biên của convergence zone.

Mặc định:

```text
InpBreakoutBuffer = 5 points
```

Biên breakout được tính:

```text
Upper Breakout = zoneHigh + buffer
Lower Breakout = zoneLow - buffer
```

---

## BUY Entry

BUY được kích hoạt khi candle #1:

```text
Close > Upper Breakout
```

và:

```text
Open <= Upper Breakout
```

Tức là cây nến phải thực sự **cross và close phía trên vùng breakout**.

Logic:

```text
previousClose > upperBreakout
AND
previousOpen <= upperBreakout
```

Sau khi tín hiệu được xác nhận, EA mở lệnh BUY theo market price.

---

## SELL Entry

SELL được kích hoạt khi candle #1:

```text
Close < Lower Breakout
```

và:

```text
Open >= Lower Breakout
```

Logic:

```text
previousClose < lowerBreakout
AND
previousOpen >= lowerBreakout
```

Sau đó EA mở lệnh SELL theo market price.

---

# Position Sizing

EA hiện sử dụng **fixed lot size**.

Input:

```text
InpLotSize
```

Mặc định:

```text
0.01 lot
```

EA tự normalize lot theo:

* minimum volume;
* maximum volume;
* volume step;

của broker hiện tại.

Không có risk-percent position sizing trong phiên bản này.

---

# Stop Loss

Stop Loss được đặt cố định theo số point.

Input:

```text
InpStopLoss = 300
```

BUY:

```text
SL = Entry Price - 300 points
```

SELL:

```text
SL = Entry Price + 300 points
```

EA có kiểm tra:

```text
SYMBOL_TRADE_STOPS_LEVEL
```

để đảm bảo SL không vi phạm minimum stop distance của broker.

---

# Take Profit

Take Profit được đặt cố định.

Input mặc định:

```text
InpTakeProfit = 600
```

BUY:

```text
TP = Entry Price + 600 points
```

SELL:

```text
TP = Entry Price - 600 points
```

Với cấu hình mặc định:

```text
SL = 300 points
TP = 600 points
```

Reward/Risk danh nghĩa:

```text
2 : 1
```

trước spread, slippage và các chi phí giao dịch khác.

---

# Break Even

Break-even được bật mặc định:

```text
InpUseBreakEven = true
```

Trigger:

```text
InpBreakEvenTrigger = 150 points
```

Khi lợi nhuận đạt ít nhất `150 points`, EA có thể chuyển Stop Loss về vùng entry.

Offset mặc định:

```text
InpBreakEvenOffset = 5 points
```

### BUY

SL mục tiêu:

```text
Open Price + 5 points
```

### SELL

SL mục tiêu:

```text
Open Price - 5 points
```

EA đồng thời kiểm tra minimum stop distance của broker trước khi sửa SL.

---

# Trailing Stop

Trailing Stop được bật mặc định.

```text
InpUseTrailingStop = true
```

Trailing bắt đầu khi lợi nhuận đạt:

```text
InpTrailingStart = 200 points
```

Khoảng trailing:

```text
InpTrailingDistance = 150 points
```

Minimum SL improvement:

```text
InpTrailingStep = 20 points
```

### BUY

SL mới được tính gần:

```text
Current Bid - TrailingDistance
```

### SELL

SL mới được tính gần:

```text
Current Ask + TrailingDistance
```

EA chỉ sửa SL nếu mức mới cải thiện SL hiện tại tối thiểu theo `InpTrailingStep`.

---

# Spread Filter

EA không mở lệnh nếu spread vượt:

```text
InpMaxSpread
```

Mặc định:

```text
30 points
```

Spread được tính:

```text
(Ask - Bid) / _Point
```

Nếu:

```text
spread > InpMaxSpread
```

EA bỏ qua tín hiệu.

---

# Maximum Positions

EA giới hạn số position đang mở theo:

```text
InpMaxPositions
```

Mặc định:

```text
1
```

EA chỉ đếm những position:

* cùng symbol;
* cùng Magic Number.

Do đó position thủ công hoặc EA khác không bị tính nếu Magic Number khác.

---

# Magic Number

Magic Number mặc định:

```text
123456
```

Input:

```text
InpMagicNumber
```

Magic Number được sử dụng để:

* xác định position thuộc EA;
* quản lý Break Even;
* quản lý Trailing Stop;
* kiểm soát số position đang mở.

---

# New Bar Processing

Mặc định:

```text
InpUseNewBarOnly = true
```

Khi bật, EA chỉ kiểm tra tín hiệu entry một lần khi xuất hiện cây nến mới.

Điều này phù hợp với logic hiện tại vì tín hiệu được xác nhận bằng candle #1 đã đóng.

Lưu ý:

Break-even và trailing stop vẫn chạy **mỗi tick**, ngay cả khi `InpUseNewBarOnly = true`.

---

# Input Parameters

## General Trading Settings

| Parameter         |  Default | Description                     |
| ----------------- | -------: | ------------------------------- |
| `InpLotSize`      |   `0.01` | Fixed lot size                  |
| `InpStopLoss`     |    `300` | Stop Loss, points               |
| `InpTakeProfit`   |    `600` | Take Profit, points             |
| `InpMagicNumber`  | `123456` | EA Magic Number                 |
| `InpSlippage`     |     `10` | Maximum deviation, points       |
| `InpMaxSpread`    |     `30` | Maximum allowed spread, points  |
| `InpMaxPositions` |      `1` | Maximum concurrent EA positions |

## Convergence Zone Settings

| Parameter             | Default | Description                                          |
| --------------------- | ------: | ---------------------------------------------------- |
| `InpZoneBars`         |    `10` | Recent closed candles used to build convergence zone |
| `InpCompareBars`      |    `10` | Older candles used as contraction reference          |
| `InpConvergenceRatio` |  `0.70` | Required contraction ratio                           |
| `InpMinZonePoints`    |    `30` | Minimum allowed zone height                          |
| `InpMaxZonePoints`    |   `500` | Maximum allowed zone height                          |
| `InpBreakoutBuffer`   |     `5` | Distance outside zone required for breakout          |
| `InpUseNewBarOnly`    |  `true` | Evaluate entries on new bars only                    |

## Break Even

| Parameter             | Default | Description                          |
| --------------------- | ------: | ------------------------------------ |
| `InpUseBreakEven`     |  `true` | Enable break-even                    |
| `InpBreakEvenTrigger` |   `150` | Profit required before BE activation |
| `InpBreakEvenOffset`  |     `5` | Points locked beyond entry           |

## Trailing Stop

| Parameter             | Default | Description                                |
| --------------------- | ------: | ------------------------------------------ |
| `InpUseTrailingStop`  |  `true` | Enable trailing                            |
| `InpTrailingStart`    |   `200` | Profit required before trailing starts     |
| `InpTrailingDistance` |   `150` | Trailing distance                          |
| `InpTrailingStep`     |    `20` | Minimum SL improvement before modification |

---

# Default Configuration

```text
Lot Size            = 0.01

Stop Loss           = 300 points
Take Profit         = 600 points

Maximum Spread      = 30 points
Maximum Positions   = 1

Zone Bars           = 10
Comparison Bars     = 10
Convergence Ratio   = 0.70

Minimum Zone        = 30 points
Maximum Zone        = 500 points

Breakout Buffer     = 5 points

Break Even          = ON
BE Trigger          = 150 points
BE Offset           = 5 points

Trailing Stop       = ON
Trailing Start      = 200 points
Trailing Distance   = 150 points
Trailing Step       = 20 points
```

---

# Execution Flow

EA hoạt động theo trình tự:

```text
OnTick
  │
  ├── ManageOpenPositions()
  │     ├── Break Even
  │     └── Trailing Stop
  │
  ├── Check New Bar
  │
  └── CheckEntrySignal()
        │
        ├── Trading allowed?
        ├── Max positions reached?
        ├── Spread acceptable?
        ├── Valid convergence zone?
        │
        ├── BUY breakout?
        │      └── OpenBuy()
        │
        └── SELL breakout?
               └── OpenSell()
```

---

# Trading Restrictions

EA sẽ không mở lệnh nếu một trong các điều kiện sau xảy ra:

* terminal không cho phép trading;
* MQL trading bị tắt;
* account không cho phép trading;
* số position đạt `InpMaxPositions`;
* spread lớn hơn `InpMaxSpread`;
* không đủ số lượng bars;
* convergence zone không hợp lệ;
* zone quá nhỏ;
* zone quá lớn;
* recent range chưa đủ contraction;
* candle #1 không xác nhận breakout.

---

# Parameter Validation

Khi khởi động EA, `OnInit()` kiểm tra một số input.

EA trả về:

```text
INIT_PARAMETERS_INCORRECT
```

nếu:

```text
InpLotSize <= 0
```

hoặc:

```text
InpStopLoss <= 0
InpTakeProfit <= 0
InpMaxSpread <= 0
```

hoặc:

```text
InpZoneBars < 3
InpCompareBars < 3
```

hoặc:

```text
InpConvergenceRatio <= 0
InpConvergenceRatio >= 1
```

hoặc:

```text
InpMaxPositions < 1
```

---

# Notes

## Point vs Pip / Price

Các thông số:

```text
Stop Loss
Take Profit
Spread
Breakout Buffer
Break Even
Trailing Stop
Zone Height
```

đều được tính theo:

```text
_Point
```

của symbol trên broker.

Vì vậy giá trị giá thực tế có thể khác nhau giữa các broker có số digit hoặc specification khác nhau.

Khi backtest XAUUSD cần ghi lại specification của symbol để đảm bảo kết quả có thể tái lập.

---

## Strategy Naming

Tên repository sử dụng:

```text
EA-056_Triangle_Break
```

Trong source code nội bộ chiến lược hiện được mô tả là:

```text
Convergence Zone Breakout
```

Tên comment khi mở lệnh:

```text
Convergence Breakout BUY
Convergence Breakout SELL
```

Về mặt logic, phiên bản hiện tại phát hiện **range contraction / convergence breakout**, chưa thực hiện nhận dạng hình học triangle bằng trendline hoặc pivot-high/pivot-low.

---

# Current Development Status

```text
EA ID:        EA-056
Strategy:     Triangle / Convergence Breakout
Platform:     MT5
Language:     MQL5
Source:       Available
Backtest:     Separate Backtest package
Research:     Separate Research package
```

File source chính:

```text
EA-056_Triangle_Break.mq5
```

---

# Disclaimer

EA này được phát triển cho mục đích nghiên cứu, kiểm thử và đánh giá chiến lược giao dịch tự động.

Kết quả backtest hoặc historical performance không đảm bảo kết quả giao dịch trong tương lai.

Trước khi sử dụng trên tài khoản thật cần thực hiện:

```text
Compile Test
→ Backtest
→ Parameter Validation
→ Forward Test
→ Risk Review
```
