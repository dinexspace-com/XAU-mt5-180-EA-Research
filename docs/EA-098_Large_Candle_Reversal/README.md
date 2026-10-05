# EA-098 Research Methodology

## Baseline Identification

The EA-098 reference experiment is:

`EA098-M1-BASELINE-001`

The baseline must remain unchanged and must be reproducible from the archived source code and documented settings.

## Baseline Test

The reference test uses:

```text
Symbol          : XAUUSD.PRO
Timeframe       : M1
Period          : 2026-01-02 → 2026-03-31
Initial Deposit : $1,000
Leverage        : 1:500
Model           : 100% real ticks
Lot             : 0.01
SL              : 300
TP              : 600
ATR Period      : 14
Large ATR       : 2.0
Maximum Spread  : 30
```

## Evaluation Criteria

EA-098 research should evaluate:

1. Net Profit
2. Profit Factor
3. Expected Payoff
4. Maximum Equity Drawdown
5. Recovery Factor
6. Sharpe Ratio
7. Total Trades
8. Win Rate
9. Average Winning Trade
10. Average Losing Trade
11. BUY vs SELL performance
12. Stability across different market conditions

A positive Net Profit alone is not sufficient for acceptance.

## Controlled Experiment Rule

Each experiment must modify only one major strategy component.

For example:

```text
Baseline
   ↓
Change Large Candle ATR Threshold
   ↓
Evaluate Result
   ↓
Return to Baseline
   ↓
Change Confirmation Rule
   ↓
Evaluate Result
```

Do not simultaneously change:

```text
Entry Logic
ATR Threshold
SL
TP
Break Even
Trailing Stop
Session
Timeframe
```

unless the experiment is explicitly designed to test that combination after the individual components have already been evaluated.

## Research Acceptance

A configuration may be considered a candidate for further research when it demonstrates meaningful improvement over the baseline while maintaining:

* Reasonable drawdown
* Positive expectancy
* Profit Factor above 1.0
* Adequate trade count
* Stable directional behavior
* No obvious dependence on a small number of exceptional trades

A research candidate is **not automatically a live-trading candidate**.

## Validation Sequence

```text
Baseline
   ↓
Controlled Research
   ↓
Longer Historical Test
   ↓
Out-of-Sample Test
   ↓
Robustness Testing
   ↓
Forward Test
   ↓
Human Review
   ↓
Live Trading Consideration
```

## Optimization Policy

Broad optimization is blocked until controlled research provides evidence that the underlying Large Candle Reversal hypothesis has sufficient merit.

Parameter optimization must not be used to rescue a failed baseline without first identifying a plausible mechanism for improvement.

## Current EA-098 Status

```text
Baseline              : COMPLETE
Baseline Classification: FAIL
Controlled Research   : IN PROGRESS
Optimization          : BLOCKED
OOS Validation        : NOT STARTED
Forward Testing       : NOT STARTED
Live Validation       : NOT STARTED
Production Ready      : NO
```
