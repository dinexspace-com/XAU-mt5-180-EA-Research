# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard research and validation methodology used in the `xauusd-mt5-ea-research` repository.

The objective is to evaluate MetaTrader 5 Expert Advisors for XAUUSD using a reproducible process based on:

```text
Strategy Definition
        ↓
Source Implementation
        ↓
Baseline Backtest
        ↓
Failure Analysis
        ↓
Optimization
        ↓
Candidate Selection
        ↓
Out-of-Sample Validation
        ↓
Robustness Testing
        ↓
Final Research Decision
```

The repository is intended for research.

A profitable backtest alone is not sufficient evidence that an EA is suitable for live deployment.

---

# 1. Core Research Principle

Every EA must begin with a fixed baseline.

The baseline consists of:

```text
Original strategy logic
+
Original source code
+
Original parameters
+
Defined market
+
Defined timeframe
+
Defined backtest period
+
Original Strategy Tester report
```

Once the baseline is recorded, it must not be overwritten.

Future versions, optimizations, or parameter sets must be stored separately.

This allows every improvement to be measured against the original EA.

---

# 2. Repository Structure

The standard repository structure is:

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

Each directory has a separate responsibility.

---

# 3. `EAs/`

The `EAs/` directory contains the actual Expert Advisor source code.

Example:

```text
EAs/
└── EA-065_Retest_Breakout/
    ├── EA-065_Retest_Breakout.mq5
    └── README.md
```

The EA README should describe only what can be verified from the implementation.

It should include:

```text
EA ID
Strategy name
Platform
Language
Target market
Timeframe
Entry logic
Exit logic
Risk controls
Trade management
Default parameters
Execution restrictions
```

Do not include unsupported profitability claims in the EA source README.

Performance evidence belongs in `Backtest/`.

---

# 4. `Backtest/`

The `Backtest/` directory stores evidence produced by MetaTrader 5 Strategy Tester.

Example:

```text
Backtest/
└── EA-065_Retest_Breakout/
    ├── README.md
    ├── Strategy Tester HTML report
    └── Associated report images
```

The original Strategy Tester HTML report should be retained whenever possible.

It is the primary numerical evidence.

Associated graphs may include:

```text
Balance / Equity curve
Trade distribution
MFE / MAE
Holding time
Optimization graphs
```

The backtest README summarizes the evidence but must not replace the original report.

---

# 5. `Research/`

The `Research/` directory contains research interpretation.

It answers questions such as:

```text
Why did the baseline pass or fail?

Which parameters influence performance?

What weaknesses appear in the strategy?

What should be tested next?

Which optimization results are candidates?

Has the strategy survived out-of-sample testing?
```

Research conclusions must always remain traceable to evidence.

---

# 6. Baseline Test

Every EA begins with one baseline test.

The baseline should use the original EA configuration before optimization.

At minimum, record:

```text
EA
Symbol
Timeframe
Test period
Initial deposit
Leverage
Lot size
Model / tick quality
Broker environment
Input parameters
```

Core output metrics should include:

```text
Net Profit
Gross Profit
Gross Loss
Profit Factor
Expected Payoff
Maximum Drawdown
Sharpe Ratio
Recovery Factor
Total Trades
Winning Trades
Losing Trades
Win Rate
Average Winning Trade
Average Losing Trade
```

When available, also record:

```text
Long / Short performance
Consecutive wins
Consecutive losses
Holding time
MFE
MAE
Trade distribution
```

---

# 7. Backtest Data Quality

For XAUUSD research, real tick data should be preferred whenever available.

A backtest should record the reported data quality.

Example:

```text
History Quality = 100% real ticks
```

Results obtained from different data quality levels should not be treated as directly equivalent without noting the difference.

---

# 8. Baseline PASS / FAIL

The baseline is evaluated before optimization.

A baseline should be marked `FAIL` when fundamental performance metrics demonstrate that the configuration is not viable.

Typical failure conditions include:

```text
Net Profit <= 0

Profit Factor <= 1

Expected Payoff <= 0

Excessive Drawdown

Persistent declining balance curve
```

