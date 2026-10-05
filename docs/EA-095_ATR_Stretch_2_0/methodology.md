# EA-095 Research Methodology

## 1. Purpose

This document defines the methodology used to research and evaluate EA-095_ATR_Stretch_2_0.

The purpose is to determine whether the strategy contains a repeatable trading edge while minimizing overfitting and uncontrolled parameter optimization.

---

## 2. Baseline Principle

The first experiment is the unchanged baseline:

`EA095-M1-BASELINE-001`

The baseline is the permanent reference point for subsequent research.

No future modification should overwrite or replace the baseline.

---

## 3. Controlled Experiment Principle

Each research experiment should change only one major strategy component.

Example:

```text
Baseline
   ↓
Change Timeframe only
   ↓
Compare Results
```

The following experiment should not simultaneously change:

* timeframe;
* ATR multiplier;
* SL;
* TP;
* trailing stop;
* spread;
* entry rules.

Changing multiple components simultaneously makes it difficult to determine which component caused the performance change.

---

## 4. Research Order

Research should follow this sequence:

### Stage 1 — Timeframe

Evaluate the strategy across suitable timeframes while keeping the entry logic and risk model unchanged.

Objective:

Determine whether the ATR Stretch hypothesis behaves differently across market sampling frequencies.

---

### Stage 2 — ATR Multiplier

Evaluate the ATR stretch threshold.

The baseline is:

`ATR(14) × 2.0`

The purpose is to determine whether the strategy requires a different definition of an extreme price extension.

Only the ATR multiplier should be changed during this stage.

---

### Stage 3 — Entry Confirmation

Evaluate whether the current recovery-candle confirmation contributes positively to the strategy.

The baseline confirmation consists of:

### BUY

* Previous candle closes below EMA - ATR × Multiplier.
* Current closed candle is bullish.
* Current close is above the previous close.
* Current close remains below EMA.

### SELL

* Previous candle closes above EMA + ATR × Multiplier.
* Current closed candle is bearish.
* Current close is below the previous close.
* Current close remains above EMA.

Potential future tests should isolate individual confirmation components rather than changing the entire entry system simultaneously.

---

### Stage 4 — Trading Session

Evaluate whether performance is concentrated in specific market sessions or hours.

The objective is to determine whether the strategy's edge, if any, is dependent on a particular trading period.

---

### Stage 5 — Directional Analysis

Evaluate BUY and SELL trades independently.

The baseline report contains separate BUY and SELL trade statistics.

The research should determine whether one direction contributes disproportionately to the result.

---

### Stage 6 — Exit Management

Evaluate the effect of:

* Stop Loss;
* Take Profit;
* Break Even;
* Trailing Stop.

Exit parameters should be tested separately from entry logic whenever possible.

---

## 5. Performance Metrics

Every experiment should record at minimum:

* Net Profit
* Profit Factor
* Expected Payoff
* Maximum Equity Drawdown
* Total Trades
* Profit Trades %
* Loss Trades %
* Average Profit Trade
* Average Loss Trade
* Maximum Consecutive Wins
* Maximum Consecutive Losses
* Sharpe Ratio
* Recovery Factor

The baseline values should remain visible for comparison.

---

## 6. Statistical Discipline

A profitable result from a single historical period should not automatically be treated as proof of a trading edge.

Research should distinguish between:

```text
In-Sample Discovery
        ↓
Independent Validation
        ↓
Robustness Testing
        ↓
Forward Testing
```

The objective is to determine whether performance survives changes in historical period, market conditions, and reasonable parameter variation.

---

## 7. Optimization Policy

Broad optimization should remain blocked during the early research stage.

Optimization should only be considered after controlled experiments identify which strategy components appear to have meaningful influence on performance.

The objective is not to find the single best historical parameter combination.

The objective is to identify a robust parameter region that behaves consistently.

---

## 8. Out-of-Sample Testing

Once a candidate configuration is identified, it should be tested on historical data that was not used to discover the configuration.

The out-of-sample test must use the finalized candidate parameters without further adjustment.

If the strategy fails out-of-sample, the candidate should not be considered validated.

---

## 9. Robustness Testing

Robustness testing should examine whether the strategy remains viable when reasonable changes are applied.

Examples include:

* small changes to ATR multiplier;
* small changes to EMA period;
* different historical periods;
* different execution conditions;
* reasonable spread variations;
* BUY/SELL asymmetry.

A strategy that only works at one exact parameter value should be treated with caution.

---

## 10. Forward Testing

Forward testing should only begin after:

1. baseline research is completed;
2. a candidate configuration has been identified;
3. out-of-sample testing has been completed;
4. robustness testing provides acceptable evidence.

Forward testing should be treated as a separate validation stage.

---

## 11. Production Readiness

EA-095_ATR_Stretch_2_0 should only be considered for production after the research process provides evidence of:

* positive expectancy;
* acceptable drawdown;
* stable performance;
* sufficient trade sample;
* out-of-sample consistency;
* robustness;
* and successful forward testing.

The current baseline does **not** meet this standard.

---

## 12. Current Baseline Reference

```text
Experiment ID : EA095-M1-BASELINE-001
Symbol        : XAUUSD.PRO
Timeframe     : M1
Period        : 2026.01.02 – 2026.03.31
Initial Fund  : $1,000
Lot           : 0.01
EMA           : 20
ATR           : 14
ATR Multiplier: 2.0
SL            : 300 points
TP            : 600 points
BE            : 150 points
Trailing      : Start 200 / Distance 100 / Step 10
Max Spread    : 30 points
```

Baseline result:

```text
Net Profit            : -$330.84
Profit Factor         : 0.95
Expected Payoff       : -$0.07
Maximum Equity DD     : 48.57%
Total Trades          : 4,971
Win Rate              : 50.65%
Classification        : FAIL
Production Ready      : NO
```

The baseline must remain unchanged and serve as the reference for all future EA-095 research.
