# Research — EA-039 Trend Score

## Research Overview

EA-039 Trend Score is an experimental XAUUSD trading strategy developed to test whether multiple trend and momentum signals can be combined into a single numerical scoring model for automated trade decisions.

The central research idea is simple:

> Instead of allowing one indicator to trigger a trade independently, combine several pieces of directional evidence and only enter when the combined trend score reaches a predefined threshold.

EA-039 combines four components:

- EMA trend direction
- MACD momentum
- ADX directional strength
- Price structure

The resulting score determines whether the EA enters BUY, SELL, or remains inactive.

This experiment is part of the broader `xauusd-mt5-ea-research` project.

---

## Research Question

The primary research question is:

> Can a weighted multi-factor trend score combining EMA, MACD, ADX, and price structure produce a robust trading signal for XAUUSD?

The strategy attempts to reduce dependence on any single indicator by requiring agreement between several independent trend-related conditions.

---

## Research Hypothesis

The initial hypothesis is:

> When multiple trend indicators simultaneously confirm the same market direction, the probability of a successful trend-following trade should increase.

Instead of using binary logic such as:

    EMA bullish → BUY

the strategy uses weighted confirmation:

    EMA
      +
    MACD
      +
    ADX
      +
    Price Structure
      ↓
    Trend Score
      ↓
    Trade only when sufficient confirmation exists

The expectation was that stronger agreement between indicators would filter weak signals and improve trade quality.

---

## Strategy Architecture

The Trend Score consists of four components.

| Component | Maximum Weight |
|---|---:|
| EMA Trend | ±30 |
| MACD Momentum | ±30 |
| ADX Direction | ±40 |
| Price Structure | ±10 |
| **Maximum Total Score** | **±110** |

Positive scores represent bullish evidence.

Negative scores represent bearish evidence.

The default entry threshold is:

    Score Threshold = 70

Therefore:

    Score >= +70 → BUY
    Score <= -70 → SELL
    -69 to +69  → NO TRADE

---

## 1. EMA Trend Component

The first component measures the general trend using two Exponential Moving Averages.

Default parameters:

    Fast EMA = 20
    Slow EMA = 50

Scoring:

    EMA Fast > EMA Slow → +30
    EMA Fast < EMA Slow → -30

Research purpose:

EMA provides the underlying directional bias of the strategy.

The faster EMA reacts more quickly to recent price changes, while the slower EMA represents a broader trend reference.

This component answers:

> What is the current directional trend?

---

## 2. MACD Momentum Component

MACD is used to evaluate momentum and directional confirmation.

Default parameters:

    Fast Period   = 12
    Slow Period   = 26
    Signal Period = 9

Bullish scoring:

    Bullish MACD crossover → +30
    MACD above Signal      → +15

Bearish scoring:

    Bearish MACD crossover → -30
    MACD below Signal      → -15

Research purpose:

EMA identifies trend direction, while MACD attempts to determine whether momentum supports that direction.

A fresh crossover receives a stronger weight than simply remaining above or below the signal line.

This component answers:

> Is momentum supporting the observed trend?

---

## 3. ADX Directional Strength Component

ADX and its directional components are used to determine whether directional movement has sufficient strength.

Default parameters:

    ADX Period    = 14
    ADX Threshold = 25

The directional score becomes active when:

    ADX > 25

Scoring:

    +DI > -DI → +40
    -DI > +DI → -40

ADX receives the largest individual weighting in the Trend Score model.

Research purpose:

The strategy attempts to avoid treating every EMA or MACD movement as a meaningful trend.

ADX acts as a trend-strength filter.

This component answers:

> Is the directional movement strong enough to be considered a trend?

---

## 4. Price Structure Component

The final component adds a simple price-action confirmation.

Bullish condition:

    Close[1] > Close[2]

and:

    Close[1] > midpoint of High[1] and Low[1]

Result:

    +10

Bearish condition:

    Close[1] < Close[2]

and:

    Close[1] < midpoint of High[1] and Low[1]

Result:

    -10

Research purpose:

This component introduces direct price information into a system otherwise dominated by indicators.

It has the smallest weighting and therefore acts as supplementary confirmation rather than the primary signal generator.

---

## Combined Trend Score

