# Research — EA-020 MACD Signal Trend

## Research Objective

**EA-020_MACD_Signal_Trend** được xây dựng để kiểm tra một giả thuyết đơn giản:

> Liệu tín hiệu MACD crossover kết hợp với vị trí của MACD so với zero line có tạo ra lợi thế giao dịch có thể đo lường được trên XAUUSD hay không?

EA-020 hiện được xem là một **baseline strategy**.

Mục tiêu ở giai đoạn này không phải tối ưu tham số để tạo ra kết quả đẹp, mà là:

1. Xây dựng logic chiến lược rõ ràng.
2. Backtest bằng dữ liệu thực.
3. Đánh giá chiến lược có edge hay không.
4. Xác định nguyên nhân thất bại.
5. Chỉ thay đổi từng thành phần có giả thuyết rõ ràng.
6. So sánh phiên bản mới với baseline.

---

## Strategy Hypothesis

EA sử dụng MACD crossover làm tín hiệu entry và zero line làm trend filter.

### BUY

```text
MACD Previous <= Signal Previous
AND
MACD Current > Signal Current
AND
MACD Current > 0
```

### SELL

```text
MACD Previous >= Signal Previous
AND
MACD Current < Signal Current
AND
MACD Current < 0
```

Giả thuyết:

```text
MACD crossover
+
Zero-line trend confirmation
=
Momentum entry aligned with trend
```

Nếu giả thuyết đúng, chiến lược phải tạo ra expectancy dương sau một số lượng giao dịch đủ lớn.

---

# Baseline — EA-020

## Test Environment

```text
EA:              EA-020_MACD_Signal_Trend
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 – 2026.08.01
Initial Deposit: $1,000
Leverage:        1:500
History Quality: 100% real ticks
```

### Baseline Parameters

```text
Lot Size:          0.01
Stop Loss:         300 points
Take Profit:       600 points

Max Spread:        30 points

Break Even:        Enabled
Break Even Trigger:150 points

Trailing Stop:     Enabled
Trailing Distance: 200 points
```

---

# Baseline Results

| Metric           |     Result |
| ---------------- | ---------: |
| Total Trades     |      2,813 |
| Winning Trades   |        833 |
| Losing Trades    |      1,980 |
| Win Rate         |     29.61% |
| Loss Rate        |     70.39% |
| Total Net Profit |   -$993.58 |
| Gross Profit     |  $5,150.72 |
| Gross Loss       | -$6,144.30 |
| Profit Factor    |       0.84 |
| Expected Payoff  |     -$0.35 |
| Sharpe Ratio     |      -5.00 |
| Maximum Drawdown |     99.38% |

### Direction

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| SELL      |  1,444 |   30.75% |
| BUY       |  1,369 |   28.41% |

SELL performed slightly better than BUY by win rate, but both directions remained insufficient to make the overall strategy profitable.

---

# Baseline Verdict

```text
STATUS: FAIL
```

The baseline does not demonstrate a profitable trading edge under the tested conditions.

Primary evidence:

```text
Profit Factor     = 0.84
Expected Payoff   = -0.35
Net Profit        = -993.58 USD
Maximum Drawdown  = 99.38%
```

The sample contains **2,813 trades**, making this result useful as a baseline for subsequent experiments.

The baseline should therefore be preserved rather than overwritten.

---

# Research Findings

## Finding 01 — Reward/Risk Is Not the Primary Problem

Average result:

```text
Average Winning Trade = +$6.18
Average Losing Trade  = -$3.10
```

The average winner is approximately twice the average loser.

This broadly reflects the intended:

```text
SL = 300 points
TP = 600 points
```

Therefore, simply increasing Take Profit is not currently supported as the first research direction.

---

## Finding 02 — Win Rate Is Too Low

The main observed weakness is:

```text
Win Rate  = 29.61%
Loss Rate = 70.39%
```

The strategy generates too many losing entries.

Research should therefore focus first on **entry quality and market-condition filtering**, rather than immediately increasing risk or position size.

---

## Finding 03 — Losing Sequences Are Significant

Baseline:

```text
Maximum consecutive wins   = 6
Maximum consecutive losses = 16

Average consecutive wins   = 1
Average consecutive losses = 3
```

This suggests that the strategy can repeatedly generate entries during market conditions where its signal has poor effectiveness.

A future filter should therefore be tested for its ability to avoid unsuitable market regimes.

---

## Finding 04 — BUY and SELL Both Underperform

```text
SELL Win Rate = 30.75%
BUY Win Rate  = 28.41%
```

SELL is slightly stronger, but the difference is not large enough to conclude that disabling BUY alone would solve the strategy.

Direction-specific performance can be investigated later, but it is not yet considered the primary issue.

---

## Finding 05 — Equity Curve Is Structurally Negative

The balance curve trends downward across the test period and eventually approaches depletion of the initial account.

