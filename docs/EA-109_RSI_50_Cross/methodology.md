
## EA-109 — RSI 50 Cross

### Strategy Definition

EA-109 combines RSI 50-level crossing conditions with an EMA trend filter. The baseline uses RSI period 14 and EMA period 20 on XAUUSD.PRO M1.

The EA evaluates entries on a new bar and manages open positions using Stop Loss, Take Profit, break-even and trailing-stop rules.

### Baseline Identification

- **Baseline ID:** `EA109-M1-BASELINE-001`
- **Symbol:** XAUUSD.PRO
- **Timeframe:** M1
- **Period:** 2026-01-02 to 2026-04-01
- **Initial Deposit:** $1,000
- **Model:** 100% real ticks
- **Baseline Status:** FAIL

### Baseline Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| RSI Period | 14 |
| EMA Period | 20 |
| Maximum Spread | 30 points |
| Break-even Trigger | 150 points |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

### Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | -$18.67 |
| Profit Factor | 0.90 |
| Expected Payoff | -$0.12 |
| Sharpe Ratio | -5.00 |
| Max Equity Drawdown | 3.92% |
| Total Trades | 153 |

### Acceptance Criteria

A candidate must be assessed using multiple performance and robustness measures, including:

- Positive net profit and Expected Payoff.
- Profit Factor above 1.00, with a sufficient margin to account for trading costs.
- Acceptable equity drawdown.
- Adequate trade count and consistency across periods.
- No material degradation on independent out-of-sample data.
- Robustness across nearby parameter settings and walk-forward periods.

Passing the initial backtest does not establish that a strategy is ready for live trading.

### Controlled Experiment Procedure

1. Preserve the original source file, configuration and baseline report.
2. Audit RSI and EMA buffer indexing before conducting optimization.
3. Confirm that the implemented signal matches the intended closed-bar RSI crossing.
4. Re-run and document a corrected baseline as a separate experiment if a code issue is confirmed.
5. Change only one parameter group per experiment.
6. Record each experiment's settings, results and decision.
7. Evaluate out-of-sample and robustness results before a forward test.
8. Require separate forward validation before considering live deployment.

### Current Decision

**EA-109 is not approved for live trading.**

The initial baseline has negative net profit, Profit Factor below 1.00 and negative Expected Payoff. The next required step is to verify the indicator-buffer indexing and signal direction before parameter research.

Do not overwrite the original baseline report when creating a corrected implementation or a new experiment.
