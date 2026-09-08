# EA-047 — 5 Bar Range Break — Backtest

## Backtest Overview

This directory contains the MetaTrader 5 Strategy Tester results for:

**EA-047 — 5 Bar Range Break**

The purpose of this backtest is to establish a reproducible baseline for the original EA implementation before any optimization or strategy modification.

This result represents the tested configuration only and must not be interpreted as evidence of future profitability.

---

## Test Environment

| Setting | Value |
|---|---|
| Expert Advisor | EA-047_5-Bar_Range_Break |
| Symbol | XAUUSD.PRO |
| Timeframe | M5 |
| Test Period | 2026.01.02 — 2026.04.01 |
| Broker / Server | ACCMIntl-Real |
| MT5 Build | 6182 |
| Company | ACCM Intl Limited |
| Deposit Currency | USD |
| Initial Deposit | $1,000.00 |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 17,327 |
| Ticks | 40,346,891 |
| Symbols | 1 |

---

## EA Parameters Used

### General Settings

| Parameter | Value |
|---|---:|
| InpLotSize | 0.01 |
| InpMagicNumber | 123456 |
| InpSlippage | 10 |

### Trade Management

| Parameter | Value |
|---|---:|
| InpStopLoss | 300 |
| InpTakeProfit | 600 |

The tested configuration therefore used a nominal Stop Loss / Take Profit distance relationship of:

**300 / 600 = 1:2**

### Break Even

| Parameter | Value |
|---|---:|
| InpUseBreakEven | false |
| InpBreakEvenTrigger | 150 |
| InpBreakEvenLock | 0 |

Break Even was **disabled** during this backtest.

### Trailing Stop

| Parameter | Value |
|---|---:|
| InpUseTrailing | false |
| InpTrailingStart | 200 |
| InpTrailingStep | 50 |

Trailing Stop was **disabled** during this backtest.

### Strategy / Filter Settings

| Parameter | Value |
|---|---:|
| InpMaxSpread | 35 |
| InpBarsCount | 5 |

The breakout range therefore used the previous **5 completed bars**.

---

## Main Backtest Results

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$89.70** |
| Gross Profit | $840.59 |
| Gross Loss | -$930.29 |
| Profit Factor | **0.90** |
| Expected Payoff | -$0.21 |
| Recovery Factor | -0.65 |
| Sharpe Ratio | -5.00 |
| AHPR | 0.9998 (-0.02%) |
| GHPR | 0.9998 (-0.02%) |
| LR Correlation | -0.73 |
| LR Standard Error | 21.22 |
| Z-Score | -2.26 (97.56%) |
| Margin Level | 8936.89% |

The backtest finished with a loss of **$89.70**, reducing the $1,000 initial balance to approximately **$910.30**.

Profit Factor was **0.90**, meaning gross profit was insufficient to compensate for gross losses during the tested period.

Expected Payoff was negative at **-$0.21 per trade**.

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $89.70 |
| Balance Drawdown Maximal | $136.25 (13.02%) |
| Balance Drawdown Relative | 13.02% ($136.25) |
| Equity Drawdown Absolute | $89.70 |
| Equity Drawdown Maximal | $138.17 (13.18%) |
| Equity Drawdown Relative | 13.18% ($138.17) |

Maximum equity drawdown reached **13.18%**.

The balance curve shows that the strategy experienced several recovery phases during the early and middle portions of the test, but the latter part developed into a sustained decline.

The final balance ended close to the lowest region of the entire test.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | **424** |
| Total Deals | 848 |
| Profit Trades | 130 (30.66%) |
| Loss Trades | 294 (69.34%) |
| Short Trades | 42 |
| Short Trades Won | 28.57% |
| Long Trades | 382 |
| Long Trades Won | 30.89% |

The EA generated substantially more BUY trades than SELL trades:

**382 Long vs 42 Short**

This means approximately **90% of all trades were Long positions** during this particular historical sample.

The overall win rate was:

**30.66%**

while:

**69.34%**

of trades closed at a loss.

---

## Winning and Losing Trades

| Metric | Result |
|---|---:|
| Largest Profit Trade | $47.71 |
| Largest Loss Trade | -$8.69 |
| Average Profit Trade | $6.47 |
| Average Loss Trade | -$3.16 |
| Maximum Consecutive Wins | 5 ($31.55) |
| Maximum Consecutive Losses | 19 (-$58.34) |
| Maximal Consecutive Profit | $47.71 (1 trade) |
| Maximal Consecutive Loss | -$58.34 (19 trades) |
| Average Consecutive Wins | 2 |
| Average Consecutive Losses | 4 |

Although the average profitable trade was approximately twice the size of the average losing trade, the low win rate prevented this payoff advantage from producing positive overall expectancy.

A significant weakness is the sequence risk.

The test recorded up to:

**19 consecutive losing trades**

with a combined loss of:

**-$58.34**

This characteristic must be considered in any future optimization or risk-management work.

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:01 |
| Maximum Holding Time | 02:05:00 |
| Average Holding Time | 00:07:27 |

The strategy generally holds positions for relatively short periods.

Average position duration was approximately:

**7 minutes 27 seconds**

on the M5 test.

---

