# Case Study: EA-124_MACD_Acceleration

## 1. Strategy Classification

EA-124_MACD_Acceleration is a MACD-based momentum strategy developed in MQL5 for MetaTrader 5.

The strategy evaluates MACD histogram zero-line transitions and consecutive directional changes to identify potential bullish or bearish momentum.

It is designed for new-candle signal evaluation with per-tick position management.

## 2. Technical Indicator

### MACD Configuration

| Parameter | Value |
|---|---:|
| Fast EMA | 12 |
| Slow EMA | 26 |
| Signal Period | 9 |
| Applied Price | Close |

The EA obtains MACD Main and Signal values using the MQL5 `iMACD` indicator.

The histogram is calculated from their difference.

### Histogram Values

`H1 = Main[1] - Signal[1]`

`H2 = Main[2] - Signal[2]`

`H3 = Main[3] - Signal[3]`

All three values refer to completed candles.

## 3. Entry Methodology

### Buy Entry

A Buy position may be opened when either of the following is true:

**Positive Zero-Line Transition**

`H1 > 0 && H2 <= 0 && H1 > H2`

**Consecutive Positive Histogram Changes**

`H1 > 0 && H1 > H2 && H2 > H3`

### Sell Entry

A Sell position may be opened when either of the following is true:

**Negative Zero-Line Transition**

`H1 < 0 && H2 >= 0 && H1 < H2`

**Consecutive Negative Histogram Changes**

`H1 < 0 && H1 < H2 && H2 < H3`

### Additional Entry Requirements

- Trading permissions must be enabled.
- A new candle must be detected.
- The spread must not exceed the configured maximum.
- No matching position may already exist for the same symbol and Magic Number.
- Required MACD buffer values must be available and valid.

The EA evaluates its entry conditions in a fixed sequence.

## 4. Position Management

The EA uses fixed lot sizing.

Initial Stop Loss and Take Profit distances are configured in points, subject to the broker's minimum initial stop-distance requirement.

Optional Break Even and Trailing Stop functions modify Stop Loss levels when their respective thresholds are reached.

Position management is evaluated on every tick.

The source code does not implement martingale, grid trading, or equity-percentage-based position sizing.

## 5. Backtest Methodology

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Testing Period | 2026-01-02 to 2026-04-01 |
| Modeling Quality | 100% real ticks |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Fixed Lot | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |

## 6. Performance Evaluation

| Metric | Result |
|---|---:|
| Net Profit | -$992.01 |
| Profit Factor | 0.80 |
| Equity Drawdown Relative | 99.20% |
| Recovery Factor | -1.00 |
| Total Trades | 3,860 |
| Win Rate | 48.06% |
| Expected Payoff | -$0.26 |

The Profit Factor below 1 indicates that gross losses exceeded gross profits.

The negative Expected Payoff indicates unfavorable average trade performance.

The relative equity drawdown of 99.20% demonstrates extreme capital risk under the tested configuration.

## 7. Research Assessment

The initial backtest failed to demonstrate a profitable strategy.

The results do not isolate the effects of zero-line transition signals, acceleration signals, market conditions, transaction costs, or exit-management behavior.

Further controlled experiments are required to determine whether any individual component has predictive value.

## 8. Validation Requirements

Additional research should include:

1. Separate tests for each entry-signal category.
2. MACD parameter sensitivity analysis.
3. Histogram magnitude and acceleration threshold testing.
4. Transaction-cost and spread sensitivity analysis.
5. Break Even and Trailing Stop comparisons.
6. Independent out-of-sample validation.
7. Reproducible reporting of all tested configurations.

## 9. Final Classification

**Research Status: FAILED BACKTEST**

The tested configuration does not meet basic profitability or capital-preservation expectations.

The original results should be preserved for research transparency.

## 10. Disclaimer

This case study is provided for research and educational purposes.

Historical backtest results do not guarantee future performance. Automated trading involves substantial financial risk.
