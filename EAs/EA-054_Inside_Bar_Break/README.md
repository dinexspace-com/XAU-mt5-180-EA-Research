# EA-054 — Inside Bar Break

## Overview

**EA-054 Inside Bar Break** is an MT5 Expert Advisor implementing a price-action breakout strategy based on the **Mother Bar / Inside Bar** structure.

The EA detects a completed Inside Bar contained within the range of the preceding Mother Bar. Once a valid structure is identified, the EA monitors price for a breakout of the Mother Bar range.

* **BUY** when price breaks above the Mother Bar High.
* **SELL** when price breaks below the Mother Bar Low.

The EA includes spread filtering, position limits, fixed Stop Loss / Take Profit, Break Even management, Trailing Stop management, broker stop-level validation, volume normalization, and Magic Number isolation.

---

## Strategy Concept

The strategy uses two completed candles:

```text
Bar[2] = Mother Bar
Bar[1] = Inside Bar
Bar[0] = Current forming bar
```

A valid Inside Bar setup exists when:

```text
Inside Bar High <= Mother Bar High
Inside Bar Low  >= Mother Bar Low
```

Graphically:

```text
        Mother Bar
      ┌─────────────┐
      │             │
High ─┤             ├─ Mother High
      │   ┌─────┐   │
      │   │     │   │
      │   │Inside│   │
      │   │ Bar │   │
      │   └─────┘   │
Low  ─┤             ├─ Mother Low
      │             │
      └─────────────┘
```

The Inside Bar represents price compression inside the previous candle's range.

The EA waits for price to leave the Mother Bar range before entering a trade.

---

## Entry Logic

### BUY

A BUY order is triggered when:

```text
Ask > Mother Bar High
```

Execution logic:

```text
Valid Inside Bar
        ↓
Store Mother Bar High / Low
        ↓
Wait for breakout
        ↓
Ask > Mother High
        ↓
BUY
```

The BUY position is opened at the current market price.

Initial Stop Loss:

```text
Entry Price - InpStopLoss
```

Initial Take Profit:

```text
Entry Price + InpTakeProfit
```

---

### SELL

A SELL order is triggered when:

```text
Bid < Mother Bar Low
```

Execution logic:

```text
Valid Inside Bar
        ↓
Store Mother Bar High / Low
        ↓
Wait for breakout
        ↓
Bid < Mother Low
        ↓
SELL
```

The SELL position is opened at the current market price.

Initial Stop Loss:

```text
Entry Price + InpStopLoss
```

Initial Take Profit:

```text
Entry Price - InpTakeProfit
```

---

## Setup Detection

The EA checks for a new setup whenever a new bar is detected.

A Mother Bar / Inside Bar structure is valid when:

```text
insideHigh <= motherHigh
AND
insideLow >= motherLow
```

When a valid setup is found, the EA stores:

```text
Mother Bar High
Mother Bar Low
Mother Bar Time
```

and resets the breakout trigger state.

If the Inside Bar condition is not satisfied, the current setup is invalidated.

---

## One Trigger Per Setup

The variable:

```text
g_setupTriggered
```

prevents the same Mother Bar setup from repeatedly triggering entries.

After a successful BUY or SELL:

```text
g_setupTriggered = true
```

The EA will wait until a new bar causes a new Mother Bar / Inside Bar structure to be evaluated.

---

## Position Management

Position management runs on **every tick**, independently of new entry detection.

The EA manages only positions matching:

```text
Current Symbol
+
InpMagicNumber
```

This prevents the EA from modifying unrelated positions.

Management features include:

```text
Break Even
Trailing Stop
Maximum Position Limit
```

---

## Break Even

Break Even can be enabled with:

```text
InpUseBreakEven = true
```

Default trigger:

```text
InpBreakEvenTrigger = 150 points
```

When the position reaches the configured profit threshold, the Stop Loss is moved toward the entry price.

For BUY:

```text
New SL =
Open Price + BreakEvenOffset
```

For SELL:

```text
New SL =
Open Price - BreakEvenOffset
```

Default offset:

```text
InpBreakEvenOffset = 0
```

Therefore, with default settings, the EA attempts to move the Stop Loss to the entry price after the Break Even trigger is reached, subject to broker stop-distance requirements.

---

## Trailing Stop

Trailing Stop can be enabled with:

```text
InpUseTrailingStop = true
```

Default activation:

```text
InpTrailingStart = 200 points
```

Default trailing distance:

```text
InpTrailingDistance = 150 points
```

For BUY:

```text
New SL =
Bid - Trailing Distance
```

For SELL:

```text
New SL =
Ask + Trailing Distance
```

The EA only moves the Stop Loss in the direction that reduces risk or locks in additional profit.

It does not intentionally move an existing Stop Loss backward.

---

## Break Even + Trailing Stop Interaction

Break Even and Trailing Stop are designed to operate together.

Once Break Even conditions have been reached, the trailing logic prevents the calculated trailing Stop Loss from moving beyond the configured Break Even level in the unfavorable direction.

For BUY positions:

```text
Trailing SL >= Break Even Price
```

For SELL positions:

```text
Trailing SL <= Break Even Price
```

This helps preserve the protection established by Break Even.

---

## Spread Filter

Before opening a new position, the EA calculates:

```text
Spread =
(Ask - Bid) / _Point
```

A trade is allowed only when:

```text
Spread <= InpMaxSpread
```

Default:

```text
InpMaxSpread = 30 points
```

This filter applies to new entries.

---

## Maximum Positions

The EA counts positions belonging to the current:

```text
Symbol + Magic Number
```

New entries are blocked when:

```text
Current Positions >= InpMaxPositions
```

Default:

```text
InpMaxPositions = 1
```

---

## Broker Protection

The EA reads the broker's minimum stop distance using:

```text
SYMBOL_TRADE_STOPS_LEVEL
```

Stop Loss and Take Profit levels are adjusted when necessary to respect this minimum distance.

The EA also validates Stop Loss modifications before sending them to the broker.

For BUY:

```text
SL < Bid
```

For SELL:

```text
SL > Ask
```

The required broker stop distance must also be satisfied.

---

## Price Normalization

Prices are normalized according to the symbol's:

```text
SYMBOL_TRADE_TICK_SIZE
```

The EA uses:

```text
NormalizePrice()
```

to align order and Stop Loss / Take Profit prices with the symbol's valid tick structure.

---

## Volume Normalization

Requested lot size is validated against:

```text
SYMBOL_VOLUME_MIN
SYMBOL_VOLUME_MAX
SYMBOL_VOLUME_STEP
```

The EA automatically normalizes the requested volume to a broker-supported value before sending an order.

---

## Trading Environment Checks

Before evaluating new entries, the EA verifies:

```text
Terminal connected
Terminal trading allowed
MQL trading allowed
Account trading allowed
Expert Advisor trading allowed
```

If any required trading condition is unavailable, new entries are skipped.

Position management is executed before this entry permission check in `OnTick()`.

---

## Input Parameters

### General Trading Settings

| Parameter         |  Default | Description                                                         |
| ----------------- | -------: | ------------------------------------------------------------------- |
| `InpLotSize`      |   `0.01` | Requested trading volume                                            |
| `InpStopLoss`     |    `300` | Initial Stop Loss in points                                         |
| `InpTakeProfit`   |    `600` | Initial Take Profit in points                                       |
| `InpMagicNumber`  | `123456` | Magic Number used to identify EA positions                          |
| `InpSlippage`     |     `10` | Maximum execution deviation in points                               |
| `InpMaxSpread`    |     `30` | Maximum spread allowed for new entries                              |
| `InpMaxPositions` |      `1` | Maximum number of positions for the current symbol and Magic Number |

### Break Even Settings

| Parameter             | Default | Description                                     |
| --------------------- | ------: | ----------------------------------------------- |
| `InpUseBreakEven`     |  `true` | Enable Break Even                               |
| `InpBreakEvenTrigger` |   `150` | Profit in points required before Break Even     |
| `InpBreakEvenOffset`  |     `0` | Offset from entry price when setting Break Even |

### Trailing Stop Settings

| Parameter             | Default | Description                                      |
| --------------------- | ------: | ------------------------------------------------ |
| `InpUseTrailingStop`  |  `true` | Enable Trailing Stop                             |
| `InpTrailingStart`    |   `200` | Profit in points required before trailing begins |
| `InpTrailingDistance` |   `150` | Trailing distance in points                      |

### Mother Bar Settings

| Parameter             | Default | Description                                        |
| --------------------- | ------: | -------------------------------------------------- |
| `InpRequireInsideBar` |  `true` | Require Bar[1] to be fully contained within Bar[2] |

---

## Default Risk/Reward Structure

With the default parameters:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

The nominal SL-to-TP distance relationship is:

```text
1 : 2
```

This describes only the configured initial SL/TP distances.

Actual trade outcomes can differ because of execution conditions, Break Even, Trailing Stop, spread, slippage, and broker rules.

---

## Execution Flow

```text
OnInit()
   │
   ├── Set Magic Number
   ├── Set Slippage
   ├── Set Symbol Filling Mode
   └── Detect initial Mother Bar
            │
            ▼
         OnTick()
            │
            ├── Manage Existing Positions
            │      ├── Break Even
            │      └── Trailing Stop
            │
            ├── Check Trading Permission
            │
            ├── Detect New Bar
            │      └── Detect Mother Bar / Inside Bar
            │
            ├── Validate Setup
            ├── Check Maximum Positions
            ├── Check Spread
            │
            └── Check Breakout
                   │
             ┌─────┴─────┐
             │           │
      Break High     Break Low
             │           │
            BUY         SELL
```

---

## Main Functions

```text
OnInit()
OnTick()

IsNewBar()
IsTradingAllowed()
IsSpreadAllowed()
CountOwnPositions()

DetectMotherBar()
CheckEntry()

OpenBuy()
OpenSell()

ManagePositions()
ManageBreakEven()
ManageTrailingStop()

ModifyPositionSLTP()

NormalizePrice()
NormalizeVolume()
GetMinStopDistance()

IsValidBuySL()
IsValidSellSL()
```

---

## File

```text
EA-054_Inside_Bar_Break.mq5
```

Repository structure:

```text
EAs/
└── EA-054_Inside_Bar_Break/
    ├── EA-054_Inside_Bar_Break.mq5
    └── README.md
```

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
Order API: CTrade
Strategy Type: Price Action / Breakout
Pattern: Mother Bar + Inside Bar
Direction: Long & Short
Position Management: Break Even + Trailing Stop
```

---

## Research Status

This directory contains the implementation of **EA-054 Inside Bar Break**.

Strategy research documentation is maintained separately under:

```text
Research/
```

Backtest evidence and MetaTrader 5 Strategy Tester results are maintained under:

```text
Backtest/EA-054_Inside_Bar_Break/
```

Repository methodology is maintained under:

```text
docs/methodology.md
```

---

## Disclaimer

This Expert Advisor is provided for research, development, and testing purposes.

Historical or backtest performance does not guarantee future results. Trading leveraged financial instruments involves substantial risk.

Always validate the strategy using appropriate historical data, out-of-sample testing, and controlled forward testing before considering live deployment.
