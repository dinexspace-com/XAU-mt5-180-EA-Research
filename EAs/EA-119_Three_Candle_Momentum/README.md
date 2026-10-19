# EA-119 — Three Candle Momentum

## 1. Strategy Overview

**EA ID:** `EA-119`  
**Strategy:** Three Candle Momentum  
**Platform:** MetaTrader 5  
**Primary Symbol:** XAUUSD.PRO  
**Baseline Timeframe:** M1  
**Baseline ID:** `EA119-M1-BASELINE-001`

The strategy detects short-term momentum using the closing prices of three completed candles.

## 2. Entry Rules

### BUY Signal

Open a BUY position when:

- The latest completed candle closes above the previous candle.
- The previous candle closes above the candle before it.

Condition:

`Close[1] > Close[2] > Close[3]`

### SELL Signal

Open a SELL position when:

- The latest completed candle closes below the previous candle.
- The previous candle closes below the candle before it.

Condition:

`Close[1] < Close[2] < Close[3]`

The EA evaluates entry conditions when a new bar forms and allows only one position per symbol and magic number.

## 3. Baseline Configuration

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 119001 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Break-even | Enabled |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

**Implementation note:** The EA uses the chart's current timeframe (`_Period`). Attach it to an M1 chart to reproduce the baseline timeframe.

## 4. Position Management

- Initial Stop Loss and Take Profit are submitted with market orders.
- Break-even management is enabled.
- Trailing-stop management is enabled.
- New entries are blocked when an existing position matches the current symbol and magic number.
- New entries are filtered by the maximum spread setting.

## 5. Baseline Research Status

**Baseline Result:** `FAIL`

The initial backtest produced negative net profit, a Profit Factor below 1, and approximately 99.27% maximum equity drawdown.

The current strategy is not validated for live trading. Preserve this baseline before conducting any controlled research.

## 6. Research Priorities

1. Verify signal behavior and execution assumptions.
2. Test the number and ordering of momentum candles.
3. Evaluate entry confirmation and minimum candle movement.
4. Evaluate BUY and SELL signals separately.
5. Review Stop Loss, Take Profit, break-even, and trailing-stop logic.
6. Test session and market-regime filters.
7. Conduct out-of-sample and robustness testing.

No live deployment is approved based on the current baseline.
