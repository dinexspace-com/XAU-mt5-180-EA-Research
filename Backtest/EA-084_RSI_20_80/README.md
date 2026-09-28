📊 Backtest Engine & Strategy Testing Module

Thư mục này chứa các kịch bản (scripts), dữ liệu lịch sử (historical data), cấu hình tham số (preset files) và các công cụ phân tích kết quả phục vụ cho quá trình Backtest & Optimization cho EA (Expert Advisor) trên nền tảng MetaTrader (MT4/MT5) hoặc Python.

📁 Cấu trúc Thư mục

Backtest/
├── data/                  # Dữ liệu giá lịch sử (Tick data / M1 data)
│   ├── raw/               # Dữ liệu thô tải về từ broker / Dukascopy
│   └── processed/         # Dữ liệu đã xử lý / clean
├── presets/               # Các file cấu hình tham số (.set files)
│   ├── default.set        # Cấu hình mặc định
│   └── optimized_EURUSD.set # Cấu hình tối ưu cho EURUSD
├── reports/               # Báo cáo kết quả backtest (HTML, CSV, PDF)
│   └── images/            # Biểu đồ Drawdown, Equity curve
├── scripts/               # Các kịch bản hỗ trợ tự động hóa backtest
│   ├── convert_data.py    # Script chuyển đổi / chuẩn hóa định dạng dữ liệu
│   └── analyze_report.py  # Script phân tích chỉ số & vẽ biểu đồ
├── config.json            # Cấu hình cài đặt môi trường backtest
└── README.md              # Tài liệu hướng dẫn (File này)


🚀 Hướng dẫn Sử dụng

1. Chuẩn bị Dữ liệu Lịch sử (Data Preparation)

Tải dữ liệu chất lượng cao (Tick Data / Quality 99% hoặc 100% Real Ticks).

Đặt dữ liệu thô vào thư mục Backtest/data/raw/.

Chạy script chuẩn hóa dữ liệu (nếu cần):

python scripts/convert_data.py --input data/raw/EURUSD_M1.csv --output data/processed/


2. Thiết lập Tham số (Configuration & Presets)

Lưu các file cấu hình thông số kỹ thuật cho EA vào thư mục Backtest/presets/.

Quản lý phiên bản tham số theo từng cặp tiền và khung thời gian (VD: EURUSD_H1_v1.0.set).

3. Chạy Backtest

Trên MetaTrader (MT4 / MT5 Strategy Tester):

Mở Strategy Tester (Ctrl + R).

Chọn EA và cặp tiền muốn kiểm thử.

Chọn Model: Every tick based on real ticks (đối với MT5) hoặc Every tick (đối với MT4).

Tải file cấu hình tương ứng từ thư mục Backtest/presets/.

Bắt đầu chạy và xuất báo cáo vào thư mục Backtest/reports/.

Trên Python (Nếu sử dụng Backtesting Framework riêng):

python scripts/run_backtest.py --config config.json --preset presets/optimized_EURUSD.set


📈 Các Chỉ số Đánh giá Cần Lưu ý (Key Metrics)

Khi phân tích báo cáo kết quả trong reports/, tập trung vào các chỉ số trọng yếu sau:

Chỉ số (Metric)

Mô tả

Mục tiêu lý tưởng

Net Profit

Lợi nhuận ròng thu được

Dương & tăng trưởng đều

Profit Factor (PF)

Tỷ lệ Tổng Lãi / Tổng Lỗ

> 1.5

Max Drawdown (DD)

Mức sụt giảm tài khoản lớn nhất

< 15% - 20%

Sharpe Ratio

Tỷ lệ lợi nhuận trên rủi ro

> 1.0

Win Rate

Tỷ lệ lệnh thắng

Tùy thuộc vào Risk/Reward (R:R)

Expectancy

Kỳ vọng lợi nhuận trên mỗi lệnh

> 0

⚠️ Lưu ý Quan trọng (Disclaimer & Best Practices)

Overfitting (Curve Fitting): Tránh việc tối ưu hóa quá mức các tham số chỉ để khớp hoàn hảo với dữ liệu quá khứ. Luôn thực hiện Out-of-Sample (OOS) testing hoặc Forward testing.

Spread & Slippage: Đảm bảo cấu hình Spread và Slippage thực tế trong quá trình test (tránh dùng Fixed Spread cố định quá nhỏ so với thị trường thực tế).

Swap / Commission: Kiểm tra xem backtest đã tính phí qua đêm (Swap) và phí hoa hồng (Commission) của broker chưa.

📝 Nhật ký Cập nhật (Changelog)

v1.0.0 (2026-09-28): Khởi tạo cấu trúc thư mục Backtest và phát hành tài liệu hướng dẫn chuẩn.
