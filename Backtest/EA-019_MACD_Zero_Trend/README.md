# EA-019_MACD_Zero_Trend — Backtest

## 1. Purpose

Thư mục này lưu kết quả backtest của:

```text
EA-019_MACD_Zero_Trend
```

Mục đích của backtest hiện tại:

* Kiểm tra EA có hoạt động xuyên suốt trên dữ liệu lịch sử hay không.
* Đánh giá hiệu quả của logic MACD Zero Line + EMA50 với bộ tham số mặc định.
* Ghi nhận Profit, Drawdown, Win Rate, Profit Factor và các chỉ số chính.
* Xác định EA hiện tại PASS hay FAIL trước khi tiếp tục nghiên cứu hoặc thay đổi strategy.

---

## 2. Backtest Files

Các artifact của lần test hiện tại:

```text
Backtest/
└── EA-019_MACD_Zero_Trend/
    ├── ReportTester-953688.html
    ├── ReportTester-953688.png
    ├── ReportTester-953688-hst.png
    ├── ReportTester-953688-mfemae.png
    ├── ReportTester-953688-holding.png
    └── README.md
```

Trong đó:

* `ReportTester-953688.html` — báo cáo Strategy Tester đầy đủ.
* `ReportTester-953688.png` — Balance graph.
* `ReportTester-953688-hst.png` — thống kê giao dịch theo giờ/ngày/tháng.
* `ReportTester-953688-mfemae.png` — MFE/MAE analysis.
* `ReportTester-953688-holding.png` — Profit theo thời gian giữ lệnh.
* `README.md` — tóm tắt và đánh giá kết quả test.

---

# 3. Test Environment

| Item            | Value                  |
| --------------- | ---------------------- |
| Expert Advisor  | EA-019_MACD_Zero_Trend |
| Platform        | MetaTrader 5           |
| Broker / Server | ACCMIntl-Real          |
| MT5 Build       | 6140                   |
| Company         | ACCM Intl Limited      |
| Symbol          | XAUUSD.PRO             |
| Timeframe       | M1                     |
| Test Start      | 2026-01-02             |
| Test End        | 2026-04-01             |
| Currency        | USD                    |
| Initial Deposit | $1,000.00              |
| Leverage        | 1:500                  |
| History Quality | 100% real ticks        |
| Bars            | 86,539                 |
| Ticks           | 40,346,891             |
| Symbols         | 1                      |

Test sử dụng dữ liệu **100% real ticks** với hơn 40 triệu ticks. Đây là dữ liệu tester đủ để đánh giá hành vi của phiên bản EA hiện tại trong chính khoảng thời gian được kiểm thử.

---

# 4. EA Parameters

Bộ tham số được sử dụng:

```text
InpLotSize       = 0.01

InpStopLoss      = 300
InpTakeProfit    = 600

InpMagicNumber   = 123456
InpSlippage      = 10

InpUseBreakEven  = true
InpBreakEven     = 150

InpUseTrailing   = true
InpTrailingStart = 200

InpMaxSpread     = 30

InpMACDFast      = 12
InpMACDSlow      = 26
InpMACDSignal    = 9

InpEMA50Period   = 50
```

Đây là bộ tham số mặc định của phiên bản EA được kiểm thử.

---

# 5. Main Results

## Profitability

| Metric           |             Result |
| ---------------- | -----------------: |
| Initial Deposit  |          $1,000.00 |
| Total Net Profit |       **-$992.55** |
| Gross Profit     |          $9,615.58 |
| Gross Loss       |        -$10,608.13 |
| Profit Factor    |           **0.91** |
| Expected Payoff  | **-$0.17 / trade** |
| Recovery Factor  |          **-0.97** |
| Sharpe Ratio     |          **-5.00** |

### Result

```text
FAIL
```

EA mất gần toàn bộ vốn ban đầu trong khoảng thời gian backtest.

Profit Factor:

```text
0.91 < 1.00
```

cho thấy tổng lợi nhuận từ các giao dịch thắng không đủ bù tổng thua lỗ.

Expected Payoff âm:

```text
-$0.17 / trade
```

cho thấy mỗi giao dịch có kỳ vọng trung bình âm trong sample này.

---

# 6. Drawdown

| Metric                    |             Result |
| ------------------------- | -----------------: |
| Balance Drawdown Absolute |            $992.55 |
| Balance Drawdown Maximal  | $1,015.73 (99.27%) |
| Balance Drawdown Relative |             99.27% |
| Equity Drawdown Absolute  |            $992.55 |
| Equity Drawdown Maximal   | $1,018.54 (99.27%) |
| Equity Drawdown Relative  |         **99.27%** |

