# EA-039 — Trend Score | Backtest Report

## Backtest Status

**Result: FAIL**

The current version of EA-039 Trend Score does not demonstrate acceptable profitability or risk characteristics under this backtest configuration.

The strategy generated a negative net result, Profit Factor below 1.0, and approximately 99% maximal drawdown.

This test is retained as research evidence and as a baseline for future strategy improvements.

---

## Test Environment

| Parameter | Value |
|---|---|
| Expert Advisor | EA-039_Trend_Score |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000.00 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Symbols | 1 |
| Platform | MetaTrader 5 |
| Broker / Server | ACCMIntl-Real |
| MT5 Build | 6140 |

---

## EA Parameters

### Trading Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Maximum Open Positions | 1 |
| Magic Number | 123456 |
| Score Threshold | 70 |

### Break Even

| Parameter | Value |
|---|---:|
| Enabled | true |
| Trigger | 150 points |

### Trailing Stop

| Parameter | Value |
|---|---:|
| Enabled | true |
| Start | 200 points |
| Step | 50 points |

### Indicator Parameters

| Indicator | Parameter | Value |
|---|---|---:|
| EMA | Fast Period | 20 |
| EMA | Slow Period | 50 |
| MACD | Fast Period | 12 |
| MACD | Slow Period | 26 |
| MACD | Signal Period | 9 |
| ADX | Period | 14 |
| ADX | Threshold | 25.0 |

---

## Performance Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$993.61** |
| Gross Profit | $8,253.13 |
| Gross Loss | -$9,246.74 |
| Profit Factor | **0.89** |
| Expected Payoff | **-$0.24** |
| Recovery Factor | **-0.97** |
| Sharpe Ratio | **-5.00** |
| AHPR | 0.9991 (-0.09%) |
| GHPR | 0.9988 (-0.12%) |
| LR Correlation | -0.91 |
| LR Standard Error | 93.70 |

---

## Drawdown

| Metric | Balance | Equity |
|---|---:|---:|
| Absolute Drawdown | $993.61 | $993.61 |
| Maximal Drawdown | $1,022.88 | $1,027.58 |
| Relative Drawdown | **99.38%** | **99.38%** |

The drawdown is the primary reason this version fails the backtest evaluation.

A drawdown of approximately 99% means the strategy effectively exhausted almost the entire initial account balance during the tested period.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | 4,217 |
| Total Deals | 8,434 |
| Winning Trades | 1,320 |
| Losing Trades | 2,897 |
| Win Rate | **31.30%** |
| Loss Rate | **68.70%** |

### Directional Performance

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | 2,163 | 31.30% |
| Long | 2,054 | 31.30% |

The almost identical win rate between long and short positions indicates that poor performance is not isolated to only one trading direction.

---

## Winning vs Losing Trades

| Metric | Result |
|---|---:|
| Largest Profit Trade | $33.16 |
| Largest Loss Trade | -$43.09 |
| Average Profit Trade | $6.25 |
| Average Loss Trade | -$3.19 |
| Maximum Consecutive Wins | 8 |
| Maximum Consecutive Losses | 17 |
| Maximum Consecutive Profit | $49.57 (8 trades) |
| Maximum Consecutive Loss | -$59.18 (6 trades) |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

Although the average winning trade is larger than the average losing trade, the strategy loses significantly more frequently than it wins.

The 31.30% win rate is insufficient to produce positive expectancy under the tested execution logic.

---

## Position Holding Time

| Metric | Result |
|---|---|
| Minimum Holding Time | 00:00:05 |
| Maximum Holding Time | 03:38:01 |
| Average Holding Time | **00:04:06** |

The strategy operates as a high-frequency intraday system on the M1 timeframe, with most positions being held for relatively short periods.

---

## MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profit, MFE) | 0.84 |
| Correlation (Profit, MAE) | 0.71 |
| Correlation (MFE, MAE) | 0.5056 |

The strong positive relationship between profit and Maximum Favorable Excursion (MFE) indicates that trades with larger favorable movement generally produced higher realized profits.

