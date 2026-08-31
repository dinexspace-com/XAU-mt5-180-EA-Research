# Research Methodology — XAUUSD MT5 EA Research

## 1. Purpose

This document defines the research methodology used in the `xauusd-mt5-ea-research` repository.

The methodology exists to ensure that every Expert Advisor is:

- Built from a clearly defined trading hypothesis.
- Tested under documented conditions.
- Evaluated using measurable evidence.
- Compared against a preserved baseline.
- Improved through controlled experiments.
- Protected against premature optimization and overfitting.
- Not classified as successful without sufficient evidence.

The objective is not to make every EA profitable.

The objective is to determine, through repeatable experiments, whether a trading idea contains a measurable and robust statistical edge.

---

## 2. Core Research Principle

Every EA should follow the same basic process:

Trading Idea  
↓  
Define Hypothesis  
↓  
Build Minimal EA  
↓  
Compile and Verify Execution  
↓  
Run Baseline Backtest  
↓  
Record Evidence  
↓  
PASS / FAIL Baseline  
↓  
Identify Failure Mode  
↓  
Define One New Hypothesis  
↓  
Run Controlled Experiment  
↓  
Compare With Baseline  
↓  
Candidate Selection  
↓  
Robustness Testing  
↓  
Forward Validation  
↓  
Live Decision

The research process should remain simple until evidence justifies additional complexity.

---

## 3. Repository Structure

The repository separates implementation, testing, research, and methodology.

xauusd-mt5-ea-research/  
│  
├── EAs/  
│   ├── EA-001_.../  
│   ├── EA-002_.../  
│   └── EA-035_HH_HL_Structure/  
│  
├── Backtest/  
│   ├── EA-001_.../  
│   ├── EA-002_.../  
│   └── EA-035_HH_HL_Structure/  
│  
├── Research/  
│   └── README.md  
│  
├── docs/  
│   └── methodology.md  
│  
└── GitHub_Profile/  
    └── README.md

Each location has a different responsibility.

### `EAs/`

Contains EA source code and documentation describing what the implementation actually does.

Typical structure:

EA-XXX_Strategy_Name/  
├── EA-XXX_Strategy_Name.mq5  
└── README.md

The EA README should document:

- Strategy concept
- Entry logic
- Exit logic
- Signal calculation
- Risk management
- Input parameters
- Execution behavior
- Known implementation limitations

It should describe the current source code rather than intended or hypothetical functionality.

---

### `Backtest/`

Contains historical testing evidence for each EA.

Typical structure:

Backtest/  
└── EA-XXX_Strategy_Name/  
    ├── README.md  
    ├── Strategy Tester report  
    └── Strategy Tester charts

The Backtest README should record:

- Symbol
- Timeframe
- Test period
- Data quality
- Initial deposit
- Leverage
- EA parameters
- Net Profit
- Profit Factor
- Expected Payoff
- Drawdown
- Win Rate
- Trade Count
- Sharpe Ratio
- Consecutive losses
- Relevant Strategy Tester observations
- PASS / FAIL result

Raw Strategy Tester artifacts should be preserved.

---

### `Research/`

Contains research interpretation rather than raw implementation details.

The Research documentation should record:

- Research objective
- Baseline hypothesis
- Baseline findings
- Failure analysis
- Research questions
- Candidate hypotheses
- Experiment history
- Comparison metrics
- Current research status

Research conclusions must be based on evidence from the corresponding implementation and backtests.

---

### `docs/`

Contains repository-wide methodology and standards.

`docs/methodology.md` defines how all EAs should be researched.

It should not contain strategy-specific conclusions unless they are used explicitly as examples.

---

## 4. EA Identification

Each Expert Advisor should have a unique identifier.

Format:

`EA-XXX_Strategy_Name`

Example:

`EA-035_HH_HL_Structure`

The numeric identifier should remain stable even when the EA progresses through multiple experiments.

