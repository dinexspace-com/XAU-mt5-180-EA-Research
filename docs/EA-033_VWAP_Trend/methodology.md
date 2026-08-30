# Methodology

This document defines the research and testing methodology used for the Expert Advisors in this repository.

The objective is to keep the process reproducible and evidence-based:

**Trading Idea → EA Implementation → Baseline Backtest → Analysis → Further Testing → Conclusion**

A strategy is not considered successful because it compiles, executes correctly, or produces an isolated profitable result.

---

## 1. Research Process

Each Expert Advisor follows the same basic workflow.

### Step 1 — Define the Trading Idea

The strategy must begin with explicit trading rules.

At minimum, define:

- Entry conditions
- BUY conditions
- SELL conditions
- Stop Loss
- Take Profit
- Position sizing
- Trade filters
- Exit or trade-management rules

The implementation should be understandable without relying on undocumented discretionary decisions.

---

## 2. EA Implementation

The strategy is implemented as a MetaTrader 5 Expert Advisor.

Source code is stored under:

`EAs/EA-XXX_Strategy_Name/`

Each EA directory contains:

- `.mq5` source code
- `README.md`

The README documents the actual implemented behavior of the EA.

If the implementation differs from the original trading hypothesis, the implemented behavior takes precedence when describing the tested EA.

---

## 3. Baseline Backtest

Before optimization, the original strategy configuration should be tested as a baseline.

The purpose of the baseline is to answer:

**Does the initial strategy demonstrate a measurable historical edge under the defined test conditions?**

The baseline must be retained even when the result is negative.

Failed tests are research evidence.

---

## 4. Backtest Environment

Backtests are performed using MetaTrader 5 Strategy Tester.

For every test, record at minimum:

| Parameter | Required |
|---|---|
| Expert Advisor | Yes |
| Symbol | Yes |
| Timeframe | Yes |
| Test Period | Yes |
| Initial Deposit | Yes |
| Leverage | Yes |
| Lot Size / Risk Model | Yes |
| Strategy Inputs | Yes |
| History Quality | Yes |

Where available, real tick data should be preferred.

The exact broker symbol and test environment must be recorded because XAUUSD contract specifications, spreads and execution conditions may differ between brokers.

---

## 5. Backtest Evidence

Each tested EA has its own directory:

`Backtest/EA-XXX_Strategy_Name/`

The directory should retain the original MetaTrader 5 Strategy Tester evidence.

Typical contents:

- Strategy Tester HTML report
- Balance graph
- Trade-distribution charts
- MFE / MAE chart
- Holding-time chart
- README describing the test and result

The raw Strategy Tester report is the primary evidence.

README files summarize the evidence but do not replace the original report.

---

## 6. Core Performance Metrics

The following metrics should be recorded when available:

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
- Average Profit Trade
- Average Loss Trade
- Largest Profit Trade
- Largest Loss Trade

### Stability

- Sharpe Ratio
- LR Correlation
- Maximum Consecutive Wins
- Maximum Consecutive Losses

No single metric should be used alone to determine whether a strategy is valid.

---

## 7. Baseline Example — EA-033 VWAP Trend

The first documented baseline in this repository is:

`EA-033_VWAP_Trend`

Test configuration:

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Lot Size | 0.01 |
| VWAP Period | 20 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Disabled |
| Trailing Stop | Disabled |
| History Quality | 100% real ticks |

Baseline result:

| Metric | Result |
|---|---:|
| Total Trades | 3,490 |
| Win Rate | 30.60% |
| Net Profit | -$992.07 |
| Profit Factor | 0.87 |
| Expected Payoff | -$0.28 |
| Sharpe Ratio | -5.00 |
| Maximum Drawdown | 99.22% |

**Classification: FAIL**

This baseline is retained as the reference point for future EA-033 research.

---

## 8. PASS / FAIL Principle

A test result must be classified from evidence rather than expectation.

### FAIL

A configuration fails when the available evidence shows that it does not demonstrate acceptable performance.

A failed configuration should remain in the repository.

It must not be deleted simply because the result is undesirable.

### RESEARCH

Used when a strategy contains characteristics worth investigating but current evidence is insufficient for validation.

### CANDIDATE

Used when a strategy has passed the defined research tests and is ready for additional validation.

### VALIDATED

Reserved for strategies that complete the required validation process.

A profitable backtest alone does not qualify a strategy as VALIDATED.

---

## 9. Optimization

Optimization should only begin after a baseline has been established.

The purpose of optimization is to investigate whether specific parameters or strategy components materially improve the result.

Examples include:

- VWAP period
- Stop Loss
- Take Profit
- Trading session
- Trend filters
- Volatility filters
- Break Even
- Trailing Stop
- Timeframe

Optimization results must always be compared against the baseline.

Parameter optimization should not be treated as proof that a strategy has a genuine trading edge.

---

## 10. Avoiding Overfitting

A strategy can appear profitable because parameters were selected specifically for one historical sample.

Therefore:

**In-sample optimization ≠ strategy validation**

A promising optimized configuration should subsequently be tested on data that was not used solely to select those parameters.

The objective is to determine whether the strategy behavior persists outside the optimization sample.

---

## 11. Out-of-Sample Testing

When a strategy becomes promising, historical data should be separated conceptually into:

**In-Sample (IS)**

Used for research and parameter development.

**Out-of-Sample (OOS)**

Used to evaluate the resulting configuration on unseen historical data.

A strategy that performs well in-sample but fails out-of-sample should not be considered validated.

---

## 12. Robustness Testing

Strategies that survive initial testing may be subjected to additional robustness checks.

Examples include:

- Different historical periods
- Different market conditions
- Different timeframes
- Parameter sensitivity
- Different spread assumptions
- Different broker environments

The purpose is not to find another profitable configuration.

The purpose is to determine whether the strategy's behavior is reasonably stable when test conditions change.

---

## 13. Forward Testing

Only strategies that survive the required historical research stages should proceed to forward testing.

Forward testing should use controlled conditions before any consideration of production deployment.

Historical backtests and forward tests represent different forms of evidence and should be documented separately.

---

## 14. Reproducibility

Every reported result should be traceable to:

1. EA source code
2. EA version/configuration
3. Input parameters
4. Symbol and timeframe
5. Historical test period
6. Strategy Tester report
7. Result classification

A result that cannot be reproduced from the available evidence should not be treated as verified research evidence.

---

## 15. Repository Structure

The research workflow maps directly to the repository:

`EAs/`

Contains strategy implementations and EA-specific documentation.

`Backtest/`

Contains Strategy Tester results and empirical evidence.

`Research/`

Contains research observations, hypotheses and interpretation.

`docs/methodology.md`

Defines the common methodology used to evaluate strategies throughout the repository.

---

## 16. Research Rule

The core rule of this repository is:

**Hypothesis → Code → Test → Evidence → Conclusion**

Do not change the conclusion to fit the original hypothesis.

If a strategy fails, record the failure.

If a modification appears to improve performance, test it.

If a strategy passes one test, continue validation before making stronger claims.

The objective is not to produce profitable-looking backtests.

The objective is to determine which trading hypotheses survive systematic testing.

---

## Disclaimer

This repository is intended for quantitative research, software development, and strategy testing.

Backtested and historical results do not guarantee future performance. A strategy should not be considered suitable for live trading solely because it produces favorable historical results.
