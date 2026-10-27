# EA-126_Impulse_Follow-through — Backtest Report

## Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-126_Impulse_Follow-through |
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

## Strategy Configuration

| Parameter | Tested Value |
|---|---:|
| Fixed Lot | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 126123 |
| Slippage | 10 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| ATR Period | 14 |
| Impulse ATR Multiplier | 1.5 |

## Performance Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$211.69 |
| Gross Profit | $1,244.11 |
| Gross Loss | -$1,455.80 |
| Profit Factor | 0.85 |
| Expected Payoff | -$0.20 |
| Recovery Factor | -0.83 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Absolute | $211.69 |
| Balance Drawdown Maximal | $253.64 (24.34%) |
| Balance Drawdown Relative | 24.34% |
| Equity Drawdown Absolute | $211.69 |
| Equity Drawdown Maximal | $255.25 (24.46%) |
| Equity Drawdown Relative | 24.46% |
| Margin Level | 7,987.78% |
| Total Trades | 1,085 |
| Total Deals | 2,170 |

## Trade Statistics

| Metric | Result |
|---|---:|
| Long Trades | 530 |
| Long Win Rate | 42.64% |
| Short Trades | 555 |
| Short Win Rate | 48.65% |
| Winning Trades | 496 (45.71%) |
| Losing Trades | 589 (54.29%) |
| Largest Winning Trade | $9.67 |
| Largest Losing Trade | -$6.21 |
| Average Winning Trade | $2.51 |
| Average Losing Trade | -$2.47 |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 11 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:13:02 |
| Average Holding Time | 00:02:37 |

## Performance Assessment

The EA executed 1,085 trades during the test period.

Gross losses of $1,455.80 exceeded gross profits of $1,244.11, producing a Profit Factor of 0.85 and a net loss of $211.69.

The overall winning trade percentage was 45.71%.

Average winning trades generated $2.51, while average losing trades lost $2.47. The slightly larger average winning trade was insufficient to compensate for the higher frequency of losing trades.

The short-trade win rate of 48.65% exceeded the long-trade win rate of 42.64%. This difference is descriptive and does not independently establish that short trades were profitable.

The Equity Drawdown Relative of 24.46% indicates substantial capital risk, although the account did not experience the near-total drawdown observed in some other EA experiments.

The average holding time of 2 minutes and 37 seconds indicates short-duration trading behavior.

## Conclusion

**Backtest Result: FAILED**

The tested configuration did not demonstrate positive expectancy or a Profit Factor above 1.

Its lower drawdown relative to some other experiments is a useful research observation, but it does not establish profitability.

Further controlled testing is required before considering deployment.

## Original Strategy Tester Report

`ReportTester-952747(20261027-065547).html`

Preserve the original HTML report alongside this README.

The report references the following external chart images:

- `ReportTester-952747.png`
- `ReportTester-952747-hst.png`
- `ReportTester-952747-mfemae.png`
- `ReportTester-952747-holding.png`

These image files should also be preserved if complete chart rendering is required.

All reported performance figures are taken from the supplied MetaTrader 5 Strategy Tester report.
