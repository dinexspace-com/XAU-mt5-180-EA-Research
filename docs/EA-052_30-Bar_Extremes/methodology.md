# XAUUSD MT5 EA Research Methodology

## Purpose

This document defines the standard research, development, backtesting, validation, and documentation methodology used in the **xauusd-mt5-ea-research** repository.

The objective of this repository is to convert trading ideas into deterministic MetaTrader 5 Expert Advisors, test them under documented conditions, preserve both positive and negative results, and evaluate whether a strategy demonstrates sufficient evidence for further research.

A strategy is never assumed to be profitable simply because its trading logic is reasonable.

Every strategy must pass through the same evidence-based process.

---

# 1. Research Workflow

The standard workflow is:

Trading Idea  
→ Strategy Definition  
→ Deterministic Trading Rules  
→ MQL5 Implementation  
→ Compile Validation  
→ Baseline Backtest  
→ Result Analysis  
→ PASS / FAIL  
→ Research Hypothesis  
→ Controlled Modification  
→ Retest  
→ Robustness Testing  
→ Out-of-Sample Validation  
→ Forward / Live Validation

Each stage should produce evidence before the strategy advances to the next stage.

---

# 2. Strategy Identification

Every Expert Advisor receives a unique research identifier.

Example:

EA-052_30-Bar_Extremes

Naming format:

EA-[ID]_[Strategy-Name]

The ID must remain stable throughout the research lifecycle.

Modified or optimized versions must not silently replace the original baseline implementation.

---

# 3. Strategy Definition

Before optimization, the strategy must be expressible as deterministic rules.

The strategy definition should describe:

- Market
- Timeframe assumptions
- Entry conditions
- Buy conditions
- Sell conditions
- Exit conditions
- Stop Loss
- Take Profit
- Position sizing
- Spread restrictions
- Trade-management rules
- Any indicator or price-action calculations

Subjective descriptions should be converted into measurable conditions before implementation.

For example:

Avoid:

"Buy when momentum looks strong."

Prefer:

"Buy when the current bar closes above the previous N-bar Highest High and the Close is within a defined percentage of the candle High."

The goal is reproducibility.

Two independent implementations using the same specification should produce materially equivalent trading logic.

---

# 4. Source Preservation

When a strategy originates from a book, paper, article, trading system, research note, or other source, that source should be documented.

Record where possible:

- Author
- Title
- Publication
- Chapter or section
- Original strategy description
- Relevant parameters
- Interpretation required for automation

Do not attribute a strategy to a specific source unless supporting evidence exists.

If the exact source is unknown, record:

Source: Unknown / Not yet documented

Do not invent attribution.

---

# 5. MQL5 Implementation

Strategies are implemented as MetaTrader 5 Expert Advisors.

Source files are stored under:

EAs/

Example:

EAs/
└── EA-052_30-Bar_Extremes/
    ├── EA-052_30-Bar_Extremes.mq5
    └── README.md

The README should document the actual implementation rather than the intended strategy if the two differ.

Any discrepancy between source theory and implementation should be explicitly recorded.

---

# 6. Compile Validation

Before backtesting, the EA should successfully compile in MetaEditor.

Target:

0 errors

0 warnings

Compilation success only confirms that the source is syntactically valid.

It does NOT demonstrate:

- Correct strategy logic
- Correct position sizing
- Correct order execution
- Profitability
- Robustness
- Production readiness

These require separate testing.

---

# 7. Baseline Principle

Every EA should first receive a baseline test.

The baseline is the first documented implementation tested without retrospective optimization against the test result.

The baseline provides a reference point for all future experiments.

Once recorded, the baseline should not be deleted or overwritten.

If the baseline loses money, the result remains part of the repository.

Negative results are research evidence.

---

# 8. Backtest Evidence

Backtests are stored under:

Backtest/

Example:

Backtest/
└── EA-052_30-Bar_Extremes/
    ├── README.md
    ├── Strategy Tester HTML report
    └── Strategy Tester charts

The original MetaTrader 5 Strategy Tester HTML report should be preserved whenever available.

Generated charts should also be retained.

The HTML report is treated as the primary backtest evidence.

---

# 9. Minimum Backtest Documentation

Each backtest should record at least:

- EA name
- Symbol
- Timeframe
- Test period
- Initial deposit
- Leverage
- Lot size or sizing method
- Stop Loss
- Take Profit
- Spread settings
- Trade-management parameters
- History quality
- Number of trades
- Net Profit
- Profit Factor
- Expected Payoff
- Drawdown
- Win rate

Additional statistics should be preserved when available.

---

# 10. Data Quality

Backtest data quality must be documented.

Where available, prefer:

100% real ticks

The repository must not silently treat tests using different data quality as equivalent.

Changes in:

- Broker
- Symbol specification
- Spread
- Commission
- Swap
- Tick history
- Execution assumptions

may materially change results.

Therefore, the test environment must be preserved with the result.

