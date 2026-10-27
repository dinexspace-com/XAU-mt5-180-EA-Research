# EA-130_ATR_Contraction_Reversal

## Overview

EA-130_ATR_Contraction_Reversal is a MetaTrader 5 Expert Advisor written in MQL5.

The strategy combines an Average True Range (ATR) contraction filter with price-range boundary detection and candlestick rejection signals.

Its objective is to identify potential short-term reversals when volatility is relatively low and a completed candle displays a sufficiently long rejection wick near a historical range boundary.

The EA uses fixed lot sizing, initial Stop Loss and Take Profit, optional Break Even, optional Trailing Stop, and a maximum-spread filter.

## Strategy Classification

- Platform: MetaTrader 5
- Language: MQL5
- Strategy family: Low-volatility range reversal
- Volatility indicator: ATR
- Entry confirmation: Candlestick wick-to-body ratio
- Directional context: Historical price-range boundary
- Position sizing: Fixed lot
- Entry frequency: Once per newly detected chart bar
- Position management: Every tick

## ATR Contraction Filter

The ATR indicator is initialized as:

`iATR(_Symbol, _Period, InpATRPeriod)`

With the default parameters:

- ATR period: 14
- ATR lookback: 30
- Low ATR factor: 0.7

The EA reads the latest completed candle's ATR:

`CurrentATR = ATR[1]`

It calculates the reference average using earlier completed candles:

`AverageATR = mean(ATR[2], ..., ATR[31])`

The contraction condition is:

`CurrentATR <= AverageATR * InpLowATRFactor`

At the default factor of 0.7, the latest completed ATR must be no greater than 70% of the historical reference average.

The code requires the reference average to be positive.

This is a low-volatility filter, not a requirement for ATR to be increasing.

## Historical Price Range

The EA calculates the highest high and lowest low of a configurable historical range.

With `InpRangeBars = 20`:

`RangeHigh = max(High[2], ..., High[21])`

`RangeLow = min(Low[2], ..., Low[21])`

The latest completed candle at shift 1 is excluded from the reference range.

The range width is:

`RangeWidth = RangeHigh - RangeLow`

The EA evaluates potential reversal signals within the outer 10% zones of the historical range.

## Candlestick Rejection Measurement

The signal candle is the latest completed candle, shift 1.

The code calculates:

`Body = max(abs(Close[1] - Open[1]), _Point)`

`LowerWick = min(Open[1], Close[1]) - Low[1]`

`UpperWick = High[1] - max(Open[1], Close[1])`

Using the default `InpWickBodyRatio = 1.5`, the qualifying rejection wick must be at least 1.5 times the measured candle body.

The minimum body denominator of one point prevents a zero-body candle from producing a zero threshold.

## Buy Entry Conditions

A Buy order is submitted when all applicable execution filters pass and:

1. ATR contraction is confirmed.
2. The latest completed candle's low reaches the lower boundary zone:

   `Low[1] <= RangeLow + RangeWidth * 0.1`

3. The signal candle is bullish:

   `Close[1] > Open[1]`

4. The lower wick is sufficiently long:

   `LowerWick >= Body * InpWickBodyRatio`

The EA then submits a market Buy order with the comment:

`EA-130 BUY`

The candle does not need to close above the range midpoint.

The low may extend below the historical range boundary.

## Sell Entry Conditions

A Sell order is submitted when all applicable execution filters pass and:

1. ATR contraction is confirmed.
2. The latest completed candle's high reaches the upper boundary zone:

   `High[1] >= RangeHigh - RangeWidth * 0.1`

3. The signal candle is bearish:

   `Close[1] < Open[1]`

4. The upper wick is sufficiently long:

   `UpperWick >= Body * InpWickBodyRatio`

The EA then submits a market Sell order with the comment:

`EA-130 SELL`

The high may extend above the historical range boundary.

## Entry Execution Filters

Before submitting a new order, the EA checks:

- Terminal trading permission
- MQL program trading permission
- Account trading permission
- New-bar detection
- No existing position with the same symbol and Magic Number
- Spread not exceeding the configured maximum
- ATR lookback of at least 2
- Range length of at least 3
- Successful ATR buffer reads
- Positive historical ATR average
- Qualifying low-ATR condition
- Qualifying rejection candle

The EA evaluates new entries once per new chart bar.

Open positions are managed on every tick.

## Position Management

The EA uses the MQL5 `CTrade` class.

### Initial Stop Loss and Take Profit

Default values:

- Stop Loss: 300 points
- Take Profit: 600 points

The EA adjusts the initial distances upward if required by the broker's minimum stop-distance setting.

The nominal Stop Loss-to-Take Profit distance ratio is 1:2.

### Break Even

Break Even is enabled by default.

- Trigger: 150 points of favorable movement
- Offset: 0 points

The EA attempts to move Stop Loss to the entry price once the configured trigger is reached.

### Trailing Stop

Trailing Stop is enabled by default.

- Start: 200 points of favorable movement
- Distance: 200 points

The trailing calculation uses the current Bid for Buy positions and Ask for Sell positions.

Stop Loss changes are intended to improve the existing protection rather than loosen it.

### Position Sizing

The EA uses a fixed requested lot size of 0.01.

It normalizes volume according to the symbol's minimum, maximum, and volume-step settings.

It does not implement percentage-risk position sizing, martingale, or grid trading.

## Default Inputs

| Input | Default |
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

The reported backtest inputs match these source-code defaults.

## Supplied Backtest Summary

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Net Profit | +$16.50 |
| Profit Factor | 1.09 |
| Expected Payoff | +$0.10 |
| Recovery Factor | 0.57 |
| Equity Drawdown Relative | 2.85% |
| Total Trades | 169 |
| Win Rate | 53.85% |

## Research Status

**PROVISIONAL PASS — RESEARCH ONLY**

The supplied test produced a small positive net profit and low relative equity drawdown.

However, the Profit Factor is close to 1.0, the absolute profit is modest, and the sample contains only 169 trades.

The evidence is insufficient to establish a robust trading edge.

Independent out-of-sample testing, execution-cost sensitivity analysis, and forward validation are required before considering deployment.

## Repository Files

- `EA-130_ATR_Contraction_Reversal.mq5`
- `README.md`

## Disclaimer

This Expert Advisor is documented for research purposes.

Historical Strategy Tester results do not guarantee future profitability.
