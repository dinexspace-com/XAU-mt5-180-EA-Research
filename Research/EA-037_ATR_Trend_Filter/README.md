# XAUUSD MT5 EA Research

## EA-037 — ATR Trend Filter

### Research Objective

EA-037 investigates whether an ATR-based volatility filter can improve a simple EMA crossover trend-following strategy on XAUUSD.

The core research question is:

> Can filtering EMA crossover signals by current market volatility reduce low-quality entries and produce a more robust trend-following strategy for XAUUSD?

---

## Strategy Hypothesis

EMA crossover systems can generate frequent false signals when the market is ranging or volatility is insufficient.

EA-037 introduces an ATR volatility condition:

Current ATR must be greater than its recent average before a new EMA crossover trade is allowed.

The hypothesis is that this filter may remove part of the low-volatility market noise and allow the strategy to participate primarily when market movement is sufficiently active.

---

## Core Strategy

The strategy uses:

- Fast EMA: 20
- Slow EMA: 50
- ATR Period: 14
- ATR Average Period: 50
- ATR volatility filter
- Spread filter
- Fixed Stop Loss
- Fixed Take Profit

### Long Signal

A BUY setup requires:

1. Fast EMA crosses above Slow EMA.
2. Current ATR is greater than Average ATR.
3. Spread is within the configured limit.
4. No existing EA position is open for the symbol.

### Short Signal

A SELL setup requires:

1. Fast EMA crosses below Slow EMA.
2. Current ATR is greater than Average ATR.
3. Spread is within the configured limit.
4. No existing EA position is open for the symbol.

---

## Baseline Backtest

The initial baseline test was performed using:

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 — 2026-03-31 |
| Initial Deposit | $1,000 |
| Lot Size | 0.01 |
| History Quality | 100% real ticks |
| Break Even | Disabled |
| Trailing Stop | Disabled |

### Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 621 |
| Net Profit | -$26.73 |
| Profit Factor | 0.98 |
| Win Rate | 33.17% |
| Maximum Equity Drawdown | 12.39% |
| Sharpe Ratio | -2.24 |
| Expected Payoff | -$0.04 |

---

## Initial Finding

The baseline configuration did not demonstrate a positive trading edge during the tested period.

Profit Factor was below 1.0 and Total Net Profit was negative.

The ATR filter therefore cannot currently be considered sufficient evidence of a profitable XAUUSD strategy in this configuration.

However, this result establishes a baseline for further research.

---

## Research Questions

The next research stages should determine:

1. Whether the ATR filter improves performance compared with the same EMA crossover strategy without the ATR filter.
2. Whether alternative ATR thresholds improve signal quality.
3. Whether the EMA 20/50 combination is appropriate for XAUUSD.
4. Whether performance changes materially across different XAUUSD timeframes.
5. Whether results remain consistent across longer and unseen market periods.
6. Whether trading performance is concentrated in specific market sessions or trading hours.
7. Whether Stop Loss and Take Profit distances are appropriate for XAUUSD volatility.

---

## Validation Requirements

EA-037 should not be considered validated based on a single backtest.

Further research should include:

- Longer historical testing
- Out-of-sample testing
- Parameter sensitivity testing
- Comparison against the strategy without the ATR filter
- Different market regimes
- Spread and execution robustness
- Additional XAUUSD timeframes

Optimization should not be treated as evidence of profitability unless the resulting configuration also performs adequately on unseen data.

---

## Current Research Status

**Status: BASELINE COMPLETED — FURTHER RESEARCH REQUIRED**

The current implementation has:

- Working EA source code
- Defined trading rules
- Initial MT5 real-tick backtest
- Baseline performance metrics

The baseline configuration is currently **not profitable**.

No production-readiness or live-trading claim is made.

---

## Related Files

EA source:

`../EAs/EA-037_ATR_Trend_Filter/`

Backtest evidence:

`../Backtest/EA-037_ATR_Trend_Filter/`

Research methodology:

`../docs/methodology.md`
