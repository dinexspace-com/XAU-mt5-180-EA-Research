Tiếp tục **`docs/methodology.md`**. Giữ nguyên các phần trước của methodology và **thay phần từ `## 17. Current Reference Experiments` trở xuống** bằng khối dưới đây. Phần này giữ EA-069, EA-070 và bổ sung **EA-071** cùng quy tắc nghiên cứu ATR.

````markdown
## 17. Current Reference Experiments

The repository currently preserves three failed baseline experiments as active research references:

```text
EA-069 — Breakout + ADX Filter
EA-070 — Breakout + Volume Filter
EA-071 — Breakout + ATR Filter
````

All three baselines are classified as:

```text
FAIL
```

A failed baseline remains valid research evidence.

It must not be deleted, rewritten, or replaced by a later improved configuration.

---

### 17.1 EA-069 — Breakout ADX Filter

```text
Expert:
EA-069_Breakout_ADX_Filter

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-03-31

Initial Deposit:
$100

Leverage:
1:500

History Quality:
100% real ticks
```

Baseline strategy:

```text
20-Bar Breakout
        +
ADX(14) > 25
```

Baseline result:

```text
Trades:                 214

Net Profit:             -$94.14

Profit Factor:          0.68

Expected Payoff:        -$0.44

Recovery Factor:        -1.00

Sharpe Ratio:           -5.00

Maximum Equity DD:      94.14%

Win Rate:               42.52%

BUY Win Rate:           47.11%

SELL Win Rate:          36.56%
```

Classification:

```text
FAIL
```

Primary unresolved question:

```text
Does directional ADX confirmation
using +DI / -DI improve breakout quality?
```

Next research stage:

```text
EA069-RQ01
ADX Directional Confirmation
```

---

### 17.2 EA-070 — Breakout Volume Filter

```text
Expert:
EA-070_Breakout_Volume_Filter

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-03-31

Initial Deposit:
$100

Leverage:
1:500

History Quality:
100% real ticks
```

Baseline strategy:

```text
20-Bar Breakout
        +
Breakout Tick Volume
>
Previous 20-Bar Average Tick Volume
```

Equivalent conceptual condition:

```text
Relative Volume > 1.00
```

Baseline result:

```text
Trades:                 386

Net Profit:             -$93.30

Profit Factor:          0.80

Expected Payoff:        -$0.24

Recovery Factor:        -0.94

Sharpe Ratio:           -5.00

Maximum Equity DD:      93.71%

Win Rate:               48.45%

BUY Win Rate:           50.27%

SELL Win Rate:          46.77%
```

Classification:

```text
FAIL
```

Primary unresolved question:

```text
Is Volume > Average Volume
too weak to represent meaningful
breakout participation?
```

Next research stage:

```text
EA070-RQ01
Relative Volume Strength
```

---

### 17.3 EA-071 — Breakout ATR Filter

```text
Expert:
EA-071_Breakout_ATR_Filter

Symbol:
XAUUSD.PRO

Timeframe:
M1

Period:
2026-01-02 → 2026-03-31

Initial Deposit:
$1,000

Leverage:
1:500

History Quality:
100% real ticks

Bars:
85,161

Ticks:
39,639,179
```

Baseline parameters:

```text
Lot Size:              0.01

Stop Loss:             300
Take Profit:           600

Maximum Spread:        30
Slippage:              10

Breakout Lookback:     20
Breakout Buffer:       0

ATR Period:            14
ATR Mean Period:       20

Break Even:            ON
BE Trigger:            150
BE Offset:             0

Trailing Stop:         ON
Trailing Start:        200
Trailing Distance:     100
Trailing Step:         10

Magic Number:          123071
```

Baseline strategy:

```text
20-Bar Breakout
        +
ATR(14)[1]
>
Average ATR(14)[2...21]
```

Conceptually:

```text
20-Bar Breakout
        +
Relative ATR > 1.00
```

Where:

```text
Relative ATR =
Current ATR
───────────
Average ATR
```

BUY:

```text
ATR(14)[1]
>
Average ATR(14)[2...21]

