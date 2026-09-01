# EA-037 — MACD Fifth Element — Methodology

## Purpose

This document defines the reproducible research methodology for EA-037. It separates source-derived signal rules from engineering choices and prevents a profitable in-sample run from being treated as deployment evidence.

## Signal Specification

- Indicator: MACD 12/26/9 histogram.
- Confirmation: four completed histogram bars with the same sign.
- Entry evaluation: opening of the fifth bar.
- Positive sequence: BUY.
- Negative sequence: SELL.

## Engineering Specification

- Primary stop: price extreme of the immediately preceding opposite-sign histogram wave.
- Sensitivity stop: ATR(14) × 2.0.
- TP1: 1R with 50% partial close.
- TP2: 2R on the remaining volume.
- Break even: move the remaining position to entry after TP1.
- Default sizing: 1% equity risk calculated from stop distance and broker tick value.
- Execution controls: spread limit, deviation limit, one managed position per symbol and Magic Number.

These engineering decisions are testable implementation choices. They must not be presented as rules proven by the source material.

## Completed Experiments

| Test | Timeframe | Stop | Net profit | PF | Equity DD | Status |
|---|---:|---|---:|---:|---:|---|
| Baseline | M15 | Previous opposite wave | -$1,711.25 | 0.99 | 83.29% | FAIL |
| Sensitivity | M15 | ATR(14) × 2.0 | +$285,980.94 | 1.17 | 88.72% | FAIL |
| Robustness | H1 | Previous opposite wave | +$470.85 | 1.02 | 52.46% | FAIL |
| Robustness | H1 | ATR(14) × 2.0 | +$4,916.80 | 1.06 | 68.34% | FAIL |

All four runs use the 2026-01-02 to 2026-08-30 period with an initial USD 10,000 deposit. The recorded reports use M1 OHLC because complete real-tick history was unavailable in the connected test environment.

## Evaluation Rule

Positive net profit alone is insufficient. A candidate must be evaluated using Profit Factor, expected payoff, maximum drawdown, Sharpe ratio, trade count, exposure consistency, transaction-cost sensitivity, parameter-neighborhood stability and out-of-sample performance.

Every completed configuration currently fails because expectancy is weak or drawdown is excessive. EA-037 is not approved for live trading.

## Controlled Research Sequence

1. Normalize exposure across wave and ATR stop models.
2. Repeat with complete real-tick history and realistic costs.
3. Compare BUY-only, SELL-only and combined directions.
4. Test timeframe stability without selecting only the best historical result.
5. Isolate stop and exit changes one variable at a time.
6. Evaluate stable parameter neighborhoods.
7. Use fixed in-sample and out-of-sample periods.
8. Run walk-forward and forward-demo validation.

Broad optimization remains blocked until the above sequence produces a stable positive edge within a predefined drawdown ceiling.

## Evidence Locations

```text
EAs/EA-037_MACD_Fifth_Element/
Backtest/EA-037_MACD_Fifth_Element/
Research/EA-037_MACD_Fifth_Element/
docs/EA-037_MACD_Fifth_Element/
```

## Disclaimer

This methodology is for quantitative research and backtesting. Historical or simulated performance does not guarantee future results and is not financial advice.
