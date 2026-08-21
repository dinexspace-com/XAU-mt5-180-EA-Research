# XAUUSD MT5 EA Research

## Overview

This directory tracks the research status of Expert Advisors developed and tested in the `xauusd-mt5-ea-research` repository.

The objective is to evaluate trading ideas systematically using reproducible MetaTrader 5 backtests before considering optimization, forward testing, or live deployment.

Each EA should progress through the research process using recorded source code, test configuration, original Strategy Tester evidence, and documented results.

A strategy is not considered successful based only on its trading idea or source code.

---

# Research Principles

The research process follows these principles:

1. Define a clear trading hypothesis.
2. Implement the hypothesis as an EA.
3. Preserve the exact tested parameters.
4. Run a reproducible MetaTrader 5 backtest.
5. Preserve the original Strategy Tester evidence.
6. Evaluate the result using objective performance metrics.
7. Record failed results as well as successful results.
8. Do not treat optimization as proof of robustness.
9. Do not make live-trading claims from backtests alone.

Failed experiments remain part of the research record.

They provide evidence about which configurations or hypotheses did not work under the tested conditions.

---

# EA Research Index

| EA | Strategy | Symbol | Timeframe | Backtest | Result |
|---|---|---|---|---|---|
| `EA-016_EMA50_Slope` | EMA50 slope + price position | `XAUUSD.PRO` | `M1` | Completed | **FAIL** |

---

# EA-016 — EMA50 Slope

## Research Question

Can the direction of EMA50, combined with the position of price relative to EMA50, provide a simple trend-following signal with positive expectancy on XAUUSD?

---

## Hypothesis

The underlying hypothesis is:

```text
Rising EMA50 + price above EMA50
→ bullish trend condition

Falling EMA50 + price below EMA50
→ bearish trend condition
```

The EA attempts to trade in the direction of this detected short-term trend.

---

## Core Signal

### BUY

The strategy looks for:

```text
EMA50 rising
AND
Close above EMA50
```

### SELL

The strategy looks for:

```text
EMA50 falling
AND
Close below EMA50
```

Signals are evaluated using completed candles.

---

# Baseline Experiment

## Test Configuration

The recorded baseline backtest used:

| Setting | Value |
|---|---|
| EA | `EA-016_EMA50_Slope` |
| Symbol | `XAUUSD.PRO` |
| Timeframe | `M1` |
| Period | `2026.01.02 - 2026.06.08` |
| History Quality | `100% real ticks` |
| Initial Deposit | `$1,000` |
| Leverage | `1:500` |
| Lot Size | `0.01` |
| EMA Period | `50` |
| Minimum Trend Bars | `2` |
| Stop Loss | `300 points` |
| Take Profit | `600 points` |
| Maximum Spread | `30 points` |
| Break Even | `OFF` |
| Trailing Stop | `OFF` |

This configuration is treated as the EA-016 baseline experiment.

---

# Baseline Results

| Metric | Result |
|---|---:|
| Total Net Profit | `-$992.38` |
| Profit Factor | `0.86` |
| Expected Payoff | `-$0.30` |
| Sharpe Ratio | `-5.00` |
| Maximum Balance Drawdown | `99.28%` |
| Total Trades | `3,338` |
| Winning Trades | `30.35%` |
| Losing Trades | `69.65%` |
| Long Win Rate | `32.72%` |
| Short Win Rate | `27.77%` |
| Average Profit Trade | `$6.13` |
| Average Loss Trade | `-$3.10` |

---

# Baseline Verdict

## FAIL

The baseline EMA50 Slope configuration does not demonstrate positive expectancy over the tested period.

Primary failure evidence:

```text
Net Profit      = -$992.38
Profit Factor   = 0.86
Expected Payoff = -$0.30
Drawdown        = 99.28%
Sharpe Ratio    = -5.00
```

The balance curve also shows a persistent downward trajectory.

The baseline configuration therefore fails the current research test.

---

# What the Baseline Tells Us

The EA generated:

```text
3,338 trades
```

which provides a substantial trade sample for this specific test.

The primary problem is therefore not simply a lack of trading opportunities.

The test produced:

```text
Winning trades = 30.35%
Losing trades  = 69.65%
```

while:

```text
Average winner = $6.13
Average loser  = -$3.10
```

The average winning trade was larger than the average losing trade, but the winning frequency was insufficient to produce positive expectancy.

---

# Long vs Short Observation

The baseline produced:

```text
Long win rate  = 32.72%
Short win rate = 27.77%
```

Long trades performed better than short trades by win rate in this test.

This is an observation from the baseline result only.

It is not sufficient evidence to conclude that a long-only version of the strategy would be profitable.

A separate controlled backtest would be required to test that hypothesis.

---

# MFE / MAE Observation

The Strategy Tester reported:

```text
Correlation (Profit, MFE) = 0.82
Correlation (Profit, MAE) = 0.65
Correlation (MFE, MAE)    = 0.3858
```

