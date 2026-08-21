# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the standard research and backtesting methodology for the **XAUUSD MT5 EA Research** repository.

The objective is to evaluate Expert Advisor ideas using a consistent, reproducible, and evidence-based process.

The methodology is designed to prevent:

* selecting strategies based only on attractive equity curves;
* changing parameters without recording them;
* declaring an EA profitable from insufficient evidence;
* mixing different backtest configurations;
* hiding failed experiments;
* optimizing before a baseline strategy has been tested.

Every EA must follow the same basic research workflow.

---

# 2. Research Principle

The repository follows:

**Idea → Implementation → Baseline Test → Analysis → Controlled Experiment → Validation → Conclusion**

The first objective is not optimization.

The first objective is to answer:

> Does the original trading hypothesis demonstrate measurable evidence of an edge?

A simple baseline must therefore be tested before additional filters or optimization are introduced.

---

# 3. Repository Evidence Structure

Each EA should have three separate layers.

## Implementation

```text
EAs/
└── EA-XXX_Name/
    ├── EA-XXX_Name.mq5
    └── README.md
```

Contains:

* source code;
* strategy logic;
* parameters;
* implementation documentation.

---

## Backtest Evidence

```text
Backtest/
└── EA-XXX_Name/
    ├── README.md
    ├── report.html
    └── report-associated files
```

Contains:

* original MetaTrader 5 Strategy Tester report;
* charts generated with the report;
* exact parameters;
* performance results;
* PASS/FAIL assessment for individual test runs.

Original Strategy Tester evidence should be preserved.

---

## Research

```text
Research/
└── README.md
```

Contains:

* research hypotheses;
* experiments;
* observations;
* comparisons;
* rejected configurations;
* unresolved questions;
* current research conclusions.

Backtest evidence and research interpretation must remain distinguishable.

---

# 4. Strategy Definition

Before testing an EA, its trading rules must be documented.

At minimum:

### Market

* Symbol
* Timeframe

### Entry

* BUY condition
* SELL condition

### Exit

* Stop Loss
* Take Profit
* other exit rules if applicable

### Trade Management

Examples:

* Break Even
* Trailing Stop
* Maximum positions
* Spread filter

### Inputs

Every parameter that can materially affect results must be recorded.

The documented strategy and the tested implementation must be consistent.

If the actual backtest uses different parameters, the backtest configuration takes precedence for interpreting that specific experiment.

---

# 5. Baseline First

Every new strategy should begin with a simple baseline test.

The baseline should answer whether the core signal itself has useful information.

Avoid immediately adding:

* multiple indicators;
* session filters;
* volatility filters;
* complex exits;
* parameter optimization;
* machine learning;
* excessive risk-management logic.

If the baseline fails, record the failure before testing modifications.

Failed experiments are research evidence and must not be deleted simply because their results are poor.

---

# 6. Backtest Configuration

Every backtest must record its exact configuration.

Minimum required information:

| Category   | Required Information          |
| ---------- | ----------------------------- |
| EA         | EA name/version               |
| Symbol     | Exact broker symbol           |
| Timeframe  | Tested timeframe              |
| Period     | Start and end date            |
| Data       | Tick/history quality          |
| Deposit    | Initial capital               |
| Currency   | Account currency              |
| Leverage   | Test leverage                 |
| Lot        | Position size                 |
| Spread     | Spread rule/filter            |
| Signal     | Signal parameters             |
| SL         | Stop Loss                     |
| TP         | Take Profit                   |
| Break Even | Enabled/disabled + parameters |
| Trailing   | Enabled/disabled + parameters |

Do not assume that EA defaults were used.

The **Strategy Tester report is the source of truth for the parameters actually used in a test run**.

---

# 7. Backtest Evidence

A backtest is not considered properly documented without evidence.

The preferred primary evidence is the original:

**MetaTrader 5 Strategy Tester HTML report**

Associated Strategy Tester images should be preserved with it when generated.

The evidence must allow another reviewer to verify:

* what was tested;
* which parameters were used;
* what period was tested;
* data quality;
* number of trades;
* performance;
* drawdown.

Screenshots alone should not replace the original numerical report when the report is available.

---

# 8. Core Metrics

At minimum, record:

### Profitability

* Total Net Profit
* Gross Profit
* Gross Loss
* Profit Factor
* Expected Payoff

### Risk

* Maximum Balance Drawdown
* Maximum Equity Drawdown
* Relative Drawdown

### Risk-Adjusted Performance

* Sharpe Ratio
* Recovery Factor

### Trade Statistics

* Total Trades
* Winning Trades
* Losing Trades
* Win Rate
* Average Profit Trade
* Average Loss Trade
* Maximum Consecutive Wins
* Maximum Consecutive Losses

Where useful, also record:

* BUY performance;
* SELL performance;
* holding time;
* MFE;
* MAE;
* time-of-day distribution.

