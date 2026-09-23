# EA-075 — Session Transition Break Research

## Research Objective

Investigate whether intraday session-range breakouts in XAUUSD can produce a repeatable trading advantage after transaction costs and realistic execution constraints.

The current implementation uses a completed intraday range and trades confirmed breaks of its high or low during a subsequent entry window.

## Working Hypothesis

The transition from a defined intraday range into a more active trading window may create directional price movements suitable for breakout trading.

This is a research hypothesis, not an established property of the supplied test.

## Baseline Experiment

Instrument: XAUUSD.PRO
Timeframe: M1
Test period: January–March 2026
Range: 00:00–08:00 server time
Entry window: 08:00–10:00 server time
Initial deposit: $1,000
Fixed lot: 0.01

The strategy was tested with fixed SL/TP, break-even and trailing-stop management.

## Observed Results

- 54 completed trades
- Net profit: -$9.67
- Profit factor: 0.86
- Win rate: 40.74%
- Maximum equity drawdown: 4.04%
- Average position duration: 2 minutes 26 seconds

The tested configuration did not demonstrate a positive net trading advantage.

## Research Questions

### 1. Breakout Quality

Does requiring stronger breakout confirmation reduce false entries?

Investigate breakout buffers and alternative candle-close confirmation conditions.

### 2. Trading Window

How sensitive is performance to the range start, range end and trade cutoff?

All time comparisons must use consistent broker-server timestamps.

### 3. Repeated Entries

The original order history includes multiple entries on individual trading days.

Investigate whether limiting entries per day or requiring a fresh breakout setup after an exit changes the distribution of results.

### 4. Exit Management

Investigate the contribution of:
- Fixed Stop Loss and Take Profit.
- Break-even activation.
- Trailing-stop activation and distance.

Compare exit configurations without changing unrelated strategy parameters in the same experiment.

### 5. Execution Sensitivity

Evaluate spread, slippage, broker stop restrictions and execution assumptions.

Short holding periods may make execution costs materially important.

## Proposed Experimental Sequence

1. Reproduce the original backtest using the archived source and inputs.
2. Establish a baseline with unchanged parameters.
3. Test breakout confirmation variants.
4. Test session-window variants.
5. Test entry-frequency controls.
6. Compare exit-management variants.
7. Select candidates using predefined evaluation criteria.
8. Validate selected candidates on previously unused historical data.
9. Conduct forward testing before considering live deployment.

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