Experimental variants should use separate experiment identifiers rather than replacing the original research record.

Example:

`EA-035-B00`

Baseline experiment.

`EA-035-E01`

First controlled experiment.

`EA-035-E02`

Second controlled experiment.

This allows every result to be traced back to a specific implementation and test.

---

## 5. Step 1 — Define the Trading Hypothesis

Every EA begins with a hypothesis.

A hypothesis should explain:

1. What market behavior is being observed?
2. What condition generates a signal?
3. Why might that condition contain predictive information?
4. What result is expected?

A hypothesis should be specific enough to implement.

Example:

> When price forms a Higher High and Higher Low, bullish continuation may be more likely than random directional movement.

The implementation can then test:

HH + HL → BUY

The opposite hypothesis may be:

LH + LL → SELL

The purpose of the EA is to test the hypothesis.

The EA should not be considered evidence that the hypothesis is correct.

---

## 6. Step 2 — Build the Minimal Implementation

The first EA version should contain only the components necessary to test the core idea.

Prefer:

Signal  
+  
Entry  
+  
Stop Loss  
+  
Take Profit  
+  
Basic execution controls

Avoid immediately adding:

- Multiple indicators
- Multiple timeframe filters
- Session optimization
- Dynamic risk models
- News filters
- Complex position management
- Machine learning
- Large parameter searches

Complexity should be introduced only when a simpler version has already been measured.

The baseline should answer:

> Does the core trading idea show evidence of an edge?

---

## 7. Step 3 — Verify Technical Execution

Before evaluating profitability, verify that the EA behaves as intended.

Minimum checks include:

- EA compiles successfully.
- Orders can be opened.
- BUY logic activates when expected.
- SELL logic activates when expected.
- Stop Loss is attached correctly.
- Take Profit is attached correctly.
- Position sizing matches configuration.
- Magic Number behaves correctly.
- Spread restrictions behave correctly.
- Position limits behave correctly.
- Strategy Tester completes without critical execution errors.

A financially negative EA may still pass technical execution validation.

Technical correctness and trading profitability are separate questions.

---

## 8. Step 4 — Create the Baseline

The first complete historical test becomes the baseline.

Recommended identifier:

`EA-XXX-B00`

The baseline should remain preserved.

Do not silently replace it after optimization.

The baseline provides the reference against which later experiments are evaluated.

At minimum, record:

- EA version
- Symbol
- Timeframe
- Historical period
- Data quality
- Broker / symbol specification when relevant
- Initial deposit
- Leverage
- Lot size
- Stop Loss
- Take Profit
- Spread settings
- Enabled / disabled management features
- Total trades
- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Drawdown
- Win Rate
- Average Winner
- Average Loser
- Sharpe Ratio
- Recovery Factor

---

## 9. Historical Data Quality

Backtest quality must be documented.

When available, prefer MetaTrader 5 testing using:

`Every tick based on real ticks`

The report should preserve the reported History Quality.

For example:

`100% real ticks`

Data quality does not guarantee that the strategy is valid.

It only increases confidence that the historical simulation is based on the available tick history rather than a simplified price model.

Broker-specific differences may still affect results.

---

## 10. Symbol Specification

XAUUSD specifications may differ between brokers.

Possible differences include:

- Symbol name
- Digits
- `_Point`
- Tick size
- Tick value
- Contract size
- Spread
- Commission
- Swap
- Minimum lot
- Lot step
- Stop level
- Execution behavior

Examples of symbol names include:

`XAUUSD`

`XAUUSD.PRO`

Therefore, parameters expressed in MetaTrader points should not automatically be interpreted as fixed USD price movement without checking the broker's symbol specification.

Backtest results from different brokers should not automatically be assumed equivalent.

---

## 11. Backtest Evidence

Every important backtest should preserve the original Strategy Tester output whenever practical.

Useful artifacts include:

- HTML Strategy Tester report
- Balance graph
- Trade-distribution chart
- MFE / MAE chart
- Holding-time chart
- Parameter configuration
- Relevant screenshots

The README summarizes the evidence.

The raw report remains the primary historical test artifact.

Do not rely only on manually copied statistics when the original report is available.

---

## 12. Minimum Performance Metrics

Every baseline and major experiment should record at least the following metrics.

### Total Net Profit

Total realized result over the test.

Net Profit alone is not sufficient to evaluate a strategy.

---

### Gross Profit

Total profit generated by winning trades.

---

### Gross Loss

Total loss generated by losing trades.

---

### Profit Factor

Profit Factor is:

Gross Profit / Absolute Gross Loss

Interpretation:

PF < 1.00  
→ Losing strategy during the tested sample.

PF = 1.00  
→ Gross profit approximately equals gross loss.

PF > 1.00  
→ Gross profit exceeds gross loss.

Profit Factor should always be considered together with trade count and drawdown.

---

### Expected Payoff

Expected Payoff represents average historical result per trade in the Strategy Tester report.

Positive Expected Payoff is preferable to negative Expected Payoff.

It should not be interpreted independently from sample size.

---

### Maximum Drawdown

Maximum Drawdown measures the largest historical decline during the test.

A strategy may produce positive Net Profit while still having unacceptable drawdown.

Therefore:

High Return + Extreme Drawdown

should not automatically be classified as successful.

---

### Win Rate

Win Rate measures the percentage of profitable trades.

Win Rate alone does not determine strategy quality.

A low-win-rate strategy may still be profitable if winners are sufficiently larger than losers.

A high-win-rate strategy may still lose money if occasional losses are disproportionately large.

---

### Average Winner

Average result of profitable trades.

---

### Average Loser

Average result of losing trades.

Average Winner and Average Loser should be evaluated together with Win Rate.

---

### Total Trades

Trade count is critical.

A strategy with:

10 trades

and a strategy with:

5,000 trades

do not provide the same amount of statistical evidence.

A high Profit Factor from a very small sample should be treated cautiously.

---

### Consecutive Losses

Maximum and average losing streaks should be recorded when available.

They provide useful information about:

- Strategy behavior
- Risk
- Psychological tolerance
- Capital requirements
- Possible market-regime dependence

---

### Sharpe Ratio

Sharpe Ratio provides information about risk-adjusted performance.

It should be treated as one supporting metric rather than a standalone decision criterion.

---

### Recovery Factor

Recovery Factor provides information about the relationship between profit and drawdown.

Negative Recovery Factor is a clear warning sign.

---

## 13. Balance Curve Analysis

The balance curve should always be reviewed visually.

Look for:

- Persistent upward trend
- Persistent downward trend
- Long stagnation
- Sudden catastrophic losses
- Dependence on one short profitable period
- Repeated deep drawdowns
- Changes in behavior over time

A profitable final balance can hide unstable behavior.

The shape of the balance curve provides context that summary metrics alone may not reveal.

---

## 14. MFE Analysis

MFE means:

**Maximum Favorable Excursion**

It measures the maximum favorable movement experienced by a trade while the position remained open.

MFE can help investigate questions such as:

- Are profitable trades being exited too early?
- Do losing trades often move significantly into profit first?
- Is Take Profit placed too close?
- Could exit management capture more favorable movement?

MFE observations should generate hypotheses.

They should not automatically trigger strategy modifications.

---

## 15. MAE Analysis

MAE means:

**Maximum Adverse Excursion**

It measures the maximum adverse movement experienced while a position remained open.

MAE can help investigate:

- Stop Loss placement
- Losing-trade behavior
- Whether winners typically require large adverse movement first
- Whether risk can potentially be reduced

MFE and MAE should be used as research evidence rather than as automatic optimization instructions.

---

## 16. Holding-Time Analysis

Record when available:

- Minimum holding time
- Maximum holding time
- Average holding time