AND

Close[1]
>
Highest High[2...21]
```

SELL:

```text
ATR(14)[1]
>
Average ATR(14)[2...21]

AND

Close[1]
<
Lowest Low[2...21]
```

Baseline result:

```text
Initial Deposit:        $1,000.00

Net Profit:             -$992.72

Gross Profit:           $4,006.58
Gross Loss:             -$4,999.30

Profit Factor:          0.80

Expected Payoff:        -$0.27

Recovery Factor:        -0.99

Sharpe Ratio:           -5.00

Maximum Balance DD:     99.28%
Maximum Equity DD:      99.28%

Total Trades:           3,669
Total Deals:            7,338

Winning Trades:         1,717
Losing Trades:          1,952

Win Rate:               46.80%
Loss Rate:              53.20%

BUY Trades:             1,597
BUY Win Rate:           49.53%

SELL Trades:            2,072
SELL Win Rate:          44.69%

Average Winner:         +$2.33
Average Loser:          -$2.56

Largest Winner:         +$29.45
Largest Loser:          -$7.23

Maximum Consecutive
Wins:                    11

Maximum Consecutive
Losses:                  12
```

Holding-time statistics:

```text
Minimum:
00:00:01

Average:
00:01:54

Maximum:
02:07:01
```

MFE / MAE correlations:

```text
Profit ↔ MFE:           0.96

Profit ↔ MAE:           0.73

MFE ↔ MAE:              0.6057
```

Classification:

```text
FAIL
```

The baseline nearly depleted the initial account.

The combination:

```text
Negative Net Profit
        +
Profit Factor < 1
        +
Negative Expected Payoff
        +
99.28% Maximum Equity Drawdown
```

prevents this configuration from advancing to live validation.

---

### 17.4 EA-071 Baseline Interpretation

The baseline ATR condition is:

```text
ATR[1] > Average ATR
```

This condition requires only that current volatility be marginally greater than the historical average.

For example:

```text
Average ATR = 5.00

Current ATR = 5.01

Relative ATR = 1.002
```

The signal would pass.

Therefore:

```text
ATR > Average ATR
```

does not necessarily represent strong volatility expansion.

EA-071 also produced:

```text
3,669 trades
```

during the baseline period.

This raises the research hypothesis that:

```text
Relative ATR > 1.00
```

may be too permissive to act as a selective breakout-volatility filter.

This is a research hypothesis.

It is not yet a conclusion.

---

### 17.5 EA-071 Primary Research Question

The next controlled research question is:

```text
EA071-RQ01
ATR Confirmation Strength
```

Research question:

> Does requiring materially stronger ATR expansion improve breakout quality?

The future experimental implementation should support:

```text
Current ATR
>
Average ATR × ATRMultiplier
```

Baseline:

```text
ATRMultiplier = 1.00
```

Initial controlled research matrix:

| Experiment   | ATR Multiplier |
| ------------ | -------------: |
| EA071-BL01   |           1.00 |
| EA071-RQ01-A |           1.10 |
| EA071-RQ01-B |           1.20 |
| EA071-RQ01-C |           1.30 |
| EA071-RQ01-D |           1.50 |

These are research values only.

They are not validated parameters.

All other baseline variables must remain unchanged during RQ01.

---

### 17.6 EA-071 Research Sequence

The authorized EA-071 research sequence is:

```text
EA071-BL01
Baseline
   ↓
EA071-RQ01
ATR Confirmation Strength
   ↓
EA071-RQ02
BUY / SELL Direction
   ↓
EA071-RQ03
ATR Mean Period
   ↓
EA071-RQ04
ATR Period
   ↓
EA071-RQ05
Breakout Lookback
   ↓
EA071-RQ06
Timeframe
   ↓
EA071-RQ07
Trading Session
   ↓
EA071-RQ08
Exit Management
   ↓
Controlled Optimization
   ↓
Candidate Selection
   ↓
Out-of-Sample Validation
   ↓
Robustness Testing
   ↓
