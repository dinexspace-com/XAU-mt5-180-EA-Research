# EA-047 — 5 Bar Range Break — Research

## Research Objective

This document records the research findings for:

**EA-047 — 5 Bar Range Break**

The objective is to determine why the original 5-bar breakout strategy produced negative expectancy on XAUUSD M5 and to define controlled experiments that can be tested individually.

The research process follows this sequence:

Baseline → Identify Weakness → Form Hypothesis → Modify One Variable → Backtest → Compare → Accept / Reject

No modification is considered an improvement until it produces reproducible backtest evidence.

---

## 1. Baseline Strategy

EA-047 implements a simple rolling-range breakout.

For each new candle, the EA calculates:

Highest = Highest High of previous 5 completed bars

Lowest = Lowest Low of previous 5 completed bars

Entry rules:

BUY:

Ask > Highest High

SELL:

Bid < Lowest Low

Baseline configuration:

Symbol: XAUUSD.PRO

Timeframe: M5

Period: 2026.01.02 — 2026.04.01

Bars Count: 5

Lot Size: 0.01

Stop Loss: 300 points

Take Profit: 600 points

Break Even: Disabled

Trailing Stop: Disabled

Maximum Spread: 35 points

Initial Deposit: $1,000

Leverage: 1:500

History Quality: 100% real ticks

The strategy therefore represents a minimal price breakout model without trend, volatility, session, momentum, or breakout-confirmation filters.

---

## 2. Baseline Backtest Result

The baseline produced:

Total Trades: 424

Winning Trades: 130 (30.66%)

Losing Trades: 294 (69.34%)

Long Trades: 382

Short Trades: 42

Long Win Rate: 30.89%

Short Win Rate: 28.57%

Gross Profit: $840.59

Gross Loss: -$930.29

Net Profit: -$89.70

Profit Factor: 0.90

Expected Payoff: -$0.21

Maximum Balance Drawdown: 13.02%

Maximum Equity Drawdown: 13.18%

Recovery Factor: -0.65

Sharpe Ratio: -5.00

Maximum Consecutive Losses: 19

Average Profit Trade: $6.47

Average Loss Trade: -$3.16

Largest Profit Trade: $47.71

Largest Loss Trade: -$8.69

Baseline verdict:

**FAIL**

The strategy successfully generates and executes breakout trades, but the tested configuration does not demonstrate positive expectancy.

---

## 3. Primary Finding

The most important baseline observation is:

**The average winning trade is substantially larger than the average losing trade, but the win rate is too low.**

Average Profit Trade:

$6.47

Average Loss Trade:

-$3.16

Approximate realized payoff ratio:

6.47 / 3.16 ≈ 2.05

This is consistent with the strategy's nominal 1:2 Stop Loss / Take Profit structure.

However:

Win Rate = 30.66%

Loss Rate = 69.34%

The strategy therefore does not primarily suffer from winners being too small.

The first research priority should be:

**improving entry quality and reducing low-quality breakout trades without destroying the payoff advantage.**

This is more logical than immediately changing Take Profit or aggressively modifying trade management.

---

## 4. Break-Even Win Rate Analysis

With an approximate reward/risk ratio of 2:1, the theoretical break-even win rate before trading costs is approximately:

Break-even Win Rate = 1 / (1 + 2)

≈ 33.33%

Observed win rate:

30.66%

Difference:

≈ -2.67 percentage points

This is important.

EA-047 is not extremely far from the theoretical break-even threshold implied by a 2:1 payoff structure.

However, real trading includes:

Spread

Slippage

Execution differences

Commission where applicable

Therefore, achieving only 33.33% would not necessarily create a robust live strategy.

A meaningful improvement should push expectancy clearly above zero rather than merely reaching mathematical break-even.

---

## 5. Core Weakness — False Breakouts

The baseline entry rule is extremely permissive.

A trade can occur simply because:

Ask > previous 5-bar high

or:

Bid < previous 5-bar low

There is no requirement for:

Breakout distance

Candle close confirmation

Momentum confirmation

Volatility expansion

Trend confirmation

Retest

Minimum range quality

Session selection

This makes the strategy vulnerable to situations where price briefly exceeds the previous range and immediately reverses.

These events are commonly described as:

**False Breakouts**

or:

**Whipsaws**

Breakout research commonly addresses this problem by adding confirmation rather than treating every penetration of support or resistance as a valid breakout.

ATR-based breakout confirmation is one established approach because ATR provides a volatility-relative threshold rather than requiring only a minimal price penetration.

Another approach is breakout-and-retest confirmation, where price must first break the level and subsequently demonstrate that the broken level can hold.

For EA-047 these techniques are research candidates only.

They have not yet been demonstrated to improve this specific strategy.

---

## 6. Research Hypothesis H1 — Breakout Confirmation Distance

