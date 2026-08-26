# XAUUSD MT5 EA Research

Research log for systematic Expert Advisor experiments on **XAUUSD using MetaTrader 5**.

The purpose of this directory is to record the research conclusion of each EA experiment, including successful and failed strategies.

A failed backtest is preserved as a research result rather than removed.

---

## Research Process

Each EA follows the same basic workflow:

```text
Strategy Idea
     ↓
EA Implementation
     ↓
MT5 Backtest
     ↓
Performance Evaluation
     ↓
PASS / FAIL
     ↓
Research Conclusion
```

The objective is not to optimize every strategy until it becomes profitable.

The first objective is to determine whether the original strategy hypothesis demonstrates a measurable trading edge.

---

# EA-025 — Donchian Midline

## Hypothesis

Test whether the **midline of a Donchian Channel** can provide a simple directional signal for XAUUSD.

The EA uses:

```text
Upper   = Highest High
Lower   = Lowest Low
Midline = (Upper + Lower) / 2
```

Directional logic:

```text
Price > Midline → BUY
Price < Midline → SELL
```

The implementation also includes:

* Fixed lot size
* Stop Loss
* Take Profit
* Break Even
* Trailing Stop
* Spread filter
* One-position control through Magic Number

---

## Test Environment

| Setting         | Value                   |
| --------------- | ----------------------- |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Test Period     | 2026-01-02 → 2026-08-24 |
| Initial Deposit | $10,000                 |
| Leverage        | 1:500                   |
| Data Quality    | 100% real ticks         |
| Total Trades    | 37,212                  |

---

## Key Results

| Metric           |         Result |
| ---------------- | -------------: |
| Net Profit       | **-$9,994.04** |
| Profit Factor    |       **0.88** |
| Expected Payoff  |     **-$0.27** |
| Sharpe Ratio     |      **-5.00** |
| Maximum Drawdown |     **99.94%** |
| Winning Trades   |     **30.75%** |
| Losing Trades    |     **69.25%** |

Long and short performance were similarly weak:

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| Long      | 18,846 |   30.57% |
| Short     | 18,366 |   30.93% |

---

## Research Finding

**Result: FAIL**

The tested Donchian Midline hypothesis did not demonstrate a viable trading edge on **XAUUSD M1** under the tested configuration and period.

The most important evidence is:

* Profit Factor below 1.0
* Negative Expected Payoff
* Negative Sharpe Ratio
* Maximum drawdown of 99.94%
* Approximately 69% of trades were losing trades
* Weak results occurred on both BUY and SELL directions
* The balance curve deteriorated persistently during the test

Therefore, the current evidence does **not support using the Donchian Midline directional rule as a standalone strategy** under this test configuration.

---

## Interpretation

The test does not prove that the Donchian Channel itself has no value.

It shows that this specific implementation:

```text
Price relative to Donchian Midline
        +
Fixed SL / TP
        +
Break Even / Trailing Stop
```

was insufficient to produce a positive expectancy on the tested XAUUSD M1 dataset.

This distinction is important.

The failed result applies to the **tested strategy configuration**, not to every possible Donchian-based strategy.

---

## Research Decision

**EA-025_Donchian_Midline is retained as a failed baseline experiment.**

No production deployment is recommended based on this result.

The EA and its complete backtest are preserved so that future experiments can:

* compare results against this baseline;
* avoid repeating the same hypothesis unnecessarily;
* determine whether additional filters or fundamentally different Donchian logic materially improve performance.

---

## Repository References

EA source:

```text
EAs/
└── EA-025_Donchian_Midline/
```

Full backtest:

```text
Backtest/
└── EA-025_Donchian_Midline/
```

The Backtest directory contains the original MT5 Strategy Tester report and supporting charts.

---

## Research Status

| EA     | Strategy         | Symbol     | TF | Result |
| ------ | ---------------- | ---------- | -- | ------ |
| EA-025 | Donchian Midline | XAUUSD.PRO | M1 | ❌ FAIL |

This table should be updated as additional EA experiments are completed.

---

## Principle

This repository records **evidence, not only successful strategies**.

A failed EA is still a valid research result when:

1. the strategy hypothesis is clearly defined;
2. the implementation is preserved;
3. the backtest configuration is documented;
4. the original test evidence is retained;
5. the conclusion follows from the observed results.

The purpose is to build a reproducible research history for XAUUSD EA development.
