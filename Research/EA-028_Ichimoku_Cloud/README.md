# Research

## Purpose

This directory documents the research process for the XAUUSD MT5 EA project.

The purpose is to separate:

* Observed backtest results
* Research hypotheses
* Experiments
* Conclusions supported by evidence

A poor backtest result is not automatically a reason to modify an EA.

The first objective is to understand **why the strategy behaves as observed**, then test specific hypotheses one at a time.

---

# EA-028 — Ichimoku Cloud

## 1. Research Objective

EA-028 investigates whether a simple Ichimoku trend-following strategy can produce a robust trading edge on XAUUSD.

The baseline strategy combines:

```text id="plxv2p"
Price relative to Ichimoku Cloud
+
Tenkan-sen relative to Kijun-sen
```

BUY condition:

```text id="3kbfqu"
Price > Cloud Top
AND
Tenkan-sen > Kijun-sen
```

SELL condition:

```text id="wvgvri"
Price < Cloud Bottom
AND
Tenkan-sen < Kijun-sen
```

The current implementation does not require a fresh Tenkan/Kijun crossover.

It evaluates the relative position of the two lines.

---

# 2. Baseline Configuration

The first documented baseline test used:

| Setting         | Value                     |
| --------------- | ------------------------- |
| Symbol          | `XAUUSD.PRO`              |
| Timeframe       | `M1`                      |
| Period          | `2026.01.02 – 2026.03.01` |
| Initial Deposit | `$1,000`                  |
| Leverage        | `1:100`                   |
| Data Quality    | `100% real ticks`         |
| Lot Size        | `0.01`                    |
| Stop Loss       | `300 points`              |
| Take Profit     | `600 points`              |
| Maximum Spread  | `60 points`               |
| Tenkan          | `9`                       |
| Kijun           | `26`                      |
| Senkou Span B   | `52`                      |
| Break Even      | Enabled                   |
| Trailing Stop   | Enabled                   |

The baseline is intentionally retained without optimization so later experiments can be compared against the same reference point.

---

# 3. Baseline Results

## Performance

| Metric               |       Result |
| -------------------- | -----------: |
| Total Net Profit     | **-$953.45** |
| Profit Factor        |     **0.92** |
| Expected Payoff      |   **-$0.15** |
| Recovery Factor      |    **-0.94** |
| Sharpe Ratio         |    **-5.00** |
| Max Balance Drawdown |   **95.62%** |
| Max Equity Drawdown  |   **95.63%** |
| LR Correlation       |    **-0.92** |

## Trades

| Metric                     | Result |
| -------------------------- | -----: |
| Total Trades               |  6,457 |
| Winning Trades             |  2,517 |
| Losing Trades              |  3,940 |
| Win Rate                   | 38.98% |
| Long Win Rate              | 39.84% |
| Short Win Rate             | 37.97% |
| Average Winner             |  $4.42 |
| Average Loser              | -$3.07 |
| Maximum Consecutive Losses |     14 |

## Holding Time

```text id="zv67cu"
Minimum: 00:00:01
Average: 00:03:13
Maximum: 03:37:01
```

---

# 4. Baseline Finding

## Result

**❌ BASELINE FAIL**

The baseline configuration does not demonstrate a profitable or practically acceptable trading edge.

Three observations are immediately supported by the test:

### Negative expectancy

```text id="i1qbyu"
Profit Factor   = 0.92
Expected Payoff = -$0.15
Net Profit      = -$953.45
```

Gross losses exceeded gross profits.

---

### Excessive drawdown

```text id="9xx5ss"
Balance DD = 95.62%
Equity DD  = 95.63%
```

The tested configuration nearly depleted the initial account.

---

### Losing trades occur too frequently

```text id="1gnj7u"
Winning Trades = 38.98%
Losing Trades  = 61.02%
```

The average winning trade was larger than the average losing trade:

```text id="6mppdi"
Average Win  = +$4.42
Average Loss = -$3.07
```

but this was not enough to overcome the frequency of losing trades.

---

# 5. Primary Research Problem

The main research question is:

> **Why does the current Ichimoku implementation generate too many losing trades on XAUUSD M1?**

The purpose of the next experiments is not to search randomly for profitable parameters.

The purpose is to identify which part of the system is responsible for the negative expectancy.

---

# 6. Research Hypotheses

The following are **hypotheses**, not conclusions.

They must be tested before being accepted.

---

## H1 — M1 may contain too much noise

The baseline was tested on:

```text id="14zkqo"
XAUUSD.PRO — M1
```

The EA generated:

```text id="drk3p4"
6,457 trades
```

in approximately two months.

Average holding time was only:

```text id="fnqv6a"
3 minutes 13 seconds
```

### Test

Run the same strategy and same core parameters on:

```text id="ufh40y"
M1
M5
M15
H1
```

### Goal

Determine whether strategy expectancy changes materially with timeframe.

---

## H2 — Persistent conditions may cause repeated entries

The current strategy checks:

```text id="7smf25"
Tenkan > Kijun
```

or:

```text id="aj0q22"
Tenkan < Kijun
```

rather than requiring a new crossover event.

Therefore, a directional Ichimoku state can remain valid across multiple bars.

### Test

Compare:

**Version A — Current**

```text id="1e06xe"
Tenkan > Kijun
or
Tenkan < Kijun
```

against:

**Version B — Actual crossover**

```text id="8nd61w"
Previous Tenkan <= Previous Kijun
AND
Current Tenkan > Current Kijun
```

for BUY, with inverse logic for SELL.

### Goal

Determine whether requiring a fresh crossover reduces low-quality or repetitive entries.

---

## H3 — Market regime may affect performance

Ichimoku is being used here as a trend-following signal.

The baseline result alone does not establish whether losses occur primarily during:

* Trending markets
* Sideways markets
* Low-volatility periods
* High-volatility periods

### Test

Segment trades by market condition.

### Goal

Determine whether EA-028 has positive expectancy only under specific market regimes.

---

## H4 — Trade management may alter the original edge

The baseline uses all of the following simultaneously:

```text id="4n7n1g"
SL
TP
Break Even
Trailing Stop
```

Therefore, the baseline alone does not tell us how each exit component affects performance.

### Test

Compare controlled variants:

```text id="3e7rhe"
A — SL + TP only

B — SL + TP + Break Even

C — SL + TP + Trailing

D — SL + TP + Break Even + Trailing
```

### Goal

Measure the contribution of Break Even and Trailing Stop independently.

---

## H5 — Fixed SL/TP may not match XAUUSD volatility

Baseline:

```text id="16y4pd"
SL = 300 points
TP = 600 points
```

These distances are fixed.

XAUUSD volatility is not constant.

### Test

Compare the baseline fixed-distance model against volatility-adjusted exits in a separate experiment.

Possible research candidate:

```text id="wbl4yi"
ATR-based SL/TP
```

### Goal

Determine whether volatility-adjusted exits produce more stable behavior than fixed point distances.

---

## H6 — Trading session may influence expectancy

The EA can trade throughout the available trading day.

The Strategy Tester report shows trades occurring across many different hours.

### Test

Segment results by trading session:

```text id="9gzszx"
Asia
Europe / London
US / New York
```

Do not add a session filter until the segmented results provide evidence that one is justified.

### Goal

Determine whether specific trading hours contribute disproportionately to profit or loss.

---

# 7. Experiment Order

Experiments should be performed one variable at a time.

Recommended order:

```text id="77a4fw"
Baseline
   ↓
Timeframe Test
   ↓
Entry Logic Test
   ↓
Market Regime Analysis
   ↓
Exit Management Test
   ↓
Session Analysis
   ↓
SL/TP / Volatility Test
```

