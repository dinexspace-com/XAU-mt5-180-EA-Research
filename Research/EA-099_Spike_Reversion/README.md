# EA-099 — Spike Reversion — Research

## Research Objective

Mục tiêu nghiên cứu là xác định liệu mô hình:

**Large Spike → Reversal Confirmation → Reversion**

có tạo ra lợi thế giao dịch ổn định trên XAUUSD hay không.

Baseline hiện tại chưa chứng minh được edge.

**Baseline ID:** `EA099-M1-BASELINE-001`

**Result:** `FAIL`

---

## Baseline Findings

Baseline có:

* Net Profit: **-$24.50**
* Profit Factor: **0.98**
* Expected Payoff: **-$0.03**
* Max Equity Drawdown: **12.91%**
* 864 trades
* Win rate tổng thể: **51.16%**

## Do average loss (-$2.41) lớn hơn average profit ($2.25), tỷ lệ thắng trên 50% vẫn chưa đủ để tạo expectancy dương.

# Controlled Research Sequence

## RQ01 — Spike Threshold

Kiểm tra ảnh hưởng của ngưỡng spike:

* 1.50 ATR
* 1.75 ATR
* 2.00 ATR
* 2.25 ATR
* 2.50 ATR
* 3.00 ATR

**Baseline:** 2.00 ATR

Mục tiêu: xác định spike lớn đến mức nào mới tạo ra reversal có ý nghĩa.

---

## RQ02 — Spike Body Ratio

Kiểm tra:

* 0.50
* 0.60
* 0.70
* 0.80
* 0.90

Mục tiêu: xác định spike cần có mức độ directional body như thế nào.

---

## RQ03 — Reversal Confirmation

So sánh các điều kiện confirmation:

1. Close quay lại bên trong spike body.
2. Close vượt spike close.
3. Close vượt midpoint của spike.
4. Confirmation body có kích thước tối thiểu.
5. Confirmation candle không được tiếp tục mở rộng range.
6. Kết hợp body + close-location.

Mục tiêu: giảm các tín hiệu reversal yếu.

---

## RQ04 — Momentum Filter

Baseline sử dụng:

`InpMomentumRatio = 0.50`

Nghiên cứu các mức:

* 0.25
* 0.50
* 0.75
* 1.00

Mục tiêu: xác định confirmation candle mạnh có làm giảm chất lượng reversal hay không.

---

## RQ05 — ATR Period

Kiểm tra:

* ATR 7
* ATR 14
* ATR 21
* ATR 28

Baseline: ATR 14.

---

## RQ06 — BUY vs SELL

Phân tích độc lập:

* BUY performance
* SELL performance

Baseline hiện tại:

* BUY: 488 trades / 51.43% winners
* SELL: 376 trades / 50.80% winners

Mục tiêu: xác định edge có phụ thuộc direction hay không.

---

## RQ07 — Exit Management

Sau khi xác định entry logic tốt hơn, kiểm tra riêng:

* Fixed SL/TP
* Risk/Reward
* Break Even
* Trailing Stop
* Không BE
* Không Trailing
* BE + Trailing

Không thay đổi entry logic trong experiment này.

---

## RQ08 — Trading Session

Phân tích kết quả theo session / thời gian giao dịch.

Mục tiêu: xác định Spike Reversion có hoạt động tốt hơn trong một số giai đoạn thị trường hay không.

---

## RQ09 — Out-of-Sample

Chỉ thực hiện sau khi một logic entry được xác nhận trên in-sample.

Không sử dụng OOS để chọn tham số.

---

## RQ10 — Robustness / Walk-Forward

Kiểm tra:

* Thay đổi nhẹ threshold.
* Thay đổi ATR period.
* Thay đổi SL/TP.
* Thay đổi session.
* Walk-forward.
* Different market regimes.

Mục tiêu là kiểm tra tính ổn định thay vì tìm parameter tối ưu nhất.

---

# Research Rules

1. Mỗi experiment chỉ thay đổi **một nhóm biến**.
2. Giữ nguyên các biến còn lại.
3. Ghi lại baseline trước mỗi experiment.
4. Không chọn parameter chỉ dựa trên Net Profit.
5. Ưu tiên Profit Factor, Expected Payoff, Drawdown và stability.
6. Không thực hiện broad optimization khi baseline chưa có evidence về edge.
7. OOS phải được giữ độc lập.
8. Không kết luận production-ready chỉ dựa trên một backtest.

---

# Current Verdict

| Category          | Status          |
| ----------------- | --------------- |
| Strategy Code     | COMPLETE        |
| Baseline Backtest | COMPLETE        |
| Technical Test    | PASS            |
| Performance Test  | **FAIL**        |
| Research          | **IN PROGRESS** |
| Optimization      | **BLOCKED**     |
| OOS               | NOT STARTED     |
| Walk-Forward      | NOT STARTED     |
| Forward Test      | NOT STARTED     |
| Live Trading      | **NO**          |
