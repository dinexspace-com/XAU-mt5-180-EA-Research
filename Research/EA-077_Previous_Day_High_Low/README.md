# EA-077 — Previous Day High/Low Research

## 1. Research Objective

Investigate whether confirmed breakouts of the previous day's high and low can produce positive trading expectancy on XAUUSD.

The initial implementation uses M1 signals with fixed stop loss, take profit, break-even and trailing-stop management.

## 2. Strategy Hypothesis

A candle closing beyond the previous day's high or low may indicate directional continuation.

The EA enters after a confirmed candle close rather than an unconfirmed intrabar breakout.

## 3. Baseline Experiment

| Parameter | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Test period | January–March 2026 |
| Signal timeframe | M1 |
| Tester timeframe | M15 |
| Initial capital | $1,000 |
| Fixed lot | 0.01 |
| Stop loss | 300 points |
| Take profit | 600 points |
| Break-even | Enabled |
| Trailing stop | Enabled |

## 4. Observed Results

| Metric | Result |
|---|---:|
| Total trades | 455 |
| Net profit | -$98.75 |
| Profit factor | 0.84 |
| Win rate | 45.05% |
| Maximum equity drawdown | 11.18% |
| Average winning trade | $2.45 |
| Average losing trade | -$2.40 |
| Maximum consecutive losses | 13 |

The initial configuration generated negative expectancy.

## 5. Research Observations

### 5.1. Winning and Losing Trades

The average winning trade ($2.45) was only slightly larger than the absolute average losing trade ($2.40).

Combined with a 45.05% win rate, this resulted in negative expectancy.

### 5.2. Break-Even and Trailing Stop

Both mechanisms were enabled during the baseline test.

Their individual contributions to profitability have not yet been isolated.

### 5.3. Consecutive Losses

The baseline recorded up to 13 consecutive losing trades.

Further trade-level analysis is required to determine whether these losses cluster around particular sessions, repeated breakouts or market conditions.

### 5.4. Holding Time

Average position holding time was 1 minute 25 seconds.

Execution costs and protective-stop behavior require further investigation.

## 6. Follow-up Research Hypotheses

### H1 — Trading Session Filter

Compare the baseline against configurations restricting entries to selected trading sessions.

Evaluate:
- Total trades.
- Net profit.
- Profit factor.
- Maximum equity drawdown.

### H2 — Break-Even and Trailing-Stop Ablation

Compare four configurations:

1. Both enabled (baseline).
2. Break-even disabled.
3. Trailing stop disabled.
4. Both disabled.

Keep other inputs unchanged.

### H3 — Re-entry Control

Investigate whether repeated entries near the same previous-day level contribute to consecutive losses.

Test limits on entries per level or trading day.

## 7. Validation

Preserve the original baseline.

Record every parameter change and corresponding result.

Use independent out-of-sample or forward testing when suitable data become available.

Do not treat an optimized in-sample result as independent validation.

## 8. Research Conclusion

The baseline generated sufficient trades for further investigation but failed the profitability criterion.

**Current status: RESEARCH — Baseline FAIL.**
