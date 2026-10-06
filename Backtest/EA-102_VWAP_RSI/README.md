# EA-102 — VWAP + RSI — Baseline Backtest

## 1. Test Configuration

| Item            | Value                   |
| --------------- | ----------------------- |
| EA              | EA-102_VWAP_RSI         |
| Baseline ID     | `EA102-M1-BASELINE-001` |
| Symbol          | XAUUSD.PRO              |
| Timeframe       | M1                      |
| Period          | 2026.01.02 – 2026.04.01 |
| Initial Deposit | $1,000                  |
| Leverage        | 1:500                   |
| History Quality | 100% real ticks         |
| Bars            | 86,539                  |
| Ticks           | 40,346,891              |
| Lot             | 0.01                    |
| Stop Loss       | 300 points              |
| Take Profit     | 600 points              |
| RSI             | 14                      |
| Oversold        | 30                      |
| Overbought      | 70                      |

---

## 2. Performance Summary

| Metric          |      Result |
| --------------- | ----------: |
| Net Profit      | **+$38.60** |
| Gross Profit    |   $2,224.36 |
| Gross Loss      |  -$2,185.76 |
| Profit Factor   |    **1.02** |
| Expected Payoff |  **+$0.02** |
| Recovery Factor |        0.24 |
| Sharpe Ratio    |        2.80 |
| Max Balance DD  |      13.39% |
| Max Equity DD   |      13.57% |
| Total Trades    |       1,863 |
| Total Deals     |       3,726 |

---

## 3. Trade Statistics

| Metric                 |       Result |
| ---------------------- | -----------: |
| Profit Trades          | 931 / 49.97% |
| Loss Trades            | 932 / 50.03% |
| Short Trades           |        1,064 |
| Short Win Rate         |       46.24% |
| Long Trades            |          799 |
| Long Win Rate          |       54.94% |
| Largest Profit         |        $9.25 |
| Largest Loss           |      -$10.33 |
| Average Profit         |        $2.39 |
| Average Loss           |       -$2.35 |
| Max Consecutive Wins   |           10 |
| Max Consecutive Losses |           10 |
| Average Holding Time   |     00:01:39 |

## Các số liệu trên được lấy từ phần Results của Strategy Tester Report.

## 4. Baseline Assessment

### Positive

* Net Profit dương: **+$38.60**
* Profit Factor > 1: **1.02**
* Expected Payoff dương: **+$0.02**
* Sharpe Ratio dương: **2.80**
* Long side có win rate 54.94%.
* Average profit ($2.39) cao hơn average loss ($2.35).

### Weaknesses

* Profit Factor chỉ đạt 1.02.
* Expected Payoff gần bằng 0.
* Net Profit rất nhỏ so với initial deposit.
* Recovery Factor chỉ 0.24.
* Drawdown 13.57%.
* Short side có win rate thấp: 46.24%.
* Tổng số trade lớn nhưng edge quan sát được vẫn rất mỏng.

---

## 5. Classification

**Baseline Result:**

`PASS FOR FURTHER RESEARCH`

Không được phân loại là production-ready.

Kết quả cho thấy strategy có tín hiệu ban đầu tích cực nhưng chưa đủ mạnh để kết luận có edge ổn định.

---

## 6. Decision

| Stage                  | Status                    |
| ---------------------- | ------------------------- |
| Strategy Code          | COMPLETE                  |
| Baseline Test          | COMPLETE                  |
| Baseline Result        | PASS FOR FURTHER RESEARCH |
| Performance Validation | WEAK POSITIVE             |
| Broad Optimization     | BLOCKED                   |
| OOS                    | NOT STARTED               |
| Robustness             | NOT STARTED               |
| Walk-Forward           | NOT STARTED               |
| Forward Test           | NOT STARTED               |
| Live Trading           | NO                        |

---

## 7. Conclusion

EA-102 có kết quả baseline dương nhưng rất sát điểm hòa vốn.

Do đó baseline chưa đủ bằng chứng để xác nhận một trading edge mạnh.

Bước tiếp theo phải là controlled research nhằm xác định:

* VWAP relationship có thực sự tạo edge hay không.
* RSI threshold nào ổn định hơn.
* BUY và SELL có nên dùng cùng một logic hay không.
* Entry timing có cần confirmation hay không.
* Exit management có đang làm giảm hoặc cải thiện edge hay không.

**Optimization remains controlled and research-only.**
