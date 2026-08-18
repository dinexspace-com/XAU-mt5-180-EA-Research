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

---

## 📊 Development & Research Workflow
- **Backtesting:** 100% Real Ticks history data backtesting for maximum precision.
- **Methodology:** Systematic hypothesis-driven experiments (`docs/methodology.md` & project-specific docs).
- **Research:** Continuous optimization on timeframes, trend filters, and volatility controls (`Research/`).

---

## 🛠️ Tech Stack & Tools
- **Trading Platforms:** MetaTrader 4 / MetaTrader 5 (MQL4 / MQL5)
- **Languages:** MQL4, MQL5, Python (Data Analysis)
- **Version Control:** Git, GitHub
- **Analysis:** Backtest Reports, Quantitative Metrics (Profit Factor, Drawdown, Sharpe Ratio)

---

## 📈 Current Projects Status

### EA-001
- [x] Baseline Backtest Completed
- [x] Research & Experiment Framework Setup
- [ ] Experiment 01: Timeframe Optimization
- [ ] Experiment 02: Trend Filter Integration

### EA-002
- [x] Baseline Backtest Completed (#01)
- [x] Strategy Code & Documentations Setup
- [ ] Experiment 01: Break Even & Trailing Stop Integration
- [ ] Experiment 02: Higher Timeframe (H1 EMA 200) Trend Filter

### EA-003
- [x] Strategy Code & Technical Specifications Setup (`EAs/EA-003TrendEMA_20_50_Cross/`)
- [x] Baseline Backtest Completed (#01) (`Backtest/EA-003TrendEMA_20_50_Cross/`)
- [ ] Experiment 01: Filter Relaxation to Increase Trade Frequency
- [ ] Experiment 02: Multi-Timeframe (M5/M15) Evaluation

### EA-004
- [x] Strategy Code & Technical Specifications Setup (`EAs/EA-004_SMA_10_30_Cross/`)
- [x] Baseline Backtest Completed (#01) (`Backtest/EA-004_SMA_10_30_Cross/`)
- [ ] Experiment 01: Trend Filter Integration (HTF EMA 200 / ADX) to Reduce Whipsaws
- [ ] Experiment 02: Timeframe Shift (M5/M15) & Parameter Optimization

### EA-005
- [x] Strategy Code & Technical Specifications Setup (`EAs/EA-005_SMA_20_100_Cross/`)
- [x] Baseline Backtest Completed (#01) (`Backtest/EA-005_SMA_20_100_Cross/`)
- [ ] Experiment 01: Timeframe Shift (M15/H1) & EMA Replacement (Reduce Whipsaw Losses)
- [ ] Experiment 02: Trend Filter (ADX > 25) & Dynamic Risk-per-Trade Implementation

### EA-006
- [x] Strategy Code & Technical Specifications Setup (`EAs/EA-006_EMA_5_20_Pullback/`)
- [x] Baseline Backtest Completed (#01) (`Backtest/EA-006_EMA_5_20_Pullback/`)
- [ ] Experiment 01: Multi-Timeframe Filter Integration (HTF EMA 200)
- [ ] Experiment 02: BreakEven & Trailing Stop Optimization

### EA-007
- [x] Strategy Code & Technical Specifications Setup (`EAs/EA-007_EMA_9_50_Pullback/`)
- [x] Baseline Backtest Completed (#01) (`Backtest/EA-007_EMA_9_50_Pullback/`)
- [ ] Experiment 01: Multi-Timeframe Filter Integration (HTF EMA 200)
- [ ] Experiment 02: Volatility / ADX Filter Implementation & Timeframe Shift (M5/M15)

### EA-008
- [x] Strategy Code & Technical Specifications Setup (`EAs/EA-008_EMA_21_55_Pullback/`)
- [x] Baseline Backtest Completed (#01) (`Backtest/EA-008_EMA_21_55_Pullback/`)
- [ ] Experiment 01: Higher Timeframe Trend Filter (HTF EMA 200) Integration
- [ ] Experiment 02: Timeframe Scaling (M5/M15) & Risk-Reward Parameter Tuning

### EA-009
- [x] Strategy Code & Technical Specifications Setup (`EAs/EA-009_EMA_34_89_Pullback/`)
- [x] Baseline Backtest Completed (#01) (`Backtest/EA-009_EMA_34_89_Pullback/`)
- [ ] Experiment 01: Higher Timeframe Trend Filter (HTF EMA 200) Integration
- [ ] Experiment 02: Timeframe Scaling (M5/M15) & Volatility (ADX/ATR) Filter Integration
