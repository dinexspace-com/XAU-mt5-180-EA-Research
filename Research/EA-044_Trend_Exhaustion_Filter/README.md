# Research — XAUUSD MT5 EA Research

## Overview

This directory contains the research records for the XAUUSD MT5 Expert Advisor research project.

The purpose of this research is to systematically convert trading ideas into explicit, testable MQL5 strategies and evaluate them using reproducible MetaTrader 5 backtests.

Each EA is treated as an independent research experiment.

A strategy is not considered successful simply because it has been implemented successfully. The trading logic must be tested against historical market data and evaluated using objective performance metrics.

## Research Workflow

The standard research process is:

Trading Idea  
→ Define Explicit Trading Rules  
→ Implement Strategy in MQL5  
→ Compile and Validate EA  
→ Run MT5 Backtest  
→ Record Results  
→ Evaluate PASS / FAIL  
→ Document Findings  
→ Continue, Modify, or Reject the Strategy

The objective is to preserve both successful and unsuccessful experiments.

Failed strategies remain useful research evidence because they show which hypotheses, filters, parameter combinations, or market assumptions did not produce a sufficiently robust trading edge.

## Research Principles

### 1. Explicit Rules

Every strategy must be converted into rules that can be implemented and tested objectively.

Entry and exit decisions should not depend on discretionary interpretation.

### 2. Reproducibility

Every reported result should contain enough information to reproduce the test, including where applicable:

- EA version
- Symbol
- Timeframe
- Test period
- Initial capital
- Lot size
- Strategy parameters
- Stop Loss
- Take Profit
- Spread assumptions
- Backtest modelling quality

### 3. Baseline Before Optimization

The original strategy should be tested before optimization.

The baseline result provides a reference point for determining whether later modifications actually improve the strategy.

### 4. Failed Tests Are Preserved

A failed backtest is not deleted from the research history.

It should remain documented so that future research does not unknowingly repeat the same experiment.

### 5. No Unsupported Performance Claims

An EA should not be described as profitable, robust, production-ready, or suitable for live trading unless sufficient testing supports that conclusion.

Backtest performance alone does not establish future profitability.

## EA Research Index

| EA ID | Strategy | Symbol | Timeframe | Status |
|---|---|---|---|---|
| EA-044 | Trend Exhaustion Filter | XAUUSD.PRO | M1 | Baseline FAIL |

## EA-044 — Trend Exhaustion Filter

### Research Hypothesis

EA-044 investigates whether a large volatility-adjusted price extension away from a long-term EMA can provide a usable directional trading signal on XAUUSD.

The implemented baseline combines:

- EMA 200 as the long-term trend reference
- ATR 14 as the volatility measurement
- ATR multiplier of 2.0 as the minimum distance threshold
- BUY when price is above EMA and sufficiently far above it
- SELL when price is below EMA and sufficiently far below it
- Fixed Stop Loss and Take Profit
- Break Even management
- Trailing Stop management

The baseline hypothesis can be summarized as:

Price direction relative to EMA  
+  
Abnormally large distance from EMA relative to ATR  
→  
Potential continuation opportunity

### Baseline Test

The baseline EA was tested using:

| Parameter | Value |
|---|---|
| EA | EA-044_Trend_Exhaustion_Filter |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Lot Size | 0.01 |
| EMA | 200 |
| ATR | 14 |
| ATR Multiplier | 2.0 |
| Stop Loss | 300 points |
| Take Profit | 600 points |

### Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 8,742 |
| Winning Trades | 43.56% |
| Total Net Profit | -$991.88 |
| Profit Factor | 0.94 |
| Expected Payoff | -$0.11 |
| Maximum Drawdown | 99.25% |
| Sharpe Ratio | -5.00 |

### Research Result

**BASELINE STATUS: FAIL**

The tested baseline does not demonstrate positive expectancy.

The strategy generated a large sample of 8,742 trades, but Profit Factor remained below 1.0 and the final result was a loss of $991.88 from the $1,000 initial deposit.

Maximum drawdown reached 99.25%.

The baseline implementation therefore does not meet the requirements for a viable trading strategy.

### Initial Finding

The baseline experiment indicates that:

**EMA trend direction + ATR distance filter alone is not sufficient to produce a profitable XAUUSD M1 strategy under the tested configuration.**

The strategy produces a high number of trading opportunities but does not demonstrate a positive statistical edge in the baseline test.

This does not establish that every possible variation of the underlying idea will fail.

It establishes only that the currently implemented EA-044 baseline configuration failed the recorded test.

## Research Status Definitions

### IDEA

Trading hypothesis exists but has not yet been implemented.

### IMPLEMENTED

Strategy rules have been converted into an EA but no valid baseline backtest has been recorded.

### BASELINE PASS

The original implementation satisfies the defined baseline acceptance criteria.

### BASELINE FAIL

The original implementation does not satisfy the defined baseline acceptance criteria.

### RESEARCH

The strategy remains under investigation or modification.

### VALIDATION

A promising strategy is undergoing additional robustness testing.

### REJECTED

Available evidence is sufficient to stop further research on the current strategy concept or implementation.

### CANDIDATE

The strategy has passed the required research stages and is considered a candidate for further forward or live validation.

## Current Research Registry

EA-044  
Strategy: Trend Exhaustion Filter  
Market: XAUUSD.PRO  
Timeframe: M1  
Baseline Test: Completed  
Baseline Result: FAIL  
Optimization: Not established  
Forward Test: Not performed  
Live Validation: Not performed  
Current Status: Research

## Repository Relationship

The research records are connected to the rest of the repository as follows:

EAs/
→ Contains the actual MQL5 strategy implementation.

Backtest/
→ Contains Strategy Tester reports, charts, statistics, and backtest evidence.

Research/
→ Records the research hypothesis, interpretation, status, and conclusions.

docs/
→ Defines the common research and testing methodology used across the project.

## Research Rule

Every EA should follow the same evidence chain:

Idea  
→ Rules  
→ Source Code  
→ Backtest  
→ Evidence  
→ Evaluation  
→ Research Conclusion

No EA should receive a positive research status based only on source code, theoretical reasoning, or isolated profitable trades.

The recorded evidence must support the conclusion.

## Current Project Status

Research database initialized.

EA-044 Trend Exhaustion Filter is currently recorded as:

**Baseline tested — FAIL — Research continues.**
