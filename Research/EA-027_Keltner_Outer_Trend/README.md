# Research — EA-027 Keltner Outer Trend

## 1. Research Objective

This research evaluates whether a simple **Keltner Channel outer-band trend-following strategy** can produce a statistically useful trading edge on XAUUSD.

The current EA is treated as a **baseline implementation**.

The research process is:

```text
Strategy idea
    ↓
Baseline implementation
    ↓
Baseline backtest
    ↓
Identify weaknesses
    ↓
Create testable hypotheses
    ↓
Test one modification at a time
    ↓
Compare against baseline
```

The objective is not to optimize the EA immediately.

The objective is to determine whether the underlying strategy contains an exploitable edge before introducing additional complexity.

---

## 2. Strategy Hypothesis

The core hypothesis behind EA-027 is:

> When price moves outside the Keltner Channel, the movement may indicate sufficient directional momentum for price to continue in the breakout direction.

The baseline strategy therefore uses:

```text
Price > Upper Keltner Band → BUY
Price < Lower Keltner Band → SELL
```

with the Keltner Channel based on:

```text
EMA Period     = 20
ATR Multiplier = 2.0
```

The baseline uses fixed position sizing and fixed protective exits.

---

## 3. Baseline Configuration

The current research baseline was tested with:

| Parameter          |                   Value |
| ------------------ | ----------------------: |
| Symbol             |              XAUUSD.PRO |
| Timeframe          |                      M1 |
| Test Period        | 2026-01-02 → 2026-03-01 |
| Lot Size           |                    0.01 |
| Stop Loss          |              300 points |
| Take Profit        |              600 points |
| Maximum Spread     |               45 points |
| Maximum Positions  |                       1 |
| Break Even         |                Disabled |
| Trailing Stop      |                Disabled |
| Keltner Period     |                      20 |
| Keltner Multiplier |                     2.0 |

The test used a $1,000 account with 1:100 leverage and 100% real-tick history.

---

## 4. Baseline Results

| Metric          |       Result |
| --------------- | -----------: |
| Total Trades    |        2,595 |
| Net Profit      | **-$789.66** |
| Profit Factor   |     **0.86** |
| Expected Payoff |   **-$0.30** |
| Win Rate        |   **30.33%** |
| Loss Rate       |       69.67% |
| Average Profit  |        $6.35 |
| Average Loss    |       -$3.20 |
| Max Balance DD  |       87.24% |
| Max Equity DD   |   **87.47%** |
| Sharpe Ratio    |        -5.00 |
| Recovery Factor |        -0.83 |

The baseline generated negative net profit and extremely high drawdown.

Profit Factor was below 1 and Expected Payoff was negative.

Only 787 of 2,595 trades were profitable, producing a win rate of **30.33%**.

### Baseline Verdict

**FAIL**

The baseline configuration does not demonstrate a usable trading edge.

However, the baseline remains valuable as the reference point for all subsequent experiments.

---

# 5. What the Baseline Tells Us

## 5.1 Reward-to-Loss Structure Is Not the Primary Failure

Average trade results were:

```text
Average Winning Trade = +$6.35
Average Losing Trade  = -$3.20
```

The average winning trade is therefore approximately twice the magnitude of the average losing trade.

The primary problem is that profitable trades occur too infrequently:

```text
Win Rate  = 30.33%
Loss Rate = 69.67%
```

The current entry mechanism appears unable to select enough successful continuation moves to overcome the losing trades.

---

## 5.2 Breakout Frequency Is High

The EA generated:

```text
2,595 trades
```

during the tested period.

Combined with a loss rate of almost 70%, this creates an important research question:

> Is the EA treating too many ordinary movements outside the Keltner Channel as valid trend breakouts?

This is currently a **hypothesis**, not a confirmed cause.

---

## 5.3 BUY and SELL Behave Differently

Baseline results:

```text
BUY
Trades   = 1,193
Win Rate = 33.11%

SELL
Trades   = 1,402
Win Rate = 27.96%
```

BUY trades had a higher win rate than SELL trades.

However, the baseline report does not provide enough evidence to conclude that BUY-only trading is profitable.

BUY and SELL therefore need to be tested independently.

---

## 5.4 Losing Streak Risk Is Significant

The baseline recorded:

```text
Maximum consecutive wins   = 8
Maximum consecutive losses = 17

Average consecutive wins   = 1
Average consecutive losses = 3
```

This behavior is consistent with a strategy that encounters repeated failed breakout signals.

---

## 5.5 Holding Time Is Short

Position holding statistics:

```text
Minimum = 00:00:01
Average = 00:04:43
Maximum = 03:44:36
```

Most strategy activity is therefore short-duration relative to the overall test period.

This makes entry quality especially important because the strategy frequently reacts to short-term M1 price movements.

---

# 6. Main Research Problem

The current evidence points to one primary research problem:

> **The strategy needs to distinguish genuine trend continuation outside the Keltner Channel from low-quality or temporary outer-band movements.**

The next research stage should therefore focus first on **entry quality**, rather than immediately adding complex money management.

---

# 7. Research Hypotheses

The following hypotheses are generated from the baseline.

They have **not yet been validated**.

---

## H1 — Directional Asymmetry

### Hypothesis

BUY and SELL signals may have materially different expectancy.

### Evidence

