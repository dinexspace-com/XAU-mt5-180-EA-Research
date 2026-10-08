# EA-103 — EMA20 + RSI Research Methodology

## 1. Strategy Definition

EA-103 is a short-term XAUUSD M1 mean-reversion strategy.

The model identifies price extension away from EMA20 and combines that extension with an RSI extreme.

### BUY Condition

```text
Close[1] < EMA20[1] - Minimum EMA Distance
AND
RSI[1] <= RSI Oversold
```

### SELL Condition

```text
Close[1] > EMA20[1] + Minimum EMA Distance
AND
RSI[1] >= RSI Overbought
```

The strategy evaluates the completed candle and executes on a new bar.

---

## 2. Baseline Specification

**Baseline ID:** `EA103-M1-BASELINE-001`

| Parameter            |   Baseline |
| -------------------- | ---------: |
| EMA Period           |         20 |
| RSI Period           |         14 |
| RSI Oversold         |         30 |
| RSI Overbought       |         70 |
| Minimum EMA Distance | 100 points |
| Stop Loss            | 300 points |
| Take Profit          | 600 points |
| Break Even Start     | 150 points |
| Trailing Start       | 200 points |
| Trailing Distance    | 200 points |

---

## 3. Baseline Test

The baseline was tested on:

* Symbol: XAUUSD.PRO
* Timeframe: M1
* Period: 2026.01.02 – 2026.03.31
* Initial Deposit: $1,000
* Leverage: 1:500
* History Quality: 100%
* Ticks: 38,264,803
* Trades: 4,460

The baseline produced:

* Net Profit: **+$2,636.37**
* Profit Factor: **1.54**
* Expected Payoff: **+$0.59**
* Max Equity Drawdown: **2.43%**
* Relative Equity Drawdown: **4.45%**
* Sharpe Ratio: **61.83**

**Baseline Classification:** `PASS FOR FURTHER RESEARCH`

---

## 4. Acceptance Criteria

A research candidate must not be selected solely because it has the highest Net Profit.

Evaluation must consider:

* Net Profit
* Profit Factor
* Expected Payoff
* Maximum Drawdown
* Sharpe Ratio
* Trade Count
* BUY / SELL balance
* Consecutive wins and losses
* Stability across parameter ranges

---

## 5. Controlled Experiment Policy

Each experiment must:

1. Start from the frozen baseline.
2. Change one logical parameter group.
3. Record the exact parameter configuration.
4. Record all relevant performance metrics.
5. Compare results against the baseline.
6. Preserve negative or inconclusive results as research evidence.

Broad multi-parameter optimization is not allowed during the initial research stage.

---

## 6. Validation Policy

The research lifecycle is:

```text
Baseline
    ↓
Controlled Parameter Research
    ↓
Entry / Exit Research
    ↓
Session / Regime Analysis
    ↓
Out-of-Sample
    ↓
Robustness
    ↓
Walk-Forward
    ↓
Forward Test
    ↓
Live Validation
```

A positive baseline result does not qualify the EA for live trading.

The current EA-103 baseline remains:

```text
NOT VALIDATED FOR LIVE TRADING
```

---

## 7. Current Methodology Status

**Strategy Code:** COMPLETE

**Baseline:** COMPLETE

**Baseline Result:** PASS FOR FURTHER RESEARCH

**Controlled Research:** IN PROGRESS

**OOS:** NOT STARTED

**Robustness:** NOT STARTED

**Walk-Forward:** NOT STARTED

**Forward Test:** NOT STARTED

**Live Trading:** NO

**Optimization Status:** `CONTROLLED RESEARCH ONLY`
