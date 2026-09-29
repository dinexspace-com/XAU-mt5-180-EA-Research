# EA-087_Z-Score_2 — Backtest

## Test Identification

| Item            | Value                    |
| --------------- | ------------------------ |
| Expert Advisor  | EA-087_Z-Score_2         |
| Symbol          | XAUUSD.PRO               |
| Timeframe       | M1                       |
| Test period     | 2026-01-02 to 2026-03-31 |
| Initial Deposit | 1,000 USD                |
| Currency        | USD                      |
| Leverage        | 1:500                    |
| History Quality | 100% real ticks          |
| Bars            | 85,161                   |
| Ticks           | 39,639,179               |
| Symbols         | 1                        |

---

## Test Parameters

### Execution

| Parameter       |  Value |
| --------------- | -----: |
| Lot Size        |   0.01 |
| Stop Loss       |    300 |
| Take Profit     |    600 |
| Magic Number    | 123087 |
| Slippage        |     10 |
| Maximum Spread  |     30 |
| Timeframe       |     M1 |
| Breakout Buffer |      0 |

### Break Even

| Parameter | Value |
| --------- | ----: |
| Enabled   |  true |
| Trigger   |   150 |
| Offset    |     0 |

### Trailing Stop

| Parameter | Value |
| --------- | ----: |
| Enabled   |  true |
| Start     |   200 |
| Distance  |   100 |
| Step      |    10 |

### Z-Score

| Parameter | Value |
| --------- | ----: |
| Period    |    20 |
| Threshold |   2.0 |

---

## Performance Results

| Metric                   |              Result |
| ------------------------ | ------------------: |
| Total Net Profit         |         -634.42 USD |
| Gross Profit             |        5,806.97 USD |
| Gross Loss               |       -6,441.39 USD |
| Profit Factor            |                0.90 |
| Expected Payoff          |           -0.12 USD |
| Recovery Factor          |               -0.84 |
| Sharpe Ratio             |               -5.00 |
| Total Trades             |               5,136 |
| Profit Trades            |      2,592 (50.47%) |
| Loss Trades              |      2,544 (49.53%) |
| Equity Drawdown Maximal  | 759.69 USD (75.22%) |
| Balance Drawdown Maximal | 758.77 USD (75.18%) |

---

## Directional Results

### Short Trades

```text
Trades: 2,398
Winning percentage: 50.67%
```

### Long Trades

```text
Trades: 2,738
Winning percentage: 50.29%
```

---

## Trade Distribution

```text
Total Trades: 5,136

Profit Trades: 2,592
Loss Trades:   2,544
```

Largest profit trade:

```text
7.95 USD
```

Largest loss trade:

```text
-35.62 USD
```

Average profit trade:

```text
2.24 USD
```

Average loss trade:

```text
-2.53 USD
```

Maximum consecutive wins:

```text
10 trades
30.21 USD
```

Maximum consecutive losses:

```text
11 trades
-25.86 USD
```

---

## Holding Time

```text
Minimum holding time: 00:00:01
Average holding time: 00:02:20
Maximum holding time: 02:08:03
```

---

## Tester Statistics

```text
Z-Score: 1.89 (94.12%)
LR Correlation: -0.86
LR Standard Error: 99.25
AHPR: 0.9998 (-0.02%)
GHPR: 0.9998 (-0.02%)
OnTester result: 0
```

---

## Interpretation

This backtest is recorded as the current baseline result for EA-087_Z-Score_2.

The test produced a negative net profit and a Profit Factor below 1. The reported maximal equity drawdown was 75.22%.

The purpose of storing this report is to preserve the exact baseline before subsequent research or parameter changes.

No optimization conclusion is recorded in this file.

Any later optimization result should be stored as a separate test rather than replacing this baseline report.

---

## Source Report

Original MetaTrader 5 Strategy Tester report:

```text
ReportTester-952747(4).html
```

The original report should remain unchanged so that later research results can be compared against the same baseline.
