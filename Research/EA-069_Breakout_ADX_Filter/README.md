# Research — EA-069 Breakout ADX Filter

## 1. Research Objective

Nghiên cứu khả năng sử dụng chiến lược **Price Breakout + ADX Filter**
cho XAUUSD trên MetaTrader 5.

EA nghiên cứu:

`EA-069_Breakout_ADX_Filter`

Mục tiêu của thử nghiệm baseline:

- Kiểm tra breakout đơn giản trên XAUUSD.
- Kiểm tra ADX có thể lọc các breakout trong điều kiện xu hướng yếu hay không.
- Đo Profit Factor, Expected Payoff, Drawdown và Win Rate.
- Tạo baseline để so sánh với các phiên bản cải tiến sau này.

---

## 2. Research Hypothesis

Giả thuyết ban đầu:

> Khi giá đóng cửa phá khỏi vùng High/Low của N nến trước
> và ADX lớn hơn một ngưỡng nhất định, xác suất breakout tiếp tục
> theo hướng phá vỡ có thể cao hơn breakout không có bộ lọc xu hướng.

Baseline sử dụng:

- Breakout Lookback: 20
- Breakout Buffer: 0
- ADX Period: 14
- ADX Threshold: 25

Tín hiệu được xác nhận bằng nến đã đóng.

### BUY

Close[1] > Highest High của vùng breakout  
AND  
ADX[1] > 25

### SELL

Close[1] < Lowest Low của vùng breakout  
AND  
ADX[1] > 25

---

## 3. Why ADX?

ADX (Average Directional Movement Index) được sử dụng để đo
**độ mạnh của xu hướng**, không trực tiếp xác định hướng của xu hướng.

Trong MQL5, ADX cung cấp:

- MAIN_LINE
- +DI
- -DI

Baseline EA-069 hiện chỉ sử dụng giá trị ADX chính làm bộ lọc.

Ý tưởng:

Price Breakout
        +
ADX > Threshold
        ↓
Trade

Mục tiêu là loại bỏ một phần breakout xảy ra khi thị trường
không có đủ sức mạnh xu hướng.

---

## 4. Baseline Test

Instrument:

XAUUSD.PRO

Timeframe:

M1

Test period:

2026.01.02 – 2026.03.31

Initial deposit:

$100

Lot:

0.01

Leverage:

1:500

History quality:

100% real ticks

---

## 5. Baseline Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$94.14 |
| Gross Profit | $199.94 |
| Gross Loss | -$294.08 |
| Profit Factor | 0.68 |
| Expected Payoff | -$0.44 |
| Recovery Factor | -1.00 |
| Sharpe Ratio | -5.00 |
| Maximum Drawdown | 94.14% |
| Total Trades | 214 |
| Winning Trades | 91 |
| Losing Trades | 123 |
| Win Rate | 42.52% |

Directional performance:

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 121 | 47.11% |
| Short | 93 | 36.56% |

---

## 6. Research Finding

### Result: BASELINE FAILED

The original hypothesis is **not supported by this baseline configuration**.

The combination:

Breakout(20)
+
ADX(14) > 25

did not produce a profitable system on the tested
XAUUSD.PRO M1 dataset.

Key evidence:

- Profit Factor < 1
- Expected Payoff < 0
- Net Profit < 0
- Maximum Drawdown = 94.14%
- Losing trades > winning trades

The account declined from the initial $100 to approximately $5.86.

Therefore this configuration is not suitable for production use.

---

## 7. Important Observation

The result does **not** prove that the general concept
"Breakout + ADX" is invalid.

It only rejects the specific tested implementation and parameter set.

The current filter asks essentially:

ADX > 25?

This confirms trend strength but does not determine whether the
directional structure supports the breakout.

ADX itself does not indicate bullish or bearish direction.

Therefore a breakout may satisfy ADX > 25 while still occurring
under unfavorable directional conditions.

---

## 8. Research Direction #1 — ADX Directional Confirmation

The first controlled modification should test the directional
components already available from ADX.

BUY candidate:

Price breaks resistance
AND
ADX > Threshold
AND
+DI > -DI

SELL candidate:

Price breaks support
AND
ADX > Threshold
AND
-DI > +DI

Reason:

The original EA checks trend strength but does not use the directional
information available from +DI and -DI.

This is the first variable that should be tested.

Do not change other major components simultaneously.

---

## 9. Research Direction #2 — Rising ADX

If Direction #1 does not produce sufficient improvement, test whether
ADX should also be increasing rather than merely exceeding a static
threshold.

Example research condition:

ADX[1] > Threshold
AND
ADX[1] > ADX[2]

This tests whether trend strength is expanding at the moment of breakout.

---

## 10. Research Direction #3 — Breakout Quality

The baseline accepts a breakout immediately after the closed candle
exceeds the previous range.

Future experiments may test:

- Breakout Buffer > 0
- ATR-normalized breakout distance
- Minimum breakout candle size
- Consolidation before breakout
- Breakout + retest confirmation

These must be tested individually rather than added simultaneously.

---

## 11. Research Direction #4 — Market Regime

M1 XAUUSD contains substantial short-term noise.

After improving the signal logic, the same strategy should be tested
independently on:

- M1
- M5
- M15

The purpose is not to select the best historical result automatically.

The objective is to determine whether the strategy behavior remains
consistent when market noise and timeframe change.

---

## 12. Experiment Order

Research should proceed in controlled stages.

Baseline:

Breakout + ADX > 25

↓

Experiment 01:

Breakout + ADX + DI direction

↓

Experiment 02:

Breakout + ADX + DI direction + Rising ADX

↓

Experiment 03:

Breakout quality / buffer

↓

Experiment 04:

M5 / M15 robustness

Only one major hypothesis should be changed at each stage.

This makes it possible to identify which modification actually
changes performance.

---

## 13. Evaluation Criteria

Each experiment should record at minimum:

- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Drawdown
- Win Rate
- Number of Trades
- Average Profit Trade
- Average Loss Trade

A new variant should always be compared against the original
EA-069 baseline.

Baseline reference:

Profit Factor: 0.68  
Expected Payoff: -0.44  
Maximum Drawdown: 94.14%  
Win Rate: 42.52%  
Trades: 214

---

## 14. Research Rule

Do not overwrite failed experiments.

Each result is research evidence.

A failed experiment should remain in the repository so later
changes can be compared against it.

Do not declare an improved strategy production-ready based only
on optimization of the same historical period.

Any promising variant must later undergo independent validation.

---

## 15. Current Research Status

EA-069_Breakout_ADX_Filter

Baseline implementation: COMPLETE

Baseline backtest: COMPLETE

Baseline result: FAIL

Primary issue:

The current Breakout + ADX threshold configuration does not demonstrate
positive expectancy on the tested XAUUSD M1 period.

Next research hypothesis:

**Add directional confirmation using +DI / -DI while keeping the
remaining baseline conditions unchanged.**
