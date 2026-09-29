# EA Research

## EA-087_Z-Score_2

This directory records the research process for `EA-087_Z-Score_2`.

The research is based on the EA source code and MetaTrader 5 Strategy Tester results.

---

## Current Research Baseline

The current baseline uses:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
Z-Score Period: 20
Z-Score Threshold: 2.0
Lot Size: 0.01
Stop Loss: 300
Take Profit: 600
Break Even: Enabled
Trailing Stop: Enabled
```

The baseline backtest covers:

```text
2026-01-02 to 2026-03-31
```

using:

```text
100% real ticks
```

---

## Baseline Result

The recorded baseline result is:

```text
Net Profit:          -634.42 USD
Profit Factor:       0.90
Sharpe Ratio:        -5.00
Equity Drawdown:     75.22%
Total Trades:        5,136
Profit Trades:       50.47%
Loss Trades:         49.53%
```

This result is the reference point for subsequent research.

---

## Research Objective

The research objective is to study the behaviour of the Z-Score strategy on XAUUSD and determine how the strategy responds to changes in its parameters and execution conditions.

The research should preserve the baseline and compare later experiments against it.

---

## Primary Variables

The principal strategy variables are:

### Z-Score

```text
InpZPeriod
InpZThreshold
```

### Risk / Exit

```text
InpStopLoss
InpTakeProfit
```

### Break Even

```text
InpUseBreakEven
InpBreakEvenTrigger
InpBreakEvenOffset
```

### Trailing Stop

```text
InpUseTrailingStop
InpTrailingStart
InpTrailingDistance
InpTrailingStep
```

### Execution

```text
InpLotSize
InpMaxSpread
InpSlippage
```

---

## Research Rules

1. The baseline test must not be overwritten.
2. Each experiment must record its parameter values.
3. Each experiment must record its test period.
4. Each experiment must record the symbol and timeframe.
5. Each experiment must preserve the original tester report.
6. Results must be compared against the baseline.
7. A parameter change must be identifiable from the experiment record.
8. Backtest results must not be treated as live-trading results.
9. Optimization results must be separated from validation results.
10. Out-of-sample results must not be mixed with in-sample optimization results.

---

## Experiment Naming

Research experiments should use a consistent naming scheme:

```text
EA-087_Z-Score_2/
├── baseline/
├── experiment-001/
├── experiment-002/
├── experiment-003/
└── ...
```

Each experiment should contain the relevant tester report and a short record of the parameters tested.

---

## Current Status

```text
Baseline recorded: YES
Optimization:       NOT RECORDED
Out-of-sample:      NOT RECORDED
Forward test:       NOT RECORDED
Live test:          NOT RECORDED
```

The current repository therefore represents a research baseline, not a validated live-trading system.
