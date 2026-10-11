# EA-108 — VWAP Crossback Research

## 1. Research Objective

Determine why the EA-108 baseline lost $992.86 and reached a 99.30% maximum equity drawdown, then evaluate whether the VWAP Crossback entry concept has a measurable edge.

**Baseline:** `EA108-M1-BASELINE-001`

**Baseline classification:** FAIL

## 2. Baseline Hypothesis

The EA uses daily VWAP calculated from M1 typical prices and tick volume. It searches for a bullish candle near VWAP while price remains below VWAP for a BUY, or a bearish candle near VWAP while price remains above VWAP for a SELL.

The baseline does not demonstrate that these patterns provide a profitable entry signal. Potential areas for investigation include signal interpretation, directional asymmetry, trading frequency, and exit behavior.

These are research questions, not confirmed causes of the loss.

## 3. Research Plan

### Phase 1 — Verify Implementation

- Confirm that VWAP resets at the intended broker-day boundary.
- Verify that each historical candle is compared with the correct VWAP value.
- Check how missing M1 history and zero-volume candles affect VWAP.
- Confirm that the entry conditions match the intended strategy definition.
- Review order placement, stop-loss, take-profit, break-even, and trailing-stop behavior.

Do not change trading parameters during this verification phase.

### Phase 2 — Inspect Baseline Trade Behavior

- Review the distribution of BUY and SELL trades.
- Analyze results by day and trading session.
- Identify whether losses cluster during strong directional moves or other market conditions.
- Inspect holding time and exit reasons.
- Compare entry-to-VWAP distance with subsequent price movement.

### Phase 3 — Controlled Entry Research

Change one variable at a time and record each experiment separately.

1. **Rejection Buffer:** Test values around the baseline of 0 points.
2. **Candle Confirmation:** Compare the existing bullish/bearish candle requirement with clearly defined alternative confirmation rules.
3. **VWAP Interaction:** Compare the current touch-and-close conditions with explicitly documented alternative interpretations.
4. **BUY vs. SELL:** Test each direction separately before evaluating a combined strategy.
5. **Time Filter:** Evaluate trading sessions without changing other variables.
6. **Market Regime:** Assess behavior in trending and ranging conditions.

Record tested values and results before choosing the next experiment. Do not assume any change will improve performance.

### Phase 4 — Exit Management

Only after the entry behavior is understood, test:

- Stop Loss and Take Profit.
- Break-even trigger and offset.
- Trailing-stop activation and distance.
- Fixed exits versus the existing management rules.

Keep entry logic fixed while evaluating each exit variable.

### Phase 5 — Validation

If a revised configuration shows improvement:

1. Preserve the original baseline.
2. Use a separate in-sample period for research.
3. Test on an unseen out-of-sample period.
4. Run walk-forward and robustness tests.
5. Evaluate spread, slippage, and execution sensitivity.
6. Conduct forward testing before considering live deployment.

## 4. Experiment Log

| Experiment | Variable | Status |
|---|---|---|
| `EA108-M1-BASELINE-001` | Original implementation and inputs | Completed — FAIL |
| `EA108-EXP-002` | VWAP calculation and signal verification | Pending |
| `EA108-EXP-003` | Rejection buffer | Pending |
| `EA108-EXP-004` | Candle confirmation | Pending |
| `EA108-EXP-005` | BUY/SELL directional analysis | Pending |
| `EA108-EXP-006` | Session and market-regime analysis | Pending |
| `EA108-EXP-007` | Exit management | Pending |
| `EA108-EXP-008` | Out-of-sample and robustness validation | Pending |

These experiment IDs are proposed tracking labels; no results are claimed for experiments that have not been run.

## 5. Research Rules

- Change one main variable per experiment.
- Preserve the baseline source code and report.
- Record every input setting and test period.
- Evaluate net profit, Profit Factor, equity drawdown, trade count, and directional performance together.
- Do not select a configuration based on net profit alone.
- Avoid choosing parameters solely because they fit the baseline test period.

## 6. Current Conclusion

The original EA-108 configuration **FAILS** the baseline test. The next priority is implementation verification and diagnosis, not broad optimization.

The EA remains a research project and is not validated for live trading.
