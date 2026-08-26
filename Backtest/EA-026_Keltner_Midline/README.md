# EA-026 — Keltner Midline Backtest

Baseline backtest results for `EA-026_Keltner_Midline`.

This test is intended to establish the performance of the current EA implementation before optimization or strategy modification.

---

## Test Configuration

| Setting          | Value                     |
| ---------------- | ------------------------- |
| Expert Advisor   | `EA-026_Keltner_Midline`  |
| Symbol           | `XAUUSD.PRO`              |
| Timeframe        | `M1`                      |
| Test Period      | `2026.01.02 – 2026.02.01` |
| Initial Deposit  | `$1,000.00`               |
| Account Currency | `USD`                     |
| Leverage         | `1:500`                   |
| History Quality  | `100% real ticks`         |
| Bars             | `28,715`                  |
| Ticks            | `13,785,469`              |
| Symbols          | `1`                       |

---

## EA Parameters

### Trading

| Parameter        |      Value |
| ---------------- | ---------: |
| `InpLotSize`     |     `0.01` |
| `InpStopLoss`    |      `300` |
| `InpTakeProfit`  |      `600` |
| `InpSlippage`    |       `10` |
| `InpMagicNumber` | `24082601` |

### Filters

| Parameter         | Value |
| ----------------- | ----: |
| `InpMaxSpread`    |  `30` |
| `InpMaxPositions` |   `1` |

### Position Management

| Parameter             |  Value |
| --------------------- | -----: |
| `InpUseBreakEven`     | `true` |
| `InpBreakEvenTrigger` |  `150` |
| `InpUseTrailingStop`  | `true` |
| `InpTrailingStart`    |  `200` |

### Keltner

| Parameter              |                Value |
| ---------------------- | -------------------: |
| `InpKeltnerPeriod`     |                 `20` |
| `InpKeltnerMultiplier` |                `2.0` |
| `InpKeltnerTF`         | `0 / PERIOD_CURRENT` |

---

# Backtest Results

## Overall Performance

| Metric           |            Result |
| ---------------- | ----------------: |
| Initial Deposit  |       `$1,000.00` |
| Total Net Profit |    **`-$996.39`** |
| Gross Profit     |       `$5,027.58` |
| Gross Loss       |      `-$6,023.97` |
| Profit Factor    |        **`0.83`** |
| Expected Payoff  |      **`-$0.20`** |
| Recovery Factor  |       **`-0.97`** |
| Sharpe Ratio     |       **`-5.00`** |
| AHPR             | `0.9993 (-0.07%)` |
| GHPR             | `0.9989 (-0.11%)` |
| LR Correlation   |           `-0.97` |

---

## Drawdown

| Metric                    |               Result |
| ------------------------- | -------------------: |
| Balance Drawdown Absolute |            `$996.39` |
| Balance Drawdown Maximal  | `$1,020.49 (99.65%)` |
| Balance Drawdown Relative |         **`99.65%`** |
| Equity Drawdown Absolute  |            `$996.39` |
| Equity Drawdown Maximal   | `$1,022.58 (99.65%)` |
| Equity Drawdown Relative  |         **`99.65%`** |

The balance curve shows a persistent downward trend across the test.

The strategy effectively loses almost the entire initial deposit during this baseline test.

---

# Trade Statistics

| Metric         |           Result |
| -------------- | ---------------: |
| Total Trades   |          `4,919` |
| Total Deals    |          `9,838` |
| Winning Trades | `2,369 (48.16%)` |
| Losing Trades  | `2,550 (51.84%)` |
| Short Trades   |          `2,477` |
| Short Win Rate |         `46.23%` |
| Long Trades    |          `2,442` |
| Long Win Rate  |         `50.12%` |

The EA generated a very high number of trades during the approximately one-month M1 test period.

---

## Win / Loss Characteristics

| Metric                     |               Result |
| -------------------------- | -------------------: |
| Largest Profit Trade       |             `$35.46` |
| Largest Loss Trade         |            `-$27.62` |
| Average Profit Trade       |              `$2.12` |
| Average Loss Trade         |             `-$2.36` |
| Maximum Consecutive Wins   |        `11 ($26.57)` |
| Maximum Consecutive Losses |       `14 (-$27.35)` |
| Maximal Consecutive Profit |   `$35.46 (1 trade)` |
| Maximal Consecutive Loss   | `-$48.73 (6 trades)` |
| Average Consecutive Wins   |                  `2` |
| Average Consecutive Losses |                  `2` |

