# EA-006: Trend EMA 5/20 Pullback (M1)

## 1. Overview
- **Strategy Name:** EMA 5/20 Pullback Strategy
- **Symbol:** XAUUSD (Gold)
- **Timeframe:** M1 (1-Minute)
- **Platform:** MetaTrader 5 (MQL5)
- **Execution Model:** Order Open on Bar Close (Nến đóng cửa để xác nhận tín hiệu)

---

## 2. Trading Logic

### Buy Setup
1. **Trend Condition:** EMA 5 nằm trên EMA 20 ($EMA_5 > EMA_{20}$).
2. **Pullback Condition:** Giá thấp nhất của nến trước đó (hoặc đuôi nến) có sự chạm/hồi về đường EMA 20.
3. **Trigger Condition:** Nến tín hiệu đóng cửa là nến Tăng (Bullish Bar: $Close > Open$).
4. **Execution:** Mở lệnh **BUY** tại giá Open của nến tiếp theo.

### Sell Setup
1. **Trend Condition:** EMA 5 nằm dưới EMA 20 ($EMA_5 < EMA_{20}$).
2. **Pullback Condition:** Giá cao nhất của nến trước đó (hoặc đuôi nến) có sự chạm/hồi về đường EMA 20.
3. **Trigger Condition:** Nến tín hiệu đóng cửa là nến Giảm (Bearish Bar: $Close < Open$).
4. **Execution:** Mở lệnh **SELL** tại giá Open của nến tiếp theo.

---

## 3. Risk & Order Management Parameters

| Parameter | Value (Points) | Description |
| :--- | :--- | :--- |
| **Stop Loss (SL)** | 300 points | Mức cắt lỗ cố định từ giá vào |
| **Take Profit (TP)** | 600 points | Mức chốt lời cố định từ giá vào |
| **Break Even (BE)** | 150 points | Dịch SL về Entry khi đạt mức lời tương ứng |
| **Trailing Stop** | 200 points | Khoảng cách bám sát giá theo chiều có lợi |
| **Max Spread** | 30 points | Giới hạn Spread tối đa cho phép vào lệnh |
| **Max Orders** | 1 order | Tối đa 1 vị thế mở tại một thời điểm |

---

## 4. Input Parameters (MQL5 Standard)
- `InpEMA_Fast_Period = 5` (EMA Nhanh)
- `InpEMA_Slow_Period = 20` (EMA Chậm)
- `InpStopLoss = 300`
- `InpTakeProfit = 600`
- `InpBreakEven = 150`
- `InpTrailingStop = 200`
- `InpMaxSpread = 30`
