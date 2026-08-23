# EA-019_MACD_Zero_Trend

## 1. Overview

`EA-019_MACD_Zero_Trend` is a MetaTrader 5 Expert Advisor that combines:

* MACD
* MACD zero-line position
* EMA 50 trend filter
* Fixed Stop Loss / Take Profit
* Break-even management
* Trailing Stop
* Spread filtering

The EA evaluates trading signals on a **new bar** and uses values from the **previous closed candle**.

> This README documents the behavior of the current source code. It does not claim that the strategy is profitable or production-ready.

---

## 2. File

Main source file:

```text
EA-019_MACD_Zero_Trend.mq5
```

Repository location:

```text
EAs/
└── EA-019_MACD_Zero_Trend/
    ├── EA-019_MACD_Zero_Trend.mq5
    └── README.md
```

---

## 3. Platform

* Platform: MetaTrader 5
* Language: MQL5
* Trade library: `Trade/Trade.mqh`
* EA version in source: `1.00`

The EA uses the symbol and timeframe of the chart on which it is attached:

```text
Symbol    = _Symbol
Timeframe = _Period
```

Therefore, XAUUSD and the desired timeframe must be selected in MetaTrader 5 before running the EA.

---

## 4. Indicators

### MACD

Default parameters:

```text
Fast EMA   = 12
Slow EMA   = 26
Signal     = 9
Price      = Close
```

MQL5 implementation:

```text
iMACD(_Symbol, _Period, 12, 26, 9, PRICE_CLOSE)
```

The EA reads:

* MACD Main line
* MACD Signal line

### EMA 50

Default parameter:

```text
EMA Period = 50
Price      = Close
```

MQL5 implementation:

```text
iMA(_Symbol, _Period, 50, 0, MODE_EMA, PRICE_CLOSE)
```

---

## 5. Signal Timing

The EA evaluates entries only when a **new candle begins**.

Trading conditions are calculated from candle:

```text
[1] = previous closed candle
```

The current forming candle `[0]` is not used for entry decisions.

This helps avoid opening positions based on incomplete candle data.

---

## 6. BUY Logic

A BUY signal occurs when all three conditions are true:

```text
MACD Main > 0
AND
MACD Main > MACD Signal
AND
Close[1] > EMA50[1]
```

Interpretation:

1. MACD is above the zero line.
2. MACD Main is above its Signal line.
3. Price is above EMA50.

This represents bullish MACD momentum aligned with the EMA50 trend filter.

Simplified:

```text
MACD bullish
+
MACD above zero
+
Price above EMA50
=
BUY
```

---

## 7. SELL Logic

A SELL signal occurs when all three conditions are true:

```text
MACD Main < 0
AND
MACD Main < MACD Signal
AND
Close[1] < EMA50[1]
```

Interpretation:

1. MACD is below the zero line.
2. MACD Main is below its Signal line.
3. Price is below EMA50.

This represents bearish MACD momentum aligned with the EMA50 trend filter.

Simplified:

```text
MACD bearish
+
MACD below zero
+
Price below EMA50
=
SELL
```

---

## 8. Important Signal Behavior

The current code checks the **state** of MACD relative to the Signal line.

It does not explicitly require a fresh MACD crossover on the most recent candle.

For example, BUY uses:

```text
macdMain > macdSignal
```

rather than checking:

```text
Previous MACD Main <= Previous Signal
AND
Current closed MACD Main > Current Signal
```

Therefore, the current EA implements a:

```text
MACD state / trend condition
```

rather than a strict:

```text
MACD crossover event
```

This distinction should be considered during research and backtesting.

---

## 9. Position Rules

The EA checks whether a position using the configured Magic Number already exists.

If such a position exists:

```text
No new position is opened.
```

Instead, the EA manages the existing position using Break Even and Trailing Stop.

Default Magic Number:

```text
123456
```

### Important

Position detection is based on Magic Number.

The current `PositionExists()` logic does not additionally require:

```text
POSITION_SYMBOL == _Symbol
```

Therefore, if the same Magic Number is used by the EA on multiple symbols, an existing position on another symbol may prevent a new position from opening.

For controlled research, use unique Magic Numbers where appropriate.

---

## 10. Default Trading Parameters

| Parameter      |    Default | Description               |
| -------------- | ---------: | ------------------------- |
| Lot Size       |       0.01 | Fixed trading volume      |
| Stop Loss      | 300 points | Initial SL                |
| Take Profit    | 600 points | Initial TP                |
| Magic Number   |     123456 | EA trade identifier       |
| Slippage       |  10 points | Maximum allowed deviation |
| Maximum Spread |  30 points | Entry spread filter       |

The nominal initial reward-to-risk based purely on configured TP and SL is:

```text
TP / SL = 600 / 300 = 2.0
```

or approximately:

```text
1 : 2
```

before considering spread, execution, Break Even or Trailing Stop effects.

---

## 11. Stop Loss

For BUY:

```text
SL = Ask - 300 points
```

For SELL:

```text
SL = Bid + 300 points
```

Default:

```text
InpStopLoss = 300
```

Values are expressed in MetaTrader **points**, not automatically in USD, pips or percentage.

The real price distance therefore depends on the broker's symbol specification.

---

## 12. Take Profit

For BUY:

```text
TP = Ask + 600 points
```

For SELL:

```text
TP = Bid - 600 points
```

Default:

```text
InpTakeProfit = 600
```

As with Stop Loss, this is measured in broker points.

