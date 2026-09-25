
# Research Methodology

## Purpose

This document defines the research and validation process for the XAUUSD MT5 Expert Advisor project.

The objective is to develop reproducible trading experiments while preserving both successful and unsuccessful results.

## 1. Strategy Definition

Each EA must have:
- A unique identifier.
- A documented trading hypothesis.
- Explicit entry and exit conditions.
- Defined risk-management rules.
- Version-controlled MQL5 source code.

The implementation must be reviewed against its stated trading rules.

## 2. Baseline Backtesting

Before optimization, establish a reproducible baseline using MetaTrader 5 Strategy Tester.

Record:
- Source-code version.
- Symbol and timeframe.
- Broker and account conditions.
- Historical testing period.
- Modeling method and data quality.
- Initial deposit and leverage.
- Complete input parameters.
- Original Strategy Tester report.

Preserve the original HTML report and associated charts.

## 3. Performance Evaluation

Evaluate each experiment using:

- Net profit.
- Profit factor.
- Maximum balance and equity drawdown.
- Expected payoff.
- Trade count.
- Win rate.
- Average winning and losing trades.
- Equity-curve behavior.

No single metric is sufficient to validate a strategy.

## 4. Controlled Optimization

Change one parameter group at a time while holding the remaining parameters constant.

Record the original settings, tested ranges and resulting performance.

Avoid selecting configurations solely on the basis of maximum historical profit.

## 5. Out-of-Sample Validation

Separate the available historical data into development and validation periods.

Do not repeatedly optimize against the validation period.

After selecting a candidate configuration, evaluate it on previously unused data.

## 6. Robustness Testing

Where data and execution conditions permit, examine:
- Alternative historical periods.
- Different market conditions.
- Spread sensitivity.
- Slippage sensitivity.
- Broker differences.
- Parameter sensitivity.

A configuration that works only at one narrow parameter combination requires further investigation.

## 7. Forward Testing

Configurations that pass historical validation may proceed to demo forward testing.

Compare actual demo execution with the assumptions used in historical testing.

Live deployment requires separate risk review and human approval.

## 8. Evidence and Version Control

Every experiment should retain its source version, parameter settings, test report and research conclusion.

Failed tests must not be deleted or presented as successful.

A strategy is not marked as validated until the required artifacts, tests, evidence and authorized review are complete.

## 9. Current Research Case

EA-079 Daily Open Break is the initial documented case under this methodology.

Its supplied January–March 2026 backtest failed, producing a profit factor of 0.78 and a maximum equity drawdown of 31.05%.

Its next stage is baseline reproduction and controlled research, not live deployment.
