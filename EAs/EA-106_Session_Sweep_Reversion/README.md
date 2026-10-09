# EA-106 — Session Sweep Reversion

## Overview

EA-106 is an experimental XAUUSD Expert Advisor designed to trade session-range sweeps and reversals.

The strategy builds a high-low range from a configured time window, then looks for price to break beyond the range and close back inside it.

* **EA ID:** EA-106
* **Strategy:** Session Sweep Reversion
* **Platform:** MetaTrader 5
* **Language:** MQL5
* **Symbol tested:** XAUUSD.PRO
* **Timeframe tested:** M1
* **Status:** Research — Baseline Failed

## Strategy Logic

### Session Range

The EA collects historical candles between `InpSessionStartHour` and `InpSessionEndHour` using the trading server's time.

Default range window:

* Start hour: 00:00
* End hour: 08:00

The highest high and lowest low during this window define the session range.

### SELL Entry

A SELL signal occurs when the previous completed candle:

1. Breaks above the session high.
2. Closes back below the session high.

### BUY Entry

A BUY signal occurs when the previous completed candle:

1. Breaks below the session low.
2. Closes back above the session low.

The EA evaluates entry conditions on a new bar and allows only one open position for the current symbol and magic number.

## Risk Management

* Fixed lot size
* Stop Loss and Take Profit
* Optional Break-Even
* Optional Trailing Stop
* Maximum spread filter
* Maximum slippage setting
* Magic number for position identification
* Trading permission checks

## Default Inputs

| Input                 |    Default |
| --------------------- | ---------: |
| `InpLotSize`          |       0.01 |
| `InpStopLoss`         | 300 points |
| `InpTakeProfit`       | 600 points |
| `InpMagicNumber`      |     123461 |
| `InpSlippage`         |  10 points |
| `InpUseBreakEven`     |       true |
| `InpBreakEvenStart`   | 150 points |
| `InpBreakEvenOffset`  |   0 points |
| `InpUseTrailingStop`  |       true |
| `InpTrailingStart`    | 200 points |
| `InpTrailingDistance` | 200 points |
| `InpMaxSpreadPoints`  |  30 points |
| `InpSessionStartHour` |          0 |
| `InpSessionEndHour`   |          8 |

## Baseline Result

Baseline ID: `EA106-M1-BASELINE-001`

* Net Profit: -$142.71
* Profit Factor: 0.81
* Max Equity Drawdown: 19.06%
* Total Trades: 569
* Modeling: Every tick based on real ticks

**Baseline decision: FAIL.**

The current configuration loses money over the tested period. Further controlled research is required before considering any later version for out-of-sample or forward testing.

## Limitations

The current baseline does not establish profitability or robustness across other market periods, brokers, spreads, or execution conditions.

The session-hour implementation and server-time interpretation should be verified before comparing parameter variants.

## Disclaimer

This EA is an experimental research project, not a verified profitable trading system. Backtest results do not guarantee future performance.
