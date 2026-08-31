# Backtest — EA-035_HH_HL_Structure

## Overview

This folder contains the baseline backtest results for:

**EA-035_HH_HL_Structure**

The EA trades XAUUSD using basic market structure:

- Higher High + Higher Low → BUY
- Lower High + Lower Low → SELL

The purpose of this backtest is to evaluate the baseline behavior and performance of the current EA implementation before further research or optimization.

---

## Test Environment

| Parameter | Value |
|---|---|
| Expert Advisor | EA-035_HH_HL_Structure |
| Symbol | XAUUSD.PRO |
| Timeframe | M1 |
| Test Period | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000.00 |
| Account Currency | USD |
| Leverage | 1:500 |
| History Quality | 100% real ticks |
| Bars | 86,539 |
| Ticks | 40,346,891 |
| Symbols | 1 |

The backtest was performed using MetaTrader 5 Strategy Tester with 100% real tick history.

---

## Tested Parameters

| Parameter | Value |
|---|---:|
| `InpLotSize` | 0.01 |
| `InpStopLoss` | 300 |
| `InpTakeProfit` | 600 |
| `InpMagicNumber` | 123456 |
| `InpSlippage` | 10 |
| `InpMaxSpread` | 35 |
| `InpUseBreakEven` | false |
| `InpBreakEvenTrigger` | 150 |
| `InpBreakEvenLock` | 10 |
| `InpUseTrailingStop` | false |
| `InpTrailingStart` | 200 |
| `InpTrailingStep` | 50 |

Break-Even and Trailing Stop parameters exist in the EA but both features were disabled during this baseline backtest.

---

## Performance Summary

| Metric | Result |
|---|---:|
| Initial Deposit | $1,000.00 |
| Total Net Profit | **-$994.57** |
| Approx. Ending Balance | **$5.43** |
| Gross Profit | $13,381.72 |
| Gross Loss | -$14,376.29 |
| Profit Factor | **0.93** |
| Expected Payoff | **-$0.15** |
| Recovery Factor | **-0.94** |
| Sharpe Ratio | **-5.00** |
| LR Correlation | **-0.91** |

The strategy produced a negative net result over the tested period.

With an initial deposit of $1,000 and a total net loss of $994.57, the account finished the test with approximately $5.43.

---

## Drawdown

| Metric | Result |
|---|---:|
| Balance Drawdown Absolute | $994.57 |
| Equity Drawdown Absolute | $994.57 |
| Balance Drawdown Maximal | $1,062.71 (99.49%) |
| Equity Drawdown Maximal | $1,062.71 (99.49%) |
| Balance Drawdown Relative | 99.49% |
| Equity Drawdown Relative | 99.49% |

Maximum relative drawdown reached:

**99.49%**

The baseline configuration therefore experienced near-total account drawdown during the test.

---

## Trade Statistics

| Metric | Result |
|---|---:|
| Total Trades | **6,651** |
| Total Deals | 13,302 |
| Profit Trades | 2,143 (32.22%) |
| Loss Trades | 4,508 (67.78%) |
| Short Trades | 3,374 |
| Short Win Rate | 32.51% |
| Long Trades | 3,277 |
| Long Win Rate | 31.92% |

The EA generated 6,651 trades during the test.

Overall win rate:

**32.22%**

Overall loss rate:

**67.78%**

BUY and SELL performance were similar, with short trades winning 32.51% of the time and long trades winning 31.92%.

---

## Profit and Loss Characteristics

| Metric | Result |
|---|---:|
| Largest Profit Trade | $35.88 |
| Largest Loss Trade | -$42.23 |
| Average Profit Trade | $6.24 |
| Average Loss Trade | -$3.19 |

The average winning trade was approximately twice the size of the average losing trade.

However, the relatively low win rate resulted in negative overall expectancy.

---

## Consecutive Trades

| Metric | Result |
|---|---:|
| Maximum Consecutive Wins | 8 |
| Profit During Maximum Win Sequence | $50.01 |
| Maximum Consecutive Losses | 30 |
| Loss During Maximum Loss Sequence | -$92.80 |
| Average Consecutive Wins | 1 |
| Average Consecutive Losses | 3 |

The longest losing sequence reached:

**30 consecutive losing trades**

The average losing sequence was three trades, while the average winning sequence was one trade.

---

## Position Holding Time

| Metric | Result |
|---|---:|
| Minimum Holding Time | 00:00:06 |
| Maximum Holding Time | 03:45:55 |
| Average Holding Time | **00:03:47** |

The average position was held for approximately 3 minutes and 47 seconds.

This confirms that under the M1 test configuration the EA operated as a short-term trading system.

---

## MFE / MAE Statistics

| Metric | Result |
|---|---:|
| Correlation (Profits, MFE) | 0.84 |
| Correlation (Profits, MAE) | 0.72 |
| Correlation (MFE, MAE) | 0.5059 |

The Strategy Tester report shows a relatively strong correlation between realized profit and Maximum Favorable Excursion (MFE).

These statistics are retained as evidence for later research and optimization.

---

## Balance Curve

The balance curve shows a clear long-term downward trend.

Although several temporary recovery periods occurred during the test, they were not sufficient to reverse the overall decline.

The reported linear regression correlation was:

**LR Correlation = -0.91**

By the end of the test, almost all of the original $1,000 account balance had been lost.

---

## Backtest Assessment

### Technical Execution

**PASS**

The backtest demonstrates that the current EA implementation is capable of:

- Detecting HH/HL and LH/LL trading signals
- Opening BUY and SELL positions
- Applying Stop Loss and Take Profit
- Processing thousands of trades
- Completing a real-tick Strategy Tester run

### Strategy Performance

**FAIL**

The baseline strategy did not demonstrate a profitable trading edge under the tested configuration.

Key evidence:

| Metric | Result |
|---|---:|
| Net Profit | **-$994.57** |
| Profit Factor | **0.93** |
| Expected Payoff | **-$0.15** |
| Win Rate | **32.22%** |
| Maximum Drawdown | **99.49%** |
| Sharpe Ratio | **-5.00** |

The current baseline configuration is therefore not suitable for live deployment.

---

## Backtest Conclusion

EA-035_HH_HL_Structure successfully completed the baseline technical test.

The EA generated and managed trades as expected from its implemented HH/HL and LH/LL structure logic.

However, the baseline trading performance failed.

The main result of this test is:

```text
Implementation / Execution: PASS
Baseline Trading Performance: FAIL
