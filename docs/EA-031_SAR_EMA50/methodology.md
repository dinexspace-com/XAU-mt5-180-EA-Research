# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard research methodology used for Expert Advisors in the `xauusd-mt5-ea-research` repository.

The objective is to maintain a simple, reproducible, and transparent process for:

- Implementing trading ideas.
- Running baseline backtests.
- Recording results.
- Comparing EA versions.
- Preserving failed experiments.
- Testing improvements.
- Reducing the risk of overfitting.

A strategy is not considered successful simply because one backtest is profitable.

---

# 1. Research Workflow

Every EA should follow the same basic research process:

```text
Strategy Idea
    ↓
EA Implementation
    ↓
Baseline Backtest
    ↓
Result Analysis
    ↓
PASS / FAIL
    ↓
Research Improvements
    ↓
Retest
    ↓
Out-of-Sample Validation
```

The baseline version should always be preserved.

Do not overwrite or remove a failed baseline simply because a later version performs better.

---

# 2. EA Identification

Each strategy receives a unique EA number.

Example:

```text
EA-031_SAR_EMA50
```

Naming convention:

```text
EA-[NUMBER]_[STRATEGY_NAME]
```

Examples:

```text
EA-031_SAR_EMA50
EA-032_...
EA-033_...
```

The same EA identifier should be used consistently across source code and backtest folders.

---

# 3. EA Source Code

EA source files are stored under:

```text
EAs/
└── EA-XXX_STRATEGY/
    ├── EA-XXX_STRATEGY.mq5
    └── README.md
```

The EA README should document at minimum:

- Strategy concept.
- Indicators used.
- BUY conditions.
- SELL conditions.
- Stop Loss.
- Take Profit.
- Position management.
- Trading filters.
- Input parameters.
- Symbol/timeframe assumptions.
- Important implementation notes.

The README should describe the actual implementation in the `.mq5` source code.

It should not claim profitability unless supported by separate backtest evidence.

---

# 4. Baseline Backtest

Every new EA should first receive a baseline backtest.

The purpose of the baseline is not to find the best parameters.

The purpose is to answer:

> Does the original strategy demonstrate useful behavior before optimization?

The baseline result becomes the reference point for future experiments.

---

# 5. Backtest Evidence

Backtest evidence is stored under:

```text
Backtest/
└── EA-XXX_STRATEGY/
```

Example:

```text
Backtest/
└── EA-031_SAR_EMA50/
    ├── README.md
    ├── Strategy Tester report
    └── Strategy Tester charts
```

Whenever possible, preserve the original MetaTrader 5 Strategy Tester report.

Do not record only manually copied statistics.

The original report provides evidence that allows the test configuration and results to be reviewed later.

---

# 6. Required Backtest Information

Every documented backtest should record at least:

## Test Environment

```text
EA
Symbol
Timeframe
Test period
Initial deposit
Currency
Leverage
History quality
```

## EA Parameters

Important EA inputs should be recorded, including where applicable:

```text
Lot size
Stop Loss
Take Profit
Spread filter
Maximum positions
Break Even
Trailing Stop
Other strategy-specific parameters
```

## Performance

At minimum record:

```text
Total Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Sharpe Ratio
Total Trades
Winning Trades
Losing Trades
```

Additional statistics may be recorded when useful.

---

# 7. Core Evaluation Metrics

No single metric should determine whether an EA is good.

Several metrics should be evaluated together.

---

## 7.1 Net Profit

Net Profit measures the final monetary result of the backtest.

```text
Net Profit > 0
```

is necessary for a profitable test, but positive Net Profit alone is not sufficient evidence that a strategy is robust.

---

## 7.2 Profit Factor

Profit Factor is:

```text
Gross Profit
────────────
Gross Loss
```

Interpretation:

```text
PF < 1.00
Strategy lost money in the tested sample.

PF = 1.00
Approximately break-even before considering other practical issues.

PF > 1.00
Gross profits exceeded gross losses.
```

A Profit Factor above 1 does not automatically qualify an EA for deployment.

---

## 7.3 Expected Payoff

Expected Payoff represents the average expected result per trade in the Strategy Tester report.

A negative Expected Payoff indicates negative historical expectancy for the tested configuration.

---

## 7.4 Drawdown

Drawdown measures the decline from account equity or balance peaks.

Both monetary and percentage drawdown should be recorded.

Example:

```text
Maximum Drawdown: 25%
```

Lower drawdown is generally preferable when comparing strategies with similar returns.

Extremely high drawdown can make an otherwise profitable strategy impractical.

---

## 7.5 Sharpe Ratio

Sharpe Ratio provides information about return relative to variability.

It should be used as supporting evidence rather than as the sole acceptance criterion.

---

## 7.6 Win Rate

Win Rate is:

```text
Winning Trades
────────────── × 100
 Total Trades
```

A high win rate does not automatically mean a strategy is profitable.

A low win rate does not automatically mean a strategy is unprofitable.

Win rate must be evaluated together with:

```text
Average Win
Average Loss
Profit Factor
Expected Payoff
Drawdown
```

---

## 7.7 Average Win / Average Loss

The relationship between average winning and losing trades helps explain the strategy's payoff structure.

