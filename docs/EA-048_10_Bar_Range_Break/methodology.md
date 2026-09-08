# Research & Backtesting Methodology

## 1. Purpose

This document defines the methodology used to research, implement, backtest, and evaluate Expert Advisors (EAs) in the XAUUSD MT5 EA Research repository.

The objective is to maintain a transparent and reproducible research process.

The workflow is:

Research Hypothesis
→ Trading Rules
→ MQL5 Implementation
→ MetaTrader 5 Backtest
→ Evidence Collection
→ Evaluation
→ PASS / FAIL
→ Further Research

A strategy is not considered successful simply because it can be coded or produces trades.

Its result must be supported by reproducible backtest evidence.

---

## 2. Research Principle

Each EA begins with a clearly defined trading hypothesis.

The hypothesis must be converted into explicit rules that can be implemented without discretionary interpretation.

For every EA, the following should be identifiable:

- Entry conditions
- Exit conditions
- Position sizing
- Stop Loss
- Take Profit
- Spread restrictions
- Trade-management rules
- Symbol
- Timeframe
- Strategy parameters

Any assumptions introduced during implementation should be documented.

---

## 3. Strategy Implementation

Strategies are implemented as MetaTrader 5 Expert Advisors using MQL5.

Source files are stored under:

    /EAs/EA-XXX_Strategy_Name/

Example:

    /EAs/EA-048_10_Bar_Donchian/
        EA-048_10_Bar_Donchian.mq5
        README.md

Each EA receives a unique identifier.

Example:

    EA-048

The identifier should remain stable so that source code, research notes, and backtest evidence can be associated with the same experiment.

---

## 4. Baseline First

The first implementation should be the simplest version capable of testing the research hypothesis.

The baseline should be tested before extensive optimization.

The purpose of the baseline is to answer:

> Does the original implementation show sufficient evidence to justify further investigation?

Negative baseline results must be retained.

They are part of the research evidence.

---

## 5. Backtesting Environment

Backtests are performed using MetaTrader 5 Strategy Tester.

Whenever possible, testing should use:

    History Quality: 100% real ticks

The backtest record should preserve:

- EA name
- Symbol
- Timeframe
- Test period
- Broker/server
- MT5 build
- Initial deposit
- Leverage
- EA inputs
- Historical-data quality
- Strategy Tester report

This information is required to make the experiment reproducible.

---

## 6. Backtest Evidence

Each EA has its own backtest directory:

    /Backtest/EA-XXX_Strategy_Name/

The directory should retain the original MetaTrader 5 Strategy Tester artifacts.

These may include:

- HTML Strategy Tester report
- Balance graph
- Entry-distribution charts
- Profit/loss charts
- MFE/MAE analysis
- Holding-time analysis
- README summary

The original Strategy Tester report is the authoritative source for numerical results.

README files summarize the evidence but do not replace the original report.

---

## 7. Core Evaluation Metrics

The following metrics should be recorded when available.

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
- Long Trades
- Short Trades
- Average Profit Trade
- Average Loss Trade
- Largest Profit Trade
- Largest Loss Trade

### Stability

- Sharpe Ratio
- Maximum Consecutive Wins
- Maximum Consecutive Losses
- Equity/Balance Curve

### Trade Behaviour

When available:

- MFE
- MAE
- Holding Time
- Entry distribution by hour
- Entry distribution by weekday
- Entry distribution by month

No single metric should be used as the sole evidence of strategy quality.

---

## 8. PASS / FAIL Evaluation

Backtest results must not be labeled profitable when the Strategy Tester evidence shows otherwise.

At minimum:

### FAIL

A baseline profitability test fails when:

    Total Net Profit <= 0

or:

    Profit Factor <= 1.00

Such a result may still justify further research, but it must not be presented as a validated profitable strategy.

### PASS

A positive baseline requires at minimum:

    Total Net Profit > 0

and:

    Profit Factor > 1.00

However, passing these two conditions does NOT automatically make an EA production-ready.

Additional validation is required.

---

## 9. EA-048 Baseline Example

EA-048 tests a 10-bar Donchian breakout implementation on XAUUSD.

