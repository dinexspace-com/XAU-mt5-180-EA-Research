# Hi there, I'm an Algorithmic Trader & EA Developer! 👋

Welcome to my GitHub profile! I specialize in developing, backtesting, and optimizing automated trading strategies (Expert Advisors) for financial markets, with a focus on Gold (XAUUSD).

---

## 🚀 Active Projects

### 📌 EA-001 (XAUUSD Trading Bot)

A quantitative trading algorithm built on MetaTrader using EMA crossover strategies combined with risk management protocols.

### 📌 EA-002 (Trend EMA 13/34 Cross - M1)

A high-frequency trend-following EA on M1 timeframe utilizing EMA 13/34 crossover and same-color candle filters.

### 📌 EA-003 (Trend EMA 20/50 Cross - M1)

A trend-following EA on M1 timeframe utilizing EMA 20/50 crossover with price-location confirmation, strict spread filtering, and dynamic risk management (BreakEven & Trailing Stop).

### 📌 EA-004 (Trend SMA 10/30 Cross - M1)

A fast-reacting moving average crossover strategy on M1 timeframe, executed strictly upon M1 candle closure with standard risk parameters (SL 300, TP 600, BE 150, Trailing 200).

### 📌 EA-005 (Trend SMA 20/100 Cross - M1)

A medium-period moving average crossover strategy on M1 timeframe designed to capture larger swings, using SMA 20 & SMA 100 on XAUUSD.

### 📌 EA-006 (EMA 5/20 Pullback - M1)

A high-frequency pullback strategy on M1 timeframe based on fast EMA 5 & EMA 20 crossovers with fixed risk controls (SL 300, TP 600).

### 📌 EA-007 (EMA 9/50 Pullback - M1)

A fast trend-following pullback strategy on M1 timeframe using EMA 9 & EMA 50 crossovers combined with strict spread filters, BreakEven, and Trailing Stop management.

### 📌 EA-008 (EMA 21/55 First Bounce Pullback - M1)

A pullback trading strategy on M1 timeframe based on EMA 21 & EMA 55 trend identification, capturing the first bounce upon returning to EMA 21 with standardized risk management (SL 300, TP 600, BE 150, Trailing 200, Spread <= 30).

### 📌 EA-009 (EMA 34/89 Pullback - M1)

A medium-term exponential moving average pullback strategy on M1 timeframe utilizing EMA 34 & EMA 89 crossovers with fixed risk management parameters (SL 300, TP 600, BE 150, Trailing 200, Spread <= 30).

### 📌 EA-010 (EMA 50/200 Trend - M1)

A long-term trend-following crossover strategy on M1 timeframe using EMA 50 & EMA 200 to capture major trend shifts on XAUUSD with standard fixed risk controls (SL 300, TP 600, Spread <= 30).

### 📌 EA-011 (EMA 50/200 Retest - M1)

A retest-based strategy on M1 timeframe identifying price pullbacks to EMA 50/200 dynamic support/resistance zones after a confirmed trend breakout.

### 📌 EA-012 (Triple EMA 5/20/50 - M1)

A multi-EMA momentum crossover strategy on M1 timeframe utilizing ultra-fast EMA 5, fast EMA 20, and baseline EMA 50 alignment for high-frequency scalp entries.

### 📌 EA-013 (Triple EMA 10/30/100 - M1)

A triple moving average trend-following strategy on M1 timeframe utilizing EMA 10, EMA 30, and EMA 100 alignment with dynamic trade management controls (SL 300, TP 600, BE 150, Trailing 200, Spread <= 30).

### 📌 EA-014 (Triple SMA 10/30/60 - M1)

A triple simple moving average strategy on M1 timeframe using SMA 10, SMA 30, and SMA 60 alignment for trend confirmation with dynamic trade controls (SL 300, TP 600, BE 150, Trailing 200, Spread <= 30).

### 📌 EA-015 (EMA20 Slope - M1)

A short-term trend-following strategy on XAUUSD M1 based on the directional slope of EMA20 combined with price-location confirmation. BUY signals require a rising EMA20 with the previous closed candle above EMA20, while SELL signals require a falling EMA20 with the previous closed candle below EMA20. The EA supports fixed SL/TP, spread filtering, Break Even, and Trailing Stop trade management.

### 📌 EA-016 (EMA50 Slope - M1)

A trend-following strategy on XAUUSD M1 based on the directional slope of EMA50 combined with price-location confirmation. BUY signals require a rising EMA50 with the previous closed candle above EMA50, while SELL signals require a falling EMA50 with the previous closed candle below EMA50. The EA supports fixed SL/TP, spread filtering, Break Even, and Trailing Stop trade management.

### 📌 EA-017 (ADX + EMA 20/50 - M1)

