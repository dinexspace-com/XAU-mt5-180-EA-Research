# EA-031 — SAR + EMA50 Backtest

## Overview

This folder contains the MetaTrader 5 Strategy Tester results for:

**EA-031_SAR_EMA50**

The purpose of this backtest is to evaluate the baseline performance of the SAR + EMA50 strategy on XAUUSD before further optimization or modification.

---

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-031_SAR___EMA50 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000.00 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

---

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123456 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Maximum Positions | 1 |
| Break Even | Disabled |
| Break Even Trigger | 150 points |
| Break Even Lock | 0 |
| Trailing Stop | Disabled |
| Trailing Start | 200 points |
| Trailing Step | 50 points |

This test therefore evaluates the strategy without active Break Even or Trailing Stop management.

---

## Main Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$991.82** |
| Gross Profit | $11,312.14 |
| Gross Loss | -$12,303.96 |
| Profit Factor | **0.92** |
| Expected Payoff | **-$0.17** |
| Recovery Factor | -0.96 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | **$1,036.87 (99.22%)** |
| Maximum Equity Drawdown | **$1,036.87 (99.22%)** |
| LR Correlation | -0.81 |

---

## Trading Statistics

| Metric | Result |
|---|---:|
| Total Trades | **5,680** |
| Total Deals | 11,360 |
| Winning Trades | 1,814 (31.94%) |
| Losing Trades | 3,866 (68.06%) |
| Short Trades | 2,860 |
| Short Win Rate | 31.15% |
| Long Trades | 2,820 |
| Long Win Rate | 32.73% |

The strategy generated a large sample of trades, with BUY and SELL activity distributed relatively evenly.

However, only **31.94% of all trades were profitable**, while **68.06% were losing trades**.

---

## Trade Distribution

### Winning Trades

```text
1,814
31.94%
