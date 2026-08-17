# Quantitative EA Development Methodology

Tài liệu này quy định các tiêu chuẩn và quy trình bắt buộc khi phát triển, kiểm thử và quản lý mã nguồn các Robot giao dịch (EA) cho thị trường XAUUSD trên nền tảng MetaTrader 5 (MT5).

---

## 1. Coding & Architecture Standards

- **Ngôn ngữ:** MQL5 (định dạng `.mq5`).
- **Thư viện chuẩn:** Ưu tiên sử dụng thư viện `<Trade\Trade.mqh>` để thực thi giao dịch.
- **Quản lý rủi ro:**
  - Mọi lệnh phải có điểm dừng lỗ (Stop Loss) và chốt lời (Take Profit) xác định ngay khi khởi tạo.
  - Sử dụng tham số `InpMaxSpread` để lọc biến động giá xấu trước khi vào lệnh.
  - Mỗi EA phải cài đặt `InpMagicNumber` riêng biệt để quản lý vị thế độc lập.
- **Xử lý Nến (Bar Control):** Sử dụng cơ chế kiểm tra `lastBarTime` để đảm bảo logic vào lệnh chỉ chạy 1 lần duy nhất khi nến mới mở (New Bar Event).

---

## 2. Backtesting Standards

Mọi kết quả backtest lưu trữ tại thư mục `Backtest/` phải tuân thủ nghiêm ngặt các tham số cấu hình sau:

1. **Dữ liệu giá (Data Quality):** Bắt buộc sử dụng `100% Real Ticks` từ nhà môi giới uy tín.
2. **Tiền ký quỹ ban đầu (Initial Deposit):** Mặc định `$1,000` hoặc `$10,000`.
3. **Đòn đẩy (Leverage):** Chuẩn `1:500`.
4. **Mô phỏng rủi ro (Slippage & Spread):**
   - Đặt `InpMaxSpread = 30` points (3 pips).
   - Mô phỏng Slippage từ 10 - 20 points.

---

## 3. Evaluation Metrics Thresholds

Một EA được đánh giá là đạt chuẩn bước đầu để đưa vào thử nghiệm Forward/Demo nếu thỏa mãn các tiêu chí định lượng tối thiểu:

- **Profit Factor:** $\ge 1.30$
- **Win Rate:** $\ge 45\%$ (đối với chiến lược Risk:Reward $\ge 1:2$)
- **Max Equity Drawdown:** $\le 15\%$
- **Total Trades:** $\ge 100$ lệnh (để đạt ý nghĩa thống kê)

---

## 4. Repository Workflow

1. **Mã nguồn EA (`EAs/`):** Lưu trữ code `.mq5` và file `README.md` mô tả logic chi tiết.
2. **Báo cáo thử nghiệm (`Backtest/`):** Chứa file báo cáo chi tiết (`report.htm`), biểu đồ đồ họa và file `README.md` tổng hợp các chỉ số chính.
3. **Ghi chép nghiên cứu (`Research/`):** Lưu trữ định hướng cải tiến, ghi chú tối ưu tham số (Optimization).
