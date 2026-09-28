EA-084: RSI Extreme Overbought/Oversold Reversal System

1. Overview

EA-084 is an automated Expert Advisor designed for MetaTrader 5 (MT5), optimized for XAUUSD on the M1 timeframe. The EA captures mean-reversion movements when the Relative Strength Index (RSI) crosses back from extreme oversold or overbought levels.

It is engineered with institutional-grade risk management mechanisms including dynamic Break-Even, Trailing Stop, spread filtering, and single-position exposure limits.

2. Trading Strategy & Logic

2.1 Core Signal Generation

Indicator: Standard RSI (iRSI) computed on PRICE_CLOSE.

Buy (Long) Signal: RSI was below InpRSILower ($20$) on bar index 2 and crosses above/equal to InpRSILower ($20$) on bar index 1.

Sell (Short) Signal: RSI was above InpRSIUpper ($80$) on bar index 2 and crosses below/equal to InpRSIUpper ($80$) on bar index 1.

Execution Timing: Signals are evaluated strictly once per new bar (OnTick checks new candle open) to prevent intra-bar whipsaws.

2.2 Risk & Trade Management

Single Position Rule: Strictly limits exposure to one active position or pending order per Magic Number across the account (supports both Hedging and Netting execution modes).

Break-Even (BE): Automatically shifts Stop Loss to entry price (plus offset) once price moves in profit by InpBreakEvenTrigger points.

Trailing Stop: Continuously updates SL behind the current price using InpTrailingStart, InpTrailingDistance, and InpTrailingStep rules.

Execution Filters: Checks real-time broker spread against InpMaxSpread, verifies free margin, and respects broker STOPS_LEVEL and FREEZE_LEVEL.

3. Input Parameters Reference

Group

Parameter

Default Value

Description

Execution

InpLotSize

0.01

Fixed order lot size



InpStopLoss

300

Stop Loss distance (in points)



InpTakeProfit

600

Take Profit distance (in points)



InpMagicNumber

123084

Unique EA identification number



InpSlippage

10

Maximum slippage allowed (in points)



InpMaxSpread

30

Maximum allowable spread to open trades (in points)



InpTimeframe

PERIOD_M1

Working timeframe for signal calculation

RSI Settings

InpRSIPeriod

14

RSI calculation period



InpRSILower

20.0

Oversold threshold



InpRSIUpper

80.0

Overbought threshold

Break Even

InpUseBreakEven

true

Enable/Disable Break Even functionality



InpBreakEvenTrigger

150

Profit distance in points to activate BE



InpBreakEvenOffset

0

Points added above/below entry price for BE

Trailing Stop

InpUseTrailingStop

true

Enable/Disable Trailing Stop functionality



InpTrailingStart

200

Minimum profit in points before Trailing activates



InpTrailingDistance

100

Distance in points maintained from price



InpTrailingStep

10

Minimum step in points to update trailing SL

4. Installation & Usage

Compilation: Place EA-084.mq5 inside /MQL5/Experts/ directory of MetaTrader 5 and compile using MetaEditor.

Chart Attachment: Drag the EA onto a XAUUSD M1 chart.

Permissions: Ensure Allow Algo Trading is enabled in MT5 settings as well as the EA properties window.
