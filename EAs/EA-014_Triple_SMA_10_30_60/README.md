# EA-014: Triple SMA Trend Strategy (M1)

## 1. Overview
- **Asset**: XAUUSD (Gold)
- **Timeframe**: M1
- **Strategy**: Trend Following using Triple SMA Alignment (10, 30, 60)
- **Execution**: Open position when SMA 10, SMA 30, and SMA 60 align in the same direction on candle close.

---

## 2. Trading Logic

### Long (Buy) Condition:
- `SMA(10) > SMA(30)` AND `SMA(30) > SMA(60)`
- All 3 SMAs sloping upwards on the current closed candle.

### Short (Sell) Condition:
- `SMA(10) < SMA(30)` AND `SMA(30) < SMA(60)`
- All 3 SMAs sloping downwards on the current closed candle.

---

## 3. Risk & Trade Management Specs
- **Max Positions**: 1 trade at a time
- **Max Spread**: 30 points (3.0 pips)
- **Stop Loss (SL)**: 300 points (30 pips)
- **Take Profit (TP)**: 600 points (60 pips)
- **Break Even (BE)**: 150 points (15 pips)
- **Trailing Stop**: 200 points (20 pips)
