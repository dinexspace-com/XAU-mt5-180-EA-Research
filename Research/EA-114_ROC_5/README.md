# EA-114 — ROC 5 Research

## Research Objective

Determine whether a five-period Rate of Change (ROC) threshold can provide a repeatable entry edge on XAUUSD.PRO M1 after accounting for trading costs and execution conditions.

## Baseline Definition

- **Baseline ID:** `EA114-M1-BASELINE-001`
- **ROC Period:** 5
- **ROC Threshold:** 0.10%
- **BUY Condition:** ROC > +0.10%
- **SELL Condition:** ROC < -0.10%
- **Baseline Net Profit:** -$994.73
- **Profit Factor:** 0.91
- **Maximum Equity Drawdown:** 99.47%
- **Total Trades:** 8,823
- **Classification:** `FAIL`

## Initial Findings

- The baseline has negative net profit and negative expected payoff.
- The drawdown is too high to consider the current configuration viable.
- BUY and SELL win rates are similar: 45.27% and 45.36%, respectively.
- The current results do not demonstrate a positive edge.
- The baseline must remain unchanged as the reference for future experiments.

## Research Plan

### RQ01 — Verify Signal Implementation

- Confirm the ROC formula and percentage units.
- Verify that `Close[1]` and `Close[ROC Period + 1]` refer to the intended closed candles.
- Confirm that entries are evaluated once per new bar.
- Check order direction, initial SL/TP placement, and execution logs.

### RQ02 — Evaluate Entry Edge

- Analyze trade outcomes by ROC magnitude.
- Compare positive and negative ROC signals separately.
- Examine whether marginal threshold crossings generate excessive low-quality entries.
- Establish whether the entry signal has measurable value before changing risk management.

### RQ03 — Controlled ROC Threshold Tests

After confirming the implementation, test a limited, predeclared set of ROC thresholds while keeping other settings fixed.

Record every configuration and compare net profit, Profit Factor, Expected Payoff, drawdown, and trade count.

### RQ04 — ROC Period Sensitivity

Evaluate a small set of alternative ROC periods only after the threshold experiment has been documented.

Change one variable at a time and retain the original baseline for comparison.

### RQ05 — Directional Analysis

Compare BUY and SELL performance, including trade count, expectancy, profit factor, and drawdown contribution.

Do not remove a direction based solely on win rate.

### RQ06 — Exit Management

Only if evidence of entry edge emerges, investigate Stop Loss, Take Profit, break-even, and trailing-stop behavior separately.

### RQ07 — Out-of-Sample Validation

Test promising, preselected configurations on data not used for parameter selection.

### RQ08 — Robustness and Walk-Forward Testing

Evaluate stability across different market periods and parameter neighborhoods before considering forward testing.

## Experiment Rules

- Preserve the baseline configuration and report.
- Change one principal variable per experiment.
- Record the hypothesis before each test.
- Do not select configurations using net profit alone.
- Consider drawdown, expectancy, Profit Factor, trade count, and stability.
- Avoid broad optimization until the entry-edge investigation is complete.

## Current Decision

**Research Status:** `ENTRY EDGE NOT ESTABLISHED`

**Baseline Status:** `FAIL`

**Optimization Status:** `BROAD OPTIMIZATION BLOCKED`

**Live Validation:** `NOT STARTED`

**Next Action:** Verify signal implementation, then assess entry-edge evidence before running controlled parameter experiments.