Holding-time analysis helps classify the practical behavior of the EA.

Examples:

- Very short holding time → scalping-like behavior
- Minutes to hours → intraday behavior
- Multi-day holding → swing behavior

Holding time also affects sensitivity to:

- Spread
- Slippage
- Commission
- Execution latency

Short-duration strategies may be particularly sensitive to transaction costs and broker conditions.

---

## 17. Trading-Time Distribution

When available, inspect performance and entry distribution by:

- Hour
- Weekday
- Month

These charts can reveal possible research questions.

For example:

> Does the strategy perform differently during London and New York activity?

However, do not create a session filter simply because one historical chart appears better.

The observation should first become a hypothesis and then be tested separately.

---

## 18. Baseline PASS / FAIL

A baseline must receive an explicit research result.

Possible states:

- `PASS`
- `FAIL`
- `CANDIDATE`
- `INCONCLUSIVE`

### FAIL

Use FAIL when evidence clearly rejects the tested configuration.

Examples:

- Profit Factor below 1
- Negative Expected Payoff
- Persistent declining balance
- Extreme drawdown
- Unacceptable risk behavior

A failed baseline is still a valid research result.

Do not delete failed experiments.

Failed experiments prevent the same idea from being repeatedly tested without learning.

---

### INCONCLUSIVE

Use INCONCLUSIVE when the evidence is insufficient.

Examples:

- Too few trades
- Incomplete historical period
- Technical execution problems
- Poor data quality
- Unclear implementation behavior

An inconclusive test should not be treated as either success or failure.

---

### CANDIDATE

Use CANDIDATE when an experiment demonstrates promising performance but has not completed robustness validation.

Possible characteristics include:

- Positive Expected Payoff
- Profit Factor above 1
- Acceptable drawdown
- Meaningful trade sample
- Reasonable balance curve
- Improved risk-adjusted performance

CANDIDATE does not mean ready for live trading.

---

### PASS

PASS should only be used when the predefined objective of the specific research stage has been satisfied and the supporting artifacts and evidence have been reviewed.

A profitable historical test alone should not automatically produce PASS for production readiness.

---

## 19. Failure Analysis

When a baseline fails, do not immediately optimize every parameter.

First identify the likely failure mode.

Possible examples:

- Too many signals
- Low win rate
- Poor reward/risk
- Excessive drawdown
- Losing clusters
- Poor BUY performance
- Poor SELL performance
- Failure during sideways markets
- Failure during low volatility
- Excessive transaction-cost sensitivity
- Poor exit behavior

The failure analysis should lead to a specific new research question.

---

## 20. Hypothesis-Driven Improvement

Every meaningful modification should answer a research question.

Example:

Observation:

Many losing trades occur during weak market structure.

Hypothesis:

A minimum swing-distance filter may remove low-quality structures.

Experiment:

Baseline  
vs  
Baseline + Minimum Swing Distance

This is preferable to changing multiple unrelated parameters simultaneously.

---

## 21. One Major Variable at a Time

Whenever practical, change one major strategy variable per experiment.

Preferred:

Baseline  
↓  
Add Higher-Timeframe Filter  
↓  
Backtest  
↓  
Compare

Then separately:

Baseline  
↓  
Add ATR Filter  
↓  
Backtest  
↓  
Compare

Avoid:

Baseline  
↓  
Add Higher-Timeframe Filter  
+ ATR  
+ Session Filter  
+ New SL  
+ New TP  
+ Break Even  
+ Trailing Stop  
↓  
Backtest

If the result improves, the cause would be difficult to identify.

---

## 22. Experiment Identification

Controlled experiments should use unique IDs.

Example:

`EA-035-B00`

Baseline.

`EA-035-E01`

First experiment.

`EA-035-E02`

Second experiment.

Each experiment should record:

- Experiment ID
- Hypothesis
- Change from baseline
- Parameters
- Test environment
- Results
- Comparison with baseline
- Conclusion
- Status