A positive result does not automatically mean the EA has passed final research validation.

Baseline PASS means only:

```text
The original configuration is sufficiently interesting to continue validation.
```

It does not mean:

```text
Approved for live trading.
```

---

# 9. Failure Analysis

If the baseline fails, determine why before modifying the EA.

Possible causes include:

```text
Poor entry quality
False breakouts
Late entries
Weak confirmation
Excessive stop distance
Insufficient take profit
Premature break-even
Overly aggressive trailing
Spread sensitivity
Session dependency
Regime dependency
Insufficient edge
```

Do not modify multiple unrelated parts of the strategy without first identifying the likely source of failure.

---

# 10. Parameter Optimization

Optimization is used to search for parameter regions worth further validation.

It must not be used merely to find the highest historical profit.

Parameters should be divided into logical groups.

Example:

```text
ENTRY
- Lookback
- Breakout threshold
- Retest tolerance
- Confirmation conditions

EXIT
- Stop Loss
- Take Profit

TRADE MANAGEMENT
- Break-even trigger
- Break-even offset
- Trailing start
- Trailing distance
- Trailing step

EXECUTION
- Spread filter
- Slippage
- Trading session
```

Optimize the smallest meaningful parameter group first.

Avoid optimizing every available parameter simultaneously unless there is a clear research reason.

---

# 11. Optimization Objective

Do not rank optimization passes using only:

```text
Net Profit
```

Candidate configurations should be compared using a combination of:

```text
Net Profit
Profit Factor
Expected Payoff
Drawdown
Recovery Factor
Trade Count
Balance Curve
Parameter Stability
```

The goal is to identify a robust region.

The goal is not to identify one isolated maximum.

---

# 12. Optimization Surface

A good candidate should ideally have nearby configurations with similar behavior.

Example:

```text
Parameter A = 18 → profitable
Parameter A = 20 → profitable
Parameter A = 22 → profitable
```

is generally more interesting than:

```text
Parameter A = 19 → poor
Parameter A = 20 → extremely profitable
Parameter A = 21 → poor
```

An isolated peak may indicate overfitting.

Optimization results should therefore be inspected as a surface rather than only as a leaderboard.

---

# 13. Candidate Selection

After optimization, select only a small number of configurations for further testing.

Each candidate should record:

```text
Candidate ID
Parameter set
Net Profit
Profit Factor
Maximum Drawdown
Expected Payoff
Trade Count
Win Rate
```

Example:

```text
Candidate A
Candidate B
Candidate C
```

Candidates must remain unchanged during their subsequent validation tests.

---

# 14. In-Sample and Out-of-Sample Testing

Optimization data and validation data should be separated.

Example:

```text
In-Sample
2026-01 → 2026-03

Out-of-Sample
2026-04 → 2026-05
```

The exact dates may vary by experiment.

The important rule is:

```text
Parameters are selected using In-Sample data.

Those same parameters are then tested unchanged on Out-of-Sample data.
```

Do not optimize again after observing the out-of-sample result and continue calling the result out-of-sample.

Changing the parameters creates a new research iteration.

---

# 15. Month-by-Month Validation

Aggregated results can hide unstable behavior.

Candidate configurations should therefore be tested across individual periods where practical.

Example:

```text
January
February
March
April
...
```

Record for each period:

```text
Net Profit
Profit Factor
Drawdown
Trades
Win Rate
```

The objective is to determine whether performance is broadly distributed or dependent on one exceptional period.

---

# 16. Market Regime Robustness

XAUUSD behavior changes over time.

Candidate strategies may respond differently to:

```text
Trending markets
Range markets
High volatility
Low volatility
News-driven movement
Fast directional expansion
Choppy price action
```

A strategy should not automatically be rejected because all regimes are not equally profitable.

However, strong dependence on one specific regime must be documented.

---

# 17. Trade Count

A backtest with too few trades may produce misleading statistics.

Trade count must therefore be reviewed together with:

```text
Test duration
Timeframe
Strategy frequency
Profit Factor
Drawdown
```

