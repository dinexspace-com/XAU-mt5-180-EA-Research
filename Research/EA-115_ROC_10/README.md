# EA-115 — ROC 10 Research Plan

## 1. Research Objective

Determine whether the ROC momentum strategy has a repeatable trading edge on `XAUUSD.PRO` before considering further optimization.

**Baseline:** `EA115-M1-BASELINE-001`

**Baseline Result:** `FAIL`

**Primary Problems:**
- Net Profit: -$991.85
- Profit Factor: 0.88
- Expected Payoff: -$0.16
- Maximum Equity Drawdown: 99.20%
- Win Rate: 44.45%

The objective is to diagnose the baseline failure, not to find parameters that merely improve the historical net profit.

## 2. Controlled Research Sequence

### RQ01 — Verify Execution and Risk Controls

Check:
- Entry and exit order sequence.
- Stop-loss and take-profit placement.
- Break-even and trailing-stop behavior.
- Spread filtering and trade frequency.
- Whether the tester report is consistent with the intended execution rules.

Record any code changes separately from the original baseline.

### RQ02 — ROC Threshold

Test one value at a time while keeping other inputs fixed:

- 0.10%
- 0.15%
- 0.20% — baseline
- 0.25%
- 0.30%
- 0.40%
- 0.50%

Measure trade count, net profit, Profit Factor, Expected Payoff, and drawdown.

### RQ03 — ROC Period

After reviewing RQ02, test:

- 5
- 7
- 10 — baseline
- 14
- 20
- 28

Do not combine a threshold sweep and period sweep into an uncontrolled optimization.

### RQ04 — Directional Analysis

Evaluate BUY and SELL performance separately.

- Compare trade counts and win rates.
- Compare net profit and Profit Factor by direction.
- Investigate whether either direction contributes disproportionately to losses.

Any direction-specific change must be tested as a separate experiment.

### RQ05 — Entry Confirmation

Evaluate alternative signal filters independently, such as:

- Minimum candle-body requirement.
- Confirmation from the next closed candle.
- Trend-direction filter.
- Volatility filter.

These are proposed experiments, not features of the current baseline.

### RQ06 — Exit Management

Investigate the baseline exit settings:

- Stop Loss: 300 points.
- Take Profit: 600 points.
- Break-even trigger: 150 points.
- Trailing start: 200 points.
- Trailing distance: 200 points.

Change one exit-related variable group at a time. Keep the original settings as the comparison baseline.

### RQ07 — Trading Session

Determine whether results vary by trading session. Record the session definition and broker/server time convention before testing.

### RQ08 — Out-of-Sample Validation

Only advance a candidate that shows credible improvement without excessive drawdown.

- Keep the out-of-sample period separate from parameter selection.
- Do not tune parameters on the out-of-sample results.
- Compare the candidate against the original baseline.

### RQ09 — Robustness and Walk-Forward

If out-of-sample results are acceptable:

- Test adjacent parameter values.
- Check sensitivity to changes in market conditions.
- Perform walk-forward evaluation.
- Reject candidates whose performance depends on a narrow parameter setting or a single period.

## 3. Experiment Rules

1. Preserve `EA115-M1-BASELINE-001` unchanged.
2. Change one variable group per experiment.
3. Record the exact EA version, inputs, test period, and tester settings.
4. Compare Profit Factor, Expected Payoff, drawdown, trade count, and net profit together.
5. Do not select a candidate using net profit alone.
6. Avoid broad optimization until diagnostic research provides evidence of an edge.
7. Keep out-of-sample data independent of parameter selection.
8. Do not treat a single backtest as proof of live-trading readiness.

## 4. Research Log Template

For each experiment, record:

- Experiment ID
- Research question
- EA version
- Changed parameter
- Baseline value
- Test value
- Symbol and timeframe
- Test dates and modelling quality
- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Equity Drawdown
- Total Trades
- Decision and explanation

## 5. Current Research Status

| Stage | Status |
|---|---|
| Strategy Code | COMPLETE |
| Baseline Test | COMPLETE |
| Baseline Assessment | FAIL |
| Execution Diagnostics | PENDING |
| ROC Threshold Research | NOT STARTED |
| ROC Period Research | NOT STARTED |
| Entry/Exit Research | NOT STARTED |
| Out-of-Sample | NOT STARTED |
| Robustness | NOT STARTED |
| Walk-Forward | NOT STARTED |
| Forward Test | NOT STARTED |
| Live Trading | NOT APPROVED |

**Current Decision:** Diagnose the failed baseline first. Do not proceed directly to broad parameter optimization.
