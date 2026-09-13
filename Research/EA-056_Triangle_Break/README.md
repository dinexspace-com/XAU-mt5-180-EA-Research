# Research — EA-056 Triangle Break

## Research ID

`EA-056_Triangle_Break`

## Research Status

**FAILED BASELINE**

The initial Triangle / Convergence Breakout hypothesis did not demonstrate a positive trading edge under the tested XAUUSD M1 configuration.

This research record is preserved as a negative experimental result.

---

## 1. Research Question

Can a short-term breakout strategy on XAUUSD become profitable by detecting price contraction before a breakout and entering only after a closed candle breaks outside the contraction zone?

The core hypothesis was:

> Price contraction represents temporary market compression. A confirmed breakout from that compressed range may precede a directional price expansion large enough to produce a tradable edge.

---

## 2. Target Market

The experiment was designed for:

- Instrument: XAUUSD
- Platform: MetaTrader 5
- Trading style: short-term / intraday
- Primary tested timeframe: M1
- Direction: BUY and SELL
- Position sizing: fixed lot

The tested broker symbol was:

`XAUUSD.PRO`

---

## 3. Strategy Hypothesis

The strategy is based on the following sequence:

**Price Expansion → Price Contraction → Confirmed Breakout → Market Entry**

Instead of detecting a geometric triangle using manually drawn trendlines, the baseline EA approximates triangle-style compression using a measurable convergence zone.

The recent price range is compared with an older price range. If the recent range contracts sufficiently, the market is considered to be in a convergence state.

The EA then waits for price to close outside the convergence zone.

---

## 4. Convergence Model

Two price windows are used:

**Older Comparison Window → Recent Convergence Window → Breakout Candle**

Baseline parameters:

| Parameter | Value |
|---|---:|
| Recent Zone Bars | 10 |
| Comparison Bars | 10 |
| Convergence Ratio | 0.70 |
| Minimum Zone Size | 30 points |
| Maximum Zone Size | 500 points |
| Breakout Buffer | 5 points |

The basic contraction requirement is:

`Recent Range <= Older Range × 0.70`

A recent price range therefore needs to contract to no more than 70% of the older reference range before it can qualify as a setup.

---

## 5. Breakout Confirmation

The strategy does not enter simply because price touches the zone boundary.

A completed candle must cross and close beyond the breakout level.

### BUY

`Previous Close > Zone High + Breakout Buffer`

AND

`Previous Open <= Zone High + Breakout Buffer`

### SELL

`Previous Close < Zone Low - Breakout Buffer`

AND

`Previous Open >= Zone Low - Breakout Buffer`

The baseline version therefore uses closed-candle confirmation to reduce entries caused by temporary intrabar price movement.

---

## 6. Baseline Risk Model

The first experiment intentionally used a simple fixed risk structure.

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |

Nominal initial reward-to-risk:

`600 / 300 = 2.0`

Additional position management:

| Parameter | Value |
|---|---:|
| Break Even | Enabled |
| BE Trigger | 150 points |
| BE Offset | 5 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 150 points |
| Trailing Step | 20 points |
| Maximum Positions | 1 |

---

## 7. Baseline Experiment

### Test Configuration

| Item | Value |
|---|---|
| EA | EA-056_Triangle_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| Tick Quality | 100% real ticks |
| Total Trades | 932 |

---

## 8. Baseline Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$263.23 |
| Gross Profit | $928.47 |
| Gross Loss | -$1,191.70 |
| Profit Factor | 0.78 |
| Expected Payoff | -$0.28 |
| Recovery Factor | -0.93 |
| Sharpe Ratio | -5.00 |
| Profit Trades | 53.00% |
| Loss Trades | 47.00% |
| Maximum Equity Drawdown | 27.78% |

Directional results:

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 467 | 51.61% |
| SELL | 465 | 54.41% |

---

## 9. Main Research Finding

The baseline produced an important result:

**Win Rate = 53.00%**

but the strategy still lost money.

The average trade outcomes were:

| Metric | Result |
|---|---:|
| Average Profit Trade | $1.88 |
| Average Loss Trade | -$2.72 |

