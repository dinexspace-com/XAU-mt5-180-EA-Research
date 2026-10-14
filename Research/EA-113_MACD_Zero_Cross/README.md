
# EA-113 — MACD Zero Cross Research

## 1. Research Objective

Determine whether the MACD main-line zero-cross strategy can demonstrate a repeatable trading edge on XAUUSD M1.

The baseline failed with negative net profit, Profit Factor 0.79, and maximum Equity Drawdown of 79.62%.

**Current Decision:** `FAIL — ENTRY EDGE NOT ESTABLISHED`

## 2. Baseline Reference

- **Baseline ID:** `EA113-M1-BASELINE-001`
- **Fast EMA:** 12
- **Slow EMA:** 26
- **Signal Period:** 9
- **Stop Loss:** 300 points
- **Take Profit:** 600 points
- **Break-even:** Trigger 150 points, offset 0
- **Trailing Stop:** Start 200 points, distance 200 points
- **Net Profit:** -$775.88
- **Profit Factor:** 0.79
- **Maximum Equity Drawdown:** 79.62%
- **Total Trades:** 2,830

## 3. Controlled Research Plan

### RQ01 — Verify Signal Implementation

- Confirm the MACD main-line buffer and zero-cross conditions.
- Verify that both compared values correspond to the intended closed candles.
- Check signal timing and new-bar execution.
- Preserve the original baseline source.

### RQ02 — Entry Signal Definition

Compare one change at a time:

- MACD main-line zero cross.
- MACD main-line versus signal-line cross.
- Zero cross with a price-trend filter.
- Zero cross with a minimum MACD movement threshold.

Treat each as a separate strategy variant, not as an equivalent implementation of the baseline.

### RQ03 — Trend Filter

Test a predefined price-trend filter, such as EMA-based direction confirmation.

Record whether the filter improves Profit Factor and drawdown while retaining a sufficient trade sample.

### RQ04 — BUY vs SELL

Evaluate BUY-only and SELL-only variants separately.

Compare net profit, Profit Factor, expected payoff, drawdown, and trade count. Do not select a direction based only on win rate.

### RQ05 — MACD Parameters

Only after the entry logic demonstrates improvement, test a controlled set of Fast EMA, Slow EMA, and Signal Period values.

Change one parameter group at a time and retain the baseline settings for comparison.

### RQ06 — Exit Management

Evaluate Stop Loss, Take Profit, break-even, and trailing-stop behavior separately.

Do not optimize entry and exit parameters simultaneously.

### RQ07 — Trading Session

Test session restrictions only after establishing evidence of an entry edge. Document the time zone and session boundaries.

### RQ08 — Out-of-Sample Validation

Evaluate the selected configuration on data not used for research or parameter selection.

### RQ09 — Robustness and Walk-Forward

Test nearby parameter values, different market periods, and walk-forward segments. Record both successful and unsuccessful runs.

## 4. Experiment Rules

1. Preserve `EA113-M1-BASELINE-001` unchanged.
2. Change one variable group per experiment.
3. Record the exact EA version, inputs, test period, and report.
4. Do not rank results by net profit alone.
5. Review Profit Factor, expected payoff, drawdown, trade count, and stability together.
6. Avoid broad optimization until entry-edge evidence exists.
7. Keep Out-of-Sample data separate from parameter selection.
8. Do not approve live trading based on one backtest.

## 5. Current Research Status

| Item | Status |
|---|---|
| Strategy Code | COMPLETE |
| Baseline Test | COMPLETE |
| Baseline Result | FAIL |
| Signal Verification | PENDING |
| Entry Logic Research | NOT STARTED |
| Parameter Research | BLOCKED pending signal assessment |
| Out-of-Sample | NOT STARTED |
| Walk-Forward | NOT STARTED |
| Forward Test | NOT STARTED |
| Live Trading | NOT APPROVED |

**Next Action:** Verify the MACD buffer indexing and zero-cross signal timing before conducting strategy experiments.
