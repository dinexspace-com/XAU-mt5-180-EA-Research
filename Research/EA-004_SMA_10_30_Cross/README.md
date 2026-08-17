# Strategy Research & Optimization Plan: EA-004_SMA_10_30_Cross

## Overview & Objective
Following the baseline backtest report on **XAUUSD.PRO (M1)**, which resulted in a **99.42% drawdown** and a **Profit Factor of 0.84**, this research plan outlines the systematic steps required to address noise exposure, reduce over-trading, and convert the EA into a profitable system.

---

## 1. Research Hypotheses

* **H1: Timeframe Expansion:** Shift trading from M1 to higher timeframes (M15, H1) to eliminate micro-market noise and drastically cut spread/slippage costs.
* **H2: Trend Regime Filtering:** Incorporate a higher-timeframe EMA (e.g., 200 EMA) to ensure crossover entries only trigger in the direction of the dominant macro trend.
* **H3: Volatility & Range Gate:** Integrate an ADX (Average Directional Index) filter (threshold > 25) to suspend trading during low-volatility, choppy market consolidation.

---

## 2. Parameter Search Space (Optimization Matrix)

| Parameter | Baseline Value | Optimization Range (Start : Step : Stop) | Target Purpose |
| :--- | :--- | :--- | :--- |
| **Timeframe** | M1 | M15, H1, H4 | Reduce trade frequency & noise |
| **Fast SMA Period** | 10 | 5 : 5 : 50 | Fine-tune entry responsiveness |
| **Slow SMA Period** | 30 | 20 : 10 : 200 | Establish proper trend baseline |
| **Filter EMA (Macro)** | None | 100, 200 | Directional bias alignment |
| **ADX Threshold** | None | 20 : 5 : 40 | Filter out ranging/sideways markets |
| **Stop Loss (Points)** | 300 | 300 : 100 : 1000 | Dynamic volatility adjustment |
| **Take Profit (Points)** | 600 | 600 : 200 : 2000 | Maintain minimum 1:1.5 Risk/Reward |

---

## 3. Robustness & Validation Framework

To prevent **Overfitting (Curve Fitting)**, optimization must adhere to the following strict testing architecture:

### A. Data Split Protocol
* **In-Sample Period (Optimization):** `2024.01.01` to `2025.12.31` (Used exclusively for parameter scanning).
* **Out-of-Sample Period (Forward Test):** `2026.01.02` to `2026.07.01` (Unseen data validation).

### B. Walk-Forward Analysis (WFA)
* **Optimization Window:** 6 Months
* **Forward Test Window:** 2 Months
* **Pass Condition:** Strategy must demonstrate positive expectancy across at least 80% of forward testing windows.

---

## 4. Key Target KPIs

| KPI Metric | Baseline Result | Target Goal | Minimum Acceptable Threshold |
| :--- | :--- | :--- | :--- |
| **Profit Factor** | 0.84 | $\ge 1.50$ | $\ge 1.35$ |
| **Maximal Drawdown (Equity)** | 99.42% | $\le 15.0\%$ | $\le 20.0\%$ |
| **Win Rate** | 39.87% | $\ge 50.0\%$ | $\ge 45.0\%$ (with R:R > 1:1.5) |
| **Sharpe Ratio** | -5.00 | $> 1.50$ | $> 1.00$ |
| **Expected Payoff** | -$0.27 | $> \$2.00$ | $> \$1.00$ |

---

## 5. Next Execution Steps

1. **MQL Code Update:** Refactor `EA-004_SMA_10_30_Cross` to add 200 EMA and ADX filter parameters.
2. **Strategy Tester Batch Run:** Execute MT4/MT5 genetic optimization algorithm over the In-Sample period.
3. **Out-of-Sample Validation:** Verify top 5 parameter sets against 2026 data.
