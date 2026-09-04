# Research — EA-041 Inside Pullback Trend

## Research Objective

EA-041 nghiên cứu giả thuyết:

> Trong một xu hướng đã được xác định, Inside Bar có thể đại diện cho một nhịp co hẹp / pullback ngắn trước khi giá tiếp tục di chuyển theo xu hướng chính.

Mục tiêu là kiểm tra xem mô hình này có tạo ra lợi thế thống kê đủ ổn định trên XAUUSD để phát triển thành EA thực tế hay không.

---

# 1. Core Hypothesis

Cấu trúc chiến lược:

Trend
→ Pullback / Consolidation
→ Inside Bar
→ Breakout
→ Trend Continuation

EA hiện sử dụng EMA 50 để xác định xu hướng.

### Bullish

Price > EMA 50

Sau khi xuất hiện Inside Bar:

Price breaks Mother Bar High
→ BUY

### Bearish

Price < EMA 50

Sau khi xuất hiện Inside Bar:

Price breaks Mother Bar Low
→ SELL

---

# 2. Inside Bar Definition

Inside Bar là nến có toàn bộ range nằm bên trong Mother Bar trước đó.

Inside High <= Mother High

AND

Inside Low >= Mother Low

Ý tưởng thị trường:

Mother Bar
→ Inside Bar
→ Volatility contraction
→ Breakout
→ Potential continuation

EA-041 không giao dịch Inside Bar độc lập.

Inside Bar được kết hợp với trend filter để ưu tiên breakout theo hướng của xu hướng hiện tại.

---

# 3. Why This Strategy Is Being Researched

Inside Bar đơn thuần chưa đủ để giả định có edge.

Giả thuyết của EA-041 là:

Inside Bar
+
Trend Filter
+
Directional Breakout

có thể tốt hơn việc giao dịch mọi Inside Bar breakout.

Đặc biệt với XAUUSD, cần kiểm tra xem các giai đoạn trend mạnh có tạo ra những breakout đủ lớn để bù cho số lượng breakout thất bại hay không.

---

# 4. Current Implementation

Phiên bản hiện tại sử dụng:

Trend Filter:
EMA 50

Pattern:
Inside Bar

Trigger:
Mother Bar breakout

Direction:
Trade with EMA trend

Stop Loss:
300 points

Take Profit:
600 points

Nominal SL:TP:
1:2

Lot:
0.01 fixed

Maximum Positions:
1

Baseline test:

Break Even = OFF
Trailing Stop = OFF

Mục đích của cấu hình này là kiểm tra logic cơ bản trước khi thêm trade-management phức tạp.

---

# 5. Baseline Evidence

Baseline backtest hiện tại:

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-09-03

Initial Deposit:
$1,000

History Quality:
100% real ticks

### Results

Net Profit:
+$26.78

Profit Factor:
1.21

Maximum Equity Drawdown:
4.50%

Total Trades:
57

Winning Trades:
18

Losing Trades:
39

Win Rate:
31.58%

Average Winner:
+$8.48

Average Loser:
-$3.23

Maximum Consecutive Losses:
8

---

# 6. Interpretation of Baseline

The first baseline is profitable.

However, the evidence is currently too weak to conclude that the strategy has a robust edge.

Main reasons:

1. Only 57 trades.
2. Profit Factor is only 1.21.
3. Win rate is 31.58%.
4. Maximum losing streak reached 8 trades.
5. Balance growth is not consistently upward.
6. One large winner of $47.71 represents a meaningful portion of total gross profit.
7. Only one timeframe and one historical period have currently been tested.

Therefore:

STATUS = RESEARCH CANDIDATE

NOT:

STATUS = VALIDATED STRATEGY

---

# 7. External Research

Independent research provides some support for continuing the hypothesis, but does not validate EA-041 itself.

A 2026 MQL5 study tested Inside Bar continuation across XAUUSD, EURUSD and SP500.

For XAUUSD H1, its baseline reported:

Profit Factor:
1.43

Recovery Factor:
1.51

The study found an important relationship between performance and Mother Bar quality.

Stronger directional Mother Bars performed better.

The strongest results appeared when the Mother Bar body represented approximately 80% of its total range.

The study also found useful behavior when the Inside / Signal Bar was approximately 50% of the Mother Bar range.

