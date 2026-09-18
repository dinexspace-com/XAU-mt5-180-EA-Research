# Expert Advisors (EAs)

Thư mục này chứa source code của các Expert Advisor (EA) được phát triển và kiểm thử trong repository `xauusd-mt5-ea-research`.

Mỗi EA được lưu trong một thư mục riêng để source code, tài liệu kỹ thuật và lịch sử phát triển không bị trộn lẫn với các EA khác.

## Structure

```text
EAs/
├── README.md
│
├── EA-067_Breakout_EMA_Filter/
│   ├── EA-067_Breakout_EMA_Filter.mq5
│   └── README.md
│
└── EA-XXX_Strategy_Name/
    ├── EA-XXX_Strategy_Name.mq5
    └── README.md
```

## Naming Convention

Mỗi EA sử dụng cấu trúc tên:

```text
EA-<ID>_<Strategy_Name>
```

Ví dụ:

```text
EA-067_Breakout_EMA_Filter
```

Trong đó:

* `EA-067` — mã định danh của EA.
* `Breakout` — logic giao dịch chính.
* `EMA_Filter` — bộ lọc tín hiệu được sử dụng.

Tên thư mục và tên source `.mq5` phải giống nhau.

## EA Source

Source code chính của mỗi EA được viết bằng MQL5 và chạy trên MetaTrader 5.

Ví dụ:

```text
EA-067_Breakout_EMA_Filter/
└── EA-067_Breakout_EMA_Filter.mq5
```

Source code chịu trách nhiệm cho:

* Signal generation
* Entry logic
* Position management
* Stop Loss / Take Profit
* Break-even
* Trailing Stop
* Spread filtering
* Broker execution constraints
* Magic Number identification
* Risk and execution parameters

Chi tiết chiến lược và parameters của từng EA được mô tả trong `README.md` nằm trong chính thư mục EA đó.

## Current EA

### EA-067_Breakout_EMA_Filter

EA sử dụng chiến lược breakout kết hợp EMA filter.

Logic chính:

```text
Price Data
    ↓
Breakout Detection
    ↓
EMA Filter
    ↓
BUY / SELL Signal
    ↓
Execution Filters
    ↓
Market Order
    ↓
SL / TP
    ↓
Break-even / Trailing Stop
```

EA chỉ đánh giá tín hiệu mới khi xuất hiện candle mới trên timeframe được cấu hình.

Source:

```text
EAs/EA-067_Breakout_EMA_Filter/EA-067_Breakout_EMA_Filter.mq5
```

## Backtest Separation

Source code EA và kết quả backtest được tách riêng.

```text
EAs/
└── EA-067_Breakout_EMA_Filter/
    └── EA-067_Breakout_EMA_Filter.mq5

Backtest/
└── EA-067_Breakout_EMA_Filter/
```

`EAs/` chỉ chứa source code và tài liệu trực tiếp của EA.

Các report, optimization results, screenshots và dữ liệu kiểm thử phải được lưu trong `Backtest/`.

## Research Separation

Các tài liệu nghiên cứu dùng để hình thành hoặc đánh giá chiến lược không lưu trong thư mục này.

Chúng được quản lý tại:

```text
Research/
```

Phương pháp nghiên cứu và backtest chung của repository được mô tả tại:

```text
docs/methodology.md
```

## Status

EA hiện có trong repository:

| EA                         | Strategy              | Platform            |
| -------------------------- | --------------------- | ------------------- |
| EA-067_Breakout_EMA_Filter | Breakout + EMA Filter | MetaTrader 5 / MQL5 |

Các EA mới sẽ được bổ sung theo cùng cấu trúc và naming convention.
