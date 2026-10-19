## EA-119 — Three Candle Momentum

### Strategy Identification

- **EA:** `EA-119_Three_Candle_Momentum`
- **Baseline ID:** `EA119-M1-BASELINE-001`
- **Strategy Type:** Short-term price momentum
- **Baseline Symbol:** XAUUSD.PRO
- **Baseline Timeframe:** M1

### Signal Definition

The EA evaluates the closing prices of three completed candles when a new bar forms.

- BUY when `Close[1] > Close[2] > Close[3]`.
- SELL when `Close[1] < Close[2] < Close[3]`.

The implementation uses the chart's current timeframe. Reproduce the baseline using M1.

### Baseline Test Configuration

- Period: 2026-01-02 to 2026-04-01
- Initial deposit: $1,000
- Leverage: 1:500
- Lot size: 0.01
- History quality: 100% real ticks
- Stop Loss: 300 points
- Take Profit: 600 points
- Break-even: enabled, trigger 150 points, offset 0
- Trailing stop: enabled, start 200 points, distance 200 points
- Maximum spread: 30 points

### Baseline Metrics

| Metric | Result |
|---|---:|
| Net Profit | -$992.47 |
| Profit Factor | 0.71 |
| Expected Payoff | -$0.37 |
| Sharpe Ratio | -5.00 |
| Maximum Equity Drawdown | 99.27% |
| Total Trades | 2,650 |

### Assessment

The baseline is classified as `FAIL`. It exhibits negative profitability metrics and extremely high equity drawdown. It is not validated for live trading.

The baseline must remain unchanged as the reference for subsequent experiments. A failed baseline must not be presented as a successful strategy merely because individual parameter combinations perform better.

### Research and Validation Protocol

1. Verify signal implementation and order execution.
2. Evaluate signal length and momentum strength separately.
3. Test entry confirmation rules in controlled experiments.
4. Analyze BUY and SELL performance separately.
5. Evaluate exit management only with clearly documented settings.
6. Assess session and market-regime filters.
7. Validate selected candidates out of sample.
8. Conduct robustness and walk-forward testing.
9. Require forward-test evidence before any live-trading decision.

### Reporting Requirements

Each experiment must record:

- Experiment ID and EA version
- Exact input parameters
- Symbol, timeframe, and test period
- Deposit, leverage, and tick-model settings
- Net profit, Profit Factor, expected payoff, and drawdown
- Trade count and directional results
- Differences from the baseline
- Decision and rationale

### Current Status

- Baseline: `COMPLETE`
- Baseline Result: `FAIL`
- Controlled Research: `REQUIRED`
- Broad Optimization: `BLOCKED`
- Out-of-Sample: `NOT STARTED`
- Walk-Forward: `NOT STARTED`
- Forward Test: `NOT STARTED`
- Live Trading: `NOT APPROVED`