There is no universal minimum trade count that guarantees statistical validity.

The trade sample should be sufficiently large to support meaningful comparison between configurations.

---

# 18. Win Rate

Win rate alone is not a measure of profitability.

The relationship between:

```text
Win Rate
Average Winner
Average Loser
```

must always be considered.

Example:

```text
Win Rate = 60%
```

can still lose money if:

```text
Average Loss >> Average Win
```

Likewise, a system with a win rate below 50% can still be profitable when its average winner is sufficiently larger than its average loser.

---

# 19. Risk / Reward

Nominal SL / TP is not necessarily equal to realized risk / reward.

For example:

```text
SL = 300
TP = 600
```

suggests:

```text
Nominal R:R = 1:2
```

but actual results may be affected by:

```text
Break Even
Trailing Stop
Manual exit logic
Market gaps
Spread
Execution
```

Research should therefore use actual statistics:

```text
Average Profit Trade
Average Loss Trade
```

rather than relying only on configured SL / TP.

---

# 20. Drawdown

Drawdown is a primary risk metric.

Always record both:

```text
Balance Drawdown
Equity Drawdown
```

when available.

A strategy with strong profitability but extreme drawdown should not automatically be considered acceptable.

Drawdown should be evaluated relative to:

```text
Initial capital
Net profit
Trade frequency
Strategy type
Intended risk tolerance
```

---

# 21. Profit Factor

Profit Factor is:

```text
Gross Profit / Gross Loss
```

Interpretation:

```text
PF < 1
Loss-making system

PF = 1
Approximately break-even before additional execution effects

PF > 1
Gross profit exceeds gross loss
```

Profit Factor should never be evaluated alone.

It must be considered together with:

```text
Trade Count
Drawdown
Expected Payoff
Test Duration
Out-of-Sample Results
```

---

# 22. Expected Payoff

Expected Payoff represents average expected result per trade in the Strategy Tester report.

A negative Expected Payoff indicates that the tested configuration produced negative average expectancy.

For research candidates:

```text
Expected Payoff > 0
```

is normally required before further validation.

---

# 23. Balance Curve

The balance curve should always be inspected visually.

Look for:

```text
Stable growth
Long stagnation
Sudden profit spikes
Long decline
Single exceptional period
Repeated recovery failures
Large step changes
```

A positive final balance can still hide an unstable strategy.

---

# 24. MFE and MAE

Where available, analyze:

```text
MFE = Maximum Favorable Excursion

MAE = Maximum Adverse Excursion
```

These help identify whether:

```text
Winning trades leave significant profit unrealized

Stop Loss is too wide

Break Even activates too early

Trailing Stop is too tight

Take Profit is unrealistic
```

MFE / MAE analysis should support research decisions but should not replace independent testing.

---

# 25. Holding Time

Record:

```text
Minimum Holding Time
Average Holding Time
Maximum Holding Time
```

Holding time can reveal whether the EA behaves as:

```text
Scalping
Short-term intraday
Intraday
Swing
```

For very short holding periods, execution quality becomes increasingly important.

---

# 26. Spread and Execution

XAUUSD execution differs between brokers.

Research should record relevant execution assumptions whenever possible:

```text
Broker
Symbol
Digits
Spread filter
Slippage
Stop Level
Leverage
Commission
Swap
```

A result generated on:

```text
XAUUSD.PRO
```

should not automatically be assumed identical to:

```text
XAUUSD
GOLD
XAUUSDm
XAUUSD.a
```

Symbol specifications may differ.

---

# 27. Fixed Lot During Comparison

When comparing strategy parameters, keep lot size fixed whenever possible.

Example:

```text
Lot Size = 0.01
```

This prevents position sizing changes from obscuring whether the strategy logic itself improved.

Dynamic risk sizing should be evaluated separately after a viable strategy configuration has been identified.

---

# 28. Strategy Logic vs Money Management

Research should distinguish:

```text
Strategy Edge
```

from:

```text
Money Management
```

A poor strategy should not be made to appear successful merely by altering position sizing.

The preferred sequence is:

