# EA-118 Body Momentum — Baseline Backtest

## 1. Test Configuration

| Item | Value |
|---|---|
| Expert Advisor | EA-118_Body_Momentum |
| Broker environment | ACCMIntl-Real |
| MT5 build | 6230 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test period | 2026-01-02 to 2026-04-01 |
| Initial deposit | $1,000 |
| Leverage | 1:500 |
| History quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Lot size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |

## 2. Financial Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$992.26 |
| Gross Profit | $2,760.74 |
| Gross Loss | -$3,753.00 |
| Profit Factor | 0.74 |
| Expected Payoff | -$0.34 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| AHPR | 0.9986 |
| GHPR | 0.9983 |
| Balance Drawdown Maximal | $1,011.25 (99.24%) |
| Equity Drawdown Maximal | $1,013.21 (99.24%) |
| Relative Equity Drawdown | 99.24% |
| Margin Level | 97.92% |

## 3. Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 2,911 |
| Total Deals | 5,822 |
| Winning Trades | 1,336 (45.89%) |
| Losing Trades | 1,575 (54.11%) |
| Long Trades | 1,534 |
| Long Win Rate | 46.02% |
| Short Trades | 1,377 |
| Short Win Rate | 45.75% |
| Largest Profit Trade | $34.99 |
| Largest Loss Trade | -$7.24 |
| Average Profit Trade | $2.07 |
| Average Loss Trade | -$2.38 |
| Maximum Consecutive Wins | 9 ($21.56) |
| Maximum Consecutive Losses | 10 (-$24.89) |
| Average Holding Time | 4 minutes 10 seconds |
| Maximum Holding Time | 2 hours 24 minutes 3 seconds |

## 4. Assessment

### Result: FAIL

The baseline failed to produce positive expectancy:

- Net profit was negative by $992.26 against a $1,000 initial deposit.
- Profit Factor was 0.74, meaning gross losses exceeded gross profits.
- Maximum relative equity drawdown reached 99.24%.
- The Sharpe Ratio was -5.00.
- Losing trades exceeded winning trades.

The reported margin level was 97.92%, reinforcing the need to investigate account-level risk and capital preservation.

Although the winning-trade percentage was 45.89%, that statistic alone does not establish profitability. The reported average winning trade ($2.07) was smaller than the average losing trade (-$2.38).

## 5. Next Steps

The following are proposed experiments, not completed tests:

1. Review signal frequency and candle-body calculations.
2. Compare the current body multiplier against alternative values.
3. Test the extreme-close filter independently.
4. Evaluate spread and execution-cost sensitivity.
5. Compare fixed SL/TP with alternative exit-management configurations.
6. Preserve the baseline report and test each change separately.
7. Require out-of-sample and forward testing before considering any deployment.

## Final Decision

**FAIL — Do not deploy live.**

This report documents the baseline outcome only. No optimized version or successful validation is implied.
