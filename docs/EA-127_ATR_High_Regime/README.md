# Case Study: EA-127_ATR_High_Regime

## 1. Strategy Classification

EA-127_ATR_High_Regime is a volatility-regime-filtered, EMA-directional trading strategy.

The system uses ATR to classify high-volatility conditions and EMA 20/50 to select Buy or Sell direction.

The EA does not require a new EMA crossover.

## 2. Indicator Methodology

### ATR

The ATR indicator is initialized with:

`iATR(_Symbol, PERIOD_M1, InpATRPeriod)`

Default ATR period:

`InpATRPeriod = 14`

The ATR timeframe is fixed at M1, regardless of the chart timeframe.

### EMA

The EMA indicators are initialized using the chart timeframe:

`iMA(_Symbol, _Period, InpFastEMA, 0, MODE_EMA, PRICE_CLOSE)`

`iMA(_Symbol, _Period, InpSlowEMA, 0, MODE_EMA, PRICE_CLOSE)`

Default periods:

- Fast EMA: 20
- Slow EMA: 50

In the supplied M1 backtest, ATR and EMA calculations use the same timeframe.

## 3. Volatility Regime Methodology

Read the latest completed ATR:

`ATRCurrent = ATR[1]`

Calculate the historical ATR baseline:

`ATRBaseline = sum(ATR[i], i = 2..51) / 50`

Apply the high-volatility condition:

`ATRCurrent >= ATRBaseline * 1.3`

If the condition is false, the EA does not submit a new entry.

The baseline excludes the most recent completed ATR observation.

## 4. Directional Signal Methodology

### Buy

`ATRCurrent >= ATRBaseline * 1.3`

AND

`EMA20[1] > EMA50[1]`

### Sell

`ATRCurrent >= ATRBaseline * 1.3`

AND

`EMA20[1] < EMA50[1]`

Both EMA values are obtained from completed candles.

No additional price-action confirmation is required.

## 5. Entry and Execution Controls

The EA processes open-position management on every tick.

New-entry evaluation requires:

1. Trading permissions from the terminal, MQL program, and account.
2. A new chart candle.
3. No existing position matching the symbol and Magic Number.
4. Spread not exceeding the configured limit.
5. ATR lookback of at least two.
6. Valid indicator readings for all required shifts.
7. A qualifying ATR regime.
8. A non-equal EMA directional relationship.

Orders are submitted through `CTrade`.

The EA normalizes position volume against broker minimum, maximum, and step requirements.

Initial Stop Loss and Take Profit distances are adjusted to respect the broker's minimum stop level.

## 6. Position Management

| Parameter | Default |
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
| Magic Number | 127123 |

Break Even and Trailing Stop modifications are applied only when their respective profit thresholds are reached.

The code attempts to move Stop Loss in a favorable direction rather than deliberately widening it.

The code does not explicitly validate broker stop-level and freeze-level constraints before each Stop Loss modification. Such modifications may be rejected by the trade server.

The EA does not include an equity drawdown circuit breaker, daily loss limit, or percentage-risk position sizing.

## 7. Backtest Environment

| Setting | Value |
|---|---|
| Expert | EA-127_ATR_High_Regime |
| Platform | MetaTrader 5 |
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Currency | USD |
| Leverage | 1:500 |
| Data Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## 8. Performance Assessment

| Metric | Result |
|---|---:|
| Net Profit | -$904.38 |
| Gross Profit | $7,716.78 |
| Gross Loss | -$8,621.16 |
| Profit Factor | 0.90 |
| Expected Payoff | -$0.14 |
| Recovery Factor | -0.98 |
| Equity Drawdown Maximal | $925.14 |
| Equity Drawdown Relative | 92.25% |
| Total Trades | 6,698 |
| Win Rate | 46.16% |
| Average Holding Time | 00:01:16 |

The reported Profit Factor below 1 indicates that the strategy generated insufficient gross profit to offset gross losses.

The negative Expected Payoff indicates an unfavorable average trade result.

The 92.25% relative equity drawdown represents severe capital risk.

## 9. Methodological Limitations

### Persistent Regime Entries

The ATR regime filter is a state condition rather than an event trigger.

As long as the regime remains active and the EMA relationship persists, the EA may re-enter after the previous position closes.

This behavior should be evaluated separately from the regime-detection hypothesis.

### Fixed ATR Timeframe

ATR is calculated on M1, while EMAs follow the chart timeframe.

The indicators therefore use different timeframes if the EA is attached to a non-M1 chart.

### Execution Sensitivity

The strategy's short average holding time makes execution assumptions important.

The supplied report does not isolate the effects of spread, slippage, Break Even, or Trailing Stop.

### Lack of Independent Validation

The supplied evidence consists of one backtest configuration.

No out-of-sample or forward-test validation is provided.

## 10. Required Validation Steps

Before reconsidering the strategy:

1. Establish baseline results with unchanged parameters.
2. Test ATR threshold sensitivity.
3. Test ATR lookback sensitivity.
4. Test EMA parameter sensitivity.
5. Compare persistent entries against regime-transition entries.
6. Evaluate long and short performance independently.
7. Isolate Break Even and Trailing Stop effects.
8. Evaluate execution-cost sensitivity.
9. Perform out-of-sample and walk-forward validation.
10. Conduct forward testing with documented risk limits.

Parameter selection must not rely solely on maximizing in-sample Profit Factor or net profit.

## 11. Final Research Classification

**FAILED BACKTEST**

The available evidence does not support live deployment or capital scaling.

EA-127_ATR_High_Regime should be retained as a reproducible research case documenting the performance of an ATR high-volatility regime filter combined with EMA directional selection.

## 12. Source References

- MQL5 source: `EA-127_ATR_High_Regime.mq5`
- Strategy Tester report: `ReportTester-952747(20261027-070125).html`

## Disclaimer

This methodology documents a historical trading-system experiment.

It is not investment advice, and historical results do not guarantee future performance.