Do not optimize all parameters simultaneously at this stage.

Changing multiple variables together would make it difficult to determine what actually caused an improvement or deterioration.

---

# 8. Experiment Record

Each experiment should record:

| Field           | Requirement |
| --------------- | ----------- |
| Experiment ID   | Required    |
| Hypothesis      | Required    |
| EA Version      | Required    |
| Symbol          | Required    |
| Timeframe       | Required    |
| Test Period     | Required    |
| Parameters      | Required    |
| Data Quality    | Required    |
| Net Profit      | Required    |
| Profit Factor   | Required    |
| Max Drawdown    | Required    |
| Expected Payoff | Required    |
| Total Trades    | Required    |
| Result          | PASS / FAIL |
| Evidence        | Required    |
| Conclusion      | Required    |

Example naming:

```text id="x81ydt"
EXP-028-001_Timeframe
EXP-028-002_Crossover
EXP-028-003_Regime
EXP-028-004_ExitManagement
EXP-028-005_Session
EXP-028-006_VolatilityExit
```

---

# 9. Research Rules

## Rule 1 — Preserve the baseline

Never overwrite the original baseline result.

The baseline is the reference against which later experiments are compared.

---

## Rule 2 — One hypothesis at a time

Avoid:

```text id="hlupf6"
Change timeframe
+ change Ichimoku parameters
+ change SL
+ add ATR
+ add session filter
```

in one experiment.

If the result improves, it would be unclear which change caused the improvement.

---

## Rule 3 — Do not optimize before understanding

A Strategy Tester optimization can find parameter combinations that perform better historically.

That does not automatically mean the underlying strategy is robust.

Research should first determine whether the strategy has a repeatable behavioral edge.

---

## Rule 4 — Keep failed experiments

Failed experiments are research evidence.

Do not delete them.

They help prevent repeating previously tested ideas and make the research process reproducible.

---

## Rule 5 — Separate observation from hypothesis

Example:

**Observation**

```text id="rwcren"
Baseline Profit Factor = 0.92
```

This is supported by the backtest.

**Hypothesis**

```text id="kr3pfp"
M1 is too noisy for this Ichimoku strategy.
```

This is not yet proven.

It requires another experiment.

---

# 10. Current Research Status

| Stage                      | Status         |
| -------------------------- | -------------- |
| EA implementation          | ✅ Completed    |
| Baseline backtest          | ✅ Completed    |
| Baseline evidence retained | ✅ Completed    |
| Baseline profitability     | ❌ FAIL         |
| Root cause identified      | ⏳ Not yet      |
| Timeframe comparison       | ⏳ Not tested   |
| Crossover comparison       | ⏳ Not tested   |
| Market regime analysis     | ⏳ Not tested   |
| Exit management comparison | ⏳ Not tested   |
| Session analysis           | ⏳ Not tested   |
| Volatility exit test       | ⏳ Not tested   |
| Robustness validation      | ⏳ Not tested   |
| Production readiness       | ❌ Not approved |

---

# 11. Current Conclusion

EA-028 has completed its first baseline experiment.

The baseline produced:

```text id="scnkrj"
6,457 trades
Profit Factor     = 0.92
Expected Payoff   = -$0.15
Net Profit        = -$953.45
Max Equity DD     = 95.63%
```

Therefore:

**EA-028 does not currently demonstrate a viable trading edge under the tested XAUUSD M1 configuration.**

However, the baseline provides enough trade data to justify further controlled research.

The next objective is **not parameter optimization**.

The next objective is to identify which component of the current strategy is responsible for the negative expectancy.

---

## Next Experiment

**EXP-028-001 — Timeframe Comparison**

Test the unchanged baseline strategy on:

```text id="7t8pgy"
M1
M5
M15
H1
```

using a consistent test period and comparable execution settings.

The experiment should determine whether the poor baseline result is specific to M1 or persists across higher timeframes.
