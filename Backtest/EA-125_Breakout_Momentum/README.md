# EA-125_Breakout_Momentum — Backtest Report

## Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-125_Breakout_Momentum |
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Broker Company | ACCM Intl Limited |
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
| Total Net Profit | -$992.17 |
| Gross Profit | $4,098.07 |
| Gross Loss | -$5,090.24 |
| Profit Factor | 0.81 |
| Expected Payoff | -$0.27 |
| Recovery Factor | -1.00 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Absolute | $992.17 |
| Balance Drawdown Maximal | $992.17 (99.22%) |
| Balance Drawdown Relative | 99.22% |
| Equity Drawdown Absolute | $992.17 |
| Equity Drawdown Maximal | $992.17 (99.22%) |
| Equity Drawdown Relative | 99.22% |
| Margin Level | 107.85% |
| Total Trades | 3,707 |
| Total Deals | 7,414 |

## Trade Statistics

| Metric | Result |
|---|---:|
| Long Trades | 1,930 |
| Long Win Rate | 45.60% |
| Short Trades | 1,777 |
| Short Win Rate | 43.78% |
| Winning Trades | 1,658 (44.73%) |
| Losing Trades | 2,049 (55.27%) |
| Largest Winning Trade | $33.74 |
| Largest Losing Trade | -$27.55 |
| Average Winning Trade | $2.47 |
| Average Losing Trade | -$2.48 |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 13 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:12:00 |
| Average Holding Time | 00:02:34 |

## Performance Assessment

The strategy generated 3,707 trades over the test period.

Gross losses of $5,090.24 exceeded gross profits of $4,098.07, resulting in a Profit Factor of 0.81.

The overall win rate was 44.73%, with an average winning trade of $2.47 and an average losing trade of $2.48.

The average winning and losing amounts were nearly equal, but losing trades occurred more frequently.

This combination produced negative expectancy, reflected in the Expected Payoff of -$0.27 per trade.

Equity Drawdown Relative reached 99.22%, indicating near-total capital depletion under the tested configuration.

The average position holding time of 2 minutes and 34 seconds indicates short-duration trading behavior.

## Conclusion

**Backtest Result: FAILED**

The tested breakout-momentum configuration did not demonstrate profitability or acceptable capital preservation.

The results do not support live deployment or capital scaling.

## Source Report

`ReportTester-952747(20261027-065020).html`

Preserve the original Strategy Tester report alongside this README.

The HTML report references the following additional chart files:

- `ReportTester-952747.png`
- `ReportTester-952747-hst.png`
- `ReportTester-952747-mfemae.png`
- `ReportTester-952747-holding.png`

These images should be included if complete HTML chart rendering is required.

All reported backtest figures are taken from the supplied MetaTrader 5 Strategy Tester report.
