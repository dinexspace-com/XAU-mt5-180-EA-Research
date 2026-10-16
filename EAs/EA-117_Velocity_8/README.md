# EA-117 — Velocity 8

## 1. Overview

| Property | Value |
|---|---|
| EA Name | EA-117 — Velocity 8 |
| Source File | `EA-117_Velocity_8.mq5` |
| Version | 1.00 |
| Platform | MetaTrader 5 |
| Strategy Type | Price Velocity |
| Tested Symbol | XAUUSD.PRO |
| Tested Timeframe | M1 |
| Magic Number | 117001 |
| Research Status | Baseline Failed |
| Live Trading | Not Approved |

## 2. Strategy Description

EA-117 sử dụng phần trăm thay đổi giá trong một khoảng nến để xác định hướng giao dịch.

Velocity được tính bằng công thức:

`Velocity = (Close[1] - Close[VelocityPeriod+1]) / Close[VelocityPeriod+1] * 100`

Trong đó:

- `Close[1]`: giá đóng cửa của nến đã hoàn thành gần nhất.
- `Close[VelocityPeriod+1]`: giá đóng cửa của nến cách đó theo chu kỳ cấu hình.
- `VelocityPeriod`: số nến dùng để đo biến động.
- `VelocityThreshold`: ngưỡng biến động để kích hoạt tín hiệu.

### Entry Rules

- **BUY:** Velocity lớn hơn `InpVelocityThreshold`.
- **SELL:** Velocity nhỏ hơn giá trị âm của `InpVelocityThreshold`.
- **No Entry:** Velocity nằm trong vùng ngưỡng.

EA đánh giá tín hiệu khi có nến mới và chỉ mở vị thế khi vượt qua các điều kiện cho phép giao dịch, kiểm tra spread và kiểm tra vị thế hiện có theo symbol và magic number.

## 3. Default Parameters

| Parameter | Default Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 117001 |
| Slippage | 10 points |
| Use Break-Even | true |
| Break-Even Start | 150 points |
| Break-Even Offset | 0 points |
| Use Trailing Stop | true |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| Velocity Period | 8 |
| Velocity Threshold | 0.20% |

## 4. Trade Management

EA hỗ trợ:

- Stop Loss và Take Profit khi mở vị thế.
- Break-Even khi lợi nhuận đạt ngưỡng cấu hình.
- Trailing Stop khi lợi nhuận đạt ngưỡng cấu hình.
- Kiểm tra spread trước khi vào lệnh.
- Hạn chế mở thêm vị thế cùng symbol và magic number khi vị thế hiện tại vẫn tồn tại.

Khối lượng giao dịch mặc định là cố định 0.01 lot. Mã nguồn hiện tại không có cơ chế tự tính lot theo phần trăm vốn hoặc tham số Trailing Step riêng.

## 5. Baseline Result

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000 |
| Net Profit | -$992.62 |
| Profit Factor | 0.90 |
| Expected Payoff | -$0.14 |
| Sharpe Ratio | -5.00 |
| Relative Drawdown | 99.32% |
| Total Trades | 7,128 |
| Win Rate | 44.46% |

## 6. Assessment

**Classification: FAIL**

Kết quả baseline cho thấy chiến lược không có hiệu quả trong cấu hình và giai đoạn được kiểm thử. Vốn ban đầu gần như bị mất hoàn toàn, Profit Factor thấp hơn 1 và Expected Payoff âm.

Không triển khai EA-117 trên tài khoản thật dựa trên kết quả hiện tại.

## 7. Next Steps

1. Lưu nguyên mã nguồn và kết quả baseline.
2. Phân tích hành vi vào lệnh và thoát lệnh.
3. Kiểm tra ảnh hưởng của Velocity Period và Velocity Threshold.
4. Đánh giá riêng SL/TP, Break-Even và Trailing Stop.
5. Chỉ xem xét kiểm định ngoài mẫu nếu có cải thiện được chứng minh bằng dữ liệu.

Mọi thử nghiệm tiếp theo phải được ghi nhận riêng; không thay thế kết quả baseline.
