# Research — EA-072 Asian Range Break

## Research Objective

This research investigates whether a systematic breakout of the Asian trading range can provide a reproducible intraday trading edge for XAUUSD.

The research is associated with:

`EA-072_Asian_Range_Break`

The core hypothesis is:

> Price behavior after the Asian session may transition from a relatively bounded range into an expansion phase during later trading hours. A confirmed break of the Asian range may therefore contain information about subsequent short-term directional movement.

This repository does not assume that the hypothesis is profitable.

The hypothesis must be validated through historical testing, robustness testing, out-of-sample testing, and realistic execution assumptions.

---

## 1. Strategy Concept

The strategy divides the trading day into two primary phases:

```text
Phase 1
Asian Range Formation
        ↓
Measure session High / Low
        ↓
Phase 2
Post-Asian Trading Window
        ↓
Price breaks range
        ↓
Breakout confirmation
        ↓
Long / Short trade
```

For EA-072, the baseline implementation uses:

```text
Range Start = 00:00
Range End   = 08:00
Trade End   = 16:00
```

All hours are broker/server time.

The Asian range is defined as:

```text
Asian High = Highest High during range window
Asian Low  = Lowest Low during range window
```

After the range is complete:

```text
Close > Asian High + Buffer
→ potential LONG breakout

Close < Asian Low - Buffer
→ potential SHORT breakout
```

The implementation therefore belongs to the broader family of intraday range-breakout / momentum strategies.

---

## 2. Research Basis

### Opening Range Breakout

Opening Range Breakout (ORB) strategies attempt to capture directional price expansion after price crosses a predefined intraday range.

Holmberg, Lönnbark and Lundström studied mechanical Opening Range Breakout rules and described ORB as a strategy designed to identify large intraday movements by entering after price moves beyond a predetermined threshold.

Their empirical application found evidence that some ORB rules could produce positive results.

However, an important result of the study was that performance was not robust across all sub-periods.

This is directly relevant to EA-072:

A breakout pattern observed during one market regime cannot automatically be assumed to remain profitable in another regime.

Reference:

Ulf Holmberg, Carl Lönnbark, Christian Lundström  
"Assessing the profitability of intraday opening range breakout strategies"  
Finance Research Letters, Volume 10, Issue 1, 2013  
DOI: 10.1016/j.frl.2012.09.001

---

## 3. Contraction → Expansion Hypothesis

One theoretical interpretation of range breakout strategies is the transition between:

```text
Contraction
↓
Reduced price expansion / bounded range
↓
Breakout
↓
Expansion
↓
Potential directional continuation
```

The Opening Range Breakout literature discusses this in relation to the contraction-expansion principle.

EA-072 applies a related idea to a session boundary:

```text
Asian Session
Range Formation

        ↓

Post-Asian Session
Potential Expansion
```

This provides a plausible research hypothesis.

It does NOT establish profitability.

The actual existence and stability of the effect on XAUUSD must be measured empirically.

---

## 4. Why the Asian Range?

EA-072 does not trade during the range-building period.

Instead, the Asian session is used to establish reference levels:

```text
Asian High
Asian Low
```

The strategy then observes whether later price action escapes those boundaries.

The research question is therefore not simply:

> Does XAUUSD move during London or European hours?

The relevant question is:

> Conditional on XAUUSD breaking a previously established Asian-session range, does the subsequent price distribution provide sufficient continuation to overcome false breakouts, spread, slippage, and trading losses?

This distinction is important.

A market can exhibit increased volatility after a session transition without producing a profitable breakout strategy.

---

## 5. Breakout Confirmation

EA-072 uses completed M1 candles.

The baseline signal requires price to close outside the range rather than merely touch it.

Conceptually:

```text
Range High
────────────────────

       candle
         │
         │
         █
         █  ← close above range
         █
────────────────────
Range High

→ breakout confirmation
```

The equivalent logic applies below the Asian Low for short trades.

The purpose is to avoid treating every temporary penetration of the range as a valid breakout.

However, a candle-close confirmation alone does not guarantee that a breakout will continue.

False breakouts remain a primary research problem.

---

## 6. False Breakout Problem

A major potential weakness of range-breakout systems is:

```text
Price breaks range
        ↓
EA enters
        ↓
Price fails to continue
        ↓
Price returns inside range
        ↓
Stop / Break Even / small loss
```

This behavior is especially important for EA-072 because the baseline test generated a large number of trades but failed to produce positive expectancy.

Therefore, subsequent research should focus primarily on distinguishing:

```text
True expansion

vs.

Temporary range penetration / false breakout
```

rather than simply increasing trade frequency.

---

## 7. EA-072 Baseline Test

The current baseline test was performed using:

```text
EA:              EA-072_Asian_Range_Break
Symbol:          XAUUSD.PRO
Timeframe:       M1

Period:
2026-01-02
→
2026-03-31

Initial Deposit: $1,000
Leverage:        1:500
History Quality: 100% real ticks
```

Baseline configuration:

```text
Lot Size          = 0.01

Stop Loss         = 300 points
Take Profit       = 600 points

Breakout Lookback = 20
Breakout Buffer   = 0

Break Even        = ON
BE Trigger        = 150 points

Trailing Stop     = ON
Trailing Start    = 200 points
Trailing Distance = 100 points
Trailing Step     = 10 points

Range:
00:00 → 08:00

Trading Window:
08:00 → 16:00
```

---

## 8. Baseline Result

The baseline produced:

| Metric | Result |
|---|---:|
| Total Trades | 265 |
| Net Profit | -$50.08 |
| Profit Factor | 0.86 |
| Expected Payoff | -$0.19 |
| Winning Trades | 47.55% |
| Losing Trades | 52.45% |
| Long Win Rate | 49.35% |
| Short Win Rate | 45.05% |
| Maximum Balance Drawdown | 9.68% |
| Maximum Equity Drawdown | 9.92% |

Therefore:

```text
BASELINE EDGE
NOT CONFIRMED
```

The current implementation does not demonstrate positive expectancy over the tested period.

---

## 9. What the Baseline Tells Us

The result is useful even though it is negative.

The strategy generated:

```text
265 trades
```

during approximately three months.

This means the EA successfully produces enough breakout events to analyze.

However:

```text
Gross Profit = $295.64
Gross Loss   = -$345.72
```

and:

```text
Profit Factor = 0.86
```

Therefore the baseline breakout rule did not compensate for losing trades.

The immediate research problem is not:

```text
How do we increase the number of trades?
```

It is:

```text
Can low-quality breakout events be identified and removed
without destroying valid breakout opportunities?
```

---

## 10. Long vs Short

Baseline results:

```text
LONG

Trades   = 154
Win Rate = 49.35%


SHORT

Trades   = 111
Win Rate = 45.05%
```

The two directions did not perform identically during this sample.

However, this sample alone is insufficient to conclude that long breakouts possess a persistent structural advantage.

Required future test:

```text
Long only
vs.
Short only
vs.
Long + Short
```

across substantially longer and independent periods.

---

## 11. Trade Duration

Observed holding time:

```text
Minimum = 00:00:01
Average = 00:01:29
Maximum = 00:17:55
```

This is an important characteristic.

Although the range itself is constructed over several hours, actual positions are extremely short-lived.

Therefore EA-072 behaves operationally as a short-duration breakout system.

Future research must therefore pay particular attention to:

```text
spread
slippage
execution latency
broker stop constraints
tick quality
```

because execution costs can represent a meaningful portion of the expected return of short-duration trades.

---

## 12. MFE / MAE Evidence

The baseline MT5 report produced:

```text
Correlation (Profit, MFE) = 0.96

Correlation (Profit, MAE) = 0.71

Correlation (MFE, MAE) = 0.6159
```

MFE:

Maximum Favorable Excursion

MAE:

Maximum Adverse Excursion

The high Profit/MFE correlation indicates that favorable price excursion is strongly associated with realized trade profit in this sample.

This does not by itself establish a predictive signal.

It does suggest that excursion behavior should be examined when researching:

```text
Take Profit
Trailing Stop
Break Even
Exit timing
```

---

## 13. Current Research Hypotheses

The following hypotheses should be tested separately.

### H1 — Asian Range Size

Breakout quality may depend on the width of the Asian range.

Possible normalization:

```text
Asian Range Size
───────────────
ATR
```

Potential test:

```text
Very Narrow Range
Narrow Range
Normal Range
Wide Range
Very Wide Range
```

Question:

Does continuation probability change materially with normalized Asian range size?

---

### H2 — Breakout Distance

Baseline:

```text
Breakout Buffer = 0
```

Therefore even a small confirmed close beyond the range can generate a signal.

Test:

```text
Breakout Distance
=
Close − Range Boundary
```

normalized using:

```text
points

or

ATR
```

Question:

Does requiring stronger displacement reduce false breakouts?

---

### H3 — Time of Breakout

Current trading window is broad:

```text
08:00 → 16:00
```

The baseline entry-distribution evidence indicates that trades occur across multiple hours within this window.

Test breakout performance by hour.

Example research buckets:

```text
08:00–09:59
10:00–11:59
12:00–13:59
14:00–15:59
```

Question:

Is the breakout effect concentrated in a smaller time window?

---

### H4 — First Breakout vs Repeated Breakouts

The baseline EA can generate multiple breakout trades during the same trading day after previous positions close.

This creates the possibility of repeated entries around the same range boundary.

Research:

```text
First breakout only

vs.

Multiple breakout attempts
```

Question:

Do repeated attempts after an initial failed breakout have negative expectancy?

---

### H5 — Breakout Retest

Instead of entering immediately after a confirmed breakout:

```text
Breakout
↓
Wait
↓
Retest range boundary
↓
Continuation confirmation
↓
Entry
```

A retest filter could potentially reduce some false breakouts.

However, it can also remove valid momentum trades.

It must therefore be tested rather than assumed beneficial.

---

### H6 — Volatility Regime

A fixed breakout threshold behaves differently under different volatility conditions.

