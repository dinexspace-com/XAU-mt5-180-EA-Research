# Quantitative Research & Optimization Journal

Thư mục ghi nhận kết quả nghiên cứu định lượng, phân tích hiệu suất và lộ trình cải tiến các thuật toán EA cho thị trường XAUUSD.

---

## 1. Ongoing EA Evaluations

### EA-014: Triple SMA 10/30/60 (M1)

* **Trạng thái:** Đã hoàn thành Backtest giai đoạn 1 (02/01/2026 - 01/06/2026)[cite: 1].
* **Đánh giá sơ bộ:**
  * **Hiệu suất chung:** Profit Factor đạt 0.84, Win Rate 48.29% (2,484 wins / 2,660 losses), Sharpe Ratio -5.00, Tổng Lợi nhuận Ròng -$992.73 trên vốn ban đầu $1,000[cite: 1].
  * **Tần suất giao dịch & Tốc độ sụt giảm:** Tổng số lệnh giao dịch cực kỳ lớn (5,144 lệnh / 5 tháng, trung bình ~50 lệnh/ngày) gây overtrading nặng nề trên khung M1[cite: 1]. Điều này làm gia tăng chi phí ma sát (spread/commission) và chịu nhiễu giá liên tục[cite: 1].
  * **Kỳ vọng toán học âm:** Trung bình lệnh thắng ($2.09) nhỏ hơn trung bình lệnh thua (-$2.32), dẫn đến kỳ vọng lợi nhuận âm -$0.19/lệnh[cite: 1]. 
  * **Sụt giảm tài khoản (Max Drawdown):** Tỷ lệ sụt giảm tối đa lên tới 99.30% ($1,030.26 / $1,032.35), tài khoản gần như sụt giảm hoàn toàn[cite: 1].
  * **Nhiễu tín hiệu:** Tín hiệu giao cắt bộ ba SMA (10/30/60) bị trễ do bản chất chỉ báo động lượng, dẫn đến tình trạng dính nhiễu quét (whipsaw) và chịu chuỗi thua liên tiếp khi thị trường XAUUSD đi ngang/tích lũy[cite: 1].
  * **Thời gian giữ lệnh:** Thời gian trung bình giữ vị thế rất ngắn (00:03:31), trong khi thời gian giữ vị thế tối đa là 03:32:23[cite: 1].
* **Hướng tối ưu (Next Steps):**
  * **Lọc nhiễu & Khung thời gian:** Tích hợp bộ lọc xu hướng từ khung lớn (như M5/M15) hoặc các chỉ báo đo độ mạnh xu hướng (ADX/ATR) để tránh vào lệnh trong giai đoạn sideway.
  * **Điều chỉnh R:R & Trailing:** Tối ưu lại khoảng Stop Loss / Take Profit nhằm gia tăng tỷ lệ Reward:Risk > 1.5, đồng thời mở rộng khoảng Break Even để giá có dư địa biến động.
  * **Quản lý rủi ro:** Thêm cơ chế Daily Max Loss (giới hạn lỗ tối đa trong ngày) và giới hạn số lượng lệnh tối đa mỗi ngày để bảo vệ tài khoản khỏi các đợt sụt giảm dây chuyền.

---

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

* Tất cả thử nghiệm backtest đều phải thực hiện trên dữ liệu 100% Real Ticks[cite: 1].
* Quản lý rủi ro cố định per trade, kiểm soát spread ≤30 points trước khi khớp lệnh.
* Mọi thay đổi về logic hoặc tham số tối ưu đều phải được ghi lại trong thư mục `Backtest/` tương ứng trước khi cập nhật mã nguồn chính tại `EAs/`.
