# EA-103 — EMA20 + RSI — Research

## Research Objective

Determine whether the positive baseline performance of the EMA20 + RSI mean-reversion strategy represents a robust trading edge or is specific to the tested historical sample.

The research must preserve the baseline and evaluate one logical variable group at a time.

---

## Baseline

**Baseline ID:** `EA103-M1-BASELINE-001`

### Baseline Parameters

* EMA Period: 20
* RSI Period: 14
* RSI Oversold: 30
* RSI Overbought: 70
* Minimum EMA Distance: 100 points
* Stop Loss: 300 points
* Take Profit: 600 points
* Break Even Start: 150 points
* Trailing Start: 200 points
* Trailing Distance: 200 points

### Baseline Result

**PASS FOR FURTHER RESEARCH**

---

# Controlled Research Sequence

## RQ01 — EMA Period

Test:

```text
10
15
20
25
30
40
50
```

Objective:

Determine whether the mean-reversion signal depends on a specific EMA lookback.

---

## RQ02 — Minimum EMA Distance

Test:

```text
50
75
100
125
150
200
250
```

Objective:

Determine the minimum price extension from EMA required before a mean-reversion setup becomes meaningful.

---

## RQ03 — RSI Period

Test:

```text
7
10
14
21
28
```

Objective:

Measure sensitivity to RSI calculation length.

---

## RQ04 — RSI Thresholds

Test:

```text
20 / 80
25 / 75
30 / 70
35 / 65
40 / 60
```

Objective:

Determine whether deeper or shallower RSI extremes improve signal quality.

---

## RQ05 — Entry Confirmation

Evaluate:

* RSI condition only
* Close relative to EMA
* Distance from EMA
* Candle direction
* Reversal candle confirmation
* Close returning toward EMA
* Previous candle confirmation

Objective:

Determine whether additional confirmation improves trade quality without eliminating the underlying edge.

---

## RQ06 — BUY vs SELL

Evaluate BUY and SELL independently.

Objective:

Determine whether the strategy has directional asymmetry and whether one side contributes disproportionately to total performance.

---

## RQ07 — Stop Loss / Take Profit

Evaluate controlled SL/TP combinations.

Objective:

Determine whether the baseline 300 / 600 point structure is robust or whether performance depends on a specific exit ratio.

---

## RQ08 — Break Even

Evaluate:

* Break Even OFF
* 100 points
* 150 points
* 200 points
* 250 points

Objective:

Determine whether break-even management improves expectancy or unnecessarily removes profitable trades.

---

## RQ09 — Trailing Stop

Evaluate:

* Trailing OFF
* Start distance
* Trailing distance
* Step behaviour

Objective:

Determine whether trailing contributes to the positive baseline or introduces unnecessary exit sensitivity.

---

## RQ10 — Trading Session

Evaluate performance by trading session / time window.

Objective:

Identify whether the edge is concentrated in particular market periods.

---

## RQ11 — Market Regime

Evaluate performance under different market conditions:

* Strong trend
* Range
* High volatility
* Low volatility
* Rapid directional expansion

Objective:

Determine where the mean-reversion model performs and where it becomes vulnerable.

---

## RQ12 — Out-of-Sample Validation

After the research parameters are frozen:

* Define the final candidate configuration
* Lock parameters
* Test on an independent unseen period
* Do not modify parameters based on OOS results

Objective:

Determine whether the researched edge survives outside the development sample.

---

## RQ13 — Robustness Testing

Evaluate:

* Parameter perturbation
* Spread variation
* Execution sensitivity
* Small parameter changes
* Different historical segments

Objective:

Determine whether performance is stable around the selected parameter region.

---

## RQ14 — Walk-Forward Validation

Evaluate the final research candidate using sequential:

```text
In-Sample → Out-of-Sample → Re-optimization → Out-of-Sample
```

Objective:

Test whether the strategy can maintain performance through changing market conditions.

---

# Research Rules

1. Preserve `EA103-M1-BASELINE-001`.
2. Change one logical variable group at a time.
3. Do not select parameters using Net Profit alone.
4. Evaluate Profit Factor, Expected Payoff, Drawdown, Sharpe, trade count and directional behaviour.
5. Do not perform broad optimization before establishing parameter sensitivity.
6. OOS data must remain independent from parameter selection.
7. A profitable baseline is not automatically a validated strategy.
8. No live trading before OOS, robustness, walk-forward and forward validation.

---

# Current Research Status

| Stage                  | Status                    |
| ---------------------- | ------------------------- |
| Strategy Code          | COMPLETE                  |
| Baseline               | COMPLETE                  |
| Baseline Result        | PASS FOR FURTHER RESEARCH |
| Parameter Evaluation   | NOT STARTED               |
| Entry Confirmation     | NOT STARTED               |
| Exit Evaluation        | NOT STARTED               |
| Session Analysis       | NOT STARTED               |
| Market Regime Analysis | NOT STARTED               |
| OOS                    | NOT STARTED               |
| Robustness             | NOT STARTED               |
| Walk-Forward           | NOT STARTED               |
| Forward Test           | NOT STARTED               |
| Live Trading           | NO                        |

**Overall Status:** `IN PROGRESS`

**Optimization:** `CONTROLLED RESEARCH ONLY`
