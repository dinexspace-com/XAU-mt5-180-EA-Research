# EA-048 — 10-Bar Donchian Breakout | Backtest

## Backtest Overview

This directory contains the MetaTrader 5 Strategy Tester results for:

**EA-048 — 10-Bar Donchian Breakout**

The test was performed on XAUUSD using 100% real tick history.

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-048_10-Bar_Donchian |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Lot Size | 0.01 |
| Donchian Period | 10 |
| Maximum Spread | 35 points |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | -$30.84 |
| Gross Profit | $1,261.46 |
| Gross Loss | -$1,292.30 |
| Profit Factor | 0.98 |
| Expected Payoff | -$0.04 |
| Recovery Factor | -0.23 |
| Sharpe Ratio | -2.62 |
| Balance Drawdown Maximal | $128.75 (12.65%) |
| Equity Drawdown Maximal | $132.16 (12.95%) |
| Total Trades | 748 |
| Total Deals | 1,496 |
| Winning Trades | 303 (40.51%) |
| Losing Trades | 445 (59.49%) |
| Short Trades | 340 (37.35% won) |
| Long Trades | 408 (43.14% won) |
| Largest Profit Trade | $47.71 |
| Largest Loss Trade | -$8.69 |
| Average Profit Trade | $4.16 |
| Average Loss Trade | -$2.90 |
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Losses | 10 |

## Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:08:01 |
| Average Holding Time | 00:04:20 |

## Result Assessment

This baseline configuration was **not profitable** over the tested period.

Key observations:

- Net result: **-$30.84**
- Profit Factor: **0.98**
- Win rate: **40.51%**
- Maximum equity drawdown: **12.95%**
- 748 trades provide a meaningful initial sample for evaluating the baseline implementation.

The result should therefore be treated as a **baseline research backtest**, not as evidence of a production-ready or profitable trading system.

The strategy requires further research, validation, and parameter/logic testing before any consideration for live deployment.

## Backtest Artifacts

This directory contains the original MetaTrader 5 Strategy Tester report and its associated charts.

The charts include:

- Balance curve
- Entry distribution by hour, weekday, and month
- Profit/loss distribution
- MFE/MAE analysis
- Position holding-time analysis

## Reproducibility

Source code:

`../../EAs/EA-048_10_Bar_Donchian/EA-048_10_Bar_Donchian.mq5`

Backtest environment:

- Platform: MetaTrader 5
- Broker/Server: ACCMIntl-Real
- Build: 6182
- Symbol: XAUUSD.PRO
- Timeframe: M1
- Historical data quality: 100% real ticks

## Status

**Baseline Backtest: COMPLETED**

**Result: NOT PROFITABLE**

This result is retained intentionally as part of the research record. Negative backtest results are not removed or hidden, allowing future strategy revisions to be compared against the original baseline.

## Disclaimer

This repository is intended for quantitative trading research and educational purposes.

Backtest results do not guarantee future performance. Trading XAUUSD and other leveraged financial instruments involves substantial risk.
