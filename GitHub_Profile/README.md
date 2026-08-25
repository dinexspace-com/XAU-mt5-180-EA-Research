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

### 📌 EA-020 (MACD Signal Trend - M1)

A MACD crossover trend-following EA on XAUUSD M1 designed to test whether strict MACD Main/Signal crossover events combined with zero-line confirmation can improve entry quality.

BUY signals require MACD Main to cross above the Signal line while MACD Main is above zero.

SELL signals require MACD Main to cross below the Signal line while MACD Main is below zero.

The baseline configuration uses MACD 12/26/9, fixed SL 300, TP 600, Lot 0.01, Spread <= 30, Break Even 150, and Trailing Stop 200.

### 📌 EA-021 (MACD Histogram Trend - M1)

A MACD histogram momentum-continuation EA on XAUUSD M1 designed to test whether expansion of the MACD histogram can provide a standalone directional trading edge.

BUY signals require the MACD histogram to remain above zero and increase relative to the previous closed bar.

SELL signals require the MACD histogram to remain below zero and decrease relative to the previous closed bar.

The baseline configuration uses MACD/OsMA 12/26/9, fixed SL 300, TP 600, Lot 0.01, Spread <= 30, with Break Even and Trailing Stop disabled to isolate the core entry hypothesis.

### 📌 EA-022 (Supertrend Direction - M1)

A Supertrend direction-change EA on XAUUSD M1 designed to test whether transitions between bullish and bearish Supertrend states can provide a standalone directional trading edge.

BUY signals are generated when the Supertrend direction changes from bearish to bullish, while SELL signals are generated when the direction changes from bullish to bearish.

The baseline configuration uses ATR Period 10, Supertrend Multiplier 3.0, fixed SL 300, TP 600, Lot 0.01, Maximum Spread 50, Break Even disabled, and Trailing Stop enabled.

### 📌 EA-023 (Supertrend Retest - M1)

A Supertrend retest strategy on XAUUSD M1 designed to test whether waiting for price to retest the Supertrend line after a confirmed direction change can improve entry quality compared with entering immediately on the Supertrend flip.

BUY signals begin when Supertrend changes from bearish to bullish, while SELL signals begin when Supertrend changes from bullish to bearish. Instead of entering immediately, the EA creates a pending signal and waits for price to retest the corresponding Supertrend level within a limited number of bars.

The baseline configuration uses ATR Period 10, Supertrend Multiplier 3.0, Retest Window 5 bars, Retest Buffer 5 points, fixed SL 300, TP 600, Lot 0.01, Maximum Spread 30, Maximum Positions 1, Break Even 150, and Trailing Stop enabled (Start 200 / Distance 200 / Step 10).




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

### EA-020

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-020_MACD_Signal_Trend/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-020_MACD_Signal_Trend/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [x] Research Methodology Documented (`docs/methodology.md`)
* [ ] RQ-01: Verify Break Even & Trailing Stop Execution
* [ ] RQ-02: Analyze MACD Entry Quality / Losing Signal Conditions
* [ ] RQ-03: Trading Session / Time Filter Evaluation
* [ ] RQ-04: Higher-Timeframe Trend Filter Evaluation
* [ ] RQ-05: BUY vs SELL Directional Evaluation
* [ ] RQ-06: Exit Parameter Evaluation after Entry Research

**Current Research Status:** `IN PROGRESS`

**Optimization Status:** `BLOCKED — Execution validation and controlled research required before parameter optimization`

**Baseline #01:** XAUUSD.PRO / M1 / MACD 12/26/9 strict Main/Signal crossover / MACD Zero-Line trend confirmation / SL 300 / TP 600 / Lot 0.01 / Spread <= 30 / Break Even 150 / Trailing Stop 200.

**Test Period:** 2026-01-02 → 2026-08-01 using 100% real ticks.

**Initial Deposit:** $1,000.00

**Leverage:** 1:500

**Baseline #01 Result:** 2,813 trades, Net Profit **-$993.58**, Profit Factor **0.84**, Expected Payoff **-$0.35**, Sharpe Ratio **-5.00**, Maximum Drawdown **99.38%**, Win Rate **29.61%**.

**Directional Results:**

* BUY: 1,369 trades / **28.41%** won
* SELL: 1,444 trades / **30.75%** won

**Average Trade Results:**

* Average profitable trade: **$6.18**
* Average losing trade: **-$3.10**
* Largest profitable trade: **$40.02**
* Largest losing trade: **-$13.80**
* Maximum consecutive losses: **16**
* Average holding time: **00:09:00**

The baseline configuration is rejected as a profitable candidate. Profit Factor remains below 1.0, expected payoff is negative, and the strategy reaches a **99.38% maximum drawdown**, leaving almost the entire initial deposit lost.

The baseline nevertheless provides a useful controlled comparison with EA-019. While EA-019 uses the **state** of MACD Main relative to the Signal line, EA-020 requires a **strict MACD crossover event** together with zero-line confirmation.

