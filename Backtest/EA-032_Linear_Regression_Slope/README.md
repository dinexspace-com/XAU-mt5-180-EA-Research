# EA-032 — Linear Regression Slope Backtest

## Overview

This folder contains the MetaTrader 5 Strategy Tester results for:

```text
EA-032_Linear_Regression_Slope
```

The purpose of this backtest is to document the historical performance of the current EA implementation under a defined test configuration.

This result should be treated as a research result, not as evidence that the strategy is profitable or suitable for live trading.

---

## Test Configuration

| Setting          | Value                            |
| ---------------- | -------------------------------- |
| Expert Advisor   | `EA-032_Linear_Regression_Slope` |
| Symbol           | `XAUUSD.PRO`                     |
| Timeframe        | `M1`                             |
| Test Period      | `2026.01.02 - 2026.04.01`        |
| Initial Deposit  | `$1,000.00`                      |
| Account Currency | `USD`                            |
| Leverage         | `1:500`                          |
| History Quality  | `100% real ticks`                |
| Bars             | `86,539`                         |
| Ticks            | `40,346,891`                     |
| Symbols          | `1`                              |

---

## EA Parameters

```text
InpLotSize=0.01
InpStopLoss=300
InpTakeProfit=600
InpMagicNumber=123456
InpSlippage=10

InpUseBreakEven=false
InpBreakEvenStart=150
InpBreakEvenShift=10

InpUseTrailing=false
InpTrailingStart=200
InpTrailingStep=50

InpMaxSpread=30
InpRegPeriod=20
InpSensibility=2
```

For this backtest, both Break Even and Trailing Stop were disabled.

---

## Main Results

| Metric                   |                 Result |
| ------------------------ | ---------------------: |
| Initial Deposit          |              $1,000.00 |
| Total Net Profit         |           **-$993.19** |
| Gross Profit             |              $9,883.28 |
| Gross Loss               |            -$10,876.47 |
| Profit Factor            |               **0.91** |
| Expected Payoff          |             **-$0.20** |
| Recovery Factor          |              **-0.94** |
| Sharpe Ratio             |              **-5.00** |
| Maximum Balance Drawdown | **$1,061.45 / 99.36%** |
| Maximum Equity Drawdown  | **$1,061.45 / 99.36%** |
| LR Correlation           |                  -0.86 |
| LR Standard Error        |                 144.27 |

---

## Trade Statistics

| Metric           |     Result |
| ---------------- | ---------: |
| Total Trades     |  **5,039** |
| Total Deals      |     10,078 |
| Winning Trades   |      1,582 |
| Winning Trades % | **31.40%** |
| Losing Trades    |      3,457 |
| Losing Trades %  | **68.60%** |
| Short Trades     |      2,471 |
| Short Win Rate   |     32.17% |
| Long Trades      |      2,568 |
| Long Win Rate    |     30.65% |

---

## Winning vs Losing Trades

### Winning Trades

```text
1,582 / 5,039
31.40%
```

### Losing Trades

```text
3,457 / 5,039
68.60%
```

The backtest produced substantially more losing trades than winning trades.

---

## Trade Payout Characteristics

| Metric               |  Result |
| -------------------- | ------: |
| Largest Profit Trade |  $40.00 |
| Largest Loss Trade   | -$27.60 |
| Average Profit Trade |   $6.25 |
| Average Loss Trade   |  -$3.15 |

The average winning trade was approximately twice the size of the average losing trade.

However, this payoff advantage was not sufficient to offset the low win rate in this test.

---

## Consecutive Trades

| Metric                         |  Result |
| ------------------------------ | ------: |
| Maximum Consecutive Wins       |       8 |
| Maximum Consecutive Win Profit |  $48.57 |
| Maximum Consecutive Losses     |      24 |
| Maximum Consecutive Loss       | -$73.76 |
| Average Consecutive Wins       |       1 |
| Average Consecutive Losses     |       3 |

The test recorded a maximum losing streak of:

```text
24 consecutive trades
```

---

## Position Holding Time

| Metric               | Result     |
| -------------------- | ---------- |
| Minimum Holding Time | `00:00:04` |
| Maximum Holding Time | `04:02:28` |
| Average Holding Time | `00:06:02` |

This indicates that the strategy operated primarily as a short-duration trading system during this M1 test.

---

## MFE / MAE Statistics

MetaTrader reported:

| Correlation   | Result |
| ------------- | -----: |
| Profit vs MFE |   0.84 |
| Profit vs MAE |   0.72 |
| MFE vs MAE    | 0.5199 |

These statistics are retained as part of the original Strategy Tester analysis and should be considered together with individual trade behavior rather than as standalone performance indicators.

---

## Balance Curve

The balance curve shows that the account experienced periods of recovery during the early and middle portions of the test.

However, the overall balance trend subsequently deteriorated and ultimately approached complete depletion of the initial account balance.

The final reported result was:

```text
Initial Deposit: $1,000.00
Net Profit:      -$993.19
```

---

## Backtest Assessment

### Result: FAILED

The current configuration does not meet basic profitability and risk criteria.

Primary reasons:

* Net Profit is negative.
* Profit Factor is below `1.00`.
* Expected Payoff is negative.
* Sharpe Ratio is negative.
* Maximum drawdown reached `99.36%`.
* Losing trades represent `68.60%` of all trades.
* The balance curve shows long-term deterioration.

Therefore, this version should **not** be considered ready for live trading.

---

## Important Interpretation

This backtest evaluates one specific combination of:

```text
EA version
+
XAUUSD.PRO
+
M1 timeframe
+
2026.01.02–2026.04.01
+
current parameter configuration
```

The result does not prove that Linear Regression Slope as a general trading concept is invalid.

It shows that:

```text
the current implementation
+
the current parameters
+
the tested market conditions
```

did not produce an acceptable result in this test.

---

## Files

Recommended contents of this folder:

```text
Backtest/
└── EA-032_Linear_Regression_Slope/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

### `ReportTester-952747.html`

Original MetaTrader 5 Strategy Tester report containing:

* Test configuration
* EA parameters
* Performance statistics
* Orders
* Deals
* Trade history

### `ReportTester-952747.png`

Balance curve generated by MetaTrader 5.

### `ReportTester-952747-hst.png`

Trade activity and profit/loss distribution by:

* Hour
* Weekday
* Month

### `ReportTester-952747-mfemae.png`

Profit relationship with:

* MFE — Maximum Favorable Excursion
* MAE — Maximum Adverse Excursion

### `ReportTester-952747-holding.png`

Relationship between trade profit and position holding duration.

---

## Conclusion

The baseline backtest of `EA-032_Linear_Regression_Slope` on `XAUUSD.PRO M1` produced an unacceptable risk-adjusted result.

Key result:

```text
Net Profit       = -$993.19
Profit Factor    = 0.91
Win Rate         = 31.40%
Max Drawdown     = 99.36%
Total Trades     = 5,039
```

### Research Status

```text
BASELINE BACKTEST: FAIL
```

The current configuration should remain in research status until the strategy logic or parameter configuration is modified and independently retested.

---

## Disclaimer

Backtest results are historical simulations and do not guarantee future performance.

This repository is intended for research and educational purposes only.
