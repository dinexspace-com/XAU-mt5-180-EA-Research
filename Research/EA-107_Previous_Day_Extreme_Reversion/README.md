
# EA-107 — Previous Day Extreme Reversion Research

## 1. Research Objective

Determine whether previous-day high/low rejection provides a repeatable trading edge on XAUUSD.

The baseline failed. Research must identify whether the main limitation is entry confirmation, market regime, trading session, or directional asymmetry.

## 2. Baseline Reference

- **Baseline ID:** `EA107-M1-BASELINE-001`
- **Net Profit:** -$152.75
- **Profit Factor:** 0.83
- **Max Equity Drawdown:** 18.51%
- **Total Trades:** 693
- **Decision:** FAIL

Do not overwrite the baseline results when running new experiments.

## 3. Research Questions

### RQ01 — Previous-Day Extreme Definition

Compare the existing definition with controlled alternatives:

- Price pierces the previous-day high/low and closes back inside.
- Minimum penetration distance beyond the level.
- Maximum penetration distance beyond the level.
- Distance measured in points versus ATR-normalized distance.

Record trade count and both directional results for every variant.

### RQ02 — Entry Confirmation

Test one confirmation method at a time:

- Existing close-back-inside condition.
- Minimum candle body size.
- Candle body direction consistent with reversal.
- Close location within the signal candle's range.
- Confirmation by a subsequent candle.

### RQ03 — BUY vs SELL

Evaluate BUY and SELL separately.

- Compare net profit, Profit Factor, expected payoff, and drawdown.
- Check whether either direction has a stable edge.
- Do not disable a direction based only on its baseline win rate.

### RQ04 — Trading Session

Compare defined trading-session windows using the same baseline settings.

Record session time zone and broker-server time. Avoid selecting a session solely because it performs best on the same historical sample.

### RQ05 — Market Regime

Investigate whether results differ across:

- Trending and ranging conditions.
- Low and high volatility.
- Small and large previous-day ranges.
- Different distances from the previous-day extreme.

Use objective definitions and avoid adding several filters simultaneously.

### RQ06 — Exit Management

Only after entry evidence improves, test:

- Stop-loss and take-profit settings.
- Break-even trigger and offset.
- Trailing-stop start and distance.

Change one parameter group at a time.

### RQ07 — Out-of-Sample Validation

Evaluate the selected configuration on data not used to select its parameters.

Do not use out-of-sample results to repeatedly tune the strategy.

### RQ08 — Robustness and Walk-Forward

Test nearby parameter values, different time windows, and sequential walk-forward periods. Record instability and degradation, not just the best result.

## 4. Evaluation Metrics

Every experiment must record:

- Net Profit
- Profit Factor
- Expected Payoff
- Maximum Equity Drawdown
- Recovery Factor
- Sharpe Ratio
- Total Trades
- BUY and SELL results
- Winning and losing trade statistics

No single metric is sufficient to establish a trading edge.

## 5. Experiment Rules

1. Preserve `EA107-M1-BASELINE-001` unchanged.
2. Change one research variable group at a time.
3. Record the exact inputs and test period for every run.
4. Compare against the baseline, not only against other variants.
5. Do not select parameters using net profit alone.
6. Avoid broad optimization until evidence supports the entry hypothesis.
7. Require independent out-of-sample and robustness checks before considering forward testing.

## 6. Current Research Status

| Item | Status |
|---|---|
| Strategy Definition | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Result | FAIL |
| Entry Condition Research | NOT STARTED |
| Directional Analysis | BASELINE RECORDED |
| Session / Regime Research | NOT STARTED |
| Exit Research | NOT STARTED |
| Out-of-Sample | NOT STARTED |
| Walk-Forward | NOT STARTED |
| Forward Test | NOT STARTED |
| Live Trading | NOT APPROVED |

## 7. Current Conclusion

The existing previous-day extreme reversal condition has not produced a positive baseline result. The next step is controlled entry-condition research, beginning with penetration distance and reversal confirmation. No production-readiness claim is justified by the current test.