These statistics may be useful in later research into exit logic, trailing stop behavior, and trade management.

---

## Equity Curve

The balance curve shows a clear long-term downward trajectory.

There are several temporary recovery periods, but none develop into sustained account growth.

The test begins with approximately:

$1,000

and ultimately loses almost the entire initial account.

This is consistent with:

Net Profit: -$993.61  
Profit Factor: 0.89  
Max Drawdown: 99.38%

The negative LR Correlation of -0.91 also reflects the strongly declining balance trend.

---

## Key Findings

### 1. Strategy is not profitable in the current configuration

**Profit Factor = 0.89**

A Profit Factor below 1.0 means total losses exceeded total profits.

### 2. Drawdown is unacceptable

**Maximal Drawdown = 99.38%**

The strategy effectively consumed nearly all available account equity.

This alone is sufficient to reject the current configuration for live deployment.

### 3. Trade frequency is very high

The EA generated **4,217 trades** during approximately three months of M1 testing.

Average position duration was only **4 minutes 6 seconds**.

The current scoring system therefore permits frequent entries despite being designed as a multi-factor trend confirmation system.

### 4. Win rate is insufficient

Winning Trades = **31.30%**  
Losing Trades = **68.70%**

Both BUY and SELL sides produced the same reported 31.30% win rate.

The issue therefore does not appear to be limited to one directional side of the strategy.

### 5. Average winner is larger than average loser

Average Profit = **$6.25**  
Average Loss = **-$3.19**

The average winning trade is approximately 1.96 times the magnitude of the average losing trade.

However, this advantage is not enough to compensate for the high frequency of losing trades.

---

## Backtest Assessment

### Profitability

**FAIL**

Reason:

Total Net Profit = -$993.61  
Profit Factor = 0.89  
Expected Payoff = -$0.24

### Risk

**FAIL**

Reason:

Balance Drawdown = 99.38%  
Equity Drawdown = 99.38%

### Robustness

**NOT YET EVALUATED**

This test represents one configuration on:

XAUUSD.PRO / M1  
2026.01.02 – 2026.04.01

No robustness claim should be made from this test alone.

### Live Trading Readiness

**FAIL**

The current version should not be considered suitable for live deployment based on this backtest.

---

## Final Result

| Metric | Result |
|---|---:|
| EA | EA-039_Trend_Score |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Initial Capital | $1,000 |
| Trades | 4,217 |
| Net Profit | **-$993.61** |
| Profit Factor | **0.89** |
| Win Rate | **31.30%** |
| Max Drawdown | **99.38%** |
| Sharpe Ratio | **-5.00** |
| Status | **FAIL** |

---

## Research Conclusion

EA-039 successfully implements and executes the Trend Score concept across a large number of real-tick simulated trades.

However, the current implementation does not demonstrate a viable trading edge under this test configuration.

The main observed problems are:

- Persistent negative balance trajectory
- Profit Factor below 1.0
- Very high trade frequency
- 68.70% losing trades
- Negative expected payoff
- Approximately 99% drawdown
- Almost complete loss of the initial test capital

The current EA should therefore be retained as a **failed research experiment / baseline implementation**, rather than presented as a profitable trading strategy.

Further changes, if researched, should be treated as a new experimental iteration and validated with a new backtest rather than altering the interpretation of this result.

---

## Backtest Files

Recommended folder structure:

    Backtest/
    └── EA-039_Trend_Score/
        ├── README.md
        ├── ReportTester-952747.html
        ├── ReportTester-952747.png
        ├── ReportTester-952747-holding.png
        ├── ReportTester-952747-hst.png
        └── ReportTester-952747-mfemae.png

The original MT5 Strategy Tester report and generated charts should be retained as evidence so the reported metrics can be independently reviewed.

---

## Disclaimer

This backtest is a historical simulation and does not guarantee future trading performance.

The result applies only to the tested EA version, parameters, symbol, timeframe, broker data, and testing period documented above.

This repository is intended for quantitative strategy research and development, not as financial advice.
