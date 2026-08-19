# Quantitative Research & Optimization Journal

Thư mục ghi nhận kết quả nghiên cứu định lượng, phân tích hiệu suất và lộ trình cải tiến các thuật toán EA cho thị trường XAUUSD.

---

## 1. Ongoing EA Evaluations



### EA-011: EMA 50/200 Retest (M1)

* **Trạng thái:** Đã hoàn thành Backtest giai đoạn 1 (01/2026 - 06/2026).
* **Đánh giá sơ bộ:**
  * Profit Factor đạt 0.91, Win Rate 30.69% (282/919 lệnh), Sharpe Ratio -5.00, Tổng Lợi nhuận Ròng -$179.95.
  * Tỷ lệ Win Rate thấp (30.69%) trong khi tỷ lệ thưởng/rủi ro trung bình (Win/Loss ratio) đạt 2.05:1 ($6.39 / -$3.11), chưa đủ để hòa vốn (cần tối thiểu 2.26:1), dẫn đến kỳ vọng lợi nhuận âm (-$0.20/lệnh).
  * Biên độ sụt giảm tài khoản (Maximal Drawdown) ở mức $298.81 (29.18%), số lệnh thua liên tiếp tối đa là 14 lệnh (-$41.98).
  * Hiện tượng Whipsaw trên khung M1 gây ra nhiều tín hiệu phá vỡ giả (false breakout) trước khi xu hướng thực sự hình thành. Cả hai tính năng BreakEven và Trailing Stop đều đang tắt (`false`), làm trôi mất lợi nhuận tạm tính trước khi giá quay đầu chạm SL.
* **Hướng tối ưu (Next Steps):**
  * **Thêm bộ lọc xu hướng khung lớn (Higher Timeframe Trend Filter):** Bắt buộc EMA 50/200 trên khung H1 hoặc M15 phải cùng hướng slope trước khi mở lệnh retest ở M1.
  * **Kích hoạt quản lý rủi ro động (Dynamic Risk Management):** Bật `InpUseBreakEven = true` (`InpBreakEvenTriggerPoints = 150-200`) và `InpUseTrailingStop = true` để khóa lợi nhuận sớm khi giá bật nhanh.
  * **Xác nhận tín hiệu Retest:** Kết hợp bộ lọc động lượng/chỉ báo dao động (RSI hoặc Stochastic) tại điểm chạm EMA 50/200 thay vì chỉ dựa vào khoảng cách giá.
  * **Bộ lọc khung giờ giao dịch (Time-of-Day Filter):** Giới hạn thời gian vào lệnh trong các phiên giao dịch biến động cao (London / New York overlap) để tránh tình trạng nhiễu sideway trong phiên Á.

---

## 2. Methodology & Guidelines

* Tất cả thử nghiệm backtest đều phải thực hiện trên dữ liệu 100% Real Ticks.
* Quản lý rủi ro cố định per trade, kiểm soát spread ≤30 points trước khi khớp lệnh.
* Mọi thay đổi về logic hoặc tham số tối ưu đều phải được ghi lại trong thư mục `Backtest/` tương ứng trước khi cập nhật mã nguồn chính tại `EAs/`.
