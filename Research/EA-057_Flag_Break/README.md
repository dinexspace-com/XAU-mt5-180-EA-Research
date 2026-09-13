# Research — EA-057 Flag Break

## 1. Research Objective

EA-057_Flag_Break investigates whether a classical **Flag Breakout** price-action structure can be converted into a fully mechanical trading strategy for XAUUSD on MetaTrader 5.

The core hypothesis is:

> A strong directional price impulse followed by a relatively small consolidation may indicate temporary profit-taking rather than a complete reversal. A confirmed breakout from that consolidation in the direction of the original impulse may provide a continuation entry.

The purpose of this research is not to assume that the Flag pattern is profitable, but to convert the concept into explicit rules, implement those rules in an EA, and test the resulting system objectively.

---

## 2. Strategy Concept

The strategy is built around three sequential market structures:

    IMPULSE
       ↓
    CONSOLIDATION / FLAG
       ↓
    BREAKOUT
       ↓
    ENTRY

The EA supports both bullish and bearish setups.

### Bullish Structure

    Strong bullish impulse
            ↓
    Small consolidation / flag
            ↓
    Price breaks above flag
            ↓
           BUY

### Bearish Structure

    Strong bearish impulse
            ↓
    Small consolidation / flag
            ↓
    Price breaks below flag
            ↓
           SELL

The important research problem is converting subjective concepts such as "strong impulse", "small flag", and "valid breakout" into measurable numerical conditions.

---

## 3. Mechanical Definition

### 3.1 Impulse Candle

Instead of identifying a strong candle visually, the EA compares the candidate candle against recent market activity.

The impulse is evaluated using:

- Recent average candle range
- Impulse range
- Candle body / total range ratio
- Candle direction

Conceptually:

    Impulse Range >= Average Range × Impulse Multiplier

and:

    Candle Body / Candle Range >= Minimum Body Ratio

This prevents every directional candle from automatically being classified as an impulse.

---

## 4. Flag Definition

After detecting an impulse, the following candles are evaluated as the potential flag structure.

The consolidation must remain sufficiently small relative to the impulse.

Two primary constraints are used:

    Flag Range / Impulse Range <= Maximum Flag-to-Impulse Ratio

and:

    Retracement / Impulse Range <= Maximum Retracement

The purpose is to reject structures where price has already retraced too much of the original impulse.

A deep retracement may indicate that the original directional movement has lost strength rather than merely paused.

---

## 5. Breakout Definition

The strategy does not enter merely because price touches the edge of the flag.

A breakout must occur in the same direction as the original impulse.

For a bullish setup:

- Original impulse is bullish
- Flag remains valid
- Breakout candle is bullish
- Price trades above the flag high
- Breakout candle closes above the required breakout level

For a bearish setup:

- Original impulse is bearish
- Flag remains valid
- Breakout candle is bearish
- Price trades below the flag low
- Breakout candle closes below the required breakout level

The use of completed-candle confirmation reduces dependence on temporary intrabar price excursions.

---

## 6. Trade Management

The implementation combines the Flag Break entry model with mechanical position management.

The tested system includes:

- Fixed lot size
- Initial Stop Loss
- Initial Take Profit
- Break Even
- Trailing Stop
- Maximum spread filter
- One-position restriction per symbol / Magic Number

Position management is separated conceptually from signal generation.

This distinction is important because future experiments may improve performance by modifying trade management without changing the underlying Flag Break signal.

---

## 7. Baseline Test

The initial recorded research test used:

| Setting | Value |
|---|---|
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| History Quality | 100% real ticks |

### Strategy Parameters

| Parameter | Value |
|---|---:|
| Average Range Period | 20 |
| Impulse Multiplier | 1.2 |
| Minimum Body Ratio | 0.5 |
| Flag Bars | 2 |
| Maximum Flag / Impulse | 0.75 |
| Maximum Retracement | 0.75 |
| Breakout Buffer | 0 |

### Position Management

| Parameter | Value |
|---|---:|
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Lock | 10 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 150 points |
| Trailing Step | 20 points |

---

## 8. Baseline Results

| Metric | Result |
|---|---:|
| Net Profit | -$161.17 |
| Profit Factor | 0.85 |
| Expected Payoff | -$0.18 |
| Total Trades | 902 |
| Winning Trades | 56.43% |
| Maximum Balance Drawdown | 19.08% |
| Maximum Equity Drawdown | 19.23% |
| Recovery Factor | -0.83 |
| Sharpe Ratio | -5.00 |
| Average Profit Trade | $1.83 |
| Average Loss Trade | -$2.78 |

The baseline configuration therefore failed to demonstrate positive expectancy.

---

## 9. Research Finding

### Finding 01 — Win Rate Alone Is Insufficient

The EA achieved a winning-trade rate of:

    56.43%

However:

    Average Winning Trade = $1.83
    Average Losing Trade  = -$2.78

Therefore, the system can win more frequently than it loses while still producing a negative overall result.

