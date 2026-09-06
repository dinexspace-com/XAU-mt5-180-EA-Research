# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard research, implementation, backtesting, and evaluation methodology used in the **XAUUSD MT5 EA Research** repository.

The objective of the project is to systematically transform trading hypotheses into reproducible MetaTrader 5 Expert Advisors, test them using historical XAUUSD data, preserve the evidence, and make research decisions based on measurable results.

The methodology applies to every EA in the repository.

The basic research chain is:

Trading Idea  
→ Define Rules  
→ Implement EA  
→ Compile and Validate  
→ Baseline Backtest  
→ Record Evidence  
→ Evaluate Results  
→ PASS / FAIL  
→ Further Research or Stop

## Core Principle

Every EA is treated as a research experiment.

Source code alone is not evidence that a strategy works.

A strategy must progress through implementation, testing, evidence collection, and evaluation before any conclusion about its performance can be made.

Both successful and unsuccessful experiments must be preserved.

A failed strategy is still valuable research evidence because it prevents the same hypothesis from being repeatedly tested without reference to previous results.

## 1. Strategy Identification

Every strategy receives a unique sequential identifier.

Format:

EA-XXX_Strategy_Name

Example:

EA-044_Trend_Exhaustion_Filter

The EA ID should remain unchanged throughout the research history of that strategy.

The same identifier should be used consistently across:

EAs/  
Backtest/  
Research/

This makes the source code, test evidence, and research conclusions traceable to the same experiment.

## 2. Trading Hypothesis

Before evaluating performance, the strategy must have a clearly defined hypothesis.

The hypothesis should explain:

- What market behavior is being tested
- Why an entry may have an edge
- Which market condition triggers the signal
- How positions are exited
- How risk is controlled

The hypothesis does not need to be proven before implementation.

Its purpose is to define exactly what the EA is testing.

## 3. Convert the Hypothesis into Explicit Rules

The trading idea must be converted into objective rules that can be implemented in MQL5.

Rules should define, where applicable:

- Indicators
- Indicator periods
- Entry conditions
- BUY conditions
- SELL conditions
- Exit conditions
- Stop Loss
- Take Profit
- Position sizing
- Spread filter
- Time filter
- Break Even
- Trailing Stop
- Maximum simultaneous positions
- Additional strategy filters

Avoid discretionary rules that cannot be reproduced programmatically.

A rule such as:

"Buy when the market looks strong"

is not suitable.

A rule such as:

"Buy when Close > EMA(200) and distance from EMA > ATR(14) × 2"

is explicit and testable.

## 4. EA Implementation

The strategy is implemented as a MetaTrader 5 Expert Advisor using MQL5.

Standard source location:

EAs/
└── EA-XXX_Strategy_Name/
    ├── EA-XXX_Strategy_Name.mq5
    └── README.md

The README should document:

- Strategy purpose
- Trading hypothesis
- Indicators
- Entry rules
- Exit rules
- Risk management
- Input parameters
- Execution behavior
- Current research status

The README describes what the code actually implements.

It should not contain unsupported profitability claims.

## 5. Compile and Technical Validation

Before backtesting, the EA must successfully compile in MetaEditor.

Minimum technical requirement:

0 compilation errors

Warnings should be reviewed and resolved where they could affect strategy behavior.

Technical validation should also verify that:

- Indicators initialize correctly
- Trading operations can execute
- Stop Loss and Take Profit are valid
- Position management works as intended
- Magic Number identification works correctly
- Spread filtering works correctly
- No obvious runtime error prevents normal testing

Passing technical validation means only that the EA can be tested.

It does not mean that the strategy is profitable.

## 6. Baseline Backtest

Every EA should receive a baseline backtest before optimization.

The baseline test evaluates the original strategy configuration.

The objective is to answer:

"Does the original hypothesis demonstrate a measurable trading edge under the tested conditions?"

The baseline must be preserved even when it fails.

Do not replace a failed baseline with an optimized result.

The baseline is the reference point for all subsequent research.

## 7. Backtest Environment

Each backtest should record enough information to reproduce the experiment.

At minimum record:

- EA name and version
- Symbol
- Timeframe
- Test start date
- Test end date
- Initial deposit
- Account currency
- Leverage
- Lot size
- Strategy inputs
- Stop Loss
- Take Profit
- Spread-related settings
- Modelling / history quality

Where available, testing should use high-quality historical tick data.

For the EA-044 baseline experiment, the recorded MT5 test used:

Symbol: XAUUSD.PRO  
Timeframe: M1  
Period: 2026.01.02 – 2026.04.01  
Initial Deposit: $1,000  
Leverage: 1:500  
History Quality: 100% real ticks

These values document the EA-044 experiment and are not automatically mandatory settings for every future EA.

## 8. Backtest Evidence

Backtest evidence is stored separately from source code.

Standard location:

Backtest/
└── EA-XXX_Strategy_Name/

The folder should preserve the original MetaTrader 5 Strategy Tester output whenever possible.

