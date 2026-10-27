# EA-128_ATR_Low-to-High — Research

## Research Objective

Investigate whether a transition from relatively low volatility to expanding volatility, confirmed by a historical price-range breakout, can produce positive trading expectancy on XAUUSD M1.

## Research Hypothesis

Periods of compressed volatility may precede directional price expansion.

The strategy attempts to identify these transitions through ATR measurements and then uses a completed-candle breakout to select trade direction.

The proposed hypothesis is:

A sufficiently strong ATR expansion following relatively low ATR, combined with a price breakout, may identify profitable short-term directional opportunities.

This hypothesis is not established by the supplied backtest.

## 1. Signal Construction

### ATR Baseline

The EA uses ATR with a period of 14.

For a lookback of 30:

`AverageATR = mean(ATR[3], ..., ATR[32])`

### Prior Low-ATR Condition

`ATR[2] < AverageATR * LowATRFactor`

### Current Expansion Condition

`ATR[1] >= ATR[2] * ExpansionFactor`

### Breakout Confirmation

For `RangeBars = N`:

`RangeHigh = max(High[2], ..., High[N+1])`

`RangeLow = min(Low[2], ..., Low[N+1])`

Buy:

`Close[1] > RangeHigh`

Sell:

`Close[1] < RangeLow`

The signal candle is excluded from the reference range.

## 2. Source Defaults Versus Tested Configuration

| Parameter | Source Default | Tested |
|---|---:|---:|
| ATR Period | 14 | 14 |
| ATR Lookback | 30 | 30 |
| Low ATR Factor | 0.7 | 1.2 |
| Expansion Factor | 1.5 | 1.05 |
| Range Bars | 10 | 3 |
| Maximum Spread | 30 | 35 |

This discrepancy is a central research consideration.

The source-default configuration requires ATR at shift 2 to be below 70% of its historical baseline and ATR at shift 1 to be at least 150% of the preceding ATR.

The tested configuration instead requires ATR at shift 2 to be below 120% of its historical baseline and ATR at shift 1 to be at least 105% of the preceding ATR.

Therefore, the tested configuration does not necessarily require an unusually low prior ATR or a large ATR expansion.

The tested breakout range is also shorter.

The two configurations should be treated as separate experiments.

## 3. Supplied Backtest Results

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Total Trades | 2,987 |
| Winning Trades | 1,321 |
| Win Rate | 44.22% |
| Net Profit | -$993.34 |
| Profit Factor | 0.75 |
| Expected Payoff | -$0.33 |
| Recovery Factor | -0.93 |
| Equity Drawdown Relative | 99.38% |
| Average Holding Time | 00:03:00 |

## 4. Research Findings

### Finding 1 — Negative Trading Expectancy

The strategy generated a net loss of $993.34.

Profit Factor was below 1, and Expected Payoff was negative.

The tested configuration did not demonstrate a profitable trading edge.

### Finding 2 — Severe Capital Drawdown

Maximum relative equity drawdown reached 99.38%.

The observed risk is unacceptable for a capital-preservation-oriented strategy.

### Finding 3 — High Trade Count Did Not Establish Reliability

The test recorded 2,987 trades.

This is a substantial number of trades for examining the tested configuration, but the observed outcomes were unfavorable.

More trades do not compensate for negative expectancy.

### Finding 4 — Both Directions Had Similar Win Rates

The report recorded:

- Long trades: 1,360, with 44.26% winning
- Short trades: 1,627, with 44.19% winning

Both directions exhibited similar winning percentages.

The supplied summary does not provide separate directional net profit or Profit Factor.

### Finding 5 — The Tested ATR Definition Was Permissive

The tested `LowATRFactor = 1.2` permits prior ATR values up to, but not including, 120% of the baseline.

This differs materially from a strict below-average volatility condition.

The tested `ExpansionFactor = 1.05` also permits relatively small ATR increases.

These are verified parameter effects, not demonstrated causes of the observed losses.

### Finding 6 — Exit Behavior Requires Isolation

Break Even and Trailing Stop were both enabled.

The average holding time was three minutes.

The report does not isolate how these management rules affected expectancy, winning-trade size, or losing-trade size.

## 5. Research Limitations

- The supplied evidence contains one reported backtest configuration.
- The tested inputs differ from the supplied source defaults.
- No source-default backtest is provided.
- No independent out-of-sample results are supplied.
- No EA-128 live results are supplied.
- No controlled parameter sensitivity results are supplied.
- No separate long/short profitability breakdown is supplied.
- No entry-signal ablation study is supplied.
- No controlled exit-management comparison is supplied.
- No spread or slippage sensitivity study is supplied.
- No walk-forward validation is supplied.

## 6. Proposed Research Experiments

### Experiment A — Reproduce the Source Defaults

Run the exact supplied source defaults:

- Low ATR Factor: 0.7
- Expansion Factor: 1.5
- Range Bars: 10
- Maximum Spread: 30

Use the same symbol, timeframe, test dates, and modeling settings where possible.

Compare results against the supplied test.

### Experiment B — Low ATR Threshold

Evaluate thresholds such as:

- 0.6
- 0.7
- 0.8
- 1.0
- 1.2

Record signal count, Profit Factor, drawdown, and out-of-sample results.

### Experiment C — Expansion Strength

Evaluate expansion factors such as:

- 1.05
- 1.2
- 1.5
- 2.0

Determine whether stronger ATR expansion improves signal quality or merely reduces trade frequency.

### Experiment D — Breakout Range

Compare historical range lengths of:

- 3 candles
- 5 candles
- 10 candles
- 20 candles

Evaluate the trade-off between signal frequency and breakout confirmation.

### Experiment E — Entry Components

Test controlled variants:

1. ATR conditions and breakout combined
2. Breakout condition without ATR filtering
3. ATR conditions with an alternative directional trigger

Source-code modifications would be required for the alternative variants.

### Experiment F — Exit Management

Compare:

- Initial SL/TP only
- Break Even only
- Trailing Stop only
- Break Even and Trailing Stop together

### Experiment G — Robustness

Evaluate:

- Out-of-sample performance
- Walk-forward performance
- Spread and slippage sensitivity
- Session-specific performance
- Long/short profitability
- Performance across different volatility environments

These experiments are proposals, not verified improvements.

## 7. Research Decision

**FAILED BACKTEST — RESEARCH ONLY**

The tested configuration produced negative expectancy and near-total equity drawdown.

The evidence does not validate the low-to-high ATR transition hypothesis.

The exact source-default configuration remains untested in the supplied materials.

Further work should first establish reproducible baseline results and then isolate the effects of the ATR and breakout parameters.

## 8. Research References

- `EAs/EA-128_ATR_Low-to-High/EA-128_ATR_Low-to-High.mq5`
- `EAs/EA-128_ATR_Low-to-High/README.md`
- `Backtest/EA-128_ATR_Low-to-High/README.md`
- `Backtest/EA-128_ATR_Low-to-High/ReportTester-952747(20261027-070818).html`