### Problem

Current entry:

Price > Range High

or:

Price < Range Low

A tiny penetration can therefore trigger an entry.

### Hypothesis

Require price to exceed the range by an additional confirmation distance.

Example:

BUY:

Ask > Highest + BreakoutBuffer

SELL:

Bid < Lowest - BreakoutBuffer

Possible implementation:

BreakoutBufferPoints

or preferably:

BreakoutBuffer = ATR × multiplier

### Reason

A volatility-adjusted buffer may reject small penetrations caused by market noise.

### Variables to Test

Breakout Buffer:

0

0.10 ATR

0.20 ATR

0.30 ATR

0.50 ATR

### Primary Metrics

Profit Factor

Expected Payoff

Net Profit

Trade Count

Win Rate

Maximum Drawdown

### PASS Condition

The filter must improve expectancy without reducing the trade sample to an unusably small number.

---

## 7. Research Hypothesis H2 — Candle Close Confirmation

### Problem

The baseline strategy does not require a completed candle to establish that price remained outside the breakout boundary.

### Hypothesis

Require a completed M5 candle to close beyond the 5-bar range.

BUY:

Close[1] > PreviousRangeHigh

SELL:

Close[1] < PreviousRangeLow

Optional stronger condition:

Close[1] > PreviousRangeHigh + Buffer

or:

Close[1] < PreviousRangeLow - Buffer

### Reason

A wick beyond resistance/support may represent a temporary liquidity sweep rather than a sustained breakout.

Waiting for a close may reject part of these events.

### Trade-Off

Confirmation occurs later.

Therefore:

Entry price may worsen.

Reward potential may decrease.

Some valid fast breakouts may be missed.

The hypothesis must therefore be tested rather than assumed to be superior.

---

## 8. Research Hypothesis H3 — ATR Volatility Filter

ATR measures recent market range and can be used to determine whether current volatility is sufficient to support a breakout.

Research on automated breakout systems frequently combines breakout logic with ATR-based volatility confirmation.

Possible condition:

ATR(current) > ATR average

Alternative:

Breakout Candle Range > ATR × threshold

Alternative:

Breakout Distance > ATR × threshold

### Candidate Test

ATR Period:

14

Test volatility threshold:

ATR / ATR_MA > 0.8

ATR / ATR_MA > 1.0

ATR / ATR_MA > 1.2

### Research Question

Do EA-047 breakouts perform better when volatility is expanding?

This must be answered through backtesting.

---

## 9. Research Hypothesis H4 — Trend Strength Filter

Breakout strategies can behave differently in trending and ranging environments.

A possible trend-strength measure is:

ADX

Candidate rule:

Only allow breakout when:

ADX(14) > threshold

Possible thresholds:

20

25

30

ADX does not determine trade direction by itself.

It measures trend strength.

The breakout direction would still come from the 5-bar range.

### Research Question

Does excluding weak-trend environments reduce false breakouts enough to improve expectancy?

### Warning

A strict ADX filter may enter too late because trend strength can increase only after the breakout has already started.

Therefore ADX should be tested independently.

---

## 10. Research Hypothesis H5 — Directional Trend Filter

The baseline generated:

Long Trades: 382

Short Trades: 42

Approximately:

90% Long

10% Short

This extreme directional imbalance deserves investigation.

Possible explanation:

The historical test period may have contained a strong bullish gold regime.

The strategy may therefore be responding heavily to underlying directional market structure.

A simple directional filter can be tested.

Example:

EMA 200

BUY only when:

Price > EMA200

SELL only when:

Price < EMA200

Alternative:

EMA50 vs EMA200

BUY:

EMA50 > EMA200

SELL:

EMA50 < EMA200

### Research Question

Can trend alignment remove counter-trend breakouts and improve expectancy?

This hypothesis should be tested separately from ATR and ADX.

---

## 11. Research Hypothesis H6 — Range Size Filter

Not every 5-bar range has the same meaning.

A very small range may produce frequent noise breakouts.

A very large range may require excessive movement before continuation becomes worthwhile.

Define:

RangeSize = Highest - Lowest

Normalize:

NormalizedRange = RangeSize / ATR

Candidate filtering:

Minimum Range / ATR

Maximum Range / ATR

Example research grid:

Minimum:

0.5 ATR

1.0 ATR

1.5 ATR

Maximum:

2 ATR

3 ATR

4 ATR

### Research Question

Is there a specific range-width regime where the 5-bar breakout has positive expectancy?

---

## 12. Research Hypothesis H7 — Number of Range Bars

The number 5 is currently fixed as the baseline strategy concept.

There is no evidence yet that 5 bars is optimal for XAUUSD M5.

Candidate tests:

3 bars

5 bars

8 bars

10 bars

12 bars

