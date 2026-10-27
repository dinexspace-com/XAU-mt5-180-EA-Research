# EA-124_MACD_Acceleration — Backtest Report

## Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-124_MACD_Acceleration |
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
| Symbols Tested | 1 |

## Performance Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$992.01 |
| Gross Profit | $3,859.82 |
| Gross Loss | -$4,851.83 |
| Profit Factor | 0.80 |
| Expected Payoff | -$0.26 |
| Recovery Factor | -1.00 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Absolute | $992.01 |
| Balance Drawdown Maximal | $992.25 (99.20%) |
| Balance Drawdown Relative | 99.20% |
| Equity Drawdown Absolute | $992.01 |
| Equity Drawdown Maximal | $994.24 (99.20%) |
| Equity Drawdown Relative | 99.20% |
| Margin Level | 97.78% |
| Total Trades | 3,860 |
| Total Deals | 7,720 |

## Trade Statistics

| Metric | Result |
|---|---:|
| Long Trades | 1,815 |
| Long Win Rate | 49.20% |
| Short Trades | 2,045 |
| Short Win Rate | 47.04% |
| Winning Trades | 1,855 (48.06%) |
| Losing Trades | 2,005 (51.94%) |
| Largest Winning Trade | $35.30 |
| Largest Losing Trade | -$33.73 |
| Average Winning Trade | $2.08 |
| Average Losing Trade | -$2.42 |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 14 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |
| Minimum Holding Time | 00:00:00 |
| Maximum Holding Time | 03:32:14 |
| Average Holding Time | 00:03:57 |

## Performance Assessment

The strategy generated 3,860 trades during the test period.

Gross losses exceeded gross profits, resulting in a Profit Factor of 0.80.

The overall win rate was 48.06%, while the average winning trade was $2.08 and the average losing trade was $2.42.

The combination of a lower win rate and larger average losses produced negative expectancy.

The reported Expected Payoff was -$0.26 per trade.

Equity Drawdown Relative reached 99.20%, indicating near-total capital depletion during the test.

The average holding time of 3 minutes and 57 seconds indicates short-duration trading behavior.

## Conclusion

**Backtest Result: FAILED**

The tested MACD acceleration configuration did not demonstrate profitability or acceptable capital preservation.

The results do not support live deployment under the tested configuration.

## Source Report

`ReportTester-952747(20261027-064625).html`

The original Strategy Tester report should be preserved alongside this README.

The HTML report references additional PNG chart files. Those image files should also be included if complete chart rendering is required.

All performance figures above are taken from the supplied MetaTrader 5 Strategy Tester report.
