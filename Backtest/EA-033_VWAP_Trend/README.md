# EA-033 — VWAP Trend | Backtest Report

## Test Summary

This directory contains the baseline MetaTrader 5 backtest results for **EA-033_VWAP_Trend**.

The purpose of this test is to evaluate the original VWAP Trend implementation under historical XAUUSD market conditions before further strategy modification or optimization.

**Result: FAIL**

The tested configuration does not demonstrate a profitable or deployable trading strategy.

---

## Test Environment

| Setting         | Value                   |
| --------------- | ----------------------- |
| Expert Advisor  | `EA-033_VWAP_Trend`     |
| Symbol          | `XAUUSD.PRO`            |
| Timeframe       | M1                      |
| Test Period     | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000                  |
| Currency        | USD                     |
| Leverage        | 1:500                   |
| History Quality | 100% real ticks         |
| Bars            | 86,539                  |
| Ticks           | 40,346,891              |
| Symbols         | 1                       |

The test was executed using MetaTrader 5 Strategy Tester with **100% real tick history quality**.

---

## Tested Parameters

### Order Settings

```text
Lot Size          = 0.01
Stop Loss         = 300 points
Take Profit       = 600 points
Magic Number      = 202411
Slippage          = 10 points
Maximum Spread    = 30 points
Maximum Positions = 1
```

### VWAP Settings

```text
VWAP Period       = 20
VWAP Timeframe    = Current timeframe
```

### Trade Management

```text
Break Even        = Disabled
Trailing Stop     = Disabled
```

Break Even and Trailing Stop parameters remain defined in the EA, but both features were disabled for this baseline test.

---

## Performance Results

| Metric                   |                 Result |
| ------------------------ | ---------------------: |
| Initial Deposit          |              $1,000.00 |
| Total Net Profit         |           **-$992.07** |
| Gross Profit             |              $6,583.69 |
| Gross Loss               |             -$7,575.76 |
| Profit Factor            |               **0.87** |
| Expected Payoff          |             **-$0.28** |
| Recovery Factor          |              **-0.98** |
| Sharpe Ratio             |              **-5.00** |
| Balance Drawdown Maximal | **$1,007.15 (99.22%)** |
| Equity Drawdown Maximal  | **$1,009.95 (99.22%)** |
| LR Correlation           |              **-0.97** |

The strategy lost approximately **99.2% of the initial $1,000 test balance** during the tested period.

The strongly negative LR Correlation is also consistent with the declining balance curve observed in the Strategy Tester report.

---

## Trade Statistics

| Metric               |         Result |
| -------------------- | -------------: |
| Total Trades         |          3,490 |
| Total Deals          |          6,980 |
| Winning Trades       | 1,068 (30.60%) |
| Losing Trades        | 2,422 (69.40%) |
| Short Trades         |          1,727 |
| Short Win Rate       |         28.03% |
| Long Trades          |          1,763 |
| Long Win Rate        |         33.13% |
| Largest Profit Trade |         $35.88 |
| Largest Loss Trade   |        -$42.23 |
| Average Profit Trade |          $6.16 |
| Average Loss Trade   |         -$3.13 |

The average winning trade is approximately twice the size of the average losing trade:

```text
Average Win  = $6.16
Average Loss = $3.13

Average Win / Average Loss ≈ 1.97
```

However, the **30.60% overall win rate was insufficient** to produce positive expectancy under the tested configuration.

---

## Consecutive Results

| Metric                     |             Result |
| -------------------------- | -----------------: |
| Maximum Consecutive Wins   |                  6 |
| Maximum Consecutive Losses |                 15 |
| Maximal Consecutive Profit |  $36.55 (6 trades) |
| Maximal Consecutive Loss   | -$54.86 (8 trades) |
| Average Consecutive Wins   |                  1 |
| Average Consecutive Losses |                  3 |

The strategy experienced substantially longer losing sequences than winning sequences during this test.

---

## Position Holding Time

| Metric               |   Result |
| -------------------- | -------: |
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 03:45:55 |
| Average Holding Time | 00:07:03 |

The strategy therefore behaved as a relatively short-duration trading system in this M1 test, with an average position duration of approximately seven minutes.

---

## MFE / MAE Statistics

MetaTrader 5 reported:

```text
Correlation (Profits, MFE) = 0.82
Correlation (Profits, MAE) = 0.64
Correlation (MFE, MAE)     = 0.3785
```

These statistics are retained as research evidence for later analysis of trade behavior and potential exit-management improvements.

No claim of strategy improvement is made from these correlations alone.

---

## Balance Curve

The balance curve shows a persistent decline across the test.

The account starts with:

```text
$1,000
```

and finishes after a net loss of:

```text
-$992.07
```

This behavior is consistent with the reported:

```text
Profit Factor = 0.87
Expected Payoff = -$0.28
Max Drawdown = 99.22%
LR Correlation = -0.97
```

The baseline configuration therefore does not exhibit a positive historical edge over the tested period.

---

## Baseline Assessment

### Status: ❌ FAIL

The baseline EA does **not** meet minimum requirements for deployment or forward testing in its current configuration.

Primary evidence:

```text
Net Profit       = -$992.07
Profit Factor    = 0.87
Expected Payoff  = -$0.28
Sharpe Ratio     = -5.00
Max Drawdown     = 99.22%
Winning Trades   = 30.60%
LR Correlation   = -0.97
```

The failure is not based on a small trade sample.

The test contains:

```text
3,490 trades
40,346,891 ticks
100% real tick history quality
```

Therefore, this result should be retained as the **baseline research result**, rather than discarded.

---

## Research Interpretation

The test shows that the current VWAP entry logic combined with the tested fixed SL/TP configuration does not produce positive expectancy over this test period.

The average winning trade is materially larger than the average losing trade, but the win rate is too low to compensate for the frequency of losses.

This baseline therefore establishes a useful reference point for subsequent research.

Potential changes or optimizations must be tested against this baseline rather than assumed to improve performance.

---

## Test Limitations

This result applies specifically to:

```text
EA             = EA-033_VWAP_Trend
Symbol         = XAUUSD.PRO
Timeframe      = M1
Period         = 2026-01-02 → 2026-04-01
VWAP Period    = 20
SL             = 300 points
TP             = 600 points
Break Even     = OFF
Trailing Stop  = OFF
Lot Size       = 0.01
```

The report does **not** establish performance:

* on other brokers,
* on other XAUUSD symbol specifications,
* on other timeframes,
* on other historical periods,
* with alternative VWAP periods,
* with Break Even enabled,
* with Trailing Stop enabled,
* or with different SL/TP configurations.

These scenarios require separate tests.

---

## Evidence Files

The complete MetaTrader 5 Strategy Tester output should be retained in this directory together with this README.

Recommended contents:

```text
Backtest/
└── EA-033_VWAP_Trend/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

The HTML report is the primary raw backtest evidence.

The image files contain the Strategy Tester balance, trading-distribution, MFE/MAE, and holding-time visualizations.

---

## Conclusion

**EA-033_VWAP_Trend baseline result: FAIL.**

The original tested configuration produced:

```text
3,490 trades
30.60% winning trades
Profit Factor 0.87
Net Profit -$992.07
Maximum Drawdown 99.22%
```

This configuration should **not be considered validated or production-ready**.

The result is retained as a reproducible baseline for future VWAP Trend research and comparison.

---

## Disclaimer

Backtest results represent historical simulations and do not guarantee future trading performance.

This repository is intended for quantitative research, strategy development, and reproducibility purposes only.
