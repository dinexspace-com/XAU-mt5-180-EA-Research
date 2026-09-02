# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the standard research and testing methodology used in the **XAUUSD MT5 EA Research** repository.

The objective is to maintain a consistent and reproducible process for developing and evaluating Expert Advisors (EAs) designed primarily for XAUUSD.

The workflow is:

**Research → Strategy Rules → EA Implementation → Backtest → Evaluation → Further Research**

An EA is not considered successful simply because it compiles, runs, or produces profitable results in a single backtest.

---

## 2. Research Scope

**Primary market:** XAUUSD  
**Primary platform:** MetaTrader 5  
**Implementation language:** MQL5

Each EA represents a specific trading hypothesis that can be converted into explicit trading rules and tested objectively.

Examples include:

- Trend following
- Momentum
- Volatility filters
- Mean reversion
- Breakout systems
- Session filters
- Indicator combinations
- Risk and trade-management techniques

---

## 3. EA Identification

Each research strategy receives a unique identifier.

Format:

`EA-XXX_Strategy_Name`

Example:

`EA-037_ATR_Trend_Filter`

The identifier should remain consistent across:

- Source code
- EA README
- Backtest folder
- Research documentation

---

## 4. Research Hypothesis

Before evaluating an EA, the underlying hypothesis should be clearly defined.

A research hypothesis should explain:

1. What market behavior the strategy attempts to exploit.
2. Why the proposed signal or filter may provide useful information.
3. What conditions trigger an entry.
4. What conditions prevent an entry.
5. How positions are exited or managed.

The hypothesis must be convertible into deterministic trading rules.

---

## 5. Strategy Rules

Trading logic should be documented before conclusions are drawn from backtesting.

At minimum, define:

### Entry

- BUY conditions
- SELL conditions
- Required filters

### Exit

- Stop Loss
- Take Profit
- Strategy-specific exit conditions

### Filters

When applicable:

- Volatility
- Spread
- Trend
- Session
- Time
- Market condition

### Position Management

When applicable:

- Break Even
- Trailing Stop
- Maximum simultaneous positions
- Position sizing

Rules implemented in the EA should correspond to the strategy being researched.

---

## 6. EA Implementation

EA source code is stored under:

`EAs/EA-XXX_Strategy_Name/`

Minimum contents:

```text
EA-XXX_Strategy_Name/
├── EA-XXX_Strategy_Name.mq5
└── README.md
```

The EA README documents:

- Strategy purpose
- Trading logic
- Parameters
- Position management
- Implementation status

A successfully compiled EA is considered an implementation result, not evidence that the strategy is profitable.

---

## 7. Baseline Backtest

Each EA should first receive a baseline backtest.

The baseline establishes a reference result before further optimization or modification.

Backtests are stored under:

`Backtest/EA-XXX_Strategy_Name/`

The test configuration should record at least:

- EA version
- Symbol
- Timeframe
- Test period
- Initial deposit
- Leverage
- Lot size
- Strategy parameters
- Historical data quality
- Relevant execution settings

Whenever available, the original MetaTrader 5 Strategy Tester report should be preserved as evidence.

---

## 8. Core Evaluation Metrics

At minimum, review:

### Profitability

- Total Net Profit
- Gross Profit
- Gross Loss
- Profit Factor
- Expected Payoff

### Risk

- Balance Drawdown
- Equity Drawdown
- Maximum Drawdown
- Recovery Factor

### Trade Statistics

- Total Trades
- Winning Trades
- Losing Trades
- Win Rate
- Long/Short performance
- Average Profit Trade
- Average Loss Trade
- Consecutive Wins
- Consecutive Losses

### Risk-Adjusted Performance

When available:

- Sharpe Ratio

No single metric should be used as the sole basis for accepting a strategy.

---

## 9. Baseline Evaluation

The first backtest is treated as a baseline.

Possible research states include:

- `BASELINE COMPLETED`
- `FURTHER RESEARCH REQUIRED`
- `VALIDATION IN PROGRESS`
- `REJECTED`
- `VALIDATED`

A negative baseline does not automatically invalidate the underlying research hypothesis.

Likewise, a profitable baseline does not automatically validate the strategy.

The result determines what should be investigated next.

---

## 10. Further Research

After the baseline, relevant tests may include:

### Parameter Sensitivity

Determine whether performance depends excessively on a narrow parameter configuration.

### Component Comparison

Compare the strategy with and without individual filters or components.

Example:

`EMA crossover + ATR filter`

versus:

`EMA crossover without ATR filter`

This helps determine whether the added component actually contributes value.

### Timeframe Testing

Test whether the hypothesis behaves consistently across relevant XAUUSD timeframes.

### Longer Historical Period

A short backtest should be expanded before making stronger conclusions.

The objective is to expose the strategy to more market conditions.

### Out-of-Sample Testing

Parameters selected using one historical period should be tested on unseen data.

The unseen period must not be used to select the parameters being evaluated.

### Market Regime Testing

Where relevant, evaluate behavior during:

- Trending markets
- Ranging markets
- High volatility
- Low volatility

---

## 11. Optimization

Optimization is a research tool, not proof of strategy validity.

The purpose of optimization is to identify:

- Parameter sensitivity
- Stable parameter regions
- Weak parameters
- Potential improvements

Avoid selecting a configuration solely because it produces the highest historical profit.

A highly optimized configuration that fails on unseen data should not be considered validated.

---

## 12. Evidence

Research conclusions should be supported by artifacts.

Typical evidence includes:

- `.mq5` source code
- MT5 Strategy Tester report
- Backtest charts
- Parameter configuration
- Performance metrics
- Research notes

Do not record a research conclusion without retaining the evidence used to reach it.

---

## 13. Reproducibility

Another researcher should be able to understand:

- What was tested
- Which EA version was tested
- Which parameters were used
- Which market was tested
- Which timeframe was used
- Which historical period was used
- What result was produced

Changes to strategy logic should be documented and tested again rather than silently replacing previous results.

---

## 14. Research Integrity

The repository separates:

**Implementation → Evidence → Conclusion**

An EA source file proves that a strategy was implemented.

A backtest proves that a specific implementation was tested under specific historical conditions.

Neither alone proves that the strategy will remain profitable in future markets.

Negative results should be retained when they provide useful research evidence.

---

## 15. Standard Repository Workflow

```text
1. Define strategy hypothesis
        ↓
2. Convert hypothesis into explicit rules
        ↓
3. Implement EA in MQL5
        ↓
4. Compile and verify execution
        ↓
5. Run baseline backtest
        ↓
6. Save original test evidence
        ↓
7. Record metrics
        ↓
8. Evaluate baseline
        ↓
9. Identify next research question
        ↓
10. Run additional validation
        ↓
11. Record final research conclusion
```

---

## 16. Repository Structure

```text
xauusd-mt5-ea-research/
│
├── EAs/
│   └── EA-XXX_Strategy_Name/
│       ├── EA-XXX_Strategy_Name.mq5
│       └── README.md
│
├── Backtest/
│   └── EA-XXX_Strategy_Name/
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

---

## 17. Current Example

EA-037 provides the current reference example for this workflow:

`EA-037_ATR_Trend_Filter`

The strategy has:

- Defined EMA + ATR trading rules
- MQL5 implementation
- Baseline MT5 backtest
- Preserved performance evidence
- Initial research evaluation

Its baseline test should be treated as research evidence rather than proof of production readiness.
