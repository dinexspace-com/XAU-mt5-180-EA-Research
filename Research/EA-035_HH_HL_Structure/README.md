# EA-035 — HH/HL Structure Research

## 1. Research Objective

This document records the research process, findings, hypotheses, and future experiments for **EA-035_HH_HL_Structure**.

The EA investigates a simple market-structure hypothesis based on:

- Higher High — HH
- Higher Low — HL
- Lower High — LH
- Lower Low — LL

The baseline trading hypothesis is:

**Bullish structure**

HH + HL → BUY

**Bearish structure**

LH + LL → SELL

The primary research question is:

> Can raw HH/HL and LH/LL market structure provide a statistically useful trading edge on XAUUSD?

The purpose of EA-035 is to test this hypothesis with the simplest possible implementation first, establish a measurable baseline, identify failure modes, and only then test isolated improvements.

---

## 2. Research Principle

EA-035 follows a baseline-first experimental process:

Simple Hypothesis  
↓  
Implement EA  
↓  
Run Backtest  
↓  
Measure Results  
↓  
Identify Failure Mode  
↓  
Define New Hypothesis  
↓  
Change One Major Variable  
↓  
Run New Backtest  
↓  
Compare With Baseline

The original baseline must be preserved.

Future improvements should be tested as separate experiments rather than silently modifying the baseline.

The purpose is to determine **why** performance changes instead of merely searching for a profitable historical result.

---

## 3. Baseline Strategy

EA-035 detects recent swing highs and swing lows and uses them to classify basic market structure.

The implementation uses a local swing definition with two bars on each side of the candidate swing.

### Swing High

A candidate is classified as a Swing High when:

High[i] > High[i-1]  
High[i] > High[i-2]  
High[i] > High[i+1]  
High[i] > High[i+2]

### Swing Low

A candidate is classified as a Swing Low when:

Low[i] < Low[i-1]  
Low[i] < Low[i-2]  
Low[i] < Low[i+1]  
Low[i] < Low[i+2]

The latest swing values are then compared with previous swing values.

---

## 4. Market Structure Classification

### Higher High — HH

Latest Swing High > Previous Swing High

### Higher Low — HL

Latest Swing Low > Previous Swing Low

### Lower High — LH

Latest Swing High < Previous Swing High

### Lower Low — LL

Latest Swing Low < Previous Swing Low

The baseline converts these structures directly into trading signals.

### BUY

HH + HL → Bullish Structure → BUY

### SELL

LH + LL → Bearish Structure → SELL

No higher-timeframe trend filter, ATR filter, session filter, news filter, or additional price confirmation is used in the baseline entry logic.

---

## 5. Baseline Experiment

The first experiment establishes the reference performance for EA-035.

### Experiment ID

**EA-035-B00**

### Configuration

| Parameter | Value |
|---|---|
| Expert Advisor | `EA-035_HH_HL_Structure` |
| Symbol | `XAUUSD.PRO` |
| Timeframe | `M1` |
| Test Period | `2026.01.02 – 2026.04.01` |
| Initial Deposit | `$1,000.00` |
| Leverage | `1:500` |
| History Quality | `100% real ticks` |
| Bars | `86,539` |
| Ticks | `40,346,891` |
| Lot Size | `0.01` |
| Stop Loss | `300 points` |
| Take Profit | `600 points` |
| Maximum Spread | `35 points` |
| Break Even | `OFF` |
| Trailing Stop | `OFF` |

Break Even and Trailing Stop were deliberately disabled in this test.

Therefore, EA-035-B00 primarily measures the raw HH/HL and LH/LL entry concept with fixed Stop Loss and Take Profit.

---

## 6. Baseline Results

| Metric | Result |
|---|---:|
| Initial Deposit | `$1,000.00` |
| Total Net Profit | `-$994.57` |
| Gross Profit | `$13,381.72` |
| Gross Loss | `-$14,376.29` |
| Profit Factor | `0.93` |
| Expected Payoff | `-$0.15` |
| Recovery Factor | `-0.94` |
| Sharpe Ratio | `-5.00` |
| Maximum Balance Drawdown | `$1,062.71 (99.49%)` |
| Maximum Equity Drawdown | `$1,062.71 (99.49%)` |
| Total Trades | `6,651` |
| Total Deals | `13,302` |
| Winning Trades | `2,143 (32.22%)` |
| Losing Trades | `4,508 (67.78%)` |

### Baseline Verdict

**FAIL**

