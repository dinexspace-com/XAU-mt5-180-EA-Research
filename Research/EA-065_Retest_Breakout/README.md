# XAUUSD MT5 EA Research

## Current Research

### EA-065 — Retest Breakout

**Platform:** MetaTrader 5  
**Language:** MQL5  
**Market:** XAUUSD.PRO  
**Timeframe:** M1  
**Strategy Type:** Breakout + Retest  
**Current Stage:** Baseline completed — optimization required

---

## 1. Research Objective

The objective of EA-065 is to evaluate whether a simple breakout-and-retest structure can produce a robust automated trading strategy for XAUUSD on a low timeframe.

The strategy follows this sequence:

```text
Identify recent price range
        ↓
Wait for breakout
        ↓
Do not enter immediately
        ↓
Wait for price to retest breakout level
        ↓
Confirm continuation
        ↓
Enter in breakout direction
        ↓
Manage position using SL + TP + Break Even + Trailing Stop
```

The original EA and its baseline backtest must remain unchanged so that all future modifications can be compared against the same reference.

---

## 2. Strategy Hypothesis

The strategy is based on the hypothesis that:

> A breakout may become more reliable when price returns to test the broken range boundary and subsequently resumes movement in the breakout direction.

EA-065 therefore does not enter immediately after the initial breakout.

Instead, it stores the breakout level and waits for a valid retest before entering.

---

## 3. Strategy Structure

### Range Detection

The EA defines a recent price range using:

```text
InpBreakoutLookback = 20
```

completed candles.

The upper boundary is determined from the highest high.

The lower boundary is determined from the lowest low.

---

### Breakout Detection

Bullish breakout:

```text
Close > Range High + Breakout Buffer
```

Bearish breakout:

```text
Close < Range Low - Breakout Buffer
```

Baseline value:

```text
InpBreakoutBuffer = 0
```

A breakout does not immediately open a position.

The broken range boundary becomes the level used for the retest stage.

---

### Retest Detection

After breakout detection, the EA waits for price to revisit the breakout level.

Baseline:

```text
InpRetestTolerance = 20
InpRetestMaxBars   = 10
```

The setup is discarded if a valid retest does not occur within the permitted number of bars.

---

### BUY Confirmation

A BUY setup requires:

```text
Bullish breakout
+
Price retests breakout level
+
Confirmation candle closes above breakout level
+
Confirmation candle is bullish
```

---

### SELL Confirmation

A SELL setup requires:

```text
Bearish breakout
+
Price retests breakout level
+
Confirmation candle closes below breakout level
+
Confirmation candle is bearish
```

---

## 4. Baseline Configuration

```text
Symbol                  = XAUUSD.PRO
Timeframe               = M1

Lot Size                = 0.01

Stop Loss               = 300 points
Take Profit             = 600 points

Breakout Lookback       = 20
Breakout Buffer         = 0

Retest Tolerance        = 20 points
Retest Maximum Bars     = 10

Break Even              = ON
Break Even Trigger      = 150
Break Even Offset       = 0

Trailing Stop           = ON
Trailing Start          = 200
Trailing Distance       = 100
Trailing Step           = 10

Maximum Spread          = 30
Slippage                = 10
```

---

## 5. Baseline Backtest

Test environment:

```text
EA                      = EA-065_Retest_Breakout
Symbol                  = XAUUSD.PRO
Timeframe               = M1
Period                  = 2026-01-02 → 2026-03-31
Initial Deposit         = $100
Leverage                = 1:500
History Quality         = 100% real ticks
```

Results:

```text
Total Trades            = 459

Winning Trades          = 236
Losing Trades           = 223

Win Rate                = 51.42%
Loss Rate               = 48.58%

Net Profit              = -$94.61

Gross Profit            = $479.85
Gross Loss              = -$574.46

Profit Factor           = 0.84
Expected Payoff         = -$0.21

Recovery Factor         = -0.85
Sharpe Ratio            = -5.00

Maximum Balance DD      = 95.32%
Maximum Equity DD       = 95.36%

Average Profit Trade    = +$2.03
Average Loss Trade      = -$2.58

Largest Profit Trade    = +$7.36
Largest Loss Trade      = -$5.35
```

Baseline status:

```text
FAIL
```

The original parameter configuration is not suitable for deployment.

---

## 6. Main Baseline Finding

The EA generated:

```text
Win Rate = 51.42%
```

but still produced:

```text
Net Profit = -$94.61
Profit Factor = 0.84
```

The key relationship is:

```text
Average Profit Trade = +$2.03
Average Loss Trade   = -$2.58
```

Therefore:

```text
Average Loss > Average Win
```

The current win rate is not high enough to compensate for the realized payoff structure.

---

## 7. Nominal vs Realized Risk/Reward

The EA is configured with:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

which represents a nominal:

```text
Risk : Reward ≈ 1 : 2
```

However, the realized backtest results are:

```text
Average Profit = +$2.03
Average Loss   = -$2.58
```

Therefore, the effective trade outcome does not behave like a simple fixed 1:2 SL/TP system.

The difference is caused by the interaction between:

```text
Initial Stop Loss
Take Profit
Break Even
Trailing Stop
Market movement
```

Future research must therefore evaluate the complete exit system rather than analyzing SL and TP independently.

---

## 8. Balance Curve Observation

The baseline balance curve shows:

1. Initial account growth.
2. A significant early peak.
3. Progressive deterioration afterward.
4. Several temporary recoveries.
5. Continued decline toward the end of the test.
6. Final balance approaching account exhaustion.

This indicates that the strategy can generate profitable clusters but does not preserve profitability across the entire test period.

The baseline parameter set is therefore not stable across changing market conditions.

---

## 9. Trade Frequency

The EA generated:

```text
459 trades
```

during approximately three months of M1 data.

This represents a sufficiently large baseline sample to identify obvious weaknesses in the original configuration.

The trades occurred across most trading hours and throughout normal weekdays.

The current EA therefore operates as a broad intraday strategy rather than a narrowly restricted session strategy.

---

## 10. Holding Time

Baseline holding-time statistics:

```text
Minimum Holding Time = 00:00:02
Average Holding Time = 00:04:30
Maximum Holding Time = 02:04:00
```

The strategy therefore behaves primarily as a short-duration intraday system.

The average position is held for only a few minutes.

This makes execution conditions important, including:

```text
Spread
Slippage
Tick quality
Broker stop level
Execution speed
```

---

## 11. MFE / MAE Observation

Baseline correlations:

```text
Correlation (Profit, MFE) = 0.96
Correlation (Profit, MAE) = 0.74
Correlation (MFE, MAE)    = 0.6262
```

The strong relationship between profit and Maximum Favorable Excursion indicates that trades which move farther in the intended direction generally generate higher realized profits.

This makes exit management an important research target.

The backtest does not by itself prove which exit modification will improve performance.

Optimization and independent validation are required.

---

## 12. Research Questions

The next research stage should answer the following questions.

### Entry Quality

Can breakout quality be improved by changing:

```text
InpBreakoutLookback
InpBreakoutBuffer
```

Questions:

```text
Is the 20-bar range too short or too long?

Does requiring a breakout buffer reduce false breakouts?

Does stronger breakout confirmation improve expectancy?
```

---

### Retest Quality

Can retest selection be improved by changing:

```text
InpRetestTolerance
InpRetestMaxBars
```

Questions:

```text
Is 20 points too permissive?

Does waiting up to 10 bars allow stale setups?

Do faster retests perform better than delayed retests?
```

---

### Initial Risk

Parameters:

```text
InpStopLoss
InpTakeProfit
```

Questions:

```text
Is the 300-point stop appropriate for M1 XAUUSD?

Is the 600-point target realistic relative to actual price behavior?

Would a different SL/TP combination improve expectancy?
```

---

### Break-Even

Parameters:

```text
InpUseBreakEven
InpBreakEvenTrigger
InpBreakEvenOffset
```

Baseline:

```text
Trigger = 150
Offset  = 0
```

Research question:

```text
Does moving the stop to break-even too early reduce the size of winning trades?
```

This must be determined through testing rather than assumption.

---

### Trailing Stop

Parameters:

```text
InpUseTrailingStop
InpTrailingStart
InpTrailingDistance
InpTrailingStep
```

Baseline:

```text
Start    = 200
Distance = 100
Step     = 10
```

Research questions:

```text
Does trailing begin too early?

Is the trailing distance too tight for XAUUSD M1 volatility?

Does the trailing mechanism cut profitable trades before continuation?
```

---

## 13. Optimization Priority

The first optimization phase should focus only on the parameters most directly related to the strategy.

Priority parameters:

```text
InpBreakoutLookback
InpBreakoutBuffer
InpRetestTolerance
InpRetestMaxBars

InpStopLoss
InpTakeProfit

InpBreakEvenTrigger

InpTrailingStart
InpTrailingDistance
```

Do not optimize every available input simultaneously during the first research stage.

The purpose is to identify whether the strategy contains a stable performance region rather than simply finding the highest historical profit.

---

## 14. Parameters Not Prioritized Initially

The following parameters should remain fixed during the first optimization unless there is a specific reason to change them:

```text
InpLotSize
InpMagicNumber
InpSlippage
InpMaxSpread
InpBreakEvenOffset
InpTrailingStep
```

Baseline lot size should remain:

```text
0.01
```

so performance comparisons remain consistent.

---

## 15. Research Sequence

The research process for EA-065 should follow:

```text
BASELINE
   ↓
PARAMETER OPTIMIZATION
   ↓
IDENTIFY ROBUST PARAMETER REGION
   ↓
SELECT CANDIDATE CONFIGURATIONS
   ↓
OUT-OF-SAMPLE TEST
   ↓
MONTH-BY-MONTH VALIDATION
   ↓
ROBUSTNESS CHECK
   ↓
FINAL DECISION
```

