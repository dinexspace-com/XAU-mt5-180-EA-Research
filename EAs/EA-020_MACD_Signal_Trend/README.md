# EA-020 — MACD Signal Trend

## Overview

**EA-020_MACD_Signal_Trend** là Expert Advisor (EA) cho MetaTrader 5 được xây dựng để nghiên cứu chiến lược giao dịch theo xu hướng dựa trên tín hiệu giao cắt của **MACD (Moving Average Convergence Divergence)**.

EA sử dụng MACD tiêu chuẩn:

* Fast EMA: `12`
* Slow EMA: `26`
* Signal Period: `9`
* Applied Price: `PRICE_CLOSE`

EA chỉ xem xét tín hiệu mới khi xuất hiện **nến mới** trên symbol và timeframe hiện tại.

---

## Strategy Logic

### BUY

EA mở lệnh **BUY** khi đồng thời thỏa mãn:

1. MACD trước đó nằm dưới hoặc bằng Signal Line.
2. MACD hiện tại cắt lên trên Signal Line.
3. MACD hiện tại lớn hơn `0`.

Logic:

```text
MACD Previous <= Signal Previous
AND
MACD Current > Signal Current
AND
MACD Current > 0
→ BUY
```

Điều kiện `MACD > 0` được sử dụng như một bộ lọc xu hướng, chỉ cho phép BUY khi tín hiệu giao cắt xuất hiện trong vùng MACD dương.

### SELL

EA mở lệnh **SELL** khi đồng thời thỏa mãn:

1. MACD trước đó nằm trên hoặc bằng Signal Line.
2. MACD hiện tại cắt xuống dưới Signal Line.
3. MACD hiện tại nhỏ hơn `0`.

Logic:

```text
MACD Previous >= Signal Previous
AND
MACD Current < Signal Current
AND
MACD Current < 0
→ SELL
```

Điều kiện `MACD < 0` được sử dụng như một bộ lọc xu hướng, chỉ cho phép SELL khi tín hiệu giao cắt xuất hiện trong vùng MACD âm.

---

## Position Rules

EA được thiết kế để chỉ duy trì tối đa **1 position theo Magic Number** tại một thời điểm.

Trước khi tìm tín hiệu mới, EA kiểm tra:

* Nến mới đã xuất hiện.
* Không có position đang mở với cùng Magic Number.
* Spread không vượt quá giới hạn cho phép.
* Dữ liệu MACD được lấy thành công.

---

## Default Parameters

| Parameter            |  Default | Description                        |
| -------------------- | -------: | ---------------------------------- |
| `InpLotSize`         |   `0.01` | Khối lượng giao dịch               |
| `InpStopLoss`        |    `300` | Stop Loss tính theo points         |
| `InpTakeProfit`      |    `600` | Take Profit tính theo points       |
| `InpMagicNumber`     | `123456` | Magic Number của EA                |
| `InpSlippage`        |     `10` | Slippage tối đa tính theo points   |
| `InpMaxSpread`       |     `30` | Spread tối đa cho phép             |
| `InpBreakEven`       |   `true` | Bật Break Even                     |
| `InpBreakEvenPoints` |    `150` | Mức lợi nhuận kích hoạt Break Even |
| `InpTrailing`        |   `true` | Bật Trailing Stop                  |
| `InpTrailingPoints`  |    `200` | Khoảng cách Trailing Stop          |

---

## Risk / Reward

Theo cấu hình mặc định:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

Tỷ lệ khoảng cách TP/SL lý thuyết:

```text
Reward : Risk = 2 : 1
```

Đây chỉ là tỷ lệ được xác định từ khoảng cách SL/TP trong cấu hình mặc định, **không phải kết quả hiệu suất thực tế của chiến lược**.

---

## Spread Filter

EA không mở position mới khi:

```text
Current Spread > InpMaxSpread
```

Giá trị mặc định:

```text
Maximum Spread = 30 points
```

Mục đích là hạn chế việc vào lệnh trong điều kiện spread vượt quá mức cấu hình.

---

## Position Management

Source code có triển khai hai cơ chế quản lý position:

### Break Even

Mặc định được kích hoạt khi position đạt:

```text
150 points
```

### Trailing Stop

Mặc định được kích hoạt khi lợi nhuận đạt:

```text
200 points
```

Khoảng cách trailing mặc định:

```text
200 points
```

---

## Known Issue

> **Important:** Phiên bản `1.00` cần được kiểm tra lại logic quản lý position trước khi sử dụng thực tế.

Trong `OnTick()`, EA hiện có logic:

```text
if(CountPositions() > 0)
   return;
```

Trong khi `ManagePosition()` được gọi ở phía sau đoạn kiểm tra này.

Điều này có nghĩa là khi position đã tồn tại, `OnTick()` có thể thoát trước khi chạy `ManagePosition()`.

Vì vậy chức năng:

* Break Even
* Trailing Stop

có thể **không được thực thi như thiết kế** trong phiên bản source hiện tại.

Issue này cần được sửa và xác nhận bằng test trước khi coi chức năng quản lý position là hoạt động chính xác.

---

## Current Research Status

| Component             | Status                                        |
| --------------------- | --------------------------------------------- |
| Source code           | Available                                     |
| MACD entry logic      | Implemented                                   |
| BUY/SELL trend filter | Implemented                                   |
| Spread filter         | Implemented                                   |
| Fixed SL/TP           | Implemented                                   |
| Break Even            | Implemented in source — requires verification |
| Trailing Stop         | Implemented in source — requires verification |
| Backtest              | Not documented here                           |
| Forward Test          | Not verified                                  |
| Live Trading          | Not verified                                  |

---

## File

```text
EA-020_MACD_Signal_Trend/
├── EA-020_MACD_Signal_Trend.mq5
└── README.md
```

---

## Research Purpose

EA-020 được lưu trong repository với mục đích:

* Nghiên cứu chiến lược MACD Signal + Trend Filter.
* Backtest trên XAUUSD.
* Đánh giá chất lượng tín hiệu.
* Đo hiệu suất và drawdown.
* Kiểm tra độ ổn định qua các giai đoạn thị trường.
* So sánh với các EA/strategy khác trong repository.

Kết quả backtest và bằng chứng thực nghiệm được lưu riêng tại:

```text
Backtest/EA-020_MACD_Signal_Trend/
```

---

## Disclaimer

This Expert Advisor is provided for **research and educational purposes only**.

Past backtest performance does not guarantee future results. The strategy should be independently tested and validated before any live trading use.
