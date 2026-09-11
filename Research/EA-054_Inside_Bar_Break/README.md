# Research — EA-054 Inside Bar Break

## 1. Research Objective

This research investigates whether a simple and fully mechanical **Inside Bar / Mother Bar breakout strategy** can produce a repeatable trading edge on XAUUSD.

The strategy is intentionally kept simple.

The research process is:

```text
Price Action Pattern
        ↓
Define Mechanical Rules
        ↓
Implement in MQL5
        ↓
Backtest on XAUUSD
        ↓
Measure Performance
        ↓
Identify Weaknesses
        ↓
Define Next Research Tests
```

The implementation produced from this research is:

```text
EA-054_Inside_Bar_Break.mq5
```

---

# 2. Strategy Classification

```text
Strategy ID:       EA-054
Strategy Name:     Inside Bar Break
Market:            XAUUSD
Platform:          MetaTrader 5
Language:          MQL5
Strategy Family:   Price Action
Strategy Type:     Breakout
Pattern:           Mother Bar + Inside Bar
Direction:         Long + Short
Initial Test TF:   M1
```

---

# 3. Core Market Idea

An Inside Bar is a candle whose trading range remains inside the high-low range of the preceding candle.

The preceding candle is referred to as the:

```text
Mother Bar
```

The following contained candle is the:

```text
Inside Bar
```

Structure:

```text
Mother Bar
│
├── High
│
│      Inside Bar
│      ├── High
│      │
│      └── Low
│
└── Low
```

Mechanical condition:

```text
Inside High <= Mother High
AND
Inside Low >= Mother Low
```

The pattern represents a contraction in price range.

The research hypothesis is that a contraction can sometimes be followed by directional expansion.

Instead of predicting the direction of that expansion, the strategy waits for price to break the Mother Bar boundary.

---

# 4. Research Hypothesis

The primary hypothesis is:

> When XAUUSD forms an Inside Bar within a Mother Bar, a subsequent breakout beyond the Mother Bar range may contain enough directional movement to support a mechanical breakout strategy.

The EA therefore does not attempt to predict whether the breakout will occur upward or downward.

Instead:

```text
Inside Bar detected
        ↓
Mother Bar range recorded
        ↓
Wait
        ↓
Price breaks Mother High → BUY

OR

Price breaks Mother Low → SELL
```

This creates a direction-neutral breakout framework.

---

# 5. Pattern Definition

The strategy evaluates completed candles.

```text
Bar[2] = Mother Bar
Bar[1] = Inside Bar
Bar[0] = Current forming candle
```

A setup is valid when:

```text
High[1] <= High[2]
AND
Low[1] >= Low[2]
```

If this condition is satisfied:

```text
MotherHigh = High[2]
MotherLow  = Low[2]
```

These levels become the breakout boundaries.

---

# 6. BUY Hypothesis

A bullish breakout occurs when the current Ask price exceeds the stored Mother Bar high.

```text
Ask > MotherHigh
```

Execution:

```text
Valid Inside Bar
      ↓
Store Mother High
      ↓
Wait for breakout
      ↓
Ask > Mother High
      ↓
BUY
```

The research assumption is that breaking above the entire Mother Bar range provides stronger confirmation than entering merely because an Inside Bar has formed.

---

# 7. SELL Hypothesis

A bearish breakout occurs when the current Bid price falls below the stored Mother Bar low.

```text
Bid < MotherLow
```

Execution:

```text
Valid Inside Bar
      ↓
Store Mother Low
      ↓
Wait for breakout
      ↓
Bid < Mother Low
      ↓
SELL
```

The same structure is therefore tested symmetrically in both directions.

---

# 8. Why Use the Mother Bar Boundary?

There are multiple possible breakout definitions for an Inside Bar strategy.

For example:

```text
Inside Bar High / Low breakout
Mother Bar High / Low breakout
Breakout candle close confirmation
Buffered breakout
```

EA-054 uses:

```text
Mother Bar High / Low breakout
```

This is the more conservative interpretation used in this experiment.

The objective is to require price to leave the complete two-candle structure before triggering an entry.

---

# 9. Initial Risk Model

The baseline EA configuration uses:

```text
Lot Size    = 0.01
Stop Loss   = 300 points
Take Profit = 600 points
```

Nominal initial SL/TP distance relationship:

```text
SL : TP
300 : 600

= 1 : 2
```

This is only the initial order configuration.

Actual realized profit and loss can differ because the EA also uses:

```text
Break Even
Trailing Stop
Spread Filter
Broker Stop-Level Validation
```

---

# 10. Break Even Research Rule

Baseline configuration:

```text
Break Even Enabled = true
Trigger            = 150 points
Offset             = 0 points
```

When a trade reaches the required favorable movement, the EA attempts to move the Stop Loss toward the entry price.

Objective:

```text
Protect trades that have already moved favorably
+
Reduce the probability that a profitable excursion becomes a full SL loss
```

---

# 11. Trailing Stop Research Rule