## MFE / MAE Analysis

| Correlation | Result |
|---|---:|
| Profits vs MFE | 0.87 |
| Profits vs MAE | 0.80 |
| MFE vs MAE | 0.5993 |

The report shows a strong positive relationship between realized profit and Maximum Favorable Excursion:

**Correlation (Profits, MFE) = 0.87**

This information may be useful in later research into exit management, Stop Loss, Take Profit, Break Even, and Trailing Stop behavior.

No optimization conclusion is made from these correlations alone.

---

## Entry Distribution

The Strategy Tester distribution charts show that entries occurred across multiple trading hours rather than being restricted to a single session.

Trades were recorded across Sunday through Friday, with the highest entry frequency appearing on Tuesday in this test sample.

The monthly distribution covers:

- January 2026
- February 2026
- March 2026

January generated the largest number of entries, followed by February and March.

These observations describe the tested sample only and are not yet evidence that a particular hour, weekday, month, or session should be filtered.

---

## Balance Curve Observation

The balance curve is not consistently upward sloping.

The strategy initially fluctuated around and above the starting balance and reached several local equity highs.

After approximately the later portion of the trade sequence, performance deteriorated.

The balance subsequently entered a prolonged downward phase and finished near:

**$910**

from the original:

**$1,000**

deposit.

This behavior is consistent with the reported:

- Total Net Profit: -$89.70
- Profit Factor: 0.90
- Expected Payoff: -$0.21
- LR Correlation: -0.73

The baseline strategy therefore does **not** demonstrate a positive equity trend over this test period.

---

## Baseline Assessment

### Result: FAIL

The original tested configuration does not pass the profitability baseline.

Primary evidence:

- Net Profit is negative: **-$89.70**
- Profit Factor is below 1.0: **0.90**
- Expected Payoff is negative: **-$0.21**
- Recovery Factor is negative: **-0.65**
- Sharpe Ratio is negative: **-5.00**
- LR Correlation is negative: **-0.73**
- Winning trades represent only **30.66%**
- Maximum losing sequence reached **19 trades**
- Final balance is below the initial deposit

However, the result is still useful as a research baseline.

The EA produced **424 trades** over approximately three months of M5 data using **100% real ticks**, providing a meaningful sample for investigating which components of the strategy are responsible for the negative expectancy.

---

## Research Questions Generated by This Backtest

The baseline result suggests that subsequent research should investigate, without assuming in advance that any modification will improve performance:

1. Whether the 5-bar breakout window is appropriate for XAUUSD on M5.
2. Whether performance differs materially between BUY and SELL signals.
3. Whether specific trading sessions or hours contain stronger or weaker expectancy.
4. Whether weekday filtering improves robustness.
5. Whether the fixed 300-point Stop Loss and 600-point Take Profit are appropriate.
6. Whether Break Even changes the expectancy.
7. Whether Trailing Stop changes the expectancy.
8. Whether spread filtering requires adjustment.
9. Whether the strategy suffers from repeated false breakouts during ranging market conditions.
10. Whether additional trend or volatility filters are justified.

These questions should be tested independently rather than introducing multiple modifications simultaneously.

---

## Backtest Files

This directory contains the original MT5 Strategy Tester report and its associated charts:

- `ReportTester-952747(20260908-021214).html`
- `ReportTester-952747(20260908-021215).png`
- `ReportTester-952747-hst(20260908-021214).png`
- `ReportTester-952747-mfemae(20260908-021214).png`
- `ReportTester-952747-holding(20260908-021215).png`
- `README.md`

The original HTML report should be retained as the primary evidence source.

---

## Reproducibility

To reproduce this baseline test, use:

**Expert:** EA-047_5-Bar_Range_Break  
**Symbol:** XAUUSD.PRO  
**Timeframe:** M5  
**Period:** 2026.01.02 — 2026.04.01  
**Initial Deposit:** $1,000  
**Leverage:** 1:500  
**Lot Size:** 0.01  
**Stop Loss:** 300 points  
**Take Profit:** 600 points  
**Break Even:** Disabled  
**Trailing Stop:** Disabled  
**Maximum Spread:** 35 points  
**Breakout Bars:** 5  
**History Quality:** 100% real ticks

Broker-specific symbol specifications, spread behavior, execution conditions, historical tick data, and MT5 build can affect reproduced results.

---

## Conclusion

EA-047 — 5 Bar Range Break successfully executes the intended breakout concept and generated a substantial number of trades during the baseline test.

However, the tested configuration was **not profitable** over XAUUSD.PRO M5 from 2026.01.02 to 2026.04.01.

The strategy produced:

**424 trades**  
**30.66% win rate**  
**Profit Factor 0.90**  
**Net Profit -$89.70**  
**Maximum Equity Drawdown 13.18%**

Therefore, this configuration should be treated as a **research baseline rather than a validated trading strategy**.

The next stage should focus on identifying the source of negative expectancy and testing individual modifications systematically before considering optimization or live deployment.

## Disclaimer

This backtest is provided for quantitative research and strategy-development purposes only.

Historical performance does not guarantee future results. Results can vary materially with broker conditions, historical data, spread, slippage, execution, symbol specifications, and parameter settings.
