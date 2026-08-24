# Research

This directory documents the research process for the Expert Advisors in this repository.

The current research subject is:

**EA-022 — Supertrend Direction**

The purpose of this research is to determine whether a simple Supertrend direction-change strategy on XAUUSD can demonstrate a repeatable trading edge before any optimization or additional strategy complexity is introduced.

---

# EA-022 — Supertrend Direction

## 1. Research Question

The primary research question is:

> Can a simple Supertrend direction-change strategy produce a viable trading edge on XAUUSD?

The initial implementation intentionally keeps the strategy simple.

The EA uses:

```text
Supertrend direction change
        ↓
BUY / SELL
        ↓
Fixed SL / TP
        ↓
Optional Break Even
        ↓
Trailing Stop
```

No additional trend, momentum, volatility, session, or higher-timeframe confirmation filters are included in the baseline strategy.

---

## 2. Strategy Hypothesis

The initial hypothesis is:

> A change in Supertrend direction may identify sufficiently strong short-term trend changes to create profitable entries when combined with predefined risk and exit rules.

The EA therefore attempts to capture:

```text
Bearish → Bullish
        ↓
       BUY
```

and:

```text
Bullish → Bearish
        ↓
       SELL
```

The strategy is based on direction changes rather than continuous trading in the existing trend direction.

---

## 3. Baseline Strategy

The baseline EA is:

```text
EA-022_Supertrend_Direction
```

Source code:

```text
EAs/
└── EA-022_Supertrend_Direction/
    └── EA-022_Supertrend_Direction.mq5
```

The Supertrend calculation uses:

```text
ATR Period = 10
Multiplier = 3.0
```

Entry signals are evaluated using completed candle information.

The EA supports:

* Fixed lot size
* Fixed Stop Loss
* Fixed Take Profit
* Spread filtering
* Maximum-position control
* Break Even
* Trailing Stop

---

## 4. Baseline Backtest

The first documented baseline test was performed using:

| Parameter             | Value                         |
| --------------------- | ----------------------------- |
| EA                    | `EA-022_Supertrend_Direction` |
| Symbol                | `XAUUSD.PRO`                  |
| Timeframe             | `M1`                          |
| Period                | `2026.01.02 – 2026.08.01`     |
| Initial Deposit       | `$1,000`                      |
| Leverage              | `1:500`                       |
| History Quality       | `100% real ticks`             |
| Lot Size              | `0.01`                        |
| Stop Loss             | `300 points`                  |
| Take Profit           | `600 points`                  |
| Maximum Spread        | `50 points`                   |
| Maximum Positions     | `1`                           |
| ATR Period            | `10`                          |
| Supertrend Multiplier | `3.0`                         |
| Break Even            | `Disabled`                    |
| Trailing Stop         | `Enabled`                     |
| Trailing Start        | `200 points`                  |
| Trailing Distance     | `200 points`                  |
| Trailing Step         | `10 points`                   |

The complete Strategy Tester evidence is stored under:

```text
Backtest/
└── EA-022_Supertrend_Direction/
```

---

## 5. Baseline Results

The baseline produced:

| Metric           |         Result |
| ---------------- | -------------: |
| Total Trades     |        `2,429` |
| Winning Trades   |       `46.93%` |
| Losing Trades    |       `53.07%` |
| Total Net Profit |   **-$992.78** |
| Gross Profit     |    `$2,806.41` |
| Gross Loss       | **-$3,799.19** |
| Profit Factor    |       **0.74** |
| Expected Payoff  |     **-$0.41** |
| Sharpe Ratio     |      **-5.00** |
| Recovery Factor  |      **-1.00** |
| Maximum Drawdown |     **99.28%** |

### Direction Breakdown

| Direction |  Trades | Win Rate |
| --------- | ------: | -------: |
| Short     | `1,218` | `48.85%` |
| Long      | `1,211` | `45.00%` |

The baseline result is:

```text
FAIL
```

---

## 6. What the Baseline Establishes

The baseline provides a sufficiently large initial sample to reject this specific configuration as a viable candidate for live deployment.

The important result is not simply:

```text
Net Profit = -$992.78
```

The test also produced:

```text
Profit Factor   = 0.74
Expected Payoff = -$0.41
Sharpe Ratio    = -5.00
Max Drawdown    = 99.28%
LR Correlation  = -0.99
```

Together with the declining balance curve, these results show that the tested configuration did not demonstrate a positive trading edge.

### Baseline conclusion

> The current EA-022 configuration does not produce a viable trading result on XAUUSD.PRO M1 over the tested period.

This conclusion applies specifically to the tested implementation and parameter configuration.

It does **not** establish that Supertrend itself cannot be used as part of a viable strategy.

---

## 7. Observations

### 7.1 Trade Frequency

The EA generated:

```text
2,429 trades
```

over the test period.

The average holding time was:

```text
00:03:32
```

This confirms that the M1 implementation behaves as a high-frequency, short-duration strategy.

---

### 7.2 Win/Loss Structure

The strategy produced:

```text
Win Rate          = 46.93%
Average Win       = $2.46
Average Loss      = -$2.95
```

Therefore the baseline has two simultaneous problems:

```text
Win Rate < 50%
```

and:

```text
Average Win < Average Loss
```