---

## 23. Experiment Record Template

Each experiment can be documented using the following structure:

### Experiment ID

`EA-XXX-EXX`

### Hypothesis

What is being tested?

### Baseline

Which experiment is the control?

### Change

What exactly changed?

### Unchanged Variables

What remained constant?

### Test Environment

- Symbol
- Timeframe
- Period
- Data quality
- Broker
- Deposit
- Leverage

### Results

- Net Profit
- Profit Factor
- Expected Payoff
- Drawdown
- Win Rate
- Total Trades
- Average Winner
- Average Loser
- Sharpe Ratio
- Recovery Factor

### Comparison

How does the experiment differ from baseline?

### Conclusion

Was the hypothesis supported?

### Status

`PASS / FAIL / CANDIDATE / INCONCLUSIVE`

---

## 24. Comparison Discipline

Future experiments should always be compared with the appropriate baseline.

Do not evaluate only:

Net Profit increased.

Instead evaluate:

- Did Profit Factor improve?
- Did Expected Payoff improve?
- Did Drawdown decrease?
- Did trade count collapse?
- Did Win Rate change?
- Did Average Winner / Loser improve?
- Did Sharpe Ratio improve?
- Did the balance curve become more stable?
- Did losing streaks improve?

An improvement in one metric may create deterioration elsewhere.

---

## 25. Sample Size

A strategy should not be considered reliable from a small number of trades.

For example:

20 trades  
PF = 2.5

may appear impressive but provides limited evidence.

A larger trade sample generally provides more information about the behavior of the strategy.

There is no single trade-count threshold that proves robustness.

Sample size must be interpreted together with:

- Strategy frequency
- Historical duration
- Market regimes
- Parameter stability
- Out-of-sample behavior

---

## 26. Avoiding Overfitting

Overfitting occurs when a strategy becomes excessively adapted to historical data.

Avoid the following process:

Backtest  
↓  
Change parameters  
↓  
Backtest same data  
↓  
Change parameters again  
↓  
Repeat until profitable

This risks fitting historical noise rather than discovering a persistent market effect.

Preferred process:

Observation  
↓  
Hypothesis  
↓  
Predefined Experiment  
↓  
Backtest  
↓  
Record Result  
↓  
Accept or Reject Hypothesis

Optimization should follow evidence, not replace research.

---

## 27. Parameter Optimization

Parameter optimization should not be the first stage.

Before optimization, establish that the underlying strategy concept has evidence of an edge.

Preferred order:

Minimal Strategy  
↓  
Baseline Test  
↓  
Controlled Improvement  
↓  
Candidate Strategy  
↓  
Parameter Sensitivity  
↓  
Optimization

Optimization of a fundamentally losing strategy can produce historically attractive parameter combinations without establishing a genuine trading edge.

---

## 28. Parameter Sensitivity

For candidate strategies, test whether performance depends excessively on one exact parameter value.

Example:

If:

SL = 299 → Poor  
SL = 300 → Excellent  
SL = 301 → Poor

the strategy may be fragile.

More robust behavior would show reasonable performance across a surrounding parameter region.

The goal is not necessarily to find the single historical optimum.

The goal is to identify parameter regions where the strategy remains reasonably stable.

---

## 29. In-Sample and Out-of-Sample Testing

Once a candidate strategy exists, historical data can be separated conceptually into:

### In-Sample

Data used for research and development.

### Out-of-Sample

Data not used to create or tune the strategy.

A strategy that performs well only on development data but fails on unseen historical data may be overfit.

Out-of-sample testing should therefore be introduced before serious production consideration.

---

## 30. Market-Regime Testing

Candidate strategies should eventually be evaluated across different market environments.

Possible regimes include:

- Strong trend
- Weak trend
- Sideways market
- High volatility
- Low volatility
- Major macroeconomic periods
- Different gold price regimes

A strategy that only works during one narrow historical condition may not be robust.

