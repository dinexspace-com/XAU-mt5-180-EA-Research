# Backtest Report: EA-005_SMA_20_100_Cross

## 1. Tổng quan chiến lược (Strategy Overview)
* **Tên EA:** EA-005_SMA_20_100_Cross[cite: 1]
* **Chiến lược:** Giao cắt đường trung bình động đơn giản SMA 20 và SMA 100 (SMA Crossover)[cite: 1]
* **Cặp tiền/Sản phẩm:** XAUUSD.PRO (Vàng)[cite: 1]
* **Khung thời gian:** M1[cite: 1]
* **Thời gian backtest:** 02/01/2026 - 01/07/2026 (~6 tháng)[cite: 1]
* **Vốn ban đầu:** $1,000.00 USD[cite: 1]

---

## 2. Kết quả Backtest (Performance Results)

| Chỉ số | Giá trị |
| :--- | :--- |
| **Tổng lợi nhuận (Net Profit)** | **-$689.15 USD** (Âm ~68.9%)[cite: 1] |
| **Lợi nhuận gộp (Gross Profit)** | $3,143.76 USD[cite: 1] |
| **Thua lỗ gộp (Gross Loss)** | -$3,832.91 USD[cite: 1] |
| **Hệ số lợi nhuận (Profit Factor)** | **0.82**[cite: 1] |
| **Sharpe Ratio** | **-5.00**[cite: 1] |
| **Sụt giảm tài khoản tối đa (Maximal Drawdown)** | **71.47%** (-$718.62 USD)[cite: 1] |
| **Tổng số lệnh thực hiện (Total Trades)** | **2,329 lệnh**[cite: 1] |
| **Tỷ lệ thắng (Win Rate)** | **40.36%** (940 lệnh thắng / 1389 lệnh thua)[cite: 1] |
| **Lệnh thắng/thua liên tiếp tối đa** | 7 lệnh thắng / 13 lệnh thua[cite: 1] |

---

## 3. Đánh giá & Phân tích (Evaluation & Analysis)
* **Trạng thái:** **Thất bại / Chưa hiệu quả**[cite: 1].
* **Nguyên nhân chính:**
  * **Nhiễu khung M1:** Khung thời gian quá nhỏ làm xuất hiện tín hiệu cắt giả liên tục, khiến EA mở lệnh dầy đặc (2,329 lệnh)[cite: 1].
  * **Sập tài khoản trong Sideway:** EA bị thua lỗ chuỗi khi thị trường đi ngang không rõ xu hướng[cite: 1].
  * **Tốn chi phí Spread/Commissions:** Tần suất vào lệnh quá lớn làm bào mòn vốn nhanh chóng[cite: 1].

---

## 4. Kế hoạch cải tiến (Action Plan / Future Optimization)
* [ ] Chuyển khung thời gian backtest lên **M15, H1 hoặc H4**.
* [ ] Thay thế SMA bằng **EMA (Exponential Moving Average)** để giảm độ trễ.
* [ ] Bổ sung bộ lọc xu hướng **ADX > 25** để tránh vào lệnh vùng thị trường đi ngang.
* [ ] Thêm điều kiện lọc nhiễu với chỉ báo **RSI**.
* [ ] Tối ưu hóa lại quản lý vốn (Risk Management) tính theo % tài khoản thay vì Lot cố định.