```text
Find positive strategy expectancy
        ↓
Validate robustness
        ↓
Then evaluate position sizing
```

---

# 29. Source Code Changes

If strategy logic is modified, create a new identifiable version.

Do not silently replace the original source.

Example:

```text
EA-065_Retest_Breakout
EA-065A_Retest_Breakout_Filter
EA-065B_Retest_Breakout_Session
```

or use another consistent versioning convention.

The important requirement is traceability.

A backtest must always be attributable to the exact EA version that generated it.

---

# 30. Reproducibility

A valid research result should be reproducible from:

```text
EA source code
+
Input parameters
+
Symbol
+
Timeframe
+
Test period
+
MT5 test settings
+
Data quality
```

If any of these are unknown, the limitation should be documented.

---

# 31. Evidence Policy

No research stage should be considered complete without evidence.

Accepted evidence may include:

```text
.mq5 source
.set parameter file
MT5 Strategy Tester HTML
Optimization XML
Optimization screenshot
Backtest graph
CSV export
Research notes
```

Statements such as:

```text
"EA is profitable"

"EA is optimized"

"EA is robust"
```

should not be recorded as validated conclusions without supporting evidence.

---

# 32. PASS / FAIL Policy

A task is not considered PASS simply because a file exists.

PASS requires:

```text
Artifact
+
Verification
+
Evidence
```

For final strategy validation, evidence should include multiple testing stages.

---

# 33. Research Stage Status

Use explicit statuses such as:

```text
PENDING
RUNNING
COMPLETE
PASS
FAIL
REVIEW REQUIRED
NOT APPROVED
```

Example:

```text
Baseline Backtest   = COMPLETE
Baseline Result     = FAIL
Optimization        = PENDING
Out-of-Sample       = PENDING
Final Validation    = NOT COMPLETE
Deployment          = NOT APPROVED
```

---

# 34. Suggested EA Research Lifecycle

Each EA should ideally follow:

```text
01 — Strategy defined

02 — Source code available

03 — Source reviewed

04 — Baseline parameters recorded

05 — Baseline backtest executed

06 — Baseline evidence stored

07 — Baseline analyzed

08 — Weakness identified

09 — Optimization plan defined

10 — Optimization executed

11 — Optimization surface reviewed

12 — Candidates selected

13 — Out-of-sample test executed

14 — Monthly stability checked

15 — Robustness reviewed

16 — Final research decision
```

---

# 35. Example — EA-065

Current implementation:

```text
EA-065_Retest_Breakout
```

Current repository state:

```text
Source Code           = AVAILABLE

Baseline Backtest     = COMPLETE

Baseline Result       = FAIL

Optimization          = PENDING

Out-of-Sample         = PENDING

Robustness Validation = PENDING

Deployment            = NOT APPROVED
```

Baseline evidence:

```text
Symbol                = XAUUSD.PRO
Timeframe             = M1
Period                = 2026-01-02 → 2026-03-31

Initial Deposit       = $100
Lot                   = 0.01

History Quality       = 100% real ticks

Total Trades          = 459

Net Profit            = -$94.61
Profit Factor         = 0.84
Expected Payoff       = -$0.21

Maximum Equity DD     = 95.36%
```

EA-065 therefore remains a research candidate.

The original baseline must remain preserved while optimization and validation continue.

---

# 36. Final Research Decision

The final research decision should be one of:

```text
REJECT

CONTINUE RESEARCH

VALIDATED FOR NEXT TEST STAGE
```

Live deployment is a separate decision from historical research validation.

A research PASS must not automatically be interpreted as authorization for live trading.

---

# 37. Methodology Summary

The repository follows this rule:

```text
Do not trust one result.

Preserve the baseline.

Change one research question at a time.

Keep original evidence.

Search for stable parameter regions.

Validate outside optimization data.

Check multiple periods.

Separate strategy edge from position sizing.

Document failures as well as successes.

Do not approve an EA without evidence.
```

The purpose of this methodology is not to produce the highest possible historical backtest result.

The purpose is to determine whether an EA demonstrates sufficiently repeatable and explainable behavior to justify further research.
