# EA-098 — Baseline Backtest

## Test Configuration

| Item             | Value                        |
| ---------------- | ---------------------------- |
| EA               | EA-098_Large_Candle_Reversal |
| Symbol           | XAUUSD.PRO                   |
| Timeframe        | M1                           |
| Test Period      | 2026-01-02 → 2026-03-31      |
| Initial Deposit  | $1,000                       |
| Leverage         | 1:500                        |
| History Quality  | 100% real ticks              |
| Lot              | 0.01                         |
| Stop Loss        | 300                          |
| Take Profit      | 600                          |
| ATR Period       | 14                           |
| Large Candle ATR | 2.0                          |
| Maximum Spread   | 30                           |
| Break Even       | ON                           |
| Trailing Stop    | ON                           |

## Baseline Result

| Metric               |       Result |
| -------------------- | -----------: |
| Total Trades         |          646 |
| Total Deals          |        1,292 |
| Net Profit           | **-$114.76** |
| Gross Profit         |      $714.06 |
| Gross Loss           |     -$828.82 |
| Profit Factor        |     **0.86** |
| Expected Payoff      |   **-$0.18** |
| Recovery Factor      |    **-0.87** |
| Sharpe Ratio         |    **-5.00** |
| Max Balance Drawdown |   **13.11%** |
| Max Equity Drawdown  |   **13.22%** |
| Profit Trades        | 326 / 50.46% |
| Loss Trades          | 320 / 49.54% |
| Average Profit Trade |        $2.19 |
| Average Loss Trade   |       -$2.59 |
| Largest Profit Trade |        $6.58 |
| Largest Loss Trade   |      -$33.30 |
| Average Holding Time |     00:02:28 |

## Directional Result

* BUY: 411 trades / **48.66%** won
* SELL: 235 trades / **53.62%** won

The baseline does not show a clear directional edge sufficient to overcome the negative expectancy.

## Baseline Assessment

**Classification:** `FAIL`

The baseline generated a negative Net Profit and Expected Payoff, with Profit Factor below 1.00 and negative Sharpe Ratio.

The result is retained as the reference baseline for future controlled research.

**Validation Status:** `NOT VALIDATED FOR LIVE TRADING`

**Optimization Status:** `BLOCKED`
