# XAUUSD MT5 EA Research

## EA-015 — EMA20 Slope

### Research Question

Can a simple EMA20 slope-based trend-following strategy produce a viable trading edge on **XAUUSD M1**?

The strategy tests the hypothesis that short-term EMA direction, combined with price position relative to EMA20, can identify sufficiently persistent intraday momentum to generate positive expectancy.

---

## Strategy Hypothesis

The underlying idea is simple:

* Rising EMA20 indicates short-term bullish momentum.
* Falling EMA20 indicates short-term bearish momentum.
* Price closing above EMA20 confirms BUY conditions.
* Price closing below EMA20 confirms SELL conditions.
* Requiring multiple consecutive EMA movements may filter weak or noisy signals.

The EA therefore attempts to capture short-term directional continuation rather than predict market reversals.

---

## Implementation

EA:

`EA-015_EMA20_Slope`

Primary research market:

`XAUUSD`

Primary timeframe:

`M1`

Signal:

**BUY**

`EMA20 rising AND Close > EMA20`

**SELL**

`EMA20 falling AND Close < EMA20`

The implementation evaluates completed candles and limits entry evaluation to a new bar.

---

# Experiment 01

## Objective

Test whether EMA20 directional persistence alone provides sufficient edge on XAUUSD M1 using fixed SL/TP trade management.

---

## Configuration

| Parameter              |                   Value |
| ---------------------- | ----------------------: |
| Symbol                 |              XAUUSD.PRO |
| Timeframe              |                      M1 |
| Period                 | 2026.01.02 – 2026.04.01 |
| EMA Period             |                      20 |
| Minimum EMA Trend Bars |                       3 |
| Stop Loss              |              300 points |
| Take Profit            |              600 points |
| Lot Size               |                    0.01 |
| Maximum Spread         |               30 points |
| Break Even             |                     OFF |
| Trailing Stop          |                     OFF |
| Initial Deposit        |                  $1,000 |
| Leverage               |                   1:500 |
| Tick Quality           |         100% real ticks |

This experiment specifically tests:

`EMA20 + 3-bar directional persistence + fixed SL/TP`

It does **not** test the Break Even or Trailing Stop components.

---

## Results

| Metric                   |       Result |
| ------------------------ | -----------: |
| Total Trades             |        3,508 |
| Winning Trades           |        1,074 |
| Losing Trades            |        2,434 |
| Win Rate                 |       30.62% |
| Net Profit               | **-$992.93** |
| Profit Factor            |     **0.87** |
| Expected Payoff          |   **-$0.28** |
| Sharpe Ratio             |    **-5.00** |
| Recovery Factor          |    **-0.96** |
| Maximum Balance Drawdown |   **99.32%** |
| Maximum Equity Drawdown  |   **99.32%** |

### Directional Results

| Direction | Trades | Win Rate |
| --------- | -----: | -------: |
| BUY       |  1,805 |   33.30% |
| SELL      |  1,703 |   27.77% |

BUY signals performed better than SELL signals by win rate, but neither direction was sufficient to make the complete strategy profitable.

---

# Research Finding

## Experiment 01: FAIL

The tested configuration does not demonstrate a viable trading edge.

The strongest evidence is:

* Profit Factor below 1.0.
* Negative Expected Payoff.
* Negative Net Profit.
* Negative Sharpe Ratio.
* Approximately 99% drawdown.
* Persistent deterioration of the balance curve.
* 69.38% of trades were losses.

The result is based on a relatively large sample of **3,508 trades**, so the failure cannot be attributed merely to a handful of isolated trades.

---

# Interpretation

The current evidence suggests that **EMA20 directional persistence by itself is insufficient to filter market noise on XAUUSD M1** under the tested configuration.

The strategy generated a large number of entries, but the aggregate result remained negative.

This indicates that identifying EMA direction alone does not necessarily distinguish between:

* genuine directional continuation;
* short-lived momentum;
* sideways market noise;
* repeated entries during unstable price movement.

The balance curve supports this interpretation because losses accumulated persistently rather than being caused by one isolated event.

---

# BUY vs SELL Observation

There is a measurable directional difference:

`BUY Win Rate = 33.30%`

`SELL Win Rate = 27.77%`

This does **not** establish that BUY-only trading is profitable.

However, it identifies a valid research question for a later experiment:

> Does removing or filtering SELL signals materially improve the strategy?

This hypothesis requires a separate backtest before any conclusion can be made.

---

# Risk Management Observation

Experiment 01 had:

`Break Even = OFF`

`Trailing Stop = OFF`

Therefore, this experiment cannot determine whether Break Even or Trailing Stop improves the strategy.

These mechanisms should not be credited or blamed for Experiment 01's result.

They require independent testing.

---

# Current Research Conclusion

### What has been rejected

The following configuration is currently rejected:

`EMA20 / 3 trend bars / XAUUSD M1 / fixed SL300 / TP600`

### What has NOT been rejected

The following questions remain open:

* Different EMA persistence requirements.
* BUY-only configuration.
* SELL filtering.
* Break Even management.
* Trailing Stop management.
* Additional market-regime filters.

No claim should be made about these variants until they are independently tested.

---

# Research Status

| Experiment | Configuration                      | Result   |
| ---------- | ---------------------------------- | -------- |
| 01         | EMA20 + 3 trend bars + SL300/TP600 | **FAIL** |

**EA-015 overall research status: IN PROGRESS**

Experiment 01 has failed.

The EA family itself is not yet marked PASS or FAIL because only one defined configuration has been evaluated.

---

# Evidence

Implementation:

`EAs/EA-015_EMA20_Slope/`

Backtest evidence:

`Backtest/EA-015_EMA20_Slope/`

The original MetaTrader 5 Strategy Tester HTML report is the primary numerical evidence for Experiment 01.

All future experiments must preserve:

1. Exact test parameters.
2. Original Strategy Tester report.
3. Test period.
4. Data/tick quality.
5. Performance metrics.
6. Explicit PASS/FAIL result.

Research conclusions must not be changed without corresponding backtest evidence.
