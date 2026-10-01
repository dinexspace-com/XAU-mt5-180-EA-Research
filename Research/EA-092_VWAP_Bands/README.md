# EA-092_VWAP_Bands — Research

## 1. Research Objective

The purpose of this research is to determine whether the VWAP-band mean-reversion concept used by `EA-092_VWAP_Bands` can produce positive expectancy on XAUUSD M1 under controlled testing conditions.

The initial baseline provides a reference point for all subsequent experiments.

---

## 2. Strategy Hypothesis

The strategy is based on the following hypothesis:

> When price moves sufficiently far from daily VWAP and then begins to return inside the VWAP deviation band, the movement may continue toward VWAP.

The EA represents this concept through:

```text
Daily VWAP
+
Population weighted standard deviation
+
Configurable band multiplier
```

The baseline multiplier is:

```text
2.0 × VWAP standard deviation
```

---

## 3. Baseline Evidence

The baseline test produced:

```text
Net Profit:       -172.04 USD
Profit Factor:    0.85
Expected Payoff:  -0.19 USD
Max Equity DD:    22.67%
Trades:           927
Win Rate:         51.13%
```

## The report confirms that the strategy generated slightly more winning trades than losing trades, but the resulting expectancy remained negative.

## 4. Important Observation

The baseline demonstrates an important distinction:

```text
Win Rate ≠ Positive Expectancy
```

The tested configuration achieved:

```text
Profit Trades: 51.13%
Loss Trades:   48.87%
```

but:

```text
Average Profit: +2.14 USD
Average Loss:   -2.61 USD
Profit Factor:   0.85
```

Therefore, the research should focus on the complete payoff distribution rather than optimizing win rate alone.

---

## 5. Primary Research Questions

### RQ-01 — VWAP Band Width

Does changing:

```text
InpVWAPBandMultiplier
```

materially change expectancy?

Candidate controlled tests may examine different deviation thresholds while keeping all other parameters unchanged.

---

### RQ-02 — VWAP Exit

The EA currently closes a position when price reaches VWAP.

Research question:

```text
Does VWAP exit improve or reduce expectancy?
```

The exit should be isolated from entry changes.

---

### RQ-03 — Fixed TP/SL

The baseline uses:

```text
SL = 300 points
TP = 600 points
```

Research question:

```text
Is the 1:2 configured TP/SL relationship appropriate for this entry model?
```

This should be tested independently from VWAP-band changes.

---

### RQ-04 — Break-even

Baseline:

```text
Break-even = ON
Trigger = 150 points
Offset = 0
```

Research question:

```text
Does break-even improve the distribution of trade outcomes?
```

---

### RQ-05 — Trailing Stop

Baseline:

```text
Trailing = ON
Start = 200
Distance = 100
Step = 10
```

Research question:

```text
Does trailing improve the final payoff distribution or prematurely reduce winning trades?
```

---

### RQ-06 — Entry Frequency

The baseline generated:

```text
927 trades
```

Research question:

```text
Is the current signal sufficiently selective?
```

The goal should not be to maximize the number of trades.

The objective is to determine whether fewer, better-defined signals improve expectancy.

---

## 6. Controlled Experiment Rules

For each experiment:

1. Keep the symbol unchanged.
2. Keep the timeframe unchanged.
3. Keep the test period unchanged.
4. Keep the history quality unchanged.
5. Change only the intended variable/rule.
6. Record the complete input configuration.
7. Record Net Profit.
8. Record Profit Factor.
9. Record Expected Payoff.
10. Record Maximum Equity Drawdown.
11. Record Total Trades.
12. Record Win Rate.
13. Record Average Profit.
14. Record Average Loss.
15. Record holding-time statistics when relevant.

---

## 7. Research Discipline

Do not change multiple major strategy components simultaneously.

For example, avoid changing all of the following in one experiment:

```text
Band Multiplier
+
Stop Loss
+
Take Profit
+
Break-even
+
Trailing Stop
```

If the result changes, the cause cannot be isolated.

Instead:

```text
Baseline
   ↓
One controlled change
   ↓
Backtest
   ↓
Compare
   ↓
Keep / Reject
   ↓
Next experiment
```

---

## 8. Baseline Reference

Baseline:

```text
EA: EA-092_VWAP_Bands
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026.01.02 - 2026.03.31
History: 100% real ticks

Lot: 0.01
SL: 300
TP: 600
VWAP Minimum Bars: 20
VWAP Band Multiplier: 2.0
Break-even: ON
Trailing Stop: ON
```

---

## 9. Current Research Status

```text
Baseline completed
Baseline expectancy: negative
Further controlled experiments: required
```

The current evidence is sufficient to establish a negative baseline, but not sufficient to determine which individual rule is responsible for the result.

Future research should therefore remain isolated, reproducible, and parameter-controlled.
