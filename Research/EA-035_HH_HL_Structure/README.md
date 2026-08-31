# Research — EA-035_HH_HL_Structure

## Strategy

**EA-035_HH_HL_Structure**

The strategy uses basic market structure:

- Higher High + Higher Low → BUY
- Lower High + Lower Low → SELL

The purpose of this research is to evaluate whether HH/HL and LH/LL market structure can provide a trading edge on XAUUSD and identify which areas should be investigated after the baseline test.

---

## Baseline

| Parameter | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 35 points |
| Break-Even | Disabled |
| Trailing Stop | Disabled |
| History Quality | 100% real ticks |

---

## Baseline Results

| Metric | Result |
|---|---:|
| Total Trades | 6,651 |
| Net Profit | -$994.57 |
| Profit Factor | 0.93 |
| Expected Payoff | -$0.15 |
| Win Rate | 32.22% |
| Loss Rate | 67.78% |
| Maximum Drawdown | 99.49% |
| Sharpe Ratio | -5.00 |
| Average Profit Trade | $6.24 |
| Average Loss Trade | -$3.19 |
| Maximum Consecutive Losses | 30 |

**Baseline Result: FAIL**

---

## Research Findings

### 1. Raw Market Structure Signal

The baseline HH/HL and LH/LL logic is technically functional.

```text
HH + HL → BUY
LH + LL → SELL
