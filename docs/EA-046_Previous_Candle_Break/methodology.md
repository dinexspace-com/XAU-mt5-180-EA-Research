# Research Methodology — XAUUSD MT5 EA Research

## Purpose

This document defines the research, implementation, backtesting, evaluation, and validation methodology used in the **xauusd-mt5-ea-research** repository.

The objective of the repository is to investigate XAUUSD trading concepts by converting each concept into an explicit MetaTrader 5 Expert Advisor, testing it under documented conditions, preserving both positive and negative results, and progressively determining whether the strategy contains a reproducible trading edge.

The repository is designed as a research record rather than a collection of only profitable backtests.

A failed strategy is considered a valid research result when its trading logic, source code, test configuration, backtest evidence, and conclusion are documented and reproducible.

## Core Research Principle

The research process follows:

**Idea → Explicit Rules → EA Implementation → Baseline Backtest → Evaluation → Controlled Experiment → Validation → Research Conclusion**

The baseline version of a strategy should remain simple.

Complex filters, optimization, machine learning, parameter searches, or additional confirmation rules should not be introduced before the original concept has been implemented and tested.

The purpose of the baseline is to answer:

**Does the original trading concept demonstrate an observable edge before additional optimization?**

If the answer is no, the failed result is preserved and can become the control against which later variants are measured.

## Repository Structure

The research repository follows this structure:

    xauusd-mt5-ea-research/
    │
    ├── EAs/
    │   ├── EA-<>/
    │   │   ├── EA-<>.mq5
    │   │   └── README.md
    │
    ├── Backtest/
    │   ├── EA-<>/
    │
    ├── Research/
    │   └── README.md
    │
    ├── docs/
    │   └── methodology.md
    │
    └── GitHub_Profile/
        └── README.md

Each directory has a separate research function.

### EAs/

Contains the MQL5 implementation of each strategy.

Each EA directory should contain:

- the original `.mq5` source code;
- a README describing the strategy;
- entry rules;
- exit rules;
- risk management;
- configurable parameters;
- implemented filters;
- known limitations.

Example:

    EAs/
    └── EA-046_Previous_Candle_Break/
        ├── EA-046_Previous_Candle_Break.mq5
        └── README.md

The source code is the authoritative implementation of the strategy.

The README explains what that implementation actually does.

Strategy behavior should not be documented as implemented unless it exists in the source code.

### Backtest/

Contains the evidence produced by MetaTrader 5 Strategy Tester.

Example:

    Backtest/
    └── EA-046_Previous_Candle_Break/
        ├── README.md
        ├── Strategy Tester HTML report
        └── Strategy Tester charts

The original Strategy Tester report should be retained whenever possible.

The backtest README summarizes the test configuration, parameters, performance metrics, observations, and result.

Failed backtests must not be removed merely because the strategy was unprofitable.

### Research/

Contains the interpretation of research results and the hypotheses generated from them.

Research documentation should distinguish between:

- observed evidence;
- interpretation;
- hypothesis;
- future experiment.

For example, if a baseline strategy loses money on M1, the valid conclusion is that the tested M1 configuration failed.

It is not sufficient evidence to conclude that the underlying strategy concept can never work on any timeframe or configuration.

### docs/

Contains repository-wide methodology and research standards.

This file defines those standards.

### GitHub_Profile/

Contains presentation material for the public GitHub profile.

Research evidence should originate from the EA, backtest, and research directories rather than being created independently for presentation purposes.

## EA Identification

Each strategy receives a unique sequential identifier.

Format:

    EA-###

Example:

    EA-046

A descriptive strategy name follows the identifier.

Example:

    EA-046_Previous_Candle_Break

The identifier should remain stable even if the strategy later fails.

A failed EA number should not be reused for another strategy.

This preserves the research history.

## Baseline Development

Each new strategy begins with a baseline implementation.

The baseline should implement the core strategy idea with the minimum logic required to test it correctly.

For example, the EA-046 baseline tests the Previous Candle Break concept using:

    BUY:
    Current Close > Previous Candle High

    SELL:
    Current Close < Previous Candle Low

Additional mechanisms such as fixed Stop Loss, Take Profit, spread protection, Break Even, Trailing Stop, Magic Number identification, and position control may be included when required for executable EA behavior.

The baseline should not be overloaded with unrelated indicators or filters.

## Strategy Specification

Before interpreting backtest results, the strategy must have explicit rules.

At minimum, document:

- instrument;
- timeframe behavior;
- BUY condition;
- SELL condition;
- Stop Loss;
- Take Profit;
- position sizing;
- spread handling;
- position limits;
- Break Even behavior if present;
- Trailing Stop behavior if present;
- session restrictions if present;
- indicator filters if present;
- other execution restrictions.

