# Research — EA-051 15-Bar Extremes

## 1. Research Objective

This research evaluates whether a short-term price breakout beyond the recent 15-bar extreme can provide a viable systematic trading signal for XAUUSD.

The strategy belongs to the broader family of **price-channel breakout / trend-following systems**.

The core hypothesis is:

> When price breaks beyond the highest high or lowest low of a recent rolling window and the breakout candle closes strongly near its extreme, the probability of short-term continuation may increase.

EA-051 implements this hypothesis mechanically so that it can be evaluated objectively using MetaTrader 5 historical testing.

---

## 2. Strategy Concept

For every completed candle, the strategy determines the highest high and lowest low of the preceding 15 bars.

These levels define the recent trading range.

Conceptually:

    Upper Extreme = Highest High of previous 15 bars
    Lower Extreme = Lowest Low of previous 15 bars

A potential bullish breakout occurs when price exceeds the upper extreme.

A potential bearish breakout occurs when price falls below the lower extreme.

EA-051 adds a breakout-candle confirmation condition rather than treating every penetration of the range as a valid signal.

The purpose is to distinguish a stronger breakout candle from a marginal price excursion beyond the previous range.

---

## 3. Relationship to Price-Channel Breakout Systems

The EA-051 concept is closely related to Donchian-style price-channel breakout systems.

A Donchian channel defines its upper and lower boundaries using the highest high and lowest low over a rolling lookback period.

Classical implementations often use longer lookback periods such as 20 bars, but the underlying mechanism is the same:

    Recent High → Upper breakout boundary
    Recent Low  → Lower breakout boundary

A new high or low is interpreted as evidence that price may be entering a directional move.

EA-051 uses a **15-bar lookback**, making it a shorter-horizon variation of this general breakout concept.

The 15-bar value should therefore be treated as a strategy parameter to be tested rather than as a universally optimal value.

---

## 4. Trend-Following Rationale

Breakout strategies are based on the assumption that some price movements exhibit persistence.

When a market begins trending, it must eventually move beyond previous local highs or lows.

A breakout system attempts to enter after this directional movement becomes observable rather than attempting to predict the turning point in advance.

Academic research provides broader evidence for persistence and time-series momentum across multiple financial markets.

Moskowitz, Ooi and Pedersen (2012) documented time-series momentum across equity index, currency, commodity and bond futures.

Their results showed that an instrument's own past returns can contain information about subsequent returns over certain horizons.

This does not prove that a 15-bar XAUUSD M1 breakout is profitable.

It provides only a broader theoretical justification for testing systematic trend-following and momentum rules.

---

## 5. Breakout Confirmation

A simple price-channel strategy could enter immediately whenever price crosses the previous N-bar high or low.

EA-051 uses an additional confirmation concept based on where the breakout candle closes within its own range.

For a bullish breakout, the candle should close near its high.

For a bearish breakout, the candle should close near its low.

Conceptually:

    Candle Range = High - Low

For BUY confirmation:

    Close should be located in the upper portion of the candle range.

For SELL confirmation:

    Close should be located in the lower portion of the candle range.

The intention is to reject weak breakout candles where price temporarily exceeds the previous extreme but fails to maintain directional pressure before the candle closes.

This is a plausible breakout-quality filter, but its usefulness must be established empirically.

---

## 6. Expected Behaviour of Breakout Strategies

Breakout systems commonly experience false breakouts.

A typical pattern is:

    Range
      ↓
    Breakout
      ↓
    Entry
      ↓
    Price returns inside range
      ↓
    Stop Loss

Therefore, a breakout strategy does not necessarily require a high win rate to be viable.

A system can theoretically remain profitable when:

    Average Winner × Number of Winners
                    >
    Average Loser × Number of Losers

This means Profit Factor, expectancy, drawdown and payoff distribution are more informative than win rate alone.

A low win rate is therefore not automatically evidence that a breakout strategy is invalid.

However, a low win rate combined with insufficient winner magnitude produces negative expectancy.

That distinction is important when interpreting EA-051.

---

## 7. EA-051 Baseline Implementation

The tested EA uses the following baseline configuration:

| Parameter | Value |
|---|---:|
| Strategy | 15-Bar Extremes |
| Market | XAUUSD.PRO |
| Timeframe | M1 |
| Lookback Concept | Previous 15 bars |
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Maximum Spread | 35 |
| Break Even | Disabled |
| Trailing Stop | Disabled |

The nominal SL/TP relationship is:

    Stop Loss   = 300
    Take Profit = 600

Therefore:

    Nominal Reward : Risk = 2 : 1

This asymmetric payoff structure is consistent with the general idea of accepting smaller losses while attempting to capture larger directional moves.

Actual realized profit and loss, however, must be determined from the Strategy Tester results rather than assumed from the configured SL/TP ratio.

---

## 8. Baseline Backtest

The initial EA-051 experiment was performed using MetaTrader 5 Strategy Tester.

### Test Environment

| Parameter | Value |
|---|---:|
| Expert Advisor | EA-051_15-Bar_Extremes |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-03-31 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |

---

## 9. Baseline Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$743.41 |
| Gross Profit | $3,795.03 |
| Gross Loss | -$4,538.44 |
| Profit Factor | 0.84 |
| Expected Payoff | -$0.36 |
| Recovery Factor | -0.93 |
| Sharpe Ratio | -5.00 |
| Total Trades | 2,046 |
| Winning Trades | 613 (29.96%) |
| Losing Trades | 1,433 (70.04%) |
| Long Trades | 1,041 |
| Long Win Rate | 31.03% |
| Short Trades | 1,005 |
| Short Win Rate | 28.86% |
| Maximum Balance Drawdown | $799.59 (77.71%) |
| Maximum Equity Drawdown | $800.58 (77.75%) |
| Average Profit Trade | $6.19 |
| Average Loss Trade | -$3.17 |
| Largest Profit Trade | $36.63 |
| Largest Loss Trade | -$38.29 |
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Losses | 26 |

---

## 10. Expectancy Analysis

The most important observation is that EA-051 does generate winners substantially larger than its average losers.

    Average Winner = $6.19
    Average Loser  = $3.17

Therefore:

    Average Winner / Average Loser
    = 6.19 / 3.17
    ≈ 1.95

This is close to the nominal 2:1 TP/SL relationship.

However, only 29.96% of trades were profitable.

The approximate break-even win rate for a payoff ratio of 1.95 is:

    Break-even Win Rate
    = 1 / (1 + 1.95)
    ≈ 33.9%

Observed:

    Actual Win Rate ≈ 29.96%

Required:

    Break-even Win Rate ≈ 33.9%

Therefore the system falls several percentage points below the approximate win rate required to compensate for its losing trades.

This explains the negative expectancy despite winners being approximately twice as large as average losers.

---

## 11. Profit Factor Analysis

EA-051 produced:

    Gross Profit = $3,795.03
    Gross Loss   = $4,538.44

Therefore:

    Profit Factor
    = Gross Profit / Gross Loss
    ≈ 0.84

A Profit Factor below 1 means the strategy lost more money than it generated during the tested sample.

For every $1.00 lost, the baseline configuration generated approximately:

    $0.84 gross profit

This confirms that the baseline strategy did not possess sufficient positive expectancy during the test period.

---

## 12. Drawdown Analysis

Maximum equity drawdown reached:

    77.75%

This is extremely high relative to the initial $1,000 account.

The balance curve also shows a persistent downward trajectory rather than a single isolated loss event.

This suggests that the poor result cannot be explained solely by one unusually large trade.

Instead, the tested configuration repeatedly accumulated losses throughout the sample.

For research purposes this is important because it indicates a structural weakness in the baseline signal/configuration during the tested period.

---

## 13. Long vs Short Performance

The strategy generated:

    Long Trades  = 1,041
    Long Win Rate = 31.03%

    Short Trades = 1,005
    Short Win Rate = 28.86%

Both directions performed poorly.

Long trades performed slightly better than short trades, but neither side achieved a win rate sufficient to make the baseline strategy profitable.

This suggests that the baseline failure cannot simply be attributed to one directional side of the strategy.

Directional separation should nevertheless be tested in future experiments.

---

## 14. Trade Frequency

EA-051 executed:

    2,046 trades

