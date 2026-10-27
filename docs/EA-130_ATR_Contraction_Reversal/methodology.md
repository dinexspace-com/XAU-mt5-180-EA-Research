# Case Study: EA-130_ATR_Contraction_Reversal

## 1. Strategy Classification

EA-130_ATR_Contraction_Reversal is a low-volatility range-reversal Expert Advisor.

Its methodology combines:

1. ATR contraction relative to a historical reference
2. Historical range construction
3. Price interaction with range boundaries
4. Candlestick rejection analysis
5. Fixed-volume market execution
6. Stop Loss and Take Profit
7. Break Even and Trailing Stop

The strategy seeks reversal opportunities rather than directional breakouts.

## 2. ATR Indicator Methodology

The EA initializes an ATR handle using:

`g_atr = iATR(_Symbol, _Period, InpATRPeriod)`

The default period is 14.

The indicator uses the current chart symbol and timeframe.

ATR values are read from indicator buffer 0 through `CopyBuffer()`.

The helper function verifies that one value was copied and that the returned value is numerically valid.

The ATR handle is released during `OnDeinit()`.

## 3. ATR Contraction Calculation

The latest completed candle's ATR is read at shift 1:

`CurrentATR = ATR[1]`

The historical reference average is calculated using shifts 2 through 31:

`AverageATR = sum(ATR[2] ... ATR[31]) / 30`

The entry filter passes when:

`AverageATR > 0`

and:

`CurrentATR <= AverageATR * 0.7`

The code rejects the signal when current ATR exceeds the threshold.

Equality with the threshold is permitted.

The strategy does not require ATR to have decreased for several consecutive candles.

It also does not require a subsequent ATR expansion before entering.

## 4. Historical Range Construction

The EA calculates historical extremes using:

`iHigh(_Symbol, _Period, i)`

and:

`iLow(_Symbol, _Period, i)`

The loop runs from:

`i = 2`

through:

`i = InpRangeBars + 1`

With the default `InpRangeBars = 20`:

`RangeHigh = max(High[2], ..., High[21])`

`RangeLow = min(Low[2], ..., Low[21])`

The signal candle at shift 1 is excluded.

The range width is:

`RangeWidth = RangeHigh - RangeLow`

## 5. Signal Candle Geometry

The EA reads the completed signal candle:

- `Open[1]`
- `Close[1]`
- `High[1]`
- `Low[1]`

It calculates:

`Body = max(abs(Close[1] - Open[1]), _Point)`

`LowerWick = min(Open[1], Close[1]) - Low[1]`

`UpperWick = High[1] - max(Open[1], Close[1])`

The default wick-to-body threshold is:

`InpWickBodyRatio = 1.5`

A wick qualifies when its length is greater than or equal to 1.5 times the measured body.

## 6. Buy Signal Methodology

The Buy condition is:

`Low[1] <= RangeLow + RangeWidth * 0.1`

and:

`Close[1] > Open[1]`

and:

`LowerWick >= Body * InpWickBodyRatio`

The ATR contraction condition must also pass.

The signal represents a bullish rejection candle interacting with the lower historical range zone.

The EA does not require:

- A bullish engulfing pattern
- A higher-timeframe uptrend
- An RSI oversold condition
- A subsequent confirmation candle
- A close above the historical range midpoint

These conditions are not implemented in the supplied source.

## 7. Sell Signal Methodology

The Sell condition is:

`High[1] >= RangeHigh - RangeWidth * 0.1`

and:

`Close[1] < Open[1]`

and:

`UpperWick >= Body * InpWickBodyRatio`

The ATR contraction condition must also pass.

The signal represents a bearish rejection candle interacting with the upper historical range zone.

The EA does not require a separate trend filter or momentum indicator.

## 8. Event Processing

### Initialization

During `OnInit()`, the EA:

1. Sets the Magic Number.
2. Sets permitted order deviation.
3. Selects the symbol-supported filling mode.
4. Creates the ATR indicator handle.
5. Returns initialization failure if the ATR handle is invalid.

### Tick Processing

Each `OnTick()` call first invokes:

`ManagePositions()`

The EA then checks trading permissions.

New entries are processed only after a new chart bar is detected.

### Entry Restrictions

The code requires:

- A newly detected chart bar
- No matching open position
- Spread within the configured limit
- `InpATRLookback >= 2`
- `InpRangeBars >= 3`
- Valid ATR data
- Positive ATR reference average
- Qualifying ATR contraction
- Qualifying candle rejection

The new-bar timestamp is updated when a new bar is detected.

If the spread or other entry conditions fail at that point, the EA does not retry the same bar's entry on later ticks.

## 9. Position Identification

The EA identifies its positions using:

- Current symbol
- Configured Magic Number

The default Magic Number is:

`130123`

The entry logic prevents opening another position while a matching position already exists.

The code does not impose a separate cooldown period after a position closes.

## 10. Order Execution

The EA uses `CTrade`.

### Lot Normalization

The requested volume is bounded by:

- `SYMBOL_VOLUME_MIN`
- `SYMBOL_VOLUME_MAX`

It is then rounded down using:

`SYMBOL_VOLUME_STEP`

The EA does not calculate volume based on account equity or a predefined percentage-risk budget.

### Entry Price

For Buy orders, the reference price is the current Ask.

For Sell orders, the reference price is the current Bid.

