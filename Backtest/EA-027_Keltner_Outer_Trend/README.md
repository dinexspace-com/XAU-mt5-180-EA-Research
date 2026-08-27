# EA-027 — Keltner Outer Trend — Backtest

## 1. Backtest Overview

This folder contains the MetaTrader 5 Strategy Tester results for:

**EA-027_Keltner_Outer_Trend**

The test evaluates the baseline Keltner Outer Trend strategy on **XAUUSD.PRO, M1** using real-tick historical data.

This run is treated as a **baseline research test**, not as evidence that the strategy is suitable for live trading.

---

## 2. Test Environment

| Setting          | Value                      |
| ---------------- | -------------------------- |
| Expert Advisor   | EA-027_Keltner_Outer_Trend |
| Symbol           | XAUUSD.PRO                 |
| Timeframe        | M1                         |
| Test Period      | 2026-01-02 → 2026-03-01    |
| History Quality  | 100% real ticks            |
| Bars             | 56,115                     |
| Ticks            | 25,190,686                 |
| Initial Deposit  | $1,000                     |
| Currency         | USD                        |
| Leverage         | 1:100                      |
| MT5 Build        | 6140                       |
| Broker / Company | ACCM Intl Limited          |

The Strategy Tester report identifies the test as `EA-027_Keltner_Outer_Trend` on `XAUUSD.PRO`, M1, covering January 2 through March 1, 2026.

The test used a $1,000 initial deposit with 1:100 leverage.

Historical data quality was reported as **100% real ticks**, with 56,115 bars and 25,190,686 ticks.

---

## 3. Parameters Used

| Parameter              |                 Value |
| ---------------------- | --------------------: |
| `InpLotSize`           |                  0.01 |
| `InpStopLoss`          |                   300 |
| `InpTakeProfit`        |                   600 |
| `InpSlippage`          |                    10 |
| `InpMagicNumber`       |              24082601 |
| `InpMaxSpread`         |                    45 |
| `InpMaxPositions`      |                     1 |
| `InpUseBreakEven`      |                 false |
| `InpBreakEvenTrigger`  |                   150 |
| `InpUseTrailingStop`   |                 false |
| `InpTrailingStart`     |                   200 |
| `InpKeltnerPeriod`     |                    20 |
| `InpKeltnerMultiplier` |                   2.0 |
| `InpKeltnerTF`         | 0 / Current Timeframe |

The backtest therefore represents the basic fixed-SL/TP version of the strategy with both **Break Even and Trailing Stop disabled**.

---

## 4. Main Results

| Metric                   |               Result |
| ------------------------ | -------------------: |
| Initial Deposit          |            $1,000.00 |
| Total Net Profit         |         **-$789.66** |
| Gross Profit             |            $4,995.60 |
| Gross Loss               |           -$5,785.26 |
| Profit Factor            |             **0.86** |
| Expected Payoff          |   **-$0.30 / trade** |
| Recovery Factor          |            **-0.83** |
| Sharpe Ratio             |            **-5.00** |
| Balance Drawdown Maximal | **$943.70 / 87.24%** |
| Equity Drawdown Maximal  | **$951.60 / 87.47%** |
| LR Correlation           |            **-0.97** |

The baseline run generated a net loss of **$789.66**. Gross losses exceeded gross profits, and maximum equity drawdown reached **87.47%**.

Profit Factor was **0.86**, Expected Payoff was **-$0.30**, Recovery Factor was **-0.83**, and Sharpe Ratio was **-5.00**.

### Baseline Assessment

**Result: FAIL**

The tested configuration does not demonstrate a profitable or sufficiently robust trading edge.

The most important reasons are:

* Net Profit is strongly negative.
* Profit Factor is below 1.0.
* Expected Payoff is negative.
* Maximum drawdown exceeds 87%.
* Sharpe Ratio is negative.
* Balance progression shows a persistent long-term decline.

This configuration should therefore **not be considered suitable for live trading based on this backtest**.

---

## 5. Trade Statistics

| Metric               |     Result |
| -------------------- | ---------: |
| Total Trades         |      2,595 |
| Total Deals          |      5,190 |
| Winning Trades       |        787 |
| Losing Trades        |      1,808 |
| Win Rate             | **30.33%** |
| Loss Rate            | **69.67%** |
| Short Trades         |      1,402 |
| Short Win Rate       |     27.96% |
| Long Trades          |      1,193 |
| Long Win Rate        |     33.11% |
| Largest Profit Trade |     $35.82 |
| Largest Loss Trade   |    -$40.44 |
| Average Profit Trade |      $6.35 |
| Average Loss Trade   |     -$3.20 |

The EA executed **2,595 trades**. Only **30.33%** were profitable, while **69.67%** were losing trades. Long trades performed somewhat better than short trades by win rate, at 33.11% versus 27.96%.

An important characteristic is that:

```text
Average Win  = $6.35
Average Loss = $3.20
```

The average winning trade is approximately twice the size of the average losing trade.

However, the win rate is too low for this payoff structure to produce positive expectancy in this test.

---

## 6. Consecutive Results

