# EA-130_ATR_Contraction_Reversal — Research

## Research Objective

Investigate whether low-volatility conditions, combined with candlestick rejection near historical price-range boundaries, can generate positive expectancy on XAUUSD M1.

## 1. Research Hypothesis

Periods of relatively low volatility may produce price behavior suitable for short-term range reversals.

A candle displaying a long rejection wick near a historical range boundary may indicate a failed attempt to move further in that direction.

The strategy hypothesis is:

**ATR contraction combined with range-boundary rejection candles may identify short-term mean-reversion opportunities.**

The supplied backtest provides limited positive evidence but does not establish a robust or independently validated edge.

## 2. Strategy Components

### Component A — ATR Contraction

The EA uses ATR period 14.

It compares the latest completed ATR with the average ATR of the preceding 30 completed candles:

`CurrentATR = ATR[1]`

`AverageATR = mean(ATR[2], ..., ATR[31])`

The filter passes when:

`CurrentATR <= AverageATR * 0.7`

The ATR filter therefore selects periods in which current volatility is relatively low compared with the historical reference.

### Component B — Historical Range

The EA calculates:

`RangeHigh = max(High[2], ..., High[21])`

`RangeLow = min(Low[2], ..., Low[21])`

The default historical range includes 20 candles.

The signal candle at shift 1 is excluded.

### Component C — Boundary Proximity

The Buy signal requires:

`Low[1] <= RangeLow + 0.1 * RangeWidth`

The Sell signal requires:

`High[1] >= RangeHigh - 0.1 * RangeWidth`

These conditions identify interaction with the outer 10% zones of the historical range.

The code does not require the signal candle to remain entirely inside the range.

### Component D — Rejection Wick

Buy entries require:

- Bullish signal candle
- Lower wick at least 1.5 times the measured body

Sell entries require:

- Bearish signal candle
- Upper wick at least 1.5 times the measured body

The strategy uses the completed candle's geometry rather than a separate momentum oscillator.

## 3. Tested Configuration

| Parameter | Value |
|---|---:|
| ATR Period | 14 |
| ATR Lookback | 30 |
| Low ATR Factor | 0.7 |
| Range Bars | 20 |
| Wick-to-Body Ratio | 1.5 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Trailing Stop | Enabled |
| Maximum Spread | 30 points |

The report inputs match the supplied source defaults.

## 4. Research Results

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000 |
| Net Profit | +$16.50 |
| Profit Factor | 1.09 |
| Expected Payoff | +$0.10 |
| Recovery Factor | 0.57 |
| Equity Drawdown Relative | 2.85% |
| Total Trades | 169 |
| Winning Trades | 91 |
| Losing Trades | 78 |
| Win Rate | 53.85% |
| Average Winning Trade | $2.11 |
| Average Losing Trade | -$2.25 |
| Average Holding Time | 00:04:15 |

## 5. Research Findings

### Finding 1 — Positive but Narrow Expectancy

The EA generated $16.50 net profit.

Profit Factor was 1.09 and Expected Payoff was $0.10.

The tested configuration was profitable over the supplied period, but the performance margin was small.

### Finding 2 — Low Observed Drawdown

Relative equity drawdown was 2.85%.

This is a favorable result for the supplied historical period.

However, the observed drawdown must be tested across additional periods before it can be considered a reliable risk characteristic.

### Finding 3 — Win Rate Above 50%

The strategy recorded 91 winning trades and 78 losing trades.

The win rate was 53.85%.

The average loss was slightly larger than the average win.

Consequently, the strategy depended on maintaining a sufficient winning frequency.

### Finding 4 — More Sell Trades Than Buy Trades

The test recorded 124 Sell trades and 45 Buy trades.

Sell trades had a higher win rate.

This suggests directional asymmetry in the tested sample, but does not establish that Sell trades were more profitable.

Separate directional profit statistics are required.

### Finding 5 — Low Trade Frequency

The EA generated 169 trades over the supplied test period.

This is materially fewer than several preceding EA experiments.

The low trade count is consistent with a restrictive combination of ATR contraction, range proximity, candle direction, and wick geometry.

However, the report alone cannot quantify how much each individual filter reduced trade frequency.

### Finding 6 — Limited Performance Margin

Gross profit was $192.03 and gross loss was $175.53.

