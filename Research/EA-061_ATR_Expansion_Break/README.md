# Research — EA-061 ATR Expansion Break

## Research ID

**EA-061_ATR_Expansion_Break**

## Research Objective

The objective of this research is to evaluate whether an ATR-confirmed price breakout can produce a viable short-term trading strategy for XAUUSD on MetaTrader 5.

The core hypothesis is:

> A breakout from a recent price range may have a higher probability of continuation when the breakout occurs together with an expansion in volatility relative to the market's recent ATR.

The first implementation is intentionally simple and serves as a baseline before any optimization or additional filters are introduced.

---

## Strategy Concept

The strategy combines two components:

1. **Price Breakout**
2. **ATR Volatility Expansion**

A breakout alone can generate false signals when price briefly moves outside a recent range without sufficient momentum.

ATR is therefore used as a volatility confirmation mechanism.

The strategy attempts to enter only when price breaks the recent range while the signal candle demonstrates greater-than-normal price expansion.

---

## Market

| Parameter | Research Scope |
|---|---|
| Instrument | XAUUSD |
| Platform | MetaTrader 5 |
| Strategy Type | Breakout / Volatility Expansion |
| Primary Timeframe | M1 |
| Direction | Long + Short |
| Execution | Automated EA |

---

## Core Hypothesis

Let:

- `H` = highest price of the previous N candles
- `L` = lowest price of the previous N candles
- `ATR` = Average True Range before the signal candle
- `R` = range of the signal candle
- `M` = ATR expansion multiplier

The volatility expansion condition is:

```text
R > ATR × M
```

A BUY setup requires price to break above the previous range.

Conceptually:

```text
Close(signal) > H
AND
Range(signal) > ATR(previous) × M
```

A SELL setup requires price to break below the previous range:

```text
Close(signal) < L
AND
Range(signal) > ATR(previous) × M
```

The baseline implementation uses:

```text
Breakout Lookback = 20
ATR Period        = 14
ATR Multiplier    = 1.5
```

---

## Research Rationale

XAUUSD frequently experiences periods of volatility compression followed by rapid expansion.

The research question is whether combining a structural breakout with an ATR expansion requirement can reduce low-quality breakout signals and capture the beginning of short-duration directional movements.

ATR is not used to predict direction.

It is used to determine whether the breakout candle represents a meaningful volatility expansion relative to recent market conditions.

---

## Baseline Implementation

The initial EA uses the following configuration:

| Parameter | Baseline |
|---|---:|
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| ATR Period | 14 |
| ATR Multiplier | 1.5 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |
| Max Spread | 30 points |

The baseline intentionally avoids introducing additional trend, session or market-regime filters before the core hypothesis is tested.

---

## Baseline Backtest

The baseline implementation was tested using MetaTrader 5 Strategy Tester.

```text
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026-01-02 → 2026-03-31
Initial Deposit: $100
Leverage:        1:500
History Quality: 100% real ticks
```

### Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$92.25 |
| Gross Profit | $504.43 |
| Gross Loss | -$596.68 |
| Profit Factor | 0.85 |
| Expected Payoff | -$0.19 |
| Recovery Factor | -0.83 |
| Sharpe Ratio | -5.00 |
| Total Trades | 494 |
| Winning Trades | 240 (48.58%) |
| Losing Trades | 254 (51.42%) |
| Long Trades | 221 |
| Long Win Rate | 50.68% |
| Short Trades | 273 |
| Short Win Rate | 46.89% |
| Maximum Equity Drawdown | 93.51% |

---

## Baseline Finding

### Result: FAIL

The baseline implementation does not demonstrate positive expectancy.

The most important observations are:

- Profit Factor is below 1.0.
- Expected Payoff is negative.
- Total Net Profit is negative.
- Maximum equity drawdown exceeds 90%.
- Losing trades outnumber winning trades.
- Average losing trade is larger than the average winning trade.
- The balance curve deteriorates substantially during the test period.

Therefore, the current configuration is not suitable for live trading.

---

## Trade Behavior

The baseline generated:

```text
494 trades
240 winners
254 losers
```

The win rate was:

```text
48.58%
```

Average winning trade:

```text
+$2.10
```

Average losing trade:

```text
-$2.35
```

This creates an unfavorable expectancy structure.

The strategy does not necessarily require a win rate above 50% if winning trades are sufficiently larger than losing trades.

However, the baseline currently shows the opposite relationship:

```text
Average Win < Average Loss
```

combined with:

```text
Win Rate < 50%
```