Baseline configuration:

```text
Trailing Stop Enabled = true
Trailing Start        = 200 points
Trailing Distance     = 150 points
```

The purpose is to allow favorable breakout movement to continue while progressively protecting accumulated profit.

Concept:

```text
Breakout
   ↓
Position gains
   ↓
Break Even
   ↓
Further favorable movement
   ↓
Trailing Stop
```

---

# 12. Execution Protection

The implementation also includes execution controls that are separate from the underlying Inside Bar hypothesis.

These include:

```text
Maximum Spread
Maximum Positions
Magic Number isolation
Volume normalization
Price normalization
Broker minimum stop-distance validation
Trading-permission checks
```

Baseline values:

```text
Maximum Spread    = 30 points
Maximum Positions = 1
Magic Number      = 123456
Slippage          = 10 points
```

These controls are intended to make the strategy mechanically testable and executable in MT5.

---

# 13. Baseline Backtest

The first documented baseline test was performed using:

```text
EA:              EA-054_Inside_Bar_Break
Symbol:          XAUUSD.PRO
Timeframe:       M1
Period:          2026-01-02 → 2026-03-31
Initial Deposit: $1,000
Leverage:        1:500
Lot Size:        0.01
History Quality: 100% real ticks
```

Dataset:

```text
Bars:  85,161
Ticks: 39,639,179
```

---

# 14. Baseline Results

```text
Total Net Profit:       +$75.40
Gross Profit:           $8,415.15
Gross Loss:             -$8,339.75

Profit Factor:          1.01
Expected Payoff:        $0.01
Recovery Factor:        0.21
Sharpe Ratio:           1.08

Maximum Balance DD:     33.99%
Maximum Equity DD:      34.10%

Total Trades:           7,172
Total Deals:            14,344

Winning Trades:         3,707
Win Rate:               51.69%

Losing Trades:          3,465
Loss Rate:              48.31%
```

---

# 15. Long vs Short Behavior

Baseline results:

```text
SHORT

Trades:     3,185
Win Rate:   52.90%

LONG

Trades:     3,987
Win Rate:   50.71%
```

The short side produced a slightly higher win rate than the long side during this sample.

Difference:

```text
52.90% - 50.71%
= 2.19 percentage points
```

This difference is worth investigating, but the baseline alone is not sufficient evidence to conclude that the strategy should become short-only.

---

# 16. Winner / Loser Structure

Baseline:

```text
Largest Winner:       +$35.96
Largest Loser:        -$33.78

Average Winner:       +$2.27
Average Loser:        -$2.41
```

The average loss was larger than the average win.

Therefore the strategy depended on maintaining a win rate above 50% to remain profitable during this test.

This explains an important baseline characteristic:

```text
Win Rate = 51.69%

but

Profit Factor = 1.01
```

The strategy is operating very close to its break-even boundary.

---

# 17. Drawdown Analysis

Maximum equity drawdown:

```text
$357.80
34.10%
```

Net profit:

```text
+$75.40
```

Therefore:

```text
Net Profit << Maximum Drawdown
```

Recovery Factor confirms this weakness:

```text
Recovery Factor = 0.21
```

This is one of the primary problems identified by the baseline test.

The strategy currently accepts too much drawdown relative to the amount of profit retained.

---

# 18. Trade Frequency

The EA generated:

```text
7,172 trades
```

during approximately three months of M1 testing.

Average holding time:

```text
00:02:44
```

Minimum:

```text
00:00:01
```

Maximum:

```text
03:37:13
```

This means the tested implementation behaves as a very short-duration, high-frequency breakout system.

This characteristic makes execution conditions particularly important.

Relevant variables include:

```text
Spread
Slippage
Commission
Tick quality
Broker execution
Session liquidity
```

---

# 19. MFE / MAE Evidence

MT5 reported:

```text
Correlation (Profit, MFE) = 0.95
Correlation (Profit, MAE) = 0.70
Correlation (MFE, MAE)    = 0.5442
```

The strongest observed relationship is:

```text
Profit ↔ MFE = 0.95
```

This suggests that favorable price excursion after entry is strongly related to final trade profitability.

This makes exit management an important candidate for later research.

Possible future experiments can investigate whether the current:

```text
Break Even
+
Trailing Stop
+
Take Profit
```

combination captures enough of the favorable movement.

---

# 20. What the Baseline Demonstrates

The baseline provides evidence that:

```text
Inside Bar detection works
Mother Bar breakout execution works
BUY execution works
SELL execution works
Break Even works within the test
Trailing management operates within the test
Thousands of trades can be generated
The EA survives the full test period
The final result is positive
```

However, a positive result alone is not sufficient to validate the strategy.

---

# 21. Main Weaknesses Identified

The first test reveals four major research problems.

## Weakness 1 — Profit Factor

```text
PF = 1.01
```

There is almost no margin between gross profit and gross loss.

---

## Weakness 2 — Drawdown

```text
Maximum Equity DD = 34.10%
```

