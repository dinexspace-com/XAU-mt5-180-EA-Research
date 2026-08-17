# Quantitative Research & Optimization Journal

Thư mục ghi nhận kết quả nghiên cứu định lượng, phân tích hiệu suất và lộ trình cải tiến các thuật toán EA cho thị trường XAUUSD.

---

## 1. Ongoing EA Evaluations

### EA-007: EMA 9/50 Pullback (M1)

* **Trạng thái:** Đã hoàn thành Backtest giai đoạn 1 (01/2026 - 05/2026)[cite: 1].
* **Đánh giá sơ bộ:**
  * Profit Factor đạt 0.85, Win Rate 46.14%, Sharpe Ratio -5.00[cite: 1].
  * Tần suất giao dịch quá cao (5,048 lệnh / 4 tháng ~ 40-50 lệnh/ngày)[cite: 1], dẫn đến chi phí spread, commission và hiện tượng whipsaw (bẫy nhiễu giá) trên khung M1 bào mòn tài khoản nhanh chóng[cite: 1].
  * Drawdown tối đa rất cao (99.32% / $994.86)[cite: 1], dù đã bật BreakEven và Trailing Stop[cite: 1] nhưng tỷ lệ Risk/Reward thực tế bị lệch (lãi trung bình $2.37 < lỗ trung bình -$2.40)[cite: 1] làm cho kỳ vọng lợi nhuận âm (-$0.20/lệnh)[cite: 1].
* **Hướng tối ưu (Next Steps):**
  * **Thêm bộ lọc xu hướng khung lớn (Multi-Timeframe Filter):** Tích hợp EMA 200 trên khung M15 hoặc H1 để chỉ giao dịch thuận theo xu hướng chủ đạo.
  * **Thêm bộ lọc biến động & tích lũy:** Sử dụng các chỉ báo Volatility / ATR / ADX để lọc các giai đoạn thị trường đi ngang (sideway) gây nhiễu tín hiệu crossover.
  * **Chuyển đổi khung thời gian (Timeframe Scale):** Tăng khung thời gian giao dịch lên M5 hoặc M15 nhằm giảm số lượng lệnh nhiễu và tối ưu hóa khoảng cách SL/TP.
  * **Tinh chỉnh tham số R:R:** Điều chỉnh lại khoảng cách `InpTakeProfit`, `InpBreakEvenTrigger` và `InpTrailingStart` để cải thiện tỷ lệ Risk/Reward và bảo vệ lợi nhuận sớm hơn.

---

## 2. Methodology & Guidelines

* Tất cả thử nghiệm backtest đều phải thực hiện trên dữ liệu 100% Real Ticks[cite: 1].
* Quản lý rủi ro cố định per trade, kiểm soát spread ≤30 points trước khi khớp lệnh[cite: 1].
* Mọi thay đổi về logic hoặc tham số tối ưu đều phải được ghi lại trong thư mục `backtest/` tương ứng trước khi cập nhật mã nguồn chính tại `EAs/`.
