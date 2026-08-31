# Research — EA-036 Swing Break Trend

## Research Overview

This document tracks the research process for **EA-036 — Swing Break Trend**.

The strategy tests a simple market-structure breakout hypothesis on XAUUSD:

> A confirmed Swing High or Swing Low may represent a meaningful market structure level, and a breakout beyond that level may lead to directional price continuation.

The baseline strategy therefore follows two primary entry rules:

- Break above a confirmed Swing High → BUY
- Break below a confirmed Swing Low → SELL

The purpose of this research is not to immediately search for profitable parameter combinations. The first objective is to determine whether the underlying Swing Break entry concept contains a measurable trading edge.

---

## Research Status

**Current Research Status:** `IN PROGRESS`

**Baseline #01 Status:** `COMPLETED — FAIL`

**Optimization Status:** `BLOCKED — Controlled research required before parameter optimization`

The baseline implementation successfully executed trades and completed a large-sample MT5 backtest, but the tested configuration did not demonstrate positive expectancy.

---

## Core Research Hypothesis

### H1 — Swing Break Continuation

The primary hypothesis is:

> When price breaks a confirmed Swing High or Swing Low, the breakout may indicate directional continuation strong enough to produce positive expectancy.

The strategy implements this concept as:

    Swing High confirmed
            │
            ▼
    Ask > Swing High
            │
            ▼
           BUY

and:

    Swing Low confirmed
            │
            ▼
    Bid < Swing Low
            │
            ▼
           SELL

The baseline is intentionally simple so the standalone Swing Break hypothesis can be evaluated before additional filters are introduced.

---

## Swing Definition

The baseline uses:

    InpSwingBars = 5

A Swing High is identified when the candidate candle has a High greater than the Highs of the configured number of candles on both sides.

A Swing Low is identified when the candidate candle has a Low lower than the Lows of the configured number of candles on both sides.

With `InpSwingBars = 5`, the candidate swing is evaluated against five candles on each side.

The resulting confirmed Swing High and Swing Low become structural breakout levels used by the entry logic.

---

## Baseline Strategy

The baseline research flow is:

    Price Data
        │
        ▼
    Detect Swing High / Swing Low
        │
        ▼
    Wait for Breakout
        │
        ├── Break Swing High → BUY
        │
        └── Break Swing Low  → SELL
        │
        ▼
    Fixed Stop Loss / Take Profit
        │
        ▼
    Position Management
        │
        ▼
    Trailing Stop

The baseline does not use a separate trend indicator to validate breakout direction.

This means Baseline #01 primarily evaluates the standalone Swing Break concept under the tested configuration.

---

## Baseline #01 Configuration

    EA:                   EA-036_Swing_Break_Trend
    Symbol:               XAUUSD.PRO
    Timeframe:            M1
    Test Period:          2026-01-02 → 2026-04-01
    Data Quality:         100% real ticks

    Initial Deposit:      $1,000
    Leverage:             1:500

    Lot Size:             0.01
    Magic Number:         123456
    Slippage:             10

    Stop Loss:            300
    Take Profit:          600

    Break Even:           OFF
    BE Trigger:           150
    BE Lock:              0

    Trailing Stop:        ON
    Trailing Start:       200
    Trailing Step:        50

    Maximum Spread:       35
    Swing Bars:           5

---

## Baseline #01 Results

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Trades | 4,573 |
| Total Deals | 9,146 |
| Net Profit | **-$994.01** |
| Gross Profit | $7,676.10 |
| Gross Loss | -$8,670.11 |
| Profit Factor | **0.89** |
| Expected Payoff | **-$0.22** |
| Recovery Factor | **-0.97** |
| Sharpe Ratio | **-5.00** |
| Maximum Drawdown | **99.42%** |
| Winning Trades | 1,845 |
| Losing Trades | 2,728 |
| Win Rate | **40.35%** |

**Baseline #01 Result:** `FAIL`

The tested configuration does not demonstrate positive expectancy.

---

