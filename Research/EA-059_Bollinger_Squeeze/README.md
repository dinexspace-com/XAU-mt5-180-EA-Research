# Research — EA-059_Bollinger_Squeeze

## Research Objective

The purpose of this research is to document the strategy logic, trading hypothesis, implementation assumptions, and observed backtest behavior of **EA-059_Bollinger_Squeeze**.

The EA is designed for XAUUSD and uses a Bollinger Bands volatility squeeze followed by a confirmed breakout as the entry signal.

This document is based on:

- `EA-059_Bollinger_Squeeze.mq5`
- MetaTrader 5 Strategy Tester report
- Backtest period: 2026-01-02 → 2026-04-01
- Symbol: XAUUSD.PRO
- Timeframe: M1
- History Quality: 100% real ticks

No external strategy source has been added to this research folder yet. Therefore, this document describes and evaluates the implemented strategy rather than claiming that the exact rules originate from a specific book, paper, or author.

## Strategy Hypothesis

The core hypothesis is:

> A period of unusually low volatility, represented by narrow Bollinger Bands, may precede a directional expansion. If price closes outside the Bollinger Bands immediately after the squeeze, the breakout may continue far enough to produce a positive reward-to-risk outcome.

The strategy therefore combines two market conditions:

1. Volatility contraction
2. Directional breakout

The EA does not attempt to predict direction during the squeeze itself.

Direction is determined only after price closes beyond one of the Bollinger Bands.

## Indicator

The strategy uses Bollinger Bands.

Core parameters:

- Period: 20
- Deviation: 2.0
- Applied price: Close

The EA calculates Bollinger Band width as:

`Band Width = (Upper Band - Lower Band) / Point`

A market is considered to be in a squeeze when:

`Band Width <= Squeeze Width Threshold`

In the current backtest, the squeeze threshold was:

`500 points`

## Signal Structure

The EA uses completed candles rather than the currently forming candle for signal confirmation.

The basic candle structure is:

- Candle shift 2 = squeeze/reference candle
- Candle shift 1 = breakout confirmation candle
- Candle shift 0 = current candle where the EA evaluates and executes the signal

This structure reduces the risk of entering on an intrabar breakout that disappears before the candle closes.

## BUY Logic

A BUY setup requires the previous market state to satisfy the Bollinger squeeze condition.

The strategy then requires price to close above the upper Bollinger Band.

Simplified logic:

`BandWidth[2] <= SqueezeThreshold`

and

`Close[2] <= UpperBand[2]`

and

`Close[1] > UpperBand[1]`

If all conditions are satisfied, the EA opens a market BUY position.

The logic attempts to capture an upside volatility expansion following compression.

## SELL Logic

A SELL setup uses the inverse condition.

Simplified logic:

`BandWidth[2] <= SqueezeThreshold`

and

`Close[2] >= LowerBand[2]`

and

`Close[1] < LowerBand[1]`

If all conditions are satisfied, the EA opens a market SELL position.

The logic attempts to capture a downside volatility expansion following compression.

## Trade Frequency Control

The EA evaluates new entry signals only once per newly opened candle.

This prevents multiple entries from being generated repeatedly during the same candle.

The implementation also restricts the EA to one active position for the current symbol and Magic Number.

## Risk Model

The tested configuration uses fixed position sizing.

Lot Size:

`0.01`

Stop Loss:

`300 points`

Take Profit:

`600 points`

The nominal Take Profit to Stop Loss ratio is therefore:

`600 / 300 = 2.0`

This means the strategy is structurally designed to allow the average winning trade to compensate for a lower win rate.

The backtest supports this behavior.

Average profitable trade:

`$6.41`

Average losing trade:

`-$3.12`

Observed average winner / loser magnitude:

`6.41 / 3.12 ≈ 2.05`

The observed ratio is close to the nominal 2:1 TP/SL structure.

## Spread Control

The EA rejects new entries when the current spread exceeds:

`30 points`

This filter is particularly relevant for an M1 XAUUSD strategy because short-term trading performance can be sensitive to transaction costs and spread expansion.

## Break Even and Trailing Stop

The EA source includes optional Break Even and Trailing Stop logic.

However, both features were disabled in the current benchmark backtest.

Backtest configuration:

`InpUseBreakEven=false`

`InpUseTrailingStop=false`

Therefore, the current backtest primarily represents the behavior of the raw Bollinger Squeeze entry logic combined with fixed Stop Loss and Take Profit.

This is important when comparing future tests.

A test with Break Even or Trailing Stop enabled should be treated as a different configuration rather than directly mixed with this benchmark.

## Backtest Configuration

Expert Advisor:

`EA-059_Bollinger_Squeeze`

Symbol:

`XAUUSD.PRO`

Timeframe:

`M1`

Period:

`2026-01-02 → 2026-04-01`

Initial Deposit:

`$1,000`

Leverage:

`1:500`

Lot Size:

`0.01`

Stop Loss:

`300 points`

Take Profit:

`600 points`

Bollinger Period:

`20`

Bollinger Deviation:

`2.0`

Squeeze Width:

`500 points`

Maximum Spread:

`30 points`

Break Even:

`Disabled`

Trailing Stop:

`Disabled`

History Quality:

`100% real ticks`

Bars:

`86,539`

Ticks:

`40,346,891`

## Backtest Results

Total Net Profit:

`+$64.47`

Return relative to initial deposit:

`+6.447%`

Gross Profit:

`$1,276.47`

Gross Loss:

`-$1,212.00`

Profit Factor:

`1.05`

Expected Payoff:

`$0.11`

Recovery Factor:

`0.55`

Sharpe Ratio:

`3.93`

Total Trades:

`588`

Total Deals:

`1,176`

Maximum Equity Drawdown:

`$116.23`

Maximum Equity Drawdown Percentage:

`9.97%`

Maximum Balance Drawdown:

`$111.83`

Maximum Balance Drawdown Percentage:

`9.62%`

## Win/Loss Characteristics

Winning Trades:

`199`

Winning Rate:

`33.84%`

Losing Trades:

`389`

Losing Rate:

`66.16%`

The strategy therefore loses considerably more often than it wins.

However, the average profitable trade is larger than the average losing trade.

Average Profit Trade:

`$6.41`

Average Loss Trade:

`-$3.12`

This is consistent with the strategy's approximately 2:1 reward-to-risk structure.

## Long vs Short Performance

Long Trades:

`285`

Long Win Rate:

`37.19%`

Short Trades:

`303`

Short Win Rate:

`30.69%`

In this specific test period, BUY trades had a higher win rate than SELL trades.

The difference is approximately:

`37.19% - 30.69% = 6.50 percentage points`

This is an observation from the current sample only.

It is not sufficient evidence to remove or suppress SELL signals without additional testing.

## Losing Streak Risk

Maximum consecutive losing trades:

`19`

Maximum loss during that sequence:

`-$57.88`

Average consecutive losing trades:

`3`

This is one of the most important characteristics of the current strategy.

A low-win-rate breakout strategy can remain profitable while still producing long losing sequences.

Therefore, risk evaluation should not be based only on maximum drawdown.

Psychological and operational tolerance for repeated losses is also relevant before live deployment.

## Holding Time

Minimum position holding time:

`00:00:01`

Average position holding time:

`00:15:36`

Maximum position holding time:

`03:45:55`

The average holding time confirms that the EA behaves primarily as a short-term strategy on the M1 timeframe.

However, some trades can remain active for several hours.

## MFE / MAE Observations

MetaTrader 5 reported:

Profit vs MFE correlation:

`0.86`

Profit vs MAE correlation:

`0.70`

MFE vs MAE correlation:

`0.4666`

The strong relationship between profit and Maximum Favorable Excursion indicates that profitable trades generally require meaningful directional movement after entry.

This is consistent with the intended breakout logic.

These statistics should be treated as descriptive evidence rather than as sufficient justification for changing the exit logic.

## Equity Curve Observation

The backtest starts with:

`$1,000`

and finishes with approximately:

`$1,064.47`

The strategy generated substantial gains during portions of the test but later gave back a significant percentage of those gains.

The balance curve therefore does not show consistent monotonic growth.

This suggests that performance may depend strongly on the prevailing market regime.

The current strategy appears more effective during periods when volatility compression is followed by sustained directional movement.

Performance weakens when breakout signals fail repeatedly or when the market produces short-lived expansions followed by reversals.

