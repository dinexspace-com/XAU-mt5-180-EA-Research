# EA-017_ADX_EMA — Backtest

Baseline backtest cho chiến lược **EMA 20/50 + ADX 14** trên XAUUSD.

## Backtest Status

**Result: FAIL**

Phiên bản hiện tại chưa tạo được lợi thế giao dịch dương trên tập dữ liệu backtest.

Nguyên nhân chính:

* Total Net Profit âm.
* Profit Factor dưới 1.00.
* Expected Payoff âm.
* Sharpe Ratio âm.
* Drawdown cao so với hiệu quả đạt được.
* Balance cuối kỳ thấp hơn vốn ban đầu.

Đây được giữ lại làm **baseline** để nghiên cứu và so sánh với các phiên bản tiếp theo.

---

# Test Configuration

| Parameter       | Value           |
| --------------- | --------------- |
| Expert          | EA-017_ADX_EMA  |
| Symbol          | XAUUSD.PRO      |
| Timeframe       | M1              |
| Test Start      | 2026.01.02      |
| Test End        | 2026.06.08      |
| Initial Deposit | $1,000          |
| Currency        | USD             |
| Leverage        | 1:500           |
| History Quality | 100% real ticks |
| Bars            | 151,130         |
| Ticks           | 65,497,516      |
| Symbols         | 1               |

---

# EA Inputs

## General

| Input        |  Value |
| ------------ | -----: |
| Lot Size     |   0.01 |
| Magic Number | 123456 |
| Slippage     |     10 |

## Trade Parameters

| Input       |      Value |
| ----------- | ---------: |
| Stop Loss   | 300 points |
| Take Profit | 600 points |

## Market Filter

| Input          |     Value |
| -------------- | --------: |
| Maximum Spread | 30 points |

## EMA / ADX

| Input       | Value |
| ----------- | ----: |
| Fast EMA    |    20 |
| Slow EMA    |    50 |
| ADX Period  |    14 |
| Minimum ADX |  25.0 |

## Position Management

| Input              | Value      |
| ------------------ | ---------- |
| Break Even         | OFF        |
| Break Even Trigger | 150 points |
| Trailing Stop      | OFF        |
| Trailing Distance  | 200 points |

Break Even và Trailing Stop được tắt trong baseline này.

Điều này giúp lần test phản ánh trực tiếp logic entry EMA + ADX kết hợp với Stop Loss và Take Profit cố định.

---

# Main Results

| Metric           |             Result |
| ---------------- | -----------------: |
| Initial Deposit  |          $1,000.00 |
| Total Net Profit |       **-$184.67** |
| Approx. Return   |        **-18.47%** |
| Gross Profit     |          $3,608.63 |
| Gross Loss       |         -$3,793.30 |
| Profit Factor    |           **0.95** |
| Expected Payoff  | **-$0.10 / trade** |
| Recovery Factor  |              -0.65 |
| Sharpe Ratio     |          **-4.45** |

---

# Drawdown

| Metric                    |               Result |
| ------------------------- | -------------------: |
| Balance Drawdown Absolute |              $277.91 |
| Balance Drawdown Maximal  |     $283.06 / 28.16% |
| Equity Drawdown Absolute  |              $278.17 |
| Equity Drawdown Maximal   | **$284.33 / 28.26%** |

Maximum equity drawdown trên 28% trong khi chiến lược vẫn tạo lợi nhuận âm.

Đây là một trong các lý do baseline được đánh giá FAIL.

---

# Trade Statistics

| Metric         |     Result |
| -------------- | ---------: |
| Total Trades   |      1,818 |
| Total Deals    |      3,636 |
| Winning Trades |        591 |
| Losing Trades  |      1,227 |
| Win Rate       | **32.51%** |
| Loss Rate      |     67.49% |

### BUY

| Metric      | Result |
| ----------- | -----: |
| Long Trades |    892 |
| Win Rate    | 31.95% |

### SELL

| Metric       | Result |
| ------------ | -----: |
| Short Trades |    926 |
| Win Rate     | 33.05% |

BUY và SELL đều có win rate thấp và không cho thấy một phía có lợi thế đủ lớn để giải quyết vấn đề của baseline.

---

# Win / Loss Characteristics

| Metric                     |      Result |
| -------------------------- | ----------: |
| Largest Profit Trade       |       $8.85 |
| Largest Loss Trade         |     -$12.86 |
| Average Profit Trade       |       $6.11 |
| Average Loss Trade         |      -$3.09 |
| Maximum Consecutive Wins   |           6 |
| Maximum Consecutive Losses |      **26** |
| Max Consecutive Profit     |      $36.53 |
| Max Consecutive Loss       | **-$90.41** |
| Average Consecutive Wins   |           2 |
| Average Consecutive Losses |           3 |

