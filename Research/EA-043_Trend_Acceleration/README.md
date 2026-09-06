# EA-043 — Trend Acceleration Research

## Research Objective

EA-043_Trend_Acceleration investigates whether acceleration in an existing trend can be used as a systematic entry signal for XAUUSD.

The core hypothesis is that when a fast EMA is already positioned in the direction of the trend and the distance between the fast and slow EMA continues to expand, price may have sufficient momentum to continue moving in that direction.

The initial implementation uses:

- Fast EMA: 20
- Slow EMA: 50
- EMA direction
- EMA separation
- Expansion of the EMA gap
- Spread filtering
- Fixed Stop Loss
- Fixed Take Profit

The first implementation is intentionally simple so that the underlying signal can be evaluated before adding additional filters or optimization.

---

## Core Hypothesis

The strategy is based on the following idea:

> A trend that is accelerating may have a higher probability of short-term continuation than a trend that is flat or losing momentum.

Instead of using only a conventional EMA crossover, EA-043 attempts to identify situations where the relationship between the two EMAs is becoming stronger.

### Bullish Acceleration

The basic BUY condition requires:

```text
Fast EMA > Slow EMA
Fast EMA is rising
EMA gap is expanding
```

### Bearish Acceleration

The basic SELL condition requires:

```text
Fast EMA < Slow EMA
Fast EMA is falling
EMA gap is expanding
```

The intention is to enter after trend direction has already been established but while momentum is still increasing.

---

## Baseline Implementation

The baseline EA was implemented for MetaTrader 5 and tested on XAUUSD.

Source code:

```text
EAs/
└── EA-043_Trend_Acceleration/
    └── EA-043_Trend_Acceleration.mq5
```

The initial strategy uses a deliberately small number of variables.

### Baseline Signal Parameters

| Parameter | Value |
|---|---:|
| Fast EMA | 20 |
| Slow EMA | 50 |
| Maximum Spread | 35 points |

### Baseline Trading Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Disabled |
| Trailing Stop | Disabled |

No additional market-regime, volatility, session, higher-timeframe, or momentum filters were applied in the baseline test.

---

## Baseline Backtest

The initial backtest was performed using:

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Data Quality | 100% real ticks |

Full backtest evidence is stored under:

```text
Backtest/
└── EA-043_Trend_Acceleration/
```

---

## Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 4,961 |
| Net Profit | -$991.99 |
| Profit Factor | 0.91 |
| Expected Payoff | -$0.20 |
| Sharpe Ratio | -5.00 |
| Winning Trades | 31.63% |
| Losing Trades | 68.37% |
| Average Winning Trade | $6.26 |
| Average Losing Trade | -$3.19 |
| Maximum Balance Drawdown | 99.25% |
| Maximum Equity Drawdown | 99.26% |

### Baseline Status

**FAIL**

The original hypothesis, in its current implementation, does not produce a profitable standalone strategy under the tested conditions.

The baseline must therefore remain unchanged as the reference point against which future modifications are compared.

---

## Initial Findings

### 1. Reward-to-Risk Is Not the Primary Problem

The average profitable trade was:

```text
+$6.26
```

while the average losing trade was:

```text
-$3.19
```

The average winning trade is therefore substantially larger than the average losing trade.

However, only 31.63% of trades were profitable.

This indicates that the baseline strategy's primary weakness is not simply the size of winners relative to losers.

The entry logic generates too many unsuccessful trades.

---

## 2. Signal Frequency Is Very High

The baseline generated:

```text
4,961 trades
```

during approximately three months of M1 data.

This indicates that the basic EMA acceleration condition occurs frequently.

A large number of signals does not translate into positive expectancy.

This suggests that EMA acceleration alone is insufficient to distinguish high-quality trend continuation from noise or temporary price movement.

---

## 3. BUY and SELL Performance Are Similar

The backtest produced:

```text
Short trades: 2,534
Short win rate: 31.69%

Long trades: 2,427
Long win rate: 31.56%
```

Both directions produced very similar win rates.

This suggests that the baseline weakness is not obviously isolated to only BUY or only SELL signals.

The common entry logic is therefore the primary research target.

---

## 4. Drawdown Is Unacceptable

Maximum drawdown reached approximately:

```text
99%
```

The balance curve declined persistently during the test.

The baseline version is therefore unsuitable for live trading.

Risk-management adjustments alone should not be used to hide this problem.