## Research Interpretation

The backtest confirms that the basic Bollinger Squeeze breakout concept can produce a positive result under the tested configuration.

The result is not strong enough to establish robustness.

The key figures supporting this conclusion are:

Net Profit:

`+$64.47`

Profit Factor:

`1.05`

Maximum Equity Drawdown:

`9.97%`

Win Rate:

`33.84%`

Recovery Factor:

`0.55`

Total Trades:

`588`

The strategy has only a small profitability margin above break-even.

A Profit Factor of 1.05 means that relatively small changes in execution costs, spread, market regime, or signal quality may materially affect profitability.

## Current Strengths

The strategy has several useful characteristics:

- Clear and deterministic entry rules
- No discretionary interpretation required
- Uses completed candles for breakout confirmation
- Positive result on 100% real tick data
- 588 trades in the benchmark sample
- Maximum equity drawdown below 10%
- Approximately 2:1 average winner-to-loser magnitude
- Simple structure that is easy to reproduce and audit
- Spread protection included
- Fixed SL and TP make performance attribution relatively clear

## Current Weaknesses

The current evidence also shows important weaknesses:

- Profit Factor is only 1.05
- Recovery Factor is only 0.55
- Win rate is 33.84%
- Maximum losing streak is 19 trades
- Large portion of earlier gains was lost later in the test
- Only one approximately three-month period has been evaluated
- Only M1 has been evaluated in the current benchmark
- Only XAUUSD.PRO has been evaluated
- Only one broker environment has been evaluated
- Break Even and Trailing Stop have not yet been evaluated as part of this benchmark
- No out-of-sample validation is currently documented
- No walk-forward validation is currently documented
- No parameter-stability analysis is currently documented

## Current Research Status

**STATUS: INITIAL STRATEGY VALIDATION COMPLETE**

The implemented strategy successfully produced a profitable MT5 backtest using 100% real tick data.

However:

**ROBUSTNESS VALIDATION: NOT COMPLETE**

The current evidence is sufficient to retain EA-059 as a research candidate.

It is not sufficient to classify the strategy as production-ready.

## Research Baseline

The current baseline configuration should be preserved for future comparison:

`BB Period = 20`

`BB Deviation = 2.0`

`Squeeze Width = 500 points`

`Stop Loss = 300 points`

`Take Profit = 600 points`

`Maximum Spread = 30 points`

`Break Even = OFF`

`Trailing Stop = OFF`

`Lot = 0.01`

`Timeframe = M1`

Future experiments should be compared against this baseline rather than replacing the benchmark results.

## Research Files

Current project relationship:

`EAs/EA-059_Bollinger_Squeeze/`

Contains the implementation source code and EA-level documentation.

`Backtest/EA-059_Bollinger_Squeeze/`

Contains the original MetaTrader 5 Strategy Tester report, charts, backtest evidence, and backtest README.

`Research/README.md`

Contains the research interpretation and strategy hypothesis documented here.

## Source Limitation

At the current stage, no external Bollinger Squeeze research paper, trading book, strategy document, or other reference source has been provided for EA-059.

Therefore:

- The strategy logic documented here is derived from the EA implementation.
- Performance observations are derived from the supplied MT5 backtest.
- No claim is currently made that the exact EA rules reproduce a published Bollinger Squeeze methodology.

External references can be added later if the objective becomes comparing the implemented EA against the original or established Bollinger Squeeze literature.

## Research Conclusion

EA-059_Bollinger_Squeeze demonstrates that a simple volatility-compression breakout strategy can produce positive performance on XAUUSD M1 under the current tested conditions.

The benchmark generated:

`+$64.47 net profit`

from:

`$1,000 initial capital`

with:

`9.97% maximum equity drawdown`

across:

`588 trades`

The strategy's main advantage is its asymmetric payoff structure.

Despite winning only:

`33.84%`

of trades, the average profitable trade was approximately:

`2.05×`

the average losing trade.

The primary weakness is the narrow profitability margin represented by:

`Profit Factor = 1.05`

combined with:

`19 consecutive losses`

and a significant late-period decline in the balance curve.

The current conclusion is therefore:

**EA-059 is a valid research candidate with a profitable initial benchmark, but further robustness testing is required before production use.**
