# EA-092_VWAP_Bands — Backtest

## 1. Baseline Test

### Tester Configuration

| Item            | Value                   |
| --------------- | ----------------------- |
| Expert          | EA-092_VWAP_Bands       |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Test Period     | 2026.01.02 – 2026.03.31 |
| History Quality | 100% real ticks         |
| Initial Deposit | USD 1,000               |
| Leverage        | 1:500                   |
| Bars            | 85,161                  |
| Ticks           | 39,639,179              |
| Symbols         | 1                       |

## These values are taken directly from the Strategy Tester report.

## 2. Input Configuration

```text
InpLotSize=0.01
InpStopLoss=300
InpTakeProfit=600
InpMagicNumber=123092
InpSlippage=10
InpMaxSpread=30
InpTimeframe=1

InpUseBreakEven=true
InpBreakEvenTrigger=150
InpBreakEvenOffset=0

InpUseTrailingStop=true
InpTrailingStart=200
InpTrailingDistance=100
InpTrailingStep=10

InpVWAPMinBars=20
InpVWAPBandMultiplier=2.0
```

The report records the same baseline configuration.

---

## 3. Performance Results

| Metric               |              Result |
| -------------------- | ------------------: |
| Net Profit           |         -172.04 USD |
| Gross Profit         |        1,012.29 USD |
| Gross Loss           |       -1,184.33 USD |
| Profit Factor        |                0.85 |
| Expected Payoff      |           -0.19 USD |
| Max Balance Drawdown | 228.67 USD / 22.61% |
| Max Equity Drawdown  | 229.46 USD / 22.67% |
| Recovery Factor      |               -0.75 |
| Sharpe Ratio         |               -5.00 |
| Z-Score              |                0.80 |
| AHPR                 |     0.9998 (-0.02%) |
| GHPR                 |     0.9998 (-0.02%) |
| LR Correlation       |               -0.96 |

The Strategy Tester report records the above performance values.

---

## 4. Trade Statistics

| Metric                     |           Result |
| -------------------------- | ---------------: |
| Total Trades               |              927 |
| Total Deals                |            1,854 |
| Profit Trades              |     474 / 51.13% |
| Loss Trades                |     453 / 48.87% |
| Short Trades               | 485 / 51.13% won |
| Long Trades                | 442 / 51.13% won |
| Largest Profit Trade       |         6.69 USD |
| Largest Loss Trade         |       -38.88 USD |
| Average Profit Trade       |         2.14 USD |
| Average Loss Trade         |        -2.61 USD |
| Max Consecutive Wins       |                8 |
| Max Consecutive Losses     |                8 |
| Average Consecutive Wins   |                2 |
| Average Consecutive Losses |                2 |

These statistics are reported by the Strategy Tester.

---

## 5. Holding Time

| Metric               |    Result |
| -------------------- | --------: |
| Minimum Holding Time | 2 seconds |
| Maximum Holding Time |   2:07:00 |
| Average Holding Time |      1:54 |

---

## 6. Baseline Interpretation

The baseline produced:

```text
Net Profit < 0
Profit Factor < 1
Expected Payoff < 0
Sharpe Ratio < 0
```

Therefore, the baseline test does not establish positive expectancy for the tested period and configuration.

The win rate alone should not be used to classify the strategy as profitable because the average loss trade was larger than the average profit trade:

```text
Average Profit = +2.14 USD
Average Loss   = -2.61 USD
```

The test also experienced a maximum equity drawdown of 22.67%.

---

## 7. Execution Observation

The report shows frequent short holding periods and many exits marked by stop-loss levels.

Example orders include:

```text
EA-092
```

for entries, followed by exits such as:

```text
sl ...
```

The order history therefore provides evidence that the EA was actively executing the configured entry/exit mechanism during the test.

---

## 8. Baseline Status

```text
Status: FAILED BASELINE / RESEARCH REQUIRED
```

This status describes the numerical backtest outcome only.

It does not imply that the strategy concept itself has been disproven. Further controlled tests are required to determine whether the negative result is caused by:

* Entry timing
* VWAP band width
* VWAP exit behavior
* Fixed SL/TP relationship
* Break-even behavior
* Trailing-stop behavior
* Market regime
* Execution frequency
* Other interaction effects

Future experiments should change one major variable or one clearly defined rule at a time.
