# EA-070 — Breakout Volume Filter Backtest

## Overview

This directory contains the baseline MetaTrader 5 Strategy Tester evidence for:

**EA-070_Breakout_Volume_Filter**

Strategy:

**Breakout + Tick Volume Filter**

Platform:

**MetaTrader 5**

The purpose of this baseline test is to determine whether requiring above-average tick volume on the breakout candle provides sufficient confirmation for a 20-bar XAUUSD breakout strategy under the tested M1 conditions.

This is a baseline research experiment.

The result is preserved regardless of profitability so that future EA-070 variants can be compared against the same reference configuration.

---

## Test Configuration

| Parameter | Value |
|---|---|
| Expert | EA-070_Breakout_Volume_Filter |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.03.31 |
| Initial Deposit | $100.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols | 1 |
| Lot Size | 0.01 |

---

## Strategy Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123070 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| Volume Lookback | 20 |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 100 points |
| Trailing Step | 10 points |

---

## Baseline Strategy

The baseline evaluates a price breakout combined with tick-volume confirmation.

Conceptually:

```text
Previous 20-Bar Price Range
            │
            ▼
      Price Breakout
            │
            ▼
 Breakout Candle Tick Volume
            >
Previous 20-Bar Average Volume
            │
            ▼
          Entry
```

BUY:

```text
Close[1] > Highest High(previous 20 bars)
AND
TickVolume[1] > Average TickVolume(previous 20 bars)
```

SELL:

```text
Close[1] < Lowest Low(previous 20 bars)
AND
TickVolume[1] > Average TickVolume(previous 20 bars)
```

The volume measure used by the EA is MT5 tick volume.

---

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$93.30** |
| Gross Profit | $364.02 |
| Gross Loss | -$457.32 |
| Profit Factor | **0.80** |
| Expected Payoff | **-$0.24** |
| Recovery Factor | **-0.94** |
| Sharpe Ratio | **-5.00** |
| Balance Drawdown Absolute | $93.30 |
| Equity Drawdown Absolute | $93.30 |
| Maximum Balance Drawdown | **$98.24 (93.62%)** |
| Maximum Equity Drawdown | **$99.75 (93.71%)** |
| Relative Balance Drawdown | 93.62% |
| Relative Equity Drawdown | 93.71% |
| Margin Level | 96.57% |
| Total Trades | **386** |
| Total Deals | 772 |
| Winning Trades | **187 (48.45%)** |
| Losing Trades | **199 (51.55%)** |

---

## Long / Short Performance

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 185 | **50.27%** |
| Short | 201 | **46.77%** |

The baseline therefore shows a modest directional asymmetry.

Long trades achieved a higher historical win rate than short trades:

```text
Long Win Rate  = 50.27%
Short Win Rate = 46.77%
Difference     = 3.50 percentage points
```

This observation is retained as a research hypothesis.

It does not establish that BUY-only trading is profitable or that SELL trades should be removed without controlled directional testing.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $6.32 |
| Largest Loss Trade | -$3.35 |
| Average Profit Trade | $1.95 |
| Average Loss Trade | -$2.30 |
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Wins Profit | $10.38 |
| Maximum Consecutive Losses | 7 |
| Maximum Consecutive Loss | -$21.49 |
| Maximal Consecutive Profit | $15.35 (6 trades) |
| Maximal Consecutive Loss | -$21.49 (7 trades) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

---

## Payoff Structure

The baseline produced:

```text
Average Winner = +$1.95
Average Loser  = -$2.30
```

Therefore the average losing trade was larger than the average profitable trade.

At the same time:

```text
Win Rate = 48.45%
Loss Rate = 51.55%
```

This combination resulted in negative historical expectancy:

```text
Expected Payoff = -$0.24 per trade
```

and:

```text
Profit Factor = 0.80
```

Gross losses therefore exceeded gross profits during the tested period.

---

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:05 |
| Average Holding Time | 00:03:46 |
| Maximum Holding Time | 02:03:19 |

The strategy is predominantly short-duration under the baseline M1 configuration.

The average position remained open for less than four minutes, although at least one position remained open for more than two hours.

---

## MFE / MAE Correlation

| Metric | Result |
|---|---:|
| Correlation (Profits, MFE) | 0.95 |
| Correlation (Profits, MAE) | 0.72 |
| Correlation (MFE, MAE) | 0.6031 |

The strong reported correlation between Profit and MFE is retained for future exit-management research.

This statistic alone does not establish that a different Take Profit or Trailing Stop configuration would improve out-of-sample performance.

