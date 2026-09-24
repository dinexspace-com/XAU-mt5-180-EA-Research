# EA-077 — Previous Day High/Low

## Overview

EA-077 is an experimental MetaTrader 5 Expert Advisor for XAUUSD. It trades confirmed breakouts of the previous daily candle's high and low.

The EA uses the previous completed candle on its configured signal timeframe to detect a crossing of the previous day's price levels.

**Status:** Research / Backtested — not validated for live trading.

## Strategy

### Buy entry
A buy signal occurs when:
- The previous completed signal candle closes above the previous day's high plus the breakout buffer.
- The candle immediately before it closed at or below that level.
- The EA's execution and position restrictions permit a new trade.

### Sell entry
A sell signal occurs when:
- The previous completed signal candle closes below the previous day's low minus the breakout buffer.
- The candle immediately before it closed at or above that level.
- The EA's execution and position restrictions permit a new trade.

Signals are evaluated once per new candle on the configured signal timeframe. The EA does not open a new position immediately when it is first attached to a chart.

## Default parameters

| Parameter | Value |
|---|---:|
| Lot size | 0.01 |
| Stop loss | 300 points |
| Take profit | 600 points |
| Magic number | 123077 |
| Slippage | 10 points |
| Maximum spread | 30 points |
| Signal timeframe | M1 |
| Breakout lookback | 20 |
| Breakout buffer | 0 points |
| Break-even enabled | true |
| Break-even trigger | 150 points |
| Break-even offset | 0 points |
| Trailing stop enabled | true |
| Trailing start | 200 points |
| Trailing distance | 100 points |
| Trailing step | 10 points |

The breakout lookback parameter determines the amount of price history requested, but the active previous-day signal uses daily High/Low levels rather than the separate lookback-range function.

## Risk management

- Fixed initial stop loss and take profit.
- Optional break-even and trailing stop.
- Spread and margin checks before entry.
- At most one position or order with the configured magic number across the account.
- Additional same-symbol exposure restriction on netting accounts.
- Broker stop-distance and freeze-level checks.

Stop loss and take profit are submitted with the initial market order. Protective stop management runs on every tick when trading is allowed.

## Backtest summary

| Metric | Result |
|---|---:|
| Symbol | XAUUSD.PRO |
| Tester chart timeframe | M15 |
| Signal timeframe | M1 |
| Period | 2026-01-02 to 2026-03-31 |
| Initial deposit | $1,000 |
| Total trades | 455 |
| Net profit | -$98.75 |
| Profit factor | 0.84 |
| Winning trades | 205 (45.05%) |
| Losing trades | 250 (54.95%) |
| Maximum equity drawdown | 11.18% |
| History quality | 100% real ticks |

The tested configuration generated a net loss. These results do not establish live-trading performance.

See the corresponding Backtest folder for the original Strategy Tester report and charts.

## Installation

1. Open MetaEditor in MetaTrader 5.
2. Place the MQ5 source file in the Experts directory.
3. Compile the source file.
4. Attach the EA to a compatible chart.
5. Check symbol specifications and input parameters before testing.

## Files

- `EA-077_Previous_Day_High_Low.mq5` — MQL5 source code.
- `README.md` — strategy documentation.

## Disclaimer

For research and educational purposes. Backtest results are not a guarantee of future performance.
