## 17. Current Reference Experiments

The repository currently contains the following documented baseline experiments:

```text
EA-069_Breakout_ADX_Filter
EA-070_Breakout_Volume_Filter
```

Both experiments use the same general breakout framework but investigate different confirmation mechanisms.

```text
EA-069
Breakout
    +
ADX Trend-Strength Filter

EA-070
Breakout
    +
Tick-Volume Confirmation
```

The purpose of maintaining these experiments separately is to determine how different confirmation mechanisms affect the same general XAUUSD breakout concept.

---

## 17.1 EA-069 — Breakout ADX Filter

### Strategy

```text
20-Bar Breakout
        +
ADX(14) > 25
```

### Baseline Environment

```text
Expert:          EA-069_Breakout_ADX_Filter
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 – 2026.03.31

Initial Deposit: $100.00
Lot Size:        0.01
Leverage:        1:500
History Quality: 100% real ticks
```

### Baseline Result

```text
Total Trades:          214

Net Profit:            -$94.14
Profit Factor:            0.68
Expected Payoff:        -$0.44

Maximum Drawdown:        94.14%
Win Rate:                42.52%
```

### Classification

**FAIL**

The tested Breakout + ADX baseline did not demonstrate positive historical expectancy under the documented XAUUSD.PRO M1 conditions.

The result is retained unchanged as the EA-069 baseline reference.

EA-069 remains a research strategy and is not validated for live trading.

---

## 17.2 EA-070 — Breakout Volume Filter

### Strategy

EA-070 investigates whether a price breakout accompanied by above-average tick volume provides better entry confirmation.

Baseline logic:

```text
Price Breakout
        +
Breakout Candle Tick Volume
        >
Previous Average Tick Volume
        ↓
Trade
```

### BUY

```text
Close[1] > Highest High(previous 20 bars)
AND
TickVolume[1] > Average TickVolume(previous 20 bars)
```

### SELL

```text
Close[1] < Lowest Low(previous 20 bars)
AND
TickVolume[1] > Average TickVolume(previous 20 bars)
```

The baseline therefore represents:

```text
20-Bar Breakout
        +
Relative Tick Volume > 1.00
```

---

### Baseline Environment

```text
Expert:          EA-070_Breakout_Volume_Filter
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 – 2026.03.31

Initial Deposit: $100.00
Lot Size:        0.01
Leverage:        1:500

History Quality: 100% real ticks
Bars:            85,161
Ticks:           39,639,179
```

---

### Baseline Parameters

```text
Breakout Lookback:     20
Breakout Buffer:       0

Volume Lookback:       20

Stop Loss:             300 points
Take Profit:           600 points

Maximum Spread:        30 points

Break Even:            Enabled
Break Even Trigger:    150 points
Break Even Offset:     0

Trailing Stop:         Enabled
Trailing Start:        200 points
Trailing Distance:     100 points
Trailing Step:         10 points
```

---

### Baseline Performance

```text
Total Trades:          386
Total Deals:           772

Winning Trades:        187 (48.45%)
Losing Trades:         199 (51.55%)

Long Trades:           185
Long Win Rate:         50.27%

Short Trades:          201
Short Win Rate:        46.77%

Gross Profit:          $364.02
Gross Loss:            -$457.32
Net Profit:            -$93.30

Profit Factor:         0.80
Expected Payoff:       -$0.24
Recovery Factor:       -0.94
Sharpe Ratio:          -5.00

Maximum Balance DD:    93.62%
Maximum Equity DD:     93.71%

Average Winner:        +$1.95
Average Loser:         -$2.30
```

---

### Holding-Time Statistics

```text
Minimum:  00:00:05
Average:  00:03:46
Maximum:  02:03:19
```

The strategy therefore behaves predominantly as a short-duration M1 system under the baseline configuration.

---

### MFE / MAE Statistics

```text
Correlation (Profit, MFE): 0.95
Correlation (Profit, MAE): 0.72
Correlation (MFE, MAE):    0.6031
```

These statistics are retained for later exit-management research.

They do not independently demonstrate that changing exit parameters will improve performance.

---

### Classification

**FAIL**

The EA-070 baseline failed to demonstrate positive historical expectancy.

Primary evidence:

```text
Net Profit:          -$93.30
Profit Factor:          0.80
Expected Payoff:      -$0.24
Max Equity DD:         93.71%
Win Rate:              48.45%
```

The strategy is therefore rejected as a deployable configuration.

The result is retained unchanged as the EA-070 baseline reference.

---

## 17.3 EA-070 Research Interpretation

The baseline establishes that the tested combination:

```text
20-Bar Breakout
        +
Breakout Tick Volume
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

did not demonstrate sufficient historical edge under the documented test conditions.

This conclusion applies specifically to the tested configuration.

It does not establish that:

```text
Breakout strategies have no edge
```

or:

```text
Tick-volume confirmation has no value
```

or:

```text
Different relative-volume thresholds will produce the same result
```

or:

```text
Different timeframes will behave identically
```

The baseline is therefore the starting point for controlled EA-070 research.

---

## 17.4 EA-070 Research Priority

The primary unresolved question is the strength of the volume-confirmation rule.

Baseline:

```text
Breakout Volume > Average Volume
```

Equivalent conceptual threshold:

```text
Relative Volume > 1.00
```

A breakout candle only slightly above average volume can therefore satisfy the baseline filter.

Example:

```text
Average Volume  = 100
Breakout Volume = 101

Relative Volume = 1.01

Signal = Accepted
```

The first controlled EA-070 experiment should therefore investigate whether stronger relative-volume confirmation improves breakout quality.

---

## 17.5 EA-070 Controlled Research Sequence

The authorized research sequence is:

```text
Baseline
   │
   ▼
EA070-RQ01
Relative Volume Strength
   │
   ▼
EA070-RQ02
BUY vs SELL Direction
   │
   ▼
EA070-RQ03
Volume Lookback
   │
   ▼
EA070-RQ04
Breakout Lookback
   │
   ▼
EA070-RQ05
Volume / Breakout Interaction
   │
   ▼
EA070-RQ06
Timeframe Evaluation
   │
   ▼
EA070-RQ07
Trading Session
   │
   ▼
EA070-RQ08
Breakout Buffer
   │
   ▼
EA070-RQ09
Exit Management
   │
   ▼
Controlled Optimization
   │
   ▼
Out-of-Sample Validation
   │
   ▼
Robustness Testing
   │
   ▼
Forward Testing
```

Broad optimization must not replace these controlled experiments.

---

## 17.6 Cross-EA Comparison Rule

Different EAs in this repository may investigate different filters applied to a similar underlying trading concept.

For example:

```text
EA-069
Breakout + ADX

EA-070
Breakout + Tick Volume
```

Their results may be compared descriptively when:

- symbol is comparable;
- timeframe is comparable;
- test period is comparable;
- position sizing is comparable;
- execution assumptions are documented.

However, differences between two EA results do not automatically prove that one filter is causally superior.

A controlled experiment is required before attributing performance differences to a specific strategy component.

---

## 17.7 Current Baseline Comparison

| Metric | EA-069 | EA-070 |
|---|---:|---:|
| Confirmation | ADX | Tick Volume |
| Symbol | XAUUSD.PRO | XAUUSD.PRO |
| Timeframe | M1 | M1 |
| Period | 2026.01.02–2026.03.31 | 2026.01.02–2026.03.31 |
| Initial Deposit | $100 | $100 |
| Lot | 0.01 | 0.01 |
| Trades | 214 | 386 |
| Win Rate | 42.52% | 48.45% |
| Net Profit | -$94.14 | -$93.30 |
| Profit Factor | 0.68 | 0.80 |
| Expected Payoff | -$0.44 | -$0.24 |
| Maximum Equity DD | 94.14% | 93.71% |
| Classification | FAIL | FAIL |

This table is descriptive.

It does not establish that the volume filter is superior to the ADX filter.

EA-069 and EA-070 differ in signal behavior and trade count, so causal conclusions require controlled research.

---

## 18. Research Experiment Naming

Future experiments should use stable identifiers.

Recommended format:

```text
EA<NUMBER>-RQ<NUMBER>
```

Examples:

```text
EA069-RQ01
EA069-RQ02

EA070-RQ01
EA070-RQ02
```

If multiple configurations are tested within one research question:

```text
EA070-RQ01-A
EA070-RQ01-B
EA070-RQ01-C
```

Example:

```text
EA070-RQ01-A
Relative Volume > 1.10

EA070-RQ01-B
Relative Volume > 1.20

EA070-RQ01-C
Relative Volume > 1.30
```

This naming convention allows every experiment to be traced back to:

```text
EA
+
Research Question
+
Configuration
+
Backtest Evidence
+
Conclusion
```

---

## 19. Research Status Definitions

Each EA may use the following research states.

### BASELINE PENDING

Strategy implementation exists but the baseline test has not been completed.

### BASELINE COMPLETE

The original configuration has been tested and documented.

### IN PROGRESS

Controlled research experiments are being performed.

### CANDIDATE

A configuration has passed the current research stage and is eligible for independent validation.

This does not mean it is production-ready.

### VALIDATION

The selected candidate is undergoing:

```text
Out-of-Sample Testing
Month-by-Month Testing
Robustness Testing
Forward Testing
```

### REJECTED

The hypothesis or configuration has failed the defined research criteria and no further experiment is currently authorized.

### PRODUCTION ASSESSMENT

A strategy has completed the required research and validation stages and is being evaluated for possible production use.

---

## 20. Validation Barrier

A strategy must not move directly from:

```text
Profitable Backtest
```

to:

```text
Live Trading
```

The minimum research path is:

```text
Baseline
    ↓
