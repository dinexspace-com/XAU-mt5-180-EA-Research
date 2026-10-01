# EA-091_VWAP_Deviation

## 1. Overview

EA-091_VWAP_Deviation is an MT5 Expert Advisor for XAUUSD that implements a daily VWAP deviation mean-reversion concept.

The EA operates on the M1 timeframe and uses:

* Daily VWAP
* VWAP population-weighted standard deviation
* ATR
* VWAP deviation threshold
* Fixed Stop Loss / Take Profit
* Break Even
* Trailing Stop
* Maximum spread filter
* Magic Number
* Position and order protection rules

The EA is designed to evaluate signals on completed candles and avoid opening a position from an old signal when the EA is first attached.

---

## 2. Core Strategy

The VWAP is calculated from the beginning of the broker trading day.

The VWAP calculation uses:

* Typical price = `(High + Low + Close) / 3`
* Tick volume as the weighting factor
* Completed candles only
* Daily reset at broker midnight

The VWAP deviation is compared against ATR.

The minimum required VWAP history is controlled by:

`InpVWAPMinBars`

The ATR period is controlled by:

`InpATRPeriod`

The required deviation threshold is controlled by:

`InpVWAPDeviationATR`

---

## 3. Buy Signal

A buy signal is generated when the previous completed candle has moved sufficiently below VWAP and then begins turning upward.

The conditions include:

* Price was below VWAP by at least the configured ATR deviation.
* The deviation candle is not rising relative to the previous candle.
* The latest completed candle closes higher than the deviation candle.
* The latest completed candle remains below VWAP.

This is intended to detect a first price turn after an excessive downside deviation rather than chase price after it has already returned through VWAP.

---

## 4. Sell Signal

A sell signal is generated using the opposite conditions.

The conditions include:

* Price was above VWAP by at least the configured ATR deviation.
* The deviation candle is not falling relative to the previous candle.
* The latest completed candle closes lower than the deviation candle.
* The latest completed candle remains above VWAP.

---

## 5. Entry Execution

The EA checks:

* Terminal connection
* Trading permission
* Expert trading permission
* Account trading permission
* Maximum spread
* Symbol trading mode
* Market-order support
* SL/TP support
* Available margin
* Lot-size validity
* Broker stop-distance requirements

The entry request includes the protective Stop Loss and Take Profit in the same market-order request.

The EA uses:

`InpMagicNumber = 123091`

and the trade comment:

`EA-091`

---

## 6. Position Protection

### Stop Loss

Default:

`InpStopLoss = 300`

### Take Profit

Default:

`InpTakeProfit = 600`

### Break Even

Default:

`InpUseBreakEven = true`

Trigger:

`InpBreakEvenTrigger = 150`

Offset:

`InpBreakEvenOffset = 0`

### Trailing Stop

Default:

`InpUseTrailingStop = true`

Start:

`InpTrailingStart = 200`

Distance:

`InpTrailingDistance = 100`

Step:

`InpTrailingStep = 10`

Position management is performed on every tick.

---

## 7. Trade Safety

The EA prevents a new entry when:

* A position belonging to the same Magic Number already exists.
* An order belonging to the same Magic Number already exists.
* On netting accounts, another position already exists on the same symbol.
* Trading is not permitted.
* Spread exceeds the configured maximum.
* Broker trading restrictions prevent the requested order.

The EA does not automatically retry a failed entry request on the following candle.

Signal evaluation is tied to the newly detected candle, while data availability may be retried on subsequent ticks before that candle is considered ready.

---

## 8. Input Parameters

| Parameter           | Default |
| ------------------- | ------: |
| InpLotSize          |    0.01 |
| InpStopLoss         |     300 |
| InpTakeProfit       |     600 |
| InpMagicNumber      |  123091 |
| InpSlippage         |      10 |
| InpMaxSpread        |      30 |
| InpTimeframe        |      M1 |
| InpUseBreakEven     |    true |
| InpBreakEvenTrigger |     150 |
| InpBreakEvenOffset  |       0 |
| InpUseTrailingStop  |    true |
| InpTrailingStart    |     200 |
| InpTrailingDistance |     100 |
| InpTrailingStep     |      10 |
| InpVWAPMinBars      |      20 |
| InpATRPeriod        |      14 |
| InpVWAPDeviationATR |     1.0 |

---

## 9. Current Backtest Reference

The accompanying Strategy Tester report uses:

* Symbol: XAUUSD.PRO
* Timeframe: M1
* Period: 2026.01.02 – 2026.03.31
* Initial deposit: USD 1,000
* Leverage: 1:500
* History quality: 100% real ticks

The tested input configuration is documented in the Backtest directory.

---

## 10. Status

This README documents the EA implementation and the supplied backtest.

The supplied backtest result is not treated as evidence of future profitability.

Further research should test the strategy across additional periods and configurations before any conclusion about robustness is made.