## Directional Results

### BUY

    Long Trades = 2,436
    Win Rate    = 43.06%

### SELL

    Short Trades = 2,137
    Win Rate     = 37.25%

The baseline therefore shows:

    BUY Win Rate  = 43.06%
    SELL Win Rate = 37.25%

BUY trades achieved a higher win rate than SELL trades in this test.

This is treated only as a research observation. It does not establish that BUY-only trading is profitable.

---

## Payoff Analysis

Average profitable trade:

    +$4.16

Average losing trade:

    -$3.18

Approximate average win/loss magnitude ratio:

    4.16 / 3.18 ≈ 1.31

The average winning trade was therefore larger than the average losing trade.

However:

    Overall Win Rate = 40.35%

was insufficient to overcome the frequency of losing trades.

The resulting baseline performance remained:

    Profit Factor   = 0.89
    Expected Payoff = -$0.22

The strategy therefore demonstrated negative expectancy under the tested configuration.

---

## Drawdown Analysis

Maximum Drawdown:

    99.42%

The balance curve showed persistent deterioration throughout the test rather than a stable profitable curve damaged by one isolated loss.

The reported:

    LR Correlation = -0.97

is consistent with the strong downward direction of the balance curve.

The strategy generated:

    4,573 trades

and still produced a near-total loss of the initial account.

This indicates that the baseline failure occurred across a substantial sample rather than being determined by only a small number of trades.

---

## Trade Frequency Observation

The EA generated:

    4,573 trades

during approximately three months of M1 testing.

Holding-time statistics:

    Minimum Holding Time = 00:00:33
    Average Holding Time = 00:03:04
    Maximum Holding Time = 02:28:03

The current implementation therefore behaves as a relatively high-frequency, short-duration breakout strategy when applied to XAUUSD.PRO M1.

This creates an important research question:

> Does M1 produce too many low-quality Swing Break signals, and does the structural breakout concept become more effective on higher timeframes?

This must be tested through controlled experiments rather than assumed from the baseline result.

---

## Baseline Research Conclusion

Baseline #01 is rejected as a profitable candidate.

    Net Profit      = -$994.01
    Profit Factor   = 0.89
    Expected Payoff = -$0.22
    Sharpe Ratio    = -5.00
    Maximum DD      = 99.42%

The current evidence supports the following conclusion:

> The tested Swing High / Swing Low breakout rule does not demonstrate a viable standalone trading edge on XAUUSD.PRO M1 under Baseline #01.

This does not establish that every Swing Break strategy is unprofitable.

The conclusion applies only to the tested implementation, market, timeframe, period and configuration.

---

## Research Questions

Further research should isolate individual hypotheses rather than immediately performing broad parameter optimization.

### RQ-01 — BUY vs SELL Directional Evaluation

Baseline observation:

    BUY Win Rate  = 43.06%
    SELL Win Rate = 37.25%

Research question:

> Does negative expectancy originate disproportionately from one trading direction?

Required controlled comparison:

    A — BUY + SELL
        Existing Baseline #01

    B — BUY ONLY

    C — SELL ONLY

All other relevant parameters should remain identical to Baseline #01.

The objective is to compare Net Profit, Profit Factor, Expected Payoff, Drawdown and trade count rather than comparing win rate alone.

A higher BUY win rate does not automatically mean BUY-only trading has positive expectancy.

---

### RQ-02 — Timeframe Evaluation

Baseline:

    Timeframe = M1
    Trades    = 4,573

Research question:

> Does Swing Break structure become more meaningful when market noise is reduced on higher timeframes?

Candidate controlled comparison:

    M1
    M5
    M15

The core Swing Break entry logic should remain unchanged during this experiment.

The purpose is to determine whether breakout quality changes systematically with timeframe.

---

### RQ-03 — Swing Strength Evaluation

Baseline:

    InpSwingBars = 5

Research question:

> Does requiring a stronger confirmed swing structure improve breakout quality?

