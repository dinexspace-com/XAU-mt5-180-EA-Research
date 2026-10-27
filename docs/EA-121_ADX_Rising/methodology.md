# Research Methodology

## 1. Purpose

This document describes the methodology used to develop, backtest, and evaluate MQL5 Expert Advisors for XAUUSD.

The objective is to maintain transparent, reproducible, and evidence-based strategy research.

## 2. Strategy Development

Each Expert Advisor is documented according to:

- Trading hypothesis
- Entry conditions
- Exit conditions
- Technical indicators
- Position sizing
- Risk management rules
- Execution constraints

Strategy logic is verified against the corresponding MQL5 source code.

## 3. Backtesting

Historical strategy evaluation is performed using the MetaTrader 5 Strategy Tester.

Each test should document:

- Expert Advisor name and version
- Trading symbol
- Timeframe
- Testing period
- Initial capital
- Leverage
- Modeling quality
- Input parameters
- Broker and execution environment

Original Strategy Tester reports should be retained.

## 4. Performance Metrics

### Net Profit

The net financial result of the tested strategy as reported by MetaTrader 5.

### Profit Factor

Gross Profit divided by the absolute value of Gross Loss.

A Profit Factor above 1 indicates gross profits exceed gross losses in the tested sample.

### Drawdown

The reduction in account balance or equity from a reference level or peak, according to the specific MetaTrader 5 metric.

Equity drawdown is particularly important because it includes floating profit and loss.

### Recovery Factor

A measure relating net profit to maximum drawdown.

### Expected Payoff

The average financial result per trade as reported by the Strategy Tester.

### Win Rate

The percentage of trades closed with a positive result.

Win rate alone is insufficient to determine profitability.

## 5. Risk Assessment

Risk evaluation considers:

- Maximum balance drawdown
- Maximum equity drawdown
- Profit Factor
- Recovery Factor
- Losing trade sequences
- Average profit and loss per trade
- Position sizing method

A strategy with extreme drawdown cannot be considered robust solely because it generates frequent trades or occasional profitable periods.

## 6. Validation Process

The research workflow consists of:

1. Review the Expert Advisor source code.
2. Record the tested input parameters.
3. Conduct historical backtesting.
4. Preserve the original test report.
5. Evaluate profitability and drawdown.
6. Identify limitations and possible weaknesses.
7. Perform additional independent validation where appropriate.
8. Compare forward or live results with historical findings when available.

## 7. Reproducibility

Each published backtest should include sufficient information to reproduce the experiment.

Differences in broker specifications, spread, commission, execution, tick history, and testing configuration may produce different results.

## 8. Reporting Standards

All research results should be documented without selectively omitting unfavorable outcomes.

Backtesting, forward testing, and live trading must be clearly distinguished.

A profitable historical result does not establish future profitability.

## 9. Case Study: EA-121_ADX_Rising

The supplied EA-121_ADX_Rising backtest was performed on XAUUSD.PRO, M1, using 100% real ticks from 2026-01-02 to 2026-04-01.

The test produced:

- Net Profit: -$993.01
- Profit Factor: 0.80
- Equity Drawdown Relative: 99.30%
- Total Trades: 3,840

The results indicate that the tested configuration failed to demonstrate profitability or acceptable capital preservation.

This case is retained as a documented research result.

## 10. Disclaimer

All strategies and testing results are presented for research and educational purposes.

Historical results do not guarantee future performance. Automated trading involves substantial financial risk.
