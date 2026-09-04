# EA-041: Inside Pullback Trend

## 1. Giới thiệu (Overview)
**EA-041 (Inside Pullback Trend)** là một Robot giao dịch tự động (Expert Advisor) được phát triển cho nền tảng MetaTrader 5 (MQL5). Strategy tập trung giao dịch theo xu hướng chủ đạo của thị trường Vàng (XAUUSD) trên khung thời gian M1 bằng cách xác định nhịp hồi phục nhẹ (pullback) chứa mô hình **Inside Bar**, sau đó vào lệnh khi giá breakout theo hướng của xu hướng chính.

## 2. Chiến lược Giao dịch (Trading Logic)
* **Xác định xu hướng (Trend Identification):** Sử dụng chỉ báo EMA 50 trên khung thời gian hiện tại.
  * **Uptrend:** Giá hiện tại > EMA 50
  * **Downtrend:** Giá hiện tại < EMA 50
* **Xác nhận mô hình (Pattern Setup):** Chờ xuất hiện mô hình **Inside Bar** (giá High/Low của nến hiện tại nằm hoàn toàn trong phạm vi High/Low của nến trước đó).
* **Tín hiệu vào lệnh (Entry Signal):**
  * **BUY:** Trong Uptrend, giá bứt phá vượt qua mức High của nến mẹ (rates[2].high).
  * **SELL:** Trong Downtrend, giá bứt phá giảm xuống dưới mức Low của nến mẹ (rates[2].low).

## 3. Thông số Cài đặt (Input Parameters)

### Lot Size & Khối lượng
| Parameter | Default Value | Description |
| :--- | :--- | :--- |
| `InpLotSize` | `0.01` | Khối lượng vào lệnh cố định |

### Quản lý Rủi ro (SL / TP)
| Parameter | Default Value | Description |
| :--- | :--- | :--- |
| `InpStopLoss` | `300` | Mức dừng lỗ tính bằng Points (30 pips) |
| `InpTakeProfit` | `600` | Mức chốt lời tính bằng Points (60 pips) |

### Bộ lọc & Quản lý Lệnh (Trade Filters & Limits)
| Parameter | Default Value | Description |
| :--- | :--- | :--- |
| `InpMagicNumber` | `123456` | ID định danh lệnh của EA |
| `InpSlippage` | `10` | Mức trượt giá cho phép (Points) |
| `InpMaxSpreadPoints` | `25` | Spread tối đa cho phép vào lệnh (Points) |
| `InpMaxOrders` | `1` | Số lượng lệnh mở tối đa đồng thời |

### Quản lý Lệnh Động (Break Even & Trailing Stop)
| Parameter | Default Value | Description |
| :--- | :--- | :--- |
| `InpUseBreakEven` | `true` | Bật/Tắt tính năng dịch Stop Loss về huề vốn |
| `InpBreakEvenTrigger` | `150` | Mức lợi nhuận (Points) để kích hoạt Break Even |
| `InpBreakEvenLevel` | `0` | Mức SL mới so với giá mở cửa (0 = Entry) |
| `InpUseTrailing` | `true` | Bật/Tắt tính năng Trailing Stop |
| `InpTrailingStart` | `200` | Mức lợi nhuận (Points) bắt đầu Trailing |
| `InpTrailingStep` | `50` | Bước dịch chuyển của Trailing Stop (Points) |

## 4. Cấu trúc Source Code (File Structure)
* `EA-041_Inside_Pullback_Trend.mq5`: File mã nguồn chính chứa toàn bộ logic xử lý nến, chỉ báo EMA, vào lệnh và quản lý vị thế động.
