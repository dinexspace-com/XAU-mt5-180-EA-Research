
# EA-080 — Impulse Candle Break Research

**Status:** Research in Progress  
**Baseline:** FAIL  
**Independent Validation:** Pending

## Research Objective

Investigate whether ATR-qualified impulse candle breakouts can provide a positive trading edge on XAUUSD M1.

The baseline generated 3,206 trades, with a profit factor of 0.82 and maximum equity drawdown of 79.02%.

## Initial Findings

### F01 — Negative Expectancy

- Win Rate: 47.47%
- Average Win: $2.30
- Average Loss: $2.54
- Expected Payoff: -$0.24

Losing trades outnumbered winning trades, while the average loss exceeded the average win.

### F02 — Trade Management

Break Even and Trailing Stop were both enabled during the baseline test.

Their individual contributions to profitability have not yet been isolated.

### F03 — Directional Performance

BUY achieved a 48.59% win rate versus 46.36% for SELL.

Separate directional testing is required before drawing conclusions about BUY-only or SELL-only performance.

### F04 — Trading Sessions

Trading activity occurred across Asian, European and US sessions.

The effects of session restrictions remain untested.

### F05 — Impulse Confirmation

The baseline used:

- ATR Period: 14
- ATR Multiplier: 1.5
- Minimum Body Ratio: 0.70
- Maximum Impulse Age: 20 bars

Alternative impulse qualifications require controlled testing.

## Research Experiments

- [ ] H1 — Isolate Break Even and Trailing Stop effects.
- [ ] H2 — Compare BUY-only and SELL-only results.
- [ ] H3 — Analyze trading-session performance.
- [ ] H4 — Optimize ATR multiplier and body ratio.
- [ ] H5 — Investigate impulse expiration and breakout buffer.
- [ ] H6 — Validate promising configurations on independent data.

## Research Acceptance Criteria

| Criterion | Requirement |
|---|---|
| Total Trades | > 200 |
| Net Profit | > $0 |
| Maximum Equity Drawdown | < 20% |
| Independent Validation | Required |
| Human Approval | Required |

These are research screening criteria, not guarantees of future performance.

## Next Experiment

H1 — Compare four configurations:

1. Break Even OFF / Trailing Stop OFF
2. Break Even ON / Trailing Stop OFF
3. Break Even OFF / Trailing Stop ON
4. Break Even ON / Trailing Stop ON

Keep all other parameters and the testing period unchanged.

Retain all reports and compare them against the original baseline.

## Current Conclusion

EA-080 remains experimental. The baseline failed profitability and drawdown requirements, and no optimized configuration has been independently validated.