---

## 16. Phase 1 — Baseline

Status:

```text
COMPLETE
```

Evidence:

```text
Source code available
MT5 Strategy Tester report available
100% real ticks
459 trades
Baseline performance recorded
```

Result:

```text
FAIL
```

Meaning:

```text
Original configuration should not be deployed.
```

The baseline remains useful as the reference configuration.

---

## 17. Phase 2 — Optimization

Status:

```text
PENDING
```

Objective:

Identify parameter regions where performance materially improves compared with the baseline.

Optimization should not be judged only by:

```text
Maximum Net Profit
```

Candidate configurations should also be reviewed using:

```text
Profit Factor
Drawdown
Expected Payoff
Trade Count
Stability across neighboring parameter values
Balance curve behavior
```

A single isolated high-profit result is not sufficient evidence of robustness.

---

## 18. Phase 3 — Candidate Selection

Optimization results should be reduced to a small number of candidate configurations.

Each candidate should record:

```text
Parameter values
Net Profit
Profit Factor
Maximum Drawdown
Expected Payoff
Trade Count
Win Rate
```

Preference should be given to parameter regions that remain reasonably stable when nearby values are changed.

The objective is not to select a single historical optimum without validation.

---

## 19. Phase 4 — Out-of-Sample Validation

Optimized parameters must be tested on data that was not used to select them.

The out-of-sample test should preserve:

```text
Same EA logic
Same symbol specification
Same lot size
Same execution assumptions
Same parameter set
```

Parameters must not be modified after seeing the out-of-sample result unless a new research iteration is explicitly started.

---

## 20. Phase 5 — Month-by-Month Validation

A candidate should also be examined across separate periods.

Example structure:

```text
Month 1
Month 2
Month 3
...
```

The objective is to determine whether performance is concentrated in one short market regime or distributed across multiple periods.

---

## 21. Robustness Requirements

A candidate configuration should not be considered validated solely because it produces positive Net Profit.

Research should check:

```text
Positive expectancy
Acceptable drawdown
Adequate trade sample
Stable neighboring parameters
Performance outside optimization period
No dependence on one exceptional trade
No dependence on one exceptional month
```

---

## 22. PASS / FAIL Criteria

### Baseline

Current result:

```text
FAIL
```

because:

```text
Net Profit < 0
Profit Factor < 1
Expected Payoff < 0
Maximum Drawdown ≈ 95%
```

---

### Optimization Candidate

A candidate may proceed to validation only if:

```text
Net Profit > 0

Profit Factor > 1

Expected Payoff > 0

Drawdown materially improves from baseline

Trade count remains sufficient for evaluation

Result is not an isolated optimization spike
```

Passing optimization does not mean the EA is approved for deployment.

It only means the candidate may proceed to validation.

---

### Final Research PASS

EA-065 should only receive final research PASS after:

```text
Source verified
+
Backtest evidence preserved
+
Optimization completed
+
Candidate selected
+
Out-of-sample test completed
+
Robustness checked
+
Results reviewed
```

Until those steps are complete:

```text
Deployment Status = NOT APPROVED
```

---

## 23. Current Research Status

```text
EA ID                 = EA-065
Strategy              = Retest Breakout

Source Code           = AVAILABLE
Baseline Backtest     = COMPLETE

Baseline Net Profit   = -$94.61
Baseline PF           = 0.84
Baseline Equity DD    = 95.36%
Baseline Trades       = 459

Baseline Result       = FAIL

Optimization          = PENDING
Candidate Selection   = PENDING
Out-of-Sample Test    = PENDING
Robustness Test       = PENDING

Final Validation      = NOT COMPLETE
Deployment            = NOT APPROVED
```

---

## 24. Repository References

EA source:

```text
EAs/
└── EA-065_Retest_Breakout/
    ├── EA-065_Retest_Breakout.mq5
    └── README.md
```

Baseline evidence:

```text
Backtest/
└── EA-065_Retest_Breakout/
    ├── README.md
    ├── ReportTester-952747(20260917-062300).html
    ├── ReportTester-952747(20260917-062259).png
    ├── ReportTester-952747-hst(20260917-062300).png
    ├── ReportTester-952747-mfemae(20260917-062300).png
    └── ReportTester-952747-holding(20260917-062300).png
```

Research documentation:

```text
Research/
└── README.md
```

---

## 25. Next Step

```text
Next Stage: Parameter Optimization
```

The baseline must remain unchanged.

Any optimization output should be stored as new research evidence and must not overwrite the original baseline report.

The immediate research task is:

```text
Optimize the strategy-sensitive parameters
        ↓
Analyze the optimization surface
        ↓
Identify stable candidate configurations
        ↓
Select candidates for independent validation
```

EA-065 remains a research strategy until those validation stages are completed.
