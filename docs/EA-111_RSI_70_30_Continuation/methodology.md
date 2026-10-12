
## EA-111 — RSI 70/30 Continuation

### Strategy Identification

- **EA:** `EA-111_RSI_70_30_Continuation`
- **Baseline ID:** `EA111-M1-BASELINE-001`
- **Symbol:** XAUUSD.PRO
- **Timeframe:** M1
- **Indicator:** RSI(14)
- **Baseline Period:** 2026-01-02 to 2026-04-01
- **Initial Deposit:** $1,000
- **Model:** 100% real ticks

### Baseline Signal Definition

The source code compares RSI values obtained through a static array populated by `CopyBuffer()`.

With a successful request for three values starting at shift 0, the code comments identify:

- `r[0]`: older closed candle
- `r[1]`: latest closed candle
- `r[2]`: current candle

The implemented BUY condition is:

- `r[0] <= 70`
- `r[1] > 70`
- Latest closed candle is bullish

The implemented SELL condition is:

- `r[0] >= 30`
- `r[1] < 30`
- Latest closed candle is bearish

These conditions represent an upward crossing of 70 for BUY and a downward crossing of 30 for SELL. They do not match the source comments describing RSI returning below 70 for BUY and above 30 for SELL.

**Required control:** Confirm the intended strategy definition before changing the code. Any correction must receive a new experiment identifier and a separate test report.

### Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | -$716.22 |
| Profit Factor | 0.73 |
| Expected Payoff | -$0.36 |
| Sharpe Ratio | -5.00 |
| Maximum Equity Drawdown | 71.88% |
| Total Trades | 1,964 |

### Acceptance Policy

The baseline is classified as `FAIL`.

A candidate cannot advance based on net profit alone. Review at minimum:

- Profit Factor
- Expected Payoff
- Maximum equity drawdown
- Trade count
- Directional performance
- Stability across independent test periods

No live-trading approval is granted by this baseline.

### Experiment Policy

1. Preserve the original EA and baseline report.
2. Verify the signal definition and candle indexing first.
3. Assign a unique identifier to every changed implementation.
4. Test one variable group at a time.
5. Record settings, dates, tick model and performance metrics.
6. Use independent OOS data and subsequent robustness testing.
7. Do not start broad parameter optimization until the signal logic is verified and retested.

### Current Research Status

- Code Review: `REQUIRED`
- Baseline: `COMPLETE`
- Baseline Result: `FAIL`
- Signal Verification: `PENDING`
- Parameter Optimization: `BLOCKED`
- OOS / Walk-Forward: `NOT STARTED`
- Forward Test: `NOT STARTED`
- Live Trading: `NOT APPROVED`
