# Research Methodology

## Purpose

This document defines the standard methodology used to develop, backtest, evaluate, and research Expert Advisors in the `xauusd-mt5-ea-research` repository.

The objective is to maintain a simple and reproducible research process where every strategy begins with a clearly defined baseline and every subsequent modification can be compared against that baseline.

The general process is:

```text
Trading Idea
    ↓
Baseline EA
    ↓
Baseline Backtest
    ↓
Performance Assessment
    ↓
Research Hypothesis
    ↓
Controlled Modification
    ↓
New Backtest
    ↓
Comparison
    ↓
Validation
```

The methodology prioritizes reproducibility and controlled experimentation over finding the highest historical profit.

---

# 1. Strategy Definition

Each EA should begin with a clearly defined trading idea.

The strategy description should identify at minimum:

- entry logic;
- exit logic;
- indicator parameters;
- Stop Loss;
- Take Profit;
- position management;
- relevant filters;
- symbol and timeframe assumptions, if any.

The implemented source code is the authoritative definition of what the EA actually does.

Strategy documentation must describe the implemented behavior rather than an intended behavior that does not exist in the code.

Each EA is stored under:

```text
EAs/
└── EA-XXX_Strategy_Name/
    ├── EA-XXX_Strategy_Name.mq5
    └── README.md
```

The EA README documents the implementation.

---

# 2. Baseline First

Every strategy must first be tested in a simple baseline configuration.

The baseline exists to answer:

> Does the core trading idea show useful behavior before additional optimization or complexity is introduced?

A baseline should avoid unnecessary filters and excessive parameter optimization.

Example:

```text
Core Signal
+
Basic SL / TP
+
Basic execution controls
        ↓
Baseline Backtest
```

The baseline result must be preserved even when it fails.

A failed baseline is still useful research evidence.

---

# 3. Backtest Environment

Backtests are performed using the MetaTrader 5 Strategy Tester.

Each documented backtest should record enough information to reproduce the experiment.

At minimum:

```text
EA
Symbol
Timeframe
Test period
Data quality
Initial deposit
Leverage
Lot size
Stop Loss
Take Profit
Spread restrictions
Relevant indicator parameters
Position-management settings
```

When available, real tick history should be used.

The exact test environment must be documented because results may differ across:

- brokers;
- symbol specifications;
- spreads;
- execution conditions;
- historical data;
- test periods.

---

# 4. Preserve Raw Backtest Evidence

The original MetaTrader Strategy Tester output should be retained.

Recommended structure:

```text
Backtest/
└── EA-XXX_Strategy_Name/
    ├── README.md
    ├── Strategy Tester report
    ├── Balance graph
    ├── Trade distribution charts
    ├── MFE / MAE charts
    └── Holding-time chart
```

The raw Strategy Tester report is the primary evidence.

The README summarizes the result but should not replace the original report.

Future experiments should not overwrite the original baseline artifacts.

---

# 5. Core Evaluation Metrics

A strategy must not be evaluated using Net Profit alone.

The following metrics should be reviewed together.

## Profitability

```text
Total Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
```

Profit Factor is calculated conceptually as:

```text
Profit Factor = Gross Profit / |Gross Loss|
```

A Profit Factor near or below `1.0` indicates that gross profits are not meaningfully exceeding gross losses.

---

## Risk

Primary risk metrics include:

```text
Balance Drawdown
Equity Drawdown
Maximum Consecutive Losses
Largest Losing Trade
```

A strategy producing positive profit but unacceptable drawdown should not automatically be considered successful.

---

## Trade Statistics

Review:

```text
Total Trades
Winning Trades
Losing Trades
Win Rate
Average Profit Trade
Average Loss Trade
Largest Profit Trade
Largest Loss Trade
```

Win rate must be interpreted together with average win and average loss.

A low-win-rate strategy can potentially work when:

```text
Average Winner >> Average Loser
```

while a high win rate does not automatically indicate a robust strategy.

---

## Risk-Adjusted Performance

Where available, review:

```text
Sharpe Ratio
Recovery Factor
```

These metrics provide additional context about the relationship between returns and risk.

They should not be interpreted independently from the equity curve and drawdown.

---

# 6. Equity Curve Review

The balance/equity curve must be inspected visually in addition to numerical metrics.

Questions include:

```text
Is growth reasonably consistent?

Are profits concentrated in one short period?

Are there prolonged losing periods?

Are previous gains later surrendered?

Does the strategy experience extreme drawdowns?

Does performance change materially over time?
```

A profitable final balance does not necessarily imply stable behavior.

---

# 7. Trade Distribution Analysis

When available, trades should be examined by:

```text
Hour
Weekday
Month
BUY / SELL direction
```

The purpose is to identify patterns that may justify a research hypothesis.

Example:

```text
Observation:
Performance appears weak during certain hours.

        ↓

Hypothesis:
A session filter may improve signal quality.

        ↓

Experiment:
Retest with predefined session rules.
```

An observed historical pattern is not automatically a valid trading rule.

It must be tested separately.

---

# 8. MFE / MAE Analysis

Where MetaTrader provides the data, Maximum Favorable Excursion (MFE) and Maximum Adverse Excursion (MAE) should be retained for research.

Conceptually:

```text
MFE
= favorable price movement while a trade is open

MAE
= adverse price movement while a trade is open
```

These statistics may help investigate:

- Stop Loss placement;
- Take Profit placement;
- exit efficiency;
- Break Even behavior;
- trailing behavior.

MFE/MAE observations should generate hypotheses rather than automatic parameter changes.

---

# 9. Holding-Time Analysis

Position holding time should be documented when available.

Review:

```text
Minimum holding time
Average holding time
Maximum holding time
Holding-time distribution
```

This helps characterize whether an EA behaves primarily as:

```text
very short-term
intraday
or longer-duration
```

It may also reveal whether a small number of unusually long trades materially affect results.

---

# 10. Baseline Assessment

After the baseline backtest, assign an explicit research assessment.

Possible status:

```text
PASS
FAIL
INCONCLUSIVE
```

### PASS

The strategy demonstrates sufficiently promising baseline characteristics to justify further validation.

### FAIL

The strategy fails important profitability or risk requirements.

A FAIL does not mean the research must be deleted.

It means the current configuration is not accepted as a deployable strategy.

### INCONCLUSIVE

The available evidence is insufficient to make a reliable assessment.

Examples include:

- insufficient trades;
- insufficient test period;
- incomplete data;
- invalid test conditions.

---

# 11. Research Hypotheses

Changes to an EA should originate from a specific research question.

Example:

```text
Observation
    ↓
Hypothesis
    ↓
Modification
    ↓
Backtest
    ↓
Comparison
```

A useful hypothesis should be testable.

For example:

```text
Observation:
Many weak entries appear during non-trending conditions.

Hypothesis:
Adding a trend filter may improve entry quality.

Experiment:
Add one clearly defined trend condition and rerun the test.
```

---

# 12. One Major Change at a Time

During early research, avoid modifying many strategy components simultaneously.

Preferred:

```text
Baseline
   ↓
Add Filter A
   ↓
Test
   ↓
Compare
```

Avoid:

```text
Baseline
   ↓
New indicator
+ New session
+ New SL
+ New TP
+ New trailing logic
   ↓
Backtest
```

If many variables change simultaneously, it becomes difficult to identify what caused the result.

---

# 13. Compare Against the Baseline

Every experiment should be compared against the original baseline.

Comparison should include at least:

| Category | Metrics |
|---|---|
| Profitability | Net Profit, Profit Factor, Expected Payoff |
| Risk | Balance DD, Equity DD |
| Stability | Sharpe Ratio, Recovery Factor |
| Trades | Total Trades, Win Rate |
| Payoff | Average Win, Average Loss |
| Loss behavior | Maximum Consecutive Losses |

The goal is not simply:

```text
More Profit
```

The goal is:

```text
Better overall risk-adjusted behavior
```

---

# 14. Avoid Premature Optimization

Parameter optimization should not be used immediately to rescue a weak trading idea.

Preferred sequence:

```text
1. Implement core idea
2. Run baseline
3. Understand behavior
4. Identify weakness
5. Form hypothesis
6. Test modification
7. Validate improvement
8. Only then consider parameter optimization
```

This reduces the risk of fitting parameters to historical noise.

---

# 15. Out-of-Sample Validation

A modification that performs better on the original test period should not automatically be accepted.

The improved strategy should subsequently be tested on historical data that was not used to design the modification.

Conceptually:

```text
Development Period
        ↓
Develop / Research
        ↓
Candidate Strategy
        ↓
Unseen Test Period
        ↓
Out-of-Sample Result
```

If performance disappears outside the development period, the apparent improvement may be caused by overfitting.

---

# 16. Robustness

A strategy considered for further development should eventually be evaluated across different conditions.

Examples:

```text
Different historical periods
Different volatility regimes
Different market conditions
Potentially different broker data
```

The purpose is not to require identical performance everywhere.

The purpose is to determine whether the strategy's behavior is reasonably persistent rather than dependent on one specific historical sample.

---

# 17. Research Integrity

The following rules apply throughout the repository.

### Preserve failed experiments

Failed strategies and experiments provide useful evidence and should not be silently removed simply because their performance is poor.

### Preserve original results

Do not replace baseline reports with later optimized reports.

### Separate evidence from hypotheses

Clearly distinguish:

```text
Measured Result
```

from:

```text
Research Hypothesis
```

### Do not claim future profitability

Historical results are evidence about historical behavior only.

They do not guarantee future results.

---

# 18. Repository Workflow

The standard workflow is:

```text
EAs/
│
│   Source code
│   Strategy documentation
│
▼
Backtest/
│
│   Raw Strategy Tester evidence
│   Backtest summary
│
▼
Research/
│
│   Observations
│   Problems
│   Hypotheses
│   Experiment direction
│
▼
Validation
│
│   New controlled tests
│   Out-of-sample tests
│
▼
Decision
```

Repository structure:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-XXX_Strategy_Name/
│       ├── EA-XXX_Strategy_Name.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-XXX_Strategy_Name/
│       ├── README.md
│       └── Test artifacts
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

# 19. EA-029 Baseline Example

The first documented application of this methodology is:

```text
EA-029_Ichimoku_Kijun_Pullback
```

Baseline:

```text
Symbol        : XAUUSD.PRO
Timeframe     : M1
Period        : 2026.01.02 – 2026.03.01
Data          : 100% real ticks

Total Trades  : 1,769
Net Profit    : -$22.77
Profit Factor : 0.99
Win Rate      : 32.90%
Equity DD     : 91.54%
```

The baseline therefore receives:

```text
FAIL
```

The result is retained as the control experiment for subsequent EA-029 research.

The failure does not justify arbitrary optimization.

Instead, it establishes the starting point for controlled hypotheses and subsequent testing.

---

# 20. Research Principle

The repository follows a simple principle:

> Define the idea, test the simplest valid implementation, preserve the evidence, understand why it behaves as it does, and only then modify it.

The objective is not to produce a backtest that looks profitable.

The objective is to determine whether a strategy demonstrates evidence of a repeatable and sufficiently robust trading edge.
