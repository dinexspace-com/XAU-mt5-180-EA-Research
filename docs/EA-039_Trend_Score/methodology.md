# Research Methodology

## XAUUSD MT5 EA Research

This document defines the standard research, implementation, backtesting, evaluation, and documentation methodology used in the `xauusd-mt5-ea-research` repository.

The purpose of this repository is not to present every Expert Advisor as a successful trading system.

The purpose is to create a structured and reproducible research process for transforming trading ideas into explicit rules, implementing those rules in MQL5, testing them with historical market data, and preserving both successful and failed experiments as research evidence.

The standard workflow is:

    Research Idea
         ↓
    Trading Hypothesis
         ↓
    Explicit Rules
         ↓
    MQL5 Implementation
         ↓
    Compilation / Technical Validation
         ↓
    MT5 Strategy Tester
         ↓
    Performance Analysis
         ↓
    PASS / FAIL
         ↓
    Research Conclusion
         ↓
    Next Experiment

A strategy is never considered successful simply because the source code compiles or because an Expert Advisor executes trades.

Performance claims must be supported by test evidence.

---

## 1. Research Objective

The primary objective of this repository is to systematically investigate automated trading strategies for XAUUSD using MetaTrader 5.

Each EA represents an individual experiment.

Experiments may investigate concepts such as:

- Trend following
- Momentum
- Mean reversion
- Breakouts
- Volatility
- Price action
- Indicator combinations
- Multi-factor scoring
- Trade filtering
- Entry timing
- Exit management
- Risk management

The objective of an experiment is to answer a specific research question.

The objective is not to force every strategy to become profitable.

Negative results are retained because they provide evidence about which hypotheses or implementations did not work under the tested conditions.

---

## 2. Core Research Principle

Every strategy should follow:

    Hypothesis
        ↓
    Rules
        ↓
    Code
        ↓
    Test
        ↓
    Evidence
        ↓
    Conclusion

The conclusion must follow the evidence.

The desired conclusion must never determine the evidence.

Therefore:

    Profitable backtest ≠ automatically proven strategy

and:

    Failed backtest ≠ failed research

A failed experiment can still provide valuable information for the next iteration.

---

## 3. Repository Structure

The standard repository structure is:

    xauusd-mt5-ea-research/
    │
    ├── EAs/
    │   ├── EA-001_<Strategy_Name>/
    │   │   ├── EA-001_<Strategy_Name>.mq5
    │   │   └── README.md
    │   │
    │   ├── EA-002_<Strategy_Name>/
    │   │   ├── EA-002_<Strategy_Name>.mq5
    │   │   └── README.md
    │   │
    │   └── ...
    │
    ├── Backtest/
    │   ├── EA-001_<Strategy_Name>/
    │   │   ├── README.md
    │   │   └── Strategy Tester evidence
    │   │
    │   ├── EA-002_<Strategy_Name>/
    │   │   ├── README.md
    │   │   └── Strategy Tester evidence
    │   │
    │   └── ...
    │
    ├── Research/
    │   └── README.md
    │
    ├── docs/
    │   └── methodology.md
    │
    └── GitHub_Profile/
        └── README.md

Each directory has a different purpose.

---

## 4. EA Directory

Location:

    EAs/EA-XXX_<Strategy_Name>/

Each EA directory contains the actual implementation of an experiment.

Minimum contents:

    EA-XXX_<Strategy_Name>.mq5
    README.md

The `.mq5` file is the executable research implementation.

The README documents what the code actually does.

The README should normally include:

- Strategy overview
- Trading hypothesis
- Indicators used
- Entry logic
- BUY conditions
- SELL conditions
- Exit logic
- Stop Loss
- Take Profit
- Break Even
- Trailing Stop
- Spread filtering
- Position limits
- Input parameters
- Platform information
- Research status

The EA README should describe implementation logic.

It should not claim profitability before backtest evidence exists.

---

## 5. Research Directory

Location:

    Research/

The Research documentation records the reasoning behind experiments.

Research documentation should distinguish between:

    Trading idea
    ↓
    Hypothesis
    ↓
    Rule conversion
    ↓
    Implementation
    ↓
    Test result
    ↓
    Interpretation

The purpose is to preserve why an experiment exists, not only how it was coded.

A useful research record should answer:

1. What is the hypothesis?
2. Why might the hypothesis work?
3. How was the idea converted into objective rules?
4. What variables are being tested?
5. What evidence was produced?
6. Did the evidence support the hypothesis?
7. What should be investigated next?

---

## 6. Strategy Rule Conversion

Trading ideas must be converted into explicit machine-readable rules before implementation.

Avoid rules such as:

    Enter when the trend looks strong.

Instead define measurable conditions such as:

    EMA Fast > EMA Slow

or:

    ADX > 25

or:

    Close[1] > Previous High

The objective is to remove discretionary interpretation from the EA.

A valid rule should be sufficiently explicit that two independent implementations would produce approximately the same intended signal logic.

---

## 7. Minimum Strategy Definition

Before coding, each strategy should define at least:

### Market

Example:

    XAUUSD

### Timeframe

Example:

    M1
    M5
    M15
    H1

### Entry Conditions

Explicit BUY and SELL conditions.

### Exit Conditions

At minimum:

    Stop Loss
    Take Profit

If applicable:

    Break Even
    Trailing Stop
    Signal Exit
    Time Exit

### Position Sizing

Example:

    Fixed Lot = 0.01

or a documented risk-based sizing method.

### Filters

If applicable:

    Spread filter
    Session filter
    Volatility filter
    Trend filter
    Position limit

### Parameters

All adjustable strategy parameters should be explicitly documented.

---

## 8. Implementation Standard

Strategies are implemented as MetaTrader 5 Expert Advisors using MQL5.

Each EA should have a unique identifier:

    EA-XXX_<Strategy_Name>

Example:

    EA-039_Trend_Score

The corresponding source file should use the same naming convention:

    EA-039_Trend_Score.mq5

The objective is to maintain traceability between:

    Research
        ↓
    EA Source
        ↓
    Backtest
        ↓
    Result

---

## 9. Technical Validation

Before performance testing, the EA should first pass technical validation.

Minimum checks include:

    Source code compiles
    ↓
    EA initializes correctly
    ↓
    Indicators initialize correctly
    ↓
    Trading logic executes
    ↓
    Orders can be opened
    ↓
    Orders can be closed
    ↓
    Stop Loss functions
    ↓
    Take Profit functions
    ↓
    Position management functions
    ↓
    No obvious runtime failure

Technical success does not imply strategy success.

Therefore:

    COMPILE PASS ≠ STRATEGY PASS

Compilation only confirms that the implementation can proceed to testing.

---

## 10. Backtesting Platform

Primary testing environment:

    MetaTrader 5 Strategy Tester

Whenever practical, historical tests should use:

    Every tick based on real ticks

The test report should preserve the reported History Quality.

The following test information should be recorded:

- EA name
- Symbol
- Timeframe
- Testing period
- Initial deposit
- Account currency
- Leverage
- Lot size
- EA parameters
- History Quality
- Number of bars
- Number of ticks

This allows future researchers to understand the conditions under which a result was produced.

---

## 11. Backtest Evidence

Each completed test should preserve the original Strategy Tester evidence whenever available.

Example:

    Backtest/
    └── EA-XXX_<Strategy_Name>/
        ├── README.md
        ├── ReportTester-XXXXXX.html
        ├── ReportTester-XXXXXX.png
        ├── ReportTester-XXXXXX-holding.png
        ├── ReportTester-XXXXXX-hst.png
        └── ReportTester-XXXXXX-mfemae.png

The HTML Strategy Tester report is the primary detailed test artifact.

Charts provide visual evidence for:

- Balance development
- Trade distribution
- Holding time
- MFE / MAE
- Profit and loss behavior

Original evidence should be preserved even when the result is poor.

---

## 12. Core Performance Metrics

Backtest evaluation should consider multiple metrics rather than Net Profit alone.

### Total Net Profit

    Net Profit = Gross Profit + Gross Loss

Positive Net Profit is necessary for a profitable historical test but is not sufficient evidence of robustness.

### Profit Factor

    Profit Factor = Gross Profit / |Gross Loss|

Interpretation:

    PF > 1.0 → Gross Profit exceeds Gross Loss
    PF = 1.0 → Break-even before other considerations
    PF < 1.0 → Gross Loss exceeds Gross Profit

A Profit Factor below 1.0 is a clear failure for profitability in that test.

### Expected Payoff

