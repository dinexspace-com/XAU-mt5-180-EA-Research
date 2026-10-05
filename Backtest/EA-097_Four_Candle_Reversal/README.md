# EA-097 — Four Candle Reversal — Backtest

## 1. Test Identification

```text
Research ID: EA097-M1-BASELINE-001
Expert: EA-097_Four_Candle_Reversal
Symbol: XAUUSD.PRO
Timeframe: M1
Period: 2026.01.02 - 2026.03.31
Initial Deposit: $1,000
Leverage: 1:500
History Quality: 100% real ticks
```

## Nguồn: Strategy Tester Report đính kèm.

## 2. Parameters

```text
InpLotSize=0.01
InpStopLoss=300
InpTakeProfit=600
InpMagicNumber=123097
InpSlippage=10
InpMaxSpread=30
InpTimeframe=1

InpUseBreakEven=true
InpBreakEvenTrigger=150
InpBreakEvenOffset=0

InpUseTrailingStop=true
InpTrailingStart=200
InpTrailingDistance=100
InpTrailingStep=10
```

Các thông số trên được lấy trực tiếp từ report.

---

## 3. Core Results

| Metric          |       Result |
| --------------- | -----------: |
| Initial Deposit |    $1,000.00 |
| Net Profit      | **-$487.18** |
| Gross Profit    |    $5,233.83 |
| Gross Loss      |   -$5,721.01 |
| Profit Factor   |     **0.91** |
| Expected Payoff |       -$0.10 |
| Recovery Factor |        -0.76 |
| Sharpe Ratio    |        -5.00 |
| LR Correlation  |        -0.95 |

Nguồn: Strategy Tester Report.

---

## 4. Drawdown

| Metric              |               Result |
| ------------------- | -------------------: |
| Balance DD Absolute |              $601.12 |
| Equity DD Absolute  |              $602.45 |
| Balance DD Maximal  |     $634.53 / 61.40% |
| Equity DD Maximal   | $636.89 / **61.57%** |

Drawdown ở mức rất cao so với vốn ban đầu $1,000.

---

## 5. Trade Statistics

| Metric        |             Result |
| ------------- | -----------------: |
| Total Trades  |              4,642 |
| Total Deals   |              9,284 |
| Profit Trades |     2,348 / 50.58% |
| Loss Trades   |     2,294 / 49.42% |
| Short Trades  | 2,374 / 51.94% win |
| Long Trades   | 2,268 / 49.16% win |

---

## 6. Trade Distribution

| Metric                     |             Result |
| -------------------------- | -----------------: |
| Largest Profit Trade       |             $11.62 |
| Largest Loss Trade         |            -$38.88 |
| Average Profit Trade       |              $2.23 |
| Average Loss Trade         |             -$2.49 |
| Max Consecutive Wins       |        10 / $22.49 |
| Max Consecutive Losses     |       10 / -$24.46 |
| Max Consecutive Profit     |  $23.12 / 7 trades |
| Max Consecutive Loss       | -$51.29 / 6 trades |
| Average Consecutive Wins   |                  2 |
| Average Consecutive Losses |                  2 |

---

## 7. Holding Time

```text
Minimum holding time: 0:00:01
Maximum holding time: 2:10:02
Average holding time: 0:02:36
```

---

## 8. Baseline Assessment

### Result: FAIL

Lý do:

1. Net Profit âm: **-$487.18**.
2. Profit Factor chỉ **0.91**, nhỏ hơn 1.
3. Expected Payoff âm.
4. Sharpe Ratio âm.
5. Maximum Equity Drawdown lên tới **61.57%**.
6. Average loss trade (-$2.49) lớn hơn average profit trade ($2.23).

Do đó:

```text
EA-097-M1-BASELINE-001 = FAIL
```

Baseline này cần được giữ nguyên làm mốc nghiên cứu và không được coi là phiên bản production.
