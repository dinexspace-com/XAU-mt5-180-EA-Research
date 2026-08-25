# EA-024 — Donchian Trend Backtest

Thư mục này lưu kết quả backtest của:

**EA-024_Donchian_Trend**

Backtest được thực hiện bằng MetaTrader 5 Strategy Tester nhằm đánh giá hành vi và hiệu quả của phiên bản EA hiện tại trước khi tiếp tục chỉnh sửa chiến lược.

> **Backtest Status: FAIL**
> Phiên bản được kiểm thử hiện tại không đạt yêu cầu về profitability và risk control.

---

## 1. Test Environment

| Thông số         | Giá trị                   |
| ---------------- | ------------------------- |
| Expert Advisor   | `EA-024_Donchian_Trend`   |
| Symbol           | `XAUUSD.PRO`              |
| Timeframe        | `M1`                      |
| Test Period      | `2026.01.02 - 2026.03.01` |
| Broker / Server  | `ACCMIntl-Real`           |
| MT5 Build        | `6140`                    |
| Account Currency | `USD`                     |
| Initial Deposit  | `$1,000.00`               |
| Leverage         | `1:500`                   |
| History Quality  | `100% real ticks`         |
| Symbols tested   | `1`                       |

Dữ liệu kiểm thử:

```text
Bars: 56,115
Ticks: 25,190,686
History Quality: 100% real ticks
```

---

# 2. EA Parameters

## Order Settings

| Parameter        |    Value |
| ---------------- | -------: |
| `InpLotSize`     |   `0.01` |
| `InpStopLoss`    |    `300` |
| `InpTakeProfit`  |    `600` |
| `InpMagicNumber` | `240208` |
| `InpSlippage`    |     `10` |

---

## Risk Management

| Parameter             |  Value |
| --------------------- | -----: |
| `InpUseBreakEven`     | `true` |
| `InpBreakEvenTrigger` |  `150` |
| `InpBreakEvenLevel`   |    `0` |

---

## Trailing Stop

| Parameter          |  Value |
| ------------------ | -----: |
| `InpUseTrailing`   | `true` |
| `InpTrailingStart` |  `200` |
| `InpTrailingStep`  |   `10` |

---

## Filters

| Parameter           |  Value |
| ------------------- | -----: |
| `InpMaxSpread`      | `30.0` |
| `InpDonchianPeriod` |   `20` |
| `InpMaxPositions`   |    `1` |

---

# 3. Main Backtest Results

## Profitability

| Metric           |            Result |
| ---------------- | ----------------: |
| Initial Deposit  |       `$1,000.00` |
| Total Net Profit |    **`-$992.04`** |
| Gross Profit     |      `$18,763.91` |
| Gross Loss       |     `-$19,755.95` |
| Profit Factor    |        **`0.95`** |
| Expected Payoff  |       **`-0.11`** |
| Recovery Factor  |       **`-0.94`** |
| Sharpe Ratio     |       **`-5.00`** |
| AHPR             | `0.9997 (-0.03%)` |
| GHPR             | `0.9995 (-0.05%)` |

### Kết quả

```text
Initial Deposit : $1,000.00
Net Profit      : -$992.04
```

EA mất gần như toàn bộ số vốn ban đầu trong test này.

Profit Factor:

```text
0.95
```

nhỏ hơn `1.00`, nghĩa là tổng gross profit không đủ bù gross loss.

Expected Payoff:

```text
-0.11 / trade
```

cho thấy expectancy của hệ thống trong backtest này là âm.

---

# 4. Drawdown

| Metric                    |                   Result |
| ------------------------- | -----------------------: |
| Balance Drawdown Absolute |                `$992.04` |
| Equity Drawdown Absolute  |                `$992.04` |
| Balance Drawdown Maximal  | **`$1,060.90 (99.26%)`** |
| Equity Drawdown Maximal   | **`$1,060.90 (99.26%)`** |
| Balance Drawdown Relative |             **`99.26%`** |
| Equity Drawdown Relative  |             **`99.26%`** |

### Assessment

```text
Maximum Drawdown = 99.26%
```

Đây là mức drawdown không thể chấp nhận đối với một hệ thống được kỳ vọng dùng trong giao dịch thực tế.

Balance graph cũng cho thấy:

* Balance giảm trong giai đoạn đầu.
* Sau đó có một giai đoạn recovery mạnh.
* Balance đạt đỉnh mới ở giữa quá trình test.
* Sau đỉnh, hệ thống bước vào một chuỗi suy giảm kéo dài.
* Cuối backtest, gần như toàn bộ vốn ban đầu đã bị mất.

Do đó vấn đề không chỉ nằm ở một vài giao dịch thua lớn mà ở khả năng duy trì lợi thế của chiến lược trong toàn bộ giai đoạn kiểm thử.

