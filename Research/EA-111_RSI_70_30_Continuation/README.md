
# EA-111 — Research Plan

## 1. Research Objective

Determine whether the EA's RSI threshold-crossing logic and candle-direction confirmation provide a measurable edge on XAUUSD M1.

**Baseline:** `EA111-M1-BASELINE-001`  
**Baseline Result:** `FAIL`  
**Current Priority:** Verify signal correctness before optimization.

## 2. Baseline Findings

- Net Profit: -$716.22
- Profit Factor: 0.73
- Expected Payoff: -$0.36
- Maximum Equity Drawdown: 71.88%
- Total Trades: 1,964
- BUY Win Rate: 44.15%
- SELL Win Rate: 41.94%

These results do not justify live deployment or broad parameter optimization.

## 3. Controlled Research Sequence

### RQ01 — Verify RSI Indexing and Signal Direction

Inspect `CopyBuffer()` indexing and compare the actual signal with the intended strategy.

- Confirm which RSI values correspond to shift 2 and shift 1.
- Confirm the signal uses closed candles only.
- Verify whether BUY should cross upward through 70 or return below 70.
- Verify whether SELL should cross downward through 30 or return above 30.
- Preserve the original baseline file.

**Acceptance:** The implemented conditions must match the explicitly documented strategy.

### RQ02 — Validate the Corrected Signal

After confirming the intended rules, run a separate baseline experiment using the corrected logic.

Keep the original EA and its backtest results unchanged for comparison.

Record the new experiment ID, code version, inputs and test report.

### RQ03 — RSI Thresholds

Only after RQ02 is complete, evaluate a controlled set of thresholds:

- 20/80
- 25/75
- 30/70
- 35/65
- 40/60

Change only the threshold pair per experiment.

### RQ04 — RSI Period

Test one parameter group at a time:

- 7
- 10
- 14
- 21
- 28

### RQ05 — Candle Confirmation

Compare:

- Bullish/bearish candle requirement
- Minimum candle body size
- Candle body relative to full range
- Close location within the candle range
- Additional confirmation candle

### RQ06 — BUY vs SELL

Evaluate BUY and SELL independently to determine whether either direction contributes most of the losses.

### RQ07 — Exit Management

After establishing signal quality, test:

- Stop Loss / Take Profit
- Break-even trigger and offset
- Trailing-stop start and distance

Do not change entry logic and exit parameters simultaneously.

### RQ08 — Trading Session

Evaluate performance by trading session after the preceding stages establish a credible candidate.

### RQ09 — Out-of-Sample Validation

Use a separate, previously unoptimized date range. Do not tune parameters on the OOS sample.

### RQ10 — Robustness and Walk-Forward

Test stability across different market periods and parameter neighborhoods before considering forward testing.

## 4. Research Rules

1. Preserve the original baseline.
2. Verify signal correctness before parameter optimization.
3. Change one variable group at a time.
4. Do not select a configuration by net profit alone.
5. Record every experiment, including negative results.
6. Do not use the same data repeatedly as both optimization and independent validation.
7. A successful historical test does not establish live-trading readiness.

## 5. Current Status

| Stage | Status |
|---|---|
| Code Review | Required |
| Baseline Backtest | Complete |
| Baseline Assessment | FAIL |
| RSI Signal Verification | Pending |
| Corrected-Signal Test | Not Started |
| Parameter Evaluation | Blocked |
| Out-of-Sample | Not Started |
| Walk-Forward | Not Started |
| Forward Test | Not Started |
| Live Trading | Not Approved |
