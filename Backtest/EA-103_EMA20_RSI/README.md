# EA-103 — EMA20 + RSI — Baseline Backtest

## Test Configuration

| Item            | Value                   |
| --------------- | ----------------------- |
| Expert Advisor  | EA-103_EMA20_RSI        |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Test Period     | 2026.01.02 – 2026.03.31 |
| Initial Deposit | $1,000                  |
| Leverage        | 1:500                   |
| History Quality | 100%                    |
| Bars            | 85,161                  |
| Ticks           | 38,264,803              |
| Lot Size        | 0.01                    |

---

## Baseline Result

| Metric             |         Result |
| ------------------ | -------------: |
| Net Profit         | **+$2,636.37** |
| Gross Profit       |      $7,485.09 |
| Gross Loss         |     -$4,848.72 |
| Profit Factor      |       **1.54** |
| Expected Payoff    |     **+$0.59** |
| Recovery Factor    |      **35.48** |
| Sharpe Ratio       |      **61.83** |
| Max Balance DD     |      **2.33%** |
| Max Equity DD      |      **2.43%** |
| Relative Equity DD |      **4.45%** |
| Total Trades       |      **4,460** |
| Total Deals        |          8,920 |
| Profit Trades      | 2,617 / 58.68% |
| Loss Trades        | 1,843 / 41.32% |

---

## Directional Results

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| BUY       |  2,241 |   59.39% |
| SELL      |  2,219 |   57.95% |

Both directions produced positive results in the baseline sample.

---

## Trade Quality

| Metric                     |   Result |
| -------------------------- | -------: |
| Largest Profit Trade       |    $7.09 |
| Largest Loss Trade         |   -$5.68 |
| Average Profit Trade       |    $2.86 |
| Average Loss Trade         |   -$2.63 |
| Maximum Consecutive Wins   |       18 |
| Maximum Consecutive Losses |       10 |
| Average Holding Time       | 00:01:46 |

---

## Baseline Assessment

**Classification: PASS FOR FURTHER RESEARCH**

The baseline produced:

* Positive net profit
* Profit Factor above 1
* Positive expected payoff
* Positive Sharpe Ratio
* Low maximum equity drawdown
* Positive BUY and SELL performance
* 4,460 trades in the tested sample

These results provide sufficient evidence to continue controlled research.

However, this result is **not sufficient for live deployment**.

---

## Research Decision

| Stage               | Status                    |
| ------------------- | ------------------------- |
| Strategy Code       | COMPLETE                  |
| Baseline Backtest   | COMPLETE                  |
| Baseline Assessment | PASS FOR FURTHER RESEARCH |
| Parameter Research  | NOT STARTED               |
| Exit Research       | NOT STARTED               |
| Session Research    | NOT STARTED               |
| OOS Validation      | NOT STARTED               |
| Robustness Testing  | NOT STARTED               |
| Walk-Forward        | NOT STARTED               |
| Forward Test        | NOT STARTED               |
| Live Trading        | NO                        |

**Baseline ID:** `EA103-M1-BASELINE-001`

**Optimization Status:** `CONTROLLED RESEARCH ONLY`
