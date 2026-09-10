# Expert Advisors (EAs)

This directory contains the MetaTrader 5 Expert Advisors developed and tested as part of the **XAUUSD MT5 EA Research** project.

Each EA is stored in its own directory and includes the MQL5 source code together with strategy-specific documentation.

## EA Directory

| ID     | Strategy        | Platform     | Status              |
| ------ | --------------- | ------------ | ------------------- |
| EA-051 | 15-Bar Extremes | MetaTrader 5 | Research / Backtest |

---

## EA-051 — 15-Bar Extremes

**Directory:** `EA-051_15-Bar_Extremes/`

A breakout-based Expert Advisor that identifies price movements beyond the high or low extremes of a 15-bar range.

The EA evaluates the breakout candle and requires the candle to close near the breakout extreme before generating a trading signal.

### Core Logic

**BUY**

A BUY signal may be generated when:

* Price breaks above the previous 15-bar high.
* The breakout candle closes near its high.
* The closing price is within the upper 25% of the breakout candle's range.
* Spread is within the configured maximum.
* No existing position belonging to the EA is open on the symbol.

**SELL**

A SELL signal may be generated when:

* Price breaks below the previous 15-bar low.
* The breakout candle closes near its low.
* The closing price is within the lower 25% of the breakout candle's range.
* Spread is within the configured maximum.
* No existing position belonging to the EA is open on the symbol.

### Trade Management

The current implementation supports:

* Fixed lot size
* Stop Loss
* Take Profit
* Maximum spread filter
* Magic Number
* Slippage/deviation control
* Break Even
* Break Even profit lock
* Trailing Stop
* Trailing step
* Maximum one EA position per symbol

### Source

```text
EA-051_15-Bar_Extremes/
├── EA-051_15-Bar_Extremes.mq5
└── README.md
```

The `.mq5` file contains the MetaTrader 5 Expert Advisor source code.

The strategy-specific `README.md` contains detailed documentation for EA-051.

---

## Repository Structure

```text
EAs/
├── README.md
│
└── EA-051_15-Bar_Extremes/
    ├── EA-051_15-Bar_Extremes.mq5
    └── README.md
```

Additional Expert Advisors can be added using the same structure:

```text
EA-XXX_Strategy_Name/
├── EA-XXX_Strategy_Name.mq5
└── README.md
```

---

## Important

The Expert Advisors in this repository are developed for **research, testing, and strategy evaluation**.

Backtest results should not be interpreted as guarantees of future trading performance.

Strategy performance must be evaluated using the corresponding data and reports stored in the repository's `Backtest/` directory.