Ambiguous discretionary rules should be converted into deterministic conditions before being coded.

## Source Code Verification

The `.mq5` source code should be reviewed before creating the EA documentation.

Documentation must reflect the implementation rather than the intended strategy.

If the intended rule and implemented rule differ, the implemented behavior must be identified.

A backtest evaluates the compiled implementation, not the original idea.

Therefore:

**Source Code → Actual Trading Logic → Backtest**

must remain traceable.

## Backtest Evidence

MetaTrader 5 Strategy Tester is used to produce the primary quantitative evidence.

Each important test should preserve the original Strategy Tester output.

Where available, retain:

- HTML Strategy Tester report;
- balance/equity graph;
- trade-distribution charts;
- MFE/MAE chart;
- holding-time chart;
- other automatically generated Strategy Tester evidence.

The HTML report should be treated as the primary source for numerical metrics.

Charts are supporting evidence.

## Backtest Configuration

Every documented test should record enough information to reproduce the experiment.

At minimum:

- EA name;
- symbol;
- timeframe;
- test start date;
- test end date;
- modeling/history quality;
- initial deposit;
- leverage;
- EA inputs;
- number of bars;
- number of ticks when available;
- number of trades.

Broker-specific symbol names should be preserved.

For example:

    XAUUSD.PRO

should not automatically be rewritten as:

    XAUUSD

because contract specifications and trading conditions can differ between broker symbols.

## Historical Data Quality

Backtests should use the highest practical data quality available.

When the Strategy Tester reports:

    100% real ticks

this should be recorded in the backtest documentation.

Data quality alone does not prove that a strategy is valid.

It improves the reliability of the historical simulation but does not remove risks such as:

- overfitting;
- regime dependence;
- broker dependence;
- execution differences;
- spread differences;
- future market changes.

## Baseline Metrics

At minimum, each major backtest should record:

- Total Net Profit;
- Gross Profit;
- Gross Loss;
- Profit Factor;
- Expected Payoff;
- Recovery Factor;
- Sharpe Ratio;
- Balance Drawdown;
- Equity Drawdown;
- Total Trades;
- Win Rate;
- Loss Rate;
- Long Trades;
- Short Trades;
- Long Win Rate;
- Short Win Rate;
- Largest Winning Trade;
- Largest Losing Trade;
- Average Winning Trade;
- Average Losing Trade;
- Consecutive Wins;
- Consecutive Losses;
- Position Holding Time when available.

No single metric should determine strategy quality.

## Profit Factor

Profit Factor is calculated conceptually as:

    Gross Profit / Absolute Gross Loss

Interpretation:

    PF > 1.0  → Gross profits exceed gross losses
    PF = 1.0  → Gross profits approximately equal gross losses
    PF < 1.0  → Gross losses exceed gross profits

Profit Factor below 1.0 is clear evidence that the tested configuration is losing before considering whether it can be improved.

Profit Factor above 1.0 alone is not sufficient to approve a strategy.

## Expected Payoff

Expected Payoff measures average result per trade.

A negative Expected Payoff indicates that the tested strategy loses money on average per trade during the tested sample.

A positive Expected Payoff is preferable but must be evaluated together with:

- sample size;
- drawdown;
- Profit Factor;
- equity behavior;
- robustness.

## Drawdown

Drawdown is treated as a primary risk metric.

Both balance and equity drawdown should be recorded when available.

A profitable strategy with excessive drawdown may still be unsuitable.

A strategy should therefore not be ranked solely by final profit.

Research comparisons should consider the relationship between:

    Return
    Risk
    Drawdown
    Trade Count
    Stability

## Trade Count

Sample size matters.

A strategy producing a small number of trades may show attractive statistics by chance.

A larger trade sample provides more evidence, but a large sample does not automatically make a strategy profitable.

For example, EA-046 produced thousands of trades in its baseline test but still showed negative expectancy.

Trade count therefore measures the amount of evidence, not the quality of the edge.

## Win Rate

Win rate must not be interpreted independently.

A low win-rate strategy can be profitable if average winners are sufficiently larger than average losers.

A high win-rate strategy can be unprofitable if occasional losses are disproportionately large.

Therefore evaluate:

    Win Rate
    +
    Average Win
    +
    Average Loss
    +
    Profit Factor
    +
    Expected Payoff

together.

## Equity Curve

The equity/balance curve is inspected as supporting evidence.

Researchers should look for:

- persistent upward progression;
- persistent downward progression;
- long stagnation;
- abrupt dependence on a few trades;
- unstable periods;
- increasing drawdown;
- regime-specific behavior.

A final positive net profit does not automatically indicate a stable strategy.

## Baseline PASS / FAIL

The purpose of baseline classification is to summarize whether the tested configuration demonstrates sufficient evidence to justify further validation.

