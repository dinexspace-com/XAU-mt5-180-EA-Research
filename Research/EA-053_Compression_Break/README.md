# EA-053 — Compression Break Research

## Research Objective

EA-053_Compression_Break investigates whether short-term price-range compression followed by a confirmed breakout can provide a systematic trading edge on XAUUSD.

The core hypothesis is that a sequence of progressively smaller candle ranges represents a temporary contraction in market volatility. If price subsequently breaks and closes outside the compression zone, the breakout may indicate the beginning of a directional expansion.

The strategy converts this hypothesis into explicit and testable trading rules suitable for implementation as a MetaTrader 5 Expert Advisor.

## Research Hypothesis

The strategy is based on the following sequence:

Range Compression → Breakout Confirmation → Directional Entry → Position Management

The working hypothesis is:

**When several consecutive candles show progressively contracting high-to-low ranges, a subsequent confirmed close outside the compression zone may contain useful directional information.**

This hypothesis is tested mechanically rather than assuming that compression automatically predicts a profitable breakout.

## Compression Definition

EA-053 measures the high-to-low range of consecutive completed candles.

For each candle:

Range = High - Low

A valid compression structure requires each newer compression candle to have a smaller range than the preceding candle.

The number of candles used to define the structure is configurable through:

`InpCompressionBars`

Baseline configuration:

`InpCompressionBars = 4`

The general structure is:

Older Candle → Large Range  
Next Candle → Smaller Range  
Next Candle → Smaller Range  
Newest Compression Candle → Smallest Range  
Next Completed Candle → Potential Breakout

The parameter:

`InpMinRangeDecreasePct`

controls the minimum required contraction between consecutive candle ranges.

Baseline value:

`InpMinRangeDecreasePct = 0.0`

With this configuration, the newer range only needs to be strictly smaller than the preceding range.

## Compression Zone

Once a valid compression sequence is detected, the strategy creates a price zone from the compression candles.

Zone High = Highest High of the compression candles

Zone Low = Lowest Low of the compression candles

The breakout candle is evaluated separately and is not included when constructing the compression zone.

This creates an objective boundary that price must exceed before a trade signal can be generated.

## Breakout Hypothesis

Compression alone does not generate an entry.

The strategy waits for a completed candle to move outside the established compression zone and close beyond its boundary.

This additional requirement attempts to distinguish an actual directional expansion from price movement that remains inside the compressed structure.

## BUY Research Rule

A BUY candidate requires:

1. A valid compression structure.
2. The breakout candle trades above Zone High.
3. The breakout candle closes above Zone High.
4. The breakout candle is bullish.
5. Close > Open.

Research sequence:

Compression → Break above Zone High → Bullish close outside zone → BUY

## SELL Research Rule

A SELL candidate requires:

1. A valid compression structure.
2. The breakout candle trades below Zone Low.
3. The breakout candle closes below Zone Low.
4. The breakout candle is bearish.
5. Close < Open.

Research sequence:

Compression → Break below Zone Low → Bearish close outside zone → SELL

## Signal Timing

Signals are evaluated using completed candles.

The EA checks the previous completed candle as the breakout candle when a new candle begins.

This design prevents the strategy from treating temporary intrabar movement as a confirmed breakout and prevents repeated entries from the same breakout candle.

## Position Constraint

The baseline implementation allows only one active position associated with the EA Magic Number.

This prevents multiple simultaneous EA-053 positions from accumulating while evaluating the baseline hypothesis.

## Baseline Risk and Exit Model

The initial research implementation uses fixed-distance Stop Loss and Take Profit values.

Baseline configuration:

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Lock | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 150 points |
| Trailing Step | 10 points |

The baseline therefore tests the compression-breakout entry together with a fixed SL/TP and active position-management model.

The backtest does not isolate the entry signal from the exit logic. Consequently, the baseline result should be interpreted as the performance of the complete tested configuration rather than proof that the compression signal itself has or does not have predictive value.

## Spread Control

The strategy includes a maximum spread filter to avoid initiating positions when transaction conditions exceed the configured threshold.

Baseline:

`InpMaxSpread = 35 points`

This filter applies to new entries.

## Baseline Experiment

The initial EA-053 implementation was tested using the following environment:

| Item | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $1,000 |
| Lot Size | 0.01 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Total Trades | 1,133 |

The relatively large number of trades provides a useful baseline sample for evaluating the original implementation.

## Baseline Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$239.65 |
| Gross Profit | $1,238.71 |
| Gross Loss | -$1,478.36 |
| Profit Factor | 0.84 |
| Expected Payoff | -$0.21 |
| Recovery Factor | -0.90 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Maximal | $263.54 (26.35%) |
| Equity Drawdown Maximal | $266.48 (26.61%) |
| Total Trades | 1,133 |
| Winning Trades | 558 (49.25%) |
| Losing Trades | 575 (50.75%) |

