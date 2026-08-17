Đánh giá chi tiết kết quả backtest của **EA-006_EMA_5_20_Pullback**:

### ⚠️ Xung đột cấu hình tham số (Parameter Discrepancy)
* Mặc dù bot có tên là `EA-006_EMA_5_20_Pullback` và ghi chú lệnh hiển thị `EMA5_EMA20`, nhưng các thông số đầu vào thực tế được thực thi trong quá trình backtest lại là **InpEmaFast = 9** và **InpEmaSlow = 50**.

---

### 📊 Chỉ số hiệu suất cốt lõi (Core Performance Metrics)

| Chỉ số (Metric) | Giá trị (Value) | Mức chuẩn (Target Benchmark) | Trạng thái (Status) |
| :--- | :--- | :--- | :--- |
| **Lợi nhuận ròng (Total Net Profit)** | **-$896.77** | > $0.00 | ❌ Thua lỗ |
| **Hệ số lợi nhuận (Profit Factor)** | **0.90** | > 1.20 | ❌ Kỳ vọng âm |
| **Mức sụt giảm tài khoản (Maximal Drawdown)** | **90.14%** ($912.29) | < 20.00% | ❌ Cháy / Sụt giảm vốn nghiêm trọng |
| **Tỷ lệ thắng (Win Rate)** | **31.72%** (1,326 / 4,180) | > 40.00% (đối với R:R 1:2) | ❌ Kém hiệu quả |
| **Tỷ lệ R/R (Risk-Reward Ratio)** | **1.94** ($6.11 avg win / $3.15 avg loss) | 1:2.00 ($30 / $60 points) | ⚠️ Bị ảnh hưởng bởi spread/slippage |
| **Tổng số lệnh (Total Trades)** | **4,180 lệnh** (trong 3 tháng) | ~300–500 lệnh | ❌ Giao dịch quá mức (Over-trading) |

---

### 🔴 Nguyên nhân thất bại chính (Key Failure Drivers)

1. **Giao dịch quá mức trong thị trường đi ngang (Over-Trading in Ranging Markets):** 
   * Thực hiện 4,180 lệnh trong 3 tháng (~65 lệnh/ngày) trên khung thời gian M1, dẫn đến việc ăn "whipsaw" liên tục khi thị trường chop/sideway, gây ra chuỗi thua lỗ liên tiếp lên đến 18 lệnh.
2. **Biên độ SL/TP không đủ bù đắp Spread & Slippage:** 
   * Nhiễu giá trên khung M1 kết hợp với Stop Loss cố định 300 points ($3.00) và Take Profit 600 points ($6.00) làm chi phí giao dịch làm mòn tỷ lệ Risk:Reward thực tế (thắng trung bình $6.11 vs thua trung bình $3.15).
3. **Độ trễ của Đường trung bình động (EMA Lag):** 
   * Việc áp dụng EMA 9 / EMA 50 giao cắt trên khung M1 Vàng (XAUUSD) tạo ra độ trễ lớn, dẫn đến vào lệnh chậm khi xu hướng đã chạy được một đoạn và thoát lệnh muộn khi giá đảo chiều đột ngột.