```text
BUY win rate  = 33.11%
SELL win rate = 27.96%
```

### Test

Run two controlled backtests:

```text
Test H1-A → BUY only
Test H1-B → SELL only
```

Keep every other parameter identical to baseline.

### PASS

A direction shows materially better:

```text
Profit Factor
Expected Payoff
Drawdown
Net Profit
```

than baseline.

---

## H2 — Trend Filter

### Hypothesis

Some Keltner outer-band signals occur without sufficient broader trend confirmation.

A simple trend filter may reduce false breakouts.

### Candidate Test

Example:

```text
BUY:
Price > Upper Keltner
AND
Trend Filter = Bullish

SELL:
Price < Lower Keltner
AND
Trend Filter = Bearish
```

Only **one simple trend filter** should be introduced in the first experiment.

### Goal

Reduce low-quality trades without destroying profitable breakout opportunities.

---

## H3 — Stronger Breakout Requirement

### Hypothesis

Crossing the outer Keltner band alone may be too permissive.

Instead of:

```text
Price > Upper Band
```

test a stronger requirement such as:

```text
Price > Upper Band + additional threshold
```

and equivalent logic for SELL.

### Goal

Reduce weak outer-band signals.

---

## H4 — Time / Session Filter

### Hypothesis

Keltner breakout performance may differ depending on trading hour or market session.

### Test

Analyze and compare:

```text
Asia
Europe / London
US / New York
```

or specific trading-hour windows.

### Goal

Determine whether losing signals are concentrated during particular periods.

No session should be removed until the data confirms that doing so improves the strategy.

---

## H5 — Exit Structure

### Hypothesis

The current fixed:

```text
SL = 300 points
TP = 600 points
```

may not match the distribution of XAUUSD M1 price excursions.

The Strategy Tester reported:

```text
Correlation (Profit, MFE) = 0.84
Correlation (Profit, MAE) = 0.74
```

### Test

Only after entry-quality experiments, evaluate alternative SL/TP structures.

Possible variables:

```text
Stop Loss
Take Profit
ATR-based exit
Break Even
Trailing Stop
```

These should not initially be optimized simultaneously.

---

# 8. Experiment Priority

Research should proceed in this order:

```text
BASELINE
   │
   ├── H1 — BUY vs SELL
   │
   ├── H2 — Trend Filter
   │
   ├── H3 — Stronger Breakout
   │
   ├── H4 — Session / Time Filter
   │
   └── H5 — Exit Optimization
```

Priority should be given to improving the **strategy signal** before optimizing trade management.

---

# 9. Experimental Rule

Only **one major variable should be changed at a time**.

Example:

```text
Baseline
vs
Baseline + Trend Filter
```

is valid.

Testing:

```text
New Trend Filter
+ New Keltner Period
+ New SL
+ New TP
+ Session Filter
```

simultaneously would make it difficult to determine which change caused the result.

---

# 10. Evaluation Metrics

Every experiment should be compared against the same baseline using at least:

| Metric          | Baseline |
| --------------- | -------: |
| Net Profit      | -$789.66 |
| Profit Factor   |     0.86 |
| Expected Payoff |   -$0.30 |
| Win Rate        |   30.33% |
| Max Equity DD   |   87.47% |
| Total Trades    |    2,595 |

A modification is not considered successful merely because Net Profit improves.

The full risk/return profile must be evaluated.

---

# 11. Research PASS / FAIL

## Minimum Research PASS

A candidate should demonstrate:

```text
Profit Factor > 1.0
Expected Payoff > 0
Net Profit > 0
```

while materially reducing the extreme baseline drawdown.

This only means the experiment is worth further validation.

It does **not** mean the EA is ready for live trading.

---

## FAIL

An experiment fails when it:

* remains negative expectancy;
* improves profit only by taking unacceptable additional risk;
* produces excessive drawdown;
* relies on an extremely small number of trades;
* or does not materially improve the baseline.

Failed experiments should still be documented.

A failed experiment provides information about what does **not** improve the strategy.

---

# 12. Research Discipline

The research process should remain:

```text
1. Define hypothesis
2. Modify one major variable
3. Backtest
4. Save report
5. Compare with baseline
6. Record evidence
7. PASS / FAIL
8. Only then open the next experiment
```

Do not modify the production/reference EA simply because an experimental configuration looks better.

Promising results require further validation before acceptance.

---

# 13. Current Research Status

```text
EA-027_Keltner_Outer_Trend

Baseline implementation       COMPLETE
Baseline real-tick backtest    COMPLETE
Baseline assessment            FAIL

H1 Directional test            PENDING
H2 Trend filter                PENDING
H3 Breakout threshold          PENDING
H4 Session filter              PENDING
H5 Exit optimization           PENDING
```

---

# 14. Current Conclusion

The first baseline test does **not** support deploying EA-027 in its current configuration.

The important result is not simply that the EA lost money.

The baseline has established measurable reference values and identified the main research direction:

> **Improve Keltner outer-band entry quality and determine whether the strategy contains a recoverable directional trend-following edge before adding further complexity.**

The next controlled experiment should isolate the BUY and SELL sides of the strategy before changing the underlying entry logic.

---

## Disclaimer

This repository documents quantitative strategy research and experimental backtesting.

Backtest results do not guarantee future performance and should not be interpreted as financial advice or evidence that a strategy is suitable for live trading.
