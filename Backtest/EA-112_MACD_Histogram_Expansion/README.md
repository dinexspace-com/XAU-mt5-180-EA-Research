# EA-112 — MACD Histogram Expansion Backtest

## Experiment Information

| Item | Value |
|---|---|
| Experiment ID | `EA112-M1-BASELINE-001` |
| EA | EA-112 MACD Histogram Expansion |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Total Trades | 3,918 |
| Total Deals | 7,836 |
| Result | **FAIL** |

## Performance Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Net Profit | -$993.33 |
| Gross Profit | $3,922.61 |
| Gross Loss | -$4,915.94 |
| Profit Factor | 0.80 |
| Expected Payoff | -$0.25 |
| Recovery Factor | -1.00 |
| Sharpe Ratio | -5.00 |
| Max Balance Drawdown | $993.60 (99.33%) |
| Max Equity Drawdown | $995.59 (99.33%) |
| Winning Trades | 1,879 (47.96%) |
| Losing Trades | 2,039 (52.04%) |
| Long Trades | 1,848 |
| Long Win Rate | 49.03% |
| Short Trades | 2,070 |
| Short Win Rate | 47.00% |
| Average Profit Trade | $2.09 |
| Average Loss Trade | -$2.41 |
| Largest Profit Trade | $35.34 |
| Largest Loss Trade | -$33.74 |
| Average Holding Time | 00:03:54 |

## Initial Assessment

The baseline is unsuccessful:

1. Net profit is negative by $993.33.
2. Profit Factor is below 1.00, indicating that gross losses exceed gross profits.
3. Maximum equity drawdown reaches 99.33%, leaving almost no initial equity.
4. Average losing trade (-$2.41) is larger than average winning trade ($2.09).
5. The EA executed 3,918 trades during the test period, so transaction costs and repeated entries should be considered in further investigation.

The winning-trade percentage alone does not indicate profitability. The relationship between average win, average loss, trade frequency, and costs must also be evaluated.

## Baseline Parameters

- Lot Size: 0.01
- Stop Loss: 300 points
- Take Profit: 600 points
- Fast EMA: 12
- Slow EMA: 26
- Signal Period: 9
- Maximum Spread: 30 points
- Break-even: Enabled at 150 points
- Trailing Stop: Enabled from 200 points, distance 200 points

## Decision

**FAIL — Do not proceed to live trading.**

Keep this report as the original baseline. Do not overwrite it with results from later experiments.

## Next Experiment

Investigate whether the entry signal, histogram indexing, repeated signal behavior, and exit management contribute to the losses. Change one factor at a time and compare each experiment against this baseline.

## Source Report

`ReportTester-952747(20261012-081758).html`

This report records the baseline results for the period and settings listed above.