Forward Testing
```

Broad optimization remains:

```text
BLOCKED
```

until controlled research demonstrates that one or more variables contain useful and reasonably stable information.

---

### 17.7 Cross-EA Research Comparison

EA-069, EA-070, and EA-071 represent different market-state confirmation hypotheses applied to breakout trading.

```text
EA-069
Breakout
+
ADX Trend-Strength Filter
```

```text
EA-070
Breakout
+
Tick-Volume Filter
```

```text
EA-071
Breakout
+
ATR Volatility Filter
```

The research objective is not simply:

```text
Which EA has the highest backtest profit?
```

Instead, the objective is:

```text
Which market-state filter,
if any,
contains useful information
for selecting higher-quality
XAUUSD breakout signals?
```

Each branch must therefore be investigated independently before cross-EA conclusions are made.

---

### 17.8 Current Cross-EA Baseline Table

| EA     | Filter                 | Trades | Win Rate | Profit Factor | Expected Payoff | Max Equity DD | Result |
| ------ | ---------------------- | -----: | -------: | ------------: | --------------: | ------------: | ------ |
| EA-069 | ADX > 25               |    214 |   42.52% |          0.68 |          -$0.44 |        94.14% | FAIL   |
| EA-070 | Relative Volume > 1.00 |    386 |   48.45% |          0.80 |          -$0.24 |        93.71% | FAIL   |
| EA-071 | Relative ATR > 1.00    |  3,669 |   46.80% |          0.80 |          -$0.27 |        99.28% | FAIL   |

The table is descriptive only.

It does not establish a superior strategy.

The baseline experiments use different research filters and EA-071 also uses a different initial deposit.

Therefore raw monetary results must not be used as a direct ranking.

---

### 17.9 Cross-EA Directional Observation

Current baseline directional win rates:

| EA     | BUY Win Rate | SELL Win Rate |
| ------ | -----------: | ------------: |
| EA-069 |       47.11% |        36.56% |
| EA-070 |       50.27% |        46.77% |
| EA-071 |       49.53% |        44.69% |

All three baselines show:

```text
BUY Win Rate > SELL Win Rate
```

This repeated observation is worth preserving as a cross-EA research hypothesis.

However:

```text
Repeated Directional Difference
≠
Proof of BUY-Only Profitability
```

The observation must be tested using controlled directional experiments.

---

## 18. Research Experiment Naming

Every experiment must have a unique identifier.

General format:

```text
EAxxx-BLxx
```

for baseline experiments.

Example:

```text
EA071-BL01
```

Research experiments use:

```text
EAxxx-RQxx-[Variant]
```

Examples:

```text
EA069-RQ01-A

EA070-RQ01-A

EA071-RQ01-A
```

Descriptive suffixes may be added:

```text
EA071-RQ01-A_ATR-Multiplier-1.10

EA071-RQ01-B_ATR-Multiplier-1.20

EA071-RQ01-C_ATR-Multiplier-1.30

EA071-RQ01-D_ATR-Multiplier-1.50
```

The identifier must remain consistent across:

```text
Source Code
Backtest Report
Research Documentation
Result Tables
Charts
Commit History
```

---

## 19. Research Status Definitions

Use the following standardized statuses.

### COMPLETE

```text
Experiment executed
+
Evidence preserved
+
Results documented
```

---

### IN PROGRESS

```text
Research branch active
but not complete
```

---

### PENDING

```text
Experiment authorized
but not yet executed
```

---

### BLOCKED

```text
Experiment must not begin
until an earlier research stage is completed
```

---

### FAIL

```text
Tested configuration failed
the current research/deployment criteria
```

FAIL does not mean:

```text
Delete Experiment
```

It means:

```text
Preserve Experiment
+
Document Failure
+
Use as Evidence
```

---

### NOT VALIDATED

```text
Insufficient evidence exists
for a live-trading conclusion
```

---

## 20. Validation Barrier

A strategy must not advance directly from:

```text
Backtest
```

to:

```text
Live Trading
```

The required validation path is:

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
Live-Readiness Review
```

