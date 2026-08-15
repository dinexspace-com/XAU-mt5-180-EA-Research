# Quy trình & Phương pháp luận Đánh giá EA (EA Evaluation Methodology)

Tài liệu này quy định tiêu chuẩn kỹ thuật, quy trình kiểm thử (Backtest) và tiêu chí đánh giá cho tất cả các Expert Advisor (EA) thuộc dự án `xauusd-mt5-ea-research`.

---

## 1. Tiêu chuẩn Dữ liệu & Môi trường Backtest

Để đảm bảo kết quả backtest phản ánh chính xác nhất thực tế giao dịch:

* **Chất lượng dữ liệu (History Quality):** Bắt buộc đạt **100% real ticks** (Dữ liệu Tick thực từ sàn).
* **Cặp tiền thử nghiệm:** XAUUSD (Gold).
* **Chi phí giao dịch (Spread & Swap):**
  * Spread lọc đầu vào: Tối đa `30 points` (0.3 pip cho XAUUSD).
  * Chịu chi phí Swap thực tế theo đêm.
* **Đòn bẩy & Vốn:**
  * Vốn giả định: `$1,000` hoặc `$10,000`.
  * Đòn bẩy: `1:500`.

---

## 2. Bộ Tiêu chí Đánh giá Hiệu suất (KPI Standards)

Một EA chỉ được coi là **Đạt chuẩn (Passed)** để cân nhắc chuyển sang giai đoạn Forward Test (Demo/Live) nếu đáp ứng đầy đủ các tiêu chuẩn tối thiểu sau:

| Chỉ số (Metric) | Yêu cầu tối thiểu (Minimum Standard) | Mục tiêu tối ưu (Optimal Target) |
| :--- | :--- | :--- |
| **Profit Factor (PF)** | $\ge 1.30$ | $\ge 1.50$ |
| **Max Drawdown (Relative)** | $\le 20.0\%$ | $\le 15.0\%$ |
| **Total Trades (Số lệnh)** | $\ge 100$ lệnh / năm | $\ge 200$ lệnh / năm |
| **Win Rate** | Đặt trong mối tương quan với Risk:Reward |
| **Sharpe Ratio** | $> 1.0$ | $> 1.5$ |
| **Recovery Factor** | $> 2.0$ | $> 3.0$ |

---

## 3. Quy trình Kiểm thử 4 Bước (4-Step Testing Pipeline)

1. **Step 1: Baseline Test (Chạy nguyên mẫu)**
   * Chạy EA với các thông số gốc (default) không bật tính năng quản lý lệnh nâng cao.
   * Mục đích: Đánh giá lợi thế tự nhiên của thuật toán vào lệnh.

2. **Step 2: Risk Management Integration (Tích hợp quản lý rủi ro)**
   * Bật các tính năng: Break Even, Trailing Stop, Max Spread Filter, Time Filter.
   * Mục đích: Bảo toàn lợi nhuận và giảm thiểu Drawdown.

3. **Step 3: Parameter Optimization (Tối ưu hóa tham số)**
   * Chạy Optimization trên MT5 bằng thuật toán Di truyền (Genetic Algorithm).
   * Áp dụng **Walk-Forward Analysis (WFA)**:
     * *In-Sample (IS):* 70% dữ liệu dùng để tối ưu.
     * *Out-Of-Sample (OOS):* 30% dữ liệu dùng để kiểm tra chống Overfitting (Học vẹt dữ liệu).

4. **Step 4: Forward Test (Test thời gian thực)**
   * Chạy EA trên tài khoản Demo real-time tối thiểu từ 1 - 3 tháng trước khi đánh giá tổng kết.
