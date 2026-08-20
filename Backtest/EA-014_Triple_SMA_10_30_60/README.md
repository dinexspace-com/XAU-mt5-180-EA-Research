# Quantitative Backtest Report

**Expert Advisor:** EA-014_Triple_SMA_10_30_60[cite: 1]  
**Symbol & Timeframe:** XAUUSD.PRO | M1 (2026.01.02 – 2026.06.01)[cite: 1]  
**Test Quality:** 100% real ticks (63,042,734 ticks across 144,243 bars)[cite: 1]  
**Initial Deposit:** $1,000.00 | **Leverage:** 1:500[cite: 1]  

---

## Key Performance Metrics

| Metric | Value |
| :--- | :--- |
| **Total Net Profit** | -$992.73[cite: 1] |
| **Profit Factor** | 0.84[cite: 1] |
| **Sharpe Ratio** | -5.00[cite: 1] |
| **Recovery Factor** | -0.96[cite: 1] |
| **Max Drawdown (Balance / Equity)** | 99.30% ($1,030.26 / $1,032.35)[cite: 1] |
| **Total Trades / Deals** | 5,144 trades / 10,288 deals[cite: 1] |
| **Win Rate** | 48.29% (2,484 wins / 2,660 losses)[cite: 1] |
| **Short Win Rate vs. Long Win Rate** | 46.96% (1,143/2,434) vs. 49.48% (1,341/2,710)[cite: 1] |
| **Average Win / Loss Trade** | $2.09 / -$2.32[cite: 1] |
| **Max / Avg Position Holding Time** | 3:32:23 / 0:03:31[cite: 1] |

---

## Core Strategy Weaknesses

* **Over-Trading on Low Timeframe:** 5,144 trades over 5 months (~50 trades/day) creates extreme fee drag and whipsaw exposure on M1 price action[cite: 1].
* **Negative Expectancy:** The average profit ($2.09) is lower than the average loss (-$2.32), resulting in an Expected Payoff of -$0.19 per trade[cite: 1].
* **High Correlation Whipsaws:** The triple SMA (10/30/60) lagging alignment fails in choppy/ranging gold conditions, triggering repeated Stop Loss exits[cite: 1].
