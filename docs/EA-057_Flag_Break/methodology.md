# Research & Backtesting Methodology

## 1. Purpose

This document defines the research, implementation, backtesting, evaluation, and evidence-preservation methodology used in the **xauusd-mt5-ea-research** repository.

The objective is to convert trading ideas into explicit algorithmic rules, implement those rules as MetaTrader 5 Expert Advisors, test them against historical market data, and preserve both successful and unsuccessful results.

The workflow is:

    Trading Idea
        ↓
    Define Hypothesis
        ↓
    Convert to Mechanical Rules
        ↓
    Implement MT5 EA
        ↓
    Compile & Functional Test
        ↓
    Baseline Backtest
        ↓
    Preserve Evidence
        ↓
    Evaluate PASS / FAIL
        ↓
    Research Improvements
        ↓
    Retest
        ↓
    Forward Validation

A strategy is not considered successful simply because the EA compiles, executes trades, or produces a high win rate.

Implementation correctness and trading profitability are evaluated separately.

---

## 2. Repository Structure

Each research EA follows the repository structure:

    xauusd-mt5-ea-research/
    │
    ├── EAs/
    │   └── EA-<ID>_<Strategy_Name>/
    │       ├── EA-<ID>_<Strategy_Name>.mq5
    │       └── README.md
    │
    ├── Backtest/
    │   └── EA-<ID>_<Strategy_Name>/
    │       ├── README.md
    │       ├── Strategy Tester report
    │       └── Strategy Tester charts
    │
    ├── Research/
    │   └── README.md
    │
    ├── docs/
    │   └── methodology.md
    │
    └── GitHub_Profile/
        └── README.md

The directories serve different purposes.

### EAs/

Contains the actual MQL5 implementation.

The EA README documents:

- Strategy logic
- Entry rules
- Exit rules
- Risk / position management
- Input parameters
- Execution safeguards
- Platform requirements

### Backtest/

Contains original MetaTrader 5 Strategy Tester evidence.

Backtest results must not be rewritten to make an EA appear more successful.

Negative results are retained.

### Research/

Documents:

- Strategy hypothesis
- Mechanical interpretation
- Research findings
- Failed assumptions
- Questions for future experiments
- Relationship between implementation and test results

### docs/

Contains repository-wide research methodology.

This file defines how strategies should be developed and evaluated consistently.

---

## 3. Strategy Research Principle

Every EA begins with a hypothesis.

Example:

> A strong directional impulse followed by a compact consolidation and a confirmed breakout in the original direction may produce a continuation opportunity.

A hypothesis is not considered evidence of profitability.

The purpose of implementation and backtesting is to attempt to falsify or support the hypothesis using reproducible tests.

The repository therefore distinguishes between:

    IDEA
    ≠
    IMPLEMENTATION
    ≠
    BACKTEST RESULT
    ≠
    VALIDATED STRATEGY

These stages must not be treated as equivalent.

---

## 4. Mechanical Rule Conversion

Trading concepts are often subjective.

Examples include:

- Strong trend
- Strong impulse
- Clean breakout
- Small pullback
- Support / resistance
- Consolidation
- Momentum
- Volatility expansion

Before implementation, subjective concepts must be converted into measurable rules.

For example:

    "Strong candle"

may become:

    Candle Range >= Average Range × Multiplier

and:

    Candle Body / Candle Range >= Minimum Body Ratio

Similarly:

    "Small consolidation"

may become:

    Consolidation Range / Impulse Range <= Maximum Ratio

This conversion is essential because an automated trading system cannot reliably execute undefined visual judgment.

---

## 5. Rule Requirements

Where applicable, each EA should define the following categories explicitly:

### Market

- Symbol
- Timeframe
- Required historical data

### Setup

- Market condition
- Pattern definition
- Indicator conditions
- Price-action conditions

### Entry

- BUY condition
- SELL condition
- Confirmation requirements

### Exit

- Stop Loss
- Take Profit
- Break Even
- Trailing Stop
- Other exit conditions

### Execution

