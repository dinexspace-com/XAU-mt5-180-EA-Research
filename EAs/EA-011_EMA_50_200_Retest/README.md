# EA-011: EMA 50/200 Retest Strategy

## Overview
- **Asset**: XAUUSD (Gold)
- **Timeframe**: M1 / M5
- **Strategy Type**: Trend Following / Pullback Retest
- **Language**: MQL5

## Strategy Logic
1. **Trend Definition**:
   - **Bullish Trend**: EMA 50 > EMA 200.
   - **Bearish Trend**: EMA 50 < EMA 200.
2. **Entry Conditions**:
   - **Buy Signal**: During a Bullish trend, the low of the previous closed bar touches/retests the EMA 50 within `InpMaxRetestDistancePoints` and closes above EMA 50.
   - **Sell Signal**: During a Bearish trend, the high of the previous closed bar touches/retests the EMA 50 within `InpMaxRetestDistancePoints` and closes below EMA 50.
3. **Execution Filters**:
   - Maximum Spread Limit (`InpMaxSpreadPoints`).
   - One order per magic number at a time.
   - Signal evaluation on new bar completion.

## Default Input Parameters
| Parameter | Default | Unit | Description |
| :--- | :--- | :--- | :--- |
| `InpFastEMAPeriod` | 50 | Period | Fast EMA Period |
| `InpSlowEMAPeriod` | 200 | Period | Slow EMA Period |
| `InpMaxRetestDistancePoints` | 50 | Points | Maximum distance to EMA 50 for retest validation |
| `InpMaxSpreadPoints` | 30 | Points | Maximum spread allowed for execution |
| `InpLotSize` | 0.01 | Lots | Fixed order volume |
| `InpStopLossPoints` | 300 | Points | Stop Loss distance |
| `InpTakeProfitPoints` | 600 | Points | Take Profit distance |
| `InpBreakEvenPoints` | 150 | Points | Distance to move SL to Entry |
| `InpTrailingStopPoints` | 200 | Points | Trailing Stop distance |
| `InpMagicNumber` | 1150200 | Number | Unique identifier for the EA |
