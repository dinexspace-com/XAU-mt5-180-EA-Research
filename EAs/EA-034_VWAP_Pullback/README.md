# EA-034 — VWAP Pullback

## Overview

**EA-034_VWAP_Pullback** is a MetaTrader 5 Expert Advisor implementing a VWAP-based pullback continuation strategy.

The EA calculates an intraday Volume Weighted Average Price (VWAP) and uses the relationship between price and VWAP to identify potential continuation entries.

The current version includes fixed Stop Loss and Take Profit, spread filtering, position limits, Break Even management, and Trailing Stop management.

> **Status:** Research / Backtesting
> This EA is intended for strategy research and testing. No profitability or live-trading performance is implied.

---

## Strategy Concept

The strategy is based on **VWAP (Volume Weighted Average Price)** as an intraday reference price.

General idea:

* Price above VWAP indicates a bullish environment.
* Price below VWAP indicates a bearish environment.
* The EA waits for price to remain close to VWAP.
* A continuation condition determines whether a BUY or SELL signal is generated.

The implementation is intentionally simple and is designed to provide a baseline that can be evaluated through systematic backtesting.

---

## VWAP Calculation

VWAP is calculated manually from the beginning of the current trading day.

For each bar:

```text
Typical Price = (High + Low + Close) / 3

VWAP = Σ(Typical Price × Volume) / Σ(Volume)
```

The EA uses the volume returned by MetaTrader through `iVolume()`.

The calculation scans up to **1,000 bars**, stopping when it reaches data before the start of the current day.

Therefore, the resulting VWAP depends on:

* symbol;
* chart timeframe;
* broker/server time;
* available historical data;
* volume data supplied by the broker.

---

## Entry Logic

Signals are evaluated only when a **new bar** is detected.

### BUY

A BUY signal is generated when:

```text
Previous Close > VWAP
AND
Current Bid >= Previous Close
```

When the VWAP filter is enabled, the current price must also be within:

```text
100 points
```

of VWAP.

Simplified:

```text
Price near VWAP
        ↓
Previous Close > VWAP
        ↓
Current Price >= Previous Close
        ↓
BUY
```

---

### SELL

A SELL signal is generated when:

```text
Previous Close < VWAP
AND
Current Bid <= Previous Close
```

When the VWAP filter is enabled, the current price must also be within **100 points** of VWAP.

Simplified:

```text
Price near VWAP
        ↓
Previous Close < VWAP
        ↓
Current Price <= Previous Close
        ↓
SELL
```

---

## Trade Filters

Before opening a position, the EA checks several conditions.

### Spread Filter

Trading is rejected when:

```text
Current Spread > InpMaxSpread
```

Default:

```text
InpMaxSpread = 30 points
```

### Maximum Positions

The EA limits the number of positions belonging to the current:

* symbol; and
* Magic Number.

Default:

```text
InpMaxPositions = 1
```

### Trading Availability

The EA also requires:

* MetaTrader terminal connection;
* algorithmic trading permission;
* available position capacity.

---

## Stop Loss & Take Profit

Each new trade receives fixed SL and TP distances measured in **points**.

Default values:

| Parameter   |    Default |
| ----------- | ---------: |
| Stop Loss   | 300 points |
| Take Profit | 600 points |

For BUY:

```text
SL = Ask - 300 points
TP = Ask + 600 points
```

For SELL:

```text
SL = Bid + 300 points
TP = Bid - 600 points
```

The default nominal TP:SL distance ratio is therefore:

```text
600 / 300 = 2.0
```

This is only the configured price-distance ratio and does not represent expected strategy performance.

---

## Break Even

Break Even management is enabled by default.

Default configuration:

```text
InpUseBreakEven      = true
InpBreakEvenTrigger  = 150 points
InpBreakEvenLock     = 0 points
```

When a position reaches **+150 points**, the EA attempts to move the Stop Loss to the entry price.

With the default configuration:

```text
New SL = Entry Price
```

For BUY positions, the new Stop Loss is only applied if it improves the existing SL.

For SELL positions, the same principle is applied in the opposite direction.

---

## Trailing Stop

Trailing Stop is enabled by default.

Default configuration:

```text
InpUseTrailingStop = true
InpTrailingStart   = 200 points
InpTrailingStep    = 50 points
```

Trailing management starts after the position has moved at least **200 points** in the profitable direction.

The EA then calculates a Stop Loss approximately **200 points behind the current price**.

Further modifications require at least the configured trailing step:

```text
50 points
```

between the proposed and existing Stop Loss.

---

## Input Parameters

### Main Trading Parameters

