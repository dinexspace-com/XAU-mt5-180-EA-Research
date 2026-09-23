
# EA-076 — Round Number Break Research

## Research Objective

Investigate whether breakouts of predefined round-number price levels in XAUUSD can produce a repeatable trading advantage after realistic transaction costs and execution constraints.

The current implementation trades completed-candle breaks of price levels separated by a configurable interval.

## Working Hypothesis

Round-number price levels may attract trading activity and influence short-term price behavior.

A confirmed breakout of these levels may be followed by sufficient directional movement to support a systematic trading strategy.

This is a research hypothesis, not an established result of the supplied backtest.

## Baseline Experiment

Instrument: XAUUSD.PRO  
Timeframe: M1  
Test period: January–March 2026  
Initial deposit: $1,000  
Fixed lot: 0.01  
Round Number Step: 10.0  
Stop Loss: 300 points  
Take Profit: 600 points  
Break Even: Enabled  
Trailing Stop: Enabled  

## Observed Results

- 10,326 completed trades
- Net profit: -$994.48
- Profit factor: 0.93
- Win rate: 49.01%
- Maximum equity drawdown: 99.47%
- Average position duration: 1 minute 13 seconds

The tested configuration did not demonstrate a positive net trading advantage.

## Research Questions

### 1. Round-Number Interval

How sensitive is strategy performance to the distance between round-number levels?

Investigate alternative round-number intervals and whether performance differs across price regions.

### 2. Breakout Confirmation

Does requiring stronger breakout confirmation reduce false entries?

Investigate breakout buffers and alternative completed-candle confirmation rules.

### 3. Trading Sessions

Does performance differ across Asian, European and US trading hours?

Investigate session-based filters and their effect on trade frequency, execution costs and drawdown.

### 4. Entry Frequency

The baseline generated more than 10,000 trades in three months.

Investigate:
- Maximum entries per day.
- Maximum entries per round-number level.
- Cooldown periods after closing a position.
- Re-entry restrictions following failed breakouts.

### 5. Exit Management

Investigate the contribution of:
- Fixed Stop Loss and Take Profit.
- Break-even activation.
- Trailing-stop activation and distance.
- Alternative risk-reward configurations.

Compare exit configurations without changing unrelated strategy parameters in the same experiment.

### 6. Execution Sensitivity

Evaluate spread, slippage, broker stop restrictions and execution assumptions.

The short average holding period may make execution costs materially important.

## Proposed Experimental Sequence

1. Reproduce the original backtest using the archived source and inputs.
2. Establish a baseline with unchanged parameters.
3. Test round-number interval variants.
4. Test breakout confirmation and buffer variants.
5. Test trading-session filters.
6. Test entry-frequency controls.
7. Compare exit-management variants.
8. Select candidates using predefined evaluation criteria.
9. Validate selected candidates on previously unused historical data.
10. Conduct forward testing before considering live deployment.

## Evaluation Metrics

Record for every experiment:
- Net profit.
- Maximum equity drawdown.
- Profit factor.
- Total trades.
- Win rate.
- Average profit and loss.
- Monthly profitability.
- Execution assumptions.
- In-sample and out-of-sample performance.

Do not select configurations based solely on maximum historical profit.

## Current Limitations

The supplied evidence covers one symbol, one broker environment and one three-month historical period.

There is no independent out-of-sample result, multi-broker comparison or verified forward-test record in the supplied materials.

The available evidence does not establish long-term profitability or robustness.

## Research Status

Baseline source and historical report: Available.  
Baseline reproduction: Pending.  
Parameter research: Pending.  
Out-of-sample validation: Pending.  
Forward testing: Pending.  

The current version remains an experimental EA.
