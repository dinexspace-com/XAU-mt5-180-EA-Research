# EA-099 — Spike Reversion Research Methodology

## 1. Baseline Identification

**Experiment ID:** `EA099-M1-BASELINE-001`

**Strategy:** Spike Reversion

**Symbol:** XAUUSD.PRO

**Timeframe:** M1

**Test Period:** 2026.01.02 – 2026.03.31

**Initial Deposit:** $1,000

**Modeling:** 100% real ticks

## Baseline sử dụng ATR 14, Large Spike threshold 2.0 ATR, Spike Body Ratio 0.70 và Momentum Ratio 0.50.

## 2. Strategy Definition

Spike được xác định khi range của candle lớn hơn:

`LargeATR × ATR`

Baseline:

`LargeATR = 2.0`

Spike candle tiếp tục phải thỏa điều kiện body/range:

`abs(body) / range >= 0.70`

Sau đó EA tìm reversal candle.

BUY:

`bearish spike → bullish confirmation → close > spike close → close < spike open`

SELL:

`bullish spike → bearish confirmation → close < spike close → close > spike open`

---

## 3. Baseline Evaluation

Baseline result:

* Net Profit: **-$24.50**
* Profit Factor: **0.98**
* Expected Payoff: **-$0.03**
* Max Equity Drawdown: **12.91%**
* Sharpe Ratio: **-3.55**
* Total Trades: **864**

### Baseline Classification

`FAIL`

Baseline chưa chứng minh được lợi thế thống kê đủ mạnh.

---

## 4. Acceptance Criteria

Một experiment chỉ được xem là đáng tiếp tục khi có cải thiện đồng thời về:

* Net Profit.
* Profit Factor.
* Expected Payoff.
* Drawdown.
* Trade count đủ lớn.
* BUY/SELL không phụ thuộc quá mức vào một direction.
* Kết quả không chỉ xuất hiện ở một vùng parameter rất hẹp.

Không sử dụng Net Profit đơn độc làm tiêu chí chọn strategy.

---

## 5. Controlled Experiment Rule

Mỗi experiment phải:

1. Xác định hypothesis.
2. Xác định parameter được thay đổi.
3. Giữ nguyên các parameter khác.
4. Chạy cùng symbol.
5. Chạy cùng timeframe.
6. Chạy cùng historical period khi so sánh baseline.
7. Ghi nhận toàn bộ metrics chính.
8. So sánh trực tiếp với baseline.

---

## 6. Research Sequence

Thứ tự nghiên cứu EA-099:

1. Spike ATR Threshold
2. Spike Body Ratio
3. Reversal Confirmation
4. Momentum Filter
5. ATR Period
6. BUY vs SELL
7. Exit Management
8. Trading Session
9. Out-of-Sample
10. Robustness
11. Walk-Forward
12. Forward Test

Không chuyển sang bước tiếp theo nếu bước trước chưa tạo ra evidence đủ tốt.

---

## 7. Optimization Policy

Broad optimization bị **BLOCKED** ở baseline.

Không chạy optimization hàng loạt để tìm parameter có Net Profit cao nhất khi entry hypothesis chưa được xác nhận.

Parameter optimization chỉ được thực hiện sau khi controlled research cho thấy strategy có edge tiềm năng.

---

## 8. Validation Sequence

Quy trình validation:

`Baseline`

→ `Controlled Research`

→ `In-Sample Improvement`

→ `Out-of-Sample`

→ `Robustness`

→ `Walk-Forward`

→ `Forward Test`

→ `Live Validation`

---

## 9. Current Research Status

**Strategy Code:** COMPLETE

**Baseline:** COMPLETE

**Performance:** FAIL

**Research:** IN PROGRESS

**Optimization:** BLOCKED

**OOS:** NOT STARTED

**Forward Test:** NOT STARTED

**Production:** NO
