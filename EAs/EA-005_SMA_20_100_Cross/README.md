# EA-005_SMA_20_100_Cross

## Overview
- **Asset**: XAUUSD
- **Timeframe**: M1
- **Strategy**: Moving Average Crossover System (SMA 20 & SMA 100)
- **Version**: 1.0
- **Status**: Build -> Compile -> Backtest QUEUE

## Trading Logic
- **BUY Signal**: Triggers when SMA(20) crosses ABOVE SMA(100) on candle close.
- **SELL Signal**: Triggers when SMA(20) crosses BELOW SMA(100) on candle close.
- **Max Positions**: 1 position at a time.
- **Spread Filter**: Maximum allowed spread is 30 points.

## Risk & Position Management
- **Stop Loss (SL)**: 300 points
- **Take Profit (TP)**: 600 points
- **Break Even**: Moves SL to Open Price at 150 points profit
- **Trailing Stop**: Activates at 200 points profit, trailing with 50 points step
