## EA-112 — MACD Histogram Expansion

### Experiment Identification

- Baseline ID: `EA112-M1-BASELINE-001`
- Symbol: XAUUSD.PRO
- Timeframe: M1
- Test Period: 2026-01-02 to 2026-04-01
- Initial Deposit: $1,000
- History Quality: 100% real ticks
- Classification: FAIL

### Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | -$993.33 |
| Profit Factor | 0.80 |
| Max Equity Drawdown | 99.33% |
| Total Trades | 3,918 |
| Win Rate | 47.96% |
| Expected Payoff | -$0.25 |

### Research Rules

1. Preserve the original EA source code and baseline report.
2. Verify indicator buffer indexing and signal timing before modifying strategy parameters.
3. Use closed candles for signal evaluation unless an experiment explicitly specifies otherwise.
4. Analyze BUY and SELL performance separately.
5. Change one independent variable per experiment whenever practical.
6. Record the experiment ID, parameters, test period, report, and conclusion.
7. Do not select a strategy based only on net profit or win rate.
8. Require out-of-sample validation, robustness testing, and forward testing before considering live deployment.

### Current Decision

The baseline fails because it loses $993.33 from a $1,000 initial deposit and reaches 99.33% maximum equity drawdown.

The next research step is to verify the MACD histogram signal and analyze trade behavior. Parameter optimization and live deployment should remain on hold until this investigation is complete.

A successful later experiment must be documented separately and must not overwrite the original baseline results.
