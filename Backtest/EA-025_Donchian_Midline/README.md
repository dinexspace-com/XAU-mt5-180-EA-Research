# EA-025 — Donchian Midline | Backtest

Backtest results for **EA-025_Donchian_Midline** on XAUUSD.

## Test Configuration

| Setting         | Value                   |
| --------------- | ----------------------- |
| Expert Advisor  | EA-025_Donchian_Midline |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Test Period     | 2026-01-02 → 2026-08-24 |
| Initial Deposit | $10,000                 |
| Leverage        | 1:500                   |
| History Quality | 100% real ticks         |
| Bars            | 226,417                 |
| Ticks           | 94,754,023              |

## EA Parameters

| Parameter        |  Value |
| ---------------- | -----: |
| Lot Size         |   0.01 |
| Stop Loss        |    300 |
| Take Profit      |    600 |
| Magic Number     | 123456 |
| Slippage         |     10 |
| Break Even       |   true |
| Break Even Point |    150 |
| Trailing Stop    |   true |
| Trailing Point   |    200 |
| Max Spread       |     30 |
| Donchian Period  |     20 |

## Backtest Results

| Metric               |          Result |
| -------------------- | --------------: |
| Total Net Profit     |  **-$9,994.04** |
| Gross Profit         |      $70,162.18 |
| Gross Loss           |     -$80,156.22 |
| Profit Factor        |        **0.88** |
| Expected Payoff      |      **-$0.27** |
| Sharpe Ratio         |       **-5.00** |
| Recovery Factor      |       **-1.00** |
| Max Balance Drawdown |      **99.94%** |
| Max Equity Drawdown  |      **99.94%** |
| Total Trades         |          37,212 |
| Winning Trades       | 11,442 (30.75%) |
| Losing Trades        | 25,770 (69.25%) |

## Long vs Short

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| Long      | 18,846 |   30.57% |
| Short     | 18,366 |   30.93% |

Performance is similarly weak in both directions, with neither long nor short trades showing a meaningful advantage.

## Trade Statistics

| Metric                     |  Result |
| -------------------------- | ------: |
| Largest Winning Trade      |  $70.38 |
| Largest Losing Trade       | -$75.88 |
| Average Winning Trade      |   $6.13 |
| Average Losing Trade       |  -$3.11 |
| Maximum Consecutive Wins   |       8 |
| Maximum Consecutive Losses |      28 |
| Average Consecutive Wins   |       1 |
| Average Consecutive Losses |       3 |

## Holding Time

| Metric  |   Result |
| ------- | -------: |
| Minimum | 00:00:11 |
| Average | 00:04:37 |
| Maximum | 05:11:41 |

## Result

**Status: FAIL**

The baseline Donchian Midline strategy does not demonstrate a viable trading edge under this test configuration.

Key reasons:

* Net loss of approximately the entire initial deposit.
* Maximum drawdown reached **99.94%**.
* Profit Factor is **0.88**, below the break-even level of 1.0.
* Expected Payoff is negative.
* Sharpe Ratio is negative.
* Only **30.75%** of trades were profitable.
* Both long and short sides produced similarly low win rates.
* The balance curve shows persistent deterioration throughout the test period.

The current version should therefore be treated as a **failed baseline experiment**, not as a production-ready trading strategy.

## Research Value

Although the strategy failed, this backtest remains useful as a research baseline.

It demonstrates that a simple Donchian Midline directional rule with the current SL/TP and trade-management configuration is insufficient on **XAUUSD M1** for the tested period.

The result should be preserved rather than discarded so future strategy variants can be compared against the same baseline.

## Files

```text
Backtest/
└── EA-025_Donchian_Midline/
    ├── README.md
    ├── ReportTester-953688.html
    ├── ReportTester-953688.png
    ├── ReportTester-953688-hst.png
    ├── ReportTester-953688-mfemae.png
    └── ReportTester-953688-holding.png
```

## Balance Curve

![Balance Curve](ReportTester-953688.png)

## Trading Distribution

![Trading Distribution](ReportTester-953688-hst.png)

## MFE / MAE Analysis

![MFE MAE](ReportTester-953688-mfemae.png)

## Holding Time

![Holding Time](ReportTester-953688-holding.png)

## Disclaimer

This backtest is maintained for **research and educational purposes only**.

Historical and backtested results do not guarantee future performance.
