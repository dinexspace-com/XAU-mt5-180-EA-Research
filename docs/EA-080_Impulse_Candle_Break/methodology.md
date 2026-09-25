
# EA-080 — Research Documentation

## Strategy Identification

| Field | Value |
|---|---|
| ID | EA-080 |
| Name | Impulse Candle Break |
| Category | Momentum / Breakout |
| Instrument | XAUUSD |
| Timeframe | M1 |
| Platform | MetaTrader 5 |
| Language | MQL5 |
| Status | Experimental |

## Research Methodology

### 1. Baseline

Preserve the original source code, complete input settings, MT5 HTML report and associated charts.

The baseline is the reference for all subsequent experiments.

### 2. Controlled Optimization

Change one parameter group at a time.

Record the hypothesis, original settings, tested values, results and comparison with the unchanged baseline.

Do not discard failed experiments.

### 3. Independent Validation

Separate development and validation periods.

Evaluate selected configurations on previously unused data without repeatedly optimizing against that validation period.

### 4. Robustness Testing

Where sufficient data are available, test:

- Alternative historical periods.
- Different market conditions.
- Spread and slippage sensitivity.
- Parameter sensitivity.
- Broker execution differences.

### 5. Forward Testing

Only configurations that pass historical validation may proceed to demo forward testing.

Compare actual execution with historical assumptions.

Live deployment requires separate human approval.

## EA-080 Baseline

| Metric | Result |
|---|---:|
| Test Period | Jan–Mar 2026 |
| Net Profit | -$774.76 |
| Profit Factor | 0.82 |
| Maximum Equity DD | 79.02% |
| Total Trades | 3,206 |
| Result | FAIL |

## Evidence Requirements

Every experiment must retain its source version, input settings, original report, charts, test results and review record.

A task is not marked as validated without complete artifacts, verification evidence and authorized approval.

## Current Release Status

**NOT VALIDATED**

The baseline failed the profitability and drawdown screening criteria.

Further research is permitted. Live deployment is not approved.
