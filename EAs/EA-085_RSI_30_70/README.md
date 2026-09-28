# EAs

Thư mục này chứa toàn bộ **Expert Advisors (EA)** được phát triển cho dự án nghiên cứu giao dịch XAUUSD trên MetaTrader 5.

Mỗi EA được quản lý độc lập theo mã EA và tên chiến lược để thuận tiện cho việc:

* quản lý source code;
* theo dõi phiên bản;
* mô tả logic chiến lược;
* backtest;
* so sánh kết quả giữa các EA;
* phục vụ quá trình nghiên cứu và phân tích.

## Cấu trúc

```text
EAs/
├── EA-001_<StrategyName>/
│   ├── EA-001_<StrategyName>.mq5
│   └── README.md
│
├── EA-002_<StrategyName>/
│   ├── EA-002_<StrategyName>.mq5
│   └── README.md
│
└── ...
```

## Quy ước đặt tên

Tên EA sử dụng cấu trúc:

```text
EA-<ID>_<StrategyName>
```

Ví dụ:

```text
EA-085_RSI_30_70
```

Trong đó:

* `EA-085`: mã định danh của EA;
* `RSI_30_70`: tên hoặc mô tả ngắn của chiến lược.

## Nội dung của mỗi EA

Mỗi thư mục EA tối thiểu gồm:

### 1. Source code

File `.mq5` chứa mã nguồn Expert Advisor.

Ví dụ:

```text
EA-085_RSI_30_70.mq5
```

### 2. README

File `README.md` mô tả EA, bao gồm:

* tên EA;
* mục đích;
* logic giao dịch;
* các tham số;
* quản lý vị thế;
* thông tin phiên bản;
* các ghi chú liên quan đến nghiên cứu.

## Quan hệ với Backtest

Kết quả kiểm thử của từng EA không lưu trực tiếp trong thư mục `EAs/`.

Kết quả backtest được lưu trong:

```text
Backtest/
```

Ví dụ:

```text
EAs/
└── EA-085_RSI_30_70/

Backtest/
└── EA-085_RSI_30_70/
```

Cách tổ chức này giúp phân biệt rõ:

```text
EA Source
    ↓
Backtest
    ↓
Research
```

## Nguyên tắc quản lý

Source code trong thư mục này là nguồn gốc của từng phiên bản EA.

Khi code thay đổi đáng kể về logic hoặc tham số nghiên cứu, phiên bản thay đổi phải được ghi nhận trong Git để có thể truy xuất lại:

* EA nào được sử dụng;
* phiên bản nào được backtest;
* kết quả nào tương ứng với phiên bản đó.

## EA hiện có

| EA                 | Strategy  |
| ------------------ | --------- |
| `EA-085_RSI_30_70` | RSI 30/70 |

Các EA mới sẽ được bổ sung theo cùng quy ước.