during approximately three months of M1 data.

This is a relatively large number of trades for the test period.

High signal frequency is useful statistically because the baseline result is not based on only a handful of observations.

However, frequent trading also increases exposure to:

- spread,
- execution costs,
- slippage,
- market noise,
- false breakouts.

This is especially relevant for a short-lookback breakout strategy operating on M1.

---

## 15. Holding-Time Behaviour

The Strategy Tester reported:

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Average Holding Time | 00:06:48 |
| Maximum Holding Time | 04:42:04 |

The average trade lasts less than seven minutes.

Therefore EA-051 behaves as a very short-term breakout system rather than a conventional medium- or long-horizon trend-following system.

This distinction matters.

Academic evidence for trend following at longer horizons cannot automatically be assumed to apply to a 15-bar M1 strategy.

EA-051 must be validated independently at its actual trading horizon.

---

## 16. Main Finding

### Baseline Result: FAIL

The current EA-051 configuration does not demonstrate a viable trading edge on the tested XAUUSD.PRO M1 sample.

The failure is supported by several independent metrics:

    Net Profit       < 0
    Profit Factor    < 1
    Expected Payoff  < 0
    Recovery Factor  < 0
    Sharpe Ratio     < 0
    Drawdown         > 77%

The balance curve also declines persistently throughout the experiment.

Therefore the current implementation should be considered a **failed baseline experiment**, not a production-ready trading strategy.

---

## 17. What the Failure Does Not Prove

This backtest does NOT prove that:

- all price breakout strategies fail,
- Donchian-style systems are invalid,
- XAUUSD cannot be traded using trend-following methods,
- every 15-bar breakout configuration will fail,
- another timeframe will produce the same result.

It demonstrates only that:

> The tested implementation and parameter configuration of EA-051 failed on XAUUSD.PRO M1 over the period 2026-01-02 to 2026-03-31.

This distinction is important to prevent overgeneralizing from one experiment.

---

## 18. Primary Research Hypothesis After Baseline Test

The baseline results suggest that the main problem is not the configured reward-to-risk relationship.

Average profitable trades are already approximately twice the size of average losing trades.

The primary weakness is the frequency of losing breakout signals.

Therefore the next research question should be:

> Can false breakouts be reduced without destroying the profitable breakout opportunities?

This should be investigated before simply increasing Take Profit or changing position size.

---

## 19. Candidate Research Directions

The following ideas are research hypotheses only and have NOT yet been validated for EA-051.

### A. Lookback Sensitivity

Test whether 15 bars is too sensitive for XAUUSD M1.

Candidate values:

    10
    15
    20
    30
    50

The objective is not to find the single best historical number.

The objective is to determine whether performance remains reasonably stable across neighboring lookback values.

### B. Higher-Timeframe Trend Filter

Only allow:

    BUY when higher-timeframe trend is bullish
    SELL when higher-timeframe trend is bearish

Possible research filters include moving-average direction or price relative to a higher-timeframe moving average.

This is consistent with the broader trend-following concept but must be tested independently.

### C. Volatility Filter

Breakouts during very low volatility may represent market noise.

ATR or another volatility measure could be used to test whether trades should only occur when market movement exceeds a predefined threshold.

### D. Breakout Distance

Instead of accepting any movement beyond the previous 15-bar extreme, require price to exceed the boundary by a minimum distance.

Conceptually:

    BUY:
    Close > PreviousHigh + BreakoutBuffer

    SELL:
    Close < PreviousLow - BreakoutBuffer

The buffer could potentially be expressed in points or relative to ATR.

### E. Session Filter

The trade-distribution charts show that signals occur across many hours.

Because XAUUSD liquidity and volatility vary throughout the trading day, performance should be segmented by trading session before implementing a session restriction.

Possible research groups:

    Asia
    Europe / London
    US / New York

A session filter should only be added if the data demonstrates a stable difference in expectancy.

### F. Long/Short Separation

Long and short performance should be evaluated independently.

This may determine whether:

    Long only
    Short only
    Long + Short

should be investigated as separate variants.

### G. Exit Research

The baseline uses fixed SL and TP.

