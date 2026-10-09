# EA-105 — Range Midpoint Backtest

## 1. Baseline Identification

* **EA:** `EA-105_Range_Midpoint`
* **Baseline ID:** `EA105-M1-BASELINE-001`
* **Symbol:** XAUUSD.PRO
* **Timeframe:** M1
* **Test Period:** 2026-01-02 to 2026-04-01
* **Initial Deposit:** $1,000
* **Leverage:** 1:500
* **History Quality:** 100% real ticks
* **Bars:** 86,539
* **Ticks:** 40,346,891

## 2. Baseline Parameters

| Parameter            |      Value |
| -------------------- | ---------: |
| Lot Size             |       0.01 |
| Stop Loss            | 300 points |
| Take Profit          | 600 points |
| Break-even Trigger   | 150 points |
| Break-even Offset    |   0 points |
| Trailing Start       | 200 points |
| Trailing Distance    | 200 points |
| Maximum Spread       |  30 points |
| Range Bars           |         20 |
| Rejection Wick Ratio |        0.5 |

## 3. Performance Results

| Metric               |           Result |
| -------------------- | ---------------: |
| Initial Deposit      |        $1,000.00 |
| Net Profit           |         -$400.13 |
| Gross Profit         |        $2,781.94 |
| Gross Loss           |       -$3,182.07 |
| Profit Factor        |             0.87 |
| Expected Payoff      |           -$0.15 |
| Recovery Factor      |            -0.89 |
| Sharpe Ratio         |            -5.00 |
| Max Balance Drawdown | $446.39 (44.42%) |
| Max Equity Drawdown  | $448.61 (44.56%) |
| Total Trades         |            2,589 |
| Total Deals          |            5,178 |
| Winning Trades       |   1,216 (46.97%) |
| Losing Trades        |   1,373 (53.03%) |
| Average Profit Trade |            $2.29 |
| Average Loss Trade   |           -$2.32 |
| Largest Profit Trade |            $7.54 |
| Largest Loss Trade   |           -$6.94 |
| Average Holding Time |         00:03:02 |

## 4. Directional Results

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| SELL      |  1,396 |   48.42% |
| BUY       |  1,193 |   45.26% |

Both directions had win rates below 50%. SELL performed better than BUY in this baseline, but this observation alone does not establish a reliable directional edge.

## 5. Assessment

**Baseline Classification: `FAIL`**

Reasons:

* Net profit is negative.
* Profit Factor is below 1.0.
* Expected Payoff is negative.
* Sharpe Ratio is negative.
* Maximum equity drawdown is 44.56%.
* Both BUY and SELL have win rates below 50%.

The test generated 2,589 trades, providing a substantial initial sample for investigation. However, the results do not demonstrate a profitable baseline.

## 6. Research Decision

| Stage                    | Status       |
| ------------------------ | ------------ |
| Strategy Code            | COMPLETE     |
| Baseline Backtest        | COMPLETE     |
| Baseline Assessment      | FAIL         |
| Controlled Research      | REQUIRED     |
| Broad Optimization       | BLOCKED      |
| Out-of-Sample Validation | NOT STARTED  |
| Walk-Forward Validation  | NOT STARTED  |
| Forward Test             | NOT STARTED  |
| Live Trading             | NOT APPROVED |

## 7. Conclusion

Do not treat this backtest as evidence of a production-ready EA. Preserve the baseline report and investigate the range definition, rejection criteria, directional performance and exit management through controlled experiments before considering further validation.
