# EA Research Methodology

## 1. Purpose

This document defines the methodology used to document and evaluate MT5 Expert Advisors in the XAUUSD research repository.

The purpose is to make each backtest reproducible and comparable.

---

## 2. EA Documentation

Each EA must have its own directory under:

`EAs/`

The directory should contain:

* EA source code
* EA README

The README describes the implementation actually present in the source code.

It should document:

* Strategy concept
* Entry conditions
* Exit conditions
* Risk controls
* Execution controls
* Input parameters
* Trade-safety mechanisms

---

## 3. Backtest Documentation

Each EA should have a corresponding directory under:

`Backtest/`

Each baseline test should preserve:

* EA name
* EA version
* Symbol
* Timeframe
* Test period
* Initial deposit
* Leverage
* Tester model
* History quality
* Input parameters
* Main performance results

The original tester report should be preserved together with the written summary.

---

## 4. Baseline Test

The first test for an EA is treated as the baseline.

The baseline establishes a reference point for later research.

For EA-091_VWAP_Deviation, the supplied baseline is:

* XAUUSD.PRO
* M1
* 2026.01.02 – 2026.03.31
* Initial deposit: USD 1,000
* 100% real ticks

The tester report contains 85,161 bars and 39,639,179 ticks for the supplied run.

---

## 5. Parameter Recording

All parameters used in a test must be recorded.

For EA-091_VWAP_Deviation, the supplied baseline includes:

* Lot Size = 0.01
* Stop Loss = 300
* Take Profit = 600
* Magic Number = 123091
* Slippage = 10
* Maximum Spread = 30
* Break Even enabled
* Break Even Trigger = 150
* Break Even Offset = 0
* Trailing Stop enabled
* Trailing Start = 200
* Trailing Distance = 100
* Trailing Step = 10
* VWAP Minimum Bars = 20
* ATR Period = 14
* VWAP Deviation = 1.0 ATR

These values are taken from the supplied Strategy Tester configuration.

---

## 6. Experimental Method

When testing a parameter or mechanism, the changed variable should be clearly identified.

Example:

Baseline:

`InpVWAPDeviationATR = 1.0`

Experiment:

`InpVWAPDeviationATR = 1.5`

The other parameters should remain unchanged unless the experiment is specifically designed to test multiple variables.

This makes the result easier to attribute to the variable being studied.

---

## 7. Performance Metrics

At minimum, each backtest should record:

* Net Profit
* Gross Profit
* Gross Loss
* Profit Factor
* Expected Payoff
* Maximum Drawdown
* Total Trades
* Winning Trades
* Losing Trades
* Average Winning Trade
* Average Losing Trade
* Maximum Consecutive Wins
* Maximum Consecutive Losses
* Sharpe Ratio
* Recovery Factor

Additional metrics may be recorded when available from the Strategy Tester.

---

## 8. Drawdown

Drawdown must be recorded together with the initial deposit.

A high net profit alone is not sufficient to describe a test.

The baseline EA-091_VWAP_Deviation test reported maximum balance drawdown of 99.35% and maximum equity drawdown of 99.35%.

---

## 9. Trade Distribution

Trade count and trade distribution should be examined together with profitability.

For the supplied EA-091 baseline:

* Total Trades = 10,893
* Profit Trades = 5,501
* Loss Trades = 5,392
* Average Profit Trade = 2.25 USD
* Average Loss Trade = -2.48 USD

These values provide context for understanding the reported Profit Factor of 0.93.

---

## 10. Execution Analysis

The research should distinguish between:

### Strategy logic

Whether the entry and exit rules generate the intended signals.

### Execution

Whether orders are actually accepted and filled according to the intended conditions.

### Position management

Whether Break Even and Trailing Stop modify protective levels as intended.

### Broker constraints

Whether spread, stops level, freeze level, symbol trading mode, margin and order rules affect execution.

---

## 11. Reproducibility

Every research result should be reproducible from:

1. The exact EA source version.
2. The recorded input parameters.
3. The recorded symbol.
4. The recorded timeframe.
5. The recorded test period.
6. The recorded tester model/history quality.
7. The preserved Strategy Tester report.

---

## 12. Interpretation Rule

A single backtest is treated as evidence about the tested historical sample only.

It is not treated as proof of future performance.

A strategy should only be considered robust after testing across appropriate additional periods and conditions.

---

## 13. Current EA-091 Baseline

The supplied EA-091_VWAP_Deviation baseline produced:

`Net Profit = -993.41 USD`

`Profit Factor = 0.93`

`Maximum Equity Drawdown = 99.35%`

`Sharpe Ratio = -5.00`

The baseline is therefore recorded as a historical reference for future EA-091 research rather than as a validated performance result.