Any exit modification must be tested independently.

---

## Equity / Balance Observation

The balance curve does not show a stable upward trajectory.

Although the account experienced temporary recoveries during the test, the broader trajectory deteriorated substantially and finished close to depletion of the original $100 deposit.

The maximum reported drawdowns were:

```text
Balance Drawdown = 93.62%
Equity Drawdown  = 93.71%
```

This level of drawdown is unacceptable for the baseline to be considered a viable deployment candidate.

---

## Baseline Classification

**Status: FAIL**

The baseline configuration does not demonstrate positive historical expectancy or acceptable risk characteristics.

Primary evidence:

```text
Initial Deposit:          $100.00

Total Net Profit:         -$93.30
Profit Factor:               0.80
Expected Payoff:           -$0.24
Recovery Factor:             -0.94
Sharpe Ratio:                -5.00

Winning Trades:             48.45%
Losing Trades:              51.55%

Maximum Balance DD:         93.62%
Maximum Equity DD:          93.71%

Total Trades:                  386
```

The baseline therefore fails on both:

```text
Profitability
+
Risk / Drawdown
```

---

## Research Interpretation

The baseline result rejects the tested configuration as a deployable candidate.

Specifically, the evidence does not support the proposition that the tested combination of:

```text
20-Bar Breakout
        +
Breakout Candle Tick Volume
>
Previous 20-Bar Average Tick Volume
        +
SL 300
        +
TP 600
        +
Break Even
        +
Trailing Stop
```

provides a profitable and sufficiently robust trading edge under the documented XAUUSD.PRO M1 test conditions.

However, this result must be interpreted narrowly.

It does **not** establish that:

- breakout trading has no edge;
- volume filtering has no value;
- XAUUSD breakout systems cannot be profitable;
- all volume thresholds will behave identically;
- all timeframes will produce the same result.

It establishes only that the specific EA-070 baseline configuration tested here failed to demonstrate positive expectancy.

---

## Important Baseline Observation

EA-070 generated:

```text
386 trades
```

during the test period.

This provides a larger baseline trade sample than a very low-frequency experiment and makes the result useful for controlled comparison with subsequent EA-070 variants.

However, trade count alone does not establish robustness.

The result still represents:

```text
One strategy configuration
+
One symbol specification
+
One broker environment
+
One timeframe
+
One historical test period
```

Independent validation is required before any broader conclusion can be made.

---

## Research Questions Raised by the Baseline

The failed baseline creates several controlled research questions.

### RQ01 — Volume Threshold

The current condition is effectively:

```text
Breakout Volume > Average Volume
```

This only requires the breakout candle to exceed the historical average.

Future controlled research can test whether stronger relative-volume requirements improve signal quality.

Conceptually:

```text
Breakout Volume
>
Average Volume × Volume Multiplier
```

This must be tested rather than assumed.

---

### RQ02 — BUY vs SELL Direction

Baseline results:

```text
Long  = 185 trades / 50.27% won
Short = 201 trades / 46.77% won
```

The directional difference warrants controlled investigation.

It does not justify removing one direction based solely on the baseline.

---

### RQ03 — Volume Lookback

Baseline:

```text
Volume Lookback = 20
```

Alternative lookback periods may change how the EA defines abnormal trading activity.

They should be evaluated through controlled experiments rather than broad optimization.

---

### RQ04 — Breakout Lookback

Baseline:

```text
Breakout Lookback = 20
```

The relationship between breakout-range length and volume confirmation remains untested.

---

### RQ05 — Timeframe

Baseline:

```text
M1
```

M1 contains substantial short-term market noise.

The same underlying hypothesis can later be evaluated independently on:

```text
M5
M15
```

without assuming that a higher timeframe will automatically improve performance.

---

### RQ06 — Exit Management

The baseline uses:

```text
SL = 300
TP = 600

Break Even:
Trigger = 150

Trailing Stop:
Start    = 200
Distance = 100
Step     = 10
```

Because entry quality and exit management are separate research dimensions, exit changes should not initially be mixed with modifications to the volume filter.

---

## Research Priority

The primary purpose of EA-070 is to test the **volume-confirmation hypothesis**.

Therefore the next research stage should first investigate the volume filter itself rather than immediately performing broad optimization across all available parameters.

Recommended controlled sequence:

```text
Baseline
   ↓
Volume Confirmation Strength
   ↓
BUY / SELL Direction
   ↓
Volume Lookback
   ↓
Breakout Lookback
   ↓
Timeframe
   ↓
Exit Management
   ↓
Controlled Optimization
   ↓
Out-of-Sample Validation
```