### Assessment

```text
CRITICAL FAIL
```

Drawdown khoảng:

```text
99.27%
```

có nghĩa tài khoản gần như bị xóa sạch trong backtest.

Balance curve cũng thể hiện xu hướng giảm dài hạn rõ rệt.

Đây không phải chỉ là một giai đoạn drawdown nhỏ bên trong một hệ thống đang tăng trưởng. Kết quả cuối cùng gần như mất toàn bộ deposit ban đầu.

---

# 7. Trade Statistics

Tổng số giao dịch:

```text
5,695 trades
```

Tổng số deals:

```text
11,390 deals
```

## Overall

| Metric        |     Result |
| ------------- | ---------: |
| Total Trades  |      5,695 |
| Profit Trades |      2,268 |
| Loss Trades   |      3,427 |
| Win Rate      | **39.82%** |
| Loss Rate     | **60.18%** |

Tỷ lệ giao dịch thua cao hơn đáng kể so với giao dịch thắng.

---

# 8. BUY vs SELL

## Short Trades

```text
2,843 trades
Win Rate = 37.88%
```

## Long Trades

```text
2,852 trades
Win Rate = 41.76%
```

So sánh:

| Direction | Trades |   Win Rate |
| --------- | -----: | ---------: |
| BUY       |  2,852 | **41.76%** |
| SELL      |  2,843 | **37.88%** |

BUY hoạt động tốt hơn SELL về Win Rate trong sample này.

Tuy nhiên cả hai hướng đều có tỷ lệ thắng dưới 50%.

Không thể kết luận chỉ từ Win Rate rằng BUY có expectancy dương; cần xét đồng thời kích thước thắng/thua và các chỉ số profitability.

---

# 9. Average Win / Loss

| Metric               |     Result |
| -------------------- | ---------: |
| Largest Profit Trade |     $33.22 |
| Largest Loss Trade   |    -$43.71 |
| Average Profit Trade |  **$4.24** |
| Average Loss Trade   | **-$3.10** |

Average winning trade lớn hơn average losing trade:

```text
Average Win  = $4.24
Average Loss = $3.10
```

Tỷ lệ xấp xỉ:

```text
4.24 / 3.10 ≈ 1.37
```

Tuy nhiên Win Rate chỉ:

```text
39.82%
```

nên lợi thế từ average winner lớn hơn average loser vẫn không đủ tạo expectancy dương trong backtest này.

Kết quả thực tế xác nhận điều đó:

```text
Expected Payoff = -$0.17
Profit Factor   = 0.91
```

---

# 10. Consecutive Results

| Metric                     |              Result |
| -------------------------- | ------------------: |
| Maximum Consecutive Wins   |                   9 |
| Maximum Consecutive Losses |              **15** |
| Maximal Consecutive Profit |   $38.05 / 7 trades |
| Maximal Consecutive Loss   | -$56.47 / 15 trades |
| Average Consecutive Wins   |                   2 |
| Average Consecutive Losses |                   3 |

EA từng trải qua:

```text
15 consecutive losing trades
```

trong sample hiện tại.

Điều này cần được tính đến khi đánh giá risk và tính ổn định của strategy.

---

# 11. Position Holding Time

| Metric               |       Result |
| -------------------- | -----------: |
| Minimum Holding Time |     00:00:01 |
| Maximum Holding Time |     03:39:23 |
| Average Holding Time | **00:03:17** |

EA giao dịch với thời gian giữ lệnh trung bình rất ngắn:

```text
3 phút 17 giây
```

Điều này phù hợp với việc test trên timeframe M1 và số lượng giao dịch lớn.

Có những lệnh đóng chỉ sau:

```text
1 giây
```

trong khi lệnh lâu nhất tồn tại:

```text
3 giờ 39 phút 23 giây
```

---

# 12. MFE / MAE

Strategy Tester ghi nhận:

| Correlation    | Result |
| -------------- | -----: |
| Profits vs MFE |   0.88 |
| Profits vs MAE |   0.69 |
| MFE vs MAE     | 0.5160 |

Các dữ liệu này có thể được sử dụng ở giai đoạn Research để nghiên cứu hành vi của:

* Stop Loss
* Take Profit
* Break Even
* Trailing Stop

