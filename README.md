[README.md](https://github.com/user-attachments/files/31080693/README.md)
# XAUUSD MT5 EA Research

A systematic research project developing and testing **180 Expert Advisors (EAs)** for **XAUUSD on MetaTrader 5**.

The project focuses on systematic strategy research, coding, backtesting, optimization and forward testing.

## Research Matrix

| Category | EA Count |
|---|---:|
| Trend | 45 |
| Breakout | 36 |
| Mean Reversion | 27 |
| Momentum | 18 |
| Volatility / Session | 18 |
| Price Action | 18 |
| Experimental | 18 |
| **Total** | **180** |

## Common Setup

- **Symbol:** XAUUSD
- **Timeframe:** M1
- **Platform:** MetaTrader 5
- **Maximum open positions:** 1 XAUUSD position
- **Default Stop Loss:** 300 points
- **Default Take Profit:** 600 points
- **Break Even:** 150 points
- **Trailing Stop:** 200 points
- **Maximum Spread:** 30 points

## Project Workflow

```text
Research Matrix
      ↓
Build EA
      ↓
Compile
      ↓
Backtest
      ↓
Record Results
      ↓
PASS / FAIL
      ↓
Optimization
      ↓
Forward Test
      ↓
Demo
      ↓
Finalist
```

## Current Progress

| EA | Strategy | Status |
|---|---|---|
| EA-001 | EMA 8/21 Cross | Research |
| EA-002 | EMA 13/34 Cross | Research |

More EAs will be added progressively.

## Repository Structure

```text
EAs/
├── EA-001_EMA_8_21_Cross/
│   ├── EA-001_EMA_8_21_Cross.mq5
│   └── README.md
├── EA-002/
└── ...

Backtest/
├── EA-001/
├── EA-002/
└── ...

Research/
└── 180-EA-Research-Matrix.xlsx

docs/
└── methodology.md
```

## Purpose

This repository is intended to document an open research process around automated XAUUSD trading systems and MetaTrader 5 development.

The source code is published so other developers and traders can inspect, learn from, test and discuss the strategies.

## Disclaimer

This project is for research and educational purposes.

Backtest results are historical simulations and do not guarantee future performance. Automated trading involves substantial risk. Always test an EA on appropriate historical data and a demo account before considering live deployment.

## Author

**[YOUR NAME]**

GitHub: **[@YOUR_GITHUB_USERNAME]**

