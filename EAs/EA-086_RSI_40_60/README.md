# EA-086_RSI_40_60

## 1. Overview

EA-086_RSI_40_60 is a MetaTrader 5 Expert Advisor using RSI-based reversal signals on XAUUSD.

The strategy uses RSI(14) with two reference levels:

* Lower level: 40
* Upper level: 60

The EA evaluates the signal once per new bar on the configured timeframe.

## 2. Strategy Logic

### Buy signal

A Buy signal is generated when:

```text
RSI[2] < 40
RSI[1] > RSI[2]
RSI[2] <= RSI[3]
```

This identifies a turn upward after RSI has been below the lower threshold.

### Sell signal

A Sell signal is generated when:

```text
RSI[2] > 60
RSI[1] < RSI[2]
RSI[2] >= RSI[3]
```

This identifies a turn downward after RSI has been above the upper threshold.

The implementation does not require RSI to cross directly through 40 or 60 on the signal bar. The conditions identify a local RSI reversal around the respective threshold zones.

## 3. Entry Execution

The EA:

* Uses market Buy/Sell orders.
* Uses a fixed lot size.
* Applies Stop Loss and Take Profit when the market order is submitted.
* Checks the current spread before entry.
* Checks trading permissions and symbol trading mode.
* Checks available margin.
* Uses the configured Magic Number.
* Prevents multiple positions/orders according to the EA's entry-blocking logic.

## 4. Position Management

The EA supports two independent position-management mechanisms.

### Break Even

Default configuration:

```text
Use Break Even = true
Trigger        = 150 points
Offset         = 0 points
```

Once the position reaches the configured profit trigger, the Stop Loss can be moved toward the entry price.

### Trailing Stop

Default configuration:

```text
Use Trailing Stop = true
Start             = 200 points
Distance          = 100 points
Step              = 10 points
```

The trailing stop is managed on every tick while the EA is active.

## 5. Default Parameters

| Parameter          | Default |
| ------------------ | ------: |
| Lot Size           |    0.01 |
| Stop Loss          |     300 |
| Take Profit        |     600 |
| Magic Number       |  123086 |
| Slippage           |      10 |
| Maximum Spread     |      30 |
| Timeframe          |      M1 |
| Breakout Buffer    |       0 |
| Break Even         |    true |
| Break Even Trigger |     150 |
| Break Even Offset  |       0 |
| Trailing Stop      |    true |
| Trailing Start     |     200 |
| Trailing Distance  |     100 |
| Trailing Step      |      10 |
| RSI Period         |      14 |
| RSI Lower          |      40 |
| RSI Upper          |      60 |

## 6. Technical Notes

The EA uses the configured symbol point size and trade tick size when calculating and normalizing protective prices.

The RSI indicator is created with:

```text
iRSI(_Symbol, InpTimeframe, InpRSIPeriod, PRICE_CLOSE)
```

Signal evaluation uses completed candles rather than the currently forming candle.

The EA initializes its last-bar reference when attached, so it does not immediately enter using an old signal.

## 7. Identification

```text
EA ID:       EA-086_RSI_40_60
Magic Number: 123086
Platform:    MetaTrader 5
Instrument:  XAUUSD
```

## 8. Status

This EA is a research/backtest candidate.

The documented baseline test should be evaluated together with the research and methodology documents before any further parameter changes are made.
