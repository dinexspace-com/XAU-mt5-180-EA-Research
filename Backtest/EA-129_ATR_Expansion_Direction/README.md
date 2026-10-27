# EA-129_ATR_Expansion_Direction — Backtest Report

## 1. Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-129_ATR_Expansion_Direction |
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
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpMagicNumber` | 129123 |
| `InpSlippage` | 10 |
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenOffset` | 0 |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 200 |
| `InpMaxSpread` | 30 |
| `InpATRPeriod` | 14 |
| `InpATRExpansionFactor` | 1.1 |
| `InpBreakoutBars` | 10 |

**Configuration verification:** All reported test inputs match the default values in the supplied MQL5 source.

## 3. Financial Performance

| Metric | Result |
|---|---:|
| Total Net Profit | -$653.50 |
| Gross Profit | $1,496.66 |
| Gross Loss | -$2,150.16 |
| Profit Factor | 0.70 |
| Expected Payoff | -$0.45 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| Margin Level | 3683.30% |
| AHPR | 0.9993 (-0.07%) |
| GHPR | 0.9993 (-0.07%) |
| Z-Score | -0.51 (38.99%) |
| LR Correlation | -0.99 |
| LR Standard Error | 23.73 |
| OnTester Result | 0 |

The test generated a net loss equivalent to 65.35% of the initial deposit.

The Profit Factor of 0.70 indicates that gross profit covered approximately 70% of gross loss.

Expected Payoff was negative.

## 4. Drawdown Analysis

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $662.28 |
| Balance Drawdown Maximal | $669.60 (66.47%) |
| Balance Drawdown Relative | 66.47% |
| Equity Drawdown Absolute | $662.79 |
| Equity Drawdown Maximal | $670.11 (66.52%) |
| Equity Drawdown Relative | 66.52% |

The maximum relative equity drawdown of 66.52% is substantial.

The drawdown amounts are measured according to the Strategy Tester's balance and equity calculations.

## 5. Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 1,463 |
| Total Deals | 2,926 |
| Short Trades | 912 |
| Short Win Rate | 41.12% |
| Long Trades | 551 |
| Long Win Rate | 41.38% |
| Winning Trades | 603 (41.22%) |
| Losing Trades | 860 (58.78%) |
| Largest Winning Trade | $9.96 |
| Largest Losing Trade | -$7.29 |
| Average Winning Trade | $2.48 |
| Average Losing Trade | -$2.50 |
| Maximum Consecutive Wins | 8 ($20.66) |
| Maximum Consecutive Losses | 13 (-$37.09) |
| Maximum Consecutive Profit | $27.01 across 6 trades |
| Maximum Consecutive Loss | -$37.09 across 13 trades |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The strategy recorded 257 more losing trades than winning trades.

The average losing trade was also slightly larger in absolute value than the average winning trade.

These results are consistent with the reported negative expectancy.

## 6. Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:04:02 |
| Average Holding Time | 00:01:57 |

The EA exhibited very short average holding times.

This increases the importance of evaluating spread, slippage, execution conditions, and the effect of dynamic Stop Loss modifications.

## 7. Additional Report Statistics

| Metric | Result |
|---|---:|
| Correlation (Profits, MFE) | 0.96 |
| Correlation (Profits, MAE) | 0.68 |
| Correlation (MFE, MAE) | 0.6170 |

These statistics describe the reported test outcomes but do not establish trading profitability.

## 8. Strategy Interpretation

The tested strategy requires:

`ATR[1] >= ATR[2] * 1.1`

combined with a completed-candle breakout above or below a historical 10-candle range.

The EA uses the close of candle 1 as the breakout signal and evaluates new entries on the next candle.

The results show that this combination, together with the tested execution and exit rules, did not produce positive expectancy over the supplied test period.

The report does not isolate whether losses originated primarily from:

- ATR expansion filtering
- Breakout selection
- Entry timing
- Stop Loss and Take Profit distances
- Break Even
- Trailing Stop
- Transaction costs

Separate controlled experiments are needed to determine the contribution of each component.

## 9. Final Backtest Assessment

**Status: FAILED**

The tested EA produced:

- Net Profit: -$653.50
- Profit Factor: 0.70
- Expected Payoff: -$0.45
- Equity Drawdown Relative: 66.52%
- Total Trades: 1,463
- Win Rate: 41.22%

The evidence does not support profitability or capital preservation.

The EA should not be approved for live deployment or capital scaling based on this backtest.

## 10. Original Report

`ReportTester-952747(20261027-071233).html`

The HTML references the following chart assets:

- `ReportTester-952747.png`
- `ReportTester-952747-hst.png`
- `ReportTester-952747-mfemae.png`
- `ReportTester-952747-holding.png`

These image files should be added only if their actual contents are available.

## Disclaimer

This document describes one historical MetaTrader 5 Strategy Tester run.

It does not establish future profitability or performance under other trading conditions.
