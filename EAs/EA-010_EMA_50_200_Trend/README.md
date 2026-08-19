# EA-010 — EMA 50/200 Trend

## 1. Thông tin EA

| Thuộc tính     | Giá trị          |
| -------------- | ---------------- |
| EA ID          | EA-010           |
| Tên chiến lược | EMA 50/200 Trend |
| Nhóm           | Trend            |
| Symbol         | XAUUSD           |
| Timeframe      | M1               |

## 2. Logic giao dịch

### BUY

Mở lệnh BUY khi:

* EMA 50 > EMA 200
* Giá nằm trên EMA 50

### SELL

Mở lệnh SELL khi:

* EMA 50 < EMA 200
* Giá nằm dưới EMA 50

## 3. Quản lý lệnh

| Tham số                 |    Giá trị |
| ----------------------- | ---------: |
| Stop Loss               | 300 points |
| Take Profit             | 600 points |
| Break Even kích hoạt    | 150 points |
| Trailing Stop kích hoạt | 200 points |
| Spread tối đa           |  30 points |
| Số lệnh tối đa          |     1 lệnh |

## 4. Nguyên tắc hoạt động

* Chỉ giao dịch trên XAUUSD.
* Timeframe sử dụng: M1.
* Chỉ mở tối đa 1 lệnh.
* BUY theo xu hướng tăng khi EMA 50 nằm trên EMA 200 và giá trên EMA 50.
* SELL theo xu hướng giảm khi EMA 50 nằm dưới EMA 200 và giá dưới EMA 50.
* Không mở lệnh khi spread vượt quá 30 points.
* Lệnh được quản lý bằng SL, TP, Break Even và Trailing Stop theo bộ tham số trên.

## 5. Backtest

Kết quả backtest được lưu tại:

```text
Backtest/EA-010_EMA_50_200_Trend/
```

Các thông số và kết quả backtest phải được ghi nhận riêng theo từng lần kiểm thử.

