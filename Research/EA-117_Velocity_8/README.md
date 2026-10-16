# EA-117 — Velocity 8 Research Notes

## 1. Research Objective

Nghiên cứu EA-117 nhằm đánh giá chiến lược Price Velocity với `VelocityPeriod = 8` và `VelocityThreshold = 0.20%`, xác định các điểm cần điều tra và thiết lập kế hoạch thử nghiệm tiếp theo.

Nội dung này phân biệt giữa kết quả được báo cáo và giả thuyết cần kiểm chứng. Chưa có thử nghiệm nào trong kế hoạch dưới đây được xem là đã hoàn thành.

## 2. Baseline Summary

| Metric | Baseline #01 |
|---|---:|
| Net Profit | -$992.62 |
| Profit Factor | 0.90 |
| Relative Drawdown | 99.32% |
| Sharpe Ratio | -5.00 |
| Expected Payoff | -$0.14 |
| Total Trades | 7,128 |
| Win Rate | 44.46% |
| Average Holding Time | 35 seconds |

### Observations

- Kết quả tổng thể âm và drawdown gần 100%.
- Cả hai hướng BUY và SELL đều có tỷ lệ thắng thấp.
- Tần suất giao dịch cao so với thời gian kiểm thử.
- Thời gian giữ lệnh trung bình ngắn, do đó cần kiểm tra tác động của chi phí giao dịch.
- Kết quả này không chứng minh rằng chỉ cần điều chỉnh một tham số là có thể khắc phục chiến lược.

## 3. Research Hypotheses

### H1 — Velocity Period

Chu kỳ 8 nến có thể chưa phù hợp với hành vi giá trên XAUUSD.PRO M1.

**Cách kiểm tra:** So sánh các chu kỳ được lựa chọn trước, giữ nguyên các điều kiện còn lại và ghi nhận Net Profit, Profit Factor, Drawdown, Sharpe Ratio và số giao dịch.

### H2 — Velocity Threshold

Ngưỡng 0.20% có thể tạo ra tín hiệu chưa đủ chất lượng hoặc chưa phù hợp với phân phối biến động trong giai đoạn kiểm thử.

**Cách kiểm tra:** Đánh giá một tập hợp ngưỡng định trước. Không lựa chọn chỉ dựa trên mức lợi nhuận cao nhất của cùng một tập dữ liệu.

### H3 — Trade Frequency and Costs

EA thực hiện 7,128 giao dịch và có thời gian giữ lệnh trung bình 35 giây. Spread, slippage và các chi phí liên quan có thể ảnh hưởng đến hiệu quả.

**Cách kiểm tra:** Xác minh điều kiện chi phí của broker và so sánh các báo cáo với giả định thực thi phù hợp. Không quy toàn bộ khoản lỗ cho chi phí khi chưa có bằng chứng.

### H4 — Stop Loss and Take Profit

Cấu hình SL 300 points và TP 600 points có thể chưa phù hợp với biến động giá thực tế hoặc hành vi của tín hiệu Velocity.

**Cách kiểm tra:** Thử nghiệm nhóm SL/TP riêng, giữ nguyên các biến khác và so sánh cả lợi nhuận lẫn drawdown.

### H5 — Break-Even and Trailing Stop

Break-Even bắt đầu ở 150 points và Trailing Stop bắt đầu ở 200 points. Cần xác định liệu hai cơ chế này có hỗ trợ quản lý vị thế trong chiến lược hiện tại hay không.

**Cách kiểm tra:** Thực hiện các phép so sánh bật/tắt riêng biệt cho từng cơ chế. Ghi nhận số lệnh thắng, lệnh thua, mức lợi nhuận trung bình và drawdown.

## 4. Proposed Experiment Matrix

| Experiment | Main Variable | Control |
|---|---|---|
| #02 | Velocity Period | Giữ nguyên các tham số khác |
| #03 | Velocity Threshold | Giữ nguyên các tham số khác |
| #04 | Stop Loss / Take Profit | Thử riêng nhóm SL/TP |
| #05 | Break-Even | So sánh bật/tắt |
| #06 | Trailing Stop | So sánh bật/tắt |
| #07 | Transaction Costs | Xác minh spread và chi phí thực thi |
| #08 | Out-of-Sample Test | Chỉ tiến hành khi có kết quả đủ triển vọng |

Đây là kế hoạch nghiên cứu đề xuất, không phải kết quả đã chạy.

## 5. Evaluation Framework

Mỗi thử nghiệm cần ghi lại:

- Cấu hình đầy đủ và mã nguồn tương ứng.
- Net Profit và Gross Profit/Gross Loss.
- Profit Factor và Expected Payoff.
- Balance và Equity Drawdown.
- Sharpe Ratio và Recovery Factor.
- Tổng số giao dịch và Win Rate.
- Average Profit, Average Loss và thời gian giữ lệnh.
- Điều kiện spread, slippage và commission nếu có dữ liệu.
- Kết quả trên dữ liệu ngoài mẫu khi phù hợp.

Một cấu hình không được xem là tốt hơn chỉ vì có Net Profit cao hơn. Cần đánh giá cả rủi ro, độ ổn định và khả năng lặp lại kết quả.

## 6. Research Decision

**Current Status:** `DIAGNOSTIC RESEARCH PENDING`

- Baseline #01: FAIL.
- Parameter Optimization: Not started.
- Out-of-Sample Validation: Not completed.
- Forward Testing: Not completed.
- Live Trading: Not approved.

Nếu các thử nghiệm tiếp theo không cho thấy cải thiện đáng tin cậy, nên dừng phát triển EA-117 và lưu lại kết quả để tránh lặp lại các thử nghiệm không hiệu quả.
