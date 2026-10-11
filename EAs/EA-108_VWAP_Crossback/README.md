# EA-108 — VWAP Crossback

## Overview

EA-108_VWAP_Crossback is an experimental MetaTrader 5 Expert Advisor for XAUUSD. It uses a daily VWAP calculated from M1 candle data and looks for candle patterns around the VWAP level.

- **EA ID:** EA-108
- **Strategy:** VWAP Crossback
- **Platform:** MetaTrader 5
- **Default timeframe:** M1
- **Test symbol:** XAUUSD.PRO
- **Baseline ID:** `EA108-M1-BASELINE-001`
- **Status:** FAIL — Research Required

## Strategy Logic

The EA calculates VWAP from the beginning of the broker's trading day using M1 typical prices and tick volume.

### BUY Signal

A BUY signal requires:

1. Candle 2 closes below its calculated VWAP.
2. Candle 1 reaches or touches the VWAP area from below, subject to the rejection buffer.
3. Candle 1 closes below its VWAP.
4. Candle 1 is bullish (`Close > Open`).

### SELL Signal

A SELL signal requires:

1. Candle 2 closes above its calculated VWAP.
2. Candle 1 reaches or touches the VWAP area from above, subject to the rejection buffer.
3. Candle 1 closes above its VWAP.
4. Candle 1 is bearish (`Close < Open`).

Signals are evaluated using completed candles when a new chart bar begins.

## Risk Management

| Parameter | Baseline Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123463 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Rejection Buffer | 0 points |
| Break-even | Enabled |
| Break-even Trigger | 150 points |
| Break-even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |

The EA allows only one open position for the current symbol and Magic Number. It checks trading permissions, spread, and broker stop-distance requirements before placing orders.

## Baseline Assessment

The initial backtest produced a negative net result and an extreme equity drawdown. The strategy is not approved for live trading.

See `Backtest/EA-108_VWAP_Crossback/README.md` for the complete baseline metrics and `Research/EA-108_VWAP_Crossback/README.md` for the controlled research plan.

## Important Notes

- This EA is an experimental research implementation.
- Baseline results must not be interpreted as evidence of a profitable strategy.
- Do not deploy on a live account based on the current test.
- Preserve the original baseline before changing parameters or entry logic.
