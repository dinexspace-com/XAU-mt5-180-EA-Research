# EA-027 — Keltner Outer Trend

## 1. Overview

**EA-027_Keltner_Outer_Trend** is a MetaTrader 5 Expert Advisor that implements a trend-following breakout strategy based on the **Keltner Channel**.

The strategy looks for price trading outside the Keltner Channel:

* **BUY** when the current price is above the Upper Band.
* **SELL** when the current price is below the Lower Band.
* No new position is opened while price remains inside the channel.

The EA evaluates new entry signals once per new chart bar while managing existing positions on every tick.

---

## 2. Strategy Logic

### Keltner Channel

The channel is calculated internally by the EA using:

* **Midline:** EMA of closing prices
* **Upper Band:** EMA + ATR × Multiplier
* **Lower Band:** EMA − ATR × Multiplier

Default parameters:

| Parameter         |                 Default |
| ----------------- | ----------------------: |
| Keltner Period    |                      20 |
| ATR Multiplier    |                     2.0 |
| Keltner Timeframe | Current chart timeframe |

Conceptually:

```text
Midline    = EMA(Close, 20)
Upper Band = Midline + 2.0 × ATR
Lower Band = Midline - 2.0 × ATR
```

The EMA and ATR calculations are implemented directly inside the EA rather than using a separate Keltner Channel indicator.

---

## 3. Entry Rules

Entry conditions are evaluated only when a **new chart bar** is detected.

### BUY

A BUY signal is generated when:

```text
Current BID > Upper Keltner Band
```

Before the order is submitted, the EA also requires:

```text
Current Spread <= Maximum Spread
Open EA Positions < Maximum Positions
```

With the default configuration:

```text
Spread <= 30 points
Open positions < 1
```

### SELL

A SELL signal is generated when:

```text
Current BID < Lower Keltner Band
```

The same spread and maximum-position filters must also pass.

### No Trade

No entry signal is generated when:

```text
Lower Band <= Current Price <= Upper Band
```

---

## 4. Position Initialization

### BUY

The EA opens a market BUY using the configured lot size.

Initial protection:

```text
Stop Loss   = Entry Price - StopLoss points
Take Profit = Entry Price + TakeProfit points
```

Default:

```text
Lot Size    = 0.01
Stop Loss   = 300 points
Take Profit = 600 points
```

### SELL

The EA opens a market SELL.

Initial protection:

```text
Stop Loss   = Entry Price + StopLoss points
Take Profit = Entry Price - TakeProfit points
```

Default:

```text
Lot Size    = 0.01
Stop Loss   = 300 points
Take Profit = 600 points
```

---

## 5. Position Management

Existing positions belonging to the EA are managed on every tick.

Positions are identified using both:

* Current symbol
* EA Magic Number

Default Magic Number:

```text
24082601
```

### Break Even

Break Even is enabled by default.

Default trigger:

```text
150 points
```

Once unrealized profit reaches at least 150 points, the EA attempts to move the Stop Loss to the original entry price.

```text
BUY  → SL = Entry Price
SELL → SL = Entry Price
```

No additional profit offset is added.

### Trailing Stop

Trailing Stop is enabled by default.

Default activation level:

```text
200 points
```

After profit reaches the configured threshold, the EA calculates the new Stop Loss as:

```text
BUY:
SL = Current BID - TrailingStart × Point

SELL:
SL = Current ASK + TrailingStart × Point
```

The Stop Loss is only modified when the new level improves the existing Stop Loss.

---

## 6. Trading Filters

### Spread Filter

The EA will not open a new position when:

```text
Current Spread > InpMaxSpread
```

Default:

```text
InpMaxSpread = 30 points
```

### Maximum Positions

The EA counts positions matching:

```text
Current Symbol
+
InpMagicNumber
```

A new trade is rejected when:

```text
Open Positions >= InpMaxPositions
```

Default:

```text
InpMaxPositions = 1
```

