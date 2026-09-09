# EA-050 — 50-Bar Donchian Breakout Backtest

## Overview

This directory contains MetaTrader 5 Strategy Tester results for:

**EA-050_50-Bar_Donchian**

The purpose of this backtest is to establish an initial baseline before parameter optimization and further robustness testing.

---

## Test Configuration

| Setting         | Value                   |
| --------------- | ----------------------- |
| Expert Advisor  | EA-050_50-Bar_Donchian  |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M5                      |
| Test Period     | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000                  |
| Leverage        | 1:500                   |
| History Quality | 100% real ticks         |
| Bars            | 17,327                  |
| Ticks           | 40,346,891              |
| Lot Size        | 0.01                    |

---

## EA Parameters

| Parameter          |      Value |
| ------------------ | ---------: |
| Donchian Period    |         50 |
| Maximum Spread     |  30 points |
| Stop Loss          | 300 points |
| Take Profit        | 600 points |
| Break Even         |    Enabled |
| Break Even Trigger | 150 points |
| Trailing Stop      |    Enabled |
| Trailing Start     | 200 points |
| Slippage           |  10 points |
| Magic Number       |     123456 |

---

# Baseline Results

| Metric                   |         Result |
| ------------------------ | -------------: |
| Initial Deposit          |      $1,000.00 |
| Final Balance            |      $1,008.57 |
| Total Net Profit         |         +$8.57 |
| Gross Profit             |         $49.59 |
| Gross Loss               |        -$41.02 |
| Profit Factor            |           1.21 |
| Expected Payoff          |          $0.43 |
| Recovery Factor          |           0.43 |
| Total Trades             |             20 |
| Winning Trades           |     9 (45.00%) |
| Losing Trades            |    11 (55.00%) |
| Maximum Balance Drawdown | $16.27 (1.60%) |
| Maximum Equity Drawdown  | $19.73 (1.93%) |

---

## Long / Short Performance

### Long Trades

```text
15 trades
Win rate: 53.33%
```

### Short Trades

```text
5 trades
Win rate: 20.00%
```

The baseline sample shows substantially different results between long and short positions.

This observation is recorded for later research and must not yet be treated as evidence that SELL trades should be disabled because the sample size is small.

---

## Trade Statistics

### Winning Trades

```text
9 / 20
45.00%
```

Average winning trade:

```text
+$5.51
```

Largest winning trade:

```text
+$6.41
```

Maximum consecutive wins:

```text
3 trades
+$18.05
```

### Losing Trades

```text
11 / 20
55.00%
```

Average losing trade:

```text
-$3.73
```

Largest losing trade:

```text
-$8.69
```

Maximum consecutive losses:

```text
5 trades
-$16.27
```

---

## Holding Time

| Metric               |   Result |
| -------------------- | -------: |
| Minimum Holding Time | 00:00:01 |
| Average Holding Time | 00:02:06 |
| Maximum Holding Time | 00:07:07 |

The baseline implementation therefore produced very short holding periods during this test.

---

## MFE / MAE Statistics

MT5 reported:

```text
Correlation (Profit, MFE): 0.91
Correlation (Profit, MAE): 0.77
Correlation (MFE, MAE):   0.6840
```

These statistics are retained as baseline diagnostic information for later comparison.

---

# Initial Observation

The baseline test produced:

```text
Net Profit:      +$8.57
Profit Factor:    1.21
Max Equity DD:    1.93%
Trades:           20
```

The EA therefore finished the tested period with a positive net result and relatively low reported drawdown.

However:

```text
20 trades
```

is not sufficient evidence to establish robustness or a reliable trading edge.

The baseline result should therefore be treated as:

**INITIAL RESEARCH EVIDENCE ONLY**

and not as a final validation of the strategy.

---

## Important Observation — Direction

The baseline contains:

```text
Long:
15 trades
53.33% win rate

Short:
5 trades
20.00% win rate
```

This difference should be investigated in subsequent research.

Possible follow-up tests may compare:

```text
BUY + SELL
BUY only
SELL only
```

No directional filter should be accepted solely from this baseline result.

---

# Research Status

```text
Baseline implementation:      COMPLETE
Baseline backtest:            COMPLETE
Parameter optimization:       PENDING
Extended-period test:         PENDING
Out-of-sample validation:     PENDING
Robustness testing:           PENDING
Final strategy conclusion:    PENDING
```

---

# Baseline Verdict

## PASS — Execution Baseline

The EA successfully:

* generated trades;
* executed both BUY and SELL signals;
* applied SL/TP;
* completed the Strategy Tester run;
* produced a positive baseline result;
* generated a complete MT5 report using 100% real tick history.

This PASS only confirms that a usable baseline backtest exists.

It does **not** mean the trading strategy itself has passed final research validation.

---

# Current Research Conclusion

```text
Strategy status:

PROMISING BASELINE
BUT INSUFFICIENT SAMPLE
```

The next research stage should determine whether the observed result survives parameter variation and a larger number of trades.

No production or profitability claim is made from this baseline backtest.