Potential volatility measurement:

```text
ATR
```

Research groups:

```text
Low Volatility
Normal Volatility
High Volatility
```

Question:

Does Asian Range Break performance depend on the prevailing volatility regime?

---

### H7 — Break Even

Baseline:

```text
Break Even Trigger = 150 points
```

Because average holding time is very short, Break Even may materially affect the realized return distribution.

Required comparison:

```text
No Break Even

vs.

Current Break Even

vs.

Alternative BE thresholds
```

The goal is to determine whether Break Even:

```text
reduces losses

or

prematurely removes trades that would later reach TP.
```

---

### H8 — Trailing Stop

Baseline:

```text
Trailing Start    = 200
Trailing Distance = 100
Trailing Step     = 10
```

Required comparison:

```text
Fixed SL/TP only

vs.

Break Even only

vs.

Trailing only

vs.

Break Even + Trailing
```

This separates entry quality from exit-management effects.

---

## 14. Research Priority

Research should proceed in this order:

```text
1. Establish longer baseline
        ↓
2. Separate Long / Short
        ↓
3. Analyze breakout time
        ↓
4. Analyze first vs repeated breakout
        ↓
5. Analyze Asian range size
        ↓
6. Analyze breakout displacement
        ↓
7. Test volatility normalization
        ↓
8. Test retest logic
        ↓
9. Optimize exits
        ↓
10. Out-of-sample validation
```

Entry logic should be investigated before aggressive SL/TP optimization.

Otherwise parameter optimization may simply fit exit parameters to weak entries.

---

## 15. Required Validation

A profitable optimization result alone is insufficient.

EA-072 should eventually pass:

```text
Baseline
    ↓
Parameter Research
    ↓
In-Sample Optimization
    ↓
Out-of-Sample Test
    ↓
Walk-Forward Test
    ↓
Different Market Regimes
    ↓
Execution Sensitivity
    ↓
Forward / Demo Test
```

Particular attention should be paid to regime stability because published ORB research has shown that breakout performance can vary materially across different historical sub-periods.

---

## 16. Overfitting Control

The research process must avoid selecting parameters simply because they maximize historical profit.

Do not optimize every variable simultaneously.

Preferred approach:

```text
One hypothesis
↓
One controlled experiment
↓
Record result
↓
Accept / Reject hypothesis
↓
Next experiment
```

Example:

```text
Question:

Does limiting EA-072 to the first breakout
improve expectancy?

Test:

A = Current baseline
B = First breakout only

Compare:

Trade Count
Net Profit
Profit Factor
Expected Payoff
Drawdown
Win Rate
Average Trade
```

Only after the hypothesis is tested should another structural variable be introduced.

---

## 17. Research Principles

The project follows these rules:

### Rule 1

A profitable backtest is not proof of future profitability.

### Rule 2

A negative backtest is still valid research evidence.

### Rule 3

Optimization and validation periods must be separated.

### Rule 4

Parameter robustness is more important than a single maximum-profit parameter combination.

### Rule 5

Execution assumptions must become progressively more realistic.

### Rule 6

Strategy modifications must have an explicit hypothesis.

### Rule 7

Failed experiments must be retained.

Negative results prevent the same failed ideas from being repeatedly tested.

---

## 18. Current Research Status

```text
Strategy:
EA-072 Asian Range Break

Implementation:
COMPLETED

Baseline Backtest:
COMPLETED

Baseline Edge:
NOT CONFIRMED

Optimization:
NOT VALIDATED

Out-of-Sample:
NOT TESTED

Walk-Forward:
NOT TESTED

Forward Test:
NOT TESTED
```

Current evidence does not support labeling EA-072 as a validated profitable trading system.

EA-072 remains a research strategy.

---

## 19. Next Research Question

The first structural question to investigate should be:

> Is the poor baseline performance caused partly by repeated breakout entries after the first breakout attempt of the day?

The controlled experiment should compare:

```text
A — Current EA
Multiple breakout attempts allowed

vs.

B — First Breakout Only
Maximum one breakout entry per trading day
```

All other parameters should remain unchanged.

This creates a clean experiment where only one strategy characteristic changes.

---

## References

### Academic Research

Holmberg, U., Lönnbark, C., & Lundström, C. (2013).

**Assessing the profitability of intraday opening range breakout strategies.**

Finance Research Letters, 10(1), 27–33.

DOI: 10.1016/j.frl.2012.09.001

Research relevance:

- mechanical intraday breakout rules;
- breakout thresholds;
- intraday momentum;
- contraction/expansion concept;
- profitability testing;
- regime instability.

### Project Evidence

EA-072 baseline evidence is stored in:

```text
/Backtest/EA-072_Asian_Range_Break/
```

EA implementation is stored in:

```text
/EAs/EA-072_Asian_Range_Break/
```

---

## Disclaimer

This research is intended for quantitative strategy development, software testing, and educational purposes.

Historical relationships, backtests, optimization results, and statistical patterns do not guarantee future trading performance.

All strategy hypotheses must be independently validated before any production use.