Expected Payoff estimates the average result per trade.

Positive values are preferable.

Negative Expected Payoff indicates negative historical trade expectancy.

### Drawdown

Drawdown measures capital decline from previous equity or balance peaks.

Both Balance Drawdown and Equity Drawdown should be reviewed.

High returns accompanied by extreme drawdown should not automatically be considered successful.

### Sharpe Ratio

Sharpe Ratio provides additional information about return relative to variability.

It should not be used as the only acceptance metric.

### Recovery Factor

Recovery Factor helps evaluate performance relative to drawdown.

Higher positive values generally indicate better recovery characteristics.

### Win Rate

    Win Rate =
    Winning Trades / Total Trades

Win rate must be interpreted together with average winner and average loser.

A low win-rate strategy may still be profitable if winning trades are sufficiently larger than losing trades.

A high win-rate strategy may still fail if losses are disproportionately large.

---

## 13. Average Winner vs Average Loser

The relationship between average profitable and losing trades should be evaluated.

Example:

    Average Winner = $6
    Average Loser  = -$3

This alone does not prove profitability.

The complete expectancy relationship depends on:

    Win Probability
    ×
    Average Win

versus:

    Loss Probability
    ×
    Average Loss

Therefore, win rate and payoff size should always be analyzed together.

---

## 14. Trade Frequency

Total trade count should be reviewed.

Unexpectedly high trade frequency can indicate:

- weak entry filtering;
- repeated signals;
- excessive exposure to market noise;
- timeframe mismatch;
- correlated indicators repeatedly confirming the same condition.

Unexpectedly low trade frequency can make statistical interpretation unreliable.

Trade count therefore provides important context for performance metrics.

---

## 15. Holding Time

Record:

    Minimum Holding Time
    Maximum Holding Time
    Average Holding Time

Holding-time statistics help determine the actual behavioral profile of an EA.

For example, a strategy described as trend-following may in practice behave like a very short-term trading system if average holding time is only several minutes.

Implementation behavior should therefore be compared with the original strategy hypothesis.

---

## 16. Balance and Equity Curve Analysis

Do not evaluate a strategy using final profit alone.

Review the shape of the balance and equity curves.

Positive characteristics may include:

- sustained long-term growth;
- manageable drawdowns;
- recovery after losses;
- absence of dependence on one isolated winning event.

Warning signs include:

- persistent downward trend;
- near-total capital loss;
- one large trade producing most profits;
- long stagnation;
- abrupt unstable changes;
- increasing drawdown over time.

Linear regression statistics may provide additional evidence but should not replace direct analysis of the curve.

---

## 17. MFE and MAE Analysis

When available, review:

    MFE = Maximum Favorable Excursion
    MAE = Maximum Adverse Excursion

MFE indicates how far a trade moved favorably while open.

MAE indicates how far a trade moved adversely while open.

These statistics can help investigate:

- Stop Loss placement
- Take Profit placement
- Break Even behavior
- Trailing Stop behavior
- premature exits
- excessive adverse excursion

MFE / MAE observations should be treated as research evidence for future hypotheses rather than automatically used to optimize the current result.

---

## 18. PASS / FAIL Framework

Every completed experiment should receive an explicit status.

Possible statuses:

    PASS
    FAIL
    INCONCLUSIVE
    NOT YET EVALUATED

### FAIL

A strategy should clearly fail the tested configuration when evidence demonstrates fundamental problems such as:

- negative Net Profit;
- Profit Factor below 1.0;
- negative expectancy;
- unacceptable drawdown;
- near-total capital loss;
- technical execution failure.

### PASS

PASS should require evidence that the strategy meets the predefined acceptance criteria for the experiment.

PASS does not mean:

    Safe for live trading

PASS means:

    The experiment satisfied the acceptance criteria for the current research stage.

### INCONCLUSIVE

Use INCONCLUSIVE when evidence is insufficient to support either PASS or FAIL.

Examples:

- insufficient trades;
- insufficient testing period;
- corrupted data;
- incomplete execution;
- unclear implementation behavior.

---

## 19. Research Stage vs Live Readiness

The following stages must not be confused:

    Code Works
        ↓
    Backtest Works
        ↓
    Initial Validation
        ↓
    Robustness Testing
        ↓
    Out-of-Sample Testing
        ↓
    Forward Testing
        ↓
    Pilot / Demo
        ↓
    Live Readiness

