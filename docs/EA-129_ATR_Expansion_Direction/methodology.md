# Case Study: EA-129_ATR_Expansion_Direction

## 1. Strategy Classification

EA-129_ATR_Expansion_Direction is an ATR-expansion breakout Expert Advisor.

Its methodology combines:

1. ATR expansion measurement
2. Historical high/low breakout detection
3. Completed-candle entry signals
4. Fixed-volume market orders
5. Initial Stop Loss and Take Profit
6. Optional Break Even and Trailing Stop

The strategy uses ATR to measure volatility expansion and the breakout direction to select Buy or Sell entries.

## 2. Indicator Methodology

### ATR Initialization

The EA creates one ATR indicator handle:

`g_atr = iATR(_Symbol, _Period, InpATRPeriod)`

The default ATR period is 14.

The indicator operates on the current chart symbol and timeframe.

### ATR Buffer Reading

The EA reads buffer 0 using `CopyBuffer()`.

The code retrieves one value at a time:

`ATRCurrent = ATR[1]`

`ATRPrevious = ATR[2]`

Both are completed-candle values.

The indicator handle is released in `OnDeinit()`.

## 3. ATR Expansion Methodology

The volatility condition is:

`ATRCurrent >= ATRPrevious * InpATRExpansionFactor`

The EA also requires:

`ATRPrevious > 0`

With the default expansion factor of 1.1:

`ATR[1] >= ATR[2] * 1.1`

This requires the latest completed ATR to be at least 10% higher than the preceding ATR.

The EA does not calculate a historical ATR average.

It does not require a preceding low-volatility regime.

## 4. Historical Breakout Methodology

The EA calculates a reference range using:

`iHigh(_Symbol, _Period, i)`

and

`iLow(_Symbol, _Period, i)`

for:

`i = 2` through `i = InpBreakoutBars + 1`

With the default range length of 10:

`RangeHigh = max(High[2], ..., High[11])`

`RangeLow = min(Low[2], ..., Low[11])`

The latest completed candle is excluded from the reference range.

### Buy Condition

`Close[1] > RangeHigh`

### Sell Condition

`Close[1] < RangeLow`

The code uses strict comparisons.

A close exactly equal to the historical range boundary does not qualify.

## 5. Entry Processing

The `OnTick()` function first calls `ManagePositions()`.

New entries are then subject to:

1. Terminal trading permission.
2. MQL program trading permission.
3. Account trading permission.
4. New-bar detection.
5. No matching open position.
6. Spread filter.
7. Minimum breakout range length of two.
8. Successful ATR buffer reads.
9. Positive preceding ATR.
10. Sufficient ATR expansion.
11. Directional breakout confirmation.

If the Buy condition is met, the EA submits:

`trade.Buy(...)`

If the Sell condition is met, it submits:

`trade.Sell(...)`

The EA uses the order comments:

- `EA-129 BUY`
- `EA-129 SELL`

## 6. Order Execution

The EA uses the MQL5 `CTrade` class.

During initialization, it configures:

- Expert Magic Number
- Maximum permitted deviation
- Symbol-supported filling type

### Volume Handling

The requested lot size is bounded by the symbol's minimum and maximum volume.

The result is rounded down according to the symbol's volume step.

The EA does not calculate volume from account balance, account equity, or percentage risk.

### Initial Stop Loss and Take Profit

For a Buy order:

`SL = Ask - SLDistance`

`TP = Ask + TPDistance`

For a Sell order:

`SL = Bid + SLDistance`

`TP = Bid - TPDistance`

Each distance is the greater of:

- The configured distance in points
- The broker's minimum stop distance

Prices are normalized to the symbol's number of digits.

The nominal configured SL/TP distances are 300 and 600 points.

## 7. Position Management

The EA manages matching positions on every tick.

Positions are identified by symbol and Magic Number.

### Break Even

When enabled, Break Even activates after the configured favorable movement.

Default trigger:

`150 points`

Default offset:

`0 points`

The proposed Stop Loss is placed at the entry price with the configured offset.

The code only attempts a modification when the proposed level improves the current Stop Loss and is on the correct side of the market price.

