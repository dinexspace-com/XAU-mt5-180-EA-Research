# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the research methodology used for Expert Advisors in the:

`xauusd-mt5-ea-research`

repository.

The objective is not to find a single profitable backtest.

The objective is to determine whether an EA shows sufficient evidence of a repeatable trading edge to justify further testing.

The research process follows:

Strategy Definition  
→ Implementation  
→ Baseline Backtest  
→ Baseline Analysis  
→ Parameter Research  
→ Extended Backtest  
→ Out-of-Sample Validation  
→ Robustness Testing  
→ Final Research Conclusion

A profitable baseline does not mean that a strategy is validated.

---

## 2. Research Principles

Every EA begins from a clearly defined trading hypothesis.

The research process should answer three separate questions:

1. Does the EA execute the intended strategy correctly?
2. Does the strategy show positive historical evidence?
3. Does that evidence remain stable when the testing conditions change?

These questions must be answered sequentially.

Optimization should not be used to hide a weak baseline implementation.

---

## 3. EA Identification

Each strategy receives a unique EA identifier.

Example:

`EA-050_50-Bar_Donchian`

Repository structure:

```text
EAs/
└── EA-050_50-Bar_Donchian/
    ├── EA-050_50-Bar_Donchian.mq5
    └── README.md
```

The source code and strategy description must be preserved so that backtest results can be traced to the implementation that produced them.

---

## 4. Strategy Definition

Before optimization, the strategy must have explicit rules for:

- Entry
- Exit
- Stop Loss
- Take Profit
- Position sizing
- Trade filters
- Break Even
- Trailing Stop
- Position management

The baseline strategy must be understandable without relying on optimized parameters.

For EA-050, the initial hypothesis is a Donchian breakout based on the previous 50 bars.

---

## 5. Baseline Backtest

Every EA must first pass a baseline backtest before parameter optimization.

The baseline test exists to establish a reference result.

It is NOT intended to find the best parameters.

The baseline must record at minimum:

- EA version
- Symbol
- Timeframe
- Test period
- Initial deposit
- Leverage
- Lot size
- Input parameters
- Tick/data quality
- Number of trades
- Net Profit
- Profit Factor
- Expected Payoff
- Drawdown
- Win/Loss statistics

The original MT5 Strategy Tester report should be preserved.

---

## 6. Baseline PASS / FAIL

A baseline can receive:

`EXECUTION PASS`

when the EA:

- runs without critical errors;
- generates trades according to its implemented rules;
- applies its position-management logic;
- completes the Strategy Tester run;
- produces a usable MT5 report.

Execution PASS does NOT mean:

`STRATEGY VALIDATED`

A strategy requires additional evidence before receiving a final research conclusion.

---

## 7. Baseline Analysis

After the baseline test, the following should be reviewed:

### Profitability

- Total Net Profit
- Gross Profit
- Gross Loss
- Profit Factor
- Expected Payoff

### Risk

- Balance Drawdown
- Equity Drawdown
- Largest Loss
- Consecutive Losses

### Trade Distribution

- Total Trades
- Winning Trades
- Losing Trades
- BUY performance
- SELL performance

### Trade Behaviour

- Average holding time
- Maximum holding time
- Minimum holding time
- MFE
- MAE

The purpose is to identify research questions.

The purpose is NOT to immediately modify the strategy based on every observed pattern.

---

## 8. Sample Size

Small samples must be treated cautiously.

For example:

`20 trades`

can be sufficient to confirm that an EA executes and to identify questions worth investigating.

It is not sufficient by itself to establish a persistent trading edge.

When the number of trades is small, metrics such as:

- Profit Factor
- Win Rate
- Drawdown
- Expected Payoff

can change materially because of only a few trades.

Therefore, extended historical testing is required before final conclusions.

---

## 9. Parameter Research

Parameter research begins only after the baseline has been recorded.

The purpose is NOT:

`Find the single most profitable combination.`

The purpose is:

`Identify parameter regions where the strategy remains reasonably stable.`

For EA-050, the initial research variables include:

- Donchian Period
- Stop Loss
- Take Profit
- Break Even Trigger
- Trailing Start

Parameters may interact.

Therefore, testing multiple parameters together can be appropriate when the objective is to study their combined behaviour.

---

## 10. Optimization Evaluation

Optimization results must not be ranked using Net Profit alone.

Important metrics include:

- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Drawdown
- Recovery Factor
- Number of Trades

A configuration with very high profit but very few trades must be treated cautiously.

Likewise, the single highest-performing optimization pass should not automatically become the selected configuration.

---

## 11. Parameter Stability

A stronger candidate should have acceptable neighbouring parameter combinations.

Conceptually:

```text
Weak candidate:

FAIL
FAIL
VERY HIGH PROFIT
FAIL
FAIL
```

may indicate parameter sensitivity or overfitting.

A more interesting region is:

```text
PASS
PASS
PASS
PASS
PASS
```

even if the central configuration is not the highest-profit result.

The research should therefore look for parameter stability rather than only a single optimum.

---

## 12. Extended Historical Testing

