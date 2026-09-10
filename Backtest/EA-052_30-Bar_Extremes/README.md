# Backtest — EA-052 30-Bar Extremes

Backtest results for **EA-052_30-Bar_Extremes**, an MT5 Expert Advisor researching a breakout strategy based on 30-bar price extremes.

> Status: **FAILED — Baseline backtest is not profitable**

---

## Test Configuration

| Setting | Value |
|---|---|
| Expert Advisor | EA-052_30-Bar_Extremes |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.03.31 |
| Initial Deposit | $1,000.00 |
| Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 85,161 |
| Ticks | 39,639,179 |
| Symbols | 1 |

---

## EA Parameters

| Parameter | Value |
|---|---:|
| Lot Size | 0.01 |
| Stop Loss | 300 points |
| Take Profit | 600 points |
| Magic Number | 202501 |
| Slippage | 10 points |
| Maximum Spread | 30 points |
| Break Even | Enabled |
| Break Even Trigger | 150 points |
| Break Even Lock | 0 |
| Trailing Stop | Enabled |
| Trailing Start | 200 points |
| Trailing Step | 50 points |

---

## Backtest Results

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$369.82** |
| Gross Profit | $2,133.14 |
| Gross Loss | -$2,502.96 |
| Profit Factor | **0.85** |
| Expected Payoff | **-$0.24** |
| Recovery Factor | **-0.96** |
| Sharpe Ratio | **-5.00** |
| Balance Drawdown Maximal | $383.18 (37.81%) |
| Equity Drawdown Maximal | $385.15 (37.93%) |
| Total Trades | 1,511 |
| Total Deals | 3,022 |

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Winning Trades | 611 (40.44%) |
| Losing Trades | 900 (59.56%) |
| Short Trades | 767 |
| Short Win Rate | 40.42% |
| Long Trades | 744 |
| Long Win Rate | 40.46% |
| Largest Profit Trade | $36.33 |
| Largest Loss Trade | -$33.80 |
| Average Profit Trade | $3.49 |
| Average Loss Trade | -$2.78 |
| Maximum Consecutive Wins | 6 |
| Maximum Consecutive Losses | 13 |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 3 |

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum | 00:00:01 |
| Average | 00:04:26 |
| Maximum | 03:33:35 |

---

## MFE / MAE Correlation

| Metric | Result |
|---|---:|
| Correlation (Profits, MFE) | 0.90 |
| Correlation (Profits, MAE) | 0.66 |
| Correlation (MFE, MAE) | 0.4985 |

---

## Result Assessment

### FAIL

The baseline configuration does **not** demonstrate a profitable trading edge over the tested period.

Main evidence:

- Total Net Profit: **-$369.82**
- Profit Factor: **0.85**
- Expected Payoff: **-$0.24 per trade**
- Winning Trades: **40.44%**
- Losing Trades: **59.56%**
- Maximum Equity Drawdown: **37.93%**
- Sharpe Ratio: **-5.00**
- Recovery Factor: **-0.96**

The balance curve shows an overall declining trend during the test period.

Both trade directions produced similar win rates:

- Long: 40.46%
- Short: 40.42%

Therefore, the baseline result does not indicate that simply restricting the strategy to one trade direction would resolve the observed weakness.

---

## Research Conclusion

**EA-052_30-Bar_Extremes baseline: FAIL**

This backtest should be retained as a negative research result rather than discarded.

The test demonstrates that the current 30-Bar Extremes implementation and default parameter configuration did not produce a profitable result on:

`XAUUSD.PRO / M1 / 2026.01.02 – 2026.03.31`

No claim of profitability or robustness is made from this test.

Further optimization or strategy modification must be tested separately and must not overwrite this baseline result.

---

## Backtest Files

The original MetaTrader 5 Strategy Tester report and its generated charts should be preserved in this directory as research evidence.

Backtest/
└── EA-052_30-Bar_Extremes/
    ├── README.md
    ├── ReportTester-952747(20260910-063533).html
    ├── ReportTester-952747(20260910-063531).png
    ├── ReportTester-952747-hst(20260910-063532).png
    ├── ReportTester-952747-mfemae(20260910-063531).png
    └── ReportTester-952747-holding(20260910-063531).png

---

## Reproducibility

The original HTML Strategy Tester report is the primary evidence source for this backtest.

Future tests should be stored separately so that this baseline result remains reproducible and auditable.
