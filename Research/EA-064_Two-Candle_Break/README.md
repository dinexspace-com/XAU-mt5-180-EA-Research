# EA-064 — Two-Candle Break — Research

## Research Overview

**EA-064_Two-Candle_Break** investigates whether requiring two consecutive completed candles to close beyond the same historical breakout boundary can provide a measurable directional continuation edge on XAUUSD.

The strategy is intentionally simple.

Instead of entering immediately after a single breakout candle, EA-064 requires the breakout to remain confirmed for a second completed candle.

The core hypothesis is:

> A breakout that remains confirmed for two consecutive completed candles may provide stronger evidence of directional continuation than a breakout confirmed by only one candle.

The research objective is not to optimize the baseline immediately.

The objective is to determine whether the underlying Two-Candle Break structure contains a sufficiently stable trading edge to justify further development.

---

## Strategy Structure

EA-064 constructs a historical breakout range from completed candles.

The two confirmation candles are excluded from that range.

Conceptually:

```text
Historical Reference Range
        ↓
Upper / Lower Boundary
        ↓
Confirmation Candle #1
        ↓
Confirmation Candle #2
        ↓
Market Entry
```

For BUY:

```text
Close #1 > Upper + Breakout Buffer
AND
Close #2 > Upper + Breakout Buffer
```

For SELL:

```text
Close #1 < Lower - Breakout Buffer
AND
Close #2 < Lower - Breakout Buffer
```

Both confirmation candles are evaluated against the same historical breakout boundary.

The second candle does not redefine the range.

---

# Baseline Experiment

## Experiment ID

```text
EA064-M1-BASELINE-001
```

Purpose:

> Establish an untouched reference result for the Two-Candle Break hypothesis before structural research or parameter optimization.

---

## Baseline Environment

```text
EA              : EA-064_Two-Candle_Break
Symbol          : XAUUSD.PRO
Timeframe       : M1
Period          : 2026-01-02 → 2026-03-31
History Quality : 100% real ticks
Bars            : 85,161
Ticks           : 39,639,179

Initial Deposit : $100.00
Leverage        : 1:500
Lot Size        : 0.01
```

---

## Baseline Configuration

```text
Breakout Lookback   : 20
Breakout Buffer     : 0

Stop Loss           : 300 points
Take Profit         : 600 points

Maximum Spread      : 30 points

Break Even          : ON
BE Trigger          : 150 points
BE Offset           : 0

Trailing Stop       : ON
Trailing Start      : 200 points
Trailing Distance   : 100 points
Trailing Step       : 10 points
```

These parameters define the baseline reference configuration.

Future experiments must identify explicitly which parameter or structural component differs from this baseline.

---

# Baseline Results

```text
Initial Deposit     : $100.00

Net Profit          : -$91.91
Gross Profit        : +$560.33
Gross Loss          : -$652.24

Profit Factor       : 0.86
Expected Payoff     : -$0.17
Recovery Factor     : -0.94
Sharpe Ratio        : -5.00

Total Trades        : 543
Winning Trades      : 276 (50.83%)
Losing Trades       : 267 (49.17%)

Max Equity DD       : $97.56 (92.34%)
LR Correlation      : -0.89
```

Baseline verdict:

```text
FAIL
```

The baseline does not demonstrate positive historical expectancy and is not suitable for deployment.

---

# Initial Research Findings

## Finding 1 — Trade Frequency Is Sufficient for Initial Research

The Two-Candle Break requirement did not reduce trade frequency to an unusably small sample.

The baseline generated:

```text
543 trades
```

during approximately three months of XAUUSD.PRO M1 data.

Therefore, the strategy produces enough signals to support controlled structural experiments on the available baseline period.

This does not establish statistical robustness.

It establishes only that signal scarcity is not the immediate problem.

---

## Finding 2 — Win Rate Is Not the Primary Failure

The baseline produced:

```text
Winning Trades : 50.83%
Losing Trades  : 49.17%
```

The strategy therefore did not fail because almost all breakout signals were incorrect.

Instead, the payoff distribution was unfavorable.

```text
Average Winner : +$2.03
Average Loser  : -$2.44
```

