# Báo Cáo Backtest: EA-041_Inside_Pullback_Trend

Thư mục này chứa kết quả thử nghiệm chiến lược giao dịch tự động (Backtest) cho Expert Advisor **EA-041_Inside_Pullback_Trend** trên sản phẩm Vàng (XAUUSD).

---

### 1. Thông Số Cấu Hình (Settings)

* **Sản phẩm (Symbol):** `XAUUSD.PRO`
* **Khung thời gian (Period):** `M1` (02/01/2026 – 03/09/2026)
* **Chất lượng dữ liệu:** `100% real ticks` (99,256,611 Ticks / 237,438 Bars)
* **Vốn ban đầu (Initial Deposit):** $1,000.00
* **Đòn bẩy (Leverage):** `1:500`
* **Khối lượng lệnh (Lot Size):** `0.01`
* **Stop Loss / Take Profit:** `300` points / `600` points
* **Bộ lọc & Quản lý:** Max Spread = `35` points | Max Orders = `1` | Break Even / Trailing = `Disabled`

---

### 2. Chỉ Số Hiệu Suất Chính (Key Metrics)

| Chỉ số Metric | Giá trị |
| :--- | :--- |
| **Total Net Profit** | **$26.78** (Lợi nhuận ròng) |
| **Profit Factor** | **1.21** |
| **Sharpe Ratio** | **10.17** |
| **Maximal Drawdown** | **$47.52 (4.50%)** |
| **Total Trades** | **57 lệnh** (114 Deals) |
| **Win Rate** | **31.58%** (18 thắng / 39 thua) |
| **Average Win / Loss** | **$8.48** / **-$3.23** (Tỷ lệ R:R ~ 2.6:1) |
| **Largest Win / Loss** | **$47.71** / **-$6.75** |
| **Avg Holding Time** | **16 phút 51 giây** |

---

### 3. Cấu Trúc Tệp Tin (Directory Structure)

* `ReportTester-952747.html`: Báo cáo chi tiết định dạng HTML xuất từ MT5.
* `ReportTester-952747.png`: Biểu đồ tăng trưởng Balance & Equity.
* `ReportTester-952747-hst.png`: Biểu đồ phân bố lợi nhuận/thua lỗ theo thời gian.
* `ReportTester-952747-mfemae.png`: Biểu đồ phân tích MFE (Maximum Favorable Excursion) và MAE (Maximum Adverse Excursion).
* `ReportTester-952747-holding.png`: Biểu đồ thời gian nắm giữ vị thế.

---

### 4. Đánh Giá & Nhận Xét

* **Ưu điểm:** Lợi nhuận dương ($26.78) với mức sụt giảm tài khoản (Drawdown) rất thấp (~4.50%). Tỷ lệ Risk/Reward cao giúp hệ thống duy trì mức sinh lời ổn định dù Win Rate chỉ đạt ~31.58%.
* **Nhược điểm:** Tỷ lệ sụt giảm tối đa / Lợi nhuận (Recovery Factor = 0.56) còn tương đối thấp do số lượng lệnh thắng chưa đủ lớn để bù đắp nhanh các chuỗi thua ngắn (tối đa 8 lệnh thua liên tiếp).