Market-regime testing belongs after a viable candidate exists.

It should not make the initial baseline unnecessarily complex.

---

## 31. Broker Robustness

XAUUSD execution conditions vary between brokers.

Candidate strategies may eventually require testing against different:

- Spreads
- Symbol specifications
- Commissions
- Tick values
- Stop levels
- Execution conditions

This is particularly important for short-duration strategies.

A strategy that depends on unrealistically favorable execution conditions should not be considered robust.

---

## 32. Transaction Costs

Research should account for transaction costs whenever the testing environment supports them.

Important costs include:

- Spread
- Commission
- Slippage
- Swap

The shorter the average holding time and the greater the trading frequency, the more important these costs become.

A strategy with a very small theoretical edge may become unprofitable after realistic transaction costs.

---

## 33. Forward Testing

Historical backtesting is not the final validation stage.

Promising candidates should eventually be tested using forward or demo execution.

Forward testing can reveal issues not obvious in historical simulation, including:

- Live spread behavior
- Slippage
- Execution delays
- Broker restrictions
- Order rejection
- Market-data differences
- Operational reliability

Forward testing should occur only after historical evidence justifies continuing the research.

---

## 34. Live Trading Decision

No EA should be considered ready for live capital solely because it produced a profitable backtest.

The research progression should be:

Baseline  
↓  
Controlled Experiments  
↓  
Candidate  
↓  
Robustness Testing  
↓  
Out-of-Sample Testing  
↓  
Forward / Demo Validation  
↓  
Human Review  
↓  
Live Decision

The final live-trading decision must remain separate from automated research results.

---

## 35. Research Status Model

Each EA can move through the following stages:

### IDEA

Trading hypothesis exists.

### IMPLEMENTED

Minimal EA exists and compiles.

### BASELINE TESTED

Initial historical test completed.

### BASELINE FAIL

Baseline does not demonstrate sufficient evidence of an edge.

### RESEARCHING

Controlled experiments are being performed.

### CANDIDATE

A promising variant has been identified.

### ROBUSTNESS TESTING

Candidate is being tested beyond the development sample.

### FORWARD TESTING

Candidate is being evaluated under forward execution.

### APPROVED

Human review has approved progression to the intended next stage.

### REJECTED

Research evidence does not justify further development.

---

## 36. Artifact Requirement

A research task should not be considered complete without supporting artifacts.

Depending on the stage, artifacts may include:

- `.mq5` source code
- EA README
- Strategy Tester HTML report
- Balance graph
- MFE / MAE chart
- Holding-time chart
- Backtest README
- Research notes
- Experiment comparison
- Parameter configuration

The research record should allow another reviewer to understand what was tested and why the conclusion was reached.

---

## 37. Evidence Requirement

Every important conclusion should be traceable to evidence.

Examples:

Claim:

`Baseline strategy is unprofitable.`

Evidence:

- Net Profit
- Profit Factor
- Expected Payoff
- Balance curve

Claim:

`Drawdown is unacceptable.`

Evidence:

- Balance Drawdown
- Equity Drawdown

Claim:

`Strategy has a low win rate.`

Evidence:

- Profit Trades
- Loss Trades

Avoid conclusions that cannot be traced back to code, test results, or documented observations.

---

## 38. Reproducibility

A useful research result should contain enough information to reproduce the test.

At minimum preserve:

- EA source/version
- Input parameters
- Symbol
- Timeframe
- Historical period
- Testing model
- Data quality
- Broker environment when relevant
- Strategy Tester report

If the original configuration cannot be reconstructed, confidence in later comparisons is reduced.

---

## 39. Failed Experiments Must Be Preserved

Do not delete failed strategies simply because they lose money.

A failed experiment answers a research question.

Preserving failures helps prevent:

- Repeating the same experiment
- Forgetting why a strategy was rejected
- Cherry-picking only profitable results
- Losing the development history

