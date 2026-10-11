## EA-108 — VWAP Crossback Research Record

### Baseline Identification

- **EA:** EA-108_VWAP_Crossback
- **Baseline ID:** `EA108-M1-BASELINE-001`
- **Symbol:** XAUUSD.PRO
- **Timeframe:** M1
- **Test Period:** 2026-01-02 to 2026-04-01
- **Initial Deposit:** $1,000
- **History Quality:** 100% real ticks
- **Classification:** FAIL

### Baseline Results

The baseline produced a net loss of $992.86, a Profit Factor of 0.82, and a maximum equity drawdown of 99.30% across 4,557 trades.

These results fail the current research acceptance criteria. The strategy must not be considered ready for live trading.

### Research Methodology

Research must proceed in the following order:

1. Verify the VWAP calculation, daily reset, candle indexing, and signal conditions.
2. Inspect baseline trades and identify possible directional, session, and market-regime differences.
3. Test the rejection buffer and candle confirmation rules independently.
4. Evaluate BUY and SELL performance separately.
5. Test session and market-regime filters while keeping other variables fixed.
6. Investigate stop-loss, take-profit, break-even, and trailing-stop settings only after entry behavior has been reviewed.
7. Validate any promising configuration with out-of-sample, walk-forward, robustness, and forward testing.

### Experiment Control

Every experiment must have a unique identifier and record:

- Source-code version.
- Input parameters.
- Symbol and timeframe.
- Test period and initial deposit.
- Tick model and data quality.
- Net profit and Profit Factor.
- Maximum balance and equity drawdown.
- Trade count and win rate.
- BUY/SELL performance.
- Observations and final decision.

The original baseline must remain unchanged and available for comparison.

### Decision Policy

The current EA-108 baseline is classified as **FAIL**. Broad optimization and live deployment are not approved at this stage.

A positive result from a modified backtest is only a reason to continue validation. It is not sufficient evidence of a durable trading edge. Any candidate must demonstrate acceptable risk and performance on unseen data before further consideration.

### Current Status

- Baseline test: Completed — FAIL.
- Implementation and signal review: Pending.
- Controlled experiments: Pending.
- Out-of-sample validation: Pending.
- Forward testing: Pending.
- Live trading approval: Not granted.
