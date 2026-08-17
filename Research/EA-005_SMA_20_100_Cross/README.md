# Research: Strategy Analysis & Optimization

## 1. Mục tiêu (Objective)
Thư mục này dùng để lưu trữ các tài liệu nghiên cứu, phân tích chiến lược giao dịch và đề xuất các phương án cải tiến kĩ thuật cho EA nhằm khắc phục các hạn chế từ kết quả Backtest (đặc biệt là phiên bản `EA-005_SMA_20_100_Cross`)[cite: 1].

---

## 2. Vấn đề cốt lõi cần giải quyết (Core Issues)
Dựa trên báo cáo thử nghiệm `EA-005`[cite: 1]:
* **Nhiễu tín hiệu khung nhỏ:** Khung M1 tạo ra quá nhiều tín hiệu giả, dẫn đến 2,329 lệnh và sụt giảm tài khoản 71.47%[cite: 1].
* **Thua lỗ trong thị trường Sideway:** Đường trung bình (MA) giao cắt liên tục khi giá không có xu hướng rõ ràng[cite: 1].
* **Chi phí giao dịch cao:** Tần suất vào lệnh dày đặc làm bào mòn lợi nhuận do Spread và Commission[cite: 1].

---

## 3. Định hướng nghiên cứu & Tối ưu (Research Roadmap)

### A. Tối ưu hóa chỉ báo (Indicator Optimization)
* **Chuyển đổi MA:** Thử nghiệm **EMA (Exponential Moving Average)** hoặc **WMA (Weighted Moving Average)** thay cho SMA để phản ứng nhanh hơn với biến động giá.
* **Bộ lọc xu hướng (Trend Filters):**
  * **ADX (Average Directional Index):** Chỉ kích hoạt lệnh khi $ADX > 25$ (thị trường có xu hướng rõ ràng).
  * **RSI (Relative Strength Index):** Xác nhận động lực giá trước khi vào lệnh.
  * **ATR (Average True Range):** Sử dụng ATR để tự động điều chỉnh Stop Loss / Take Profit theo độ biến động của thị trường.

### B. Thử nghiệm Khung thời gian & Sản phẩm (Timeframe & Assets)
* **Timeframes:** M15, H1, H4 (Giảm nhiễu, tăng tỷ lệ Win Rate).
* **Assets:** Test so sánh giữa XAUUSD, EURUSD, GBPUSD.

### C. Quản lý rủi ro (Risk & Capital Management)
* **Position Sizing:** Chuyển từ Lot cố định sang tính % rủi ro tài khoản (Risk % per trade).
* **Tỷ lệ R:R (Risk to Reward):** Yêu cầu tối thiểu $R:R = 1:1.5$ hoặc $1:2$.
* **Trailing Stop:** Áp dụng Trailing Stop dựa trên ATR hoặc Parabolic SAR để bảo vệ lợi nhuận.

---

## 4. Danh sách tài liệu & Đề xuất tiếp theo (Next Steps)
- [ ] Nghiên cứu mã nguồn & giải pháp tích hợp ADX Filter.
- [ ] Chạy Backtest đối chứng giữa SMA vs EMA trên khung H1.
- [ ] Xây dựng phiên bản thử nghiệm mới (`EA-006_EMA_Filter`).
