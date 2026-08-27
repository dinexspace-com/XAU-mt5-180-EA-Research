# EA-028 — Ichimoku Cloud Backtest

## Backtest Status

**Result: ❌ FAIL**

EA-028 was tested on XAUUSD using MetaTrader 5 Strategy Tester with real tick data.

The baseline configuration produced a substantial loss and extremely high drawdown. The current version therefore does **not** demonstrate a viable trading edge under this test configuration.

This result should be retained as the baseline research result rather than discarded or hidden.

---

## Test Configuration

| Setting         | Value                     |
| --------------- | ------------------------- |
| Expert Advisor  | `EA-028_Ichimoku_Cloud`   |
| Symbol          | `XAUUSD.PRO`              |
| Timeframe       | `M1`                      |
| Test Period     | `2026.01.02 – 2026.03.01` |
| Initial Deposit | `$1,000.00`               |
| Currency        | `USD`                     |
| Leverage        | `1:100`                   |
| History Quality | `100% real ticks`         |
| Bars            | `56,115`                  |
| Ticks           | `25,190,686`              |
| Total Trades    | `6,457`                   |

---

## EA Parameters

| Parameter             |  Value |
| --------------------- | -----: |
| `InpLotSize`          |   0.01 |
| `InpStopLoss`         |    300 |
| `InpTakeProfit`       |    600 |
| `InpMagicNumber`      | 123456 |
| `InpSlippage`         |     10 |
| `InpMaxSpread`        |     60 |
| `InpTenkanSen`        |      9 |
| `InpKijunSen`         |     26 |
| `InpSenkouSpanB`      |     52 |
| `InpUseBreakEven`     |   true |
| `InpBreakEvenTrigger` |    150 |
| `InpBreakEvenLevel`   |      0 |
| `InpUseTrailing`      |   true |
| `InpTrailingStart`    |    200 |
| `InpTrailingStep`     |     50 |

---

## Main Results

| Metric                   |                 Result |
| ------------------------ | ---------------------: |
| Initial Deposit          |              $1,000.00 |
| Total Net Profit         |           **-$953.45** |
| Gross Profit             |             $11,123.01 |
| Gross Loss               |            -$12,076.46 |
| Profit Factor            |               **0.92** |
| Expected Payoff          |     **-$0.15 / trade** |
| Recovery Factor          |              **-0.94** |
| Sharpe Ratio             |              **-5.00** |
| Balance Drawdown Maximal | **$1,017.33 (95.62%)** |
| Equity Drawdown Maximal  | **$1,019.42 (95.63%)** |
| LR Correlation           |              **-0.92** |

The EA lost approximately:

```text
$953.45 / $1,000 initial capital
```

or approximately **95.35% of the initial deposit** in net profit terms.

The maximum equity drawdown reached **95.63%**.

---

## Trade Statistics

| Metric                     |         Result |
| -------------------------- | -------------: |
| Total Trades               |          6,457 |
| Total Deals                |         12,914 |
| Winning Trades             | 2,517 (38.98%) |
| Losing Trades              | 3,940 (61.02%) |
| Short Trades               |          2,968 |
| Short Win Rate             |         37.97% |
| Long Trades                |          3,489 |
| Long Win Rate              |         39.84% |
| Largest Profit Trade       |         $32.85 |
| Largest Loss Trade         |        -$43.09 |
| Average Profit Trade       |          $4.42 |
| Average Loss Trade         |         -$3.07 |
| Maximum Consecutive Wins   |              8 |
| Maximum Consecutive Losses |             14 |
| Average Consecutive Wins   |              2 |
| Average Consecutive Losses |              3 |

---

## Position Holding Time

| Metric               |       Result |
| -------------------- | -----------: |
| Minimum Holding Time |     00:00:01 |
| Maximum Holding Time |     03:37:01 |
| Average Holding Time | **00:03:13** |

The strategy generated a high number of relatively short-duration trades on the M1 timeframe.

---

## MFE / MAE Statistics

The Strategy Tester reported:

| Correlation   |  Value |
| ------------- | -----: |
| Profit vs MFE |   0.88 |
| Profit vs MAE |   0.71 |
| MFE vs MAE    | 0.5520 |

These statistics are retained for later analysis of trade management and exit behavior.

They are not sufficient on their own to establish strategy profitability.

---

## Balance Curve

The balance curve shows a strong overall downward trajectory.

