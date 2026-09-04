# EA-041 — Inside Pullback Trend

## 1. Tổng Quan Chiến Lược & Kết Quả Backtest

### Giới Thiệu & Cấu Trúc Dự Án

Tài liệu này tổng hợp kết quả nghiên cứu và cấu trúc thư mục kiểm thử cho Expert Advisor **EA-041_Inside_Pullback_Trend** trên sản phẩm Vàng (XAUUSD).

```
Research/
├── EA-001_EMA_Cross/           # Báo cáo & dữ liệu backtest EA-001
├── EA-002_Trend_EMA_13_34/     # Báo cáo & dữ liệu backtest EA-002
├── EA-003_Trend_EMA_20_50/     # Báo cáo & dữ liệu backtest EA-003
├── EA-004_Trend_SMA_10_30/     # Báo cáo & dữ liệu backtest EA-004
├── EA-005_SMA_20_100_Cross/    # Báo cáo & dữ liệu backtest EA-005
├── EA-041_Inside_Pullback/     # Báo cáo & dữ liệu backtest EA-041
└── methodology.md              # Quy chuẩn nghiên cứu & phương pháp backtest
```

## 2. Thông Số Cấu Hình (Settings)

| Thông số                     | Giá trị                   |
| ---------------------------- | ------------------------- |
| **Sản phẩm (Symbol)**        | `XAUUSD.PRO`              |
| **Khung thời gian (Period)** | `M1`                      |
| **Thời gian Backtest**       | `02/01/2026 – 03/09/2026` |
| **Chất lượng dữ liệu**       | `100% Real Ticks`         |
| **Tổng số Ticks**            | `99,256,611`              |
| **Tổng số Bars**             | `237,438`                 |
| **Vốn ban đầu**              | `$1,000.00`               |
| **Đòn bẩy (Leverage)**       | `1:500`                   |
| **Lot Size**                 | `0.01`                    |
| **Stop Loss**                | `300 points`              |
| **Take Profit**              | `600 points`              |
| **Max Spread**               | `35 points`               |
| **Max Orders**               | `1`                       |
| **Break Even**               | `Disabled`                |
| **Trailing Stop**            | `Disabled`                |

## 3. Chỉ Số Hiệu Suất Chính (Key Metrics)

| Metric                     |             Kết quả |
| -------------------------- | ------------------: |
| **Total Net Profit**       |         **+$26.78** |
| **Profit Factor**          |            **1.21** |
| **Sharpe Ratio**           |           **10.17** |
| **Maximal Drawdown**       |  **$47.52 (4.50%)** |
| **Total Trades**           |         **57 lệnh** |
| **Total Deals**            |       **114 Deals** |
| **Win Rate**               |          **31.58%** |
| **Winning Trades**         |              **18** |
| **Losing Trades**          |              **39** |
| **Average Win**            |          **+$8.48** |
| **Average Loss**           |          **-$3.23** |
| **Risk/Reward trung bình** |          **~2.6:1** |
| **Largest Win**            |         **+$47.71** |
| **Largest Loss**           |          **-$6.75** |
| **Average Holding Time**   | **16 phút 51 giây** |
| **Max Consecutive Losses** |          **8 lệnh** |
| **Recovery Factor**        |            **0.56** |

## 4. Đánh Giá & Nhận Xét

### Ưu Điểm

* **Lợi nhuận dương:** +$26.78 trên vốn ban đầu $1,000.
* **Drawdown thấp:** Maximal Drawdown chỉ khoảng **4.50%**.
* **Profit Factor = 1.21**, cho thấy hệ thống có lợi thế dương trong giai đoạn backtest.
* **Risk/Reward tốt:** Average Win / Average Loss đạt khoảng **2.6:1**.
* Với **Win Rate chỉ 31.58%**, hệ thống vẫn duy trì được lợi nhuận nhờ tỷ lệ Reward/Risk cao.
* **Max Orders = 1**, hạn chế việc mở nhiều vị thế đồng thời.
* Thời gian giữ lệnh trung bình chỉ **16 phút 51 giây**, phù hợp với phong cách **scalp trên M1**.

### Nhược Điểm

* **Win Rate thấp:** chỉ **31.58%** (18 thắng / 39 thua).
* Xuất hiện chuỗi tối đa **8 lệnh thua liên tiếp**, có thể gây áp lực tâm lý nếu áp dụng giao dịch thực tế.
* **Recovery Factor = 0.56**, cho thấy khả năng phục hồi sau drawdown chưa thực sự mạnh.
* Tổng số lệnh **57 trades** vẫn tương đối thấp để đánh giá độ ổn định dài hạn của chiến lược.
* Lợi nhuận tuyệt đối còn thấp so với mức vốn ban đầu, do **Lot Size cố định 0.01**.

## 5. Kết Luận

**EA-041 — Inside Pullback Trend** cho kết quả backtest **có lợi nhuận dương** trên XAUUSD.PRO M1 trong giai đoạn 02/01/2026 – 03/09/2026.

### Kết Quả Nổi Bật

* **Net Profit:** +$26.78
* **Profit Factor:** 1.21
* **Max Drawdown:** 4.50%
* **Win Rate:** 31.58%
* **Risk/Reward:** ~2.6:1
* **Sharpe Ratio:** 10.17

### Đánh Giá Cuối

Chiến lược có tiềm năng nhờ **R:R cao và Drawdown thấp**, nhưng cần tiếp tục kiểm thử trên các giai đoạn dữ liệu khác và thực hiện **Forward Test / Out-of-Sample Test** trước khi sử dụng giao dịch thực tế.

> **Backtest không đảm bảo lợi nhuận trong tương lai.**
