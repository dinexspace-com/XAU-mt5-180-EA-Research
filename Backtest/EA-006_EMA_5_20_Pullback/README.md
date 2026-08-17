# Strategy Tester Report: EA-006_EMA_5_20_Pullback

Báo cáo kết quả backtest chiến lược giao dịch tự động **EA-006_EMA_5_20_Pullback** trên cặp tiền **XAUUSD.PRO** (Vàng) khung thời gian **M1**.

---

## 📌 Thông tin tổng quan (Overview)

| Thông số | Giá trị |
| :--- | :--- |
| **Expert Advisor** | `EA-006_EMA_5_20_Pullback` |
| **Sản phẩm (Symbol)** | `XAUUSD.PRO` |
| **Khung thời gian (Period)** | `M1 (2026.01.02 - 2026.04.01)` |
| **Chất lượng dữ liệu (History Quality)** | **100% real ticks** |
| **Số lượng Nến / Ticks** | 86,539 Bars / 40,346,891 Ticks |
| **Vốn ban đầu (Initial Deposit)** | **$1,000.00** |
| **Tỷ lệ đòn bẩy (Leverage)** | 1:500 |
| **Đơn vị tiền tệ** | USD |

---

## ⚙️ Tham số cấu hình (Input Parameters)

```ini
InpLotSize=0.01          ; Kích thước khối lượng giao dịch
InpStopLoss=300          ; Cắt lỗ (300 pips/points)
InpTakeProfit=600        ; Chốt lời (600 pips/points)
InpMagicNumber=123456    ; Mã định danh EA
InpSlippage=10           ; Trượt giá tối đa
InpUseBreakEven=false    ; Sử dụng BreakEven (Tắt)
InpUseTrailingStop=false ; Sử dụng Trailing Stop (Tắt)
InpBreakEvenTrigger=150  ; Mức kích hoạt BreakEven
InpTrailingStart=200     ; Mức bắt đầu Trailing Stop
InpTrailingStop=200      ; Khoảng cách Trailing Stop
InpMaxSpread=30          ; Spread tối đa cho phép vào lệnh
InpMaxOrders=1           ; Số lượng lệnh tối đa cùng lúc
InpEmaFast=5             ; Chu kỳ EMA nhanh
InpEmaSlow=20            ; Chu kỳ EMA chậm
