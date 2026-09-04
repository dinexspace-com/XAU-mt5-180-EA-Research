# Backtest — EA-041 Inside Pullback Trend

## Overview

This folder contains MetaTrader 5 Strategy Tester results for:

**EA-041 — Inside Pullback Trend**

The purpose of this backtest is to establish a baseline performance result for the current EA implementation on XAUUSD before further optimization or robustness testing.

---

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-041_Inside_Pullback_Trend |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-09-03 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 237,438 |
| Ticks | 99,256,611 |
| Currency | USD |

Broker / test environment:

- ACCMIntl-Real
- MetaTrader 5 Build 6140
- ACCM Intl Limited

---

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123456 |
| Slippage | 10 |
| Max Spread | 35 points |
| Max Orders | 1 |
| Break Even | Disabled |
| Break Even Trigger | 150 |
| Break Even Level | 0 |
| Trailing Stop | Disabled |
| Trailing Start | 200 |
| Trailing Step | 50 |

This baseline test therefore evaluates the core Inside Pullback Trend strategy without Break Even or Trailing Stop management.

---

## Main Results

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **+$26.78** |
| Gross Profit | $152.66 |
| Gross Loss | -$125.88 |
| Profit Factor | **1.21** |
| Expected Payoff | $0.47 |
| Recovery Factor | 0.56 |
| Sharpe Ratio | 10.17 |
| Total Trades | **57** |
| Total Deals | 114 |

Approximate return on initial capital:

**+2.68%**

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $6.48 |
| Balance Drawdown Maximal | $45.37 (4.31%) |
| Balance Drawdown Relative | 4.31% |
| Equity Drawdown Absolute | $6.69 |
| Equity Drawdown Maximal | $47.52 (4.50%) |
| Equity Drawdown Relative | **4.50%** |

The baseline produced positive net profit while keeping reported maximum equity drawdown below 5%.

---

## Trade Statistics

### Overall

| Metric | Result |
|---|---:|
| Total Trades | 57 |
| Winning Trades | 18 (31.58%) |
| Losing Trades | 39 (68.42%) |
| Largest Profit Trade | +$47.71 |
| Largest Loss Trade | -$6.75 |
| Average Profit Trade | +$8.48 |
| Average Loss Trade | -$3.23 |

The strategy has a relatively low win rate, but its average winning trade is substantially larger than its average losing trade.

Average Winner / Average Loser:

**8.48 / 3.23 ≈ 2.63**

---

## Long vs Short

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 23 | 34.78% |
| Short | 34 | 29.41% |

Both BUY and SELL sides participated in the test.

The BUY side achieved a somewhat higher win rate, but this baseline alone is not sufficient to determine whether directional filtering would improve the strategy.

---

## Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 3 |
| Maximum Consecutive Losses | 8 |
| Maximal Consecutive Profit | $47.71 |
| Maximal Consecutive Loss | -$24.30 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 3 |

The EA experienced a maximum losing sequence of **8 consecutive trades** during this test.

This characteristic should be considered in future risk-management and robustness testing.

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:03 |
| Maximum Holding Time | 02:54:30 |
| Average Holding Time | **00:16:51** |

The M1 implementation therefore behaves as a relatively short-duration trading strategy in this test.

---

## MFE / MAE Statistics

Reported Strategy Tester correlations:

| Correlation | Result |
|---|---:|
| Profit vs MFE | 0.93 |
| Profit vs MAE | 0.63 |
| MFE vs MAE | 0.4333 |

These statistics are retained as baseline diagnostic data for later analysis of exit behavior and trade management.

---

## Balance Curve

The test started with:

**$1,000**

and finished with approximately:

**$1,026.78**

The balance curve was not consistently upward throughout the entire test period.

The strategy generated a strong early increase, subsequently experienced a prolonged drawdown/retracement period, and recovered partially toward the end of the test.

Therefore, positive final net profit should not by itself be interpreted as evidence of a stable production-ready edge.

---

## Baseline Assessment

### Positive observations

- Positive Total Net Profit: **+$26.78**
- Profit Factor above 1: **1.21**
- Maximum Equity Drawdown: **4.50%**
- Average winner significantly larger than average loser
- Both BUY and SELL signals generated trades
- Test used **100% real ticks**

### Weak points

- Only **57 trades** across the test period
- Win rate only **31.58%**
- Maximum losing streak reached **8 trades**
- Profit Factor of **1.21** provides only a modest profitability margin
- Recovery Factor only **0.56**
- Balance curve is not consistently increasing
- Result may be sensitive to a small number of large winning trades
- Only one symbol/timeframe/configuration is represented by this baseline test

---

## Current Status

**Status: BASELINE BACKTEST — NOT VALIDATED FOR LIVE TRADING**

The current result demonstrates that the EA produced a positive result under this specific Strategy Tester configuration.

It does **not** establish that the strategy is robust, optimized, or suitable for live trading.

No production approval should be inferred from this baseline result.

---

## Next Validation

Future testing may evaluate:

- Longer historical periods
- Different market regimes
- Additional XAUUSD timeframes
- Parameter sensitivity
- Spread sensitivity
- Break Even ON/OFF
- Trailing Stop ON/OFF
- Out-of-sample testing
- Walk-forward testing
- Monte Carlo / robustness testing
- Forward testing

These should be stored as separate test runs rather than replacing the baseline result.

---

## Backtest Files

Recommended structure:

Backtest/
└── EA-041_Inside_Pullback_Trend/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png

The original MetaTrader 5 Strategy Tester report should be preserved together with its generated charts so that the README summary remains auditable.

---

## Conclusion

EA-041 Inside Pullback Trend achieved a **positive baseline result** on XAUUSD.PRO M1 from January to September 2026.

Key baseline figures:

- Net Profit: **+$26.78**
- Return on $1,000 initial deposit: **~+2.68%**
- Profit Factor: **1.21**
- Maximum Equity Drawdown: **4.50%**
- Total Trades: **57**
- Win Rate: **31.58%**
- Maximum Consecutive Losses: **8**

The result is sufficient to preserve as a baseline research run, but it is **not sufficient to classify the EA as robust or production-ready**.
