# Quantitative Research & Optimization Journal

Thư mục ghi nhận kết quả nghiên cứu định lượng, phân tích hiệu suất và lộ trình cải tiến các thuật toán EA cho thị trường XAUUSD.

---

## 1. Ongoing EA Evaluations

### EA-010: EMA 50/200 Trend (M1)

* **Trạng thái:** Đã hoàn thành Backtest giai đoạn 1 (01/2026 - 06/2026).
* **Đánh giá sơ bộ:**
  * Profit Factor đạt 0.94, Win Rate 32.40%, Sharpe Ratio -5.00, Tổng Lợi nhuận Ròng -$993.92.
  * Tần suất giao dịch cực kỳ cao (7,354 lệnh / 5 tháng ~ 49 lệnh/ngày), dẫn đến hiện tượng whipsaw (bẫy nhiễu giá) liên tục trên khung M1 do hai đường EMA 50 và EMA 200 liên tục giao cắt trong các giai đoạn thị trường đi ngang (sideway).
  * Drawdown tối đa rất cao (99.46% / $1,112.08) làm cháy tài khoản. Việc không bật BreakEven (`InpUseBreakEven=false`) và Trailing Stop (`InpUseTrailingStop=false`) khiến các lệnh đang có lời không được bảo vệ và bị đảo chiều chạm SL.
  * Chi phí giao dịch (spread và slippage) tích tụ lớn từ số lượng lệnh quá nhiều làm cho kỳ vọng lợi nhuận âm (-$0.14/lệnh).
* **Hướng tối ưu (Next Steps):**
  * **Thêm bộ lọc xu hướng khung lớn (Multi-Timeframe Filter):** Tích hợp EMA xu hướng trên khung M15 hoặc H1 để chỉ cho phép vào lệnh M1 thuận theo xu hướng chính.
  * **Thêm bộ lọc biến động & tích lũy:** Tích hợp chỉ báo ATR hoặc ADX để tạm ngưng vào lệnh trong giai đoạn thị trường tích lũy, biên độ hẹp.
  * **Kích hoạt công cụ quản lý lệnh động:** Bật BreakEven và Trailing Stop nhằm bảo vệ lợi nhuận sớm khi giá đi đúng hướng.
  * **Chuyển đổi khung thời gian (Timeframe Scale):** Thử nghiệm chiến lược trên khung thời gian lớn hơn (M5, M15 hoặc H1) để giảm số lượng lệnh nhiễu và loại bỏ chi phí spread không cần thiết.

---

## 2. Methodology & Guidelines

* Tất cả thử nghiệm backtest đều phải thực hiện trên dữ liệu 100% Real Ticks.
* Quản lý rủi ro cố định per trade, kiểm soát spread ≤30 points trước khi khớp lệnh.
* Mọi thay đổi về logic hoặc tham số tối ưu đều phải được ghi lại trong thư mục `Backtest/` tương ứng trước khi cập nhật mã nguồn chính tại `EAs/`.
