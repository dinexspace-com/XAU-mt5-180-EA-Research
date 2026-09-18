# EA Research & Backtesting Methodology

This document defines the standard research, backtesting, optimization, and validation methodology used for Expert Advisors (EAs) in the `xauusd-mt5-ea-research` repository.

The methodology is designed to keep EA development reproducible and to separate strategy ideas from implementation and empirical evidence.

---

## 1. Research Workflow

Every EA should follow the same general process:

```text
Strategy Idea
    ↓
Research Hypothesis
    ↓
Explicit Trading Rules
    ↓
MQL5 Implementation
    ↓
Baseline Backtest
    ↓
Optimization
    ↓
Out-of-Sample Testing
    ↓
Robustness Testing
    ↓
Forward / Demo Testing
    ↓
Assessment
```

A strategy must not be considered validated simply because one historical backtest or optimization result is profitable.

---

## 2. Repository Separation

Three types of information are maintained separately.

### Strategy Implementation

```text
EAs/
```

Contains:

- MQL5 source code
- EA-specific technical documentation

### Testing Evidence

```text
Backtest/
```

Contains:

- MetaTrader 5 Strategy Tester reports
- test configurations
- charts
- optimization evidence
- validation evidence

### Research

```text
Research/
```

Contains:

- strategy hypotheses
- research reasoning
- assumptions
- experimental findings

The fundamental rule is:

```text
Hypothesis ≠ Implementation ≠ Evidence
```

---

## 3. EA Identification

Each EA must have a unique identifier.

Naming convention:

```text
EA-<ID>_<Strategy_Name>
```

Example:

```text
EA-067_Breakout_EMA_Filter
```

The same identifier should be used consistently across:

```text
EAs/
Backtest/
Research documentation
Strategy Tester comments / Magic Number conventions
```

---

## 4. Baseline Backtest

Before optimization, the EA should be tested using a defined baseline configuration.

The baseline establishes how the original strategy behaves before parameter searching.

Record at minimum:

| Field | Required |
|---|---|
| EA version | Yes |
| Symbol | Yes |
| Timeframe | Yes |
| Test period | Yes |
| Tick model | Yes |
| Initial deposit | Yes |
| Leverage | Yes |
| Lot size | Yes |
| EA inputs | Yes |
| Broker / symbol variant | Yes |
| Strategy Tester report | Yes |

The original MT5 Strategy Tester report should be retained as evidence.

---

## 5. Historical Data

Historical-data quality must be recorded with every important test.

For final validation, preference should be given to:

```text
Every tick based on real ticks
```

when appropriate real tick history is available.

Lower-detail modelling modes may be used during exploratory research to reduce testing time.

However, candidate configurations should be re-tested with high-fidelity data before final assessment.

---

## 6. Trading Environment

The testing environment may materially affect results.

Record relevant information including:

```text
Broker
Symbol
Contract specification
Spread
Commission
Leverage
Execution assumptions
Initial deposit
Lot size
```

Broker-specific symbol names must be preserved.

For example:

```text
XAUUSD
XAUUSD.PRO
XAUUSDm
```

must not automatically be assumed to have identical trading conditions.

---

## 7. Metrics

Each important backtest should evaluate at least the following metrics.

### Profitability

```text
Total Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
```

### Risk

```text
Balance Drawdown
Equity Drawdown
Maximum Drawdown %
Recovery Factor
```

### Trade Statistics

```text
Total Trades
Winning Trades
Losing Trades
Long Trades
Short Trades
Average Profit Trade
Average Loss Trade
Largest Profit Trade
Largest Loss Trade
```

### Stability

Where available:

```text
Sharpe Ratio
AHPR
GHPR
LR Correlation
Consecutive Wins
Consecutive Losses
```

### Trade Behaviour

Where relevant:

```text
MFE
MAE
Position Holding Time
Entries by Hour
Entries by Weekday
Entries by Month
```

No single metric should be used as the sole basis for accepting an EA.

---

## 8. Optimization

Optimization is performed after a baseline test establishes the initial behaviour of the strategy.

The purpose of optimization is to explore parameter behaviour.

It is not simply:

```text
Find maximum historical profit
```

Instead, optimization should search for parameter regions that demonstrate acceptable behaviour across multiple nearby configurations.

---

## 9. Optimization Parameters

Only parameters relevant to the research question should be optimized.

For example, a breakout strategy may investigate:

```text
Breakout Lookback
Breakout Buffer
EMA Period
Stop Loss
Take Profit
Break Even
Trailing Stop
```

Avoid optimizing every available parameter simultaneously without a defined research reason.

This increases the search space and increases the risk of fitting the strategy to historical noise.

---

## 10. Candidate Selection

Optimization candidates should be evaluated using multiple metrics.

A candidate should not be selected solely because it has:

```text
Highest Net Profit
```

Consider together:

```text
Net Profit
Profit Factor
Maximum Drawdown
Trade Count
Expected Payoff
Recovery Factor
Parameter stability
```

Preference should be given to stable parameter regions rather than isolated extreme results.

---

## 11. In-Sample and Out-of-Sample Testing

Historical data used for parameter discovery should be separated from data used for independent validation where practical.

