# Documentation

Thư mục `docs/` chứa các tài liệu phương pháp và quy định sử dụng trong quá trình phát triển, backtest và nghiên cứu Expert Advisors.

Mục tiêu của thư mục này là đảm bảo quá trình nghiên cứu có cấu trúc thống nhất và có thể truy xuất lại.

## Cấu trúc

```text
docs/
├── README.md
└── methodology.md
```

## methodology.md

File `methodology.md` là tài liệu chính mô tả phương pháp được sử dụng trong dự án.

Nội dung bao gồm:

* quy trình phát triển EA;
* quy trình chuẩn bị backtest;
* cách cấu hình Strategy Tester;
* cách ghi nhận kết quả;
* cách phân tích performance;
* cách so sánh các phiên bản EA;
* cách kiểm tra tính nhất quán của kết quả;
* các giới hạn của backtest và nghiên cứu.

## Research Workflow

Quy trình tổng thể của repository:

```text
EA Development
      ↓
EA Source
      ↓
Backtest
      ↓
Backtest Result
      ↓
Research
      ↓
Analysis
```

Mỗi bước phải có thể truy ngược về bước trước.

## Traceability

Một kết quả nghiên cứu phải xác định được:

```text
EA
↓
Version
↓
Configuration
↓
Symbol
↓
Timeframe
↓
Testing Period
↓
Backtest Result
↓
Research
```

Ví dụ với EA-085:

```text
EA-085_RSI_30_70
        ↓
XAUUSD.PRO
        ↓
M1
        ↓
2026.01.02 - 2026.03.31
        ↓
Strategy Tester Report
        ↓
Research
```

## Documentation Principles

### 1. Reproducibility

Thông tin cần thiết để tái hiện một thử nghiệm phải được ghi nhận.

### 2. Consistency

Các EA và backtest phải sử dụng cách ghi nhận thống nhất.

### 3. Traceability

Kết quả phải truy ngược được về source code và cấu hình tương ứng.

### 4. Version Control

Những thay đổi đối với source code, phương pháp hoặc cấu hình nghiên cứu phải được quản lý thông qua Git.

### 5. Raw Data Preservation

Kết quả gốc từ Strategy Tester phải được giữ nguyên.

Các phân tích hoặc phép tính bổ sung phải được phân biệt với dữ liệu gốc.

## Relationship

```text
EAs/
├── Source Code
│
├───────────────→ Backtest/
│                   │
│                   └── Tester Results
│
└────────────────────────→ Research/
                             │
                             └── Analysis

docs/
└── Methodology
```

`docs/` không chứa source code EA hoặc kết quả backtest. Thư mục này chỉ chứa tài liệu hướng dẫn và phương pháp được sử dụng chung cho dự án.