A trend-following EA on XAUUSD M1 using EMA 20/50 crossover signals confirmed by ADX 14 and directional movement (+DI / -DI). The baseline configuration uses Minimum ADX 25, fixed SL 300, TP 600, Spread <= 30, with Break Even and Trailing Stop disabled for the initial validation test.

### 📌 EA-018 (DI Trend - M1)

A trend-following EA on XAUUSD M1 combining DMI directional movement (+DI / -DI) with EMA50 slope confirmation.

BUY signals require +DI to dominate -DI together with a rising EMA50, while SELL signals require -DI to dominate +DI together with a falling EMA50.

The baseline configuration uses EMA50, DMI/ADX14, fixed SL 300, TP 600, Spread <= 30, with Break Even and Trailing Stop disabled for the initial validation test.

### 📌 EA-019 (MACD Zero Trend - M1)

A MACD-based trend-following EA on XAUUSD combining MACD zero-line positioning, MACD Main/Signal state confirmation, and an EMA50 trend filter.

BUY signals require MACD Main above zero, MACD Main above the Signal line, and the previous closed candle above EMA50.

SELL signals require MACD Main below zero, MACD Main below the Signal line, and the previous closed candle below EMA50.

The baseline configuration uses MACD 12/26/9, EMA50, fixed SL 300, TP 600, Break Even 150, Trailing Stop 200, Lot 0.01, and Spread <= 30.

---

## 📊 Development & Research Workflow

* **Backtesting:** 100% Real Ticks history data backtesting for maximum precision.
* **Methodology:** Systematic hypothesis-driven experiments (`docs/methodology.md` & project-specific docs).
* **Research:** Controlled experiments on signal parameters, timeframes, trend filters, volatility controls, and trade management (`Research/`).
* **Evidence:** Original MetaTrader 5 Strategy Tester reports are retained as the numerical source of truth for individual backtests.
* **Experiment Tracking:** Failed configurations are preserved as research evidence rather than removed or hidden.

---

## 🛠️ Tech Stack & Tools

* **Trading Platforms:** MetaTrader 4 / MetaTrader 5 (MQL4 / MQL5)
* **Languages:** MQL4, MQL5, Python (Data Analysis)
* **Version Control:** Git, GitHub
* **Analysis:** Backtest Reports, Quantitative Metrics (Profit Factor, Drawdown, Sharpe Ratio)

---

## 📈 Current Projects Status

### EA-001

* [x] Baseline Backtest Completed
* [x] Research & Experiment Framework Setup
* [ ] Experiment 01: Timeframe Optimization
* [ ] Experiment 02: Trend Filter Integration

### EA-002

* [x] Baseline Backtest Completed (#01)
* [x] Strategy Code & Documentations Setup
* [ ] Experiment 01: Break Even & Trailing Stop Integration
* [ ] Experiment 02: Higher Timeframe (H1 EMA 200) Trend Filter

### EA-003

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-003TrendEMA_20_50_Cross/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-003TrendEMA_20_50_Cross/`)
* [ ] Experiment 01: Filter Relaxation to Increase Trade Frequency
* [ ] Experiment 02: Multi-Timeframe (M5/M15) Evaluation

### EA-004

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-004_SMA_10_30_Cross/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-004_SMA_10_30_Cross/`)
* [ ] Experiment 01: Trend Filter Integration (HTF EMA 200 / ADX) to Reduce Whipsaws
* [ ] Experiment 02: Timeframe Shift (M5/M15) & Parameter Optimization

### EA-005

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-005_SMA_20_100_Cross/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-005_SMA_20_100_Cross/`)
* [ ] Experiment 01: Timeframe Shift (M15/H1) & EMA Replacement (Reduce Whipsaw Losses)
* [ ] Experiment 02: Trend Filter (ADX > 25) & Dynamic Risk-per-Trade Implementation

### EA-006

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-006_EMA_5_20_Pullback/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-006_EMA_5_20_Pullback/`)
* [ ] Experiment 01: Multi-Timeframe Filter Integration (HTF EMA 200)
* [ ] Experiment 02: BreakEven & Trailing Stop Optimization

### EA-007

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-007_EMA_9_50_Pullback/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-007_EMA_9_50_Pullback/`)
* [ ] Experiment 01: Multi-Timeframe Filter Integration (HTF EMA 200)
* [ ] Experiment 02: Volatility / ADX Filter Implementation & Timeframe Shift (M5/M15)

### EA-008

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-008_EMA_21_55_Pullback/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-008_EMA_21_55_Pullback/`)
* [ ] Experiment 01: Higher Timeframe Trend Filter (HTF EMA 200) Integration
* [ ] Experiment 02: Timeframe Scaling (M5/M15) & Risk-Reward Parameter Tuning

