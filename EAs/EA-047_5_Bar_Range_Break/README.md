# EA-047 — 5 Bar Range Break

## Overview

EA-047 is a MetaTrader 5 Expert Advisor implementing a simple price breakout strategy based on the trading range formed by a configurable number of previous completed candles.

The default configuration uses the previous **5 completed bars**.

The EA identifies:

* The highest high of the previous 5 completed candles.
* The lowest low of the previous 5 completed candles.

A BUY signal is generated when the current Ask price breaks above the calculated highest high.

A SELL signal is generated when the current Bid price breaks below the calculated lowest low.

The strategy includes fixed Stop Loss and Take Profit protection together with optional Break Even and Trailing Stop management.

## Strategy Logic

### Breakout Range

At the beginning of a new candle, the EA retrieves the current candle plus the previous completed candles.

The current incomplete candle is excluded from the breakout range calculation.

With the default configuration:

InpBarsCount = 5

The breakout range is calculated from:

Bar 1
Bar 2
Bar 3
Bar 4
Bar 5

where Bar 1 is the most recently completed candle.

The EA calculates:

Highest = Highest High of previous 5 completed bars
Lowest = Lowest Low of previous 5 completed bars

## Entry Rules

### BUY

A BUY order is opened when:

Ask > Highest High of previous 5 completed bars

Additional conditions:

* A new candle must have started.
* Current spread must not exceed `InpMaxSpread`.
* There must be no existing position for the same symbol and Magic Number.

### SELL

A SELL order is opened when:

Bid < Lowest Low of previous 5 completed bars

Additional conditions:

* A new candle must have started.
* Current spread must not exceed `InpMaxSpread`.
* There must be no existing position for the same symbol and Magic Number.

## Important Execution Behavior

The EA evaluates entry conditions only when a **new bar is detected**.

Therefore, this implementation does not continuously monitor intrabar price movement for breakout entries.

The breakout condition is evaluated using the market price available when the EA processes the first tick of a newly detected candle.

This behavior should be considered when interpreting backtest results.

## Position Control

The EA allows only one active position for the combination of:

Current Symbol + Magic Number

Before opening a new trade, the EA checks all open positions.

If a position with the same symbol and Magic Number already exists, no new position is opened.

## Stop Loss

Default:

InpStopLoss = 300 points

For BUY:

SL = Entry Price - Stop Loss

For SELL:

SL = Entry Price + Stop Loss

## Take Profit

Default:

InpTakeProfit = 600 points

For BUY:

TP = Entry Price + Take Profit

For SELL:

TP = Entry Price - Take Profit

The default nominal SL/TP relationship is:

300 : 600
1 : 2

This is the configured distance ratio and should not be interpreted as an expected performance ratio.

## Break Even

Break Even is enabled by default.

InpUseBreakEven = true
InpBreakEvenTrigger = 150
InpBreakEvenLock = 0

When a position reaches at least 150 points of unrealized profit, the EA can move the Stop Loss to the entry price.

With:

InpBreakEvenLock = 0

the new Stop Loss is placed at exact break even.

For BUY:

SL = Open Price + BreakEvenLock

For SELL:

SL = Open Price - BreakEvenLock

A positive `InpBreakEvenLock` can be used to lock additional points beyond the entry price.

## Trailing Stop

Trailing Stop is enabled by default.

InpUseTrailing = true
InpTrailingStart = 200
InpTrailingStep = 50

Trailing management starts when unrealized profit reaches at least 200 points.

For BUY positions:

New SL = Current Bid - InpTrailingStart

For SELL positions:

New SL = Current Ask + InpTrailingStart

The Stop Loss is modified only when the new level improves the existing Stop Loss by at least:

InpTrailingStep = 50 points

## Spread Filter

The EA prevents new processing beyond the spread check when spread exceeds:

InpMaxSpread = 30 points

Spread is calculated as:

(Ask - Bid) / Point

If:

Current Spread > InpMaxSpread

the EA does not continue with position management or entry evaluation on that new-bar execution.

## Default Parameters

| Parameter             | Default | Description                                      |
| --------------------- | ------: | ------------------------------------------------ |
| `InpLotSize`          |    0.01 | Fixed trading volume                             |
| `InpMagicNumber`      |  123456 | EA position identifier                           |
| `InpSlippage`         |      10 | Maximum deviation in points                      |
| `InpStopLoss`         |     300 | Stop Loss distance in points                     |
| `InpTakeProfit`       |     600 | Take Profit distance in points                   |
| `InpUseBreakEven`     |    true | Enable Break Even                                |
| `InpBreakEvenTrigger` |     150 | Profit required before Break Even                |
| `InpBreakEvenLock`    |       0 | Points locked after Break Even                   |
| `InpUseTrailing`      |    true | Enable Trailing Stop                             |
| `InpTrailingStart`    |     200 | Profit threshold / trailing distance             |
| `InpTrailingStep`     |      50 | Minimum SL improvement before modification       |
| `InpMaxSpread`        |      30 | Maximum allowed spread                           |
| `InpBarsCount`        |       5 | Number of completed bars used for breakout range |

## Simplified Algorithm

New bar detected
↓
Get current tick
↓
Check spread
↓
Too high → Stop
↓
Manage existing position
Break Even / Trailing
↓
Existing EA position?
↓
YES → Stop
↓
Load previous bars
↓
Calculate Highest High and Lowest Low of previous 5 completed bars
↓
Ask > Highest?
↓
YES → BUY
↓
Bid < Lowest?
↓
YES → SELL
↓
No trade

## Source File

EA-047_5-Bar_Range_Break.mq5

Language: MQL5
Platform: MetaTrader 5
Version: 1.00

## Repository Structure

EAs/
└── EA-047_5_Bar_Range_Break/
    ├── EA-047_5-Bar_Range_Break.mq5
    └── README.md

## Research Status

Strategy implementation: COMPLETE
Source code: AVAILABLE
Backtest validation: SEE `/Backtest/EA-047/`
Research analysis: SEE `/Research/`
Methodology: SEE `/docs/methodology.md`

Backtest performance should be evaluated separately from the strategy implementation.

No profitability claim is made based solely on the EA source code.

## Disclaimer

This Expert Advisor is provided for research, development, and testing purposes.

Historical backtest results do not guarantee future trading performance. Trading leveraged financial instruments involves significant risk.

Always validate the strategy under appropriate historical data, spread, execution, and broker conditions before considering live deployment.