Candidate controlled values:

    SwingBars = 3
    SwingBars = 5
    SwingBars = 7
    SwingBars = 10

The objective is not to immediately select whichever value generates the highest historical profit.

The objective is to determine whether strategy behavior changes consistently as swing confirmation becomes weaker or stronger.

---

### RQ-04 — Trend Filter Evaluation

The baseline enters after a Swing High or Swing Low breakout without requiring an independent trend confirmation.

Research question:

> Does restricting Swing Break entries to the prevailing trend improve expectancy?

A future trend-filter experiment should modify only the trend-confirmation component while preserving the remaining baseline logic wherever possible.

Trend filtering should be evaluated after the basic directional and timeframe behavior of the strategy is understood.

---

### RQ-05 — Trading Hour / Session Evaluation

Baseline trades occurred across much of the trading day.

Research question:

> Are Swing Break signals materially stronger or weaker during particular trading sessions?

Candidate groups:

    Asia
    Europe
    USA

Alternatively, exact server-time windows may be defined for reproducible testing.

No trading session should be removed solely because a chart visually appears weaker.

Each session hypothesis must be tested independently.

---

### RQ-06 — Exit Logic Evaluation

Baseline exit configuration:

    Stop Loss      = 300
    Take Profit    = 600

    Break Even     = OFF

    Trailing Stop  = ON
    Trailing Start = 200
    Trailing Step  = 50

Research question:

> Is negative expectancy primarily caused by entry quality or by the current exit logic?

Candidate controlled comparisons:

    A — Fixed SL / TP only

    B — Fixed SL / TP
        + Break Even

    C — Fixed SL / TP
        + Trailing Stop

    D — Fixed SL / TP
        + Break Even
        + Trailing Stop

Only one controlled change should be evaluated at a time.

Exit optimization should not be used to hide a fundamentally weak entry signal.

---

## Research Sequence

The planned research sequence is:

    Baseline #01
         │
         │ FAIL
         ▼
    RQ-01
    BUY vs SELL
         │
         ▼
    RQ-02
    Timeframe
         │
         ▼
    RQ-03
    Swing Strength
         │
         ▼
    RQ-04
    Trend Filter
         │
         ▼
    RQ-05
    Trading Session
         │
         ▼
    RQ-06
    Exit Logic
         │
         ▼
    Out-of-Sample Validation
         │
         ▼
    Forward Testing
         │
         ▼
    Consider Optimization

The purpose of this sequence is to understand why the strategy succeeds or fails before searching for optimized parameter combinations.

---

## Optimization Policy

Broad parameter optimization is currently:

    BLOCKED

Do not simultaneously optimize variables such as:

    SwingBars
    Stop Loss
    Take Profit
    Break Even
    Trailing Stop
    Maximum Spread
    Timeframe
    Trading Hours
    Trend Filters

A large optimization sweep could discover a historically profitable combination without establishing whether the underlying Swing Break concept has a robust edge.

Controlled research must come first.

---

## Research Rules

Each experiment should follow these rules:

1. Define one research question.
2. Use Baseline #01 as the reference.
3. Change only the variable required by the hypothesis whenever possible.
4. Keep all unrelated parameters unchanged.
5. Use documented MT5 test settings.
6. Save the original Strategy Tester evidence.
7. Compare the experiment directly against the baseline.
8. Record both profitability and risk metrics.
9. Preserve failed experiments as research evidence.
10. Do not mark an experiment PASS based only on positive Net Profit.
11. Do not perform broad optimization before the core hypothesis has been evaluated.
12. Do not approve the strategy for live trading from backtesting alone.

---

## Minimum Evaluation Metrics

Every experiment should record at least:

    Net Profit
    Gross Profit
    Gross Loss
    Profit Factor
    Expected Payoff
    Maximum Drawdown
    Sharpe Ratio
    Total Trades
    Winning Trades
    Losing Trades
    Win Rate
    Average Winning Trade
    Average Losing Trade
    BUY Performance
    SELL Performance

