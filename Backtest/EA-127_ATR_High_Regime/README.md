# EA-127_ATR_High_Regime — Backtest Report

## 1. Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-127_ATR_High_Regime |
| Broker Server | ACCMIntl-Real |
| MT5 Build | 6230 |
| Broker Company | ACCM Intl Limited |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Account Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Total Bars | 86,539 |
| Total Ticks | 40,346,891 |
| Symbols Tested | 1 |

## 2. Tested Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 127123 |
| Slippage | 10 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 200 points |
| Maximum Spread | 30 points |
| ATR Period | 14 |
| ATR Lookback | 50 |
| High ATR Factor | 1.3 |
| Fast EMA | 20 |
| Slow EMA | 50 |

## 3. Financial Performance

| Metric | Result |
|---|---:|
| Total Net Profit | -$904.38 |
| Gross Profit | $7,716.78 |
| Gross Loss | -$8,621.16 |
| Profit Factor | 0.90 |
| Expected Payoff | -$0.14 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| Margin Level | 833.55% |
| AHPR | 0.9997 (-0.03%) |
| GHPR | 0.9996 (-0.04%) |

Gross losses exceeded gross profits by $904.38.

The Profit Factor of 0.90 and negative Expected Payoff indicate that the tested configuration did not generate a profitable trading edge.

## 4. Drawdown Analysis

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $921.97 |
| Balance Drawdown Maximal | $922.85 (92.20%) |
| Balance Drawdown Relative | 92.20% |
| Equity Drawdown Absolute | $922.23 |
| Equity Drawdown Maximal | $925.14 (92.25%) |
| Equity Drawdown Relative | 92.25% |

The reported maximum relative equity drawdown of 92.25% indicates severe capital deterioration.

This risk level is incompatible with a capital-preservation objective.

## 5. Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 6,698 |
| Total Deals | 13,396 |
| Long Trades | 2,261 |
| Long Win Rate | 48.47% |
| Short Trades | 4,437 |
| Short Win Rate | 44.99% |
| Winning Trades | 3,092 (46.16%) |
| Losing Trades | 3,606 (53.84%) |
| Largest Winning Trade | $9.67 |
| Largest Losing Trade | -$9.92 |
| Average Winning Trade | $2.50 |
| Average Losing Trade | -$2.39 |
| Maximum Consecutive Wins | 10 |
| Maximum Consecutive Losses | 11 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

Although average winning trades were slightly larger than average losing trades, the lower winning-trade frequency resulted in negative overall performance.

Short trades accounted for approximately 66.24% of all trades, while long trades accounted for approximately 33.76%.

The reported win rates alone do not establish separate long-side or short-side profitability.

## 6. Position Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 03:41:01 |
| Average Holding Time | 00:01:16 |

The average holding time indicates very short-duration trading.

This makes execution quality, spreads, and the interaction between entry timing and position management important subjects for further research.

## 7. Backtest Interpretation

The EA completed 6,698 trades over the supplied test period.

This provides a substantial number of observations for the tested configuration, but a high trade count does not establish profitability or robustness.

The ATR regime filter allowed frequent entries during qualifying volatility conditions.

Because the EMA direction filter does not require a new crossover, multiple entries can occur during a sustained qualifying regime after previous positions close.

The supplied results show:

- Negative net profit
- Profit Factor below 1
- Negative expected payoff
- Severe equity drawdown
- More losing trades than winning trades

The report does not independently identify which component caused the losses.

## 8. Final Assessment

**Backtest Status: FAILED**

The tested strategy lost $904.38 from a $1,000 initial deposit and recorded 92.25% relative equity drawdown.

The current configuration does not meet reasonable requirements for profitability or capital preservation.

Further research should focus on regime classification, signal persistence, execution frequency, and exit-management behavior.

## 9. Original Report

`ReportTester-952747(20261027-070125).html`

The HTML report references the following chart image filenames:

- `ReportTester-952747.png`
- `ReportTester-952747-hst.png`
- `ReportTester-952747-mfemae.png`
- `ReportTester-952747-holding.png`

These referenced images are not established as separate uploaded files.

Preserve the original HTML report as the primary record of the backtest.

## Disclaimer

This report documents historical simulated performance only.

It does not constitute evidence of future profitability.
