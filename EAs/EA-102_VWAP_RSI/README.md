# EA-102 — VWAP + RSI

## 1. Overview

**EA-102 — VWAP + RSI** là Expert Advisor cho MT5 sử dụng:

* Daily VWAP
* RSI
* Mean-reversion entry
* Fixed Stop Loss / Take Profit
* Break Even
* Trailing Stop
* Spread protection
* One-position control

Mục tiêu của chiến lược là tìm điểm hồi giá quanh **Daily VWAP**, kết hợp với trạng thái quá bán/quá mua và sự đảo chiều của RSI.

---

## 2. Trading Logic

### BUY

EA mở BUY khi đồng thời thỏa mãn:

```text
Previous Close < Daily VWAP
Current Signal Close < Daily VWAP

RSI[2] < RSI Oversold
RSI[1] > RSI[2]
```

Với cấu hình baseline:

```text
RSI Period     = 14
RSI Oversold   = 30
```

Diễn giải:

* Hai nến đóng cửa gần nhất vẫn nằm dưới Daily VWAP.
* RSI trước đó nằm trong vùng oversold.
* RSI bắt đầu hồi tăng.
* EA kỳ vọng giá hồi trở lại sau trạng thái suy yếu.

### SELL

EA mở SELL khi đồng thời thỏa mãn:

```text
Previous Close > Daily VWAP
Current Signal Close > Daily VWAP

RSI[2] > RSI Overbought
RSI[1] < RSI[2]
```

Với cấu hình baseline:

```text
RSI Period      = 14
RSI Overbought  = 70
```

Diễn giải:

* Hai nến đóng cửa gần nhất vẫn nằm trên Daily VWAP.
* RSI trước đó nằm trong vùng overbought.
* RSI bắt đầu giảm.
* EA kỳ vọng giá hồi xuống sau trạng thái tăng quá mức.

---

## 3. Daily VWAP Calculation

Daily VWAP được tính lại từ đầu mỗi ngày.

Công thức sử dụng:

```text
Typical Price = (High + Low + Close) / 3

Daily VWAP =
Σ(Typical Price × Tick Volume)
/
Σ(Tick Volume)
```

Dữ liệu VWAP được lấy từ M1 và sử dụng tick volume.

---

## 4. Baseline Configuration

| Parameter         |      Value |
| ----------------- | ---------: |
| Lot Size          |       0.01 |
| Stop Loss         | 300 points |
| Take Profit       | 600 points |
| RSI Period        |         14 |
| RSI Oversold      |         30 |
| RSI Overbought    |         70 |
| Max Spread        |  30 points |
| Break Even        |         ON |
| Break Even Start  | 150 points |
| Break Even Offset |          0 |
| Trailing Stop     |         ON |
| Trailing Start    | 200 points |
| Trailing Distance | 200 points |
| Magic Number      |     123457 |
| Timeframe         |         M1 |

---

## 5. Execution Rules

EA chỉ đánh giá tín hiệu khi xuất hiện nến mới.

Trước khi vào lệnh, EA kiểm tra:

* Trading permission
* Chưa có position của EA
* Spread không vượt quá giới hạn
* Stop Loss / Take Profit hợp lệ
* VWAP hợp lệ
* RSI data hợp lệ

Mỗi thời điểm chỉ cho phép một position của EA trên symbol.

---

## 6. Baseline Experiment

**Baseline ID:**

`EA102-M1-BASELINE-001`

**Test status:**

`PASS FOR FURTHER RESEARCH`

Kết quả baseline có lợi nhuận dương nhưng biên lợi nhuận rất thấp. Strategy chưa được xem là có edge đủ mạnh để triển khai live.

---

## 7. Research Status

| Stage                      | Status                    |
| -------------------------- | ------------------------- |
| Strategy Code              | COMPLETE                  |
| Baseline Backtest          | COMPLETE                  |
| Baseline Assessment        | PASS FOR FURTHER RESEARCH |
| Parameter Evaluation       | NOT STARTED               |
| Entry Logic Evaluation     | NOT STARTED               |
| BUY vs SELL Evaluation     | NOT STARTED               |
| Exit Management Evaluation | NOT STARTED               |
| Session Evaluation         | NOT STARTED               |
| OOS                        | NOT STARTED               |
| Robustness                 | NOT STARTED               |
| Walk-Forward               | NOT STARTED               |
| Forward Test               | NOT STARTED               |
| Live Trading               | NO                        |

---

## 8. Research Principle

EA-102 phải được nghiên cứu theo controlled experiment.

Không tối ưu đồng thời nhiều nhóm parameter.

Không đánh giá strategy chỉ dựa trên Net Profit.

Ưu tiên:

```text
Baseline
→ Controlled Research
→ Candidate Configuration
→ OOS
→ Robustness
→ Walk-Forward
→ Forward Test
→ Live
```

**Current classification:**

`RESEARCH CANDIDATE — NOT VALIDATED FOR LIVE TRADING`
