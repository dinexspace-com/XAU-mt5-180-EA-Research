# EA Research Methodology

## 1. Purpose

This document defines the methodology used to develop, test and document Expert Advisors in the XAUUSD MT5 EA Research project.

The purpose is to keep EA development, backtesting and research reproducible.

---

## 2. EA Definition

Each EA must have:

```text
Unique EA ID
Strategy Name
Source Code
Input Parameters
Trading Logic
Risk Management Logic
Exit Logic
Backtest Record
Research Record
```

For EA-093:

```text
EA ID       = EA-093
Name        = Keltner_Reversion
Platform    = MetaTrader 5
Language    = MQL5
```

---

## 3. Source Code

The source code is stored under:

```text
EAs/EA-093_Keltner_Reversion/
```

The main source file is:

```text
EA-093_Keltner_Reversion.mq5
```

The source code is the authoritative reference for the actual implementation.

Documentation must not describe rules that are not implemented in the source code.

---

## 4. Baseline Configuration

Every EA must have a clearly identified baseline configuration.

For EA-093:

```text
Lot Size       = 0.01
Stop Loss      = 300
Take Profit    = 600

EMA Period     = 20
ATR Period     = 14
ATR Multiplier = 2.0

Break Even     = true
BE Trigger     = 150
BE Offset      = 0

Trailing Stop  = true
Trail Start    = 200
Trail Distance = 100
Trail Step     = 10

Timeframe      = M1
```

The baseline must not be overwritten when conducting new experiments.

---

## 5. Backtest Requirements

Each backtest record should contain:

```text
EA version
Symbol
Timeframe
Test period
Initial deposit
Leverage
Data quality
Input parameters
Net profit
Gross profit
Gross loss
Profit factor
Expected payoff
Maximum drawdown
Total trades
Win rate
Average winning trade
Average losing trade
Average holding time
```

The original tester report should be preserved whenever possible.

---

## 6. Controlled Experiments

Parameter experiments should change one research variable at a time whenever possible.

Example:

```text
Baseline:
EMA = 20

Experiment A:
EMA = 10

Experiment B:
EMA = 30

Experiment C:
EMA = 50
```

Other parameters should remain unchanged.

This allows the effect of the tested variable to be isolated more clearly.

---

## 7. Performance Metrics

The following metrics should be recorded for each test.

### Net Profit

Measures the final profit or loss of the test.

### Profit Factor

Calculated from gross profit relative to gross loss.

### Maximum Drawdown

Records the largest observed decline in the account during the test.

### Win Rate

Measures the percentage of profitable trades.

### Average Profit Trade

Measures the average result of profitable trades.

### Average Loss Trade

Measures the average result of losing trades.

### Trade Count

Measures how frequently the EA trades.

### Holding Time

Measures how long positions remain open.

---

## 8. Drawdown

Drawdown must always be recorded together with return metrics.

A strategy should not be evaluated from net profit alone.

For EA-093, the baseline report recorded:

```text
Balance Drawdown Relative = 86.40%
Equity Drawdown Relative  = 86.43%
```

These values are part of the baseline record.

---

## 9. In-Sample and Out-of-Sample

A parameter configuration should not be considered robust solely because it performs well on one historical period.

Research should eventually separate:

```text
In-Sample
Out-of-Sample
```

The parameter-development period should not be reused as the only evidence for the final evaluation.

---

## 10. Robustness Testing

After parameter research, the strategy should be tested against variations in:

```text
Time period
Market conditions
Parameter values
Execution conditions
Spread
Trading costs
```

The purpose is to determine whether performance depends excessively on one specific configuration.

---

## 11. Version Control

Changes to the EA should be identifiable.

Recommended format:

```text
EA-093 v1.00
EA-093 v1.01
EA-093 v1.02
```

A meaningful change to trading logic should create a new version.

Backtests should identify the EA version used.

---

## 12. Research Record

Every experiment should record:

```text
Experiment ID
Date
EA Version
Changed Parameter
Old Value
New Value
Symbol
Timeframe
Test Period
Net Profit
Profit Factor
Maximum Drawdown
Trade Count
Win Rate
Notes
```

Example:

```text
Experiment: EA093-EXP-001
Parameter: InpATRMultiplier
Baseline: 2.0
Test: 1.5
```

---

## 13. Reproducibility

A test should be reproducible from the stored information.

At minimum, the repository should contain:

```text
Source Code
Input Parameters
Strategy Tester Report
Research Notes
Methodology
```

---

## 14. Interpretation Rule

Backtest results are historical observations.

They should be documented as test results rather than treated as guarantees of future trading performance.

The research process should distinguish between:

```text
Observed Result
Research Hypothesis
Interpretation
Future Experiment
```

These categories should not be mixed.

---

## 15. Current EA-093 Baseline

The current EA-093 baseline is documented in:

```text
EAs/EA-093_Keltner_Reversion/
Backtest/EA-093_Keltner_Reversion/
Research/
```

The methodology in this document is the common framework for subsequent EA research.
