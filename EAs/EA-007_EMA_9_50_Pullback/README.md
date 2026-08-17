# EA-007: EMA 9/50 Pullback Strategy (M1)

## Overview
**EA-007_EMA_9_50_Pullback** là một Expert Advisor giao dịch tự động trên cặp **XAUUSD (Gold)** ở khung thời gian **M1**. Strategy tập trung vào việc đánh theo xu hướng chính (xác định bởi đường EMA 50) và tìm điểm vào lệnh tối ưu khi giá hồi phục (pullback) về đường EMA 9 kết hợp với nến tiếp diễn xu hướng.

---

## Trading Rules

### 1. Trend Identification (Khung M1)
* **Uptrend (Xu hướng Tăng):** Giá nằm trên đường EMA 50 và đường EMA 9 nằm trên EMA 50 ($EMA_9 > EMA_{50}$).
* **Downtrend (Xu hướng Giảm):** Giá nằm dưới đường EMA 50 và đường EMA 9 nằm dưới EMA 50 ($EMA_9 < EMA_{50}$).

### 2. Entry Conditions
* **BUY Signal:**
  1. Thi hành trong Uptrend.
  2. Giá có nhịp hồi (Pullback) chạm/tiệm cận đường EMA 9 (Low $\le$ EMA 9).
  3. Xuất hiện **nến tiếp diễn tăng** (Nến đóng cửa xanh / Close > Open) hoàn tất trên M1.
  4. Vào lệnh BUY tại giá Mở cửa (Open) của nến tiếp theo.

* **SELL Signal:**
  1. Thi hành trong Downtrend.
  2. Giá có nhịp hồi (Pullback) chạm/tiệm cận đường EMA 9 (High $\ge$ EMA 9).
  3. Xuất hiện **nến tiếp diễn giảm** (Nến đóng cửa đỏ / Close < Open) hoàn tất trên M1.
  4. Vào lệnh SELL tại giá Mở cửa (Open) của nến tiếp theo.

### 3. Execution Constraints
* **Max Concurrent Positions:** Tối đa 1 lệnh tại một thời điểm (`MaxPositions = 1`).
* **Spread Filter:** Chỉ vào lệnh nếu Spread hiện tại $\le$ **30 points** (3 pips).

---

## Risk & Position Management

| Parameter | Standard Value | Description |
| :--- | :--- | :--- |
| **Stop Loss (SL)** | `300 points` | Khoảng cách cắt lỗ cố định (30 pips) |
| **Take Profit (TP)** | `600 points` | Khoảng cách chốt lời cố định (60 pips) |
| **Break Even (BE)** | `150 points` | Khi lợi nhuận đạt 150 points, dời SL về hòa vốn (Entry + Offset) |
| **Trailing Stop** | `200 points` | Bắt đầu kích hoạt Trailing Stop khi lợi nhuận đạt 200 points |
| **Max Spread** | `30 points` | Bộ lọc giáp hạt Spread trước khi mở vị thế |
| **Max Orders** | `1` | Giới hạn số lượng lệnh mở đồng thời |

---

## Input Parameters List

```mql5
input group "=== Trend & Entry Settings ==="
input int                  InpFastEMAPeriod   = 9;              // Fast EMA Period
input int                  InpSlowEMAPeriod   = 50;             // Slow EMA Period

input group "=== Risk Management ==="
input double               InpLotSize         = 0.01;           // Trade Fixed Lot Size
input int                  InpStopLoss        = 300;            // Stop Loss (points)
input int                  InpTakeProfit      = 600;            // Take Profit (points)

input group "=== Trade Protection & Trailing ==="
input int                  InpBreakEvenTrigger= 150;            // Break Even Trigger (points)
input int                  InpBreakEvenOffset = 10;             // Break Even Lock Profit (points)
input int                  InpTrailingStart   = 200;            // Trailing Stop Start (points)
input int                  InpTrailingStep    = 50;             // Trailing Step (points)

input group "=== Filters & Limits ==="
input int                  InpMaxSpread       = 30;             // Max Spread Allowed (points)
input int                  InpMaxPositions    = 1;              // Max Open Positions
input ulong                InpMagicNumber     = 007950;         // EA Magic Number
