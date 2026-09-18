# Research

This directory documents the research basis, hypotheses, and validation process used to develop and evaluate Expert Advisors in this repository.

The current research focuses on systematic trading strategies for XAUUSD using MetaTrader 5.

---

# EA-067 — Breakout + EMA Filter

## Research Objective

EA-067 investigates whether a simple price breakout strategy can be improved by applying a trend-direction filter based on an Exponential Moving Average (EMA).

The strategy combines two concepts:

1. Price breakout
2. Trend filtering

The objective is not to assume that the combination is profitable, but to implement the hypothesis as explicit trading rules and evaluate it using historical market data.

---

## Strategy Hypothesis

The underlying hypothesis is:

> A breakout in the direction of the prevailing trend may have a higher probability of continuation than a breakout taken without directional filtering.

The strategy therefore separates:

```text
Breakout detection
        +
Trend confirmation
        ↓
Trading signal
```

The breakout component identifies price movement beyond a recent price range.

The EMA component acts as a directional filter rather than as the primary entry signal.

---

## Breakout Concept

A breakout strategy attempts to detect when price moves beyond a previously established trading range.

For EA-067, the implemented research configuration currently uses:

```text
Breakout Lookback = 20
Breakout Buffer   = 0
```

Conceptually:

```text
Recent price range
        ↓
Highest High / Lowest Low
        ↓
Price breaks range
        ↓
Potential breakout
```

A breakout alone does not guarantee continuation.

Price can return inside the previous range after crossing the breakout level, creating a false breakout.

This is one of the main risks that the strategy must control.

---

## EMA Trend Filter

EA-067 adds an Exponential Moving Average as a directional filter.

Current research configuration:

```text
EMA Period = 50
```

Conceptually:

```text
Price above EMA
      ↓
Prefer bullish breakout

Price below EMA
      ↓
Prefer bearish breakout
```

The EMA is therefore used to reduce breakout signals that occur against the prevailing price direction.

The EMA does not by itself establish that a trade will be profitable.

Its usefulness must be determined empirically through testing.

---

## Combined Strategy

The research model can be represented as:

```text
Market Data
    ↓
Recent Price Range
    ↓
Breakout Detection
    ↓
EMA Trend Filter
    ↓
BUY / SELL Candidate
    ↓
Execution Filters
    ↓
Position
    ↓
Risk Management
```

The purpose of the combined model is to test whether directional filtering improves the behavior of a basic breakout system.

---

## Risk Management

The current EA implementation includes explicit position-management mechanisms.

Research parameters currently include:

```text
Stop Loss       = 300
Take Profit     = 600

Break Even      = enabled
BE Trigger      = 150
BE Offset       = 0

Trailing Stop   = enabled
Trailing Start  = 200
Trailing Dist.  = 100
Trailing Step   = 10
```

These mechanisms should be evaluated separately from the entry logic.

A strategy may fail because of:

- weak entry signals,
- unsuitable Stop Loss,
- unsuitable Take Profit,
- premature break-even,
- overly aggressive trailing,
- spread/execution effects,
- or interaction between several parameters.

Therefore changes to entry logic and changes to exit logic should not automatically be treated as the same research experiment.

---

## Instrument

Primary research instrument:

```text
XAUUSD
```

Broker implementations may use different symbol names.

The current test evidence uses:

```text
XAUUSD.PRO
```

Results from one broker environment should not automatically be assumed to reproduce under another broker's:

- spread,
- tick history,
- execution,
- contract specification,
- commission,
- or liquidity conditions.

---

## Timeframe

Current EA-067 research is being conducted on:

```text
M1
```

M1 makes the strategy particularly sensitive to:

- tick sequence,
- spread,
- execution assumptions,
- short-term volatility,
- and trade-management behavior.

For this reason, detailed tick-based testing is important before drawing conclusions about the strategy.

---

## Research Method

The research process for an EA should follow:

```text
Trading hypothesis
        ↓
Explicit trading rules
        ↓
MQL5 implementation
        ↓
Baseline backtest
        ↓
Identify weaknesses
        ↓
Parameter research
        ↓
Optimization
        ↓
Out-of-sample / forward validation
        ↓
Robustness testing
        ↓
Final assessment
```

Optimization results alone are not considered proof that a strategy is robust.

---

## Baseline Testing

The baseline test should establish the behavior of the strategy before optimization.

At minimum record:

```text
Symbol
Timeframe
Date range
Tick mode
Initial deposit
Leverage
Lot size
Spread assumptions
EA parameters
Net Profit
Profit Factor
Maximum Drawdown
Total Trades
Win Rate
```

The original Strategy Tester report should be preserved as evidence.

---

## Tick Data

For final validation, preference should be given to:

```text
Every tick based on real ticks
```

when appropriate broker tick history is available.

Lower-detail tester modes may be useful for faster exploratory work, but results should be re-tested using higher-fidelity tick data before being treated as strong evidence.

---

## Optimization

Optimization is used to explore parameter behavior, not simply to locate the single historical combination with the highest profit.

Parameters that may be investigated include:

```text
Breakout Lookback
Breakout Buffer
EMA Period

Stop Loss
Take Profit

Break Even Trigger
Break Even Offset

Trailing Start
Trailing Distance
Trailing Step
```

The objective is to identify parameter regions that remain reasonably stable rather than isolated historical peaks.

---

## Overfitting Control

A parameter set should not be accepted simply because it performs well on the same historical period used for optimization.

Research should distinguish between:

```text
In-Sample
    ↓
Parameter discovery

Out-of-Sample
    ↓
Independent validation

Forward / Demo
    ↓
Execution validation
```

A large difference between in-sample and out-of-sample performance is evidence that the configuration requires further investigation.

---

## Robustness Tests

Candidate configurations should eventually be tested across changes in:

### Time

Different months and market regimes.

### Parameters

Small changes around the selected parameter values.

### Trading Costs

Higher spreads and realistic execution conditions.

### Market Data

Different historical periods and, where possible, broker data.

### Execution

Execution delay and other realistic trading conditions where relevant.

A robust strategy should not depend entirely on one exact historical configuration.

---

## Current Research Finding

The current baseline evidence does **not** establish EA-067 as a profitable strategy.

The purpose of the existing baseline is therefore diagnostic:

```text
Baseline
   ↓
Identify failure modes
   ↓
Research parameters / logic
   ↓
Retest
```

A failed baseline is still useful research evidence and should not be deleted or replaced by only successful optimization results.

---

## Evidence Separation

Research reasoning is stored here:

```text
Research/
```

EA implementation is stored in:

```text
EAs/
```

Actual Strategy Tester evidence is stored in:

```text
Backtest/
```

This separation allows the repository to distinguish:

```text
Hypothesis ≠ Implementation ≠ Test Result
```

---

## Research Status

```text
EA: EA-067_Breakout_EMA_Filter
Instrument: XAUUSD
Platform: MetaTrader 5
Language: MQL5
Stage: Research / Validation
Status: IN PROGRESS
```

No strategy should be marked as validated solely because an optimized historical configuration has been found.
