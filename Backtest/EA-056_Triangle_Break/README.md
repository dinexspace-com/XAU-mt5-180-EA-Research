# EA-056 — Triangle Break | Backtest

## Backtest Status

**Result: FAIL**

Baseline backtest cho thấy phiên bản hiện tại của `EA-056_Triangle_Break`
chưa tạo được lợi thế giao dịch dương trên tập dữ liệu kiểm thử.

EA vẫn được giữ lại trong repository nhằm lưu lại kết quả nghiên cứu,
code và bằng chứng backtest để phục vụ việc đánh giá hoặc phát triển
các phiên bản tiếp theo.

---

## Test Environment

| Item | Value |
|---|---|
| Expert Advisor | EA-056_Triangle_Break |
| Platform | MetaTrader 5 |
| Broker / Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026-01-02 → 2026-04-01 |
| Initial Deposit | $1,000 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Symbols | 1 |

---

## Parameters

### General Trading Settings

| Parameter | Value |
|---|---:|
| InpLotSize | 0.01 |
| InpStopLoss | 300 |
| InpTakeProfit | 600 |
| InpMagicNumber | 123456 |
| InpSlippage | 10 |
| InpMaxSpread | 30 |
| InpMaxPositions | 1 |

### Convergence Zone Settings

| Parameter | Value |
|---|---:|
| InpZoneBars | 10 |
| InpCompareBars | 10 |
| InpConvergenceRatio | 0.7 |
| InpMinZonePoints | 30 |
| InpMaxZonePoints | 500 |
| InpBreakoutBuffer | 5 |
| InpUseNewBarOnly | true |

### Break Even

| Parameter | Value |
|---|---:|
| InpUseBreakEven | true |
| InpBreakEvenTrigger | 150 |
| InpBreakEvenOffset | 5 |

### Trailing Stop

| Parameter | Value |
|---|---:|
| InpUseTrailingStop | true |
| InpTrailingStart | 200 |
| InpTrailingDistance | 150 |
| InpTrailingStep | 20 |

---

# Main Results

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$263.23** |
| Gross Profit | $928.47 |
| Gross Loss | -$1,191.70 |
| Profit Factor | **0.78** |
| Expected Payoff | **-$0.28** |
| Recovery Factor | **-0.93** |
| Sharpe Ratio | **-5.00** |
| Total Trades | 932 |
| Total Deals | 1,864 |
| Profit Trades | 494 (53.00%) |
| Loss Trades | 438 (47.00%) |

---

# Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $263.74 |
| Balance Drawdown Maximal | $281.30 (27.64%) |
| Balance Drawdown Relative | 27.64% |
| Equity Drawdown Absolute | $263.97 |
| Equity Drawdown Maximal | $283.10 (27.78%) |
| Equity Drawdown Relative | **27.78%** |

The backtest finished with approximately:

**$736.77**

from the original $1,000 balance.

---

# Long / Short Performance

| Direction | Trades | Win Rate |
|---|---:|---:|
| Short | 465 | 54.41% |
| Long | 467 | 51.61% |

Short trades performed slightly better than long trades by win rate,
but neither side was sufficient to make the complete strategy profitable.

---

# Trade Statistics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $34.29 |
| Largest Loss Trade | -$27.58 |
| Average Profit Trade | $1.88 |
| Average Loss Trade | -$2.72 |
| Maximum Consecutive Wins | 9 ($21.55) |
| Maximum Consecutive Losses | 9 (-$27.27) |
| Maximal Consecutive Profit | $36.81 (3 trades) |
| Maximal Consecutive Loss | -$33.59 (3 trades) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 2 |

---

# Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:08:01 |
| Average Holding Time | 00:05:48 |

The strategy therefore behaves as a short-duration intraday system on
the tested M1 configuration.

---

# MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profits, MFE) | 0.92 |
| Correlation (Profits, MAE) | 0.58 |
| Correlation (MFE, MAE) | 0.3262 |

---

# Balance Curve

The balance curve shows a persistent negative trend over the test period.

Although there are temporary recoveries, the strategy fails to establish
a sustained positive equity/balance trajectory.

The account starts at:

`$1,000`

and finishes at approximately:

`$736.77`

corresponding to:

`-$263.23 Total Net Profit`.

---

# Key Finding

The most important result is:

**Win Rate = 53.00%**

but:

**Profit Factor = 0.78**

and:

**Expected Payoff = -$0.28/trade**

The strategy therefore wins slightly more trades than it loses, but the
average losing trade is larger than the average winning trade:

- Average winner: `$1.88`
- Average loser: `-$2.72`

This causes the positive win rate to remain insufficient for profitability.

---

# Baseline Assessment

This baseline configuration does **not** demonstrate a profitable trading
edge on XAUUSD.PRO M1 during the tested period.

Reasons for FAIL:

1. Total Net Profit is negative.
2. Profit Factor is below 1.0.
3. Expected Payoff is negative.
4. Recovery Factor is negative.
5. Sharpe Ratio is negative.
6. Maximum Equity Drawdown reaches 27.78%.
7. Balance curve exhibits a persistent downward trend.
8. Average loss is materially larger than average profit.

---

# Result

## ❌ FAIL

The current version of `EA-056_Triangle_Break` should **not be considered
validated for live trading** based on this backtest.

This result represents the tested baseline configuration and should not
be interpreted as evidence that every possible Triangle Breakout strategy
or future modification will produce the same result.

---

# Evidence Files

The original MT5 Strategy Tester artifacts should be retained in this
directory together with this README.

Recommended structure:

Backtest/
└── EA-056_Triangle_Break/
    ├── README.md
    ├── ReportTester-952747.html
    ├── ReportTester-952747.png
    ├── ReportTester-952747-hst.png
    ├── ReportTester-952747-mfemae.png
    └── ReportTester-952747-holding.png

The HTML report is the primary source of truth for the numerical
backtest results. The PNG files provide the associated visual evidence.

---

# Reproducibility

To reproduce this baseline test:

1. Open MetaTrader 5 Strategy Tester.
2. Select `EA-056_Triangle_Break`.
3. Select `XAUUSD.PRO`.
4. Set timeframe to `M1`.
5. Use the period `2026-01-02` through `2026-04-01`.
6. Use an initial deposit of `$1,000`.
7. Set leverage to `1:500`.
8. Use the parameter values documented above.
9. Run using real tick history.
10. Compare the resulting statistics with this report.

---

# Conclusion

**EA-056_Triangle_Break — Baseline: FAIL**

The experiment produced a valid backtest with 100% real-tick history and
932 trades, but the tested configuration lost `$263.23`, produced a
Profit Factor of `0.78`, and reached `27.78%` maximum equity drawdown.

The result should therefore be preserved as a **negative research result**
rather than promoted as a successful trading strategy.
