# EA-003_EMA_20_50_Cross

## Overview
EA giao dịch theo xu hướng sử dụng tín hiệu giao cắt của 2 đường EMA (20 và 50) kết hợp với xác nhận vị trí của giá đối với đường trung bình động trên khung thời gian M1 (XAUUSD).

## Strategy Specifications
- **Asset:** XAUUSD
- **Timeframe:** M1
- **Entry Rules:**
  - **BUY:** EMA 20 cắt lên EMA 50 VÀ giá đóng cửa NẰM TRÊN cả EMA 20 và EMA 50.
  - **SELL:** EMA 20 cắt xuống EMA 50 VÀ giá đóng cửa NẰM DƯỚI cả EMA 20 và EMA 50.
- **Filter:**
  - Max Spread Allowed: 30 Points (3 pips).
  - Max Concurrent Trades: 1 position.

## Risk Management Parameters
- **Stop Loss (SL):** 300 points
- **Take Profit (TP):** 600 points
- **Break Even Trigger:** 150 points
- **Trailing Stop Start:** 200 points
- **Trailing Stop Step:** 50 points
