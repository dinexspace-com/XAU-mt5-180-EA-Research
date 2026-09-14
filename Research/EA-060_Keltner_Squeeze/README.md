# EA-060 — Keltner Squeeze Research

## 1. Research Objective

This document records the research status of:

**EA-060_Keltner_Squeeze**

The purpose of this stage is to evaluate whether the implemented Keltner Squeeze breakout concept demonstrates a usable trading edge on XAUUSD before further optimization or production development.

This document separates:

1. Strategy hypothesis
2. Implemented trading logic
3. Backtest evidence
4. Observed weaknesses
5. Research conclusions
6. Next research direction

The current implementation is treated as a research baseline, not as a production-ready trading system.

---

## 2. Strategy Hypothesis

The strategy is based on the following market hypothesis:

> A period of volatility contraction may be followed by volatility expansion. If price closes outside the Keltner Channel after a compressed-volatility state, the breakout may provide a directional trading opportunity.

The EA therefore combines two concepts:

- Volatility compression
- Price breakout

The Keltner Channel provides both the volatility measurement and breakout boundary.

---

## 3. Implemented Strategy

The current EA uses:

- EMA as the Keltner Channel center line
- ATR to determine channel width
- Keltner Channel width contraction to detect a squeeze
- Candle close outside the channel to detect breakout
- Fixed Stop Loss
- Fixed Take Profit
- Break Even
- Trailing Stop
- Spread filtering

The strategy supports both BUY and SELL signals.

---

## 4. Keltner Channel Model

The implemented channel is:

Upper Channel:

    Upper = EMA + ATR × Multiplier

Lower Channel:

    Lower = EMA - ATR × Multiplier

Channel width:

    Width = 2 × ATR × Multiplier

The EA compares the current channel width with historical channel width to identify volatility compression.

---

## 5. Squeeze Logic

The squeeze condition implemented by the EA is based on:

    Current Width <= Average Historical Width × Squeeze Ratio

The backtested configuration used:

    EMA Period       = 20
    ATR Period       = 20
    ATR Multiplier   = 2
    Squeeze Lookback = 2
    Squeeze Ratio    = 1.5

These are the parameters actually used in the recorded MT5 backtest and therefore represent the current research baseline.

---

## 6. Entry Hypothesis

### BUY

The strategy attempts to capture bullish volatility expansion when:

1. A Keltner squeeze condition exists.
2. The previous reference candle was inside the channel.
3. The latest completed candle closes above the upper Keltner Channel.
4. Spread and trading conditions permit entry.
5. No existing EA position is active for the same symbol and Magic Number.

Conceptually:

    Compression
        ↓
    Price inside channel
        ↓
    Close above upper channel
        ↓
    BUY

### SELL

The inverse condition is used for bearish breakouts:

    Compression
        ↓
    Price inside channel
        ↓
    Close below lower channel
        ↓
    SELL

---

## 7. Risk and Exit Model

The tested configuration used:

    Lot Size              = 0.01
    Stop Loss             = 300 points
    Take Profit           = 600 points

Break Even:

    Enabled               = true
    Trigger               = 150 points
    Offset                = 0

Trailing Stop:

    Enabled               = true
    Start                 = 200 points
    Distance              = 150 points

Maximum entry spread:

    30 points

The nominal fixed SL/TP configuration therefore begins with a 1:2 stop-loss-to-take-profit distance relationship before Break Even and Trailing Stop modify the effective exit behavior.

---

## 8. Baseline Backtest

### Environment

    Expert:          EA-060_Keltner_Squeeze
    Symbol:          XAUUSD.PRO
    Timeframe:       M1
    Period:          2026.01.02 - 2026.04.01
    Initial Deposit: $1,000
    Leverage:        1:500
    Lot Size:        0.01
    History Quality: 100% real ticks
    Bars:            86,539
    Ticks:           40,346,891

This test is retained as the baseline empirical result for the current strategy implementation and parameter configuration.

---

## 9. Baseline Results

    Total Net Profit:          -$921.69

    Gross Profit:              $3,929.48
    Gross Loss:                -$4,851.17

    Profit Factor:             0.81
    Expected Payoff:           -$0.25
    Recovery Factor:           -0.98
    Sharpe Ratio:              -5.00

    Balance Drawdown Maximal:  $935.93 (92.45%)
    Equity Drawdown Maximal:   $936.18 (92.48%)

    Total Trades:              3,642
    Total Deals:               7,284

    Winning Trades:            1,717 (47.14%)
    Losing Trades:             1,925 (52.86%)