A key baseline observation is:

```text
Average Winner = +$2.12
Average Loser  = -$2.36
```

Combined with a win rate below 50%, this produces negative expectancy.

---

# BUY vs SELL

## Long Trades

```text
Trades:   2,442
Win Rate: 50.12%
```

## Short Trades

```text
Trades:   2,477
Win Rate: 46.23%
```

Long trades performed better than short trades by win rate during this test.

However, the current test does not establish that the long side is independently profitable.

---

# Position Holding Time

| Metric               |     Result |
| -------------------- | ---------: |
| Minimum Holding Time | `00:00:02` |
| Maximum Holding Time | `03:32:23` |
| Average Holding Time | `00:03:59` |

The strategy therefore behaves as a high-frequency short-duration intraday system under the tested M1 configuration.

---

# MFE / MAE Statistics

| Metric        | Correlation |
| ------------- | ----------: |
| Profit vs MFE |      `0.95` |
| Profit vs MAE |      `0.63` |
| MFE vs MAE    |    `0.4908` |

The report shows a strong positive relationship between trade profit and Maximum Favorable Excursion (MFE).

These statistics are recorded for later research and should not by themselves be interpreted as evidence that a specific exit modification will improve the strategy.

---

# Baseline Assessment

## Result: FAIL

The current baseline configuration does **not** demonstrate a viable trading strategy.

Primary evidence:

```text
Net Profit       = -$996.39
Profit Factor    = 0.83
Expected Payoff  = -$0.20
Sharpe Ratio     = -5.00
Maximum Drawdown = 99.65%
Winning Trades   = 48.16%
Losing Trades    = 51.84%
```

The balance curve also exhibits a strong and persistent downward trajectory.

---

## Main Findings

### 1. Negative expectancy

The EA loses approximately:

```text
$0.20 per trade
```

on average during this test.

With `4,919` trades, even a relatively small negative expectancy accumulates into a very large total loss.

---

### 2. Profit Factor below 1

```text
Profit Factor = 0.83
```

Gross losses exceed gross profits.

The tested configuration therefore does not currently possess a positive trading edge.

---

### 3. Extremely high drawdown

```text
Maximum Drawdown = 99.65%
```

This is effectively account destruction under the tested conditions.

The configuration is unsuitable for live trading.

---

### 4. Very high trade frequency

```text
4,919 trades
```

were generated during approximately one month of M1 data.

Average holding time was only:

```text
3 minutes 59 seconds
```

This indicates that the current entry logic reacts frequently to short-term price movement.

---

### 5. Average loss exceeds average win

```text
Average Profit = +$2.12
Average Loss   = -$2.36
```

Despite the configured nominal SL/TP relationship, actual trade management through Break Even and Trailing Stop produces a realized payoff distribution different from the nominal SL/TP ratio.

---

### 6. SELL side is weaker by win rate

```text
BUY win rate  = 50.12%
SELL win rate = 46.23%
```

This difference is worth investigating in later research.

It is not sufficient by itself to justify disabling SELL trades.

---

# Research Conclusion

This baseline test successfully establishes that the current version of `EA-026_Keltner_Midline` is **not profitable under the tested configuration**.

This is a valid research result.

The purpose of the baseline is not to demonstrate profitability, but to establish an objective reference point before modifying the strategy.

Current status:

```text
Implementation: WORKING
Backtest:       COMPLETED
Data Quality:   100% REAL TICKS
Baseline Edge:  NOT CONFIRMED
Performance:    FAIL
Live Ready:     NO
```

---

## Important

This baseline should be preserved unchanged.

Future improvements should be tested as separate strategy versions or experiments so their results can be compared against this reference without overwriting the original evidence.

No optimization result should replace this baseline backtest.

---

## Source

MetaTrader 5 Strategy Tester Report:

```text
Expert: EA-026_Keltner_Midline
Symbol: XAUUSD.PRO
Period: M1
Test:   2026.01.02 – 2026.02.01
Model:  100% real ticks
```

---

## Disclaimer

This backtest is a historical simulation and does not guarantee future performance.

The tested configuration produced severe losses and should not be used for live trading based on this result.
