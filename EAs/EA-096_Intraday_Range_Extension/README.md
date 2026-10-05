# EA-096_Intraday_Range_Extension

## 1. Overview

| Item          | Value                           |
| ------------- | ------------------------------- |
| EA Name       | EA-096_Intraday_Range_Extension |
| Platform      | MetaTrader 5                    |
| Language      | MQL5                            |
| Symbol Tested | XAUUSD.PRO                      |
| Timeframe     | M1                              |
| Version       | 1.00                            |
| Magic Number  | 123096                          |
| Initial Lot   | 0.01                            |

EA-096 is an intraday range-extension strategy.

The EA first identifies the intraday M1 range, then checks whether price extends beyond that range by a configurable ATR-based distance. A reversal candle is then used as the entry confirmation.

---

## 2. Core Indicators

### ATR

* ATR Period: `14`
* Extension threshold: `1.0 ATR`

The ATR is used to determine whether price has extended sufficiently beyond the established intraday range.

### Intraday Range

* Minimum range bars: `30`
* Timeframe: `M1`
* Range is calculated from the beginning of the trading day up to the signal sequence.

---

## 3. Entry Logic

### BUY

A BUY signal requires:

1. The previous intraday range contains the relevant historical M1 data.
2. Price extends below the established intraday low by at least:

`1.0 × ATR(14)`

3. The extension is exclusively downward.
4. The confirmation candle is bullish.
5. The confirmation candle closes above the extension candle close.

Conceptually:

`Low of extension candle < Intraday Low - ATR(14) × ExtensionATR`

and

`Confirmation Candle = Bullish`

and

`Confirmation Close > Extension Candle Close`

Then:

`BUY`

---

### SELL

A SELL signal requires:

1. The previous intraday range contains the required historical M1 data.
2. Price extends above the established intraday high by at least:

`1.0 × ATR(14)`

3. The extension is exclusively upward.
4. The confirmation candle is bearish.
5. The confirmation candle closes below the extension candle close.

Conceptually:

`High of extension candle > Intraday High + ATR(14) × ExtensionATR`

and

`Confirmation Candle = Bearish`

and

`Confirmation Close < Extension Candle Close`

Then:

`SELL`

---

## 4. Important Signal Restrictions

The EA rejects the signal when:

* Both upward and downward extensions occur on the same extension candle.
* The confirmation candle closes outside the established range in a way that invalidates the intended setup.
* Required historical M1 data is unavailable.
* The minimum number of range bars is not available.

The strategy therefore attempts to isolate a one-sided range extension followed by reversal confirmation.

---

## 5. Execution Parameters

| Parameter      |    Default |
| -------------- | ---------: |
| Lot Size       |       0.01 |
| Stop Loss      | 300 points |
| Take Profit    | 600 points |
| Slippage       |  10 points |
| Maximum Spread |  30 points |
| Timeframe      |         M1 |
| Magic Number   |     123096 |

---

## 6. Break-Even

| Parameter |      Value |
| --------- | ---------: |
| Enabled   |       true |
| Trigger   | 150 points |
| Offset    |   0 points |

When the position reaches the configured profit threshold, the EA moves the stop loss toward the entry price, subject to broker stop/freeze restrictions.

---

## 7. Trailing Stop

| Parameter |      Value |
| --------- | ---------: |
| Enabled   |       true |
| Start     | 200 points |
| Distance  | 100 points |
| Step      |  10 points |

Trailing management is performed on every tick.

---

## 8. Position Management

The EA:

* Uses market orders.
* Sends SL and TP together with the entry order.
* Checks broker stop-distance requirements.
* Checks broker freeze levels.
* Checks available margin.
* Checks spread before entry.
* Checks symbol trading mode.
* Prevents conflicting positions/orders.
* Uses the EA magic number `123096`.
* Does not silently increase the configured lot size.

Protective position management continues even when the current spread is too high for a new entry.

---

## 9. Processing Model

Signal evaluation is performed on a new M1 candle.

Position protection is handled tick-by-tick.

The EA starts from the next available candle after initialization, preventing an old signal from being immediately traded when the EA is attached.

---

## 10. Current Research Status

This version is the baseline implementation for EA-096.

Baseline identifier:

`EA096-M1-BASELINE-001`

The attached Strategy Tester result is documented separately under:

`Backtest/EA-096_Intraday_Range_Extension/`

---

## 11. Research Classification

The current backtest is **positive but not yet sufficient for production validation**.

The strategy produced a positive net profit and low reported drawdown in the supplied test, but the sample contains only 86 trades.

Therefore the result should be treated as a **baseline research result**, not as evidence of production robustness.
