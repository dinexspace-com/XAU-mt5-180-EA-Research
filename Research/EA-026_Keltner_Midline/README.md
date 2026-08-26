# Research

Research notes and experiment tracking for the XAUUSD MT5 EA project.

The purpose of this directory is to record what has been learned from each EA implementation and its backtests before deciding whether the strategy should be improved, retested, or rejected.

---

# EA-026 — Keltner Midline

## Research Question

Can a simple Keltner midline trend-following rule produce a viable trading edge on XAUUSD?

The tested implementation uses:

```text
BUY:
Price > Midline
AND
Midline is rising

SELL:
Price < Midline
AND
Midline is falling
```

The current implementation effectively uses EMA midline direction and price position.

Although ATR and a Keltner multiplier exist in the EA parameters, the current entry logic does not use the upper or lower Keltner bands.

---

## Hypothesis

The initial hypothesis is:

> When price remains on the same side as a directional Keltner midline, short-term momentum may persist long enough to generate a positive trading expectancy.

The baseline test is intended to test this hypothesis without optimization.

---

# Baseline Experiment

## Configuration

```text
EA:          EA-026_Keltner_Midline
Symbol:      XAUUSD.PRO
Timeframe:   M1
Period:      2026.01.02 – 2026.02.01
Data:        100% real ticks
Deposit:     $1,000
Lot Size:    0.01
```

Core parameters:

```text
Stop Loss:           300 points
Take Profit:         600 points
Maximum Spread:       30 points

Break Even:          Enabled
BE Trigger:          150 points

Trailing Stop:       Enabled
Trailing Start:      200 points

Keltner Period:       20
Keltner Multiplier:  2.0
```

---

# Baseline Results

| Metric           |       Result |
| ---------------- | -----------: |
| Total Trades     |      `4,919` |
| Winning Trades   |     `48.16%` |
| Losing Trades    |     `51.84%` |
| Net Profit       |   `-$996.39` |
| Gross Profit     |  `$5,027.58` |
| Gross Loss       | `-$6,023.97` |
| Profit Factor    |       `0.83` |
| Expected Payoff  |     `-$0.20` |
| Sharpe Ratio     |      `-5.00` |
| Maximum Drawdown |     `99.65%` |

Result:

```text
BASELINE: FAIL
```

The baseline does not demonstrate a positive trading edge.

---

# Research Findings

## Finding 1 — Midline logic alone is insufficient

The current entry condition generates a very large number of signals:

```text
4,919 trades
```

during approximately one month of M1 testing.

Despite this sample size:

```text
Profit Factor   = 0.83
Expected Payoff = -$0.20
```

The tested midline-direction rule therefore did not demonstrate positive expectancy under this configuration.

---

## Finding 2 — Trade frequency is very high

Average position holding time:

```text
00:03:59
```

Minimum:

```text
00:00:02
```

Maximum:

```text
03:32:23
```

The EA behaves as a short-duration intraday system on M1.

The high number of entries suggests that the current signal reacts frequently to short-term price movement.

---

## Finding 3 — Realized payoff is unfavorable

Average winning trade:

```text
+$2.12
```

Average losing trade:

```text
-$2.36
```

Win rate:

```text
48.16%
```

Therefore:

```text
Average Win < Average Loss
AND
Win Rate < 50%
```

This combination produces negative expectancy.

---

## Finding 4 — BUY performs better than SELL by win rate

BUY:

```text
2,442 trades
50.12% won
```

SELL:

```text
2,477 trades
46.23% won
```

The difference is large enough to justify further investigation.

However, win rate alone is insufficient to conclude that BUY-only trading would be profitable.

A separate controlled backtest is required.

---

## Finding 5 — Drawdown invalidates the current configuration

Maximum drawdown:

```text
99.65%
```

Net result:

```text
-$996.39
```

from an initial:

```text
$1,000
```

The current configuration is therefore not suitable for live deployment.

---

## Finding 6 — MFE contains useful research information

The Strategy Tester reports:

```text
Correlation (Profit, MFE) = 0.95
Correlation (Profit, MAE) = 0.63
Correlation (MFE, MAE)    = 0.4908
```

The strong Profit/MFE correlation makes trade excursion behavior worth investigating.

This does not prove that changing the exit logic will improve performance.

It identifies a possible research direction that requires a controlled experiment.

---

# Main Problem Identified

The baseline indicates that the first research priority should be the **entry signal**, not parameter optimization.

The current strategy effectively asks:

```text
Is price above/below the EMA midline?

+

Is the EMA moving in the same direction?
```

This condition appears too permissive on XAUUSD M1 under the tested configuration.

It generates thousands of trades without demonstrating positive expectancy.

---

# Research Direction

The baseline should remain unchanged.

Future experiments should change **one major variable at a time** and compare the result against the baseline.

Baseline reference:

```text
Trades          = 4,919
Profit Factor   = 0.83
Expected Payoff = -0.20
Max Drawdown    = 99.65%
Net Profit      = -996.39
```

---

## Experiment 01 — BUY vs SELL

Research question:

```text
Does the negative expectancy originate primarily from SELL signals?
```

Test separately:

```text
A: BUY only
B: SELL only
```

Keep all other parameters unchanged.

Compare:

```text
Profit Factor
Expected Payoff
Net Profit
Maximum Drawdown
Number of Trades
Average Win
Average Loss
```

Do not conclude from win rate alone.

---

## Experiment 02 — Full Keltner Channel

Research question:

```text
Does using actual Keltner Channel structure improve signal quality?
```

The current EA exposes:

```text
Keltner Period
ATR
Keltner Multiplier
```

but entry decisions currently use only the midline.

A future version can test whether upper/lower channel information provides a useful entry filter.

This should be implemented as a separate EA version rather than silently changing the baseline EA.

---

## Experiment 03 — Trend Strength Filter

Research question:

```text
Can weak midline movements be filtered out?
```

The current logic only checks whether:

```text
Current Midline > Previous Midline
```

or:

```text
Current Midline < Previous Midline
```

It does not require a minimum slope magnitude.

A controlled experiment can test whether requiring stronger directional movement reduces low-quality entries.

---

## Experiment 04 — Time Filter

Research question:

```text
Is performance materially different by trading hour or session?
```

The Strategy Tester provides entry and profit/loss distributions by hour.

A future experiment can test session filtering if the underlying trade-level analysis demonstrates meaningful differences.

The filter should not be selected solely by visually choosing the best historical hours.

---

## Experiment 05 — Exit Logic

Only after the entry behavior is better understood should the exit system be isolated.

Potential variables:

```text
Fixed SL / TP
Break Even
Trailing Stop
```

The purpose is to determine how much of the negative expectancy originates from entries versus position management.

---

# Experiment Rules

To keep research results comparable:

1. Preserve the original baseline.
2. Change one major hypothesis at a time.
3. Record the exact EA version.
4. Record all input parameters.
5. Use reproducible Strategy Tester settings.
6. Save the complete Strategy Tester report.
7. Compare every experiment against the baseline.
8. Do not classify a strategy as successful based only on Net Profit.
9. Do not optimize parameters before establishing that the underlying logic has potential.
10. Do not use live trading until validation is completed.

---

# Current Research Status

```text
EA-026_Keltner_Midline
│
├── Implementation       DONE
│
├── Baseline Backtest    DONE
│
├── Baseline Result      FAIL
│
├── Positive Edge        NOT CONFIRMED
│
├── Main Issue           ENTRY QUALITY
│
└── Next Research        BUY vs SELL isolation
```

---

# Current Conclusion

The baseline experiment rejects the current form of the hypothesis:

> EMA/Keltner midline direction combined with price position is sufficient to produce a profitable XAUUSD M1 strategy.

Under the tested configuration, it is not.

The result should not yet be interpreted as proof that all Keltner-based approaches are ineffective.

It establishes only that **this implementation, with these parameters, on this symbol, timeframe, and test period, failed to demonstrate a positive edge**.

The next step is controlled experimentation rather than parameter optimization.
