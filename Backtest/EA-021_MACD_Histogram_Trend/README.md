# EA-021 — MACD Histogram Trend — Backtest

## Backtest Overview

This folder contains the MetaTrader 5 Strategy Tester results for:

**EA-021_MACD_Histogram_Trend**

The purpose of this backtest is to evaluate the baseline MACD Histogram Trend strategy on XAUUSD before further strategy development or optimization.

**Backtest status: ❌ FAIL**

The tested configuration is not profitable and is not suitable for live trading in its current form.

---

## Test Environment

| Setting         | Value                       |
| --------------- | --------------------------- |
| Expert Advisor  | EA-021_MACD_Histogram_Trend |
| Symbol          | XAUUSD.PRO                  |
| Timeframe       | M1                          |
| Test Period     | 2026.01.02 – 2026.08.01     |
| Initial Deposit | $1,000                      |
| Currency        | USD                         |
| Leverage        | 1:500                       |
| History Quality | 100% real ticks             |
| Bars            | 205,636                     |
| Ticks           | 87,255,913                  |

---

## Tested Parameters

| Parameter          |      Value |
| ------------------ | ---------: |
| Lot Size           |       0.01 |
| Stop Loss          | 300 points |
| Take Profit        | 600 points |
| Magic Number       |     123456 |
| Slippage           |  10 points |
| Break Even         |   Disabled |
| Trailing Stop      |   Disabled |
| Break Even Trigger | 150 points |
| Trailing Start     | 200 points |
| Trailing Distance  | 200 points |
| Maximum Spread     |  30 points |

This test therefore evaluates the core entry logic with fixed SL/TP and without Break Even or Trailing Stop intervention.

---

## Main Results

| Metric                   |                 Result |
| ------------------------ | ---------------------: |
| Total Net Profit         |           **-$994.28** |
| Gross Profit             |             $16,786.51 |
| Gross Loss               |            -$17,780.79 |
| Profit Factor            |               **0.94** |
| Expected Payoff          |             **-$0.12** |
| Recovery Factor          |              **-0.97** |
| Sharpe Ratio             |              **-5.00** |
| Total Trades             |                  8,367 |
| Winning Trades           |         2,729 (32.62%) |
| Losing Trades            |         5,638 (67.38%) |
| Maximum Balance Drawdown | **$1,026.29 (99.45%)** |
| Maximum Equity Drawdown  | **$1,028.04 (99.45%)** |

---

## Long vs Short

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| Short     |  4,278 |   33.10% |
| Long      |  4,089 |   32.11% |

The poor result is not isolated to only one trade direction.

Both BUY and SELL trades have win rates close to 32–33%.

---

## Trade Characteristics

| Metric                     |  Result |
| -------------------------- | ------: |
| Largest Profit Trade       |  $40.10 |
| Largest Loss Trade         | -$43.71 |
| Average Profit Trade       |   $6.15 |
| Average Loss Trade         |  -$3.15 |
| Maximum Consecutive Wins   |       9 |
| Maximum Consecutive Losses |      18 |
| Average Consecutive Wins   |       1 |
| Average Consecutive Losses |       3 |

Although the average winning trade is larger than the average losing trade, the strategy loses substantially more often than it wins.

This causes the overall expectancy to remain negative.

---

## Position Holding Time

| Metric  |   Result |
| ------- | -------: |
| Minimum | 00:00:01 |
| Maximum | 03:44:00 |
| Average | 00:04:34 |

The strategy therefore behaves as a high-frequency intraday system on the M1 timeframe, with most positions having relatively short holding periods.

---

## MFE / MAE Statistics

MetaTrader 5 reported:

| Correlation   |  Value |
| ------------- | -----: |
| Profit vs MFE |   0.83 |
| Profit vs MAE |   0.70 |
| MFE vs MAE    | 0.4641 |

These statistics are retained as research evidence and may be useful when investigating future exit-management or filtering approaches.

They should not be interpreted as evidence that the current strategy is profitable.

---

## Equity Curve

The balance curve shows a persistent long-term decline.

Starting capital:

```text
$1,000
```

Final net result:

```text
-$994.28
```

The account therefore lost approximately **99.4% of the initial deposit** during the tested period.

This is consistent with the reported maximum drawdown of approximately 99.45%.

---

## Assessment

### ❌ FAIL

The baseline configuration fails the research acceptance test.

Primary evidence:

* Profit Factor is below 1.0
* Expected Payoff is negative
* Net Profit is strongly negative
* Maximum drawdown is approximately 99.45%
* 67.38% of trades are losing trades
* Balance curve shows persistent deterioration
* Both BUY and SELL sides have low win rates

The strategy therefore does **not demonstrate a positive trading edge under this test configuration**.

---

## Research Interpretation

This result is still useful.

The backtest contains **8,367 trades using 100% real tick history**, providing a substantial sample of how the baseline MACD histogram continuation rule behaves under the tested XAUUSD M1 configuration.

The failure establishes a baseline against which future strategy modifications can be compared.

The correct conclusion from this test is:

> The current MACD Histogram Trend entry logic combined with SL 300 / TP 600 does not produce a profitable standalone strategy on XAUUSD.PRO M1 over the tested period.

No claim is made about other timeframes, symbols, parameter configurations, filters, or market periods because they were not evaluated by this backtest.

---

## Backtest Artifacts

The original MetaTrader 5 Strategy Tester report and its generated charts should be preserved in this folder as research evidence.

Recommended structure:

```text
Backtest/
└── EA-021_MACD_Histogram_Trend/
    ├── README.md
    ├── ReportTester-953688.html
    ├── ReportTester-953688.png
    ├── ReportTester-953688-hst.png
    ├── ReportTester-953688-mfemae.png
    └── ReportTester-953688-holding.png
```

These files provide the reproducible evidence behind the metrics summarized in this README.

---

## Conclusion

**EA-021_MACD_Histogram_Trend baseline result: FAIL.**

The EA should remain classified as a research strategy.

This baseline version should **not be used for live trading based on the results of this test**.

Further research should be treated as a separate experiment rather than modifying or hiding this baseline result.
