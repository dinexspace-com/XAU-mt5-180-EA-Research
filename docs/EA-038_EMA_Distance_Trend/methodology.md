# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the research and validation methodology used in the **XAUUSD MT5 EA Research** repository.

The objective is to maintain a clear and reproducible process for transforming a trading hypothesis into:

1. A documented strategy.
2. A MetaTrader 5 Expert Advisor.
3. A reproducible backtest.
4. Measurable evidence.
5. A PASS / FAIL research conclusion.

A strategy is not considered successful simply because its trading logic appears reasonable.

Every strategy must be evaluated using actual test evidence.

---

## 2. Research Workflow

The standard workflow is:

```text
Trading Idea / Hypothesis
        ↓
Define Trading Rules
        ↓
Implement EA in MQL5
        ↓
Compile and Verify
        ↓
Baseline Backtest
        ↓
Collect Evidence
        ↓
Analyze Results
        ↓
PASS / FAIL
        ↓
Further Research if justified
```

Each stage should remain traceable through files stored in the repository.

---

## 3. Strategy Definition

Before evaluating performance, the trading idea must be converted into explicit rules that can be implemented in code.

The strategy definition should identify, where applicable:

- Market / symbol
- Timeframe
- Indicators
- Indicator parameters
- Long entry conditions
- Short entry conditions
- Stop Loss
- Take Profit
- Position sizing
- Maximum simultaneous positions
- Spread restrictions
- Trading session restrictions
- Break-even logic
- Trailing-stop logic
- Exit conditions

Rules should be deterministic enough that the same conditions can be reproduced in MQL5.

---

## 4. EA Implementation

Each strategy receives a unique identifier.

Example:

```text
EA-038_EMA_Distance_Trend
```

The implementation is stored under:

```text
EAs/
└── EA-038_EMA_Distance_Trend/
    ├── EA-038_EMA_Distance_Trend.mq5
    └── README.md
```

The `.mq5` file is the executable strategy implementation.

The accompanying `README.md` documents:

- Strategy concept
- Entry logic
- Exit logic
- Parameters
- Risk / position management
- Operational behavior

The README should describe what the source code actually implements.

Backtest performance should not be presented as strategy logic.

---

## 5. Baseline Principle

The first test of an EA is treated as the **baseline**.

The purpose of the baseline is not to prove that the strategy is profitable.

Its purpose is to establish a measurable reference point before optimization or modification.

Baseline results must be preserved even when they fail.

A failed baseline is valid research evidence.

It should not be deleted or replaced simply because a later configuration performs better.

---

## 6. Backtesting

Backtests are performed using the MetaTrader 5 Strategy Tester.

Where available, testing should use:

```text
History Quality = 100% real ticks
```

Each test must record the configuration required to understand and reproduce the result.

At minimum:

```text
EA
Symbol
Timeframe
Test Period
Initial Deposit
Leverage
Lot Size
Stop Loss
Take Profit
EA Input Parameters
History Quality
```

The original Strategy Tester output should be preserved.

---

## 7. Backtest Evidence

Backtest evidence is stored separately from EA source code.

Example:

```text
Backtest/
└── EA-038_EMA_Distance_Trend/
    ├── README.md
    ├── Strategy Tester HTML report
    └── Strategy Tester charts
```

The raw MetaTrader report is the primary evidence.

The Backtest README provides a human-readable summary of the test configuration and results.

Important metrics include:

```text
Total Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Maximum Drawdown
Sharpe Ratio
Recovery Factor
Total Trades
Win Rate
Average Profit Trade
Average Loss Trade
Consecutive Wins
Consecutive Losses
Position Holding Time
```

Additional metrics such as MFE and MAE may be recorded when they are useful for research.

---

## 8. Research Evaluation

After the baseline test, the results are evaluated in the `Research` section.

The research layer should answer:

```text
What was tested?

What happened?

What evidence supports the conclusion?

Did the tested configuration PASS or FAIL?

What should be investigated next?
```

The research conclusion must be based on the test evidence rather than the expected behavior of the strategy.

---

## 9. PASS / FAIL Principle

An EA must not be marked PASS simply because:

- The strategy idea appears logical.
- The EA compiles successfully.
- Some trades are profitable.
- The balance curve contains profitable periods.
- A small subset of trades performs well.

A research result requires measurable evidence.

The general decision process is:

```text
Implementation complete
        ↓
Backtest complete
        ↓
Evidence preserved
        ↓
Metrics reviewed
        ↓
Research conclusion
        ↓
PASS / FAIL
```

PASS means the tested configuration has met the research acceptance criteria defined for that stage.

FAIL means the tested configuration has not met those criteria.

A FAIL result applies to the tested configuration and test conditions.

It does not automatically prove that every possible variation of the underlying strategy concept is invalid.

---

## 10. Failed Strategies

Failed strategies must remain in the repository.

They provide useful evidence about:

- Ineffective trading hypotheses
- Weak parameter configurations
- Excessive drawdown
- Poor expectancy
- Market conditions where a strategy fails
- Potential areas for future research

Example:

```text
EA-038_EMA_Distance_Trend

Baseline:
XAUUSD.PRO
M1
2026-01-02 → 2026-03-31

Result:
FAIL
```

The EA-038 baseline produced:

```text
Net Profit      = -$991.90
Profit Factor   = 0.94
Win Rate        = 32.43%
Max Drawdown    = 99.27%
Total Trades    = 7,198
```

This baseline is preserved as research evidence rather than removed from the project.

---

## 11. Strategy Modification

If a baseline fails but the hypothesis remains worth investigating, modifications may be tested.

Possible research variables include:

```text
Timeframe
EMA periods
ATR periods
ATR threshold
Entry filters
Trading sessions
Stop Loss
Take Profit
Break Even
Trailing Stop
Exit logic
```

Changes should be controlled where practical.

Instead of modifying many variables simultaneously, individual changes should be tested separately when possible.

This makes it easier to determine which modification caused a performance difference.

---

## 12. Optimization

Optimization should occur only after a working baseline has been established.

The sequence is:

```text
Baseline
    ↓
Identify weakness
    ↓
Define hypothesis for improvement
    ↓
Modify parameter or rule
    ↓
Backtest
    ↓
Compare with baseline
```

Optimization results must not overwrite the baseline.

The baseline remains the reference point.

---

## 13. Avoiding Overfitting

A better historical result does not automatically mean a better strategy.

Repeated parameter optimization can produce configurations that fit historical data without providing a robust trading edge.

For this reason:

- Do not select parameters solely because they maximize historical profit.
- Preserve failed tests where they provide useful evidence.
- Separate strategy development from final validation.
- Test modified strategies on data not used to select the parameters when the research reaches that stage.
- Prefer stable performance across reasonable parameter ranges over a single exceptional parameter combination.

---

## 14. Risk Evaluation

Profitability alone is not sufficient.

Risk must also be evaluated.

Important risk measures include:

```text
Maximum Drawdown
Consecutive Losses
Largest Loss
Recovery Factor
Sharpe Ratio
Position Exposure
```

A strategy producing positive net profit with unacceptable drawdown should not automatically be considered deployable.

Research PASS and approval for live deployment are separate decisions.

---

## 15. Live Deployment

Backtest success does not automatically authorize live trading.

The progression should be:

```text
Research
    ↓
Backtest
    ↓
Validation
    ↓
Forward / Demo Testing
    ↓
Risk Review
    ↓
Live Deployment Decision
```

A strategy must not be described as production-ready solely because it passed a historical backtest.

---

## 16. Repository Structure

The project follows this structure:

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-<>/
│       ├── EA-<>.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-<>/
│       ├── README.md
│       └── Backtest Evidence
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

The responsibilities are separated as follows:

```text
EAs/
→ Strategy implementation and EA documentation

Backtest/
→ Raw test evidence and test-specific results

Research/
→ Analysis, findings and research conclusions

docs/
→ Project-wide methodology

GitHub_Profile/
→ Public project / researcher presentation
```

---

## 17. Evidence Principle

Every research conclusion should be traceable back to evidence.

The expected chain is:

```text
Research Conclusion
        ↓
Backtest README
        ↓
Original MT5 Strategy Tester Report
        ↓
EA Source Code
```

This allows another researcher to understand:

- What strategy was implemented.
- What parameters were used.
- What data was tested.
- What result was produced.
- Why the research conclusion was reached.

---

## 18. Reproducibility

A backtest should contain enough information for another researcher to reproduce the experiment as closely as practical.

Therefore, preserve:

```text
EA source version
EA input parameters
Symbol
Timeframe
Testing period
Testing model / history quality
Account assumptions
Original Strategy Tester report
Relevant charts
Research conclusion
```

Do not rely only on screenshots when the original Strategy Tester report is available.

---

## 19. Research Integrity

The repository should preserve both successful and unsuccessful experiments.

Results must not be selectively removed because they contradict the original hypothesis.

The purpose of the repository is not to demonstrate that every EA is profitable.

The purpose is to document a reproducible process for researching systematic XAUUSD trading strategies.

The core principle is:

```text
Hypothesis
    ↓
Implementation
    ↓
Test
    ↓
Evidence
    ↓
Decision
```

Evidence determines the research conclusion.

---

## 20. Current Reference Case

EA-038 serves as an example of the methodology.

```text
Strategy:
EMA Distance Trend

Implementation:
EA-038_EMA_Distance_Trend.mq5

Baseline:
XAUUSD.PRO / M1
2026-01-02 → 2026-03-31
100% real ticks

Result:
FAIL

Evidence:
Backtest/EA-038_EMA_Distance_Trend/

Research conclusion:
Research/README.md
```

The failed baseline remains part of the repository because it provides reproducible evidence about the tested strategy configuration.
