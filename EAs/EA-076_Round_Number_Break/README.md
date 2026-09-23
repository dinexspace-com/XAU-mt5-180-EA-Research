
# EA-076 — Round Number Break

## Overview

EA-076 is an experimental MetaTrader 5 Expert Advisor designed to trade XAUUSD breakouts of predefined round-number price levels.

The strategy identifies price levels at regular intervals and enters when a completed candle closes beyond a relevant level.

**Status:** Research and backtesting. Not validated for live trading.

## Strategy Logic

- Instrument: XAUUSD
- Signal timeframe: M1
- Default round-number interval: 10.0 price units
- Signal evaluation: Once per new candle
- Confirmation: Completed candle close beyond a round-number level

### Buy Signal

A buy signal is generated when the previous completed candle closes above the relevant upper round-number boundary, including the configured breakout buffer.

### Sell Signal

A sell signal is generated when the previous completed candle closes below the relevant lower round-number boundary, including the configured breakout buffer.

The upper and lower boundaries are calculated using the preceding completed candle's closing price.

The default configuration uses a breakout buffer of zero.

## Default Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123076 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 points |
| Break-even Enabled | Yes |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop Enabled | Yes |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |
| Round Number Step | 10.0 |

The breakout lookback parameter is retained in the source but is not used by the active round-number signal calculation.

## Position Management

The EA includes:

- Fixed initial Stop Loss and Take Profit.
- Break-even protection.
- Trailing-stop management.
- Spread filtering for new entries.
- Margin and broker execution checks.
- Magic-number-based position identification.
- A maximum of one active position or order per magic number across the account.

On netting accounts, the EA also avoids merging its position with another EA's exposure on the same symbol.

Protective position management runs on every tick while trading is permitted.

## Installation

1. Copy `EA-076_Round_Number_Break.mq5` into the MT5 `MQL5/Experts` directory.
2. Open the file in MetaEditor.
3. Compile the source.
4. Attach the EA to an XAUUSD chart.
5. Verify broker symbol specifications and input parameters.
6. Run MT5 Strategy Tester before considering deployment.

## Current Validation

The supplied baseline report covers January–March 2026 on XAUUSD.PRO M1.

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000 |
| Net Profit | -$994.48 |
| Profit Factor | 0.93 |
| Maximum Equity Drawdown | 99.47% |
| Total Trades | 10,326 |
| Win Rate | 49.01% |

The tested configuration was unprofitable and experienced near-total account drawdown.

Independent compilation and reproduction of the supplied test remain pending.

## Risk Notice

This project is intended for algorithmic trading research. Historical backtests do not guarantee future performance. The current configuration is not approved for live trading.