---

## 13. Spread Filter

Before evaluating an entry, the EA calculates:

```text
Spread = (Ask - Bid) / Point
```

If:

```text
Spread > 30 points
```

the EA skips processing for that new bar.

Default:

```text
InpMaxSpread = 30
```

---

## 14. Break Even

Break Even is enabled by default:

```text
InpUseBreakEven = true
```

Trigger:

```text
150 points profit
```

When triggered, the EA moves Stop Loss slightly beyond the entry price.

For BUY:

```text
SL = Entry Price + 10 points
```

For SELL:

```text
SL = Entry Price - 10 points
```

Therefore, the implemented behavior is technically a small locked-profit stop rather than an exact zero-profit stop.

Default:

```text
Break Even Trigger = 150 points
Break Even Offset  = 10 points
```

The 10-point offset is hard-coded in the current source.

---

## 15. Trailing Stop

Trailing Stop is enabled by default:

```text
InpUseTrailing = true
```

Default start/distance parameter:

```text
InpTrailingStart = 200 points
```

For BUY, once price has moved at least 200 points above entry, the EA can place/update SL approximately:

```text
Current Bid - 200 points
```

For SELL:

```text
Current Ask + 200 points
```

Trailing management only runs when the position already has a non-zero Stop Loss.

---

## 16. Account and Volume Checks

Before opening a position, the EA performs basic checks.

### Free Margin

The EA estimates required margin and rejects the trade if available free margin is considered insufficient.

### Broker Lot Limits

The requested lot size is checked against:

```text
SYMBOL_VOLUME_MIN
SYMBOL_VOLUME_MAX
SYMBOL_VOLUME_STEP
```

The lot size is then normalized to the broker's allowed volume step.

Default lot:

```text
0.01
```

---

## 17. Current Input Parameters

```text
InpLotSize       = 0.01

InpStopLoss      = 300
InpTakeProfit    = 600

InpMagicNumber   = 123456
InpSlippage      = 10

InpUseBreakEven  = true
InpBreakEven     = 150

InpUseTrailing   = true
InpTrailingStart = 200

InpMaxSpread     = 30

InpMACDFast      = 12
InpMACDSlow      = 26
InpMACDSignal    = 9

InpEMA50Period   = 50
```

---

## 18. Current Strategy Flow

```text
New candle
    ↓
Refresh market tick
    ↓
Check spread
    ↓
Position with Magic Number already open?
    ├── YES → Manage Break Even / Trailing Stop
    │
    └── NO
         ↓
    Check account conditions
         ↓
    Read MACD + EMA50
         ↓
    Use previous closed candle [1]
         ↓
    ┌───────────────────────────────────┐
    │ MACD > 0                          │
    │ MACD > Signal                     │
    │ Close > EMA50                     │
    └───────────────────────────────────┘
         ↓
        BUY

OR

    ┌───────────────────────────────────┐
    │ MACD < 0                          │
    │ MACD < Signal                     │
    │ Close < EMA50                     │
    └───────────────────────────────────┘
         ↓
        SELL
```

---

## 19. Features Not Present in Current Version

The current source code does not implement:

* News filter
* Trading session filter
* Day-of-week filter
* Daily loss limit
* Daily profit target
* Maximum trades per day
* Percentage-risk lot sizing
* ATR-based SL/TP
* Explicit MACD crossover detection
* Higher-timeframe confirmation
* Partial close
* Maximum consecutive-loss protection
* Equity drawdown protection

These should not be assumed to be part of the strategy unless added and tested separately.

---

## 20. Research Status

Current status:

```text
Strategy implementation available.
Research validation pending.
Backtest validation pending.
Parameter robustness testing pending.
Live / forward-test validation pending.
```

The EA should currently be treated as a **research candidate**, not as a validated trading system.

---

## 21. Backtest Requirement

Performance conclusions must be based on actual MetaTrader 5 backtests.

At minimum, record:

```text
Symbol
Broker / data source
Timeframe
Testing period
Modeling mode
Initial deposit
Leverage
Spread conditions
EA input parameters
Number of trades
Net profit
Profit factor
Expected payoff
Maximum drawdown
Relative drawdown
Win rate
Average win
Average loss
Recovery factor
```

Results should be stored under:

```text
Backtest/
└── EA-019_MACD_Zero_Trend/
```

Do not modify strategy rules based solely on a single profitable backtest.

---

## 22. Known Research Questions

Before considering the EA validated, the following questions should be tested:

1. Which timeframe is appropriate for XAUUSD?
2. Does the EMA50 filter improve results versus MACD alone?
3. Does requiring MACD to be above/below zero improve robustness?
4. Should entry require an actual MACD crossover rather than only Main > Signal / Main < Signal?
5. Are 300-point SL and 600-point TP appropriate across different XAUUSD broker specifications?
6. Does Break Even improve expectancy or prematurely stop profitable trades?
7. Does the current 200-point trailing mechanism improve or reduce performance?
8. How sensitive are results to spread?
9. Does the strategy remain profitable outside the optimization period?
10. Are results stable across different market regimes?

These are research questions only. They should be answered with backtest evidence rather than assumptions.

---

## 23. Disclaimer

This EA is intended for research, development and backtesting.

Historical or backtested performance does not guarantee future results.

Trading leveraged products such as XAUUSD involves substantial financial risk. The EA should not be used with real capital until its behavior, implementation and risk characteristics have been independently reviewed and validated.
