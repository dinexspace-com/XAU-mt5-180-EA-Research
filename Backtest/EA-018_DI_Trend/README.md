# EA-018_DI_Trend — Backtest

## 1. Mục đích

Thư mục này lưu kết quả backtest của **EA-018_DI_Trend** trên MetaTrader 5.

Baseline backtest được sử dụng để đánh giá phiên bản hiện tại của EA trước khi thực hiện bất kỳ optimization hoặc thay đổi chiến lược nào.

**Kết quả Baseline:** ❌ **FAIL**

---

## 2. Test Environment

| Parameter        | Value                     |
| ---------------- | ------------------------- |
| Expert Advisor   | `EA-018_DI_Trend`         |
| Symbol           | `XAUUSD.PRO`              |
| Timeframe        | `M1`                      |
| Test Period      | `2026-01-02 → 2026-06-08` |
| Broker / Company | `ACCM Intl Limited`       |
| MT5 Server       | `ACCMIntl-Real`           |
| MT5 Build        | `6090`                    |
| Currency         | `USD`                     |
| Initial Deposit  | `$1,000.00`               |
| Leverage         | `1:500`                   |
| History Quality  | `100% real ticks`         |
| Bars             | `151,130`                 |
| Ticks            | `65,497,516`              |

---

## 3. EA Inputs

### Trading

| Input            |     Value |
| ---------------- | --------: |
| `InpLotSize`     |    `0.01` |
| `InpMagicNumber` | `2024001` |
| `InpSlippage`    |      `10` |

### EMA

| Input          | Value |
| -------------- | ----: |
| `InpEmaPeriod` |  `50` |

### DMI / ADX

| Input          | Value |
| -------------- | ----: |
| `InpAdxPeriod` |  `14` |

### Trade Management

| Input                       |   Value |
| --------------------------- | ------: |
| `InpStopLoss`               |   `300` |
| `InpTakeProfit`             |   `600` |
| `InpUseBreakEven`           | `false` |
| `InpBreakEvenStartPoints`   |   `150` |
| `InpUseTrailingStop`        | `false` |
| `InpTrailingStartPoints`    |   `200` |
| `InpTrailingDistancePoints` |     `0` |

### Filters / Limits

| Input                 | Value |
| --------------------- | ----: |
| `InpMaxSpreadPoints`  |  `30` |
| `InpMaxOpenPositions` |   `1` |

> Break Even và Trailing Stop đều được tắt trong baseline backtest này.

---

## 4. Backtest Results

### Performance

| Metric            |            Result |
| ----------------- | ----------------: |
| Initial Deposit   |       `$1,000.00` |
| Total Net Profit  |      **-$993.61** |
| Gross Profit      |       `$7,854.52` |
| Gross Loss        |      `-$8,848.13` |
| Profit Factor     |          **0.89** |
| Expected Payoff   |        **-$0.24** |
| Recovery Factor   |         **-1.00** |
| Sharpe Ratio      |         **-5.00** |
| AHPR              | `0.9989 (-0.11%)` |
| GHPR              | `0.9988 (-0.12%)` |
| LR Correlation    |           `-0.96` |
| LR Standard Error |           `62.80` |

---

## 5. Drawdown

| Metric                    |               Result |
| ------------------------- | -------------------: |
| Balance Drawdown Absolute |            `$993.61` |
| Balance Drawdown Maximal  |   `$994.06 (99.36%)` |
| Balance Drawdown Relative | **99.36% ($994.06)** |
| Equity Drawdown Absolute  |            `$993.61` |
| Equity Drawdown Maximal   |   `$998.00 (99.36%)` |
| Equity Drawdown Relative  | **99.36% ($998.00)** |

### Đánh giá

Drawdown **99.36%** cho thấy baseline gần như mất toàn bộ vốn ban đầu.

Đây là mức drawdown không thể chấp nhận đối với một chiến lược được xem xét cho giao dịch thực tế.

---

## 6. Trade Statistics

| Metric         |           Result |
| -------------- | ---------------: |
| Total Trades   |          `4,096` |
| Total Deals    |          `8,192` |
| Winning Trades | `1,278 (31.20%)` |
| Losing Trades  | `2,818 (68.80%)` |
| Short Trades   |          `2,235` |
| Short Win Rate |         `30.16%` |
| Long Trades    |          `1,861` |
| Long Win Rate  |         `32.46%` |

### Win / Loss

| Metric                     |         Result |
| -------------------------- | -------------: |
| Largest Profit Trade       |       `$36.46` |
| Largest Loss Trade         |      `-$26.85` |
| Average Profit Trade       |        `$6.15` |
| Average Loss Trade         |       `-$3.14` |
| Maximum Consecutive Wins   |   `7 ($37.56)` |
| Maximum Consecutive Losses | `17 (-$59.93)` |
| Average Consecutive Wins   |            `1` |
| Average Consecutive Losses |            `3` |

