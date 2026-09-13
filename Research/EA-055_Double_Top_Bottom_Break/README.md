# Research — XAUUSD MT5 EA

This directory contains the research records for the Expert Advisors developed in this repository.

The purpose of the research layer is to document the trading hypothesis behind each EA, connect that hypothesis to an implemented MQL5 strategy, and preserve the relationship between research, source code and empirical backtest results.

---

# EA-055 — Double Top / Bottom Break

## Research Status

| Item | Status |
|---|---|
| EA ID | `EA-055` |
| Strategy | `Double Top / Double Bottom Breakout` |
| Market | `XAUUSD` |
| Platform | `MetaTrader 5` |
| Implementation | `Completed` |
| Baseline Backtest | `Completed` |
| Baseline Result | **FAIL** |
| Production Ready | **NO** |

---

## Research Hypothesis

EA-055 investigates whether classical Double Top and Double Bottom reversal structures can be converted into objective rules suitable for automated trading.

The core hypothesis is:

> When price forms two comparable swing extremes and subsequently closes beyond the neckline separating those extremes, the breakout may indicate a sufficiently strong reversal to justify entering in the breakout direction.

The strategy therefore does not enter simply because two tops or two bottoms exist.

A completed pattern requires confirmation through a neckline breakout.

---

## Pattern Definition

### Double Top

A Double Top consists of:

1. A first Swing High.
2. A pullback from that high.
3. A second Swing High near the price level of the first high.
4. A neckline defined by the lowest price between the two highs.
5. A confirmed break below the neckline.

The expected market interpretation is a potential transition from upward pressure toward downward movement.

The EA therefore looks for a **SELL** opportunity after confirmed downside breakout.

---

## Double Bottom

A Double Bottom consists of:

1. A first Swing Low.
2. A rebound from that low.
3. A second Swing Low near the price level of the first low.
4. A neckline defined by the highest price between the two lows.
5. A confirmed break above the neckline.

The expected market interpretation is a potential transition from downward pressure toward upward movement.

The EA therefore looks for a **BUY** opportunity after confirmed upside breakout.

---

## Automated Strategy Translation

The discretionary chart pattern is converted into measurable rules so that the strategy can be reproduced by an Expert Advisor.

The implementation uses the following concepts:

| Component | Automated Rule |
|---|---|
| Swing detection | Local Swing High / Swing Low |
| Pattern similarity | Maximum price tolerance between two tops/bottoms |
| Minimum pattern width | Minimum number of bars between two swings |
| Maximum pattern width | Maximum number of bars between two swings |
| Double Top neckline | Lowest Low between the two tops |
| Double Bottom neckline | Highest High between the two bottoms |
| Confirmation | Closed candle breakout |
| Entry | Breakout direction |
| Risk control | Stop Loss |
| Profit target | Take Profit |
| Trade management | Break Even + Trailing Stop |
| Execution filter | Maximum Spread |

---

## Entry Logic

### SELL — Double Top Breakout

A SELL signal requires:

- Two valid Swing Highs.
- Both highs within the configured pattern tolerance.
- Distance between the highs within the allowed pattern width.
- A valid neckline between the highs.
- Previous candle not already below the breakout level.
- Latest closed candle below the breakout level.

Conceptually:

    Double Top
        ↓
    Identify two Swing Highs
        ↓
    Validate price similarity
        ↓
    Find lowest Low between highs
        ↓
    Define neckline
        ↓
    Wait for closed candle below neckline
        ↓
    SELL

---

## BUY — Double Bottom Breakout

A BUY signal requires:

- Two valid Swing Lows.
- Both lows within the configured pattern tolerance.
- Distance between the lows within the allowed pattern width.
- A valid neckline between the lows.
- Previous candle not already above the breakout level.
- Latest closed candle above the breakout level.

Conceptually:

    Double Bottom
        ↓
    Identify two Swing Lows
        ↓
    Validate price similarity
        ↓
    Find highest High between lows
        ↓
    Define neckline
        ↓
    Wait for closed candle above neckline
        ↓
    BUY

---

## Baseline Implementation

The initial implementation uses the following strategy parameters:

| Parameter | Baseline |
|---|---:|
| Lookback Bars | `100` |
| Swing Strength | `2` |
| Minimum Pattern Bars | `5` |
| Maximum Pattern Bars | `60` |
| Pattern Tolerance | `100 points` |
| Breakout Buffer | `0` |
| Maximum Spread | `30 points` |

Trade management:

| Parameter | Baseline |
|---|---:|
| Fixed Lot | `0.01` |
| Stop Loss | `300 points` |
| Take Profit | `600 points` |
| Break Even | `Enabled` |
| Break Even Trigger | `150 points` |
| Break Even Offset | `0` |
| Trailing Stop | `Enabled` |
| Trailing Start | `200 points` |
| Trailing Distance | `150 points` |

These parameters represent the baseline implementation and should not be interpreted as optimized parameters.

---

## Baseline Experiment

The first recorded test was performed using:

| Parameter | Value |
|---|---|
| Symbol | `XAUUSD.PRO` |
| Timeframe | `M1` |
| Period | `2026-01-02 → 2026-04-01` |
| Initial Deposit | `$1,000` |
| Leverage | `1:500` |
| Fixed Lot | `0.01` |
| Tick Quality | `100% real ticks` |