Negative evidence is part of the research record.

---

## 40. No Silent Strategy Changes

When strategy logic changes materially, the change should be documented.

Do not modify an EA and continue treating new results as if they came from the original implementation.

A meaningful change should create:

- A new experiment ID
- A documented hypothesis
- A new backtest artifact
- A comparison with the previous version

This maintains traceability.

---

## 41. Research Before Scale

Do not build large optimization or automation infrastructure before the basic research process works.

Preferred progression:

Minimal Working Version  
↓  
Real Backtest  
↓  
Baseline Evidence  
↓  
Controlled Experiments  
↓  
Candidate  
↓  
Robustness  
↓  
Automation  
↓  
Scale

Automation should make a valid research process faster.

It should not replace the research process.

---

## 42. Standard Workflow for a New EA

For every new EA:

### Step 1

Create:

`EAs/EA-XXX_Strategy_Name/`

### Step 2

Add:

`EA-XXX_Strategy_Name.mq5`

### Step 3

Create the EA README documenting the actual implementation.

### Step 4

Compile and verify technical execution.

### Step 5

Run the baseline Strategy Tester experiment.

### Step 6

Create:

`Backtest/EA-XXX_Strategy_Name/`

### Step 7

Preserve the Strategy Tester artifacts.

### Step 8

Create the Backtest README.

### Step 9

Record the research finding.

### Step 10

Classify the baseline:

`PASS / FAIL / CANDIDATE / INCONCLUSIVE`

### Step 11

If further research is justified, define the next hypothesis.

### Step 12

Create a new controlled experiment.

---

## 43. Standard Research Flow

The complete repository methodology can be summarized as:

IDEA  
│  
▼  
HYPOTHESIS  
│  
▼  
MINIMAL EA  
│  
▼  
TECHNICAL TEST  
│  
▼  
BASELINE BACKTEST  
│  
├── Technical Failure  
│   └── Fix implementation and retest  
│  
├── Insufficient Evidence  
│   └── INCONCLUSIVE  
│  
├── Negative Evidence  
│   └── FAIL  
│       │  
│       └── Failure Analysis  
│           ↓  
│           New Hypothesis  
│           ↓  
│           Controlled Experiment  
│  
└── Promising Evidence  
    └── CANDIDATE  
        │  
        ▼  
    Robustness Testing  
        │  
        ▼  
    Out-of-Sample  
        │  
        ▼  
    Forward Testing  
        │  
        ▼  
    Human Review  
        │  
        ▼  
    Live Decision

---

## 44. Methodology Summary

The repository follows five fundamental rules.

### Rule 1 — Start Simple

Test the smallest implementation capable of evaluating the hypothesis.

### Rule 2 — Preserve the Baseline

Never erase the original result after optimization.

### Rule 3 — Change One Major Variable at a Time

Controlled experiments are more informative than uncontrolled combinations.

### Rule 4 — Require Evidence

Every conclusion must be supported by artifacts and measurable results.

### Rule 5 — Separate Research From Approval

Backtests and automated analysis provide evidence.

They do not automatically authorize live trading.

---

## 45. Final Principle

The purpose of this repository is not:

> Find settings that make every backtest look profitable.

The purpose is:

> Test trading hypotheses systematically, preserve both positive and negative evidence, identify genuine improvements through controlled experiments, and reject ideas that do not survive validation.

The expected progression is:

**Hypothesis → Minimal Implementation → Evidence → Learning → Controlled Improvement → Robustness**

A failed EA with clear evidence is a valid research result.

A profitable EA without reproducible evidence is not sufficient.

---

## Disclaimer

This repository is intended for quantitative trading research and software experimentation.

Historical simulations and backtests do not guarantee future performance.

Results may differ because of market conditions, broker specifications, spread, commission, slippage, liquidity, execution behavior, data quality, and other factors.

No EA should be deployed with live capital solely on the basis of historical backtest results.
