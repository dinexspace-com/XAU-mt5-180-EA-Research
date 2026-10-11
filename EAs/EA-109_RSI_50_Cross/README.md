
# EA-109 — RSI 50 Cross

## 1. Overview

EA-109 is an automated trading strategy for XAUUSD using the Relative Strength Index (RSI) 50-level crossing and an Exponential Moving Average (EMA) trend filter.

The EA evaluates entry conditions on a new bar and allows only one open position associated with its symbol and Magic Number.

**Baseline ID:** `EA109-M1-BASELINE-001`

**Current Status:** `FAIL — BASELINE`

## 2. Strategy Logic

### Indicators

- RSI: Period 14, applied to Close
- EMA: Period 20, applied to Close
- Default timeframe: Current chart timeframe; baseline tested on M1

### BUY Condition

The source code checks:

- RSI crossing condition: `r[2] < 50 && r[1] >= 50`
- Previous candle close above the EMA value read by the EA

### SELL Condition

The source code checks:

- RSI crossing condition: `r[2] > 50 && r[1] <= 50`
- Previous candle close below the EMA value read by the EA

**Implementation note:** The code uses `CopyBuffer()` with fixed-size arrays. The RSI and EMA buffer indexes should be verified carefully to confirm that the intended closed-bar crossing and EMA filter are being compared. The documented conditions above reproduce the source expressions, not a claim that the array indexes represent the intended bars.

## 3. Baseline Configuration

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123464 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| RSI Period | 14 |
| EMA Period | 20 |
| Break-even | Enabled |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

## 4. Trade Management

- Market orders with initial Stop Loss and Take Profit.
- Break-even management.
- Trailing Stop management.
- Maximum spread filter.
- Trade permission checks.
- One open position per symbol and Magic Number.

## 5. Baseline Verdict

The baseline produced negative net profit and a Profit Factor below 1.

The strategy is **not validated for live trading**. Verify the indicator-buffer indexing and execution logic before conducting further parameter research.
