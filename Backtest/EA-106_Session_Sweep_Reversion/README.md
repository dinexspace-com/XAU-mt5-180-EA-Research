# EA-106 — Baseline Backtest Report

## Test Identification

* **EA:** EA-106 Session Sweep Reversion
* **Baseline ID:** `EA106-M1-BASELINE-001`
* **Symbol:** XAUUSD.PRO
* **Timeframe:** M1
* **Test period:** 2026-01-02 to 2026-04-01
* **Initial deposit:** $1,000
* **Leverage:** 1:500
* **History quality:** 100% real ticks
* **Bars:** 86,539
* **Ticks:** 40,346,891
* **Total trades:** 569
* **Total deals:** 1,138

## Performance Summary

| Metric                    |           Result |
| ------------------------- | ---------------: |
| Total Net Profit          |         -$142.71 |
| Gross Profit              |          $613.45 |
| Gross Loss                |         -$756.16 |
| Profit Factor             |             0.81 |
| Expected Payoff           |           -$0.25 |
| Recovery Factor           |            -0.75 |
| Sharpe Ratio              |            -5.00 |
| Max Balance Drawdown      | $187.58 (18.76%) |
| Max Equity Drawdown       | $190.99 (19.06%) |
| Absolute Balance Drawdown |          $187.46 |
| Absolute Equity Drawdown  |          $188.83 |

## Trade Statistics

| Metric                     |             Result |
| -------------------------- | -----------------: |
| Winning Trades             |       271 (47.63%) |
| Losing Trades              |       298 (52.37%) |
| BUY Trades                 |                242 |
| BUY Win Rate               |             53.31% |
| SELL Trades                |                327 |
| SELL Win Rate              |             43.43% |
| Average Profit Trade       |              $2.26 |
| Average Loss Trade         |             -$2.54 |
| Largest Profit Trade       |              $7.33 |
| Largest Loss Trade         |             -$6.83 |
| Maximum Consecutive Losses | 9 trades (-$26.46) |
| Average Holding Time       |           00:01:47 |
| Maximum Holding Time       |           00:28:05 |

## Baseline Assessment

**Decision: FAIL — Do not approve for live trading.**

Key observations:

1. Net profit is negative.
2. Profit Factor of 0.81 indicates that gross losses exceed gross profits.
3. Expected Payoff is negative.
4. Average losing trade (-$2.54) is larger than average winning trade ($2.26).
5. BUY trades have a higher reported win rate than SELL trades, suggesting that directional performance should be investigated separately.
6. Maximum equity drawdown is 19.06% of the initial account balance.

## Research Priority

Before changing several inputs together, investigate:

1. Whether the session range and trading window are implemented as intended.
2. BUY-only versus SELL-only performance.
3. Session-range definition and sweep confirmation.
4. Break-Even and Trailing Stop effects.
5. Stop Loss and Take Profit sensitivity.

Each experiment must retain its own ID and be compared with this baseline.

## Conclusion

EA-106 failed its initial baseline test on XAUUSD.PRO M1 for 2026-01-02 to 2026-04-01. The results justify further diagnosis, not deployment. No claim of out-of-sample robustness can be made from this test alone.
