# EA-057 — Flag Break | Backtest

Backtest evidence for **EA-057_Flag_Break**, an MT5 Expert Advisor based on an Impulse → Flag → Breakout strategy.

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-057_Flag_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Leverage | 1:500 |
| Lot Size | 0.01 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

The test was performed using MT5 Strategy Tester with 100% real-tick history quality.

## Tested Parameters

### General

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 123456 |
| Slippage | 10 points |
| Maximum Spread | 30 points |

### Break Even

| Parameter | Value |
|---|---:|
| Enabled | Yes |
| Trigger | 150 points |
| Lock | 10 points |

### Trailing Stop

| Parameter | Value |
|---|---:|
| Enabled | Yes |
| Start | 200 points |
| Distance | 150 points |
| Step | 20 points |

### Flag Break Strategy

| Parameter | Value |
|---|---:|
| Average Range Period | 20 |
| Impulse Multiplier | 1.2 |
| Minimum Body Ratio | 0.5 |
| Flag Bars | 2 |
| Maximum Flag / Impulse | 0.75 |
| Maximum Retracement | 0.75 |
| Breakout Buffer | 0 |

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$161.17** |
| Gross Profit | $930.38 |
| Gross Loss | -$1,091.55 |
| Profit Factor | **0.85** |
| Expected Payoff | -$0.18 |
| Recovery Factor | -0.83 |
| Sharpe Ratio | -5.00 |
| Total Trades | **902** |
| Total Deals | 1,804 |
| Winning Trades | 509 (56.43%) |
| Losing Trades | 393 (43.57%) |
| Maximum Balance Drawdown | $193.13 (19.08%) |
| Maximum Equity Drawdown | $194.89 (19.23%) |

## Long / Short Results

| Direction | Trades | Win Rate |
|---|---:|---:|
| Long | 542 | 57.01% |
| Short | 360 | 55.56% |

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $7.62 |
| Largest Loss Trade | -$5.36 |
| Average Profit Trade | $1.83 |
| Average Loss Trade | -$2.78 |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 9 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

## Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:14:10 |
| Average Holding Time | **00:02:45** |

The short average holding time is consistent with this test being performed on the M1 timeframe.

## MFE / MAE Correlation

| Metric | Result |
|---|---:|
| Profit vs MFE | 0.97 |
| Profit vs MAE | 0.72 |
| MFE vs MAE | 0.6360 |

## Result Assessment

**Status: FAILED BASELINE**

This tested configuration is **not profitable** over the tested period.

Despite achieving a win rate of **56.43%**, the average losing trade (-$2.78) is substantially larger than the average winning trade ($1.83).

The resulting expectancy is negative:

- Net Profit: -$161.17
- Profit Factor: 0.85
- Expected Payoff: -$0.18
- Maximum Equity Drawdown: 19.23%
- Sharpe Ratio: -5.00

The balance curve shows a persistent downward tendency during the tested period.

This backtest should therefore be treated as a **baseline research result**, not as evidence of a production-ready or profitable trading system.

The negative result is intentionally retained because failed tests are useful research evidence and provide a reproducible baseline for future improvements.

## Important Observation

The tested parameters differ from some of the EA source-code default values.

This report specifically tested:

- Impulse Multiplier: 1.2
- Minimum Body Ratio: 0.5
- Flag Bars: 2
- Maximum Flag / Impulse: 0.75
- Maximum Retracement: 0.75
- Breakout Buffer: 0

Backtest conclusions apply only to this tested configuration and test environment.

## Evidence Files

The original MT5 Strategy Tester report and its associated chart files are stored together in this directory.

    Backtest/
    └── EA-057_Flag_Break/
        ├── README.md
        ├── ReportTester-952747(20260913-045805).html
        ├── ReportTester-952747(20260913-045805).png
        ├── ReportTester-952747-hst(20260913-045805).png
        ├── ReportTester-952747-mfemae(20260913-045806).png
        └── ReportTester-952747-holding(20260913-045806).png

Do not separate the HTML report from its associated image files because the MT5 report references these charts.

## Reproducibility

This directory preserves the original Strategy Tester output so that the reported results can be independently inspected.

Test environment:

- Expert Advisor: EA-057_Flag_Break
- Symbol: XAUUSD.PRO
- Timeframe: M1
- Period: 2026-01-02 → 2026-04-01
- Initial Deposit: $1,000
- Leverage: 1:500
- Lot Size: 0.01
- History Quality: 100% real ticks

## Disclaimer

Backtest results are historical simulations and do not guarantee future performance.

This test produced a negative result and should not be interpreted as evidence that EA-057_Flag_Break is suitable for live trading.