After parameter research, promising configurations must be tested over a longer historical period.

The objective is to increase exposure to:

- more trades;
- different volatility regimes;
- trending markets;
- ranging markets;
- bullish periods;
- bearish periods;
- different spread conditions.

The extended test must be stored separately from the original baseline.

The baseline result must not be overwritten.

---

## 13. In-Sample and Out-of-Sample

Research data should eventually be separated into:

`IN-SAMPLE`

and:

`OUT-OF-SAMPLE`

The In-Sample period can be used for parameter research.

The Out-of-Sample period is used to test whether the selected configuration continues to work on unseen historical data.

The Out-of-Sample period must not be repeatedly used to tune the parameters.

Otherwise it effectively becomes part of the optimization data.

---

## 14. Robustness Testing

A promising EA must survive more than one historical backtest.

Robustness testing should investigate several dimensions.

### Parameter Robustness

Change important parameters around the selected configuration.

Small parameter changes should not immediately destroy the strategy.

### Time Robustness

Test different historical periods.

The result should not depend entirely on one short market regime.

### Spread Sensitivity

Test less favorable spread assumptions where appropriate.

This is particularly important for strategies with short holding periods.

### Execution Sensitivity

Determine whether modest execution deterioration materially changes the result.

### Direction Robustness

When relevant, compare:

```text
BUY + SELL
BUY only
SELL only
```

Directional filters should be supported by repeated evidence rather than one small sample.

---

## 15. XAUUSD Considerations

The primary research instrument for this repository is:

`XAUUSD`

Broker symbols may differ, for example:

`XAUUSD.PRO`

Research results are therefore tied to the tested environment.

Contract specification, spread, execution and broker conditions may differ.

A result from one broker environment must not automatically be assumed to reproduce identically elsewhere.

---

## 16. Execution-Sensitive Strategies

Strategies with short average holding times require additional attention.

If trades commonly last only seconds or minutes, results may be more sensitive to:

- spread;
- slippage;
- tick sequence;
- execution;
- broker conditions.

Such strategies should receive stronger execution-sensitivity testing before production use is considered.

---

## 17. Evidence Storage

Each EA should maintain its research evidence separately.

Example:

```text
Backtest/
└── EA-050_50-Bar_Donchian/
    ├── README.md
    ├── Strategy Tester report
    └── Strategy Tester images
```

The original test artifacts should be retained whenever possible.

README files summarize the evidence.

They do not replace the original MT5 reports.

---

## 18. Research Status

Each EA can move through the following stages:

```text
IMPLEMENTED
↓
BASELINE TESTED
↓
PARAMETER RESEARCH
↓
EXTENDED TESTED
↓
OUT-OF-SAMPLE TESTED
↓
ROBUSTNESS TESTED
↓
FINAL REVIEW
```

A stage should only be marked complete when the corresponding evidence exists.

---

## 19. Research Verdicts

The following terminology is used.

### EXECUTION PASS

The EA implementation runs and produces a valid test.

This says nothing about long-term profitability.

### BASELINE PASS

The initial result provides sufficient evidence to justify continued research.

This is not final validation.

### RESEARCH CONTINUE

The evidence is incomplete but sufficiently interesting to justify additional testing.

### RESEARCH FAIL

The available evidence does not justify continued development under the tested hypothesis or configuration.

A failed result should be preserved rather than deleted.

Negative results are part of the research record.

### STRATEGY VALIDATED

This status should only be considered after the strategy has passed the required extended, out-of-sample and robustness tests.

Validation does not guarantee future profitability.

---

## 20. Anti-Overfitting Rules

The following practices should be avoided:

- selecting parameters only because they produced the highest historical profit;
- repeatedly optimizing against the same data;
- changing strategy rules after every losing result;
- removing SELL or BUY solely because of a very small sample;
- judging configurations only by Net Profit;
- ignoring low trade counts;
- deleting unsuccessful backtests;
- using Out-of-Sample data repeatedly for tuning.

The research process should prefer simple explanations and stable parameter regions.

---

## 21. Reproducibility

A research result should contain enough information to reproduce the test.

At minimum:

```text
EA
EA version
Symbol
Timeframe
Date range
Input parameters
Initial deposit
Leverage
Testing mode / data quality
MT5 report
```

When the EA source changes materially, previous results must not silently be presented as results of the new implementation.

---

## 22. Current EA-050 Application

The methodology is currently being applied to:

`EA-050_50-Bar_Donchian`

Current status:

```text
Implementation           COMPLETE
Baseline Backtest        COMPLETE
Baseline Analysis        COMPLETE
Parameter Research       NEXT
Extended Backtest        PENDING
Out-of-Sample            PENDING
Robustness               PENDING
Final Conclusion         PENDING
```

The baseline contains only 20 trades.

Therefore EA-050 currently has research evidence sufficient to continue testing, but not sufficient for final strategy validation.

---

## 23. Research Rule

The central rule of this repository is:

> A profitable backtest is evidence to investigate, not proof of a trading edge.

The research process should advance only when the previous stage has produced reproducible evidence.