This is reflected in:

    Profit Factor    = 0.85
    Expected Payoff  = -$0.18
    Net Profit       = -$161.17

The first baseline therefore rejects the assumption that this Flag Break implementation is profitable simply because it produces a win rate above 50%.

---

## 10. Research Finding — Equity Behaviour

The balance curve shows an overall declining tendency during the tested period.

The test started with:

    $1,000

and generated:

    -$161.17 Net Profit

Maximum equity drawdown reached:

    19.23%

This indicates that the baseline problem is not simply one isolated losing trade.

The tested configuration produced negative aggregate expectancy over 902 trades.

---

## 11. Research Finding — Trade Frequency

The baseline generated:

    902 trades

over approximately three months of M1 data.

Average position holding time was:

    00:02:45

with:

    Minimum = 00:00:01
    Maximum = 02:14:10

The implementation therefore behaves as a high-frequency short-duration intraday strategy under this M1 configuration.

This provides a sufficiently large initial sample to justify further investigation of the strategy logic rather than drawing conclusions from only a handful of trades.

---

## 12. Research Finding — Long vs Short

The baseline produced:

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 542 | 57.01% |
| Short | 360 | 55.56% |

Both directions achieved similar winning percentages.

The negative aggregate result therefore cannot be attributed solely to one direction based on win rate alone.

Direction-specific expectancy should be examined separately in future experiments before deciding whether BUY and SELL logic should remain symmetrical.

---

## 13. Research Finding — MFE / MAE

The Strategy Tester reported:

| Correlation | Value |
|---|---:|
| Profit vs MFE | 0.97 |
| Profit vs MAE | 0.72 |
| MFE vs MAE | 0.6360 |

The strong relationship between profit and Maximum Favorable Excursion makes exit management an important area for future investigation.

However, these correlations alone do not prove that changing Take Profit, Break Even, or Trailing Stop will make the strategy profitable.

They should be treated as research signals for further controlled testing.

---

## 14. Baseline Conclusion

### Status

    FAILED BASELINE

EA-057 successfully demonstrates that the Flag Break concept can be converted into deterministic rules and executed automatically in MT5.

However, the first recorded configuration does not demonstrate a profitable trading edge.

The baseline produced:

    Net Profit       = -$161.17
    Profit Factor    = 0.85
    Expected Payoff  = -$0.18
    Equity DD        = 19.23%
    Trades           = 902

Therefore:

    IMPLEMENTATION TEST   → PASS
    PROFITABILITY TEST    → FAIL

The strategy remains a research candidate rather than a production-ready trading system.

---

## 15. Next Research Questions

Future experiments should investigate one variable group at a time.

Priority questions:

1. Is the impulse definition too permissive?
2. Does increasing the required impulse strength improve signal quality?
3. Is a two-candle flag too short for reliable consolidation detection?
4. Should maximum retracement be reduced?
5. Does requiring additional breakout distance reduce false breakouts?
6. Are particular trading sessions responsible for most negative expectancy?
7. Does BUY expectancy differ materially from SELL expectancy?
8. Is the current Break Even logic cutting profitable trades prematurely?
9. Does the Trailing Stop improve or reduce expectancy?
10. Would volatility-normalized SL/TP perform better than fixed-point exits?

These questions should be tested independently where possible to avoid changing multiple variables simultaneously and losing attribution of the result.

---

## 16. Research Workflow

Each future experiment should follow:

    Hypothesis
        ↓
    Change One Variable Group
        ↓
    Compile EA
        ↓
    MT5 Real-Tick Backtest
        ↓
    Save Original Evidence
        ↓
    Compare Against Baseline
        ↓
    PASS / FAIL
        ↓
    Record Finding

The baseline documented here must remain unchanged so future versions can be compared against the same reference result.

---

## 17. Evidence Location

Source code:

    EAs/EA-057_Flag_Break/
    └── EA-057_Flag_Break.mq5

Backtest evidence:

    Backtest/EA-057_Flag_Break/
    ├── README.md
    ├── ReportTester-952747(20260913-045805).html
    ├── ReportTester-952747(20260913-045805).png
    ├── ReportTester-952747-hst(20260913-045805).png
    ├── ReportTester-952747-mfemae(20260913-045806).png
    └── ReportTester-952747-holding(20260913-045806).png

The original MT5 report is the primary evidence source for numerical performance claims.

---

## 18. Research Status

    EA: EA-057_Flag_Break
    Implementation: COMPLETE
    Baseline Backtest: COMPLETE
    Baseline Result: FAIL
    Optimization: NOT YET VALIDATED
    Forward Test: NOT YET PERFORMED
    Live Validation: NOT PERFORMED

EA-057 should remain classified as an experimental research EA until additional tests demonstrate robust positive expectancy.

---

## Disclaimer

This research repository documents experimental algorithmic-trading work.

Backtests are historical simulations and do not guarantee future performance. No result documented here should be interpreted as financial advice or a guarantee of profitability.
