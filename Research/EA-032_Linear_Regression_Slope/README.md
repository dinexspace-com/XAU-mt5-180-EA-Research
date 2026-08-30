# Research — EA-032 Linear Regression Slope

## Research Objective

This research evaluates whether a Linear Regression Slope based trading strategy can produce a robust trading signal for XAUUSD when implemented as a MetaTrader 5 Expert Advisor.

The current research case is:

```text
EA-032_Linear_Regression_Slope
```

The initial objective is not parameter optimization.

The first objective is to establish a reproducible baseline and determine whether the current strategy logic has sufficient statistical and trading merit to justify further development.

---

## Core Hypothesis

The strategy is based on the hypothesis that market direction can be identified using:

```text
Linear Regression Slope
+
Price position relative to regression midpoint
```

The current implementation assumes:

### Bullish condition

```text
Regression slope > 0
AND
Price > regression midpoint
```

### Bearish condition

```text
Regression slope < 0
AND
Price < regression midpoint
```

The hypothesis is that alignment between regression direction and price position may identify short-term directional momentum.

---

## Current Strategy Structure

The EA currently uses:

* Linear regression calculated from closing prices
* Regression period = `20`
* BUY and SELL directional filters
* Fixed Stop Loss
* Fixed Take Profit
* Spread filter
* One position per symbol / Magic Number
* Optional Break Even
* Optional Trailing Stop

Baseline money management:

```text
Lot Size    = 0.01
Stop Loss   = 300 points
Take Profit = 600 points
```

This creates a nominal:

```text
Reward : Risk ≈ 2 : 1
```

before execution costs and market effects.

---

## Baseline Test

The current EA was tested using MetaTrader 5 Strategy Tester under the following configuration:

| Setting           | Value                     |
| ----------------- | ------------------------- |
| Symbol            | `XAUUSD.PRO`              |
| Timeframe         | `M1`                      |
| Period            | `2026.01.02 - 2026.04.01` |
| Initial Deposit   | `$1,000`                  |
| Leverage          | `1:500`                   |
| History Quality   | `100% real ticks`         |
| Lot Size          | `0.01`                    |
| Regression Period | `20`                      |
| Stop Loss         | `300`                     |
| Take Profit       | `600`                     |
| Break Even        | Disabled                  |
| Trailing Stop     | Disabled                  |

---

## Baseline Result

The initial baseline test failed.

Key results:

```text
Total Trades     = 5,039
Net Profit       = -$993.19
Profit Factor    = 0.91
Expected Payoff  = -$0.20
Win Rate         = 31.40%
Loss Rate        = 68.60%
Max Drawdown     = 99.36%
Sharpe Ratio     = -5.00
```

The baseline therefore does not demonstrate a viable trading system.

---

## Initial Findings

### 1. The strategy generates a large number of trades

The EA produced:

```text
5,039 trades
```

during approximately three months of M1 testing.

This indicates that the current signal condition is relatively permissive.

The strategy may therefore be reacting to many small changes in regression direction rather than isolating strong directional moves.

---

### 2. Win rate is low

The baseline win rate was:

```text
31.40%
```

with:

```text
68.60% losing trades
```

Short and Long performance were similar:

```text
Short win rate = 32.17%
Long win rate  = 30.65%
```

This suggests that poor baseline performance was not caused exclusively by one market direction.

---

### 3. Average winner is larger than average loser

The test reported:

```text
Average profit trade = $6.25
Average loss trade   = -$3.15
```

The average winner was therefore approximately:

```text
1.98 ×
```

the average loser.

This is broadly consistent with the configured Stop Loss / Take Profit relationship.

However, the win rate was insufficient to make the system profitable.

---

## Approximate Break-Even Analysis

Ignoring costs, a strategy with approximately:

```text
Reward : Risk = 2 : 1
```

requires a theoretical break-even win rate of approximately:

```text
33.3%
```

The observed win rate was:

```text
31.40%
```

This places the current strategy below the approximate theoretical break-even level even before considering spread, slippage and other trading costs.

This observation is consistent with the reported:

```text
Profit Factor = 0.91
```

---

## 4. Drawdown is unacceptable

Maximum drawdown reached:

```text
99.36%
```

This means the current baseline configuration effectively exhausted the initial account balance.

This is the most important reason why the current version cannot be considered suitable for live trading.

