# EA-040 — Two-Candle Continuation Backtest

## Backtest Overview

This folder contains the MetaTrader 5 baseline backtest results for **EA-040_Two-Candle_Continuation**.

The test was performed on XAUUSD using real-tick historical data.

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-040_Two-Candle_Continuation |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |

The Strategy Tester report confirms the EA, symbol, timeframe, test period, initial deposit, leverage, and 100% real-tick history quality.

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 |
| Take Profit | 600 |
| Magic Number | 123456 |
| Slippage | 10 |
| Maximum Spread | 30 |
| Break Even | Enabled |
| Break Even Start | 150 |
| Break Even Shift | 10 |
| Trailing Stop | Enabled |
| Trailing Start | 200 |
| Trailing Step | 50 |
| Fast MA | 20 |
| Slow MA | 50 |

## Performance Summary

| Metric | Result |
|---|---:|
| Total Net Profit | **-$993.54** |
| Gross Profit | $7,245.01 |
| Gross Loss | -$8,238.55 |
| Profit Factor | **0.88** |
| Expected Payoff | **-$0.21** |
| Recovery Factor | **-0.97** |
| Sharpe Ratio | **-5.00** |
| Max Balance Drawdown | **$1,023.27 (99.37%)** |
| Max Equity Drawdown | **$1,023.27 (99.37%)** |

The strategy generated a net loss of $993.54 from the $1,000 starting balance, with maximal balance and equity drawdown reaching 99.37%.

Profit Factor was 0.88 and Expected Payoff was -$0.21 per trade. Recovery Factor and Sharpe Ratio were also negative.

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 4,630 |
| Total Deals | 9,260 |
| Winning Trades | 1,980 (42.76%) |
| Losing Trades | 2,650 (57.24%) |
| Short Trades | 2,212 |
| Short Win Rate | 41.00% |
| Long Trades | 2,418 |
| Long Win Rate | 44.38% |
| Largest Winning Trade | $32.66 |
| Largest Losing Trade | -$26.02 |
| Average Winning Trade | $3.66 |
| Average Losing Trade | -$3.11 |
| Maximum Consecutive Wins | 9 |
| Maximum Consecutive Losses | 14 |

The backtest generated 4,630 trades. 42.76% were profitable while 57.24% were losing trades.

Average profit per winning trade was $3.66 compared with an average loss of $3.11. The longest losing sequence reached 14 trades.

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum | 00:00:01 |
| Average | 00:03:05 |
| Maximum | 03:38:01 |

The strategy operated primarily as a short-duration M1 trading system during this test.

## Backtest Result

### FAIL

The current EA configuration does **not pass baseline profitability validation**.

Primary reasons:

- Total Net Profit: **-$993.54**
- Profit Factor: **0.88**
- Winning Trades: **42.76%**
- Losing Trades: **57.24%**
- Maximum Drawdown: **99.37%**
- Expected Payoff: **negative**
- Sharpe Ratio: **negative**

The balance curve shows a substantial long-term decline and the account finishes close to depletion.

This configuration should therefore **not be treated as a validated trading configuration**.

## Research Interpretation

This result is still useful as the baseline benchmark for EA-040.

The EA successfully produced a large sample of **4,630 trades** using **100% real ticks**.

The baseline result indicates that the current combination of:

- Two-candle continuation signal
- SMA 20 / SMA 50 trend filter
- SL 300
- TP 600
- Break Even
- Trailing Stop

does not produce acceptable results under this specific XAUUSD.PRO M1 test configuration.

The next research stage should investigate which components are responsible for the negative expectancy before parameter optimization is attempted.

## Current Status

```text
EA implementation        COMPLETE
        ↓
Baseline backtest        COMPLETE
        ↓
Baseline result          FAIL
        ↓
Strategy research        NEXT
```

**Baseline FAIL does not mean the research project failed.**

It establishes the reference result against which future EA versions can be compared.

## Files

```text
Backtest/
└── EA-040_Two-Candle_Continuation/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png
```

The HTML Strategy Tester Report should be retained as the primary evidence for this baseline backtest.

## Conclusion

**EA-040 Two-Candle Continuation — Baseline: FAIL**

The baseline strategy is not profitable under the tested XAUUSD.PRO M1 configuration.

This backtest should be preserved as the baseline benchmark for subsequent research and EA revisions.
