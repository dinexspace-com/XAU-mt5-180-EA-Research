# EA-105 — Range Midpoint Research Plan

## 1. Research Objective

Determine whether the Range Boundary Rejection strategy has a repeatable trading edge on XAUUSD M1.

The baseline failed with net profit of -$400.13, Profit Factor 0.87 and maximum equity drawdown of 44.56%.

Research must identify whether the entry rules, range construction, direction or trade management contribute to the negative result.

## 2. Frozen Baseline

**Baseline ID:** `EA105-M1-BASELINE-001`

| Parameter            |      Value |
| -------------------- | ---------: |
| Range Bars           |         20 |
| Rejection Wick Ratio |        0.5 |
| Stop Loss            | 300 points |
| Take Profit          | 600 points |
| Break-even Trigger   | 150 points |
| Trailing Start       | 200 points |
| Trailing Distance    | 200 points |
| Maximum Spread       |  30 points |
| Lot Size             |       0.01 |

Preserve the original code, inputs and report. Change only the parameter group being tested in each experiment.

## 3. Controlled Experiment Sequence

### RQ01 — Range Length

Test `InpRangeBars`:

`10, 15, 20, 25, 30, 40, 50`

Objective: determine whether the range lookback is too short or too long.

### RQ02 — Rejection Wick Ratio

Test `InpRejectionWickRatio`:

`0.30, 0.40, 0.50, 0.60, 0.70, 0.80`

Objective: evaluate whether requiring a stronger rejection improves entry quality.

### RQ03 — Range Boundary Zone

Test the boundary-zone width independently:

`5%, 10%, 15%, 20%`

Objective: evaluate how close price must reach the range extreme before a signal is accepted.

The boundary-zone percentage is not currently an input in the source code. If this experiment is implemented, document the code change and assign a new experiment identifier.

### RQ04 — BUY vs SELL

Evaluate BUY-only and SELL-only separately using identical test conditions.

The baseline showed:

* BUY: 1,193 trades, 45.26% wins.
* SELL: 1,396 trades, 48.42% wins.

Do not conclude that SELL has a robust edge based only on these baseline results.

### RQ05 — Entry Confirmation

Evaluate one confirmation change at a time, such as:

* Minimum candle body size.
* Candle close location within its range.
* Stronger rejection-wick requirement.
* Additional confirmation from the next candle.

Any new rule must be documented as a strategy modification rather than a baseline parameter change.

### RQ06 — Stop Loss and Take Profit

After entry behavior has been investigated, test controlled SL/TP combinations.

Do not optimize exits solely to maximize net profit on the original sample.

### RQ07 — Break-even and Trailing Stop

Compare:

* Break-even and trailing both enabled.
* Break-even only.
* Trailing only.
* Both disabled.

Keep all other inputs unchanged for each comparison.

### RQ08 — Trading Session

Compare predefined trading sessions to assess whether the baseline losses are concentrated in particular periods.

Record the timezone used for session definitions.

### RQ09 — Out-of-Sample Validation

Only proceed if an experiment shows credible improvement on the development sample.

Use a separate, previously unused period. Do not use the out-of-sample period to select parameters.

### RQ10 — Robustness and Walk-Forward

Evaluate parameter stability, adjacent parameter values and multiple market conditions. Use walk-forward testing before considering a forward test.

## 4. Evaluation Metrics

Record at least:

* Net Profit
* Profit Factor
* Expected Payoff
* Maximum Equity Drawdown
* Recovery Factor
* Sharpe Ratio
* Number of Trades
* Win Rate
* BUY and SELL performance separately
* Performance by test period

Do not select a configuration by net profit alone. Consider drawdown, trade count, consistency and out-of-sample performance.

## 5. Research Rules

1. Keep the baseline unchanged.
2. Change one variable group per experiment.
3. Record every run, including failed results.
4. Avoid broad parameter optimization before finding credible evidence of an edge.
5. Do not reuse out-of-sample data for parameter selection.
6. Do not approve live trading based on a single backtest.

## 6. Current Status

* Strategy Code: `COMPLETE`
* Baseline Backtest: `COMPLETE`
* Baseline Result: `FAIL`
* Controlled Research: `PENDING`
* Out-of-Sample: `NOT STARTED`
* Walk-Forward: `NOT STARTED`
* Forward Test: `NOT STARTED`
* Live Trading: `NOT APPROVED`
