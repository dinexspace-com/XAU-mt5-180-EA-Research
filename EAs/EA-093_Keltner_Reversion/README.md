# EA-093_Keltner_Reversion

## 1. Overview

EA-093_Keltner_Reversion is an MQL5 Expert Advisor designed for short-term mean-reversion trading on XAUUSD.

The strategy uses an EMA center line and ATR-based upper/lower bands. The default configuration uses:

* EMA Period: 20
* ATR Period: 14
* ATR Multiplier: 2.0
* Timeframe: M1

The EA evaluates completed candles and opens a position when price shows an excursion beyond the Keltner-style envelope.

---

## 2. Strategy Components

### EMA

The center line is calculated using an Exponential Moving Average:

* `InpEMAPeriod = 20`

### ATR

Volatility is measured using:

* `InpATRPeriod = 14`

### Keltner-style Bands

The bands are calculated as:

```text
Upper Band = EMA + ATR × Multiplier
Lower Band = EMA - ATR × Multiplier
```

Default multiplier:

```text
InpATRMultiplier = 2.0
```

---

## 3. Signal Logic

The EA reads the previous completed candles rather than the currently forming candle.

The signal calculation uses:

* EMA value at shift 1 and shift 2
* ATR value at shift 1 and shift 2
* OHLC data from the previous candles

A buy condition can be generated when:

```text
Previous candle close < previous Keltner-style lower band
OR
Current completed candle low < current lower band
```

A sell condition can be generated when:

```text
Previous candle close > previous Keltner-style upper band
OR
Current completed candle high > current upper band
```

The EA only assigns a direction when the buy and sell conditions are not simultaneously true.

---

## 4. Execution

Default execution parameters:

| Parameter      |    Default |
| -------------- | ---------: |
| Lot Size       |       0.01 |
| Stop Loss      | 300 points |
| Take Profit    | 600 points |
| Magic Number   |     123093 |
| Slippage       |         10 |
| Maximum Spread |  30 points |
| Timeframe      |         M1 |

The EA checks:

* Terminal trading permission
* Account trading permission
* Expert Advisor trading permission
* Spread
* Symbol trading mode
* Market order support
* SL/TP support
* Available margin
* Lot-size validity
* Broker stop-distance requirements

---

## 5. Position Management

### Break Even

Break-even management is enabled by default.

```text
Use Break Even = true
Trigger = 150 points
Offset = 0 points
```

When the position reaches the configured trigger, the EA attempts to move the stop loss to the entry price, subject to broker stop and freeze-level restrictions.

### Trailing Stop

Trailing stop management is enabled by default.

```text
Use Trailing Stop = true
Start = 200 points
Distance = 100 points
Step = 10 points
```

Trailing-stop updates are performed on every tick while an eligible position exists.

---

## 6. Position Restrictions

The EA attempts to maintain only one relevant position/order.

Entry is blocked when:

* A position with the EA magic number already exists.
* A pending order with the EA magic number already exists.
* On a netting account, another position already exists on the same symbol.

---

## 7. Order Protection

SL and TP are included directly in the market-order request.

The EA also respects:

* Symbol tick size
* Symbol point size
* Broker stop level
* Broker freeze level
* Symbol trading mode
* Available margin

Prices are rounded according to the symbol tick size.

---

## 8. Initial Parameters

The current EA version validates the following:

```text
Lot Size > 0
Stop Loss > 0
Take Profit > 0
Magic Number != 0
Slippage >= 0
Maximum Spread >= 0
EMA Period: 2–10000
ATR Period: 2–10000
ATR Multiplier > 0
```

The EA also validates the configured lot against the symbol's minimum, maximum and volume step.

---

## 9. File Status

EA:

```text
EA-093_Keltner_Reversion.mq5
```

Version:

```text
1.00
```

Magic Number:

```text
123093
```

---

## 10. Current Research Status

The EA has an available Strategy Tester report covering:

```text
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026.01.02 – 2026.03.31
Initial Deposit: 1000 USD
Leverage: 1:500
History Quality: 100% real ticks
```

The detailed results are documented separately under:

```text
Backtest/EA-093_Keltner_Reversion/
```

This README documents the implementation. It does not represent a conclusion about the strategy's future profitability.