The raw HH/HL and LH/LL strategy does not demonstrate positive expectancy under the tested configuration.

The most important evidence is:

- Profit Factor: `0.93`
- Expected Payoff: `-$0.15`
- Net Profit: `-$994.57`
- Maximum Drawdown: `99.49%`
- Sharpe Ratio: `-5.00`

The account experienced near-total depletion during the historical test.

---

## 7. Long vs Short Performance

The strategy generated a nearly balanced number of BUY and SELL trades.

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | `3,374` | `32.51%` |
| Long | `3,277` | `31.92%` |

The performance difference between BUY and SELL is small.

The baseline therefore provides no strong evidence that simply disabling one trading direction would solve the underlying problem.

The primary issue appears broader than directional bias.

---

## 8. Win Rate Analysis

The baseline produced:

- Winning Trades: `2,143`
- Losing Trades: `4,508`
- Win Rate: `32.22%`
- Loss Rate: `67.78%`

Approximately two out of every three trades were losing trades.

The strategy therefore depends heavily on winners being substantially larger than losers.

---

## 9. Reward vs Risk Observation

The baseline configuration uses:

- Stop Loss: `300 points`
- Take Profit: `600 points`

The nominal price-distance relationship is:

**Risk : Reward = 1 : 2**

Actual historical results were:

| Metric | Result |
|---|---:|
| Average Profit Trade | `$6.24` |
| Average Loss Trade | `-$3.19` |
| Largest Profit Trade | `$35.88` |
| Largest Loss Trade | `-$42.23` |

The average winner is substantially larger than the average loser.

However, the low win rate prevents this advantage from producing positive expectancy.

This is an important finding.

The baseline failure cannot be explained simply by winners being too small relative to losers.

The entry logic generates too many losing trades for the current payoff structure.

---

## 10. Losing Sequence Analysis

The Strategy Tester recorded:

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | `8` |
| Maximum Consecutive Losses | `30` |
| Maximum Consecutive Profit | `$50.01` |
| Maximum Consecutive Loss | `-$92.80` |
| Average Consecutive Wins | `1` |
| Average Consecutive Losses | `3` |

The maximum losing streak reached:

**30 consecutive losing trades**

The average sequence was:

- 1 consecutive winning trade
- 3 consecutive losing trades

This indicates that losing signals frequently occur in clusters.

A future research question is therefore:

> Are HH/HL and LH/LL signals failing systematically during specific market regimes?

Possible regimes for later testing include:

- Sideways markets
- Weak trends
- Low volatility
- Structure-transition periods
- False breakouts
- Noisy M1 price action

These are research hypotheses only and are not yet validated conclusions.

---

## 11. Trade Frequency Observation

The baseline generated:

**6,651 trades**

during the test period.

Average position holding time:

**00:03:47**

Minimum holding time:

**00:00:06**

Maximum holding time:

**03:45:55**

EA-035 therefore behaves as a short-duration intraday strategy when operating on M1.

The simple market-structure detector converts a large number of structures directly into trades.

This creates an important research question:

> Is the underlying HH/HL structure useful, but the EA is trading too many low-quality structures?

The next research stages should investigate signal quality before introducing unnecessary strategy complexity.

---

## 12. Balance Curve Observation

The balance curve shows a persistent long-term decline.

The Strategy Tester reports:

**LR Correlation = -0.91**

The account experiences temporary recoveries during the test, but none develop into a sustained upward trend.

The balance eventually approaches complete depletion.

This behavior indicates that the negative result is not caused only by one isolated catastrophic trade.

The strategy demonstrates persistent negative performance across the test sample.

---

## 13. MFE / MAE Observation

The Strategy Tester reports:

| Correlation | Value |
|---|---:|
| Profit vs MFE | `0.84` |
| Profit vs MAE | `0.72` |
| MFE vs MAE | `0.5059` |

### MFE

MFE — Maximum Favorable Excursion — measures the maximum favorable price movement experienced while a position remains open.

The reported correlation is:

**Correlation (Profit, MFE) = 0.84**

Trades experiencing larger favorable movements generally produce larger realized profits.

This makes MFE useful for later research into exit management.

### MAE

MAE — Maximum Adverse Excursion — measures the maximum adverse price movement experienced while a position remains open.

The supplied backtest provides useful MAE data for future analysis of Stop Loss placement and losing-trade behavior.

However, this baseline does not establish that changing Stop Loss, Take Profit, Break Even, or Trailing Stop would improve performance.

Those changes require independent experiments.

