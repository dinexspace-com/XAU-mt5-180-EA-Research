# EA-114 — ROC 5 Backtest

## Baseline Information

| Item | Value |
|---|---|
| Baseline ID | `EA114-M1-BASELINE-001` |
| Expert Advisor | `EA-114_ROC_5` |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## Performance Summary

| Metric | Result |
|---|---:|
| Total Net Profit | -$994.73 |
| Gross Profit | $10,640.09 |
| Gross Loss | -$11,634.82 |
| Profit Factor | 0.91 |
| Expected Payoff | -$0.11 |
| Recovery Factor | -1.00 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | $994.73 (99.47%) |
| Maximum Equity Drawdown | $994.73 (99.47%) |
| Total Trades | 8,823 |
| Total Deals | 17,646 |
| Winning Trades | 3,998 (45.31%) |
| Losing Trades | 4,825 (54.69%) |
| Average Winning Trade | $2.66 |
| Average Losing Trade | -$2.41 |
| Largest Winning Trade | $10.43 |
| Largest Losing Trade | -$11.90 |
| Average Holding Time | 00:00:57 |

## Directional Breakdown

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 4,451 | 45.27% |
| SELL | 4,372 | 45.36% |

Both directions have similar win rates. The report does not establish a meaningful directional advantage.

## Assessment

**Result: FAIL**

The strategy lost nearly the entire initial deposit during the test period. Profit Factor below 1.00 and negative Expected Payoff indicate that the baseline has a negative trading expectancy under the tested configuration.

The large drawdown is a critical risk warning. The result does not support live deployment or broad parameter optimization.

## Next Actions

1. Verify the ROC calculation and entry timing.
2. Examine trade-level outcomes and the contribution of spread and execution costs.
3. Test the entry signal independently before changing exit parameters.
4. Record each controlled experiment separately.
5. Require out-of-sample and robustness testing before reconsidering the strategy.

## Reproducibility

Retain the EA source, original Strategy Tester report, parameter settings, and experiment notes together.

**Baseline ID:** `EA114-M1-BASELINE-001`

**Final Classification:** `FAIL`

**Live Trading Status:** `NOT APPROVED`
