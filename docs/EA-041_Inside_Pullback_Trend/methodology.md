# Documentation & Technical Specifications

Thư mục này chứa toàn bộ tài liệu kỹ thuật, quy trình phát triển, hướng dẫn vận hành và các tiêu chuẩn kiểm thử dành cho hệ thống Expert Advisor (EA).

---

## 1. Cấu Trúc Thư Mục Docs

```
Docs/
├── architecture/         # Thiết kế kiến trúc phần mềm & sơ đồ luồng (Flowchart)
├── strategies/           # Mô tả chi tiết thuật toán & quy tắc vào/ra lệnh
├── testing-standards/    # Tiêu chuẩn backtest & tối ưu hóa (Optimization)
└── deployment/           # Hướng dẫn cài đặt, cấu hình & quản lý rủi ro trên VPS
```

---

## 2. Danh Mục Tài Liệu Chính

### Kiến Trúc & Mã Nguồn (`architecture/`)

* `mql5-framework-spec.md`: Cấu trúc Framework MQL5 tiêu chuẩn, quản lý thư viện và module lệnh.
* `risk-management-module.md`: Cơ chế quản lý vốn, Stop Loss/Take Profit, Trailing Stop và bộ lọc Max Spread.

### Chi Tiết Thuật Toán (`strategies/`)

* `ema-crossover-logic.md`: Quy tắc kỹ thuật cho các chiến lược giao cắt đường trung bình động (EMA/SMA).
* `inside-bar-pullback.md`: Logic nhận diện mô hình Inside Bar và xác nhận xu hướng chính.

### Tiêu Chuẩn Kiểm Thử (`testing-standards/`)

* `backtest-checklist.md`: Quy trình thực hiện backtest với dữ liệu 100% Real Ticks.
* `metrics-thresholds.md`: Bộ tiêu chí đánh giá EA:

  * Profit Factor > 1.2
  * Max Drawdown < 10%
  * Sharpe Ratio > 1.0

### Vận Hành & Triển Khai (`deployment/`)

* `vps-setup-guide.md`: Hướng dẫn thiết lập môi trường MetaTrader 5 trên VPS.
* `live-monitoring.md`: Quy trình theo dõi nhật ký lệnh (Logs) và xử lý sự cố kết nối.

---

## 3. Quy Chuẩn Đóng Góp Tài Liệu

1. Sử dụng định dạng **Markdown** chuẩn cho tất cả các tài liệu.
2. Mọi thay đổi trong thuật toán EA phải được cập nhật tương ứng vào thư mục `strategies/`.
3. Tài liệu mới cần bao gồm:

   * Mục đích
   * Thông số đầu vào (Inputs)
   * Logic xử lý
   * Ví dụ minh họa
