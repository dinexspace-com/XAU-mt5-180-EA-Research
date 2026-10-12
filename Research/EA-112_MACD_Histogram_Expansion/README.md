# EA-112 — MACD Histogram Expansion Research

## 1. Research Objective

Investigate whether MACD histogram expansion provides a useful directional entry signal for XAUUSD on M1.

The first objective is to understand the baseline failure before changing parameters or adding filters.

**Baseline ID:** `EA112-M1-BASELINE-001`  
**Research Status:** IN PROGRESS  
**Baseline Classification:** FAIL

## 2. Baseline Findings

The initial test covered 2026-01-02 to 2026-04-01 using 100% real ticks.

| Metric | Baseline |
|---|---:|
| Net Profit | -$993.33 |
| Profit Factor | 0.80 |
| Max Equity Drawdown | 99.33% |
| Total Trades | 3,918 |
| Win Rate | 47.96% |
| Average Profit Trade | $2.09 |
| Average Loss Trade | -$2.41 |
| BUY Win Rate | 49.03% |
| SELL Win Rate | 47.00% |

The EA loses money despite a win rate close to 48%. The average loss is larger than the average win, while the account experiences near-total equity drawdown.

These results do not support proceeding directly to live trading or broad parameter optimization.

## 3. Strategy Under Investigation

The EA uses MACD settings:

- Fast EMA: 12
- Slow EMA: 26
- Signal Period: 9

The signal is based on the MACD main line minus the signal line, evaluated across three closed candles.

### BUY hypothesis

The histogram is above zero and has increased across the checked candles.

### SELL hypothesis

The histogram is below zero and has decreased further into negative territory across the checked candles.

These rules identify histogram expansion, but the baseline does not establish that this expansion predicts a profitable subsequent move.

## 4. Research Questions

1. Does the EA evaluate the intended closed candles correctly?
2. Are BUY and SELL signals behaving as specified?
3. Does histogram expansion provide sufficient follow-through after entry?
4. Are entries occurring too frequently in choppy market conditions?
5. Does the break-even and trailing-stop configuration reduce winners prematurely?
6. Is performance materially different between BUY and SELL trades?
7. Do spread and transaction costs materially affect the result?

## 5. Experiment Plan

### Phase A — Signal Verification

- Verify MACD buffer indexing and the exact candle shifts used.
- Confirm that the signal is based on closed candles, not the current forming candle.
- Inspect sample BUY and SELL signals against the chart.
- Record signal time, histogram values, direction, entry price, and subsequent price movement.

### Phase B — Trade Outcome Analysis

- Compare BUY and SELL results separately.
- Measure outcomes after entry over predefined horizons.
- Examine maximum favorable excursion (MFE) and maximum adverse excursion (MAE), where data is available.
- Investigate rapid reversals and repeated entries.

### Phase C — Controlled Experiments

After signal verification, test one variable at a time:

- Histogram expansion requirements.
- Entry confirmation or trend filters.
- Break-even settings.
- Trailing-stop settings.
- Stop-loss and take-profit settings.
- Trading-session filters.

Do not change multiple independent factors in one experiment because that makes attribution difficult.

### Phase D — Validation

Any promising configuration must be evaluated on a separate out-of-sample period, followed by robustness and forward testing. A better result on the original test period alone is not sufficient evidence of a durable edge.

## 6. Experiment Log

| Experiment | Change | Result | Status |
|---|---|---|---|
| `EA112-M1-BASELINE-001` | Original EA settings | Net Profit -$993.33; PF 0.80; Equity DD 99.33% | FAIL |
| Next | Verify signal indexing and chart alignment | Pending | Not started |
| Next | Analyze BUY versus SELL | Pending | Not started |
| Next | Evaluate exit management independently | Pending | Not started |

## 7. Research Decision

**Current decision: investigate the signal and trade behavior before optimizing parameters.**

The EA is not validated for live trading. Preserve the original code and baseline report as reference artifacts. Store every subsequent experiment separately with its configuration, test period, report, and conclusion.