### EA-009

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-009_EMA_34_89_Pullback/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-009_EMA_34_89_Pullback/`)
* [ ] Experiment 01: Higher Timeframe Trend Filter (HTF EMA 200) Integration
* [ ] Experiment 02: Timeframe Scaling (M5/M15) & Volatility (ADX/ATR) Filter Integration

### EA-010

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-010_EMA_50_200_Trend/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-010_EMA_50_200_Trend/`)
* [ ] Experiment 01: Enable Dynamic Risk Controls (BreakEven & Trailing Stop)
* [ ] Experiment 02: Multi-Timeframe (H1/H4) Trend Filter & Timeframe Scaling (M5/M15)

### EA-011

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-011_EMA_50_200_Retest/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-011_EMA_50_200_Retest/`)
* [ ] Experiment 01: Higher Timeframe Trend Filter Integration (H1/M15 EMA Slope)
* [ ] Experiment 02: Enable Dynamic Risk Controls (BreakEven & Trailing Stop)

### EA-012

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-012_Triple_EMA_5_20_50/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-012_Triple_EMA_5_20_50/`)
* [ ] Experiment 01: Higher Timeframe Trend Filter Integration & Volatility Thresholds (ADX/ATR)
* [ ] Experiment 02: Enable Active Trade Management (BreakEven & Trailing) & Session Window Limits

### EA-013

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-013_Triple_EMA_10_30_100/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-013_Triple_EMA_10_30_100/`)
* [ ] Experiment 01: Volatility & Higher Timeframe Trend Filter Integration (ADX / HTF EMA 200)
* [ ] Experiment 02: BreakEven & Trailing Stop Parameter Relaxation & Risk-Reward Tuning

### EA-014

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-014_Triple_SMA_10_30_60/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-014_Triple_SMA_10_30_60/`)
* [ ] Experiment 01: Trend Filter (HTF EMA 200 / ADX) Integration to Reduce Whipsaws
* [ ] Experiment 02: Timeframe Shift (M5/M15) & Risk-Reward Ratio Tuning

### EA-015

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-015_EMA20_Slope/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-015_EMA20_Slope/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [ ] Experiment 02: Test Alternative EMA Trend Persistence
* [ ] Experiment 03: Evaluate BUY vs SELL Directional Filtering

**Current Research Status:** `IN PROGRESS`

**Baseline #01:** EMA20 / Minimum Trend Bars = 3 / SL 300 / TP 600 / Break Even OFF / Trailing OFF.

**Baseline #01 Result:** 3,508 trades, Net Profit **-$992.93**, Profit Factor **0.87**, Expected Payoff **-$0.28**, Sharpe Ratio **-5.00**, Maximum Drawdown approximately **99.32%**.

The baseline configuration is rejected. EA-015 remains under research because alternative configurations and hypotheses have not yet been independently tested.

### EA-016

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-016_EMA50_Slope/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-016_EMA50_Slope/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [ ] Experiment 02: Test Alternative EMA50 Trend Persistence
* [ ] Experiment 03: Evaluate BUY vs SELL Directional Filtering

**Current Research Status:** `IN PROGRESS`

**Baseline #01:** EMA50 / Minimum Trend Bars = 2 / SL 300 / TP 600 / Break Even OFF / Trailing OFF.

**Baseline #01 Result:** 3,338 trades, Net Profit **-$992.38**, Profit Factor **0.86**, Expected Payoff **-$0.30**, Sharpe Ratio **-5.00**, Maximum Drawdown approximately **99.28%**.

The baseline configuration is rejected. EA-016 remains under research because alternative configurations and hypotheses have not yet been independently tested.

### EA-017

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-017_ADX_EMA/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-017_ADX_EMA/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [x] Research Methodology Documented (`docs/methodology.md`)
* [ ] Experiment 01: ADX Threshold Evaluation (20 / 25 / 30 / 35)
* [ ] Experiment 02: Multi-Timeframe Evaluation (M1 / M5 / M15)
* [ ] Experiment 03: Break Even & Trailing Stop Validation after timer fix

**Current Research Status:** `IN PROGRESS`

**Baseline #01:** EMA20 / EMA50 crossover + ADX14 / Minimum ADX 25 / +DI & -DI confirmation / SL 300 / TP 600 / Break Even OFF / Trailing OFF.

**Baseline #01 Result:** 1,818 trades, Net Profit **-$184.67**, Profit Factor **0.95**, Expected Payoff **-$0.10**, Sharpe Ratio **-4.45**, Maximum Equity Drawdown **28.26%**.

The baseline configuration is rejected as a profitable candidate, but retained as the reference baseline. EA-017 remains under research because the current result is close to break-even and the next controlled experiment will test whether changing the ADX threshold improves entry quality without changing the core strategy.