Alternative exit mechanisms can later be evaluated, including:

    ATR-based stop
    opposite-channel exit
    trailing stop
    break-even
    time-based exit

However, exit optimization should not be used to hide a fundamentally poor entry signal.

Entry quality should be investigated first.

---

## 20. Research Order

To minimize overfitting, experiments should be performed incrementally.

Recommended sequence:

    Baseline
        ↓
    Lookback sensitivity
        ↓
    Breakout-strength / distance filter
        ↓
    Volatility filter
        ↓
    Session analysis
        ↓
    Higher-timeframe trend filter
        ↓
    Exit research
        ↓
    Combined candidate
        ↓
    Out-of-sample validation

Only one major strategy component should be changed at a time whenever possible.

This makes it possible to identify which modification actually changes performance.

---

## 21. Overfitting Control

A profitable optimized backtest alone is not sufficient evidence of a trading edge.

Testing many parameter combinations creates a risk of selecting parameters that fit historical noise.

Therefore future EA-051 research should avoid choosing a configuration solely because it produces the highest historical profit.

A stronger candidate should demonstrate:

- positive expectancy,
- acceptable drawdown,
- Profit Factor above 1,
- sufficient trade count,
- reasonable parameter stability,
- performance across different time periods,
- out-of-sample survival.

Parameter regions are more important than isolated optimal values.

For example, if:

    Lookback 29 → strong profit
    Lookback 30 → strong profit
    Lookback 31 → strong profit

this is generally more interesting than:

    Lookback 29 → loss
    Lookback 30 → exceptional profit
    Lookback 31 → loss

The latter pattern is more suspicious and may indicate curve fitting.

---

## 22. Research Status

| Stage | Status |
|---|---|
| Strategy concept defined | COMPLETE |
| MQL5 implementation | COMPLETE |
| Baseline MT5 backtest | COMPLETE |
| Real-tick baseline test | COMPLETE |
| Baseline performance evaluation | COMPLETE |
| Baseline strategy | FAIL |
| Lookback sensitivity test | NOT TESTED |
| Breakout filter research | NOT TESTED |
| Volatility filter | NOT TESTED |
| Session filter | NOT TESTED |
| Higher-timeframe filter | NOT TESTED |
| Exit optimization | NOT TESTED |
| Out-of-sample validation | NOT TESTED |
| Forward test | NOT TESTED |

---

## 23. Research Conclusion

EA-051 provides a clean experimental implementation of a short-term price-extreme breakout strategy.

The underlying concept is related to established price-channel and trend-following methods, and broader academic literature provides evidence that price trends and time-series momentum can exist in financial markets.

However, theoretical plausibility does not imply profitability for a particular implementation.

The first real-tick XAUUSD.PRO M1 experiment produced:

    Net Profit      = -$743.41
    Profit Factor   = 0.84
    Win Rate        = 29.96%
    Equity Drawdown = 77.75%

Therefore:

    EA-051 BASELINE = FAIL

The result should be retained rather than discarded.

It establishes a reproducible baseline from which subsequent hypotheses can be tested.

The most important next research objective is not to maximize historical profit.

It is to determine whether the high false-breakout rate can be reduced through simple, logically justified modifications that remain robust outside the original test sample.

---

## References

1. Moskowitz, T. J., Ooi, Y. H., & Pedersen, L. H. (2012). *Time Series Momentum*. Journal of Financial Economics, 104(2), 228–250. DOI: 10.1016/j.jfineco.2011.11.003.

2. Marshall, B. R., Nguyen, N. H., & Visaltanachoti, N. (2017). *Time Series Momentum and Moving Average Trading Rules*. Quantitative Finance, 17(3), 405–421. DOI: 10.1080/14697688.2016.1205209.

3. Donchian-style price-channel breakout literature and systematic trend-following methodology are used as conceptual references. EA-051's 15-bar M1 implementation and its specific confirmation, stop-loss and take-profit rules are independently tested strategy components and should not be interpreted as the classical Donchian system.

---

## Disclaimer

This repository is for quantitative research, software development, backtesting, and educational purposes.

Historical backtest performance does not guarantee future results.

EA-051 should not be considered production-ready unless it passes subsequent robustness, out-of-sample, and forward-testing stages.
