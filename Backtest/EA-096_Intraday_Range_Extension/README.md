# Backtest - EA-096_Intraday_Range_Extension

## 1. Experiment ID

`EA096-M1-BASELINE-001`

---

## 2. Test Configuration

| Parameter       | Value                           |
| --------------- | ------------------------------- |
| Expert          | EA-096_Intraday_Range_Extension |
| Symbol          | XAUUSD.PRO                      |
| Timeframe       | M1                              |
| Test Period     | 2026.01.02 – 2026.03.31         |
| Initial Deposit | $1,000                          |
| Leverage        | 1:500                           |
| History Quality | 100% real ticks                 |
| Bars            | 85,161                          |
| Ticks           | 39,639,179                      |
| Symbols         | 1                               |

The report confirms that the test used 100% real ticks.

---

## 3. EA Parameters

| Parameter          |      Value |
| ------------------ | ---------: |
| Lot Size           |       0.01 |
| Stop Loss          | 300 points |
| Take Profit        | 600 points |
| Magic Number       |     123096 |
| Slippage           |         10 |
| Maximum Spread     |         30 |
| Timeframe          |         M1 |
| Break-Even         |    Enabled |
| Break-Even Trigger |        150 |
| Break-Even Offset  |          0 |
| Trailing Stop      |    Enabled |
| Trailing Start     |        200 |
| Trailing Distance  |        100 |
| Trailing Step      |         10 |
| ATR Period         |         14 |
| Extension ATR      |        1.0 |
| Minimum Range Bars |         30 |

These values are the parameters used in the supplied tester report.

---

## 4. Performance Results

| Metric          |          Result |
| --------------- | --------------: |
| Initial Deposit |       $1,000.00 |
| Net Profit      |         +$30.80 |
| Gross Profit    |         $113.34 |
| Gross Loss      |         -$82.54 |
| Profit Factor   |            1.37 |
| Expected Payoff |           $0.36 |
| Recovery Factor |            2.11 |
| Sharpe Ratio    |           49.56 |
| AHPR            | 1.0004 (+0.04%) |
| GHPR            | 1.0004 (+0.04%) |
| LR Correlation  |            0.88 |

The supplied report records a positive net profit of $30.80 and Profit Factor of 1.37.

---

## 5. Drawdown

| Metric              |         Result |
| ------------------- | -------------: |
| Balance DD Absolute |          $3.30 |
| Equity DD Absolute  |          $3.60 |
| Balance DD Maximal  | $13.30 (1.31%) |
| Equity DD Maximal   | $14.57 (1.44%) |
| Balance DD Relative |          1.31% |
| Equity DD Relative  |          1.44% |

The reported maximum equity drawdown is 1.44%.

---

## 6. Trade Statistics

| Metric         |      Result |
| -------------- | ----------: |
| Total Trades   |          86 |
| Total Deals    |         172 |
| Profit Trades  | 46 (53.49%) |
| Loss Trades    | 40 (46.51%) |
| Short Trades   |          46 |
| Short Win Rate |      52.17% |
| Long Trades    |          40 |
| Long Win Rate  |      55.00% |

The report shows 86 total trades, with 46 profitable trades and 40 losing trades.

---

## 7. Trade Size Distribution

| Metric               | Result |
| -------------------- | -----: |
| Largest Profit Trade |  $6.22 |
| Largest Loss Trade   | -$3.39 |
| Average Profit Trade |  $2.46 |
| Average Loss Trade   | -$2.06 |

The average winning trade was larger than the average losing trade in this test.

---

## 8. Consecutive Results

| Metric                     |  Result |
| -------------------------- | ------: |
| Maximum Consecutive Wins   |       6 |
| Maximum Consecutive Losses |       6 |
| Maximum Consecutive Profit |  $19.53 |
| Maximum Consecutive Loss   | -$13.30 |
| Average Consecutive Wins   |       2 |
| Average Consecutive Losses |       2 |

---

## 9. Holding Time

| Metric               |  Result |
| -------------------- | ------: |
| Minimum Holding Time | 0:00:01 |
| Maximum Holding Time | 0:16:15 |
| Average Holding Time | 0:01:45 |

---

## 10. Baseline Assessment

### Result: POSITIVE — RESEARCH BASELINE

The supplied test produced:

* Positive net profit
* Profit Factor above 1
* Positive Recovery Factor
* Positive Sharpe Ratio
* Low reported maximum drawdown
* Win rate above 50%

However, the test contains only **86 trades**.

Therefore:

`EA096-M1-BASELINE-001 = POSITIVE RESEARCH RESULT`

It is **not yet classified as production-ready**.

---

## 11. Baseline Rule

This configuration must remain unchanged as the reference baseline.

Future experiments should compare their results against:

`EA096-M1-BASELINE-001`

Do not overwrite the baseline result when testing new parameters.
