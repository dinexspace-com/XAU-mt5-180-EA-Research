
# EA-109 — RSI 50 Cross Research

## 1. Research Objective

Determine whether an RSI 50-level crossing combined with an EMA trend filter can produce a repeatable trading edge on XAUUSD M1.

The current baseline is negative and must not be optimized blindly.

**Baseline ID:** `EA109-M1-BASELINE-001`

**Baseline Result:** `FAIL`

## 2. Initial Findings

- Net Profit: -$18.67
- Profit Factor: 0.90
- Expected Payoff: -$0.12
- Max Equity Drawdown: 3.92%
- Total Trades: 153
- BUY Win Rate: 52.05%
- SELL Win Rate: 52.50%

The win rate is above 50%, but the average loss is larger than the average win. The strategy remains unprofitable in this test.

## 3. Research Plan

### RQ01 — Indicator Buffer and Signal Audit

Before optimization:

- Verify how `CopyBuffer()` maps data into the fixed-size RSI and EMA arrays.
- Confirm which RSI values correspond to the current and closed bars.
- Confirm that the EMA filter uses the intended candle and EMA value.
- Verify that BUY and SELL conditions match the intended RSI crossing direction.
- Re-run the unchanged baseline after correcting any confirmed implementation issue.
- Record any corrected version separately; do not overwrite the original baseline result.

### RQ02 — RSI Period

Only after RQ01 is resolved, test:

- 7
- 10
- 14
- 21
- 28

### RQ03 — EMA Period

Test one value at a time:

- 10
- 15
- 20
- 25
- 30
- 50

### RQ04 — RSI Crossing Confirmation

Compare:

- RSI crosses 50 on a closed candle.
- RSI crossing plus candle direction confirmation.
- RSI crossing plus minimum candle body.
- RSI crossing plus close-location filter.

Keep the baseline entry rule as the control.

### RQ05 — BUY vs SELL

Evaluate BUY and SELL separately using identical test conditions. Determine whether one direction contributes disproportionately to losses.

### RQ06 — Stop Loss and Take Profit

After entry logic is verified, test controlled SL/TP combinations. Do not change entry parameters and exit parameters in the same experiment.

### RQ07 — Break-even and Trailing Stop

Compare the baseline management settings with isolated alternatives. Track their effect on expectancy, Profit Factor and drawdown.

### RQ08 — Trading Session

Test predefined trading sessions only after the entry logic is stable. Avoid selecting a session solely because it performs best in the original sample.

### RQ09 — Out-of-Sample Validation

Freeze the candidate rules and test them on data not used to select parameters.

### RQ10 — Robustness and Walk-Forward

Assess nearby parameter values, different market periods and walk-forward performance before considering a forward test.

## 4. Research Rules

1. Preserve the original baseline and its report.
2. Resolve implementation uncertainty before parameter optimization.
3. Change one parameter group at a time.
4. Do not select a candidate by net profit alone.
5. Review Profit Factor, Expected Payoff, drawdown, trade count and consistency.
6. Keep out-of-sample data separate from parameter selection.
7. Do not authorize live trading based on a single backtest.

## 5. Current Status

| Item | Status |
|---|---|
| Source Code Review | INITIAL REVIEW COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Result | FAIL |
| Signal / Buffer Audit | REQUIRED |
| Parameter Research | NOT STARTED |
| Out-of-Sample | NOT STARTED |
| Walk-Forward | NOT STARTED |
| Forward Test | NOT STARTED |
| Live Trading | NOT APPROVED |
