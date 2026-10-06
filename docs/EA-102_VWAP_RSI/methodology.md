# EA-102 — VWAP + RSI Methodology

## Strategy Classification

EA-102 được phân loại là:

`VWAP + RSI Mean Reversion`

Strategy sử dụng Daily VWAP làm reference price và RSI làm momentum/reversal filter.

---

## Baseline Definition

Baseline identifier:

`EA102-M1-BASELINE-001`

Baseline parameters:

```text
Timeframe       = M1
Lot             = 0.01
SL              = 300 points
TP              = 600 points

RSI Period      = 14
RSI Oversold    = 30
RSI Overbought  = 70

Break Even      = ON
BE Start        = 150
BE Offset       = 0

Trailing        = ON
Trailing Start  = 200
Trailing Distance = 200

Max Spread      = 30 points
```

Daily VWAP được tính từ M1 tick volume với Typical Price:

```text
Typical Price = (High + Low + Close) / 3
```

---

## Entry Model

### BUY

```text
Close[2] < Daily VWAP
AND
Close[1] < Daily VWAP
AND
RSI[2] < Oversold
AND
RSI[1] > RSI[2]
```

### SELL

```text
Close[2] > Daily VWAP
AND
Close[1] > Daily VWAP
AND
RSI[2] > Overbought
AND
RSI[1] < RSI[2]
```

---

## Baseline Validation

Backtest:

```text
Symbol          XAUUSD.PRO
Timeframe       M1
Period          2026.01.02 – 2026.04.01
Deposit         $1,000
Leverage        1:500
History         100% real ticks
Trades          1,863
```

Results:

```text
Net Profit       +$38.60
Profit Factor    1.02
Expected Payoff  +$0.02
Sharpe Ratio     2.80
Max Equity DD    13.57%
Recovery Factor  0.24
```

Kết quả này cho thấy baseline có positive result nhưng edge rất mỏng. Vì vậy chưa đủ điều kiện để chuyển sang production validation.

---

## Validation Criteria

Một candidate configuration phải được đánh giá trên nhiều tiêu chí:

* Net Profit
* Profit Factor
* Expected Payoff
* Maximum Equity Drawdown
* Recovery Factor
* Sharpe Ratio
* Trade Count
* BUY/SELL stability
* Parameter stability
* OOS performance
* Robustness
* Walk-Forward performance

Không sử dụng một metric duy nhất để lựa chọn candidate.

---

## Research Hierarchy

```text
Baseline
↓
Controlled Research
↓
Candidate Configuration
↓
Out-of-Sample
↓
Robustness
↓
Walk-Forward
↓
Forward Test
↓
Live Trading
```

Không được bỏ qua OOS, robustness hoặc walk-forward chỉ vì baseline/candidate có Net Profit dương.

---

## Optimization Policy

EA-102 hiện **không được broad optimization**.

Mọi thay đổi phải được thực hiện theo controlled experiment:

```text
One Variable Group
→ Backtest
→ Record Metrics
→ Compare With Baseline
→ Keep / Reject
```

Không thay đổi đồng thời:

```text
RSI
+ VWAP distance
+ SL/TP
+ Trailing
```

trong cùng một experiment.

---

## Current Classification

```text
Strategy Code       COMPLETE
Baseline Test       COMPLETE
Baseline Result     PASS FOR FURTHER RESEARCH
Optimization        BLOCKED
OOS                 NOT STARTED
Robustness          NOT STARTED
Walk-Forward        NOT STARTED
Forward Test        NOT STARTED
Live Trading        NO
```

### Methodology Decision

EA-102 được giữ lại trong research pipeline vì baseline có:

```text
Net Profit > 0
Profit Factor > 1
Sharpe > 0
```

Tuy nhiên, kết quả chỉ ở mức marginal positive.

**Decision:**

`RESEARCH CANDIDATE — NOT VALIDATED FOR LIVE TRADING`
