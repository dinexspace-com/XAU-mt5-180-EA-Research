# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard research, implementation, backtesting, validation, and decision-making methodology used in the `xauusd-mt5-ea-research` repository.

The objective of this repository is not to collect Expert Advisors that appear profitable in isolated backtests.

The objective is to build a reproducible research process for converting trading hypotheses into MetaTrader 5 Expert Advisors and determining, through controlled evidence, whether those hypotheses contain a robust trading edge on XAUUSD.

The core workflow is:

```text
Trading Idea
    ↓
Formal Strategy Rules
    ↓
MQL5 Implementation
    ↓
Technical Validation
    ↓
Baseline Backtest
    ↓
Failure Analysis
    ↓
Controlled Experiments
    ↓
Out-of-Sample Validation
    ↓
Robustness Testing
    ↓
Forward Testing
    ↓
Final Evaluation
```

No EA is considered validated simply because it compiles, executes trades, or produces a profitable historical backtest.

## Repository Research Principles

All EA research follows the principles below.

### Evidence Before Claims

Every performance claim must be supported by reproducible evidence.

The hierarchy is:

```text
Idea
<
Source Code
<
Successful Compilation
<
Backtest
<
Out-of-Sample Test
<
Robustness Test
<
Forward Test
<
Validated Evidence
```

A strategy description is not evidence of profitability.

Source code is not evidence of profitability.

A profitable backtest is not evidence of future profitability.

### Failed Experiments Are Preserved

Failed backtests must not be deleted simply because their results are poor.

A failed experiment provides information about:

```text
What was tested
What configuration failed
Under which conditions it failed
Why the next experiment is being performed
```

Therefore:

```text
FAIL ≠ useless
```

A properly documented failure becomes part of the research history.

### Baselines Are Frozen

Each EA begins with a baseline implementation.

Example:

```text
EA045-M1-BASELINE-001
```

Once the baseline has been tested and documented, its:

```text
Source code
Parameters
Test environment
Backtest report
Charts
Metrics
Conclusion
```

should remain preserved.

Future experiments are compared against this baseline.

### One Major Hypothesis at a Time

Avoid modifying many strategy components simultaneously.

Bad experimental design:

```text
Change EMA
+ Change timeframe
+ Add ADX
+ Add ATR
+ Add session filter
+ Change SL
+ Change TP
+ Add trailing stop
        ↓
Run backtest
```

Even if the result improves, the cause cannot be identified.

Preferred process:

```text
Baseline
   ↓
Identify one weakness
   ↓
Form one hypothesis
   ↓
Change one major component
   ↓
Backtest
   ↓
Compare
```

This repository prioritizes explainable improvements over blind optimization.

## Standard EA Research Lifecycle

Every EA should progress through the following stages.

### Stage 1 — Strategy Definition

Before coding, define the trading hypothesis.

At minimum:

```text
Market
Direction logic
Entry conditions
Exit conditions
Stop Loss
Take Profit
Position sizing
Trading timeframe
Filters
Position management
```

The rules should be sufficiently explicit that they can be translated into deterministic code.

Avoid rules such as:

```text
Buy when trend looks strong.
```

Prefer:

```text
BUY when:
EMA20 > EMA50
AND
specified pullback condition is satisfied
AND
specified structural confirmation is satisfied.
```

The goal is to eliminate discretionary ambiguity wherever possible.

### Stage 2 — MQL5 Implementation

The strategy is implemented as a MetaTrader 5 Expert Advisor.

Each EA receives a unique identifier.

Example:

```text
EA-045_Trend_Pullback_Structure
```

The source should be stored under:

```text
EAs/
└── EA-045_Trend_Pullback_Structure/
    ├── EA-045_Trend_Pullback_Structure.mq5
    └── README.md
```

The EA README documents:

```text
Strategy concept
Entry logic
Exit logic
Parameters
Risk model
Trade management
Implementation notes
Known limitations
Validation status
```

### Stage 3 — Technical Validation

Before evaluating profitability, verify that the EA functions technically.

Minimum checks:

```text
Compilation successful
No critical runtime errors
Indicators initialize correctly
BUY signals can execute
SELL signals can execute
Stop Loss works
Take Profit works
Position sizing works
Magic Number works
Spread filter works
Position control works
```