Average winning trade lớn gần gấp đôi average losing trade.

Tuy nhiên win rate chỉ khoảng 32.5%, không đủ để tạo expectancy dương trong cấu hình hiện tại.

---

# Holding Time

| Metric               |       Result |
| -------------------- | -----------: |
| Minimum Holding Time |     00:00:01 |
| Maximum Holding Time |     04:52:04 |
| Average Holding Time | **00:09:03** |

EA hoạt động như một chiến lược ngắn hạn trên timeframe M1.

---

# MFE / MAE

Report MT5 ghi nhận:

| Correlation   |  Value |
| ------------- | -----: |
| Profit vs MFE |   0.83 |
| Profit vs MAE |   0.81 |
| MFE vs MAE    | 0.6500 |

Các dữ liệu này được giữ lại để phục vụ nghiên cứu exit logic và trade management ở giai đoạn tiếp theo.

Chưa kết luận thay đổi strategy chỉ dựa trên các correlation này.

---

# Equity / Balance Observation

Balance curve cho thấy:

1. Tài khoản bắt đầu quanh $1,000.
2. Xu hướng tổng thể giảm trong phần lớn thời gian test.
3. Có một giai đoạn drawdown lớn ở khoảng giữa/cuối tập dữ liệu.
4. Sau đó balance có phục hồi một phần.
5. Tuy nhiên cuối test vẫn thấp hơn đáng kể so với initial deposit.

Điều này phù hợp với Total Net Profit âm của strategy.

---

# Baseline Assessment

## PASS Conditions

Baseline chỉ được PASS nếu tối thiểu:

* Total Net Profit > 0
* Profit Factor > 1.00
* Expected Payoff > 0
* Drawdown nằm trong mức có thể chấp nhận
* Equity curve không thể hiện xu hướng suy giảm dài hạn

## Current Result

| Criterion                  | Result |
| -------------------------- | ------ |
| Net Profit > 0             | ❌ FAIL |
| Profit Factor > 1          | ❌ FAIL |
| Expected Payoff > 0        | ❌ FAIL |
| Sharpe > 0                 | ❌ FAIL |
| Acceptable equity behavior | ❌ FAIL |
| Backtest data quality      | ✅ PASS |

### Overall

**FAIL**

EA-017_ADX_EMA phiên bản baseline chưa có đủ bằng chứng về profitability để chuyển sang forward test hoặc live trading.

---

# Important Interpretation

Kết quả FAIL **không có nghĩa repository hoặc nghiên cứu thất bại**.

Mục đích của baseline là xác định chính xác hiệu suất của chiến lược gốc:

**EMA 20/50 crossover + ADX 14 ≥ 25 + DI confirmation + fixed SL/TP**

Kết quả này trở thành mốc so sánh cho các nghiên cứu tiếp theo.

Không được thay đổi nhiều biến cùng lúc nếu muốn xác định nguyên nhân cải thiện hoặc suy giảm performance.

---

# Artifacts

```text
EA-017_ADX_EMA/
├── README.md
├── report.html
└── screenshots/
    ├── balance.png
    ├── statistics.png
    ├── mfe-mae.png
    └── holding-time.png
```

## report.html

Strategy Tester Report gốc xuất trực tiếp từ MetaTrader 5.

Đây là **source of evidence chính** cho backtest này.

## screenshots/balance.png

Balance curve của toàn bộ backtest.

## screenshots/statistics.png

Phân bố trades và profit/loss theo:

* Hour
* Weekday
* Month

## screenshots/mfe-mae.png

Phân tích Profit / MFE / MAE.

## screenshots/holding-time.png

Phân bố thời gian giữ position.

---

# Conclusion

Baseline cho thấy:

**EMA 20/50 + ADX 14/25 trên XAUUSD.PRO M1 chưa profitable trong cấu hình hiện tại.**

Các chỉ số quan trọng:

* Net Profit: **-$184.67**
* Return: khoảng **-18.47%**
* Profit Factor: **0.95**
* Win Rate: **32.51%**
* Max Equity Drawdown: **28.26%**
* Sharpe Ratio: **-4.45**
* Trades: **1,818**

**Final Status: FAIL — RETAIN AS BASELINE**

Không dùng kết quả này để chứng minh strategy profitable.

Không triển khai live trading dựa trên baseline này.