---

# 5. Trade Statistics

Tổng số giao dịch:

```text
Total Trades: 9,320
Total Deals : 18,640
```

## Winning vs Losing Trades

| Metric         |       Result |
| -------------- | -----------: |
| Winning Trades |      `3,056` |
| Losing Trades  |      `6,264` |
| Win Rate       | **`32.79%`** |
| Loss Rate      | **`67.21%`** |

Hệ thống có số giao dịch thua lớn hơn đáng kể số giao dịch thắng.

---

# 6. Long vs Short

| Direction |  Trades | Win Rate |
| --------- | ------: | -------: |
| Short     | `4,811` | `32.47%` |
| Long      | `4,509` | `33.13%` |

Hai hướng giao dịch có kết quả tương đối giống nhau.

```text
Short Win Rate = 32.47%
Long Win Rate  = 33.13%
```

Không có bằng chứng rõ ràng trong backtest này cho thấy BUY hoặc SELL đang tạo ra lợi thế nổi bật so với hướng còn lại.

---

# 7. Average Win / Loss

| Metric               |    Result |
| -------------------- | --------: |
| Largest Profit Trade |  `$33.87` |
| Largest Loss Trade   | `-$43.09` |
| Average Profit Trade |   `$6.14` |
| Average Loss Trade   |  `-$3.15` |

Average winning trade lớn hơn average losing trade:

```text
Average Win  = $6.14
Average Loss = $3.15
```

Tỷ lệ xấp xỉ:

```text
Average Win / Average Loss ≈ 1.95
```

Tuy nhiên win rate chỉ:

```text
32.79%
```

nên reward của winning trades chưa đủ để tạo expectancy dương.

Kết quả cuối cùng:

```text
Profit Factor = 0.95
Expected Payoff = -0.11
```

---

# 8. Consecutive Wins / Losses

| Metric                     |                Result |
| -------------------------- | --------------------: |
| Maximum Consecutive Wins   |                   `8` |
| Maximum Consecutive Losses |              **`19`** |
| Maximal Consecutive Profit |   `$47.68 / 8 trades` |
| Maximal Consecutive Loss   | `-$75.25 / 11 trades` |
| Average Consecutive Wins   |                   `1` |
| Average Consecutive Losses |                   `3` |

Điểm đáng chú ý:

```text
Average winning streak = 1
Average losing streak  = 3
```

và:

```text
Maximum losing streak = 19 trades
```

Hệ thống vì vậy phải chịu các chuỗi thua đáng kể.

---

# 9. Holding Time

| Metric               |     Result |
| -------------------- | ---------: |
| Minimum Holding Time | `00:00:01` |
| Maximum Holding Time | `02:48:02` |
| Average Holding Time | `00:03:13` |

EA giao dịch với thời gian giữ lệnh tương đối ngắn.

Average:

```text
3 phút 13 giây / position
```

Trong khi thời gian tối đa đạt:

```text
2 giờ 48 phút 02 giây
```

Điều này cho thấy phần lớn giao dịch đóng khá nhanh nhưng vẫn tồn tại một số position kéo dài đáng kể.

---

# 10. MFE / MAE Statistics

Strategy Tester ghi nhận:

| Correlation    |   Result |
| -------------- | -------: |
| Profits vs MFE |   `0.84` |
| Profits vs MAE |   `0.72` |
| MFE vs MAE     | `0.4996` |

Trong đó:

* **MFE — Maximum Favorable Excursion:** mức giá đi thuận lợi tối đa khi position còn mở.
* **MAE — Maximum Adverse Excursion:** mức giá đi bất lợi tối đa khi position còn mở.

Correlation giữa Profit và MFE:

```text
0.84
```

là tương đối cao.

Thông tin này có thể được sử dụng ở vòng nghiên cứu sau để kiểm tra:

* Exit logic.
* Take Profit.
* Trailing Stop.
* Break Even.
* Khả năng giữ winning trades lâu hơn.

Tuy nhiên backtest hiện tại chưa đủ để kết luận thay đổi nào sẽ cải thiện hệ thống.

---

# 11. Balance Curve

Balance curve cho thấy ba giai đoạn đáng chú ý.

### Phase 1 — Initial Drawdown

Balance giảm đáng kể từ vốn ban đầu.

### Phase 2 — Recovery

Hệ thống sau đó hồi phục mạnh và có thời điểm vượt mức vốn ban đầu.

Điều này cho thấy chiến lược có khả năng kiếm tiền trong một số market regimes.

### Phase 3 — Structural Decline

Sau khi đạt vùng balance cao nhất, equity/balance bước vào xu hướng giảm kéo dài cho đến cuối test.

Kết quả cuối cùng:

```text
Net Profit = -$992.04
```

trên vốn:

```text
$1,000
```

Do đó recovery ở giữa backtest không duy trì được.

---

# 12. Trade Frequency

EA tạo:

```text
9,320 trades
```

trong khoảng thời gian:

```text
2026.01.02 → 2026.03.01
```

trên timeframe:

```text
M1
```

Đây là tần suất giao dịch rất cao đối với phiên bản chiến lược đang được nghiên cứu.

Kết hợp với:

```text
Average holding time = 3:13
Win rate             = 32.79%
Profit factor        = 0.95
```

trade frequency là một yếu tố cần được kiểm tra trong các phiên bản tiếp theo.

---

# 13. Key Findings

Backtest hiện tại cho thấy:

### Positive observations

* Test sử dụng `100% real ticks`.
* Có số lượng giao dịch lớn: `9,320 trades`.
* Average profit trade (`$6.14`) lớn hơn average loss trade (`$3.15`).
* Profit/MFE correlation cao (`0.84`).
* Hệ thống từng có khả năng recovery và tạo balance vượt vốn ban đầu trong một phần giai đoạn test.

### Critical problems

* Net Profit: **`-$992.04`**
* Profit Factor: **`0.95`**
* Expected Payoff: **`-0.11`**
* Sharpe Ratio: **`-5.00`**
* Maximum Drawdown: **`99.26%`**
* Losing Trades: **`67.21%`**
* Maximum Losing Streak: **`19 trades`**
* Balance cuối test gần mất toàn bộ vốn ban đầu.

---

# 14. Backtest Verdict

## ❌ FAIL

Phiên bản EA được kiểm thử **không đạt tiêu chí để chuyển sang validation/live test**.

Nguyên nhân chính:

```text
Profit Factor < 1
Expected Payoff < 0
Net Profit < 0
Maximum Drawdown ≈ 99%
```

Backtest này được giữ lại như **baseline result** để so sánh với các version sau.

Không tối ưu parameter chỉ để làm đẹp kết quả baseline này.

---

# 15. Next Research Direction

Kết quả backtest hiện tại nên được sử dụng làm baseline.

Trước backtest tiếp theo cần ưu tiên kiểm tra:

```text
1. Entry logic
2. Donchian calculation
3. Position-management execution
4. Break Even
5. Trailing Stop
6. Trade frequency
```

Sau khi sửa logic EA mới chạy lại test với cùng dataset để tạo so sánh:

```text
Current version
      ↓
Fixed version
      ↓
Same test period
      ↓
Compare metrics
```

Các metric chính để so sánh:

```text
Net Profit
Profit Factor
Expected Payoff
Maximum Drawdown
Win Rate
Trade Count
Average Win
Average Loss
```

---

# 16. Files

Backtest package bao gồm Strategy Tester Report và các chart được MetaTrader 5 xuất ra.

Ví dụ cấu trúc:

```text
EA-024_Donchian_Trend/
├── README.md
├── ReportTester-953688.html
├── ReportTester-953688.png
├── ReportTester-953688-hst.png
├── ReportTester-953688-mfemae.png
└── ReportTester-953688-holding.png
```

### Main Report

`ReportTester-953688.html`

Chứa:

* Test settings.
* Inputs.
* Performance metrics.
* Drawdown metrics.
* Trade statistics.
* Orders.
* Deals.
* Balance graph references.

### `ReportTester-953688.png`

Balance curve.

### `ReportTester-953688-hst.png`

Phân bố:

* Entries theo giờ.
* Entries theo ngày trong tuần.
* Entries theo tháng.
* Profit/Loss theo giờ.
* Profit/Loss theo ngày.
* Profit/Loss theo tháng.

### `ReportTester-953688-mfemae.png`

Phân tích:

* Profit vs MFE.
* Profit vs MAE.

### `ReportTester-953688-holding.png`

Phân bố Profit theo thời gian giữ position.

---

# 17. Research Status

```text
EA: EA-024_Donchian_Trend

Baseline Backtest:
❌ FAIL

Reason:
Negative expectancy
Profit Factor < 1
Maximum Drawdown ≈ 99%

Next:
Fix strategy implementation before new backtest.
```

---

## Disclaimer

Backtest results không bảo đảm kết quả giao dịch trong tương lai.

Kết quả trong thư mục này chỉ đại diện cho:

* EA version được test.
* Parameters được ghi trong report.
* Symbol `XAUUSD.PRO`.
* Timeframe `M1`.
* Giai đoạn `2026.01.02 - 2026.03.01`.
* Dữ liệu và điều kiện Strategy Tester tại thời điểm chạy test.

Không được sử dụng kết quả này như bằng chứng rằng chiến lược có khả năng sinh lời trong live trading.
