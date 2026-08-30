# XAUUSD EA Research

This directory documents the research process behind the Expert Advisors in this repository.

The purpose is to preserve:

- Strategy hypotheses
- Tested implementations
- Experimental results
- Failed approaches
- Observations
- Next research questions

A strategy is not considered validated simply because it has been implemented or backtested.

---

# EA-034 — VWAP Pullback

## Research Status

| Item | Status |
|---|---|
| Strategy Hypothesis | DOCUMENTED |
| EA Implementation | COMPLETE |
| Baseline Backtest | COMPLETE |
| Baseline Performance | **FAIL** |
| Further Research | REQUIRED |
| Live Validation | **NOT APPROVED** |

EA-034 is currently a research strategy and should not be considered validated for live trading.

---

## 1. Research Idea

EA-034 investigates whether VWAP can be used as an intraday reference for identifying short-term pullback continuation opportunities in XAUUSD.

The hypothesis implemented in the current EA is:

> When price is trading near VWAP and remains on one side of VWAP, continuation in that direction may provide a tradable short-term opportunity.

The strategy combines:

1. Intraday VWAP
2. Price position relative to VWAP
3. Proximity to VWAP
4. Short-term continuation confirmation
5. Fixed Stop Loss and Take Profit
6. Optional trade management

This is a research hypothesis and is not assumed to be profitable.

---

## 2. Core Hypothesis

### Bullish Hypothesis

If:

- Price is near VWAP
- Previous close is above VWAP
- Current price continues above the previous close

Then bullish continuation may occur.

```text
Price near VWAP
      ↓
Previous Close > VWAP
      ↓
Current Price >= Previous Close
      ↓
BUY
```

### Bearish Hypothesis

If:

- Price is near VWAP
- Previous close is below VWAP
- Current price continues below the previous close

Then bearish continuation may occur.

```text
Price near VWAP
      ↓
Previous Close < VWAP
      ↓
Current Price <= Previous Close
      ↓
SELL
```

---

## 3. Current Implementation

Current implementation:

```text
EA-034_VWAP_Pullback
```

Source:

```text
EAs/
└── EA-034_VWAP_Pullback/
    ├── EA-034_VWAP_Pullback.mq5
    └── README.md
```

The EA calculates intraday VWAP using:

```text
Typical Price = (High + Low + Close) / 3

VWAP = Σ(Typical Price × Volume) / Σ(Volume)
```

VWAP resets according to the trading day determined by MetaTrader server time.

---

## 4. Entry Model

### BUY

The current implementation requires:

```text
Previous Close > VWAP
AND
Current Price >= Previous Close
```

When the VWAP filter is enabled:

```text
Distance from Current Price to VWAP <= 100 points
```

### SELL

The current implementation requires:

```text
Previous Close < VWAP
AND
Current Price <= Previous Close
```

When the VWAP filter is enabled:

```text
Distance from Current Price to VWAP <= 100 points
```

Signals are evaluated on a new-bar cycle.

---

## 5. Baseline Configuration

The first documented baseline backtest used:

| Parameter | Value |
|---|---:|
| Expert Advisor | EA-034_VWAP_Pullback |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Slippage | 10 points |
| Break Even | Disabled |
| Break Even Trigger | 150 points |
| Break Even Lock | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Step | 50 points |
| Maximum Spread | 30 points |
| Maximum Positions | 1 |
| Magic Number | 202411 |
| VWAP Filter | Enabled |

### Test Environment

| Setting | Value |
|---|---|
| Broker / Company | ACCM Intl Limited |
| Terminal | ACCMIntl-Real |
| MT5 Build | 6140 |
| Initial Deposit | $1,000.00 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

---

## 6. Baseline Result

### Result: FAIL

The first documented backtest did not demonstrate positive expectancy.

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$335.57** |
| Gross Profit | $1,715.70 |
| Gross Loss | -$2,051.27 |
| Profit Factor | **0.84** |
| Expected Payoff | **-$0.36** |
| Recovery Factor | **-0.91** |
| Sharpe Ratio | **-5.00** |
| Total Trades | 939 |
| Total Deals | 1,878 |
| Winning Trades | 280 |
| Losing Trades | 659 |
| Win Rate | **29.82%** |
| Maximum Balance Drawdown | **35.93%** |
| Maximum Equity Drawdown | **36.07%** |

---

## 7. Trade Statistics

The baseline produced:

```text
Total Trades   = 939
Winning Trades = 280
Losing Trades  = 659
Win Rate       = 29.82%
```

Trade outcome statistics:

| Metric | Result |
|---|---:|
| Largest Profit Trade | $7.44 |
| Largest Loss Trade | -$6.22 |
| Average Profit Trade | $6.13 |
| Average Loss Trade | -$3.11 |

The average winning trade was approximately twice the average losing trade.

However, the **29.82% win rate was insufficient to produce positive expectancy** under the tested configuration.

This resulted in:

```text
Profit Factor   = 0.84
Expected Payoff = -$0.36
Net Profit      = -$335.57
```

---

## 8. Long vs Short

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | 457 | 30.63% |
| Long | 482 | 29.05% |

The short side had a slightly higher win rate than the long side.

However, this single backtest is not sufficient evidence to conclude that SELL signals have a durable advantage over BUY signals.

---

## 9. Drawdown Observation

The baseline recorded:

```text
Maximum Balance Drawdown = 35.93%
Maximum Equity Drawdown  = 36.07%
```

The balance curve declined across the test period.

This indicates that the negative result was not caused only by a single isolated losing trade.

