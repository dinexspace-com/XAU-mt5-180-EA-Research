# MT5 Strategy Tester Report Analysis
**Expert Advisor:** EA-013_Triple_EMA_10_30_100  
**Symbol:** XAUUSD.PRO  
**Timeframe:** M1  
**Period:** 2026.01.02 – 2026.06.01  

---

## Key Backtest Metrics

| Metric | Value / Detail |
| :--- | :--- |
| **Initial Deposit** | $1,000.00 |
| **Total Net Profit** | -$994.79 *(Near complete account loss)* |
| **Maximal Drawdown** | 99.50% ($1,026.54) |
| **Profit Factor** | 0.84 |
| **Sharpe Ratio** | -5.00 |
| **Win Rate** | 48.26% (2,516 wins / 2,697 losses out of 5,213 total trades) |
| **Average Win / Loss** | $2.10 / -$2.33 |
| **Trade Frequency** | ~5,213 trades in 5 months (~50 trades/day) |
| **Holding Time** | Avg 3m 22s (Min 2s, Max 3h 32m) |

---

## Core Issues & Failure Analysis

* **Over-Trading & Whip-sawing in Ranging Markets:** Executing 5,213 trades on an M1 timeframe using a Triple EMA crossover (10/30/100) generates severe lagging signals. During sideways consolidation, the EMA 10/30 crosses back and forth relative to EMA 100, triggering massive consecutive losses (Max loss streak: 14 trades / -$40.99).
* **Negative Expectancy:** The average loss ($2.33) outweighs the average win ($2.10). Combined with spread costs (`MaxSpread=30 points`) over 5,200+ trades, transaction friction alone severely erodes balance.
* **Aggressive Trailing / Premature Stop-outs:** The Break Even setting (150 points / $1.50) and Trailing Stop (200 points / $2.00) trigger too early for M1 XAUUSD. Standard gold price noise easily sweeps the tight trailing stop before price can reach the 600-point ($6.00) Take Profit target.

---

## Recommended Optimization Steps

**1. Trend & Volatility Filters**
* Integrate an **ADX filter** (e.g., ADX > 20/25) or an **ATR threshold** to pause trading when M1 volatility is flat, avoiding choppy ranges.
* Require higher-timeframe trend alignment (e.g., M5 or M15 EMA 200 direction) before allowing M1 entries.

**2. Risk Management & Trailing Logic**
* Widen the Break Even activation distance (e.g., 250–300 points) to allow price noise space to breathe.
* Increase the Take Profit ratio relative to Stop Loss (e.g., SL 250, TP 750) to push the risk-reward payoff positive.

**3. Execution Control**
* Implement a daily max loss limit or daily trade count cap to prevent severe drawdown spirals on high-volatility days.
