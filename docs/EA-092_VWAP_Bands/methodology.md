# EA Research Methodology

## 1. Purpose

This document defines the methodology used to document and evaluate MT5 Expert Advisors in the research repository.

The purpose is to ensure that different EA versions and experiments can be compared using reproducible test conditions.

---

## 2. EA Documentation

Each EA should document:

* EA identifier
* Strategy name
* Symbol
* Timeframe
* Entry logic
* Exit logic
* Risk controls
* Execution controls
* Input parameters
* Position-management rules
* Current research status

The documentation should describe the implemented behavior rather than an intended or assumed behavior.

---

## 3. Backtest Documentation

Every baseline backtest should record:

```text
EA
Symbol
Timeframe
Test Period
History Quality
Initial Deposit
Leverage
Lot Size
Stop Loss
Take Profit
Magic Number
Spread Limit
Strategy Parameters
Break-even Parameters
Trailing Parameters
```

## The EA-092 baseline report provides these values and uses XAUUSD.PRO M1 data from 2026.01.02 through 2026.03.31 with 100% real ticks.

## 4. Core Performance Metrics

The following metrics should be recorded for every experiment:

### Net Profit

Total profit or loss over the test period.

### Profit Factor

```text
Gross Profit / Absolute Gross Loss
```

### Expected Payoff

Average result per trade.

### Maximum Equity Drawdown

Maximum decline in equity during the test.

### Total Trades

Total number of completed trades.

### Win Rate

```text
Winning Trades / Total Trades
```

### Average Profit Trade

Average result among winning trades.

### Average Loss Trade

Average result among losing trades.

---

## 5. Risk Evaluation

Performance should not be evaluated using Net Profit alone.

At minimum, research records should consider:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Equity Drawdown
Maximum Balance Drawdown
Largest Loss
Consecutive Losses
Average Loss
Trade Count
```

For EA-092, the baseline maximum equity drawdown was 22.67% while Net Profit was -172.04 USD.

---

## 6. Trade Distribution

A strategy can have a win rate above 50% while still losing money.

Therefore, the following relationship should always be examined:

```text
Win Rate
+
Average Winning Trade
+
Average Losing Trade
=
Actual Payoff Distribution
```

For the EA-092 baseline:

```text
Win Rate:          51.13%
Average Profit:     2.14 USD
Average Loss:      -2.61 USD
Profit Factor:      0.85
Expected Payoff:   -0.19 USD
```

---

## 7. Execution Analysis

Execution behavior should be separated from strategy logic.

Review:

* Entry frequency
* Holding time
* Exit reason
* Stop-loss exits
* Take-profit exits
* VWAP exits
* Break-even modifications
* Trailing-stop modifications
* Spread restrictions
* Order rejection
* Position blocking

The EA-092 report records:

```text
Minimum Holding Time: 2 seconds
Maximum Holding Time: 2:07:00
Average Holding Time: 1:54
```

---

## 8. Baseline Experiment Rule

The first test of every EA should be treated as the baseline.

The baseline should:

1. Use the documented default inputs.
2. Use a fixed test period.
3. Use a fixed symbol.
4. Use a fixed timeframe.
5. Use the same historical-data quality.
6. Record all relevant results.
7. Be preserved without modification.

The baseline becomes the reference point for later experiments.

---

## 9. One-Variable Experiment

When investigating a strategy, change one major variable or rule at a time.

Example:

```text
Experiment A
Baseline:
Band Multiplier = 2.0

Experiment B
Only change:
Band Multiplier = X

Everything else:
Unchanged
```

This makes the resulting difference attributable to the tested variable with greater confidence.

---

## 10. Avoid Parameter Mixing

Do not combine several unrelated modifications into one experiment.

For example:

```text
Band = changed
SL = changed
TP = changed
Break-even = changed
Trailing = changed
```

Such a test cannot determine which change produced the observed result.

Instead, maintain a sequence of controlled experiments.

---

## 11. Reproducibility

Every experiment should be reproducible from the repository.

Store or document:

```text
EA source version
EA identifier
Input configuration
Symbol
Timeframe
Test period
History quality
Initial deposit
Leverage
Tester build
Backtest report
Result summary
Research conclusion
```

The EA-092 report identifies the tester environment as `ACCMIntl-Real (Build 6230)`.

---

## 12. Interpretation Rule

A backtest result should be described factually.

Use:

```text
Positive / Negative
```

for numerical outcomes when appropriate.

Avoid treating a single backtest as proof of future live performance.

A negative baseline means the tested configuration produced negative results under the specified historical conditions.

It does not by itself establish that every variation of the strategy will fail.

Likewise, a positive historical backtest does not establish future profitability.

---

## 13. EA-092 Baseline

The current EA-092 baseline is:

```text
EA: EA-092_VWAP_Bands
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026.01.02 - 2026.03.31
History: 100% real ticks

Initial Deposit: 1,000 USD
Leverage: 1:500

Net Profit: -172.04 USD
Profit Factor: 0.85
Expected Payoff: -0.19 USD
Maximum Equity Drawdown: 22.67%
Total Trades: 927
```

This result should remain unchanged as the reference baseline for subsequent EA-092 research.
