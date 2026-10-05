# EA-100 — Bollinger + RSI Methodology

## 1. Strategy Definition

EA-100 được xây dựng trên hai indicator:

```text
Bollinger Bands
+
RSI
```

Baseline configuration:

```text
Bollinger Period    = 20
Bollinger Deviation = 2.0
RSI Period          = 14
RSI Lower           = 30
RSI Upper           = 70
```

---

## 2. Signal Definition

### BUY

```text
Low[1] <= LowerBand[1]
AND
RSI[1] < 30
```

### SELL

```text
High[1] >= UpperBand[1]
AND
RSI[1] > 70
```

Signal được đánh giá trên candle Shift 1 khi xuất hiện candle mới.

---

## 3. Baseline Identification

```text
EA100-M1-BASELINE-001
```

Baseline:

```text
Symbol     = XAUUSD.PRO
Timeframe  = M1
Period     = 2026.01.02 – 2026.03.31
Deposit    = $1,000
Leverage   = 1:500
Model      = 100% real ticks
```

Tester report xác nhận test sử dụng 85,161 bars và 39,639,179 ticks.

---

## 4. Baseline Acceptance

Baseline được đánh giá là:

```text
PASS FOR FURTHER RESEARCH
```

Lý do:

* Net Profit dương.
* Profit Factor > 1.
* Expected Payoff dương.
* Drawdown tương đối thấp.
* Sharpe Ratio dương.
* Số lượng trades đủ lớn cho research baseline.

Baseline đạt:

```text
Net Profit       = +$694.91
Profit Factor    = 1.20
Max Equity DD    = 5.57%
Trades           = 3,096
Sharpe Ratio     = 33.78
Recovery Factor  = 11.93
```

---

## 5. Controlled Experiment Policy

Research phải thực hiện theo thứ tự:

```text
Baseline
   ↓
Bollinger Period
   ↓
Bollinger Deviation
   ↓
RSI Period
   ↓
RSI Threshold
   ↓
Entry Confirmation
   ↓
Candle / Shadow Structure
   ↓
BUY vs SELL
   ↓
SL / TP
   ↓
Break Even / Trailing
   ↓
Session
   ↓
Market Regime
   ↓
OOS
   ↓
Robustness
   ↓
Walk-Forward
   ↓
Forward Test
```

Không thực hiện broad optimization trước khi xác định được các yếu tố thực sự đóng góp vào performance.

---

## 6. Evaluation Metrics

Mỗi experiment phải theo dõi tối thiểu:

* Net Profit.
* Profit Factor.
* Expected Payoff.
* Max Balance Drawdown.
* Max Equity Drawdown.
* Recovery Factor.
* Sharpe Ratio.
* Number of Trades.
* Win Rate.
* Average Profit Trade.
* Average Loss Trade.
* BUY performance.
* SELL performance.

Không sử dụng Net Profit đơn độc để lựa chọn parameter.

---

## 7. Validation Policy

Một configuration chỉ được xem là ứng viên tốt khi:

```text
Baseline
+
Controlled Research
+
OOS
+
Robustness
+
Walk-Forward
+
Forward Test
```

đều cho kết quả chấp nhận được.

Không đưa EA-100 vào live trading chỉ dựa trên baseline backtest.

---

## 8. Current Status

```text
Strategy Code      = COMPLETE
Baseline           = COMPLETE
Baseline Result    = PASS FOR FURTHER RESEARCH
Research           = IN PROGRESS
Optimization       = CONTROLLED ONLY
OOS                = NOT STARTED
Robustness         = NOT STARTED
Walk-Forward       = NOT STARTED
Forward Test       = NOT STARTED
Live Trading       = NO
```