Where applicable:

```text
Break Even works
Trailing Stop works
Session filter works
Higher-timeframe data works
```

Technical validation answers:

```text
Does the EA behave according to its implementation?
```

It does not answer:

```text
Is the strategy profitable?
```

These are separate questions.

## Baseline Backtesting

After technical validation, create a baseline backtest.

The baseline is the first standardized performance reference for the EA.

### Backtest Environment

Record at minimum:

```text
EA version
Symbol
Broker / server
Timeframe
Start date
End date
History quality
Tick model
Initial deposit
Account currency
Leverage
Spread configuration
Lot size
EA parameters
MT5 build where available
```

Example:

```text
EA              = EA-045_Trend_Pullback_Structure
Symbol          = XAUUSD.PRO
Timeframe       = M1
Period          = 2026.01.02 - 2026.04.01
History Quality = 100% real ticks
Deposit         = $1,000
Leverage        = 1:500
Lot             = 0.01
```

### Real Tick Testing

Where available, baseline validation should prioritize:

```text
Every tick based on real ticks
```

because short-term XAUUSD strategies can be highly sensitive to intrabar price movement.

Lower-quality models may be useful during rapid development, but important conclusions should be confirmed using high-quality historical data.

### Backtest Evidence

Each important backtest should preserve the original MT5 evidence.

Typical structure:

```text
Backtest/
└── EA-045_Trend_Pullback_Structure/
    ├── README.md
    ├── ReportTester-XXXXXX.html
    ├── ReportTester-XXXXXX.png
    ├── ReportTester-XXXXXX-hst.png
    ├── ReportTester-XXXXXX-mfemae.png
    └── ReportTester-XXXXXX-holding.png
```

The HTML report is the primary raw evidence.

Images provide quick visual inspection.

The README records interpretation and the PASS/FAIL decision.

## Standard Metrics

Every meaningful experiment should capture the following metrics.

### Profitability

```text
Initial Deposit
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
Maximum Drawdown
Relative Drawdown
Recovery Factor
```

### Risk-Adjusted Performance

```text
Sharpe Ratio
AHPR
GHPR
```

where available.

### Trade Statistics

```text
Total Trades
Total Deals
Winning Trades
Losing Trades
Win Rate
Long Trades
Short Trades
Long Win Rate
Short Win Rate
```

### Trade Distribution

```text
Largest Winner
Largest Loser
Average Winner
Average Loser
Maximum Consecutive Wins
Maximum Consecutive Losses
Average Consecutive Wins
Average Consecutive Losses
```

### Holding Behavior

```text
Minimum Holding Time
Maximum Holding Time
Average Holding Time
```

### Diagnostic Metrics

Where available:

```text
MFE
MAE
Correlation (Profit, MFE)
Correlation (Profit, MAE)
Performance by hour
Performance by weekday
Performance by month
```

## Reward/Risk Analysis

Win rate must not be interpreted independently from payoff ratio.

For a simplified strategy with:

```text
Reward = R
Risk   = 1
```

the theoretical break-even win rate before costs is:

```text
Break-even Win Rate = 1 / (1 + R)
```

Example:

```text
Reward/Risk = 2:1

Break-even Win Rate
= 1 / (1 + 2)
= 33.33%
```

Therefore a strategy with:

```text
Win Rate = 31%
```

may still fail even if its average winner is approximately twice its average loser.

Conversely, a strategy with a lower reward/risk ratio may remain profitable if its win probability is sufficiently high.

Always evaluate:

```text
Win Rate
+
Average Winner
+
Average Loser
+
Trading Costs
```

together.

## Expectancy

The central research question is whether the strategy demonstrates positive expectancy.

Simplified expectancy can be represented as:

```text
Expectancy
=
(Pwin × Average Win)
-
(Ploss × Average Loss)
```

where:

```text
Pwin  = probability of winning
Ploss = probability of losing
```

A strategy should not be considered promising merely because:

```text
TP > SL
```

The probability distribution of outcomes determines whether that relationship produces an edge.

## Drawdown Evaluation

Profitability alone is insufficient.

A system producing:

```text
High Profit
+
Extreme Drawdown
```

may still be unsuitable.

Drawdown should be evaluated alongside:

```text
Net Profit
Profit Factor
Recovery Factor
Sharpe Ratio
Trade count
Equity behavior
```

A backtest approaching total account loss is considered a failure regardless of isolated profitable periods.

## Balance Curve Analysis

Do not evaluate an EA only from summary metrics.

Inspect the balance and equity curves.

Healthy behavior should be investigated for:

```text
Long-term direction
Stability
Large isolated jumps
Extended stagnation
Persistent decline
Sudden catastrophic loss
Regime dependence
```

Example warning:

```text
Profitability comes almost entirely from one short period.
```

Another warning:

```text
Balance declines consistently across thousands of trades.
```

The shape of the curve can reveal weaknesses that aggregate metrics hide.

## Sample Size

Small trade samples provide weak evidence.

For example:

```text
12 trades
10 wins
83% win rate
```

is not equivalent in evidential strength to:

```text
1,000+ trades
stable performance
multiple market regimes
```

There is no universal minimum trade count applicable to every strategy.

The required sample depends on:

```text
Strategy frequency
Holding period
Market regime
Test duration
Trade independence
```

Nevertheless, conclusions based on very small samples should always be treated cautiously.

## Market Regime Analysis

XAUUSD does not behave identically under all market conditions.

Potential regimes include:

```text
Strong bullish trend
Strong bearish trend
Weak trend
Range
High volatility
Low volatility
News-driven expansion
Transition
```

A strategy may possess an edge only in specific regimes.

Therefore future research should ask:

```text
WHEN does the strategy work?
```

rather than only:

```text
DOES the strategy work?
```

Possible regime variables include:

```text
EMA alignment
EMA slope
EMA separation
ADX
ATR
Higher-timeframe trend
Price structure
Volatility expansion
```

These should be introduced through controlled experiments.

## Multi-Timeframe Research

Trend and entry logic do not necessarily need to operate on the same timeframe.

A common research architecture is:

```text
Higher Timeframe
      ↓
Determine market regime
      ↓
Execution Timeframe
      ↓
Identify pullback
      ↓
Confirm continuation
      ↓
Enter
```

Example research configuration:

```text
H1 → Trend
M5 → Pullback
M5 → Entry
```

or:

```text
M15 → Trend
M5  → Entry
```

Multi-timeframe filtering should be treated as a hypothesis and compared against a same-timeframe baseline.

## Pullback Research

A pullback must be defined objectively.

Potential definitions include:

```text
Retracement toward EMA
ATR-normalized retracement
Percentage retracement of previous impulse
Minimum pullback distance
Minimum pullback duration
Swing-based correction
```

Avoid allowing any small local fluctuation to automatically qualify as a meaningful pullback.

Each definition should be tested separately.

## Breakout Confirmation

A structural breakout can be defined in multiple ways.

Examples:

```text
Price touches beyond level
```

```text
Current High > Swing High
```

```text
Candle closes above Swing High
```

```text
Break + Retest + Continuation
```

More confirmation may reduce false signals but can also produce later entries.

Therefore:

```text
More confirmation ≠ automatically better
```

The trade-off must be measured.

## Volatility Normalization

Fixed-distance risk parameters may behave differently as XAUUSD volatility changes.

Example:

```text
SL = 300 points
```

can be relatively wide during quiet conditions and relatively narrow during high volatility.

Volatility-normalized research may use:

```text
ATR
```

to define risk distances.

Example hypothesis:

```text
SL = ATR × multiplier
TP = SL × reward multiple
```

This should be compared against the fixed-distance baseline.

## Structural Risk Management

Another research approach is to place Stop Loss where the strategy hypothesis becomes invalid.

For a bullish structure:

```text
Trend
  ↓
Pullback
  ↓
Higher Low
  ↓
Breakout
  ↓
BUY

SL below structural invalidation
```

For bearish structure:

```text
Trend
  ↓
Pullback
  ↓
Lower High
  ↓
Breakdown
  ↓
SELL

SL above structural invalidation
```

Structural stops may better represent the trading hypothesis but can create variable risk distances.

Position sizing must therefore be considered when testing them.

## Position Sizing

Fixed lot sizing and percentage-risk sizing must be distinguished.

Fixed lot:

```text
Lot = constant
```

Percentage risk:

```text
Account Equity
      ↓
Risk %
      ↓
Stop Distance
      ↓
Calculate Lot Size
```