---

## 5. Balance curve shows long-term deterioration

The balance curve experienced several temporary recovery periods.

However, the overall long-term direction was negative and eventually approached total account depletion.

The problem therefore appears structural rather than being caused by only one isolated losing sequence.

---

## 6. Losing streak risk is significant

Maximum consecutive losses:

```text
24 trades
```

Average consecutive losses:

```text
3 trades
```

For a strategy with a relatively high trade frequency, repeated losing sequences create substantial cumulative drawdown.

---

## 7. Trade duration is short

Average holding time:

```text
00:06:02
```

Minimum:

```text
00:00:04
```

Maximum:

```text
04:02:28
```

The current EA therefore behaves primarily as a short-term trading system on M1.

This increases the importance of:

* Spread
* Execution quality
* Market noise
* Signal filtering

---

# Technical Observations

## Regression Midpoint

In the current EA implementation, the variable used as the regression midpoint is calculated from the average closing price of the regression window.

It is therefore not necessarily the exact current value of the fitted regression line.

This should be investigated separately because it directly affects entry filtering.

---

## Sensibility Parameter

The EA contains:

```text
InpSensibility = 2
```

but the parameter is currently not used in the BUY or SELL signal condition.

Therefore changing this parameter currently does not change the strategy signal.

This parameter should not be optimized until it has an explicit function in the strategy.

---

# Research Questions

The next research stage should focus on determining **why the baseline fails**, rather than immediately searching thousands of parameter combinations.

The main research questions are:

### RQ-01 — Is raw regression slope too sensitive?

Current condition:

```text
slope > 0
or
slope < 0
```

Even a very small slope can therefore generate directional confirmation.

Research should determine whether a minimum slope threshold is required.

---

### RQ-02 — Does regression period materially affect signal quality?

Current baseline:

```text
InpRegPeriod = 20
```

Research should determine whether short regression windows create excessive market-noise signals.

---

### RQ-03 — Does the price-midpoint filter improve the strategy?

Current BUY condition requires:

```text
Price > regMid
```

and SELL requires:

```text
Price < regMid
```

This condition should be tested independently to determine whether it improves or reduces signal quality.

---

### RQ-04 — Are entries occurring in low-quality market regimes?

The current strategy does not explicitly distinguish between:

```text
Trending market
vs
Sideways market
```

Linear Regression Slope may behave differently under these regimes.

This is a primary research candidate.

---

### RQ-05 — Is M1 appropriate for this strategy?

The baseline was performed on:

```text
M1
```

The same strategy logic should eventually be compared across selected higher timeframes before drawing conclusions about the underlying concept.

---

# Research Priority

Research should proceed in this order:

```text
1. Verify strategy implementation
        ↓
2. Understand baseline failure
        ↓
3. Improve signal quality
        ↓
4. Re-test
        ↓
5. Only then optimize parameters
```

Avoid large-scale optimization before validating the signal logic.

Otherwise the optimization process may simply overfit parameters to an inherently weak entry condition.

---

# Current Research Status

```text
EA:       EA-032_Linear_Regression_Slope
Stage:    Baseline Research
Status:   FAIL
```

Evidence:

```text
Net Profit    = -$993.19
Profit Factor = 0.91
Drawdown      = 99.36%
```

The EA remains a research candidate.

It should not progress to live trading evaluation based on the current baseline.

---

# Next Research Task

The next task should isolate the entry signal before adding additional complexity.

Recommended first experiment:

```text
Test whether applying a minimum Linear Regression Slope threshold
reduces low-quality entries and improves expectancy.
```

The purpose is not yet to maximize profit.

The purpose is to answer one specific question:

```text
Does filtering weak regression slopes improve the underlying signal?
```

Only one primary variable should be changed in this experiment so the result can be compared clearly against the current baseline.

---

## Related Repository Files

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-032_Linear_Regression_Slope/
│       ├── EA-032_Linear_Regression_Slope.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-032_Linear_Regression_Slope/
│       └── README.md
│
└── Research/
    └── README.md
```

The EA source defines the strategy implementation.

The Backtest folder contains empirical Strategy Tester evidence.

The Research folder records hypotheses, findings and subsequent experiments.

---

## Disclaimer

This repository is intended for quantitative research and educational purposes.

Historical backtests do not guarantee future trading performance.
