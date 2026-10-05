# EA-098 — Large Candle Reversal Research

## Research Objective

The objective of EA-098 research is to determine whether large-candle exhaustion followed by midpoint reversal confirmation provides a repeatable short-term reversal edge on XAUUSD.

The baseline result is negative:

* Net Profit: **-$114.76**
* Profit Factor: **0.86**
* Expected Payoff: **-$0.18**
* Max Equity Drawdown: **13.22%**
* Total Trades: **646**

The baseline therefore does not qualify as a profitable trading configuration.

However, the result does not establish that the broader Large Candle Reversal hypothesis has no edge. It establishes only that the current implementation and baseline configuration failed under the documented test conditions.

## Baseline Experiment

**Experiment ID:** `EA098-M1-BASELINE-001`

**Baseline:**

```text
XAUUSD.PRO
M1
ATR Period = 14
Large Candle ATR = 2.0
SL = 300
TP = 600
Lot = 0.01
Maximum Spread = 30
Break Even = ON
Trailing Stop = ON
```

## Primary Research Questions

### EA098-RQ01 — Large Candle Threshold

Evaluate whether the reversal behavior changes when the large-candle threshold is modified.

Suggested controlled values:

```text
1.5 ATR
1.75 ATR
2.0 ATR
2.25 ATR
2.5 ATR
3.0 ATR
```

Only the ATR threshold should change during this experiment.

### EA098-RQ02 — Reversal Confirmation Quality

Evaluate the confirmation candle independently.

Possible hypotheses:

```text
Close beyond midpoint
Close beyond signal candle open
Close beyond signal candle high/low
Minimum confirmation candle body
Confirmation candle direction
```

### EA098-RQ03 — ATR Period

Evaluate whether the large-candle definition is sensitive to ATR lookback.

Suggested values:

```text
ATR 7
ATR 14
ATR 21
ATR 28
```

### EA098-RQ04 — BUY vs SELL Direction

Separate BUY and SELL performance.

The baseline produced:

```text
BUY  = 48.66% win rate
SELL = 53.62% win rate
```

The directional difference should be tested independently before introducing directional filtering.

### EA098-RQ05 — Trading Session

Evaluate whether the reversal setup behaves differently across market sessions.

The session experiment should not simultaneously modify ATR, confirmation, SL, TP, or trailing parameters.

### EA098-RQ06 — Exit Management

After entry quality has been evaluated, independently test:

```text
Break Even OFF / ON
Trailing Stop OFF / ON
SL / TP structure
```

Exit changes should not be combined with entry changes in the same controlled experiment.

## Research Sequence

```text
EA098-M1-BASELINE-001
        ↓
Large Candle ATR Threshold
        ↓
Reversal Confirmation Quality
        ↓
ATR Period
        ↓
BUY vs SELL Analysis
        ↓
Trading Session Analysis
        ↓
Exit Management
        ↓
Multi-Timeframe Evaluation
        ↓
Longer Historical Test
        ↓
Out-of-Sample Validation
        ↓
Robustness Testing
        ↓
Forward Testing
```

## Research Rules

Only one major strategy component should be changed per controlled experiment.

The failed baseline must remain unchanged as the reference configuration.

No broad parameter optimization should be performed before the strategy demonstrates a stable improvement through controlled experiments.

## Current Verdict

```text
Strategy Code       : COMPLETE
Baseline Backtest   : COMPLETE
Technical Execution : PASS
Baseline Performance: FAIL
Research             : IN PROGRESS
Optimization         : BLOCKED
Out-of-Sample        : NOT STARTED
Forward Test         : NOT STARTED
Production Ready     : NO
```

EA-098 is **not validated for live trading**.

The next authorized research step is:

**EA098-RQ01 — Large Candle ATR Threshold Evaluation.**
