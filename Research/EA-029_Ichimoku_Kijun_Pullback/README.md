# Research — XAUUSD MT5 EA

## Purpose

This directory documents the research process used to evaluate and improve the Expert Advisors in this repository.

Each EA starts from a clearly defined baseline implementation. Backtest results are then used to identify weaknesses, formulate testable hypotheses, and determine whether further development is justified.

The objective is not to optimize historical performance blindly, but to determine whether a trading idea demonstrates a repeatable and sufficiently robust statistical edge.

---

# EA-029 — Ichimoku Kijun Pullback

## Research Question

Can a simple Kijun-sen pullback strategy on XAUUSD produce a sufficiently stable trading edge to justify further development?

The baseline strategy tests the following concept:

```text
Trend relative to Kijun
        ↓
Price pulls back toward Kijun
        ↓
Price rejects Kijun
        ↓
Close returns in trend direction
        ↓
BUY / SELL
```

The first experiment intentionally uses a relatively simple implementation so that the behavior of the core signal can be measured before additional filters are introduced.

---

## Baseline Strategy

EA:

```text
EA-029_Ichimoku_Kijun_Pullback
```

Core indicator:

```text
Ichimoku Kinko Hyo

Tenkan-sen    = 9
Kijun-sen     = 26
Senkou Span B = 52
```

The entry logic primarily uses price interaction with the **Kijun-sen**.

The baseline does not require:

- Tenkan/Kijun crossover confirmation
- Kumo/cloud confirmation
- higher-timeframe confirmation
- trading-session filtering

This allows the first test to measure the raw Kijun pullback concept with limited additional filtering.

---

# Baseline Backtest

## Test Environment

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.03.01 |
| Initial Deposit | $100 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 60 points |
| Break Even | Disabled |
| Trailing Stop | Disabled |
| Data Quality | 100% real ticks |

---

## Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 1,769 |
| Net Profit | -$22.77 |
| Profit Factor | 0.99 |
| Expected Payoff | -$0.01 |
| Sharpe Ratio | -0.95 |
| Winning Trades | 32.90% |
| Losing Trades | 67.10% |
| Balance Drawdown | 89.77% |
| Equity Drawdown | 91.54% |

Directional results:

| Direction | Trades | Win Rate |
|---|---:|---:|
| SELL | 909 | 34.98% |
| BUY | 860 | 30.70% |

Trade payoff:

| Metric | Result |
|---|---:|
| Average Winner | $6.34 |
| Average Loser | -$3.13 |
| Largest Winner | $35.35 |
| Largest Loser | -$8.79 |
| Maximum Consecutive Losses | 17 |

---

# Baseline Assessment

## Result: FAIL

The baseline configuration does not demonstrate an acceptable trading edge.

The main problems are:

```text
Profit Factor       = 0.99
Net Profit          = negative
Expected Payoff     = negative
Sharpe Ratio        = negative
Equity Drawdown     = 91.54%
```

The strategy therefore should **not** be considered suitable for live trading in its current form.

However, the baseline generated 1,769 trades, providing enough observations to investigate how the underlying signal behaves under different market conditions.

---

# Key Observations

## 1. Raw Kijun Pullback Is Not Sufficient

The baseline takes Kijun pullbacks with limited contextual confirmation.

The resulting:

```text
Profit Factor = 0.99
```

suggests that the raw entry condition alone did not produce a meaningful positive expectancy during this test.

This establishes an important baseline:

> Kijun interaction by itself is not sufficient evidence of a robust trading edge in this test.

---

## 2. Win Rate Is Low

The strategy produced:

```text
Winning Trades = 32.90%
Losing Trades  = 67.10%
```

The strategy therefore depends heavily on winners being larger than losers.

Average trade results support this structure:

```text
Average Winner = $6.34
Average Loser  = -$3.13
```

The average winner was approximately twice the size of the average loser.

However, this payoff relationship was not enough to overcome the frequency of losing trades.

---

## 3. Drawdown Is the Primary Risk Problem

The most serious baseline result is:

```text
Balance Drawdown = 89.77%
Equity Drawdown  = 91.54%
```

This is unacceptable for practical deployment.

Future research must therefore evaluate not only profitability but also whether modifications materially reduce drawdown.

A higher net profit alone is not sufficient evidence of improvement.

---

## 4. SELL Performed Better Than BUY

Baseline directional win rates:

```text
SELL = 34.98%
BUY  = 30.70%
```

SELL signals performed slightly better during the tested period.

This difference is an observation only.

It is not sufficient evidence to conclude that XAUUSD Kijun pullbacks have a persistent short-side advantage.

