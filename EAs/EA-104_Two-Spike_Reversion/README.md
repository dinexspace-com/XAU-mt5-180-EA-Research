# EA-104 — Two Spike Reversion

## Overview

EA-104 is an experimental XAUUSD intraday mean-reversion Expert Advisor for MetaTrader 5.

The strategy looks for **two consecutive abnormal price spikes in the same direction**, followed by a reversal candle confirming that price has started reverting.

The strategy operates on the **M1 timeframe** and evaluates entry conditions only after a new bar is formed.

---

## Strategy Concept

The EA identifies:

1. Two consecutive bullish spike candles → potential overextension to the upside.
2. Two consecutive bearish spike candles → potential overextension to the downside.
3. A reversal candle confirming the beginning of the opposite move.
4. Entry is executed on the next available tick after the completed reversal candle.

The spike threshold is defined dynamically using ATR.

```text
Spike Range >= ATR × Spike ATR Multiplier
```

Baseline:

```text
ATR Period = 14
Spike ATR Multiplier = 1.5
```

---

## BUY Conditions

A BUY signal requires:

```text
Candle[3] = Bearish spike
AND
Candle[2] = Bearish spike
AND
Candle[1] = Bullish reversal
AND
Close[1] > Close[2]
```

Where:

```text
Bearish spike:
Close < Open
AND
Range >= ATR × SpikeATRMultiplier
```

The logic assumes that two consecutive bearish spikes represent downside overextension and that the following bullish candle confirms an initial upward reversion.

---

## SELL Conditions

A SELL signal requires:

```text
Candle[3] = Bullish spike
AND
Candle[2] = Bullish spike
AND
Candle[1] = Bearish reversal
AND
Close[1] < Close[2]
```

Where:

```text
Bullish spike:
Close > Open
AND
Range >= ATR × SpikeATRMultiplier
```

The logic assumes that two consecutive bullish spikes represent upside overextension and that the following bearish candle confirms an initial downward reversion.

---

## Entry Model

The EA uses completed candles only.

```text
Candle[0] = Current forming candle
Candle[1] = Latest completed candle
Candle[2] = Previous completed candle
Candle[3] = Candle before Candle[2]
```

Entry evaluation occurs only on a new bar.

The EA allows only one open position associated with its magic number.

---

## Baseline Configuration

| Parameter            |   Baseline |
| -------------------- | ---------: |
| Symbol               | XAUUSD.PRO |
| Timeframe            |         M1 |
| Lot Size             |       0.01 |
| Stop Loss            | 300 points |
| Take Profit          | 600 points |
| ATR Period           |         14 |
| Spike ATR Multiplier |        1.5 |
| Max Spread           |  30 points |
| Magic Number         |     123459 |
| Slippage             |         10 |
| Break Even           |    Enabled |
| Break Even Start     | 150 points |
| Break Even Offset    |          0 |
| Trailing Stop        |    Enabled |
| Trailing Start       | 200 points |
| Trailing Distance    | 200 points |

---

## Position Management

The EA uses:

* Initial Stop Loss: 300 points
* Initial Take Profit: 600 points
* Break Even activation: 150 points
* Break Even offset: 0 points
* Trailing Stop activation: 200 points
* Trailing Stop distance: 200 points

Position management is performed on every tick.

---

## Baseline Status

**Baseline ID:** `EA104-M1-BASELINE-001`

**Baseline Result:** `FAIL`

The baseline does not currently demonstrate a positive trading edge.

The EA is therefore:

```text
NOT VALIDATED FOR LIVE TRADING
```

and broad parameter optimization is blocked until controlled research identifies whether the underlying setup contains a stable edge.

---

## Research Direction

The primary research questions are:

1. Spike ATR threshold
2. ATR period
3. Number and sequence of spike candles
4. Reversal candle confirmation
5. Close-location confirmation
6. Spike body/range characteristics
7. BUY vs SELL asymmetry
8. Stop Loss / Take Profit
9. Break Even
10. Trailing Stop
11. Trading session
12. Market regime
13. Out-of-sample validation
14. Robustness and walk-forward testing

---

## Research Principle

EA-104 is treated as a research candidate rather than a production trading system.

The baseline configuration must remain preserved as the reference experiment.

Any subsequent modification must be tested as a controlled experiment against the baseline.
