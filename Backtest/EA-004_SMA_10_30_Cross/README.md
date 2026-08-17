# Strategy Tester Report: EA-004_SMA_10_30_Cross

## Executive Summary
The strategy backtest for **EA-004_SMA_10_30_Cross** on **XAUUSD.PRO** (M1 timeframe) covering the period **2026.01.02 to 2026.07.01** resulted in a total net loss of **-$994.01**, representing an almost complete account depletion (-99.4% drawdown) from the initial $1,000.00 deposit.

---

## Strategy Parameters & Configuration
* **Symbol / Timeframe:** XAUUSD.PRO / M1 (1-Minute)
* **Strategy Type:** Fast & Slow SMA Crossover
* **Moving Averages:** Fast SMA (10 period) / Slow SMA (30 period)
* **Position Size:** 0.01 Lot (Fixed)
* **Stop Loss (SL):** 300 Points
* **Take Profit (TP):** 600 Points
* **Trade Management:**
  * Break-even: Enabled at 150 points
  * Trailing Stop: Enabled (Start: 200 points, Distance: 200 points)

---

## Key Performance Metrics

| Metric | Value |
| :--- | :--- |
| **Initial Deposit** | $1,000.00 |
| **Total Net Profit** | -$994.01 |
| **Gross Profit** | $5,225.86 |
| **Gross Loss** | -$6,219.87 |
| **Profit Factor** | 0.84 |
| **Expected Payoff** | -$0.27 |
| **Sharpe Ratio** | -5.00 |
| **Maximal Drawdown (Equity)** | 99.42% ($1,019.25) |
| **Absolute Drawdown** | $994.01 |

---

## Trade Statistics

| Metric | Total | Short (Sell) | Long (Buy) |
| :--- | :--- | :--- | :--- |
| **Total Trades** | 3,745 | 1,855 | 1,890 |
| **Win Rate** | 39.87% | 39.51% (733/1,855) | 40.21% (760/1,890) |
| **Winning Trades** | 1,493 | - | - |
| **Losing Trades** | 2,252 | - | - |
| **Average Win** | $3.50 | - | - |
| **Average Loss** | -$2.76 | - | - |
| **Largest Win** | $6.02 | - | - |
| **Largest Loss** | -$3.03 | - | - |
| **Average Holding Time** | 4m 31s | - | - |

---

## Key Analysis & Observations

1. **Severe Over-Trading on Noise:**
   * Executing **3,745 trades over 6 months** (~20+ trades per day) on a 1-minute chart exposes the account heavily to market noise and spread costs.
2. **MA Crossover Lag in Ranging Markets:**
   * Pure SMA crossovers perform poorly in choppy/sideways markets, generating repeated false breakout signals (whip-saws).
3. **Negative Expectancy:**
   * With a **39.87% win rate** and an average win of $3.50 vs loss of -$2.76, the expected payoff per trade is **-$0.27**, guaranteeing long-term account decay.
4. **Drawdown & Risk:**
   * The maximum equity drawdown reached **99.42%**, causing complete margin exhaustion.

---

## Recommendations for Optimization
* **Timeframe Higher Shift:** Test the strategy on H1 or H4 timeframes to filter out M1 noise.
* **Trend Filter Addition:** Incorporate a higher-timeframe trend indicator (e.g., 200 EMA) to only take trades in the direction of the dominant trend.
* **Filter Ranging Regimes:** Add an ADX (Average Directional Index) or Volatility filter to avoid trading during low-volatility consolidation phases.