Additional metrics may be added when required by the specific research question.

---

## PASS / FAIL Principle

An experiment should not automatically PASS because:

    Net Profit > 0

Evaluation should consider at minimum:

    Profit Factor
    Expected Payoff
    Maximum Drawdown
    Sharpe Ratio
    Trade Count
    Balance Curve
    Stability of Results

A historically profitable configuration with unacceptable drawdown or an insufficient sample should not automatically be accepted.

Likewise, an improvement over Baseline #01 does not automatically mean the strategy is ready for deployment.

---

## Current Research Checklist

- [x] Strategy code and technical specifications documented (`EAs/EA-036_Swing_Break_Trend/`)
- [x] Baseline Backtest #01 completed (`Backtest/EA-036_Swing_Break_Trend/`)
- [x] Baseline #01 evaluated
- [x] Baseline #01 result recorded as **FAIL**
- [x] Baseline research findings documented
- [ ] RQ-01: BUY vs SELL Directional Evaluation
- [ ] RQ-02: Timeframe Evaluation
- [ ] RQ-03: Swing Strength Evaluation
- [ ] RQ-04: Trend Filter Evaluation
- [ ] RQ-05: Trading Hour / Session Evaluation
- [ ] RQ-06: Exit Logic Evaluation
- [ ] Out-of-Sample Validation
- [ ] Forward Testing
- [ ] Live Deployment Evaluation

---

## Current Research State

    EA-036 — Swing Break Trend
    │
    ├── Strategy Code
    │      └── COMPLETE
    │
    ├── Baseline Backtest #01
    │      └── COMPLETE
    │
    ├── Baseline Evaluation
    │      └── FAIL
    │
    ├── Research
    │      └── IN PROGRESS
    │             │
    │             └── NEXT: RQ-01 BUY vs SELL
    │
    ├── Optimization
    │      └── BLOCKED
    │
    ├── Out-of-Sample Validation
    │      └── NOT STARTED
    │
    ├── Forward Testing
    │      └── NOT STARTED
    │
    └── Live Deployment
           └── NOT APPROVED

---

## Next Research Step

The next controlled research task is:

**RQ-01 — BUY vs SELL Directional Evaluation**

Required comparison:

    Test A
    BUY + SELL
    = Existing Baseline #01

    Test B
    BUY ONLY

    Test C
    SELL ONLY

All other relevant test conditions should remain identical to Baseline #01.

The experiment should determine whether the directional difference observed in Baseline #01 represents a meaningful difference in expectancy rather than only a difference in win rate.

Broad parameter optimization must remain blocked until the controlled research questions are completed.

---

## Repository References

    xauusd-mt5-ea-research/
    │
    ├── EAs/
    │   └── EA-036_Swing_Break_Trend/
    │       ├── EA-036_Swing_Break_Trend.mq5
    │       └── README.md
    │
    ├── Backtest/
    │   └── EA-036_Swing_Break_Trend/
    │       ├── README.md
    │       └── MT5 Strategy Tester evidence
    │
    ├── Research/
    │   └── README.md
    │
    └── docs/
        └── methodology.md

---

## Final Research Status

    EA:                  EA-036_Swing_Break_Trend
    Strategy:            Swing Break Trend
    Market:              XAUUSD.PRO
    Baseline Timeframe:  M1

    Baseline Trades:     4,573
    Baseline Net Profit: -$994.01
    Baseline PF:         0.89
    Baseline Win Rate:   40.35%
    Baseline Max DD:     99.42%

    BASELINE:            FAIL
    RESEARCH:            IN PROGRESS
    OPTIMIZATION:        BLOCKED
    NEXT:                RQ-01 BUY vs SELL
    LIVE TRADING:        NOT APPROVED

---

## Disclaimer

This repository documents quantitative strategy research.

Failed backtests are retained as research evidence and should not be removed simply because the strategy was unprofitable.

Historical or simulated performance does not guarantee future results.

EA-036 remains a research strategy and is not approved for live trading.