Baseline environment:

    EA: EA-048_10-Bar_Donchian
    Symbol: XAUUSD.PRO
    Timeframe: M1
    Period: 2026-01-02 → 2026-04-01
    Initial Deposit: $1,000
    Leverage: 1:500
    History Quality: 100% real ticks

Key baseline results:

    Total Net Profit: -$30.84
    Profit Factor: 0.98
    Expected Payoff: -$0.04
    Maximum Equity Drawdown: 12.95%
    Total Trades: 748
    Win Rate: 40.51%

According to the baseline criteria:

    EA-048 BASELINE RESULT: FAIL

The result is retained rather than removed because it provides the reference point for future EA-048 experiments.

---

## 10. Optimization Policy

Optimization must follow baseline testing.

The process should be:

    Baseline
        ↓
    Identify weakness
        ↓
    Define new hypothesis
        ↓
    Change limited variables
        ↓
    Backtest
        ↓
    Compare with baseline

Optimization should not consist of repeatedly searching parameter combinations until a profitable historical result is found.

Every meaningful modification should be treated as a new experiment.

Examples include:

- Different Donchian periods
- Different timeframe
- Different exit logic
- Different Stop Loss
- Different Take Profit
- Different Break Even logic
- Different Trailing Stop logic
- Session filters
- Volatility filters

Results should be compared against the baseline.

---

## 11. Avoiding Overfitting

A profitable historical backtest does not prove that a strategy will remain profitable.

Repeatedly optimizing parameters against the same historical period increases the risk of overfitting.

Therefore:

1. Establish a baseline first.
2. Record every meaningful experiment.
3. Avoid selecting results only because they are profitable.
4. Preserve failed experiments.
5. Separate strategy development from final validation.
6. Use unseen data for later validation when appropriate.

Optimization results should be treated as research candidates rather than final evidence.

---

## 12. Further Validation

A promising strategy should undergo additional testing before being considered for production use.

Possible later validation stages include:

### Out-of-Sample Testing

Test the strategy on historical data not used during development.

### Walk-Forward Testing

Develop or optimize on one period and evaluate on a later unseen period.

### Parameter Robustness

Test whether performance remains reasonable when parameters are changed slightly.

### Different Market Conditions

Evaluate performance across:

- Trending periods
- Ranging periods
- High-volatility periods
- Low-volatility periods

### Forward Testing

Run the EA in a demo or controlled forward environment before considering live deployment.

These stages are separate from the initial baseline experiment.

---

## 13. Research Integrity

All results should be retained whether they PASS or FAIL.

The repository should not:

- Delete negative experiments merely because they failed.
- Present optimized results as if they were the original baseline.
- Modify historical metrics manually.
- Claim profitability without supporting evidence.
- Claim production readiness from a single backtest.
- Hide material assumptions used during testing.

The goal is research traceability rather than selecting only attractive results.

---

## 14. Repository Traceability

Each experiment should be traceable across the repository.

Example:

    EA-048
    │
    ├── EAs/
    │   └── EA-048_10_Bar_Donchian/
    │       ├── EA-048_10_Bar_Donchian.mq5
    │       └── README.md
    │
    ├── Backtest/
    │   └── EA-048_10_Bar_Donchian/
    │       ├── Strategy Tester artifacts
    │       └── README.md
    │
    └── Research/
        └── README.md

This creates a chain of evidence:

    Research Idea
        ↓
    Source Code
        ↓
    Backtest
        ↓
    Raw Evidence
        ↓
    Evaluation

---

## 15. Current Research Stage

For EA-048:

    Strategy defined       : YES
    MQL5 implementation    : YES
    Baseline backtest      : YES
    Raw evidence retained  : YES
    Baseline PASS          : NO
    Optimization validated : NO
    Out-of-sample test     : NOT YET
    Forward test           : NOT YET
    Production ready       : NO

EA-048 therefore remains in the research stage.

---

## Disclaimer

This repository is intended for quantitative trading research, software development, and educational purposes.

Backtests represent historical simulations and do not guarantee future performance.

Trading XAUUSD and other leveraged financial instruments involves substantial risk.
