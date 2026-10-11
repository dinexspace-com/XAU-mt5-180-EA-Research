
# EA-109 — RSI 50 Cross Backtest

## 1. Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-109_RSI_50_Cross |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Baseline ID | `EA109-M1-BASELINE-001` |

## 2. Performance Summary

| Metric | Result |
|---|---:|
| Net Profit | -$18.67 |
| Gross Profit | $167.32 |
| Gross Loss | -$185.99 |
| Profit Factor | 0.90 |
| Expected Payoff | -$0.12 |
| Recovery Factor | -0.47 |
| Sharpe Ratio | -5.00 |
| Max Balance Drawdown | $37.71 (3.71%) |
| Max Equity Drawdown | $39.88 (3.92%) |
| Total Trades | 153 |
| Total Deals | 306 |
| Profit Trades | 80 (52.29%) |
| Loss Trades | 73 (47.71%) |

## 3. Directional Results

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 73 | 52.05% |
| SELL | 80 | 52.50% |

## 4. Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $7.76 |
| Largest Loss Trade | -$11.35 |
| Average Profit Trade | $2.09 |
| Average Loss Trade | -$2.55 |
| Maximum Consecutive Wins | 4 |
| Maximum Consecutive Losses | 5 |
| Average Holding Time | 5 minutes |

## 5. Assessment

**Baseline Result: FAIL**

Reasons:

- Net profit is negative.
- Profit Factor is below 1.00.
- Expected Payoff is negative.
- Sharpe Ratio is negative.
- Average loss ($2.55) exceeds average profit ($2.09).

The reported maximum equity drawdown is relatively low at 3.92%, but low drawdown does not compensate for negative expectancy.

## 6. Research Decision

| Stage | Status |
|---|---|
| Strategy Code | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Assessment | FAIL |
| Buffer Index / Signal Logic Audit | REQUIRED |
| Parameter Research | BLOCKED pending logic audit |
| Out-of-Sample Validation | NOT STARTED |
| Walk-Forward Test | NOT STARTED |
| Forward Test | NOT STARTED |
| Live Trading | NOT APPROVED |

**Conclusion:** Do not treat this result as evidence of a profitable strategy. Audit the signal indexing and confirm the intended RSI 50 crossing before changing parameters.
