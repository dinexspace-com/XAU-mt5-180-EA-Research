# EA-025 — Donchian Midline

Expert Advisor (EA) cho MetaTrader 5 sử dụng **đường giữa (Midline) của Donchian Channel** để xác định hướng giao dịch.

## Strategy

EA tính Donchian Channel dựa trên Highest High và Lowest Low trong `InpDonchianPeriod`.

```text
Upper   = Highest High
Lower   = Lowest Low
Midline = (Upper + Lower) / 2
```

Logic vào lệnh:

* **BUY:** Ask > Donchian Midline
* **SELL:** Bid < Donchian Midline
* Chỉ kiểm tra tín hiệu khi xuất hiện **nến mới**
* Không mở lệnh mới nếu đã tồn tại position có cùng Magic Number
* Không giao dịch nếu spread vượt giới hạn cho phép

## Default Parameters

| Parameter           | Default | Description                      |
| ------------------- | ------: | -------------------------------- |
| `InpLotSize`        |    0.01 | Khối lượng giao dịch             |
| `InpStopLoss`       |     300 | Stop Loss (points)               |
| `InpTakeProfit`     |     600 | Take Profit (points)             |
| `InpMagicNumber`    |  123456 | Magic Number                     |
| `InpSlippage`       |      10 | Slippage (points)                |
| `InpUseBreakEven`   |    true | Bật Break Even                   |
| `InpBreakEvenPoint` |     150 | Ngưỡng kích hoạt Break Even      |
| `InpUseTrailing`    |    true | Bật Trailing Stop                |
| `InpTrailingPoint`  |     200 | Ngưỡng/khoảng cách Trailing Stop |
| `InpMaxSpread`      |      30 | Spread tối đa cho phép (points)  |
| `InpDonchianPeriod` |      20 | Chu kỳ Donchian Channel          |

## Risk & Position Management

EA sử dụng:

* Fixed Lot Size
* Fixed Stop Loss
* Fixed Take Profit
* Spread Filter
* Break Even
* Trailing Stop
* Magic Number để nhận diện position của EA
* Kiểm tra quyền giao dịch và free margin trước khi vào lệnh

### Break Even

Khi lợi nhuận đạt `InpBreakEvenPoint`, Stop Loss được chuyển về giá mở lệnh.

### Trailing Stop

Khi lợi nhuận đạt `InpTrailingPoint`, EA bắt đầu cập nhật Stop Loss theo giá hiện tại.

## Execution Flow

```text
New Bar
   ↓
Calculate Donchian Channel
   ↓
Check Spread
   ↓
Check Existing Position
   ↓
Check Account / Margin
   ↓
Compare Price vs Donchian Midline
   ↓
BUY / SELL
```

## Files

```text
EA-025_Donchian_Midline/
├── EA-025_Donchian_Midline.mq5
└── README.md
```

## Platform

* MetaTrader 5
* Language: MQL5
* Trade library: `Trade/Trade.mqh`

## Research Status

This EA is part of the **XAUUSD MT5 EA Research** project.

The strategy should be evaluated through historical backtesting and out-of-sample testing before any consideration for live deployment.

Backtest results are maintained separately in:

```text
Backtest/EA-025_Donchian_Midline/
```

## Disclaimer

This repository is for **research and educational purposes only**.

Historical or backtested performance does not guarantee future results. The EA should not be used with real capital without independent validation, appropriate risk controls, and forward testing.
