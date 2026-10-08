# EA-103 — EMA20 + RSI

## Strategy Overview

EA-103 is an XAUUSD M1 mean-reversion strategy combining:

* EMA20
* RSI14
* RSI oversold / overbought levels
* Minimum distance from EMA
* Fixed Stop Loss / Take Profit
* Break Even
* Trailing Stop

The strategy attempts to identify short-term price extensions away from EMA20 and use RSI extremes as a mean-reversion entry condition.

---

## Entry Logic

### BUY

A BUY signal is generated when:

```text
Close[1] < EMA20[1] - MinimumEMADistance
AND
RSI[1] <= 30
```

### SELL

A SELL signal is generated when:

```text
Close[1] > EMA20[1] + MinimumEMADistance
AND
RSI[1] >= 70
```

The signal is evaluated on the completed candle (`Shift 1`) and executed on a new bar.

---

## Baseline Configuration

| Parameter            |      Value |
| -------------------- | ---------: |
| Symbol               | XAUUSD.PRO |
| Timeframe            |         M1 |
| Lot Size             |       0.01 |
| Stop Loss            | 300 points |
| Take Profit          | 600 points |
| EMA Period           |         20 |
| RSI Period           |         14 |
| RSI Oversold         |         30 |
| RSI Overbought       |         70 |
| Minimum EMA Distance | 100 points |
| Break Even           |    Enabled |
| Break Even Start     | 150 points |
| Break Even Offset    |          0 |
| Trailing Stop        |    Enabled |
| Trailing Start       | 200 points |
| Trailing Distance    | 200 points |
| Maximum Spread       |  30 points |
| Magic Number         |     123458 |

---

## Position Management

The EA includes:

* Initial Stop Loss
* Initial Take Profit
* Break-even protection
* Trailing stop
* Maximum spread filter
* Broker stop-level validation
* One active position per EA magic number
* New-bar signal evaluation

---

## Research Baseline

**Baseline ID:** `EA103-M1-BASELINE-001`

**Baseline Result:** `PASS FOR FURTHER RESEARCH`

The baseline demonstrates positive performance in the tested historical sample, but it has not yet passed out-of-sample, robustness, walk-forward, or forward validation.

**Live Trading:** `NO`