### EA-018

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-018_DI_Trend/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-018_DI_Trend/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [x] Research Methodology Documented (`docs/methodology.md`)
* [ ] RQ-01: Verify EMA Slope Implementation / `CopyBuffer()` Indexing
* [ ] Experiment 02: DI State vs DI Crossover
* [ ] Experiment 03: ADX Strength Filter Evaluation
* [ ] Experiment 04: Multi-Timeframe Evaluation (M5 / M15 / M30 / H1)

**Current Research Status:** `IN PROGRESS`

**Optimization Status:** `BLOCKED — Implementation verification required`

**Baseline #01:** XAUUSD.PRO / M1 / EMA50 + DMI/ADX14 / SL 300 / TP 600 / Lot 0.01 / Spread <= 30 / Break Even OFF / Trailing OFF.

**Test Period:** 2026-01-02 → 2026-06-08 using 100% real ticks.

**Baseline #01 Result:** 4,096 trades, Net Profit **-$993.61**, Profit Factor **0.89**, Expected Payoff **-$0.24**, Sharpe Ratio **-5.00**, Maximum Drawdown **99.36%**, Win Rate **31.20%**.

The baseline configuration is rejected as a profitable candidate. The balance curve shows persistent deterioration and the test ends with almost the entire initial deposit lost.

EA-018 remains under research because the current baseline does not by itself prove that the underlying DI + EMA trend concept has no edge. Before any parameter optimization, the EMA slope implementation and `CopyBuffer()` indexing must be verified to ensure that the EA implementation matches the intended strategy logic.

The next controlled research steps are to verify EMA slope direction first, then compare DI state-based entries against DI crossover entries, evaluate ADX strength filtering, and finally test higher timeframes without changing multiple strategy components simultaneously.

### EA-019

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-019_MACD_Zero_Trend/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-019_MACD_Zero_Trend/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [x] Research Methodology Documented (`docs/methodology.md`)
* [ ] R01: MACD State vs Strict MACD Crossover
* [ ] R02: EMA50 Filter ON vs OFF
* [ ] R03: MACD Zero-Line Filter ON vs OFF
* [ ] R04: Break Even ON vs OFF
* [ ] R05: Trailing Stop ON vs OFF
* [ ] R06: BUY vs SELL Directional Evaluation
* [ ] R07: Multi-Timeframe Evaluation

**Current Research Status:** `IN PROGRESS`

**Optimization Status:** `BLOCKED — Controlled research required before parameter optimization`

**Baseline #01:** XAUUSD.PRO / M1 / MACD 12/26/9 / MACD Zero-Line confirmation / EMA50 trend filter / SL 300 / TP 600 / Lot 0.01 / Break Even 150 / Trailing Stop 200 / Spread <= 30.

**Test Period:** 2026-01-02 → 2026-04-01 using 100% real ticks.

**Initial Deposit:** $1,000.00

**Leverage:** 1:500

**Baseline #01 Result:** 5,695 trades, Net Profit **-$992.55**, Profit Factor **0.91**, Expected Payoff **-$0.17**, Sharpe Ratio **-5.00**, Maximum Equity Drawdown **99.27%**, Win Rate **39.82%**.

**Directional Results:**

* BUY: 2,852 trades / **41.76%** won
* SELL: 2,843 trades / **37.88%** won

**Average Trade Results:**

* Average profitable trade: **$4.24**
* Average losing trade: **-$3.10**
* Maximum consecutive losses: **15**
* Average holding time: **00:03:17**

The baseline configuration is rejected as a profitable candidate. The Strategy Tester report shows negative expectancy, Profit Factor below 1.0, an extremely high drawdown, and a balance curve that ends with almost the entire initial deposit lost.

The baseline does not by itself prove that the underlying MACD Zero Trend concept has no edge.

A key implementation characteristic is that the current EA uses the **state** of MACD Main relative to the Signal line rather than requiring a new MACD crossover event. This may materially affect trade frequency and entry quality.

The first controlled research experiment will therefore compare:

```text
Baseline:
MACD Main > Signal / MACD Main < Signal

vs

Variant:
Strict MACD crossover event
```

All unrelated strategy components should remain unchanged during this experiment.

No parameter optimization should be performed before the main strategy components have been isolated through controlled experiments.

---

## 🔬 Research Philosophy

Every strategy follows a simple evidence-driven process:

**Hypothesis → Implementation → Backtest → Evidence → Analysis → Controlled Experiment**

A failed backtest is not removed from the research history.

A successful backtest is not automatically considered ready for live trading.

Each configuration is evaluated independently, and promising strategies must progress through additional robustness, out-of-sample, and forward-testing stages before being considered for live deployment.

---

## ⚠️ Disclaimer

This repository documents algorithmic trading research, strategy development, and historical backtesting.

Backtest results do not guarantee future performance.

Nothing in this repository should be considered financial or investment advice.
