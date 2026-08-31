# EA-035 — HH/HL Structure Backtest

## 1. Overview

This directory contains the MetaTrader 5 Strategy Tester results for:

**EA-035_HH_HL_Structure**

The purpose of this backtest is to evaluate the baseline performance of the EA's HH/HL and LH/LL market-structure strategy under historical XAUUSD data.

This test represents the current baseline implementation and should not be interpreted as a profitable or production-ready configuration.

---

## 2. Backtest Environment

| Parameter | Value |
|---|---|
| Expert Advisor | `EA-035_HH_HL_Structure` |
| Symbol | `XAUUSD.PRO` |
| Timeframe | `M1` |
| Test Period | `2026.01.02 – 2026.04.01` |
| Broker / Company | `ACCM Intl Limited` |
| MT5 Server | `ACCMIntl-Real` |
| MT5 Build | `6140` |
| Account Currency | `USD` |
| Initial Deposit | `$1,000.00` |
| Leverage | `1:500` |
| History Quality | `100% real ticks` |
| Bars | `86,539` |
| Ticks | `40,346,891` |
| Symbols | `1` |

---

## 3. EA Parameters

The following parameters were used for this backtest:

| Parameter | Value |
|---|---:|
| `InpLotSize` | `0.01` |
| `InpStopLoss` | `300` |
| `InpTakeProfit` | `600` |
| `InpMagicNumber` | `123456` |
| `InpSlippage` | `10` |
| `InpMaxSpread` | `35` |
| `InpUseBreakEven` | `false` |
| `InpBreakEvenTrigger` | `150` |
| `InpBreakEvenLock` | `10` |
| `InpUseTrailingStop` | `false` |
| `InpTrailingStart` | `200` |
| `InpTrailingStep` | `50` |

### Important

Break Even and Trailing Stop were disabled during this test:

```text
InpUseBreakEven = false
InpUseTrailingStop = false
```

Therefore, this backtest primarily evaluates the base HH/HL and LH/LL entry logic combined with fixed Stop Loss and Take Profit.

---

## 4. Main Results

| Metric | Result |
|---|---:|
| Initial Deposit | `$1,000.00` |
| Total Net Profit | `-$994.57` |
| Gross Profit | `$13,381.72` |
| Gross Loss | `-$14,376.29` |
| Profit Factor | `0.93` |
| Expected Payoff | `-$0.15` |
| Recovery Factor | `-0.94` |
| Sharpe Ratio | `-5.00` |
| AHPR | `0.9995 (-0.05%)` |
| GHPR | `0.9992 (-0.08%)` |
| LR Correlation | `-0.91` |
| LR Standard Error | `92.61` |

### Result

```text
Initial Deposit: $1,000.00
        ↓
Net Profit: -$994.57
        ↓
Approximately 99.46% of the original deposit lost
```

The tested configuration is clearly unprofitable.

---

## 5. Drawdown

| Metric | Balance | Equity |
|---|---:|---:|
| Absolute Drawdown | `$994.57` | `$994.57` |
| Maximal Drawdown | `$1,062.71 (99.49%)` | `$1,062.71 (99.49%)` |
| Relative Drawdown | `99.49%` | `99.49%` |

The drawdown is the most critical result of this backtest.

```text
Maximum Drawdown = 99.49%
```

This represents near-total account depletion.

The current configuration therefore fails basic capital-preservation requirements.

---

## 6. Trading Statistics

| Metric | Result |
|---|---:|
| Total Trades | `6,651` |
| Total Deals | `13,302` |
| Winning Trades | `2,143 (32.22%)` |
| Losing Trades | `4,508 (67.78%)` |
| Short Trades | `3,374` |
| Short Win Rate | `32.51%` |
| Long Trades | `3,277` |
| Long Win Rate | `31.92%` |

Overall win rate:

```text
32.22%
```

Overall loss rate:

```text
67.78%
```

