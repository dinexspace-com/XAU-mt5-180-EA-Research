# Research — EA-037 MACD Fifth Element

## Research Overview

This document tracks the research process for **EA-037 — MACD Fifth Element** on XAUUSD.

The strategy tests whether four completed MACD histogram bars of the same sign identify momentum continuation that remains exploitable at the opening of the fifth bar.

## Research Status

- **Current Research Status:** `IN PROGRESS`
- **Baseline status:** `COMPLETED — FAIL`
- **Variant status:** `COMPLETED — FAIL / UNACCEPTABLE RISK`
- **Optimization status:** `BLOCKED — robustness work required before optimization`
- **Live trading:** `NOT APPROVED`

## Core Hypothesis

MACD parameters are 12/26/9. Four positive closed histogram bars produce a BUY evaluation at the fifth bar; four negative bars produce a SELL evaluation.

The implementation evaluates two stop hypotheses:

1. Price extreme of the immediately preceding opposite-sign MACD wave.
2. ATR(14) × 2.0 as a controlled sensitivity comparison.

Trade management uses partial profit at 1R, final target at 2R and optional break-even movement after TP1. Position size is calculated from equity risk and actual broker tick value.

## Test Matrix

| Experiment | Timeframe | Stop model | Net profit | Profit Factor | Equity DD | Verdict |
|---|---:|---|---:|---:|---:|---|
| Baseline | M15 | Previous opposite MACD wave | -$1,711.25 | 0.99 | 83.29% | FAIL |
| Variant A | M15 | ATR(14) × 2.0 | +$285,980.94 | 1.17 | 88.72% | FAIL — risk/compounding distortion |
| Robustness | H1 | Previous opposite MACD wave | +$470.85 | 1.02 | 52.46% | FAIL — weak edge/high DD |
| Robustness | H1 | ATR(14) × 2.0 | +$4,916.80 | 1.06 | 68.34% | FAIL — excessive DD |

Test period: 2026-01-02 to 2026-08-30. Initial deposit: USD 10,000. The current reports use M1 OHLC because complete real-tick history was unavailable in the connected MetaQuotes demo environment.

## Findings

1. The M15 wave-stop baseline does not show positive expectancy.
2. Results are highly sensitive to stop model and timeframe.
3. Positive nominal profit is not sufficient: every tested variant breaches a reasonable drawdown ceiling.
4. Percentage-of-equity sizing causes strong compounding and makes the ATR M15 nominal profit unsuitable for direct comparison without exposure normalization.
5. No tested configuration is eligible for deployment.

## Research Questions

- **RQ-01 — Exposure normalization:** Compare fixed-lot and capped fractional-risk sizing.
- **RQ-02 — Data quality:** Repeat all experiments using complete real ticks and realistic trading costs.
- **RQ-03 — Directionality:** Evaluate BUY-only, SELL-only and combined signals.
- **RQ-04 — Timeframe stability:** Compare M15, M30, H1 and H4 without choosing solely by in-sample profit.
- **RQ-05 — Stop robustness:** Test stable neighborhoods around wave and ATR stops.
- **RQ-06 — Exit robustness:** Isolate TP1, break-even and TP2 behavior one change at a time.
- **RQ-07 — Market regime:** Evaluate trend, volatility and session conditioning.
- **RQ-08 — Validation:** Use fixed in-sample/out-of-sample periods and walk-forward analysis.

## Research Sequence

```text
Technical baseline
    ↓
Normalize exposure and costs
    ↓
Complete real-tick retest
    ↓
Direction/timeframe/stop experiments
    ↓
Parameter-neighborhood stability
    ↓
Out-of-sample validation
    ↓
Walk-forward test
    ↓
Forward demo test
```

## Acceptance Policy

A run must not pass based only on positive net profit. Evaluation must include Profit Factor, expected payoff, maximum drawdown, Sharpe ratio, trade count, cost sensitivity, parameter stability and out-of-sample performance.

Before optimization, define a maximum drawdown ceiling and reject every run that violates it. Optimization must not search for a single historical maximum.

## Checklist

- [x] Strategy code documented
- [x] EA compiled successfully
- [x] M15 wave-stop baseline completed
- [x] M15 ATR sensitivity run completed
- [x] H1 wave-stop robustness run completed
- [x] H1 ATR robustness run completed
- [x] Reports and reproduction configurations preserved
- [x] Current variants classified as FAIL / research only
- [ ] Complete real-tick retest
- [ ] Exposure-normalized comparison
- [ ] In-sample/out-of-sample split
- [ ] Walk-forward analysis
- [ ] Forward demo test
- [ ] Live deployment approval

## Repository References

```text
EAs/EA-037_MACD_Fifth_Element/
Backtest/EA-037_MACD_Fifth_Element/
Research/EA-037_MACD_Fifth_Element/
docs/methodology.md
GitHub_Profile/README.md
```

## Disclaimer

This repository documents quantitative strategy research. Historical or simulated performance does not guarantee future results. EA-037 is not approved for live trading and is not financial advice.
