# Case Study: EA-128_ATR_Low-to-High

## 1. Strategy Classification

EA-128_ATR_Low-to-High is an ATR-based volatility-transition and price-breakout Expert Advisor.

Its methodology combines:

1. A historical ATR baseline
2. A prior-candle ATR threshold
3. A current ATR expansion threshold
4. A completed-candle price breakout
5. Fixed-volume execution and dynamic Stop Loss management

The system does not use an EMA trend filter or an additional momentum indicator.

## 2. Indicator Methodology

### ATR Initialization

The EA creates one ATR indicator handle:

`iATR(_Symbol, _Period, InpATRPeriod)`

Default period:

`InpATRPeriod = 14`

ATR uses the chart timeframe.

The handle is initialized in `OnInit()` and released in `OnDeinit()`.

### Indicator Data

The EA reads ATR buffer 0 using `CopyBuffer()`.

The latest signal values are:

`ATRCurrent = ATR[1]`

`ATRPrevious = ATR[2]`

Both refer to completed candles.

## 3. Historical ATR Baseline

The baseline is calculated from ATR shifts beginning at 3.

For lookback length `L`:

`ATRBaseline = sum(ATR[i], i = 3..L+2) / L`

For the default lookback of 30:

`ATRBaseline = mean(ATR[3], ..., ATR[32])`

This calculation excludes both the latest completed ATR and the immediately preceding completed ATR.

## 4. Volatility Transition Rules

The EA requires:

`ATRPrevious < ATRBaseline * LowATRFactor`

AND

`ATRCurrent >= ATRPrevious * ExpansionFactor`

If either condition fails, no entry is submitted.

### Source Defaults

`LowATRFactor = 0.7`

`ExpansionFactor = 1.5`

### Tested Configuration

`LowATRFactor = 1.2`

`ExpansionFactor = 1.05`

The tested thresholds are materially different from the source defaults.

In particular, a low ATR factor above 1 does not enforce ATR below its historical average.

## 5. Historical Range Methodology

The EA calculates the reference range using completed candles starting at shift 2.

For range length `N`:

`RangeHigh = max(High[2], ..., High[N+1])`

`RangeLow = min(Low[2], ..., Low[N+1])`

The latest completed candle at shift 1 is the breakout signal candle.

It is not included in the historical range.

### Buy Condition

`Close[1] > RangeHigh`

### Sell Condition

`Close[1] < RangeLow`

The code uses strict comparisons.

An exact equality with the range high or low does not trigger an order.

## 6. Entry Processing

The EA processes open-position management on every tick.

New entries require:

1. Terminal trading permission.
2. MQL program trading permission.
3. Account trading permission.
4. A newly detected chart candle.
5. No existing position with the same symbol and Magic Number.
6. Spread within the configured limit.
7. ATR lookback of at least two.
8. Range length of at least two.
9. Successful ATR data retrieval.
10. A positive historical ATR baseline.
11. A qualifying volatility transition.
12. A qualifying price breakout.

The EA uses `CTrade` to submit market orders.

## 7. Order Execution

The EA:

- Sets the configured Magic Number.
- Sets permitted deviation in points.
- Selects the symbol-supported filling type.
- Normalizes volume to broker constraints.
- Calculates initial Stop Loss and Take Profit.
- Applies the broker's minimum stop-distance requirement to initial protective levels.

The initial Stop Loss and Take Profit are expressed in symbol points, not necessarily whole units of the quoted price.

## 8. Position Management

| Parameter | Source Default |
|---|---:|
| Lot Size | 0.01 |
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
| Magic Number | 128123 |

Break Even attempts to move Stop Loss toward the position entry price after the configured favorable movement.

Trailing Stop attempts to move Stop Loss according to the current market price and configured trailing distance.

The implementation checks that a proposed Stop Loss is on the appropriate side of the current Bid or Ask and improves the existing stop.

It does not explicitly check the broker's stop-level and freeze-level restrictions before each position modification.

Rejected modifications may therefore occur.

The EA has no explicit daily loss limit, maximum equity drawdown shutdown, or account-equity-based position sizing.

## 9. Source and Test Configuration Control

### Source Attachment

`EA-128_ATR_Low-to-High(1).mq5`

### Reported Expert

`EA-128_ATR_Low-to-High`

### Tested Parameter Differences

| Parameter | Source Default | Tested |
|---|---:|---:|
| Maximum Spread | 30 | 35 |
| Low ATR Factor | 0.7 | 1.2 |
| Expansion Factor | 1.5 | 1.05 |
| Range Bars | 10 | 3 |

These values must be recorded separately for reproducibility.

The supplied files do not establish whether the test parameters were loaded from a preset, changed manually, or produced through another configuration process.

## 10. Backtest Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Broker Server | ACCMIntl-Real |
| Build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## 11. Performance Evaluation

| Metric | Result |
|---|---:|
| Total Net Profit | -$993.34 |
| Gross Profit | $3,061.05 |
| Gross Loss | -$4,054.39 |
| Profit Factor | 0.75 |
| Expected Payoff | -$0.33 |
| Recovery Factor | -0.93 |
| Equity Drawdown Relative | 99.38% |
| Total Trades | 2,987 |
| Winning Trades | 1,321 |
| Win Rate | 44.22% |
| Average Holding Time | 00:03:00 |

The results indicate negative expectancy and severe drawdown for the tested configuration.

The trade count is sufficient to demonstrate that the observed losses were not confined to only a handful of trades.

However, trade count alone does not establish statistical robustness across other market periods or configurations.

## 12. Methodological Limitations

### Parameter Mismatch

The supplied backtest does not represent the untouched source defaults.

The difference must be preserved in all subsequent performance comparisons.

### No Independent Validation

The supplied materials do not include out-of-sample or live results for EA-128.

### No Component Isolation

The results do not separately measure the contribution of:

- Prior ATR threshold
- ATR expansion threshold
- Historical breakout range
- Break Even
- Trailing Stop

### Execution Risk

The average holding time was three minutes.

The supplied summary does not quantify performance sensitivity to execution costs or broker-specific trading conditions.

### Capital Protection

The EA does not contain an account-level equity drawdown stop.

Its protective mechanisms operate primarily at the individual position level.

## 13. Validation Methodology

Recommended research sequence:

1. Preserve the original source and HTML report.
2. Record the exact tested input values.
3. Reproduce the reported test where possible.
4. Run a separate baseline using the source defaults.
5. Compare volatility-threshold configurations.
6. Compare breakout-range lengths.
7. Isolate exit-management components.
8. Analyze Buy and Sell performance independently.
9. Test transaction-cost sensitivity.
10. Conduct out-of-sample and walk-forward validation.
11. Apply predefined drawdown and profitability acceptance criteria.
12. Consider forward testing only after acceptable independent validation.

Do not select parameters solely by maximizing in-sample net profit.

## 14. Final Methodological Classification

**FAILED BACKTEST — NOT APPROVED FOR DEPLOYMENT**

The reported test lost $993.34 from a $1,000 initial deposit and recorded 99.38% relative equity drawdown.

The tested configuration does not satisfy basic profitability or capital-preservation requirements.

The source-default configuration requires separate testing before its performance can be assessed.

## 15. Source References

- MQL5 source: `EA-128_ATR_Low-to-High(1).mq5`
- MT5 report: `ReportTester-952747(20261027-070818).html`

## Disclaimer

This case study documents a historical strategy experiment and its methodology.

It does not constitute investment advice or a guarantee of future results.
