# EA-106 — Research Log

## Research Objective

Investigate why the Session Sweep Reversion strategy loses money and determine whether its entry logic has a measurable edge before optimizing parameters.

## Baseline

* **Baseline ID:** `EA106-M1-BASELINE-001`
* **Symbol:** XAUUSD.PRO
* **Timeframe:** M1
* **Period:** 2026-01-02 to 2026-04-01
* **Net Profit:** -$142.71
* **Profit Factor:** 0.81
* **Max Equity Drawdown:** 19.06%
* **Trades:** 569
* **Decision:** FAIL

## Initial Findings

### 1. Directional Performance Is Uneven

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| BUY       |    242 |   53.31% |
| SELL      |    327 |   43.43% |

The BUY win rate is higher in this report. This does not by itself prove that BUY trades are profitable; net profit and average outcome by direction must be measured separately.

### 2. Average Loss Exceeds Average Win

* Average winning trade: $2.26
* Average losing trade: -$2.54
* Expected Payoff: -$0.25

The strategy's win rate and win/loss sizes are not sufficient to produce a positive baseline result.

### 3. Verify Session-Time Logic

The source uses `InpSessionStartHour` and `InpSessionEndHour` to build a session range. With defaults of 0 and 8, it collects the range from 00:00 to 08:00 and allows entry checks from hour 08 through hour 19, based on the candle's time.

Verify that these hours use the intended broker server time and represent the intended session. Do not assume they correspond to local Vietnam time.

## Experiment Plan

### Phase 1 — Validate Implementation

* [ ] Confirm broker server-time interpretation.
* [ ] Confirm range boundaries include the intended candles.
* [ ] Confirm the entry window matches the intended session.
* [ ] Verify behavior when no valid range is available.
* [ ] Review order rejection logs and stop-distance constraints.

### Phase 2 — Isolate Directional Edge

* [ ] Run BUY-only test.
* [ ] Run SELL-only test.
* [ ] Compare net profit, Profit Factor, expected payoff, drawdown, and trade count.
* [ ] Do not select a direction using win rate alone.

Suggested experiment IDs:

* `EA106-M1-BUY-ONLY-001`
* `EA106-M1-SELL-ONLY-001`

### Phase 3 — Test Entry Logic

Change one variable or rule at a time:

* Session-range start and end hours.
* Definition of range high and low.
* Sweep confirmation and candle-close conditions.
* Minimum distance beyond the range before a sweep qualifies.
* Optional confirmation before entering after a sweep.

Record the hypothesis before each test. Any new entry filter must be documented as a strategy change rather than silently treated as the original baseline.

### Phase 4 — Test Exit Management

Evaluate separately:

* Stop Loss and Take Profit.
* Break-Even activation and offset.
* Trailing Stop activation and distance.

Do not combine exit changes with entry changes in the same initial experiment; otherwise, the cause of a performance change will be unclear.

### Phase 5 — Robustness

Only if controlled experiments show improvement:

* Test a separate out-of-sample period.
* Compare performance across different market conditions.
* Perform walk-forward analysis.
* Assess sensitivity to spread and execution assumptions.
* Run forward testing on demo before considering live deployment.

## Research Rules

1. Preserve the original source and baseline report.
2. Use a unique experiment ID for each test.
3. Change one major variable at a time.
4. Record all inputs and tester settings.
5. Do not classify an EA as successful based only on a higher win rate or a single optimized run.
6. Do not approve live trading until robustness and forward testing are complete.

## Current Conclusion

EA-106 remains a failed baseline. The first priority is to verify the session-time implementation and measure BUY and SELL results separately before further parameter optimization.