---

## 14. Trading-Time Observation

The Strategy Tester shows entries distributed across multiple trading hours.

The baseline does not contain a dedicated trading-session filter.

Signals therefore occur across broad intraday periods associated with:

- Asia
- Europe
- USA

Trading activity is also distributed across the working week.

The supplied distribution shows substantial activity from Monday through Friday.

This creates another possible research question:

> Does HH/HL structure quality vary materially by trading session or time of day?

The baseline does not provide enough evidence to select a preferred session without additional controlled testing.

---

## 15. Core Research Finding

EA-035-B00 establishes the following:

**Raw HH/HL and LH/LL market structure can generate directional trading signals, but those signals are not sufficiently selective to produce positive expectancy under the tested XAUUSD M1 configuration.**

The result can be summarized as:

Market Structure  
↓  
HH + HL / LH + LL detected  
↓  
Directional trades generated  
↓  
6,651-trade historical sample  
↓  
Win Rate = 32.22%  
↓  
Profit Factor = 0.93  
↓  
Maximum Drawdown = 99.49%  
↓  
**BASELINE FAIL**

The value of EA-035-B00 is therefore not profitability.

Its value is establishing a measurable reference point for future experiments.

---

## 16. Current Research Question

The primary next question is:

> Can low-quality HH/HL and LH/LL signals be filtered while preserving useful market-structure signals?

This should be investigated before redesigning the entire strategy.

The existing market-structure detector should remain the control variable while individual filters are tested independently.

---

## 17. Research Hypothesis H1 — Higher-Timeframe Context

### Hypothesis

M1 market structure may generate false signals when it conflicts with the broader market direction.

Possible rule:

- BUY only when higher-timeframe structure is bullish.
- SELL only when higher-timeframe structure is bearish.

### Research Question

> Does higher-timeframe alignment improve the quality of M1 HH/HL and LH/LL signals?

### Status

**NOT TESTED**

No conclusion should be made until a controlled backtest is completed.

---

## 18. Research Hypothesis H2 — Structure Strength

The baseline only checks whether the latest swing is above or below the previous swing.

It does not measure how significant that difference is.

For example:

HH by a very small distance

and

HH by a large structural distance

are both classified simply as HH.

### Hypothesis

Very small HH, HL, LH, or LL changes may represent market noise rather than meaningful structural movement.

Potential measurements include:

- HH distance
- HL distance
- LH distance
- LL distance
- Minimum swing distance

### Research Question

> Does requiring a minimum structural distance reduce low-quality signals?

### Status

**NOT TESTED**

---

## 19. Research Hypothesis H3 — Volatility

The baseline does not distinguish between high-volatility and low-volatility environments.

### Hypothesis

HH/HL and LH/LL signals may perform differently depending on current market volatility.

ATR could later be used as a simple volatility measurement.

### Research Question

> Does filtering unsuitable volatility regimes improve market-structure signal quality?

### Status

**NOT TESTED**

---

## 20. Research Hypothesis H4 — Trading Session

The baseline trades across multiple hours of the day.

### Hypothesis

HH/HL and LH/LL signals may have different expectancy during different trading sessions.

Potential research groups:

- Asia
- London / Europe
- New York / USA

### Research Question

> Does restricting execution to specific trading sessions improve expectancy?

### Status

**NOT TESTED**

---

## 21. Research Hypothesis H5 — Entry Confirmation

The baseline converts detected market structure directly into a trading signal.

### Hypothesis

Additional continuation confirmation after HH/HL or LH/LL may reduce premature entries and false structural signals.

### Research Question

> Does waiting for confirmation after structure detection improve signal quality?

### Status

**NOT TESTED**

---

## 22. Research Hypothesis H6 — Exit Management

The baseline backtest used:

- Break Even: `OFF`
- Trailing Stop: `OFF`

The source supports both features, but they were not part of EA-035-B00.

Potential experiments include:

1. Fixed SL/TP baseline
2. Fixed SL/TP + Break Even
3. Fixed SL/TP + Trailing Stop

### Research Question

> Can exit management improve realized expectancy without changing the underlying entry signal?

### Status

**NOT TESTED**

Exit-management experiments should initially remain separate from entry-filter experiments.

Changing entry and exit logic simultaneously would make it difficult to identify which modification caused the result.

---

## 23. Experiment Method

Each experiment should modify one major variable whenever practical.

Preferred process:

