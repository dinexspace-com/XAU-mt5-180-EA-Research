# Quantitative Research & Optimization Journal

Thư mục ghi nhận kết quả nghiên cứu định lượng, phân tích hiệu suất và lộ trình cải tiến các thuật toán EA cho thị trường XAUUSD.

---

## 1. Ongoing EA Evaluations


### EA-012: Triple EMA 5/20/50 (M1)

* **Trạng thái:** Đã hoàn thành Backtest giai đoạn 1 (01/2026 - 06/2026).
* **Đánh giá sơ bộ:**
  * Profit Factor đạt 0.92, Win Rate 32.17% (1,973/6,133 lệnh), Sharpe Ratio -5.00, Tổng Lợi nhuận Ròng -$995.15.
  * Tần suất giao dịch quá cao (6,133 lệnh / 5 tháng, trung bình ~41 lệnh/ngày) gây ra hiện tượng overtrading nghiêm trọng trên khung M1, chịu ảnh hưởng nặng nề bởi chi phí spread và slippage.
  * Tỷ lệ thưởng/rủi ro đạt 1.95:1 ($6.10 / -$3.13) không đủ bù đắp cho Win Rate 32.17% (mức hòa vốn yêu cầu tối thiểu 2.11:1), dẫn đến kỳ vọng lợi nhuận -$0.16/lệnh.
  * Sụt giảm tài khoản (Maximal Drawdown) chạm ngưỡng cực hạn $1,049.50 (99.54%), tài khoản gần như cháy hoàn toàn. Bộ ba EMA nhanh (5/20/50) liên tục dính nhiễu quét (whipsaw) trong giai đoạn thị trường đi ngang.
* **Hướng tối ưu (Next Steps):**
  * **Bộ lọc xu hướng cấu trúc lớn:** Thêm EMA 200 trên M15/H1 làm điều kiện chặn lệnh counter-trend.
  * **Kích hoạt quản lý rủi ro tự động:** Bật `InpUseBreakEven = true` và `InpUseTrailing = true` để bảo toàn lợi nhuận ngắn hạn trong các cú bứt phá nhanh.
  * **Bộ lọc biến động/khối lượng:** Tích hợp bộ lọc ADX hoặc ATR để ngừng phát tín hiệu khi thị trường đi vào biên độ hẹp (low volatility).
  * **Giới hạn số lượng lệnh & Khung giờ:** Áp dụng giới hạn số lệnh tối đa/ngày và chỉ giao dịch trong phiên London/New York overlap.

---

## 2. Methodology & Guidelines

* Tất cả thử nghiệm backtest đều phải thực hiện trên dữ liệu 100% Real Ticks.
* Quản lý rủi ro cố định per trade, kiểm soát spread ≤30 points trước khi khớp lệnh.
* Mọi thay đổi về logic hoặc tham số tối ưu đều phải được ghi lại trong thư mục `Backtest/` tương ứng trước khi cập nhật mã nguồn chính tại `EAs/`.
