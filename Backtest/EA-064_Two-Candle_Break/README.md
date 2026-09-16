# EA-064 — Two-Candle Break — Backtest

## Baseline Experiment

**Experiment ID:** `EA064-M1-BASELINE-001`

This directory contains the baseline MetaTrader 5 backtest evidence for:

```text
EA-064_Two-Candle_Break
```

The purpose of this experiment is to establish the initial reference performance of the Two-Candle Break strategy before controlled parameter research or optimization.

The baseline must remain unchanged and serves as the comparison point for all subsequent EA-064 experiments.

---

## Test Environment

```text
Expert Advisor : EA-064_Two-Candle_Break
Symbol         : XAUUSD.PRO
Timeframe      : M1
Test Period    : 2026-01-02 → 2026-03-31
History Quality: 100% real ticks
Bars           : 85,161
Ticks          : 39,639,179
Symbols        : 1
Initial Deposit: $100.00
Leverage       : 1:500
Currency       : USD
MT5 Build      : 6182
```

---

## Baseline Parameters

```text
Execution
─────────────────────────────────
Lot Size            : 0.01
Stop Loss           : 300 points
Take Profit         : 600 points
Magic Number        : 123064
Slippage            : 10
Maximum Spread      : 30 points
Timeframe           : M1

Two-Candle Break
─────────────────────────────────
Breakout Lookback   : 20
Breakout Buffer     : 0

Break Even
─────────────────────────────────
Enabled             : true
Trigger             : 150 points
Offset              : 0

Trailing Stop
─────────────────────────────────
Enabled             : true
Start               : 200 points
Distance            : 100 points
Step                : 10 points
```

No optimization was applied to select these baseline parameters.

This run is treated as the reference configuration for subsequent controlled experiments.

---

## Baseline Results

| Metric | Result |
|---|---:|
| Initial Deposit | $100.00 |
| Total Net Profit | **-$91.91** |
| Gross Profit | $560.33 |
| Gross Loss | -$652.24 |
| Profit Factor | **0.86** |
| Expected Payoff | **-$0.17** |
| Recovery Factor | **-0.94** |
| Sharpe Ratio | **-5.00** |
| AHPR | 0.9971 (-0.29%) |
| GHPR | 0.9954 (-0.46%) |
| LR Correlation | **-0.89** |
| LR Standard Error | 9.78 |
| Z-Score | -0.25 (19.74%) |
| Total Trades | **543** |
| Total Deals | 1,086 |

---

## Drawdown

```text
Balance Drawdown Absolute : $91.91
Balance Drawdown Maximal  : $96.01 (92.23%)
Balance Drawdown Relative : 92.23% ($96.01)

Equity Drawdown Absolute  : $91.91
Equity Drawdown Maximal   : $97.56 (92.34%)
Equity Drawdown Relative  : 92.34% ($97.56)
```

The baseline experienced extremely high drawdown relative to the initial $100 deposit.

The balance curve shows a persistent long-term decline and finishes close to account depletion.

Therefore, the baseline does not satisfy basic capital-preservation requirements.

---

## Trade Statistics

```text
Total Trades : 543
Total Deals  : 1,086

Winning Trades : 276 (50.83%)
Losing Trades  : 267 (49.17%)
```

The overall historical win rate is slightly above 50%.

However, the strategy still produced negative net profit because the realized payoff distribution was unfavorable.

---

## BUY vs SELL

```text
SELL / Short Trades
─────────────────────────────────
Trades   : 243
Win Rate : 51.44%

BUY / Long Trades
─────────────────────────────────
Trades   : 300
Win Rate : 50.33%
```

Both directions produced win rates close to 50%.

SELL achieved a slightly higher historical win rate than BUY during this test period.

This difference alone is not sufficient evidence to remove either trading direction.

BUY and SELL performance should be evaluated separately in a controlled experiment if directional filtering is investigated later.

---

## Winner / Loser Distribution