---

## 10. Directional Results

Short trades:

    Trades:     1,853
    Win Rate:   47.33%

Long trades:

    Trades:     1,789
    Win Rate:   46.95%

The backtest does not show a large difference between BUY and SELL win rates.

The difference is only:

    47.33% - 46.95% = 0.38 percentage points

Therefore, the baseline evidence does not indicate that simply disabling one direction would solve the strategy's performance problem.

---

## 11. Trade Distribution

Largest profit trade:

    $8.80

Largest loss trade:

    -$5.62

Average profit trade:

    $2.29

Average loss trade:

    -$2.52

Maximum consecutive wins:

    12 trades
    $26.59

Maximum consecutive losses:

    10 trades
    -$31.33

Average consecutive wins:

    2

Average consecutive losses:

    2

Although the nominal TP distance is larger than the nominal SL distance, the realized average winning trade is smaller in absolute value than the realized average losing trade:

    Average Win  = $2.29
    Average Loss = $2.52

This indicates that the effective exit behavior produced by Stop Loss, Take Profit, Break Even and Trailing Stop does not preserve the nominal 1:2 relationship in realized trade outcomes.

---

## 12. Holding-Time Characteristics

Minimum position holding time:

    00:00:01

Maximum position holding time:

    02:04:00

Average position holding time:

    00:02:07

The average trade lasts only slightly more than two minutes.

Therefore, despite using breakout logic, the tested implementation behaves operationally as a very short-duration M1 trading system.

This makes execution characteristics such as spread, price movement immediately after entry, stop management and short-term market noise particularly important for further investigation.

---

## 13. MFE / MAE Evidence

The MT5 report recorded:

    Correlation (Profits, MFE):  0.97
    Correlation (Profits, MAE):  0.71
    Correlation (MFE, MAE):      0.6272

The strong Profit/MFE correlation indicates that trades which achieve greater favorable excursion are strongly associated with higher realized profit.

However, this metric alone does not establish how the exit rules should be changed.

The raw trade behavior should be examined before modifying Take Profit, Break Even or Trailing Stop.

---

## 14. Equity Curve Observation

The balance graph shows a persistent downward trajectory across the test.

The account begins with approximately:

    $1,000

and finishes after losing:

    $921.69

The maximum balance drawdown reaches:

    92.45%

and maximum equity drawdown reaches:

    92.48%

This is not an isolated small statistical loss.

The baseline configuration exhibits sustained negative performance over the tested sample.

---

## 15. Baseline Assessment

### RESULT: FAIL

The current configuration fails the baseline research test.

Primary evidence:

    Net Profit        = -$921.69
    Profit Factor     = 0.81
    Expected Payoff   = -$0.25
    Recovery Factor   = -0.98
    Sharpe Ratio      = -5.00
    Balance DD        = 92.45%
    Equity DD         = 92.48%

The strategy therefore does not currently demonstrate a profitable trading edge in this test.

---

## 16. What the Backtest Establishes

The available evidence supports the following conclusions:

### 1. The current configuration is not profitable

Profit Factor is below 1:

    PF = 0.81

Gross losses exceed gross profits.

### 2. Risk is unacceptable

Maximum drawdown exceeds 92%.

This configuration is unsuitable for production deployment.

### 3. Trade frequency is high

The EA generated:

    3,642 trades

during approximately three months of M1 testing.

### 4. Realized payoff structure is unfavorable

Average winner:

    $2.29

Average loser:

    -$2.52

Combined with a win rate of:

    47.14%

this produces negative expectancy.

### 5. Both BUY and SELL sides currently fail to provide an obvious directional solution

Their win rates are very similar.

---

## 17. What the Backtest Does NOT Establish

This test does NOT prove that:

- every Keltner breakout strategy is unprofitable;
- Keltner Channels are unsuitable for XAUUSD;
- the strategy cannot work on another timeframe;
- different squeeze definitions cannot work;
- different exits cannot improve performance;
- market-regime filters cannot improve signal quality.

The test establishes only that:

> The current EA implementation with the recorded parameter configuration failed on XAUUSD.PRO M1 over the tested period.

This distinction must be preserved during subsequent research.

---