Ratio:

```text
Average Winner / Average Loser
≈ 0.83
```

Therefore, the average realized winner was smaller than the average realized loser.

With a win rate only slightly above 50%, this produced negative expectancy.

---

## Finding 3 — Exit Behaviour Is a Major Research Candidate

The nominal baseline protective configuration is:

```text
SL = 300 points
TP = 600 points
```

which initially suggests a 1:2 stop-loss/take-profit relationship.

However, the realized results were:

```text
Average Winner : +$2.03
Average Loser  : -$2.44
```

Therefore, the nominal SL/TP relationship did not translate into the same realized payoff distribution.

This is expected to be influenced by the active position-management rules:

```text
Break Even
+
Trailing Stop
```

Consequently, exit management is an important research dimension.

However, the baseline alone does not establish that Break Even or Trailing Stop is specifically responsible for the negative expectancy.

They must be isolated experimentally.

---

## Finding 4 — BUY and SELL Are Relatively Similar

Directional results:

```text
SELL
Trades   : 243
Win Rate : 51.44%

BUY
Trades   : 300
Win Rate : 50.33%
```

Difference:

```text
SELL advantage ≈ 1.11 percentage points
```

This is not a sufficiently large baseline difference to justify immediately disabling one direction.

Both BUY and SELL should remain enabled in the reference strategy.

Directional separation can be tested later as a controlled research question.

---

## Finding 5 — Drawdown Is Unacceptable

Maximum equity drawdown:

```text
$97.56
92.34%
```

against:

```text
Initial Deposit = $100
```

This represents near-account depletion under the baseline configuration.

The baseline therefore fails capital-preservation requirements regardless of trade count or win rate.

---

## Finding 6 — Balance Trend Is Structurally Negative

MT5 reported:

```text
LR Correlation = -0.89
```

The balance graph also shows a persistent downward trajectory across the test sequence.

The strategy experienced temporary recoveries, but those recoveries did not reverse the overall decline.

This suggests that the negative baseline result is not explained solely by one isolated losing trade.

---

## Finding 7 — Strategy Operates as a Short-Duration M1 System

Position holding statistics:

```text
Minimum : 00:00:01
Average : 00:03:57
Maximum : 02:03:02
```

Most exposure is therefore short-duration relative to the total test period.

This makes execution conditions particularly relevant.

Potential future robustness tests should therefore consider:

```text
Spread
Slippage
Broker execution conditions
```

after a viable strategy structure has first been identified.

---

## Finding 8 — Favorable Excursion Contains Useful Information

MT5 reported:

```text
Correlation (Profit, MFE) : 0.94
Correlation (Profit, MAE) : 0.74
Correlation (MFE, MAE)    : 0.6050
```

The strong Profit/MFE correlation indicates that trades experiencing greater favorable excursion generally produced better realized results.

This makes MFE potentially useful when researching exit management.

However:

```text
Correlation ≠ causal evidence
```

The baseline does not prove that changing TP, Break Even, or Trailing Stop will improve expectancy.

That requires controlled experiments.

---

# Core Research Problem

The baseline raises two separate questions:

```text
ENTRY QUALITY
     +
EXIT QUALITY
```

The current results do not establish which component contributes most to the failure.

Therefore, optimization should not begin by sweeping all parameters simultaneously.

Doing so could produce a profitable-looking combination without revealing whether the improvement came from:

```text
better breakout selection,
different market exposure,
different exit behavior,
or parameter overfitting.
```

The research must first isolate the major structural components.

---

# Research Questions

## EA064-RQ01 — Breakout Lookback

Question:

> Does the historical range length materially affect the quality of Two-Candle Break signals?

Baseline:

```text
Breakout Lookback = 20
```

Research variable:

```text
InpBreakoutLookback
```

All other major parameters should remain fixed during the initial experiment.

Metrics to compare:

```text
Trade Count
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Average Winner
Average Loser
BUY / SELL distribution
```

Status:

```text
PENDING
```

---

## EA064-RQ02 — Breakout Buffer

Question:

> Does requiring price to close farther beyond the historical boundary reduce weak or false breakout signals?