This results in negative expectancy.

---

### 7.3 Long vs Short

Short trades performed better than long trades:

```text
SHORT
Win Rate = 48.85%

LONG
Win Rate = 45.00%
```

This difference is worth investigating separately.

However, neither direction demonstrated sufficient performance in the baseline test to be considered viable on its own based on the available evidence.

---

### 7.4 Drawdown

Maximum drawdown reached:

```text
99.28%
```

This is effectively account destruction for the tested configuration.

Risk reduction alone would reduce the monetary magnitude of the losses but would not by itself establish a trading edge.

The strategy logic therefore needs to be investigated before considering position-sizing optimization.

---

## 8. Current Research Interpretation

The baseline suggests that a raw Supertrend direction change on M1 produces too many signals that do not develop into sufficiently profitable moves under the tested exit configuration.

At this stage, the evidence supports investigating the **quality of entries and exits**, rather than increasing complexity indiscriminately.

The research should therefore remain focused on identifying which component is responsible for the negative expectancy.

---

## 9. Next Research Questions

The next experiments should answer one question at a time.

### RQ-01 — Exit Logic

Question:

> Is the current trailing-stop configuration damaging otherwise profitable trades?

Baseline:

```text
Break Even   = OFF
Trailing Stop = ON
```

First comparison:

```text
Baseline
vs.
Trailing Stop = OFF
```

Everything else should remain unchanged.

---

### RQ-02 — Long vs Short

Question:

> Does either trade direction contain a materially stronger edge?

Test independently:

```text
BUY only
```

and:

```text
SELL only
```

using otherwise identical settings.

---

### RQ-03 — Timeframe

Question:

> Is M1 too noisy for raw Supertrend direction changes?

Potential comparison:

```text
M1
M5
M15
```

The strategy logic and parameters should remain controlled where possible so that the timeframe itself can be evaluated.

---

### RQ-04 — Supertrend Parameters

Question:

> Does changing ATR period or multiplier materially improve signal quality?

Baseline:

```text
ATR Period = 10
Multiplier = 3.0
```

Parameter optimization should only be performed after the basic behavior of the strategy is understood.

The purpose is to identify robust regions, not simply the single best historical parameter combination.

---

### RQ-05 — Market Filters

Only after the simpler experiments above should additional entry filters be considered.

Possible research areas include:

```text
Trend filter
Volatility filter
Trading session filter
Higher-timeframe confirmation
```

These are research candidates only.

They are **not part of the current EA** and have not yet been validated.

---

## 10. Research Order

Research should proceed in this order:

```text
BASELINE
   │
   ├── RQ-01: Trailing ON vs OFF
   │
   ├── RQ-02: BUY vs SELL
   │
   ├── RQ-03: M1 vs M5 vs M15
   │
   ├── RQ-04: Supertrend parameters
   │
   └── RQ-05: Additional filters
```

Only one major variable should be changed per experiment whenever practical.

This makes it possible to identify which change actually affects performance.

---

## 11. Research Rules

### Rule 1 — Preserve the Baseline

The original failed backtest must remain unchanged.

Do not replace the baseline with a better optimization result.

---

### Rule 2 — Keep Evidence

Every meaningful experiment should retain:

```text
EA version
Test settings
Test period
Strategy Tester report
Key metrics
PASS / FAIL result
```

---

### Rule 3 — Change One Variable at a Time

Avoid simultaneously changing:

```text
Supertrend
SL
TP
Trailing
Timeframe
Session
Entry filters
```

because the source of any improvement would become unclear.

---

### Rule 4 — Do Not Optimize for Net Profit Alone

Future experiments should consider at minimum:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Trade Count
Win Rate
Average Win
Average Loss
```

A higher historical net profit alone is not sufficient evidence of a better strategy.

---

### Rule 5 — No Live-Trading Claim Without Validation

A successful backtest is only evidence for further testing.

Before any live-trading conclusion, a candidate strategy should undergo additional validation beyond the baseline development test.

---

## 12. Research Status

Current status:

```text
EA-022_Supertrend_Direction

Implementation       COMPLETE
Baseline Backtest    COMPLETE
Baseline Result      FAIL
Research             IN PROGRESS
Live Ready           NO
```

### Current Evidence

```text
Source Code
    ↓
EAs/EA-022_Supertrend_Direction/

Baseline Evidence
    ↓
Backtest/EA-022_Supertrend_Direction/

Research Conclusions
    ↓
Research/README.md
```

---

## 13. Current Conclusion

The first research cycle has established a clear baseline.

**EA-022_Supertrend_Direction in its current tested configuration fails.**

The failure is supported by:

* `2,429` trades
* `-$992.78` net profit
* `0.74` Profit Factor
* `-0.41` Expected Payoff
* `99.28%` maximum drawdown
* `-5.00` Sharpe Ratio
* strongly declining balance curve

The baseline should therefore be used as the reference point for controlled experiments rather than discarded.

The next research objective is to determine whether the negative expectancy originates primarily from:

1. exit management,
2. trade direction,
3. M1 market noise,
4. Supertrend parameterization,
5. or the underlying entry concept itself.

Until evidence demonstrates otherwise:

```text
RESEARCH STATUS: CONTINUE
LIVE DEPLOYMENT: REJECT
```
