# Backtest — EA-088_Z-Score_2_5

## Test Identification

| Item            | Value                    |
| --------------- | ------------------------ |
| Expert Advisor  | EA-088_Z-Score_2_5       |
| Symbol          | XAUUSD.PRO               |
| Timeframe       | M1                       |
| Test Period     | 2026-01-02 to 2026-03-31 |
| Initial Deposit | USD 1,000                |
| Currency        | USD                      |
| Leverage        | 1:500                    |
| History Quality | 100% real ticks          |
| Bars            | 85,161                   |
| Ticks           | 39,639,179               |
| Symbols         | 1                        |
| Magic Number    | 123088                   |

The tester report records the exact execution inputs, including `InpZPeriod=20` and `InpZThreshold=2.5`.

---

## Test Parameters

```text
InpLotSize=0.01
InpStopLoss=300
InpTakeProfit=600
InpMagicNumber=123088
InpSlippage=10
InpMaxSpread=30
InpTimeframe=1
InpBreakoutBuffer=0

InpUseBreakEven=true
InpBreakEvenTrigger=150
InpBreakEvenOffset=0

InpUseTrailingStop=true
InpTrailingStart=200
InpTrailingDistance=100
InpTrailingStep=10

InpZPeriod=20
InpZThreshold=2.5
```

These values are taken directly from the Strategy Tester report.

---

## Performance Summary

| Metric           |          Result |
| ---------------- | --------------: |
| Total Net Profit | **-123.57 USD** |
| Gross Profit     |    1,717.00 USD |
| Gross Loss       |   -1,840.57 USD |
| Profit Factor    |            0.93 |
| Expected Payoff  |       -0.08 USD |
| Recovery Factor  |           -0.65 |
| Sharpe Ratio     |           -5.00 |
| Initial Deposit  |    1,000.00 USD |

The tester therefore recorded a negative net result for this configuration.

---

## Drawdown

| Metric                    |     Result |
| ------------------------- | ---------: |
| Balance Drawdown Absolute | 178.56 USD |
| Equity Drawdown Absolute  | 178.83 USD |
| Balance Drawdown Maximal  | 188.74 USD |
| Balance Drawdown Maximal  |     18.68% |
| Equity Drawdown Maximal   | 190.04 USD |
| Equity Drawdown Maximal   |     18.79% |

The reported maximum equity drawdown was 18.79%.

---

## Trade Statistics

| Metric         |       Result |
| -------------- | -----------: |
| Total Trades   |        1,484 |
| Total Deals    |        2,968 |
| Profit Trades  | 772 (52.02%) |
| Loss Trades    | 712 (47.98%) |
| Short Trades   |          592 |
| Short Win Rate |       52.70% |
| Long Trades    |          892 |
| Long Win Rate  |       51.57% |

The report records a slightly higher percentage of profitable trades than losing trades, while the overall net result remained negative.

---

## Trade Size Distribution

| Metric               |     Result |
| -------------------- | ---------: |
| Largest Profit Trade |   7.76 USD |
| Largest Loss Trade   | -35.62 USD |
| Average Profit Trade |   2.22 USD |
| Average Loss Trade   |  -2.59 USD |

The average losing trade was larger than the average winning trade in absolute value.

---

## Consecutive Trades

| Metric                     |     Result |
| -------------------------- | ---------: |
| Maximum Consecutive Wins   |         10 |
| Maximum Consecutive Wins   |  27.43 USD |
| Maximum Consecutive Losses |          8 |
| Maximum Consecutive Losses | -19.03 USD |
| Average Consecutive Wins   |          2 |
| Average Consecutive Losses |          2 |

---

## Holding Time

| Metric               |   Result |
| -------------------- | -------: |
| Minimum Holding Time | 00:00:01 |
| Average Holding Time | 00:02:22 |
| Maximum Holding Time | 02:07:01 |

The strategy therefore generated predominantly short-duration positions, while the maximum recorded holding period exceeded two hours.

---

## Additional Tester Statistics

```text
Z-Score              = -0.22 (17.41%)
LR Correlation       = -0.83
LR Standard Error    = 27.67
AHPR                 = 0.9999 (-0.01%)
GHPR                 = 0.9999 (-0.01%)
OnTester result      = 0
Margin Level         = 7717.02%
```

---

## MFE / MAE Correlation

```text
Correlation (Profits,MFE) = 0.87
Correlation (Profits,MAE) = 0.77
Correlation (MFE,MAE)     = 0.4614
```

---

## Baseline Interpretation

The recorded baseline result is:

```text
Net Profit   = -123.57 USD
Profit Factor = 0.93
Max Equity DD = 18.79%
```

Therefore, this exact parameter configuration is recorded as a **negative baseline backtest**.

The result should be retained as the reference point for subsequent research rather than removed or replaced.

Future experiments should be compared against this baseline using the same:

* Symbol
* Timeframe
* Test period
* Initial deposit
* Execution model
* History quality

unless the experiment is explicitly intended to test one of those variables.

---

## Source Report

Original Strategy Tester report:

```text
ReportTester-952747(5).html
```

The original report should remain unchanged in this directory.

---

## Validation Status

```text
Baseline Backtest: YES
Optimization: NOT RECORDED
Out-of-Sample Test: NOT RECORDED
Forward Test: NOT RECORDED
Live Test: NOT RECORDED
```

This document records the historical tester result only.
