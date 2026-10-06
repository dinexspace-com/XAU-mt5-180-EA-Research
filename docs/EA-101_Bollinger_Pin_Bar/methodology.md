# EA-101 — Bollinger Pin Bar Methodology

## Strategy Definition

EA-101 tests a mean-reversion concept using Bollinger Bands and Pin Bar candle structure on XAUUSD M1.

### BUY

The Shift 1 candle must be:

* Bullish
* Touching or penetrating the Lower Bollinger Band
* Lower shadow at least 2× candle body
* Lower shadow at least 50% of candle range

### SELL

The Shift 1 candle must be:

* Bearish
* Touching or penetrating the Upper Bollinger Band
* Upper shadow at least 2× candle body
* Upper shadow at least 50% of candle range

---

## Baseline Configuration

```text
Baseline ID: EA101-M1-BASELINE-001

Symbol: XAUUSD.PRO
Timeframe: M1

Bollinger Period: 20
Bollinger Deviation: 2.0

Shadow / Body Ratio: 2.0
Shadow / Range Ratio: 50%

Lot Size: 0.01
Stop Loss: 300 points
Take Profit: 600 points

Break-even: ON
Break-even Start: 150 points

Trailing Stop: ON
Trailing Start: 200 points
Trailing Distance: 200 points

Maximum Spread: 30 points
```

---

## Baseline Validation

The baseline backtest produced:

```text
Net Profit: -$393.88
Profit Factor: 0.90
Expected Payoff: -$0.12
Sharpe Ratio: -5.00
Max Equity Drawdown: 41.62%
Total Trades: 3,207
```

The baseline is classified as:

```text
FAIL
```

## Therefore the strategy is not validated for live trading.

## Acceptance Criteria

A research candidate should demonstrate improvement across multiple dimensions rather than Net Profit alone.

Primary metrics:

1. Profit Factor
2. Expected Payoff
3. Maximum Equity Drawdown
4. Sharpe Ratio
5. Trade Count
6. Average Profit vs Average Loss
7. Directional consistency
8. Parameter robustness

---

## Controlled Experiment Policy

Research must follow a controlled sequence.

Only one variable group should be modified at a time.

The baseline remains the control:

```text
EA101-M1-BASELINE-001
```

Experiments should first investigate:

```text
Pin Bar Structure
        ↓
Bollinger Interaction
        ↓
Entry Confirmation
        ↓
BUY vs SELL
        ↓
Exit Management
        ↓
Trading Session
        ↓
Market Regime
        ↓
OOS
        ↓
Robustness
        ↓
Walk-Forward
```

---

## Optimization Policy

Broad parameter optimization is **BLOCKED**.

Optimization may only be used after the strategy demonstrates evidence of a repeatable edge through controlled research.

The purpose of optimization is parameter validation, not curve fitting.

---

## Validation Policy

The validation hierarchy is:

```text
Baseline
   ↓
Controlled Research
   ↓
Candidate Configuration
   ↓
Out-of-Sample
   ↓
Robustness
   ↓
Walk-Forward
   ↓
Forward Test
   ↓
Live Trading
```

EA-101 currently remains at the **Controlled Research** stage.

---

## Current Classification

```text
Strategy Code: COMPLETE
Baseline Test: COMPLETE
Baseline Result: FAIL
Optimization: BLOCKED
OOS: NOT STARTED
Robustness: NOT STARTED
Walk-Forward: NOT STARTED
Forward Test: NOT STARTED
Live Trading: NO
```
