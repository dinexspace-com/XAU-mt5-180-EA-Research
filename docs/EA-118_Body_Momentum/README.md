## EA-118 Body Momentum — Baseline Evaluation

### Strategy Description

EA-118 Body Momentum evaluates the most recently closed candle against the average candle body over a configurable lookback period.

A bullish candle may trigger a BUY when its body is sufficiently large and its close is near the candle high. A bearish candle may trigger a SELL when its body is sufficiently large and its close is near the candle low.

The baseline uses these parameters:

- Average body period: 20 candles
- Body multiplier: 1.50
- Extreme close ratio: 0.75
- Stop Loss: 300 points
- Take Profit: 600 points
- Break-even trigger: 150 points
- Trailing-stop trigger: 200 points
- Trailing distance: 200 points
- Maximum spread: 30 points
- Lot size: 0.01

### Baseline Environment

- Symbol: XAUUSD.PRO
- Timeframe: M1
- Test period: 2026-01-02 to 2026-04-01
- Initial deposit: $1,000
- Modeling: 100% real ticks
- Bars: 86,539
- Ticks: 40,346,891

### Recorded Results

| Metric | Result |
|---|---:|
| Net Profit | -$992.26 |
| Profit Factor | 0.74 |
| Expected Payoff | -$0.34 |
| Sharpe Ratio | -5.00 |
| Relative Equity Drawdown | 99.24% |
| Total Trades | 2,911 |
| Winning Trades | 45.89% |

### Evaluation Policy

EA-118 is classified as **FAIL — Baseline** because it lost nearly the entire initial deposit during the recorded test and exhibited extreme drawdown.

The baseline must remain available as a reproducible reference. Any modified version should have a separate source file, version identifier, parameter record, and backtest report.

### Research and Validation Requirements

1. Reproduce the baseline before changing its logic.
2. Test parameter changes under controlled conditions.
3. Preserve the same test environment when comparing individual changes.
4. Account for spread, slippage, and other applicable transaction costs.
5. Evaluate drawdown and risk-adjusted performance in addition to net profit.
6. Use separate out-of-sample data to assess generalization.
7. Require forward testing before any consideration of live deployment.

Parameter optimization, out-of-sample validation, and forward testing have not been established by the supplied baseline report.

### Status

**Not approved for live trading.**

Any future approval must be based on new, documented test evidence rather than assumptions about the strategy.