The EA-020 baseline produced a **29.61% win rate** and Profit Factor of **0.84**, so strict crossover by itself does not demonstrate a profitable edge under the tested XAUUSD.PRO M1 conditions.

A technical issue must also be resolved before parameter optimization: the current source requires verification that **Break Even and Trailing Stop position management are actually executed as intended**.

The next research step is therefore execution validation first, followed by controlled investigation of entry quality. No broad parameter optimization should be performed until these components have been independently verified.


---

## 🔬 Research Philosophy

Every strategy follows a simple evidence-driven process:

**Hypothesis → Implementation → Backtest → Evidence → Analysis → Controlled Experiment**

A failed backtest is not removed from the research history.

A successful backtest is not automatically considered ready for live trading.

Each configuration is evaluated independently, and promising strategies must progress through additional robustness, out-of-sample, and forward-testing stages before being considered for live deployment.

### EA-021

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-021_MACD_Histogram_Trend/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-021_MACD_Histogram_Trend/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [x] Research Methodology Documented (`docs/methodology.md`)

**Current Research Status:** `BASELINE COMPLETE — FAIL`

**Baseline #01:** XAUUSD.PRO / M1 / MACD-OsMA 12/26/9 histogram momentum continuation / SL 300 / TP 600 / Lot 0.01 / Spread <= 30 / Break Even OFF / Trailing OFF.

**Test Period:** 2026-01-02 → 2026-08-01 using 100% real ticks.

**Initial Deposit:** $1,000.00

**Leverage:** 1:500

**Baseline #01 Result:** 8,367 trades, Net Profit **-$994.28**, Profit Factor **0.94**, Expected Payoff **-$0.12**, Sharpe Ratio **-5.00**, Maximum Equity Drawdown **99.45%**, Win Rate **32.62%**.

**Directional Results:**

* BUY: 4,089 trades / **32.11%** won
* SELL: 4,278 trades / **33.10%** won

**Average Trade Results:**

* Average profitable trade: **$6.15**
* Average losing trade: **-$3.15**
* Largest profitable trade: **$40.10**
* Largest losing trade: **-$43.71**
* Maximum consecutive wins: **9**
* Maximum consecutive losses: **18**
* Average holding time: **00:04:34**

The baseline configuration is rejected as a profitable candidate. Profit Factor is below 1.0, expected payoff is negative, and maximum drawdown reaches approximately **99.45%**, resulting in the loss of almost the entire initial deposit.

Both BUY and SELL directions show similarly weak results, with win rates of **32.11%** and **33.10%** respectively. The tested baseline therefore does not demonstrate that simple MACD histogram expansion provides a profitable standalone trading edge on XAUUSD.PRO M1.

The failed baseline is retained as research evidence and as a benchmark for any future EA-021 experiments.

No conclusion is made about alternative timeframes, additional filters, different exit logic, or other MACD histogram configurations because these were not evaluated in this baseline test.

### EA-022

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-022_Supertrend_Direction/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-022_Supertrend_Direction/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [x] Research Methodology Documented (`docs/methodology.md`)
* [ ] RQ-01: Trailing Stop ON vs OFF
* [ ] RQ-02: BUY vs SELL Directional Evaluation
* [ ] RQ-03: Multi-Timeframe Evaluation (M1 / M5 / M15)
* [ ] RQ-04: Supertrend ATR Period / Multiplier Evaluation
* [ ] RQ-05: Additional Market Filters — only after core strategy research

**Current Research Status:** `IN PROGRESS`

**Optimization Status:** `BLOCKED — Controlled research required before parameter optimization`

**Baseline #01:** XAUUSD.PRO / M1 / Supertrend ATR Period 10 / Multiplier 3.0 / SL 300 / TP 600 / Lot 0.01 / Maximum Spread 50 / Maximum Positions 1 / Break Even OFF / Trailing Stop ON (Start 200 / Distance 200 / Step 10).

**Test Period:** 2026-01-02 → 2026-08-01 using 100% real ticks.

**Initial Deposit:** $1,000.00

**Leverage:** 1:500

**Baseline #01 Result:** 2,429 trades, Net Profit **-$992.78**, Profit Factor **0.74**, Expected Payoff **-$0.41**, Sharpe Ratio **-5.00**, Maximum Drawdown **99.28%**, Win Rate **46.93%**.

**Directional Results:**

* BUY: 1,211 trades / **45.00%** won
* SELL: 1,218 trades / **48.85%** won

**Average Trade Results:**

* Average profitable trade: **$2.46**
* Average losing trade: **-$2.95**
* Largest profitable trade: **$33.85**
* Largest losing trade: **-$40.44**
* Maximum consecutive wins: **10**
* Maximum consecutive losses: **11**
* Average holding time: **00:03:32**