### Stop Loss and Take Profit

The configured initial distances are:

- Stop Loss: 300 points
- Take Profit: 600 points

The EA uses the greater of the configured distance and the symbol's minimum stop-distance requirement.

For Buy:

`SL = Ask - SLDistance`

`TP = Ask + TPDistance`

For Sell:

`SL = Bid + SLDistance`

`TP = Bid - TPDistance`

Prices are normalized to the symbol's digit precision.

The order comments are:

- `EA-130 BUY`
- `EA-130 SELL`

## 11. Break Even Methodology

Break Even is enabled by default.

The trigger is:

`150 points`

The offset is:

`0 points`

When the favorable movement reaches the trigger, the EA calculates a proposed Stop Loss at the entry price plus or minus the configured offset.

The modification is attempted only when the proposed Stop Loss improves the existing level and lies on the appropriate side of the current market price.

A Stop Loss at the entry price does not guarantee a zero-net-profit trade because actual execution and trading costs may affect the result.

## 12. Trailing Stop Methodology

Trailing Stop is enabled by default.

The default parameters are:

- Trailing Start: 200 points
- Trailing Distance: 200 points

For Buy positions:

`TrailingSL = Bid - TrailingDistance`

For Sell positions:

`TrailingSL = Ask + TrailingDistance`

The proposed trailing level must improve the existing Stop Loss.

Break Even and Trailing Stop are evaluated during the same position-management cycle.

The final proposed Stop Loss is submitted through:

`trade.PositionModify(ticket, newSL, tp)`

## 13. Execution and Risk Limitations

The EA does not explicitly recheck broker stop-level and freeze-level constraints before every Stop Loss modification.

The code logs failed trade operations when the `CTrade` method reports failure.

A successful `CTrade` method return should not be treated as independent proof of completed broker execution without examining the trade result code.

The EA does not implement:

- Percentage-of-equity position sizing
- Daily loss shutdown
- Maximum account-equity drawdown shutdown
- Maximum daily trade count
- Trading-session filter
- News-event filter
- Grid trading
- Martingale

## 14. Default Parameter Reference

| Parameter | Default |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpMagicNumber` | 130123 |
| `InpSlippage` | 10 |
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenOffset` | 0 |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 200 |
| `InpMaxSpread` | 30 |
| `InpATRPeriod` | 14 |
| `InpATRLookback` | 30 |
| `InpLowATRFactor` | 0.7 |
| `InpRangeBars` | 20 |
| `InpWickBodyRatio` | 1.5 |

## 15. Source and Backtest Verification

### Source File

`EA-130_ATR_Contraction_Reversal.mq5`

### Report File

`ReportTester-952747(20261027-071810).html`

### Input Verification

**MATCHED**

All parameters in the Strategy Tester report match the defaults in the supplied source.

This verifies consistency of the documented input configuration.

It does not independently establish compiled-binary identity because no binary hash or compilation provenance was supplied.

## 16. Backtest Environment

| Setting | Value |
|---|---|
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## 17. Performance Evaluation

| Metric | Result |
|---|---:|
| Net Profit | +$16.50 |
| Gross Profit | $192.03 |
| Gross Loss | -$175.53 |
| Profit Factor | 1.09 |
| Expected Payoff | +$0.10 |
| Recovery Factor | 0.57 |
| Equity Drawdown Relative | 2.85% |
| Total Trades | 169 |
| Win Rate | 53.85% |
| Average Holding Time | 00:04:15 |

The supplied backtest generated a small positive net profit and low relative drawdown.

The Profit Factor of 1.09 and Expected Payoff of $0.10 indicate a narrow historical performance margin.

These results are encouraging for further research but insufficient to establish a robust strategy.

## 18. Validation Requirements

Before considering deployment, the methodology should be tested through:

1. Reproduction of the original Strategy Tester run.
2. Manual verification of ATR and rejection signals.
3. ATR threshold sensitivity analysis.
4. Historical range sensitivity analysis.
5. Wick-to-body threshold sensitivity analysis.
6. Entry-filter ablation studies.
7. Break Even and Trailing Stop ablation studies.
8. Buy and Sell profitability analysis.
9. Spread and slippage stress testing.
10. Independent out-of-sample validation.
11. Walk-forward testing.
12. Forward testing with realistic execution conditions.

Acceptance criteria should be defined before conducting optimization.

## 19. Final Methodological Classification

**PROVISIONAL PASS — NOT YET DEPLOYMENT-READY**

EA-130 differs from the preceding ATR expansion strategies by selecting low-volatility conditions and trading candlestick rejection near historical range boundaries.

The supplied test produced:

- Net Profit: +$16.50
- Profit Factor: 1.09
- Equity Drawdown Relative: 2.85%
- Total Trades: 169

The positive result is insufficient to confirm a durable trading advantage.

The EA should remain a research candidate pending independent validation.

## 20. References

- `EAs/EA-130_ATR_Contraction_Reversal/EA-130_ATR_Contraction_Reversal.mq5`
- `EAs/EA-130_ATR_Contraction_Reversal/README.md`
- `Backtest/EA-130_ATR_Contraction_Reversal/README.md`
- `Backtest/EA-130_ATR_Contraction_Reversal/ReportTester-952747(20261027-071810).html`

## Disclaimer

This case study documents historical simulation results and source-code methodology.

It does not constitute investment advice or guarantee future performance.
