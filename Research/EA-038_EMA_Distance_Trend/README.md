# EA Research

This directory contains research notes, evaluations, and conclusions for the Expert Advisors developed in the **XAUUSD MT5 EA Research** project.

The purpose of this section is to separate strategy research and conclusions from EA source code and raw MetaTrader 5 backtest artifacts.

---

# EA-038 — EMA Distance Trend

## Research Objective

Evaluate whether trend strength measured by the distance between a fast EMA and a slow EMA can provide a viable systematic trading signal for XAUUSD.

The strategy attempts to avoid weak EMA trend signals by requiring the EMA separation to exceed a volatility-adjusted threshold based on ATR.

Core concept:

```text
EMA Distance >= ATR × Minimum Distance Ratio
```

Baseline configuration:

```text
Fast EMA = 20
Slow EMA = 50
ATR Period = 14
ATR Ratio = 0.5
```

---

## Strategy Hypothesis

A simple EMA relationship:

```text
Fast EMA > Slow EMA
```

or:

```text
Fast EMA < Slow EMA
```

may generate signals even when the trend is weak.

EA-038 therefore adds an EMA-distance filter.

### Long

```text
EMA20 > EMA50

AND

EMA20 - EMA50 >= ATR(14) × 0.5
```

### Short

```text
EMA20 < EMA50

AND

EMA50 - EMA20 >= ATR(14) × 0.5
```

The research hypothesis is that sufficiently large EMA separation relative to current volatility may identify stronger directional market conditions.

---

## Baseline Test

The initial implementation was tested using:

| Parameter | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $1,000 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Fast EMA | 20 |
| Slow EMA | 50 |
| ATR | 14 |
| ATR Ratio | 0.5 |
| Break Even | Disabled |
| Trailing Stop | Disabled |
| History Quality | 100% real ticks |

---

## Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 7,198 |
| Winning Trades | 32.43% |
| Losing Trades | 67.57% |
| Net Profit | -$991.90 |
| Profit Factor | 0.94 |
| Expected Payoff | -$0.14 |
| Sharpe Ratio | -5.00 |
| Maximum Drawdown | 99.27% |
| Average Profit Trade | $6.24 |
| Average Loss Trade | -$3.20 |

---

## Research Finding

### Baseline Result: FAILED

The baseline implementation does not demonstrate a viable trading edge under the tested configuration.

The account experienced approximately 99% maximal drawdown and lost almost the entire initial deposit.

Although:

```text
Average Winner = $6.24
Average Loser  = -$3.20
```

the winning trade percentage was only:

```text
32.43%
```

This was insufficient to generate positive expectancy.

The resulting Profit Factor was:

```text
0.94
```

and Expected Payoff was:

```text
-$0.14 per trade
```

Therefore, the tested configuration does not meet the requirements for deployment.

---

## Important Interpretation

This result rejects the **tested baseline configuration**, not necessarily the entire EMA-distance hypothesis.

The backtest only establishes that:

```text
EMA 20 / EMA 50
ATR 14
ATR Ratio 0.5
M1
SL 300
TP 600
```

did not produce acceptable results on the tested XAUUSD.PRO dataset.

No conclusion should yet be made about other:

- Timeframes
- EMA combinations
- ATR ratios
- Trading sessions
- Entry filters
- Exit methods
- Stop-loss / take-profit structures

without separate testing.

---

## Observations

### 1. Trade Frequency

The EA generated:

```text
7,198 trades
```

during approximately three months of M1 testing.

Average position holding time was:

```text
00:03:12
```

This indicates a very high-frequency baseline behavior for the strategy.

### 2. Win/Loss Structure

The strategy produced:

```text
Winning trades = 32.43%
Losing trades  = 67.57%
```

However, the average winner was approximately:

```text
$6.24
```

versus an average loss of:

```text
-$3.20
```

The payoff asymmetry was favorable, but the hit rate was not sufficient to overcome the frequency of losses.

### 3. Drawdown

Maximum balance drawdown reached:

```text
99.27%
```

This is unacceptable for deployment and indicates that the baseline configuration has no usable risk-adjusted performance.

### 4. MFE Relationship

The Strategy Tester reported:

```text
Correlation (Profit, MFE) = 0.84
```

This indicates a strong relationship in this test between favorable price excursion and final trade profit.

This metric may be useful when investigating alternative exit management, but it does not by itself demonstrate that a profitable exit modification exists.

---

## Next Research Questions

EA-038 may proceed to further research only as an experimental strategy.

The next tests should determine whether the weakness comes primarily from:

1. M1 market noise.
2. EMA parameter selection.
3. ATR distance threshold.
4. Lack of session filtering.
5. Entry timing.
6. Fixed SL/TP configuration.
7. Exit management.

Each modification should be tested separately where possible so that its effect can be measured.

---

## Research Status

```text
Strategy: EA-038_EMA_Distance_Trend
Baseline Backtest: COMPLETE
Baseline Result: FAIL
Live Deployment: NOT APPROVED
Further Research: OPTIONAL / EXPERIMENTAL
```

EA-038 must not be classified as a validated or production-ready strategy based on the current evidence.

---

## Evidence

Source implementation:

```text
EAs/EA-038_EMA_Distance_Trend/
```

Backtest evidence:

```text
Backtest/EA-038_EMA_Distance_Trend/
```

The original Strategy Tester report and associated charts should remain preserved in the Backtest directory so the research conclusion can be independently checked.

---

## Research Principle

A strategy is not considered successful because its trading logic appears reasonable.

The research process is:

```text
Hypothesis
    ↓
EA Implementation
    ↓
Backtest
    ↓
Evidence
    ↓
PASS / FAIL
    ↓
Further Research or Rejection
```

For EA-038, the current evidence supports:

```text
BASELINE = FAIL
```
