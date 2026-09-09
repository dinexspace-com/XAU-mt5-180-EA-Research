# EA-049 — 20-Bar Donchian Breakout Research

## 1. Research Objective

The objective of EA-049 is to investigate whether a simple 20-bar Donchian breakout can provide a robust trading edge on XAUUSD using MetaTrader 5.

The research process is intentionally incremental:

1. Establish a baseline.
2. Identify weaknesses.
3. Test one parameter or hypothesis at a time.
4. Validate promising configurations over larger samples.
5. Perform robustness testing before considering the strategy viable.

The objective is not to optimize the backtest until it looks profitable.

The objective is to determine whether a repeatable edge actually exists.

---

## 2. Strategy Under Test

EA:

```text
EA-049_20-Bar_Donchian
```

Core entry logic:

```text
Upper Donchian = Highest High of previous N bars
Lower Donchian = Lowest Low of previous N bars

BUY  = Close > Upper Donchian
SELL = Close < Lower Donchian
```

Baseline:

```text
N = 20
```

The current bar is excluded from the Donchian calculation.

---

## 3. Relationship to Classical Donchian / Turtle Systems

The strategy belongs to the classical breakout / trend-following family.

The original Turtle System 1 used:

```text
Entry  = 20-period breakout
Exit   = 10-period opposite breakout
Risk   = volatility based
Stop   = volatility based
```

The Turtle framework also used ATR-like volatility measurement ("N") for position sizing and stops.

EA-049 should therefore not be described as an implementation of the complete Turtle Trading System.

EA-049 currently uses the Donchian breakout concept for entry while using fixed SL/TP plus Break Even and Trailing Stop for trade management.

This distinction is important because exit logic and risk management can materially change the behavior of a trend-following system.

---

# 4. Baseline Experiment

## Market

```text
Symbol: XAUUSD.PRO
Timeframe: M5
Period: 2026.01.02 — 2026.04.01
Model: 100% real ticks
Initial Deposit: $1,000
Leverage: 1:500
```

## Parameters

```text
LotSize             = 0.01

DonchianPeriod       = 20
MaxSpread            = 30

StopLoss             = 300
TakeProfit           = 600

UseBreakEven         = true
BreakEvenTrigger     = 150

UseTrailingStop      = true
TrailingStart        = 200
```

---

# 5. Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | +$14.59 |
| Gross Profit | $87.43 |
| Gross Loss | -$72.84 |
| Profit Factor | 1.20 |
| Expected Payoff | $0.41 |
| Recovery Factor | 0.54 |
| Max Balance DD | 2.55% |
| Max Equity DD | 2.64% |
| Total Trades | 36 |
| Winning Trades | 16 |
| Losing Trades | 20 |
| Win Rate | 44.44% |

The baseline is profitable, but the sample is too small to establish robustness.

```text
36 trades
≈ 3 months
1 instrument
1 timeframe
1 parameter configuration
```

Therefore:

```text
Positive backtest ≠ validated edge
```

---

# 6. Most Important Observation

The strongest anomaly in the baseline is the difference between BUY and SELL performance.

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 22 | 68.18% |
| SELL | 14 | 7.14% |

This difference is large enough to justify investigation.

However:

```text
DO NOT conclude that SELL should be disabled yet.
```

There are only:

```text
14 SELL trades
```

which is far too small a sample for a robust conclusion.

---

# 7. Research Question RQ-01

## Does EA-049 have asymmetric LONG/SHORT performance on XAUUSD?

### Hypothesis

```text
H0:
The BUY/SELL difference is primarily sample noise
or market-regime dependent.

H1:
The Donchian breakout implementation has materially
different performance between LONG and SHORT trades
on XAUUSD.
```

### Required Test

Repeat the strategy over substantially longer historical periods and compare:

```text
BUY trades
SELL trades

Win Rate
Profit Factor
Expectancy
Net Profit
Average Winner
Average Loser
Maximum Drawdown
```

No directional filter should be added before this question is tested.

---

# 8. Research Question RQ-02

## Is DonchianPeriod = 20 appropriate for XAUUSD M5?

The value:

```text
20
```

is historically important in Donchian/Turtle systems.

But the classical rule was originally associated with much slower trading horizons.

Therefore:

```text
20 bars on M5 ≠ 20 days
```

On M5:

```text
20 bars ≈ 100 minutes of market data
```

This makes `DonchianPeriod` one of the most important parameters to investigate.

### Candidate experiment

Test a deliberately broad but small parameter grid:

```text
10
20
30
40
55
80
100
```

Do not search hundreds of nearby values at this stage.

The purpose is first to determine whether strategy behavior changes systematically as breakout horizon increases.

---

# 9. Research Question RQ-03

## Is the current exit mechanism suitable for a trend-following strategy?

