# Research — EA-120_Five_Candle_Momentum

## 1. Research Objective

The objective of this research is to evaluate the behavior and historical performance of `EA-120_Five_Candle_Momentum` on XAUUSD using MetaTrader 5 Strategy Tester.

The research focuses on:

- Understanding the actual entry logic implemented in the source code.
- Evaluating the relationship between entry direction and regression slope.
- Measuring profitability and drawdown.
- Assessing the impact of break-even and trailing-stop management.
- Maintaining reproducible experiments and documenting limitations.

## 2. Current Implementation

The current EA calculates a linear regression slope using recent closed-bar prices.

The default slope period is five bars.

The source code uses the following entry mapping:

| Calculated slope | Entry action |
|---|---|
| Negative | BUY |
| Positive | SELL |
| Zero | No entry |

New entries are evaluated on a new bar, subject to the trading-permission checks, spread filter, and existing-position restriction.

The EA also implements fixed lot sizing, Stop Loss, Take Profit, break-even, and trailing-stop management.

## 3. Initial Research Finding

The baseline test for 2026-01-02 to 2026-04-01 produced the following results:

- Net profit: -992.60 USD.
- Profit factor: 0.84.
- Maximum balance drawdown: 99.28%.
- Total trades: 5,012.
- Winning trades: 48.16%.

The baseline result is unsuccessful. The current configuration requires further investigation before any claim of profitability can be made.

## 4. Research Questions

### RQ-01 — Entry Logic

Does the implemented regression-slope entry logic behave as intended?

The source code currently buys when the calculated slope is negative and sells when it is positive. This direction mapping should be verified against the intended strategy specification.

### RQ-02 — Five-Candle Definition

Does the intended Five Candle Momentum strategy require five consecutive candles in the same direction, or does the name refer to a five-bar regression calculation?

The current source code does not explicitly check five consecutive bullish or bearish candles. The intended rule must be defined before the strategy can be evaluated against that specification.

### RQ-03 — Trade Management

How do break-even and trailing-stop settings affect the final trade outcomes?

The baseline enables both features. Their individual effects have not been isolated in the supplied results.

### RQ-04 — Parameter Sensitivity

How sensitive are the results to the slope period, Stop Loss, Take Profit, spread limit, and trailing-stop settings?

No parameter-sensitivity study has been supplied yet.

### RQ-05 — Robustness

Does the strategy maintain acceptable performance across different historical periods and market conditions?

The current report covers one symbol, one timeframe, and one test period. It is insufficient to establish general robustness.

## 5. Experiment Plan

Experiments should be conducted one variable at a time wherever practical.

| Experiment | Objective | Status |
|---|---|---|
| EXP-001 | Record baseline performance | Completed — unsuccessful |
| EXP-002 | Verify intended entry direction and strategy definition | Pending |
| EXP-003 | Compare break-even enabled vs. disabled | Pending |
| EXP-004 | Compare trailing stop enabled vs. disabled | Pending |
| EXP-005 | Evaluate slope-period sensitivity | Pending |
| EXP-006 | Evaluate performance over additional historical periods | Pending |

Pending experiments are research plans, not completed results.

## 6. Evaluation Criteria

Each experiment should record:

- Net profit.
- Profit factor.
- Maximum balance and equity drawdown.
- Total trades and win rate.
- Average winning and losing trade.
- Recovery factor.
- Changes to source code and input parameters.
- Any limitations affecting interpretation.

A profitable result in a single test is not sufficient to establish robustness. Results should be compared under consistent testing conditions and subsequently validated on data not used to select parameters.

## 7. Research Integrity

- Preserve the original source code and baseline report.
- Record each change and its rationale.
- Do not omit unsuccessful experiments.
- Do not describe planned experiments as completed.
- Do not claim that backtest results guarantee future performance.
- Distinguish observed results from hypotheses and interpretations.

## 8. Current Conclusion

The available baseline does not support the profitability of the current EA configuration.

The next research priority is to clarify the intended Five Candle Momentum rule and verify that the implemented entry direction matches that rule. Further experiments should follow after the strategy definition has been established.