Baseline  
↓  
Define one hypothesis  
↓  
Modify one major variable  
↓  
Backtest using controlled conditions  
↓  
Record metrics  
↓  
Compare with baseline  
↓  
PASS / FAIL hypothesis  
↓  
Preserve artifact and evidence

Avoid experiments such as:

Trend Filter  
+ ATR Filter  
+ Session Filter  
+ New Stop Loss  
+ New Take Profit  
+ Break Even  
+ Trailing Stop  
↓  
Single Backtest

Even if such a configuration performs better, it would be difficult to determine which component created the improvement.

---

## 24. Baseline Metrics for Future Comparison

Every future EA-035 experiment should be compared against EA-035-B00.

| Metric | EA-035-B00 |
|---|---:|
| Net Profit | `-$994.57` |
| Gross Profit | `$13,381.72` |
| Gross Loss | `-$14,376.29` |
| Profit Factor | `0.93` |
| Expected Payoff | `-$0.15` |
| Maximum Drawdown | `99.49%` |
| Win Rate | `32.22%` |
| Total Trades | `6,651` |
| Average Profit Trade | `$6.24` |
| Average Loss Trade | `-$3.19` |
| Maximum Consecutive Losses | `30` |
| Sharpe Ratio | `-5.00` |
| Recovery Factor | `-0.94` |
| LR Correlation | `-0.91` |

Future experiments should not be judged using Net Profit alone.

At minimum, compare:

- Profit Factor
- Expected Payoff
- Maximum Drawdown
- Total Trades
- Win Rate
- Average Winner
- Average Loser
- Maximum Losing Streak
- Sharpe Ratio
- Recovery Factor

---

## 25. Experiment Log

| Experiment ID | Description | Status | Result |
|---|---|---|---|
| `EA-035-B00` | Raw HH/HL + LH/LL baseline | COMPLETE | FAIL |
| `EA-035-E01` | First isolated improvement | NOT STARTED | — |
| `EA-035-E02` | Second isolated improvement | NOT STARTED | — |
| `EA-035-E03` | Third isolated improvement | NOT STARTED | — |

---

## 26. EA-035-B00 Record

### Experiment

Raw HH/HL and LH/LL market-structure baseline.

### Symbol

`XAUUSD.PRO`

### Timeframe

`M1`

### Period

`2026.01.02 – 2026.04.01`

### Sample

`6,651 trades`

### Profit Factor

`0.93`

### Win Rate

`32.22%`

### Net Profit

`-$994.57`

### Maximum Drawdown

`99.49%`

### Result

**FAIL**

### Conclusion

Raw HH/HL and LH/LL structure is insufficient as a standalone entry strategy under the tested XAUUSD M1 configuration.

---

## 27. Research Status Definitions

### NOT STARTED

The hypothesis has been identified but no controlled implementation and backtest have been completed.

### TESTING

Implementation or backtesting is currently in progress.

### FAIL

The experiment does not demonstrate the required improvement or produces unacceptable deterioration in other important metrics.

Examples include:

- Profit Factor remains below 1.
- Expected Payoff remains negative.
- Drawdown remains extreme.
- Improvement depends on an insignificant trade sample.
- Risk increases disproportionately to return.

### CANDIDATE

The experiment demonstrates meaningful improvement and is worth further validation.

Possible characteristics include:

- Positive expectancy
- Profit Factor above 1
- Substantially reduced drawdown
- Meaningful trade sample
- Improved risk-adjusted performance

A CANDIDATE is not automatically considered robust or suitable for live trading.

### PASS

An experiment should only receive PASS status after:

- The intended artifact exists.
- The backtest completed successfully.
- Required metrics were recorded.
- Evidence was preserved.
- Predefined acceptance criteria were satisfied.
- The result was reviewed and approved.

A profitable backtest alone is not sufficient evidence for production use.

---

## 28. Overfitting Control

EA-035 research should not repeatedly modify parameters simply to maximize performance on the same historical period.

Avoid:

Backtest  
↓  
Adjust parameters until result improves  
↓  
Backtest same period  
↓  
Adjust again  
↓  
Repeat until profitable

This can create a strategy fitted to historical noise.

Preferred process:

Define Hypothesis  
↓  
Define Experiment  
↓  
Define Comparison Metrics  
↓  
Implement  
↓  
Backtest  
↓  
Record Result  
↓  
Accept or Reject Hypothesis

Only variants that demonstrate meaningful improvement should proceed to additional validation.

---

## 29. Development Stages

EA-035 should progress through the following stages:

### Stage 1 — Baseline

Status: **COMPLETE**

Objective:

Determine whether raw HH/HL and LH/LL structure provides a standalone edge.

Result:

**FAIL**

### Stage 2 — Controlled Experiments

Status: **NOT STARTED**

Objective:

Test individual hypotheses designed to improve signal quality or trade management.

### Stage 3 — Candidate Selection

Status: **NOT STARTED**

Objective:

Identify variants that demonstrate positive expectancy and materially better risk characteristics.

### Stage 4 — Robustness Testing

Status: **NOT STARTED**

Potential future tests may include:

- Different historical periods
- Out-of-sample data
- Different market regimes
- Parameter sensitivity
- Different broker conditions
- Different spread conditions

These tests should only be introduced after a simple candidate first demonstrates a measurable improvement.

### Stage 5 — Forward / Demo Validation

Status: **NOT STARTED**

Only research candidates that survive historical robustness testing should proceed to forward validation.

### Stage 6 — Live Trading

Status: **NOT APPROVED**

EA-035 currently has no evidence supporting live deployment.

---

## 30. Research Roadmap

Current position:

EA-035  
│  
├── B00 — Raw HH/HL Baseline  
│   └── FAIL  
│  
├── E01 — Controlled Experiment  
│   └── NOT STARTED  
│  
├── E02 — Controlled Experiment  
│   └── NOT STARTED  
│  
├── E03 — Controlled Experiment  
│   └── NOT STARTED  
│  
├── Candidate Selection  
│   └── NOT STARTED  
│  
├── Robustness Testing  
│   └── NOT STARTED  
│  
├── Forward Validation  
│   └── NOT STARTED  
│  
└── Live Deployment  
    └── NOT APPROVED

---

## 31. Repository Relationship

EA-035 research artifacts are separated by purpose:

xauusd-mt5-ea-research/  
│  
├── EAs/  
│   └── EA-035_HH_HL_Structure/  
│       ├── EA-035_HH_HL_Structure.mq5  
│       └── README.md  
│  
├── Backtest/  
│   └── EA-035_HH_HL_Structure/  
│       ├── README.md  
│       ├── Strategy Tester Report  
│       └── Backtest Charts  
│  
└── Research/  
    └── README.md

### EAs

Contains the EA implementation and technical strategy documentation.

### Backtest

Contains historical test evidence, Strategy Tester reports, charts, and measured performance.

### Research

Contains:

- Research objective
- Baseline findings
- Research questions
- Hypotheses
- Experiment history
- PASS / FAIL logic
- Future research direction

---

## 32. Current Research Status

| Item | Status |
|---|---|
| EA Implementation | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Analysis | COMPLETE |
| Baseline Result | FAIL |
| Next Experiment | NOT SELECTED |
| Optimization | NOT STARTED |
| Robustness Testing | NOT STARTED |
| Forward Testing | NOT STARTED |
| Live Trading | NOT APPROVED |

Current established finding:

> Raw HH/HL and LH/LL market structure alone does not demonstrate a viable trading edge in the tested XAUUSD.PRO M1 baseline.

---

## 33. Final Conclusion

EA-035 successfully establishes a measurable baseline for a simple HH/HL and LH/LL market-structure hypothesis.

The baseline produced:

- `6,651` trades
- `32.22%` win rate
- `67.78%` loss rate
- `0.93` Profit Factor
- `-$0.15` Expected Payoff
- `-$994.57` Total Net Profit
- `99.49%` Maximum Drawdown
- `-5.00` Sharpe Ratio

The evidence does not support using raw HH/HL and LH/LL classification alone as a viable XAUUSD M1 trading strategy under the tested configuration.

The experiment is therefore classified:

**EA-035-B00 — FAIL**

However, the experiment provides a useful research baseline.

The next stage should not attempt to optimize everything simultaneously.

The correct research progression is:

Baseline preserved  
↓  
Identify one failure hypothesis  
↓  
Modify one major variable  
↓  
Backtest  
↓  
Compare against EA-035-B00  
↓  
Record evidence  
↓  
Accept or reject the hypothesis

EA-035-B00 remains the reference point for all subsequent EA-035 experiments.

---

## Disclaimer

This repository contains quantitative trading research and historical simulations.

Historical and backtested performance does not guarantee future results.

Broker specifications, spread, slippage, commissions, execution conditions, historical data quality, market regime, liquidity, and other factors can materially affect trading performance.

EA-035 is currently a research system and is not approved for live trading.
