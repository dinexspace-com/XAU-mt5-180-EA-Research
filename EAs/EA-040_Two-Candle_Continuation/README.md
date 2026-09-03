# EA-040 — Two-Candle Continuation

## Overview

**EA-040 Two-Candle Continuation** is a MetaTrader 5 Expert Advisor (EA) designed to trade trend continuation setups based on two consecutive candles moving in the direction of the prevailing trend.

The EA identifies the current trend using a dual Simple Moving Average (SMA) filter. When two consecutive closed candles confirm momentum in the same direction as the detected trend, the EA opens a position with predefined Stop Loss and Take Profit levels.

The strategy also includes spread filtering, Break Even management, and Trailing Stop management.

---

## Strategy Logic

### 1. Trend Detection

The EA determines market direction using two Simple Moving Averages:

* Fast SMA: `20`
* Slow SMA: `50`

Trend classification:

**Bullish trend**

```text
Fast SMA > Slow SMA
```

**Bearish trend**

```text
Fast SMA < Slow SMA
```

If both moving averages are equal, no trading signal is generated.

---

## 2. Two-Candle Confirmation

After determining the trend, the EA checks the previous closed candles.

### BUY Setup

A BUY signal requires:

```text
Fast SMA > Slow SMA
+
Two consecutive bullish closed candles
```

A bullish candle is defined as:

```text
Close > Open
```

If all conditions are satisfied, the EA may open a BUY position.

### SELL Setup

A SELL signal requires:

```text
Fast SMA < Slow SMA
+
Two consecutive bearish closed candles
```

A bearish candle is defined as:

```text
Close < Open
```

If all conditions are satisfied, the EA may open a SELL position.

---

## 3. Entry Execution

Signals are evaluated when a new bar is detected.

The EA will not open a new trade when another position with the same symbol and Magic Number is already active.

Maximum concurrent positions per symbol/Magic Number:

```text
1
```

Before entering a trade, the EA also verifies that the current spread does not exceed the configured maximum spread.

---

## 4. Stop Loss and Take Profit

Default trade protection parameters:

| Parameter                           |    Default |
| ----------------------------------- | ---------: |
| Stop Loss                           | 300 points |
| Take Profit                         | 600 points |
| Risk/Reward based on SL/TP distance |        1:2 |

For BUY positions:

```text
SL = Entry Price - Stop Loss
TP = Entry Price + Take Profit
```

For SELL positions:

```text
SL = Entry Price + Stop Loss
TP = Entry Price - Take Profit
```

---

## 5. Break Even

Break Even protection is enabled by default.

Default configuration:

| Parameter  |    Default |
| ---------- | ---------: |
| Break Even |    Enabled |
| Trigger    | 150 points |
| Shift      |  10 points |

For a BUY position, once profit reaches the Break Even trigger, the Stop Loss can be moved to:

```text
Open Price + 10 points
```

For a SELL position:

```text
Open Price - 10 points
```

This moves the Stop Loss beyond the original entry price once the required profit threshold has been reached.

---

## 6. Trailing Stop

Trailing Stop management is enabled by default.

Default configuration:

| Parameter     |    Default |
| ------------- | ---------: |
| Trailing Stop |    Enabled |
| Trigger       | 200 points |
| Trailing Step |  50 points |

Trailing management begins after the position reaches the configured profit threshold.

For BUY positions, the Stop Loss is moved upward as price advances.

For SELL positions, the Stop Loss is moved downward as price declines.

---

## 7. Spread Filter

The EA prevents new entries when spread exceeds:

```text
30 points
```

Default parameter:

```text
InpMaxSpread = 30
```

This filter is intended to avoid trade execution during excessively wide spread conditions.

---

## Default Parameters

| Parameter           | Default | Description                   |
| ------------------- | ------: | ----------------------------- |
| `InpLotSize`        |    0.01 | Fixed trading volume          |
| `InpStopLoss`       |     300 | Stop Loss in points           |
| `InpTakeProfit`     |     600 | Take Profit in points         |
| `InpMagicNumber`    |  123456 | EA position identifier        |
| `InpSlippage`       |      10 | Maximum execution deviation   |
| `InpMaxSpread`      |      30 | Maximum allowed spread        |
| `InpUseBreakEven`   |    true | Enable Break Even             |
| `InpBreakEvenStart` |     150 | Break Even trigger            |
| `InpBreakEvenShift` |      10 | Break Even shift beyond entry |
| `InpUseTrailing`    |    true | Enable Trailing Stop          |
| `InpTrailingStart`  |     200 | Trailing activation threshold |
| `InpTrailingStep`   |      50 | Trailing distance/step        |
| `InpFastMA`         |      20 | Fast SMA period               |
| `InpSlowMA`         |      50 | Slow SMA period               |

---

## Trading Flow

```text
New Bar
   │
   ▼
Check Spread
   │
   ▼
Manage Existing Position
(Break Even / Trailing Stop)
   │
   ▼
Existing EA Position?
   │
   ├── YES → No New Entry
   │
   └── NO
        │
        ▼
Determine Trend
Fast SMA vs Slow SMA
        │
        ▼
Check Two Consecutive Candles
        │
        ├── Bullish Trend
        │   + 2 Bullish Candles
        │        ↓
        │       BUY
        │
        └── Bearish Trend
            + 2 Bearish Candles
                 ↓
                SELL
```

---

## Platform

* Platform: MetaTrader 5
* Language: MQL5
* EA type: Trend Continuation
* Trend filter: Dual SMA
* Signal: Two consecutive directional candles
* Position sizing: Fixed lot
* Position management: Stop Loss, Take Profit, Break Even, Trailing Stop

---

## Files

```text
EA-040_Two-Candle_Continuation/
├── EA-040_Two-Candle_Continuation.mq5
└── README.md
```

---

## Research Status

This EA should be treated as a **research and backtesting strategy**, not as a validated profitable trading system.

Performance characteristics such as profitability, drawdown, robustness, optimal timeframe, and parameter stability must be established through controlled backtesting and validation.

Backtest results are maintained separately under:

```text
Backtest/
└── EA-040_Two-Candle_Continuation/
```

---

## Disclaimer

This project is intended for research, education, strategy development, and backtesting purposes.

Historical or backtested performance does not guarantee future results. Trading leveraged financial instruments involves substantial risk. Validate the strategy under realistic trading conditions before considering any live deployment.
