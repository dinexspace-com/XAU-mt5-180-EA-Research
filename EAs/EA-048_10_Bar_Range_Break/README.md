# EA-048 — 10-Bar Donchian Breakout

## Overview

EA-048 is a MetaTrader 5 Expert Advisor implementing a systematic Donchian Channel breakout strategy.

The EA monitors the highest high and lowest low of the previous 10 bars and attempts to enter a position when price breaks outside this range.

The strategy includes fixed Stop Loss and Take Profit protection, spread filtering, Break Even management, and Trailing Stop management.

## Strategy Logic

The default Donchian lookback period is:

```text
10 bars
```

The channel is calculated from historical bars, excluding the current bar.

### BUY

A BUY signal is generated when:

```text
Current Close > Highest High of previous 10 bars
```

### SELL

A SELL signal is generated when:

```text
Current Close < Lowest Low of previous 10 bars
```

The EA allows only one open position for the current symbol and Magic Number at a time.

## Default Parameters

| Parameter          |    Default | Description                               |
| ------------------ | ---------: | ----------------------------------------- |
| Lot Size           |       0.01 | Fixed trading volume                      |
| Magic Number       |     123456 | EA position identifier                    |
| Slippage           |  10 points | Maximum execution deviation               |
| Donchian Period    |         10 | Channel lookback period                   |
| Max Spread         |  30 points | Maximum permitted spread                  |
| Stop Loss          | 300 points | Initial Stop Loss                         |
| Take Profit        | 600 points | Initial Take Profit                       |
| Use Break Even     |       true | Enable Break Even                         |
| Break Even Trigger | 150 points | Profit required before moving SL to entry |
| Use Trailing Stop  |       true | Enable Trailing Stop                      |
| Trailing Start     | 200 points | Profit threshold for trailing management  |

## Position Management

### Break Even

When enabled, the EA moves the Stop Loss to the entry price after the position reaches the configured Break Even trigger.

Default:

```text
150 points
```

### Trailing Stop

When enabled, trailing management begins after the position reaches the configured profit threshold.

Default:

```text
200 points
```

The Stop Loss is then adjusted as price moves in the profitable direction.

## Spread Filter

Before evaluating a new trading opportunity, the EA checks the current spread.

Trading is skipped when:

```text
Current Spread > Max Spread
```

Default maximum spread:

```text
30 points
```

## Execution

The EA operates on the current chart symbol and timeframe:

```text
Symbol: PERIOD_CURRENT symbol
Timeframe: PERIOD_CURRENT
```

Trading logic is evaluated when a new bar is detected rather than on every incoming tick.

## Risk Notice

This Expert Advisor is provided for research, development, and backtesting purposes.

Historical or backtest performance does not guarantee future results. Trading leveraged financial instruments involves significant risk.

Test the EA in MetaTrader 5 Strategy Tester and on a demo environment before considering live deployment.

## Files

```text
EA-048_10_Bar_Donchian/
├── EA-048_10_Bar_Donchian.mq5
└── README.md
```

## Research Status

```text
EA ID: EA-048
Strategy: 10-Bar Donchian Breakout
Platform: MetaTrader 5
Language: MQL5
Source Code: Available
Backtest: See /Backtest/EA-048_10_Bar_Donchian/
```