Therefore:

**Average Loss > Average Profit**

The winning percentage alone was not sufficient to create positive expectancy.

This is reflected by:

- Profit Factor = `0.78`
- Expected Payoff = `-$0.28`
- Total Net Profit = `-$263.23`

---

## 10. Equity Behaviour

The balance curve declined persistently across the tested period.

| Metric | Result |
|---|---:|
| Initial Balance | $1,000.00 |
| Net Result | -$263.23 |
| Approximate Ending Balance | $736.77 |
| Maximum Equity Drawdown | 27.78% |

This behaviour does not support the hypothesis that the baseline convergence-breakout rules contain a sufficiently strong standalone edge.

---

## 11. What the Experiment Demonstrated

The experiment demonstrated that:

1. Convergence conditions can be converted into deterministic MQL5 rules.
2. The strategy generates a substantial number of signals on XAUUSD M1.
3. BUY and SELL signals both occur frequently.
4. The strategy can achieve a win rate above 50%.
5. A win rate above 50% does not guarantee positive expectancy.
6. The tested exit structure produced average losses larger than average wins.
7. The baseline strategy is not profitable in the tested configuration.

---

## 12. What the Experiment Did NOT Prove

The experiment does **not** prove that every Triangle Breakout strategy fails.

It only rejects the tested baseline configuration:

- EA: `EA-056_Triangle_Break`
- Symbol: `XAUUSD.PRO`
- Timeframe: `M1`
- Period: `2026-01-02 → 2026-04-01`
- Parameters: current baseline configuration

The test also does not independently establish whether the main weakness comes from:

- breakout quality;
- contraction-zone definition;
- market regime;
- entry timing;
- stop-loss placement;
- take-profit placement;
- break-even logic;
- trailing-stop behaviour;
- trading session;
- or a combination of these factors.

Those questions require separate experiments.

---

## 13. Research Interpretation

The baseline data suggests that signal frequency is not the primary problem.

The strategy generated **932 trades** during approximately three months of M1 data.

The larger issue is expectancy.

Despite a **53.00% winning-trade rate**, the combination of winning and losing trade sizes produced:

- Profit Factor < 1
- Expected Payoff < 0
- Net Profit < 0

Therefore, the current research priority should not be to increase trade frequency.

Any future version should first investigate whether signal quality and/or exit behaviour can improve expectancy.

---

## 14. Baseline Decision

### ❌ FAIL

The baseline hypothesis is rejected for the tested configuration.

Criteria supporting the decision:

| Criterion | Result |
|---|---:|
| Net Profit | < 0 |
| Profit Factor | 0.78 |
| Expected Payoff | < 0 |
| Recovery Factor | < 0 |
| Sharpe Ratio | < 0 |
| Maximum Equity Drawdown | 27.78% |

The EA should not be treated as validated for live trading.

---

## 15. Research Artifact Map

Related repository artifacts:

    EAs/
    └── EA-056_Triangle_Break/
        ├── EA-056_Triangle_Break.mq5
        └── README.md

    Backtest/
    └── EA-056_Triangle_Break/
        ├── README.md
        ├── ReportTester-952747.html
        ├── ReportTester-952747.png
        ├── ReportTester-952747-hst.png
        ├── ReportTester-952747-mfemae.png
        └── ReportTester-952747-holding.png

    Research/
    └── README.md

The original MT5 HTML report is the primary numerical evidence for the baseline backtest.

---

## 16. Current Research Conclusion

`EA-056_Triangle_Break` successfully converts the idea of price compression followed by breakout into an automated and testable trading system.

However, the first real-tick baseline test does not show a profitable edge.

The tested configuration produced:

- 932 trades
- 53.00% winning trades
- -$263.23 net profit
- 0.78 Profit Factor
- -$0.28 Expected Payoff
- 27.78% maximum equity drawdown

The experiment therefore ends with:

**EA-056 BASELINE — FAIL**

The negative result is retained because documenting failed hypotheses is part of the research process and prevents the same baseline experiment from being repeated without justification.
