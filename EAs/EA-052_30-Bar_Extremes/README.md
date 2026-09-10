# EA-052 — 30-Bar Extremes

Expert Advisor (EA) cho MetaTrader 5 nghiên cứu chiến lược breakout dựa trên vùng cực trị High/Low của **30 nến trước đó**.

## Strategy Overview

EA tìm kiếm breakout khỏi vùng giá được hình thành bởi 30 nến trước.

### Buy

EA tìm tín hiệu Buy khi:

1. Giá phá lên trên mức High cao nhất của vùng quan sát.
2. Nến breakout có Low chạm hoặc nằm dưới mức breakout.
3. Giá đóng cửa nằm gần High của nến breakout.
4. Khoảng cách từ Close đến High không vượt quá **25% biên độ nến**.

Điều kiện chính:

```text
Current High > Previous 30-Bar Highest High

và

Distance(Close, High) <= 25% × Bar Range
```

### Sell

EA tìm tín hiệu Sell khi:

1. Giá phá xuống dưới mức Low thấp nhất của vùng quan sát.
2. Nến breakout có High chạm hoặc nằm trên mức breakout.
3. Giá đóng cửa nằm gần Low của nến breakout.
4. Khoảng cách từ Close đến Low không vượt quá **25% biên độ nến**.

Điều kiện chính:

```text
Current Low < Previous 30-Bar Lowest Low

và

Distance(Close, Low) <= 25% × Bar Range
```

## Trade Execution

EA sử dụng thư viện chuẩn của MetaTrader 5:

```mql5
#include <Trade\Trade.mqh>
```

với:

```mql5
CTrade trade;
```

EA chỉ cho phép tối đa **1 position trên cùng symbol và Magic Number** tại một thời điểm.

Tín hiệu giao dịch được kiểm tra khi EA phát hiện một nến mới.

## Risk & Trade Management

EA hiện hỗ trợ:

* Fixed Lot Size
* Stop Loss
* Take Profit
* Maximum Spread Filter
* Slippage / Deviation
* Magic Number
* Break Even
* Break Even Profit Lock
* Trailing Stop
* Trailing Step

## Default Parameters

| Parameter          | Default | Description                                     |
| ------------------ | ------: | ----------------------------------------------- |
| `InpLotSize`       |    0.01 | Khối lượng giao dịch                            |
| `InpStopLoss`      |     300 | Stop Loss, tính theo points                     |
| `InpTakeProfit`    |     600 | Take Profit, tính theo points                   |
| `InpMagicNumber`   |  202501 | Magic Number                                    |
| `InpSlippage`      |      10 | Deviation cho phép, theo points                 |
| `InpMaxSpread`     |      30 | Spread tối đa, theo points                      |
| `InpUseBreakEven`  |    true | Bật/tắt Break Even                              |
| `InpBreakEvenPips` |     150 | Mức lợi nhuận kích hoạt Break Even, theo points |
| `InpBreakEvenLock` |       0 | Số points lợi nhuận khóa khi Break Even         |
| `InpUseTrailing`   |    true | Bật/tắt Trailing Stop                           |
| `InpTrailingStart` |     200 | Khoảng trailing, theo points                    |
| `InpTrailingStep`  |      50 | Bước cập nhật Trailing Stop, theo points        |

## Position Management

### Break Even

Khi position đạt mức lợi nhuận:

```text
150 points
```

EA có thể dịch Stop Loss về giá vào lệnh.

Mặc định:

```text
InpBreakEvenLock = 0
```

nên Stop Loss được đưa về đúng mức hòa vốn.

### Trailing Stop

Trailing Stop mặc định sử dụng khoảng cách:

```text
200 points
```

và chỉ cập nhật Stop Loss khi khoảng thay đổi đạt tối thiểu:

```text
50 points
```

## Spread Filter

EA không mở lệnh mới nếu spread vượt quá:

```text
30 points
```

theo cấu hình mặc định.

## Files

```text
EA-052_30-Bar_Extremes/
├── EA-052_30-Bar_Extremes.mq5
└── README.md
```

## Platform

* MetaTrader 5
* Language: MQL5
* Order management: `CTrade`
* Timeframe: `PERIOD_CURRENT`
* Symbol: `_Symbol`

EA không khóa cứng timeframe hoặc symbol trong source code.

## Research Status

```text
Strategy implementation: Available
Source code: Available
Backtest validation: See /Backtest/EA-052_30-Bar_Extremes/
```

Kết quả hiệu suất, profitability, drawdown và robustness không được tuyên bố trong README này nếu chưa có bằng chứng backtest tương ứng.

## Important Implementation Note

Tên chiến lược và biến chính sử dụng vùng **30 bars**:

```mql5
int barsCount = 30;
```

Tuy nhiên trong source hiện tại vẫn còn một số comment/property cũ ghi **15-bar**, ví dụ:

```text
Breakout strategy based on 15-bar high/low
```

Các comment này không phù hợp với giá trị `barsCount = 30` hiện tại và nên được đồng bộ khi source code được review.

Ngoài ra, logic indexing của dữ liệu trả về từ `CopyRates()` cần được xác minh bằng compile/test/backtest trước khi coi implementation là bản đã được validation.

## Disclaimer

EA này thuộc repository nghiên cứu XAUUSD/MT5.

Các kết quả trong quá khứ hoặc backtest không đảm bảo kết quả giao dịch trong tương lai. EA cần được kiểm thử trên dữ liệu, điều kiện spread, execution và broker phù hợp trước khi sử dụng trên tài khoản thực.
