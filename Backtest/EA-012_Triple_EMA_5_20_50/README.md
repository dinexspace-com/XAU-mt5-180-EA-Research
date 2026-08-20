# Performance Overview: EA-012_Triple_EMA_5_20_50

The **EA-012_Triple_EMA_5_20_50** backtest on **XAUUSD.PRO (M1)** covering 5 months (2026.01.02 – 2026.06.01) resulted in a net loss of **-$995.15** with a **Profit Factor of 0.92**.

## Performance Metrics

| Key Metric | Value | Key Metric | Value |
| :--- | :--- | :--- | :--- |
| **Total Net Profit** | -$995.15 | **Total Trades** | 6,133 |
| **Profit Factor** | 0.92 | **Win Rate** | 32.17% (1,973/6,133) |
| **Maximal Drawdown** | $1,049.50 (99.54%) | **Sharpe Ratio** | -5.00 |
| **Average Win / Loss** | $6.10 / -$3.13 | **Max Consecutive Losses** | 22 trades (-$69.57) |
| **Expected Payoff** | -$0.16 per trade | **Avg Holding Time** | 0:03:42 |

---

## Core Strategy Weaknesses

* **Extreme Overtrading & Micro-Noise:** Generating **6,133 trades** across 5 months (~41 trades per day) on the M1 timeframe creates extreme exposure to spread and execution drag, compounding small losses into a near total drawdown ($1,049.50 / 99.54%).
* **Low Win Rate vs. Risk Reward:** A win rate of **32.17%** requires a win/loss ratio greater than **2.11:1** to break even. The actual average win ($6.10) to loss ($3.13) ratio is **1.95:1**, resulting in a net negative expectancy of **-$0.16** per trade.
* **Fast EMA Whipsaws & Unused Protections:** Triple fast EMAs (5/20/50) trigger constant false crossovers during range-bound conditions. Furthermore, dynamic exit parameters `InpUseBreakEven` and `InpUseTrailing` were set to `false`, preventing trades from locking in profits during brief favorable spikes.

---

## Optimization Recommendations

* **Higher Timeframe / Trend Structure Filter:** Implement an M15 or H1 higher-timeframe trend filter (e.g., EMA 200) so trade triggers only fire in the direction of the macro trend, bypassing M1 consolidation noise.
* **Enable Active Trade Management:**
  * Set `InpUseBreakEven = true` with an early trigger to move Stop Loss to entry once price advances into partial profit.
  * Set `InpUseTrailing = true` to trail profits dynamically during strong momentum expansion.
* **Volatility / Volume Confirmation:** Introduce a volatility filter (e.g., minimum ATR or ADX threshold) to halt trade generation when price is oscillating in low-volatility ranges.
* **Session & Entry Frequency Limits:** Restrict trade triggers to high-liquidity sessions (London/New York overlap) and limit maximum entries per day/bar to drastically curb overtrading.
