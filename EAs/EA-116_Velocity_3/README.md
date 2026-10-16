# EA-116 — Velocity 3

## Overview

**EA Name:** EA-116 — Velocity 3  
**File:** `EA-116_Velocity_3.mq5`  
**Version:** 1.00  
**Platform:** MetaTrader 5 (MT5)  
**Symbol Tested:** XAUUSD.PRO  
**Timeframe Tested:** M1  
**Magic Number:** 116001  
**Status:** `RESEARCH ONLY — BASELINE FAILED`

## Strategy Description

EA-116 sử dụng tốc độ thay đổi giá (Price Velocity) để xác định hướng giao dịch.

EA tính phần trăm thay đổi giữa giá đóng cửa của nến đã hoàn thành gần nhất và giá đóng cửa cách đó một số nến xác định.

- **BUY:** Velocity lớn hơn ngưỡng dương.
- **SELL:** Velocity nhỏ hơn ngưỡng âm.
- **No Entry:** Velocity nằm trong vùng không có tín hiệu.

EA kiểm tra tín hiệu khi xuất hiện nến mới. Trước khi mở lệnh, EA kiểm tra quyền giao dịch, spread và vị thế hiện có cùng symbol và magic number.

## Default Parameters

| Parameter | Default Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 116001 |
| Slippage | 10 |
| Use Break-Even | true |
| Break-Even Start | 150 points |
| Break-Even Offset | 0 points |
| Use Trailing Stop | true |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| Velocity Period | 3 |
| Velocity Threshold | 0.10% |

## Risk Management

EA sử dụng lot cố định 0.01, Stop Loss, Take Profit, Break-Even và Trailing Stop.

EA hiện chưa sử dụng cơ chế tính khối lượng theo phần trăm vốn và chưa có tham số Trailing Step riêng.

## Current Assessment

Backtest baseline #01 cho kết quả âm, Profit Factor dưới 1 và Equity Drawdown gần 100%.

**Conclusion:** Không sử dụng EA-116 để giao dịch tài khoản thật. Chỉ tiếp tục nghiên cứu để xác định nguyên nhân thất bại và đánh giá liệu chiến lược có cơ sở cải thiện hay không.

## Research Rules

- Giữ nguyên bản baseline để đối chiếu.
- Chỉ thay đổi các tham số hoặc logic đã được ghi nhận.
- Mỗi thay đổi phải có kết quả backtest riêng.
- Không kết luận chiến lược hiệu quả chỉ dựa trên một giai đoạn dữ liệu.
- Chỉ xem xét kiểm định tiếp theo nếu có bằng chứng cải thiện rõ ràng về lợi nhuận, drawdown và độ ổn định.
