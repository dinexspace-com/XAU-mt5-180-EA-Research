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

---

## 📊 Development & Research Workflow
- **Backtesting:** 100% Real Ticks history data backtesting for maximum precision.
- **Methodology:** Systematic hypothesis-driven experiments (`docs/methodology.md` & `docs/methodology-EA-002.md`).
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