The BUY and SELL sides perform similarly:

```text
SELL win rate = 32.51%
BUY win rate  = 31.92%
```

There is no strong directional advantage visible between the long and short sides in this test.

---

## 7. Average Winner vs Average Loser

| Metric | Result |
|---|---:|
| Average Profit Trade | `$6.24` |
| Average Loss Trade | `-$3.19` |
| Largest Profit Trade | `$35.88` |
| Largest Loss Trade | `-$42.23` |

The average winning trade is approximately:

```text
$6.24
```

while the average losing trade is approximately:

```text
-$3.19
```

Therefore, average winners are substantially larger than average losers.

However, this advantage is not sufficient to overcome the low win rate.

The result is:

```text
Profit Factor = 0.93
```

Since the Profit Factor is below `1.00`, total losses exceed total profits.

---

## 8. Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | `8` |
| Profit during Maximum Win Sequence | `$50.01` |
| Maximum Consecutive Losses | `30` |
| Loss during Maximum Loss Sequence | `-$92.80` |
| Average Consecutive Wins | `1` |
| Average Consecutive Losses | `3` |

A particularly important result is:

```text
Maximum consecutive losses = 30
```

while:

```text
Maximum consecutive wins = 8
```

The average sequence is also unfavorable:

```text
Average winning streak = 1 trade
Average losing streak  = 3 trades
```

This indicates that losing trades frequently occur in clusters.

---

## 9. Balance Curve

The balance graph shows a persistent long-term decline.

General behavior:

```text
Start
≈ $1,000
   │
   ▼
Progressive decline
   │
   ├── Temporary recoveries
   │
   ▼
Further decline
   │
   ▼
Near account depletion
```

There are several temporary recovery periods, but none establish a sustained upward equity trend.

The negative:

```text
LR Correlation = -0.91
```

is consistent with the strongly declining balance curve observed in this test.

---

## 10. Trade Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | `00:00:06` |
| Maximum Holding Time | `03:45:55` |
| Average Holding Time | `00:03:47` |

The average position remains open for approximately:

```text
3 minutes 47 seconds
```

This confirms that, under the M1 configuration tested here, EA-035 behaves as a short-duration trading strategy.

Some positions remain open substantially longer, with the maximum recorded holding time reaching:

```text
3 hours 45 minutes 55 seconds
```

---

## 11. MFE / MAE Analysis

The Strategy Tester reports:

| Correlation | Value |
|---|---:|
| Profit vs MFE | `0.84` |
| Profit vs MAE | `0.72` |
| MFE vs MAE | `0.5059` |

### MFE

MFE represents Maximum Favorable Excursion — the maximum favorable price movement experienced while a position was open.

```text
Correlation (Profit, MFE) = 0.84
```

The strong positive relationship is expected: trades experiencing larger favorable movement generally produce larger realized profits.

### MAE

MAE represents Maximum Adverse Excursion — the maximum adverse price movement experienced while a position was open.

```text
Correlation (Profit, MAE) = 0.72
```

The MFE/MAE plots should be retained as research artifacts for later analysis of exit behavior and Stop Loss / Take Profit placement.

---

## 12. Entry Distribution

The Strategy Tester distribution charts show that trades occurred across multiple hours of the day.

Trading activity is not restricted to a dedicated market session in this baseline configuration.

Entries occur across:

```text
Asia
Europe
USA
```

The test therefore represents a broad intraday execution profile rather than a session-filtered strategy.

This may be investigated separately in future research, but no conclusion about the best trading session is established by this baseline test alone.

---

## 13. Weekday Distribution

Trades occurred primarily from Monday through Friday, with a small number recorded on Sunday in the Strategy Tester distribution.

The highest entry count in the supplied distribution chart occurs on Thursday.

However, profits and losses are both present throughout the trading week.

The supplied test does not establish a sufficiently strong weekday advantage to justify introducing a weekday filter solely from this result.

---

