# EA-063 — Close Location Break

## Baseline Backtest

This directory contains the MetaTrader 5 baseline backtest for **EA-063_Close_Location_Break**.

The purpose of this test is to establish the unoptimized baseline performance of the strategy before parameter optimization or structural modification.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-063_Close_Location_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 — 2026.03.31 |
| Initial Deposit | $100.00 |
| Leverage | 1:500 |
| Tick Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols | 1 |

---

## Baseline Parameters

| Parameter | Value |
|---|---:|
| InpLotSize | 0.01 |
| InpStopLoss | 300 |
| InpTakeProfit | 600 |
| InpMagicNumber | 123063 |
| InpSlippage | 10 |
| InpMaxSpread | 30 |
| InpTimeframe | M1 |
| InpBreakoutLookback | 20 |
| InpBreakoutBuffer | 0 |
| InpUseBreakEven | true |
| InpBreakEvenTrigger | 150 |
| InpBreakEvenOffset | 0 |
| InpUseTrailingStop | true |
| InpTrailingStart | 200 |
| InpTrailingDistance | 100 |
| InpTrailingStep | 10 |
| InpCloseEdgeFraction | 0.20 |

No optimization result is represented by this README.

This is the baseline configuration.

---

## Baseline Results

| Metric | Result |
|---|---:|
| Initial Deposit | $100.00 |
| Total Net Profit | **-$92.09** |
| Gross Profit | $262.21 |
| Gross Loss | -$354.30 |
| Profit Factor | **0.74** |
| Expected Payoff | **-$0.34** |
| Recovery Factor | **-0.88** |
| Sharpe Ratio | **-5.00** |
| Balance Drawdown Maximal | **$104.60 (92.97%)** |
| Equity Drawdown Maximal | **$104.60 (92.97%)** |
| Total Trades | 269 |
| Total Deals | 538 |
| Winning Trades | 123 (45.72%) |
| Losing Trades | 146 (54.28%) |

---

## BUY / SELL Distribution

The EA generated trades in both directions.

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY / Long | 144 | 48.61% |
| SELL / Short | 125 | 42.40% |
| Total | 269 | 45.72% overall |

Both BUY and SELL sides participated materially in the test.

The baseline weakness is therefore not caused by one trading direction being absent.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $6.09 |
| Largest Loss Trade | -$3.26 |
| Average Profit Trade | $2.13 |
| Average Loss Trade | -$2.43 |
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Losses | 8 |
| Maximal Consecutive Profit | $11.33 / 5 trades |
| Maximal Consecutive Loss | -$15.17 / 5 trades |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The baseline has two simultaneous disadvantages:

1. Winning trades occur less frequently than losing trades.
2. The average losing trade is larger than the average winning trade.

This combination produces negative expectancy.

---

## Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:04 |
| Maximum Holding Time | 02:03:19 |
| Average Holding Time | 00:04:10 |

The strategy behaves as a short-duration M1 breakout system under this configuration.

---

## MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profit, MFE) | 0.96 |
| Correlation (Profit, MAE) | 0.77 |
| Correlation (MFE, MAE) | 0.6807 |

These values are retained as diagnostic information from the MT5 Strategy Tester.

They should not by themselves be interpreted as evidence of strategy profitability.

---

## Equity Curve

The balance curve is structurally negative over the baseline test.

Although temporary recovery phases occur, the account fails to establish sustained positive growth and ultimately declines from the $100 initial deposit to approximately $7.91.

This is consistent with:

- Total Net Profit: -$92.09
- Profit Factor: 0.74
- Expected Payoff: -$0.34
- Maximum Drawdown: 92.97%
- Sharpe Ratio: -5.00

The baseline configuration is therefore not suitable for deployment.

---

## Baseline Assessment

### Result: FAIL

The baseline configuration fails the research acceptance test.

Primary reasons:

- Profit Factor is below 1.00.
- Expected Payoff is negative.
- Total Net Profit is strongly negative.
- Maximum Drawdown reaches 92.97%.
- Winning trades represent only 45.72% of total trades.
- Average loss exceeds average profit.
- Balance curve shows persistent deterioration.
- Recovery Factor and Sharpe Ratio are negative.

The test nevertheless produced 269 trades using 100% real tick history, providing a usable baseline sample for further parameter research.

---

## Research Interpretation

This result does **not** establish that the Close Location Break hypothesis itself is invalid.

It establishes that:

> EA-063 with the current baseline parameter set does not produce an acceptable result on XAUUSD.PRO M1 over the tested 2026.01.02–2026.03.31 period.

The baseline should therefore be treated as a reference point for subsequent optimization.

Optimization results must be stored and evaluated separately from this baseline test.

---

## Files

```text
Backtest/
└── EA-063_Close_Location_Break/
    ├── README.md
    ├── ReportTester-952747(20260916-060943).html
    ├── ReportTester-952747(20260916-060942).png
    ├── ReportTester-952747-hst(20260916-060942).png
    ├── ReportTester-952747-mfemae(20260916-060941).png
    └── ReportTester-952747-holding(20260916-060942).png
```

The HTML file is the primary raw evidence.

The PNG files are supporting visual evidence generated by MetaTrader 5.

---

## Status

```text
EA:                 EA-063_Close_Location_Break
Baseline:           COMPLETED
Data Quality:       100% real ticks
Trades:             269
Baseline Result:    FAIL
Optimization:       NOT DOCUMENTED HERE
Deployment Ready:   NO
```

The baseline result must not be replaced or removed if later optimization produces a profitable parameter set. It remains the reference result for the original EA configuration.
