# EA-055 — Double Top / Bottom Break

Expert Advisor cho MetaTrader 5 giao dịch theo mô hình **Double Top / Double Bottom**, vào lệnh khi giá đóng cửa phá vỡ neckline của mô hình.

## Strategy Overview

EA tự động:

* Phát hiện Swing High / Swing Low.
* Tìm mô hình Double Top.
* Tìm mô hình Double Bottom.
* Xác định neckline của mô hình.
* Chờ nến đóng cửa breakout neckline.
* Mở lệnh BUY hoặc SELL.
* Quản lý Stop Loss, Take Profit, Break Even và Trailing Stop.
* Lọc spread trước khi vào lệnh.
* Chỉ duy trì tối đa một position của EA trên cùng symbol và Magic Number.

EA kiểm tra tín hiệu vào lệnh **một lần trên mỗi nến mới**, trong khi Break Even và Trailing Stop được quản lý trên mỗi tick.

---

## Trading Logic

### Double Top → SELL

EA tìm hai Swing High có mức giá gần nhau.

Điều kiện chính:

1. Xác định Swing High gần nhất.
2. Tìm Swing High cũ hơn trong khoảng số nến cho phép.
3. Khoảng cách giá giữa hai đỉnh không vượt quá `InpPatternTolerance`.
4. Neckline được xác định bằng **Low thấp nhất giữa hai đỉnh**.
5. Chờ giá phá xuống neckline.

Điều kiện breakout:

```text
Previous Close >= Breakout Level
Latest Closed Candle < Breakout Level
```

Trong đó:

```text
Breakout Level = Neckline - Breakout Buffer
```

Khi thỏa điều kiện, EA mở:

```text
SELL
```

---

### Double Bottom → BUY

EA tìm hai Swing Low có mức giá gần nhau.

Điều kiện chính:

1. Xác định Swing Low gần nhất.
2. Tìm Swing Low cũ hơn trong khoảng số nến cho phép.
3. Khoảng cách giá giữa hai đáy không vượt quá `InpPatternTolerance`.
4. Neckline được xác định bằng **High cao nhất giữa hai đáy**.
5. Chờ giá phá lên neckline.

Điều kiện breakout:

```text
Previous Close <= Breakout Level
Latest Closed Candle > Breakout Level
```

Trong đó:

```text
Breakout Level = Neckline + Breakout Buffer
```

Khi thỏa điều kiện, EA mở:

```text
BUY
```

---

## Default Parameters

### General

| Parameter        |  Default | Description                              |
| ---------------- | -------: | ---------------------------------------- |
| `InpLotSize`     |   `0.01` | Fixed lot size                           |
| `InpStopLoss`    |    `300` | Stop Loss, tính theo points              |
| `InpTakeProfit`  |    `600` | Take Profit, tính theo points            |
| `InpMagicNumber` | `123456` | Magic Number của EA                      |
| `InpSlippage`    |     `10` | Deviation/slippage cho phép, theo points |

### Break Even

| Parameter             | Default | Description                      |
| --------------------- | ------: | -------------------------------- |
| `InpUseBreakEven`     |  `true` | Bật Break Even                   |
| `InpBreakEvenTrigger` |   `150` | Số points lợi nhuận để kích hoạt |
| `InpBreakEvenOffset`  |     `0` | Khoảng dịch SL khỏi giá entry    |

### Trailing Stop

| Parameter             | Default | Description                             |
| --------------------- | ------: | --------------------------------------- |
| `InpUseTrailingStop`  |  `true` | Bật Trailing Stop                       |
| `InpTrailingStart`    |   `200` | Số points lợi nhuận để bắt đầu trailing |
| `InpTrailingDistance` |   `150` | Khoảng cách trailing theo points        |

### Strategy

| Parameter             | Default | Description                                    |
| --------------------- | ------: | ---------------------------------------------- |
| `InpMaxSpread`        |    `30` | Spread tối đa cho phép                         |
| `InpLookbackBars`     |   `100` | Số nến lịch sử dùng để tìm mô hình             |
| `InpSwingStrength`    |     `2` | Độ mạnh Swing High / Swing Low                 |
| `InpMinPatternBars`   |     `5` | Khoảng cách tối thiểu giữa hai đỉnh/đáy        |
| `InpMaxPatternBars`   |    `60` | Khoảng cách tối đa giữa hai đỉnh/đáy           |
| `InpPatternTolerance` |   `100` | Sai lệch tối đa giữa hai đỉnh/đáy, theo points |
| `InpBreakoutBuffer`   |     `0` | Buffer bổ sung cho neckline breakout           |

