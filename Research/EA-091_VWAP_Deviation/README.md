# EA-091_VWAP_Deviation Research

## 1. Research Objective

The research objective is to evaluate the behavior and robustness of the EA-091_VWAP_Deviation strategy on XAUUSD.

The strategy is based on price deviation from daily VWAP and an ATR-based deviation threshold.

The research should separate:

1. Strategy logic
2. Execution behavior
3. Risk management
4. Historical performance
5. Robustness across different market periods

---

## 2. Baseline Version

**EA:** EA-091_VWAP_Deviation

**Timeframe:** M1

**Symbol tested:** XAUUSD.PRO

**Baseline period:** 2026.01.02 – 2026.03.31

**Initial deposit:** USD 1,000

**Lot size:** 0.01

**VWAP minimum bars:** 20

**ATR period:** 14

**VWAP deviation threshold:** 1.0 ATR

---

## 3. Strategy Hypothesis

The strategy attempts to identify a first price turn after price has deviated from daily VWAP by at least a specified ATR multiple.

### Buy hypothesis

Price moves below VWAP by the required ATR deviation and subsequently shows an upward turn while remaining below VWAP.

### Sell hypothesis

Price moves above VWAP by the required ATR deviation and subsequently shows a downward turn while remaining above VWAP.

The strategy therefore attempts to capture a reversion from an extreme deviation rather than enter after price has already crossed VWAP.

---

## 4. Baseline Evidence

The supplied baseline test produced:

* Net Profit: -993.41 USD
* Profit Factor: 0.93
* Expected Payoff: -0.09 USD
* Total Trades: 10,893
* Profit Trades: 50.50%
* Loss Trades: 49.50%
* Maximum Equity Drawdown: 99.35%
* Sharpe Ratio: -5.00

These figures come directly from the supplied Strategy Tester report.

---

## 5. Initial Research Findings

The baseline test demonstrates that the tested configuration did not produce a positive net result over the supplied period.

The win rate was close to 50%, while the average losing trade was larger than the average winning trade:

* Average profit trade: 2.25 USD
* Average loss trade: -2.48 USD

The test also generated a large number of trades:

`10,893`

This provides a substantial sample for studying execution and distribution characteristics, but the reported profitability metrics remained negative.

---

## 6. Research Questions

The next research stages should answer:

### A. VWAP Deviation

Does changing the required VWAP deviation from 1.0 ATR materially change the trade distribution?

### B. Stop Loss / Take Profit

How does the fixed SL/TP structure affect:

* Average win
* Average loss
* Profit Factor
* Drawdown
* Trade frequency

### C. Break Even

How much of the result is affected by the Break Even mechanism?

### D. Trailing Stop

How much of the result is affected by the Trailing Stop mechanism?

### E. Market Period

Does the behavior remain consistent across different market regimes and historical periods?

### F. Execution

How sensitive is the strategy to:

* Spread
* Slippage
* Broker execution
* Symbol specification

---

## 7. Research Discipline

Each experiment should preserve:

* EA version
* Test period
* Symbol
* Timeframe
* Initial deposit
* Lot size
* All input parameters
* Tester model
* History quality
* Result metrics

Changes should be isolated whenever possible so that the effect of each variable can be identified.

---

## 8. Baseline Reference

The current supplied test is the baseline reference for EA-091_VWAP_Deviation.

Future versions should be compared against this baseline without changing multiple research variables at the same time unless the experiment explicitly requires it.

---

## 9. Current Research Status

`BASELINE ESTABLISHED`

The baseline test is complete.

The current result is documented for comparison purposes.

No claim of strategy robustness or future profitability is made from this single historical test.
