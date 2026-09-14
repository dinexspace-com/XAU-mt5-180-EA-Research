# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the research, implementation, backtesting, evaluation, and evidence-management methodology used in the `xauusd-mt5-ea-research` repository.

The purpose of the repository is to develop and evaluate MetaTrader 5 Expert Advisors for XAUUSD using a reproducible research process.

The methodology is designed to prevent:

- unsupported performance claims;
- selective reporting of successful tests;
- modification of historical evidence;
- premature optimization;
- treating a compiled EA as a validated strategy;
- treating one profitable backtest as proof of robustness.

Each EA must progress through a consistent evidence-based workflow.

---

## 2. Repository Structure

The repository uses the following structure:

    xauusd-mt5-ea-research/
    │
    ├── EAs/
    │   └── EA-<>/
    │       ├── EA-<>.mq5
    │       └── README.md
    │
    ├── Backtest/
    │   └── EA-<>/
    │       ├── original MT5 report
    │       ├── original MT5 graphs
    │       └── README.md
    │
    ├── Research/
    │   └── README.md
    │
    ├── docs/
    │   └── methodology.md
    │
    └── GitHub_Profile/
        └── README.md

Each directory has a separate purpose.

`EAs/` stores strategy implementations.

`Backtest/` stores empirical Strategy Tester evidence.

`Research/` records strategy hypotheses, analysis, findings, failures, and next experiments.

`docs/` defines the common research methodology.

The GitHub profile README presents the overall project publicly.

---

## 3. Core Research Principle

The project follows:

    Hypothesis
        ↓
    Trading Rules
        ↓
    MQL5 Implementation
        ↓
    Compile / Technical Validation
        ↓
    Baseline Backtest
        ↓
    Evidence Preservation
        ↓
    Analysis
        ↓
    PASS / FAIL
        ↓
    Controlled Experiment
        ↓
    Robustness Testing
        ↓
    Production Consideration

A stage must not be treated as evidence for a later stage.

For example:

    Compiles successfully
        ≠
    Profitable strategy

and:

    Profitable backtest
        ≠
    Robust strategy

and:

    Robust historical result
        ≠
    Guaranteed future profitability

---

## 4. EA Identification

Each Expert Advisor receives a unique identifier.

Format:

    EA-XXX_Strategy_Name

Example:

    EA-060_Keltner_Squeeze

The identifier should remain consistent across:

    source code
    documentation
    backtest directory
    research notes
    report references

This allows every result to be traced back to the strategy implementation being tested.

---

## 5. Strategy Hypothesis

Before optimization, each EA should have a clearly defined market hypothesis.

The hypothesis should explain:

- what market behavior is being exploited;
- why an entry may have positive expectancy;
- what invalidates the trade;
- how the strategy exits;
- what market conditions are expected to favor or hurt the strategy.

Example structure:

    Market condition
        ↓
    Observable setup
        ↓
    Entry trigger
        ↓
    Risk definition
        ↓
    Exit logic

The hypothesis should be testable.

Statements such as:

> "This strategy should make money."

are not sufficient.

A useful hypothesis describes observable market behavior that can be converted into explicit trading rules.

---

## 6. Trading Rules

Trading logic must be explicit enough to implement in code.

Rules should define, where applicable:

### Market

    Symbol
    Timeframe

### Entry

    Indicator conditions
    Price conditions
    Candle conditions
    Direction conditions
    Spread restrictions
    Existing-position restrictions

### Risk

    Position size
    Stop Loss
    Maximum spread
    Position limits

### Exit

    Take Profit
    Break Even
    Trailing Stop
    Signal exit
    Time-based exit

The source code is the authoritative definition of what the EA actually executes.

Research documentation describes the intended strategy.

If documentation and implementation disagree, the discrepancy must be investigated rather than silently reconciled.

---

## 7. Source Code Documentation

Each EA directory should contain:

    EAs/EA-XXX_Name/
        EA-XXX_Name.mq5
        README.md

The README should document:

- strategy overview;
- indicators;
- signal logic;
- BUY conditions;
- SELL conditions;
- risk management;
- exit management;
- configurable inputs;
- execution behavior;
- platform requirements.

Performance claims should not be included in the source README unless they are explicitly linked to verified backtest evidence.

---

## 8. Technical Validation

Before backtesting, the EA should pass basic implementation checks.

Minimum technical checks:

    Source exists
    Correct EA identity
    Compiles successfully
    No blocking compile errors
    Indicators initialize correctly
    Trading functions can execute
    Position filtering works
    Price normalization works
    Broker stop constraints are handled

