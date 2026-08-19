# Performance Overview: EA-011_EMA_50_200_Retest

The **EA-011_EMA_50_200_Retest** backtest on **XAUUSD.PRO (M1)** covering 5 months (2026.01.02 – 2026.06.01) resulted in a net loss of **-$179.95** with a **Profit Factor of 0.91**.

## Performance Metrics

| Key Metric | Value | Key Metric | Value |
| :--- | :--- | :--- | :--- |
| **Total Net Profit** | -$179.95 | **Total Trades** | 919 |
| **Profit Factor** | 0.91 | **Win Rate** | 30.69% (282/919) |
| **Maximal Drawdown** | $298.81 (29.18%) | **Sharpe Ratio** | -5.00 |
| **Average Win / Loss** | $6.39 / -$3.11 | **Max Consecutive Losses** | 14 trades (-$41.98) |
| **Expected Payoff** | -$0.20 per trade | **Avg Holding Time** | 0:10:09 |

---

## Core Strategy Weaknesses

* **Low Win Rate vs. Risk Reward:** A win rate of **30.69%** requires a win/loss ratio greater than **2.26:1** just to break even. The current average win ($6.39) to loss ($3.11) ratio sits at **2.05:1**, causing steady negative expectancy (-$0.20/trade).
* **Severe Whipsaw in Ranging Markets:** Long trades won only **28.85%** and short trades **32.53%**. On the M1 timeframe, EMA 50/200 crossovers experience high false-breakout noise, resulting in frequent stop-outs before trend establishment.
* **Unused Risk Controls:** Both `InpUseBreakEven` and `InpUseTrailingStop` were set to `false`. The MAE/MFE correlation analysis shows price often moves significantly into profit before reversing to hit the full Stop Loss.

---

## Optimization Recommendations

* **Higher Timeframe Trend Filter:** Require H1 or M15 EMA 50/200 slope alignment to filter out counter-trend retests on M1.
* **Enable Dynamic Risk Management:**
  * Set `InpUseBreakEven = true` with `InpBreakEvenTriggerPoints = 150-200` to lock in profits early on quick M1 retest spikes.
  * Set `InpUseTrailingStop = true` to capture extended moves during strong trends.
* **Refine Retest Confirmation:** Add an oscillator filter (e.g., RSI overbought/oversold or Stochastic momentum confirmation) at the EMA 50/200 touch rather than entering purely on price proximity.
* **Time-of-Day Filter:** Restrict M1 entry triggers exclusively to high-volatility sessions (London/New York overlap) to avoid low-liquidity whipsaws during Asian hours.