| Parameter       | Default | Description                 |
| --------------- | ------: | --------------------------- |
| `InpLotSize`    |    0.01 | Fixed trading volume        |
| `InpStopLoss`   |     300 | Stop Loss in points         |
| `InpTakeProfit` |     600 | Take Profit in points       |
| `InpSlippage`   |      10 | Allowed deviation in points |

### Position Management

| Parameter             | Default | Description                            |
| --------------------- | ------: | -------------------------------------- |
| `InpUseBreakEven`     |    true | Enable Break Even                      |
| `InpBreakEvenTrigger` |     150 | Profit distance before Break Even      |
| `InpBreakEvenLock`    |       0 | Profit locked after Break Even         |
| `InpUseTrailingStop`  |    true | Enable Trailing Stop                   |
| `InpTrailingStart`    |     200 | Profit distance before trailing starts |
| `InpTrailingStep`     |      50 | Minimum trailing adjustment            |

### Trading Filters

| Parameter         | Default | Description                                 |
| ----------------- | ------: | ------------------------------------------- |
| `InpMaxSpread`    |      30 | Maximum permitted spread in points          |
| `InpMaxPositions` |       1 | Maximum positions for symbol + Magic Number |

### EA Identification

| Parameter          | Default | Description                    |
| ------------------ | ------: | ------------------------------ |
| `InpMagicNumber`   |  123456 | EA Magic Number                |
| `InpUseVWAPFilter` |    true | Enable distance-to-VWAP filter |

---

## Execution Flow

The current EA follows this process:

```text
New Tick
   │
   ▼
New Bar?
   │
   ├── No → Stop
   │
   ▼
Update Position Status
   │
   ▼
Check Spread / Trading Conditions
   │
   ▼
Check Position Limit
   │
   ▼
Calculate Intraday VWAP
   │
   ▼
Check VWAP Distance
   │
   ▼
Generate BUY / SELL / No Signal
   │
   ▼
Open Position
   │
   ▼
Manage Break Even
   │
   ▼
Manage Trailing Stop
```

---

## Important Implementation Notes

### 1. Signal evaluation occurs on new bars

The main strategy logic is executed only when `IsNewBar()` returns true.

This reduces repeated signal processing within the same candle.

### 2. Position management also follows the new-bar cycle

In the current implementation, `ManageOpenPositions()` is called after the new-bar check.

Therefore, Break Even and Trailing Stop management are also evaluated on this cycle rather than continuously on every incoming tick.

This behavior should be considered when interpreting backtest results.

### 3. VWAP proximity is currently hard-coded

When `InpUseVWAPFilter = true`, the EA rejects a signal when:

```text
abs(Current Price - VWAP) > 100 points
```

The **100-point threshold is currently hard-coded** and is not exposed as an input parameter.

### 4. VWAP uses broker-provided volume

The calculation uses:

```text
iVolume()
```

Results may therefore vary depending on the volume data supplied by the broker.

### 5. VWAP resets according to server day

The VWAP calculation starts from `00:00` of the day derived from `TimeCurrent()`.

Consequently, broker/server timezone can affect the VWAP calculation and strategy signals.

### 6. Fixed position sizing

The current version uses:

```text
InpLotSize = 0.01
```

There is currently no percentage-risk or account-equity-based position sizing.

---

## Research Questions

EA-034 should be evaluated through backtesting before any conclusions are made.

Important research questions include:

* Does the VWAP continuation condition provide positive expectancy?
* Which timeframe performs best?
* How sensitive is the strategy to the 100-point VWAP distance?
* How sensitive are results to spread?
* Does Break Even improve or reduce expectancy?
* Does Trailing Stop improve risk-adjusted performance?
* How does broker/server timezone affect VWAP signals?
* How stable are results across different market regimes?
* How stable are results across different historical periods?

---

## Backtesting

Backtest evidence for this EA should be stored separately under:

```text
Backtest/
└── EA-034_VWAP_Pullback/
```

Recommended evidence includes:

```text
Strategy Tester report
Trade history
Equity curve
Parameter configuration
Testing period
Timeframe
Broker / data source
Spread assumptions
Key performance metrics
```

No backtest result is included in this README until it has been independently generated and recorded.

---

## File

```text
EAs/
└── EA-034_VWAP_Pullback/
    ├── EA-034_VWAP_Pullback.mq5
    └── README.md
```

Main source:

`EA-034_VWAP_Pullback.mq5`

Platform:

`MetaTrader 5 / MQL5`

---

## Disclaimer

This project is for **research, development, and educational purposes**.

Historical or backtested performance does not guarantee future results. Trading XAUUSD, forex, CFDs, or other leveraged instruments involves substantial financial risk.

The EA should not be considered validated for live trading until it has completed appropriate backtesting, robustness testing, and independent review.
