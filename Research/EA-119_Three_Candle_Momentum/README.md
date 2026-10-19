# EA-119 — Three Candle Momentum Research Plan

## 1. Research Objective

Determine whether the Three Candle Momentum strategy can demonstrate a repeatable trading edge after addressing its negative baseline performance and excessive drawdown.

**Baseline ID:** `EA119-M1-BASELINE-001`  
**Baseline Verdict:** `FAIL`  
**Research Status:** `IN PROGRESS`  
**Live Trading:** `NOT APPROVED`

## 2. Baseline Findings

- Net Profit: -$992.47
- Profit Factor: 0.71
- Expected Payoff: -$0.37
- Sharpe Ratio: -5.00
- Maximum Equity Drawdown: 99.27%
- Total Trades: 2,650
- BUY win rate: 47.76%
- SELL win rate: 44.19%

The baseline shows no demonstrated profitability and an unacceptable drawdown profile.

## 3. Controlled Research Sequence

### RQ01 — Signal Verification

Confirm that the implementation uses completed candles and that entry signals match the documented rules.

- BUY: `Close[1] > Close[2] > Close[3]`
- SELL: `Close[1] < Close[2] < Close[3]`

Check new-bar timing, position restrictions, spread filtering, and order execution.

### RQ02 — Number of Momentum Candles

Compare a controlled set of alternatives:

- 2 consecutive rising/falling closes
- 3 consecutive rising/falling closes (baseline)
- 4 consecutive rising/falling closes
- 5 consecutive rising/falling closes

Change only the signal-length rule during this experiment.

### RQ03 — Minimum Momentum Strength

Evaluate whether a minimum price movement or total candle movement filter reduces weak signals.

Possible measures include:

- Total close-to-close movement
- Average candle range
- Minimum body size
- Movement relative to ATR

Define the exact measurement and units before running each test.

### RQ04 — Entry Confirmation

Evaluate one confirmation rule at a time:

- Minimum signal-candle body
- Minimum close-to-close movement
- Break of the previous candle's high or low
- Confirmation candle direction

Do not combine multiple new filters in the first experiment.

### RQ05 — BUY vs SELL Analysis

Test BUY and SELL signals separately using the same test period and execution assumptions.

Compare net profit, Profit Factor, expectancy, trade count, and drawdown. Do not select a direction based on win rate alone.

### RQ06 — Exit Management

After the entry rule has evidence of improvement, evaluate:

- Stop Loss and Take Profit
- Break-even activation
- Trailing-stop start
- Trailing-stop distance

Keep the original baseline settings available for comparison.

### RQ07 — Trading Session

Measure performance by trading session and time window. Confirm any improvement on data not used to choose the session filter.

### RQ08 — Market Regime

Evaluate whether momentum entries behave differently in trending, ranging, and high-volatility conditions.

### RQ09 — Out-of-Sample Validation

Test the selected configuration on a separate period that was not used for parameter selection.

### RQ10 — Robustness and Walk-Forward

Check sensitivity to nearby parameter values, different market periods, spreads, and execution assumptions. Use walk-forward testing before considering forward testing.

## 4. Experiment Rules

1. Preserve `EA119-M1-BASELINE-001` unchanged.
2. Change one logical variable group at a time.
3. Record the EA version, inputs, period, and tester settings for every run.
4. Compare drawdown, expectancy, Profit Factor, and trade count alongside net profit.
5. Do not choose parameters solely because they maximize historical net profit.
6. Do not treat a small sample or a single backtest as validation.
7. Do not begin broad optimization while the baseline remains unexplained and uncompetitive.
8. Keep out-of-sample data separate from parameter selection.

## 5. Acceptance Criteria

A candidate must demonstrate:

- Positive net expectancy after modeled trading costs.
- Profit Factor above 1 with a meaningful margin.
- Drawdown within a predefined risk limit.
- Adequate trade count and stability.
- Results that persist out of sample and under robustness checks.

Set numeric thresholds before evaluating candidate results. Passing one backtest does not authorize live deployment.

## 6. Current Status

- [x] EA source available
- [x] Baseline backtest completed
- [x] Baseline result documented
- [ ] Signal verification
- [ ] Controlled entry research
- [ ] Exit-management research
- [ ] Session and market-regime analysis
- [ ] Out-of-sample validation
- [ ] Robustness testing
- [ ] Walk-forward testing
- [ ] Forward testing

**Current Decision:** `FAIL — RESEARCH REQUIRED; LIVE TRADING NOT APPROVED`