## 14. Monthly Distribution

The tested period is:

```text
2026.01.02 – 2026.04.01
```

The supplied distribution chart shows most trading activity concentrated in January and February.

Later months contain little or no comparable activity in the chart.

Therefore, monthly comparisons from this test should not be treated as equally sampled performance comparisons.

---

## 15. Baseline Assessment

### Test Status

```text
BACKTEST RESULT: FAIL
```

### Primary reasons

```text
Net Profit       = -$994.57
Profit Factor    = 0.93
Win Rate         = 32.22%
Max Drawdown     = 99.49%
Sharpe Ratio     = -5.00
Recovery Factor  = -0.94
LR Correlation   = -0.91
```

The current baseline implementation does not demonstrate a tradable statistical edge under this test configuration.

---

## 16. What This Test Establishes

Despite the negative financial result, the backtest is useful as a baseline experiment.

It establishes that:

1. The EA executes a large number of HH/HL and LH/LL trades.

2. Both BUY and SELL logic are active.

3. The test contains `6,651` completed trades, providing a substantial baseline sample.

4. The raw HH/HL structure logic alone does not produce positive expectancy under this M1 test configuration.

5. The strategy produces larger average winners than average losers, but the win rate is too low to compensate.

6. Losing trades frequently occur in sequences.

7. The balance curve demonstrates persistent negative performance rather than a single isolated catastrophic event.

---

## 17. Research Interpretation

The most important research conclusion from this test is:

```text
HH + HL
or
LH + LL
alone
≠
sufficient trading edge
```

The EA successfully generates structural trading signals, but the baseline signal definition is not selective enough to produce profitable performance in this test.

The purpose of the next research stage should therefore be to determine whether additional market context can distinguish higher-quality HH/HL and LH/LL structures from low-quality signals.

This backtest should remain unchanged as the baseline against which future variants are compared.

---

## 18. Baseline Configuration

This test should be referenced as:

```text
EA-035
Baseline
XAUUSD.PRO
M1
2026-01-02 → 2026-04-01
SL = 300
TP = 600
Max Spread = 35
Break Even = OFF
Trailing Stop = OFF
Lot = 0.01
```

Future modifications should be tested separately rather than overwriting this baseline result.

---

## 19. Files

Recommended directory structure:

```text
Backtest/
└── EA-035_HH_HL_Structure/
    │
    ├── README.md
    │
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

### Files

`README.md`

Research summary and interpretation of the backtest.

`ReportTester-952747.html`

Original MetaTrader 5 Strategy Tester report containing settings, statistics, orders, deals, and detailed test results.

`ReportTester-952747.png`

Balance curve generated by MetaTrader 5 Strategy Tester.

`ReportTester-952747-hst.png`

Trade distribution statistics by hour, weekday, and month.

`ReportTester-952747-mfemae.png`

MFE / MAE versus realized profit analysis.

`ReportTester-952747-holding.png`

Position holding-time distribution.

---

## 20. Final Conclusion

**EA-035_HH_HL_Structure baseline does not pass profitability or risk requirements.**

The test produced:

```text
6,651 trades
32.22% win rate
Profit Factor 0.93
-$994.57 net result
99.49% maximum drawdown
```

Therefore:

```text
BASELINE
   │
   ├── Technical execution → Tested
   │
   ├── Sample size → 6,651 trades
   │
   ├── Positive expectancy → NO
   │
   ├── Capital preservation → NO
   │
   └── Research baseline → YES
```

### Status

**FAIL — BASELINE STRATEGY IS NOT SUITABLE FOR LIVE TRADING**

The result should be retained as the reference baseline for subsequent EA-035 research and strategy modifications.

---

## Disclaimer

This backtest is a historical simulation and does not guarantee future performance.

Results can be affected by broker specifications, spread, execution conditions, commissions, slippage, historical data, symbol properties, and market regime.

No live-trading suitability should be inferred from this report.