Tuy nhiên không thay đổi các tham số này chỉ dựa trên biểu đồ MFE/MAE hiện tại.

---

# 13. Balance Curve

Balance graph cho thấy xu hướng tổng thể:

```text
Initial Balance
≈ $1,000
     ↓
Long-term decline
     ↓
Temporary recovery periods
     ↓
Further decline
     ↓
Near account depletion
```

Có những giai đoạn phục hồi cục bộ nhưng không thay đổi được xu hướng giảm tổng thể.

Chỉ số:

```text
LR Correlation = -0.86
```

cũng phù hợp với xu hướng balance giảm mạnh trong sample.

---

# 14. Backtest Verdict

## Status

```text
FAIL
```

### Evidence

```text
Net Profit          = -$992.55
Profit Factor       = 0.91
Expected Payoff     = -$0.17
Sharpe Ratio        = -5.00
Max Equity Drawdown = 99.27%
Win Rate            = 39.82%
Loss Rate           = 60.18%
```

### Primary Failure Reason

```text
The current strategy configuration has negative expectancy
and produces near-total account drawdown in this backtest.
```

EA hiện tại **không đạt yêu cầu để chuyển sang forward test/live test** dựa trên kết quả này.

---

# 15. What This Test Proves

Backtest hiện tại cung cấp evidence rằng:

1. EA có tạo và quản lý số lượng lớn giao dịch trong Strategy Tester.
2. Logic hiện tại tạo cả BUY và SELL.
3. Tester chạy trên 100% real ticks trong sample được chọn.
4. Phiên bản hiện tại không tạo lợi nhuận trên XAUUSD.PRO M1 trong khoảng thời gian test.
5. Drawdown của cấu hình hiện tại là không chấp nhận được.
6. Strategy hiện tại cần được nghiên cứu trước khi tiếp tục validation.

---

# 16. What This Test Does NOT Prove

Backtest này không chứng minh rằng:

* MACD Zero Trend hoàn toàn không thể hoạt động.
* Strategy không thể hoạt động trên timeframe khác.
* Strategy không thể hoạt động với logic entry/exit khác.
* Một bộ tham số khác chắc chắn sẽ có lợi nhuận.
* Kết quả tối ưu trong tương lai sẽ hoạt động ngoài sample.
* EA có thể sử dụng an toàn trên tài khoản thật.

Đây là kết quả của:

```text
1 EA version
+
1 parameter set
+
1 symbol
+
1 timeframe
+
1 historical test period
```

---

# 17. Research Questions Raised by This Test

Kết quả FAIL tạo ra các câu hỏi cần nghiên cứu tiếp:

### Entry

* Logic hiện tại có vào quá nhiều lệnh trên M1 không?
* `MACD Main > Signal` / `< Signal` có quá rộng không?
* Có nên yêu cầu MACD crossover thực sự?
* Zero-line filter có tạo lợi thế không?
* EMA50 có thực sự cải thiện expectancy không?

### Exit

* SL 300 có phù hợp với XAUUSD.PRO M1 không?
* TP 600 có phù hợp không?
* Break Even 150 có đóng lệnh quá sớm không?
* Trailing 200 có cải thiện hay làm giảm expectancy?

### Market Conditions

* Strategy có hoạt động khác nhau theo trading session không?
* BUY và SELL có cần được nghiên cứu riêng không?
* Strategy có hoạt động tốt hơn trên timeframe cao hơn không?

Các câu hỏi trên thuộc giai đoạn **Research**, chưa phải kết luận thay đổi EA.

---

# 18. Next Status

```text
EA implementation
      ↓
Backtest #001
      ↓
FAIL
      ↓
Research required
```

Không chuyển trạng thái EA sang validated.

Không forward test.

Không live test.

Không coi strategy hiện tại là profitable.

---

# 19. Final Conclusion

`EA-019_MACD_Zero_Trend` với cấu hình hiện tại trên:

```text
XAUUSD.PRO
M1
2026-01-02 → 2026-04-01
```

đã:

```text
BACKTEST RESULT: FAIL
```

Lý do chính:

```text
Negative Net Profit
Profit Factor < 1
Negative Expected Payoff
Extremely high Drawdown
Negative Sharpe Ratio
Declining Balance Curve
```

Artifact Strategy Tester phải được giữ nguyên để làm evidence cho kết quả này.

Bước tiếp theo thuộc:

```text
Research/
```

Không tối ưu EA trực tiếp trước khi xác định nguyên nhân strategy thất bại.