Percentage-risk sizing should not be introduced merely to make an unprofitable strategy appear safer.

First establish whether the underlying entry/exit logic demonstrates positive expectancy.

Then evaluate portfolio and capital-risk management.

## Spread and Execution Costs

Short-term XAUUSD systems can be highly sensitive to execution costs.

Relevant variables include:

```text
Spread
Commission
Slippage
Execution delay
Broker price feed
Stop level
Tick size
Contract size
```

A strategy with marginal theoretical expectancy may become unprofitable after realistic costs.

Therefore robustness testing should eventually include less favorable execution assumptions.

## Session Analysis

Performance should be examined by trading session where relevant.

Possible groups:

```text
Asia
London
New York
London/New York overlap
Rollover / low-liquidity periods
```

Do not add a session filter based only on intuition.

First measure:

```text
Trades
Win Rate
Profit Factor
Expectancy
Drawdown
```

for each session.

Then test whether excluding specific periods improves out-of-sample performance.

## Directional Analysis

BUY and SELL performance should be measured independently.

Record:

```text
Long Trades
Long Win Rate
Long Expectancy

Short Trades
Short Win Rate
Short Expectancy
```

Do not disable one direction solely because its raw win rate is slightly lower.

The decision should consider:

```text
Expectancy
Profit Factor
Drawdown
Sample size
Stability
```

## Controlled Experiment Naming

Experiments should receive unique identifiers.

Recommended format:

```text
EA<NUMBER>-<TIMEFRAME>-<TYPE>-<SEQUENCE>
```

Examples:

```text
EA045-M1-BASELINE-001
EA045-M5-TIMEFRAME-001
EA045-M15-TIMEFRAME-002
EA045-M5-HTF-001
EA045-M5-CLOSEBREAK-001
EA045-M5-ATRSL-001
```

The identifier should make it possible to trace:

```text
Code
Parameters
Backtest
Result
Conclusion
```

## Experiment Record

Every experiment should answer:

```text
1. What is the hypothesis?
2. What changed?
3. What stayed constant?
4. What data was used?
5. What were the results?
6. Did it beat the baseline?
7. PASS or FAIL?
8. What is the next experiment?
```

Example:

```text
Experiment:
EA045-M5-TIMEFRAME-001

Hypothesis:
M5 reduces false structural breakouts compared with M1.

Changed:
Timeframe M1 → M5

Unchanged:
EMA20
EMA50
SwingBars 5
SL 300
TP 600
Lot 0.01

Result:
[Backtest metrics]

Decision:
PASS / FAIL
```

## Optimization Policy

Optimization should not begin with unrestricted parameter searching.

Avoid:

```text
EMA Fast  = 5 → 100
EMA Slow  = 20 → 300
SL        = 50 → 2000
TP        = 50 → 5000
SwingBars = 1 → 30
```

followed by selecting the highest historical profit.

This creates substantial overfitting risk.

Preferred order:

```text
Understand failure
      ↓
Form hypothesis
      ↓
Test architecture
      ↓
Find promising behavior
      ↓
Only then optimize parameters
```

Optimization is used to investigate parameter regions, not merely to discover the single best historical result.

## Parameter Stability

A robust parameter region is generally more interesting than a single isolated optimum.

Warning pattern:

```text
Parameter 18 → FAIL
Parameter 19 → FAIL
Parameter 20 → EXCELLENT
Parameter 21 → FAIL
Parameter 22 → FAIL
```

This may indicate overfitting.

More desirable:

```text
Parameter 18 → acceptable
Parameter 19 → good
Parameter 20 → good
Parameter 21 → good
Parameter 22 → acceptable
```

This suggests a broader region of stability.

Parameter stability does not prove future profitability, but it provides stronger evidence than a narrow optimum.

## In-Sample and Out-of-Sample Testing

Once a promising strategy is identified, historical data should be separated.

Example:

```text
Historical Data
      ↓
┌───────────────────┬───────────────────┐
│ In-Sample         │ Out-of-Sample     │
│ Research          │ Validation        │
└───────────────────┴───────────────────┘
```

The in-sample period is used for:

```text
Strategy development
Hypothesis testing
Parameter research
```

The out-of-sample period is reserved for validation.

