# EA-090_EMA50_Distance Backtest

## Test Configuration

| Parameter       |                   Value |
| --------------- | ----------------------: |
| Expert          |   EA-090_EMA50_Distance |
| Symbol          |              XAUUSD.PRO |
| Timeframe       |                      M1 |
| Test Period     | 2026.01.02 - 2026.03.31 |
| Initial Deposit |               1,000 USD |
| Leverage        |                   1:500 |
| History Quality |         100% real ticks |
| Bars            |                  85,161 |
| Ticks           |              39,639,179 |
| Symbols         |                       1 |

The report uses the Strategy Tester configuration recorded in `ReportTester-952747(7).html`.

## EA Parameters

```text
InpLotSize             = 0.01
InpStopLoss            = 300
InpTakeProfit          = 600
InpMagicNumber         = 123090
InpSlippage             = 10
InpMaxSpread            = 30
InpTimeframe            = M1
InpBreakoutBuffer       = 0

InpUseBreakEven         = true
InpBreakEvenTrigger     = 150
InpBreakEvenOffset      = 0

InpUseTrailingStop      = true
InpTrailingStart        = 200
InpTrailingDistance     = 100
InpTrailingStep         = 10

InpEMAPeriod            = 50
InpATRPeriod            = 14
InpDistanceATR          = 1.5
```

These values are recorded in the Strategy Tester report.

## Performance Results

| Metric            |          Result |
| ----------------- | --------------: |
| Total Net Profit  |     -992.55 USD |
| Gross Profit      |    8,024.30 USD |
| Gross Loss        |   -9,016.85 USD |
| Profit Factor     |            0.89 |
| Expected Payoff   |       -0.14 USD |
| Recovery Factor   |           -1.00 |
| Sharpe Ratio      |           -5.00 |
| AHPR              | 0.9995 (-0.05%) |
| GHPR              | 0.9993 (-0.07%) |
| LR Correlation    |           -0.95 |
| LR Standard Error |           75.24 |
| Z-Score           |   1.51 (86.90%) |
| OnTester Result   |               0 |

The report records a negative total net profit for this test period.

## Drawdown

| Drawdown Metric            |     Result |
| -------------------------- | ---------: |
| Balance Drawdown Absolute  | 992.55 USD |
| Equity Drawdown Absolute   | 992.55 USD |
| Balance Drawdown Maximal   | 993.08 USD |
| Balance Drawdown Maximal % |     99.26% |
| Equity Drawdown Maximal    | 994.33 USD |
| Equity Drawdown Maximal %  |     99.26% |
| Balance Drawdown Relative  |     99.26% |
| Equity Drawdown Relative   |     99.26% |

The Strategy Tester report records maximum balance and equity drawdown of approximately 99.26% during this test.

## Trade Statistics

| Metric               |     Result |
| -------------------- | ---------: |
| Total Trades         |      7,170 |
| Total Deals          |     14,340 |
| Short Trades         |      3,970 |
| Short Win Rate       |     49.12% |
| Long Trades          |      3,200 |
| Long Win Rate        |     50.16% |
| Profit Trades        |      3,555 |
| Profit Trade Rate    |     49.58% |
| Loss Trades          |      3,615 |
| Loss Trade Rate      |     50.42% |
| Largest Profit Trade |  11.62 USD |
| Largest Loss Trade   | -38.88 USD |
| Average Profit Trade |   2.26 USD |
| Average Loss Trade   |  -2.49 USD |

The report records a relatively similar number of winning and losing trades, while the average loss is larger in absolute value than the average profit.

## Consecutive Results

| Metric                     |     Result |
| -------------------------- | ---------: |
| Maximum Consecutive Wins   |         11 |
| Maximum Consecutive Losses |         15 |
| Maximum Consecutive Profit |  28.25 USD |
| Maximum Consecutive Loss   | -48.62 USD |
| Average Consecutive Wins   |          2 |
| Average Consecutive Losses |          2 |

The maximum losing sequence was longer than the maximum winning sequence in the reported test.

## Position Holding Time

| Metric               |  Result |
| -------------------- | ------: |
| Minimum Holding Time | 0:00:01 |
| Maximum Holding Time | 3:36:03 |
| Average Holding Time | 0:02:22 |

The majority of the strategy's reported activity is short-duration trading, although the maximum recorded holding time was several hours.

## MFE / MAE Statistics

| Metric                    | Result |
| ------------------------- | -----: |
| Correlation Profits / MFE |   0.92 |
| Correlation Profits / MAE |   0.75 |
| Correlation MFE / MAE     | 0.5562 |

These values are directly reported by the Strategy Tester.

## Backtest Record

Source report:

```text
ReportTester-952747(7).html
```

Test:

```text
EA-090_EMA50_Distance
XAUUSD.PRO
M1
2026.01.02 - 2026.03.31
Initial Deposit: 1,000 USD
History Quality: 100% real ticks
```

## Scope of Interpretation

This README records the result of the supplied Strategy Tester run.

The figures describe this specific test configuration and period only. They should not be interpreted as a guarantee or prediction of future trading performance.