---

## Position Management

### Stop Loss / Take Profit

SL và TP được đặt theo khoảng cách point từ giá thị trường tại thời điểm mở lệnh.

EA đồng thời kiểm tra `SYMBOL_TRADE_STOPS_LEVEL` và tự điều chỉnh mức SL/TP để đáp ứng khoảng cách stop tối thiểu của broker.

### Break Even

Khi position đạt:

```text
InpBreakEvenTrigger
```

points lợi nhuận, Stop Loss có thể được chuyển về:

```text
Entry Price ± InpBreakEvenOffset
```

tùy theo BUY hoặc SELL.

### Trailing Stop

Khi lợi nhuận đạt:

```text
InpTrailingStart
```

EA bắt đầu di chuyển Stop Loss theo giá với khoảng cách:

```text
InpTrailingDistance
```

Trailing Stop chỉ di chuyển theo hướng bảo vệ thêm lợi nhuận và không nới Stop Loss theo hướng ngược lại.

---

## Trade Filters

EA sẽ không mở position mới nếu:

* Terminal không kết nối.
* Auto Trading không được cho phép.
* Symbol không được phép giao dịch.
* Spread lớn hơn `InpMaxSpread`.
* Không đủ dữ liệu lịch sử.
* Đã tồn tại position cùng Symbol và Magic Number.
* Không tìm thấy Double Top / Double Bottom hợp lệ.
* Chưa có nến đóng cửa xác nhận breakout neckline.

---

## Position Rule

EA chỉ cho phép:

```text
1 open position / Symbol / Magic Number
```

Position của EA được nhận diện bằng:

```text
POSITION_SYMBOL
+
POSITION_MAGIC
```

Position của EA khác hoặc Magic Number khác không bị xem là position của EA-055.

---

## Volume Management

EA hiện sử dụng:

```text
Fixed Lot Size
```

được thiết lập bởi:

```text
InpLotSize
```

Lot được tự động chuẩn hóa theo:

* Minimum volume của broker.
* Maximum volume của broker.
* Volume step của broker.

Phiên bản hiện tại **không sử dụng Risk % theo Balance/Equity**.

---

## Symbol & Timeframe

Source code sử dụng:

```mql5
_Symbol
_Period
```

Do đó EA chạy trên **symbol và timeframe của chart hiện tại**.

Repository này được tổ chức cho nghiên cứu EA XAUUSD, nhưng source code hiện tại không hard-code riêng `XAUUSD`.

Thông số phù hợp cho từng symbol, timeframe và broker cần được xác định thông qua backtest riêng.

---

## Source File

```text
EAs/
└── EA-055_Double_Top_Bottom_Break/
    ├── EA-055_Double_Top_Bottom_Break.mq5
    └── README.md
```

Source:

```text
EA-055_Double_Top_Bottom_Break.mq5
```

MQL5 property version:

```text
1.00
```

Platform:

```text
MetaTrader 5
```

Language:

```text
MQL5
```

---

## Backtest

Backtest và các artifact kiểm chứng của EA được lưu riêng tại:

```text
Backtest/
└── EA-055_Double_Top_Bottom_Break/
```

README này chỉ mô tả implementation của EA.

Không có kết luận về profitability, drawdown, robustness hoặc hiệu quả giao dịch nếu chưa có kết quả backtest tương ứng.

---

## Research Status

```text
EA ID:       EA-055
Strategy:    Double Top / Double Bottom Neckline Breakout
Platform:    MT5
Language:    MQL5
Version:     1.00
Lot Model:   Fixed Lot
Entry:       Closed-candle neckline breakout
Management:  SL / TP / Break Even / Trailing Stop
Backtest:    See /Backtest/EA-055_Double_Top_Bottom_Break/
```

---

## Disclaimer

This repository is intended for strategy research, development and backtesting.

Trading results depend on market conditions, broker specifications, spread, execution, symbol specification and parameter configuration.

Historical or backtest performance does not guarantee future results.
