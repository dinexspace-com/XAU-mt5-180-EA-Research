# EA-130_ATR_Contraction_Reversal — Backtest Report

## 1. Test Environment

| Setting | Value |
|---|---|
| Platform | MetaTrader 5 |
| Expert Advisor | EA-130_ATR_Contraction_Reversal |
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
| `InpMagicNumber` | 130123 |
| `InpSlippage` | 10 |
| `InpUseBreakEven` | true |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenOffset` | 0 |
| `InpUseTrailingStop` | true |
| `InpTrailingStart` | 200 |
| `InpTrailingDistance` | 200 |
| `InpMaxSpread` | 30 |
| `InpATRPeriod` | 14 |
| `InpATRLookback` | 30 |
| `InpLowATRFactor` | 0.7 |
| `InpRangeBars` | 20 |
| `InpWickBodyRatio` | 1.5 |

**Configuration verification: MATCHED**

All reported inputs match the default parameters declared in the supplied MQL5 source.

## 3. Financial Performance

| Metric | Result |
|---|---:|
| Total Net Profit | +$16.50 |
| Gross Profit | $192.03 |
| Gross Loss | -$175.53 |
| Profit Factor | 1.09 |
| Expected Payoff | +$0.10 |
| Recovery Factor | 0.57 |
| Sharpe Ratio | 9.45 |
| Margin Level | 9022.35% |
| AHPR | 1.0001 (0.01%) |
| GHPR | 1.0001 (0.01%) |
| Z-Score | 0.39 (30.35%) |
| LR Correlation | 0.08 |
| LR Standard Error | 6.64 |
| OnTester Result | 0 |

The EA generated a net profit of $16.50, equivalent to 1.65% of the initial deposit.

Gross profit exceeded gross loss by a small margin.

Profit Factor was 1.09, indicating that gross profit was approximately 9% greater than gross loss.

Expected Payoff was positive but only $0.10 per trade.

Although the report shows a Sharpe Ratio of 9.45, this statistic should not override the modest net profit, low Profit Factor, and limited sample size.

## 4. Drawdown Analysis

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $16.74 |
| Balance Drawdown Maximal | $26.51 (2.63%) |
| Balance Drawdown Relative | 2.63% ($26.51) |
| Equity Drawdown Absolute | $16.95 |
| Equity Drawdown Maximal | $28.89 (2.85%) |
| Equity Drawdown Relative | 2.85% ($28.89) |

The reported maximum relative equity drawdown was 2.85%.

This is substantially lower than the drawdowns reported for several preceding EA experiments.

However, a low drawdown in one historical test does not establish that the same risk profile will persist in future market conditions.

## 5. Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 169 |
| Total Deals | 338 |
| Short Trades | 124 |
| Short Win Rate | 55.65% |
| Long Trades | 45 |
| Long Win Rate | 48.89% |
| Winning Trades | 91 (53.85%) |
| Losing Trades | 78 (46.15%) |
| Largest Winning Trade | $6.28 |
| Largest Losing Trade | -$3.34 |
| Average Winning Trade | $2.11 |
| Average Losing Trade | -$2.25 |
| Maximum Consecutive Wins | 6 ($8.41) |
| Maximum Consecutive Losses | 7 (-$18.45) |
| Maximum Consecutive Profit | $12.24 across 3 trades |
| Maximum Consecutive Loss | -$18.45 across 7 trades |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

The win rate was above 50%.

However, the average losing trade was slightly larger in absolute value than the average winning trade.

The positive expectancy depended on the winning frequency being sufficient to offset this payoff disadvantage.

## 6. Directional Distribution

The report recorded:

| Direction | Trades | Win Rate |
|---|---:|---:|
| Buy | 45 | 48.89% |
| Sell | 124 | 55.65% |

Sell trades represented approximately 73.37% of all completed trades.

The Sell win rate exceeded the Buy win rate by 6.76 percentage points.

However, the summary does not provide separate net profit or Profit Factor figures for Buy and Sell trades.

It is therefore not possible to establish directional profitability from these win rates alone.

## 7. Position Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:06 |
| Maximum Holding Time | 01:04:22 |
| Average Holding Time | 00:04:15 |

The average holding time was four minutes and fifteen seconds.

This relatively short holding period makes execution costs, spread, slippage, and stop-management behavior important validation considerations.

## 8. Additional Report Statistics

| Metric | Result |
|---|---:|
| Correlation (Profits, MFE) | 0.96 |
| Correlation (Profits, MAE) | 0.60 |
| Correlation (MFE, MAE) | 0.4827 |

These values are reported by MetaTrader 5.

They provide descriptive information about historical trade behavior but do not independently demonstrate a robust trading advantage.

## 9. Strategy Interpretation

The EA combines:

1. Low ATR relative to an earlier 30-candle ATR average.
2. Price interaction with the outer 10% of a historical 20-candle range.
3. A bullish lower-wick rejection for Buy entries.
4. A bearish upper-wick rejection for Sell entries.
5. Fixed Stop Loss and Take Profit.
6. Break Even and Trailing Stop.

The tested configuration produced positive net profit and low relative drawdown.

Nevertheless, the edge was narrow.

A Profit Factor of 1.09 provides limited protection against deterioration caused by different market regimes or execution conditions.

The report does not isolate the individual contribution of the ATR filter, rejection candle, range boundary, or exit-management rules.

## 10. Backtest Assessment

**Status: PROVISIONAL PASS — RESEARCH ONLY**

Positive observations:

- Net profit was positive.
- Profit Factor exceeded 1.0.
- Expected Payoff was positive.
- Relative equity drawdown was 2.85%.
- Win rate exceeded 50%.

Limitations:

- Net profit was only $16.50.
- Profit Factor was only 1.09.
- The test included 169 trades.
- No independent out-of-sample validation is supplied.
- No EA-130 live trading results are supplied.
- No execution-cost stress test is supplied.

The EA passes a basic profitability observation but does not pass a robust deployment-readiness assessment.

## 11. Deployment Decision

**Not approved for live capital scaling.**

The next stage should be independent validation rather than increasing lot size or trading capital.

## 12. Original Report

`ReportTester-952747(20261027-071810).html`

The HTML references the following chart files:

- `ReportTester-952747.png`
- `ReportTester-952747-hst.png`
- `ReportTester-952747-mfemae.png`
- `ReportTester-952747-holding.png`

These files should only be committed if the corresponding actual image assets are available.

## Disclaimer

This document describes one historical Strategy Tester run.

It does not establish future profitability or guarantee that the observed drawdown will remain unchanged.
