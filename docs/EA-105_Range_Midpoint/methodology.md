## EA-105 — Range Midpoint

### Strategy and Baseline

* **Baseline ID:** `EA105-M1-BASELINE-001`
* **Symbol:** XAUUSD.PRO
* **Timeframe:** M1
* **Test Period:** 2026-01-02 to 2026-04-01
* **Initial Deposit:** $1,000
* **Modeling:** 100% real ticks

The strategy calculates the highest high and lowest low over `InpRangeBars` historical candles, starting at shift 2. It evaluates the completed candle at shift 1 for rejection near either range boundary.

BUY requires a low near the lower range boundary, a lower-wick-to-range ratio at or above `InpRejectionWickRatio`, and a bullish close.

SELL requires a high near the upper range boundary, an upper-wick-to-range ratio at or above `InpRejectionWickRatio`, and a bearish close.

### Baseline Configuration

* Lot Size: 0.01
* Stop Loss: 300 points
* Take Profit: 600 points
* Range Bars: 20
* Rejection Wick Ratio: 0.5
* Maximum Spread: 30 points
* Break-even: enabled, trigger 150 points, offset 0
* Trailing Stop: enabled, start 200 points, distance 200 points

### Baseline Results

* Net Profit: -$400.13
* Profit Factor: 0.87
* Expected Payoff: -$0.15
* Recovery Factor: -0.89
* Sharpe Ratio: -5.00
* Maximum Equity Drawdown: 44.56%
* Total Trades: 2,589
* Winning Trades: 46.97%

### Assessment

**Classification: FAIL**

The baseline is not profitable under the tested conditions. Both directional win rates were below 50%, and the drawdown was high relative to the initial deposit.

The results justify controlled investigation, not immediate broad optimization or live deployment.

### Research and Validation Policy

1. Preserve the original baseline and its report.
2. Evaluate range length and rejection-wick ratio independently.
3. Investigate boundary-zone width and directional performance through documented experiments.
4. Test entry confirmation and exit management only with controlled comparisons.
5. Require out-of-sample, robustness and walk-forward validation before considering forward testing.
6. Do not approve live trading based on this baseline.

### Current Status

* Strategy Code: COMPLETE
* Baseline: COMPLETE
* Baseline Result: FAIL
* Controlled Research: PENDING
* Out-of-Sample Validation: NOT STARTED
* Walk-Forward Validation: NOT STARTED
* Forward Test: NOT STARTED
* Live Trading: NOT APPROVED
