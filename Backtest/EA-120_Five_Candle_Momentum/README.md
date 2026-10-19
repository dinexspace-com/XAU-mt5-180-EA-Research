# Backtest Records — EA-120_Five_Candle_Momentum

## 1. Purpose

This directory stores Strategy Tester reports and experiment records for `EA-120_Five_Candle_Momentum`.

The objective is to evaluate the EA's historical trading performance, document its behavior, and maintain reproducible records of each test.

## 2. Test Register

### Run-001 — Baseline Test

| Field | Value |
|---|---|
| EA | EA-120_Five_Candle_Momentum |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test start | 2026-01-02 |
| Test end | 2026-04-01 |
| Initial deposit | USD 1,000 |
| Account currency | USD |
| Leverage | 1:500 |
| Tick model | 100% real ticks |
| Lot size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 120001 |
| Break-even | Enabled |
| Trailing stop | Enabled |
| Slope period | 5 |
| Source report | `Run-001/ReportTester-952747(1).html` |

## 3. Results Summary

| Metric | Recorded result |
|---|---:|
| Total net profit | -992.60 USD |
| Gross profit | 5,037.41 USD |
| Gross loss | -6,030.01 USD |
| Profit factor | 0.84 |
| Expected payoff | -0.20 USD |
| Maximum balance drawdown | 1,015.21 USD (99.28%) |
| Maximum equity drawdown | 1,015.45 USD (99.28%) |
| Total trades | 5,012 |
| Winning trades | 2,414 (48.16%) |
| Losing trades | 2,598 (51.84%) |
| Long trades | 2,456 |
| Short trades | 2,556 |
| Average winning trade | 2.09 USD |
| Average losing trade | -2.32 USD |
| Recovery factor | -0.98 |
| Sharpe ratio | -5.00 |

Values are transcribed from the supplied Strategy Tester report. The report's maximum drawdown exceeds the initial deposit in monetary terms, while the reported relative drawdown is 99.28%. These are the tester's reported figures and should be preserved as recorded.

## 4. Initial Assessment

The baseline test shows that the tested configuration was unprofitable over the recorded period.

Key observations:

- Net profit was negative.
- Profit factor was below 1.0.
- The percentage of losing trades exceeded the percentage of winning trades.
- The average losing trade was larger than the average winning trade.
- Maximum reported drawdown was approximately 99% of the initial deposit.

These results indicate that the tested configuration did not meet a reasonable initial profitability and drawdown objective.

The results alone do not identify the precise cause of the losses. The entry logic, order direction, execution costs, stop management, and behavior under different market conditions require separate investigation.

## 5. Experiment Policy

For every new test, record:

1. Experiment ID.
2. EA source version.
3. Symbol and timeframe.
4. Start and end dates.
5. Initial deposit, leverage, and account currency.
6. Tick model and relevant tester settings.
7. All EA input parameters.
8. Net profit, profit factor, drawdown, trade count, and win rate.
9. Any code changes since the previous experiment.
10. A brief conclusion based on the observed results.

Do not overwrite previous experiment reports. Each run should remain available for comparison.

## 6. Suggested Directory Layout

```text
Backtest/
└── EA-120_Five_Candle_Momentum/
    ├── README.md
    ├── Run-001/
    │   └── ReportTester-952747(1).html
    ├── Run-002/
    │   └── Report.html
    └── Run-003/
        └── Report.html
```

Create `Run-002` and later directories only when those experiments have actually been performed.

## 7. Current Status

**Baseline status: Unsuccessful.**

The supplied results do not support a claim of profitability or readiness for live trading. Further testing should be documented as new experiments rather than presented as a successful outcome in advance.