A baseline should be marked **FAIL** when the available evidence clearly demonstrates a negative trading result.

Examples include combinations such as:

- negative net profit;
- Profit Factor below 1.0;
- negative Expected Payoff;
- severe drawdown;
- persistently declining equity curve.

EA-046 is an example of a baseline FAIL.

A baseline should not automatically be marked PASS merely because Net Profit is positive.

A positive candidate requires further evaluation.

Therefore the research states should be understood as:

    FAIL
    CANDIDATE
    VALIDATED

rather than assuming that every profitable backtest is validated.

## FAIL

FAIL means:

**The tested configuration did not demonstrate an acceptable edge under the documented conditions.**

FAIL does not necessarily mean:

**The entire underlying trading idea can never work.**

Failed results remain part of the repository.

## CANDIDATE

CANDIDATE means that a configuration shows enough evidence to justify additional validation.

Candidate status does not authorize live trading and does not establish robustness.

A candidate should proceed to additional testing.

## VALIDATED

VALIDATED should only be used after substantially stronger evidence than a single backtest.

Validation may include:

- out-of-sample testing;
- walk-forward evaluation;
- robustness testing;
- parameter sensitivity testing;
- forward/demo testing.

The exact validation evidence should be documented.

## Controlled Experiments

After the baseline, strategy development should use controlled experiments.

Preferred rule:

**Change one major variable at a time.**

Example:

    Baseline
    ↓
    Change timeframe
    ↓
    Compare
    ↓
    Add trend filter
    ↓
    Compare
    ↓
    Add volatility filter
    ↓
    Compare

Avoid:

    Baseline
    ↓
    Change timeframe + EMA + RSI + ATR + session + SL + TP
    ↓
    Profitable result

The second process makes it difficult to determine which modification produced the improvement.

## Variant Naming

Research variants should be traceable to their parent EA.

Example:

    EA-046
    EA-046-R01
    EA-046-R02
    EA-046-R03

The exact naming convention may evolve, but every experiment should remain traceable to:

- parent strategy;
- modification;
- test configuration;
- backtest evidence;
- conclusion.

## Parameter Optimization

Parameter optimization should not be the first research step.

Before optimization, determine whether the strategy contains a plausible underlying edge.

Optimization performed too early can fit parameters to historical noise.

When optimization is eventually performed:

- define the parameter ranges;
- record the optimization method;
- preserve the tested range;
- avoid selecting only the single best result;
- inspect neighboring parameter values;
- test selected parameters on unseen data.

A robust strategy should not depend on one extremely narrow parameter combination.

## Overfitting Control

Overfitting is one of the main risks in EA research.

The following practices should be avoided:

- repeatedly changing rules until historical profit appears;
- searching extremely large parameter spaces without a hypothesis;
- selecting only the best-performing timeframe;
- selecting only profitable periods;
- deleting failed tests;
- adding filters based solely on observed historical losses;
- evaluating and validating on the same dataset;
- presenting in-sample optimization as independent evidence.

Negative experiments should remain visible.

## In-Sample Testing

In-sample data may be used for:

- initial strategy development;
- hypothesis generation;
- controlled parameter research.

Performance on in-sample data should not be treated as final validation.

## Out-of-Sample Testing

Once a candidate strategy is identified, it should be tested on data that was not used to develop the strategy.

The purpose is to answer:

**Does the observed behavior persist outside the development sample?**

The out-of-sample period should not be repeatedly used to redesign the strategy, otherwise it effectively becomes part of the in-sample data.

## Walk-Forward Evaluation

For stronger candidates, walk-forward testing can be used.

Conceptually:

    Development Window
    → Test Window
    → Move Forward
    → Development Window
    → Test Window
    → Repeat

The objective is to evaluate whether the strategy remains useful across changing market periods rather than only one historical interval.

## Robustness Testing

Candidate strategies should eventually be challenged rather than protected.

Potential robustness tests include:

- different historical periods;
- different market regimes;
- parameter perturbation;
- spread variation;
- execution assumptions;
- different broker data when practical;
- timeframe comparison;
- Monte Carlo analysis when appropriate.

The objective is not to find another attractive chart.

The objective is to discover whether the strategy fails when reasonable assumptions change.

## XAUUSD-Specific Research

This repository focuses on XAUUSD.

XAUUSD behavior can vary significantly with:

- volatility;
- trading session;
- macroeconomic events;
- liquidity;
- spread;
- broker symbol specification;
- market regime.

Research variants may therefore investigate:

- timeframe;
- trend regime;
- volatility regime;
- ATR;
- session;
- breakout strength;
- structural levels;
- confirmation;
- exit behavior.

These variables should be introduced through explicit hypotheses rather than arbitrary complexity.

## Separation of Entry and Exit Research

