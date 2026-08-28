# XAUUSD MT5 EA Research

## Overview

This directory documents the research process for Expert Advisors developed and tested in this repository.

The objective is to maintain a clear record of:

- Strategy hypotheses
- Baseline results
- Observed weaknesses
- Research findings
- Proposed improvements
- Experimental directions
- Final research conclusions

Backtest reports remain in the `/Backtest` directory.

This directory focuses on **what was learned from those tests and what should be investigated next**.

---

# EA-030 — Parabolic SAR

## Research Status

**Stage:** Baseline Evaluation  
**Baseline Result:** FAIL  
**Next Stage:** Strategy Improvement Research

---

## 1. Research Hypothesis

EA-030 investigates whether the **Parabolic SAR** indicator can be used as the primary directional signal for an automated XAUUSD trading strategy.

The baseline hypothesis is:

> When price is above Parabolic SAR, bullish momentum may justify a BUY position.  
> When price is below Parabolic SAR, bearish momentum may justify a SELL position.

The initial version intentionally uses relatively simple trading logic so that the behavior of the underlying Parabolic SAR signal can be evaluated before introducing additional filters or optimization.

---

## 2. Baseline Strategy

The baseline EA uses:

- Parabolic SAR directional signal
- Fixed lot size
- Fixed Stop Loss
- Fixed Take Profit
- Spread filter
- Maximum position control
- New-bar signal evaluation

Baseline SAR configuration:

| Parameter | Value |
|---|---:|
| SAR Step | 0.02 |
| SAR Maximum | 0.2 |

Backtest configuration:

| Parameter | Value |
|---|---:|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.03.01 |
| Initial Deposit | $100 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 60 points |
| Break Even | Disabled |
| Trailing Stop | Disabled |

---

## 3. Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 410 |
| Winning Trades | 124 (30.24%) |
| Losing Trades | 286 (69.76%) |
| Total Net Profit | -$92.43 |
| Gross Profit | $786.31 |
| Gross Loss | -$878.74 |
| Profit Factor | 0.89 |
| Expected Payoff | -$0.23 |
| Maximum Drawdown | 93.11% |
| Recovery Factor | -0.90 |
| Sharpe Ratio | -5.00 |

### Directional Performance

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 206 | 34.47% |
| Short | 204 | 25.98% |

The baseline configuration is therefore classified as:

**FAIL**

---

## 4. Key Findings

### Finding 1 — Baseline strategy is not profitable

Profit Factor is **0.89**, meaning gross losses exceeded gross profits during the test.

Total Net Profit was:

**-$92.43**

The baseline Parabolic SAR signal alone did not produce a profitable strategy under the tested configuration.

---

### Finding 2 — Win rate is low

Only:

**30.24%**

of trades were profitable.

The strategy generated:

- 124 winning trades
- 286 losing trades

This suggests that a large number of SAR signals resulted in unsuccessful entries.

---

### Finding 3 — Winning trades are larger than losing trades

Average winning trade:

**$6.34**

Average losing trade:

**-$3.07**

The average winner was therefore substantially larger than the average loser.

However, this payoff advantage was insufficient to compensate for the high frequency of losing trades.

---

### Finding 4 — Drawdown is unacceptable

Maximum balance drawdown reached:

**93.11%**

This represents the most serious weakness observed in the baseline test.

Even if profitability were improved, risk and drawdown would require substantial improvement before the strategy could be considered viable.

---

### Finding 5 — Long signals performed better than short signals

Long win rate:

**34.47%**

Short win rate:

**25.98%**

This difference should be investigated further.

At this stage it is only an observation from the baseline test and is **not sufficient evidence** to conclude that BUY-only trading would produce a robust strategy.

---

### Finding 6 — Losing streaks are significant

Maximum consecutive losses:

**12 trades**

Average consecutive losses:

**3 trades**

This behavior contributes directly to the instability observed in the balance curve.

---

## 5. Current Research Conclusion

The baseline test indicates that **Parabolic SAR alone is not sufficient as an entry system for EA-030 under the tested XAUUSD M1 configuration**.

The strategy demonstrates a potentially useful payoff characteristic:

> Average winning trades are larger than average losing trades.

However, the frequency of losing trades is too high.

The primary research problem is therefore:

> Can low-quality Parabolic SAR signals be filtered while retaining enough profitable moves to improve overall expectancy and reduce drawdown?

---

## 6. Research Questions

The next research stage should investigate:

### RQ-01 — Trend Filter

Can a trend filter reduce SAR signals that occur against the broader market direction?

Potential experiment:

- SAR + Moving Average trend filter

---

### RQ-02 — Market Regime Filter

Does Parabolic SAR perform differently during trending and ranging market conditions?

Research objective:

Identify whether trades should be avoided during low-quality or sideways market regimes.

---

### RQ-03 — Long vs Short

Why did BUY trades achieve a higher win rate than SELL trades?

Test separately:

- BUY only
- SELL only
- BUY + SELL

---

### RQ-04 — Time Filter

Does strategy performance vary significantly by trading hour or market session?

Test:

- Asia
- Europe
- US
- Selected trading-hour windows

---

### RQ-05 — SAR Parameters

Determine whether the default:

```text
Step    = 0.02
Maximum = 0.2
