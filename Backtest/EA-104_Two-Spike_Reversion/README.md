# EA-104 — Two-Spike Reversion

## Baseline Backtest

### Baseline ID

`EA104-M1-BASELINE-001`

---

## Test Configuration

| Item                 | Value                      |
| -------------------- | -------------------------- |
| Expert Advisor       | EA-104_Two-Spike_Reversion |
| Symbol               | XAUUSD.PRO                 |
| Timeframe            | M1                         |
| Test Period          | 2026.01.02 – 2026.04.01    |
| Initial Deposit      | $1,000                     |
| Leverage             | 1:500                      |
| History Quality      | 100% real ticks            |
| Bars                 | 86,539                     |
| Ticks                | 40,346,891                 |
| Lot Size             | 0.01                       |
| Stop Loss            | 300 points                 |
| Take Profit          | 600 points                 |
| ATR Period           | 14                         |
| Spike ATR Multiplier | 1.5                        |
| Break Even           | ON                         |
| Break Even Start     | 150 points                 |
| Trailing Stop        | ON                         |
| Trailing Start       | 200 points                 |
| Trailing Distance    | 200 points                 |

---

## Baseline Results

| Metric          |       Result |
| --------------- | -----------: |
| Net Profit      | **-$129.77** |
| Gross Profit    |      $656.62 |
| Gross Loss      |     -$786.39 |
| Profit Factor   |     **0.83** |
| Expected Payoff |   **-$0.22** |
| Recovery Factor |    **-0.78** |
| Sharpe Ratio    |    **-5.00** |
| Max Balance DD  |       15.76% |
| Max Equity DD   |   **16.08%** |
| Total Trades    |          590 |
| Total Deals     |        1,180 |

## The baseline results are taken directly from the MT5 Strategy Tester report.

## Trade Statistics

| Metric                     |       Result |
| -------------------------- | -----------: |
| Profit Trades              | 282 / 47.80% |
| Loss Trades                | 308 / 52.20% |
| Long Trades                |          385 |
| Long Win Rate              |       48.83% |
| Short Trades               |          205 |
| Short Win Rate             |       45.85% |
| Largest Profit Trade       |        $7.67 |
| Largest Loss Trade         |       -$7.36 |
| Average Profit Trade       |        $2.33 |
| Average Loss Trade         |       -$2.55 |
| Maximum Consecutive Wins   |            7 |
| Maximum Consecutive Losses |            9 |
| Average Holding Time       |     00:02:06 |

## The trade distribution and trade-quality statistics are reported by the Strategy Tester.

## Baseline Assessment

### Classification

**FAIL**

### Evidence

The baseline fails the primary profitability criteria:

* Net Profit is negative.
* Profit Factor is below 1.00.
* Expected Payoff is negative.
* Recovery Factor is negative.
* Sharpe Ratio is negative.
* Loss trades exceed profit trades.
* Average loss is larger than average profit.
* Maximum Equity Drawdown reaches 16.08%.

Therefore, the current configuration does not provide sufficient evidence of a positive trading edge.

---

## Research Decision

| Area                                   | Decision    |
| -------------------------------------- | ----------- |
| Baseline preserved                     | YES         |
| Strategy accepted for further research | YES         |
| Live trading validation                | NO          |
| Broad optimization                     | BLOCKED     |
| Controlled research                    | ALLOWED     |
| OOS validation                         | NOT STARTED |
| Robustness testing                     | NOT STARTED |
| Walk-forward testing                   | NOT STARTED |

---

## Conclusion

EA-104 does not pass the baseline profitability test.

The result should **not** be interpreted as proof that the Two-Spike Reversion concept is permanently invalid.

The correct research conclusion is:

> The current baseline configuration failed to demonstrate a positive edge over the tested sample.

Further work must determine whether the failure originates from:

* spike definition,
* ATR threshold,
* reversal confirmation,
* directional asymmetry,
* exit structure,
* trading session,
* or market-regime dependency.

No live deployment should be performed from this baseline.
