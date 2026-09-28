# Backtest

Thư mục này chứa toàn bộ **kết quả backtest** của các Expert Advisors trong dự án.

Mục đích của thư mục là lưu lại kết quả kiểm thử theo cách có thể:

* truy xuất;
* kiểm tra;
* so sánh;
* tái hiện;
* sử dụng cho nghiên cứu.

## Cấu trúc

```text
Backtest/
├── EA-001_<StrategyName>/
│   ├── report.html
│   ├── report.png
│   └── README.md
│
├── EA-002_<StrategyName>/
│   ├── report.html
│   ├── report.png
│   └── README.md
│
└── ...
```

Tên thư mục backtest phải tương ứng với EA được kiểm thử.

Ví dụ:

```text
Backtest/
└── EA-085_RSI_30_70/
```

## Thông tin cần ghi nhận

Mỗi backtest cần lưu các thông tin chính:

### EA

* EA name;
* EA version;
* strategy;
* magic number.

### Market

* Symbol;
* Timeframe;
* Testing period;
* History Quality.

### Account

* Initial Deposit;
* Currency;
* Leverage;
* Lot Size.

### Trading Parameters

* Stop Loss;
* Take Profit;
* Break Even;
* Trailing Stop;
* các tham số chiến lược liên quan.

### Performance

* Total Net Profit;
* Gross Profit;
* Gross Loss;
* Profit Factor;
* Drawdown;
* Recovery Factor;
* Sharpe Ratio;
* Total Trades;
* Total Deals;
* Profit Trades;
* Loss Trades;
* các chỉ số khác có trong Strategy Tester Report.

## Ví dụ: EA-085_RSI_30_70

Backtest được ghi nhận trong tài liệu:

| Parameter       | Value                   |
| --------------- | ----------------------- |
| EA              | EA-085_RSI_30_70        |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Period          | 2026.01.02 – 2026.03.31 |
| Initial Deposit | 1,000 USD               |
| Leverage        | 1:500                   |
| Lot Size        | 0.01                    |
| History Quality | 100% real ticks         |
| Bars            | 85,161                  |
| Ticks           | 39,639,179              |

Các tham số chiến lược trong report gồm RSI Period `14`, RSI Lower `30`, RSI Upper `70`, Stop Loss `300`, Take Profit `600`, Break Even Trigger `150` và Trailing Stop Start `200`.

## Kết quả được ghi nhận

| Metric                   |         Result |
| ------------------------ | -------------: |
| Total Net Profit         |     -11.06 USD |
| Gross Profit             |   2,940.38 USD |
| Gross Loss               |  -2,951.44 USD |
| Profit Factor            |           1.00 |
| Balance Drawdown Maximal |         15.40% |
| Equity Drawdown Maximal  |         15.57% |
| Recovery Factor          |          -0.07 |
| Sharpe Ratio             |          -0.60 |
| Total Trades             |          2,502 |
| Total Deals              |          5,004 |
| Profit Trades            | 1,295 (51.76%) |
| Loss Trades              | 1,207 (48.24%) |

Các số liệu trên là số liệu từ Strategy Tester Report và không được tự điều chỉnh khi đưa vào repository.

## Nguyên tắc lưu kết quả

### Raw Result

Kết quả gốc từ MetaTrader 5 Strategy Tester phải được giữ nguyên.

Không chỉnh sửa các số liệu của report để làm đẹp kết quả.

### Research Result

Các phép tính bổ sung hoặc phân tích được thực hiện trong:

```text
Research/
```

### Methodology

Các quy tắc và phương pháp dùng để thực hiện backtest được mô tả trong:

```text
docs/
```

## Traceability

Mỗi kết quả backtest phải có thể truy ngược về EA source tương ứng:

```text
EAs/
   ↓
Backtest/
   ↓
Research/
```

Mục tiêu là đảm bảo mỗi kết quả đều xác định được:

* EA nào;
* phiên bản nào;
* tham số nào;
* symbol nào;
* timeframe nào;
* giai đoạn nào;
* kết quả nào.