---

## 7. Position Holding Time

| Metric               |     Result |
| -------------------- | ---------: |
| Minimum Holding Time | `00:00:01` |
| Maximum Holding Time | `04:10:59` |
| Average Holding Time | `00:04:56` |

EA hoạt động với tần suất giao dịch cao trên timeframe M1, với thời gian giữ lệnh trung bình dưới 5 phút.

---

## 8. MFE / MAE

| Metric                     |   Result |
| -------------------------- | -------: |
| Correlation (Profits, MFE) |   `0.83` |
| Correlation (Profits, MAE) |   `0.74` |
| Correlation (MFE, MAE)     | `0.5190` |

Các biểu đồ MFE/MAE được giữ cùng Strategy Tester Report để phục vụ phân tích sau này.

---

## 9. Balance Curve

Balance curve cho thấy xu hướng giảm rõ ràng xuyên suốt baseline test.

Tài khoản bắt đầu với:

```text
$1,000
```

và kết thúc với mức lỗ:

```text
-$993.61
```

Điều này phù hợp với:

```text
Profit Factor = 0.89
Expected Payoff = -$0.24
LR Correlation = -0.96
```

Baseline hiện tại không thể hiện positive expectancy.

---

## 10. Baseline Assessment

### Kết quả

```text
BASELINE STATUS: FAIL
```

### Lý do

Baseline FAIL vì đồng thời xuất hiện các vấn đề chính:

1. **Total Net Profit âm**

```text
-$993.61
```

2. **Profit Factor dưới 1**

```text
0.89
```

3. **Expected Payoff âm**

```text
-$0.24 / trade
```

4. **Drawdown cực cao**

```text
99.36%
```

5. **Sharpe Ratio âm**

```text
-5.00
```

6. **Win Rate thấp**

```text
31.20%
```

7. Balance curve có xu hướng giảm mạnh trong toàn bộ test.

---

## 11. PASS / FAIL

### Baseline

**❌ FAIL**

EA-018_DI_Trend phiên bản hiện tại **không đạt yêu cầu baseline** trên:

```text
XAUUSD.PRO
M1
2026-01-02 → 2026-06-08
```

Kết quả này chỉ xác nhận rằng **cấu hình EA + timeframe + khoảng dữ liệu của baseline test này không có lợi thế giao dịch (positive expectancy)**.

Không được suy rộng kết quả này thành kết luận rằng mọi biến thể của chiến lược DI Trend đều không hoạt động.

---

## 12. Quyết định sau Backtest

Không thực hiện optimization hàng loạt trên version hiện tại.

Trước khi optimization cần kiểm tra lại:

```text
1. Logic tín hiệu EMA slope
2. Logic +DI / -DI
3. Tần suất entry trên M1
4. SL / TP hiện tại
5. Điều kiện lọc trend
```

Đặc biệt cần xác minh vấn đề EMA slope đã được ghi nhận trong:

```text
EAs/EA-018_DI_Trend/README.md
```

Nếu logic implementation sai với strategy intent, cần sửa logic trước rồi tạo baseline mới.

---

## 13. Evidence

Strategy Tester Report gốc:

```text
ReportTester-953688(3).html
```

Các biểu đồ được export cùng report:

```text
ReportTester-953688(3).png
ReportTester-953688-hst(3).png
ReportTester-953688-mfemae(3).png
ReportTester-953688-holding(3).png
```

Report MT5 xác nhận test sử dụng **100% real ticks** với 151,130 bars và 65,497,516 ticks.

---

## 14. Folder Structure

```text
Backtest/
└── EA-018_DI_Trend/
    ├── README.md
    ├── ReportTester-953688(3).html
    ├── ReportTester-953688(3).png
    ├── ReportTester-953688-hst(3).png
    ├── ReportTester-953688-mfemae(3).png
    └── ReportTester-953688-holding(3).png
```

---

## 15. Current Status

```text
EA                    : EA-018_DI_Trend
Baseline              : COMPLETED
Baseline Result       : FAIL

Symbol                : XAUUSD.PRO
Timeframe             : M1
Period                : 2026-01-02 → 2026-06-08
History Quality       : 100% real ticks

Net Profit            : -$993.61
Profit Factor         : 0.89
Max Drawdown          : 99.36%
Total Trades          : 4,096
Win Rate              : 31.20%
Sharpe Ratio          : -5.00

Optimization          : NOT STARTED
Forward Test          : NOT STARTED
Live Validation       : NOT STARTED
```

**Decision:** Không optimization cho đến khi logic chiến lược và implementation được review.
