# Research

Thư mục này chứa các **nghiên cứu và phân tích** được thực hiện dựa trên source code EA và kết quả backtest.

Mục tiêu của Research là chuyển dữ liệu backtest thành thông tin có cấu trúc để đánh giá hành vi của chiến lược và phục vụ các thử nghiệm tiếp theo.

## Cấu trúc

```text
Research/
├── README.md
├── EA-001_<StrategyName>/
├── EA-002_<StrategyName>/
└── ...
```

Hoặc khi số lượng nghiên cứu tăng lên, có thể tổ chức theo từng chủ đề/thí nghiệm.

## Nội dung nghiên cứu

Mỗi nghiên cứu nên xác định rõ:

### 1. Research Question

Câu hỏi mà nghiên cứu cần trả lời.

Ví dụ:

* Chiến lược hoạt động như thế nào?
* Điều kiện nào tạo ra tín hiệu giao dịch?
* Thay đổi tham số ảnh hưởng như thế nào đến kết quả?
* Kết quả có thay đổi giữa các giai đoạn khác nhau không?
* Drawdown và phân bố lợi nhuận thay đổi như thế nào?

### 2. Hypothesis

Giả thuyết được đặt ra trước khi thực hiện thử nghiệm.

Giả thuyết phải được phân biệt với kết quả thực tế.

### 3. Experimental Setup

Ghi lại cấu hình của thí nghiệm:

* EA;
* version;
* Symbol;
* Timeframe;
* Testing Period;
* Initial Deposit;
* Lot Size;
* Stop Loss;
* Take Profit;
* Break Even;
* Trailing Stop;
* các tham số chiến lược.

### 4. Data

Ghi nhận nguồn dữ liệu và chất lượng dữ liệu được sử dụng trong backtest.

Ví dụ với EA-085:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026.01.02 - 2026.03.31
History Quality: 100% real ticks
Bars: 85,161
Ticks: 39,639,179
```

Các thông tin này được lấy từ Strategy Tester Report.

### 5. Results

Kết quả phải được ghi lại bằng số liệu từ backtest.

Các chỉ số có thể bao gồm:

* Net Profit;
* Gross Profit;
* Gross Loss;
* Profit Factor;
* Drawdown;
* Recovery Factor;
* Sharpe Ratio;
* Total Trades;
* Profit Trades;
* Loss Trades;
* Average Profit Trade;
* Average Loss Trade;
* Maximum Consecutive Wins;
* Maximum Consecutive Losses;
* Position Holding Time.

### 6. Analysis

Phân tích phải dựa trên dữ liệu đã ghi nhận.

Cần phân biệt:

```text
Observed Data
     ↓
Analysis
     ↓
Interpretation
```

Không trình bày nhận định như một số liệu nếu nhận định đó không xuất phát trực tiếp từ Strategy Tester Report.

## EA-085 Research Baseline

EA-085 sử dụng RSI với:

```text
RSI Period = 14
RSI Lower  = 30
RSI Upper  = 70
```

Cấu hình backtest cũng sử dụng:

```text
Stop Loss       = 300
Take Profit     = 600
Break Even      = enabled
Break Even Trigger = 150
Trailing Stop   = enabled
Trailing Start  = 200
Trailing Distance = 100
Trailing Step   = 10
```

Các giá trị trên được ghi trong report.

## Nguyên tắc nghiên cứu

### Reproducibility

Một nghiên cứu phải cung cấp đủ thông tin để có thể xác định lại:

* EA;
* phiên bản;
* tham số;
* dữ liệu;
* timeframe;
* testing period;
* kết quả.

### Data First

Kết quả phải được trình bày trước khi đưa ra diễn giải.

### No Silent Changes

Không thay đổi dữ liệu backtest mà không ghi nhận.

### Version Tracking

Khi source code hoặc cấu hình thay đổi, nghiên cứu tương ứng phải xác định rõ phiên bản mới.

## Liên kết với các thư mục khác

```text
EAs/
  │
  ├── EA source
  │
  ↓
Backtest/
  │
  ├── Tester result
  │
  ↓
Research/
  │
  └── Analysis
  │
  ↓
docs/
  └── Methodology
```

Research sử dụng dữ liệu từ `Backtest/` và tham chiếu source trong `EAs/`.

Các quy tắc phương pháp luận được quản lý trong `docs/`.
