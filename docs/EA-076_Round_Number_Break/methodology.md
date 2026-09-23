
# EA-076 — Research Methodology

## 1. Purpose

This document defines the research, testing and validation process for EA-076 Round Number Break.

The purpose is to maintain a reproducible record of strategy development, historical testing and subsequent validation.

## 2. Source of Truth

Every reported result must be traceable to:
- An identifiable EA source-code version.
- A complete input configuration.
- An original MT5 Strategy Tester report.
- The instrument and broker environment.
- The historical test period and execution settings.

Never replace a historical result with an optimized result without preserving the original evidence.

## 3. Strategy Specification

EA-076 is an intraday round-number breakout strategy for MetaTrader 5.

The active implementation calculates relevant upper and lower round-number boundaries from the preceding completed candle's closing price.

A buy signal is generated when the next completed candle closes above the upper boundary plus the configured breakout buffer.

A sell signal is generated when the next completed candle closes below the lower boundary minus the configured breakout buffer.

Signals are evaluated once per new candle.

The default round-number interval is 10.0 price units.

The breakout lookback parameter is retained in the source but is not used by the active round-number signal calculation.

## 4. Baseline Configuration

- Symbol: XAUUSD.PRO
- Timeframe: M1
- Round Number Step: 10.0
- Lot Size: 0.01
- Stop Loss: 300 points
- Take Profit: 600 points
- Breakout Buffer: 0 points
- Break Even: Enabled
- Trailing Stop: Enabled
- Maximum Spread: 30 points

The original source and complete MT5 report contain the authoritative parameter definitions.

## 5. Backtesting

Use MT5 Strategy Tester and preserve the selected tick-model configuration.

For every test, record:
1. Source-code version.
2. Parameter set.
3. Broker and symbol.
4. Date range.
5. Initial deposit and leverage.
6. Tick-model and history quality.
7. Performance metrics.
8. Original HTML report and charts.

The supplied baseline used 100% real ticks over January–March 2026.

## 6. Experiment Control

Modify a defined parameter group for each experiment.

Record the hypothesis, baseline, modified inputs and resulting metrics.

Preserve failed experiments. Do not retrospectively present an optimized configuration as the original baseline.

## 7. Validation

Separate development data from validation data.

A configuration selected using one historical period must be evaluated on previously unused data.

Where practical, investigate:
- Different historical market conditions.
- Different spread and slippage assumptions.
- Different broker environments.
- Sensitivity to small parameter changes.

A positive in-sample result alone is not sufficient for live deployment.

## 8. Acceptance Criteria

Define numerical acceptance thresholds before conducting optimization.

At minimum, evaluate profitability, drawdown, trade count, monthly consistency and out-of-sample performance.

A candidate must not be marked as validated solely because it satisfies one performance metric.

The current baseline is unprofitable and is not approved for live deployment.

## 9. Reproducibility

Preserve original artifacts in their designated directories.

Do not modify historical reports or overwrite the original source without version control.

Any new experiment must reference its corresponding source revision and input configuration.

## 10. Current Status

Historical baseline: Documented.  
Independent reproduction: Pending.  
Optimization: Pending.  
Out-of-sample testing: Pending.  
Forward testing: Pending.  
Live deployment approval: Not granted.  

All future changes and conclusions must be supported by reproducible test evidence.