Baseline:

```text
Breakout Buffer = 0
```

Research variable:

```text
InpBreakoutBuffer
```

Hypothesis:

A larger breakout buffer may:

```text
reduce trade count
filter marginal breakouts
increase confirmation strength
delay entry
reduce remaining continuation potential
```

No direction of improvement is assumed before testing.

Status:

```text
PENDING
```

---

## EA064-RQ03 — Timeframe

Question:

> Is the Two-Candle Break structure more stable on another intraday timeframe than M1?

Baseline:

```text
M1
```

Potential controlled comparison:

```text
M1
M5
M15
```

The same underlying strategy structure should be retained when comparing timeframes.

Because the available historical period is limited, timeframe results must not automatically be interpreted as general long-term performance.

Status:

```text
PENDING
```

---

## EA064-RQ04 — Trading Session

Question:

> Does the Two-Candle Break structure behave differently during different XAUUSD trading periods?

The baseline trades across multiple hours.

Future experiments may isolate defined trading windows.

Potential categories:

```text
Asia
Europe
US
```

The exact session definitions must be documented before testing.

They must not be chosen retrospectively solely because a particular backtest chart appears profitable.

Status:

```text
PENDING
```

---

## EA064-RQ05 — Directional Behaviour

Question:

> Do BUY and SELL signals have materially different expectancy even though their baseline win rates are similar?

Baseline:

```text
BUY  : 300 trades / 50.33% won
SELL : 243 trades / 51.44% won
```

Future directional experiments should compare:

```text
BUY only
SELL only
BUY + SELL
```

using otherwise equivalent conditions.

The baseline does not justify removing either direction yet.

Status:

```text
PENDING
```

---

## EA064-RQ06 — Exit Management

Question:

> Does the baseline Break Even + Trailing Stop configuration reduce the realized payoff quality of otherwise valid breakout trades?

Baseline:

```text
SL             : 300
TP             : 600

Break Even     : ON
Trigger        : 150
Offset         : 0

Trailing Stop  : ON
Start          : 200
Distance       : 100
Step           : 10
```

Controlled experiments should isolate the exit components.

Possible sequence:

```text
Fixed SL/TP only
        ↓
Fixed SL/TP + Break Even
        ↓
Fixed SL/TP + Trailing
        ↓
Fixed SL/TP + Break Even + Trailing
```

The purpose is to identify the effect of each exit-management component.

Status:

```text
PENDING
```

---

# Research Priority

The current priority is:

```text
ENTRY STRUCTURE
before
BROAD OPTIMIZATION
```

Initial sequence:

```text
Baseline
   ↓
Lookback
   ↓
Breakout Buffer
   ↓
Timeframe
   ↓
Session
   ↓
Direction
   ↓
Exit Management
```

After the structural experiments:

```text
Define justified parameter space
        ↓
Optimization
        ↓
Out-of-Sample
        ↓
Robustness
        ↓
Forward Test
```

---

# Controlled Experiment Rule

Whenever practical, each research experiment should modify only one major component relative to its reference configuration.

Example:

```text
EA064-M1-BASELINE-001

Lookback = 20
Buffer   = 0
SL       = 300
TP       = 600
BE       = ON
Trailing = ON
```

If testing Breakout Lookback:

```text
CHANGE:
Breakout Lookback

KEEP FIXED:
Breakout Buffer
SL
TP
Break Even
Trailing Stop
Timeframe
other execution rules
```

This provides a clearer comparison against the baseline.

---

# Experiment Naming

All EA-064 experiments should use a consistent identifier.

Format:

```text
EA064-[CATEGORY]-[NUMBER]
```

Examples:

```text
EA064-M1-BASELINE-001

EA064-LOOKBACK-001
EA064-LOOKBACK-002

EA064-BUFFER-001
EA064-BUFFER-002

EA064-TIMEFRAME-001

EA064-SESSION-001

EA064-DIRECTION-001

EA064-EXIT-001

EA064-OPT-001

EA064-OOS-001

EA064-ROBUST-001

EA064-FWD-001
```

The identifier should allow every result to be traced back to its exact configuration and evidence.

---

