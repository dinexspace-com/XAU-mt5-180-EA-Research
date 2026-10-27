# EA-121_ADX_Rising — Backtest Report

## Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-121_ADX_Rising |
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Start | 2026-01-02 |
| Test End | 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Currency | USD |
| History Quality | 100% real ticks |
| Total Bars | 86,539 |
| Total Ticks | 40,346,891 |

## Performance Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$993.01 |
| Gross Profit | $3,895.79 |
| Gross Loss | -$4,888.80 |
| Profit Factor | 0.80 |
| Expected Payoff | -$0.26 |
| Recovery Factor | -1.00 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Relative | 99.30% |
| Equity Drawdown Relative | 99.30% |
| Equity Drawdown Maximal | $994.04 |
| Total Trades | 3,840 |
| Total Deals | 7,680 |
| Winning Trades | 1,807 (47.06%) |
| Losing Trades | 2,033 (52.94%) |

## Trade Statistics

| Metric | Result |
|---|---:|
| Buy Trades | 1,853 |
| Buy Win Rate | 47.60% |
| Sell Trades | 1,987 |
| Sell Win Rate | 46.55% |
| Largest Winning Trade | $33.74 |
| Largest Losing Trade | -$43.08 |
| Average Winning Trade | $2.16 |
| Average Losing Trade | -$2.40 |
| Maximum Consecutive Wins | 11 |
| Maximum Consecutive Losses | 12 |
| Average Holding Time | 00:03:51 |

## Performance Assessment

The backtest produced a negative net profit of $993.01 from an initial deposit of $1,000.

The Profit Factor of 0.80 indicates that gross losses exceeded gross profits.

The 47.06% win rate, combined with average winning and losing trade values, was insufficient to produce positive expectancy.

The relative equity drawdown of 99.30% indicates extreme capital risk under the tested configuration.

## Conclusion

**Backtest Result: FAILED**

The current configuration does not demonstrate a profitable or capital-preserving trading strategy over the tested period.

Further research is required before considering deployment.

## Source

Original MetaTrader 5 Strategy Tester report:

`ReportTester-952747(20261027-063039).html`

All reported performance statistics are taken from the supplied Strategy Tester report.