This is high relative to:

```text
Net Profit = 7.54% of initial $1,000 deposit
```

---

## Weakness 3 — Recovery

```text
Recovery Factor = 0.21
```

The system does not recover enough profit relative to the drawdown experienced.

---

## Weakness 4 — Trade Quality

```text
Average Winner = +$2.27
Average Loser  = -$2.41
```

Despite the nominal 300-point SL and 600-point TP configuration, realized trade management produces an average winner smaller than the average loser.

This deserves further investigation.

---

# 22. Primary Research Question

The next research stage should not ask:

```text
Can an Inside Bar breakout make money?
```

The baseline has already shown that the implementation can finish slightly positive on this sample.

The more useful question is:

```text
Can low-quality Inside Bar breakouts be filtered
without destroying the useful breakout opportunities?
```

This becomes the primary optimization hypothesis for EA-054.

---

# 23. Candidate Research Directions

Potential filters should be tested individually rather than added simultaneously.

Candidate experiments:

```text
Trend filter
ATR / volatility filter
Mother Bar size filter
Inside Bar compression ratio
Trading-session filter
Spread filter adjustment
Breakout buffer
Breakout close confirmation
BUY / SELL asymmetric rules
Time-based setup expiration
SL optimization
TP optimization
Break Even optimization
Trailing Stop optimization
```

Each change should be tested independently whenever possible.

This allows the effect of each rule to be measured.

---

# 24. Research Priority

Based on the baseline evidence, the preferred research order is:

```text
1. Entry quality
2. Market regime / trend
3. Volatility
4. Trading session
5. Exit management
6. Parameter optimization
```

The goal is not simply to maximize net profit.

The target is to improve the relationship between:

```text
Profit
Drawdown
Trade Count
Stability
Robustness
```

---

# 25. Avoid Overfitting

EA-054 generated more than seven thousand trades in the baseline sample.

This provides a large number of observations, but optimization can still overfit the tested January–March 2026 period.

Therefore parameter selection should not be based solely on the best historical result.

Research should eventually separate data into:

```text
Development / In-Sample
        ↓
Validation / Out-of-Sample
        ↓
Forward Test
```

A parameter set should only be considered stronger if its behavior remains acceptable outside the period used to develop it.

---

# 26. Research Acceptance Criteria

The baseline is recorded as:

```text
BASELINE COMPLETE
```

It should **not** be classified as a validated production strategy.

Current evidence:

```text
Net Profit       = Positive
Profit Factor    = Weak
Drawdown         = High
Recovery Factor  = Weak
Trade Sample     = Large
Robustness       = Not yet tested
Out-of-Sample    = Not yet tested
Forward Test     = Not yet performed
```

Current research status:

```text
IMPLEMENTATION: PASS
BASELINE BACKTEST: PASS
STRATEGY ROBUSTNESS: NOT VERIFIED
LIVE READINESS: NOT VERIFIED
```

---

# 27. Research Workflow

EA-054 should continue through:

```text
Strategy hypothesis
        ↓
Mechanical specification
        ↓
MQL5 implementation
        ↓
Baseline backtest
        ↓
Analyze weaknesses
        ↓
Test one improvement at a time
        ↓
Compare against baseline
        ↓
Out-of-sample validation
        ↓
Forward testing
        ↓
Final assessment
```

The baseline must remain unchanged as the comparison reference.

---

# 28. Repository Relationship

Implementation:

```text
EAs/
└── EA-054_Inside_Bar_Break/
    ├── EA-054_Inside_Bar_Break.mq5
    └── README.md
```

Backtest evidence:

```text
Backtest/
└── EA-054_Inside_Bar_Break/
    ├── README.md
    ├── Strategy Tester HTML report
    └── MT5 report charts
```

Research documentation:

```text
Research/
└── README.md
```

General repository methodology:

```text
docs/
└── methodology.md
```

---

# 29. Current Research Conclusion

EA-054 demonstrates that a mechanically defined Mother Bar / Inside Bar breakout strategy can be implemented and tested systematically on XAUUSD.

The first M1 baseline produced:

```text
+$75.40 net profit
7,172 trades
51.69% win rate
1.01 Profit Factor
34.10% maximum equity drawdown
0.21 Recovery Factor
```

The result is slightly profitable but not sufficiently robust for acceptance as a finished trading system.

The key finding from this stage is therefore not simply that the strategy made a profit.

The important finding is:

```text
The raw Inside Bar breakout contains enough signal
to remain near break-even / slightly profitable across
a large trade sample,

but the unfiltered implementation produces too many
low-quality trades and excessive drawdown relative
to the retained profit.
```

EA-054 should therefore remain a **research strategy** until additional filtering, out-of-sample validation and forward testing demonstrate materially stronger robustness.

---

## Disclaimer

This research is for strategy development, quantitative experimentation and educational purposes.

Historical simulation does not guarantee future performance.

No backtest result should be interpreted as proof of future profitability or as a recommendation to deploy the strategy with live capital.