This means the default configuration allows only one EA position per symbol for the configured Magic Number.

---

## 7. Input Parameters

### Trading Parameters

| Input            |  Default | Description                       |
| ---------------- | -------: | --------------------------------- |
| `InpLotSize`     |     0.01 | Fixed trading volume              |
| `InpStopLoss`    |      300 | Initial Stop Loss in points       |
| `InpTakeProfit`  |      600 | Initial Take Profit in points     |
| `InpSlippage`    |       10 | Maximum trade deviation in points |
| `InpMagicNumber` | 24082601 | EA Magic Number                   |

### Trading Filters

| Input             | Default | Description                      |
| ----------------- | ------: | -------------------------------- |
| `InpMaxSpread`    |      30 | Maximum allowed spread in points |
| `InpMaxPositions` |       1 | Maximum number of EA positions   |

### Position Management

| Input                 | Default | Description                            |
| --------------------- | ------: | -------------------------------------- |
| `InpUseBreakEven`     |    true | Enable Break Even                      |
| `InpBreakEvenTrigger` |     150 | Profit threshold for Break Even        |
| `InpUseTrailingStop`  |    true | Enable Trailing Stop                   |
| `InpTrailingStart`    |     200 | Profit threshold and trailing distance |

### Keltner Parameters

| Input                  |        Default | Description                   |
| ---------------------- | -------------: | ----------------------------- |
| `InpKeltnerPeriod`     |             20 | Keltner calculation period    |
| `InpKeltnerMultiplier` |            2.0 | ATR multiplier                |
| `InpKeltnerTF`         | PERIOD_CURRENT | Keltner calculation timeframe |

---

## 8. Execution Flow

The EA follows this sequence:

```text
New Tick
   │
   ├── Detect new chart bar
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
                ├── Calculate Keltner Channel
                │
                ├── Price > Upper Band → BUY
                ├── Price < Lower Band → SELL
                └── Otherwise → No Trade
```

---

## 9. Risk Management

The current implementation uses **fixed-lot position sizing**.

There is currently no:

* Percentage-of-equity risk sizing
* Percentage-of-balance risk sizing
* Volatility-based position sizing
* Daily loss limit
* Maximum drawdown protection
* Trading-session filter

Risk therefore depends directly on:

```text
Lot Size
Stop Loss
Symbol contract specification
Account size
```

These factors should be considered when comparing backtest results across brokers or account configurations.

---

## 10. Implementation Notes

The strategy should be interpreted according to the actual EA implementation.

Important implementation characteristics:

1. Entry signals are evaluated once per new chart bar.
2. Existing positions are managed on every tick.
3. Entry comparison uses the current **BID** price.
4. BUY execution uses **ASK**.
5. SELL execution uses **BID**.
6. Keltner Channel values are calculated internally.
7. ATR is calculated manually from True Range values.
8. Position sizing is fixed-lot.
9. Spread is measured in MetaTrader **points**.
10. Stop Loss, Take Profit, Break Even and Trailing Stop parameters are also expressed in **points**.

---

## 11. Research Status

```text
Strategy implementation : Complete
Source-code review       : Complete
Backtest                 : Pending / documented separately
Parameter optimization   : Not evaluated here
Forward test             : Not evaluated here
Live validation          : Not evaluated here
```

Performance claims should not be made from the strategy logic alone.

Backtest and validation results should be stored separately under the corresponding research repository structure.

---

## 12. Repository Location

```text
EAs/
└── EA-027_Keltner_Outer_Trend/
    ├── EA-027_Keltner_Outer_Trend.mq5
    └── README.md
```

The `.mq5` file is the authoritative source for the implemented trading logic. This README provides a human-readable description of that implementation.

---

## Disclaimer

This Expert Advisor is provided for **research, development, and backtesting purposes**.

Historical or simulated results do not guarantee future trading performance. Trading leveraged financial instruments involves substantial risk and may result in loss of capital.
