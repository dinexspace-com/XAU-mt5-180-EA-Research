# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This repository documents the development, testing and evaluation of experimental XAUUSD Expert Advisors using MetaTrader 5.

Each EA has a dedicated source-code directory and backtest evidence.

Research findings and methodological decisions are documented separately.

## 2. Research Workflow

### Step 1 — Define the Strategy

Specify:

- Trading instrument.
- Reference levels.
- Signal timeframe.
- Entry conditions.
- Exit conditions.
- Position sizing.
- Risk-management parameters.

For EA-078, the reference levels are the previous completed week's high and low.

### Step 2 — Implement the EA

Develop the strategy in MQL5.

Preserve the source version used for each test.

Verify signal timing, weekly reference data, order restrictions and protective-order handling.

### Step 3 — Run the Baseline

Use MetaTrader 5 Strategy Tester.

Record:

- Broker and symbol.
- Test period.
- Tester and signal timeframes.
- Initial capital and leverage.
- Modeling quality.
- Complete input configuration.
- Original HTML report and charts.

### Step 4 — Evaluate Results

Measure:

- Total trades.
- Net profit.
- Profit factor.
- Expected payoff.
- Win rate.
- Average winning and losing trades.
- Maximum balance and equity drawdown.
- Consecutive losses.
- Holding time.
- MFE and MAE.

### Step 5 — Analyze Trade Behavior

Review the balance curve and trade distributions.

Investigate the contribution of trading sessions, direction, re-entry frequency and position-management rules.

Treat explanations as hypotheses until supported by controlled experiments.

### Step 6 — Controlled Experiments

Preserve the baseline configuration.

Change one primary factor at a time when isolating the effect of a strategy component.

Document the exact source version, changed inputs and test results.

### Step 7 — Independent Validation

Use out-of-sample or forward testing when suitable data are available.

Assess sensitivity to broker spread, slippage and execution conditions.

Do not present in-sample optimization as independent validation.

## 3. Current Research Criteria

| Metric | Requirement |
|---|---|
| Total Trades | More than 200 |
| Net Profit | Greater than $0 |
| Maximum Equity Drawdown | Below 20% |

A configuration must meet all three thresholds to qualify for further validation.

Passing these thresholds does not prove future profitability.

## 4. EA-078 Baseline Assessment

| Metric | Requirement | Actual | Result |
|---|---|---:|---|
| Trades | >200 | 263 | PASS |
| Net Profit | >$0 | -$22.97 | FAIL |
| Maximum Equity DD | <20% | 5.05% | PASS |

Overall baseline: FAIL.

## 5. Evidence Management

Keep the original MQL5 source, MT5 HTML report and exported charts.

Maintain a separate directory for each EA.

Do not overwrite baseline evidence with optimized test results.

Use descriptive version identifiers for subsequent experiments.

## 6. Approval Rules

A research configuration is not considered validated without:

1. Complete source and test artifacts.
2. Completed performance checks.
3. Supporting evidence.
4. Independent validation where required.
5. Explicit human review and approval.

## 7. Limitations

Historical backtests depend on market data, broker specifications, modeling assumptions and the selected test period.

EA-078 has currently been evaluated using the attached January–March 2026 baseline.

No conclusion about full-year performance or live profitability can be established from this test alone.
