# Backtest — EA-029 Ichimoku Kijun Pullback

## Overview

This folder contains the MetaTrader 5 backtest results for:

**EA-029_Ichimoku_Kijun_Pullback**

The test evaluates the baseline Ichimoku Kijun Pullback strategy on XAUUSD using M1 data.

This result is preserved as a research baseline. It is not presented as evidence of a profitable production-ready strategy.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-029_Ichimoku_Kijun_Pullback |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.03.01 |
| Initial Deposit | $100.00 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 56,115 |
| Ticks | 25,190,686 |

---

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 60 points |
| Maximum Positions | 1 |
| Slippage | 10 points |
| Tenkan-sen | 9 |
| Kijun-sen | 26 |
| Senkou Span B | 52 |
| Break Even | Disabled |
| Trailing Stop | Disabled |

Additional configuration:

```text
Magic Number       = 123456

BreakEven Trigger  = 150
BreakEven Lock     = 5

Trailing Start     = 200
Trailing Step      = 20
```

Break Even and Trailing Stop parameters were present in the EA configuration but both features were disabled during this test.

---

## Main Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$22.77** |
| Gross Profit | $3,688.88 |
| Gross Loss | -$3,711.65 |
| Profit Factor | **0.99** |
| Expected Payoff | -$0.01 |
| Recovery Factor | -0.07 |
| Sharpe Ratio | -0.95 |
| Total Trades | **1,769** |
| Total Deals | 3,538 |
| Winning Trades | 582 (32.90%) |
| Losing Trades | 1,187 (67.10%) |

The baseline configuration finished the tested period with a negative net result.

---

## BUY vs SELL

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | 909 | 34.98% |
| Long | 860 | 30.70% |

SELL trades achieved a slightly higher win rate than BUY trades during this test.

However, neither direction is evaluated independently enough here to establish a robust directional advantage.

---

## Trade Distribution

### Winning Trades

```text
582 / 1,769
Win Rate = 32.90%
```

### Losing Trades

```text
1,187 / 1,769
Loss Rate = 67.10%
```

The strategy has a relatively low win rate.

This is partly offset by the difference between average winning and losing trades:

| Metric | Result |
|---|---:|
| Average Profit Trade | $6.34 |
| Average Loss Trade | -$3.13 |
| Largest Profit Trade | $35.35 |
| Largest Loss Trade | -$8.79 |

The average winning trade was approximately twice the magnitude of the average losing trade.

Despite this payoff structure, the win rate was insufficient to produce positive net profitability in this test.

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $63.89 |
| Balance Drawdown Maximal | $317.00 (89.77%) |
| Balance Drawdown Relative | 89.77% |
| Equity Drawdown Absolute | $69.95 |
| Equity Drawdown Maximal | $324.95 (91.54%) |
| Equity Drawdown Relative | **91.54%** |

The drawdown is extremely high relative to the initial $100 deposit.

This baseline configuration therefore demonstrates unacceptable risk characteristics for live deployment.

---

## Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Losses | 17 |
| Maximal Consecutive Profit | $38.53 (2 trades) |
| Maximal Consecutive Loss | -$53.46 (17 trades) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 3 |

The maximum losing streak reached **17 consecutive trades**.

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Average Holding Time | 00:07:26 |
| Maximum Holding Time | 02:25:02 |

The strategy therefore behaved primarily as a short-duration intraday system during this M1 test.

---

## MFE / MAE

MetaTrader reported:

| Correlation | Value |
|---|---:|
| Profit vs MFE | 0.86 |
| Profit vs MAE | 0.72 |
| MFE vs MAE | 0.5549 |

These statistics and the accompanying MFE/MAE charts are retained for later analysis of trade excursion behavior.

No optimization conclusion is made from these correlations alone.

---

## Equity / Balance Observation

The balance curve shows substantial variation during the test.

The strategy experienced periods of significant account growth, followed by large drawdowns that removed those gains.

The final result was:

```text
Initial Deposit : $100.00
Net Profit      : -$22.77
```

This behavior indicates that the baseline strategy was capable of capturing profitable periods but did not maintain those gains consistently across the complete test period.

---

## Baseline Assessment

### Result: FAIL

The current configuration does **not** pass profitability and risk requirements.

Primary evidence:

```text
Net Profit          = -$22.77
Profit Factor       = 0.99
Expected Payoff     = -$0.01
Sharpe Ratio        = -0.95

Win Rate            = 32.90%
Loss Rate           = 67.10%

Balance Drawdown    = 89.77%
Equity Drawdown     = 91.54%
```

The most important issue is not only the negative final return, but the extremely high drawdown observed during the test.

---

## Research Value

Although the baseline fails as a deployable strategy, the test produced **1,769 trades using 100% real tick history**, providing a useful sample for further research.

This backtest should therefore be treated as:

```text
Baseline strategy
      ↓
Measure behavior
      ↓
Identify weaknesses
      ↓
Research improvements
      ↓
Run new controlled backtests
```

The original baseline result should be preserved rather than overwritten by future optimization results.

---

## Backtest Files

Recommended contents of this folder:

```text
EA-029_Ichimoku_Kijun_Pullback/
│
├── README.md
│
├── ReportTester-952747.html
├── ReportTester-952747.png
├── ReportTester-952747-hst.png
├── ReportTester-952747-mfemae.png
└── ReportTester-952747-holding.png
```

### Files

**ReportTester-952747.html**

Complete MetaTrader 5 Strategy Tester report containing settings, performance statistics, orders and deals.

**ReportTester-952747.png**

Balance curve generated by MetaTrader 5.

**ReportTester-952747-hst.png**

Trade distribution by hour, weekday and month.

**ReportTester-952747-mfemae.png**

MFE / MAE analysis.

**ReportTester-952747-holding.png**

Position holding-time distribution.

---

## Important Note

This backtest represents one specific configuration, symbol, timeframe, broker environment and historical period.

It does not demonstrate future profitability.

The purpose of preserving this result is to provide a reproducible baseline for subsequent EA research and comparison.
