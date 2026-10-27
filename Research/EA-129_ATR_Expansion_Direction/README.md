# EA-129_ATR_Expansion_Direction — Research

## Research Objective

Evaluate whether an increase in Average True Range (ATR), combined with a directional price breakout, can generate positive expectancy on XAUUSD M1.

## Research Hypothesis

Increasing volatility may accompany directional price movement.

The EA attempts to exploit this behavior by requiring ATR expansion and a completed-candle close outside a historical price range.

The research hypothesis is:

**ATR expansion combined with a directional breakout may identify short-term trading opportunities with positive expectancy.**

The supplied backtest does not validate this hypothesis.

## 1. Signal Construction

### ATR Expansion

The EA uses ATR period 14.

The expansion condition is:

`ATR[1] >= ATR[2] * 1.1`

This compares two completed candles.

### Breakout Reference

With `InpBreakoutBars = 10`:

`RangeHigh = max(High[2], ..., High[11])`

`RangeLow = min(Low[2], ..., Low[11])`

### Buy Signal

`Close[1] > RangeHigh`

### Sell Signal

`Close[1] < RangeLow`

Both ATR expansion and the relevant directional breakout are required.

The strategy does not test whether ATR was previously low relative to a longer historical average.

## 2. Backtest Configuration

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 to 2026-04-01 |
| Initial Capital | $1,000 |
| Lot Size | 0.01 |
| ATR Period | 14 |
| ATR Expansion Factor | 1.1 |
| Breakout Range | 10 candles |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Trailing Stop | Enabled |
| Maximum Spread | 30 points |
| Modeling | 100% real ticks |

The reported inputs match the supplied source-code defaults.

## 3. Research Results

| Metric | Result |
|---|---:|
| Net Profit | -$653.50 |
| Gross Profit | $1,496.66 |
| Gross Loss | -$2,150.16 |
| Profit Factor | 0.70 |
| Expected Payoff | -$0.45 |
| Recovery Factor | -0.98 |
| Equity Drawdown Relative | 66.52% |
| Total Trades | 1,463 |
| Winning Trades | 603 |
| Losing Trades | 860 |
| Win Rate | 41.22% |
| Average Winning Trade | $2.48 |
| Average Losing Trade | -$2.50 |
| Average Holding Time | 00:01:57 |

## 4. Research Findings

### Finding 1 — Negative Expectancy

The strategy generated a net loss of $653.50.

Profit Factor was 0.70 and Expected Payoff was -$0.45.

The tested configuration did not demonstrate a profitable trading edge.

### Finding 2 — Substantial Drawdown

Relative equity drawdown reached 66.52%.

The observed drawdown is incompatible with a conservative capital-preservation objective.

### Finding 3 — Loss Frequency Exceeded Win Frequency

The report recorded:

- 603 winning trades
- 860 losing trades
- Win rate of 41.22%

The average winning and losing trades were similar in absolute value.

With this payoff distribution, the winning frequency was insufficient to produce positive expectancy.

### Finding 4 — Directional Win Rates Were Similar

The report recorded:

- Long trades: 551, with 41.38% winners
- Short trades: 912, with 41.12% winners

The directional win rates were similar.

However, the supplied summary does not separately report long and short net profit or Profit Factor.

Directional profitability cannot be determined from win rate alone.

### Finding 5 — The ATR Filter Measures Expansion, Not Direction

ATR measures volatility magnitude.

The EA obtains direction from the historical breakout, not from ATR itself.

Therefore, the name "ATR Expansion Direction" describes a combined volatility-and-breakout strategy rather than a directional ATR indicator.

### Finding 6 — Very Short Holding Times

Average holding time was 1 minute and 57 seconds.

The results may be sensitive to execution quality and exit management.

The supplied report does not isolate these effects.

## 5. Comparison With EA-128

EA-128_ATR_Low-to-High and EA-129_ATR_Expansion_Direction both combine ATR expansion with price breakouts.

However, their signal conditions differ.

| Feature | EA-128 | EA-129 |
|---|---|---|
| ATR Period | 14 | 14 |
| Historical ATR Baseline | Yes | No |
| Prior ATR Threshold | Yes | No |
| ATR Expansion | Yes | Yes |
| Historical Price Breakout | Yes | Yes |
| Source Default Expansion Factor | 1.5 | 1.1 |
| Source Default Range Bars | 10 | 10 |

### Supplied Backtest Comparison

| Metric | EA-128 | EA-129 |
|---|---:|---:|
| Net Profit | -$993.34 | -$653.50 |
| Profit Factor | 0.75 | 0.70 |
| Equity DD Relative | 99.38% | 66.52% |
| Total Trades | 2,987 | 1,463 |
| Win Rate | 44.22% | 41.22% |

EA-129 produced a smaller absolute net loss and lower relative equity drawdown than the supplied EA-128 test.

However, EA-129 also had a lower Profit Factor and win rate.

The comparison is not a controlled strategy-component experiment because EA-128's tested parameters differed from its source defaults.

Both reported configurations failed.

## 6. Research Limitations

- Only one EA-129 backtest configuration is supplied.
- No independent out-of-sample validation is supplied.
- No EA-129 live trading evidence is supplied.
- No parameter sensitivity analysis is supplied.
- No isolated breakout-only comparison is supplied.
- No isolated ATR-only comparison is supplied.
- No exit-management ablation study is supplied.
- No separate long/short profitability results are supplied.
- No execution-cost stress test is supplied.
- No walk-forward validation is supplied.

## 7. Proposed Research Experiments

### Experiment A — ATR Expansion Sensitivity

Compare ATR expansion factors such as:

- 1.05
- 1.10
- 1.20
- 1.30
- 1.50

Evaluate whether stronger expansion improves signal quality or simply reduces the number of trades.

### Experiment B — Breakout Range Length

Compare:

- 3 candles
- 5 candles
- 10 candles
- 20 candles

Record trade frequency, Profit Factor, expected payoff, and drawdown.

### Experiment C — ATR Filter Contribution

Compare the original strategy with a breakout-only variant.

A source-code change is required to create the breakout-only control.

### Experiment D — Breakout Confirmation

Evaluate additional confirmation criteria, such as:

- Minimum candle body size
- Minimum close distance beyond the range
- Directional candle requirement
- Higher-timeframe trend agreement

These are research proposals, not features present in the supplied EA.

### Experiment E — Exit Management

Test controlled variants:

1. Initial SL/TP only
2. Break Even only
3. Trailing Stop only
4. Break Even and Trailing Stop combined

### Experiment F — Robustness

Evaluate:

- Independent out-of-sample periods
- Walk-forward testing
- Spread and slippage sensitivity
- Session-specific performance
- Long/short performance
- Different market volatility regimes

Avoid choosing parameters solely because they maximize historical net profit.

## 8. Research Decision

**FAILED BACKTEST — RESEARCH ONLY**

The supplied results show negative expectancy and substantial drawdown.

The tested ATR expansion and breakout combination is not validated for live deployment.

Further research should focus on determining whether the entry logic contains a repeatable edge and whether exit-management choices materially affect outcomes.

## 9. Research References

- `EAs/EA-129_ATR_Expansion_Direction/EA-129_ATR_Expansion_Direction.mq5`
- `EAs/EA-129_ATR_Expansion_Direction/README.md`
- `Backtest/EA-129_ATR_Expansion_Direction/README.md`
- `Backtest/EA-129_ATR_Expansion_Direction/ReportTester-952747(20261027-071233).html`