# Required Experiment Record

Every retained research experiment should document at minimum:

```text
Experiment ID
EA version
Symbol
Timeframe
Test period
History quality

Changed variable
Reference configuration
Test configuration

Initial deposit
Lot size

Total trades
Net profit
Profit factor
Expected payoff
Maximum drawdown
Win rate
Average winner
Average loser

BUY trades
BUY win rate

SELL trades
SELL win rate

Evidence files

Result
Interpretation
Next action
```

---

# PASS / FAIL Framework

An experiment should not be considered successful merely because:

```text
Net Profit > 0
```

At minimum, evaluation should consider:

```text
Positive Net Profit
Profit Factor > 1
Positive Expected Payoff
Acceptable Drawdown
Adequate Trade Count
Reasonable BUY / SELL behaviour
Stable balance trajectory
```

A result that improves one metric while severely degrading another must be documented rather than automatically accepted.

---

# Optimization Gate

Broad optimization is currently:

```text
NOT STARTED
```

Optimization should begin only after the primary structural research has narrowed the search space sufficiently.

The intended sequence is:

```text
Baseline
   ↓
Controlled Structural Research
   ↓
Identify viable parameter regions
   ↓
Define optimization ranges
   ↓
Optimization
```

Optimization should not be used as the first method for discovering whether the strategy works.

---

# Out-of-Sample Requirement

Any configuration selected from optimization or repeated in-sample experimentation must subsequently be evaluated on data that was not used to select it.

Therefore:

```text
In-Sample Research
        ↓
Candidate Configuration
        ↓
Out-of-Sample Test
```

A candidate that performs well only on the research sample is not considered validated.

---

# Robustness Requirement

If EA-064 reaches a viable candidate configuration, robustness testing should investigate sensitivity to reasonable changes in:

```text
Parameters
Spread
Slippage
Execution conditions
Time period
```

A candidate that fails under small perturbations should be treated cautiously even if its optimized result is strong.

---

# Forward Testing Requirement

Historical testing alone is insufficient for deployment validation.

A candidate must eventually progress through:

```text
Baseline
   ↓
Research
   ↓
Optimization
   ↓
Out-of-Sample
   ↓
Robustness
   ↓
Forward Test
```

Only after those stages should deployment readiness be assessed.

---

# Evidence Policy

The original baseline evidence must remain unchanged.

Primary baseline evidence:

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

The original MT5 Strategy Tester HTML report is the primary numerical evidence.

Images are supporting visual evidence.

Future experiments must not overwrite the baseline files.

---

# Current Research Status

```text
EA                  : EA-064_Two-Candle_Break

Strategy Code       : COMPLETE
Baseline Backtest   : COMPLETE
Baseline Evidence   : RETAINED

Baseline Experiment : EA064-M1-BASELINE-001
Baseline Result     : FAIL

Research Stage      : ACTIVE

EA064-RQ01 Lookback : PENDING
EA064-RQ02 Buffer   : PENDING
EA064-RQ03 Timeframe: PENDING
EA064-RQ04 Session  : PENDING
EA064-RQ05 Direction: PENDING
EA064-RQ06 Exit     : PENDING

Optimization        : NOT STARTED
Out-of-Sample       : NOT STARTED
Robustness          : NOT STARTED
Forward Test        : NOT STARTED

Validated           : NO
Production Ready    : NO
```

---

# Current Conclusion

The first EA-064 baseline produced a sufficiently large initial sample but failed economically.

The key baseline relationship is:

```text
543 trades
        ↓
50.83% Win Rate
        ↓
Average Winner = +$2.03
Average Loser  = -$2.44
        ↓
Profit Factor = 0.86
        ↓
Expected Payoff = -$0.17
        ↓
Net Profit = -$91.91
        ↓
Maximum Equity Drawdown = 92.34%
        ↓
BASELINE FAIL
```

The result does not establish that the Two-Candle Break concept itself should be discarded.

It establishes that the current baseline implementation and parameter configuration did not demonstrate positive historical expectancy.

The strategy should therefore remain:

```text
RESEARCH ONLY
```

The next stage is controlled structural testing before broad parameter optimization.
