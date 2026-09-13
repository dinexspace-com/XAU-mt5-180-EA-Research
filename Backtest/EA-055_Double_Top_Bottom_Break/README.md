# EA-055 — Double Top / Bottom Break
## Backtest Report

Baseline backtest for **EA-055_Double_Top_Bottom_Break**.

Strategy: **Double Top / Double Bottom Neckline Breakout**

---

## Test Status

**Result: FAIL**

This baseline configuration produced a negative net profit, Profit Factor below 1.00, negative Expected Payoff and drawdown above 50%.

This result applies specifically to the tested configuration and test period below.

It does not by itself prove that the underlying Double Top / Double Bottom strategy is invalid.

---

## Test Environment

| Parameter | Value |
|---|---|
| Expert Advisor | `EA-055_Double_Top_Bottom_Break` |
| Symbol | `XAUUSD.PRO` |
| Timeframe | `M1` |
| Test Start | `2026-01-02` |
| Test End | `2026-04-01` |
| Currency | `USD` |
| Initial Deposit | `$1,000.00` |
| Leverage | `1:500` |
| History Quality | `100% real ticks` |
| Bars | `86,539` |
| Ticks | `40,346,891` |
| Symbols | `1` |

---

## EA Parameters

### General

| Parameter | Value |
|---|---:|
| `InpLotSize` | `0.01` |
| `InpStopLoss` | `300` |
| `InpTakeProfit` | `600` |
| `InpMagicNumber` | `123456` |
| `InpSlippage` | `10` |

### Break Even

| Parameter | Value |
|---|---:|
| `InpUseBreakEven` | `true` |
| `InpBreakEvenTrigger` | `150` |
| `InpBreakEvenOffset` | `0` |

### Trailing Stop

| Parameter | Value |
|---|---:|
| `InpUseTrailingStop` | `true` |
| `InpTrailingStart` | `200` |
| `InpTrailingDistance` | `150` |

### Strategy

| Parameter | Value |
|---|---:|
| `InpMaxSpread` | `30` |
| `InpLookbackBars` | `100` |
| `InpSwingStrength` | `2` |
| `InpMinPatternBars` | `5` |
| `InpMaxPatternBars` | `60` |
| `InpPatternTolerance` | `100` |
| `InpBreakoutBuffer` | `0` |

---

## Performance Summary

| Metric | Result |
|---|---:|
| Total Net Profit | **-$489.98** |
| Gross Profit | `$2,937.39` |
| Gross Loss | `-$3,427.37` |
| Profit Factor | **0.86** |
| Expected Payoff | **-$0.18** |
| Recovery Factor | **-0.89** |
| Sharpe Ratio | **-5.00** |
| AHPR | `0.9998 (-0.02%)` |
| GHPR | `0.9998 (-0.02%)` |
| LR Correlation | `-0.98` |
| LR Standard Error | `24.66` |

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | `$497.12` |
| Balance Drawdown Maximal | `$546.26 (52.07%)` |
| Balance Drawdown Relative | `52.07% ($546.26)` |
| Equity Drawdown Absolute | `$497.35` |
| Equity Drawdown Maximal | **$548.00 (52.16%)** |
| Equity Drawdown Relative | **52.16% ($548.00)** |

The balance curve shows a persistent downward trend over the test period.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | `2,719` |
| Total Deals | `5,438` |
| Winning Trades | `1,298 (47.74%)` |
| Losing Trades | `1,421 (52.26%)` |

### BUY / SELL

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | `1,445` | `48.03%` |
| Long | `1,274` | `47.41%` |

The strategy generated a substantial number of trades in both directions, with neither side reaching a 50% win rate in this test.

---

## Win / Loss Characteristics

| Metric | Result |
|---|---:|
| Largest Profit Trade | `$34.29` |
| Largest Loss Trade | `-$27.58` |
| Average Profit Trade | `$2.26` |
| Average Loss Trade | `-$2.41` |
| Maximum Consecutive Wins | `9 ($18.73)` |
| Maximum Consecutive Losses | `13 (-$27.66)` |
| Maximal Consecutive Profit | `$43.55 (5 trades)` |
| Maximal Consecutive Loss | `-$30.70 (2 trades)` |
| Average Consecutive Wins | `2` |
| Average Consecutive Losses | `2` |

Average Win = `$2.26`

Average Loss = `$2.41`

Combined with a win rate below 50%, this produced a negative overall expectancy.

---

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | `00:00:01` |
| Maximum Holding Time | `03:41:01` |
| Average Holding Time | `00:03:42` |

The average holding period of approximately 3 minutes 42 seconds confirms that this configuration operates as a short-duration M1 trading strategy.

---

## MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profit, MFE) | `0.95` |
| Correlation (Profit, MAE) | `0.64` |
| Correlation (MFE, MAE) | `0.4699` |

---

## Baseline Assessment

This baseline test does **not** satisfy the minimum conditions for a profitable EA configuration.

Main reasons:

- Total Net Profit is negative.
- Profit Factor is below `1.00`.
- Expected Payoff is negative.
- Sharpe Ratio is negative.
- Recovery Factor is negative.
- Maximum Equity Drawdown exceeds `52%`.
- Losing trades exceed winning trades.
- Average loss is larger than average profit.
- Balance curve trends downward through the test period.

---

## Baseline Verdict

| Item | Result |
|---|---|
| EA | `EA-055_Double_Top_Bottom_Break` |
| Symbol | `XAUUSD.PRO` |
| Timeframe | `M1` |
| Period | `2026-01-02 → 2026-04-01` |
| Deposit | `$1,000` |
| Lot | `0.01` |
| Net Profit | `-$489.98` |
| Profit Factor | `0.86` |
| Win Rate | `47.74%` |
| Max Equity DD | `52.16%` |
| Total Trades | `2,719` |
| Status | **FAIL** |

This test should therefore be treated as the **baseline/reference backtest**, not as a production-ready configuration.

---

## Backtest Artifacts

    Backtest/
    └── EA-055_Double_Top_Bottom_Break/
        ├── README.md
        ├── ReportTester-952747(20260913-043715).html
        ├── ReportTester-952747(20260913-043712).png
        ├── ReportTester-952747-hst(20260913-043712).png
        ├── ReportTester-952747-mfemae(20260913-043711).png
        └── ReportTester-952747-holding(20260913-043711).png

### Artifact Description

- `ReportTester-952747(20260913-043715).html` — Full MetaTrader 5 Strategy Tester report including settings, statistics, orders and deals.
- `ReportTester-952747(20260913-043712).png` — Balance curve.
- `ReportTester-952747-hst(20260913-043712).png` — Entry and profit/loss distribution by hour, weekday and month.
- `ReportTester-952747-mfemae(20260913-043711).png` — MFE / MAE analysis.
- `ReportTester-952747-holding(20260913-043711).png` — Position holding-time distribution.

---

## Notes

This repository preserves failed backtests as part of the research process.

A failed baseline is retained so that future modifications can be compared against the same reference configuration instead of selectively keeping only profitable results.

The result of this backtest applies only to:

- `XAUUSD.PRO`
- `M1`
- Test period `2026-01-02` to `2026-04-01`
- Initial deposit `$1,000`
- Fixed lot `0.01`
- The exact EA parameters documented above

Changing the symbol, timeframe, broker, spread conditions, market period or EA parameters may produce materially different results.
