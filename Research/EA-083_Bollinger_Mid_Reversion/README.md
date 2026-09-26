
# EA-083 — Research

## 1. Research Objective

Investigate why the Bollinger Mid Reversion strategy produced persistent losses despite a win rate above 50%.

Determine whether losses are primarily associated with:

- Entry signal quality.
- Early exits at the middle band.
- Trading frequency.
- Position management.
- Market regime.
- Trading costs.
- Extreme adverse price movements.

These are research hypotheses, not confirmed causes.

## 2. Confirmed Baseline Results

Test period: January–March 2026.

- Initial Capital: $1,000.
- Net Profit: -$991.84.
- Profit Factor: 0.81.
- Maximum Equity Drawdown: 99.20%.
- Total Trades: 4,484.
- Win Rate: 53.93%.
- Average Win: $1.80.
- Average Loss: -$2.59.

Baseline status: FAILED.

## 3. Research Findings

### F01 — Negative Expectancy

The win rate is 53.93%, but the average winning trade is only $1.80.

The average losing trade is -$2.59.

The observed win rate is insufficient to compensate for the larger average loss.

Research question:

Can entry filtering or exit management improve the profit/loss distribution?

### F02 — Middle-Band Exit

The strategy closes positions when price reaches the Bollinger middle band.

This may limit the profit captured from favorable price movements.

Research question:

Does the middle-band exit improve or reduce net expectancy compared with alternative exit rules?

### F03 — Trading Frequency

The baseline generated 4,484 trades over approximately three months.

Frequent trading increases exposure to transaction costs and unfavorable market conditions.

Research question:

Does reducing trading frequency improve net performance?

### F04 — Extreme Loss Events

Largest winning trade: $7.76.

Largest losing trade: -$35.62.

The MFE/MAE chart contains several extreme adverse excursions.

Research question:

Are these losses associated with execution gaps, abnormal volatility or other identifiable conditions?

Inspect transaction records before drawing conclusions.

### F05 — Position Management

The strategy combines:

- Middle-band exit.
- Fixed SL and TP.
- Break Even.
- Trailing Stop.

Average holding time is 2 minutes 3 seconds.

Research question:

Do these exit mechanisms interfere with one another or systematically reduce realized profits?

### F06 — Market Regime

The strategy does not include a dedicated trend or volatility-regime filter.

Research question:

Does strong directional movement produce a disproportionate share of losing trades?

This has not yet been demonstrated.

## 4. Next Experiments

Experiment 01 — Execution Audit

- Identify the largest losing trades.
- Inspect their entry and exit records.
- Compare intended SL with realized loss.
- Check available spread and execution evidence.
- Investigate abnormal holding times.

Experiment 02 — Exit Management

Run separate tests with:

A. Current baseline.
B. Middle-band exit disabled.
C. Break Even disabled.
D. Trailing Stop disabled.
E. Break Even and Trailing Stop disabled.

Keep entry conditions unchanged.

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

An improvement in historical net profit alone does not establish a validated strategy.

## 6. Research Status

Baseline backtest: COMPLETED — FAIL.

Execution audit: PENDING.

Exit-management experiments: PENDING.

Entry-filter experiments: PENDING.

Out-of-sample validation: NOT STARTED.

Forward testing: NOT STARTED.

Live deployment: BLOCKED.