The tested strategy configuration generated negative aggregate expectancy across a large sample of trades.

---

## 10. Consecutive Results

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 4 |
| Maximum Consecutive Profit | $24.70 |
| Maximum Consecutive Losses | 17 |
| Maximum Consecutive Loss | -$54.00 |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

A maximum sequence of:

```text
17 consecutive losses
```

is an important research concern.

Future experiments should investigate whether these losing sequences cluster around identifiable market conditions.

---

## 11. Time Distribution

The MT5 Strategy Tester report contains distributions for:

- Entries by hour
- Entries by weekday
- Entries by month
- Profits and losses by hour
- Profits and losses by weekday
- Profits and losses by month

These distributions provide a possible research path for determining whether strategy performance changes materially across trading periods.

However:

> No trading-hour, session, weekday, or month filter is accepted based on the baseline test alone.

Adding filters after observing historical losses can introduce overfitting.

Any proposed time filter must therefore be treated as a new research hypothesis and tested independently.

---

## 12. MFE / MAE Observations

The Strategy Tester reported:

| Correlation | Value |
|---|---:|
| Profit vs MFE | 0.83 |
| Profit vs MAE | 0.86 |
| MFE vs MAE | 0.6924 |

These statistics provide evidence for further investigation of trade excursion behavior.

They do not independently prove how Stop Loss, Take Profit, or Trailing Stop should be changed.

Any modification based on MFE/MAE analysis must be tested as a separate experiment.

---

## 13. Holding Time

Baseline holding-time statistics:

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Average Holding Time | 00:07:51 |
| Maximum Holding Time | 03:44:00 |

The current implementation therefore behaved primarily as a short-duration intraday strategy during this test.

---

## 14. Research Questions

The failed baseline creates several research questions.

### RQ-01 — Entry Quality

Does the current VWAP continuation condition provide sufficient predictive value?

---

### RQ-02 — VWAP Distance

Is the current:

```text
100-point VWAP proximity threshold
```

appropriate for XAUUSD?

---

### RQ-03 — Trading Time

Are losses concentrated in particular:

- Hours
- Trading sessions
- Weekdays

Any resulting time filter must be independently tested rather than selected solely from the baseline data.

---

### RQ-04 — Long vs Short

Should BUY and SELL signals be treated differently?

Baseline:

```text
SELL Win Rate = 30.63%
BUY Win Rate  = 29.05%
```

The difference requires further testing before any directional filter is accepted.

---

### RQ-05 — Exit Model

Are the current:

```text
Stop Loss   = 300 points
Take Profit = 600 points
```

appropriate for the observed trade behavior?

---

### RQ-06 — Trailing Stop

Does the current Trailing Stop implementation improve or reduce expectancy?

Baseline configuration:

```text
Trailing Stop  = Enabled
Trailing Start = 200 points
Trailing Step  = 50 points
```

This should be compared against a controlled test without Trailing Stop.

---

### RQ-07 — Market Regime

Does strategy performance change during:

- Trending markets
- Ranging markets
- High-volatility periods
- Low-volatility periods

---

### RQ-08 — VWAP Definition

How sensitive are results to:

- VWAP calculation method
- Volume source
- Daily reset
- Broker/server timezone

---

## 15. Research Method

EA-034 should not be optimized by changing many strategy components simultaneously.

Each material change should be treated as a separate experiment.

```text
Baseline
   ↓
Identify one hypothesis
   ↓
Change one strategy component
   ↓
Backtest
   ↓
Compare against baseline
   ↓
PASS / FAIL
   ↓
Keep or reject hypothesis
```

This makes it possible to identify which modification actually changes strategy behavior.

---

## 16. Baseline Preservation

The failed baseline must remain unchanged as the comparison point for future experiments.

Evidence:

```text
Backtest/
└── EA-034_VWAP_Pullback/
    ├── README.md
    ├── ReportTester-952747(7).html
    ├── ReportTester-952747(7).png
    ├── ReportTester-952747-hst(7).png
    ├── ReportTester-952747-mfemae(7).png
    └── ReportTester-952747-holding(7).png
```

Failed baseline evidence should not be deleted or replaced by later optimized results.

---

## 17. Current Research Conclusion

### Hypothesis

```text
VWAP proximity
        +
Price remains on one side of VWAP
        +
Short-term continuation
        ↓
Potential directional entry
```

### Baseline Result

```text
FAIL
```

### Evidence

```text
Net Profit       = -$335.57
Profit Factor    = 0.84
Expected Payoff  = -$0.36
Sharpe Ratio     = -5.00
Win Rate         = 29.82%
Max Equity DD    = 36.07%
Total Trades     = 939
```

### Conclusion

The current implementation of **EA-034_VWAP_Pullback does not demonstrate a profitable trading edge under the documented baseline test conditions**.

This result applies to the tested combination of:

```text
EA version
+
Parameters
+
XAUUSD.PRO
+
M1
+
2026.01.02 – 2026.04.01
+
Test environment
```

It does not independently prove that every possible VWAP Pullback strategy is invalid.

The baseline should be retained as a failed research result and used as the reference point for future controlled experiments.

---

## 18. Research Status

```text
EA-034_VWAP_Pullback

Strategy hypothesis   → DOCUMENTED
EA implementation     → COMPLETE
Baseline backtest     → COMPLETE
Baseline performance  → FAIL
Further research      → REQUIRED
Live validation       → NOT APPROVED
```

No profitability claim should be made until subsequent research produces independently tested and reproducible evidence.
