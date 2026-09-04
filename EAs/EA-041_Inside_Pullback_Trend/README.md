# EA-041 — Inside Pullback Trend

## Overview

**EA-041 Inside Pullback Trend** là Expert Advisor (EA) cho MetaTrader 5, được xây dựng để giao dịch mô hình **Inside Bar theo hướng của xu hướng chính**.

EA sử dụng **EMA 50** để xác định hướng xu hướng, sau đó tìm Inside Bar và chờ giá phá vỡ Mother Bar theo hướng của xu hướng để tạo tín hiệu giao dịch.

EA hiện được định hướng nghiên cứu và backtest cho **XAUUSD (Gold)**.

---

## Platform

* Platform: MetaTrader 5
* Language: MQL5
* File: `EA-041_Inside_Pullback_Trend.mq5`
* Strategy Type: Trend Following / Inside Bar Breakout
* Primary Market: XAUUSD
* Timeframe: Current chart timeframe (`PERIOD_CURRENT`)
* Version: 1.00

---

## Strategy Logic

Chiến lược gồm 3 thành phần chính:

1. Xác định xu hướng bằng EMA 50.
2. Phát hiện mô hình Inside Bar.
3. Giao dịch breakout theo hướng của xu hướng.

### Trend Detection

EA sử dụng **EMA 50** trên timeframe hiện tại.

**Uptrend:**

```text
Current Price > EMA 50
```

**Downtrend:**

```text
Current Price < EMA 50
```

Nếu không xác định được xu hướng, EA không tạo tín hiệu giao dịch.

---

## Inside Bar Detection

EA kiểm tra nến vừa đóng (`rates[1]`) so với nến trước đó (`rates[2]`).

Inside Bar hợp lệ khi:

```text
Inside Bar High <= Mother Bar High

AND

Inside Bar Low >= Mother Bar Low
```

Trong đó:

* `rates[1]` = Inside Bar
* `rates[2]` = Mother Bar

---

## Buy Condition

EA tạo tín hiệu BUY khi đồng thời thỏa mãn:

```text
Price > EMA 50

AND

Inside Bar detected

AND

Current Price > Mother Bar High
```

Khi tín hiệu hợp lệ, EA mở lệnh BUY theo Lot Size được cấu hình.

---

## Sell Condition

EA tạo tín hiệu SELL khi đồng thời thỏa mãn:

```text
Price < EMA 50

AND

Inside Bar detected

AND

Current Price < Mother Bar Low
```

Khi tín hiệu hợp lệ, EA mở lệnh SELL theo Lot Size được cấu hình.

---

## Stop Loss & Take Profit

Stop Loss và Take Profit được tính theo `points` từ giá mở lệnh.

Giá trị mặc định:

| Parameter   |    Default |
| ----------- | ---------: |
| Stop Loss   | 300 points |
| Take Profit | 600 points |

Tỷ lệ khoảng cách TP/SL mặc định:

```text
600 / 300 = 2.0
```

Tương đương Risk/Reward danh nghĩa khoảng **1:2** trước spread, slippage và chi phí giao dịch.

---

## Break Even

Break Even được bật mặc định.

| Parameter          |    Default |
| ------------------ | ---------: |
| Use Break Even     |       true |
| Break Even Trigger | 150 points |
| Break Even Level   |   0 points |

Khi giá đi đúng hướng ít nhất `150 points`, EA có thể di chuyển Stop Loss về giá vào lệnh.

Với `BreakEvenLevel = 0`:

```text
New SL = Entry Price
```

---

## Trailing Stop

Trailing Stop được bật mặc định.

| Parameter      |    Default |
| -------------- | ---------: |
| Use Trailing   |       true |
| Trailing Start | 200 points |
| Trailing Step  |  50 points |

Trailing chỉ bắt đầu sau khi vị thế đạt mức lợi nhuận tối thiểu được cấu hình.

Stop Loss sau đó được cập nhật khi mức thay đổi đủ lớn so với `TrailingStep`.

---

## Position & Order Control

EA mặc định chỉ cho phép tối đa:

```text
1 open position
```

cho cùng:

* Symbol
* Magic Number

Default Magic Number:

```text
123456
```

---

## Spread Filter

EA kiểm tra spread trước khi tìm và thực thi tín hiệu.

Giá trị mặc định:

```text
Max Spread = 25 points
```

Nếu:

```text
Current Spread > Max Spread
```

EA không mở giao dịch mới.

---

## Default Parameters

| Parameter             | Default | Description                  |
| --------------------- | ------: | ---------------------------- |
| `InpLotSize`          |    0.01 | Fixed lot size               |
| `InpStopLoss`         |     300 | Stop Loss in points          |
| `InpTakeProfit`       |     600 | Take Profit in points        |
| `InpMagicNumber`      |  123456 | EA Magic Number              |
| `InpSlippage`         |      10 | Maximum deviation            |
| `InpMaxSpreadPoints`  |      25 | Maximum allowed spread       |
| `InpMaxOrders`        |       1 | Maximum open positions       |
| `InpUseBreakEven`     |    true | Enable Break Even            |
| `InpBreakEvenTrigger` |     150 | Break Even activation        |
| `InpBreakEvenLevel`   |       0 | Break Even SL offset         |
| `InpUseTrailing`      |    true | Enable Trailing Stop         |
| `InpTrailingStart`    |     200 | Trailing activation          |
| `InpTrailingStep`     |      50 | Minimum trailing update step |

---

## Execution Flow

```text
New Bar
   ↓
Check Maximum Open Positions
   ↓
Check Spread
   ↓
Calculate EMA 50 Trend
   ↓
Detect Inside Bar
   ↓
Check Mother Bar Breakout
   ↓
BUY / SELL
   ↓
Apply SL + TP
   ↓
Break Even
   ↓
Trailing Stop
```

---

## Current Research Status

This EA should currently be treated as a **research/backtest implementation**, not as a production-ready trading system.

The current parameter values are baseline values and have not been established by this README as optimal for XAUUSD.

Further validation should include:

* MetaTrader 5 compilation test
* Strategy Tester backtest
* Multiple timeframe testing
* Spread sensitivity
* Parameter robustness
* Out-of-sample testing
* Drawdown analysis
* Profit Factor analysis
* Trade-count analysis
* Forward testing

---

## Known Implementation Notes

The current implementation evaluates new trade signals only when a **new bar** is detected.

The strategy uses:

```text
PERIOD_CURRENT
```

Therefore, behavior and results depend directly on the timeframe of the chart or Strategy Tester configuration.

EMA 50 is currently hard-coded in the strategy logic rather than exposed as an input parameter.

The strategy currently uses fixed lot sizing rather than percentage-based risk sizing.

The current implementation should be independently verified through compilation and backtesting before any live-trading use.

---

## Repository Location

```text
EAs/
└── EA-041_Inside_Pullback_Trend/
    ├── EA-041_Inside_Pullback_Trend.mq5
    └── README.md
```

Backtest results for this EA should be stored separately under:

```text
Backtest/
└── EA-041_Inside_Pullback_Trend/
```

---

## Disclaimer

This project is for research, development, and testing purposes.

Historical backtest performance does not guarantee future trading performance. The EA should not be considered validated for live trading until it has passed the defined backtest, robustness, and forward-testing process.
