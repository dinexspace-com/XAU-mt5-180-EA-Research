
# EA-082 — Research

## 1. Research Objective

Investigate why the Bollinger Re-entry strategy produced persistent losses on XAUUSD M1.

Determine whether the losses are primarily associated with:

- Entry signal quality.
- Trading frequency.
- Market regime.
- Position management.
- Trading costs.
- Extreme adverse price movements.

These are hypotheses requiring controlled experiments.

## 2. Confirmed Baseline Results

Test period: January–March 2026.

- Initial capital: $1,000.
- Net Profit: -$994.17.
- Profit Factor: 0.88.
- Maximum Equity Drawdown: 99.43%.
- Total Trades: 6,504.
- Win Rate: 49.78%.
- Average Win: $2.23.
- Average Loss: -$2.51.

Baseline status: FAILED.

## 3. Research Findings

### F01 — Negative Expectancy

The average winning trade is smaller than the average losing trade.

The observed win rate is insufficient to compensate for this difference.

Research question:
Can entry filtering improve the distribution of winning and losing trades?

### F02 — Excessive Trading Frequency

The baseline generated 6,504 trades over approximately three months.

High trading frequency increases exposure to spreads, slippage and unfavorable market conditions.

Research question:
Does restricting entries to selected market conditions improve net expectancy?

### F03 — Extreme Loss Events

Largest winning trade: $9.25.
Largest losing trade: -$33.31.

The MFE/MAE chart contains several extreme adverse excursions.

Research question:
Are these losses caused by execution gaps, abnormal volatility or other identifiable market conditions?

Inspect the original transaction records before drawing conclusions.

### F04 — Position Management

The baseline uses both Break Even and Trailing Stop.

Average holding time is 2 minutes 24 seconds.

Research question:
Does the current position management exit profitable trades prematurely while leaving the strategy exposed to larger losses?

### F05 — Market Regime

The strategy attempts mean-reversion entries without a dedicated trend or volatility-regime filter.

Research question:
Do strong directional market conditions produce a disproportionate share of losses?

This has not yet been demonstrated.

## 4. Next Experiments

Experiment 01 — Execution Audit

- Identify the largest losing trades.
- Inspect their entry and exit records.
- Compare intended SL with realized loss.
- Check available spread and execution evidence.

Experiment 02 — Position Management

Run separate tests with:

A. Current baseline.
B. Break Even disabled.
C. Trailing Stop disabled.
D. Both disabled.

Keep the entry logic unchanged.

Experiment 03 — Entry Filtering

Only after completing the execution audit:

- Test a trend filter.
- Test a volatility-regime filter.
- Test a trading-session filter.

Change one filter at a time.

## 5. Acceptance Criteria

Each experiment must provide:

- Source version.
- Complete input parameters.
- Original HTML backtest report.
- Performance comparison.
- Maximum drawdown.
- Trade count.
- Explanation of observed differences.

A result is not considered validated solely because its historical net profit improves.

## 6. Research Status

Baseline backtest: COMPLETED — FAIL.

Execution audit: PENDING.

Position-management experiments: PENDING.

Entry-filter experiments: PENDING.

Out-of-sample validation: NOT STARTED.

Forward testing: NOT STARTED.

Live deployment: BLOCKED.