```text
Largest Profitable Trade : +$6.19
Largest Losing Trade     : -$5.43

Average Profitable Trade : +$2.03
Average Losing Trade     : -$2.44
```

The baseline has:

```text
Average Winner = +$2.03
Average Loser  = -$2.44
```

Therefore:

```text
Average Winner / Average Loser
≈ 0.83
```

The realized average loss is larger than the realized average profit.

With:

```text
Win Rate        = 50.83%
Average Winner  = +$2.03
Average Loser   = -$2.44
```

the resulting historical expectancy is negative.

This is consistent with the MT5 Expected Payoff result:

```text
-$0.17 per trade
```

---

## Consecutive Results

```text
Maximum Consecutive Wins   : 7
Profit During Sequence     : +$14.31

Maximum Consecutive Losses : 7
Loss During Sequence       : -$18.47

Maximal Consecutive Profit : +$17.56 across 6 trades
Maximal Consecutive Loss   : -$18.47 across 7 trades

Average Consecutive Wins   : 2
Average Consecutive Losses : 2
```

The maximum observed winning and losing streak lengths were equal at seven trades.

However, the maximum monetary loss sequence exceeded the corresponding seven-trade winning sequence.

---

## Holding Time

```text
Minimum Holding Time : 00:00:01
Maximum Holding Time : 02:03:02
Average Holding Time : 00:03:57
```

The average position remained open for less than four minutes.

This confirms that under the baseline configuration EA-064 behaves operationally as a short-duration M1 breakout strategy.

---

## MFE / MAE Statistics

MT5 reported:

```text
Correlation (Profits, MFE) : 0.94
Correlation (Profits, MAE) : 0.74
Correlation (MFE, MAE)     : 0.6050
```

The strong positive correlation between Profit and MFE indicates that trades producing larger favorable excursions generally generated better realized outcomes.

The MAE/MFE plots are retained as evidence for later exit-management research.

These correlations are descriptive statistics from this baseline and are not sufficient by themselves to establish a profitable exit modification.

---

## Balance Curve

The baseline balance curve is structurally negative.

The account begins around:

```text
$100
```

and experiences repeated recoveries and declines before ultimately falling to approximately:

```text
$8
```

which is consistent with:

```text
Initial Deposit   : $100.00
Total Net Profit  : -$91.91
Ending Balance    : approximately $8.09
```

The decline is not attributable to a single isolated losing event.

Instead, the graph shows repeated drawdowns followed by incomplete recoveries across the test sequence.

The final section of the backtest shows another pronounced decline.

This is consistent with the reported:

```text
LR Correlation = -0.89
```

and demonstrates that the baseline equity/balance trajectory is unsuitable for deployment.

---

## Baseline Assessment

The baseline result is:

```text
Performance : FAIL
```

Primary evidence:

```text
Net Profit       : -$91.91
Profit Factor    : 0.86
Expected Payoff  : -$0.17
Recovery Factor  : -0.94
Sharpe Ratio     : -5.00
Equity Drawdown  : 92.34%
LR Correlation   : -0.89
```

Despite achieving:

```text
Win Rate = 50.83%
```

the strategy loses money because its realized average losing trade exceeds its realized average profitable trade.

The baseline therefore does not demonstrate positive expectancy.

---

## Comparison With Strategy Hypothesis

EA-064 tests whether requiring two consecutive completed candles to remain beyond the same historical breakout boundary can improve breakout confirmation.

The baseline generated:

```text
543 trades
```

over the documented test period.

This confirms that the Two-Candle Break condition remains sufficiently frequent to produce a substantial initial sample on XAUUSD.PRO M1.

However, the baseline result shows:

```text
Two-Candle confirmation
        ↓
543 trades
        ↓
50.83% winning trades
        ↓
Average Winner +$2.03
Average Loser  -$2.44
        ↓
Profit Factor 0.86
        ↓
Negative Expectancy
        ↓
Net Profit -$91.91
```

