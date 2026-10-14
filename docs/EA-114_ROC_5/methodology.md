## EA-114 — ROC 5 Research Methodology

### Strategy Definition

EA-114 uses a five-period Rate of Change (ROC) calculation to measure percentage price movement.

`ROC = (Close[1] - Close[ROC Period + 1]) / Close[ROC Period + 1] × 100`

The baseline opens a BUY when ROC exceeds `+0.10%` and a SELL when ROC falls below `-0.10%`. Entry evaluation occurs once per new bar.

### Baseline Configuration

- **Baseline ID:** `EA114-M1-BASELINE-001`
- **Symbol / Timeframe:** XAUUSD.PRO / M1
- **Test Period:** 2026-01-02 to 2026-04-01
- **Initial Deposit:** $1,000
- **Leverage:** 1:500
- **History Quality:** 100% real ticks
- **ROC Period:** 5
- **ROC Threshold:** 0.10%
- **Stop Loss / Take Profit:** 300 / 600 points

### Baseline Assessment

The baseline produced net profit of `-$994.73`, Profit Factor of `0.91`, Expected Payoff of `-$0.11`, maximum equity drawdown of `99.47%`, and 8,823 trades.

The baseline is classified as `FAIL`. It is not approved for live trading.

### Research Protocol

1. Verify ROC calculation, candle indexing, new-bar timing, and order execution.
2. Assess entry-edge evidence before changing strategy parameters.
3. Test ROC thresholds using controlled experiments.
4. Evaluate ROC period sensitivity only after documenting threshold results.
5. Compare BUY and SELL performance using multiple metrics.
6. Investigate exit management only if entry-edge evidence justifies further work.
7. Validate selected configurations out of sample.
8. Perform robustness and walk-forward testing before forward testing.

### Evaluation Metrics

Every experiment should record:

- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Balance and Equity Drawdown
- Total Trades and Win Rate
- BUY and SELL breakdown
- Trading costs and execution conditions
- Performance across test and validation periods

### Acceptance Principles

A configuration must not be accepted based on net profit alone. Positive expectancy, acceptable drawdown, adequate trade count, and stability outside the selection period must be evaluated together.

### Current Research Status

- **Baseline:** `FAIL`
- **Entry Edge:** `NOT ESTABLISHED`
- **Broad Optimization:** `BLOCKED`
- **Out-of-Sample Validation:** `NOT STARTED`
- **Forward Testing:** `NOT STARTED`
- **Live Trading:** `NOT APPROVED`

The next permitted step is signal verification followed by a documented entry-edge assessment.
