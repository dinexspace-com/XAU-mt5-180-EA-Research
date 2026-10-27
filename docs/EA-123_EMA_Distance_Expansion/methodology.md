# Case Study: EA-123_EMA_Distance_Expansion

## 1. Strategy Classification

EA-123_EMA_Distance_Expansion is a momentum-continuation strategy developed in MQL5 for MetaTrader 5.

The strategy identifies potential directional momentum by measuring the expansion of the absolute distance between a fast and a slow Exponential Moving Average.

Unlike a conventional EMA crossover strategy, the entry logic does not require the EMAs to cross on the signal candle.

## 2. Technical Indicators

### Fast EMA

The fast EMA uses an 8-period calculation based on closing prices.

Its direction provides additional confirmation of the intended trade direction.

### Slow EMA

The slow EMA uses a 21-period calculation based on closing prices.

Its position relative to the fast EMA determines the directional bias.

### EMA Distance Expansion

The strategy compares the absolute distance between the two EMAs across consecutive completed candles.

The expansion factor determines how much the EMA separation must increase to qualify as a trading signal.

## 3. Entry Methodology

### Distance Calculation

`D1 = abs(FastEMA[1] - SlowEMA[1])`

`D2 = abs(FastEMA[2] - SlowEMA[2])`

A valid expansion requires:

`D2 > 0`

`D1 >= D2 * ExpansionFactor`

The tested Expansion Factor is 1.2.

### Buy Entry

A Buy position may be opened when:

- The EMA distance expansion condition is satisfied.
- Fast EMA is above Slow EMA.
- Fast EMA is rising between the two completed candles.
- Spread is within the configured limit.
- No matching position is already open.
- Trading permissions are enabled.

### Sell Entry

A Sell position may be opened when:

- The EMA distance expansion condition is satisfied.
- Fast EMA is below Slow EMA.
- Fast EMA is falling between the two completed candles.
- Spread is within the configured limit.
- No matching position is already open.
- Trading permissions are enabled.

Entry evaluation occurs once per new candle using completed-candle indicator values.

## 4. Position Management

The EA uses fixed lot sizing and broker-compatible volume normalization.

Initial Stop Loss and Take Profit distances are configured in points and adjusted for the broker's minimum stop level.

The EA supports optional Break Even and Trailing Stop management.

Open positions are managed on every tick.

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
| Fast EMA | 8 |
| Slow EMA | 21 |
| Expansion Factor | 1.2 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Trailing Stop | Enabled |

## 6. Performance Evaluation

| Metric | Result |
|---|---:|
| Net Profit | -$994.33 |
| Profit Factor | 0.88 |
| Equity Drawdown Relative | 99.45% |
| Recovery Factor | -0.96 |
| Total Trades | 6,598 |
| Win Rate | 46.15% |
| Expected Payoff | -$0.15 |

The Profit Factor below 1 indicates that gross losses exceeded gross profits.

The negative Expected Payoff indicates an unfavorable average trade outcome.

The relative equity drawdown of 99.45% demonstrates extreme capital risk under the tested configuration.

## 7. Research Assessment

The initial backtest failed to demonstrate a profitable strategy.

The available evidence does not establish whether the negative results were primarily caused by EMA expansion signal quality, frequent trading, market conditions, execution costs, or position-management behavior.

Controlled experiments are required to distinguish these factors.

## 8. Validation Requirements

Further evaluation should include:

1. Independent out-of-sample testing.
2. Fast and slow EMA parameter sensitivity.
3. Expansion-factor sensitivity analysis.
4. Signal frequency and transaction-cost analysis.
5. Break Even and Trailing Stop configuration comparisons.
6. Forward testing only if subsequent research justifies it.

## 9. Final Classification

**Research Status: FAILED BACKTEST**

The tested configuration does not meet basic profitability or capital-preservation expectations.

The original test results should be preserved for research transparency and reproducibility.

## 10. Disclaimer

This case study is provided for research and educational purposes.

Backtest results do not guarantee future performance. Automated trading involves substantial financial risk.