For example:

```text
Average Win  = $6
Average Loss = $3
```

means the average winner is approximately twice the size of the average loser.

However, profitability still depends on how frequently each occurs.

---

# 8. Trade Sample Size

The number of trades should always be recorded.

A very small number of trades provides weak statistical evidence.

Example:

```text
20 trades
```

is substantially less informative than:

```text
5,000 trades
```

However, a large sample alone does not make a strategy profitable or robust.

Sample size should be considered together with:

- Length of historical period.
- Different market conditions represented.
- Number of independent signals.
- Trading frequency.

---

# 9. Baseline Classification

Each baseline should receive a clearly documented status.

Possible research states include:

```text
NOT TESTED
TESTED — FAIL
TESTED — CANDIDATE
VALIDATION REQUIRED
```

A failed baseline should remain in the repository.

Example:

```text
EA-031
Baseline: FAIL
```

This is still a valid research result.

---

# 10. Research After Baseline

After the baseline is documented, improvements may be investigated.

Examples include:

```text
Timeframe
Stop Loss
Take Profit
Break Even
Trailing Stop
Trading session
Trend filters
Volatility filters
Entry conditions
Exit conditions
```

Changes should be treated as new experiments rather than silently replacing the baseline.

---

# 11. Change One Research Question at a Time

Where practical, each experiment should answer a specific question.

Example:

```text
Baseline
↓
Test Break Even
↓
Compare result
```

rather than immediately adding:

```text
Break Even
+ Trailing Stop
+ RSI
+ ATR
+ Session Filter
+ New SL
+ New TP
```

Changing many unrelated components simultaneously makes it difficult to determine what caused an improvement or deterioration.

Parameter groups may be tested together when they represent one clearly defined research question.

---

# 12. Avoid Overfitting

Optimization can find parameter combinations that perform well historically but fail on unseen data.

Therefore:

```text
Good optimization result
≠
Proven trading strategy
```

Potential warning signs include:

- Extremely specific parameters.
- Large performance changes from very small parameter changes.
- Excellent results over only one short period.
- Strategy performance concentrated in a few trades.
- Large optimization searches with no independent validation.

---

# 13. Out-of-Sample Validation

A promising strategy should eventually be evaluated on data that was not used to select its parameters.

Conceptually:

```text
Historical Data
│
├── Development / Optimization
│
└── Out-of-Sample Validation
```

The validation period should remain untouched while developing or selecting parameters.

Only after the strategy configuration has been selected should it be evaluated on the out-of-sample period.

---

# 14. Forward Testing

A strategy that survives historical validation may later be tested in a demo or controlled forward-testing environment.

Suggested progression:

```text
Baseline Backtest
↓
Research
↓
Out-of-Sample Test
↓
Forward Test
↓
Further Evaluation
```

Passing a historical backtest alone should not be treated as evidence that an EA is ready for live capital.

---

# 15. Reproducibility

Another researcher should be able to understand:

```text
What EA was tested?
What parameters were used?
What market was tested?
What timeframe was used?
What historical period was used?
What result was obtained?
Where is the original evidence?
```

If these questions cannot be answered from the repository, the experiment is not sufficiently documented.

---

# 16. Preserve Failed Experiments

Failed tests are research evidence.

Do not delete a result simply because:

```text
Profit Factor < 1
Net Profit < 0
Drawdown is high
```

Failed experiments can reveal:

- Weak strategy assumptions.
- Market conditions where the strategy fails.
- Ineffective filters.
- Bad parameter regions.
- Improvements that do not work.

They also prevent the same failed experiment from being repeated unnecessarily.

---

# 17. Separate Evidence From Interpretation

Research documentation should distinguish between:

## Evidence

Example:

```text
Profit Factor = 0.92
Win Rate = 31.94%
Maximum Drawdown = 99.22%
```

and:

## Interpretation

Example:

```text
The tested configuration does not demonstrate
positive historical expectancy.
```

Evidence should come directly from reproducible test results.

Interpretation should be clearly presented as analysis of that evidence.

---

# 18. Repository Structure

Standard repository structure:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-XXX_STRATEGY/
│   │   ├── EA-XXX_STRATEGY.mq5
│   │   └── README.md
│
├── Backtest/
│   ├── EA-XXX_STRATEGY/
│   │   ├── README.md
│   │   └── test evidence
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

# 19. EA-031 Baseline Example

EA-031 is the first documented example using this methodology.

```text
EA: EA-031_SAR_EMA50
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026.01.02 – 2026.04.01
Trades: 5,680
Profit Factor: 0.92
Net Profit: -$991.82
Maximum Drawdown: 99.22%
Win Rate: 31.94%
```

Classification:

```text
Implementation: COMPLETE
Baseline Backtest: COMPLETE
Baseline Result: FAIL
Production Ready: NO
```

The failed result is retained as the baseline for future EA-031 research.

---

# 20. Research Principle

The repository follows one central principle:

> Preserve the evidence, test hypotheses systematically, and improve strategies only when reproducible results support the change.

The objective is not to produce attractive historical equity curves.

The objective is to determine whether an EA demonstrates a repeatable trading advantage that survives increasingly strict testing.
