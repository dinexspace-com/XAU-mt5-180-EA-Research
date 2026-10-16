# EA-115 — ROC 10 Baseline Backtest

## 1. Test Configuration

| Item | Value |
|---|---|
| EA | `EA-115_ROC_10` |
| Baseline ID | `EA115-M1-BASELINE-001` |
| Symbol | `XAUUSD.PRO` |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Lot Size | 0.01 |
| ROC Period | 10 |
| ROC Threshold | 0.20% |
| Stop Loss | 300 points |
| Take Profit | 600 points |

## 2. Performance Results

| Metric | Result |
|---|---:|
| Net Profit | -$991.85 |
| Gross Profit | $7,598.29 |
| Gross Loss | -$8,590.14 |
| Profit Factor | 0.88 |
| Expected Payoff | -$0.16 |
| Recovery Factor | -0.98 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | $1,007.24 (99.20%) |
| Maximum Equity Drawdown | $1,007.24 (99.20%) |
| Relative Equity Drawdown | 99.20% |
| Total Trades | 6,185 |
| Total Deals | 12,370 |
| Winning Trades | 2,749 (44.45%) |
| Losing Trades | 3,436 (55.55%) |
| Average Profit Trade | $2.76 |
| Average Loss Trade | -$2.50 |
| Largest Profit Trade | $11.44 |
| Largest Loss Trade | -$43.08 |
| Average Holding Time | 35 seconds |

## 3. Directional Results

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 3,064 | 44.65% |
| SELL | 3,121 | 44.25% |

Both directions had win rates below 45%. The report does not provide evidence that either direction is profitable on its own.

## 4. Assessment

**Baseline Result: FAIL**

Reasons:

- Net profit is negative.
- Profit Factor is below 1.00.
- Expected Payoff is negative.
- Sharpe Ratio is negative.
- Maximum reported equity drawdown is 99.20%.
- The account lost nearly all its initial capital during the test.

The EA generated 6,185 trades, but a large sample does not compensate for negative performance and extreme drawdown.

## 5. Decision

| Stage | Status |
|---|---|
| Strategy Code | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Assessment | FAIL |
| Parameter Research | DIAGNOSTIC RESEARCH ONLY |
| Out-of-Sample Validation | NOT STARTED |
| Walk-Forward Testing | NOT STARTED |
| Forward Testing | NOT STARTED |
| Live Trading | NOT APPROVED |

## 6. Next Action

Preserve this report as the original baseline. Investigate signal frequency, execution behavior, exit management, and directional performance using controlled experiments. Do not promote the EA based on isolated improvements in net profit alone.
