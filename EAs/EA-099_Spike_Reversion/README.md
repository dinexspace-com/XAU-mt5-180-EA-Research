# EA-099 — Spike Reversion

## Strategy Overview

**EA-099 — Spike Reversion** là Expert Advisor giao dịch XAUUSD trên MT5, tập trung vào mô hình **large-range spike → reversal**.

Logic tín hiệu sử dụng:

1. Tính ATR theo `InpATRPeriod`.
2. Xác định spike khi range của nến tín hiệu lớn hơn:
   `InpLargeATR × ATR`
3. Nến spike phải có tỷ lệ body/range tối thiểu:
   `InpSpikeBodyRatio`
4. Sau spike, EA tìm nến xác nhận đảo chiều.
5. BUY khi:

   * Spike candle là bearish.
   * Confirmation candle là bullish.
   * Confirmation close cao hơn spike close.
   * Confirmation close vẫn nằm dưới spike open.
6. SELL khi:

   * Spike candle là bullish.
   * Confirmation candle là bearish.
   * Confirmation close thấp hơn spike close.
   * Confirmation close vẫn nằm trên spike open.

EA chỉ đánh giá tín hiệu khi xuất hiện nến mới và sử dụng tối đa một position/order theo magic number.

---

## Baseline Configuration

| Parameter           |      Value |
| ------------------- | ---------: |
| Timeframe           |         M1 |
| Lot Size            |       0.01 |
| Stop Loss           | 300 points |
| Take Profit         | 600 points |
| Magic Number        |     123099 |
| Max Spread          |  30 points |
| ATR Period          |         14 |
| Large ATR Threshold |        2.0 |
| Spike Body Ratio    |       0.70 |
| Momentum Ratio      |       0.50 |
| Break Even          |         ON |
| BE Trigger          | 150 points |
| BE Offset           |          0 |
| Trailing Stop       |         ON |
| Trailing Start      | 200 points |
| Trailing Distance   | 100 points |
| Trailing Step       |  10 points |

---

## Research Status

**Baseline ID:** `EA099-M1-BASELINE-001`

**Baseline Result:** `FAIL`

**Validation Status:** `NOT VALIDATED FOR LIVE TRADING`

**Optimization Status:** `BLOCKED`

Baseline không đạt yêu cầu do Net Profit âm và Profit Factor thấp hơn 1.

EA-099 hiện chỉ được sử dụng cho mục đích **research / controlled experimentation**.

---

## Main Research Question

> Spike Reversion có tạo ra lợi thế thống kê ổn định trên XAUUSD hay kết quả âm chủ yếu đến từ cách xác định spike, confirmation candle và exit management?

Mọi thay đổi tiếp theo phải được kiểm tra bằng controlled experiment, chỉ thay đổi một nhóm biến tại một thời điểm.