| Metric                     |              Result |
| -------------------------- | ------------------: |
| Maximum Consecutive Wins   |                   8 |
| Maximum Consecutive Losses |                  17 |
| Maximal Consecutive Profit |   $50.19 / 8 trades |
| Maximal Consecutive Loss   | -$69.11 / 10 trades |
| Average Consecutive Wins   |                   1 |
| Average Consecutive Losses |                   3 |

The strategy experienced as many as **17 consecutive losing trades**, compared with a maximum of 8 consecutive wins.

This confirms that losing streaks are a significant characteristic of the tested configuration.

---

## 7. Balance Curve

The balance curve is clearly downward over the full test.

The account begins with:

```text
$1,000
```

and produces:

```text
Total Net Profit = -$789.66
```

The balance chart shows several temporary recoveries, but these fail to reverse the broader decline.

Combined with an **LR Correlation of -0.97**, the test indicates a strongly negative balance trend rather than a result caused only by a small number of isolated losing trades.

---

## 8. BUY vs SELL Observation

Trade distribution was relatively balanced:

```text
SELL = 1,402 trades
BUY  = 1,193 trades
```

But neither side produced a strong win rate:

```text
SELL win rate = 27.96%
BUY win rate  = 33.11%
```

BUY performed better than SELL by win rate in this sample, but the available baseline result does **not** establish that BUY-only trading would be profitable.

That hypothesis requires a separate controlled backtest.

---

## 9. MFE / MAE Analysis

The report provides the following correlations:

| Correlation    |  Value |
| -------------- | -----: |
| Profits vs MFE |   0.84 |
| Profits vs MAE |   0.74 |
| MFE vs MAE     | 0.5218 |

The strong relationship between profit and Maximum Favorable Excursion (MFE) indicates that profitable trades are associated with meaningful favorable price movement.

The MFE/MAE plots are useful for later research into whether the current fixed Stop Loss and Take Profit distances are appropriate.

No optimized SL/TP conclusion should be made from these plots alone.

---

## 10. Holding Time

| Metric               |       Result |
| -------------------- | -----------: |
| Minimum Holding Time |     00:00:01 |
| Maximum Holding Time |     03:44:36 |
| Average Holding Time | **00:04:43** |

The EA therefore behaves as a relatively short-duration strategy in this M1 test.

The average trade remains open for less than five minutes, although some positions remain active for several hours.

---

## 11. Key Findings

### Finding 1 — Baseline strategy is not profitable

The clearest result is:

```text
Profit Factor   = 0.86
Expected Payoff = -$0.30
Net Profit      = -$789.66
```

The current baseline does not demonstrate positive expectancy.

### Finding 2 — Drawdown is unacceptable

```text
Balance DD = 87.24%
Equity DD  = 87.47%
```

This level of drawdown makes the tested configuration unsuitable for live deployment.

### Finding 3 — Low win rate is the main structural problem

The strategy has:

```text
Average Profit = +$6.35
Average Loss   = -$3.20
```

but only:

```text
30.33% winning trades
```

The larger average winner is insufficient to compensate for the frequency of losing trades.

### Finding 4 — SELL side is weaker by win rate

```text
BUY  = 33.11%
SELL = 27.96%
```

This creates a valid research hypothesis for testing BUY and SELL independently.

It is **not yet evidence** that either direction is independently profitable.

### Finding 5 — Entry filtering requires investigation

With **2,595 trades in roughly two months on M1**, the strategy generates a large number of entries.

Combined with the 69.67% loss rate, this suggests that reducing low-quality breakout entries should be investigated before adding complexity elsewhere.

---

## 12. Baseline Verdict

### ❌ FAIL — Research Baseline

The purpose of this test is still useful: it establishes a measurable baseline.

```text
Net Profit        : -$789.66
Profit Factor     : 0.86
Win Rate          : 30.33%
Max Equity DD     : 87.47%
Expected Payoff   : -$0.30
Total Trades      : 2,595
```

The tested EA configuration should **not proceed directly to live trading**.

The result should instead be retained as the reference baseline against which future strategy modifications are measured.

---

## 13. Research Questions Generated by This Test

The baseline produces several hypotheses worth testing separately:

1. Does separating BUY and SELL improve expectancy?
2. Can an additional trend filter reduce false Keltner breakouts?
3. Are the current fixed SL/TP distances appropriate for XAUUSD M1?
4. Does limiting trading by hour/session improve results?
5. Does increasing the required distance outside the Keltner Channel reduce low-quality entries?

These are **research questions**, not conclusions from the current backtest.

Each modification should be tested independently against this baseline before combining multiple changes.

---

## 14. Files

Recommended folder structure:

```text
Backtest/
└── EA-027_Keltner_Outer_Trend/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

The HTML Strategy Tester report is the authoritative source for numerical backtest results.

The PNG files contain the supporting MT5 charts for:

* Balance progression
* Entry/profit distribution
* MFE/MAE analysis
* Position holding time

---

## Disclaimer

This backtest is provided for **quantitative research and strategy-development purposes only**.

Historical backtest performance does not guarantee future results. Broker conditions, spread, execution, slippage, liquidity and market regime can materially affect live performance.