Repeatedly modifying the strategy after viewing out-of-sample results gradually turns the out-of-sample data into development data.

Therefore all such iterations must be documented.

## Walk-Forward Testing

A stronger validation approach is walk-forward testing.

Conceptually:

```text
Train 1 → Test 1
Train 2 → Test 2
Train 3 → Test 3
Train 4 → Test 4
```

This evaluates whether the strategy can maintain useful behavior as market conditions change.

Walk-forward validation becomes relevant after a strategy demonstrates credible baseline and out-of-sample performance.

## Market-Regime Robustness

A strategy should eventually be tested across different XAUUSD environments.

Examples:

```text
Bull markets
Bear markets
Sideways periods
High volatility
Low volatility
Major macro events
Normal trading conditions
```

A system that succeeds only during one favorable regime should be documented as regime-dependent rather than universally robust.

## Broker Robustness

XAUUSD specifications vary between brokers.

Potential differences include:

```text
Symbol name
Digits
Point size
Tick size
Spread
Commission
Contract size
Swap
Trading hours
Stop levels
Liquidity
Execution
```

Therefore a mature EA should eventually be tested using more than one realistic broker/data environment where possible.

## Stress Testing

After a strategy demonstrates positive expectancy, deliberately make conditions worse.

Examples:

```text
Increase spread
Add slippage
Delay entries
Modify parameters slightly
Change test period
Change broker
Change timeframe where logically valid
```

A strategy that collapses under very small changes may not be sufficiently robust.

## Monte Carlo Analysis

For mature candidates, trade-sequence analysis can be extended using Monte Carlo techniques.

Possible simulations include:

```text
Shuffle trade order
Vary slippage
Vary spread
Randomly skip trades
Perturb returns
```

The objective is not to predict the future precisely.

The objective is to estimate how dependent the observed result is on one particular historical sequence.

## Forward Testing

Only strategies that survive historical validation should proceed to forward testing.

Recommended progression:

```text
Backtest
   ↓
Out-of-Sample
   ↓
Robustness
   ↓
Demo Forward Test
   ↓
Small Controlled Live Test
```

Live testing should not be used as a substitute for basic historical research.

## PASS / FAIL Framework

Two separate decisions must always be recorded.

### Technical PASS / FAIL

Technical PASS means:

```text
EA compiles
EA runs
Signals execute
Orders behave according to code
Risk mechanisms function as intended
No critical runtime defects detected
```

Technical PASS does not mean profitable.

### Performance PASS / FAIL

Performance evaluation considers:

```text
Net Profit
Profit Factor
Expected Payoff
Drawdown
Recovery Factor
Sharpe Ratio
Trade count
Stability
```

A strategy with:

```text
Technical PASS
Performance FAIL
```

is a valid research result but not a deployment candidate.

## Research Candidate Status

Recommended statuses:

```text
IDEA
IMPLEMENTED
TECHNICALLY_VALIDATED
BASELINE_TESTED
RESEARCHING
PROMISING
OUT_OF_SAMPLE_VALIDATED
ROBUSTNESS_VALIDATED
FORWARD_TESTING
VALIDATED
REJECTED
```

An EA should move forward only when evidence supports the transition.

## Production Readiness

Production readiness requires substantially more than a profitable backtest.

Minimum evidence should eventually include:

```text
Documented deterministic strategy
Verified source implementation
Technical validation
Positive historical expectancy
Acceptable drawdown
Adequate sample size
Out-of-sample validation
Parameter stability
Execution-cost robustness
Market-regime analysis
Forward-test evidence
Defined risk policy
```

Only then should live deployment be considered.

## EA-045 Methodology Example

The methodology applied to `EA-045_Trend_Pullback_Structure` currently produces:

```text
Strategy documented
        ↓
MQL5 implementation available
        ↓
Technical execution demonstrated
        ↓
Baseline real-tick backtest completed
        ↓
3,757 trades
        ↓
Win Rate = 30.88%
        ↓
Profit Factor = 0.88
        ↓
Net Profit = -$991.65
        ↓
Max Drawdown = 99.17%
        ↓
PERFORMANCE FAIL
```

The correct research response is not:

```text
Delete EA
```

and not:

```text
Optimize everything
```

The correct response is:

```text
Freeze baseline
      ↓
Identify likely failure mechanism
      ↓
Create hypothesis
      ↓
Run controlled experiment
      ↓
Compare evidence
```

For EA-045, the current primary research target is improving entry quality and market-regime selection before optimizing exits.

## Standard Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-<>/
│   │   ├── EA-<>.mq5
│   │   └── README.md
│
├── Backtest/
│   ├── EA-<>/
│   │   ├── README.md
│   │   └── Strategy Tester evidence
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

## Folder Responsibilities

### `EAs/`

Contains the actual Expert Advisor implementation and strategy-specific technical documentation.

### `Backtest/`

Contains reproducible Strategy Tester evidence and interpretation of individual EA experiments.

### `Research/`

Contains research hypotheses, findings, experiment roadmaps, and cross-experiment conclusions.

### `docs/`

Contains repository-wide methodology and research standards.

### `GitHub_Profile/`

Contains the public-facing GitHub profile README and high-level presentation of the research project.

## Reproducibility Standard

Another researcher should ideally be able to determine:

```text
What was tested
Why it was tested
Which code was used
Which parameters were used
Which data/environment was used
What result occurred
How the result was interpreted
What experiment followed
```

If these questions cannot be answered from the repository, the experiment is insufficiently documented.

## Evidence Chain

Each important conclusion should be traceable through:

```text
Research Hypothesis
      ↓
EA Source
      ↓
Parameter Configuration
      ↓
Strategy Tester Report
      ↓
Metrics
      ↓
README Interpretation
      ↓
PASS / FAIL Decision
```

This creates an auditable research history.

## Version Control

Changes to strategy logic should be committed separately from unrelated repository changes where practical.

Commit messages should describe the experiment.

Examples:

```text
Add EA-045 baseline implementation
Add EA-045 M1 baseline backtest
Test EA-045 M5 timeframe hypothesis
Add closed-bar breakout experiment
Document EA-045 baseline failure analysis
```

Avoid ambiguous messages such as:

```text
update
fix
changes
new version
```

The Git history should help reconstruct the research process.

## Research Integrity

Results must be reported regardless of whether they support the original hypothesis.

Do not:

```text
Hide failed backtests
Cherry-pick only profitable periods
Change parameters without documenting them
Present optimization results as unseen validation
Treat one profitable run as proof
Claim production readiness without evidence
```

The purpose of the repository is research transparency, not retrospective selection of attractive results.

## Final Methodology

The complete methodology can be summarized as:

```text
1. Define a deterministic trading hypothesis.

2. Implement the smallest functional EA.

3. Verify technical behavior.

4. Freeze a baseline.

5. Backtest using documented conditions.

6. Preserve raw evidence.

7. Measure profitability, expectancy, risk, and trade behavior.

8. Mark the result PASS or FAIL.

9. Diagnose the most likely weakness.

10. Form one testable hypothesis.

11. Modify one major component.

12. Backtest again.

13. Compare against the baseline.

14. Preserve both successes and failures.

15. Repeat until evidence justifies further validation.

16. Test out-of-sample.

17. Test parameter and regime stability.

18. Stress execution assumptions.

19. Forward test.

20. Consider live deployment only after the complete evidence chain is credible.
```

The repository therefore follows one central rule:

> **Do not search for a backtest that looks good. Build evidence that determines whether a trading edge is real, reproducible, and sufficiently robust to justify the next stage of validation.**

## Current Validation Standard

```text
Code without test
    = UNVALIDATED

Successful compilation
    = TECHNICAL EVIDENCE ONLY

Profitable backtest
    = RESEARCH EVIDENCE ONLY

Out-of-sample success
    = STRONGER EVIDENCE

Robustness success
    = VALIDATION CANDIDATE

Forward-test success
    = DEPLOYMENT EVIDENCE

No single stage alone guarantees future profitability.
```

## Disclaimer

This repository is intended for quantitative research, software development, strategy testing, and educational purposes.

Historical performance does not guarantee future results.

XAUUSD is a leveraged and highly volatile market. Results can vary materially due to spread, slippage, broker specifications, liquidity, execution conditions, leverage, market regime, data quality, and implementation details.

No EA should be deployed with real capital solely because it produces favorable historical results.

Independent validation and appropriate risk management are required before any live trading decision.