The baseline configuration is rejected as a profitable candidate. Profit Factor is below 1.0, expected payoff is negative, and maximum drawdown reaches **99.28%**, resulting in the loss of almost the entire initial deposit.

The balance curve shows persistent deterioration rather than an isolated period of poor performance. Both trade directions are unprofitable under the tested configuration, although SELL trades produced a higher win rate (**48.85%**) than BUY trades (**45.00%**).

The failed baseline does not by itself establish that the underlying Supertrend concept has no trading edge. It establishes that the tested combination of raw Supertrend direction changes, M1 execution, and the current exit configuration does not demonstrate a viable edge.

The first controlled experiment will therefore isolate the effect of trade management by comparing the current **Trailing Stop ON** baseline against an otherwise identical **Trailing Stop OFF** configuration.

Subsequent experiments will evaluate BUY versus SELL directionality and M1 versus higher timeframes before broad Supertrend parameter optimization is considered.

No conclusion is made about alternative ATR periods, Supertrend multipliers, higher timeframes, additional filters, or different exit configurations because these have not yet been independently tested.

### EA-023

* [x] Strategy Code & Technical Specifications Setup (`EAs/EA-023_Supertrend_Retest/`)
* [x] Baseline Backtest Completed (#01) (`Backtest/EA-023_Supertrend_Retest/`)
* [x] Baseline Experiment #01 Assessed: **FAIL**
* [x] Research Documentation Updated (`Research/`)
* [x] Research Methodology Documented (`docs/methodology.md`)
* [ ] RQ-01: BUY vs SELL Directional Evaluation
* [ ] RQ-02: Trading Hour / Session Evaluation
* [ ] RQ-03: Break Even ON vs OFF
* [ ] RQ-04: Trailing Stop ON vs OFF
* [ ] RQ-05: Retest Window / Buffer Evaluation
* [ ] RQ-06: Supertrend ATR Period / Multiplier Evaluation
* [ ] RQ-07: Stop Loss / Take Profit Evaluation

**Current Research Status:** `IN PROGRESS`

**Optimization Status:** `BLOCKED — Controlled research required before parameter optimization`

**Baseline #01:** XAUUSD.PRO / M1 / Supertrend ATR Period 10 / Multiplier 3.0 / Retest Window 5 bars / Retest Buffer 5.0 points / SL 300 / TP 600 / Lot 0.01 / Maximum Spread 30 / Maximum Positions 1 / Break Even ON (Trigger 150) / Trailing Stop ON (Start 200 / Distance 200 / Step 10).

**Test Period:** 2026-01-02 → 2026-03-01 using 100% real ticks.

**Initial Deposit:** $1,000.00

**Leverage:** 1:500

**Baseline #01 Result:** 139 trades, Net Profit **-$18.71**, Profit Factor **0.89**, Expected Payoff **-$0.13**, Recovery Factor **-0.34**, Sharpe Ratio **-5.00**, Maximum Equity Drawdown **5.51%**, Win Rate **48.20%**.

**Directional Results:**

* BUY: 49 trades / **44.90%** won
* SELL: 90 trades / **50.00%** won

**Average Trade Results:**

* Average profitable trade: **$2.34**
* Average losing trade: **-$2.44**
* Largest profitable trade: **$7.42**
* Largest losing trade: **-$3.92**
* Maximum consecutive wins: **9**
* Maximum consecutive losses: **6**
* Average holding time: **00:02:38**

The baseline configuration is rejected as a profitable candidate. Net Profit and Expected Payoff are negative, while Profit Factor remains below 1.0.

Unlike several earlier failed M1 baselines, EA-023 produced a relatively limited Maximum Equity Drawdown of **5.51%** during this test. However, low drawdown alone does not establish a profitable trading edge.

SELL trades produced a higher win rate (**50.00%**) than BUY trades (**44.90%**), but this difference is treated only as an observation. A controlled BUY-versus-SELL experiment is required before making any directional filtering decision.

The realized average profitable trade (**$2.34**) is slightly smaller than the average losing trade (**-$2.44**) despite the baseline using a nominal fixed SL 300 / TP 600 configuration. Break Even and Trailing Stop are active, so their effect on realized trade outcomes requires separate controlled testing.

The failed baseline does not establish that the underlying Supertrend Retest concept has no trading edge. It establishes only that the tested combination of Supertrend direction change, retest entry logic, M1 execution, and the current trade-management configuration does not demonstrate positive expectancy during the tested period.

The next research steps will isolate BUY versus SELL performance, trading-hour/session effects, Break Even, Trailing Stop, and retest parameters before broad Supertrend parameter optimization is considered.

No conclusion is made about alternative ATR periods, Supertrend multipliers, higher timeframes, session filters, or different exit configurations because these have not yet been independently tested.



---

## ⚠️ Disclaimer

This repository documents algorithmic trading research, strategy development, and historical backtesting.

Backtest results do not guarantee future performance.

Nothing in this repository should be considered financial or investment advice.