A technically valid EA is marked only as:

    TECHNICALLY VALID

This does not imply:

    STRATEGY PASS

---

## 9. Baseline Backtest

Every EA should first receive a baseline backtest before broad optimization.

The baseline provides a reference result against which future changes can be compared.

The baseline should record:

    Expert Advisor
    Symbol
    Timeframe
    Test period
    Initial deposit
    Leverage
    Lot size
    Strategy parameters
    History quality
    Number of bars
    Number of ticks

The exact configuration used must be preserved.

---

## 10. Backtest Data Quality

Where available, MT5 Strategy Tester should use:

    Every tick based on real ticks

The Strategy Tester report should record the resulting history quality.

For the EA-060 baseline, the preserved report records:

    History Quality = 100% real ticks

A backtest with weaker data quality may still be useful for exploratory research, but its limitations must be recorded.

Data quality must not be hidden.

---

## 11. Original Evidence Preservation

Original MetaTrader 5 Strategy Tester evidence must be retained.

Typical evidence:

    ReportTester-XXXXXX.html
    ReportTester-XXXXXX.png
    ReportTester-XXXXXX-hst.png
    ReportTester-XXXXXX-mfemae.png
    ReportTester-XXXXXX-holding.png

The HTML report is the primary numerical evidence.

Associated MT5-generated images are supporting visual evidence.

Original reports should not be edited to improve presentation or remove unfavorable results.

Failed backtests are retained.

---

## 12. Backtest README

Each tested EA should have a corresponding backtest directory:

    Backtest/EA-XXX_Name/

Its README should summarize the original MT5 report.

Typical metrics include:

    Total Net Profit
    Gross Profit
    Gross Loss
    Profit Factor
    Expected Payoff
    Recovery Factor
    Sharpe Ratio
    Balance Drawdown
    Equity Drawdown
    Total Trades
    Winning Trades
    Losing Trades
    Average Profit Trade
    Average Loss Trade

The README is a summary.

The original Strategy Tester report remains the authoritative evidence.

---

## 13. Baseline Evaluation

The first evaluation asks:

> Does the current implementation demonstrate evidence of a usable trading edge under the tested conditions?

A baseline should be classified transparently.

Possible research statuses:

    PASS
    FAIL
    INCONCLUSIVE

### PASS

The tested configuration provides sufficient evidence to justify further robustness testing.

PASS does not mean production-ready.

### FAIL

The tested configuration does not demonstrate an acceptable edge or risk profile.

The failure is retained as research evidence.

### INCONCLUSIVE

The evidence is insufficient or unsuitable for a reliable conclusion.

Possible causes include:

    insufficient sample size
    poor data quality
    technical execution problems
    incomplete test period
    invalid test configuration

---

## 14. Metrics Used for Evaluation

No single metric determines strategy quality.

The project should examine metrics together.

### Net Profit

    Net Profit = Gross Profit + Gross Loss

Positive net profit is necessary for a profitable historical test but is not sufficient evidence of robustness.

### Profit Factor

    Profit Factor = Gross Profit / |Gross Loss|

Interpretation:

    PF > 1  → historical gross profit exceeds gross loss
    PF = 1  → approximately break-even before other considerations
    PF < 1  → historical gross loss exceeds gross profit

### Expected Payoff

Measures average historical result per trade.

Negative expected payoff indicates negative historical expectancy for the tested sample.

### Drawdown

Both balance and equity drawdown should be examined.

High drawdown can invalidate a strategy even when net profit is positive.

### Recovery Factor

Used to compare profit with experienced drawdown.

### Sharpe Ratio

Used as supporting information about return relative to variability.

It should not be evaluated independently of the equity curve and other risk metrics.

### Trade Count

Sample size matters.

A very small number of trades provides weak statistical evidence.

### Win Rate

Win rate must be interpreted together with average winner and average loser.

A high win rate does not automatically imply positive expectancy.

---

## 15. Expectancy

A simplified expectancy model is:

    Expectancy
        =
    (Win Rate × Average Win)
        -
    (Loss Rate × Average Loss Magnitude)

Therefore:

    Win Rate alone
        ≠
    Trading Edge

A strategy can have a win rate below 50% and remain profitable if winners sufficiently exceed losers.

Likewise, a strategy can have a high win rate and remain unprofitable if losses are disproportionately large.

---

## 16. Equity Curve Analysis

Numerical metrics should be examined together with the equity or balance curve.

