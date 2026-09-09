# EA-050 — 50-Bar Donchian Breakout Research

## Research Objective

This research evaluates whether a simple 50-bar Donchian breakout strategy can provide a repeatable trading edge on XAUUSD when implemented as an MT5 Expert Advisor.

The research process is:

Baseline
→ Parameter Exploration
→ Extended Backtest
→ Out-of-Sample Test
→ Robustness Test
→ Final Conclusion

No strategy is considered validated from a single profitable backtest.

---

# 1. Strategy Hypothesis

EA-050 is based on a simple trend-following hypothesis:

> When price breaks beyond the highest or lowest price of a defined historical window, the breakout may indicate the beginning or continuation of directional price movement.

The baseline uses:

Donchian Period = 50 bars

BUY:

Current Close > Highest High of previous 50 bars

SELL:

Current Close < Lowest Low of previous 50 bars

The EA therefore attempts to participate in price expansion after a breakout rather than predict reversals.

---

# 2. Research Instrument

Primary research market:

XAUUSD

Baseline broker symbol:

XAUUSD.PRO

Baseline timeframe:

M5

The current research conclusions apply only to the tested configuration.

Results must not automatically be assumed to transfer to:

- other brokers;
- other XAUUSD contract specifications;
- other timeframes;
- other spreads;
- other market periods.

---

# 3. Baseline Configuration

| Parameter | Baseline |
|---|---:|
| Donchian Period | 50 |
| Lot Size | 0.01 |
| Maximum Spread | 30 |
| Stop Loss | 300 |
| Take Profit | 600 |
| Break Even | Enabled |
| Break Even Trigger | 150 |
| Trailing Stop | Enabled |
| Trailing Start | 200 |

Test environment:

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M5 |
| Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 17,327 |
| Ticks | 40,346,891 |

---

# 4. Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | +$8.57 |
| Profit Factor | 1.21 |
| Expected Payoff | $0.43 |
| Recovery Factor | 0.43 |
| Maximum Balance DD | 1.60% |
| Maximum Equity DD | 1.93% |
| Total Trades | 20 |
| Winning Trades | 9 |
| Losing Trades | 11 |
| Win Rate | 45.00% |
| Average Winner | +$5.51 |
| Average Loser | -$3.73 |
| Largest Winner | +$6.41 |
| Largest Loser | -$8.69 |

Baseline result:

POSITIVE

but:

NOT VALIDATED

---

# 5. Baseline Findings

## Finding 1 — Positive Expectancy Exists in the Initial Sample

The baseline finished with:

Net Profit = +$8.57
Profit Factor = 1.21
Expected Payoff = +$0.43

Therefore, the tested configuration produced positive historical expectancy during the baseline period.

However, the edge is currently weak.

A Profit Factor of 1.21 leaves limited margin for deterioration under different market conditions, execution costs, spread changes, or unseen data.

Research status:

INTERESTING — REQUIRES MORE TESTING

---

## Finding 2 — Sample Size Is Too Small

Only:

20 trades

were generated during approximately three months of M5 data.

This is insufficient for a reliable statistical conclusion.

A few trades can materially change:

- Net Profit
- Profit Factor
- Win Rate
- Drawdown
- Expected Payoff

Therefore, the current test cannot establish that the strategy possesses a persistent edge.

Research status:

INSUFFICIENT SAMPLE

---

# 6. Directional Asymmetry

The baseline produced:

| Direction | Trades | Win Rate |
|---|---:|---:|
| BUY | 15 | 53.33% |
| SELL | 5 | 20.00% |

There is a large observed difference between BUY and SELL performance.

This creates an important research question:

Does EA-050 perform better as a long-only strategy on XAUUSD?

At present the answer is:

UNKNOWN

because SELL contains only five observations.

Required later comparison:

BUY + SELL
vs
BUY only
vs
SELL only

No directional filter should be introduced solely because of the current result.

---

# 7. Reward / Loss Structure

Baseline:

Average Winner = $5.51

Average Loser = $3.73

Observed ratio:

5.51 / 3.73 ≈ 1.48

This means the strategy does not require a win rate above 50% to potentially remain profitable.

The baseline achieved:

Win Rate = 45%

while still producing:

Profit Factor = 1.21

This is consistent with a strategy where average winning trades are larger than average losing trades.

Whether this relationship persists outside the baseline period remains unverified.

---

# 8. Drawdown

Maximum Balance Drawdown:

1.60%

Maximum Equity Drawdown:

1.93%

These values are low in the baseline test.

However, the low drawdown must be interpreted together with:

20 trades
0.01 lot
$1,000 initial capital
short test period

Therefore:

LOW BASELINE DRAWDOWN ≠ PROVEN LOW-RISK STRATEGY

A longer test is required before drawdown characteristics can be assessed.

---

# 9. Consecutive Loss Risk

Maximum consecutive losses:

5 trades

Loss during that sequence:

-$16.27

With only 20 total trades, a five-loss sequence is already significant.

Future research must determine whether longer historical periods produce materially larger losing sequences.

This is important for:

- capital requirements;
- position sizing;
- psychological tolerance;
- risk limits.

---

# 10. Trade Duration Observation

Baseline holding time:

| Metric | Result |
|---|---:|
| Minimum | 00:00:01 |
| Average | 00:02:06 |
| Maximum | 00:07:07 |

This is an important finding.

Although the signal is calculated from a 50-bar Donchian breakout on M5, actual positions are held for only a few minutes.

Therefore, execution conditions may have meaningful influence on results.

Future testing should pay particular attention to:

- spread;
- slippage;
- broker execution;
- tick quality.

---

# 11. MFE / MAE Observation

MT5 baseline statistics:

Correlation (Profit, MFE) = 0.91

Correlation (Profit, MAE) = 0.77

Correlation (MFE, MAE) = 0.6840

The strong observed Profit/MFE relationship indicates that favorable price movement is closely associated with final trade outcome in this small sample.

This may later help evaluate whether:

- Take Profit is too restrictive;
- Trailing Stop is effective;
- Break Even activates too early;
- profitable breakouts should be allowed more room.

No parameter change is justified yet from this statistic alone.

---

# 12. Primary Research Variables

The strategy currently contains several parameters that can materially affect results.

Priority research variables:

1. Donchian Period
2. Stop Loss
3. Take Profit
4. Break Even Trigger
5. Trailing Start

These parameters should be researched together where appropriate because their effects can interact.

For example:

Donchian Period

changes signal frequency and breakout sensitivity.

Stop Loss

changes loss size and trade survival.

Take Profit

changes winner size.

Break Even

can reduce losses but may prematurely remove trades.

Trailing Stop

changes how much of a breakout trend can be captured.

---

# 13. Parameter Research Principle

The objective is NOT:

Find the single most profitable parameter combination.

The objective is:

Find parameter regions that remain profitable across neighboring settings.

A parameter set that performs extremely well while nearby combinations fail is potentially overfit.

Preferred evidence:

stable profitable region

rather than:

single best result

---

# 14. Optimization Research Plan

The first parameter exploration should investigate:

Donchian Period
Stop Loss
Take Profit
Break Even Trigger
Trailing Start

The optimization result should be evaluated using multiple metrics rather than Net Profit alone.

Important metrics:

- Profit Factor
- Net Profit
- Expected Payoff
- Drawdown
- Number of Trades
- Recovery Factor

Configurations with very few trades should not be treated as strong evidence even if profitability is high.

---

# 15. Extended Historical Test

The current approximately three-month test is only the baseline.

After identifying reasonable parameter regions, the EA must be tested over a substantially longer historical period.

Purpose:

- increase trade count;
- include different volatility environments;
- include bullish and bearish gold periods;
- expose longer losing sequences;
- determine whether the baseline edge persists.

Status:

PENDING

---

# 16. Out-of-Sample Validation

Parameters selected using one historical period must later be tested on data not used to select those parameters.

Concept:

IN-SAMPLE
→ parameter research

OUT-OF-SAMPLE
→ independent validation

The out-of-sample period must not be used to repeatedly tune the EA.

Otherwise it effectively becomes part of the optimization data.

Status:

PENDING

---

# 17. Robustness Testing

If the strategy survives extended and out-of-sample testing, robustness testing should follow.

Required categories:

### Parameter Robustness

Test neighboring parameter values.

A viable strategy should not collapse after small parameter changes.

### Spread Sensitivity

Test less favorable spread assumptions.

### Execution Sensitivity

Evaluate whether small execution changes materially destroy profitability.

### Time Robustness

Compare results across different historical periods.

### Direction Robustness

Compare:

BUY + SELL
BUY only
SELL only

Status:

PENDING

---

# 18. Current Evidence

What is currently supported:

✓ EA compiles and executes  
✓ BUY and SELL trades are generated  
✓ Stop Loss and Take Profit execute  
✓ Break Even / trailing behavior appears in trade history  
✓ MT5 baseline completed  
✓ 100% real-tick history reported  
✓ Baseline Net Profit is positive  
✓ Baseline Profit Factor > 1  
✓ Baseline drawdown is low  

What is NOT currently supported:

✗ Long-term profitability  
✗ Statistical robustness  
✗ Parameter robustness  
✗ Out-of-sample profitability  
✗ Broker independence  
✗ Spread robustness  
✗ Stable SELL edge  
✗ Production readiness  

---

# 19. Current Research Verdict

EA-050 currently receives:

BASELINE PASS

Meaning:

The implementation is functional and the initial historical result is sufficiently interesting to justify continued research.

It does NOT receive:

STRATEGY VALIDATED

because the current evidence contains only:

20 trades
~3 months
1 symbol
1 timeframe
1 broker environment
1 baseline parameter configuration

---

# 20. Research Status

| Stage | Status |
|---|---|
| EA implementation | COMPLETE |
| Baseline backtest | COMPLETE |
| Baseline analysis | COMPLETE |
| Parameter research | NEXT |
| Extended historical test | PENDING |
| Out-of-sample validation | PENDING |
| Robustness test | PENDING |
| Final research conclusion | PENDING |

---

# Next Research Question

The immediate next question is:

Can EA-050 maintain or improve its positive expectancy across reasonable combinations of Donchian Period, Stop Loss, Take Profit, Break Even and Trailing Stop parameters?

This question must be answered before changing the core strategy logic.