---

# 9. Minimum Sample Size

A very small number of trades is insufficient for a reliable strategy conclusion.

Use the following research convention:

| Total Trades | Interpretation              |
| -----------: | --------------------------- |
|        < 100 | Insufficient evidence       |
|      100–299 | Preliminary evidence        |
|      300–999 | Useful research sample      |
|      ≥ 1,000 | Stronger statistical sample |

Trade count alone does not prove robustness.

A large losing sample can provide strong evidence that a tested configuration should be rejected.

A large profitable sample still requires validation before the EA can be considered robust.

---

# 10. Experiment-Level PASS / FAIL

Every individual experiment must receive one of three statuses:

**PASS**

**FAIL**

**INCONCLUSIVE**

These statuses apply to the **tested configuration**, not automatically to the entire EA concept.

---

## FAIL

A configuration should be marked FAIL when the evidence clearly demonstrates unacceptable performance.

Examples include:

* Profit Factor below 1.0;
* negative Expected Payoff;
* persistent negative Net Profit;
* catastrophic drawdown;
* clearly deteriorating balance/equity;
* insufficient performance relative to risk.

A strategy does not need to fail every metric to be rejected.

One severe risk characteristic can be sufficient.

For example:

> A configuration producing extreme drawdown may be rejected even if Net Profit is positive.

---

## INCONCLUSIVE

Use INCONCLUSIVE when the test cannot support a reliable conclusion.

Examples:

* insufficient number of trades;
* inadequate historical period;
* questionable data quality;
* incorrect test configuration;
* execution error;
* corrupted report;
* strategy implementation does not match intended rules.

An inconclusive test should not be treated as PASS or FAIL.

---

## PASS

PASS means:

> The tested configuration has produced sufficient evidence to justify continued validation.

PASS does **not** mean:

> Ready for live trading.

As a minimum research gate, a PASS candidate should generally demonstrate:

* positive Net Profit;
* Profit Factor greater than 1.0;
* positive Expected Payoff;
* acceptable drawdown;
* sufficient number of trades;
* no obvious catastrophic balance/equity behavior.

More demanding thresholds may be introduced later when enough EA experiments exist to establish meaningful project-wide benchmarks.

---

# 11. Configuration vs EA Status

This distinction is mandatory.

Example:

```text
Experiment 01
EMA20
TrendBars = 3
SL = 300
TP = 600

Result: FAIL
```

This proves:

**this configuration failed.**

It does not automatically prove:

**every EMA20 strategy fails.**

Therefore maintain two levels of status.

### Experiment Status

`PASS / FAIL / INCONCLUSIVE`

### EA Research Status

`IN PROGRESS / CANDIDATE / REJECTED`

---

# 12. EA Research Status

## IN PROGRESS

Use when:

* experiments are still being performed;
* relevant hypotheses remain untested;
* there is insufficient evidence for final rejection or promotion.

---

## CANDIDATE

Use when:

* at least one configuration passes the baseline research gate;
* results justify robustness testing;
* the strategy has not yet completed validation.

CANDIDATE does not mean production-ready.

---

## REJECTED

Use when the research evidence is sufficient to stop further investigation of the current strategy concept.

The reason must be documented.

Example:

```text
EA STATUS: REJECTED

Reason:
Repeated controlled experiments failed to produce positive expectancy,
and no remaining hypothesis justifies further testing.
```

---

# 13. Controlled Experiment Rule

Change as few variables as possible between experiments.

Preferred:

```text
Experiment 01
TrendBars = 3

Experiment 02
TrendBars = 1
```

Not preferred:

```text
Experiment 01
TrendBars = 3
SL = 300
TP = 600
No trailing

Experiment 02
TrendBars = 1
SL = 500
TP = 900
Trailing ON
Session filter ON
RSI filter ON
```

The second example makes it difficult to determine which change caused the performance difference.

Whenever practical:

> Change one major hypothesis at a time.

---

# 14. Optimization Rule

Do not begin large-scale parameter optimization before the basic strategy behavior is understood.

Optimization can create attractive historical results without establishing genuine robustness.

The preferred sequence is:

```text
Baseline
↓
Identify weakness
↓
Form hypothesis
↓
Change one major variable
↓
Backtest
↓
Compare
↓
Repeat only if justified
```

Only after a strategy demonstrates promising behavior should broader optimization be considered.

---

# 15. No Cherry-Picking

All meaningful experiments should be retained.

Do not:

* delete losing tests;
* publish only the best parameter combination;
* silently change test periods;
* hide unfavorable market conditions;
* select only the best BUY/SELL direction after seeing results without retesting it as a new experiment.

If an observation from one test generates a new hypothesis, that hypothesis must be evaluated in a separate test.

Example:

Experiment 01 shows:

`BUY Win Rate > SELL Win Rate`

Valid conclusion:

> BUY may deserve independent investigation.

Invalid conclusion:

> BUY-only is profitable.

The latter requires another experiment.

---

# 16. In-Sample and Out-of-Sample

Once a strategy becomes a **CANDIDATE**, historical data should be separated conceptually into:

### In-Sample

Used for:

* strategy development;
* parameter exploration;
* hypothesis generation.

### Out-of-Sample

Used for:

* independent validation;
* checking whether performance persists on unseen data.

Out-of-sample results should not be repeatedly used to redesign the strategy, otherwise they effectively become part of the development sample.

---

# 17. Robustness Validation

A strategy that passes the initial backtest should not immediately be considered ready for live deployment.

Validation may include:

1. Different historical periods.
2. Out-of-sample testing.
3. Different market regimes.
4. Parameter sensitivity.
5. Spread sensitivity.
6. Execution-cost sensitivity.
7. Forward testing.

The exact validation protocol can evolve as the research repository matures.

The baseline research stage should remain simple.

---

# 18. Parameter Sensitivity

A robust strategy should not depend entirely on one extremely precise parameter combination.

Example:

If:

```text
EMA = 19 → FAIL
EMA = 20 → extremely profitable
EMA = 21 → FAIL
```

the result should be treated cautiously.

More stable behavior across nearby reasonable parameters provides stronger evidence than a single isolated optimum.

---

# 19. Risk Before Return

Profitability alone is insufficient.

Always evaluate:

**Return together with drawdown.**

A strategy generating positive profit with unacceptable capital loss is not automatically acceptable.

Particular attention should be paid to:

* maximum drawdown;
* losing streaks;
* recovery factor;
* balance/equity stability.

Capital preservation is part of the strategy evaluation.

---

# 20. Reproducibility

Another researcher should be able to reconstruct an experiment from the repository.

Each experiment therefore needs:

```text
EA source/version
+
exact inputs
+
symbol
+
timeframe
+
test period
+
data quality
+
Strategy Tester report
+
documented result
```

If these cannot be determined, the experiment is not fully reproducible.

---

# 21. Research Workflow

For every new EA:

```text
1. Define hypothesis
        ↓
2. Implement EA
        ↓
3. Document EA
        ↓
4. Run baseline backtest
        ↓
5. Save original evidence
        ↓
6. Record metrics
        ↓
7. Assign experiment PASS / FAIL / INCONCLUSIVE
        ↓
8. Analyze why
        ↓
9. Define next hypothesis
        ↓
10. Run controlled experiment
```

Repeat only while additional experiments are justified.

---

# 22. Promotion Workflow

A successful EA should progress through stages rather than jumping directly from backtest to live trading.

```text
IDEA
 ↓
IMPLEMENTED
 ↓
BASELINE TESTED
 ↓
RESEARCH CANDIDATE
 ↓
ROBUSTNESS TESTED
 ↓
OUT-OF-SAMPLE VALIDATED
 ↓
FORWARD TESTED
 ↓
LIVE CANDIDATE
```

Each stage requires evidence from the previous stage.

---

# 23. Documentation Rule

Never write conclusions that exceed the available evidence.

Use:

> This configuration failed.

Instead of:

> EMA strategies do not work.

Use:

> BUY signals had a higher win rate in this experiment.

Instead of:

> BUY-only trading is profitable.

Use:

> This configuration passed the initial research gate.

Instead of:

> This EA is profitable and ready for live trading.

---

# 24. Source of Truth

For an individual backtest:

**Original MT5 Strategy Tester report = numerical source of truth.**

For implementation:

**EA source code = implementation source of truth.**

For research conclusions:

**Research documentation + preserved backtest evidence = research source of truth.**

When documentation conflicts with actual test evidence, the original evidence must be checked and the documentation corrected.

---

# 25. Current Example — EA-015

EA-015 Experiment 01 provides an example of this methodology.

Test configuration:

```text
XAUUSD.PRO
M1
EMA20
Minimum Trend Bars = 3
SL = 300 points
TP = 600 points
Break Even = OFF
Trailing = OFF
```

Observed results included:

```text
Trades:             3,508
Net Profit:         -$992.93
Profit Factor:      0.87
Expected Payoff:    -$0.28
Sharpe Ratio:       -5.00
Maximum Drawdown:   ~99.32%
```

Experiment status:

**FAIL**

EA research status:

**IN PROGRESS**

This distinction demonstrates the central principle of the repository:

> Reject failed configurations based on evidence without prematurely rejecting untested hypotheses.

---

# 26. Final Rule

Every conclusion in this repository must follow:

**Hypothesis → Test → Artifact → Evidence → Conclusion**

No strategy receives PASS because it looks promising.

No strategy receives FAIL because it sounds weak.

The decision must follow the recorded evidence.
