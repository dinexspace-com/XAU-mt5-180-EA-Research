# EA-023 — Supertrend Retest | Backtest

## 1. Backtest Overview

Thư mục này lưu kết quả backtest của **EA-023_Supertrend_Retest** trên MetaTrader 5.

Mục đích của backtest là kiểm tra hiệu suất thực tế của phiên bản EA hiện tại trước khi thực hiện các bước nghiên cứu và tối ưu tiếp theo.

### Test Environment

| Item             | Value                      |
| ---------------- | -------------------------- |
| Expert Advisor   | `EA-023_Supertrend_Retest` |
| Symbol           | `XAUUSD.PRO`               |
| Timeframe        | `M1`                       |
| Test Period      | `2026.01.02 – 2026.03.01`  |
| History Quality  | `100% real ticks`          |
| Bars             | `56,115`                   |
| Ticks            | `25,190,686`               |
| Initial Deposit  | `$1,000.00`                |
| Currency         | `USD`                      |
| Leverage         | `1:500`                    |
| Broker / Company | `ACCM Intl Limited`        |
| MT5 Build        | `6140`                     |

---

## 2. EA Parameters

### Risk Management

| Parameter         |  Value |
| ----------------- | -----: |
| `InpLotSize`      |   0.01 |
| `InpStopLoss`     |    300 |
| `InpTakeProfit`   |    600 |
| `InpMagicNumber`  | 123456 |
| `InpSlippage`     |     10 |
| `InpMaxSpread`    |     30 |
| `InpMaxPositions` |      1 |

### Supertrend

| Parameter       | Value |
| --------------- | ----: |
| `InpAtrPeriod`  |    10 |
| `InpMultiplier` |   3.0 |

### Retest

| Parameter          | Value |
| ------------------ | ----: |
| `InpRetestMaxBars` |     5 |
| `InpRetestBuffer`  |   5.0 |

### Break Even & Trailing Stop

| Parameter             | Value |
| --------------------- | ----: |
| `InpUseBreakEven`     |  true |
| `InpBreakEvenTrigger` |   150 |
| `InpUseTrailingStop`  |  true |
| `InpTrailingStart`    |   200 |
| `InpTrailingDistance` |   200 |
| `InpTrailingStep`     |    10 |

---

## 3. Backtest Results

### Performance

| Metric            |          Result |
| ----------------- | --------------: |
| Total Net Profit  |     **-$18.71** |
| Gross Profit      |         $156.85 |
| Gross Loss        |        -$175.56 |
| Profit Factor     |        **0.89** |
| Expected Payoff   |      **-$0.13** |
| Recovery Factor   |       **-0.34** |
| Sharpe Ratio      |       **-5.00** |
| AHPR              | 0.9999 (-0.01%) |
| GHPR              | 0.9999 (-0.01%) |
| LR Correlation    |           -0.43 |
| LR Standard Error |           12.84 |

Kết quả cho thấy phiên bản hiện tại **chưa tạo được positive expectancy** trong giai đoạn backtest này.

Profit Factor dưới 1.0 và Total Net Profit âm.

---

## 4. Drawdown

| Metric                    |             Result |
| ------------------------- | -----------------: |
| Balance Drawdown Absolute |             $49.07 |
| Balance Drawdown Maximal  | $54.77 (**5.45%**) |
| Balance Drawdown Relative | **5.45%** ($54.77) |
| Equity Drawdown Absolute  |             $49.28 |
| Equity Drawdown Maximal   | $55.46 (**5.51%**) |
| Equity Drawdown Relative  | **5.51%** ($55.46) |

Drawdown của backtest nằm quanh mức **5.5%** trên tài khoản ban đầu $1,000.

Tuy nhiên, drawdown thấp không đủ để đánh giá EA đạt yêu cầu khi lợi nhuận ròng và expectancy vẫn âm.

---

## 5. Trade Statistics

| Metric         |          Result |
| -------------- | --------------: |
| Total Trades   |         **139** |
| Total Deals    |             278 |
| Winning Trades | 67 (**48.20%**) |
| Losing Trades  | 72 (**51.80%**) |
| Short Trades   |              90 |
| Short Win Rate |      **50.00%** |
| Long Trades    |              49 |
| Long Win Rate  |      **44.90%** |

### Profit / Loss Distribution

| Metric                     |  Result |
| -------------------------- | ------: |
| Largest Profit Trade       |   $7.42 |
| Largest Loss Trade         |  -$3.92 |
| Average Profit Trade       |   $2.34 |
| Average Loss Trade         |  -$2.44 |
| Maximum Consecutive Wins   |       9 |
| Maximum Consecutive Losses |       6 |
| Maximum Consecutive Profit |  $29.47 |
| Maximum Consecutive Loss   | -$14.85 |
| Average Consecutive Wins   |       2 |
| Average Consecutive Losses |       2 |

Average winning trade ($2.34) nhỏ hơn average losing trade ($2.44), trong khi win rate chỉ đạt 48.20%.

Đây là một trong những đặc điểm cần được xem xét ở bước nghiên cứu tiếp theo.

---

## 6. Long vs Short

Kết quả cho thấy sự khác biệt giữa hai hướng giao dịch:

```text
SELL
90 trades
Win Rate: 50.00%

BUY
49 trades
Win Rate: 44.90%
```

