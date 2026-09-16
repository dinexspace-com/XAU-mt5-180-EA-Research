# EA-063 — Close Location Break

## Research Record

**Strategy ID:** EA-063  
**Strategy Name:** Close Location Break  
**Instrument:** XAUUSD.PRO  
**Primary Timeframe:** M1  
**Platform:** MetaTrader 5  
**Research Status:** BASELINE COMPLETED — OPTIMIZATION PENDING

---

## 1. Research Hypothesis

EA-063 tests the hypothesis that a breakout has greater continuation potential when the breakout candle closes near the extreme of its own range.

The strategy therefore combines two conditions:

1. Price must break a recent reference range.
2. The breakout candle must close near the breakout-side edge of its High-Low range.

The underlying idea is that the close location of the breakout candle can act as a simple confirmation of breakout strength.

This repository does not assume that the hypothesis is profitable.

The purpose of the research process is to test whether the hypothesis produces a measurable and sufficiently robust trading edge on XAUUSD.

---

## 2. Core Signal

### Reference Range

A reference range is constructed from the previous completed candles.

Baseline:

```text
Lookback = 20 candles
```

The breakout candle itself is excluded from the reference range.

---

### BUY

A BUY setup requires:

```text
Close > Previous Range High + Breakout Buffer
```

and:

```text
(High - Close) / (High - Low) <= CloseEdgeFraction
```

Baseline:

```text
CloseEdgeFraction = 0.20
```

Therefore, the breakout candle must close within the upper 20% of its own High-Low range.

---

### SELL

A SELL setup requires:

```text
Close < Previous Range Low - Breakout Buffer
```

and:

```text
(Close - Low) / (High - Low) <= CloseEdgeFraction
```

With the baseline value:

```text
CloseEdgeFraction = 0.20
```

the breakout candle must close within the lower 20% of its own High-Low range.

---

## 3. Baseline Configuration

| Parameter | Baseline |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Max Spread | 30 points |
| Timeframe | M1 |
| Breakout Lookback | 20 |
| Breakout Buffer | 0 |
| Close Edge Fraction | 0.20 |
| Break Even | Enabled |
| Break Even Trigger | 150 |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 |
| Trailing Distance | 100 |
| Trailing Step | 10 |

---

## 4. Baseline Test

The first baseline test was performed using:

```text
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026.01.02 — 2026.03.31
Initial Capital: $100
Leverage:        1:500
Data:            100% real ticks
```

Dataset:

```text
Bars:   85,161
Ticks:  39,639,179
Trades: 269
Deals:  538
```

---

## 5. Baseline Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$92.09 |
| Gross Profit | $262.21 |
| Gross Loss | -$354.30 |
| Profit Factor | 0.74 |
| Expected Payoff | -$0.34 |
| Recovery Factor | -0.88 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | 92.97% |
| Maximum Equity Drawdown | 92.97% |
| Winning Trades | 123 / 269 |
| Losing Trades | 146 / 269 |
| Win Rate | 45.72% |

---

## 6. Directional Results

Both directions generated a meaningful number of trades.

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 144 | 48.61% |
| SELL | 125 | 42.40% |

Therefore, the baseline result cannot be explained by one side of the strategy being inactive.

SELL performed worse by win rate during this sample, but the current evidence is not sufficient to justify removing SELL from the strategy.

BUY and SELL must remain part of the research unless later testing provides evidence for a structural change.

---

## 7. Trade Expectancy Problem

Baseline average trade outcomes were:

```text
Average Winner = +$2.13
Average Loser  = -$2.43
Win Rate       = 45.72%
Loss Rate      = 54.28%
```

This creates an unfavorable combination:

```text
Win frequency < Loss frequency
```

and:

```text
Average Winner < Average Loser
```

The resulting Expected Payoff is:

```text
-$0.34 per trade
```

The baseline therefore has negative expectancy.

---

## 8. Equity Behaviour

The baseline balance begins at:

```text
$100
```

and finishes at approximately:

```text
$7.91
```

The balance curve contains temporary recovery phases but maintains an overall negative trajectory.

Maximum drawdown reaches:

```text
92.97%
```

This is not acceptable for deployment.

The baseline configuration is therefore classified:

```text
BASELINE RESULT = FAIL
```

---

## 9. Holding Behaviour

Position duration:

| Metric | Result |
|---|---:|
| Minimum | 00:00:04 |
| Average | 00:04:10 |
| Maximum | 02:03:19 |

The baseline implementation therefore behaves primarily as a short-duration M1 breakout strategy.

---

## 10. MFE / MAE Observation

MT5 reports:

| Correlation | Value |
|---|---:|
| Profit / MFE | 0.96 |
| Profit / MAE | 0.77 |
| MFE / MAE | 0.6807 |

These values are retained as diagnostic evidence.

They are not sufficient by themselves to establish profitability or robustness.

---

## 11. What the Baseline Establishes

The baseline test establishes that:

