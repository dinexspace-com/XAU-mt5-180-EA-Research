# Quantitative Research & Optimization Journal

Thư mục ghi nhận kết quả nghiên cứu định lượng, phân tích hiệu suất và lộ trình cải tiến các thuật toán EA cho thị trường XAUUSD.

---

## 1. Ongoing EA Evaluations

### **EA-006: EMA 5/20 Pullback (M1)**
- **Trạng thái:** Đã hoàn thành Backtest giai đoạn 1 (01/2026 - 04/2026).
- **Đánh giá sơ bộ:** 
  - Profit Factor đạt **0.91**, Win Rate **31.83%**, Sharpe Ratio **-5.00**.
  - Tần suất giao dịch quá cao (**4,901 lệnh / 3 tháng** ~ 54 lệnh/ngày), dẫn đến chi phí spread, commission và hiện tượng *whipsaw* (bẫy nhiễu giá) trên khung M1 bào mòn tài khoản nhanh chóng.
  - Drawdown tối đa rất cao (**99.25%** / **$1,066.68**), cho thấy hệ thống thiếu bộ lọc xu hướng lớn và cơ chế bảo vệ rủi ro hiệu quả.
- **Hướng tối ưu (Next Steps):**
  1. **Thêm bộ lọc xu hướng khung lớn (Multi-Timeframe Filter):** Tích hợp EMA 200 trên khung M15 hoặc H1 để chỉ giao dịch thuận theo xu hướng chủ đạo.
  2. **Tối ưu hóa quản lý lệnh:** Kích hoạt và tối ưu tham số BreakEven/Trailing Stop (`InpUseBreakEven=true`, `InpUseTrailingStop=true`) để bảo vệ lợi nhuận khi giá chạy đúng hướng.
  3. **Thêm bộ lọc biến động & tích lũy:** Sử dụng các chỉ báo Volatility/ATR/ADX để lọc các giai đoạn thị trường đi ngang (sideway) gây nhiễu tín hiệu crossover.
  4. **Kiểm soát tần suất vào lệnh:** Giới hạn số lượng lệnh tối đa mỗi ngày hoặc yêu cầu khoảng cách tối thiểu giữa các lệnh liên tiếp.

---

## 2. Methodology & Guidelines
- Tất cả thử nghiệm backtest đều phải thực hiện trên dữ liệu **100% Real Ticks**.
- Quản lý rủi ro cố định per trade, kiểm soát spread $\le 30$ points trước khi khớp lệnh.
- Mọi thay đổi về logic hoặc tham số tối ưu đều phải được ghi lại trong thư mục `Backtest/` tương ứng trước khi cập nhật mã nguồn chính tại `EAs/`.
