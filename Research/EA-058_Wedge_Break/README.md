# Research — EA-058_Wedge_Break

## 1. Research Objective

EA-058 investigates whether a contracting wedge breakout can provide a systematic trading edge on XAUUSD using MetaTrader 5.

The research converts the visual concept of a wedge pattern into explicit rules that can be detected, executed, and evaluated automatically.

The implementation focuses on:

- Detecting contracting price structures from pivot highs and pivot lows.
- Confirming breakouts using closed candles.
- Executing both BUY and SELL breakouts.
- Controlling execution using spread and position limits.
- Managing trades with fixed SL/TP, Break Even, and Trailing Stop.
- Evaluating the resulting strategy using MT5 real-tick backtesting.

---

## 2. Research Hypothesis

The hypothesis tested by EA-058 is:

> A confirmed breakout from a contracting wedge may produce sufficient directional continuation to create a repeatable trading edge on XAUUSD.

A valid wedge requires price compression:

- Successive pivot highs move lower.
- Successive pivot lows move higher.
- The upper boundary slopes downward.
- The lower boundary slopes upward.

Conceptually:

```text
        Lower High
           \
            \
             \   BREAKOUT ↑
              \ /
              / \
             /   \
            /
       Higher Low
```

The strategy waits for price to break outside the contracting structure rather than trading while price remains inside it.

---

## 3. Pattern Definition

The implementation identifies a wedge using two pivot highs and two pivot lows.

Required structure:

```text
Recent Pivot High < Previous Pivot High
Recent Pivot Low  > Previous Pivot Low
```

This creates:

```text
Upper boundary → descending
Lower boundary → ascending
```

The pattern must also satisfy a contraction requirement.

Implemented contraction range:

```text
Minimum contraction ratio = 0.10
Maximum contraction ratio = 0.80
```

The EA searches within a rolling lookback window.

Current implementation:

```text
Wedge Lookback          = 30 bars
Pivot Strength          = 2
Minimum Pivot Distance  = 3 bars
```

---

## 4. Breakout Hypothesis

A wedge alone is not treated as a trading signal.

The strategy requires a confirmed breakout.

### Bullish Breakout

A BUY signal occurs when the previous price is not already above the upper wedge boundary and the latest closed candle closes above the projected upper boundary plus the breakout buffer.

```text
Wedge
   \
    \
     \     ● Close
      \   /
       \ /
--------X---------- Upper breakout
```

### Bearish Breakout

A SELL signal uses the opposite condition.

The latest closed candle must break below the projected lower wedge boundary.

```text
--------X---------- Lower breakout
       / \
      /   \
     /     ● Close
    /
   /
Wedge
```

Current breakout buffer:

```text
5 points
```

Using closed candles is intended to reduce signals caused only by temporary intrabar penetration of the wedge boundary.

---

## 5. Trade Direction

The research tests both directions independently:

```text
Upper wedge breakout → BUY
Lower wedge breakout → SELL
```

The strategy therefore does not assume a permanent bullish or bearish bias for XAUUSD.

---

## 6. Risk and Exit Model

The tested implementation uses:

```text
Lot Size    = 0.01
Stop Loss   = 300 points
Take Profit = 600 points
```

Nominal initial SL:TP distance:

```text
1 : 2
```

The actual exit behavior is more complex because Break Even and Trailing Stop are enabled.

### Break Even

```text
Enabled
Trigger = 150 points
Offset  = 0
```

### Trailing Stop

```text
Enabled
Start    = 200 points
Distance = 150 points
Step     = 10 points
```

Therefore, the nominal 1:2 SL/TP configuration should not be interpreted as the realized reward-to-risk ratio of completed trades.

---

## 7. Execution Filters

The implementation includes basic execution controls.

### Spread Filter

```text
Maximum Spread = 30 points
```

No new position is opened when spread exceeds this threshold.

### Position Limit

```text
Maximum Positions = 1
```

The EA therefore tests individual wedge breakout signals without intentionally stacking multiple simultaneous EA positions on the same symbol.

---

## 8. Experimental Backtest

The current implementation was tested using:

| Variable | Configuration |
|---|---|
| EA | EA-058_Wedge_Break |
| Instrument | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026.01.02 – 2026.04.01 |
| Initial Capital | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| Data Quality | 100% real ticks |

Dataset:

```text
Bars  = 86,539
Ticks = 40,346,891
```

The test generated:

```text
856 trades
1,712 deals
```

This provides the first empirical test of the implemented wedge-breakout hypothesis.

---

## 9. Experimental Results

Key results:

| Metric | Result |
|---|---:|
| Net Profit | -$267.40 |
| Gross Profit | $890.23 |
| Gross Loss | -$1,157.63 |
| Profit Factor | 0.77 |
| Expected Payoff | -$0.31 |
| Recovery Factor | -0.99 |
| Sharpe Ratio | -5.00 |
| Maximum Balance Drawdown | 26.85% |
| Maximum Equity Drawdown | 26.97% |
| Winning Trades | 47.90% |
| Losing Trades | 52.10% |

Directional results:

| Direction | Trades | Win Rate |
|---|---:|---:|
| SELL | 433 | 48.50% |
| BUY | 423 | 47.28% |

Trade distribution is relatively balanced between BUY and SELL signals.

Neither direction demonstrated a sufficient win rate in this configuration to make the complete strategy profitable.

---

## 10. Observations

### Observation 1 — The strategy generates signals

The algorithm successfully detects and trades wedge breakout structures.

With 856 completed trades during the test period, the implementation produces enough signals for empirical evaluation.

Therefore, the immediate problem is not a lack of trading opportunities.

### Observation 2 — Current implementation has no demonstrated positive edge

The most important result is:

```text
Profit Factor = 0.77
Net Profit    = -$267.40
```

Gross losses exceeded gross profits.

The tested version therefore does not demonstrate a profitable edge.

### Observation 3 — Win rate is below 50%

Overall:

```text
Winning = 47.90%
Losing  = 52.10%
```

BUY and SELL performance are relatively similar.

This does not indicate an obvious directional problem limited to only one side of the strategy.

### Observation 4 — Realized winners are smaller than realized losers on average

```text
Average Profit Trade = $2.17
Average Loss Trade   = -$2.60
```

Despite the initial 300-point SL and 600-point TP configuration, trade management changes the realized payoff distribution.

This is important because Break Even and Trailing Stop may materially affect the original reward/risk hypothesis.

### Observation 5 — Losing streak risk is significant

Maximum consecutive losses:

```text
13 trades
```

Combined with the negative expectancy, this creates a persistent declining balance curve in the tested configuration.

### Observation 6 — Trading behavior is short-term

```text
Minimum Holding Time = 00:00:01
Average Holding Time = 00:02:58
Maximum Holding Time = 02:19:00
```

The M1 implementation therefore behaves primarily as a short-duration intraday breakout system.

---

## 11. Current Research Conclusion

### Result: FAILED

The original research hypothesis is **not supported by the current backtest configuration**.

The implemented wedge breakout logic successfully:

- identifies wedge structures,
- generates BUY and SELL signals,
- executes trades,
- manages positions,
- and produces a substantial test sample.

However, the tested configuration produces:

```text
Negative Net Profit
Profit Factor < 1
Negative Expected Payoff
High Drawdown relative to return
Negative Sharpe Ratio
```

Therefore:

> EA-058_Wedge_Break in its current configuration does not demonstrate a profitable trading edge on XAUUSD.PRO M1 during the tested period.

The negative result should be retained as research evidence rather than removed.

---

## 12. Future Research Questions

The current result creates several testable research questions for later versions:

1. Does adding trend confirmation reduce false wedge breakouts?
2. Does restricting trades by trading session improve expectancy?
3. Does volatility filtering improve breakout quality?
4. Does requiring stronger breakout confirmation reduce failed breakouts?
5. Are the current Break Even and Trailing Stop rules reducing profitable trade expectancy?
6. Do different wedge contraction thresholds produce higher-quality patterns?
7. Does the strategy perform differently on higher timeframes?

These questions are future research directions only and are not claims that any modification will improve profitability.

Each modification should be tested independently against the baseline EA-058 result.

---

## 13. Baseline

EA-058 should be retained as the baseline implementation.

```text
Baseline:
EA-058_Wedge_Break

Instrument    = XAUUSD.PRO
Timeframe     = M1
Period        = 2026.01.02 – 2026.04.01
Data Quality  = 100% real ticks
Total Trades  = 856

Net Profit    = -$267.40
Profit Factor = 0.77
Equity DD     = 26.97%

Status        = FAILED
```

Any future variant should be compared against this baseline rather than replacing the original evidence.

---

## 14. Evidence Location

Implementation:

```text
EAs/
└── EA-058_Wedge_Break/
    ├── EA-058_Wedge_Break.mq5
    └── README.md
```

Backtest evidence:

```text
Backtest/
└── EA-058_Wedge_Break/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

---

## Research Status

**EA:** EA-058_Wedge_Break  
**Research Type:** Contracting Wedge Breakout  
**Instrument Tested:** XAUUSD.PRO  
**Baseline Timeframe:** M1  
**Evidence:** MT5 Strategy Tester — 100% real ticks  
**Current Result:** FAILED  
**Reason:** Negative expectancy and Profit Factor below 1.0