An ATR filter around 0.6 ATR helped remove very small setups, although increasing the ATR requirement further reduced trade count without meaningful performance improvement.

These findings are external research observations.

They are NOT yet validated for EA-041.

---

# 8. Main Research Questions

EA-041 should now answer the following questions.

## Q1 — Does the edge survive more data?

57 trades are insufficient.

Test longer historical periods.

Target:

2020 → 2026

where reliable broker data is available.

---

## Q2 — Is M1 the correct timeframe?

Current baseline:

M1

Research should compare at minimum:

M1
M5
M15
H1

The objective is NOT to choose the timeframe with the highest historical profit.

The objective is to identify whether the underlying strategy remains profitable across reasonable timeframe changes.

---

## Q3 — Does Mother Bar quality matter?

Test:

Mother Body / Mother Range

Possible research thresholds:

>= 50%
>= 60%
>= 70%
>= 80%

Hypothesis:

Directional Mother Bars may produce higher-quality continuation breakouts.

---

## Q4 — Does Inside Bar size matter?

Calculate:

Inside Range / Mother Range

Research whether very large or very small Inside Bars produce different outcomes.

Candidate ranges for investigation:

<= 30%
<= 40%
<= 50%
<= 60%
<= 70%

Do not assume 50% is optimal simply because external research observed it.

EA-041 must verify this independently.

---

## Q5 — Does volatility filtering improve results?

Candidate:

ATR(14)

Research whether very small Mother Bars should be rejected.

The objective is to remove low-volatility setups without destroying trade frequency.

---

## Q6 — Are BUY and SELL equally effective?

Current baseline:

BUY:
23 trades
34.78% win rate

SELL:
34 trades
29.41% win rate

This difference is not sufficient to disable SELL.

Research should compare:

LONG only
SHORT only
LONG + SHORT

over a larger sample.

---

## Q7 — Is fixed 300/600 SL/TP robust?

Current configuration:

SL = 300 points
TP = 600 points

This creates nominal:

RR = 1:2

Research should determine whether fixed-point exits remain suitable across different XAUUSD volatility regimes.

Alternative future research:

ATR-based SL/TP

and

Mother-Bar-range-based SL/TP.

These should NOT replace the baseline until separately tested.

---

# 9. Research Priority

Do not optimize everything simultaneously.

Research order:

STEP 1
Increase historical sample.

STEP 2
Compare timeframes.

STEP 3
Test Mother Bar quality.

STEP 4
Test Inside Bar size.

STEP 5
Test volatility filter.

STEP 6
Test exit structure.

STEP 7
Test trade management.

This order reduces the risk of overfitting.

---

# 10. Anti-Overfitting Rule

Do not select parameters solely because they maximize historical Net Profit.

A candidate improvement should preferably show:

- larger trade sample;
- acceptable drawdown;
- Profit Factor improvement;
- reasonable behavior across adjacent parameter values;
- performance across different market periods;
- out-of-sample survival.

A single isolated parameter combination with exceptional historical performance should be treated as suspicious.

---

# 11. Validation Pipeline

EA-041 research should progress through:

Baseline
↓
Long Historical Test
↓
Timeframe Comparison
↓
Filter Research
↓
Parameter Robustness
↓
Out-of-Sample Test
↓
Walk-Forward Test
↓
Monte Carlo / Robustness
↓
Forward Test
↓
Candidate for Live Evaluation

No stage should be considered automatically passed.

---

# 12. Current Research Conclusion

EA-041 has produced an initial positive baseline:

Profit Factor = 1.21
Net Profit = +$26.78
Max Equity DD = 4.50%

This is enough to justify continued research.

It is NOT enough to establish a reliable trading edge.

The most important next experiment is not parameter optimization.

The next experiment is:

LONGER HISTORICAL BACKTEST + TIMEFRAME COMPARISON.

Only after confirming that the basic Inside Bar + Trend hypothesis survives a substantially larger sample should additional filters be optimized.

---

# Research Status

EA-041_Inside_Pullback_Trend

Status:

RESEARCH IN PROGRESS

Current Stage:

BASELINE COMPLETED

Next Stage:

LONG-HISTORY / MULTI-TIMEFRAME VALIDATION

Live Trading Approval:

NO