Each experiment should preserve enough of the baseline configuration to make the effect of the tested change identifiable.

---

## Comparison Rule

All future EA-070 experiments should be compared against this baseline.

Primary comparison metrics:

- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Drawdown
- Win Rate
- Average Profit Trade
- Average Loss Trade
- Trade Count
- Long / Short performance
- Recovery Factor
- Stability across test periods

Improvement in one metric alone is insufficient.

For example:

```text
Higher Net Profit
+
Much Higher Drawdown
```

should not automatically be considered an improvement.

Likewise:

```text
Higher Win Rate
+
Negative Expected Payoff
```

does not establish a viable strategy.

---

## Baseline Preservation Rule

This failed baseline must remain unchanged.

Future profitable variants must not overwrite the original test.

The baseline provides the reference necessary to determine whether later modifications actually improve the strategy.

Recommended experiment structure:

```text
EA-070 Baseline
        │
        ├── EA070-RQ01
        ├── EA070-RQ02
        ├── EA070-RQ03
        ├── EA070-RQ04
        └── ...
```

Each experiment should preserve:

```text
Code Version
+
Parameters
+
Test Environment
+
MT5 Report
+
Result
+
Conclusion
```

---

## Evidence Files

The original MetaTrader 5 Strategy Tester evidence should remain in this directory.

```text
Backtest/
└── EA-070_Breakout_Volume_Filter/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

### File Purpose

```text
ReportTester-952747.html
└── Complete MT5 Strategy Tester report

ReportTester-952747.png
└── Balance curve

ReportTester-952747-hst.png
└── Entry / profit-loss distribution statistics

ReportTester-952747-mfemae.png
└── MFE / MAE analysis

ReportTester-952747-holding.png
└── Position holding-time distribution
```

The HTML Strategy Tester report is the primary numerical evidence.

The associated charts provide visual supporting evidence.

---

## Reproducibility

The original MT5 Strategy Tester report should be preserved unchanged.

It records the information required to audit the baseline, including:

- EA name
- Symbol
- Timeframe
- Historical period
- Input parameters
- Initial deposit
- Leverage
- Data quality
- Orders
- Deals
- Performance statistics
- Drawdown
- Trade distribution
- Position holding times

A future researcher should be able to reconstruct which configuration produced this result without relying on undocumented assumptions.

---

## Baseline Summary

```text
EA:                    EA-070_Breakout_Volume_Filter
Strategy:              Breakout + Tick Volume Filter

Symbol:                XAUUSD.PRO
Timeframe:             M1
Period:                2026.01.02 – 2026.03.31
History Quality:       100% real ticks

Initial Deposit:       $100.00
Lot Size:              0.01
Leverage:              1:500

Breakout Lookback:     20
Volume Lookback:       20

Total Trades:          386
Winning Trades:        187 (48.45%)
Losing Trades:         199 (51.55%)

Long Trades:           185 (50.27% won)
Short Trades:          201 (46.77% won)

Gross Profit:          $364.02
Gross Loss:            -$457.32
Net Profit:            -$93.30

Profit Factor:         0.80
Expected Payoff:       -$0.24
Recovery Factor:       -0.94
Sharpe Ratio:          -5.00

Max Balance DD:        93.62%
Max Equity DD:         93.71%

Average Winner:        +$1.95
Average Loser:         -$2.30

Average Holding Time:  00:03:46

BASELINE STATUS:       FAIL
LIVE VALIDATION:       NOT VALIDATED
```

---

## Conclusion

**EA-070 Baseline #01: FAIL**

The baseline Breakout + Volume Filter configuration failed to demonstrate positive historical expectancy on XAUUSD.PRO M1 during the tested period.

The strategy produced:

```text
386 trades
48.45% Win Rate
0.80 Profit Factor
-$0.24 Expected Payoff
-$93.30 Net Profit
93.71% Maximum Equity Drawdown
```

The result is not suitable as evidence for live deployment.

The baseline is retained as research evidence and as the reference configuration for subsequent controlled EA-070 experiments.

The next research stage should investigate whether the **volume-confirmation rule itself** can be improved before broad parameter optimization is attempted.

---

## Disclaimer

This backtest represents historical simulation under the documented MetaTrader 5 Strategy Tester conditions.

Backtest performance does not guarantee future trading performance.

This baseline is maintained for research, comparison, reproducibility, and strategy-development purposes only.