Research should inspect whether performance is:

    consistently rising
    consistently declining
    dominated by a few trades
    concentrated in one period
    highly unstable
    experiencing prolonged drawdown

A final profit figure alone can hide unstable behavior.

---

## 17. Trade-Level Analysis

When a baseline fails or produces questionable results, trade-level behavior should be investigated.

Possible questions:

    Are entries occurring too frequently?

    Are false breakouts common?

    Are profitable trades being closed prematurely?

    Are losing trades concentrated in specific sessions?

    Does one market regime dominate losses?

    Are BUY and SELL results materially different?

    Is spread materially affecting short-duration trades?

    Are Stop Loss and Take Profit distances appropriate?

This analysis should occur before broad parameter optimization.

---

## 18. MFE and MAE

Where available, research may use:

    MFE = Maximum Favorable Excursion
    MAE = Maximum Adverse Excursion

MFE helps measure how far price moved favorably while a trade was open.

MAE helps measure how far price moved adversely while a trade was open.

These metrics can help investigate:

    Stop Loss placement
    Take Profit placement
    Break Even timing
    Trailing Stop behavior
    exit efficiency

Correlation values alone should not be used to redesign exits without examining actual trade behavior.

---

## 19. Holding-Time Analysis

Position holding time should be recorded where available.

Important values include:

    Minimum holding time
    Maximum holding time
    Average holding time

Holding time helps classify the actual behavior of an EA.

For example, a strategy designed around breakout logic may operationally behave as a short-duration scalping system if most positions close within minutes.

This affects the importance of:

    spread
    execution
    slippage
    market noise
    broker conditions

---

## 20. Failed Backtests

Failed tests must not be deleted merely because they perform poorly.

A failed test provides evidence about:

    invalid hypotheses
    weak filters
    poor parameters
    inappropriate exits
    unsuitable market regimes

Failed tests should remain traceable.

Example:

    EA-060 baseline
        ↓
    Net Profit < 0
        ↓
    PF < 1
        ↓
    Extreme drawdown
        ↓
    Baseline FAIL
        ↓
    Investigate cause

This prevents repeated testing of previously rejected configurations without understanding why they failed.

---

## 21. Controlled Experiments

After a baseline, research should prefer controlled experiments.

Principle:

> Change one primary variable or one tightly related component at a time whenever practical.

Example:

Baseline:

    Squeeze Ratio = 1.5

Experiment:

    0.60
    0.70
    0.80
    0.90
    1.00

while keeping other parameters unchanged.

This allows changes in performance to be associated more clearly with the variable under investigation.

---

## 22. Avoid Blind Optimization

Large optimization searches can discover parameter combinations that fit historical noise.

Therefore the preferred sequence is:

    Understand baseline
        ↓
    Identify likely weakness
        ↓
    Form hypothesis
        ↓
    Run controlled experiment
        ↓
    Analyze behavior
        ↓
    Only then expand search

Optimization should answer a research question.

It should not simply search thousands of combinations until a profitable backtest appears.

---

## 23. Parameter Selection

Parameters should be divided conceptually into groups.

### Signal Parameters

Examples:

    EMA period
    ATR period
    Keltner multiplier
    squeeze lookback
    squeeze ratio

### Risk Parameters

Examples:

    lot size
    Stop Loss

### Exit Parameters

Examples:

    Take Profit
    Break Even trigger
    Break Even offset
    Trailing start
    Trailing distance

### Execution Parameters

Examples:

    spread filter
    slippage/deviation

Changing multiple groups simultaneously makes it harder to identify why performance changed.

---

## 24. In-Sample and Out-of-Sample Testing

A configuration discovered using one historical period should not be evaluated only on the same data used to develop it.

Later-stage research should separate:

    In-Sample
    Out-of-Sample

Conceptually:

    Historical Data
        │
        ├── Development / In-Sample
        │
        └── Validation / Out-of-Sample

The in-sample period is used for strategy development.

The out-of-sample period is used to evaluate whether the resulting strategy behavior persists on unseen historical data.

---

## 25. Robustness Testing

A promising EA should eventually be tested beyond a single parameter set.

Potential robustness checks include:

    Different historical periods
    Different volatility regimes
    Nearby parameter values
    Different spreads
    Different execution assumptions
    Out-of-sample periods

A robust strategy should not depend entirely on one exact historical configuration.

Robustness testing occurs after a promising baseline or controlled research result.

It should not be used to hide a fundamentally failing baseline.

---

## 26. Forward Testing

