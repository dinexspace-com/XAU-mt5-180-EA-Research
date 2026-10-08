# EA-104 — Two-Spike Reversion Methodology

## 1. Strategy Definition

EA-104 tests a short-term mean-reversion hypothesis on XAUUSD M1.

The hypothesis is:

> Two consecutive abnormal candles moving in the same direction may represent short-term price overextension. A subsequent reversal candle may provide evidence that price is beginning to revert.

The strategy uses ATR to define abnormal candle range.

```text
Spike Range >= ATR × Spike ATR Multiplier
```

Baseline:

```text
ATR Period = 14
Spike ATR Multiplier = 1.5
```

---

## 2. Signal Structure

### BUY

```text
Candle[3] = bearish spike
Candle[2] = bearish spike
Candle[1] = bullish reversal
Close[1] > Close[2]
```

### SELL

```text
Candle[3] = bullish spike
Candle[2] = bullish spike
Candle[1] = bearish reversal
Close[1] < Close[2]
```

The EA evaluates the setup using completed candles and executes only on a new bar.

---

## 3. Baseline Specification

| Parameter            |      Value |
| -------------------- | ---------: |
| Symbol               | XAUUSD.PRO |
| Timeframe            |         M1 |
| Lot                  |       0.01 |
| Stop Loss            | 300 points |
| Take Profit          | 600 points |
| ATR Period           |         14 |
| Spike ATR Multiplier |        1.5 |
| Max Spread           |  30 points |
| Break Even Start     | 150 points |
| Break Even Offset    |          0 |
| Trailing Start       | 200 points |
| Trailing Distance    | 200 points |
| Magic Number         |     123459 |

---

## 4. Baseline Experiment

**Experiment ID**

```text
EA104-M1-BASELINE-001
```

**Test Period**

```text
2026.01.02 – 2026.04.01
```

**Model**

```text
100% real ticks
```

**Initial Deposit**

```text
$1,000
```

The Strategy Tester report records 86,539 bars and 40,346,891 ticks for the baseline test.

---

## 5. Baseline Results

| Metric          |   Result |
| --------------- | -------: |
| Net Profit      | -$129.77 |
| Profit Factor   |     0.83 |
| Expected Payoff |   -$0.22 |
| Recovery Factor |    -0.78 |
| Sharpe Ratio    |    -5.00 |
| Max Balance DD  |   15.76% |
| Max Equity DD   |   16.08% |
| Total Trades    |      590 |
| Profit Trades   |   47.80% |
| Loss Trades     |   52.20% |

## These results indicate that the baseline did not establish a positive statistical edge in the tested sample.

## 6. Acceptance Criteria

A research candidate should not be considered validated from a single profitable backtest.

Evaluation should consider:

1. Positive Net Profit.
2. Profit Factor above 1.00.
3. Positive Expected Payoff.
4. Controlled drawdown.
5. Positive risk-adjusted performance.
6. Sufficient trade count.
7. Stability across reasonable parameter changes.
8. Out-of-sample confirmation.
9. Robustness testing.
10. Walk-forward consistency.

Passing a single historical test is insufficient for live validation.

---

## 7. Controlled Experiment Policy

EA-104 follows a controlled research process.

The baseline must remain unchanged.

Each research experiment should modify one logical variable group.

Examples:

```text
Spike threshold
ATR period
Spike structure
Reversal confirmation
Direction
SL/TP
Break Even
Trailing
Session
Market regime
```

Results must be compared against:

```text
EA104-M1-BASELINE-001
```

---

## 8. Research Priority

The research order is:

```text
1. Spike ATR Threshold
2. ATR Period
3. Spike Sequence
4. Spike Candle Structure
5. Reversal Confirmation
6. BUY vs SELL
7. Stop Loss / Take Profit
8. Break Even
9. Trailing Stop
10. Trading Session
11. Market Regime
12. Out-of-Sample
13. Robustness
14. Walk-forward
```

This sequence is intended to determine whether the underlying entry hypothesis has an edge before extensive exit or parameter optimization is performed.

---

## 9. Validation Lifecycle

```text
Strategy Code
      ↓
Baseline
      ↓
Baseline Assessment
      ↓
Controlled Research
      ↓
Hypothesis Selection
      ↓
Out-of-Sample
      ↓
Robustness
      ↓
Walk-forward
      ↓
Forward Test
      ↓
Live Validation
```

Failure at an earlier stage prevents progression to later stages.

---

## 10. Current Status

```text
Strategy Code: COMPLETE
Baseline: COMPLETE
Baseline Result: FAIL
Controlled Research: NOT STARTED
OOS: NOT STARTED
Robustness: NOT STARTED
Walk-forward: NOT STARTED
Forward Test: NOT STARTED
Live Validation: NOT VALIDATED
```

EA-104 should currently be treated as a **research experiment**, not as a production trading system.
