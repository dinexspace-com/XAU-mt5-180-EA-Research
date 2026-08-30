# XAUUSD MT5 EA Research

## Research Objective

This directory documents the research process for the XAUUSD Expert Advisors contained in this repository.

The purpose is to:

- Record each strategy hypothesis.
- Compare EA implementations.
- Record backtest findings.
- Identify weaknesses and potential improvements.
- Preserve failed experiments as research evidence.
- Prevent optimization results from replacing or hiding baseline results.

Each EA should be evaluated through the following process:

```text
Strategy Idea
→ Implementation
→ Baseline Backtest
→ Analysis
→ Improvement
→ Retest
```

---

# EA-031 — SAR + EMA50

## Research Status

**Status: BASELINE TEST COMPLETED — FAIL**

EA-031 combines:

- Parabolic SAR
- EMA50 trend filter
- Fixed Stop Loss
- Fixed Take Profit

The baseline configuration has been implemented and tested on XAUUSD.

---

## Strategy Hypothesis

The original hypothesis is:

> Parabolic SAR can identify short-term directional movement, while EMA50 can filter trades so that positions are opened in the direction of the broader trend.

### BUY

```text
SAR below price
AND
Price above EMA50
```

### SELL

```text
SAR above price
AND
Price below EMA50
```

The baseline test is intended to determine whether this simple combination has sufficient statistical advantage before additional filters or optimization are introduced.

---

## Baseline Test

### Environment

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 30 points |
| Maximum Positions | 1 |
| Break Even | Disabled |
| Trailing Stop | Disabled |
| History Quality | 100% real ticks |

---

## Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 5,680 |
| Winning Trades | 31.94% |
| Losing Trades | 68.06% |
| Net Profit | **-$991.82** |
| Profit Factor | **0.92** |
| Expected Payoff | **-$0.17** |
| Maximum Drawdown | **99.22%** |
| Sharpe Ratio | **-5.00** |

### Baseline Result

**FAIL**

The original SAR + EMA50 configuration does not demonstrate a profitable or deployable strategy under the tested conditions.

---

## Key Findings

### 1. Negative Expectancy

Profit Factor:

```text
0.92
```

Expected Payoff:

```text
-$0.17
```

The baseline strategy therefore does not show positive expectancy.

---

### 2. Very High Drawdown

Maximum drawdown reached:

```text
99.22%
```

This represents near-total account drawdown and is unacceptable for deployment.

---

### 3. Low Win Rate

Winning trades:

```text
31.94%
```

Losing trades:

```text
68.06%
```

The strategy loses substantially more often than it wins.

---

### 4. Winners Are Larger Than Losers

Average winning trade:

```text
$6.24
```

Average losing trade:

```text
-$3.18
```

The average winner is approximately twice the average loser.

However, this payoff advantage was insufficient to compensate for the low win rate.

---

### 5. BUY and SELL Show Similar Weakness

BUY:

```text
2,820 trades
32.73% won
```

SELL:

```text
2,860 trades
31.15% won
```

The poor baseline result cannot be attributed solely to one trade direction.

Both directions produced similarly low win rates.

---

### 6. Large Trade Sample

The test generated:

```text
5,680 trades
```

This provides a useful baseline dataset for subsequent comparison.

A failed strategy should therefore not be deleted from the research repository.

Its results should be retained so that future modifications can be compared against the original implementation.

---

## Current Research Interpretation

The baseline test demonstrates that:

**SAR + EMA50 alone is not sufficient to produce a profitable EA under the tested XAUUSD.PRO M1 conditions.**

The test does **not** yet establish:

- Whether another timeframe performs better.
- Whether another SL/TP configuration performs better.
- Whether Break Even improves performance.
- Whether Trailing Stop improves performance.
- Whether session filtering improves performance.
- Whether additional trend or volatility filters improve performance.
- Whether results remain similar over other historical periods.

These questions require separate tests.

---

## Research Rules

To avoid overfitting and preserve reproducibility:

1. Keep the original baseline result.
2. Change one research variable or a clearly defined parameter group at a time.
3. Record every meaningful test.
4. Do not delete failed tests.
5. Do not classify an EA as successful based on a single profitable backtest.
6. Keep source code and backtest evidence linked to the tested EA version.
7. Separate observed results from hypotheses.
8. Validate improvements on data outside the optimization period before considering deployment.

---

## Evidence

### EA Source

```text
EAs/
└── EA-031_SAR_EMA50/
    ├── EA-031_SAR_EMA50.mq5
    └── README.md
```

### Baseline Backtest

```text
Backtest/
└── EA-031_SAR_EMA50/
    ├── README.md
    ├── ReportTester-952747(4).html
    ├── ReportTester-952747(4).png
    ├── ReportTester-952747-hst(4).png
    ├── ReportTester-952747-mfemae(4).png
    └── ReportTester-952747-holding(4).png
```

---

## EA Research Index

| EA | Strategy | Baseline | Status |
|---|---|---:|---|
| EA-031 | SAR + EMA50 | PF 0.92 / DD 99.22% | ❌ FAIL |

Additional EAs should be added to this table as research progresses.

---

## Current Conclusion

EA-031 has successfully completed the **baseline research stage**, but the strategy itself failed the baseline performance test.

```text
EA implementation: COMPLETE
Baseline backtest: COMPLETE
Baseline performance: FAIL
Production ready: NO
```

The baseline should now be preserved as the reference point for any future EA-031 experiments.