The complete conceptual model is:

                         MARKET DATA
                              │
             ┌────────────────┼────────────────┐
             │                │                │
             ▼                ▼                ▼
         EMA Trend       MACD Momentum     ADX Strength
           ±30               ±30              ±40
             │                │                │
             └────────────────┼────────────────┘
                              │
                              ▼
                       Price Structure
                            ±10
                              │
                              ▼
                        TOTAL SCORE
                              │
              ┌───────────────┼───────────────┐
              │               │               │
              ▼               ▼               ▼
          Score ≥ 70      -69 to +69      Score ≤ -70
              │               │               │
              ▼               ▼               ▼
             BUY           NO TRADE          SELL

Maximum theoretical directional score:

    +110 bullish
    -110 bearish

Default threshold:

    ±70

A trade therefore requires multiple components to agree before an entry can occur.

---

## Trade Management

The research implementation also includes basic trade-management controls.

### Position Size

    Fixed Lot = 0.01

### Stop Loss

    Stop Loss = 300 points

### Take Profit

    Take Profit = 600 points

Nominal SL/TP relationship:

    Risk : Reward = 1 : 2

### Break Even

    Enabled = true
    Trigger = 150 points

### Trailing Stop

    Enabled = true
    Start   = 200 points
    Step    = 50 points

### Spread Filter

    Maximum Spread = 30 points

### Position Limit

    Maximum Open Positions = 1

These controls form part of the tested EA implementation and therefore affect the observed strategy performance.

---

## Initial Experimental Configuration

The initial Trend Score experiment was tested using:

| Parameter | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Initial Capital | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| History Quality | 100% real ticks |

Indicator configuration:

| Parameter | Value |
|---|---:|
| EMA Fast | 20 |
| EMA Slow | 50 |
| MACD Fast | 12 |
| MACD Slow | 26 |
| MACD Signal | 9 |
| ADX Period | 14 |
| ADX Threshold | 25 |
| Trend Score Threshold | 70 |

---

## Experimental Result

The first backtest produced:

| Metric | Result |
|---|---:|
| Total Trades | 4,217 |
| Winning Trades | 1,320 |
| Losing Trades | 2,897 |
| Win Rate | 31.30% |
| Loss Rate | 68.70% |
| Total Net Profit | **-$993.61** |
| Profit Factor | **0.89** |
| Expected Payoff | **-$0.24** |
| Sharpe Ratio | **-5.00** |
| Maximum Drawdown | **99.38%** |

Final experimental status:

    FAIL

---

## Research Interpretation

The initial hypothesis was not supported by this implementation and test configuration.

Although the strategy requires multiple trend factors to contribute to the score, the resulting system did not produce a profitable trading edge during the tested period.

The most important observations are:

### Excessive Trade Frequency

The EA generated:

    4,217 trades

during approximately three months of M1 data.

This is a large number of trades for a strategy intended to require multi-factor trend confirmation.

This suggests that reaching the default score threshold of 70 is not sufficiently selective under the tested M1 conditions.

### Low Win Rate

The strategy produced:

    Win Rate  = 31.30%
    Loss Rate = 68.70%

The majority of generated signals therefore resulted in losing trades.

### Negative Expectancy

The backtest produced:

    Expected Payoff = -$0.24

This indicates that the average trade had negative expectancy under the tested configuration.

### Profit Factor Below 1

    Profit Factor = 0.89

Gross losses exceeded gross profits.

Therefore, the strategy did not demonstrate a positive trading edge.

### Extreme Drawdown

    Maximum Drawdown = 99.38%

This represents the most serious failure of the experiment.

The strategy effectively depleted almost the entire initial test capital.

### Strong Negative Balance Trend

The reported linear-regression correlation of the balance curve was:

    LR Correlation = -0.91

This is consistent with the visibly persistent downward trajectory of the backtest balance.

---

## What the Experiment Demonstrates

The failed result does not mean that the Trend Score concept itself has been universally disproven.

It demonstrates something narrower and more useful:

> The current EA-039 implementation, weighting system, threshold, trade management, M1 timeframe, and tested configuration did not produce a viable XAUUSD strategy during this experiment.

The test therefore provides a baseline against which future experiments can be compared.

---

## Identified Research Problems

Based on the first experiment, the following areas require investigation before considering another iteration.

### 1. Signal Selectivity

A threshold of:

    70 / 110

still generated 4,217 trades.

Research should determine whether the scoring model is producing excessive repeated confirmation during noisy M1 conditions.

### 2. Indicator Redundancy

