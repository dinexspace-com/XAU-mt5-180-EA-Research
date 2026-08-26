# EA-026 — Keltner Midline

Expert Advisor for MetaTrader 5 based on the direction of the Keltner Channel midline.

The EA trades when price is positioned on the same side as the direction of the midline:

* **BUY:** Price is above the midline and the midline is rising.
* **SELL:** Price is below the midline and the midline is falling.

The current implementation uses an EMA-based midline calculated internally by the EA.

---

## Strategy Logic

### BUY

A BUY signal is generated when:

```text
Current Price > Current Midline
AND
Current Midline > Previous Midline
```

In other words:

1. Price is above the EMA midline.
2. The EMA midline is rising.
3. Spread and position-limit filters allow a new trade.

---

### SELL

A SELL signal is generated when:

```text
Current Price < Current Midline
AND
Current Midline < Previous Midline
```

In other words:

1. Price is below the EMA midline.
2. The EMA midline is falling.
3. Spread and position-limit filters allow a new trade.

---

## Signal Evaluation

Entry signals are evaluated only when the EA detects a **new bar** on the chart timeframe.

Open positions are managed on every tick for:

* Break Even
* Trailing Stop

This separates entry evaluation from position management and prevents the EA from repeatedly opening trades on every tick of the same candle.

---

## Keltner Midline Calculation

The default Keltner period is:

```text
20
```

The EA calculates the midline internally using an Exponential Moving Average concept based on closing prices.

Default configuration:

```text
Keltner Period:     20
Keltner Multiplier: 2.0
Keltner Timeframe:  Current chart timeframe
```

### Important implementation note

The current version calculates ATR data internally, but the ATR value and `InpKeltnerMultiplier` are not currently used in the BUY/SELL decision.

Therefore, the strategy implemented in version `1.00` should more precisely be understood as:

```text
EMA Midline Direction + Price Position
```

rather than a complete upper/mid/lower Keltner Channel breakout system.

---

## Trade Management

### Stop Loss

Default:

```text
300 points
```

BUY:

```text
SL = Entry Price - 300 points
```

SELL:

```text
SL = Entry Price + 300 points
```

---

### Take Profit

Default:

```text
600 points
```

BUY:

```text
TP = Entry Price + 600 points
```

SELL:

```text
TP = Entry Price - 600 points
```

The default nominal SL/TP ratio is therefore:

```text
1 : 2
```

before considering spread, slippage, Break Even, or Trailing Stop.

---

## Break Even

Break Even is enabled by default.

Default trigger:

```text
150 points
```

Once floating profit reaches the configured trigger, the Stop Loss is moved to the original entry price if this improves the existing Stop Loss.

Default:

```text
Use Break Even:      true
Break Even Trigger:  150 points
```

---

## Trailing Stop

Trailing Stop is enabled by default.

Default activation level:

```text
200 points
```

For BUY positions:

```text
New SL = Current Bid - TrailingStart
```

For SELL positions:

```text
New SL = Current Ask + TrailingStart
```

The Stop Loss is modified only when the new value improves the current Stop Loss.

Default:

```text
Use Trailing Stop: true
Trailing Start:    200 points
```

---

## Trading Filters

### Maximum Spread

The EA rejects new entries when:

```text
Current Spread > InpMaxSpread
```

Default:

```text
30 points
```

---

### Maximum Open Positions

The EA counts positions matching both:

```text
Current Symbol
+
EA Magic Number
```

Default maximum:

```text
1 position
```

This prevents the EA from opening another position for the same symbol and Magic Number while the configured maximum has already been reached.

---

## Input Parameters

### Trading Parameters

| Parameter        |    Default | Description                 |
| ---------------- | ---------: | --------------------------- |
| `InpLotSize`     |     `0.01` | Fixed trading volume        |
| `InpStopLoss`    |      `300` | Stop Loss in points         |
| `InpTakeProfit`  |      `600` | Take Profit in points       |
| `InpSlippage`    |       `10` | Maximum deviation in points |
| `InpMagicNumber` | `24082601` | EA Magic Number             |

### Trading Filters

| Parameter         | Default | Description                                               |
| ----------------- | ------: | --------------------------------------------------------- |
| `InpMaxSpread`    |    `30` | Maximum accepted spread in points                         |
| `InpMaxPositions` |     `1` | Maximum positions for the current symbol and Magic Number |

### Position Management

| Parameter             | Default | Description                                      |
| --------------------- | ------: | ------------------------------------------------ |
| `InpUseBreakEven`     |  `true` | Enable Break Even                                |
| `InpBreakEvenTrigger` |   `150` | Profit in points required to activate Break Even |
| `InpUseTrailingStop`  |  `true` | Enable Trailing Stop                             |
| `InpTrailingStart`    |   `200` | Profit threshold and trailing distance in points |

### Keltner Parameters

| Parameter              |          Default | Description                                                   |
| ---------------------- | ---------------: | ------------------------------------------------------------- |
| `InpKeltnerPeriod`     |             `20` | Midline calculation period                                    |
| `InpKeltnerMultiplier` |            `2.0` | Keltner ATR multiplier; currently not used by the entry logic |
| `InpKeltnerTF`         | `PERIOD_CURRENT` | Timeframe used for Keltner calculation                        |

---

## Position Identification

The EA manages only positions that match:

```text
POSITION_SYMBOL == current chart symbol
AND
POSITION_MAGIC == InpMagicNumber
```

Default Magic Number:

```text
24082601
```

This allows the EA to distinguish its own positions from trades opened manually or by other Expert Advisors.

---

## Execution Flow

```text
OnTick
   │
   ├── Detect new bar
   │
   ├── Manage existing positions
   │     ├── Break Even
   │     └── Trailing Stop
   │
   └── New bar?
         │
         ├── No → Stop entry evaluation
         │
         └── Yes
               │
               ├── Check spread
               ├── Check maximum positions
               ├── Calculate midline
               ├── Determine midline direction
               │
               ├── BUY
               │     Price > Midline
               │     Midline rising
               │
               └── SELL
                     Price < Midline
                     Midline falling
```

---

## File

```text
EA-026_Keltner_Midline.mq5
```

Target platform:

```text
MetaTrader 5 / MQL5
```

EA version:

```text
1.00
```

---

## Research Status

This repository is intended for strategy research and backtesting.

The current source code represents the implementation under study and should not be interpreted as evidence of strategy profitability.

Performance characteristics such as:

* Profit Factor
* Expected Payoff
* Maximum Drawdown
* Win Rate
* Number of Trades
* Recovery Factor
* Stability across periods
* Stability across parameter sets

must be established separately through reproducible backtesting and validation.

---

## Known Implementation Notes

Version `1.00` currently has several characteristics that should be considered when interpreting future backtest results:

1. The strategy uses the **midline only** for entry decisions.
2. ATR is calculated but does not currently affect the entry signal.
3. `InpKeltnerMultiplier` is exposed as an input but does not currently affect trading behavior.
4. There are no upper or lower Keltner Channel entry conditions.
5. Position sizing is fixed rather than risk-percentage based.
6. There is no trading-session filter.
7. There is no news filter.
8. Entry signals are evaluated once per new chart bar.
9. Position management is evaluated on every tick.

These characteristics describe the current implementation and should remain fixed during baseline testing unless a new EA version is explicitly created.

---

## Disclaimer

This Expert Advisor is provided for research, development, and backtesting purposes.

Historical or simulated performance does not guarantee future results. Trading leveraged financial instruments involves significant risk.
