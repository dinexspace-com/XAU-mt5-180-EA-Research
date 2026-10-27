# EA-123_EMA_Distance_Expansion — Backtest Report

## Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-123_EMA_Distance_Expansion |
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
| Total Net Profit | -$994.33 |
| Gross Profit | $7,573.42 |
| Gross Loss | -$8,567.75 |
| Profit Factor | 0.88 |
| Expected Payoff | -$0.15 |
| Recovery Factor | -0.96 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Absolute | $994.33 |
| Balance Drawdown Maximal | $1,030.66 (99.45%) |
| Balance Drawdown Relative | 99.45% |
| Equity Drawdown Absolute | $994.33 |
| Equity Drawdown Maximal | $1,032.03 (99.45%) |
| Equity Drawdown Relative | 99.45% |
| Total Trades | 6,598 |
| Total Deals | 13,196 |
| Winning Trades | 3,045 (46.15%) |
| Losing Trades | 3,553 (53.85%) |

## Trade Statistics

| Metric | Result |
|---|---:|
| Buy Trades | 3,114 |
| Buy Win Rate | 47.37% |
| Sell Trades | 3,484 |
| Sell Win Rate | 45.06% |
| Largest Winning Trade | $33.74 |
| Largest Losing Trade | -$26.62 |
| Average Winning Trade | $2.49 |
| Average Losing Trade | -$2.41 |
| Maximum Consecutive Wins | 13 |
| Maximum Consecutive Losses | 12 |
| Average Holding Time | 00:02:34 |
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 03:41:01 |

## Performance Assessment

The strategy generated 6,598 trades during the evaluated period.

Gross losses exceeded gross profits, resulting in a Profit Factor of 0.88.

The overall win rate was 46.15%. Although the average winning trade was slightly larger than the average losing trade, the proportion of losing trades resulted in negative expectancy.

The negative Expected Payoff of $0.15 per trade confirms that the tested configuration was unprofitable on average.

Relative equity drawdown reached 99.45%, indicating near-total depletion of the initial test capital.

## Conclusion

**Backtest Result: FAILED**

The tested EMA distance expansion strategy did not demonstrate profitability or acceptable capital preservation.

The results do not support deployment under the tested configuration.

## Source

Original MetaTrader 5 Strategy Tester report:

`ReportTester-952747(20261027-064100).html`

All reported performance statistics are taken from the supplied Strategy Tester report.
