
# EA-111 — RSI 70/30 Continuation

## 1. Overview

**EA ID:** `EA-111`  
**Strategy:** RSI 70/30 threshold-crossing with candle-direction confirmation  
**Platform:** MetaTrader 5  
**Symbol:** XAUUSD.PRO  
**Timeframe:** M1  
**Baseline ID:** `EA111-M1-BASELINE-001`

## 2. Strategy Logic

The EA uses RSI(14) and the previous closed candle's direction to determine entry signals.

### BUY Condition — As Implemented

- RSI on the older closed candle is `<= 70`.
- RSI on the latest closed candle is `> 70`.
- The latest closed candle is bullish (`Close > Open`).

### SELL Condition — As Implemented

- RSI on the older closed candle is `>= 30`.
- RSI on the latest closed candle is `< 30`.
- The latest closed candle is bearish (`Close < Open`).

**Important:** The implemented BUY condition crosses upward through 70, while SELL crosses downward through 30. This differs from the source comments describing RSI returning below 70 or above 30. Verify the intended logic before modifying the EA.

## 3. Baseline Configuration

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| RSI Period | 14 |
| Maximum Spread | 30 points |
| Magic Number | 111001 |
| Slippage | 10 points |
| Break-even | Enabled |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

## 4. Execution and Risk Management

- Entry signals are evaluated on a new candle.
- Only one position per EA magic number and symbol is permitted.
- Spread and trading-permission checks are applied.
- Initial SL and TP are submitted with market orders.
- Break-even and trailing-stop management run on every tick.

## 5. Baseline Status

**Result:** `FAIL`

The initial backtest is negative and has excessive drawdown. The EA is not validated for live trading.

Further parameter optimization is blocked until the RSI indexing and intended entry logic are verified.