Typical contents include:

README.md  
Strategy Tester HTML report  
Balance graph  
Trade distribution graph  
MFE / MAE graph  
Holding-time graph  
Other relevant test evidence

The original report should be preserved because it provides evidence supporting the summarized metrics in the README.

## 9. Metrics to Record

At minimum, evaluate the following metrics when available:

### Net Profit

Total financial result of the test.

### Gross Profit

Total profit generated by winning trades.

### Gross Loss

Total loss generated by losing trades.

### Profit Factor

Gross Profit divided by absolute Gross Loss.

A Profit Factor below 1.0 indicates that gross losses exceeded gross profits during the test.

### Expected Payoff

Average expected financial result per trade in the tested sample.

### Maximum Drawdown

Measures the largest observed decline during the test.

Both monetary and percentage drawdown should be recorded when available.

### Sharpe Ratio

Used as an additional measure of return relative to variability in the tested results.

### Total Trades

Number of completed trades in the test.

A larger sample can provide more evidence about how the strategy behaves, but a large number of trades does not by itself establish profitability.

### Win Rate

Percentage of profitable trades.

Win rate must not be evaluated independently from average profit, average loss, transaction costs, and overall expectancy.

### Average Profit Trade

Average result of profitable trades.

### Average Loss Trade

Average result of losing trades.

### Consecutive Wins and Losses

Used to understand observed winning and losing streaks.

### Holding Time

Where available, record:

- Minimum holding time
- Maximum holding time
- Average holding time

This helps characterize the actual trading behavior of the EA.

## 10. Balance Curve Review

Numerical metrics should be reviewed together with the balance or equity curve.

The curve should be inspected for:

- Overall direction
- Large drawdowns
- Extended deterioration
- Dependence on isolated periods
- Sudden changes in performance
- Recovery behavior
- Potential instability

A profitable final number alone is not sufficient evidence of robustness.

## 11. Baseline Evaluation

After the baseline test, assign a research result.

Possible baseline results:

BASELINE PASS

or

BASELINE FAIL

The decision must be supported by recorded evidence.

A strategy should not receive PASS merely because:

- It compiled successfully
- It generated trades
- Some trades were profitable
- One period was profitable
- The trading idea appears logically convincing

The backtest evidence must support the decision.

## 12. EA-044 Baseline Reference

EA-044 Trend Exhaustion Filter provides the first documented example under this methodology.

Recorded result:

Total Trades: 8,742  
Winning Trades: 43.56%  
Net Profit: -$991.88  
Profit Factor: 0.94  
Expected Payoff: -$0.11  
Maximum Drawdown: 99.25%  
Sharpe Ratio: -5.00

Result:

BASELINE FAIL

This does not prove that every possible Trend Exhaustion strategy fails.

It establishes that the specific EA-044 implementation and parameter configuration failed under the recorded test conditions.

## 13. Failed Strategy Handling

Failed experiments must not be hidden or deleted simply because the result is poor.

A failed strategy should retain:

- Source code
- Strategy description
- Backtest report
- Performance metrics
- Result classification
- Research conclusion

The purpose is to build a cumulative research database.

Future experiments can then determine whether a similar hypothesis has already been tested.

## 14. Optimization

Optimization should only occur after the baseline has been recorded.

The original baseline result must remain unchanged.

Optimization may investigate parameters such as:

- Indicator periods
- ATR multipliers
- Stop Loss
- Take Profit
- Break Even parameters
- Trailing parameters
- Trading sessions
- Volatility filters
- Trend filters
- Entry confirmation filters

Optimization results must be treated as separate experiments from the original baseline.

A better optimized result does not erase the original baseline result.

## 15. Overfitting Control

Optimization creates a risk of selecting parameters that fit historical data without representing a persistent market edge.

Therefore, a strong in-sample result should not automatically be considered a successful strategy.

Promising strategies should subsequently be tested using data not used to select the parameters.

The general progression should be:

Baseline  
→ Research / Optimization  
→ Out-of-Sample Test  
→ Robustness Test  
→ Forward Test  
→ Candidate

Additional validation should only be performed when earlier stages justify continuing the research.

## 16. Out-of-Sample Testing

If a strategy becomes promising after research or optimization, it should be tested on historical data that was not used to select its parameters.

The purpose is to determine whether the observed behavior persists outside the development sample.

The out-of-sample period and results should be recorded separately.

## 17. Robustness Testing

Strategies that survive initial testing may be subjected to additional robustness checks.

Depending on the strategy, these may include:

- Different historical periods
- Different market regimes
- Parameter sensitivity
- Spread variation
- Execution-cost assumptions
- Slippage assumptions
- Nearby parameter combinations
- Different XAUUSD broker symbols or data sources where appropriate

Robustness testing should be proportional to the maturity of the strategy.

Do not build complex validation infrastructure before the strategy demonstrates enough potential to justify it.

## 18. Forward Testing

Backtesting alone is not sufficient evidence for live deployment.