Current EA:

```text
Fixed Stop Loss
Fixed Take Profit
Break Even
Trailing Stop
```

Baseline:

```text
SL = 300
TP = 600
BE = 150
Trailing = 200
```

Classical Donchian/Turtle trend following uses a structurally different concept:

```text
Entry on longer-period breakout
Exit on shorter-period opposite breakout
```

For example:

```text
20-period entry
10-period exit
```

This creates an important future experiment:

```text
Current fixed SL/TP exit

vs.

Donchian structural exit
```

This should NOT be changed simultaneously with the first Donchian-period experiment.

Otherwise the effect of each modification cannot be isolated.

---

# 10. Research Question RQ-04

## Are fixed point distances appropriate for XAUUSD?

EA-049 currently uses fixed point values:

```text
SL = 300
TP = 600
BE = 150
Trailing = 200
```

Gold volatility changes substantially across market regimes.

A fixed distance therefore represents different amounts of market volatility at different times.

A later research branch should compare:

```text
Fixed-point risk management

vs.

ATR / volatility-normalized risk management
```

Example research variables:

```text
ATR period
SL = k × ATR
Trailing = k × ATR
```

This is conceptually closer to the volatility-normalized risk framework used by the Turtle system.

---

# 11. MFE / MAE Observation

Baseline MT5 report:

```text
Correlation (Profit, MFE) = 0.85
Correlation (Profit, MAE) = 0.79
Correlation (MFE, MAE)    = 0.6611
```

These statistics indicate that MFE/MAE behavior should be retained for later exit research.

The current sample is insufficient to use these correlations alone to redesign SL, TP or trailing parameters.

---

# 12. Holding-Time Observation

Baseline:

```text
Minimum holding time = 00:00:01
Maximum holding time = 00:13:39
Average holding time = 00:02:14
```

This is notable because Donchian breakout is conceptually a trend-following strategy, while the current EA is producing very short-duration trades.

This creates another research question:

> Is the current exit management terminating trades before meaningful trends can develop?

This should be investigated during the exit-logic research stage.

---

# 13. External Research Context

Independent research supports treating Donchian breakout as a trend-following framework rather than assuming that the 20-period entry itself creates an edge.

Classical Turtle-style systems combine:

```text
Breakout entry
+
structural exit
+
volatility-normalized risk
+
position sizing
+
multiple markets / diversification
```

Therefore performance from a single XAUUSD M5 implementation cannot be generalized to the complete Donchian/Turtle methodology.

Published research and independent quantitative testing also show that Donchian strategies can produce highly market- and timeframe-dependent results.

This reinforces the need for out-of-sample and robustness testing rather than selecting parameters based only on the best historical result.

---

# 14. Experimental Rules

To reduce overfitting, EA-049 research will follow these rules.

## Rule 1 — Establish baseline first

Completed.

## Rule 2 — Change one logical component at a time

Example:

```text
Experiment A:
Change DonchianPeriod only.

Experiment B:
Change exit logic only.

Experiment C:
Change volatility/risk logic only.
```

Do not optimize everything simultaneously during hypothesis testing.

## Rule 3 — Do not select parameters from Net Profit alone

Evaluate at minimum:

```text
Trade count
Profit Factor
Expectancy
Drawdown
Long/Short behavior
Stability across periods
```

## Rule 4 — Preserve negative results

Failed experiments are research evidence.

They should not be deleted simply because another configuration performs better.

## Rule 5 — Separate discovery from validation

Data used to discover a parameter should not be the only data used to validate it.

---

# 15. Research Roadmap

Current research sequence:

```text
BASELINE
   ↓
RQ-01 LONG vs SHORT
   ↓
RQ-02 DONCHIAN PERIOD
   ↓
RQ-03 EXIT LOGIC
   ↓
RQ-04 VOLATILITY / ATR
   ↓
LONGER BACKTEST
   ↓
OUT-OF-SAMPLE
   ↓
ROBUSTNESS
```

Only after these stages should more complex filters be considered.

---

# 16. Current Status

```text
EA: EA-049_20-Bar_Donchian

Baseline Backtest: COMPLETE

Baseline result:
Net Profit     +$14.59
Profit Factor   1.20
Max Equity DD   2.64%
Trades          36

Research status:
EDGE NOT YET VALIDATED
```

The baseline provides enough evidence to continue research, but not enough evidence to accept or reject the strategy.

---

# 17. Next Experiment

The next experiment is:

```text
RQ-01
LONG vs SHORT robustness
```

Before optimizing the EA, the baseline should be extended over a significantly longer XAUUSD M5 history.

The objective is to determine whether:

```text
BUY >> SELL
```

persists outside the current three-month sample.

No strategy modification should be made until this test is completed.
