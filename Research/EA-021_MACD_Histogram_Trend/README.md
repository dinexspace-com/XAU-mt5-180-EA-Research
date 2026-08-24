# EA Research

This directory documents the research process, hypotheses, experimental results, and conclusions for the Expert Advisors contained in this repository.

The objective is not to present every EA as a successful trading system.

Both successful and failed experiments are retained because failed strategies provide useful evidence about which ideas did not demonstrate an edge under the tested conditions.

---

# EA-021 — MACD Histogram Trend

## 1. Research Question

The research question behind EA-021 is:

> Can MACD histogram momentum continuation provide a standalone trading edge for XAUUSD?

The strategy tests a simple trend-continuation hypothesis:

* Positive and increasing MACD histogram → BUY
* Negative and decreasing MACD histogram → SELL

The purpose of the baseline experiment is to test this idea with minimal additional filtering before introducing further strategy complexity.

---

## 2. Hypothesis

The underlying hypothesis is that an expanding MACD histogram may indicate strengthening directional momentum.

For bullish conditions:

```text
Histogram > 0
AND
Current Histogram > Previous Histogram
```

For bearish conditions:

```text
Histogram < 0
AND
Current Histogram < Previous Histogram
```

If this momentum persists long enough after entry, the strategy may capture directional price movement.

The baseline EA was implemented to test whether this signal alone provides sufficient statistical edge.

---

## 3. Baseline Strategy

### Indicator

EA-021 uses the MACD histogram represented through MetaTrader 5's OsMA indicator.

Indicator configuration:

| Parameter     | Value |
| ------------- | ----: |
| Fast EMA      |    12 |
| Slow EMA      |    26 |
| Signal Period |     9 |
| Applied Price | Close |

Signals are evaluated using closed bars.

---

## 4. Entry Logic

### BUY

A BUY signal occurs when:

```text
Current Histogram > 0
Previous Histogram > 0
Current Histogram > Previous Histogram
```

Interpretation:

The MACD histogram is positive and expanding upward.

### SELL

A SELL signal occurs when:

```text
Current Histogram < 0
Previous Histogram < 0
Current Histogram < Previous Histogram
```

Interpretation:

The MACD histogram is negative and expanding downward.

---

## 5. Baseline Experiment

The baseline strategy was tested using MetaTrader 5 Strategy Tester.

### Environment

| Setting         | Value                   |
| --------------- | ----------------------- |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Period          | 2026.01.02 – 2026.08.01 |
| Initial Deposit | $1,000                  |
| Leverage        | 1:500                   |
| Data Quality    | 100% real ticks         |

### Parameters

| Parameter      |      Value |
| -------------- | ---------: |
| Lot Size       |       0.01 |
| Stop Loss      | 300 points |
| Take Profit    | 600 points |
| Break Even     |   Disabled |
| Trailing Stop  |   Disabled |
| Maximum Spread |  30 points |

Break Even and Trailing Stop were disabled so the test could evaluate the baseline entry logic with fixed SL/TP exits.

---

## 6. Baseline Results

| Metric                   |       Result |
| ------------------------ | -----------: |
| Total Trades             |        8,367 |
| Net Profit               | **-$994.28** |
| Profit Factor            |     **0.94** |
| Expected Payoff          |   **-$0.12** |
| Sharpe Ratio             |    **-5.00** |
| Winning Trades           |       32.62% |
| Losing Trades            |       67.38% |
| Maximum Balance Drawdown |   **99.45%** |
| Maximum Equity Drawdown  |   **99.45%** |

Direction breakdown:

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| BUY       |  4,089 |   32.11% |
| SELL      |  4,278 |   33.10% |

---

## 7. Finding

### Baseline Result: ❌ FAIL

The tested baseline does not demonstrate a profitable trading edge.

Important observations:

* Profit Factor is below 1.0.
* Expected Payoff is negative.
* Approximately two-thirds of all trades are losing trades.
* Both BUY and SELL directions show similarly low win rates.
* Maximum drawdown approaches the entire initial account balance.
* The balance curve deteriorates substantially over the test period.

The failure therefore cannot be attributed simply to one trade direction.

---

## 8. What the Experiment Demonstrates

The experiment provides evidence that:

> The tested MACD histogram continuation rule, when used as a standalone entry signal on XAUUSD.PRO M1 with SL 300 and TP 600, does not produce a profitable strategy over the tested period.

This conclusion applies only to the tested configuration.

The experiment does **not** establish that:

* MACD histogram strategies can never work.
* The strategy behaves the same on other timeframes.
* The strategy behaves the same under different market regimes.
* Different entry filters would produce the same result.
* Different exit logic would produce the same result.

Those questions require separate experiments.

---

## 9. Research Value of the Failed Baseline

The failed baseline is intentionally retained.

A negative result provides a reference point for future experiments.

The baseline contains:

```text
8,367 trades
```

using:

```text
100% real tick history
```

This creates a measurable benchmark.

Any future modification to EA-021 should be compared against this baseline rather than judged only by whether the modified version becomes profitable.

---

## 10. Research Discipline

Future experiments should change a clearly defined component and preserve the result as a separate research record.

The purpose is to distinguish genuine improvements from parameter fitting or accidental backtest performance.

A future experiment should document at minimum:

```text
Hypothesis
↓
Change
↓
Backtest
↓
Metrics
↓
Comparison with baseline
↓
PASS / FAIL
↓
Conclusion
```

Failed experiments should not be deleted.

They remain part of the research history.

---

## 11. Current Research Status

```text
EA-021_MACD_Histogram_Trend
│
├── Hypothesis
│   └── MACD histogram expansion may identify momentum continuation
│
├── Baseline Implementation
│   └── COMPLETE
│
├── Baseline Backtest
│   └── COMPLETE
│
├── Dataset
│   └── XAUUSD.PRO / M1 / 100% real ticks
│
├── Sample
│   └── 8,367 trades
│
├── Result
│   └── FAIL
│
└── Research Decision
    └── Baseline retained as experimental evidence
```

---

## 12. Evidence

Source implementation:

```text
EAs/
└── EA-021_MACD_Histogram_Trend/
    ├── EA-021_MACD_Histogram_Trend.mq5
    └── README.md
```

Backtest evidence:

```text
Backtest/
└── EA-021_MACD_Histogram_Trend/
    ├── README.md
    ├── ReportTester-953688.html
    ├── ReportTester-953688.png
    ├── ReportTester-953688-hst.png
    ├── ReportTester-953688-mfemae.png
    └── ReportTester-953688-holding.png
```

The source code defines the experiment.

The Strategy Tester report provides the experimental evidence.

The research documentation records the conclusion.

---

## 13. Conclusion

**EA-021 baseline research status: FAIL.**

The simple MACD histogram continuation hypothesis did not demonstrate a positive standalone trading edge under the tested XAUUSD.PRO M1 configuration.

The baseline implementation and backtest are retained as research evidence and as a benchmark for any future EA-021 experiments.