Historical backtesting cannot reproduce every live trading condition.

Before production consideration, a promising strategy should eventually undergo forward testing.

Forward testing can reveal differences involving:

    execution latency
    live spread
    slippage
    broker behavior
    market data
    trading-session conditions

A successful backtest alone does not authorize live deployment.

---

## 27. Production Readiness

The repository distinguishes research success from production readiness.

A conceptual progression is:

    SOURCE CREATED
        ↓
    TECHNICALLY VALID
        ↓
    BASELINE TESTED
        ↓
    RESEARCH PASS
        ↓
    ROBUSTNESS PASS
        ↓
    OUT-OF-SAMPLE PASS
        ↓
    FORWARD TEST PASS
        ↓
    PRODUCTION CANDIDATE

Each stage requires its own evidence.

Skipping stages should be explicitly documented.

---

## 28. Reproducibility

Another researcher should be able to identify:

    Which EA was tested?
    Which source implementation?
    Which symbol?
    Which timeframe?
    Which period?
    Which parameters?
    Which initial deposit?
    Which leverage?
    Which data quality?
    What was the result?
    Where is the original evidence?

If these questions cannot be answered, the experiment is not sufficiently documented.

---

## 29. Evidence Hierarchy

For this repository, evidence should be interpreted in the following order:

    1. Original MT5 Strategy Tester report
    2. Original MT5-generated graphs
    3. EA source code
    4. Backtest README
    5. Research README
    6. Repository summaries / profile presentation

Performance numbers should trace back to the original Strategy Tester report.

Trading logic should trace back to the actual EA source.

Documentation must not override contradictory primary evidence.

---

## 30. EA-060 Baseline Example

The first documented baseline under this methodology is:

    EA-060_Keltner_Squeeze

Test:

    Symbol:          XAUUSD.PRO
    Timeframe:       M1
    Period:          2026.01.02 - 2026.04.01
    Initial Deposit: $1,000
    Leverage:        1:500
    History Quality: 100% real ticks

Result:

    Net Profit:       -$921.69
    Profit Factor:    0.81
    Expected Payoff:  -$0.25
    Balance DD:       92.45%
    Equity DD:        92.48%
    Total Trades:     3,642

Classification:

    BASELINE FAIL

This result is retained rather than discarded.

The failure becomes the starting point for the next research hypothesis.

---

## 31. EA-060 Next Research Question

For EA-060, the next controlled investigation focuses on the squeeze definition.

The baseline uses:

    Squeeze Lookback = 2
    Squeeze Ratio    = 1.5

Given the implemented condition:

    Current Width <= Historical Average Width × Squeeze Ratio

the value:

    1.5

allows the current width to be substantially larger than the historical average while still satisfying the condition.

This raises a research question:

> Is the baseline squeeze filter too permissive to represent meaningful volatility compression?

The next experiment should test this hypothesis without simultaneously redesigning the entire EA.

---

## 32. Research Integrity

The repository should preserve both successful and unsuccessful results.

The following practices should be avoided:

    deleting failed tests;
    reporting only the best parameter combination;
    modifying original MT5 evidence;
    presenting optimization results as independent validation;
    claiming profitability without corresponding evidence;
    changing several strategy components without recording the change;
    treating historical profitability as guaranteed future performance.

The purpose of the repository is research traceability rather than presenting every EA as successful.

---

## 33. Documentation Rule

For every EA:

### Source

Store in:

    EAs/EA-XXX_Name/

### Backtest Evidence

Store in:

    Backtest/EA-XXX_Name/

### Research Analysis

Document according to the methodology defined here.

Every important claim should be traceable to:

    code
    test
    evidence
    analysis

---

## 34. Final Methodology

The standard workflow for this repository is:

    01. Define hypothesis

    02. Convert hypothesis into explicit rules

    03. Implement EA in MQL5

    04. Validate implementation technically

    05. Document source behavior

    06. Run baseline MT5 backtest

    07. Preserve original report and graphs

    08. Extract performance metrics

    09. Classify baseline as PASS / FAIL / INCONCLUSIVE

    10. Analyze trade behavior

    11. Identify one primary research question

    12. Run controlled experiments

    13. Compare against baseline

    14. Test robustness if evidence improves

    15. Perform out-of-sample validation

    16. Perform forward testing before production consideration

The governing principle is:

> Hypothesis → Code → Test → Evidence → Analysis → Decision → Next Experiment

No EA is considered validated merely because it exists, compiles, or produces a profitable historical result.
