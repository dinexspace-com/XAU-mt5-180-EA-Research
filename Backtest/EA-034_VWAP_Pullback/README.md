# EA-034 — VWAP Pullback Backtest

## Backtest Summary

This directory contains the MetaTrader 5 Strategy Tester results for:

**EA-034_VWAP_Pullback**

The purpose of this backtest is to establish a documented baseline for the current strategy implementation.

> **Result: FAILED**
>
> The tested configuration produced negative net profit, Profit Factor below 1.0, negative expectancy, and substantial drawdown.
>
> This version should not be considered validated for live trading.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-034_VWAP_Pullback |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Broker / Company | ACCM Intl Limited |
| Terminal | ACCMIntl-Real |
| MT5 Build | 6140 |
| Initial Deposit | $1,000.00 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Symbols | 1 |

---

## Parameters

### Main Trading Parameters

| Parameter | Value |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpSlippage` | 10 |

### Position Management

| Parameter | Value |
|---|---:|
| `InpUseBreakEven` | false |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenLock` | 0 |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingStep` | 50 |

### Trading Filters

| Parameter | Value |
|---|---:|
| `InpMaxSpread` | 30 |
| `InpMaxPositions` | 1 |
| `InpMagicNumber` | 202411 |
| `InpUseVWAPFilter` | true |

---

## Performance Results

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$335.57** |
| Gross Profit | $1,715.70 |
| Gross Loss | -$2,051.27 |
| Profit Factor | **0.84** |
| Expected Payoff | **-$0.36** |
| Recovery Factor | **-0.91** |
| Sharpe Ratio | **-5.00** |
| Total Trades | 939 |
| Total Deals | 1,878 |

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $344.33 |
| Balance Drawdown Maximal | **$367.65 (35.93%)** |
| Balance Drawdown Relative | **35.93%** |
| Equity Drawdown Absolute | $344.56 |
| Equity Drawdown Maximal | **$369.81 (36.07%)** |
| Equity Drawdown Relative | **36.07%** |

The balance curve shows a persistent decline over the test period rather than a temporary isolated drawdown.

This is consistent with the negative expectancy and Profit Factor below 1.0.

---

## Trade Statistics

### Overall

| Metric | Result |
|---|---:|
| Total Trades | 939 |
| Winning Trades | 280 (29.82%) |
| Losing Trades | 659 (70.18%) |
| Average Profit Trade | $6.13 |
| Average Loss Trade | -$3.11 |
| Largest Profit Trade | $7.44 |
| Largest Loss Trade | -$6.22 |

The average winning trade is approximately twice the size of the average losing trade.

However, the **29.82% win rate was insufficient to produce positive expectancy** under this configuration.

---

## Long vs Short

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | 457 | 30.63% |
| Long | 482 | 29.05% |

Neither direction demonstrated a sufficiently high win rate in this test.

The short side performed slightly better by win rate, but this backtest alone does not establish that the difference is statistically meaningful.

---

## Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 4 |
| Maximum Consecutive Profit | $24.70 |
| Maximum Consecutive Losses | 17 |
| Maximum Consecutive Loss | -$54.00 |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

A maximum losing streak of **17 trades** indicates significant clustering of losing signals.

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 03:44:00 |
| Average Holding Time | 00:07:51 |

The strategy therefore operated primarily as a short-duration intraday system during this test.

---

## MFE / MAE Analysis

MetaTrader reported:

| Correlation | Result |
|---|---:|
| Profit vs MFE | 0.83 |
| Profit vs MAE | 0.86 |
| MFE vs MAE | 0.6924 |

The accompanying MFE/MAE plots are retained in this directory for future strategy analysis.

No optimization conclusion should be made from these correlations alone.

---

## Balance Curve

See:

`ReportTester-952747(7).png`

The balance curve is the clearest high-level indication that the tested version does not currently demonstrate a profitable edge.

Starting from approximately:

`$1,000`

the test finished with:

`$664.43`

corresponding to:

`-$335.57 Total Net Profit`

The curve trends downward across the test rather than showing a stable upward equity progression.

---

## Entry Distribution

See:

`ReportTester-952747-hst(7).png`

The Strategy Tester report includes distributions for:

- entries by hour;
- entries by weekday;
- entries by month;
- profits and losses by hour;
- profits and losses by weekday;
- profits and losses by month.

The test contains activity across multiple trading hours and weekdays.

These distributions can later be used to investigate whether specific sessions or time windows are responsible for a disproportionate share of losses.

No session filter is approved based on this backtest alone.

---

## Baseline Assessment

### Result: FAIL

The current configuration does not pass baseline profitability validation.

Primary evidence:

1. **Total Net Profit:** -$335.57
2. **Profit Factor:** 0.84
3. **Expected Payoff:** -$0.36/trade
4. **Sharpe Ratio:** -5.00
5. **Winning Trades:** 29.82%
6. **Maximum Equity Drawdown:** 36.07%
7. **Balance curve:** persistent downward trend

Therefore:

**EA-034_VWAP_Pullback is NOT validated for live trading in its current tested configuration.**

---

## Important Interpretation

This result means:

**This specific EA version + parameter configuration + symbol + timeframe + historical period failed the backtest.**

It does NOT prove that the underlying VWAP Pullback concept is permanently invalid.

Further research would be required to determine whether the weakness comes from:

- entry logic;
- VWAP proximity condition;
- trading session;
- market regime;
- SL/TP configuration;
- trailing-stop behavior;
- long/short asymmetry;
- or another strategy component.

Those questions belong to the research stage and should not be answered by modifying or selectively filtering this baseline result.

---

## Evidence Files

### Full MT5 Report

`ReportTester-952747(7).html`

Original MetaTrader 5 Strategy Tester report containing:

- test settings;
- parameters;
- performance metrics;
- orders;
- deals;
- trade history;
- Strategy Tester statistics.

This file is the primary source of truth for this backtest.

### Balance Curve

`ReportTester-952747(7).png`

### Historical Distribution

`ReportTester-952747-hst(7).png`

Contains trade and P/L distributions by:

- hour;
- weekday;
- month.

### MFE / MAE

`ReportTester-952747-mfemae(7).png`

Contains Maximum Favorable Excursion and Maximum Adverse Excursion analysis.

### Holding Time

`ReportTester-952747-holding(7).png`

Contains trade profit/loss distribution relative to position holding time.

---

## Backtest Status

**Baseline Backtest: COMPLETE**

**Performance Validation: FAIL**

Reason:

`Negative expectancy + Profit Factor < 1 + negative net profit + high drawdown`

This baseline should be preserved unchanged as evidence for subsequent research and strategy revisions.
