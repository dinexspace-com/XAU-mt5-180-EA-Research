# EA-092_VWAP_Bands

## 1. Overview

`EA-092_VWAP_Bands` is an MT5 Expert Advisor for XAUUSD using a daily VWAP band mean-reversion concept on the M1 timeframe.

The EA calculates a daily VWAP and its volume-weighted population standard deviation, then defines upper and lower VWAP bands using a configurable multiplier.

The baseline configuration uses:

* Symbol: XAUUSD.PRO
* Timeframe: M1
* VWAP minimum bars: 20
* VWAP band multiplier: 2.0
* Fixed Stop Loss: 300 points
* Fixed Take Profit: 600 points
* Break-even: enabled
* Trailing Stop: enabled
* Lot size: 0.01

---

## 2. Strategy Concept

The strategy is based on the assumption that sufficiently extended price movements away from daily VWAP may revert toward the VWAP.

The EA therefore monitors:

* Daily VWAP
* Daily VWAP standard deviation
* Upper VWAP band
* Lower VWAP band
* Price movement between completed candles

The bands are calculated as:

```text
Upper Band = VWAP + BandMultiplier × StandardDeviation

Lower Band = VWAP - BandMultiplier × StandardDeviation
```

The VWAP uses typical price:

```text
Typical Price = (High + Low + Close) / 3
```

and tick volume as the weighting factor.

The VWAP calculation uses completed candles and resets at broker midnight.

---

## 3. Buy Signal

A Buy signal is generated when:

1. The previous completed candle was below the lower VWAP band.
2. The latest completed candle moves back above the lower VWAP band.
3. The latest completed candle remains below VWAP.
4. The latest completed candle closes higher than the previous candle.
5. Current market price has not already reached VWAP.

Conceptually:

```text
Previous Close < Lower Band
AND
Current Close > Lower Band
AND
Current Close < VWAP
AND
Current Close > Previous Close
```

The intent is to enter after price begins reverting from an extreme below VWAP.

---

## 4. Sell Signal

A Sell signal is generated when:

1. The previous completed candle was above the upper VWAP band.
2. The latest completed candle moves back below the upper VWAP band.
3. The latest completed candle remains above VWAP.
4. The latest completed candle closes lower than the previous candle.
5. Current market price has not already reached VWAP.

Conceptually:

```text
Previous Close > Upper Band
AND
Current Close < Upper Band
AND
Current Close > VWAP
AND
Current Close < Previous Close
```

The intent is to enter after price begins reverting from an extreme above VWAP.

---

## 5. VWAP Exit

The EA includes a separate VWAP-based exit.

For an existing Buy position:

```text
Bid >= VWAP
```

causes the EA to attempt to close the position.

For an existing Sell position:

```text
Ask <= VWAP
```

causes the EA to attempt to close the position.

This means the VWAP itself acts as a potential mean-reversion exit target in addition to the fixed TP/SL protection.

---

## 6. Entry Protection

Before sending an entry order, the EA checks:

* Trading permissions
* Existing positions
* Existing orders
* Spread
* Symbol trading mode
* Supported order flags
* Stop-loss distance
* Take-profit distance
* Available margin
* Symbol filling mode
* Valid market price

Protective SL and TP are submitted together with the market order.

The EA does not silently increase the requested lot size if the configured lot is invalid for the symbol.

---

## 7. Position Management

### Break-even

Default:

```text
InpUseBreakEven = true
InpBreakEvenTrigger = 150
InpBreakEvenOffset = 0
```

When the position reaches the configured profit threshold, the EA attempts to move the stop loss to break-even.

### Trailing Stop

Default:

```text
InpUseTrailingStop = true
InpTrailingStart = 200
InpTrailingDistance = 100
InpTrailingStep = 10
```

Trailing stop management is performed on every tick.

The EA only accepts a new stop level when it improves the existing stop.

Broker stop and freeze levels are also checked before modifying the position.

---

## 8. Trade Safety

The EA limits exposure by blocking new entries when an existing position/order is detected for the EA magic number.

On netting accounts, the EA also prevents merging with another position on the same symbol.

Entry execution is one-shot for the evaluated candle:

* A signal is evaluated once when the new candle becomes ready.
* If the entry request fails, the EA does not automatically resend the same signal on the following candle.
* Data availability may be retried before the candle is considered ready.

This separates data-readiness retry from trade-entry retry.

---

## 9. Input Parameters

| Parameter               | Default | Description                             |
| ----------------------- | ------: | --------------------------------------- |
| `InpLotSize`            |    0.01 | Trading volume                          |
| `InpStopLoss`           |     300 | Stop Loss in points                     |
| `InpTakeProfit`         |     600 | Take Profit in points                   |
| `InpMagicNumber`        |  123092 | EA magic number                         |
| `InpSlippage`           |      10 | Maximum deviation setting               |
| `InpMaxSpread`          |      30 | Maximum allowed spread in points        |
| `InpTimeframe`          |      M1 | Trading timeframe                       |
| `InpUseBreakEven`       |    true | Enable break-even                       |
| `InpBreakEvenTrigger`   |     150 | Break-even trigger in points            |
| `InpBreakEvenOffset`    |       0 | Break-even offset                       |
| `InpUseTrailingStop`    |    true | Enable trailing stop                    |
| `InpTrailingStart`      |     200 | Trailing activation threshold           |
| `InpTrailingDistance`   |     100 | Trailing distance                       |
| `InpTrailingStep`       |      10 | Minimum trailing improvement            |
| `InpVWAPMinBars`        |      20 | Minimum VWAP bars                       |
| `InpVWAPBandMultiplier` |     2.0 | VWAP band standard-deviation multiplier |

The tester report confirms the baseline parameter values, including magic number `123092` and VWAP band multiplier `2.0`.

---

## 10. Baseline Test

The baseline Strategy Tester run used:

```text
Expert:
EA-092_VWAP_Bands

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026.01.02 - 2026.03.31

History:
100% real ticks

Initial Deposit:
1000 USD

Leverage:
1:500
```

## The report confirms these settings.

## 11. Status

Current status:

```text
Baseline tested
```

The baseline result is negative and should be treated as a research baseline rather than as a production-ready configuration.

The next research work should isolate which component of the VWAP-band entry/exit logic is responsible for the negative expectancy before changing multiple variables simultaneously.