Entry quality and exit quality should be studied separately whenever practical.

For example:

    Entry A + Exit 1
    Entry A + Exit 2
    Entry A + Exit 3

can determine whether performance changes are caused by exit management.

Similarly:

    Entry A + Exit 1
    Entry B + Exit 1

can help compare entry logic while holding exits constant.

This reduces ambiguity.

## Break Even and Trailing Stop

Break Even and Trailing Stop can materially alter the realized payoff distribution.

Therefore the nominal Stop Loss / Take Profit ratio must not automatically be interpreted as the realized reward/risk ratio.

Where these mechanisms are active, research should examine:

- average winner;
- average loser;
- win rate;
- Profit Factor;
- Expected Payoff;
- exit reasons;
- resulting drawdown.

## Failed Strategy Preservation

Failed strategies must be preserved.

A failed strategy provides:

- evidence that a hypothesis was tested;
- a baseline for future comparison;
- protection against repeating the same experiment;
- information about market behavior;
- evidence of research transparency.

The repository should not become a survivorship-biased collection containing only profitable EAs.

## Reproducibility

Another researcher should be able to understand:

1. What was tested?
2. Why was it tested?
3. What code executed the strategy?
4. What parameters were used?
5. What market and timeframe were used?
6. What historical period was tested?
7. What result was produced?
8. Where is the original evidence?
9. What conclusion was reached?
10. What experiment came next?

If these questions cannot be answered, the research record is incomplete.

## Evidence Hierarchy

The preferred evidence hierarchy is:

    MQL5 Source Code
    ↓
    MT5 Strategy Tester Original Report
    ↓
    Backtest README
    ↓
    Research Interpretation
    ↓
    Repository / GitHub Presentation

Presentation material should never override the underlying evidence.

## Research Workflow

Every new EA should follow this workflow:

    1. Define strategy idea
    2. Convert idea into explicit rules
    3. Assign EA identifier
    4. Implement MQL5 baseline
    5. Review source code
    6. Document EA behavior
    7. Compile and verify execution
    8. Run baseline backtest
    9. Preserve original Strategy Tester evidence
    10. Extract performance metrics
    11. Evaluate result
    12. Mark FAIL or CANDIDATE
    13. Record research interpretation
    14. Define one next hypothesis
    15. Create controlled variant
    16. Repeat testing
    17. Perform out-of-sample validation for candidates
    18. Perform robustness testing
    19. Forward/demo test stronger candidates
    20. Record final research conclusion

## Example — EA-046

EA-046 demonstrates the methodology.

Strategy:

    Previous Candle Break

Baseline entry:

    BUY:
    Current Close > Previous Candle High

    SELL:
    Current Close < Previous Candle Low

Baseline test:

    Symbol: XAUUSD.PRO
    Timeframe: M1
    Period: 2026.01.02 - 2026.04.01
    Initial Deposit: $1,000
    Leverage: 1:500
    History Quality: 100% real ticks
    Total Trades: 2,760

Key results:

    Net Profit: -$592.81
    Profit Factor: 0.87
    Expected Payoff: -$0.21
    Maximum Equity Drawdown: 59.88%
    Win Rate: 39.67%
    Sharpe Ratio: -5.00

Research classification:

    BASELINE: FAIL

The failed baseline is preserved.

The appropriate next action is not to hide the result or immediately optimize dozens of parameters.

Instead, EA-046 proceeds through controlled hypotheses, beginning with a timeframe comparison.

This allows future variants to be measured against a known baseline.

## Research Integrity

The repository should present results as they occurred.

Do not:

- label an unvalidated strategy as profitable in general;
- imply live profitability from a historical backtest;
- remove failed results to improve presentation;
- change reported Strategy Tester metrics;
- describe functionality that does not exist in the source code;
- describe optimized results as baseline results;
- confuse research hypotheses with demonstrated findings.

The distinction between evidence and hypothesis must remain clear.

## Final Research Standard

An EA is not considered successful because:

- it compiles;
- it places trades;
- one backtest is profitable;
- one parameter set produces a high return;
- one equity curve looks attractive.

The research objective is stronger:

**Identify trading behavior that is explicit, measurable, reproducible, robust enough to survive additional testing, and supported by preserved evidence.**

The repository therefore values:

**Reproducibility over presentation.**

**Evidence over assumptions.**

**Controlled experiments over uncontrolled optimization.**

**Robustness over maximum historical profit.**

**Preserved failures over survivorship bias.**

## Disclaimer

All Expert Advisors, source code, research notes, and backtest results in this repository are provided for research and educational purposes.

Backtested or historical performance does not guarantee future results.

Trading XAUUSD and other leveraged financial instruments involves substantial risk. Broker conditions, spreads, execution, leverage, market structure, and future price behavior may differ materially from historical simulations.
