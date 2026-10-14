
# EA-113 — MACD Zero Cross Baseline Backtest

## 1. Test Configuration

| Setting | Value |
|---|---|
| EA | EA-113_MACD_Zero_Cross |
| Baseline ID | `EA113-M1-BASELINE-001` |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 to 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

## 2. Performance Results

| Metric | Result |
|---|---:|
| Net Profit | -$775.88 |
| Gross Profit | $2,927.52 |
| Gross Loss | -$3,703.40 |
| Profit Factor | 0.79 |
| Expected Payoff | -$0.27 |
| Recovery Factor | -0.97 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | $796.19 (79.56%) |
| Maximum Equity Drawdown | $798.54 (79.62%) |
| Total Trades | 2,830 |
| Total Deals | 5,660 |
| Winning Trades | 1,290 (45.58%) |
| Losing Trades | 1,540 (54.42%) |
| Average Profit Trade | $2.27 |
| Average Loss Trade | -$2.40 |
| Largest Profit Trade | $29.77 |
| Largest Loss Trade | -$13.52 |
| Average Holding Time | 00:03:11 |

## 3. Directional Results

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 1,415 | 45.72% |
| SELL | 1,415 | 45.44% |

Both directions recorded win rates below 50%. The baseline report does not establish a profitable directional edge.

## 4. Baseline Assessment

**Classification: `FAIL`**

Reasons:

- Net profit is negative.
- Profit Factor is below 1.00.
- Expected Payoff is negative.
- Sharpe Ratio is negative.
- Maximum Equity Drawdown is 79.62%.
- Losing trades outnumber winning trades.

## 5. Research Decision

| Stage | Status |
|---|---|
| Strategy Code | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Assessment | FAIL |
| Entry Logic Research | PENDING |
| Parameter Evaluation | BLOCKED pending entry-edge assessment |
| Out-of-Sample Validation | NOT STARTED |
| Walk-Forward Validation | NOT STARTED |
| Forward Test | NOT STARTED |
| Live Trading | NOT APPROVED |

Preserve this report as the baseline record. Do not replace it with results from later experiments. Any future experiment should have its own identifier and a documented comparison against this baseline.