## 18. Primary Research Problem

The next research task should NOT begin with blind parameter optimization.

The first question is:

> Why does the current breakout hypothesis produce negative expectancy?

The current evidence suggests several components requiring investigation:

    Signal quality
        ↓
    Squeeze definition
        ↓
    Breakout confirmation
        ↓
    Market regime
        ↓
    Exit behavior
        ↓
    Effective expectancy

These should be investigated before large-scale optimization.

---

## 19. Research Questions

The next research stage should answer:

### Signal

- Are many entries false breakouts?
- Does price frequently return inside the Keltner Channel immediately after entry?
- Does breakout candle size affect outcome?
- Does breakout direction relative to a higher-timeframe trend affect outcome?

### Squeeze

- Is the current squeeze definition actually identifying meaningful volatility contraction?
- Is `SqueezeRatio = 1.5` too permissive for the implemented inequality?
- Is `SqueezeLookback = 2` sufficient to represent a genuine volatility compression period?

### Exit

- Is Break Even being triggered too early?
- Is Trailing Stop cutting profitable breakouts before expansion completes?
- What percentage of trades reaches significant MFE before closing?
- How much potential profit is being surrendered or prematurely closed?

### Market Regime

- Does the strategy behave differently during trending and ranging conditions?
- Are results materially different by trading session?
- Are specific volatility environments responsible for most losses?

---

## 20. Important Squeeze-Parameter Observation

The tested condition is conceptually:

    Current Width <= Historical Average Width × Squeeze Ratio

The tested value is:

    Squeeze Ratio = 1.5

This deserves specific investigation.

A ratio greater than 1 allows the current width to be as high as 150% of the historical average while still satisfying the implemented condition.

Therefore, depending on the exact intended definition of "squeeze", this setting may not represent strict volatility compression.

This is a research hypothesis requiring validation against the strategy's intended design before modifying the EA.

---

## 21. Recommended Next Experiment

The next experiment should isolate the signal logic before performing broad optimization.

Recommended priority:

### Experiment 01 — Validate Squeeze Definition

Objective:

Determine whether the implemented squeeze filter is actually selecting periods of meaningful volatility contraction.

Compare a small controlled set of Squeeze Ratio values while keeping all other variables unchanged.

Candidate test values:

    0.60
    0.70
    0.80
    0.90
    1.00

Keep fixed:

    Symbol            = XAUUSD.PRO
    Timeframe         = M1
    EMA Period        = 20
    ATR Period        = 20
    ATR Multiplier    = 2
    Lot Size          = 0.01
    Stop Loss         = 300
    Take Profit       = 600
    Break Even        = unchanged
    Trailing Stop     = unchanged

The purpose is not yet to find the "best" parameter.

The purpose is to determine whether stricter volatility compression materially changes:

    Trade Count
    Profit Factor
    Expected Payoff
    Drawdown
    Win Rate
    Average Win
    Average Loss

Only after this behavior is understood should additional variables be changed.

---

## 22. Research Status

    EA:                 EA-060_Keltner_Squeeze
    Source available:   YES
    Backtest available: YES
    Real ticks:         YES
    Baseline completed: YES
    Baseline result:    FAIL
    Production ready:   NO
    Optimization ready: NOT YET
    Next stage:         Squeeze-definition experiment

---

## 23. Evidence

The research baseline is supported by the files stored in:

    EAs/EA-060_Keltner_Squeeze/

and:

    Backtest/EA-060_Keltner_Squeeze/

The original MetaTrader 5 HTML Strategy Tester report is the authoritative source for backtest performance metrics.

Backtest graphs are retained as supporting visual evidence.

No profitable-performance claim should be made for EA-060 based on the current baseline result.

---

## 24. Conclusion

EA-060 successfully implements a testable Keltner Squeeze breakout concept and generates a sufficiently large sample of trades for initial analysis.

However, the current XAUUSD.PRO M1 baseline configuration fails decisively.

The combination of:

    Negative Net Profit
    Profit Factor < 1
    Negative Expected Payoff
    >92% Drawdown
    Negative Recovery Factor
    Negative Sharpe Ratio
    Persistent declining balance curve

means the current version must remain classified as a research EA.

The correct next step is not production deployment and not blind optimization.

The next step is controlled investigation of the squeeze definition, beginning with the Squeeze Ratio while holding the remaining strategy variables constant.