Trong mẫu backtest này, SELL có win rate cao hơn BUY.

Tuy nhiên, dữ liệu hiện tại chưa đủ để kết luận EA nên loại bỏ hoặc thay đổi một hướng giao dịch. Cần kiểm tra trên khoảng thời gian dài hơn trước khi đưa ra quyết định.

---

## 7. Position Holding Time

| Metric               |       Result |
| -------------------- | -----------: |
| Minimum Holding Time |     00:00:02 |
| Maximum Holding Time |     00:15:45 |
| Average Holding Time | **00:02:38** |

EA-023 trên timeframe M1 tạo ra các giao dịch có thời gian giữ lệnh tương đối ngắn.

---

## 8. MFE / MAE Statistics

MetaTrader 5 report ghi nhận:

| Correlation    |     Result |
| -------------- | ---------: |
| Profits vs MFE |   **0.96** |
| Profits vs MAE |   **0.71** |
| MFE vs MAE     | **0.6313** |

Các dữ liệu MFE/MAE và biểu đồ tương ứng được giữ lại trong Strategy Tester Report để phục vụ nghiên cứu exit logic ở các bước sau.

---

## 9. Equity / Balance Observation

Balance bắt đầu tại:

```text
$1,000
```

Trong quá trình backtest, balance trải qua một giai đoạn giảm kéo dài trước khi phục hồi đáng kể về cuối kỳ.

Final result:

```text
Initial Deposit: $1,000.00
Net Profit:      -$18.71
Final Balance:   ~$981.29
```

Do đó, dù có giai đoạn phục hồi mạnh về cuối backtest, EA vẫn kết thúc dưới mức vốn ban đầu.

---

## 10. Baseline Assessment

### Current Status

**FAIL — Baseline is not profitable.**

Lý do:

```text
Net Profit       = -$18.71
Profit Factor    = 0.89
Expected Payoff  = -$0.13
Recovery Factor  = -0.34
Win Rate         = 48.20%
```

Backtest này không bị loại bỏ.

Nó được giữ làm **baseline** để so sánh với các phiên bản nghiên cứu hoặc tối ưu tiếp theo.

---

## 11. Important Observations

Từ kết quả baseline hiện tại:

1. EA có **139 trades**, đủ để quan sát hành vi ban đầu nhưng chưa nên dùng để kết luận độ bền dài hạn.

2. Profit Factor **0.89** cho thấy tổng lợi nhuận chưa bù được tổng thua lỗ.

3. Win rate tổng thể **48.20%**.

4. Average winner **$2.34** thấp hơn average loser **$2.44**.

5. SELL có win rate **50.00%**, cao hơn BUY **44.90%**.

6. Maximum Equity Drawdown **5.51%** tương đối thấp, nhưng EA vẫn không có positive expectancy.

7. Average holding time chỉ **2 phút 38 giây**, cho thấy kết quả có thể nhạy với spread, execution và điều kiện giao dịch trên M1.

8. Equity/balance phục hồi đáng kể trong phần cuối backtest nhưng chưa đủ để đưa tổng kết quả về mức có lợi nhuận.

---

## 12. Research Questions

Baseline này tạo ra các câu hỏi cần nghiên cứu tiếp theo:

* Hiệu suất có khác biệt đáng kể giữa BUY và SELL không?
* EA hoạt động tốt/xấu ở những trading hours nào?
* Kết quả có phụ thuộc vào trading session không?
* Retest condition hiện tại có quá rộng hoặc quá hẹp không?
* `InpRetestMaxBars` và `InpRetestBuffer` ảnh hưởng thế nào?
* Supertrend ATR Period / Multiplier có phù hợp với XAUUSD M1 không?
* Break Even có cắt các winner quá sớm không?
* Trailing Stop có cải thiện hay làm giảm expectancy?
* Fixed SL/TP có phù hợp với biến động XAUUSD không?
* Kết quả có ổn định khi mở rộng test period không?

Các câu hỏi này thuộc bước **Research** và không được coi là kết luận chỉ từ baseline hiện tại.

---

## 13. Backtest Evidence

Các file Strategy Tester gốc cần được giữ lại trong thư mục này.

```text
Backtest/
└── EA-023_Supertrend_Retest/
    ├── README.md
    ├── ReportTester-953688(8).html
    ├── ReportTester-953688(8).png
    ├── ReportTester-953688-hst(8).png
    ├── ReportTester-953688-mfemae(8).png
    └── ReportTester-953688-holding(8).png
```

Không chỉnh sửa dữ liệu trong Strategy Tester Report gốc.

---

## 14. Conclusion

Backtest baseline của **EA-023_Supertrend_Retest** trên `XAUUSD.PRO M1` trong giai đoạn `2026.01.02 – 2026.03.01` cho kết quả:

```text
Net Profit:      -$18.71
Profit Factor:    0.89
Max Equity DD:    5.51%
Total Trades:     139
Win Rate:         48.20%
```

### Verdict

**FAIL — Strategy baseline chưa có lợi thế thống kê dương trong mẫu backtest hiện tại.**

Kết quả này được giữ làm **baseline reference** cho quá trình Research và các backtest tiếp theo.

Không sử dụng kết quả này làm bằng chứng rằng EA đã sẵn sàng cho live trading.
