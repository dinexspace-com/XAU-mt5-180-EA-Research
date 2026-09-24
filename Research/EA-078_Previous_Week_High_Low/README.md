# EA-078 — Previous Week High/Low Research

## 1. Research Objective

Evaluate whether confirmed breakouts of the previous completed week's high and low can generate positive trading expectancy on XAUUSD.

The initial implementation uses M1 candle-close confirmation, fixed lot sizing, Stop Loss, Take Profit, Break Even and Trailing Stop.

## 2. Strategy Hypothesis

A confirmed close beyond the previous week's high or low may indicate short-term directional continuation.

The strategy attempts to capture this movement immediately after confirmation.

This hypothesis is being tested and has not been validated.

## 3. Baseline Experiment

| Parameter | Value |
|---|---|
| EA | EA-078 |
| Symbol | XAUUSD.PRO |
| Test Period | January–March 2026 |
| Signal Timeframe | M1 |
| Tester Timeframe | M15 |
| Initial Capital | $1,000 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Trailing Stop | Enabled |

## 4. Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 263 |
| Net Profit | -$22.97 |
| Profit Factor | 0.93 |
| Win Rate | 50.57% |
| Maximum Equity Drawdown | 5.05% |
| Average Winning Trade | $2.27 |
| Average Losing Trade | -$2.50 |
| Maximum Consecutive Losses | 7 |

## 5. Research Observations

### 5.1. Winning and Losing Trades

The win rate exceeded 50%, but the strategy still generated a net loss.

Average winning trade: $2.27.

Average losing trade: -$2.50.

The combination of win rate and average trade outcomes produced negative expectancy.

### 5.2. Long and Short Performance

Long trades: 124, with a 54.84% win rate.

Short trades: 139, with a 46.76% win rate.

These results justify investigating direction-specific performance, but win rates alone are insufficient to establish whether either direction is profitable.

### 5.3. Drawdown

Maximum equity drawdown was 5.05%.

This satisfies the current research threshold of less than 20%.

However, low drawdown does not compensate for the negative net profit.

### 5.4. Holding Time

Average position holding time was 1 minute 13 seconds.

Execution costs, spread sensitivity and rapid stop-outs warrant further analysis.

### 5.5. Break Even and Trailing Stop

Both mechanisms were enabled in the baseline test.

Their individual contributions to performance have not yet been isolated.

## 6. Follow-up Hypotheses

### H1 — Break Even and Trailing Stop

Test four configurations:

- Both enabled: baseline.
- Break Even disabled.
- Trailing Stop disabled.
- Both disabled.

Keep all other parameters unchanged.

Compare net profit, trade count, profit factor and equity drawdown.

### H2 — Directional Filtering

Investigate BUY-only and SELL-only configurations.

Compare trade frequency, average profit/loss and total profitability.

The baseline long/short win-rate difference is an observation, not proof that directional filtering will improve results.

### H3 — Re-entry Restrictions

Investigate whether repeated entries around the same weekly level contribute to losses.

Test a restriction on the number of entries per direction or weekly level.

Compare against the unchanged baseline.

## 7. Additional Investigation

The current source contains a Breakout Lookback parameter, but the weekly signal uses the previous W1 high/low.

Confirm whether the lookback parameter is intentionally retained for compatibility or should be removed in a future version.

Do not silently change the baseline source.

## 8. Validation Plan

Preserve the original baseline and its MT5 report.

Record the exact source version and parameters for each experiment.

Do not optimize multiple variables simultaneously without documenting the experimental design.

Use independent out-of-sample or forward testing when suitable data become available.

## 9. Research Status

| Criterion | Result |
|---|---|
| More than 200 trades | PASS |
| Positive net profit | FAIL |
| Equity drawdown below 20% | PASS |
| Independent validation | PENDING |

**Current status: BASELINE FAIL — RESEARCH IN PROGRESS.**

No profitable configuration has been established by the attached baseline test.