Passing one backtest is insufficient.

---

## 21. Optimization Barrier

Optimization is not the first research stage.

The preferred process is:

```text
Hypothesis
   ↓
Baseline
   ↓
Failure Analysis
   ↓
Research Question
   ↓
Controlled Experiment
   ↓
Evidence
   ↓
Repeatable Improvement
   ↓
Controlled Optimization
```

Avoid:

```text
Baseline
   ↓
Optimize Everything
   ↓
Select Best Result
```

because this makes it difficult to determine which variable created the observed performance and increases overfitting risk.

---

### 21.1 One Major Variable Rule

During controlled research:

```text
Change One Major Variable
```

while preserving the remaining baseline configuration.

For EA-071 RQ01:

```text
CHANGE:
ATR Multiplier

KEEP CONSTANT:
Symbol
Timeframe
Period
Breakout Lookback
Breakout Buffer
ATR Period
ATR Mean Period
Lot
SL
TP
Break Even
Trailing Stop
Spread Filter
```

This allows the effect of ATR confirmation strength to be evaluated independently.

---

### 21.2 Parameter Neighborhood Rule

A potentially useful parameter should preferably show improvement across nearby values.

Prefer:

```text
1.15 → improvement
1.20 → improvement
1.25 → improvement
1.30 → improvement
```

over:

```text
1.15 → poor
1.20 → poor
1.25 → exceptional
1.30 → poor
```

An isolated peak may indicate parameter fragility.

---

## 22. Evidence Hierarchy

Research conclusions should use the following evidence hierarchy.

### Level 1 — Source Code

Defines:

```text
What the EA is intended to execute
```

---

### Level 2 — Strategy Tester Configuration

Defines:

```text
What was actually tested
```

including:

```text
Symbol
Timeframe
Date Range
Deposit
Leverage
Inputs
Data Quality
```

---

### Level 3 — Strategy Tester Results

Defines:

```text
What occurred during the historical test
```

including:

```text
Net Profit
Profit Factor
Expected Payoff
Drawdown
Trade Count
Win Rate
Recovery
Sharpe
```

---

### Level 4 — Trade-Level Evidence

Includes:

```text
Orders
Deals
Holding Time
BUY / SELL Results
MFE
MAE
Trade Distribution
```

---

### Level 5 — Controlled Research

Tests whether:

```text
A specific change
produces measurable improvement
```

---

### Level 6 — Out-of-Sample Evidence

Tests performance on data not used for candidate selection.

---

### Level 7 — Robustness Evidence

Tests whether results survive:

```text
Parameter Perturbation
Different Market Regimes
Execution Changes
Spread Changes
Alternative Data
```

---

### Level 8 — Forward Evidence

Tests the strategy on new market data after development.

Higher evidence levels are required before stronger conclusions can be made.

---

## 23. Failed Experiment Preservation

Failed experiments must remain in the repository.

Do not:

```text
Delete
Rewrite
Replace
Hide
```

a failed baseline.

Instead:

```text
Preserve
Document
Classify
Compare
Learn
```

The repository is a research record rather than a collection containing only successful backtests.

Current preserved failed references include:

```text
EA069-BL01
EA070-BL01
EA071-BL01
```

---

## 24. Reproducibility Requirement

Every documented experiment should provide enough information to reproduce the test.

At minimum preserve:

```text
EA Name

EA Version

Experiment ID

Symbol

Timeframe

Test Period

Initial Deposit

Leverage

History Quality

Lot Size

Stop Loss

Take Profit

Spread Limit

Strategy Parameters

Break Even Parameters

Trailing Parameters

MT5 Report

Supporting Images
```

When a research variable changes, record:

```text
Baseline Value
New Value
Reason for Change
Experiment ID
```

---

## 25. Repository Structure

The research repository should continue using the separation:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-069_Breakout_ADX_Filter/
│   ├── EA-070_Breakout_Volume_Filter/
│   └── EA-071_Breakout_ATR_Filter/
│
├── Backtest/
│   ├── EA-069_Breakout_ADX_Filter/
│   ├── EA-070_Breakout_Volume_Filter/
│   └── EA-071_Breakout_ATR_Filter/
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