The baseline experiment therefore failed to demonstrate positive expectancy.

## Directional Results

The baseline produced:

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 628 | 50.80% |
| Short | 505 | 47.33% |

Long trades performed better by win rate than short trades in this specific test sample.

This observation is descriptive only.

It is not sufficient evidence to conclude that BUY-only trading is profitable, because win rate alone does not account for average win, average loss, transaction costs, drawdown, or the distribution of returns.

## Win/Loss Structure

The complete baseline produced:

Average winning trade = $2.22

Average losing trade = -$2.57

Largest winning trade = $8.77

Largest losing trade = -$12.16

The average losing trade was larger than the average winning trade while the strategy won fewer than half of all trades.

This combination resulted in negative expectancy under the tested configuration.

## Holding-Time Observation

Position holding statistics were:

Minimum holding time = 00:00:03

Average holding time = 00:02:50

Maximum holding time = 01:08:04

The baseline therefore behaves primarily as a very short-duration M1 breakout strategy.

This makes execution conditions, spread, breakout quality, and exit behavior potentially important variables for subsequent experiments.

## Baseline Research Conclusion

The original hypothesis has been successfully converted into deterministic trading rules and implemented as an executable MT5 Expert Advisor.

The implementation generated sufficient trading activity for an initial baseline experiment.

However, the tested configuration did not demonstrate a profitable edge.

Research status:

Strategy concept: IMPLEMENTED

Compression detection: IMPLEMENTED

Breakout detection: IMPLEMENTED

Mechanical execution: IMPLEMENTED

100% real-tick baseline: COMPLETED

Sample size: 1,133 trades

Positive expectancy: NOT CONFIRMED

Profit Factor > 1: NOT ACHIEVED

Positive net profit: NOT ACHIEVED

Acceptable equity progression: NOT ACHIEVED

Baseline research result: FAIL

## What the Baseline Establishes

The baseline establishes that:

- The compression pattern can be defined mechanically.
- The breakout condition can be executed mechanically.
- The strategy generates a substantial number of signals on XAUUSD.PRO M1.
- Both BUY and SELL signals occur frequently enough for further analysis.
- The current complete configuration produces negative expectancy over the tested period.
- The original configuration should not progress directly to live deployment.

## What the Baseline Does Not Establish

The baseline does not establish that every compression-breakout approach is unprofitable.

It also does not establish that changing one parameter will make the strategy profitable.

The experiment simultaneously contains several components:

Compression definition  
Breakout definition  
Direction filter  
Stop Loss  
Take Profit  
Break Even  
Trailing Stop  
Spread filter

Therefore, additional experiments are required before identifying which component or combination of components is responsible for the observed performance.

## Research Discipline

Future work should preserve the original baseline as immutable evidence.

The baseline should not be overwritten after optimization.

Every meaningful strategy modification should be treated as a new experiment and compared against the original EA-053 baseline.

Changes should be introduced deliberately so that improvements can be attributed to specific modifications rather than uncontrolled parameter combinations.

Optimization results should not automatically be interpreted as validation.

Any promising configuration should subsequently be evaluated on data not used to select its parameters.

## Next Research Stage

EA-053 remains in the research stage.

The next research objective is to determine whether the negative baseline performance originates primarily from:

1. Compression-pattern quality.
2. Breakout confirmation quality.
3. Market direction or regime.
4. Time/session effects.
5. Fixed SL/TP configuration.
6. Break Even behavior.
7. Trailing Stop behavior.
8. Spread and short-duration execution effects.

These are research questions, not validated improvements.

Each proposed modification should be tested separately or through a controlled experimental design before being accepted.

## Evidence

Source implementation:

`EAs/EA-053_Compression_Break/EA-053_Compression_Break.mq5`

Strategy documentation:

`EAs/EA-053_Compression_Break/README.md`

Baseline evidence:

`Backtest/EA-053_Compression_Break/`

Primary baseline report:

`Backtest/EA-053_Compression_Break/ReportTester-952747(20260911-003258).html`

Associated MT5 charts are retained in the same backtest directory.

## Research Status

**EA-053_Compression_Break**

Stage: Baseline Research

Implementation: COMPLETE

Baseline Backtest: COMPLETE

Baseline Result: FAIL

Optimization: NOT VALIDATED

Out-of-Sample Validation: NOT COMPLETED

Forward Test: NOT COMPLETED

Live Validation: NOT COMPLETED

Production Ready: NO
