# EA-128_ATR_Low-to-High — Backtest Report

## 1. Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-128_ATR_Low-to-High |
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

## 2. Actual Tested Parameters

The following values are taken directly from the supplied MT5 Strategy Tester report.

| Parameter | Tested Value |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpMagicNumber` | 128123 |
| `InpSlippage` | 10 |
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenOffset` | 0 |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 200 |
| `InpMaxSpread` | 35 |
| `InpATRPeriod` | 14 |
| `InpATRLookback` | 30 |
| `InpLowATRFactor` | 1.2 |
| `InpExpansionFactor` | 1.05 |
| `InpRangeBars` | 3 |

### Source-to-Report Configuration Difference

Four tested inputs differ from the supplied source defaults.

| Parameter | Source Default | Backtest |
|---|---:|---:|
| `InpMaxSpread` | 30 | 35 |
| `InpLowATRFactor` | 0.7 | 1.2 |
| `InpExpansionFactor` | 1.5 | 1.05 |
| `InpRangeBars` | 10 | 3 |

These differences materially change the entry-selection criteria.

The results below apply only to the configuration recorded in the report.

## 3. Financial Performance

| Metric | Result |
|---|---:|
| Total Net Profit | -$993.34 |
| Gross Profit | $3,061.05 |
| Gross Loss | -$4,054.39 |
| Profit Factor | 0.75 |
| Expected Payoff | -$0.33 |
| Recovery Factor | -0.93 |
| Sharpe Ratio | -5.00 |
| Margin Level | 97.55% |
| AHPR | 0.9985 (-0.15%) |
| GHPR | 0.9983 (-0.17%) |
| Z-Score | -1.26 (79.23%) |
| LR Correlation | -0.99 |
| LR Standard Error | 53.67 |
| OnTester Result | 0 |

The reported net loss equals approximately 99.33% of the initial deposit.

Gross losses substantially exceeded gross profits.

A Profit Factor of 0.75 indicates that the tested strategy did not generate sufficient gross profit to cover its gross losses.

## 4. Drawdown Analysis

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $993.34 |
| Balance Drawdown Maximal | $1,063.13 (99.38%) |
| Balance Drawdown Relative | 99.38% |
| Equity Drawdown Absolute | $993.34 |
| Equity Drawdown Maximal | $1,065.15 (99.38%) |
| Equity Drawdown Relative | 99.38% |

The maximum relative equity drawdown of 99.38% represents near-total capital deterioration.

The maximal drawdown amounts are measured from the applicable equity or balance peak, not necessarily from the initial deposit.

## 5. Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 2,987 |
| Total Deals | 5,974 |
| Short Trades | 1,627 |
| Short Win Rate | 44.19% |
| Long Trades | 1,360 |
| Long Win Rate | 44.26% |
| Winning Trades | 1,321 (44.22%) |
| Losing Trades | 1,666 (55.78%) |
| Largest Winning Trade | $31.04 |
| Largest Losing Trade | -$6.82 |
| Average Winning Trade | $2.32 |
| Average Losing Trade | -$2.43 |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 13 |
| Maximum Consecutive Profit | $34.06 across 3 trades |
| Maximum Consecutive Loss | -$30.82 across 13 trades |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

Losing trades outnumbered winning trades.

The average losing trade was also larger in absolute value than the average winning trade.

Both observations contributed to the negative expectancy.

## 6. Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:12:00 |
| Average Holding Time | 00:03:00 |

The strategy exhibited short-duration trading behavior.

Execution quality, transaction costs, and dynamic stop management should therefore be evaluated carefully.

## 7. Additional Report Statistics

| Metric | Result |
|---|---:|
| Correlation (Profits, MFE) | 0.96 |
| Correlation (Profits, MAE) | 0.68 |
| Correlation (MFE, MAE) | 0.6001 |

These correlations describe relationships within the reported test results.

They do not establish a profitable or reliable trading strategy.

## 8. Strategy Interpretation

The tested EA used:

- ATR period: 14
- ATR baseline lookback: 30
- Low ATR factor: 1.2
- ATR expansion factor: 1.05
- Historical breakout range: 3 candles

The tested configuration is substantially less restrictive than the source defaults in several respects.

For example:

- The low-volatility threshold was increased from 0.7 to 1.2.
- The ATR expansion requirement was reduced from 1.5 to 1.05.
- The breakout reference range was reduced from 10 candles to 3.

These differences are important when interpreting the number and quality of signals.

However, the report does not provide a controlled comparison against the source-default configuration.

It is therefore not possible to quantify the performance effect of each parameter difference from the supplied evidence.

## 9. Final Backtest Assessment

**Status: FAILED**

The tested configuration produced:

- Net loss of $993.34
- Profit Factor of 0.75
- Expected Payoff of -$0.33
- Equity Drawdown Relative of 99.38%
- 2,987 completed trades

The results do not support profitability, capital preservation, or deployment readiness.

The EA should not be approved for live trading or capital scaling based on this test.

## 10. Original Report

`ReportTester-952747(20261027-070818).html`

The HTML report references the following image files:

- `ReportTester-952747.png`
- `ReportTester-952747-hst.png`
- `ReportTester-952747-mfemae.png`
- `ReportTester-952747-holding.png`

The referenced images should only be added to the repository if the actual image files are available.

## Disclaimer

This report documents one historical Strategy Tester run.

The supplied results do not establish the performance of other parameter configurations or future market conditions.
