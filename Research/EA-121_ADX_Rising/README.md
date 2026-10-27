# XAUUSD EA Research

## Research Objective

This repository documents the development, testing, and evaluation of automated trading strategies for XAUUSD using MetaTrader 5 and MQL5.

The research focuses on trading logic, historical performance, risk exposure, and strategy robustness.

## EA-121_ADX_Rising

### Research Hypothesis

An increase in ADX, combined with directional confirmation from +DI and -DI, may provide useful entry signals for short-term XAUUSD trading.

The strategy attempts to identify rising trend strength and enter in the direction indicated by the directional indicators.

### Strategy Design

- Indicator: Average Directional Index (ADX)
- Directional Confirmation: +DI and -DI
- Signal Timing: Closed candles
- Position Sizing: Fixed lot
- Risk Controls: SL, TP, Break Even, Trailing Stop
- Execution Filter: Maximum spread

### Initial Backtest Findings

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Total Trades | 3,840 |
| Profit Factor | 0.80 |
| Net Profit | -$993.01 |
| Equity Drawdown | 99.30% |

### Interpretation

The tested strategy did not demonstrate a positive trading edge during the evaluated period.

Although ADX rising conditions generated frequent trading signals, the resulting trades produced losses greater than profits.

The observed results raise questions about signal quality, trade frequency, execution sensitivity, and exit management.

The supplied backtest does not isolate the individual contribution of these factors.

### Research Limitations

- Only one backtest configuration is provided.
- The evaluated period is approximately three months.
- No independent out-of-sample test is provided.
- No forward-test or live-trading record is provided for this EA.
- Parameter sensitivity has not been established.
- Results from alternative market conditions are not available.

### Future Research

1. Investigate the impact of the minimum ADX threshold.
2. Evaluate sensitivity to spread and execution costs.
3. Compare Break Even and Trailing Stop configurations.
4. Analyze performance across different market conditions.
5. Perform independent out-of-sample testing.

## Research Conclusion

**EA-121_ADX_Rising remains an unsuccessful research configuration based on the supplied backtest.**

The available evidence does not establish a profitable or robust trading strategy.

Further testing is required to determine whether the underlying hypothesis has predictive value.

## Research Principles

- Preserve original test results.
- Report both successful and unsuccessful experiments.
- Avoid unsupported profitability claims.
- Distinguish backtest results from live trading.
- Prioritize reproducibility and risk assessment.
