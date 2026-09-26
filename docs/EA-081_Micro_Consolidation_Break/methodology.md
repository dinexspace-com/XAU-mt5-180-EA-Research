
# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This repository documents the development, backtesting and evaluation of automated trading strategies for XAUUSD using MetaTrader 5.

Each strategy is maintained separately to preserve its source code, test results and research history.

## 2. Research Workflow

The standard workflow consists of:

1. Define the trading hypothesis.
2. Implement the strategy in MQL5.
3. Review and compile the source code.
4. Execute an initial backtest.
5. Archive the original test report.
6. Analyze performance and risk.
7. Conduct controlled experiments.
8. Validate using additional historical data.
9. Perform forward testing when appropriate.

## 3. Backtest Documentation

Every documented backtest should include:

- EA name and source version.
- Trading instrument.
- Timeframe.
- Historical test period.
- Initial capital and leverage.
- Broker and testing environment.
- Modeling method and history quality.
- Complete input parameters.
- Original Strategy Tester HTML report.
- Performance charts.

## 4. Performance Metrics

The following metrics are recorded:

| Metric | Purpose |
|---|---|
| Net Profit | Overall historical result |
| Profit Factor | Gross profit / absolute gross loss |
| Maximum Drawdown | Historical capital decline |
| Win Rate | Percentage of winning trades |
| Expected Payoff | Average result per trade |
| Recovery Factor | Profit relative to drawdown |
| Total Trades | Observed sample size |
| Average Win/Loss | Realized trade distribution |
| Holding Time | Position duration |

No single metric is sufficient to establish strategy robustness.

## 5. Controlled Experiments

Change one parameter group at a time whenever practical.

Keep other conditions constant to isolate the effect of the tested change.

Archive each experiment separately and record both positive and negative results.

## 6. Validation

An initial backtest is treated as preliminary evidence.

Additional validation should include:

- Reproduction of the original test.
- Out-of-sample historical testing.
- Sensitivity analysis.
- Spread and slippage testing.
- Forward testing.

Avoid treating optimized historical performance as evidence of future profitability.

## 7. Repository Organization

EAs/
- MQL5 source code and strategy documentation.

Backtest/
- Original reports, charts and test evidence.

Research/
- Findings, hypotheses and experiment records.

docs/
- Shared research methodology.

## 8. Research Status

BACKTESTED:
A historical test has been completed and its evidence archived.

RESEARCH:
Additional experiments or investigation are in progress.

VALIDATED:
Defined validation criteria have been met and supporting evidence reviewed.

LIVE:
Real-account execution has been independently documented.

A completed backtest does not automatically qualify a strategy as validated or live-ready.