Therefore, the tested baseline configuration does not provide a profitable implementation of the hypothesis.

---

## What This Baseline Establishes

The baseline establishes that:

```text
1. EA-064 successfully generated both BUY and SELL trades.

2. The Two-Candle Break rule produced 543 trades during
   the documented XAUUSD.PRO M1 period.

3. Overall historical win rate was approximately 50%.

4. SELL and BUY win rates were relatively close.

5. Average losses were larger than average profits.

6. Historical expectancy was negative.

7. Drawdown exceeded 92%.

8. The balance curve showed a strong negative trajectory.

9. The baseline configuration is not suitable for deployment.
```

---

## What This Baseline Does NOT Establish

The result does **not** establish that the broader Two-Candle Break hypothesis has no trading edge.

It establishes only that:

```text
EA064-M1-BASELINE-001
```

failed under the documented configuration and test period.

The baseline does not determine whether performance could materially change with controlled modification of:

```text
Breakout Lookback
Breakout Buffer
Timeframe
Trading Session
BUY / SELL direction
Stop Loss
Take Profit
Break Even
Trailing Stop
```

Those questions require separate experiments.

---

## Research Direction

The next stage should investigate the strategy structure before broad optimization.

Recommended research sequence:

```text
EA064-M1-BASELINE-001
        ↓
Breakout Lookback Evaluation
        ↓
Breakout Buffer Evaluation
        ↓
Timeframe Evaluation
        ↓
Trading Session Evaluation
        ↓
BUY vs SELL Evaluation
        ↓
Exit Management Evaluation
        ↓
Parameter Optimization
        ↓
Out-of-Sample Validation
        ↓
Robustness Testing
        ↓
Forward Testing
```

Only one major strategy component should be changed per controlled experiment where practical.

This allows each result to be compared against the retained baseline.

---

## Baseline Verdict

```text
Experiment ID       : EA064-M1-BASELINE-001

Technical Execution : PASS
Sample Size         : 543 trades
History Quality     : 100% real ticks

Net Profit          : FAIL
Profit Factor       : FAIL
Expected Payoff     : FAIL
Drawdown            : FAIL
Balance Stability   : FAIL

Overall Baseline    : FAIL

Optimization        : NOT STARTED
Out-of-Sample Test  : NOT STARTED
Forward Test        : NOT STARTED
Production Ready    : NO
```

`Technical Execution: PASS` means the retained Strategy Tester report contains completed BUY/SELL trading activity and test results.

It does **not** mean that the strategy passed profitability or deployment validation.

---

## Evidence Files

The baseline evidence should be retained together in this directory:

```text
Backtest/
└── EA-064_Two-Candle_Break/
    ├── README.md
    ├── ReportTester-952747(20260916-061820).html
    ├── ReportTester-952747(20260916-061820).png
    ├── ReportTester-952747-hst(20260916-061819).png
    ├── ReportTester-952747-mfemae(20260916-061819).png
    └── ReportTester-952747-holding(20260916-061819).png
```

The original MT5 HTML report is the primary evidence source.

The PNG files provide visual evidence for:

```text
Balance
Trade distribution by time
MFE / MAE
Holding time
```

Do not replace the original baseline evidence after subsequent optimization.

Future experiments should be stored separately so that the original baseline remains reproducible and auditable.

---

## Current Status

```text
EA                  : EA-064_Two-Candle_Break
Baseline Experiment : EA064-M1-BASELINE-001

Source Code         : COMPLETE
Baseline Backtest   : COMPLETE
Baseline Evidence   : RETAINED
Baseline Result     : FAIL

Research            : NEXT
Optimization        : PENDING
Out-of-Sample       : NOT STARTED
Robustness Test     : NOT STARTED
Forward Test        : NOT STARTED
Production Ready    : NO
```

The next stage is research analysis of the failed baseline before optimization.