This explains the negative baseline expectancy.

---

## Holding-Time Observation

The Strategy Tester reported:

```text
Minimum Holding Time: 00:00:02
Average Holding Time: 00:04:01
Maximum Holding Time: 02:08:02
```

The strategy therefore behaves primarily as a short-duration trading system under the baseline configuration.

This characteristic should be considered in later research because execution costs, spread, slippage and intraday market conditions can have a significant effect on short-duration strategies.

---

## MFE / MAE Observation

The baseline report produced:

```text
Correlation (Profit, MFE): 0.96
Correlation (Profit, MAE): 0.72
Correlation (MFE, MAE):   0.6087
```

The strong Profit/MFE relationship makes exit behavior an important candidate for later investigation.

However, these correlations alone do not demonstrate that changing the exit rules will make the strategy profitable.

They are retained as research evidence for subsequent testing.

---

## Research Questions

The baseline test raises several questions that should be investigated separately.

### 1. Is M1 too noisy?

The strategy may be generating breakout signals during market noise rather than meaningful volatility expansion.

Future experiments can compare:

```text
M1
M5
M15
```

without changing the underlying strategy hypothesis.

### 2. Is ATR Multiplier 1.5 appropriate?

The current requirement is:

```text
Signal Range > ATR × 1.5
```

Alternative thresholds should be tested systematically rather than selected from the same backtest result.

### 3. Is the 20-bar breakout range appropriate?

The baseline uses:

```text
Breakout Lookback = 20
```

Different lookback lengths may change the structural significance and frequency of breakout signals.

### 4. Does the strategy require a market-regime filter?

ATR expansion confirms volatility but does not identify whether the broader market environment is favorable for continuation.

A later experiment may investigate a trend or regime filter.

This should be treated as a separate hypothesis rather than silently added to the baseline.

### 5. Are trading sessions important?

The entry distribution indicates that signals occur across many hours.

XAUUSD liquidity, spread and volatility characteristics vary during the trading day.

A session-based analysis may determine whether particular periods produce materially different expectancy.

### 6. Are exits limiting the strategy?

The baseline combines:

```text
Fixed SL
Fixed TP
Break Even
Trailing Stop
```

Because these mechanisms interact, later tests should isolate their effects.

---

## Research Sequence

Further work should change one strategy dimension at a time whenever practical.

Recommended sequence:

```text
Baseline
   ↓
Timeframe Test
   ↓
ATR Threshold Test
   ↓
Breakout Lookback Test
   ↓
Session Analysis
   ↓
Exit Analysis
   ↓
Market-Regime Filter
   ↓
Out-of-Sample Test
   ↓
Forward Test
```

This prevents multiple simultaneous changes from obscuring which modification actually affected performance.

---

## Overfitting Control

Optimization must not be treated as proof of strategy validity.

A parameter combination that performs well on the same historical period used to discover it may simply be fitted to historical noise.

Any promising configuration should therefore be validated on data that was not used to select the parameters.

The research process should separate:

```text
Development / In-Sample
        ↓
Candidate Selection
        ↓
Out-of-Sample
        ↓
Forward Test
```

Only configurations that remain acceptable outside the development sample should progress further.

---

## Current Research Status

```text
Strategy concept:        IMPLEMENTED
EA source:               AVAILABLE
Baseline backtest:       COMPLETED
Baseline result:         FAIL
Optimization:            NOT YET VALIDATED
Out-of-sample test:      NOT STARTED
Forward test:            NOT STARTED
Live trading approval:   NO
```

---

## Evidence

EA source:

```text
EAs/EA-061_ATR_Expansion_Break/
└── EA-061_ATR_Expansion_Break.mq5
```

Baseline test evidence:

```text
Backtest/EA-061_ATR_Expansion_Break/
├── README.md
├── Strategy Tester HTML report
└── Strategy Tester charts
```

The original Strategy Tester report and images should remain unchanged as evidence of the baseline result.

---

## Research Conclusion

The first test rejects the current baseline configuration as a viable live-trading configuration.

The result does **not** establish that ATR Expansion Breakout is fundamentally invalid.

It establishes only that:

```text
EA-061 baseline
+
XAUUSD.PRO
+
M1
+
20-bar breakout
+
ATR(14) × 1.5
+
current exit configuration
+
2026-01-02 → 2026-03-31
```

did not produce acceptable performance.

The baseline should therefore remain unchanged as the reference experiment.

Any subsequent improvement should be implemented and tested as a new research iteration rather than replacing the original evidence.