- Spread restrictions
- Slippage handling
- Position limits
- Magic Number
- Duplicate-signal prevention

### Risk

- Lot sizing
- Maximum simultaneous exposure
- Capital assumptions

Not every EA must use every category, but any omitted category should be intentional.

---

## 6. Implementation Stage

Strategies are implemented as MetaTrader 5 Expert Advisors using MQL5.

The implementation stage should focus first on faithfully representing the defined strategy.

The first objective is:

    Correct implementation

not:

    Maximum profitability

Premature optimization can hide problems in the underlying trading hypothesis.

---

## 7. Functional Validation

Before evaluating profitability, the EA should first pass basic implementation checks.

Examples:

- Source compiles successfully
- EA initializes successfully
- No critical runtime errors
- BUY logic can execute
- SELL logic can execute
- Stop Loss is assigned correctly
- Take Profit is assigned correctly
- Position-management logic operates
- Spread restrictions operate where implemented
- Duplicate positions are prevented where intended

Passing these checks means only:

    IMPLEMENTATION → PASS

It does not mean:

    STRATEGY → PROFITABLE

---

## 8. Baseline Backtest

After functional validation, a baseline backtest is performed.

The baseline establishes the first reproducible performance reference for the strategy.

A baseline should record at minimum:

- EA version / filename
- Symbol
- Timeframe
- Test period
- Initial deposit
- Leverage
- Lot size or risk model
- Historical-data quality
- Input parameters
- Strategy Tester results

The exact parameters used in the test must be recorded.

The source-code defaults and tested parameters may differ.

When they differ, the backtest documentation must report the parameters actually used by Strategy Tester.

---

## 9. Historical Data Quality

Where available, testing should prioritize MetaTrader 5 real-tick data.

The historical-data quality must be recorded with the result.

For example:

    History Quality: 100% real ticks

Data quality does not guarantee strategy validity.

It only improves the fidelity of the historical simulation relative to lower-quality modelling methods.

---

## 10. Performance Metrics

Backtest evaluation should consider multiple metrics rather than a single headline result.

Important metrics include:

### Net Profit

Total monetary result after all recorded trades.

### Gross Profit

Total profit generated by winning trades.

### Gross Loss

Total loss generated by losing trades.

### Profit Factor

Conceptually:

    Profit Factor = Gross Profit / |Gross Loss|

A Profit Factor below 1 indicates that gross losses exceeded gross profits during the test.

### Expected Payoff

Average expected monetary result per trade as reported by Strategy Tester.

A negative value indicates negative historical expectancy for the tested configuration.

### Drawdown

Both balance and equity drawdown should be examined.

Relevant values include:

- Absolute drawdown
- Maximum drawdown
- Relative drawdown

### Win Rate

Percentage of profitable trades.

Win rate must never be evaluated in isolation.

A strategy may have:

    Win Rate > 50%

while remaining unprofitable if average losses exceed average profits sufficiently.

### Average Winning Trade

Average result of profitable trades.

### Average Losing Trade

Average result of losing trades.

These two metrics help explain why a strategy with a high win rate may still lose money.

### Recovery Factor

Used as an additional measure of performance relative to drawdown.

### Sharpe Ratio

Used as an additional risk-adjusted performance metric reported by Strategy Tester.

### Number of Trades

Sample size must be considered when interpreting results.

A result generated from only a small number of trades provides weaker evidence than a result observed over a substantial number of independent trading events.

---

## 11. MFE and MAE

Where available, the following Strategy Tester statistics should also be preserved:

    MFE = Maximum Favorable Excursion
    MAE = Maximum Adverse Excursion

These metrics help investigate how far trades move favorably or adversely while positions are open.

Correlations between:

- Profit and MFE
- Profit and MAE
- MFE and MAE

may help identify future research questions concerning:

- Take Profit
- Stop Loss
- Break Even
- Trailing Stop
- Exit timing

However, correlation alone must not be interpreted as proof that changing an exit parameter will improve profitability.

It is a research signal, not a conclusion.

---

## 12. Holding-Time Analysis

Position holding time should be recorded where available.

Relevant statistics include:

- Minimum holding time
- Maximum holding time
- Average holding time

These values help classify the actual behavior of the implemented system.

For example, an EA designed around M1 signals may effectively behave as a short-duration intraday system if most positions are held for only a few minutes.

---

## 13. Direction Analysis

BUY and SELL performance should be examined separately where sufficient data exists.

At minimum:

- Number of long trades
- Long win rate
- Number of short trades
- Short win rate

Where possible, future research may additionally compare:

- Long expectancy
- Short expectancy
- Long Profit Factor
- Short Profit Factor
- Direction-specific drawdown

A strategy should not automatically assume that BUY and SELL behavior is symmetrical.

---

## 14. Evidence Preservation

Every backtest must preserve the original Strategy Tester evidence whenever available.

Typical files include:

    ReportTester-<ID>.html
    ReportTester-<ID>.png
    ReportTester-<ID>-hst.png
    ReportTester-<ID>-mfemae.png
    ReportTester-<ID>-holding.png

The HTML report and its referenced images should remain together.

Do not manually alter Strategy Tester results.

Do not delete failed backtests merely because the results are unfavorable.

A negative backtest is still valid research evidence.

---

## 15. Backtest Classification

Each completed baseline should receive an explicit research status.

Possible classifications include:

    INCOMPLETE
    FAILED BASELINE
    PASSED BASELINE
    NEEDS VALIDATION

### INCOMPLETE

Used when evidence or testing is insufficient.

Examples:

- Missing Strategy Tester report
- Test did not complete
- Runtime errors
- Insufficient data
- Invalid configuration

### FAILED BASELINE

Used when implementation works but the tested configuration fails the research performance criteria.

Examples include:

- Negative net profit
- Profit Factor below 1
- Negative expectancy
- Unacceptable drawdown

### PASSED BASELINE

Used only when the predefined baseline acceptance criteria are satisfied.

Passing a baseline does not mean the strategy is ready for live trading.

It only allows the strategy to proceed to additional validation.

### NEEDS VALIDATION

Used when baseline results appear promising but robustness has not yet been established.

---

## 16. Separate Technical PASS From Strategy PASS

Two different PASS / FAIL decisions must be maintained.

### Technical Validation

Example:

    Compilation                PASS
    EA initialization          PASS
    Entry execution            PASS
    Position management        PASS

Result:

    IMPLEMENTATION PASS

### Trading Validation

Example:

    Positive expectancy        FAIL
    Profit Factor threshold    FAIL
    Drawdown threshold         PASS/FAIL
    Robustness                 NOT TESTED

Result:

    STRATEGY FAIL

This prevents a technically functioning EA from being incorrectly presented as a successful trading strategy.

---

## 17. Baseline Preservation

Once a baseline has been documented, it should remain available as the reference point for future experiments.

Do not overwrite a failed baseline with a later optimized result.

Instead:

    Baseline
       ↓
    Experiment 01
       ↓
    Experiment 02
       ↓
    Experiment 03
       ↓
    Validation Candidate

This preserves the research history and makes improvements traceable.

---

## 18. Controlled Experiments

After a baseline test, improvements should be driven by explicit hypotheses.

Example:

    Observation:
    Too many weak impulse signals may be entering the market.

    Hypothesis:
    Increasing the minimum impulse requirement may reduce false breakouts.

    Change:
    Modify impulse-strength parameters.

    Test:
    Run the same historical test environment.

    Compare:
    Baseline vs Experiment.

Where practical, change one logical variable group at a time.

This helps determine which modification caused the observed result.

---

## 19. Avoid Blind Optimization

Parameter optimization can produce excellent historical results without producing a robust trading strategy.

Therefore:

    Best historical parameter set
    ≠
    Proven trading edge

Optimization should not be used merely to search thousands of combinations until a profitable equity curve appears.

Parameter changes should preferably correspond to a research hypothesis.

Examples:

- Stronger impulse requirement
- Smaller permitted retracement
- Different flag duration
- Breakout confirmation
- Session filter
- Volatility filter
- Exit-management modification

---