The behavior should be tested over additional periods before making directional changes to the strategy.

---

## 5. Losing Streak Risk Is Significant

Maximum consecutive losses:

```text
17 trades
```

This contributes directly to the large observed drawdown.

Any future version of the strategy should be evaluated for both:

```text
Profitability
+
Loss clustering
+
Drawdown
```

rather than profitability alone.

---

# Research Hypotheses

The baseline suggests that the core problem may be excessive low-quality entries rather than simply the SL/TP configuration.

The next research stage should therefore test filters individually.

## H1 — Trend Confirmation

Question:

> Does requiring stronger trend confirmation improve Kijun pullback quality?

Potential experiment:

```text
Baseline Kijun Pullback
+
Ichimoku trend confirmation
```

Possible confirmation variables include Tenkan/Kijun relationship or price position relative to the Kumo.

Only one clearly defined modification should be tested at a time.

---

## H2 — Trading Session Filter

Question:

> Does the strategy perform differently across trading hours or sessions?

The backtest contains entry and profit/loss distributions by hour.

Potential experiment:

```text
Baseline
        ↓
Analyze performance by hour
        ↓
Identify weak/strong periods
        ↓
Retest with a predefined session filter
```

A session should not be removed simply because it performed poorly in one sample. Any candidate filter must be validated on additional data.

---

## H3 — BUY and SELL Separation

Question:

> Do BUY and SELL signals have materially different expectancy?

Current results show different win rates between the two directions.

Future tests should calculate performance independently for:

```text
BUY only
SELL only
```

before considering directional filtering.

---

## H4 — Market Regime Filter

Kijun pullback behavior may differ between trending and ranging conditions.

Research question:

> Can low-quality pullbacks during sideways markets be identified without destroying performance during trends?

Potential variables may include:

```text
Kumo structure
Kijun slope
Price distance from Kijun
Volatility
```

These are research candidates only and are not yet validated improvements.

---

# Research Rules

To reduce overfitting, future experiments should follow several basic rules.

### One hypothesis at a time

Avoid changing multiple strategy components simultaneously.

Prefer:

```text
Baseline
   ↓
Change A
   ↓
Backtest
   ↓
Compare
```

instead of:

```text
Baseline
   ↓
Change A + B + C + D
   ↓
Unknown source of improvement
```

---

### Preserve the baseline

The original baseline backtest must not be overwritten.

It serves as the control result for future experiments.

Baseline reference:

```text
EA-029
XAUUSD.PRO
M1
2026.01.02 – 2026.03.01
1,769 trades
PF 0.99
Net Profit -$22.77
Equity DD 91.54%
```

---

### Do not judge improvement by Net Profit alone

Future versions should be compared using multiple metrics:

```text
Profit Factor
Expected Payoff
Drawdown
Sharpe Ratio
Number of Trades
Win Rate
Average Win / Average Loss
Consecutive Losses
```

---

### Avoid premature optimization

Parameter optimization should not be the first response to a failed baseline.

The preferred research sequence is:

```text
Baseline
    ↓
Understand failure
    ↓
Form hypothesis
    ↓
Modify one component
    ↓
Backtest
    ↓
Compare
    ↓
Validate on unseen period
    ↓
Only then consider optimization
```

---

# Current Research Status

```text
EA-029_Ichimoku_Kijun_Pullback

[PASS] Strategy implemented
[PASS] Baseline backtest completed
[PASS] 100% real tick test completed
[PASS] Baseline performance documented

[FAIL] Baseline profitability
[FAIL] Baseline drawdown

[NEXT] Investigate improvement hypotheses
```

Current conclusion:

> The original Kijun Pullback implementation does not currently demonstrate a sufficient edge for deployment, but it provides a valid baseline for controlled research.

No improved version has yet been validated.

---

# Repository Relationship

```text
EAs/
└── EA-029_Ichimoku_Kijun_Pullback/
    ├── EA-029_Ichimoku_Kijun_Pullback.mq5
    └── README.md
                │
                ▼
Backtest/
└── EA-029_Ichimoku_Kijun_Pullback/
    ├── README.md
    └── Strategy Tester artifacts
                │
                ▼
Research/
└── README.md
        │
        ├── Baseline assessment
        ├── Research observations
        ├── Hypotheses
        └── Future experiments
```

---

## Disclaimer

This research is intended for strategy development, testing, and educational purposes.

Backtest results do not guarantee future performance.

No strategy documented in this repository should be considered suitable for live deployment until it has passed additional validation and risk assessment.
