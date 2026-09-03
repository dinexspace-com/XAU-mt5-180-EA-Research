# Research

## Overview

This directory contains the research layer of the **XAUUSD MT5 EA Research** project.

The purpose of this section is to document the reasoning, observations, hypotheses, and research conclusions that lead from an initial trading idea to an implemented and tested MetaTrader 5 Expert Advisor.

The research process follows a simple principle:

```text
Trading Idea
    ↓
Define Explicit Rules
    ↓
Implement EA
    ↓
Baseline Backtest
    ↓
Analyze Results
    ↓
Identify Weaknesses
    ↓
Form Research Hypotheses
    ↓
Modify Strategy
    ↓
Backtest Again
    ↓
Compare With Baseline
```

The objective is not to assume that a trading idea is profitable.

Every strategy must be converted into explicit rules, implemented, tested on historical data, and evaluated using measurable evidence.

---

## Research Scope

The primary research market is:

**XAUUSD — Gold**

Strategies in this repository are designed and evaluated primarily as automated trading systems for MetaTrader 5.

Research may include:

- Price-action strategies
- Trend-following strategies
- Continuation strategies
- Reversal strategies
- Breakout strategies
- Momentum strategies
- Volatility-based strategies
- Time/session filters
- Technical indicator filters
- Entry filters
- Exit logic
- Stop Loss and Take Profit structures
- Break Even logic
- Trailing Stop logic
- Risk-management rules

Each strategy is treated as an independent research hypothesis until backtesting provides evidence supporting or rejecting it.

---

## Research Principles

### 1. Rules Must Be Explicit

A strategy must be expressed as rules that can be implemented programmatically.

Avoid subjective descriptions such as:

```text
Enter when the market looks strong.
```

Prefer explicit conditions such as:

```text
Fast SMA > Slow SMA
AND
Candle[1] closes above its open
AND
Candle[2] closes above its open
→ BUY
```

If a trading concept cannot yet be expressed as deterministic rules, it remains a research idea and should not be treated as a completed EA specification.

---

### 2. Baseline Before Optimization

Every EA should first be tested using a clearly defined baseline configuration.

The baseline establishes a reference point.

Optimization should not begin before the baseline result is recorded.

```text
Baseline
    ↓
Measure
    ↓
Analyze
    ↓
Hypothesis
    ↓
Change
    ↓
Retest
```

This prevents parameter optimization from hiding weaknesses in the underlying strategy logic.

---

### 3. Preserve Failed Results

Failed strategies and failed configurations are part of the research process.

They should not be deleted simply because they are unprofitable.

A failed baseline provides evidence about:

- Weak entry logic
- Poor market regime selection
- Excessive trade frequency
- Inadequate trend filtering
- Ineffective exit logic
- Poor Stop Loss / Take Profit structure
- Spread sensitivity
- Time/session sensitivity
- Strategy assumptions that do not hold under testing

Failed tests can therefore guide the next research iteration.

---

### 4. Separate Evidence From Hypothesis

Backtest results are evidence.

Ideas about why those results occurred are hypotheses.

These should not be confused.

Example:

```text
Evidence:
Profit Factor = 0.88

Hypothesis:
The two-candle signal may generate too many low-quality continuation entries.

Required action:
Design a controlled test before accepting or rejecting the hypothesis.
```

A strategy should not be modified solely because an explanation sounds reasonable.

Changes should be tested.

---

### 5. Change One Logical Component at a Time

When possible, research iterations should isolate individual changes.

Example:

```text
Baseline
    ↓
Test trend filter
    ↓
Test entry filter
    ↓
Test trading session
    ↓
Test exit logic
    ↓
Test risk parameters
```

Changing many components simultaneously makes it difficult to determine which modification caused the result.

---

## Current Research Case

### EA-040 — Two-Candle Continuation

EA-040 is currently being used as a research case for a simple trend-continuation strategy.

The baseline strategy combines:

```text
SMA Trend Filter
+
Two Consecutive Directional Candles
+
Fixed Stop Loss / Take Profit
+
Break Even
+
Trailing Stop
```

Trend detection:

```text
Fast SMA = 20
Slow SMA = 50
```

BUY concept:

```text
Fast SMA > Slow SMA
+
Two consecutive bullish candles
→ BUY
```

SELL concept:

```text
Fast SMA < Slow SMA
+
Two consecutive bearish candles
→ SELL
```

Baseline trade-management parameters:

```text
Lot Size           = 0.01
Stop Loss          = 300
Take Profit        = 600
Maximum Spread     = 30

Break Even         = Enabled
Break Even Start   = 150
Break Even Shift   = 10

Trailing Stop      = Enabled
Trailing Start     = 200
Trailing Step      = 50
```

---

## EA-040 Baseline Test

Baseline environment:

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Total Trades | 4,630 |

Baseline result:

| Metric | Result |
|---|---:|
| Total Net Profit | -$993.54 |
| Profit Factor | 0.88 |
| Expected Payoff | -$0.21 |
| Winning Trades | 42.76% |
| Losing Trades | 57.24% |
| Maximum Drawdown | 99.37% |
| Sharpe Ratio | -5.00 |

### Baseline Status

**FAIL**

The baseline implementation is not profitable under the tested XAUUSD.PRO M1 configuration.

This result is retained as the reference benchmark for future EA-040 research iterations.

---

## EA-040 Research Questions

The baseline result raises several questions that require controlled testing.

### Signal Quality

Does the basic two-candle continuation pattern provide sufficient predictive value on XAUUSD?

### Trend Filter

Is SMA 20 / SMA 50 sufficient to distinguish useful continuation conditions from sideways or noisy market conditions?

### Trade Frequency

The baseline generated 4,630 trades during the tested period.

Research should determine whether the entry conditions are too permissive and whether reducing low-quality signals improves expectancy.

### Timeframe

The baseline uses M1.

The strategy should not automatically be assumed to behave similarly on other timeframes.

Any alternative timeframe must be tested independently.

### Trading Session

The baseline allows signals across available trading hours.

Session-based filtering may be investigated to determine whether performance differs across market periods.

### Exit Management

The baseline combines:

```text
SL / TP
+
Break Even
+
Trailing Stop
```

These components should be investigated separately where practical to determine their effect on expectancy and drawdown.

---

## Research Workflow

For each strategy:

```text
1. Define the trading hypothesis
2. Convert the hypothesis into explicit rules
3. Implement the minimum working EA
4. Compile and verify execution
5. Run baseline backtest
6. Save the complete Strategy Tester evidence
7. Record baseline metrics
8. Mark baseline PASS or FAIL
9. Analyze the failure/success
10. Define the next hypothesis
11. Change the minimum necessary logic
12. Backtest again
13. Compare against baseline
14. Preserve results
15. Repeat only when evidence justifies another iteration
```

---

## Research Record Template

Each research iteration should record:

```text
EA:
Version:
Research Question:

Baseline / Previous Version:

Hypothesis:

Change Introduced:

What Was NOT Changed:

Symbol:
Timeframe:
Test Period:
Data Quality:
Initial Deposit:

Net Profit:
Profit Factor:
Expected Payoff:
Maximum Drawdown:
Total Trades:
Win Rate:
Sharpe Ratio:

Result:
PASS / FAIL

Evidence:

Conclusion:

Next Research Question:
```

---

## Validation Principle

A profitable backtest alone does not prove that an EA is robust.

Research should distinguish between:

```text
Idea
↓
Implemented Strategy
↓
Baseline Result
↓
Improved Result
↓
Validated Candidate
```

A strategy should only move forward when sufficient testing evidence supports doing so.

Optimization results should not replace the original baseline.

The baseline must remain available for comparison.

---

## Repository Relationship

Research documentation connects strategy implementation with backtest evidence.

```text
Research/
    │
    ├── Trading hypothesis
    ├── Research questions
    └── Findings
            │
            ▼
EAs/
    │
    └── Strategy implementation
            │
            ▼
Backtest/
    │
    └── Empirical test evidence
            │
            ▼
Research/
    │
    └── Analysis and next hypothesis
```

---

## Current Research Status

```text
EA-040 Strategy Definition       COMPLETE
            ↓
EA Implementation               COMPLETE
            ↓
Baseline Backtest               COMPLETE
            ↓
Baseline Result                 FAIL
            ↓
Research Analysis               OPEN
            ↓
Next Controlled Experiment      PENDING
```

EA-040 should remain in the research stage until subsequent evidence demonstrates that the strategy has acceptable performance and robustness.

---

## Purpose of This Directory

The purpose of `Research/` is not to present strategies as profitable systems.

Its purpose is to maintain a transparent record of:

**Idea → Rules → Code → Test → Evidence → Conclusion → Next Experiment**

Both successful and failed experiments are valuable when they are reproducible and properly documented.