---

# 11. Baseline Evaluation

A backtest result must be evaluated quantitatively.

Important metrics include:

## Total Net Profit

Measures the final monetary result of the tested strategy.

Net Profit > 0 alone is not sufficient evidence of robustness.

---

## Profit Factor

Profit Factor = Gross Profit / Gross Loss

Interpretation:

PF > 1.0 indicates gross profits exceeded gross losses during the tested sample.

PF < 1.0 indicates a losing test.

Profit Factor should not be evaluated independently from trade count, drawdown, and stability.

---

## Expected Payoff

Expected Payoff estimates the average result per trade.

Positive expectancy is preferred.

A negative value indicates that the tested configuration lost money per trade on average.

---

## Drawdown

Both Balance Drawdown and Equity Drawdown should be reviewed.

High profitability accompanied by extreme drawdown may not represent an acceptable strategy.

Drawdown must therefore be considered together with return.

---

## Recovery Factor

Recovery Factor evaluates the relationship between profit and drawdown.

Negative recovery values indicate a losing test.

---

## Sharpe Ratio

Sharpe Ratio provides information about risk-adjusted performance.

It should not be used as the only criterion for strategy selection.

---

## Trade Count

A small number of trades may provide insufficient evidence.

Results based on larger trade samples generally provide more information about the behavior of the strategy.

However, a large trade count does not automatically make a strategy profitable or robust.

---

## Win Rate

Win rate must be interpreted together with:

- Average profit
- Average loss
- Risk/reward
- Profit Factor
- Expected Payoff

A high win rate does not guarantee profitability.

A low win rate does not automatically imply failure if winning trades are sufficiently larger than losing trades.

---

# 12. PASS / FAIL Classification

Every baseline should receive a clear research classification.

Possible states:

PASS

FAIL

INCONCLUSIVE

PASS means the baseline provides sufficient evidence to justify additional validation.

PASS does NOT mean production-ready.

FAIL means the tested configuration did not demonstrate an acceptable edge.

INCONCLUSIVE means the available test is insufficient to make a useful determination.

A failed strategy may remain valuable for research.

---

# 13. Negative Results

Negative results must not be deleted merely because the strategy lost money.

A failed experiment can demonstrate:

- A trading hypothesis did not work
- A parameter set was ineffective
- A timeframe was unsuitable
- A market condition caused weakness
- A filter failed to improve expectancy

Preserving failures prevents repeated research into previously rejected configurations.

---

# 14. Optimization Rules

Optimization should occur only after a baseline has been preserved.

The baseline must remain unchanged.

Optimization should be treated as a new experiment.

Avoid changing many unrelated components simultaneously.

Preferred process:

Baseline  
→ identify weakness  
→ define hypothesis  
→ modify one logical component  
→ backtest  
→ compare  
→ record result

This allows researchers to identify which change actually affected performance.

---

# 15. Parameter Optimization

Parameter optimization may include variables such as:

- Lookback period
- Stop Loss
- Take Profit
- Break Even trigger
- Trailing Stop
- Volatility threshold
- Session filter
- Trend filter
- Entry confirmation

Optimization results must not automatically be considered validation.

Searching many parameter combinations increases the probability of finding configurations that perform well by chance.

Therefore, optimized parameters require independent testing.

---

# 16. Avoiding Overfitting

Overfitting occurs when a strategy becomes excessively adapted to historical data.

Warning signs include:

- Extremely specific parameters
- Large performance changes from small parameter changes
- Excellent in-sample results but poor validation results
- Strategy logic becoming increasingly complex after every losing test
- Too many filters
- Optimization across very large parameter spaces
- Selecting only the best historical configuration

A robust strategy should preferably perform reasonably across a region of parameter values rather than at one isolated optimum.

---

# 17. In-Sample and Out-of-Sample Testing

When optimization begins, historical data should eventually be separated into:

In-Sample data

and

Out-of-Sample data

In-Sample data may be used for research and optimization.

Out-of-Sample data should be reserved for independent validation.

Parameters should not be repeatedly adjusted after observing out-of-sample results.

Doing so effectively converts the out-of-sample period into additional training data.

---

# 18. Robustness Testing

A profitable baseline or optimized configuration is not sufficient for deployment.

Potential robustness tests include:

- Different historical periods
- Different market regimes
- Different timeframes
- Different spread assumptions
- Different parameter values
- Different brokers or symbol specifications
- Out-of-sample testing
- Forward testing

The exact robustness process may vary by strategy.

Every completed robustness test should be documented.

---

# 19. Market Regime Testing

XAUUSD behavior can change significantly across different environments.

Research should eventually consider periods characterized by:

- High volatility
- Low volatility
- Strong trends
- Range-bound markets
- Major macroeconomic events
- Different trading sessions

A strategy that performs well only during one narrow regime should not automatically be treated as universally robust.

---

# 20. Transaction Costs

