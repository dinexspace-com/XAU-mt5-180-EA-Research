
## EA-113 — MACD Zero Cross Research Methodology

### Strategy Definition

EA-113 uses the MACD main line and enters when it crosses the zero line.

- **BUY:** Previous closed MACD value `<= 0` and latest closed MACD value `> 0`.
- **SELL:** Previous closed MACD value `>= 0` and latest closed MACD value `< 0`.

Baseline indicator parameters are Fast EMA 12, Slow EMA 26, and Signal Period 9.

### Baseline Identification

`EA113-M1-BASELINE-001`

The baseline must remain unchanged and serve as the reference for subsequent experiments.

### Baseline Configuration

- Symbol: XAUUSD.PRO
- Timeframe: M1
- Test period: 2026-01-02 to 2026-04-01
- Initial deposit: $1,000
- Leverage: 1:500
- Tick model: 100% real ticks
- Lot size: 0.01
- Stop Loss: 300 points
- Take Profit: 600 points
- Break-even trigger: 150 points
- Trailing start: 200 points
- Trailing distance: 200 points

### Baseline Acceptance Criteria

The baseline is classified as `FAIL` because:

- Net Profit: -$775.88
- Profit Factor: 0.79
- Expected Payoff: -$0.27
- Sharpe Ratio: -5.00
- Maximum Equity Drawdown: 79.62%

The baseline does not satisfy the requirement to demonstrate positive performance with acceptable risk.

### Experimental Method

1. Verify source-code correctness and signal timing.
2. Preserve the baseline source and report.
3. Establish a specific research question for each experiment.
4. Change one variable group at a time.
5. Use identical test settings when comparing variants.
6. Record all input parameters and performance metrics.
7. Reject variants that improve profit at the cost of unacceptable drawdown or unstable performance.
8. Reserve independent data for Out-of-Sample validation.
9. Perform robustness and Walk-Forward testing before considering Forward Testing.

### Required Evaluation Metrics

Each experiment should record:

- Net Profit
- Gross Profit and Gross Loss
- Profit Factor
- Expected Payoff
- Recovery Factor
- Sharpe Ratio
- Maximum Balance and Equity Drawdown
- Total Trades
- Winning and Losing Trade Counts
- BUY and SELL performance
- Average profit and average loss per trade

### Current Decision

- Strategy Code: `COMPLETE`
- Baseline: `COMPLETE`
- Baseline Performance: `FAIL`
- Signal Verification: `PENDING`
- Broad Optimization: `BLOCKED`
- Out-of-Sample: `NOT STARTED`
- Walk-Forward: `NOT STARTED`
- Forward Test: `NOT STARTED`
- Live Trading: `NOT APPROVED`

**Research Principle:** Correct implementation and a completed backtest do not establish a profitable strategy. EA-113 must demonstrate a measurable entry edge and pass independent validation before advancing toward live deployment.