### Trailing Stop

When enabled, trailing begins after:

`200 points`

The default trailing distance is:

`200 points`

For Buy positions, the trailing Stop Loss is calculated below the current Bid.

For Sell positions, it is calculated above the current Ask.

The code attempts to improve, rather than loosen, the Stop Loss.

### Modification Limitations

The EA does not explicitly recheck the broker's stop-level or freeze-level constraints before every Stop Loss modification.

A broker may reject modifications that violate those restrictions.

The code logs unsuccessful trade-operation results.

## 8. Default Parameters

| Parameter | Default |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 129123 |
| Slippage | 10 points |
| Break Even Enabled | true |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop Enabled | true |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| ATR Period | 14 |
| ATR Expansion Factor | 1.1 |
| Breakout Bars | 10 |

## 9. Source and Test Configuration Verification

### Source File

`EA-129_ATR_Expansion_Direction.mq5`

### Report File

`ReportTester-952747(20261027-071233).html`

### Configuration Result

**MATCHED**

All reported input parameters match the defaults declared in the supplied MQL5 source.

This establishes input-configuration consistency between the provided source and report.

It does not independently prove that the report was generated from an identical compiled binary; no binary hash or build provenance was supplied.

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
| Modeling Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## 11. Performance Evaluation

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
| Average Holding Time | 00:01:57 |

The tested configuration produced negative expectancy.

Its maximum relative equity drawdown was substantial.

The results do not support a conclusion that the strategy is profitable or sufficiently robust for live deployment.

## 12. Methodological Limitations

### Single Backtest Configuration

The supplied report documents one tested configuration.

No controlled parameter comparisons are provided.

### No Independent Validation

No EA-129 out-of-sample, walk-forward, or live results are supplied.

### No Entry Component Isolation

The report does not separately measure the contribution of ATR expansion and historical breakout confirmation.

### No Exit Component Isolation

Break Even and Trailing Stop were both enabled.

The report does not separately quantify their contribution to profitability or drawdown.

### Execution Sensitivity

The average holding time was less than two minutes.

Spread, slippage, and broker execution conditions may materially affect results.

### Account-Level Risk Controls

The EA does not implement:

- Percentage-of-equity position sizing
- Daily loss shutdown
- Maximum equity drawdown shutdown
- Account-level risk budgeting

Its risk-management mechanisms primarily operate at the position level.

## 13. Recommended Validation Workflow

1. Preserve the original MQL5 source and Strategy Tester report.
2. Record the exact input parameters.
3. Reproduce the reported backtest.
4. Verify the indicator values and breakout range on selected historical trades.
5. Test ATR expansion sensitivity.
6. Test breakout range sensitivity.
7. Isolate entry-filter contributions.
8. Isolate Break Even and Trailing Stop effects.
9. Analyze Buy and Sell profitability independently.
10. Test execution-cost sensitivity.
11. Conduct out-of-sample testing.
12. Conduct walk-forward validation.
13. Apply predefined profitability and drawdown acceptance criteria.
14. Consider forward testing only if independent validation is satisfactory.

Any optimization must be evaluated against independent data to reduce overfitting risk.

## 14. Final Methodological Classification

**FAILED BACKTEST — NOT APPROVED FOR DEPLOYMENT**

The supplied test recorded:

- Net loss of $653.50
- Profit Factor of 0.70
- Relative equity drawdown of 66.52%
- 1,463 completed trades

The ATR expansion and breakout methodology did not demonstrate positive expectancy under the tested conditions.

Further research is required before the strategy can be reconsidered.

## 15. References

- `EAs/EA-129_ATR_Expansion_Direction/EA-129_ATR_Expansion_Direction.mq5`
- `EAs/EA-129_ATR_Expansion_Direction/README.md`
- `Backtest/EA-129_ATR_Expansion_Direction/README.md`
- `Backtest/EA-129_ATR_Expansion_Direction/ReportTester-952747(20261027-071233).html`

## Disclaimer

This case study documents historical simulation results and implementation methodology.

It does not constitute investment advice or guarantee future performance.
