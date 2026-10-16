# EA-115 — Rate of Change (ROC 10)

## Overview

EA-115 is an Expert Advisor for MetaTrader 5 (MT5) that uses the Rate of Change (ROC) indicator logic to generate momentum-based trading signals.

- **EA File:** `EA-115_ROC_10.mq5`
- **Strategy:** ROC Momentum
- **Default Chart Timeframe:** M1, when attached to an M1 chart
- **Symbol Tested:** `XAUUSD.PRO`
- **Magic Number:** `115001`
- **Baseline ID:** `EA115-M1-BASELINE-001`
- **Current Classification:** `FAIL`

## Entry Logic

The EA calculates ROC from the previous closed candle and the close from `InpROCPeriod` bars earlier:

`ROC = (Close[1] - Close[InpROCPeriod + 1]) / Close[InpROCPeriod + 1] × 100`

### BUY

Open a BUY position when:

- `ROC > InpROCThreshold`
- Trading is allowed.
- No position exists for the current symbol and magic number.
- Current spread does not exceed `InpMaxSpread`.

### SELL

Open a SELL position when:

- `ROC < -InpROCThreshold`
- Trading is allowed.
- No position exists for the current symbol and magic number.
- Current spread does not exceed `InpMaxSpread`.

The EA evaluates entries on a new chart bar. It uses the chart's current timeframe; there is no separate timeframe input in the source code.

## Baseline Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 115001 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| ROC Period | 10 |
| ROC Threshold | 0.20% |
| Break-even | Enabled |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

## Position Management

- Initial stop loss and take profit are submitted with market orders.
- Break-even management starts when the position reaches the configured profit threshold.
- Trailing stop management updates the stop loss as price moves favorably.
- The EA checks spread before opening a new position.
- Position management runs on every tick.

## Baseline Status

The baseline backtest produced a negative net profit and a maximum equity drawdown of 99.20%.

**Decision:** The current configuration is not validated for live trading. Preserve this baseline and investigate the strategy before considering further optimization.

## File Structure

- `EA-115_ROC_10.mq5` — EA source code.
- `README.md` — Strategy definition, inputs, and current research status.
