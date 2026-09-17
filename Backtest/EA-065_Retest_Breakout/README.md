# EA-065 — Retest Breakout Backtest

## Overview

This directory contains the MetaTrader 5 backtest evidence for:

**EA-065_Retest_Breakout**

The purpose of this test is to establish the baseline performance of the original EA configuration before optimization or strategy modification.

This README records the test environment, EA parameters, core performance metrics, observed behavior, and the current research status.

---

## Backtest Environment

| Item | Value |
|---|---|
| Expert Advisor | EA-065_Retest_Breakout |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $100.00 |
| Leverage | 1:500 |
| Broker / Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols Tested | 1 |

---

## EA Parameters

### Execution

| Parameter | Value |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpMagicNumber` | 123065 |
| `InpSlippage` | 10 |
| `InpMaxSpread` | 30 |
| `InpTimeframe` | M1 |
| `InpBreakoutLookback` | 20 |
| `InpBreakoutBuffer` | 0 |

### Retest

| Parameter | Value |
|---|---:|
| `InpRetestTolerance` | 20 |
| `InpRetestMaxBars` | 10 |

### Break Even

| Parameter | Value |
|---|---:|
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenOffset` | 0 |

### Trailing Stop

| Parameter | Value |
|---|---:|
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 100 |
| `InpTrailingStep` | 10 |

---

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$94.61** |
| Gross Profit | $479.85 |
| Gross Loss | -$574.46 |
| Profit Factor | **0.84** |
| Expected Payoff | **-$0.21** |
| Recovery Factor | **-0.85** |
| Sharpe Ratio | **-5.00** |
| Balance Drawdown Absolute | $94.61 |
| Balance Drawdown Maximal | **$109.66 / 95.32%** |
| Balance Drawdown Relative | **95.32%** |
| Equity Drawdown Absolute | $94.61 |
| Equity Drawdown Maximal | **$110.67 / 95.36%** |
| Equity Drawdown Relative | **95.36%** |
| LR Correlation | -0.90 |
| LR Standard Error | 12.61 |

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | **459** |
| Total Deals | 918 |
| Winning Trades | 236 |
| Losing Trades | 223 |
| Win Rate | **51.42%** |
| Loss Rate | 48.58% |
| Short Trades | 200 |
| Short Win Rate | 49.50% |
| Long Trades | 259 |
| Long Win Rate | 52.90% |
| Largest Profit Trade | $7.36 |
| Largest Loss Trade | -$5.35 |
| Average Profit Trade | $2.03 |
| Average Loss Trade | -$2.58 |
| Maximum Consecutive Wins | 7 |
| Maximum Consecutive Losses | 8 |
| Maximal Consecutive Profit | $16.29 / 5 trades |
| Maximal Consecutive Loss | -$20.49 / 6 trades |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

---

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:02 |
| Average Holding Time | 00:04:30 |
| Maximum Holding Time | 02:04:00 |

The EA therefore behaves as a short-duration intraday system under this M1 configuration, with most exposure measured in minutes rather than hours.

---

## MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profit, MFE) | 0.96 |
| Correlation (Profit, MAE) | 0.74 |
| Correlation (MFE, MAE) | 0.6262 |

The strong positive correlation between realized profit and MFE indicates that trades which achieved larger favorable excursions generally produced larger realized profits.

However, the overall system remained unprofitable despite this relationship.

---

## Baseline Assessment

### Result: FAIL

The baseline configuration is **not suitable for deployment**.

The main reasons are:

- Total Net Profit is negative at **-$94.61**.
- Profit Factor is below 1 at **0.84**.
- Expected Payoff is negative at **-$0.21 per trade**.
- Maximum equity drawdown reached approximately **95.36%**.
- Sharpe Ratio is negative at **-5.00**.
- LR Correlation is strongly negative at **-0.90**.
- The balance curve shows a persistent long-term decline.
- The account experienced severe capital deterioration during the tested period.

Although the strategy achieved a win rate slightly above 50%, this was insufficient to generate positive expectancy.

The primary reason is the payoff structure:

```text
Average Winning Trade = +$2.03
Average Losing Trade  = -$2.58
```

Therefore, the average loss was materially larger than the average win.

A win rate of approximately 51% is not sufficient to compensate for this negative realized reward/risk relationship.

---

## Important Observation

The original configuration uses:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

which nominally represents a 1:2 SL/TP relationship.

However, realized trade statistics show:

```text
Average Profit Trade = +$2.03
Average Loss Trade   = -$2.58
```

This indicates that actual trade exits differ substantially from the nominal SL/TP ratio.

Break-even and trailing-stop logic affect realized trade outcomes.

Therefore, future research should evaluate the interaction between:

```text
Breakout detection
Retest confirmation
Break-even trigger
Trailing start
Trailing distance
Trailing step
Stop Loss
Take Profit
```

rather than assuming that the nominal SL/TP ratio represents the EA's actual realized risk/reward profile.

---

## Balance Curve Observation

The balance curve shows:

1. An initial period of growth.
2. A peak during the early part of the test.
3. Progressive deterioration afterward.
4. Several temporary recoveries.
5. Continued decline toward the end of the test period.

This indicates that the baseline parameter set was not stable across the full test period.

The strategy appears capable of producing profitable clusters of trades but fails to preserve those gains across changing market conditions.

---

## Trade Distribution

The EA generated trades across most trading hours.

Trading activity occurred across Asian, European, and US sessions rather than being concentrated in one narrow session.

The weekday distribution shows substantial activity from Monday through Friday.

The available report therefore does not support treating the current EA as a session-specific strategy.

Further optimization may investigate whether restricting trading hours improves performance.

---

## Research Interpretation

This test should be treated as a **baseline research result**, not as evidence that the Retest Breakout concept itself is invalid.

The test demonstrates that:

```text
EA-065 original logic
+
default parameters
+
XAUUSD.PRO
+
M1
+
2026-01-02 → 2026-03-31
```

did not produce a viable result.

The baseline should therefore be preserved unchanged as the reference against which later optimized versions are compared.

---

## Current Research Status

```text
EA ID:              EA-065
Strategy:           Retest Breakout
Symbol:             XAUUSD.PRO
Timeframe:          M1
Test Period:        2026-01-02 → 2026-03-31
Initial Capital:    $100
Lot Size:           0.01
History Quality:    100% real ticks
Trades:             459
Win Rate:           51.42%
Net Profit:         -$94.61
Profit Factor:      0.84
Max Equity DD:      95.36%
Baseline Status:    FAIL
Deployment Status:  NOT APPROVED
```

---

## Evidence

The directory should retain the original MT5 Strategy Tester report and its associated graphs.

Recommended structure:

```text
Backtest/
└── EA-065_Retest_Breakout/
    ├── README.md
    ├── ReportTester-952747(20260917-062300).html
    ├── ReportTester-952747(20260917-062259).png
    ├── ReportTester-952747-hst(20260917-062300).png
    ├── ReportTester-952747-mfemae(20260917-062300).png
    └── ReportTester-952747-holding(20260917-062300).png
```

The HTML report is the primary numerical evidence.

The PNG files provide visual evidence for:

- balance development;
- trade distribution by hour, weekday, and month;
- MFE / MAE relationships;
- position holding time.

---

## Next Research Step

The baseline test is complete and should remain unchanged.

The next phase should focus on determining whether EA-065 can be improved through controlled parameter optimization and subsequent out-of-sample validation.

Any optimized configuration must be stored separately from this baseline evidence so that the original result remains reproducible.

No optimized version should replace or overwrite this baseline test.