EMA and MACD both derive information from price trends and moving averages.

ADX directional movement also responds to directional price behavior.

Therefore, multiple points in the score may represent correlated information rather than truly independent confirmation.

This should be investigated rather than assuming that a higher combined score automatically represents stronger independent evidence.

### 3. Market Regime

A trend-following strategy can behave differently during:

- trending markets;
- ranging markets;
- high-volatility periods;
- low-volatility periods.

The current implementation does not establish that its scoring system adequately separates these regimes.

### 4. Timeframe

The initial experiment uses:

    M1

The high trade count and short average holding period indicate that the strategy is highly exposed to short-term market noise.

Future research may test whether the underlying hypothesis behaves differently on higher timeframes.

### 5. Score Weighting

Current maximum weights are:

    EMA       = 30
    MACD      = 30
    ADX       = 40
    Structure = 10

These weights should be treated as experimental assumptions rather than proven optimal values.

### 6. Entry Threshold

Current threshold:

    70

The threshold should also be treated as an experimental parameter.

Changing it requires a new backtest and should not retroactively alter the result of this experiment.

### 7. Exit Logic

The relationship between MFE and realized profit indicates that trade-management behavior may deserve further investigation.

Current exits combine:

- fixed Stop Loss;
- fixed Take Profit;
- Break Even;
- Trailing Stop.

Future research should isolate entry quality from exit-management effects rather than changing multiple components simultaneously.

---

## Recommended Research Sequence

Future iterations should follow a controlled experimental process.

    EA-039 baseline
          │
          ▼
    Identify one hypothesis
          │
          ▼
    Change one major variable
          │
          ▼
    Create new EA iteration
          │
          ▼
    Backtest using documented conditions
          │
          ▼
    Compare against baseline
          │
          ├── Improvement not demonstrated → FAIL / retain evidence
          │
          └── Improvement demonstrated → continue validation

Avoid optimizing many parameters simultaneously during the early research stage.

The objective is to understand why performance changes, not merely to discover a profitable-looking historical parameter combination.

---

## Research Status

| Stage | Status |
|---|---|
| Strategy hypothesis defined | COMPLETE |
| Rule-based implementation | COMPLETE |
| MT5 EA implementation | COMPLETE |
| Initial real-tick backtest | COMPLETE |
| Initial profitability validation | **FAIL** |
| Risk validation | **FAIL** |
| Robustness testing | NOT STARTED |
| Out-of-sample validation | NOT STARTED |
| Forward testing | NOT STARTED |
| Live readiness | **NOT APPROVED** |

---

## Research Decision

**EA-039 Trend Score — BASELINE EXPERIMENT FAILED**

The current version should not proceed directly to live trading.

The experiment should be retained because it provides:

- a documented hypothesis;
- reproducible trading rules;
- executable MQL5 implementation;
- real-tick backtest evidence;
- measurable failure conditions;
- a baseline for future research.

A future improved implementation should be treated as a separate experimental iteration rather than replacing the EA-039 result.

---

## Related Repository Files

    xauusd-mt5-ea-research/
    │
    ├── EAs/
    │   └── EA-039_Trend_Score/
    │       ├── EA-039_Trend_Score.mq5
    │       └── README.md
    │
    ├── Backtest/
    │   └── EA-039_Trend_Score/
    │       ├── README.md
    │       └── Strategy Tester evidence
    │
    └── Research/
        └── README.md

The EA directory documents the implementation.

The Backtest directory contains empirical testing evidence.

The Research directory records the hypothesis, experimental interpretation, findings, and future research direction.

---

## Research Principle

A failed backtest is still a valid research result.

EA-039 should not be modified to make its historical result appear successful.

The correct research workflow is:

    Hypothesis
        ↓
    Implementation
        ↓
    Backtest
        ↓
    Evidence
        ↓
    PASS / FAIL
        ↓
    New Hypothesis

For EA-039:

    Hypothesis → Implemented
    EA         → Working
    Backtest   → Completed
    Evidence   → Available
    Result     → FAIL

This result becomes the baseline evidence for the next research iteration.

---

## Disclaimer

This research is intended for quantitative strategy development and experimentation.

Backtest performance does not guarantee future results.

EA-039 Trend Score has not demonstrated sufficient performance or risk characteristics for live trading under the documented test configuration.

Nothing in this research should be interpreted as financial advice.
