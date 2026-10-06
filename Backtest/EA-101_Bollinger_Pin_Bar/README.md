# EA-101 — Bollinger Pin Bar — Baseline Backtest

## 1. Test Configuration

| Parameter         | Value                    |
| ----------------- | ------------------------ |
| Expert Advisor    | EA-101_Bollinger_Pin_Bar |
| Symbol            | XAUUSD.PRO               |
| Timeframe         | M1                       |
| Test Period       | 2026.01.02 – 2026.04.01  |
| Initial Deposit   | $1,000                   |
| Leverage          | 1:500                    |
| History Quality   | 100% real ticks          |
| Bars              | 86,539                   |
| Ticks             | 40,346,891               |
| Lot Size          | 0.01                     |
| Stop Loss         | 300 points               |
| Take Profit       | 600 points               |
| Break-even        | ON                       |
| Break-even Start  | 150 points               |
| Trailing Stop     | ON                       |
| Trailing Start    | 200 points               |
| Trailing Distance | 200 points               |
| Max Spread        | 30 points                |

---

## 2. Baseline Result

**Baseline ID:**

```text
EA101-M1-BASELINE-001
```

**Classification:**

```text
FAIL
```

### Performance

| Metric          |       Result |
| --------------- | -----------: |
| Net Profit      | **-$393.88** |
| Gross Profit    |    $3,545.03 |
| Gross Loss      |   -$3,938.91 |
| Profit Factor   |     **0.90** |
| Expected Payoff |   **-$0.12** |
| Recovery Factor |    **-0.94** |
| Sharpe Ratio    |    **-5.00** |
| Max Balance DD  |   **41.44%** |
| Max Equity DD   |   **41.62%** |

The baseline produced a negative return and a Profit Factor below 1.0.

---

## 3. Trading Statistics

| Metric                 |         Result |
| ---------------------- | -------------: |
| Total Trades           |          3,207 |
| Total Deals            |          6,414 |
| Profit Trades          | 1,584 (49.39%) |
| Loss Trades            | 1,623 (50.61%) |
| Short Trades           |          2,551 |
| Short Win Rate         |         49.78% |
| Long Trades            |            656 |
| Long Win Rate          |         47.87% |
| Largest Profit         |          $7.39 |
| Largest Loss           |        -$34.10 |
| Average Profit         |          $2.24 |
| Average Loss           |         -$2.43 |
| Max Consecutive Wins   |             10 |
| Max Consecutive Losses |             13 |
| Average Holding Time   |       00:03:04 |

---

## 4. Assessment

The baseline shows several negative characteristics:

1. **Net Profit is negative:** -$393.88.
2. **Profit Factor is below 1:** 0.90.
3. **Expected Payoff is negative:** -$0.12 per trade.
4. **Sharpe Ratio is negative:** -5.00.
5. **Maximum Equity Drawdown is high:** 41.62%.
6. **Win rate is below 50%:** 49.39%.
7. **Average loss exceeds average profit:** -$2.43 vs $2.24.
8. **Both directions are weak**, with BUY winning 47.87% and SELL winning 49.78%.

---

## 5. Baseline Decision

```text
Strategy Code: COMPLETE
Baseline Test: COMPLETE
Baseline Result: FAIL
Performance Validation: FAIL
Optimization: BLOCKED
OOS: NOT STARTED
Walk-Forward: NOT STARTED
Forward Test: NOT STARTED
Live Trading: NO
```

The baseline should **not** be used for live trading.

Research should first determine whether the Pin Bar definition, Bollinger interaction, entry confirmation, or exit structure is responsible for the negative expectancy.

---

## 6. Baseline Conclusion

EA-101 provides a sufficiently large sample of **3,207 trades** for initial evaluation, but the statistical and financial result is negative.

The next stage is therefore **controlled research**, not broad optimization.