Passing one stage does not automatically approve the next stage.

For example:

    Profitable Backtest ≠ Live Ready

Live deployment requires substantially more evidence than a single profitable historical test.

---

## 20. Baseline Experiment

The first valid implementation of a hypothesis should be treated as a baseline.

Example:

    EA-039
        ↓
    Initial implementation
        ↓
    Backtest
        ↓
    FAIL
        ↓
    Preserve result

Do not erase the failed experiment.

Instead:

    EA-039 baseline
         ↓
    Analyze failure
         ↓
    Create new hypothesis
         ↓
    Create new iteration
         ↓
    Backtest again
         ↓
    Compare

This preserves research history.

---

## 21. Controlled Iteration

When improving an EA, avoid changing many unrelated variables simultaneously.

Preferred process:

    Identify problem
         ↓
    Form hypothesis
         ↓
    Change one major factor
         ↓
    Test
         ↓
    Compare
         ↓
    Accept / Reject hypothesis

Example:

    Problem:
    Too many low-quality entries

    Hypothesis:
    Entry threshold is too permissive

    Change:
    Increase threshold

    Test:
    Run new backtest

    Compare:
    Trade count
    Profit Factor
    Net Profit
    Drawdown
    Expected Payoff

This provides more useful research information than blindly optimizing every parameter.

---

## 22. Avoid Overfitting

Historical profitability can be created artificially by excessive parameter optimization.

Potential warning signs include:

- large numbers of optimized parameters;
- repeated optimization on the same historical period;
- extremely specific parameter combinations;
- excellent in-sample performance but poor unseen-data performance.

Therefore, parameter optimization should occur only after the basic strategy demonstrates enough evidence to justify further investigation.

The research sequence should favor:

    Simple implementation
        ↓
    Initial test
        ↓
    Understand behavior
        ↓
    Controlled improvement
        ↓
    Robustness validation

rather than:

    Massive optimization
        ↓
    Select best historical curve
        ↓
    Assume strategy works

---

## 23. Out-of-Sample Testing

A strategy that survives initial testing should eventually be tested on data not used to develop or optimize the strategy.

Conceptually:

    Historical Data
    ├── Development / In-Sample
    └── Validation / Out-of-Sample

The purpose is to investigate whether performance survives outside the data used to design the strategy.

Out-of-sample testing becomes more important as strategy optimization increases.

---

## 24. Forward Testing

Strategies that survive historical validation may proceed to forward testing.

Forward testing should occur before serious live deployment.

Possible environments include:

    MT5 Demo Account

or a controlled low-risk pilot when appropriate.

Forward testing helps evaluate factors not perfectly represented by historical simulations, including:

- real-time execution;
- spread variation;
- slippage;
- broker conditions;
- operational reliability.

---

## 25. Reproducibility

A research result should preserve enough information for another researcher to understand and reproduce the experiment.

At minimum retain:

    EA source code
    EA version/name
    Symbol
    Timeframe
    Test period
    Initial deposit
    Leverage
    Input parameters
    Strategy Tester report
    Performance metrics
    PASS / FAIL status
    Research conclusion

If these elements are missing, future comparison becomes unreliable.

---

## 26. Documentation Integrity

Documentation must reflect actual evidence.

Do not write:

    The strategy is profitable.

unless testing evidence supports that statement.

Do not write:

    The strategy is robust.

after only one backtest.

Do not write:

    Suitable for live trading.

without completing the required validation stages.

Preferred wording is specific:

    The strategy produced a Profit Factor of X
    during the documented test period.

or:

    The strategy failed the initial backtest
    because Net Profit was negative and
    drawdown exceeded the accepted level.

Specific evidence is preferable to promotional language.

---

## 27. Failed Experiments

Failed experiments should remain in the repository.

Example:

    EA-039_Trend_Score
    Status: FAIL

This is intentional.

A research repository should document:

    What worked
    AND
    What did not work

Removing failed experiments creates survivorship bias and makes the research history less useful.

A failed EA can reveal:

- ineffective indicators;
- redundant signals;
- poor parameter assumptions;
- unsuitable timeframes;
- weak entry filters;
- ineffective exits;
- excessive trading frequency;
- unacceptable risk.

These findings can inform future experiments.

---

