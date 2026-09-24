# EA-077 — Previous Day High/Low | Backtest

## 1. Test Configuration

| Parameter | Value |
|---|---|
| Expert Advisor | EA-077_Previous_Day_High_Low |
| Symbol | XAUUSD.PRO |
| Test period | 2026-01-02 to 2026-03-31 |
| Tester timeframe | M15 |
| EA signal timeframe | M1 |
| Initial deposit | $1,000 |
| Leverage | 1:500 |
| Lot size | 0.01 |
| History quality | 100% real ticks |
| Total ticks | 39,639,179 |
| Total bars | 5,688 |

## 2. Performance Results

| Metric | Result |
|---|---:|
| Total trades | 455 |
| Net profit | -$98.75 |
| Gross profit | $501.52 |
| Gross loss | -$600.27 |
| Profit factor | 0.84 |
| Expected payoff | -$0.22 |
| Maximum balance drawdown | 10.85% |
| Maximum equity drawdown | 11.18% |
| Winning trades | 205 (45.05%) |
| Losing trades | 250 (54.95%) |
| Average winning trade | $2.45 |
| Average losing trade | -$2.40 |
| Largest winning trade | $9.32 |
| Largest losing trade | -$5.12 |
| Maximum consecutive losses | 13 |

## 3. Trading Parameters

| Parameter | Value |
|---|---:|
| Stop loss | 300 points |
| Take profit | 600 points |
| Break-even | Enabled |
| Break-even trigger | 150 points |
| Trailing stop | Enabled |
| Trailing start | 200 points |
| Trailing distance | 100 points |
| Maximum spread | 30 points |

## 4. Balance Curve

![Balance Curve](ReportTester-952747(20260924-061946).png)

The strategy generated an overall declining balance curve.

Starting balance: $1,000.

Final balance: $901.25.

## 5. Entry Distribution

![Entry Distribution](ReportTester-952747-hst(20260924-061946).png)

The chart displays trade entries and profit/loss distributions by hour, weekday and month.

## 6. MFE and MAE

![MFE and MAE](ReportTester-952747-mfemae(20260924-061946).png)

| Correlation | Value |
|---|---:|
| Profit / MFE | 0.96 |
| Profit / MAE | 0.72 |
| MFE / MAE | 0.6285 |

## 7. Holding Time

![Holding Time](ReportTester-952747-holding(20260924-061945).png)

| Metric | Value |
|---|---|
| Minimum | 1 second |
| Average | 1 minute 25 seconds |
| Maximum | 13 minutes 19 seconds |

## 8. Conclusion

The baseline produced 455 trades with a maximum equity drawdown of 11.18%.

However, net profit was negative and profit factor was below 1.

**Status: FAIL — Profitability criterion.**

This is a historical backtest, not evidence of live profitability.

## 9. Original MT5 Report

[Strategy Tester HTML](ReportTester-952747(20260924-061947).html)