A strategy that passes research and robustness stages may proceed to forward testing.

Forward testing should evaluate behavior under current market and execution conditions without immediately exposing significant real capital.

Record:

- Start date
- End date
- Account type
- Broker
- Symbol
- EA version
- Parameters
- Number of trades
- Profit / loss
- Drawdown
- Execution issues
- Differences from backtest behavior

## 19. Research Status

The following statuses are used throughout the project.

### IDEA

Trading hypothesis exists but has not been implemented.

### IMPLEMENTED

EA has been created and technically validated but does not yet have a completed baseline test.

### BASELINE PASS

The original strategy passed the defined baseline evaluation.

### BASELINE FAIL

The original strategy failed the baseline evaluation.

### RESEARCH

The strategy remains under investigation.

### VALIDATION

The strategy is undergoing additional out-of-sample or robustness testing.

### REJECTED

Available evidence is sufficient to stop further work on the current strategy or implementation.

### CANDIDATE

The strategy has passed the required research stages and is suitable for further forward or controlled live validation.

## 20. Repository Structure

The standard repository structure is:

xauusd-mt5-ea-research/
│
├── EAs/
│   ├── EA-XXX_Strategy_Name/
│   │   ├── EA-XXX_Strategy_Name.mq5
│   │   └── README.md
│
├── Backtest/
│   ├── EA-XXX_Strategy_Name/
│   │   ├── README.md
│   │   └── Backtest evidence
│
├── Research/
│   └── README.md
│
├── docs/
│   └── methodology.md
│
└── GitHub_Profile/
    └── README.md

## 21. Role of Each Directory

### EAs/

Contains the actual MQL5 implementations.

Question answered:

"What exactly was coded?"

### Backtest/

Contains test evidence and performance results.

Question answered:

"What happened when the EA was tested?"

### Research/

Contains the research registry, hypotheses, findings, and current status.

Question answered:

"What did we learn from the experiment?"

### docs/

Contains the common methodology used to conduct the research.

Question answered:

"How is this research performed and evaluated?"

### GitHub_Profile/

Contains the public-facing GitHub profile documentation.

It is separate from the technical evidence used to evaluate individual strategies.

## 22. Traceability Rule

Every research conclusion should be traceable through:

EA ID  
→ Source Code  
→ Strategy Description  
→ Backtest Report  
→ Metrics  
→ Research Conclusion

For example:

EA-044  
→ EA-044_Trend_Exhaustion_Filter.mq5  
→ EAs/EA-044_Trend_Exhaustion_Filter/README.md  
→ Backtest/EA-044_Trend_Exhaustion_Filter/  
→ Backtest metrics  
→ BASELINE FAIL

This prevents conclusions from becoming separated from their supporting evidence.

## 23. Version Integrity

When strategy logic changes materially, the change should be identifiable.

Do not silently replace historical source code when doing so would make an existing backtest impossible to reproduce.

The source version associated with an important backtest should remain traceable.

If a modification changes the hypothesis substantially enough to represent a different strategy, consider assigning a new EA research ID rather than treating it as a simple parameter variation.

## 24. Evidence Rule

A research result requires evidence.

The minimum evidence chain is:

Source Code  
+  
Successful Technical Test  
+  
Backtest Report  
+  
Recorded Metrics  
+  
Evaluation

Without supporting evidence, the strategy remains unverified.

## 25. No Automatic Profitability Claim

The following terms should not be used without sufficient evidence:

Profitable  
Robust  
Production Ready  
Live Ready  
Low Risk  
Safe  
Guaranteed

A successful backtest is evidence about historical behavior under specific test conditions.

It is not a guarantee of future performance.

## 26. Research Decision Flow

The standard decision process is:

Trading hypothesis identified  
↓  
Can the hypothesis be converted into explicit rules?

NO → Clarify or reject hypothesis  
YES → Implement EA  
↓  
Does the EA compile and execute correctly?

NO → Fix implementation  
YES → Run baseline backtest  
↓  
Is valid test evidence available?

NO → Test again  
YES → Record metrics  
↓  
Does baseline meet evaluation requirements?

NO → BASELINE FAIL  
YES → BASELINE PASS  
↓  
Is further research justified?

NO → Preserve evidence and stop  
YES → Research / Optimization  
↓  
Out-of-Sample Testing  
↓  
Robustness Testing  
↓  
Forward Testing  
↓  
CANDIDATE

## 27. Final Research Principle

The purpose of this repository is not to make every EA look successful.

The purpose is to discover which XAUUSD trading hypotheses survive systematic testing.

Therefore:

Do not hide failures.  
Do not change historical results.  
Do not optimize before recording the baseline.  
Do not claim performance without evidence.  
Do not confuse successful code with a successful strategy.  
Do not promote a backtest result directly to live-trading validation.

For every EA:

Define it.  
Code it.  
Test it.  
Record it.  
Evaluate it.  
Preserve the evidence.  
Then decide whether the research should continue.
