# XAUUSD MT5 EA Research Methodology

## 1. Purpose

This document defines the methodology used to document and evaluate Expert Advisors in the XAUUSD MT5 research repository.

The purpose is to keep EA implementation, backtest results, and research observations separated.

---

## 2. Repository Structure

Each EA follows this structure:

```text
EAs/
└── EA-XXX_Name/
    ├── EA-XXX_Name.mq5
    └── README.md

Backtest/
└── EA-XXX_Name/
    ├── Strategy Tester Report
    └── README.md

Research/
└── README.md

docs/
└── methodology.md
```

---

## 3. EA Documentation

The EA directory documents the actual implementation.

The documentation should identify:

* EA name.
* Indicators used.
* Entry conditions.
* Exit conditions.
* Stop Loss.
* Take Profit.
* Break Even.
* Trailing Stop.
* Position restrictions.
* Execution parameters.
* Default timeframe.
* Default inputs.

The EA README should describe the implementation without adding assumptions that are not present in the source code.

---

## 4. Backtest Documentation

Each backtest must record the actual Strategy Tester configuration.

At minimum, document:

* Expert Advisor.
* Symbol.
* Timeframe.
* Test period.
* Initial deposit.
* Leverage.
* Data quality.
* EA inputs.
* Net profit.
* Gross profit.
* Gross loss.
* Profit factor.
* Drawdown.
* Sharpe ratio.
* Total trades.
* Winning trades.
* Losing trades.
* Average profit.
* Average loss.
* Maximum consecutive wins.
* Maximum consecutive losses.
* Position holding time.

The original Strategy Tester report should be retained as the primary record whenever available.

---

## 5. Research Documentation

Research separates observed results from interpretation.

The research document should contain:

1. Research objective.
2. Strategy structure.
3. Backtest configuration.
4. Performance results.
5. Trade distribution.
6. Drawdown.
7. Trade frequency.
8. Consecutive results.
9. MFE/MAE statistics.
10. Research limitations.
11. Source files.

Numerical observations must come from the corresponding Strategy Tester report.

---

## 6. Interpretation Rules

A backtest result must be described according to the tested configuration and period.

The following distinctions must be maintained:

### Observed Result

A value directly reported by the Strategy Tester.

Example:

```text
Net Profit = -597.97 USD
```

### Interpretation

A description of what the observed result means within the tested configuration.

Example:

```text
The tested configuration produced a negative net result.
```

### Hypothesis

A possible explanation that requires additional testing.

A hypothesis must not be presented as an established fact.

---

## 7. Avoiding Unsupported Conclusions

A single backtest should not be used to claim future profitability.

The following should be kept separate:

* Historical backtest result.
* Research observation.
* Hypothesis.
* Future expectation.

If additional tests are not available, the documentation should explicitly state that the conclusion is limited to the supplied test.

---

## 8. Parameter Recording

All EA parameters used in a backtest must be recorded.

For EA-089_EMA20_Distance, the relevant parameters include:

```text
InpLotSize
InpStopLoss
InpTakeProfit
InpMagicNumber
InpSlippage
InpMaxSpread
InpTimeframe
InpBreakoutBuffer

InpUseBreakEven
InpBreakEvenTrigger
InpBreakEvenOffset

InpUseTrailingStop
InpTrailingStart
InpTrailingDistance
InpTrailingStep

InpEMAPeriod
InpATRPeriod
InpDistanceATR
```

The recorded values must correspond to the actual Strategy Tester configuration.

---

## 9. Reproducibility

A research result should be reproducible from:

```text
EA source code
+
Strategy Tester configuration
+
Test period
+
Symbol
+
Timeframe
+
Tester report
```

When any of these elements changes, the result should be treated as a separate test.

---

## 10. Versioning

Changes to the EA should be identifiable.

If the trading logic changes, the resulting backtest should not overwrite the historical result without preserving the original record.

A new configuration or materially changed EA should receive a separate backtest record.

---

## 11. Research Principle

The repository records what was tested and what was observed.

It does not treat a backtest result as proof of future market performance.

The primary objective is reproducibility, traceability, and separation between code, test results, and research interpretation.
