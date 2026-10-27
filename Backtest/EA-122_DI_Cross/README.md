# EA-122_DI_Cross — Backtest Report

## Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-122_DI_Cross |
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
| Total Net Profit | -$992.57 |
| Gross Profit | $3,802.22 |
| Gross Loss | -$4,794.79 |
| Profit Factor | 0.79 |
| Expected Payoff | -$0.27 |
| Recovery Factor | -0.94 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Relative | 99.30% |
| Balance Drawdown Maximal | $1,052.89 |
| Equity Drawdown Relative | 99.30% |
| Equity Drawdown Maximal | $1,054.97 |
| Total Trades | 3,647 |
| Total Deals | 7,294 |
| Winning Trades | 1,646 (45.13%) |
| Losing Trades | 2,001 (54.87%) |

## Trade Statistics

| Metric | Result |
|---|---:|
| Buy Trades | 1,983 |
| Buy Win Rate | 45.79% |
| Sell Trades | 1,664 |
| Sell Win Rate | 44.35% |
| Largest Winning Trade | $35.30 |
| Largest Losing Trade | -$16.61 |
| Average Winning Trade | $2.31 |
| Average Losing Trade | -$2.40 |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 13 |
| Average Holding Time | 00:03:15 |
| Minimum Holding Time | 00:00:04 |
| Maximum Holding Time | 03:41:01 |

## Performance Assessment

The backtest produced a negative net profit of $992.57 from an initial deposit of $1,000.

The Profit Factor of 0.79 indicates that gross losses exceeded gross profits.

The strategy recorded a 45.13% win rate, with an average winning trade of $2.31 and an average losing trade of $2.40.

This combination produced negative trade expectancy.

The relative equity drawdown of 99.30% indicates extreme capital risk under the tested configuration.

## Conclusion

**Backtest Result: FAILED**

The DI crossover strategy with an EMA filter did not demonstrate profitability or acceptable capital preservation during the tested period.

Further research is required before considering deployment.

## Source

Original MetaTrader 5 Strategy Tester report:

`ReportTester-952747(20261027-063541).html`

All reported performance statistics are taken from the supplied Strategy Tester report.
