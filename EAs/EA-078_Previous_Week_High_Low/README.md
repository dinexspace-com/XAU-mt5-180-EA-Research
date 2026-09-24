# EA-078 — Previous Week High/Low

![MQL5](https://img.shields.io/badge/MQL5-MetaTrader_5-blue)
![Market](https://img.shields.io/badge/Market-XAUUSD-gold)
![Status](https://img.shields.io/badge/Research-Baseline_FAIL-red)

## 1. Overview

EA-078 is an experimental MetaTrader 5 Expert Advisor designed to trade confirmed breakouts of the previous week's high and low on XAUUSD.

The EA uses the previous completed weekly candle as its reference and evaluates breakout signals using completed candles on the configured signal timeframe.

**Research status:** Baseline tested; profitability criterion not met.

## 2. Trading Logic

### Reference levels

The EA retrieves the high and low of the previous completed weekly candle (W1).

- Previous Week High: bullish breakout reference.
- Previous Week Low: bearish breakout reference.

### BUY entry

A BUY signal is generated when:

1. The previous completed signal candle closed at or below the previous week's high plus the breakout buffer.
2. The latest completed signal candle closes above that level.
3. The EA passes its trading-permission, spread, margin and position checks.

### SELL entry

A SELL signal is generated when:

1. The previous completed signal candle closed at or above the previous week's low minus the breakout buffer.
2. The latest completed signal candle closes below that level.
3. The EA passes its trading-permission, spread, margin and position checks.

Signals are evaluated when a new candle begins on the configured signal timeframe.

### Position restrictions

The EA restricts concurrent positions and orders associated with its Magic Number across the account.

On netting accounts, it also blocks new entries when the same symbol already has exposure.

## 3. Default Parameters

| Parameter | Default |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123078 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Signal Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |

Note: Breakout Lookback is present in the source and controls the number of candles requested, but the current weekly breakout signal uses the previous W1 high/low rather than the rolling lookback range.

## 4. Risk Management

The EA uses fixed lot sizing and submits Stop Loss and Take Profit with the initial market-order request.

Break Even and Trailing Stop management are evaluated on every tick.

The EA also checks:

- Broker minimum stop distance.
- Broker freeze level.
- Symbol trading permissions.
- Available margin.
- Maximum allowed spread.
- Lot-size restrictions.

## 5. Baseline Backtest

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Period | 2026-01-02 to 2026-03-31 |
| Tester Timeframe | M15 |
| Signal Timeframe | M1 |
| Initial Deposit | $1,000 |
| Total Trades | 263 |
| Net Profit | -$22.97 |
| Profit Factor | 0.93 |
| Win Rate | 50.57% |
| Maximum Equity Drawdown | 5.05% |

The baseline satisfies the trade-count and drawdown research thresholds but fails the positive-profit requirement.

## 6. Files

- [MQL5 Source](EA-078_Previous_Week_High_Low.mq5)
- [Backtest Results](../../Backtest/EA-078_Previous_Week_High_Low/README.md)
- [Research](../../Research/README.md)
- [Methodology](../../docs/methodology.md)

## 7. Status

**BASELINE FAIL — Further research required.**

This is an experimental strategy. Historical backtest results do not establish live trading profitability.
