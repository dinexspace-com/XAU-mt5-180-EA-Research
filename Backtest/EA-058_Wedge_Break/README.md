# EA-058_Wedge_Break — Backtest

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-058_Wedge_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Lot Size | 0.01 |

## EA Parameters

| Parameter | Value |
|---|---:|
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Max Spread | 30 points |
| Max Positions | 1 |
| Wedge Lookback | 30 |
| Pivot Strength | 2 |
| Minimum Pivot Distance | 3 |
| Breakout Buffer | 5 |
| Minimum Contraction Ratio | 0.10 |
| Maximum Contraction Ratio | 0.80 |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Offset | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Distance | 150 points |
| Trailing Step | 10 points |

## Backtest Results

| Metric | Result |
|---|---:|
| Total Net Profit | **-$267.40** |
| Gross Profit | $890.23 |
| Gross Loss | -$1,157.63 |
| Profit Factor | **0.77** |
| Expected Payoff | -$0.31 |
| Recovery Factor | -0.99 |
| Sharpe Ratio | -5.00 |
| Balance Drawdown Maximal | $268.89 (26.85%) |
| Equity Drawdown Maximal | $270.56 (26.97%) |
| Total Trades | 856 |
| Total Deals | 1,712 |
| Winning Trades | 410 (47.90%) |
| Losing Trades | 446 (52.10%) |

## Long / Short Performance

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | 433 | 48.50% |
| Long | 423 | 47.28% |

## Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $21.55 |
| Largest Loss Trade | -$4.42 |
| Average Profit Trade | $2.17 |
| Average Loss Trade | -$2.60 |
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Losses | 13 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

## Holding Time

| Metric | Result |
|---|---|
| Minimum | 00:00:01 |
| Maximum | 02:19:00 |
| Average | 00:02:58 |

The average holding time of approximately 3 minutes confirms that this implementation behaves as a short-duration intraday breakout strategy on the M1 timeframe.

## Result Assessment

**Status: FAILED**

The tested configuration is not profitable.

Key reasons:

- Net Profit is negative at **-$267.40**.
- Profit Factor is **0.77**, below the break-even level of 1.00.
- Expected Payoff is negative at **-$0.31 per trade**.
- Maximum equity drawdown reaches **26.97%**.
- Losing trades (52.10%) exceed winning trades (47.90%).
- Average winning trade ($2.17) is smaller than average losing trade (-$2.60).
- The balance curve shows a persistent downward trend over the test period.

The test nevertheless produced **856 trades using 100% real tick history**, providing a meaningful sample for evaluating the current rule set.

## Conclusion

The current `EA-058_Wedge_Break` configuration does **not demonstrate a profitable trading edge** on XAUUSD.PRO M1 for the tested period from January 2, 2026 to April 1, 2026.

This result should be preserved as a negative research result rather than discarded.

Possible future research should focus on determining whether additional breakout confirmation, trend filtering, volatility filtering, trading-session filtering, or alternative exit management can improve the strategy.

No profitability claim should be made from this version.

## Evidence

The original MetaTrader 5 Strategy Tester report and its generated charts should be stored in this directory together with this README.

Recommended structure:

Backtest/
└── EA-058_Wedge_Break/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png

## Research Status

**EA ID:** EA-058  
**Strategy:** Wedge Breakout  
**Instrument:** XAUUSD.PRO  
**Timeframe:** M1  
**Test Quality:** 100% Real Ticks  
**Backtest Status:** FAILED  
**Reason:** Negative net profit and Profit Factor below 1.0
