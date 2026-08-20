# Quantitative Research & Optimization Journal

Thư mục ghi nhận kết quả nghiên cứu định lượng, phân tích hiệu suất và lộ trình cải tiến các thuật toán EA cho thị trường XAUUSD.

---

## 1. Ongoing EA Evaluations


### EA-013: Triple EMA 10/30/100 (M1)

* **Trạng thái:** Đã hoàn thành Backtest giai đoạn 1 (01/2026 - 06/2026).
* **Đánh giá sơ bộ:**
  * Profit Factor đạt 0.84, Win Rate 48.26% (2,516/5,213 lệnh), Sharpe Ratio -5.00, Tổng Lợi nhuận Ròng -$994.79.
  * Tần suất giao dịch cao (5,213 lệnh / 5 tháng, trung bình ~50 lệnh/ngày) gây overtrading mạnh trên khung M1, liên tục chịu ma sát chi phí spread (MaxSpread=30 points).
  * Kỳ vọng toán học âm khi trung bình lệnh thắng ($2.10) nhỏ hơn trung bình lệnh thua (-$2.33), kết hợp với tần suất vào lệnh cao khiến tài khoản bị bào mòn nhanh chóng.
  * Sụt giảm tài khoản (Maximal Drawdown) chạm 99.50% ($1,026.54), tài khoản gần như cháy hoàn toàn. Tín hiệu giao cắt 10/30/100 bị trễ và liên tục dính nhiễu quét (whipsaw) trong giai đoạn thị trường tích lũy/đi ngang (chuỗi thua tối đa 14 lệnh liên tiếp / -$40.99).
  * Việc kích hoạt Break Even (150 points / $1.50) và Trailing Stop (200 points / $2.00) quá chặt khiến lệnh bị đóng sớm do độ nhiễu bình thường của XAUUSD trước khi chạm tới Take Profit (600 points / $6.00).
* **Hướng tối ưu (Next Steps):**
  * **Bộ lọc xu hướng & biến động:** Tích hợp bộ lọc ADX (ví dụ: ADX > 20/25) hoặc ngưỡng ATR để dừng giao dịch khi thị trường sideways; đồng thời yêu cầu xác nhận xu hướng từ khung thời gian lớn hơn (M5/M15 EMA 200).
  * **Tối ưu quản lý rủi ro & Trailing Logic:** Nới rộng khoảng kích hoạt Break Even (250–300 points) để giá có không gian biến động; nâng tỷ lệ R:R (SL 250, TP 750) để đưa kỳ vọng lợi nhuận lên mức dương.
  * **Kiểm soát thi hành:** Áp dụng giới hạn lỗ tối đa trong ngày (Daily Max Loss) hoặc giới hạn số lượng lệnh theo ngày để tránh sụt giảm tài khoản quá sâu trong những ngày thị trường biến động bất thường.

---

## 2. Methodology & Guidelines

* Tất cả thử nghiệm backtest đều phải thực hiện trên dữ liệu 100% Real Ticks.
* Quản lý rủi ro cố định per trade, kiểm soát spread ≤30 points trước khi khớp lệnh.
* Mọi thay đổi về logic hoặc tham số tối ưu đều phải được ghi lại trong thư mục `Backtest/` tương ứng trước khi cập nhật mã nguồn chính tại `EAs/`.