The relatively high Profit/MFE correlation indicates that favorable excursion was meaningfully associated with realized profit in this test.

However, these correlations do not establish that a different exit mechanism would improve the strategy.

Any change to exit logic must be tested separately.

---

# Current Interpretation

The baseline evidence supports the following conclusion:

> The simple EMA50 slope + price-position signal, using the tested parameters on XAUUSD.PRO M1, did not produce a profitable trading system during the tested period.

The result does **not** establish that:

- EMA50 is universally ineffective;
- all EMA slope strategies fail;
- the strategy fails on every timeframe;
- the strategy fails under every parameter configuration;
- long-only trading would fail;
- different exit logic would fail;
- additional market filters would fail.

Those are separate hypotheses and require separate experiments.

---

# Research Issues Identified

## 1. High Losing-Trade Frequency

```text
Loss Trades = 69.65%
```

The signal generates many trades that fail before reaching the intended profit target.

---

## 2. Extreme Drawdown

```text
Maximum Drawdown = 99.28%
```

This makes the tested configuration unsuitable for live deployment.

---

## 3. Negative Expectancy

```text
Expected Payoff = -$0.30
Profit Factor   = 0.86
```

The current combination of entry frequency, win rate, and payoff structure does not produce positive expectancy.

---

## 4. Directional Difference

```text
Long win rate  = 32.72%
Short win rate = 27.77%
```

The difference between BUY and SELL performance is large enough to justify investigation, but not large enough to support a conclusion without a separate test.

---

# Next Research Questions

The baseline suggests several testable questions.

### RQ-01 — Trend Persistence

Does requiring a stronger or longer EMA50 slope condition reduce false entries?

Example variable:

```text
InpMinTrendBars
```

---

### RQ-02 — Direction Separation

Do BUY and SELL signals have materially different expectancy when tested independently?

Required experiments:

```text
BUY only
SELL only
```

---

### RQ-03 — Timeframe

Is the M1 timeframe too noisy for the EMA50 slope signal?

Possible future controlled tests:

```text
M5
M15
```

These should be treated as separate experiments rather than assumed improvements.

---

### RQ-04 — Exit Logic

Would alternative trade-management logic improve the relationship between favorable excursion and realized profit?

Possible variables already available in the EA:

```text
Break Even
Trailing Stop
Stop Loss
Take Profit
```

Each change should be tested independently where possible.

---

### RQ-05 — Market / Session Filter

Does strategy performance differ materially by trading session or hour?

The Strategy Tester contains entry and profit/loss distributions by hour and weekday.

This can be investigated before introducing a time filter into the EA.

A filter should not be added solely because a historical chart appears favorable; it requires a separate backtest.

---

# Research Discipline

Future EA-016 experiments should change as few variables as practical.

Example:

```text
Baseline
    ↓
Change one research variable
    ↓
Backtest
    ↓
Compare against baseline
    ↓
PASS / FAIL
```

Avoid changing multiple unrelated components simultaneously because the source of any performance change would become difficult to identify.

---

# Evidence

EA-016 source:

```text
EAs/
└── EA-016_EMA50_Slope/
    ├── EA-016_EMA50_Slope.mq5
    └── README.md
```

Baseline backtest evidence:

```text
Backtest/
└── EA-016_EMA50_Slope/
    ├── README.md
    ├── ReportTester-953688(1).html
    ├── ReportTester-953688(1).png
    ├── ReportTester-953688-hst(1).png
    ├── ReportTester-953688-mfemae(1).png
    └── ReportTester-953688-holding(1).png
```

The original MetaTrader 5 Strategy Tester report should remain the primary evidence for the baseline result.

---

# Research Status

| Item | Status |
|---|---|
| Strategy hypothesis defined | `DONE` |
| EA implementation available | `DONE` |
| Baseline backtest completed | `DONE` |
| Original evidence preserved | `DONE` |
| Baseline evaluated | `DONE` |
| Baseline result | **FAIL** |
| Optimization validated | `NO` |
| Forward test validated | `NO` |
| Live trading validated | `NO` |

---

# EA-016 Current Status

```text
EA-016_EMA50_Slope

Stage:
BASELINE RESEARCH

Evidence:
AVAILABLE

Baseline:
FAIL

Reason:
Negative net profit
Profit Factor below 1
Negative expected payoff
99.28% maximum drawdown
Persistent declining balance curve

Next:
Controlled research experiments
```

---

# Conclusion

EA-016 establishes a useful negative baseline.

The tested EMA50 Slope configuration produced enough trades to evaluate the basic hypothesis, but the resulting performance was unacceptable:

```text
3,338 trades
30.35% win rate
Profit Factor 0.86
Net Profit -$992.38
Maximum Drawdown 99.28%
```

The baseline should therefore be preserved rather than overwritten.

Future EA-016 experiments should be compared against this result to determine whether a specific modification produces a measurable improvement.

Until such improvements are independently tested and validated, EA-016 remains a **research strategy with a failed baseline**, not a live-trading system.