---

## Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | **-$489.98** |
| Profit Factor | **0.86** |
| Expected Payoff | **-$0.18** |
| Recovery Factor | **-0.89** |
| Sharpe Ratio | **-5.00** |
| Total Trades | `2,719` |
| Winning Trades | `47.74%` |
| Losing Trades | `52.26%` |
| Short Win Rate | `48.03%` |
| Long Win Rate | `47.41%` |
| Average Winning Trade | `$2.26` |
| Average Losing Trade | `-$2.41` |
| Maximum Balance Drawdown | `52.07%` |
| Maximum Equity Drawdown | **52.16%** |

---

## Baseline Finding

**Baseline Result: FAIL**

The first implementation did not demonstrate a profitable edge under the tested conditions.

Three important observations are visible in the baseline result:

1. Win rate was below 50%.
2. Average loss (`$2.41`) exceeded average win (`$2.26`).
3. The combination produced a Profit Factor of only `0.86`.

The result was therefore negative despite the strategy generating a large sample of `2,719` trades.

Maximum Equity Drawdown of `52.16%` is also too high for this configuration to be considered suitable for deployment.

---

## Research Interpretation

The baseline result rejects the **current implementation and parameter configuration** for the tested XAUUSD.PRO M1 period.

It does **not** establish that every possible Double Top / Double Bottom breakout implementation is unprofitable.

Several components are combined in this baseline:

- Swing detection.
- Pattern tolerance.
- Pattern width.
- Neckline definition.
- Breakout confirmation.
- Stop Loss.
- Take Profit.
- Break Even.
- Trailing Stop.
- Spread filter.

The baseline test evaluates the combined system.

It does not independently establish which individual component is responsible for the negative expectancy.

Therefore, future experiments should change controlled components and compare their results against this baseline rather than treating parameter optimization alone as proof of a trading edge.

---

## Research Questions

The baseline creates several questions for future testing:

- Is `M1` too noisy for this pattern?
- Does increasing Swing Strength improve pattern quality?
- Is the current Pattern Tolerance too permissive?
- Is a breakout buffer required to reduce false breakouts?
- Does increasing the minimum distance between the two tops/bottoms improve pattern quality?
- Should breakout confirmation require additional market structure confirmation?
- Does the strategy perform differently during specific trading sessions?
- Do BUY and SELL patterns have materially different expectancy?
- Does disabling Break Even improve or reduce expectancy?
- Does disabling Trailing Stop improve or reduce expectancy?
- Are fixed SL/TP distances appropriate for changing XAUUSD volatility?
- Would volatility-adjusted exits produce more stable behavior?

These are research questions only and are not claims that the corresponding changes will improve performance.

---

## Research Method

Future development should follow:

    Hypothesis
        ↓
    Define measurable trading rules
        ↓
    Implement rules in MQL5
        ↓
    Compile and verify execution
        ↓
    Run baseline backtest
        ↓
    Preserve original artifacts
        ↓
    Analyze results
        ↓
    Define one controlled modification
        ↓
    Backtest again
        ↓
    Compare against baseline
        ↓
    Accept or reject modification

Failed experiments must be retained.

This prevents survivorship bias from keeping only successful configurations.

---

## Evidence Structure

EA-055 is documented across three repository layers:

    Research/
    └── README.md
            │
            │ Trading hypothesis
            │
            ▼
    EAs/
    └── EA-055_Double_Top_Bottom_Break/
        ├── EA-055_Double_Top_Bottom_Break.mq5
        └── README.md
            │
            │ Implementation
            │
            ▼
    Backtest/
    └── EA-055_Double_Top_Bottom_Break/
        ├── README.md
        ├── MT5 Strategy Tester Report
        └── Backtest charts

The roles are separated intentionally:

**Research** documents why the strategy is being investigated.

**EAs** contains what was actually implemented.

**Backtest** contains what happened when that implementation was tested.

---

## Current Conclusion

EA-055 has successfully reached the stage where the trading hypothesis has been converted into executable MQL5 rules and tested using real-tick historical data.

However, the first baseline configuration failed profitability and risk criteria.

Current research state:

| Stage | Status |
|---|---|
| Strategy hypothesis | `DONE` |
| Rule definition | `DONE` |
| MQL5 implementation | `DONE` |
| Compilation | `DONE` |
| Baseline backtest | `DONE` |
| Baseline evidence | `RECORDED` |
| Baseline profitability | `FAIL` |
| Optimization / modification | `NOT VALIDATED` |
| Robustness testing | `NOT STARTED` |
| Forward testing | `NOT STARTED` |
| Production approval | `NO` |

**EA-055 remains a research EA and must not be classified as production-ready based on the current evidence.**

---

## Source Material

No external research source is documented in this repository entry yet.

The current research record is based on the defined Double Top / Double Bottom strategy hypothesis, its MQL5 implementation, and the recorded MT5 baseline experiment.

External books, papers, articles or other research materials should only be added here when the exact source used for EA-055 has been identified and preserved.

---

## Repository

Project:

**XAUUSD MT5 EA Research**

EA:

**EA-055_Double_Top_Bottom_Break**

Platform:

**MetaTrader 5 / MQL5**

Research status:

**BASELINE TESTED — FAIL — FURTHER RESEARCH REQUIRED**
