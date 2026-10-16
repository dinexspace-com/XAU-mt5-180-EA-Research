# EA-116 — Velocity 3 Research Notes

## 1. Research Objective

Đánh giá chiến lược Price Velocity của EA-116, xác định các yếu tố có thể liên quan đến kết quả backtest thất bại và xây dựng kế hoạch nghiên cứu tiếp theo.

Nghiên cứu hiện tại dựa trên baseline #01. Các giả thuyết dưới đây cần được kiểm tra bằng thử nghiệm, không được xem là nguyên nhân đã được xác nhận.

## 2. Baseline Findings

| Metric | Baseline #01 |
|---|---:|
| Net Profit | -$994.08 |
| Profit Factor | 0.91 |
| Relative Drawdown | 99.47% |
| Sharpe Ratio | -5.00 |
| Expected Payoff | -$0.12 |
| Total Trades | 8,025 |
| Win Rate | 45.05% |

### Key Observations

- EA thực hiện 8,025 giao dịch trong giai đoạn kiểm thử.
- Tổng thua lỗ gộp lớn hơn tổng lợi nhuận gộp.
- Drawdown gần 100% cho thấy rủi ro của cấu hình hiện tại không chấp nhận được.
- Tỷ lệ thắng của lệnh BUY và SELL đều dưới 50%.
- Thời gian giữ lệnh trung bình khoảng 51 giây, vì vậy chi phí giao dịch và điều kiện thực thi cần được kiểm tra kỹ.

## 3. Research Hypotheses

### H1 — Velocity Threshold

Ngưỡng 0.10% có thể chưa phân biệt hiệu quả giữa biến động có khả năng tiếp diễn và biến động ngắn hạn.

**Test:** So sánh một tập hợp ngưỡng đã xác định trước, giữ nguyên các điều kiện khác.

### H2 — Velocity Period

Chu kỳ 3 nến có thể phản ứng quá nhanh với nhiễu giá trên M1.

**Test:** So sánh một số chu kỳ khác nhau, đánh giá đồng thời lợi nhuận, drawdown và số lượng giao dịch.

### H3 — Transaction Costs

Tần suất giao dịch cao và thời gian giữ lệnh ngắn có thể khiến spread, commission hoặc slippage ảnh hưởng đáng kể đến kết quả.

**Test:** Kiểm tra cấu hình chi phí thực tế của broker và so sánh kết quả khi thay đổi điều kiện spread trong phạm vi hợp lý.

### H4 — Stop Loss and Take Profit

Cấu hình SL 300 points và TP 600 points có thể không phù hợp với phân phối biến động của XAUUSD.PRO trên M1.

**Test:** Đánh giá cấu hình SL/TP theo kế hoạch thử nghiệm riêng. Không thay đổi đồng thời nhiều nhóm tham số vì sẽ khó xác định yếu tố tác động.

### H5 — Break-Even and Trailing Stop

Break-Even bắt đầu ở 150 points và Trailing Stop bắt đầu ở 200 points. Cần xác định liệu các cơ chế này có cải thiện việc bảo toàn lợi nhuận hay làm giảm khả năng để lệnh phát triển.

**Test:** So sánh baseline với từng cơ chế quản lý lệnh được bật hoặc tắt riêng biệt.

## 4. Proposed Experiment Plan

| Experiment | Variable | Other Conditions |
|---|---|---|
| #02 | Velocity Threshold | Giữ nguyên các tham số còn lại |
| #03 | Velocity Period | Giữ nguyên các tham số còn lại |
| #04 | SL/TP | Kiểm tra riêng nhóm SL/TP |
| #05 | Break-Even | So sánh bật/tắt |
| #06 | Trailing Stop | So sánh bật/tắt |
| #07 | Transaction Costs | Kiểm tra spread và chi phí thực tế |
| #08 | Out-of-Sample | Chỉ thực hiện nếu kết quả trước đó đủ triển vọng |

Các thử nghiệm trên là kế hoạch đề xuất, chưa phải những thử nghiệm đã hoàn thành.

## 5. Evaluation Criteria

Mỗi thử nghiệm cần ghi nhận tối thiểu:

- Net Profit.
- Profit Factor.
- Expected Payoff.
- Relative Equity Drawdown.
- Sharpe Ratio.
- Total Trades.
- Win Rate.
- Average Profit và Average Loss.
- Spread, commission và slippage nếu có dữ liệu.
- Kết quả trên giai đoạn dữ liệu chưa dùng để lựa chọn tham số.

Không lựa chọn cấu hình chỉ dựa trên lợi nhuận cao nhất. Cần đánh giá sự cân bằng giữa lợi nhuận, drawdown, chi phí giao dịch và độ ổn định.

## 6. Current Research Decision

**Status:** `DIAGNOSTIC RESEARCH PENDING`

- Baseline #01: FAIL.
- Parameter Optimization: Not started.
- Out-of-Sample Validation: Not completed.
- Forward Testing: Not completed.
- Live Trading: Not approved.

Chỉ tiếp tục tối ưu hóa nếu phân tích và thử nghiệm cho thấy cơ sở cải thiện có thể kiểm chứng. Nếu không, nên lưu trữ kết quả và chuyển sang chiến lược khác.
