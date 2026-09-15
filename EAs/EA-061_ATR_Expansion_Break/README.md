# EA-061 — ATR Expansion Break

## Overview

**EA-061_ATR_Expansion_Break** is a MetaTrader 5 Expert Advisor designed to trade breakout movements that occur together with volatility expansion.

The strategy combines:

* Price range breakout
* ATR-based volatility expansion confirmation
* Fixed Stop Loss and Take Profit
* Break-even management
* Trailing Stop management
* Spread and broker execution checks

The default configuration uses the **M1 timeframe**.

---

## Strategy Logic

The EA searches for a breakout from the recent price range.

The reference range is calculated from the previous **20 candles** by default.

A trade signal requires two conditions:

1. The signal candle closes outside the previous breakout range.
2. The signal candle's total range is greater than the previous ATR multiplied by the configured ATR multiplier.

This prevents the EA from treating every small range breakout as a valid signal.

### BUY Signal

A BUY signal occurs when:

* The signal candle closes above the highest price of the breakout lookback range.
* The signal candle range is greater than:

`ATR × ATR Multiplier`

### SELL Signal

A SELL signal occurs when:

* The signal candle closes below the lowest price of the breakout lookback range.
* The signal candle range is greater than:

`ATR × ATR Multiplier`

The ATR value is taken from the candle before the signal candle so that the expansion candle is compared against prior volatility.

---

## Default Parameters

| Parameter         |    Default | Description                               |
| ----------------- | ---------: | ----------------------------------------- |
| Lot Size          |       0.01 | Fixed trading volume                      |
| Stop Loss         | 300 points | Initial protective stop                   |
| Take Profit       | 600 points | Initial profit target                     |
| Magic Number      |     123061 | Unique EA identifier                      |
| Slippage          |  10 points | Maximum execution deviation               |
| Max Spread        |  30 points | Maximum spread allowed for new entries    |
| Timeframe         |         M1 | Signal timeframe                          |
| Breakout Lookback |         20 | Number of candles used for breakout range |
| Breakout Buffer   |          0 | Additional breakout distance              |
| ATR Period        |         14 | ATR calculation period                    |
| ATR Multiplier    |        1.5 | Required volatility expansion             |

---

## Break-Even

Break-even management is enabled by default.

| Parameter      |    Default |
| -------------- | ---------: |
| Use Break Even |       true |
| Trigger        | 150 points |
| Offset         |   0 points |

When the position reaches at least **150 points of profit**, the EA can move the Stop Loss to the entry price.

The EA also checks the broker's minimum stop and freeze distances before modifying the position.

---

## Trailing Stop

Trailing Stop management is enabled by default.

| Parameter         |    Default |
| ----------------- | ---------: |
| Use Trailing Stop |       true |
| Trailing Start    | 200 points |
| Trailing Distance | 100 points |
| Trailing Step     |  10 points |

Trailing management begins after the position reaches at least **200 points of profit**.

The Stop Loss then follows price while maintaining the configured trailing distance and minimum adjustment step.

---

## Position Management

The EA is designed to prevent uncontrolled duplicate exposure.

For its configured Magic Number, it allows at most one active position or order across the account.

On netting accounts, the EA also avoids opening a trade when another position or order already exists on the same symbol.

Position management is performed on every tick.

New entry signals are evaluated only when a new candle becomes available.

---

## Execution Protection

Before submitting a market order, the EA checks:

* Terminal connection
* Automated trading permissions
* Account trading permissions
* Symbol trading mode
* Current spread
* Broker-supported market orders
* Stop Loss / Take Profit support
* Broker minimum stop distance
* Available margin
* Symbol lot minimum, maximum and lot step
* Symbol tick size

Stop Loss and Take Profit are submitted together with the initial market order.

The configured lot size is never silently increased to satisfy broker volume requirements.

---

## Files

```text
EA-061_ATR_Expansion_Break/
├── EA-061_ATR_Expansion_Break.mq5
└── README.md
```

`EA-061_ATR_Expansion_Break.mq5` contains the complete MQL5 source code.

`README.md` documents the strategy logic and default implementation parameters.

---

## Platform

* **Platform:** MetaTrader 5
* **Language:** MQL5
* **EA ID:** EA-061
* **Strategy:** ATR Expansion Breakout
* **Default Timeframe:** M1
* **Position sizing:** Fixed Lot

---

## Research Status

This EA is part of the **XAUUSD MT5 EA Research** repository.

Strategy implementation and backtest results should be evaluated separately.

Backtest evidence is stored in the corresponding:

```text
Backtest/EA-061_ATR_Expansion_Break/
```

Past backtest performance does not guarantee future trading results.

---

## Disclaimer

This Expert Advisor is provided for research, development, and testing purposes.

Algorithmic trading involves substantial financial risk. Backtest results, historical performance, and simulated results do not guarantee future performance.

Users are responsible for independently evaluating the strategy and its suitability before using it in a live trading environment.
