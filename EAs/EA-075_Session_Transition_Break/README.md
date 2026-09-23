# EA-075 — Session Transition Break

## Overview

EA-075 is an experimental MetaTrader 5 Expert Advisor for XAUUSD, designed to trade breakouts of a predefined intraday session range.

The strategy records the high and low of a configured range, then looks for a confirmed breakout during the subsequent trading window.

**Status:** Research and backtesting. Not validated for live trading.

## Strategy Logic

- Trading instrument: XAUUSD
- Signal timeframe: M1
- Default range: 00:00–08:00 server time
- Default entry window: 08:00–10:00 server time
- Range boundaries: highest high and lowest low of the completed M1 candles within the configured session
- Buy: the previous completed candle closes above the range high plus the breakout buffer, having crossed that level from below
- Sell: the previous completed candle closes below the range low minus the breakout buffer, having crossed that level from above
- Entries are evaluated on new M1 candles.

All session hours refer to broker server time, not automatically converted local-market hours.

## Default Parameters

| Parameter | Value |
|---|---:|
| Lot size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123075 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 points |
| Break-even enabled | Yes |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop enabled | Yes |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |
| Range Start Hour | 0 |
| Range End Hour | 8 |
| Trade End Hour | 10 |

Note: The source contains general breakout helper functions, but the active session strategy uses the configured session high/low. The breakout lookback parameter is not the active session-range length.

## Position Management

The EA supports:
- Initial fixed SL and TP submitted with the market order.
- Break-even protection.
- Trailing-stop management.
- Spread filtering for new entries.
- Broker stop-distance and freeze-level checks.
- Margin checks before entry.
- Magic-number-based position identification.
- A maximum of one active position or order per magic number across the account.

Position protection is evaluated on every tick while trading is permitted.

## Installation

1. Copy EA-075_Session_Transition_Break.mq5 into the MT5 MQL5/Experts directory.
2. Open the file in MetaEditor.
3. Compile the source.
4. Attach the EA to an XAUUSD chart.
5. Confirm broker symbol specifications, server time and input parameters.
6. Test using MT5 Strategy Tester before considering any live deployment.

## Current Validation

The supplied MT5 report covers January–March 2026 on XAUUSD.PRO M1.

- Initial deposit: $1,000
- Net profit: -$9.67
- Profit factor: 0.86
- Maximum equity drawdown: 4.04%
- Total trades: 54

The tested configuration was unprofitable over the supplied period. Compilation and live-trading readiness have not been independently verified.

See the Backtest and Research directories for the report and further investigation.

## Risk Notice

This project is for algorithmic trading research. Historical backtest performance does not guarantee future results. No live profitability claim is made.