## 20. In-Sample and Out-of-Sample Testing

A strategy that passes its initial research stage should eventually be evaluated on data not used to develop or optimize it.

Conceptually:

    Historical Data
          │
          ├── In-Sample
          │      ↓
          │   Research / Development
          │
          └── Out-of-Sample
                 ↓
              Validation

Parameters selected using in-sample data should not automatically be considered validated.

Out-of-sample performance provides additional evidence about whether the observed behavior generalizes beyond the development period.

---

## 21. Forward Testing

A promising historical strategy should proceed to forward testing before being considered for live deployment.

The progression is:

    Mechanical Strategy
          ↓
    Baseline Backtest
          ↓
    Controlled Research
          ↓
    Out-of-Sample Validation
          ↓
    Forward Test
          ↓
    Live Consideration

Forward testing should preserve:

- Start date
- End date
- Broker
- Symbol
- Account conditions
- EA version
- Parameter set
- Trade history
- Performance metrics

---

## 22. Reproducibility

A research result should contain enough information for another researcher to understand what was tested.

At minimum:

    WHAT was tested
    WHERE it was tested
    WHEN it was tested
    WHICH parameters were used
    WHAT result was produced
    WHERE the original evidence is stored

The original Strategy Tester report is preferred as the primary numerical evidence.

README files summarize the evidence but do not replace it.

---

## 23. Failed Experiments

Failed experiments must not be hidden.

Examples:

    Negative Net Profit
    Profit Factor < 1
    Excessive Drawdown
    Unstable Performance
    Insufficient Trades
    Implementation Failure

A failed experiment can reveal:

- Incorrect assumptions
- Weak signal definitions
- Poor exit logic
- Excessive trade frequency
- Market-regime dependence
- Parameter sensitivity

Recording failures prevents the same unsuccessful approach from being repeatedly rediscovered.

---

## 24. EA-057 Baseline Example

EA-057_Flag_Break provides the first documented example of this methodology.

The recorded baseline used:

    Symbol: XAUUSD.PRO
    Timeframe: M1
    Period: 2026-01-02 → 2026-04-01
    Initial Deposit: $1,000
    Leverage: 1:500
    Lot Size: 0.01
    History Quality: 100% real ticks

The test generated:

    Total Trades: 902
    Winning Trades: 56.43%
    Net Profit: -$161.17
    Profit Factor: 0.85
    Expected Payoff: -$0.18
    Maximum Equity Drawdown: 19.23%
    Average Profit Trade: $1.83
    Average Loss Trade: -$2.78

Therefore:

    EA IMPLEMENTATION: PASS
    BASELINE PROFITABILITY: FAIL

This result is preserved rather than discarded.

It becomes the reference against which future EA-057 experiments can be compared.

---

## 25. Standard Research Workflow

For each new EA:

    01. Define trading hypothesis
    02. Convert hypothesis into mechanical rules
    03. Implement rules in MQL5
    04. Compile
    05. Perform functional validation
    06. Run baseline Strategy Tester test
    07. Save original Strategy Tester evidence
    08. Record exact test configuration
    09. Record performance metrics
    10. Assign PASS / FAIL status
    11. Document findings
    12. Define next research hypothesis
    13. Run controlled experiment
    14. Compare against baseline
    15. Preserve both positive and negative results
    16. Perform additional robustness validation before live consideration

---

## 26. Core Principle

The repository follows one fundamental rule:

> Evidence first, conclusions second.

An EA is not considered successful because:

- The strategy sounds logical
- The source code is complex
- The EA compiles
- It executes many trades
- It has a high win rate
- One backtest looks attractive

A strategy becomes more credible only as reproducible evidence accumulates across increasingly demanding tests.

The purpose of this repository is therefore not to present every EA as profitable.

Its purpose is to document the process of discovering which ideas survive objective testing and which do not.

---

## Disclaimer

All Expert Advisors, research results, and backtests in this repository are experimental.

Historical simulations do not guarantee future performance.

Nothing in this repository should be interpreted as financial advice, an investment recommendation, or a guarantee of profitability.