```text
Historical Data
      │
      ├── In-Sample
      │      ↓
      │   Research
      │   Optimization
      │
      └── Out-of-Sample
             ↓
          Validation
```

The Out-of-Sample period should not be used to repeatedly tune parameters and then still be described as independent validation.

If parameters are changed because of Out-of-Sample results, a new independent validation period is required.

---

## 12. Monthly Testing

For strategies sensitive to changing market conditions, results should also be inspected by month.

Example:

```text
January
February
March
...
```

This helps identify whether aggregate profitability is being generated by:

- consistent behaviour,
- one exceptional month,
- one market regime,
- or a small number of exceptional trades.

A profitable combined period does not imply that performance is stable across its component periods.

---

## 13. Robustness Testing

Promising candidates should undergo robustness tests.

### Parameter Perturbation

Change important parameters slightly around the selected configuration.

Example:

```text
Selected EMA = 50

Test:
45
48
50
52
55
```

A dramatic collapse after a very small parameter change is a warning that the selected configuration may be overly sensitive.

### Different Time Periods

Test the strategy across different historical periods.

### Trading Costs

Where possible, test more conservative trading costs.

### Broker / Data Variation

Where suitable data is available, compare behaviour using another broker or data source.

### Execution Conditions

Execution delay, spread changes and other realistic conditions should be investigated where relevant.

---

## 14. Overfitting Control

Optimization creates a risk of overfitting.

Warning signs include:

```text
One exceptional parameter combination
        +
Poor neighbouring combinations
```

or:

```text
Excellent In-Sample result
        +
Poor Out-of-Sample result
```

or:

```text
Profit concentrated in a very short period
```

These patterns require further investigation before the strategy can progress.

---

## 15. Forward Testing

After historical validation, promising EA configurations should be tested under forward conditions.

Preferred progression:

```text
Backtest
    ↓
Out-of-Sample
    ↓
Robustness
    ↓
Demo / Forward Test
    ↓
Small controlled live test
```

Forward testing is used to observe behaviour under conditions not contained in the historical optimization process.

---

## 16. Evidence

Every important conclusion should be traceable to an artifact.

Examples:

```text
.mq5 source
.html Strategy Tester report
.xml optimization report
.set parameter file
.png Strategy Tester charts
README.md test summary
```

Do not replace original evidence with manually typed summaries.

A summary may describe evidence, but the original artifact should be retained whenever possible.

---

## 17. File Naming

Backtest artifacts should use descriptive names.

Recommended format:

```text
<EA>_<TEST-TYPE>_<SYMBOL>_<TIMEFRAME>_<PERIOD>
```

Examples:

```text
EA-067_BASELINE_XAUUSD_M1_2026-01_2026-03.html

EA-067_OOS_XAUUSD_M1_2026-04.html

EA-067_OPT_XAUUSD_M1_2025.xml
```

This makes test evidence understandable without opening every file.

---

## 18. Test Status

Each test may have one of three statuses:

```text
RESEARCH
PASS
FAIL
```

### RESEARCH

The experiment is still being investigated or does not yet have sufficient validation evidence.

### PASS

The test satisfies the acceptance criteria defined for that experiment.

### FAIL

One or more predefined acceptance criteria were not satisfied.

A profitable result does not automatically mean PASS.

A losing result does not make the artifact useless; failed tests remain part of the research record.

---

## 19. Acceptance Criteria

Acceptance criteria should be defined before interpreting the final result whenever practical.

Criteria may include:

```text
Minimum Profit Factor
Maximum Drawdown
Minimum Trade Count
Positive Net Profit
Out-of-Sample performance
Monthly consistency
Parameter robustness
```

Thresholds are strategy-specific and should not be invented after seeing the result simply to make a test pass.

---

## 20. Failed Experiments

Failed experiments should normally be preserved.

Example:

```text
Backtest/
└── EA-067_Breakout_EMA_Filter/
    ├── baseline/
    ├── optimization/
    ├── validation/
    └── failed-tests/
```

Keeping failed experiments helps prevent the same unsuccessful configuration from being rediscovered and tested repeatedly.

---

## 21. Reproducibility Rule

A result should be considered reproducible only when another researcher has enough information to reconstruct the test.

At minimum:

```text
EA source/version
+
EA parameters
+
Symbol
+
Timeframe
+
Historical period
+
Tester configuration
+
Trading environment
+
Original result artifact
```

If critical information is missing, the result should be labelled accordingly rather than reconstructed from assumptions.

---

## 22. Current Reference Implementation

The first documented strategy using this methodology is:

```text
EA-067_Breakout_EMA_Filter
```

Current reference environment:

```text
Platform: MetaTrader 5
Language: MQL5
Primary instrument: XAUUSD
Research timeframe: M1
```

EA-067 is used as a research case and does not define universal parameter values for future EAs.

---

## 23. Core Principle

The repository follows the principle:

```text
Research the idea
        ↓
Implement the rules
        ↓
Test the implementation
        ↓
Preserve the evidence
        ↓
Validate outside optimization data
        ↓
Test robustness
        ↓
Only then assess the strategy
```

Historical profitability alone is not evidence of future profitability.
