
# EA-081 — Micro Consolidation Break

## Overview

EA-081 is an automated trading strategy developed in MQL5 for MetaTrader 5.

The strategy identifies short-term price consolidation and enters trades when price closes outside the consolidation range.

- Primary instrument: XAUUSD
- Tested symbol: XAUUSD.PRO
- Timeframe: M1
- Strategy: Micro Consolidation Breakout
- Trading directions: Buy and Sell
- Version: 1.00
- Status: Research / Backtesting

## Trading Logic

### 1. Consolidation Detection

The EA identifies a consolidation zone using four completed candles preceding the breakout candle.

The following conditions must be satisfied:

- Consolidation candles: 4
- ATR period: 14
- Maximum individual candle range: 0.60 × ATR
- Maximum consolidation zone width: 1.20 × ATR

ATR is sampled from the candle preceding the consolidation window.

### 2. Entry Conditions

BUY:
- A valid consolidation zone has formed.
- The completed breakout candle closes above the consolidation high.
- The breakout buffer condition is satisfied.

SELL:
- A valid consolidation zone has formed.
- The completed breakout candle closes below the consolidation low.
- The breakout buffer condition is satisfied.

Signals are evaluated once per completed candle. Entry is attempted at the beginning of the following candle.

### 3. Position Management

Default configuration:

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |
| Maximum Spread | 30 points |
| Maximum Slippage | 10 points |
| Magic Number | 123081 |

The initial SL/TP distance corresponds to a nominal reward-to-risk ratio of 2:1. Actual trade outcomes are affected by Break Even, Trailing Stop and execution costs.

### 4. Execution Protection

The EA includes:

- Spread filtering.
- Margin availability checks.
- Broker stop-distance validation.
- Trading permission checks.
- Tick-size price normalization.
- One active position/order per Magic Number across the account.
- Position management on every tick.

## Installation

1. Open MetaTrader 5.
2. Open MetaEditor.
3. Copy the MQ5 file into the Experts directory.
4. Compile the EA.
5. Attach it to the intended trading chart.
6. Verify all input parameters before testing.

Compilation and live execution have not been independently verified as part of this repository documentation.

## Backtesting

The initial documented backtest covers January–March 2026 on XAUUSD.PRO M1.

Full results and original Strategy Tester evidence are available in the Backtest directory.

## Disclaimer

This EA is an experimental trading research project.

Historical backtesting does not guarantee future profitability. It is not presented as a production-ready or independently validated trading system.
