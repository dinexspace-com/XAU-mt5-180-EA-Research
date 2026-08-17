# XAUUSD.PRO M1 Strategy - Methodology & Backtest Analysis

## 1. Thông số Kỹ thuật (System Specifications)
* **Công cụ giao dịch (Symbol):** XAUUSD.PRO[cite: 1]
* **Khung thời gian (Timeframe):** M1 (1 phút)[cite: 1]
* **Thời gian kiểm thử (Period):** 2026.01.02 – 2026.07.01 (6 tháng)[cite: 1]
* **Vốn ban đầu (Initial Deposit):** $1,000.00 USD[cite: 1]
* **Loại chiến lược:** Scalping / Trend-Following (MA Crossover)

---

## 2. Kết quả Thực nghiệm (Backtest Performance Summary)
* **Tổng lợi nhuận ròng (Net Profit):** -$994.01 USD[cite: 1]
* **Mức sụt giảm tài khoản tối đa (Max Drawdown):** 99.42% ($1,019.25)[cite: 1]
* **Hệ số lợi nhuận (Profit Factor):** 0.84[cite: 1]
* **Tỷ số Sharpe (Sharpe Ratio):** -5.00[cite: 1]
* **Tổng số lệnh thực hiện:** 3,745 lệnh[cite: 1]
* **Tỷ lệ thắng (Win Rate):** 39.87% (1,493 lệnh thắng / 2,252 lệnh thua)[cite: 1]

---

## 3. Phân tích Nguyên nhân Thất bại (Root Cause Analysis)
1. **Giao dịch quá tần suất (Severe Over-trading Drag):**
   * Tổng cộng 3,745 lệnh trong 6 tháng (~29 lệnh/ngày) trên khung M1 làm cho phí Spread và Commission tích lũy cực kỳ lớn, ăn mòn sạch vốn ban đầu[cite: 1].
2. **Nhiễu thị trường ở khung M1 (Market Whipsaws):**
   * Khung M1 có quá nhiều tín hiệu giả. Tỷ lệ thua 60.13% cho thấy thuật toán bị dính cắt lỗ liên tục trong các giai đoạn thị trường đi ngang (sideway)[cite: 1].
3. **Trạng thái tài khoản (Near Total Depletion):**
   * Drawdown lên tới 99.42% dẫn đến việc tài khoản bị cháy hoàn toàn[cite: 1].

---

## 4. Kế hoạch Cải tiến (Action Plan & Optimization)
* **Khung thời gian:** Chuyển giao dịch từ M1 lên khung M15, H1 hoặc H4 để giảm bớt nhiễu giá và giảm số lượng lệnh xuống mức an toàn.
* **Bộ lọc xu hướng:** Tích hợp bộ lọc Trend khung lớn (như EMA 200 H1 hoặc ADX) — chỉ mở lệnh BUY khi giá nằm trên EMA 200.
* **Quản lý rủi ro:** Khống chế rủi ro tối đa 1-2% vốn/lệnh. Thiết lập tỷ lệ Risk:Reward tối thiểu từ 1:1.5 trở lên.

---

## 5. Nhật ký Phiên bản (Versioning Log)
* **v1.0.0 (2026-07-01):** Thử nghiệm bản M1 gốc. Trạng thái: **THẤT BẠI** (Net Profit: -$994.01, Drawdown: 99.42%)[cite: 1].
* **v1.1.0 (Dự kiến):** Cấu trúc lại khung thời gian M15, thêm bộ lọc xu hướng H1 và cố định tỷ lệ R:R.