Starting from approximately:

```text
$1,000
```

the account progressively loses capital throughout the test and finishes with only a small fraction of the original balance remaining.

There are several temporary recoveries, but none reverse the dominant negative trend.

This is consistent with the reported:

```text
Total Net Profit:        -$953.45
Profit Factor:                0.92
Max Equity Drawdown:         95.63%
LR Correlation:              -0.92
```

The negative LR Correlation is also consistent with the visually declining balance curve.

---

## Key Findings

### 1. Strategy is unprofitable in this baseline test

Profit Factor is:

```text
0.92
```

Gross losses therefore exceed gross profits.

Expected Payoff is also negative:

```text
-$0.15 per trade
```

The tested configuration does not show positive expectancy.

---

### 2. Drawdown is unacceptable

Maximum Equity Drawdown:

```text
95.63%
```

Maximum Balance Drawdown:

```text
95.62%
```

This represents near-total depletion of the test account and is sufficient to reject the current configuration.

---

### 3. Win rate is low

Overall:

```text
Winning trades: 38.98%
Losing trades:  61.02%
```

Long and short performance are similarly weak:

```text
Long win rate:  39.84%
Short win rate: 37.97%
```

The weakness is therefore not isolated to only one trade direction in this test.

---

### 4. Average winner is larger than average loser

The average trade outcomes were:

```text
Average Profit: +$4.42
Average Loss:   -$3.07
```

Therefore, winning trades are larger on average than losing trades.

However, this advantage is insufficient because losing trades occur too frequently.

The final expectancy remains negative.

---

### 5. High trade frequency

The EA generated:

```text
6,457 trades
```

during approximately two months of M1 testing.

Average holding time was only:

```text
3 minutes 13 seconds
```

The strategy therefore behaves as a high-frequency short-duration system relative to the tested timeframe.

This makes entry quality, spread, execution and repeated signals particularly important areas for later investigation.

---

## Baseline Assessment

| Criterion                | Assessment |
| ------------------------ | ---------- |
| Positive Net Profit      | ❌ FAIL     |
| Profit Factor > 1        | ❌ FAIL     |
| Positive Expected Payoff | ❌ FAIL     |
| Acceptable Drawdown      | ❌ FAIL     |
| Positive Sharpe Ratio    | ❌ FAIL     |
| Positive Balance Trend   | ❌ FAIL     |
| Sufficient Trade Sample  | ✅ YES      |
| Real Tick Data           | ✅ YES      |

### Final Baseline Result

# ❌ FAIL

The current EA-028 configuration should **not proceed to live trading** based on this backtest.

The test does, however, provide a useful baseline because it contains a large trade sample using real tick history.

---

## Research Questions Raised

The baseline result suggests that further research should focus on determining **why the Ichimoku signal produces too many losing trades**, rather than immediately optimizing parameters.

Priority questions:

1. Is M1 too noisy for the current Ichimoku entry logic?
2. Does the EA repeatedly enter during weak or sideways market conditions?
3. Would requiring an actual Tenkan/Kijun crossover reduce low-quality entries?
4. Is additional trend confirmation required?
5. Are Break Even and Trailing Stop improving or degrading expectancy?
6. Is the fixed SL/TP appropriate for XAUUSD volatility?
7. How much does the strategy change across M5, M15, H1 and higher timeframes?
8. Are particular trading sessions responsible for disproportionate losses?

These questions belong to the research stage and should **not be treated as proven explanations from this backtest alone**.

---

## Evidence

The baseline test evidence consists of the original MetaTrader 5 Strategy Tester export and its associated charts.

Recommended files to retain in this directory:

```text
Backtest/
└── EA-028_Ichimoku_Cloud/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

Do not replace the original MT5 report when later tests are performed.

New test runs should be preserved separately so that results remain reproducible and comparable.

---

## Conclusion

EA-028 Ichimoku Cloud **fails the baseline backtest** on:

```text
XAUUSD.PRO
M1
2026.01.02 – 2026.03.01
```

The most important results are:

```text
Net Profit        = -$953.45
Profit Factor     = 0.92
Expected Payoff   = -$0.15
Win Rate          = 38.98%
Max Equity DD     = 95.63%
Total Trades      = 6,457
```

The baseline implementation should therefore be classified as:

**Research candidate — not production ready.**

The next stage is to investigate the causes of failure before performing parameter optimization.
