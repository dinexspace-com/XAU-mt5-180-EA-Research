# Case Study: EA-126_Impulse_Follow-through

## 1. Strategy Classification

EA-126_Impulse_Follow-through is a volatility-normalized impulse and price-continuation strategy implemented in MQL5.

The EA identifies a large candle body relative to ATR and requires the next completed candle to close beyond the impulse candle's directional extreme.

The strategy is evaluated once per new candle, while open-position management operates on every tick.

## 2. Indicator Configuration

| Parameter | Value |
|---|---:|
| Indicator | Average True Range |
| ATR Period | 14 |
| ATR Buffer | 0 |
| ATR Reference | Shift 2 |
| Impulse ATR Multiplier | 1.5 |

## 3. Signal Methodology

### Impulse Candle

The impulse candle is the completed candle at shift 2.

Calculate:

`ImpulseBody = abs(Close[2] - Open[2])`

`ImpulseThreshold = ATR[2] * InpImpulseATRMultiplier`

The impulse qualifies when:

`ImpulseBody >= ImpulseThreshold`

ATR must be available, numerically valid, and greater than zero.

### Buy Signal

A Buy signal requires:

`Close[2] > Open[2]`

AND

`Close[1] > High[2]`

AND

`ImpulseBody >= ImpulseThreshold`

### Sell Signal

A Sell signal requires:

`Close[2] < Open[2]`

AND

`Close[1] < Low[2]`

AND

`ImpulseBody >= ImpulseThreshold`

### Signal Timing

- Shift 2: Impulse candle
- Shift 1: Confirmation candle
- Shift 0: Current candle, when the EA evaluates entry

The strategy does not use an incomplete candle for impulse or follow-through confirmation.

## 4. Execution Methodology

Before evaluating a new entry, the EA requires:

- Terminal trading permission
- MQL program trading permission
- Account trading permission
- Detection of a new candle
- No existing matching symbol/Magic Number position
- Spread within the configured maximum
- Valid positive ATR at shift 2

The EA uses the MQL5 `CTrade` class for market orders.

Position volume is normalized against the symbol's broker-defined minimum, maximum, and volume step.

## 5. Position Management

| Setting | Value |
|---|---:|
| Fixed Lot | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| Slippage | 10 points |
| Magic Number | 126123 |

Initial Stop Loss and Take Profit distances are adjusted to satisfy the broker's minimum initial stop-distance requirement.

Break Even and Trailing Stop logic may modify the Stop Loss after entry.

The source code does not separately check broker stop/freeze-distance restrictions before every position modification; the trade server may reject an invalid modification.

No martingale, grid trading, or percentage-based equity risk model is implemented.

## 6. Backtest Methodology

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| History Quality | 100% real ticks |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Total Bars | 86,539 |
| Total Ticks | 40,346,891 |

## 7. Performance Evaluation

| Metric | Result |
|---|---:|
| Net Profit | -$211.69 |
| Gross Profit | $1,244.11 |
| Gross Loss | -$1,455.80 |
| Profit Factor | 0.85 |
| Expected Payoff | -$0.20 |
| Equity Drawdown Maximal | $255.25 |
| Equity Drawdown Relative | 24.46% |
| Recovery Factor | -0.83 |
| Total Trades | 1,085 |
| Win Rate | 45.71% |
| Average Holding Time | 00:02:37 |

The Profit Factor below 1 indicates that gross losses exceeded gross profits.

Negative Expected Payoff indicates an unfavorable average trade outcome.

The Equity Drawdown Relative of 24.46% indicates material risk to capital.

## 8. Research Assessment

The initial backtest failed to establish positive expectancy.

The impulse-follow-through strategy generated fewer trades and lower drawdown than EA-125 in the supplied reports, but the tested EA-126 configuration remained unprofitable.

No causal conclusion can be drawn about which entry or exit component produced the observed losses without controlled experiments.

## 9. Validation Requirements

Further evaluation should include:

1. ATR period sensitivity analysis.
2. Impulse multiplier sensitivity analysis.
3. Alternative follow-through confirmation rules.
4. Long/short directional performance analysis.
5. Stop Loss and Take Profit sensitivity testing.
6. Break Even and Trailing Stop ablation tests.
7. Spread and execution-cost sensitivity testing.
8. Independent out-of-sample validation.
9. Forward testing with documented execution conditions.
10. Preservation of source code, parameter settings, and original test reports.

## 10. Final Classification

**Research Status: FAILED BACKTEST**

The available evidence does not support live deployment or capital scaling.

EA-126 should remain a documented research experiment pending further validation.

## 11. Disclaimer

This case study is intended for research and educational purposes.

Historical Strategy Tester results do not guarantee future trading performance.