The difference was only $16.50.

Relatively small changes in trade outcomes or execution costs could therefore materially affect the overall result.

### Finding 7 — Reversal Logic Differs From ATR Expansion Strategies

EA-130 uses a low-ATR filter and rejection candles.

EA-129 uses an ATR expansion condition and breakout closes.

The two strategies test different market hypotheses:

- EA-129: volatility expansion with directional continuation
- EA-130: volatility contraction with potential range reversal

The supplied EA-130 test produced a small positive profit, while the supplied EA-129 test produced a loss.

This observation does not establish that contraction strategies are generally superior to expansion strategies.

## 6. Comparison With EA-129

| Metric | EA-129 | EA-130 |
|---|---:|---:|
| Strategy | ATR expansion breakout | ATR contraction reversal |
| Net Profit | -$653.50 | +$16.50 |
| Profit Factor | 0.70 | 1.09 |
| Equity DD Relative | 66.52% | 2.85% |
| Total Trades | 1,463 | 169 |
| Win Rate | 41.22% | 53.85% |

EA-130 achieved better results on these reported metrics.

However, the comparison involves different entry strategies and trade frequencies.

It is not a controlled experiment isolating the effect of ATR contraction alone.

## 7. Research Limitations

- Only one EA-130 backtest configuration is supplied.
- The test contains 169 trades.
- No independent out-of-sample period is supplied.
- No walk-forward analysis is supplied.
- No EA-130 live results are supplied.
- No ATR-filter ablation study is supplied.
- No rejection-candle-only control is supplied.
- No range-boundary sensitivity study is supplied.
- No exit-management ablation study is supplied.
- No separate Buy and Sell Profit Factors are supplied.
- No transaction-cost stress test is supplied.

## 8. Proposed Research Experiments

### Experiment A — Low ATR Factor

Evaluate factors such as:

- 0.5
- 0.6
- 0.7
- 0.8
- 0.9

Measure changes in trade count, expectancy, Profit Factor, and drawdown.

### Experiment B — ATR Lookback

Compare reference windows such as:

- 20 candles
- 30 candles
- 50 candles
- 100 candles

Determine whether the contraction condition is stable across different averaging periods.

### Experiment C — Range Length

Compare:

- 10 candles
- 20 candles
- 30 candles
- 50 candles

Evaluate how the historical range definition affects entry quality.

### Experiment D — Wick-to-Body Ratio

Compare thresholds such as:

- 1.0
- 1.5
- 2.0
- 2.5

Test whether stronger rejection candles improve expectancy at the cost of fewer trades.

### Experiment E — Boundary Zone Width

The current code uses a fixed 10% boundary zone.

A source-code modification would be required to test alternative zone widths such as 5%, 15%, and 20%.

### Experiment F — Component Ablation

Create controlled variants:

1. Range rejection without ATR contraction
2. ATR contraction with a simpler reversal signal
3. Original combined entry logic

The original source does not expose switches for these entry components, so code changes are required.

### Experiment G — Exit Management

Compare:

1. Fixed Stop Loss and Take Profit only
2. Break Even only
3. Trailing Stop only
4. Break Even and Trailing Stop combined

### Experiment H — Robustness

Evaluate:

- Out-of-sample periods
- Walk-forward testing
- Different market regimes
- Spread and slippage stress
- Buy and Sell profitability separately
- Session-specific performance
- Alternative brokers and symbol specifications

Optimization should be evaluated on independent data rather than selected solely by historical net profit.

## 9. Research Decision

**PROVISIONAL PASS — RESEARCH ONLY**

EA-130 is a candidate for further validation because its supplied backtest produced:

- Positive net profit
- Profit Factor above 1.0
- Positive expected payoff
- Low observed equity drawdown

However, the trading edge is narrow and the sample is limited.

The next research objective is to determine whether the positive expectancy persists under independent data and less favorable execution assumptions.

## 10. Research References

- `EAs/EA-130_ATR_Contraction_Reversal/EA-130_ATR_Contraction_Reversal.mq5`
- `EAs/EA-130_ATR_Contraction_Reversal/README.md`
- `Backtest/EA-130_ATR_Contraction_Reversal/README.md`
- `Backtest/EA-130_ATR_Contraction_Reversal/ReportTester-952747(20261027-071810).html`