This is consistent with:

```text
Net Profit       = -$993.58
Relative DD      = 99.38%
Profit Factor    = 0.84
LR Correlation   = -0.96
```

The baseline therefore does not appear to fail because of only a small number of isolated losing trades.

The tested configuration has a persistent negative expectancy.

---

# Important Technical Issue

The current EA source also requires verification of its position-management execution.

The source contains logic that can return from `OnTick()` when an existing position is detected before `ManagePosition()` is reached.

Therefore the intended:

```text
Break Even
Trailing Stop
```

must not yet be assumed to operate correctly merely because they are enabled in the Strategy Tester inputs.

This should be treated as a **code-validation issue**, separate from strategy optimization.

---

# Research Priorities

Research should proceed one hypothesis at a time.

## Priority 1 — Validate Execution Logic

Before changing the strategy:

```text
Verify Break Even
Verify Trailing Stop
Verify position management
Verify actual SL/TP execution
```

Reason:

A strategy should not be optimized while important execution logic is potentially behaving differently from its intended design.

---

## Priority 2 — Improve Entry Quality

If execution is confirmed correct, investigate why approximately 70% of entries lose.

Primary research question:

> Under what market conditions do MACD crossover signals on XAUUSD M1 fail most frequently?

Potential variables to investigate individually:

```text
Trend strength
Volatility
Trading session
Higher-timeframe direction
Distance from zero line
MACD momentum
```

These are **research candidates**, not approved modifications.

Each candidate must be tested separately against the baseline.

---

## Priority 3 — Time / Session Analysis

The MT5 report contains entry and profit/loss distributions by hour, weekday and month.

These should be analyzed to determine whether specific trading periods systematically reduce performance.

No session should be removed solely because its chart appears weak.

A session filter requires a separate controlled backtest.

---

## Priority 4 — Exit Optimization

Only after entry quality is better understood should the following be tested:

```text
Stop Loss
Take Profit
Break Even
Trailing Stop
```

Changing exit parameters before understanding poor entry quality risks optimizing around a weak underlying signal.

---

# Experiment Rule

Every experiment must change **one primary variable at a time** whenever practical.

Example:

```text
Baseline
   ↓
Add Filter A
   ↓
Backtest
   ↓
Compare with Baseline
   ↓
PASS / FAIL
```

Avoid:

```text
Change MACD
+ change SL
+ change TP
+ add session filter
+ add trend filter
→ backtest
```

because the source of any improvement or deterioration becomes unclear.

---

# Evaluation Metrics

Every experiment should record at minimum:

| Metric             | Purpose                   |
| ------------------ | ------------------------- |
| Total Trades       | Sample size               |
| Net Profit         | Absolute result           |
| Profit Factor      | Profitability             |
| Expected Payoff    | Expectancy                |
| Win Rate           | Entry effectiveness       |
| Maximum Drawdown   | Risk                      |
| Average Win        | Reward characteristics    |
| Average Loss       | Risk characteristics      |
| Consecutive Losses | Losing streak risk        |
| Sharpe Ratio       | Risk-adjusted performance |

Results must always be compared against the EA-020 baseline.

---

# Research Log

| Version         | Change                            | Result                             | Status      |
| --------------- | --------------------------------- | ---------------------------------- | ----------- |
| EA-020 Baseline | MACD crossover + zero-line filter | PF 0.84 / DD 99.38% / Net -$993.58 | FAIL        |
| Next Experiment | TBD                               | —                                  | NOT STARTED |

Add new experiments below this baseline rather than modifying the original result.

---

# Research Rules

1. Preserve the original EA-020 baseline.
2. Do not overwrite failed experiments.
3. Keep the original MT5 Strategy Tester evidence.
4. Use real-tick testing where available.
5. Change one primary hypothesis at a time.
6. Record failed experiments as well as successful experiments.
7. Do not judge a strategy using Net Profit alone.
8. Do not increase lot size to make an unprofitable strategy appear profitable.
9. Do not treat optimization results as proof of robustness.
10. Do not move to live trading based only on a single backtest.

---

# Current Research Status

```text
EA-020_MACD_Signal_Trend

Strategy implementation     DONE
        ↓
Baseline backtest           DONE
        ↓
Baseline evaluation         FAIL
        ↓
Execution validation        REQUIRED
        ↓
Entry-quality research      PENDING
        ↓
Controlled experiments      PENDING
        ↓
Robustness validation       PENDING
```

## Current Conclusion

**EA-020 is a failed baseline, but a valid research result.**

The current MACD crossover + zero-line trend filter does not demonstrate sufficient edge on the tested XAUUSD.PRO M1 dataset.

The next research stage should **not** begin with parameter optimization.

The first action is to validate the EA's position-management execution. After that, research should focus on identifying why the MACD entry signal produces a 70.39% losing-trade rate and testing individual filters against this baseline.