Controlled Research
    ↓
Candidate Selection
    ↓
Out-of-Sample Validation
    ↓
Robustness Testing
    ↓
Forward Testing
    ↓
Production Assessment
```

A profitable in-sample configuration remains an experimental result until independent validation is completed.

---

## 21. Optimization Barrier

Broad optimization must not be used as the first response to a failed baseline.

A failed baseline should first generate a research question.

Example:

```text
Observation
    ↓
Hypothesis
    ↓
Controlled Change
    ↓
Backtest
    ↓
Comparison
```

Only after meaningful strategy behavior has been identified should broader parameter optimization be considered.

This reduces the risk of searching a large parameter space for accidental historical profitability.

---

## 22. Evidence Hierarchy

Research conclusions should be supported in the following order:

```text
1. MQL5 Source Code
2. Exact Input Parameters
3. Original MT5 Strategy Tester Report
4. Associated MT5 Charts
5. Research Interpretation
```

The source code defines what the EA actually does.

The Strategy Tester report defines what was actually tested.

Research documentation interprets those results.

Documentation must not contradict the implementation or the original test evidence.

---

## 23. Failed Experiment Preservation

Failed experiments must remain in the repository.

A failed baseline is not useless data.

It may reveal:

- insufficient signal quality;
- excessive market noise;
- directional asymmetry;
- unsuitable confirmation strength;
- poor payoff structure;
- excessive drawdown;
- unstable exit behavior;
- broker or timeframe sensitivity.

Removing failed experiments would create survivorship bias in the research history.

Therefore:

```text
FAIL ≠ DELETE
```

Instead:

```text
FAIL
 ↓
Document
 ↓
Analyze
 ↓
Generate Research Question
```

---

## 24. Reproducibility Requirement

Every experiment should be traceable to:

```text
Strategy Source
        +
EA Version
        +
Input Parameters
        +
Symbol
        +
Timeframe
        +
Test Period
        +
Data Quality
        +
MT5 Report
        +
Research Conclusion
```

Another researcher should be able to determine:

1. Which EA was tested.
2. Which version was tested.
3. Which parameters were used.
4. Which market was tested.
5. Which timeframe was tested.
6. Which historical period was tested.
7. What data quality was used.
8. What result was produced.
9. Why the experiment passed or failed.
10. What research question followed from the result.

If these cannot be reconstructed, the experiment is not considered fully reproducible.

---

## 25. Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-069_Breakout_ADX_Filter/
│   │   ├── EA-069_Breakout_ADX_Filter.mq5
│   │   └── README.md
│   │
│   └── EA-070_Breakout_Volume_Filter/
│       ├── EA-070_Breakout_Volume_Filter.mq5
│       └── README.md
│
├── Backtest/
│   ├── EA-069_Breakout_ADX_Filter/
│   │   ├── README.md
│   │   └── MT5 Strategy Tester evidence
│   │
│   └── EA-070_Breakout_Volume_Filter/
│       ├── README.md
│       └── MT5 Strategy Tester evidence
│
├── Research/
│   └── README.md
│
├── docs/
│   └── methodology.md
│
└── GitHub_Profile/
    └── README.md
```

---

## 26. Current Repository Research State

```text
EA-069
Strategy:             Breakout + ADX
Baseline:             COMPLETE
Baseline Result:      FAIL
Research Status:      IN PROGRESS
Live Validation:      NOT VALIDATED

EA-070
Strategy:             Breakout + Tick Volume
Baseline:             COMPLETE
Baseline Result:      FAIL
Research Status:      IN PROGRESS
Next Stage:           EA070-RQ01
Live Validation:      NOT VALIDATED
```

---

## 27. Core Research Rule

Research results must follow the evidence.

A profitable backtest is not proof of future profitability.

A failed backtest is not discarded.

A higher Win Rate does not automatically indicate a better strategy.

A higher Net Profit does not automatically indicate a more robust strategy.

An optimized parameter set is not independently validated simply because it performed well on development data.

Every meaningful experiment should leave behind:

```text
Code
+
Configuration
+
Backtest
+
Evidence
+
Interpretation
+
Conclusion
```

The purpose of this repository is not to present only successful strategies.

The purpose is to maintain a transparent, reproducible record of the process used to determine which XAUUSD trading hypotheses survive controlled testing.
