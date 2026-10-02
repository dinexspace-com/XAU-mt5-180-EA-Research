# EA-093_Keltner_Reversion — Research

## 1. Research Objective

The objective of EA-093_Keltner_Reversion research is to study a short-term mean-reversion approach on XAUUSD using an EMA center line and ATR-based volatility bands.

The current implementation uses:

```text
EMA Period     = 20
ATR Period     = 14
ATR Multiplier = 2.0
Timeframe      = M1
```

The research focuses on whether excursions beyond the volatility envelope can be followed by a reversion trade.

---

## 2. Strategy Hypothesis

The current implementation is based on the following hypothesis:

```text
Price moves significantly away from the EMA
        ↓
Distance is measured using ATR
        ↓
Price reaches/exceeds the Keltner-style envelope
        ↓
A mean-reversion trade is considered
```

The current EA therefore investigates whether extreme short-term deviations from the EMA can provide usable reversal signals.

---

## 3. Signal Structure

The implementation calculates:

```text
Middle = EMA
Upper  = EMA + ATR × Multiplier
Lower  = EMA - ATR × Multiplier
```

The signal logic examines completed candles.

A buy signal can be generated when:

```text
Previous close < lower band
OR
Current completed candle low < lower band
```

A sell signal can be generated when:

```text
Previous close > upper band
OR
Current completed candle high > upper band
```

If both directional conditions occur simultaneously, no direction is assigned.

---

## 4. Risk and Exit Structure

The current configuration uses:

```text
Stop Loss      = 300 points
Take Profit    = 600 points
Break Even     = enabled
BE Trigger     = 150 points
Trailing Stop  = enabled
Trailing Start = 200 points
Trailing Dist. = 100 points
Trailing Step  = 10 points
```

The initial SL/TP are submitted together with the market order.

Position management is subsequently performed on every tick.

---

## 5. Baseline Backtest

The current baseline test was performed on:

```text
Symbol       = XAUUSD.PRO
Timeframe    = M1
Period       = 2026.01.02 – 2026.03.31
Initial Fund = 1,000 USD
Data Quality = 100% real ticks
```

The test produced:

```text
Net Profit    = -741.62 USD
Profit Factor = 0.91
Trades        = 6,886
Win Rate      = 50.17%
Max Drawdown  = 86.40% balance
```

The baseline therefore provides a reference point for further controlled experiments rather than a final strategy specification.

---

## 6. Research Observations

### 6.1 Win Rate

The overall profitable-trade percentage was:

```text
50.17%
```

Long trades:

```text
50.22%
```

Short trades:

```text
50.12%
```

The difference between long and short results is small in this test.

---

### 6.2 Average Win vs Average Loss

The report shows:

```text
Average Profit Trade = 2.24 USD
Average Loss Trade   = -2.47 USD
```

The average loss is larger than the average profit.

This is relevant when investigating why the strategy produced a Profit Factor below 1 despite a win rate close to 50%.

---

### 6.3 Drawdown

The maximum balance drawdown was:

```text
86.40%
```

and maximum equity drawdown was:

```text
86.43%
```

This is a major characteristic of the current baseline and should remain a primary metric in subsequent research.

---

### 6.4 Trade Frequency

The test generated:

```text
6,886 trades
```

over the tested period.

The average position holding time was:

```text
2 minutes 5 seconds
```

with a minimum holding time of:

```text
1 second
```

This confirms that the current implementation operates as a high-frequency short-term M1 strategy.

---

## 7. Research Questions

The next research stages should answer the following questions:

### Q1 — EMA Period

How does changing:

```text
InpEMAPeriod
```

affect:

* trade frequency
* win rate
* average trade
* Profit Factor
* drawdown

### Q2 — ATR Period

How does changing:

```text
InpATRPeriod
```

affect the definition of extreme price movement?

### Q3 — ATR Multiplier

How does changing:

```text
InpATRMultiplier
```

affect:

* number of signals
* signal quality
* average profit
* drawdown

### Q4 — Stop Loss / Take Profit

How does changing:

```text
InpStopLoss
InpTakeProfit
```

change the payoff distribution?

### Q5 — Break Even

What happens when:

```text
InpUseBreakEven = true
```

is compared with:

```text
InpUseBreakEven = false
```

### Q6 — Trailing Stop

What happens when trailing-stop management is enabled versus disabled?

### Q7 — Long vs Short

Does the strategy behave differently on:

```text
Long
Short
```

positions across different market periods?

---

## 8. Research Discipline

Each experiment should change only the intended variable whenever possible.

Each test should record:

```text
Parameter configuration
Test period
Symbol
Timeframe
Initial deposit
Net profit
Profit factor
Maximum drawdown
Number of trades
Win rate
Average profit trade
Average loss trade
```

Results should be recorded before changing to the next experiment.

---

## 9. Baseline

The current baseline configuration is:

```text
Lot Size       = 0.01
Stop Loss      = 300
Take Profit    = 600

EMA Period     = 20
ATR Period     = 14
ATR Multiplier = 2.0

Break Even     = true
BE Trigger     = 150
BE Offset      = 0

Trailing Stop  = true
Trail Start    = 200
Trail Distance = 100
Trail Step     = 10
```

This configuration should be preserved as the baseline for comparison.

---

## 10. Research Status

Current status:

```text
Baseline implementation: Complete
Baseline backtest:       Complete
Parameter research:      Not yet completed
Out-of-sample testing:   Not yet completed
Robustness testing:      Not yet completed
```

No conclusion about future profitability is made from the current baseline alone.