## 28. Experiment Versioning

When a strategy undergoes a meaningful conceptual change, preserve traceability.

Do not overwrite historical evidence to make the original experiment appear successful.

Preferred approach:

    Original Experiment
         ↓
    Result preserved
         ↓
    New hypothesis
         ↓
    New iteration / version
         ↓
    New evidence

Each test should remain attributable to the exact strategy implementation and parameter configuration used to produce it.

---

## 29. Standard Research Checklist

Before considering an experiment complete, verify:

### Research

- [ ] Strategy hypothesis documented
- [ ] Trading rules explicitly defined
- [ ] BUY logic documented
- [ ] SELL logic documented
- [ ] Exit logic documented
- [ ] Risk logic documented

### Implementation

- [ ] MQL5 source exists
- [ ] EA compiles
- [ ] EA initializes
- [ ] Orders execute
- [ ] Position management executes
- [ ] Parameters documented

### Backtest

- [ ] Symbol recorded
- [ ] Timeframe recorded
- [ ] Test period recorded
- [ ] Initial capital recorded
- [ ] Leverage recorded
- [ ] History Quality recorded
- [ ] Input parameters preserved
- [ ] Strategy Tester report preserved

### Evaluation

- [ ] Net Profit reviewed
- [ ] Profit Factor reviewed
- [ ] Drawdown reviewed
- [ ] Expected Payoff reviewed
- [ ] Sharpe Ratio reviewed
- [ ] Win/Loss statistics reviewed
- [ ] Trade count reviewed
- [ ] Holding time reviewed
- [ ] Balance curve reviewed

### Documentation

- [ ] EA README completed
- [ ] Backtest README completed
- [ ] Research conclusion recorded
- [ ] PASS / FAIL status recorded
- [ ] Evidence retained

---

## 30. Standard Experiment Flow

The complete minimal research process is:

    STEP 1
    Select research idea
        ↓
    STEP 2
    Define hypothesis
        ↓
    STEP 3
    Convert hypothesis into objective rules
        ↓
    STEP 4
    Implement minimal EA
        ↓
    STEP 5
    Compile and verify execution
        ↓
    STEP 6
    Run standardized MT5 backtest
        ↓
    STEP 7
    Save original evidence
        ↓
    STEP 8
    Analyze performance
        ↓
    STEP 9
    Assign PASS / FAIL / INCONCLUSIVE
        ↓
    STEP 10
    Document conclusion
        ↓
    STEP 11
    Decide whether another experiment is justified

Only after the basic process works should additional complexity be introduced.

---

## 31. Research Philosophy

The repository follows several core principles.

### Evidence Before Claims

No performance claim without evidence.

### Simple Before Complex

Start with the smallest implementation capable of testing the hypothesis.

### Test Before Optimize

Do not optimize a strategy that has not yet demonstrated that its basic behavior is worth investigating.

### Preserve Failures

Failed experiments are part of the research record.

### Separate Implementation From Performance

Working code does not mean a working trading strategy.

### Separate Backtest From Live Readiness

Historical performance alone does not approve real-money deployment.

### Reproducibility

Every important result should be traceable to its code, parameters, environment, and test evidence.

---

## 32. Final Methodology

The standard methodology of `xauusd-mt5-ea-research` can be summarized as:

    IDEA
      ↓
    HYPOTHESIS
      ↓
    EXPLICIT RULES
      ↓
    MINIMAL EA
      ↓
    TECHNICAL TEST
      ↓
    REAL-TICK BACKTEST
      ↓
    SAVE EVIDENCE
      ↓
    ANALYZE METRICS
      ↓
    PASS / FAIL
      ↓
    DOCUMENT RESULT
      ↓
    NEXT HYPOTHESIS

The objective is not to maximize the number of profitable-looking backtests.

The objective is to build a transparent research history in which every strategy can be traced from idea to implementation to empirical result.

A successful repository therefore contains both:

    PASS experiments

and:

    FAIL experiments

because both contribute evidence to the research process.

---

## Disclaimer

This repository is intended for quantitative trading research, software development, and experimentation.

Historical backtests are simulations and do not guarantee future performance.

Results can vary due to market conditions, broker specifications, spreads, slippage, execution, data quality, leverage, symbol configuration, and other factors.

Nothing contained in this repository should be interpreted as financial or investment advice.
