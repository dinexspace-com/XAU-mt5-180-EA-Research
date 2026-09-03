# EA-039 — Trend Score

## Overview

**EA-039 Trend Score** is an MT5 Expert Advisor designed to trade trend-following opportunities using a multi-factor scoring system.

Instead of relying on a single indicator, the EA combines signals from:

* EMA trend direction
* MACD momentum
* ADX trend strength and directional movement
* Basic price structure

Each component contributes positive or negative points to a total trend score. A trade is opened only when the total score reaches the configured threshold.

The strategy includes spread filtering, position limits, fixed Stop Loss / Take Profit, Break Even, and Trailing Stop management.

---

## Strategy Logic

The EA calculates a directional score from multiple market conditions.

A positive score represents bullish conditions, while a negative score represents bearish conditions.

The maximum theoretical directional score is:

```text
EMA       = ±30
MACD      = ±30
ADX       = ±40
Structure = ±10
----------------
Maximum   = ±110
```

The default trading threshold is:

```text
InpScoreThreshold = 70
```

Therefore:

```text
Score >= +70  → BUY
Score <= -70  → SELL
Otherwise     → NO TRADE
```

---

## 1. EMA Trend Score

The EA uses two Exponential Moving Averages:

```text
Fast EMA = 20
Slow EMA = 50
```

Scoring logic:

```text
EMA Fast > EMA Slow → +30
EMA Fast < EMA Slow → -30
```

This component identifies the primary trend direction.

---

## 2. MACD Momentum Score

Default MACD settings:

```text
Fast EMA   = 12
Slow EMA   = 26
Signal     = 9
```

Bullish scoring:

```text
Bullish MACD crossover → +30
MACD above Signal      → +15
```

Bearish scoring:

```text
Bearish MACD crossover → -30
MACD below Signal      → -15
```

A crossover receives a higher score than simply remaining above or below the signal line.

---

## 3. ADX Trend Strength Score

Default ADX configuration:

```text
ADX Period    = 14
ADX Threshold = 25
```

ADX contributes to the score only when:

```text
ADX > 25
```

Directional scoring:

```text
+DI > -DI → +40
-DI > +DI → -40
```

This gives stronger weighting to markets where directional movement is supported by sufficient trend strength.

---

## 4. Price Structure Score

The EA also evaluates recent price behavior.

Bullish structure:

```text
Close[1] > Close[2]
AND
Close[1] > midpoint of High[1] and Low[1]
```

Result:

```text
+10
```

Bearish structure:

```text
Close[1] < Close[2]
AND
Close[1] < midpoint of High[1] and Low[1]
```

Result:

```text
-10
```

---

## Entry Logic

### BUY

A BUY signal is generated when:

```text
Total Trend Score >= InpScoreThreshold
```

Default:

```text
Score >= +70
```

The EA then opens a market BUY position using the configured lot size, Stop Loss, and Take Profit.

### SELL

A SELL signal is generated when:

```text
Total Trend Score <= -InpScoreThreshold
```

Default:

```text
Score <= -70
```

The EA then opens a market SELL position.

---

## New-Bar Execution

Trading signal evaluation is performed only when a new bar is detected.

This prevents the EA from repeatedly evaluating and opening trades on every incoming tick.

The EA uses the timeframe of the chart on which it is running:

```text
PERIOD_CURRENT
```

Therefore, strategy behavior can vary significantly depending on the selected timeframe.

---

## Spread Filter

Before evaluating a new trade, the EA checks the current spread.

Default:

```text
InpMaxSpread = 30 points
```

If:

```text
Current Spread > Maximum Spread
```

the EA does not open a new trade.

---

## Position Limit

The EA limits the number of simultaneously open positions associated with:

* Current symbol
* EA Magic Number

Default:

```text
InpMaxOpenPositions = 1
```

This prevents multiple positions from being opened by the same EA instance when the configured limit has already been reached.

---

## Risk & Trade Parameters

