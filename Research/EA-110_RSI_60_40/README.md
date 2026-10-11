# EA-110_RSI_60_40 — Research Notes

## 1. Research Objective

Evaluate whether the RSI 60/40 strategy used by EA-110 can maintain positive expectancy and acceptable drawdown after verifying the signal implementation and testing robustness across different market conditions.

## 2. Baseline Reference

| Metric | Baseline |
|---|---:|
| Net Profit | +$81.46 |
| Profit Factor | 1.36 |
| Expected Payoff | $0.40 |
| Recovery Factor | 2.39 |
| Sharpe Ratio | 32.22 |
| Maximum Equity Drawdown | 3.40% |
| Total Trades | 205 |
| Long Win Rate | 45.53% |
| Short Win Rate | 56.10% |

Test conditions: XAUUSD.PRO, M1, 2026-01-02 to 2026-04-01, initial deposit $1,000, 100% real ticks.

## 3. Primary Finding

The initial test produced positive net profit and a Profit Factor above 1. The reported maximum equity drawdown was 3.40%.

However, the baseline has only 205 trades. The result should be treated as an initial research signal rather than proof of a stable trading edge.

## 4. Priority 1 — Audit RSI Signal Logic

The current source contains:

- BUY condition: `r[2] <= 60 && r[1] > 60`
- SELL condition: `r[2] >= 40 && r[1] < 40`

The code calls `CopyBuffer(g_rsi, 0, 0, 3, r)` with a fixed-size array. MQL5 buffer-copy ordering means the oldest copied value is placed at the beginning of physical memory. Verify the mapping of `r[0]`, `r[1]`, and `r[2]` to bar shifts before interpreting the conditions.

Research tasks:

1. Confirm the RSI value represented by each array index.
2. Confirm whether the conditions use the forming bar or closed bars.
3. Determine whether BUY and SELL trigger on the intended threshold-crossing directions.
4. If the code is corrected, run a separate test and label it as a new version; do not overwrite the original baseline.

## 5. Priority 2 — Directional Performance

The baseline report shows:

- Long trades: 123; win rate 45.53%.
- Short trades: 82; win rate 56.10%.

Investigate whether this difference persists across additional periods and whether it is associated with market conditions, signal implementation, or exit behavior. Do not disable either direction based only on this one report.

## 6. Priority 3 — Risk and Exit Behavior

The EA currently uses:

- Stop Loss: 300 points.
- Take Profit: 600 points.
- Break-Even start: 150 points, offset 0.
- Trailing Stop start: 200 points.
- Trailing distance: 200 points.
- Maximum spread: 30 points.

After the signal audit, test exit-management changes independently. Change one parameter group at a time and compare each version with the original baseline.

## 7. Validation Plan

| Stage | Objective | Status |
|---|---|---|
| Baseline reproduction | Reproduce the supplied test | Report supplied |
| RSI logic audit | Verify buffer indexing and crossing direction | Pending |
| Directional analysis | Compare long and short performance | Pending |
| Exit-management tests | Evaluate SL/TP, Break-Even, and Trailing Stop | Pending |
| Parameter sensitivity | Check whether results depend on narrow settings | Pending |
| Out-of-sample test | Evaluate unseen data | Not documented |
| Walk-forward test | Check stability across sequential periods | Not documented |
| Forward demo test | Observe real-time execution | Not documented |
| Live trading | Evaluate only after validation | Not approved |

## 8. Research Rules

- Keep the original source and baseline report unchanged.
- Record each test's code version, inputs, date range, and report.
- Avoid optimizing parameters before verifying the signal logic.
- Compare net profit, Profit Factor, Expected Payoff, drawdown, trade count, and directional statistics together.
- Do not select a configuration using net profit alone.
- Distinguish in-sample results from out-of-sample and forward results.

## 9. Current Conclusion

**Research status: IN PROGRESS**

EA-110 merits further investigation based on the supplied baseline results. The next priority is to verify RSI buffer indexing and signal direction, then reproduce the baseline and conduct controlled tests. No evidence supplied so far establishes out-of-sample robustness or live-trading readiness.