15 bars

20 bars

Shorter ranges:

More signals

More sensitivity

Potentially more noise

Longer ranges:

Fewer signals

More significant breakout levels

Potentially later entries

### Important

This test should not be combined initially with other filters.

First determine whether the breakout lookback itself contains useful structure.

---

## 13. Research Hypothesis H8 — Time-of-Day Filter

The Strategy Tester distribution demonstrates that trades occur throughout many hours of the day.

Gold volatility and liquidity are not constant throughout the 24-hour trading cycle.

Therefore performance should be decomposed by hour.

Research groups:

Asia

London

New York

London / New York overlap

Instead of immediately imposing session assumptions, calculate:

Trades per hour

Win Rate per hour

Net Profit per hour

Profit Factor per hour

Expected Payoff per hour

Maximum Drawdown contribution

### Objective

Identify whether specific hours consistently destroy expectancy.

Only after this analysis should a session filter be introduced.

---

## 14. Research Hypothesis H9 — Day-of-Week Filter

Trades occurred from Sunday through Friday in the baseline report.

The entry-frequency chart alone is not enough to determine whether a weekday is good or bad.

Frequency ≠ profitability.

Research should calculate:

Monday Profit Factor

Tuesday Profit Factor

Wednesday Profit Factor

Thursday Profit Factor

Friday Profit Factor

and corresponding:

Trade Count

Win Rate

Net Profit

Expected Payoff

If a weekday repeatedly shows materially negative expectancy, exclusion can then be tested.

---

## 15. Research Hypothesis H10 — Break Even

Baseline:

Break Even = Disabled

EA-047 already contains Break Even functionality.

Therefore this is a low-cost experiment.

Candidate configurations:

BE OFF

Trigger 100 / Lock 0

Trigger 150 / Lock 0

Trigger 200 / Lock 0

Trigger 250 / Lock 0

### Research Question

Can Break Even reduce losing trades without prematurely terminating trades that would otherwise reach Take Profit?

Because the strategy relies on winners being approximately twice the size of losers, overly aggressive Break Even could damage expectancy.

Therefore:

Do not assume Break Even improves the system.

Backtest it.

---

## 16. Research Hypothesis H11 — Trailing Stop

Baseline:

Trailing Stop = Disabled

EA already contains trailing functionality.

Candidate experiment:

Trailing OFF

versus controlled trailing configurations.

### Risk

The baseline's primary strength is its relatively large winning trades.

Trailing too aggressively may reduce:

Average Profit Trade

Largest Winners

Effective Reward/Risk

Therefore trailing should be evaluated only after entry-quality experiments.

Priority:

LOWER than false-breakout research.

---

## 17. Research Hypothesis H12 — Stop Loss / Take Profit

Baseline:

SL = 300

TP = 600

Nominal R:R:

1:2

Realized average:

Average Win = $6.47

Average Loss = $3.16

≈ 2.05:1

This suggests the basic payoff structure is functioning approximately as intended.

Therefore SL/TP optimization should NOT be the first research task.

It should occur after improving entry quality.

Candidate future test:

SL:

200

250

300

350

400

TP multiplier:

1.5R

2.0R

2.5R

3.0R

Prefer eventually normalizing stops using ATR instead of relying exclusively on fixed points.

---

## 18. Priority Ranking

Research should proceed in the following order.

### Priority 1 — Entry Quality

1. Breakout Close Confirmation

2. Breakout Buffer

3. ATR Volatility Confirmation

Reason:

The baseline's clearest weakness is the high frequency of losing breakout entries.

---

### Priority 2 — Market Regime

4. Range Size / ATR

5. Directional Trend Filter

6. ADX Trend Strength

Reason:

Breakouts are unlikely to behave identically across ranging and trending environments.

---

### Priority 3 — Time Structure

7. Hour / Session Analysis

8. Weekday Analysis

Reason:

The baseline trades across many market conditions and times.

Removing consistently poor periods could improve expectancy without changing the core strategy.

---

### Priority 4 — Core Parameter

9. Bars Count

Reason:

The assumption that five candles provide the best breakout boundary has not yet been validated.

---

### Priority 5 — Exit Optimization

10. Break Even

11. Trailing Stop

12. SL / TP Optimization

Reason:

Exit optimization should not be used to hide fundamentally poor entry quality.

---

## 19. Recommended First Experiment

The first modification should be:

**Candle Close Breakout Confirmation**

Reason:

It directly targets the suspected false-breakout problem.

It requires minimal code modification.

It introduces only one new conceptual variable.

It can be compared directly against the baseline.

Baseline:

Price penetration → Entry

Experiment:

Completed candle close beyond range → Entry

Everything else must remain unchanged.

Symbol:

XAUUSD.PRO

Timeframe:

M5

Period:

2026.01.02 — 2026.04.01

Lot:

0.01

SL:

300

TP:

600

Break Even:

OFF

Trailing:

OFF

Max Spread:

35

Bars Count:

5

This creates a clean A/B test.

---

## 20. Experiment Acceptance Criteria

Each modification must be compared against baseline:

Baseline:

Trades = 424

Net Profit = -$89.70

Profit Factor = 0.90

Expected Payoff = -$0.21

Win Rate = 30.66%

Max Equity DD = 13.18%

Average Win = $6.47

Average Loss = -$3.16

A modification should not be accepted merely because Net Profit improves.

Evaluation must include:

Profit Factor

Expected Payoff

Trade Count

Maximum Drawdown

Win Rate

Average Win

Average Loss

Long / Short distribution

Equity curve

Result stability

---

## 21. Overfitting Control

Optimization presents a major risk.

Testing many parameters against the same three-month historical sample can produce configurations that appear profitable by chance.

Therefore:

Do not search thousands of combinations immediately.

Use economically meaningful parameter values.

Change one component at a time.

Record every experiment.

Do not delete failed tests.

After identifying a candidate configuration, test it on unseen data.

Recommended structure:

Development Period

→ Find hypothesis

Validation Period

→ Confirm hypothesis

Out-of-Sample Period

→ Final verification

Only configurations surviving unseen data should progress.

---

## 22. Required Future Validation

The current baseline covers approximately three months.

This is sufficient for initial diagnosis but not sufficient for declaring a robust XAUUSD trading strategy.

Any promising variant should later be tested across:

Different market regimes

Longer historical periods

Bullish gold periods

Bearish gold periods

High-volatility periods

Low-volatility periods

Different spreads

Different execution conditions

Out-of-sample data

Only then should forward testing be considered.

---

## 23. Research Roadmap

EA-047

↓

Baseline Backtest

↓

FAIL

↓

Diagnose Entry Quality

↓

Test Close Confirmation

↓

Test Breakout Buffer

↓

Test ATR Filter

↓

Analyze Range Regime

↓

Test Trend Filter

↓

Analyze Sessions

↓

Analyze Weekdays

↓

Test Bars Count

↓

Optimize Exit Logic

↓

Out-of-Sample Validation

↓

Forward Test

↓

Candidate Strategy

---

## 24. Current Research Status

Strategy implementation:

COMPLETE

Baseline backtest:

COMPLETE

Baseline result:

FAIL

Root-cause research:

COMPLETE — INITIAL

Primary suspected weakness:

LOW BREAKOUT ENTRY QUALITY / FALSE BREAKOUT EXPOSURE

First experiment selected:

CANDLE CLOSE BREAKOUT CONFIRMATION

Optimization:

NOT STARTED

Out-of-Sample Test:

NOT STARTED

Forward Test:

NOT STARTED

Live Validation:

NOT STARTED

---

## 25. Research Conclusion

EA-047 demonstrates that the basic 5-bar breakout concept can generate a large number of mechanically reproducible XAUUSD M5 trades.

However, the baseline configuration does not currently demonstrate a tradable statistical edge.

The central finding is:

**The payoff structure is reasonably favorable, but the strategy loses too frequently.**

Average profitable trade:

$6.47

Average losing trade:

-$3.16

but only:

30.66%

of trades were profitable.

Therefore the immediate research objective should not be maximizing profit through parameter optimization.

It should be:

**reduce low-quality breakout entries while preserving the strategy's favorable winner-to-loser payoff relationship.**

The highest-priority research path is therefore:

Breakout Confirmation

→ Volatility Confirmation

→ Market Regime Filtering

→ Session Analysis

→ Exit Optimization

The first controlled experiment will test candle-close confirmation while keeping all other baseline parameters unchanged.

No research hypothesis described in this document is considered validated until supported by new backtest evidence.

---

## External Research References

The following external concepts were reviewed only to identify testable hypotheses for EA-047.

MQL5 research on ATR breakout confirmation describes using volatility-relative thresholds to distinguish stronger breakouts from small penetrations of support or resistance.

MQL5 volatility-breakout research also identifies static breakout systems as vulnerable to false signals and demonstrates the use of ATR-based adaptive filters.

MQL5 Opening Range Breakout research provides another relevant design pattern: breakout followed by retest confirmation before entry.

MQL5 ADX research demonstrates combining range breakouts with trend-strength confirmation.

These references support investigating ATR, confirmation, retest, and trend-strength filters.

They do **not** prove that any of these modifications will improve EA-047.

EA-047 must validate each hypothesis independently using controlled backtests.

---

## Disclaimer

This research is intended for quantitative strategy development and educational purposes.

Backtest performance does not guarantee future trading results.

No modification should be deployed to live trading solely because it improves historical performance.