```text
EA-063
+
current implementation
+
current baseline parameters
+
XAUUSD.PRO
+
M1
+
2026.01.02 — 2026.03.31
```

produces an unacceptable result.

Specifically:

```text
Net Profit      = -$92.09
Profit Factor   = 0.74
Expected Payoff = -$0.34
Max Drawdown    = 92.97%
```

Therefore:

```text
Baseline configuration = REJECTED
```

---

## 12. What the Baseline Does NOT Establish

The baseline does not establish that:

```text
Close Location Break has no edge.
```

It also does not establish that:

```text
EA-063 should be permanently discarded.
```

Only one baseline parameter configuration has been evaluated.

The current evidence cannot distinguish between:

```text
A. Strategy hypothesis has no usable edge

or

B. Strategy hypothesis has an edge but the current parameters / trade management are poor
```

Parameter optimization is therefore required before making the research decision.

---

## 13. Optimization Objective

The next research stage is not simply to search for the single most profitable parameter combination.

The objective is to determine whether a **stable profitable parameter region** exists.

MetaTrader 5 optimization runs the EA repeatedly using different combinations of input parameters. Forward testing can subsequently test selected optimization results on a separate period to help detect overfitting.

For EA-063, optimization should investigate the sensitivity of the strategy to its principal structural and trade-management parameters.

---

## 14. Parameters to Investigate

Primary strategy parameters:

```text
InpBreakoutLookback
InpBreakoutBuffer
InpCloseEdgeFraction
```

Risk / exit parameters:

```text
InpStopLoss
InpTakeProfit
```

Trade-management parameters:

```text
InpBreakEvenTrigger
InpTrailingStart
InpTrailingDistance
InpTrailingStep
```

The first optimization should prioritize the parameters that directly define the strategy hypothesis:

```text
BreakoutLookback
BreakoutBuffer
CloseEdgeFraction
```

before introducing excessive combinations of secondary trade-management parameters.

---

## 15. Optimization Evaluation

A single profitable optimization pass is not sufficient evidence.

The optimization should be examined for clusters of neighboring parameter combinations that produce similar results.

Evidence of interest would include:

```text
multiple neighboring parameter sets
→ positive expectancy
→ Profit Factor > 1
→ controlled drawdown
→ sufficient trades
→ similar behaviour across nearby settings
```

A result where only one isolated parameter combination performs strongly while surrounding combinations fail should be treated cautiously because it may indicate parameter sensitivity or overfitting.

---

## 16. Forward Validation

If optimization identifies a credible parameter region, the selected configuration must not immediately be classified as successful.

The next stage is:

```text
Optimization
      ↓
Candidate parameter region
      ↓
Independent / Forward Test
      ↓
Robustness assessment
      ↓
Research decision
```

MetaTrader 5 provides Forward Optimization specifically to evaluate selected optimization results on a separate portion of historical data.

---

## 17. Research Decision States

EA-063 should move through the following states:

```text
HYPOTHESIS
    ↓
IMPLEMENTED
    ↓
BASELINE TESTED
    ↓
OPTIMIZATION
    ↓
FORWARD VALIDATION
    ↓
FINAL RESEARCH DECISION
```

Current position:

```text
HYPOTHESIS             PASS
IMPLEMENTATION         PASS
BASELINE TEST          COMPLETE
BASELINE PERFORMANCE   FAIL
OPTIMIZATION           PENDING
FORWARD VALIDATION     NOT STARTED
FINAL DECISION         NOT YET AVAILABLE
```

---

## 18. Current Conclusion

The original EA-063 configuration is not viable.

The baseline produced:

```text
269 trades
45.72% win rate
Profit Factor 0.74
Expected Payoff -$0.34
Maximum Drawdown 92.97%
Net Profit -$92.09
```

However, the baseline alone is insufficient to reject the underlying Close Location Break hypothesis.

The next required evidence is an MT5 optimization result.

Until that evidence exists:

```text
EA-063 STATUS:

BASELINE FAILED
RESEARCH CONTINUES
OPTIMIZATION REQUIRED
NO DEPLOYMENT
NO FINAL STRATEGY VERDICT
```

---

## 19. Evidence Location

EA implementation:

```text
/EAs/EA-063_Close_Location_Break/
```

Baseline evidence:

```text
/Backtest/EA-063_Close_Location_Break/
```

Research record:

```text
/Research/README.md
```

Primary baseline evidence:

```text
ReportTester-952747(20260916-060943).html
```

Supporting MT5 graphs are retained alongside the HTML report.

---

## 20. Next Required Artifact

The next required artifact is:

```text
MT5 Optimization Report
```

for:

```text
EA-063_Close_Location_Break
XAUUSD.PRO
M1
```

Once the optimization artifact exists, this research record can be extended with:

```text
Optimization setup
Optimization ranges
Number of passes
Parameter sensitivity
Candidate clusters
Best candidate configurations
Overfitting assessment
Forward-test candidate
Continue / Modify / Reject research decision
```

No final research decision should be recorded before optimization evidence is available.