Default parameters:

| Parameter             | Default | Description                           |
| --------------------- | ------: | ------------------------------------- |
| `InpLotSize`          |    0.01 | Fixed trading lot size                |
| `InpStopLoss`         |     300 | Stop Loss in points                   |
| `InpTakeProfit`       |     600 | Take Profit in points                 |
| `InpMagicNumber`      |  123456 | EA position identifier                |
| `InpSlippage`         |      10 | Maximum trade deviation in points     |
| `InpMaxSpread`        |      30 | Maximum allowed spread in points      |
| `InpMaxOpenPositions` |       1 | Maximum number of EA positions        |
| `InpScoreThreshold`   |      70 | Minimum absolute trend score required |

The default SL/TP configuration gives a nominal ratio of:

```text
Stop Loss   = 300 points
Take Profit = 600 points

SL : TP = 1 : 2
```

Actual monetary risk depends on symbol specifications, lot size, broker conditions, and account configuration.

---

## Break Even

Break Even is enabled by default.

```text
InpUseBreakEven     = true
InpBreakEvenTrigger = 150 points
```

When an open position reaches at least 150 points of profit, the EA attempts to move the Stop Loss to the position's opening price.

---

## Trailing Stop

Trailing Stop is enabled by default.

```text
InpUseTrailingStop = true
InpTrailingStart   = 200 points
InpTrailingStep    = 50 points
```

Trailing management begins after the position reaches at least 200 points of profit.

For BUY positions:

```text
New SL = Current Price - 50 points
```

For SELL positions:

```text
New SL = Current Price + 50 points
```

The Stop Loss is only modified when the new level improves the existing protection.

---

## Default Indicator Parameters

| Indicator | Parameter     | Default |
| --------- | ------------- | ------: |
| EMA       | Fast Period   |      20 |
| EMA       | Slow Period   |      50 |
| MACD      | Fast Period   |      12 |
| MACD      | Slow Period   |      26 |
| MACD      | Signal Period |       9 |
| ADX       | Period        |      14 |
| ADX       | Threshold     |      25 |

---

## Signal Summary

```text
                     EA-039 TREND SCORE
                            │
                            ▼
                     New Bar Detected
                            │
                            ▼
                       Spread OK?
                            │
                            ▼
                  Position Limit OK?
                            │
                            ▼
                  Calculate Trend Score
                            │
          ┌─────────────────┼─────────────────┐
          │                 │                 │
       EMA Score        MACD Score        ADX Score
        ±30              ±30              ±40
          │                 │                 │
          └─────────────────┼─────────────────┘
                            │
                     Structure ±10
                            │
                            ▼
                       Total Score
                            │
             ┌──────────────┼──────────────┐
             ▼              ▼              ▼
          >= +70        -69 to +69       <= -70
             │              │              │
             ▼              ▼              ▼
            BUY          NO TRADE          SELL
```

---

## File Structure

```text
EAs/
└── EA-039_Trend_Score/
    ├── EA-039_Trend_Score.mq5
    └── README.md
```

---

## Platform

```text
Platform: MetaTrader 5
Language: MQL5
EA Type: Trend Following / Multi-Factor Scoring
Execution: New Bar
Position Sizing: Fixed Lot
```

---

## Research Status

EA-039 is part of the **XAUUSD MT5 EA Research** repository.

The source code defines the strategy implementation. Performance claims should not be made from the strategy logic alone.

Backtest results should be evaluated separately using standardized testing conditions before drawing conclusions regarding:

* profitability,
* drawdown,
* robustness,
* expected return,
* win rate,
* or suitability for live trading.

See the corresponding backtest package for empirical performance results.

---

## Disclaimer

This Expert Advisor is provided for research, development, and testing purposes.

Historical backtest results do not guarantee future performance. Trading leveraged financial instruments involves substantial risk. Strategy behavior may vary due to spread, execution, slippage, broker specifications, market regime, timeframe, and other trading conditions.
