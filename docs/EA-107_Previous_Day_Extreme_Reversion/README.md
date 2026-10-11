
## EA-107 — Previous Day Extreme Reversion

### Strategy Hypothesis

EA-107 tests whether price rejection at the previous trading day's high or low can provide a mean-reversion entry on XAUUSD M1.

The strategy uses the previous completed daily candle to obtain the reference high and low, then evaluates the previous completed chart-timeframe candle for a breakout-and-rejection pattern.

### Signal Definition

**SELL**

- Previous candle high exceeds the previous day's high.
- Previous candle close returns below the previous day's high.

`High[1] > PreviousDayHigh AND Close[1] < PreviousDayHigh`

**BUY**

- Previous candle low falls below the previous day's low.
- Previous candle close returns above the previous day's low.

`Low[1] < PreviousDayLow AND Close[1] > PreviousDayLow`

The EA checks for a new chart-timeframe bar before evaluating an entry. The current implementation uses the previous completed daily candle (`PERIOD_D1`, shift 1) as its reference.

### Baseline Experiment

| Parameter | Value |
|---|---|
| Baseline ID | `EA107-M1-BASELINE-001` |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Tick Model | 100% real ticks |
| Lot Size | 0.01 |
| Stop Loss Input | 300 points |
| Take Profit Input | 600 points |
| Maximum Spread | 30 points |
| Break-even | Enabled, trigger 150 points |
| Trailing Stop | Enabled, start 200 points, distance 200 points |

### Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | -$152.75 |
| Profit Factor | 0.83 |
| Expected Payoff | -$0.22 |
| Recovery Factor | -0.82 |
| Sharpe Ratio | -5.00 |
| Maximum Equity Drawdown | 18.51% |
| Total Trades | 693 |
| Win Rate | 44.59% |

**Baseline decision: FAIL.**

The baseline does not meet the minimum requirement of positive net profit and Profit Factor above 1.0. The negative expected payoff and Sharpe Ratio provide additional evidence that the current configuration has not demonstrated a profitable edge.

### Research Protocol

1. Preserve the original EA source, inputs, and baseline report.
2. Investigate the entry condition before broad parameter optimization.
3. Test penetration distance and confirmation rules independently.
4. Evaluate BUY and SELL separately without assuming that one direction is inherently better.
5. Investigate session and market-regime effects using predefined rules.
6. Evaluate exit management only after entry improvements show credible evidence.
7. Reserve independent data for out-of-sample validation.
8. Use robustness and walk-forward testing to assess stability.
9. Consider forward testing only after the strategy passes the preceding validation stages.

### Acceptance Principles

A candidate must not be accepted solely because it has the highest net profit among tested variants.

Evaluation must consider profitability, drawdown, trade count, expected payoff, Profit Factor, consistency across periods, and sensitivity to nearby parameter values.

No baseline result alone authorizes live trading.

### Current Status

- Strategy code: COMPLETE
- Baseline test: COMPLETE
- Baseline assessment: FAIL
- Controlled entry research: REQUIRED
- Broad optimization: BLOCKED
- Out-of-sample validation: NOT STARTED
- Walk-forward validation: NOT STARTED
- Forward testing: NOT STARTED
- Live trading: NOT APPROVED