The responsibilities remain:

```text
EAs/
=
Strategy implementation
+
technical specification

Backtest/
=
Historical test evidence
+
baseline result

Research/
=
Research questions
+
experiment sequence
+
hypothesis tracking

docs/
=
Global research methodology
+
cross-EA rules

GitHub_Profile/
=
Public project summary
+
current research status
```

---

## 26. Current Repository Research State

```text
EA-069
Strategy:               COMPLETE
Baseline:               COMPLETE
Baseline Result:        FAIL
Research:               IN PROGRESS
Next:                   EA069-RQ01
Live Validation:        NOT VALIDATED
```

```text
EA-070
Strategy:               COMPLETE
Baseline:               COMPLETE
Baseline Result:        FAIL
Research:               IN PROGRESS
Next:                   EA070-RQ01
Live Validation:        NOT VALIDATED
```

```text
EA-071
Strategy:               COMPLETE
Baseline:               COMPLETE
Baseline Result:        FAIL
Research:               IN PROGRESS
Next:                   EA071-RQ01
Live Validation:        NOT VALIDATED
```

Current primary questions:

```text
EA-069:
Does +DI / -DI directional confirmation
improve the ADX breakout filter?

EA-070:
Does stronger relative tick volume
improve breakout quality?

EA-071:
Does stronger relative ATR expansion
improve breakout quality?
```

---

## 27. Cross-EA Research Framework

The current research series can be represented as:

```text
                    XAUUSD Breakout
                          │
          ┌───────────────┼───────────────┐
          │               │               │
          ▼               ▼               ▼
        EA-069           EA-070           EA-071
          │               │               │
          ▼               ▼               ▼
         ADX          Tick Volume          ATR
          │               │               │
          ▼               ▼               ▼
    Trend Strength     Participation    Volatility
       Filter             Filter          Filter
```

Each EA asks a different question about the market state surrounding a breakout.

The research should determine whether any of these filters provide repeatable information beyond the underlying breakout signal.

---

## 28. Cross-EA Comparison Rule

Cross-EA comparison should prioritize normalized statistics rather than raw monetary profit alone.

Primary comparison metrics:

```text
Profit Factor

Expected Payoff

Maximum Drawdown %

Recovery Factor

Sharpe Ratio

Win Rate

BUY / SELL Performance

Trade Count

Average Winner / Loser

Parameter Stability
```

Raw:

```text
Net Profit ($)
```

must be interpreted in the context of:

```text
Initial Deposit
Lot Size
Trade Count
Test Configuration
```

This is particularly important because EA-071 Baseline #01 used:

```text
$1,000 Initial Deposit
```

while EA-069 and EA-070 used:

```text
$100 Initial Deposit
```

Therefore their raw dollar results are not directly comparable.

---

## 29. Research Escalation Rule

A research branch should progress only when the previous stage produces enough evidence to justify the next question.

Conceptually:

```text
Baseline Failure
        ↓
Identify Structural Weakness
        ↓
Controlled Research Question
        ↓
Measure Effect
        ↓
Stable Improvement?
   ┌────┴────┐
   │         │
  NO        YES
   │         │
   ▼         ▼
Reassess    Continue
Hypothesis  Research
```

Do not continue adding complexity simply because a baseline fails.

Every additional filter or parameter must answer a defined research question.

---

## 30. Core Research Rule

The repository follows one central principle:

```text
Do not search for the best parameter first.

Determine whether the variable
contains useful information first.
```

The objective is not to manufacture an attractive historical equity curve.

The objective is to determine whether a strategy hypothesis produces:

```text
Positive Expectancy
        +
Controlled Risk
        +
Repeatable Behavior
        +
Parameter Stability
        +
Out-of-Sample Persistence
```

before considering the strategy validated.

Current status:

```text
EA-069 = RESEARCH
EA-070 = RESEARCH
EA-071 = RESEARCH

LIVE VALIDATION = NONE
```

```