The underlying signal quality must first improve.

---

## 5. MFE Shows Potential Information

The backtest reported:

```text
Correlation (Profit, MFE): 0.84
Correlation (Profit, MAE): 0.71
Correlation (MFE, MAE): 0.4928
```

The strong relationship between profitable outcomes and Maximum Favorable Excursion suggests that further analysis of post-entry price movement may be useful.

This does not prove that the strategy has an exploitable edge.

It identifies an area for further investigation.

---

## Research Direction

The next research phase should focus on one question:

> Can low-quality EMA acceleration signals be filtered out while preserving the stronger trend-continuation signals?

The baseline should not immediately be replaced by a complex strategy.

Changes should be tested individually so that the effect of each modification can be measured.

---

## Research Priorities

### R1 — Trend Strength Filter

Investigate whether EMA acceleration performs differently when the underlying trend is sufficiently strong.

Goal:

```text
Reduce entries during weak or sideways markets.
```

---

### R2 — Minimum EMA Separation / Acceleration Threshold

The baseline detects whether the EMA gap is expanding but does not require the expansion to be large enough to represent meaningful acceleration.

Research whether a minimum threshold improves signal quality.

Goal:

```text
Ignore very small EMA-gap changes that may represent market noise.
```

---

### R3 — Volatility Filter

Investigate whether the strategy behaves differently under different XAUUSD volatility regimes.

Goal:

```text
Avoid conditions where price movement is too weak or excessively unstable for the baseline signal.
```

---

### R4 — Higher-Timeframe Trend Confirmation

Investigate whether M1 entries improve when aligned with a higher-timeframe trend.

Goal:

```text
Avoid taking short-term acceleration signals against the broader market direction.
```

---

### R5 — Trading Session Analysis

The baseline contains thousands of trades distributed across different trading hours.

Research whether performance differs materially between:

```text
Asia
Europe / London
US / New York
```

Goal:

```text
Determine whether specific trading periods contain better or worse expectancy.
```

---

## Experimental Method

Each modification should be evaluated independently whenever possible.

The research cycle should follow:

```text
Baseline
   ↓
Add ONE modification
   ↓
Backtest
   ↓
Compare against baseline
   ↓
PASS / FAIL
   ↓
Keep or reject modification
```

Avoid combining multiple new filters before their individual effects are understood.

---

## Primary Comparison Metrics

Each experiment should record at minimum:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Total Trades
Win Rate
Average Win
Average Loss
Sharpe Ratio
```

Trade-count reduction alone is not considered an improvement.

A modification must improve the quality of the resulting trading system.

---

## Research Rules

### Rule 1 — Preserve the Baseline

The original EA and original backtest must remain available.

Do not overwrite baseline evidence.

---

### Rule 2 — One Main Variable at a Time

Where practical, test one hypothesis or filter independently before combining it with other modifications.

---

### Rule 3 — Do Not Optimize for Net Profit Alone

A higher Net Profit does not automatically mean a better strategy.

Drawdown, Profit Factor, trade count, expectancy, and robustness must also be considered.

---

### Rule 4 — Failed Experiments Are Preserved

A failed strategy variation is still research evidence.

Failed experiments should not be deleted simply because the result is negative.

---

### Rule 5 — No Live-Trading Claim From Baseline Backtest

A profitable backtest alone is not sufficient evidence that an EA is production-ready.

Further validation is required before considering live deployment.

---

## Current Research Status

```text
EA-043 Trend Acceleration
│
├── Strategy implementation       DONE
├── Baseline EA                   DONE
├── Baseline real-tick backtest   DONE
├── Baseline evaluation           FAIL
│
└── Signal-quality research       NEXT
```

The current baseline demonstrates that simple EMA trend acceleration alone does not provide sufficient performance under the tested M1 XAUUSD conditions.

The next phase is therefore focused on improving signal quality while maintaining the original strategy concept.

---

## Repository References

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-043_Trend_Acceleration/
│       ├── EA-043_Trend_Acceleration.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-043_Trend_Acceleration/
│       ├── README.md
│       └── Strategy Tester evidence
│
└── Research/
    └── README.md
```

---

## Research Status

**Current conclusion:** Baseline rejected.

**Research question:** Can signal filtering convert the underlying trend-acceleration concept into a strategy with positive expectancy and acceptable drawdown?

**Next stage:** Test improvements to entry quality individually against the preserved EA-043 baseline.