Backtests should account for realistic trading conditions whenever possible.

Relevant costs include:

- Spread
- Commission
- Swap
- Slippage

High-frequency strategies and M1 strategies can be particularly sensitive to execution costs.

A strategy whose edge disappears after realistic transaction costs should not be considered robust.

---

# 21. Forward Testing

Strategies that survive historical validation should proceed to forward testing before live deployment.

Forward testing may include:

- Demo account
- Controlled real-time environment
- Small-risk live account

Forward results should be compared against expected backtest behavior.

Important differences include:

- Trade frequency
- Slippage
- Spread
- Execution
- Drawdown
- Win rate
- Average trade
- Profit Factor

---

# 22. Live Validation

Live deployment is a separate research stage.

Backtest profitability does not guarantee live profitability.

Before production use, the strategy should have sufficient evidence from:

Baseline testing

→ optimization research

→ robustness testing

→ out-of-sample validation

→ forward testing

→ controlled live validation

The amount of evidence required may vary according to the strategy and intended risk.

---

# 23. Research Versioning

Every material strategy modification should be traceable.

Do not overwrite historical evidence.

Examples of material changes:

- Entry logic changed
- Exit logic changed
- Lookback changed
- New filter added
- Position sizing changed
- Stop Loss logic changed
- Take Profit logic changed
- Break Even changed
- Trailing logic changed

The repository should make it possible to determine which EA version produced each backtest.

---

# 24. Reproducibility

A researcher should be able to identify:

1. Which EA source was tested
2. Which parameters were used
3. Which symbol was tested
4. Which timeframe was tested
5. Which historical period was used
6. Which trading environment was used
7. What the resulting statistics were
8. Where the original report is stored

If these cannot be determined, the experiment is not fully reproducible.

---

# 25. Repository Structure

Standard structure:

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

---

# 26. Documentation Responsibilities

## EAs/EA-<>/README.md

Documents what the EA actually does.

It should include:

- Strategy overview
- Entry logic
- Exit logic
- Parameters
- Trade management
- Platform requirements
- Implementation notes

---

## Backtest/EA-<>/README.md

Documents a specific test and its evidence.

It should include:

- Test environment
- Parameters
- Results
- Trade statistics
- PASS / FAIL assessment
- Backtest files
- Reproducibility information

---

## Research/README.md

Documents the research reasoning.

It may include:

- Strategy hypothesis
- Strategy family
- Research questions
- Baseline findings
- Experiment history
- Research conclusions
- Current research status

---

## docs/methodology.md

Defines the common methodology used across the repository.

It should not be rewritten to make individual EA results appear more favorable.

---

# 27. Evidence Hierarchy

When documentation conflicts, prefer direct evidence.

Recommended hierarchy:

Original MT5 Strategy Tester Report  
→ EA source code  
→ Backtest README  
→ Research documentation  
→ Summary documentation

For example:

If a README states a Profit Factor of 1.50 but the original Strategy Tester report states 0.85, the Strategy Tester report is treated as the authoritative evidence.

If the intended strategy description differs from the actual EA implementation, the source code determines what was actually implemented.

The discrepancy should then be documented.

---

# 28. Research Integrity

The repository follows these principles:

**No fabricated results**

Do not invent missing backtest metrics.

**No hidden failures**

Negative experiments remain part of the research history.

**No unsupported profitability claims**

A profitable backtest is evidence from one historical experiment, not proof of future profitability.

**No silent parameter changes**

Material parameter changes must be documented.

**No silent strategy changes**

Modified logic must be traceable.

**No cherry-picking**

Results should not be selected solely because they are favorable.

**Preserve primary evidence**

Original reports should be retained whenever possible.

---

# 29. Current Example — EA-052

EA-052_30-Bar_Extremes is the first documented example under this methodology.

Baseline environment:

Symbol: XAUUSD.PRO  
Timeframe: M1  
Period: 2026.01.02 – 2026.03.31  
Initial Deposit: $1,000  
History Quality: 100% real ticks  
Total Trades: 1,511

Baseline result:

Net Profit: -$369.82  
Profit Factor: 0.85  
Expected Payoff: -$0.24  
Maximum Equity Drawdown: 37.93%  
Winning Trades: 40.44%  
Sharpe Ratio: -5.00

Classification:

**FAIL**

The EA remains in the repository because the failed baseline is valid research evidence.

Future versions or modifications should be evaluated against this preserved baseline rather than replacing it.

---

# 30. Final Principle

The objective of this repository is not to produce attractive backtests.

The objective is to determine whether a trading hypothesis survives systematic testing.

The research standard is therefore:

**Idea → Rules → Code → Evidence → Evaluation → Validation**

A strategy advances only when the available evidence justifies the next research stage.

Profitable results are preserved.

Unprofitable results are preserved.

Uncertain results are identified as uncertain.

The repository should remain reproducible, auditable, and evidence-driven throughout the entire XAUUSD EA research process.
